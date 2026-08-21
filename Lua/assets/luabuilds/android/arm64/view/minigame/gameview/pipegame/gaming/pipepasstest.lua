local var_0_0 = class("PipePassTest")
local var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1 = PipeGameVo
	arg_1_0._tf = arg_1_1
	arg_1_0._leftId = 1
	arg_1_0._rightId = 1
	arg_1_0._leftIndex = 1
	arg_1_0._rightIndex = 2
	arg_1_0._leftDirect = {
		0,
		0
	}
	arg_1_0._rightDirect = {
		0,
		0
	}
	arg_1_0._leftTrigger = GetOrAddComponent(findTF(arg_1_0._tf, "left/ok"), typeof(EventTriggerListener))

	arg_1_0._leftTrigger:AddPointClickFunc(function()
		arg_1_0._leftId = tonumber(GetComponent(findTF(arg_1_0._tf, "left/inputId"), typeof(Text)).text)
		arg_1_0._leftIndex = tonumber(GetComponent(findTF(arg_1_0._tf, "left/inputIndex"), typeof(Text)).text)
		arg_1_0._leftDirect = PipeGameConst.map_item_data[arg_1_0._leftId].direct

		setImageSprite(findTF(arg_1_0._tf, "left/icon"), var_0_1.GetSprite(PipeGameConst.map_item_data[arg_1_0._leftId].img), false)

		return
	end)

	arg_1_0._rightTrigger = GetOrAddComponent(findTF(arg_1_0._tf, "right/ok"), typeof(EventTriggerListener))

	arg_1_0._rightTrigger:AddPointClickFunc(function()
		arg_1_0._rightId = tonumber(GetComponent(findTF(arg_1_0._tf, "right/inputId"), typeof(Text)).text)
		arg_1_0._rightIndex = tonumber(GetComponent(findTF(arg_1_0._tf, "right/inputIndex"), typeof(Text)).text)
		arg_1_0._rightDirect = PipeGameConst.map_item_data[arg_1_0._rightId].direct

		setImageSprite(findTF(arg_1_0._tf, "right/icon"), var_0_1.GetSprite(PipeGameConst.map_item_data[arg_1_0._rightId].img), false)

		return
	end)

	arg_1_0._passTrigger = GetOrAddComponent(findTF(arg_1_0._tf, "btnPass"), typeof(EventTriggerListener))

	arg_1_0._passTrigger:AddPointClickFunc(function()
		if callback then
			callback(arg_1_0._leftIndex, arg_1_0._rightIndex, arg_1_0._leftDirect, arg_1_0._rightDirect)
		end

		return
	end)

	return
end

function var_0_0.setPassDesc(arg_5_0, arg_5_1)
	if arg_5_1 then
		setText(findTF(arg_5_0._tf, "passDesc"), "检测通过")
	else
		setText(findTF(arg_5_0._tf, "passDesc"), "检测失败")
	end

	return
end

function var_0_0.setVisible(arg_6_0, arg_6_1)
	setActive(arg_6_0._tf, arg_6_1)

	return
end

function var_0_0.dispose(arg_7_0)
	ClearEventTrigger(arg_7_0._leftTrigger)
	ClearEventTrigger(arg_7_0._rightTrigger)

	return
end

return var_0_0
