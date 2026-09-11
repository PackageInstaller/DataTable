local CoreVerificationChallengeStageViewMode4 = class("CoreVerificationChallengeStageViewMode4", ReduxView)

function CoreVerificationChallengeStageViewMode4:UIName()
	return "Widget/System/Core_verification_new/Mode4/Core_Verification_OrdinaryStageUI_Mode4"
end

function CoreVerificationChallengeStageViewMode4:UIParent()
	return manager.ui.uiMain.transform
end

function CoreVerificationChallengeStageViewMode4:Init()
	self:InitUI()
	self:AddUIListeners()
end

local function var_0_1(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	for iter_4_0 = arg_4_0.childCount + 1, arg_4_4 do
		local var_4_0 = Object.Instantiate(arg_4_1, arg_4_0)
	end

	for iter_4_1 = 1, arg_4_0.childCount do
		arg_4_3[iter_4_1] = arg_4_3[iter_4_1] or arg_4_2.New(arg_4_0:GetChild(iter_4_1 - 1).gameObject)

		arg_4_3[iter_4_1]:SetActive(iter_4_1 <= arg_4_4)
	end
end

local var_0_2 = class("CoreVerificationChallengeStageViewMode4.TeamTabItem", BaseView)

function var_0_2:Ctor(arg_5_1)
	self.gameObject_ = arg_5_1
	self.transform_ = arg_5_1.transform

	self:Init()
end

function var_0_2:Init()
	self:BindCfgUI()

	self.stateController = self.controllers_:GetController("state")
	self.selectController = self.controllers_:GetController("select")

	self:AddBtnListener(self.btn_, nil, function()
		self:OnSelect()
	end)
end

function var_0_2:SetData(arg_8_1, arg_8_2)
	self.stageView = arg_8_1
	self.index = arg_8_2

	self:RefreshTeamInfo()
end

function var_0_2:OnSelect()
	self.stageView:OnSwitchTeam(self.index)
end

function var_0_2:RefreshSelect(arg_10_1)
	self.selectController:SetSelectedState(arg_10_1 and "true" or "false")
end

function var_0_2:RefreshTeamInfo()
	local var_11_0 = nullable(CoreVerificationChallengeMode4Data:GetStageDataByStageID(self.stageView.stageID), "teams", self.index, "score") or 0

	if var_11_0 > 0 then
		self.clearStage = true

		self.stateController:SetSelectedState("clear")

		self.score_.text = var_11_0
	else
		self.clearStage = false

		self.stateController:SetSelectedState("lock")
	end
end

function var_0_2:SetActive(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function CoreVerificationChallengeStageViewMode4:InitUI()
	self:BindCfgUI()

	self.challengeHeadItems = {}

	for iter_13_0 = 1, 3 do
		self.challengeHeadItems[iter_13_0] = CoreVerificationChallengeHeroHeadItem.New(self["heroRightGo_" .. iter_13_0], iter_13_0)
	end

	self.recommendHeroItems = {}
	self.recommendTagItems = {}
	self.teamTabItems = {}
	self.updateInfoHandler = handler(self, self.UpdateCoreVerification)
	self.switchTeamHandler = handler(self, self.OnSwitchTeam)
	self.scoreController = self.controller_:GetController("points")
	self.timeController = self.controller_:GetController("time")
end

function CoreVerificationChallengeStageViewMode4:AddUIListeners()
	self:AddBtnListener(self.goBtn_, nil, function()
		local var_15_0 = CoreVerificationChallengeTools.GetActivityId()
		local var_15_1 = {
			section = self.stageID,
			sectionType = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4,
			activityID = var_15_0
		}
		local var_15_2 = ReserveTools.GetReserveParams(BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4, self.stageID, var_15_0)

		var_15_2.teamIndex = self.selectedTeamIndex
		var_15_1.reserveParams = var_15_2

		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", var_15_1)
	end)
	self:AddBtnListener(self.resetStageBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_CL_RESETTIPS1"),
			OkCallback = function()
				CoreVerificationChallengeMode4Action.ResetStage(self.activityID, self.stageID)
			end
		})
	end)
	self:AddBtnListener(self.resetTeamBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_CL_RESETTIPS3"),
			OkCallback = function()
				CoreVerificationChallengeMode4Action.ResetTeam(self.activityID, self.stageID, self.selectedTeamIndex)
			end
		})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isChallenge = true
		})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		SetActive(self.tipsGo_, false)
	end)
