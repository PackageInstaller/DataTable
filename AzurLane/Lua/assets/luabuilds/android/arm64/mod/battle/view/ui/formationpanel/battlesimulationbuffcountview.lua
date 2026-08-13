ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleSimulationBuffCountView")

var_0.Battle.BattleSimulationBuffCountView = var_0_3
var_0_3.__name = "BattleSimulationBuffCountView"

function var_0_3.Ctor(arg_1_0, arg_1_1)
	var_0.EventListener.AttachEventListener(arg_1_0)

	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0._timer = var_2.Find(var_1_0, "buff_count/Text")

	local var_1_1 = arg_1_0._timer
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0._text = var_1_2(var_1_1, var_5(var_1_10007))

	return
end

function var_0_3.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._go, arg_2_1)

	return
end

function var_0_3.SetCountDownText(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._text

	i18n = var_1_10003

	local var_3_1 = "simulation_advantage_counting"

	math = var_1_10006
	var_3_0.text = var_1_10003(var_3_1, var_1_10006.floor(arg_3_1))

	return
end

function var_0_3.SetEnhancedText(arg_4_0)
	local var_4_0 = arg_4_0._text

	i18n = var_1_10002
	var_4_0.text = var_1_10002("simulation_enhanced")

	return
end

function var_0_3.Dispose(arg_5_0)
	arg_5_0._rateBarList = nil
	arg_5_0._progressList = nil

	return
end

return
