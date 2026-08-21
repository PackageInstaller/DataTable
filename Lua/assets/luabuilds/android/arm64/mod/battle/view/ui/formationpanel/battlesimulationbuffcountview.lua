ys = ys or {}

local var_0_2 = class("BattleSimulationBuffCountView")

ys.Battle.BattleSimulationBuffCountView = var_0_2
var_0_2.__name = "BattleSimulationBuffCountView"

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0._timer = arg_1_0._tf:Find("buff_count/Text")
	arg_1_0._text = arg_1_0._timer:GetComponent(typeof(Text))

	return
end

function var_0_2.SetActive(arg_2_0, arg_2_1)
	setActive(arg_2_0._go, arg_2_1)

	return
end

function var_0_2.SetCountDownText(arg_3_0, arg_3_1)
	arg_3_0._text.text = i18n("simulation_advantage_counting", math.floor(arg_3_1))

	return
end

function var_0_2.SetEnhancedText(arg_4_0)
	arg_4_0._text.text = i18n("simulation_enhanced")

	return
end

function var_0_2.Dispose(arg_5_0)
	arg_5_0._rateBarList = nil
	arg_5_0._progressList = nil

	return
end

return
