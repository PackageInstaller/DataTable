ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleControllerCommand = class("BattleControllerCommand", ys.MVC.Command)
ys.Battle.BattleControllerCommand.__name = "BattleControllerCommand"

function ys.Battle.BattleControllerCommand.Ctor(arg_1_0)
	var_0_0.Battle.BattleControllerCommand.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleControllerCommand.Initialize(arg_2_0)
	var_0_0.Battle.BattleControllerCommand.super.Initialize(arg_2_0)

	arg_2_0._dataProxy = arg_2_0._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	arg_2_0:InitBattleEvent()

	return
end

function ys.Battle.BattleControllerCommand.InitBattleEvent(arg_3_0)
	return
end

function ys.Battle.BattleControllerCommand.addSpeed(arg_4_0)
	var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE = var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE * arg_4_0

	var_0_0.Battle.BattleVariable.AppendIFFFactor(var_0_0.Battle.BattleConfig.FOE_CODE, "cheat_speed_up_" .. var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE, arg_4_0)
	var_0_0.Battle.BattleVariable.AppendIFFFactor(var_0_0.Battle.BattleConfig.FRIENDLY_CODE, "cheat_speed_up_" .. var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE, arg_4_0)

	return
end

function ys.Battle.BattleControllerCommand.removeSpeed(arg_5_0)
	var_0_0.Battle.BattleVariable.RemoveIFFFactor(var_0_0.Battle.BattleConfig.FOE_CODE, "cheat_speed_up_" .. var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE)
	var_0_0.Battle.BattleVariable.RemoveIFFFactor(var_0_0.Battle.BattleConfig.FRIENDLY_CODE, "cheat_speed_up_" .. var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE)

	var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE = var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE * arg_5_0

	return
end

function ys.Battle.BattleControllerCommand.scaleTime(arg_6_0)
	pg.TipsMgr.GetInstance():ShowTips("┏━━━━━━━━━━━━┓")
	pg.TipsMgr.GetInstance():ShowTips("┃ヽ(•̀ω•́ )ゝ嗑药 X" .. var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE .. " ！(ง •̀_•́)ง┃")
	pg.TipsMgr.GetInstance():ShowTips("┗━━━━━━━━━━━━┛")
	arg_6_0._state:ScaleTimer()

	return
end

return
