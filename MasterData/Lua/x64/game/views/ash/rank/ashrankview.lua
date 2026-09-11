local AshRankView = class("AshRankView", ReduxView)
local var_0_1 = {
	ALL = 1,
	GUILD = 2
}

function AshRankView:UIName()
	return "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BoundlessRankUI"
end

function AshRankView:UIParent()
	return manager.ui.uiMain.transform
end

function AshRankView:Init()
	self.curRankType_ = var_0_1.ALL

	self:InitUI()
	self:AddUIListener()
end

function AshRankView:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.IndexItem), self.m_list, ActivityAshRankItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
end

function AshRankView:AddUIListener()
	return
end

function AshRankView:IndexItem(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(self.rankList_[arg_6_1])
end

function AshRankView:QueryRankData(arg_7_1)
	RankAction.QueryActivityRank(self.activityID_, nil, arg_7_1)
end

function AshRankView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	self.activityID_ = ActivityConst.ACTIVITY_ASH_RANK

	self:QueryRankData(function()
		self:RefreshUI()
	end)
end

function AshRankView:RefreshUI()
	self:RefreshSelfRank()
	self:RefreshList()
end

function AshRankView:SwitchPageIfDiff(arg_11_1)
	if self.curRankType_ ~= arg_11_1 then
		self:SwitchPage(arg_11_1)
	end
end

function AshRankView:SwitchPage(arg_12_1)
	self.curRankType_ = arg_12_1

	self:RefreshSelfRank()
	self:RefreshList()
end

function AshRankView:RefreshSelfRank()
	local var_13_0 = PlayerData:GetPlayerInfo()

	self.commonPortrait_:RenderHead(var_13_0 and var_13_0.portrait)
	self.commonPortrait_:RenderFrame(var_13_0.icon_frame)

	self.nametextText_.text = var_13_0.nick

	if self.curRankType_ == var_0_1.ALL then
		local var_13_1 = RankData:GetActivityRank(self.activityID_)

		if var_13_1 then
			local var_13_2, var_13_3 = var_13_1:GetCurRankDes()

			self.textnumText_.text = var_13_2
			self.textscoreText_.text = var_13_3
		else
			self.textnumText_.text = ""
			self.textscoreText_.text = ""
		end
	else
		local var_13_4 = RankData:GetGuildActivityRank(self.activityID_)

		if var_13_4 then
			local var_13_5, var_13_6 = var_13_4:GetCurRankDes()

			self.textnumText_.text = var_13_5
			self.textscoreText_.text = var_13_6
		else
			self:RefreshNone()
		end
	end
end

function AshRankView:RefreshNone()
	self.textnumText_.text = GetTips("MATRIX_RANK_NO_RANK")
	self.textscoreText_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function AshRankView:RefreshList()
	if self.curRankType_ == var_0_1.ALL then
		local var_15_0 = RankData:GetActivityRank(self.activityID_)

		if var_15_0 then
			self.rankList_ = var_15_0.rankList or {}
		end
	else
		local var_15_1 = RankData:GetGuildActivityRank(self.activityID_)

		if var_15_1 then
			self.rankList_ = var_15_1.rankList or {}
		end
	end

	self.scrollHelper_:StartScroll(#self.rankList_)
end

function AshRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AshRankView:OnExit()
	self.scrollHelper_:StartScroll(0)
	manager.windowBar:HideBar()
end

function AshRankView:Dispose()
	AshRankView.super.Dispose(self)
	self:RemoveAllListeners()
	self.commonPortrait_:Dispose()

	self.commonPortrait_ = nil

	self.scrollHelper_:Dispose()

	self.scrollHelper_ = nil
end

return AshRankView
