local PipePassTest = class("PipePassTest")
local var_0_1

function PipePassTest:Ctor(arg_1_1, arg_1_2, arg_1_3)
	var_0_1 = PipeGameVo
	self._tf = arg_1_1
	self._leftId = 1
	self._rightId = 1
	self._leftIndex = 1
	self._rightIndex = 2
	self._leftDirect = {
		0,
		0
	}
	self._rightDirect = {
		0,
		0
	}
	self._leftTrigger = GetOrAddComponent(findTF(self._tf, "left/ok"), typeof(EventTriggerListener))

	self._leftTrigger:AddPointClickFunc(function()
		self._leftId = tonumber(GetComponent(findTF(self._tf, "left/inputId"), typeof(Text)).text)
		self._leftIndex = tonumber(GetComponent(findTF(self._tf, "left/inputIndex"), typeof(Text)).text)
		self._leftDirect = PipeGameConst.map_item_data[self._leftId].direct

		setImageSprite(findTF(self._tf, "left/icon"), var_0_1.GetSprite(PipeGameConst.map_item_data[self._leftId].img), false)

		return
	end)

	self._rightTrigger = GetOrAddComponent(findTF(self._tf, "right/ok"), typeof(EventTriggerListener))

	self._rightTrigger:AddPointClickFunc(function()
		self._rightId = tonumber(GetComponent(findTF(self._tf, "right/inputId"), typeof(Text)).text)
		self._rightIndex = tonumber(GetComponent(findTF(self._tf, "right/inputIndex"), typeof(Text)).text)
		self._rightDirect = PipeGameConst.map_item_data[self._rightId].direct

		setImageSprite(findTF(self._tf, "right/icon"), var_0_1.GetSprite(PipeGameConst.map_item_data[self._rightId].img), false)

		return
	end)

	self._passTrigger = GetOrAddComponent(findTF(self._tf, "btnPass"), typeof(EventTriggerListener))

	self._passTrigger:AddPointClickFunc(function()
		if callback then
			callback(self._leftIndex, self._rightIndex, self._leftDirect, self._rightDirect)
		end

		return
	end)

	return
end

function PipePassTest:setPassDesc(arg_5_1)
	if arg_5_1 then
		setText(findTF(self._tf, "passDesc"), "检测通过")
	else
		setText(findTF(self._tf, "passDesc"), "检测失败")
	end

	return
end

function PipePassTest:setVisible(arg_6_1)
	setActive(self._tf, arg_6_1)

	return
end

function PipePassTest:dispose()
	ClearEventTrigger(self._leftTrigger)
	ClearEventTrigger(self._rightTrigger)

	return
end

return PipePassTest
