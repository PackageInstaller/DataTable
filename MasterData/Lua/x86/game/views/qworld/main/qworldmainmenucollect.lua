QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local QWorldMainMenuCollect = class("QWorldMainMenuCollect", QWorldMainMenuItemBase)

function QWorldMainMenuCollect:BindRed()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.ACTIVITY_RED_ENVELOPE .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE)
end

function QWorldMainMenuCollect:UnBindRed()
	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.ACTIVITY_RED_ENVELOPE .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE)
end

function QWorldMainMenuCollect:OnBtnClick()
	if not self.mainView:CheckCanInteract() then
		return
	end

	local var_3_0 = 313581

	if QWorldMgr:GetQWorldTagMgr():CheckTagCanOpen(313581) then
		QWorldMgr:GetQWorldTagMgr():GotoTag(var_3_0)
	else
		ShowTips(GetTipsF("ACTIVITY_SPRING_RED_ENVELOPE_OPEN_TIPS", manager.time:GetLostTimeStr(ActivityData:GetActivityData(SandplayTagCfg[var_3_0].activityId).stopTime)))
	end
end

return QWorldMainMenuCollect
