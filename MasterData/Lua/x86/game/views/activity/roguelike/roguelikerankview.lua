local RoguelikeRankView = class("RoguelikeRankView", ReduxView)
local var_0_1 = {
	ALL = 2,
	Club = 1
}

function RoguelikeRankView:UIName()
	return "UI/StrategyMatrix/StrategyMatrixRankUI"
end

function RoguelikeRankView:UIParent()
	return manager.ui.uiMain.transform
end

function RoguelikeRankView:UIBackCount()
	return 2
end

function RoguelikeRankView:OnCtor()
	return
end

function RoguelikeRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RoguelikeRankView:OnEnter()
	self.isInit_ = false
	self.rank_id = self.params_.rank_id

	RankAction.QueryActivityRank(self.rank_id)

	local var_6_0 = GuildData.IsGuildValid(GuildData:GetGuildInfo().id)

	self.TogClub:SetActive(var_6_0)

	if var_6_0 then
		RankAction.QueryGuildActivityRank(self.rank_id)
	end
end

function RoguelikeRankView:OnExit()
	self:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function RoguelikeRankView:InitUI()
	self.gameObject_:InjectUI(self)

	self.scroll = LuaList.New(handler(self, self.RefreshItem), self.GoList, RoguelikeRankItemView)
	self.toggleList = {
		self.TogClub,
		self.TogAll
	}
	self.commonPortrait_ = CommonHeadPortrait.New(self.GoHeadItem)
end

function RoguelikeRankView:OnTop()
	self:UpdateBar()
end

function RoguelikeRankView:OnBehind()
	manager.windowBar:HideBar()
end

function RoguelikeRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.scroll then
		self.scroll:Dispose()

		self.scroll = nil
	end

	RoguelikeRankView.super.Dispose(self)
end

function RoguelikeRankView:SwitchTab(arg_12_1)
	self.toggleList[arg_12_1].isOn = true
	self.tab = arg_12_1
	self.dataList = self:GetListFromIndex(self.rank_id, arg_12_1)

	self:RefreshView()
end

function RoguelikeRankView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function RoguelikeRankView:RefreshView()
	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)

	if self.tab == var_0_1.Club then
		local var_14_0 = RankData:GetGuildActivityRank(self.rank_id)

		if var_14_0 then
			local var_14_1, var_14_2 = var_14_0:GetCurRankDes()

			self.TxtMyRank.text = var_14_1
			self.TxtMyScore.text = var_14_2
		else
			self.TxtMyRank.text = ""
			self.TxtMyScore.text = ""
		end
	elseif self.tab == var_0_1.ALL then
		local var_14_3 = RankData:GetActivityRank(self.rank_id)

		if var_14_3 then
			local var_14_4, var_14_5 = var_14_3:GetCurRankDes()

			self.TxtMyRank.text = var_14_4
			self.TxtMyScore.text = var_14_5
		else
			self.TxtMyRank.text = ""
			self.TxtMyScore.text = ""
		end
	end

	self.scroll:StartScroll(#self.dataList)
end

function RoguelikeRankView:RefreshItem(arg_15_1, arg_15_2)
	arg_15_2:SetData(arg_15_1, self.dataList[arg_15_1], self.tab == var_0_1.Club)
end

function RoguelikeRankView:OnActivityMatrixRankUpdate()
	self:SwitchTab(var_0_1.ALL)
end

function RoguelikeRankView:AddUIListener()
	for iter_17_0, iter_17_1 in ipairs(self.toggleList) do
		self:AddToggleListener(iter_17_1, function(arg_18_0)
			if arg_18_0 then
				self:SwitchTab(iter_17_0)
			end
		end)
	end
end

function RoguelikeRankView:GetListFromIndex(arg_19_1, arg_19_2)
	local var_19_0 = {}

	if arg_19_2 == var_0_1.Club then
		local var_19_1 = RankData:GetGuildActivityRank(self.rank_id)

		var_19_0 = var_19_1 and var_19_1.rankList or {}
	elseif arg_19_2 == var_0_1.ALL then
		local var_19_2 = RankData:GetActivityRank(self.rank_id)

		var_19_0 = var_19_2 and var_19_2.rankList or {}
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		return arg_20_0.rank < arg_20_1.rank
	end)

	return var_19_0
end

function RoguelikeRankView:OnRankUpdate()
	self:SwitchTab(var_0_1.ALL)
end

return RoguelikeRankView
