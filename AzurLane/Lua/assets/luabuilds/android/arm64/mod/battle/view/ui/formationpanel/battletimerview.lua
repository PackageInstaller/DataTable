ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleTimerView = var_0_10002("BattleTimerView")
var_0.Battle.BattleTimerView.__name = "BattleTimerView"

function var_0.Battle.BattleTimerView.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	local var_1_0 = arg_1_0._go.transform

	arg_1_0._timer = var_2.Find(var_1_0, "Text")

	local var_1_1 = arg_1_0._timer
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Animator = var_1_10007
	arg_1_0._blinker = var_1_2(var_1_1, var_5(var_1_10007))
	arg_1_0._isBlink = false

	local var_1_3 = arg_1_0._timer
	local var_1_4 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0._text = var_1_4(var_1_3, var_5(var_1_10007))
	arg_1_0.timeStr = ""

	return
end

function var_0.Battle.BattleTimerView.SetActive(arg_2_0, arg_2_1)
	setActive = var_1_10002

	var_1_10002(arg_2_0._go, arg_2_1)

	return
end

function var_0.Battle.BattleTimerView.SetCountDownText(arg_3_0, arg_3_1)
	if arg_3_1 <= 30 and not arg_3_0._isBlink then
		arg_3_0._blinker.enabled = true
		arg_3_0._isBlink = true
	end

	local var_3_0 = arg_3_0.formatTime

	math = var_1_10004

	if var_3_0(var_1_10004.floor(arg_3_1)) == arg_3_0.timeStr then
		return
	end

	arg_3_0.timeStr = var_2
	arg_3_0._text.text = var_2

	return
end

function var_0.Battle.BattleTimerView.formatTime(arg_4_0)
	string = var_1_10001

	local var_4_0 = var_1_10001.format
	local var_4_1 = "%02u:%02u"

	math = var_1_10004

	return var_4_0(var_4_1, var_1_10004.floor(arg_4_0 / 60), arg_4_0 % 60)
end

function var_0.Battle.BattleTimerView.Dispose(arg_5_0)
	return
end

return
