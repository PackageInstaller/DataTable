local BlinkStoryPlayer = class("BlinkStoryPlayer", import(".StoryPlayer"))

function BlinkStoryPlayer:UpdateBg(arg_1_1)
	BlinkStoryPlayer.super.UpdateBg(self, arg_1_1)

	self.blurOptimized = pg.UIMgr.GetInstance().cameraBlurs[pg.UIMgr.CameraOverlay][1]
	self.blurFlag = false
	self.defaultBlueValues = {
		downsample = self.blurOptimized.downsample,
		blurSize = self.blurOptimized.blurSize,
		blurIteration = self.blurOptimized.blurIteration
	}

	return
end

function BlinkStoryPlayer:LoadEffects(arg_2_1, arg_2_2)
	parallelAsync({
		function(arg_3_0)
			self:PlayOpenEyeEffect(arg_2_1, arg_3_0)

			return
		end,
		function(arg_4_0)
			BlinkStoryPlayer.super.LoadEffects(self, arg_2_1, arg_4_0)

			return
		end
	}, arg_2_2)

	return
end

function BlinkStoryPlayer:PlayOpenEyeEffect(arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetOpenEyeData()

	seriesAsync({
		function(arg_6_0)
			self:LoadOpenEyeEffect(function(arg_7_0)
				self.targetGo = arg_7_0

				arg_6_0()

				return
			end)

			return
		end,
		function(arg_8_0)
			self:ApplyOpenEyeEffect(arg_5_1, var_5_0, self.targetGo, arg_8_0)

			return
		end,
		function(arg_9_0)
			self:ClearTarget()
			arg_9_0()

			return
		end
	}, arg_5_2)

	return
end

function BlinkStoryPlayer:ClearTarget()
	if self.targetGo then
		self.targetGo:GetComponent(typeof(Image)).material:SetFloat("_EyeClose", 1)
		Object.Destroy(self.targetGo)

		self.targetGo = nil
	end

	return
end

function BlinkStoryPlayer:LoadOpenEyeEffect(arg_11_1)
	LoadAndInstantiateAsync("effect", "openEye", function(arg_12_0)
		setParent(arg_12_0, self.topEffectTr)

		arg_12_0.transform.localScale = Vector3.one

		setActive(arg_12_0, true)
		arg_11_1(arg_12_0)

		return
	end)

	return
end

local function var_0_1(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_0:TweenValueWithEase(arg_13_0._go, arg_13_2.x, arg_13_2.y, arg_13_2.z, 0, arg_13_3, function(arg_14_0)
		arg_13_1:SetFloat("_EyeClose", arg_14_0)

		return
	end, arg_13_4)

	return
end

function BlinkStoryPlayer:ApplyOpenEyeEffect(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	setActive(self.bgPanel, true)

	local var_15_0 = arg_15_2.open
	local var_15_1 = arg_15_2.close
	local var_15_2 = arg_15_2.hold
	local var_15_3 = arg_15_2.ease
	local var_15_4 = arg_15_3:GetComponent(typeof(Image)).material

	seriesAsync({
		function(arg_16_0)
			parallelAsync({
				function(arg_17_0)
					var_0_1(self, var_15_4, var_15_1, var_15_3, arg_17_0)

					return
				end,
				function(arg_18_0)
					self:ClearToBlur(arg_15_1, arg_18_0)

					return
				end
			}, arg_16_0)

			return
		end,
		function(arg_19_0)
			parallelAsync({
				function(arg_20_0)
					self:UpdateNextBg(arg_15_1, arg_20_0)

					return
				end,
				function(arg_21_0)
					var_0_1(self, var_15_4, var_15_2, var_15_3, arg_21_0)

					return
				end
			}, arg_19_0)

			return
		end,
		function(arg_22_0)
			parallelAsync({
				function(arg_23_0)
					var_0_1(self, var_15_4, var_15_0, var_15_3, arg_23_0)

					return
				end,
				function(arg_24_0)
					self:BlurToClear(arg_15_1, arg_24_0)

					return
				end
			}, arg_22_0)

			return
		end
	}, arg_15_4)

	return
end

function BlinkStoryPlayer:ClearToBlur(arg_25_1, arg_25_2)
	self.blurFlag = true
	self.blurOptimized.downsample = 0
	self.blurOptimized.blurSize = 0
	self.blurOptimized.blurIteration = 0
	self.blurOptimized.enabled = true

	self:TweenValueWithEase(self._go, 0, 3, arg_25_1.closeTime * arg_25_1.blurTimeFactor[1], 0, arg_25_1.ease, function(arg_26_0)
		self.blurOptimized.blurSize = arg_26_0
		self.blurOptimized.blurIteration = arg_26_0

		return
	end, arg_25_2)

	return
end

function BlinkStoryPlayer:BlurToClear(arg_27_1, arg_27_2)
	self:TweenValueWithEase(self._go, 3, 0, arg_27_1.openTime * arg_27_1.blurTimeFactor[2], 0, arg_27_1.ease, function(arg_28_0)
		self.blurOptimized.blurSize = arg_28_0
		self.blurOptimized.blurIteration = arg_28_0

		return
	end, function()
		self:ClearBlur()
		arg_27_2()

		return
	end)

	return
end

function BlinkStoryPlayer:ClearBlur()
	if self.blurFlag then
		self.blurOptimized.enabled = false
		self.blurOptimized.downsample = self.defaultBlueValues.downsample
		self.blurOptimized.blurSize = self.defaultBlueValues.blurSize
		self.blurOptimized.blurIteration = self.defaultBlueValues.blurIteration
		self.blurFlag = false
	end

	return
end

function BlinkStoryPlayer:UpdateNextBg(arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1:GetNextBgName()

	if not var_31_0 then
		arg_31_2()

		return
	end

	setActive(self.bgPanel, true)

	self.bgPanelCg.alpha = 1
	self.bgImage.color = Color.New(1, 1, 1)
	self.bgImage.sprite = self:GetBg(var_31_0)

	arg_31_2()

	return
end

function BlinkStoryPlayer:RegisetEvent(arg_32_1, arg_32_2)
	arg_32_2()

	return
end

function BlinkStoryPlayer:OnClear()
	self:ClearTarget()
	self:ClearBlur()

	return
end

function BlinkStoryPlayer:OnEnd()
	self:ClearTarget()
	self:ClearBlur()

	return
end

return BlinkStoryPlayer