end

local function var_0_3(arg_22_0, arg_22_1)
	if arg_22_0 < 0 then
		return 0
	elseif arg_22_1 <= arg_22_0 then
		return arg_22_1 - 1
	else
		return arg_22_0
	end
end

function CoreVerificationChallengeStageViewMode4:OnEnter()
	CoreVerificationChallengeStageViewMode4.super.OnEnter(self)

	self.stageID = self.params_.stageID or self.stageID
	self.cfg = CoreVerificationClMode4Cfg[self.stageID]
	self.selectedTeamIndex = var_0_3(self.params_.team or self.selectedTeamIndex or ReserveConst.DEFAULT_TEAM_INDEX, self.cfg.stage_team)
	self.activityID = CoreVerificationChallengeTools.GetActivityId()

	self:RegistEventListener(CORE_VERIFICATION_CHALLENGE_CURRESET, self.updateInfoHandler)
	self:RegistEventListener(CORE_VERIFICATION_CHALLENGE_RESET, self.updateInfoHandler)
	manager.delayed:Add(self.updateInfoHandler, 0.033)
	manager.redPoint:bindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	self:StartTimer()
end

function CoreVerificationChallengeStageViewMode4:OnExit()
	self:StopTimer()
	self:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(self.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	CoreVerificationChallengeStageViewMode4.super.OnExit(self)
end

function CoreVerificationChallengeStageViewMode4:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function CoreVerificationChallengeStageViewMode4:OnBehind()
	manager.windowBar:HideBar()
end

function CoreVerificationChallengeStageViewMode4:Dispose()
	for iter_27_0, iter_27_1 in ipairs(self.challengeHeadItems) do
		iter_27_1:Dispose()
	end

	for iter_27_2, iter_27_3 in ipairs(self.recommendHeroItems) do
		iter_27_3:Dispose()
	end

	for iter_27_4, iter_27_5 in ipairs(self.recommendTagItems) do
		iter_27_5:Dispose()
	end

	for iter_27_6, iter_27_7 in ipairs(self.teamTabItems) do
		iter_27_7:Dispose()
	end

	CoreVerificationChallengeStageViewMode4.super.Dispose(self)
end

function CoreVerificationChallengeStageViewMode4:EnsureRecommondHeroItemCnt(arg_28_1)
	var_0_1(self.roleTrs_, self.recommendGo_, CoreVerificationChallengeHeroHeadItem, self.recommendHeroItems, arg_28_1)
end

function CoreVerificationChallengeStageViewMode4:EnsureRecommondTagItemCnt(arg_29_1)
	var_0_1(self.tagContent_, self.attributeGo_, CoreVerificationChallengeRecommendAttributeItem, self.recommendTagItems, arg_29_1)
end

function CoreVerificationChallengeStageViewMode4:EnsureTeamTabItemCnt(arg_30_1)
	var_0_1(self.teamTabs_, self.teamTabGo_, var_0_2, self.teamTabItems, arg_30_1)
end

function CoreVerificationChallengeStageViewMode4:StartTimer()
	self:StopTimer()

	self.timeTask = manager.timeWheel:AddTask(handler(self, self.RefreshTimeText), manager.time:GetServerTime(), 1)
end

function CoreVerificationChallengeStageViewMode4:StopTimer()
	if self.timeTask then
		manager.timeWheel:RemoveTask(self.timeTask)

		self.timeTask = nil
	end
end

function CoreVerificationChallengeStageViewMode4:UpdateCoreVerification()
	SetActive(self.tipsGo_, false)
	self:RefreshTitle()
	self:RefreshStageInfo()
	self:RefreshTeamInfo(self.selectedTeamIndex)
	self:RefreshTimeText()
end

function CoreVerificationChallengeStageViewMode4:OnSwitchTeam(arg_34_1)
	self.selectedTeamIndex = var_0_3(arg_34_1, self.cfg.stage_team)

	self:RefreshTeamInfo(self.selectedTeamIndex)
end

function CoreVerificationChallengeStageViewMode4:RefreshStageInfo()
	self.stageName_.text = self.cfg.stage_name

	local var_35_0 = nullable(self.cfg.stage_affix, 1) or 0

	if var_35_0 > 0 then
		SetActive(self.stageAffixObj_, true)

		self.stageDesc_.text = getAffixDesc(ActivityAffixPoolCfg[var_35_0].affix)
	else
		SetActive(self.stageAffixObj_, false)
	end

	local var_35_1 = ActivityAffixPoolCfg[self.cfg.type_affix[1]].affix

	self.stageAffixName_.text = getAffixName(ActivityAffixPoolCfg[self.cfg.type_affix[1]].affix)
	self.stageAffixDesc_.text = getAffixDesc(var_35_1)
	self.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/BossAttribute_new/%s", self.cfg.stage_img))

	self:EnsureRecommondHeroItemCnt(#self.cfg.recommend_team)

	for iter_35_0 = 1, #self.cfg.recommend_team do
		self.recommendHeroItems[iter_35_0]:RefreshUI(self.cfg.recommend_team[iter_35_0])
	end

	self:EnsureRecommondTagItemCnt(#self.cfg.recommend)

	for iter_35_1 = 1, #self.cfg.recommend do
		self.recommendTagItems[iter_35_1]:RefreshUI(self.cfg.recommend[iter_35_1])
	end

	local var_35_2 = false

	self:EnsureTeamTabItemCnt(self.cfg.stage_team)

	for iter_35_2 = 1, self.cfg.stage_team do
		local var_35_3 = self.teamTabItems[iter_35_2]

		self.teamTabItems[iter_35_2]:SetData(self, iter_35_2 - 1)
		var_35_3:RefreshSelect(var_35_3.index == self.selectTeamIndex)
		var_35_3:RefreshTeamInfo()

		if var_35_3.clearStage then
			var_35_2 = true
		end
	end

	SetActive(self.resetStageBtn_.gameObject, var_35_2 and self:IsStageResetEnabled())
end

function CoreVerificationChallengeStageViewMode4:RefreshTitle()
	self.titleText_.text = self.cfg.stage_name
	self.comAffixName_.text = getAffixName(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.comAffixDesc_.text = getAffixDesc(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
	self.comAffixIcon_.sprite = getAffixSprite(ActivityAffixPoolCfg[self.cfg.stage_com_affix[1]].affix)
end

function CoreVerificationChallengeStageViewMode4:RefreshTeamInfo(arg_37_1)
	for iter_37_0 = 1, self.cfg.stage_team do
		self.teamTabItems[iter_37_0]:RefreshSelect(self.teamTabItems[iter_37_0].index == arg_37_1)
	end

	local var_37_0 = CoreVerificationChallengeMode4Data:GetStageDataByStageID(self.stageID)
	local var_37_1 = nullable(var_37_0, "teams", arg_37_1, "score") or 0
	local var_37_2 = nullable(var_37_0, "teams", arg_37_1, "time") or 0
	local var_37_3 = nullable(var_37_0, "teams", arg_37_1, "heroList")
	local var_37_4 = false

	for iter_37_1 = 1, 3 do
		local var_37_5 = nullable(var_37_3, iter_37_1) or 0

		self.challengeHeadItems[iter_37_1]:RefreshUI(var_37_5)

		if var_37_5 ~= 0 then
			var_37_4 = true
		end
	end

	self.scoreText_.text = var_37_1

	if var_37_4 then
		self.pushTimeText_.text = manager.time:DescCdTime2(var_37_2, "00:00+")

		self.timeController:SetSelectedState("on")
		self.scoreController:SetSelectedState("on")
	else
		self.timeController:SetSelectedState("off")
		self.scoreController:SetSelectedState("off")
	end

	SetActive(self.resetTeamBtn_.gameObject, var_37_4 and self:IsStageResetEnabled())
end

function CoreVerificationChallengeStageViewMode4:RefreshTimeText()
	self.refreshTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId()).stopTime)
end

function CoreVerificationChallengeStageViewMode4:IsStageResetEnabled()
	return CoreVerificationChallengeMode4Data:GetMaxPoint() > 0
end

return CoreVerificationChallengeStageViewMode4
