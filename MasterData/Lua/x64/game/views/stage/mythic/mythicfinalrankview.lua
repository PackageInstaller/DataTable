local MythicFinalRankView = class("MythicFinalRankView", ReduxView)

function MythicFinalRankView:UIName()
	return "Widget/System/Challenge_Mythic/MythicRankUI"
end

function MythicFinalRankView:UIParent()
	return manager.ui.uiMain.transform
end

function MythicFinalRankView:Init()
	self.rankTypeConst_ = MythicData:GetRankTypeConst()

	self:InitUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()
end

function MythicFinalRankView:InitUI()
	self:BindCfgUI()
	self:BindCfgUI(self.commonRankGo_)

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, MythicFinalRankItem)
	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
end

function MythicFinalRankView:AddListeners()
	self:AddBtnListener(self.clubBtn_, nil, function()
		self:SwitchPageIfDiff(self.rankTypeConst_.GUILD)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self:SwitchPageIfDiff(self.rankTypeConst_.ALL)
	end)
end

function MythicFinalRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function MythicFinalRankView:OnEnter()
	self:RefreshGuildRankGo()
	RankAction.QueryCommonRank(RankConst.RANK_ID.MYTHIC)

	local var_9_0 = GuildData:GetGuildInfo()

	if var_9_0 and var_9_0.id ~= nil and var_9_0.id ~= 0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.MYTHIC)
	end

	if self.params_.reset then
		self.params_.reset = nil

		self:SwitchPageIfDiff(self.rankTypeConst_.ALL)
	end

	self:Refresh()
end

function MythicFinalRankView:OnExit()
	self.pos_ = self.list_:GetScrolledPosition()

	manager.windowBar:HideBar()
end

function MythicFinalRankView:Refresh()
	if MythicData:GetCurRankType() == self.rankTypeConst_.ALL then
		local var_11_0 = RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC)

		if var_11_0 then
			self.rankList = var_11_0.rankList or {}
		end

		if var_11_0 then
			local var_11_1, var_11_2 = var_11_0:GetCurRankDes()

			self.myRankLabel_.text = var_11_1
			self.myScoreLabel_.text = var_11_2
		else
			self.myRankLabel_.text = ""
			self.myScoreLabel_.text = ""
		end

		self.tabController_:SetSelectedState("all")
	else
		local var_11_3 = RankData:GetGuildCommonRank(RankConst.RANK_ID.MYTHIC)

		if var_11_3 then
			self.rankList = var_11_3.rankList or {}
		end

		if var_11_3 then
			local var_11_4, var_11_5 = var_11_3:GetCurRankDes()

			self.myRankLabel_.text = var_11_4
			self.myScoreLabel_.text = var_11_5
		else
			self.myRankLabel_.text = ""
			self.myScoreLabel_.text = ""
		end

		self.tabController_:SetSelectedState("club")
	end

	self.list_:StartScroll(#self.rankList)

	if self.pos_ then
		self.list_:SetScrolledPosition(self.pos_)
	end

	local var_11_6 = PlayerData:GetPlayerInfo()

	self.commonPortrait_:RenderHead(var_11_6 and var_11_6.portrait)
	self.commonPortrait_:RenderFrame(var_11_6.icon_frame)
end

function MythicFinalRankView:SwitchPageIfDiff(arg_12_1)
	if arg_12_1 ~= MythicData:GetCurRankType() then
		MythicData:SetCurRankType(arg_12_1)
		self:Refresh()
	end
end

function MythicFinalRankView:IndexItem(arg_13_1, arg_13_2)
	arg_13_2:Refresh(self.rankList[arg_13_1])
end

function MythicFinalRankView:Dispose()
	self.commonPortrait_:Dispose()
	self.list_:Dispose()
	MythicFinalRankView.super.Dispose(self)

	self.refreshGuildHandler_ = nil
end

function MythicFinalRankView:RefreshGuildRankGo()
	if GuildData:GetGuildInfo().id == nil then
		self.tabNumController_:SetSelectedState("01")
	else
		self.tabNumController_:SetSelectedState("02")
	end
end

function MythicFinalRankView:OnRankUpdate()
	self:Refresh()
end

return MythicFinalRankView
