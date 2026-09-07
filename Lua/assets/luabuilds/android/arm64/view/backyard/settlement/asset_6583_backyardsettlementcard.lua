local BackYardSettlementCard = class("BackYardSettlementCard")

function BackYardSettlementCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self.additionTF = findTF(self._go, "addition_bg/Text")
	self.levelText = findTF(self._go, "exp/level"):GetComponent(typeof(Text))
	self.additionText = self.additionTF:GetComponent(typeof(Text))
	self.nameTxt = findTF(self._go, "name_bg/Mask/Text"):GetComponent(typeof(ScrollText))
	self.icon = findTF(self._go, "icon"):GetComponent(typeof(Image))
	self.slider = findTF(self._go, "exp/value"):GetComponent(typeof(Slider))

	return
end

function BackYardSettlementCard:Update(arg_2_1, arg_2_2, arg_2_3)
	self:UpdateInfo(arg_2_2)
	self:DoAnimation(arg_2_1, arg_2_2, arg_2_3)

	return
end

function BackYardSettlementCard:UpdateInfo(arg_3_1)
	self.additionText.text = "EXP+" .. 0
	self.levelText.text = "LEVEL" .. arg_3_1.level

	self.nameTxt:SetText(arg_3_1:getName())
	LoadSpriteAtlasAsync("HeroHrzIcon/" .. arg_3_1:getPainting(), "", function(arg_4_0)
		if self.exited then
			return
		end

		self.icon.sprite = arg_4_0

		return
	end)

	return
end

function BackYardSettlementCard:DoAnimation(arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2.level == arg_5_2:getMaxLevel() then
		return
	end

	local var_5_0 = 0.3
	local var_5_1 = arg_5_3.level - arg_5_2.level

	TweenValue(self.additionTF, 0, arg_5_1, var_5_0 * (arg_5_3.level - arg_5_2.level + 1), 0, function(arg_6_0)
		self.additionText.text = "EXP+" .. math.floor(arg_6_0)

		return
	end)

	local var_5_2 = math.max(arg_5_3:getLevelExpConfig().exp, 0.001)

	if var_5_1 > 0 then
		self:DoLevelUpAnimation(arg_5_2.exp, math.max(arg_5_2:getLevelExpConfig().exp, 0.001), arg_5_3.exp, var_5_2, arg_5_3.level, var_5_1, var_5_0)
	else
		TweenValue(self.slider, 0, arg_5_3.exp / var_5_2, var_5_0, 0, function(arg_7_0)
			self:SetSliderValue(self.slider, arg_7_0)

			return
		end)
	end

	return
end

function BackYardSettlementCard:DoLevelUpAnimation(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	local var_8_0

	local function var_8_3()
		TweenValue(self.slider, 0, arg_8_3 / arg_8_4, arg_8_7, 0, function(arg_10_0)
			self:SetSliderValue(self.slider, arg_10_0)

			return
		end)

		return
	end

	local function var_8_4()
		TweenValue(self.slider, 0, 1, arg_8_7, 0, function(arg_12_0)
			self:SetSliderValue(self.slider, arg_12_0)

			return
		end, var_8_0)

		return
	end

	function var_8_0()
		arg_8_6 = arg_8_6 - 1

		if arg_8_6 == 0 then
			var_8_3()
		else
			var_8_4()
		end

		pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_BOAT_LEVEL_UP)

		self.levelText.text = "LEVEL" .. arg_8_5 - arg_8_6

		return
	end

	TweenValue(self.slider, arg_8_1, arg_8_2, arg_8_7, 0, function(arg_14_0)
		self:SetSliderValue(self.slider, arg_14_0 / arg_8_2)

		return
	end, nil)

	return
end

function BackYardSettlementCard:SetSliderValue(arg_15_1, arg_15_2)
	if arg_15_2 ~= 0 and arg_15_2 < 0.03 then
		arg_15_2 = 0.03
	end

	arg_15_1.value = arg_15_2

	return
end

function BackYardSettlementCard:Dispose()
	if LeanTween.isTweening(self.slider.gameObject) then
		LeanTween.cancel(self.slider.gameObject)
	end

	if LeanTween.isTweening(self.additionTF.gameObject) then
		LeanTween.cancel(self.additionTF.gameObject)
	end

	self.exited = true

	return
end

return BackYardSettlementCard
