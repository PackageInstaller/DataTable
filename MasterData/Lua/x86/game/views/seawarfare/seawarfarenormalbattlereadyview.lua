local SeaWarfareNormalBattleReadyView = class("SeaWarfareNormalBattleReadyView", (import("game.views.seaWarfare.SeaWarfareBattleReadyView")))

function SeaWarfareNormalBattleReadyView:OnEnter()
	SeaWarfareNormalBattleReadyView.super.OnEnter(self)
	QWorldMgr:EnableCustomCamera(SeaWarfareConst.CAMERA_GROUP_ID, 1, QWorldCameraLayer.System)
	SeaWarfareModelView:GetInstance():Load()
end

function SeaWarfareNormalBattleReadyView:OnExit()
	SeaWarfareNormalBattleReadyView.super.OnExit(self)
	QWorldMgr:ExitCustomCamera(SandplayCameraGroupCfg[SeaWarfareConst.CAMERA_GROUP_ID].camera[1])
	SeaWarfareModelView:GetInstance():Unload()
end

return SeaWarfareNormalBattleReadyView
