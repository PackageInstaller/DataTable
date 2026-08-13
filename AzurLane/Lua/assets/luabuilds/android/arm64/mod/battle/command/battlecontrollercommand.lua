ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleControllerCommand = var_0_10002("BattleControllerCommand", var_0.MVC.Command)
var_0.Battle.BattleControllerCommand.__name = "BattleControllerCommand"

function var_0.Battle.BattleControllerCommand.Ctor(arg_1_0)
	var_0.Battle.BattleControllerCommand.super.Ctor(arg_1_0)

	return
end

function var_0.Battle.BattleControllerCommand.Initialize(arg_2_0)
	var_0.Battle.BattleControllerCommand.super.Initialize(arg_2_0)

	local var_2_0 = arg_2_0._state

	arg_2_0._dataProxy = var_1.GetProxyByName(var_2_0, var_0.Battle.BattleDataProxy.__name)

	arg_2_0:InitBattleEvent()

	return
end

function var_0.Battle.BattleControllerCommand.InitBattleEvent(arg_3_0)
	return
end

function var_0.Battle.BattleControllerCommand.addSpeed(arg_4_0)
	var_0.Battle.BattleConfig.BASIC_TIME_SCALE = var_0.Battle.BattleConfig.BASIC_TIME_SCALE * arg_4_0

	var_0.Battle.BattleVariable.AppendIFFFactor(var_0.Battle.BattleConfig.FOE_CODE, "cheat_speed_up_" .. var_0.Battle.BattleConfig.BASIC_TIME_SCALE, arg_4_0)
	var_0.Battle.BattleVariable.AppendIFFFactor(var_0.Battle.BattleConfig.FRIENDLY_CODE, "cheat_speed_up_" .. var_0.Battle.BattleConfig.BASIC_TIME_SCALE, arg_4_0)

	return
end

function var_0.Battle.BattleControllerCommand.removeSpeed(arg_5_0)
	var_0.Battle.BattleVariable.RemoveIFFFactor(var_0.Battle.BattleConfig.FOE_CODE, "cheat_speed_up_" .. var_0.Battle.BattleConfig.BASIC_TIME_SCALE)
	var_0.Battle.BattleVariable.RemoveIFFFactor(var_0.Battle.BattleConfig.FRIENDLY_CODE, "cheat_speed_up_" .. var_0.Battle.BattleConfig.BASIC_TIME_SCALE)

	var_0.Battle.BattleConfig.BASIC_TIME_SCALE = var_0.Battle.BattleConfig.BASIC_TIME_SCALE * arg_5_0

	return
end

function var_0.Battle.BattleControllerCommand.scaleTime(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.TipsMgr.GetInstance()

	var_1.ShowTips(var_6_0, "┏━━━━━━━━━━━━┓")

	pg = var_1

	local var_6_1 = var_1.TipsMgr.GetInstance()

	var_1.ShowTips(var_6_1, "┃ヽ(•̀ω•́ )ゝ嗑药 X" .. var_0.Battle.BattleConfig.BASIC_TIME_SCALE .. " ！(ง •̀_•́)ง┃")

	pg = var_1

	local var_6_2 = var_1.TipsMgr.GetInstance()

	var_1.ShowTips(var_6_2, "┗━━━━━━━━━━━━┛")

	local var_6_3 = arg_6_0._state

	var_1.ScaleTimer(var_6_3)

	return
end

return
