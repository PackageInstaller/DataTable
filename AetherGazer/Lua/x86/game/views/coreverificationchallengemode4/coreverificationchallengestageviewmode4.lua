local var_0_0 = class("CoreVerificationChallengeStageViewMode4", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode4/Core_Verification_OrdinaryStageUI_Mode4"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

local function var_0_1(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	for iter_4_0 = arg_4_0.childCount + 1, arg_4_4 do
		local var_4_0 = Object.Instantiate(arg_4_1, arg_4_0)
	end

	local var_4_1 = arg_4_0.childCount

	for iter_4_1 = 1, var_4_1 do
		local var_4_2 = arg_4_0:GetChild(iter_4_1 - 1).gameObject

		arg_4_3[iter_4_1] = arg_4_3[iter_4_1] or arg_4_2.New(var_4_2)

		arg_4_3[iter_4_1]:SetActive(iter_4_1 <= arg_4_4)
	end
end

local var_0_2 = class("CoreVerificationChallengeStageViewMode4.TeamTabItem", BaseView)

function var_0_2.Ctor(arg_5_0, arg_5_1)
	arg_5_0.gameObject_ = arg_5_1
	arg_5_0.transform_ = arg_5_1.transform

	arg_5_0:Init()
end

function var_0_2.Init(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.stateController = arg_6_0.controllers_:GetController("state")
	arg_6_0.selectController = arg_6_0.controllers_:GetController("select")

	arg_6_0:AddBtnListener(arg_6_0.btn_, nil, function()
		arg_6_0:OnSelect()
	end)
end

function var_0_2.SetData(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.stageView = arg_8_1
	arg_8_0.index = arg_8_2

	arg_8_0:RefreshTeamInfo()
end

function var_0_2.OnSelect(arg_9_0)
	arg_9_0.stageView:OnSwitchTeam(arg_9_0.index)
end

function var_0_2.RefreshSelect(arg_10_0, arg_10_1)
	arg_10_0.selectController:SetSelectedState(arg_10_1 and "true" or "false")
end

function var_0_2.RefreshTeamInfo(arg_11_0)
	local var_11_0 = arg_11_0.stageView.stageID
	local var_11_1 = CoreVerificationChallengeMode4Data:GetStageDataByStageID(var_11_0)
	local var_11_2 = nullable(var_11_1, "teams", arg_11_0.index, "score") or 0

	if var_11_2 > 0 then
		arg_11_0.clearStage = true

		arg_11_0.stateController:SetSelectedState("clear")

		arg_11_0.score_.text = var_11_2
	else
		arg_11_0.clearStage = false

		arg_11_0.stateController:SetSelectedState("lock")
	end
end

function var_0_2.SetActive(arg_12_0, arg_12_1)
	SetActive(arg_12_0.gameObject_, arg_12_1)
end

function var_0_0.InitUI(arg_13_0)
	arg_13_0:BindCfgUI()

	arg_13_0.challengeHeadItems = {}

	for iter_13_0 = 1, 3 do
		arg_13_0.challengeHeadItems[iter_13_0] = CoreVerificationChallengeHeroHeadItem.New(arg_13_0["heroRightGo_" .. iter_13_0], iter_13_0)
	end

	arg_13_0.recommendHeroItems = {}
	arg_13_0.recommendTagItems = {}
	arg_13_0.teamTabItems = {}
	arg_13_0.updateInfoHandler = handler(arg_13_0, arg_13_0.UpdateCoreVerification)
	arg_13_0.switchTeamHandler = handler(arg_13_0, arg_13_0.OnSwitchTeam)
	arg_13_0.scoreController = arg_13_0.controller_:GetController("points")
	arg_13_0.timeController = arg_13_0.controller_:GetController("time")
end

function var_0_0.AddUIListeners(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.goBtn_, nil, function()
		local var_15_0 = CoreVerificationChallengeTools.GetActivityId()
		local var_15_1 = arg_14_0.stageID
		local var_15_2 = BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION_CHALLENGE_MODE4
		local var_15_3 = {
			section = var_15_1,
			sectionType = var_15_2,
			activityID = var_15_0
		}
		local var_15_4 = ReserveTools.GetReserveParams(var_15_2, var_15_1, var_15_0)

		var_15_4.teamIndex = arg_14_0.selectedTeamIndex
		var_15_3.reserveParams = var_15_4

		JumpTools.OpenPageByJump("/coreVerificationChallengeSectionSelectHeroView", var_15_3)
	end)
	arg_14_0:AddBtnListener(arg_14_0.resetStageBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_CL_RESETTIPS1"),
			OkCallback = function()
				CoreVerificationChallengeMode4Action.ResetStage(arg_14_0.activityID, arg_14_0.stageID)
			end
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.resetTeamBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("CORE_VERIFICATION_CL_RESETTIPS3"),
			OkCallback = function()
				CoreVerificationChallengeMode4Action.ResetTeam(arg_14_0.activityID, arg_14_0.stageID, arg_14_0.selectedTeamIndex)
			end
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("/coreVerificationReward", {
			isChallenge = true
		})
	end)
	arg_14_0:AddBtnListener(arg_14_0.bgBtn_, nil, function()
		SetActive(arg_14_0.tipsGo_, false)
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

function var_0_0.OnEnter(arg_23_0)
	var_0_0.super.OnEnter(arg_23_0)

	arg_23_0.stageID = arg_23_0.params_.stageID or arg_23_0.stageID
	arg_23_0.cfg = CoreVerificationClMode4Cfg[arg_23_0.stageID]
	arg_23_0.selectedTeamIndex = var_0_3(arg_23_0.params_.team or arg_23_0.selectedTeamIndex or ReserveConst.DEFAULT_TEAM_INDEX, arg_23_0.cfg.stage_team)
	arg_23_0.activityID = CoreVerificationChallengeTools.GetActivityId()

	arg_23_0:RegistEventListener(CORE_VERIFICATION_CHALLENGE_CURRESET, arg_23_0.updateInfoHandler)
	arg_23_0:RegistEventListener(CORE_VERIFICATION_CHALLENGE_RESET, arg_23_0.updateInfoHandler)
	manager.delayed:Add(arg_23_0.updateInfoHandler, 0.033)
	manager.redPoint:bindUIandKey(arg_23_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	arg_23_0:StartTimer()
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0:StopTimer()
	arg_24_0:RemoveAllEventListener()
	manager.redPoint:unbindUIandKey(arg_24_0.rewardBtn_.transform, RedPointConst.CORE_VERIFICATION_CHALLENGE_MODE_REWARD)
	var_0_0.super.OnExit(arg_24_0)
end

function var_0_0.OnTop(arg_25_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnBehind(arg_26_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.challengeHeadItems) do
		iter_27_1:Dispose()
	end

	for iter_27_2, iter_27_3 in ipairs(arg_27_0.recommendHeroItems) do
		iter_27_3:Dispose()
	end

	for iter_27_4, iter_27_5 in ipairs(arg_27_0.recommendTagItems) do
		iter_27_5:Dispose()
	end

	for iter_27_6, iter_27_7 in ipairs(arg_27_0.teamTabItems) do
		iter_27_7:Dispose()
	end

	var_0_0.super.Dispose(arg_27_0)
end

function var_0_0.EnsureRecommondHeroItemCnt(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.roleTrs_
	local var_28_1 = arg_28_0.recommendGo_
	local var_28_2 = CoreVerificationChallengeHeroHeadItem
	local var_28_3 = arg_28_0.recommendHeroItems

	var_0_1(var_28_0, var_28_1, var_28_2, var_28_3, arg_28_1)
end

function var_0_0.EnsureRecommondTagItemCnt(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.tagContent_
	local var_29_1 = arg_29_0.attributeGo_
	local var_29_2 = CoreVerificationChallengeRecommendAttributeItem
	local var_29_3 = arg_29_0.recommendTagItems

	var_0_1(var_29_0, var_29_1, var_29_2, var_29_3, arg_29_1)
end

function var_0_0.EnsureTeamTabItemCnt(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.teamTabs_
	local var_30_1 = arg_30_0.teamTabGo_
	local var_30_2 = var_0_2
	local var_30_3 = arg_30_0.teamTabItems

	var_0_1(var_30_0, var_30_1, var_30_2, var_30_3, arg_30_1)
end

function var_0_0.StartTimer(arg_31_0)
	arg_31_0:StopTimer()

	arg_31_0.timeTask = manager.timeWheel:AddTask(handler(arg_31_0, arg_31_0.RefreshTimeText), manager.time:GetServerTime(), 1)
end

function var_0_0.StopTimer(arg_32_0)
	if arg_32_0.timeTask then
		manager.timeWheel:RemoveTask(arg_32_0.timeTask)

		arg_32_0.timeTask = nil
	end
end

function var_0_0.UpdateCoreVerification(arg_33_0)
	SetActive(arg_33_0.tipsGo_, false)
	arg_33_0:RefreshTitle()
	arg_33_0:RefreshStageInfo()
	arg_33_0:RefreshTeamInfo(arg_33_0.selectedTeamIndex)
	arg_33_0:RefreshTimeText()
end

function var_0_0.OnSwitchTeam(arg_34_0, arg_34_1)
	arg_34_0.selectedTeamIndex = var_0_3(arg_34_1, arg_34_0.cfg.stage_team)

	arg_34_0:RefreshTeamInfo(arg_34_0.selectedTeamIndex)
end

function var_0_0.RefreshStageInfo(arg_35_0)
	local var_35_0 = arg_35_0.cfg

	arg_35_0.stageName_.text = var_35_0.stage_name

	local var_35_1 = nullable(var_35_0.stage_affix, 1) or 0

	if var_35_1 > 0 then
		SetActive(arg_35_0.stageAffixObj_, true)

		local var_35_2 = ActivityAffixPoolCfg[var_35_1].affix

		arg_35_0.stageDesc_.text = getAffixDesc(var_35_2)
	else
		SetActive(arg_35_0.stageAffixObj_, false)
	end

	local var_35_3 = var_35_0.type_affix[1]
	local var_35_4 = ActivityAffixPoolCfg[var_35_3].affix

	arg_35_0.stageAffixName_.text = getAffixName(var_35_4)
	arg_35_0.stageAffixDesc_.text = getAffixDesc(var_35_4)
	arg_35_0.bossIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("TextureConfig/BossAttribute_new/%s", var_35_0.stage_img))

	local var_35_5 = var_35_0.recommend_team

	arg_35_0:EnsureRecommondHeroItemCnt(#var_35_5)

	for iter_35_0 = 1, #var_35_5 do
		local var_35_6 = var_35_5[iter_35_0]

		arg_35_0.recommendHeroItems[iter_35_0]:RefreshUI(var_35_6)
	end

	local var_35_7 = var_35_0.recommend

	arg_35_0:EnsureRecommondTagItemCnt(#var_35_7)

	for iter_35_1 = 1, #var_35_7 do
		local var_35_8 = var_35_7[iter_35_1]

		arg_35_0.recommendTagItems[iter_35_1]:RefreshUI(var_35_8)
	end

	local var_35_9 = false
	local var_35_10 = var_35_0.stage_team

	arg_35_0:EnsureTeamTabItemCnt(var_35_10)

	for iter_35_2 = 1, var_35_10 do
		local var_35_11 = arg_35_0.teamTabItems[iter_35_2]

		var_35_11:SetData(arg_35_0, iter_35_2 - 1)

		local var_35_12 = var_35_11.index == arg_35_0.selectTeamIndex

		var_35_11:RefreshSelect(var_35_12)
		var_35_11:RefreshTeamInfo()

		if var_35_11.clearStage then
			var_35_9 = true
		end
	end

	SetActive(arg_35_0.resetStageBtn_.gameObject, var_35_9 and arg_35_0:IsStageResetEnabled())
end

function var_0_0.RefreshTitle(arg_36_0)
	local var_36_0 = arg_36_0.cfg
	local var_36_1 = var_36_0.stage_com_affix[1]
	local var_36_2 = ActivityAffixPoolCfg[var_36_1].affix

	arg_36_0.titleText_.text = var_36_0.stage_name
	arg_36_0.comAffixName_.text = getAffixName(var_36_2)
	arg_36_0.comAffixDesc_.text = getAffixDesc(var_36_2)
	arg_36_0.comAffixIcon_.sprite = getAffixSprite(var_36_2)
end

function var_0_0.RefreshTeamInfo(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.cfg.stage_team

	for iter_37_0 = 1, var_37_0 do
		local var_37_1 = arg_37_0.teamTabItems[iter_37_0].index == arg_37_1

		arg_37_0.teamTabItems[iter_37_0]:RefreshSelect(var_37_1)
	end

	local var_37_2 = CoreVerificationChallengeMode4Data:GetStageDataByStageID(arg_37_0.stageID)
	local var_37_3 = nullable(var_37_2, "teams", arg_37_1, "score") or 0
	local var_37_4 = nullable(var_37_2, "teams", arg_37_1, "time") or 0
	local var_37_5 = nullable(var_37_2, "teams", arg_37_1, "heroList")
	local var_37_6 = false

	for iter_37_1 = 1, 3 do
		local var_37_7 = nullable(var_37_5, iter_37_1) or 0

		arg_37_0.challengeHeadItems[iter_37_1]:RefreshUI(var_37_7)

		if var_37_7 ~= 0 then
			var_37_6 = true
		end
	end

	arg_37_0.scoreText_.text = var_37_3

	if var_37_6 then
		arg_37_0.pushTimeText_.text = manager.time:DescCdTime2(var_37_4, "00:00+")

		arg_37_0.timeController:SetSelectedState("on")
		arg_37_0.scoreController:SetSelectedState("on")
	else
		arg_37_0.timeController:SetSelectedState("off")
		arg_37_0.scoreController:SetSelectedState("off")
	end

	SetActive(arg_37_0.resetTeamBtn_.gameObject, var_37_6 and arg_37_0:IsStageResetEnabled())
end

function var_0_0.RefreshTimeText(arg_38_0)
	local var_38_0 = ActivityData:GetActivityData(CoreVerificationChallengeTools.GetActivityId())

	arg_38_0.refreshTime_.text = manager.time:GetLostTimeStrWith2UnitWithPrefix(var_38_0.stopTime)
end

function var_0_0.IsStageResetEnabled(arg_39_0)
	return CoreVerificationChallengeMode4Data:GetMaxPoint() > 0
end

return var_0_0
