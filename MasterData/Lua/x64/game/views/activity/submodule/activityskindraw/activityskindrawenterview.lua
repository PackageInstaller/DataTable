local ActivitySkinDrawEnterView = class("ActivitySkinDrawEnterView", (import("game.views.activity.Main.toggle.ActivityMainBasePanel")))

function ActivitySkinDrawEnterView:GetUIName()
	return T0SkinDrawCfg[self.activityID_].activity_UI
end

function ActivitySkinDrawEnterView:Init()
	self:InitUI()
	self:AddListeners()
end

function ActivitySkinDrawEnterView:InitUI()
	self:BindCfgUI()
end

function ActivitySkinDrawEnterView:AddListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		ActivitySkinDrawTools.OnJumpToSkinDraw(self.activityID_)
	end)
end

function ActivitySkinDrawEnterView:OnEnter()
	ActivitySkinDrawEnterView.super.OnEnter(self)
	self:BindRedPointUI()
end

function ActivitySkinDrawEnterView:OnExit()
	ActivitySkinDrawEnterView.super.OnExit(self)
	self:UnbindRedPointUI()
end

function ActivitySkinDrawEnterView:BindRedPointUI()
	if ActivityData:GetActivityIsOpen(self.activityID_) and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and self.goBtn_ then
		manager.redPoint:bindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_DRAW .. "_" .. self.activityID_)
	end
end

function ActivitySkinDrawEnterView:UnbindRedPointUI()
	if ActivityData:GetActivityIsOpen(self.activityID_) and not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.SKIN_DRAW) and self.goBtn_ then
		manager.redPoint:unbindUIandKey(self.goBtn_.transform, RedPointConst.ACTIVITY_DRAW .. "_" .. self.activityID_)
	end
end

return ActivitySkinDrawEnterView
