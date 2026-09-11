local SoloHeartDemonRankView = class("SoloHeartDemonRankView", ReduxView)

function SoloHeartDemonRankView:UIName()
	return "Widget/System/Challenge_SoloHeartDemonUI/SoloHeartDemonRankUI"
end

function SoloHeartDemonRankView:UIParent()
	return manager.ui.uiMain.transform
end

function SoloHeartDemonRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function SoloHeartDemonRankView:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, SoloHeartDemonListItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.nothingController_ = self.conExCollection_:GetController("stage")
end

function SoloHeartDemonRankView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData[arg_5_1], arg_5_1, 2)
end

function SoloHeartDemonRankView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.GoToSystem("/soloHeartDemonReward", {
			selectIndex = 2,
			activityId = self.activityId
		})
	end)
	self:AddBtnListener(self.clubBtn_, nil, function()
		self:SwitchPageIfDiff(1)
	end)
	self:AddBtnListener(self.allBtn_, nil, function()
		self:SwitchPageIfDiff(2)
	end)
end

function SoloHeartDemonRankView:SwitchPage(arg_10_1)
	if self.tabConState_ == nil then
		self.tabConState_ = {
			"club",
			"all"
		}
	end

	self.tabController_:SetSelectedState(self.tabConState_[arg_10_1])

	self.curPage_ = arg_10_1
	self.rankData = self:GetListFromIndex(arg_10_1)

	self:UpdateView()
end

function SoloHeartDemonRankView:SwitchPageIfDiff(arg_11_1)
	if self.curPage_ ~= arg_11_1 then
		self:SwitchPage(arg_11_1)
	end
end

function SoloHeartDemonRankView:IsShowRank()
	return self.remainTime - 86400 > manager.time:GetServerTime() and self.challengeStage == 1
end

function SoloHeartDemonRankView:UpdateView()
	self.remainTime = ActivityData:GetActivityRefreshTime(ActivityConst.SOLO_HEART_DEMON)
	self.challengeStage = SoloHeartDemonData:GetDataByPara("challengeStage")

	self.list:StartScroll(self:IsShowRank() and 0 or #self.rankData)
	SetActive(self.rewardBtn_.gameObject, self.curPage_ == 2)

	local var_13_0 = RankData[self.curPage_ == 1 and "GetGuildCommonRank" or "GetCommonRank"](RankData, RankConst.RANK_ID.SOLOHEARTDEMON)

	if var_13_0 then
		local var_13_1, var_13_2 = var_13_0:GetCurRankDes()

		self.gradeTxt_.text = var_13_2
		self.rankTxt_.text = var_13_1
	else
		self.gradeTxt_.text = ""
		self.rankTxt_.text = ""
	end

	self.nothingController_:SetSelectedState(self.challengeStage == 0 and "challenge" or "refresh")
end

function SoloHeartDemonRankView:OnEnter()
	self.isInit_ = false
	self.activityId = self.params_.activityId
	self.nameTxt_.text = PlayerData:GetPlayerInfo().nick

	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
	RankAction.QueryCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

	local var_14_0 = not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0)

	self.tabNumController_:SetSelectedState(var_14_0 and "02" or "01")

	if var_14_0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)
	end
end

function SoloHeartDemonRankView:GetListFromIndex(arg_15_1)
	if arg_15_1 == 1 then
		local var_15_0 = RankData:GetGuildCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

		return (var_15_0 or nil) and (var_15_0.rankList or {})
	else
		local var_15_1 = RankData:GetCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

		return (var_15_1 or nil) and (var_15_1.rankList or {})
	end
end

function SoloHeartDemonRankView:OnRankUpdate()
	if not self.isInit_ then
		self:SwitchPage(2)

		self.isInit_ = true
	end
end

function SoloHeartDemonRankView:OnExit()
	manager.windowBar:HideBar()
end

function SoloHeartDemonRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function SoloHeartDemonRankView:OnSoloDemonHeartUpdate()
	if not self.isInit_ then
		self:SwitchPage(2)

		self.isInit_ = true
	end
end

function SoloHeartDemonRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	SoloHeartDemonRankView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return SoloHeartDemonRankView
