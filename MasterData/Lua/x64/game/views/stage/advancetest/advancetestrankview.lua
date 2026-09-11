local AdvanceTestRankView = class("AdvanceTestRankView", ReduxView)

function AdvanceTestRankView:UIName()
	return "UI/AdvancetestingUI/AtestingRankUI"
end

function AdvanceTestRankView:UIParent()
	return manager.ui.uiMain.transform
end

function AdvanceTestRankView:Init()
	self.rankTypeConst_ = AdvanceTestData:GetRankTypeConst()

	self:InitUI()

	self.subTypeToggleController_ = self.conExCollection_:GetController("subType")
	self.tabController_ = self.toggleConEx:GetController("tab")
	self.tabNumController_ = self.toggleConEx:GetController("num")
	self.itemGo_ = {
		self.m_easyBtn.gameObject,
		self.m_nomalBtn.gameObject,
		self.m_hardBtn.gameObject,
		self.m_spe4Btn.gameObject,
		self.m_spe5Btn.gameObject,
		self.m_spe6Btn.gameObject
	}

	for iter_3_0, iter_3_1 in ipairs(self.itemGo_) do
		local var_3_0 = ""

		var_3_0 = iter_3_0 <= 3 and string.format(GetTips("TEST_CHALLENGE_TIPS_6"), GetTips(({
			"TEST_CHALLENGE_SS",
			"TEST_CHALLENGE_SSS",
			"TEST_CHALLENGE_OMEGA"
		})[iter_3_0])) or string.format(GetTips("TEST_CHALLENGE_TIPS_6"), GetTips("TEST_CHALLENGE_SPE"))

		local var_3_1 = iter_3_1.transform:Find("select_on/Textselect")
		local var_3_2 = var_3_1 and var_3_1:GetComponent("Text")

		if var_3_2 then
			var_3_2.text = var_3_0
		end

		local var_3_3 = iter_3_1.transform:Find("upselect/Textupselect")
		local var_3_4 = var_3_3 and var_3_3:GetComponent("Text")

		if var_3_4 then
			var_3_4.text = var_3_0
		end
	end

	self.clickIndex_ = {}
	self.commonPortrait_ = CommonHeadPortrait.New(self.headItem_)

	self:AddListeners()
end

function AdvanceTestRankView:InitUI()
	self:BindCfgUI()

	self.RefreshUIHandler_ = handler(self, self.Refresh)
	self.list_ = LuaList.New(handler(self, self.IndexItem), self.m_list, AdvanceTestRankItem)
end

function AdvanceTestRankView:AddListeners()
	self:AddBtnListener(self.m_allBtn, nil, function()
		if AdvanceTestData:GetCurRankType() ~= self.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(self.activityID, self.stageType)
		end

		AdvanceTestData:SetCurRankType(self.rankTypeConst_.ALL)
		self:Refresh()
	end)
	self:AddBtnListener(self.m_guildBtn, nil, function()
		if AdvanceTestData:GetCurRankType() ~= self.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(self.activityID, self.stageType)
		end

		AdvanceTestData:SetCurRankType(self.rankTypeConst_.GUILD)
	end)
	self:AddBtnListener(self.m_rewardBtn, nil, function()
		JumpTools.OpenPageByJump("advanceTestReward", {
			activityID = self.activityID
		})
	end)
	self:AddBtnListener(self.m_easyBtn, nil, function()
		self:OnClickSubType(1)
	end)
	self:AddBtnListener(self.m_nomalBtn, nil, function()
		self:OnClickSubType(2)
	end)
	self:AddBtnListener(self.m_hardBtn, nil, function()
		self:OnClickSubType(3)
	end)
	self:AddBtnListener(self.m_spe4Btn, nil, function()
		self:OnClickSubType(4)
	end)
	self:AddBtnListener(self.m_spe5Btn, nil, function()
		self:OnClickSubType(5)
	end)
	self:AddBtnListener(self.m_spe6Btn, nil, function()
		self:OnClickSubType(6)
	end)
end

function AdvanceTestRankView:OnClickSubType(arg_15_1)
	local var_15_0 = AdvanceTestData:GetCurRankType()

	if self.index ~= self.clickIndex_[arg_15_1] then
		if var_15_0 == self.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(self.activityID, arg_15_1)
		elseif var_15_0 == self.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(self.activityID, arg_15_1)
		end
	end

	self.index = self.clickIndex_[arg_15_1]
	self.stageType = arg_15_1

	self:Refresh()
