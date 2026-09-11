local ActivityMatrixRankView = class("ActivityMatrixRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function ActivityMatrixRankView:UIName()
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeSoloRoguelikeRankUI"
end

function ActivityMatrixRankView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityMatrixRankView:Init()
	self.curRankType_ = var_0_1.ALL

	self:InitUI()
	self:AddUIListeners()
end

function ActivityMatrixRankView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityMatrixRankItem)
end

function ActivityMatrixRankView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.rankList_[arg_5_1])
end

function ActivityMatrixRankView:AddUIListeners()
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

function ActivityMatrixRankView:OnEnter()
	self.activityID_ = self.params_.activityId

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

function ActivityMatrixRankView:RefreshUI()
	self:RefreshSelfRank()
	self:RefreshList()
end

function ActivityMatrixRankView:RefreshSelfRank()
	local var_11_0 = PlayerData:GetPlayerInfo()

	self.icon_.sprite = ItemTools.getItemSprite(var_11_0 and var_11_0.portrait)
	self.frame_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. var_11_0.icon_frame)
	self.name_.text = var_11_0.nick

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

function ActivityMatrixRankView:RefreshNone()
	self.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	self.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function ActivityMatrixRankView:RefreshList()
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

	table.sort(self.rankList_, function(arg_14_0, arg_14_1)
		return arg_14_0.rank < arg_14_1.rank
	end)
	self.scrollHelper_:StartScroll(#self.rankList_)
end

function ActivityMatrixRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityMatrixRankView:OnExit()
	manager.windowBar:HideBar()

	self.allToggle_.isOn = true
end

function ActivityMatrixRankView:Dispose()
	self:RemoveAllListeners()
	self.scrollHelper_:Dispose()
	ActivityMatrixRankView.super.Dispose(self)
end

function ActivityMatrixRankView:OnActivityMatrixRankUpdate()
	self:RefreshUI()
end

function ActivityMatrixRankView:OnRankUpdate()
	self:RefreshUI()
end

return ActivityMatrixRankView
