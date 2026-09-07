ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleControllerCommand = class("BattleControllerCommand", ys.MVC.Command)
ys.Battle.BattleControllerCommand.__name = "BattleControllerCommand"

function ys.Battle.BattleControllerCommand.Ctor(arg_1_0)
	var_0_0.Battle.BattleControllerCommand.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleControllerCommand:Initialize()
	var_0_0.Battle.BattleControllerCommand.super.Initialize(self)

	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	self:InitBattleEvent()

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

function ys.Battle.BattleControllerCommand:scaleTime()
	pg.TipsMgr.GetInstance():ShowTips("┏━━━━━━━━━━━━┓")
	pg.TipsMgr.GetInstance():ShowTips("┃ヽ(•̀ω•́ )ゝ嗑药 X" .. var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE .. " ！(ง •̀_•́)ง┃")
	pg.TipsMgr.GetInstance():ShowTips("┗━━━━━━━━━━━━┛")
	self._state:ScaleTimer()

	return
end

return
