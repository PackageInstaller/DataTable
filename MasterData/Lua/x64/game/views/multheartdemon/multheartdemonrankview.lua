local MultHeartDemonRankView = class("MultHeartDemonRankView", ReduxView)

function MultHeartDemonRankView:UIName()
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_RankUI"
end

function MultHeartDemonRankView:UIParent()
	return manager.ui.uiMain.transform
end

function MultHeartDemonRankView:Init()
	self:InitUI()
	self:AddUIListener()
end

function MultHeartDemonRankView:InitUI()
	self:BindCfgUI()

	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.list = LuaList.New(handler(self, self.SetListItem), self.list_, MultHeartDemonListItem)
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)
	self.nothingController_ = self.conExCollection_:GetController("stage")
end

function MultHeartDemonRankView:SetListItem(arg_5_1, arg_5_2)
	arg_5_2:SetData(self.rankData[arg_5_1], arg_5_1, 2)
end

function MultHeartDemonRankView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.GoToSystem("/multHeartDemonReward", {
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

function MultHeartDemonRankView:SwitchPage(arg_10_1)
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

function MultHeartDemonRankView:SwitchPageIfDiff(arg_11_1)
	if self.curPage_ ~= arg_11_1 then
		self:SwitchPage(arg_11_1)
	end
end

function MultHeartDemonRankView:IsShowRank()
	return false
end

function MultHeartDemonRankView:UpdateView()
	self.remainTime = ActivityData:GetActivityRefreshTime(self.activityId)
	self.challengeStage = MultHeartDemonData:GetDataByPara("challengeStage")

	self.list:StartScroll(self:IsShowRank() and 0 or #self.rankData)
	SetActive(self.rewardBtn_.gameObject, self.curPage_ == 2)

	local var_13_0 = RankData[self.curPage_ == 1 and "GetGuildCommonRank" or "GetCommonRank"](RankData, RankConst.RANK_ID.MULTHEARTDEMON)

	if var_13_0 then
		local var_13_1, var_13_2 = var_13_0:GetCurRankDes(300)

		self.gradeTxt_.text = var_13_2
		self.rankTxt_.text = var_13_1
	else
		self.gradeTxt_.text = ""
		self.rankTxt_.text = ""
	end

	self.nothingController_:SetSelectedState(self.challengeStage == 0 and "challenge" or "refresh")
end

function MultHeartDemonRankView:OnEnter()
	self.isInit_ = false
	self.activityId = self.params_.activityId

	local var_14_0 = nullable(ActivityCfg, self.activityId, "remark")

	if var_14_0 then
		self.nameLabel_.text = var_14_0
	end

	self.nameTxt_.text = PlayerData:GetPlayerInfo().nick

	self.commonPortrait_:RenderHead(PlayerData:GetPlayerInfo().portrait)
	self.commonPortrait_:RenderFrame(PlayerData:GetPlayerInfo().icon_frame)
	RankAction.QueryCommonRank(RankConst.RANK_ID.MULTHEARTDEMON, nil, nil, 300)

	local var_14_1 = not (GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0)

	self.tabNumController_:SetSelectedState(var_14_1 and "02" or "01")

	if var_14_1 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.MULTHEARTDEMON)
	end
end

function MultHeartDemonRankView:GetListFromIndex(arg_15_1)
	if arg_15_1 == 1 then
		local var_15_0 = RankData:GetGuildCommonRank(RankConst.RANK_ID.MULTHEARTDEMON)

		return (var_15_0 or nil) and (var_15_0.rankList or {})
	else
		local var_15_1 = RankData:GetCommonRank(RankConst.RANK_ID.MULTHEARTDEMON)

		return (var_15_1 or nil) and (var_15_1.rankList or {})
	end
end

function MultHeartDemonRankView:OnRankUpdate()
	if not self.isInit_ then
		self:SwitchPage(2)

		self.isInit_ = true
	end
end

function MultHeartDemonRankView:OnExit()
	manager.windowBar:HideBar()
end

function MultHeartDemonRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function MultHeartDemonRankView:OnMultDemonHeartUpdate()
	if not self.isInit_ then
		self:SwitchPage(2)

		self.isInit_ = true
	end
end

function MultHeartDemonRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.list then
		self.list:Dispose()

		self.list = nil
	end

	MultHeartDemonRankView.super.Dispose(self)
	Object.Destroy(self.gameObject_)
end

return MultHeartDemonRankView
