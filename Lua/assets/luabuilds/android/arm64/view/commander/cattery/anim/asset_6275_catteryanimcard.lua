local CatteryAnimCard = class("CatteryAnimCard", import("..CatterySettlementCard"))
local var_0_1 = 1

function CatteryAnimCard:Ctor(arg_1_1)
	self._tf = arg_1_1
	self.emptyTF = findTF(self._tf, "empty")
	self.commanderTF = findTF(self._tf, "commander")
	self.char = self.commanderTF:Find("mask/char")
	self.slider = self.commanderTF:Find("slider"):GetComponent(typeof(Slider))
	self.nameTxt = self.commanderTF:Find("name/Text"):GetComponent(typeof(Text))
	self.levelTxt = self.commanderTF:Find("name/level"):GetComponent(typeof(Text))
	self.expTxt = self.commanderTF:Find("exp"):GetComponent(typeof(Text))
	self.addition = self.commanderTF:Find("addition")
	self.additionTxt = self.addition:Find("Text"):GetComponent(typeof(Text))
	self.additionY = self.addition.localPosition.y

	return
end

function CatteryAnimCard:UpdateCommander()
	CatteryAnimCard.super.UpdateCommander(self)

	self.additionTxt.text = self.exp .. "<size=40>EXP</size>"

	return
end

function CatteryAnimCard:Action(arg_3_1)
	setActive(self.addition, false)

	if not self.commander or self.exp <= 0 then
		arg_3_1()

		return
	end

	local var_3_0 = {}

	self:InitAnim(var_3_0)
	table.insert(var_3_0, function(arg_4_0)
		self:AdditionAnim(var_0_1, arg_4_0)

		return
	end)
	parallelAsync(var_3_0, arg_3_1)

	return
end

function CatteryAnimCard:Clear()
	CatteryAnimCard.super.Clear(self)

	if LeanTween.isTweening(go(self.addition)) then
		LeanTween.cancel(go(self.addition))
	end

	return
end

function CatteryAnimCard:LoadCommander(arg_6_1)
	self:ReturnCommander()

	self.painting = arg_6_1:getPainting()

	setCommanderPaintingPrefab(self.char, self.painting, "result1")

	return
end

function CatteryAnimCard:AdditionAnim(arg_7_1, arg_7_2)
	setActive(self.addition, true)

	local var_7_0 = self.additionY

	LeanTween.value(go(self.addition), self.additionY, self.additionY + 25, arg_7_1):setOnUpdate(System.Action_float(function(arg_8_0)
		self.addition.localPosition = Vector3(self.addition.localPosition.x, arg_8_0, 0)

		return
	end)):setOnComplete(System.Action(function()
		setActive(self.addition, false)
		arg_7_2()

		self.addition.localPosition = Vector3(self.addition.localPosition.x, var_7_0, 0)

		return
	end))

	return
end

function CatteryAnimCard:GetColor()
	return "#ffffff"
end

return CatteryAnimCard
