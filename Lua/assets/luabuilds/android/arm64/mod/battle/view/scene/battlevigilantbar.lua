ys = ys or {}
ys.Battle.BattleVigilantBar = class("BattleVigilantBar")
ys.Battle.BattleVigilantBar.__name = "BattleVigilantBar"

local var_0_0 = ys.Battle.BattleVigilantBar

ys.Battle.BattleVigilantBar.MIN = 0.267
ys.Battle.BattleVigilantBar.MAX = 0.7335
ys.Battle.BattleVigilantBar.METER_LENGTH = ys.Battle.BattleVigilantBar.MAX - ys.Battle.BattleVigilantBar.MIN
ys.Battle.BattleVigilantBar.STATE_CALM = 0
ys.Battle.BattleVigilantBar.STATE_SUSPICIOUS = 1
ys.Battle.BattleVigilantBar.STATE_VIGILANT = 2
ys.Battle.BattleVigilantBar.STATE_ENGAGE = 3

function ys.Battle.BattleVigilantBar.Ctor(arg_1_0, arg_1_1)
	arg_1_0._vigilantBar = arg_1_1
	arg_1_0._vigilantBarGO = arg_1_0._vigilantBar.gameObject
	arg_1_0._progress = arg_1_0._vigilantBar:Find("progress"):GetComponent(typeof(Image))
	arg_1_0._markList = {}
	arg_1_0._markList[var_0_0.STATE_CALM] = arg_1_0._vigilantBar:Find("mark/" .. var_0_0.STATE_CALM)
	arg_1_0._markList[var_0_0.STATE_SUSPICIOUS] = arg_1_0._vigilantBar:Find("mark/" .. var_0_0.STATE_SUSPICIOUS)
	arg_1_0._markList[var_0_0.STATE_VIGILANT] = arg_1_0._vigilantBar:Find("mark/" .. var_0_0.STATE_VIGILANT)
	arg_1_0._markList[var_0_0.STATE_ENGAGE] = arg_1_0._vigilantBar:Find("mark/" .. var_0_0.STATE_ENGAGE)

	return
end

function ys.Battle.BattleVigilantBar.ConfigVigilant(arg_2_0, arg_2_1)
	arg_2_0._vigilantState = arg_2_1

	return
end

function ys.Battle.BattleVigilantBar.UpdateVigilantProgress(arg_3_0)
	arg_3_0._progress.fillAmount = arg_3_0.meterConvert((arg_3_0._vigilantState:GetVigilantRate()))

	return
end

function ys.Battle.BattleVigilantBar.UpdateVigilantMark(arg_4_0)
	local var_4_0 = arg_4_0._vigilantState:GetVigilantMark()

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._markList) do
		SetActive(iter_4_1, var_4_0 == iter_4_0)
	end

	return
end

function ys.Battle.BattleVigilantBar.UpdateVigilantBarPosition(arg_5_0, arg_5_1)
	arg_5_0._vigilantBar.position = arg_5_1

	return
end

function ys.Battle.BattleVigilantBar.meterConvert(arg_6_0)
	return var_0_0.METER_LENGTH * arg_6_0 + var_0_0.MIN
end

function ys.Battle.BattleVigilantBar.Dispose(arg_7_0)
	arg_7_0._vigilantState = nil

	Object.Destroy(arg_7_0._vigilantBarGO)

	arg_7_0._vigilantBar = nil
	arg_7_0._vigilantBarGO = nil
	arg_7_0._markList = nil
	arg_7_0._progress = nil

	return
end

return
