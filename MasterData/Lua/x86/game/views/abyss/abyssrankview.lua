local AbyssRankView = class("AbyssRankView", ReduxView)

function AbyssRankView:UIName()
	return "Widget/System/Challenge_Abyss/AbyssRankUI"
end

function AbyssRankView:UIParent()
	return manager.ui.uiMain.transform
end

function AbyssRankView:OnCtor()
	return
end

function AbyssRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AbyssRankView:InitUI()
	self:BindCfgUI()
	self:BindCfgUI(self.commonRankGo_)

	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.rankList_ = LuaList.New(handler(self, self.indexItem), self.uiListGo_, AbyssRankItemView)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function AbyssRankView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, self.dataList_[arg_6_1], self.curPage_ == 1)
end

function AbyssRankView:AddUIListener()
	self:AddBtnListener(self.clubBtn_, nil, function()
		self:SwitchPageIfDiff(1)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self:SwitchPageIfDiff(2)
	end)
end

function AbyssRankView:AddEventListeners()
	self:RegistEventListener(ABYSS_RANK_UPDATE, function()
		if not self.isInit_ then
			self:SwitchPage(2)

			self.isInit_ = true
		end
	end)
end

function AbyssRankView:OnTop()
	self:UpdateBar()
end

function AbyssRankView:OnBehind()
	manager.windowBar:HideBar()
end

function AbyssRankView:SwitchPage(arg_14_1)
	if self.tabConState_ == nil then
		self.tabConState_ = {
			"club",
			"all"
		}
	end

	self.tabController_:SetSelectedState(self.tabConState_[arg_14_1])

	self.curPage_ = arg_14_1
	self.dataList_ = self:GetListFromIndex(arg_14_1)

	self:UpdateView()
end

function AbyssRankView:SwitchPageIfDiff(arg_15_1)
	if self.curPage_ ~= arg_15_1 then
		self:SwitchPage(arg_15_1)
	end
end

function AbyssRankView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AbyssRankView:OnEnter()
	self.isInit_ = false

	self:AddEventListeners()
	RankAction.QueryCommonRank(RankConst.RANK_ID.ABYSS)

	local var_17_0 = not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0)

	self.tabNumController_:SetSelectedState(var_17_0 and "02" or "01")

	if var_17_0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.ABYSS)
	end
end

function AbyssRankView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function AbyssRankView:GetListFromIndex(arg_19_1)
	if arg_19_1 == 1 then
		local var_19_0 = RankData:GetGuildCommonRank(RankConst.RANK_ID.ABYSS)

		return (var_19_0 or nil) and (var_19_0.rankList or {})
	else
		local var_19_1 = RankData:GetCommonRank(RankConst.RANK_ID.ABYSS)

		return (var_19_1 or nil) and (var_19_1.rankList or {})
	end
end

function AbyssRankView:UpdateView()
	self.rankList_:StartScroll(#self.dataList_)
	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)

	if self.curPage_ == 1 then
		local var_20_0 = RankData:GetGuildCommonRank(RankConst.RANK_ID.ABYSS)

		if var_20_0 then
			local var_20_1, var_20_2 = var_20_0:GetCurRankDes()

			self.myRankLabel_.text = var_20_1
			self.myScoreLabel_.text = var_20_2
		else
			self.myRankLabel_.text = ""
			self.myScoreLabel_.text = ""
		end
	else
		local var_20_3 = RankData:GetCommonRank(RankConst.RANK_ID.ABYSS)

		if var_20_3 then
			local var_20_4, var_20_5 = var_20_3:GetCurRankDes()

			self.myRankLabel_.text = var_20_4
			self.myScoreLabel_.text = var_20_5
		else
			self.myRankLabel_.text = ""
			self.myScoreLabel_.text = ""
		end
	end
end

function AbyssRankView:OnMainHomeViewTop()
	return
end

function AbyssRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.rankList_ then
		self.rankList_:Dispose()

		self.rankList_ = nil
	end

	AbyssRankView.super.Dispose(self)
end

function AbyssRankView:OnRankUpdate()
	if not self.isInit_ then
		self:SwitchPage(2)

		self.isInit_ = true
	end
end

return AbyssRankView
