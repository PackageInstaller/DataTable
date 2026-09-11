local ActivityAttributeArenaRankView = class("ActivityAttributeArenaRankView", ReduxView)

function ActivityAttributeArenaRankView:UIName()
	return AttributeArenaTools.GetRankUI(self.params_.rank_activity_id)
end

local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function ActivityAttributeArenaRankView:UIParent()
	return manager.ui.uiMain.transform
end

function ActivityAttributeArenaRankView:Init()
	self.curRankType_ = var_0_1.ALL

	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddUIListeners()
end

function ActivityAttributeArenaRankView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityAttributeArenaRankItem)
	self.switchList = LuaList.New(handler(self, self.IndexSwitchItem), self.switchList_, ActivityAttributeArenaRankSwitchItem)
	self.switchItemClickHandle = handler(self, self.SwitchItemClick)
	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
end

function ActivityAttributeArenaRankView:IndexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(self.rankList_[arg_5_1])
end

function ActivityAttributeArenaRankView:IndexSwitchItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.index)
	arg_6_2:RegistCallBack(self.switchItemClickHandle)
end

function ActivityAttributeArenaRankView:SwitchItemClick(arg_7_1)
	self.params_.index = arg_7_1
	self.index = arg_7_1

	RankAction.QueryActivityRank(self.activityID_, self.index)

	if GuildData:GetGuildInfo().id == nil then
		self.tabNumController_:SetSelectedState("01")

		self.curRankType_ = var_0_1.ALL
	else
		self.tabNumController_:SetSelectedState("02")
		RankAction.QueryGuildActivityRank(self.activityID_, self.index)
	end

	self.switchList:Refresh()
end

function ActivityAttributeArenaRankView:AddUIListeners()
	self:AddBtnListener(self.clubBtn_, nil, function()
		self:SwitchPageIfDiff(var_0_1.GUILD)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self:SwitchPageIfDiff(var_0_1.ALL)
	end)
end

function ActivityAttributeArenaRankView:OnEnter()
	self.activityID_ = self.params_.rank_activity_id
	self.index = self.params_.index and self.params_.index or 1

	RankAction.QueryActivityRank(self.activityID_, self.index)

	if GuildData:GetGuildInfo().id == nil then
		self.tabNumController_:SetSelectedState("01")

		self.curRankType_ = var_0_1.ALL
	else
		self.tabNumController_:SetSelectedState("02")
		RankAction.QueryGuildActivityRank(self.activityID_, self.index)
	end

	self.switchList:StartScroll(3)
	self:RefreshUI()
end

function ActivityAttributeArenaRankView:SwitchPageIfDiff(arg_12_1)
	if self.curRankType_ ~= arg_12_1 then
		self.curRankType_ = arg_12_1

		self:RefreshUI()
	end
end

function ActivityAttributeArenaRankView:RefreshUI()
	self:RefreshSelfRank()
	self:RefreshList()
end

function ActivityAttributeArenaRankView:RefreshSelfRank()
	local var_14_0 = PlayerData:GetPlayerInfo()

	self.commonPortrait_:RenderHead(var_14_0 and var_14_0.portrait)
	self.commonPortrait_:RenderFrame(var_14_0.icon_frame)

	self.name_.text = var_14_0.nick

	if self.curRankType_ == var_0_1.ALL then
		local var_14_1 = RankData:GetActivityRank(self.activityID_, self.index)

		if var_14_1 then
			local var_14_2, var_14_3 = var_14_1:GetCurRankDes()

			self.rank_.text = var_14_2
			self.score_.text = var_14_3
		else
			self.rank_.text = ""
			self.score_.text = ""
		end

		self.tabController_:SetSelectedState("all")
	else
		local var_14_4 = RankData:GetGuildActivityRank(self.activityID_, self.index)

		if var_14_4 then
			local var_14_5, var_14_6 = var_14_4:GetCurRankDes()

			self.rank_.text = var_14_5
			self.score_.text = var_14_6
		else
			self.rank_.text = ""
			self.score_.text = ""
		end

		self.tabController_:SetSelectedState("club")
	end
end

function ActivityAttributeArenaRankView:RefreshNone()
	self.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	self.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function ActivityAttributeArenaRankView:RefreshList()
	if self.curRankType_ == var_0_1.ALL then
		local var_16_0 = RankData:GetActivityRank(self.activityID_, self.index)

		if var_16_0 then
			self.rankList_ = var_16_0.rankList or {}
		end
	else
		local var_16_1 = RankData:GetGuildActivityRank(self.activityID_, self.index)

		if var_16_1 then
			self.rankList_ = var_16_1.rankList or {}
		end
	end

	self.scrollHelper_:StartScroll(#self.rankList_)
end

function ActivityAttributeArenaRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ActivityAttributeArenaRankView:OnExit()
	manager.windowBar:HideBar()
	self:SwitchPageIfDiff(var_0_1.ALL)
end

function ActivityAttributeArenaRankView:Dispose()
	self:RemoveAllListeners()
	self.commonPortrait_:Dispose()
	self.scrollHelper_:Dispose()
	self.switchList:Dispose()
	ActivityAttributeArenaRankView.super.Dispose(self)
end

function ActivityAttributeArenaRankView:OnRankUpdate()
	self:RefreshUI()
end

function ActivityAttributeArenaRankView:AdaptLeft()
	if self.leftTrs_ == nil then
		self.leftGo_ = self:FindGo("RankUI_01/panel/left")
		self.leftTrs_ = self.leftGo_:GetComponent(typeof(RectTransform))
		self.needAdaptLeft_ = false
	end

	ActivityAttributeArenaRankView.super.AdaptLeft(self)
end

function ActivityAttributeArenaRankView:AdaptRight()
	if self.rightTrs_ == nil then
		self.rightGo_ = self:FindGo("RankUI_01/panel/right_adapt")
		self.rightTrs_ = self.rightGo_:GetComponent(typeof(RectTransform))
		self.needAdaptRight_ = true
	end

	ActivityAttributeArenaRankView.super.AdaptRight(self)
end

return ActivityAttributeArenaRankView
