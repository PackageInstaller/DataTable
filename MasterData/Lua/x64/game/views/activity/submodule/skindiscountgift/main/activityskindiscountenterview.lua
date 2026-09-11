local ActivitySkinDiscountEnterView = class("ActivitySkinDiscountEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivitySkinDiscountEnterView:GetUIName()
	return ActivitySkinDiscountCfg[ActivitySkinDiscountCfg.get_id_list_by_activity_id[self.activityID_][1]].ui_path
end

function ActivitySkinDiscountEnterView:Init()
	self:InitUI()
	self:AddListeners()
end

function ActivitySkinDiscountEnterView:InitUI()
	self:BindCfgUI()
end

function ActivitySkinDiscountEnterView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "homepage_banner_activity_" .. self.activityID_
		})
		JumpTools.GoToSystem("/skinDiscountGiftMain", {
			activityID = self.activityID_
		}, ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT)
	end)
end

function ActivitySkinDiscountEnterView:OnEnter()
	ActivitySkinDiscountEnterView.super.OnEnter(self)
	self:BindRedPoint()
end

function ActivitySkinDiscountEnterView:BindRedPoint()
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DISCOUNT_GIFT) then
		manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.SKIN_DISCOUNT_GIFT .. "_" .. self.activityID_)
	end
end

function ActivitySkinDiscountEnterView:UnBindRedPoint()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.SKIN_DISCOUNT_GIFT .. "_" .. self.activityID_)
end

function ActivitySkinDiscountEnterView:OnExit()
	self:UnBindRedPoint()
	ActivitySkinDiscountEnterView.super.OnExit(self)
end

function ActivitySkinDiscountEnterView:Dispose()
	self.super.Dispose(self)
end

return ActivitySkinDiscountEnterView
