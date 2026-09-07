local CatteryAddHomeExpAnim = class("CatteryAddHomeExpAnim")
local var_0_1 = 1

function CatteryAddHomeExpAnim:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.expSlider = findTF(self._tf, "slider"):GetComponent(typeof(Slider))
	self.levelTxt = findTF(self._tf, "level"):GetComponent(typeof(Text))
	self.expTxt = findTF(self._tf, "exp"):GetComponent(typeof(Text))
	self.addition = findTF(self._tf, "addition")
	self.additionExp = findTF(self._tf, "addition/exp")
	self.additionExpTxt = self.additionExp:Find("Text"):GetComponent(typeof(Text))
	self.additionItem = findTF(self._tf, "addition/item")
	self.additionItemImg = findTF(self._tf, "addition/item/icon")
	self.animRiseH = self.addition.localPosition.y

	setActive(self._tf, false)

	return
end

function CatteryAddHomeExpAnim:Action(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	setActive(self._tf, true)

	self.callback = arg_2_5

	setAnchoredPosition(self.addition, {
		x = self:GetAwardOffset(arg_2_3, arg_2_4)
	})
	self:RefreshAward(arg_2_3, arg_2_4)
	self:RefreshHome(arg_2_2)

	return
end

function CatteryAddHomeExpAnim:GetAwardOffset(arg_3_1, arg_3_2)
	return (arg_3_1 or arg_3_2) and -82 or -15
end

function CatteryAddHomeExpAnim:RefreshAward(arg_4_1, arg_4_2)
	if arg_4_1 then
		GetImageSpriteFromAtlasAsync("Props/20010", "", self.additionItemImg)
	elseif arg_4_2 then
		GetImageSpriteFromAtlasAsync("Props/dormMoney", "", self.additionItemImg)
	end

	setActive(self.additionItem, arg_4_1 or arg_4_2)

	return
end

function CatteryAddHomeExpAnim:RefreshHome(arg_5_1)
	local var_5_0 = getProxy(CommanderProxy):GetCommanderHome()

	self.additionExpTxt.text = arg_5_1 .. "<size=40>EXP</size>"

	if var_5_0.exp - arg_5_1 < 0 then
		self:DoUpgradeAnim(var_5_0, arg_5_1)
	else
		self:DoAddExpAnim(var_5_0, arg_5_1)
	end

	return
end

function CatteryAddHomeExpAnim:DoUpgradeAnim(arg_6_1, arg_6_2)
	self.levelTxt.text = "LV." .. arg_6_1:GetLevel() - 1

	if arg_6_2 == 0 then
		self:IfIsMaxLevel(arg_6_1, arg_6_2, true)

		return
	end

	local var_6_0 = arg_6_1:GetPrevLevelExp()
	local var_6_1 = var_6_0 - math.abs(arg_6_1.exp - arg_6_2)

	self.expTxt.text = "<color=#92FC63FF>" .. var_6_1 .. "/</color>" .. var_6_0
	self.expSlider.value = var_6_1 / var_6_0

	local var_6_2 = arg_6_1:GetNextLevelExp()
	local var_6_3 = arg_6_1.exp / var_6_2

	self:AddExpAnim(var_6_1 / var_6_0, 1, var_6_1, var_6_0, var_6_0, function()
		self.levelTxt.text = "LV." .. arg_6_1:GetLevel()

		self:AddExpAnim(0, var_6_3, 0, arg_6_1.exp, var_6_2, function()
			self:IfIsMaxLevel(arg_6_1, arg_6_2)

			return
		end)

		return
	end)
	self:AdditionAnim(var_0_1, function()
		if self.callback then
			self.callback()
		end

		self.callback = nil

		return
	end)

	return
end

function CatteryAddHomeExpAnim:DoAddExpAnim(arg_10_1, arg_10_2)
	self.levelTxt.text = "LV." .. arg_10_1:GetLevel()

	if arg_10_2 == 0 then
		self:IfIsMaxLevel(arg_10_1, arg_10_2, true)

		return
	end

	local var_10_0 = arg_10_1:GetNextLevelExp()

	self:AddExpAnim((arg_10_1.exp - arg_10_2) / var_10_0, arg_10_1.exp / var_10_0, arg_10_1.exp - arg_10_2, arg_10_1.exp, var_10_0)
	self:AdditionAnim(var_0_1, function()
		if self.callback then
			self.callback()
		end

		self.callback = nil

		self:IfIsMaxLevel(arg_10_1, arg_10_2)

		return
	end)

	return
end

function CatteryAddHomeExpAnim:IfIsMaxLevel(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_1:IsMaxLevel() then
		self.expTxt.text = "MAX"
		self.expSlider.value = 1
	end

	self:HideOrShowAddition(arg_12_2)

	if arg_12_3 then
		if not IsNil(self.additionItem) and isActive(self.additionItem) then
			self:AdditionAnim(var_0_1, function()
				if self.callback then
					self.callback()
				end

				self.callback = nil

				return
			end)
		else
			Timer.New(function()
				if self.callback then
					self.callback()
				end

				self.callback = nil

				return
			end, var_0_1, 1):Start()
		end
	end

	return
end

function CatteryAddHomeExpAnim:HideOrShowAddition(arg_15_1)
	setActive(self.additionExp, arg_15_1 > 0)

	return
end

function CatteryAddHomeExpAnim:Clear()
	if not IsNil(self.expSlider) and LeanTween.isTweening(go(self.expSlider)) then
		LeanTween.cancel(go(self.expSlider))
	end

	if not IsNil(self.expTxt) and LeanTween.isTweening(go(self.expTxt)) then
		LeanTween.cancel(go(self.expTxt))
	end

	if not IsNil(self.addition) and LeanTween.isTweening(go(self.addition)) then
		LeanTween.cancel(go(self.addition))
	end

	return
end

function CatteryAddHomeExpAnim:Hide()
	self:Clear()
	setActive(self._tf, false)

	return
end

function CatteryAddHomeExpAnim:Dispose()
	self:Hide()

	return
end

function CatteryAddHomeExpAnim:AddExpAnim(arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5, arg_19_6)
	parallelAsync({
		function(arg_20_0)
			LeanTween.value(go(self.expSlider), arg_19_1, arg_19_2, var_0_1):setOnUpdate(System.Action_float(function(arg_21_0)
				self.expSlider.value = arg_21_0

				return
			end)):setOnComplete(System.Action(arg_20_0))

			return
		end,
		function(arg_22_0)
			LeanTween.value(go(self.expTxt), arg_19_3, arg_19_4, var_0_1):setOnUpdate(System.Action_float(function(arg_23_0)
				self.expTxt.text = "<color=#92FC63FF>" .. math.ceil(arg_23_0) .. "/</color>" .. arg_19_5

				return
			end)):setOnComplete(System.Action(arg_22_0))

			return
		end
	}, function()
		if arg_19_6 then
			arg_19_6()
		end

		return
	end)

	return
end

function CatteryAddHomeExpAnim:AdditionAnim(arg_25_1, arg_25_2)
	setActive(self.addition, true)
	LeanTween.value(go(self.addition), self.animRiseH, self.animRiseH + 25, arg_25_1):setOnUpdate(System.Action_float(function(arg_26_0)
		self.addition.localPosition = Vector3(self.addition.localPosition.x, arg_26_0, 0)

		return
	end)):setOnComplete(System.Action(function()
		setActive(self.addition, false)
		arg_25_2()

		self.addition.localPosition = Vector3(self.addition.localPosition.x, 0, 0)

		return
	end))

	return
end

return CatteryAddHomeExpAnim
