ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivityGodEaterGamePage = class("ActivityGodEaterGamePage", ActivityMainBasePanel)

function ActivityGodEaterGamePage:GetUIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_Entrance/V4_2_GodEaterUI_EntranceUI"
end

function ActivityGodEaterGamePage:Init()
	self.super.Init(self)

	self.preRewardList_ = LuaList.New(handler(self, self.IndexPreviewItem), self.rewardListGo_, CommonItemView)
end

function ActivityGodEaterGamePage:OnEnter()
	ActivityGodEaterGamePage.super.OnEnter(self)
	self:OnUpdateView()
	manager.redPoint:bindUIandKey(self.btn01Btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function ActivityGodEaterGamePage:OnExit()
	ActivityGodEaterGamePage.super.OnExit(self)
	manager.redPoint:unbindUIandKey(self.btn01Btn_.transform, string.format("%s%s", ActivityTools.GetRedPointKey(self.activityID_), self.activityID_))
end

function ActivityGodEaterGamePage:OnTop()
	return
end

function ActivityGodEaterGamePage:OnUpdateView()
	if ActivityCfg[self.activityID_] and ActivityCfg[self.activityID_].reward_show and ActivityCfg[self.activityID_].reward_show ~= "" then
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityCfg[self.activityID_].reward_show) do
			table.insert(var_6_0, rewardToItemTemplate({
				id = iter_6_1
			}, nil, true))
		end

		self.preRewards_ = ItemTools.SortRewardItemList(var_6_0)

		self.preRewardList_:StartScroll(#self.preRewards_)
	end
end

function ActivityGodEaterGamePage:IndexPreviewItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.preRewards_[arg_7_1])
end

function ActivityGodEaterGamePage:RefreshTimeText()
	self.m_timeLab.text = manager.time.WrapTimeStrWithTips(manager.time:GetLostTimeStrWith2Unit(self.stopTime_))
end

function ActivityGodEaterGamePage:AddListeners()
	self:AddBtnListener(self.btn01Btn_, nil, function()
		JumpTools.OpenPageByJump("/ActivityGodEaterGameMainView", {
			activity_id = self.activityID_
		})
	end)
	self:AddBtnListener(self.m_descBtn, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "GOD_EATER_GAME_TIPS_1",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("GOD_EATER_GAME_TIPS_1")
		})
	end)
end

function ActivityGodEaterGamePage:Dispose()
	if self.preRewardList_ then
		self.preRewardList_:Dispose()

		self.preRewardList_ = nil
	end

	ActivityGodEaterGamePage.super.Dispose(self)
end

return ActivityGodEaterGamePage
