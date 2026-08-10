local var_0_0 = import("game.views.seaWarfare.SeaWarfareBattleReadyView")
local var_0_1 = class("SeaWarfareNormalBattleReadyView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	var_0_1.super.OnEnter(arg_1_0)
	QWorldMgr:EnableCustomCamera(SeaWarfareConst.CAMERA_GROUP_ID, 1, QWorldCameraLayer.System)
	SeaWarfareModelView:GetInstance():Load()
end

function var_0_1.OnExit(arg_2_0)
	var_0_1.super.OnExit(arg_2_0)
	QWorldMgr:ExitCustomCamera(SandplayCameraGroupCfg[SeaWarfareConst.CAMERA_GROUP_ID].camera[1])
	SeaWarfareModelView:GetInstance():Unload()
end

return var_0_1
