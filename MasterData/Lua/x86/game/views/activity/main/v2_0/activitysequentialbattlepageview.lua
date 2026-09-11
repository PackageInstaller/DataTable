ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivitySequentialBattlePageView = class("ActivitySequentialBattlePageView", ActivityMainBasePanel)

function ActivitySequentialBattlePageView:GetUIName()
	return SequentialBattleUICfg[SequentialBattleUICfg.get_id_list_by_main_activity_id[self.activityID_][1]].entrance_prefab
end

function ActivitySequentialBattlePageView:OnEnter()
	ActivitySequentialBattlePageView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function ActivitySequentialBattlePageView:OnExit()
	ActivitySequentialBattlePageView.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function ActivitySequentialBattlePageView:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		JumpTools.OpenPageByJump("/sequentialBattleFactory", {
			activityID = self.activityID_
		})
	end)
	self:AddBtnListener(self.descBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("SEQUENTIAL_BATTLE_DESC"),
			key = key
		})
	end)
end

function ActivitySequentialBattlePageView:isHasLeftTimeDes()
	return true
end

return ActivitySequentialBattlePageView
