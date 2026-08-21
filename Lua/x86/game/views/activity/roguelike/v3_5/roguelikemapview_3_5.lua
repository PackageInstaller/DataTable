local var_0_0 = class("RoguelikeMapView_3_5", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_RoguelikeUI/SummerUI_3_5_RoguelikeMapUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0.map = nil
	arg_4_0.activity_id = arg_4_0.params_.activity_id
	arg_4_0.activityData = ActivityData:GetActivityData(arg_4_0.activity_id)

	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.CtrlRank = ControllerUtil.GetController(arg_4_0.GoRank.transform, "rank")
	arg_4_0.CtrlDifficult = ControllerUtil.GetController(arg_4_0.GoDifficult.transform, "stage")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.BtnReset, nil, handler(arg_5_0, arg_5_0.OnBtnResetClick))
	arg_5_0:AddBtnListener(arg_5_0.BtnRole, nil, handler(arg_5_0, arg_5_0.OnBtnRoleClick))
	arg_5_0:AddBtnListener(arg_5_0.BtnReward, nil, handler(arg_5_0, arg_5_0.OnBtnRewardClick))
	arg_5_0:AddBtnListener(arg_5_0.BtnRank, nil, handler(arg_5_0, arg_5_0.OnBtnRankClick))
end

function var_0_0.OnBtnResetClick(arg_6_0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("GIVE_UP_MATRIX"),
		OkCallback = function()
			StrategyMatrixAction.QueryMatrixGiveUp(arg_6_0.activity_id)
		end,
		CancelCallback = function()
			return
		end
	})
end

function var_0_0.OnBtnRoleClick(arg_9_0)
	local var_9_0 = StrategyMatrixData:GetMatrixHeroTeam(arg_9_0.activity_id)

	JumpTools.OpenPageByJump("/strategyMatrixHero_new", {
		isEnter = true,
		matrix_activity_id = arg_9_0.activity_id,
		type = HeroConst.HERO_DATA_TYPE.STRATEGYMATRIX,
		tempHeroList = var_9_0
	})
end

function var_0_0.OnBtnRewardClick(arg_10_0)
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_reward2")
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_3_5
	})
end

function var_0_0.OnBtnRankClick(arg_11_0)
	JumpTools.OpenPageByJump("/roguelikeRank", {
		rank_id = arg_11_0.rank_id
	})
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.activity_id = arg_12_0.params_.activity_id
	arg_12_0.rank_id = arg_12_0:GetRankId(arg_12_0.activity_id)

	arg_12_0:BindRedPoint()
	arg_12_0:GenerateRoguelikeMap(arg_12_0.Content)
	arg_12_0:Refresh()

	arg_12_0.timer = Timer.New(handler(arg_12_0, arg_12_0.Tick), 1, -1)

	arg_12_0.timer:Start()
end

function var_0_0.OnExit(arg_13_0)
	manager.windowBar:HideBar()

	if arg_13_0.map then
		arg_13_0.map:Exit()
	end

	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end

	arg_13_0:UnBindRedPoint()
end

function var_0_0.OnUpdate(arg_14_0)
	arg_14_0:InitBar()
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:InitBar()

	if arg_15_0.map then
		arg_15_0.map:OnTop()
	end
end

function var_0_0.InitBar(arg_16_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(arg_16_0.activity_id))
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_16_0.activity_id)
	manager.windowBar:RegistBackCallBack(function()
		arg_16_0:Back()
	end)
end

function var_0_0.Refresh(arg_18_0)
	arg_18_0:TryPlayAnimation()
	arg_18_0:Tick()
	arg_18_0:RefreshTitleAndBg()
end

function var_0_0.GenerateRoguelikeMap(arg_19_0, arg_19_1)
	arg_19_0.mapId = StrategyMatrixData:GetMapId(arg_19_0.activity_id)

	if arg_19_0.map and arg_19_0.mapId ~= arg_19_0.map:GetMapId() then
		arg_19_0.map:Dispose()

		arg_19_0.map = nil
	end

	arg_19_0.map = arg_19_0.map or StrategyMatrixMap.New(arg_19_0.mapId, arg_19_1)

	arg_19_0.map:SetData(arg_19_0.activity_id)
end

function var_0_0.TryPlayAnimation(arg_20_0)
	arg_20_0.m_animation = arg_20_0.m_panel:GetComponent(typeof(Animation))

	if arg_20_0.params_.playerAnim then
		arg_20_0.m_animation:Play(nil, 0)

		arg_20_0.params_.playerAnim = nil

		arg_20_0.map:PlayerAnim(true)
	else
		arg_20_0.m_animation:Play(nil, 1)
		arg_20_0.map:PlayerAnim(false)
	end
end

function var_0_0.RefreshTitleAndBg(arg_21_0)
	local var_21_0 = RoguelikeConst[arg_21_0.activity_id]
	local var_21_1 = StrategyMatrixCfg[arg_21_0.activity_id]

	if not var_21_0 or not var_21_1 then
		print("请在RoguelikeConst加上对应活动id的配置")

		return
	end

	local var_21_2 = StrategyMatrixData:GetTierID(arg_21_0.activity_id)

	if not var_21_2 then
		arg_21_0.TxtTier.text = ""

		return
	end

	local var_21_3 = StrategyMatrixTierTemplateCfg[var_21_2]
	local var_21_4 = StrategyMatrixData:GetRoguelikeScore(arg_21_0.activity_id)
	local var_21_5 = var_21_1.activity_difficulty ~= 1

	arg_21_0.CtrlDifficult:SetSelectedIndex(var_21_5 and 1 or 0)

	arg_21_0.TxtDifficult.text = GetTips(var_21_5 and "HARDLEVEL_HARD" or "HARDLEVEL_EASY")
	arg_21_0.TxtTier.text = GetTips("ACTIVITY_ROGUELIKE_3_5_TITLE_" .. var_21_3.tier)
	arg_21_0.ImgBg.sprite = pureGetSpriteWithoutAtlas(var_21_0.background[var_21_3.tier])

	arg_21_0.GoRank:SetActive(arg_21_0.rank_id ~= 0)
	arg_21_0.CtrlRank:SetSelectedIndex(var_21_4 > 0 and 1 or 0)

	arg_21_0.TxtScore.text = var_21_4
end

function var_0_0.BindRedPoint(arg_22_0)
	manager.redPoint:bindUIandKey(arg_22_0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
end

function var_0_0.UnBindRedPoint(arg_23_0)
	manager.redPoint:unbindUIandKey(arg_23_0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
end

function var_0_0.Tick(arg_24_0)
	if manager.time:GetServerTime() <= arg_24_0.activityData.stopTime then
		arg_24_0.TxtTime.text = manager.time:GetLostTimeStrWith2Unit(arg_24_0.activityData.stopTime, true)
	else
		arg_24_0.TxtTime.text = GetTips("TIME_OVER")
	end
end

function var_0_0.GetRankId(arg_25_0, arg_25_1)
	local var_25_0 = ActivityCfg[arg_25_1]

	if not var_25_0 then
		return 0
	end

	for iter_25_0, iter_25_1 in ipairs(var_25_0.sub_activity_list) do
		local var_25_1 = ActivityCfg[iter_25_1]

		if var_25_1 and var_25_1.activity_template == ActivityTemplateConst.ROGUELIKE_RANK then
			return iter_25_1
		end
	end

	return 0
end

function var_0_0.Dispose(arg_26_0)
	if arg_26_0.map then
		arg_26_0.map:Dispose()
	end

	arg_26_0.map = nil

	var_0_0.super.Dispose(arg_26_0)
end

return var_0_0
