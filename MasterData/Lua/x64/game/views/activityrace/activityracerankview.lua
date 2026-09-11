local ActivityRaceRankView = class("ActivityRaceRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function ActivityRaceRankView:UIName()
	return ActivityRaceRankTools.GetRankUIName(self.params_.activityID)
end

function ActivityRaceRankView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityRaceRankView:Init()
	self.curRankType_ = var_0_1.ALL

	self:InitUI()
	self:AddUIListeners()
end

function ActivityRaceRankView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityRaceRankTools.GetRankItemClass(self.params_.activityID))
end

function ActivityRaceRankView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.rankList_[arg_5_1])
end

function ActivityRaceRankView:AddUIListeners()
	self:AddToggleListener(self.allToggle_, function(arg_7_0)
		if arg_7_0 then
			self.curRankType_ = var_0_1.ALL

			self:RefreshUI()
		end
	end)
	self:AddToggleListener(self.guildToggle_, function(arg_8_0)
		if arg_8_0 then
			self.curRankType_ = var_0_1.GUILD

			self:RefreshUI()
		end
	end)
end

function ActivityRaceRankView:OnEnter()
	self.activityID_ = self.params_.activityID

	RankAction.QueryActivityRank(self.activityID_)

	if GuildData:GetGuildInfo().id == nil then
		SetActive(self.guildToggleGo_, false)

		self.curRankType_ = var_0_1.ALL
	else
		SetActive(self.guildToggleGo_, true)
		RankAction.QueryGuildActivityRank(self.activityID_)
	end

	self:RefreshUI()
end

function ActivityRaceRankView:RefreshUI()
	self:RefreshSelfRank()
	self:RefreshList()
end

function ActivityRaceRankView:RefreshSelfRank()
	local var_11_0 = PlayerData:GetPlayerInfo()

	self.icon_.sprite = ItemTools.getItemSprite(var_11_0 and var_11_0.portrait)
	self.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_11_0.icon_frame)
	self.name_.text = GetI18NText(var_11_0.nick)

	if self.curRankType_ == var_0_1.ALL then
		local var_11_1 = RankData:GetActivityRank(self.activityID_)

		if var_11_1 then
			local var_11_2, var_11_3 = var_11_1:GetCurRankDes()

			self.rank_.text = var_11_2
			self.score_.text = var_11_3
		else
			self.rank_.text = ""
			self.score_.text = ""
		end
	else
		local var_11_4 = RankData:GetGuildActivityRank(self.activityID_)

		if var_11_4 then
			local var_11_5, var_11_6 = var_11_4:GetCurRankDes()

			self.rank_.text = var_11_5
			self.score_.text = var_11_6
		else
			self.rank_.text = ""
			self.score_.text = ""
		end
	end
end

function ActivityRaceRankView:RefreshNone()
	self.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	self.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function ActivityRaceRankView:RefreshList()
	if self.curRankType_ == var_0_1.ALL then
		local var_13_0 = RankData:GetActivityRank(self.activityID_)

		if var_13_0 then
			self.rankList_ = var_13_0.rankList or {}
		end
	else
		local var_13_1 = RankData:GetGuildActivityRank(self.activityID_)

		if var_13_1 then
			self.rankList_ = var_13_1.rankList or {}
		end
	end

	self.scrollHelper_:StartScroll(#self.rankList_)
end

function ActivityRaceRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityRaceRankView:OnExit()
	manager.windowBar:HideBar()

	self.allToggle_.isOn = true
end

function ActivityRaceRankView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	ActivityRaceRankView.super.Dispose(self)
end

function ActivityRaceRankView:OnRankUpdate()
	self:RefreshUI()
end

return ActivityRaceRankView
