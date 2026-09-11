local AreaBattleRankView = class("AreaBattleRankView", ReduxView)

function AreaBattleRankView:UIName()
	return ActivityAreaBattleData:GetPrefabByActivityID(self.params_.mainActivityID) .. "NormalfightingRankUI"
end

function AreaBattleRankView:UIParent()
	return manager.ui.uiMain.transform
end

function AreaBattleRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function AreaBattleRankView:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, AreaBattleRankItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.nothingController_ = self.conExCollection_:GetController("stage")
end

function AreaBattleRankView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData[arg_5_1], arg_5_1, 2)
end

function AreaBattleRankView:AddUIListener()
	self:AddBtnListener(self.clubBtn_, nil, function()
		self:SwitchPageIfDiff(1)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self:SwitchPageIfDiff(2)
	end)
end

function AreaBattleRankView:SwitchPage(arg_9_1)
	if self.tabConState_ == nil then
		self.tabConState_ = {
			"club",
			"all"
		}
	end

	self.tabController_:SetSelectedState(self.tabConState_[arg_9_1])

	self.curPage_ = arg_9_1
	self.rankData = self:GetListFromIndex(arg_9_1)

	self:UpdateView()
end

function AreaBattleRankView:SwitchPageIfDiff(arg_10_1)
	if self.curPage_ ~= arg_10_1 then
		self:SwitchPage(arg_10_1)
	end
end

function AreaBattleRankView:UpdateView()
	self.list:StartScroll(#self.rankData)
	SetActive(self.rewardBtn_.gameObject, self.curPage_ == 2)

	local var_11_0 = RankData[self.curPage_ == 1 and "GetGuildActivityRank" or "GetActivityRank"](RankData, self.activityID)

	if var_11_0 then
		local var_11_1, var_11_2 = var_11_0:GetCurRankDes()

		self.gradeTxt_.text = var_11_2
		self.rankTxt_.text = var_11_1
	else
		self.gradeTxt_.text = ""
		self.rankTxt_.text = ""
	end

	self.nothingController_:SetSelectedState(self.challengeStage == 0 and "challenge" or "refresh")
end

function AreaBattleRankView:OnEnter()
	self.isInit_ = false
	self.activityID = ActivityCfg[self.params_.activityID].sub_activity_list[1]
	self.nameTxt_.text = PlayerData:GetPlayerInfo().nick

	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
	RankAction.QueryActivityRank(self.activityID)

	local var_12_0 = not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0)

	self.tabNumController_:SetSelectedState(var_12_0 and "02" or "01")

	if var_12_0 then
		RankAction.QueryGuildActivityRank(self.activityID)
	end
end

function AreaBattleRankView:GetListFromIndex(arg_13_1)
	if arg_13_1 == 1 then
		local var_13_0 = RankData:GetGuildActivityRank(self.activityID)

		return (var_13_0 or nil) and (var_13_0.rankList or {})
	else
		local var_13_1 = RankData:GetActivityRank(self.activityID)

		return (var_13_1 or nil) and (var_13_1.rankList or {})
	end
end

function AreaBattleRankView:OnExit()
	manager.windowBar:HideBar()
end

function AreaBattleRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function AreaBattleRankView:OnRankUpdate()
	if not self.isInit_ then
		self:SwitchPage(2)

		self.isInit_ = true
	end
end

function AreaBattleRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	AreaBattleRankView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return AreaBattleRankView
