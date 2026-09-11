local CoreVerificationRankView = class("CoreVerificationRankView", ReduxView)

function CoreVerificationRankView:UIName()
	return "Widget/System/Core_Verification/CoreVerificationRankUI"
end

function CoreVerificationRankView:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationRankView:Init()
	self:BindCfgUI()

	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.tabController_ = self.ndtabControllerexcollection_:GetController("tab")
	self.tabNumController_ = self.ndtabControllerexcollection_:GetController("num")

	self:AddUIListener()

	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, CoreVerificationRankItem)
end

function CoreVerificationRankView:AddUIListener()
	self:AddBtnListener(self.clubbtnBtn_, nil, function()
		self:SwitchPage(1)
	end)
	self:AddBtnListener(self.allbtnBtn_, nil, function()
		self:SwitchPage(2)
	end)
end

function CoreVerificationRankView:IndexItem(arg_7_1, arg_7_2)
	arg_7_2:Refresh(self.rankList[arg_7_1])
end

function CoreVerificationRankView:GetListFromIndex(arg_8_1)
	if arg_8_1 == 1 then
		local var_8_0 = RankData:GetGuildCommonRank(RankConst.RANK_ID.COREVERIFICATION)

		return (var_8_0 or nil) and (var_8_0.rankList or {})
	else
		local var_8_1 = RankData:GetCommonRank(RankConst.RANK_ID.COREVERIFICATION)

		return (var_8_1 or nil) and (var_8_1.rankList or {})
	end
end

function CoreVerificationRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function CoreVerificationRankView:OnBehind()
	manager.windowBar:HideBar()
end

function CoreVerificationRankView:OnEnter()
	RankAction.QueryCommonRank(RankConst.RANK_ID.COREVERIFICATION)

	local var_11_0 = not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0)

	self.tabNumController_:SetSelectedState(var_11_0 and "02" or "01")

	if var_11_0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.COREVERIFICATION)
	end
end

function CoreVerificationRankView:OnRankUpdate()
	self.rankData = RankData[self.curPage_ == 1 and "GetGuildCommonRank" or "GetCommonRank"](RankData, RankConst.RANK_ID.COREVERIFICATION)

	if self.rankData then
		self.rankList = self.rankData.rankList or {}
	end

	self.list_:StartScroll(#self.rankList)

	local var_12_0 = PlayerData:GetPlayerInfo()

	self.commonPortrait_:RenderHead(var_12_0 and var_12_0.portrait)
	self.commonPortrait_:RenderFrame(var_12_0.icon_frame)

	if self.rankData then
		local var_12_1, var_12_2 = self.rankData:GetCurRankDes()

		self.textnumText_.text = var_12_1
		self.textscoreText_.text = var_12_2
	else
		self.textnumText_.text = ""
		self.textscoreText_.text = ""
	end
end

function CoreVerificationRankView:SwitchPage(arg_13_1)
	if self.tabConState_ == nil then
		self.tabConState_ = {
			"club",
			"all"
		}
	end

	self.tabController_:SetSelectedState(self.tabConState_[arg_13_1])

	self.curPage_ = arg_13_1
	self.rankList = self:GetListFromIndex(arg_13_1)

	self:OnRankUpdate()
end

function CoreVerificationRankView:OnExit()
	return
end

function CoreVerificationRankView:Dispose()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	CoreVerificationRankView.super.Dispose(self)

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end
end

return CoreVerificationRankView