end

function AdvanceTestRankView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function AdvanceTestRankView:OnEnter()
	self.activityID = self.params_.activityID

	local var_17_0 = ActivityData:GetActivityData(self.activityID)

	self.startTime_ = var_17_0.startTime
	self.stopTime_ = var_17_0.stopTime

	local var_17_1 = AdvanceTestCfg.get_id_list_by_activity_id[AdvanceTestData:GetCacheActivityID()]

	for iter_17_0 = 1, #self.itemGo_ do
		SetActive(self.itemGo_[iter_17_0], false)
	end

	for iter_17_1 = 1, #self.itemGo_ do
		if var_17_1[iter_17_1] then
			SetActive(self.itemGo_[AdvanceTestCfg[var_17_1[iter_17_1]].stage_type], true)

			self.clickIndex_[AdvanceTestCfg[var_17_1[iter_17_1]].stage_type] = iter_17_1
		end
	end

	self.stageType = self.params_.stageType
	self.index = self.clickIndex_[self.params_.stageType]

	manager.notify:RegistListener(ADVANCE_TEST_RANK_UPGRADE, self.RefreshUIHandler_)
	RankAction.QueryActivityRank(self.activityID, self.stageType)
	self:RefreshGuildRankGo()
	self:AddTimer()
end

function AdvanceTestRankView:OnExit()
	self.pos_ = self.list_:GetScrolledPosition()

	self:StopTimer()
	manager.windowBar:HideBar()
	manager.notify:RemoveListener(ADVANCE_TEST_RANK_UPGRADE, self.RefreshUIHandler_)
	AdvanceTestData:SetCurRankType(self.rankTypeConst_.ALL)
end

function AdvanceTestRankView:Refresh()
	if AdvanceTestData:GetCurRankType() == self.rankTypeConst_.ALL then
		local var_19_0 = RankData:GetActivityRank(self.activityID, self.stageType)

		if var_19_0 then
			self.rankList = var_19_0.rankList or {}
		end

		if var_19_0 then
			local var_19_1, var_19_2 = var_19_0:GetCurRankDes()

			self.m_rank.text = var_19_1
			self.m_score.text = var_19_2
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end

		SetActive(self.m_rewardBtn, true)
		self.tabController_:SetSelectedState("all")
	else
		local var_19_3 = RankData:GetGuildActivityRank(self.activityID, self.stageType)

		if var_19_3 then
			self.rankList = var_19_3.rankList or {}
		end

		if var_19_3 then
			local var_19_4, var_19_5 = var_19_3:GetCurRankDes()

			self.m_rank.text = var_19_4
			self.m_score.text = var_19_5
		else
			self.m_rank.text = ""
			self.m_score.text = ""
		end

		SetActive(self.m_rewardBtn, false)
		self.tabController_:SetSelectedState("club")
	end

	self.list_:StartScroll(#self.rankList)

	if self.pos_ then
		self.list_:SetScrolledPosition(self.pos_)
	end

	local var_19_6 = PlayerData:GetPlayerInfo()

	self.commonPortrait_:RenderHead(var_19_6 and var_19_6.portrait)
	self.commonPortrait_:RenderFrame(var_19_6.icon_frame)
	self.subTypeToggleController_:SetSelectedState(self.stageType)
end

function AdvanceTestRankView:IndexItem(arg_20_1, arg_20_2)
	arg_20_2:Refresh(self.rankList[arg_20_1], self.stageType)
end

function AdvanceTestRankView:Dispose()
	self.commonPortrait_:Dispose()

	if self.list_ then
		self.list_:Dispose()

		self.list_ = nil
	end

	AdvanceTestRankView.super.Dispose(self)
end

function AdvanceTestRankView:AddTimer()
	self:StopTimer()

	self.m_leftTimeText.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	self.timer_ = Timer.New(function()
		if manager.time:GetServerTime() > self.stopTime_ then
			return
		end

		self.m_leftTimeText.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(self.stopTime_, nil, true)
	end, 1, -1)

	self.timer_:Start()
end

function AdvanceTestRankView:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function AdvanceTestRankView:RefreshGuildRankGo()
	if GuildData:GetGuildInfo().id == nil then
		self.tabNumController_:SetSelectedState("01")
	else
		self.tabNumController_:SetSelectedState("02")
	end
end

function AdvanceTestRankView:OnRankUpdate()
	self:Refresh()
end

return AdvanceTestRankView
