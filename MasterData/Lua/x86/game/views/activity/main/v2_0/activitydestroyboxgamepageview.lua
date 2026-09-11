ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityDestroyBoxGamePageView = class("ActivityDestroyBoxGamePageView", ActivityMainBasePanel)

function ActivityDestroyBoxGamePageView:GetUIName()
	return DestroyBoxGameUICfg[DestroyBoxGameUICfg.get_id_list_by_main_activity_id[self.activityID_][1]].entrance_prefab
end

function ActivityDestroyBoxGamePageView:OnEnter()
	ActivityDestroyBoxGamePageView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function ActivityDestroyBoxGamePageView:OnExit()
	ActivityDestroyBoxGamePageView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function ActivityDestroyBoxGamePageView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self:Go("/destroyBoxGame", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(DestroyBoxGameUICfg[DestroyBoxGameUICfg.get_id_list_by_main_activity_id[self.activityID_][1]].desc),
			key = DestroyBoxGameUICfg[DestroyBoxGameUICfg.get_id_list_by_main_activity_id[self.activityID_][1]].desc
		})
	end)
end

function ActivityDestroyBoxGamePageView:isHasLeftTimeDes()
	return true
end

return ActivityDestroyBoxGamePageView
