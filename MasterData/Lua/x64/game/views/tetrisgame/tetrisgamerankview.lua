local TetrisGameRankView = class("TetrisGameRankView", ReduxView)

function TetrisGameRankView:UIName()
	return "Widget/Version/Alone_TetrisGameUI/TetrisGameRankUI"
end

function TetrisGameRankView:UIParent()
	return manager.ui.uiMain.transform
end

function TetrisGameRankView:OnCtor()
	return
end

local var_0_1 = {
	all = 2,
	club = 1
}

function TetrisGameRankView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function TetrisGameRankView:InitUI()
	self:BindCfgUI()

	self.uiList_ = LuaList.New(handler(self, self.indexItem), self.uilistGo_, TetrisGameRankItem)
	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function TetrisGameRankView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.rankList_[arg_6_1])
end

function TetrisGameRankView:AddUIListeners()
	self:AddBtnListener(self.clubBtn_, nil, function()
		if self.index == var_0_1.club then
			return
		end

		self:SwitchPageIfDiff(var_0_1.club)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		if self.index == var_0_1.all then
			return
		end

		self:SwitchPageIfDiff(var_0_1.all)
	end)
end

function TetrisGameRankView:OnEnter()
	self.activityID_ = self.params_.rankActivityID

	if not self.activityID_ then
		return
	end

	local var_10_0 = self.params_.index or self.index or var_0_1.all

	self:RefreshBtnState()
	self:SwitchPageIfDiff(var_10_0)
end

function TetrisGameRankView:OnTop()
	self:UpdateBar()
end

function TetrisGameRankView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function TetrisGameRankView:OnBehind()
	manager.windowBar:HideBar()
end

function TetrisGameRankView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function TetrisGameRankView:RefreshBtnState()
	if GuildData:GetGuildInfo().id == nil then
		self.tabNumController_:SetSelectedState("01")
	else
		self.tabNumController_:SetSelectedState("02")
	end
end

function TetrisGameRankView:SwitchPageIfDiff(arg_16_1)
	self.index = arg_16_1

	if self.index == var_0_1.all then
		RankAction.QueryActivityRank(self.activityID_)
	else
		RankAction.QueryGuildActivityRank(self.activityID_)
	end
end

function TetrisGameRankView:OnRankUpdate()
	if self.index == var_0_1.all then
		local var_17_0 = RankData:GetActivityRank(self.activityID_)

		if var_17_0 then
			self.rankList_ = var_17_0.rankList or {}
		end
	else
		local var_17_1 = RankData:GetGuildActivityRank(self.activityID_)

		if var_17_1 then
			self.rankList_ = var_17_1.rankList or {}
		end
	end

	self.uiList_:StartScroll(#self.rankList_)
	self:RefreshSelfRank()
end

function TetrisGameRankView:RefreshSelfRank()
	local var_18_0 = PlayerData:GetPlayerInfo()

	self.commonPortrait_:RenderHead(var_18_0 and var_18_0.portrait)
	self.commonPortrait_:RenderFrame(var_18_0.icon_frame)

	self.name_.text = var_18_0.nick

	if self.index == var_0_1.all then
		local var_18_1 = RankData:GetActivityRank(self.activityID_)

		if var_18_1 then
			local var_18_2, var_18_3 = var_18_1:GetCurRankDes()

			self.rank_.text = var_18_2
			self.score_.text = var_18_3
		else
			self.rank_.text = ""
			self.score_.text = ""
		end

		self.tabController_:SetSelectedState("all")
	else
		local var_18_4 = RankData:GetGuildActivityRank(self.activityID_)

		if var_18_4 then
			local var_18_5, var_18_6 = var_18_4:GetCurRankDes()

			self.rank_.text = var_18_5
			self.score_.text = var_18_6
		else
			self.rank_.text = ""
			self.score_.text = ""
		end

		self.tabController_:SetSelectedState("club")
	end
end

function TetrisGameRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.uiList_ then
		self.uiList_:Dispose()

		self.uiList_ = nil
	end

	TetrisGameRankView.super.Dispose(self)
end

return TetrisGameRankView
