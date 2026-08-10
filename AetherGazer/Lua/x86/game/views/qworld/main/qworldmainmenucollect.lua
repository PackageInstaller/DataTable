QWorldMainMenuItemBase = import("game.views.qworld.main.QWorldMainMenuItemBase")

local var_0_0 = class("QWorldMainMenuCollect", QWorldMainMenuItemBase)

function var_0_0.BindRed(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.transform_, RedPointConst.ACTIVITY_RED_ENVELOPE .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE)
end

function var_0_0.UnBindRed(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.transform_, RedPointConst.ACTIVITY_RED_ENVELOPE .. "_" .. ActivityConst.ACTIVITY_RED_ENVELOPE)
end

function var_0_0.OnBtnClick(arg_3_0)
	if not arg_3_0.mainView:CheckCanInteract() then
		return
	end

	local var_3_0 = 313581

	if QWorldMgr:GetQWorldTagMgr():CheckTagCanOpen(var_3_0) then
		QWorldMgr:GetQWorldTagMgr():GotoTag(var_3_0)
	else
		local var_3_1 = ActivityData:GetActivityData(SandplayTagCfg[var_3_0].activityId)

		ShowTips(GetTipsF("ACTIVITY_SPRING_RED_ENVELOPE_OPEN_TIPS", manager.time:GetLostTimeStr(var_3_1.stopTime)))
	end
end

return var_0_0
