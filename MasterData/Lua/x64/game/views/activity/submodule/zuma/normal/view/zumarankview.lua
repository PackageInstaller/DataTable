local ZumaRankView = class("ZumaRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function ZumaRankView:UIName()
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaRankUI"
end

function ZumaRankView:UIParent()
	return manager.ui.uiMain.transform
end

function ZumaRankView:Init()
	self.curRankType_ = var_0_1.ALL

	self:InitUI()
	self:AddUIListener()
end

function ZumaRankView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.listGo_, ActivityAttributeArenaRankItem)
	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function ZumaRankView:AddUIListener()
	self:AddBtnListener(self.clubBtn_, nil, function()
		self:SwitchPageIfDiff(var_0_1.GUILD)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self:SwitchPageIfDiff(var_0_1.ALL)
	end)
end

function ZumaRankView:IndexItem(arg_8_1, arg_8_2)
	arg_8_2:RefreshUI(self.rankList_[arg_8_1])
end

function ZumaRankView:QueryRankData()
	RankAction.QueryActivityRank(self.activityID_)
	self.tabNumController_:SetSelectedState("01")
end

function ZumaRankView:OnEnter()
	self.activityID_ = self.params_.rank_activity_id

	self:QueryRankData()
end

function ZumaRankView:RefreshUI()
	self:RefreshSelfRank()
	self:RefreshList()
end

function ZumaRankView:SwitchPageIfDiff(arg_12_1)
	if self.curRankType_ ~= arg_12_1 then
		self:SwitchPage(arg_12_1)
	end
end

function ZumaRankView:SwitchPage(arg_13_1)
	self.curRankType_ = arg_13_1

	self:RefreshSelfRank()
	self:RefreshList()
end

function ZumaRankView:RefreshSelfRank()
	local var_14_0 = PlayerData:GetPlayerInfo()

	self.commonPortrait_:RenderHead(var_14_0 and var_14_0.portrait)
	self.commonPortrait_:RenderFrame(var_14_0.icon_frame)

	self.name_.text = var_14_0.nick

	if self.curRankType_ == var_0_1.ALL then
		local var_14_1 = RankData:GetActivityRank(self.activityID_)

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
		local var_14_4 = RankData:GetGuildActivityRank(self.activityID_)

		if var_14_4 then
			local var_14_5, var_14_6 = var_14_4:GetCurRankDes()

			self.rank_.text = var_14_5
			self.score_.text = var_14_6
		else
			self:RefreshNone()
		end

		self.tabController_:SetSelectedState("club")
	end
end

function ZumaRankView:RefreshNone()
	self.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	self.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function ZumaRankView:RefreshList()
	if self.curRankType_ == var_0_1.ALL then
		local var_16_0 = RankData:GetActivityRank(self.activityID_)

		if var_16_0 then
			self.rankList_ = var_16_0.rankList or {}
		end
	else
		local var_16_1 = RankData:GetGuildActivityRank(self.activityID_)

		if var_16_1 then
			self.rankList_ = var_16_1.rankList or {}
		end
	end

	self.scrollHelper_:StartScroll(#self.rankList_)
end

function ZumaRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ZumaRankView:OnExit()
	self.scrollHelper_:StartScroll(0)
	manager.windowBar:HideBar()
end

function ZumaRankView:Dispose()
	self:RemoveAllListeners()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil

	ZumaRankView.super.Dispose(self)
end

function ZumaRankView:OnRankUpdate()
	self:RefreshUI()
end

return ZumaRankView
