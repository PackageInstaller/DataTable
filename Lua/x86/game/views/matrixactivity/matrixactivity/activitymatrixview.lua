local var_0_0 = class("ActivityMatrixView", ReduxView)

function var_0_0.UIBackCount(arg_1_0)
	return 2
end

function var_0_0.UIName(arg_2_0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeSoloRoguelikeMainUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.campController = ControllerUtil.GetController(arg_5_0.m_titleTrans, "camp")
	arg_5_0.entranceController = ControllerUtil.GetController(arg_5_0.m_titleTrans, "entrance")
	arg_5_0.maxCamp = 6
	arg_5_0.rankActivityId = -1
	arg_5_0.rotationDiagram = MatrixRotationDiagram2D.New(arg_5_0.m_rotationDiagram, arg_5_0.m_particle)
	arg_5_0.clickTime = 0
	arg_5_0.selectCamp = ActivityMatrixAction.GetSelectCamp()
	arg_5_0.noticeController = ControllerUtil.GetController(arg_5_0.m_particle.transform, "notice")
	arg_5_0.particleController = ControllerUtil.GetController(arg_5_0.m_particle.transform, "particle")
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.m_storyBtn, nil, function()
		JumpTools.OpenPageByJump("/activityMatrixStoryReview")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_clueBtn, nil, function()
		JumpTools.OpenPageByJump("activityMatrixClue", {
			main_matrix_activity_id = arg_6_0.main_matrix_activity_id
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_rewardBtn, nil, function()
		local var_9_0 = arg_6_0.subActivityIdList[arg_6_0.selectCamp]

		if not var_9_0 then
			return
		end

		JumpTools.OpenPageByJump("activityMatrixScoreExchange", {
			matrix_activity_id = var_9_0
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_rankBtn, nil, function()
		if arg_6_0.rankActivityId == -1 then
			return
		end

		JumpTools.OpenPageByJump("/activityMatrixRank", {
			activityId = arg_6_0.rankActivityId
		})
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_leftBtn, nil, function()
		if Time.realtimeSinceStartup < arg_6_0.clickTime + 0.4 then
			return
		end

		arg_6_0.clickTime = Time.realtimeSinceStartup

		if arg_6_0.selectCamp <= 1 then
			arg_6_0.selectCamp = arg_6_0.maxCamp
		else
			arg_6_0.selectCamp = arg_6_0.selectCamp - 1
		end

		ActivityMatrixAction.SetSelectCamp(arg_6_0.selectCamp)

		arg_6_0.params_.selectCamp = arg_6_0.selectCamp

		arg_6_0.rotationDiagram:Change(arg_6_0.selectCamp)
		arg_6_0:RefreshUI()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_activity_1_3_select", "")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_rightBtn, nil, function()
		if Time.realtimeSinceStartup < arg_6_0.clickTime + 0.5 then
			return
		end

		arg_6_0.clickTime = Time.realtimeSinceStartup
		arg_6_0.selectCamp = arg_6_0.selectCamp % arg_6_0.maxCamp + 1

		ActivityMatrixAction.SetSelectCamp(arg_6_0.selectCamp)

		arg_6_0.params_.selectCamp = arg_6_0.selectCamp

		arg_6_0.rotationDiagram:Change(arg_6_0.selectCamp)
		arg_6_0:RefreshUI()
		manager.audio:PlayEffect("minigame_activity_1_3", "minigame_activity_1_3_select", "")
	end)
	arg_6_0:AddBtnListener(arg_6_0.m_clickBtn, nil, function()
		arg_6_0:StartMatrix()
	end)
end

function var_0_0.StartMatrix(arg_14_0)
	local var_14_0 = arg_14_0.subActivityIdList[arg_14_0.selectCamp]

	if not var_14_0 then
		return
	end

	local var_14_1 = ActivityMatrixCfg[var_14_0].preconditions
	local var_14_2 = ActivityMatrixCfg[var_14_1]

	if var_14_1 ~= 0 and not ActivityMatrixData:GetIsClearance(var_14_1) then
		ShowTips(string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), GetI18NText(var_14_2.name)))

		return
	end

	if not ActivityTools.GetActivityIsOpenWithTip(var_14_0) then
		return
	end

	local var_14_3 = ActivityMatrixData:GetGameState(var_14_0)

	if var_14_3 == MatrixConst.STATE_TYPE.SUCCESS or var_14_3 == MatrixConst.STATE_TYPE.FAIL then
		OpenPageUntilLoaded("/matrixBlank/activityMatrixOver", {
			matrix_activity_id = var_14_0
		})
	elseif var_14_3 == MatrixConst.STATE_TYPE.NOTSTARTED then
		OpenPageUntilLoaded("/activityMatrixSelectHero", {
			matrix_activity_id = var_14_0
		})
	elseif var_14_3 == MatrixConst.STATE_TYPE.STARTED then
		JumpTools.GoToSystem("/matrixBlank/activityMatrixOrigin", {
			matrix_activity_id = var_14_0
		})
	else
		error("activity matrix with error game state by id : " .. var_14_0 .. " gameState:" .. var_14_3)
	end
end

function var_0_0.OnTop(arg_15_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
end

function var_0_0.OnEnter(arg_16_0)
	if arg_16_0.params_.playerAnim then
		arg_16_0.m_animator:Play("VolumeSoloRoguelikeMainUI", 0, 0)

		arg_16_0.params_.playerAnim = nil
	else
		arg_16_0.m_animator:Play("VolumeSoloRoguelikeMainUI", 0, 9999999)
	end

	arg_16_0.main_matrix_activity_id = arg_16_0.params_.main_matrix_activity_id
	arg_16_0.subActivityIdList = ActivityCfg[arg_16_0.main_matrix_activity_id] and ActivityCfg[arg_16_0.main_matrix_activity_id].sub_activity_list or {}
	arg_16_0.selectCamp = arg_16_0.params_.selectCamp or arg_16_0.selectCamp or 1

	if arg_16_0.params_.matrix_activity_id then
		arg_16_0.selectCamp = table.indexof(arg_16_0.subActivityIdList, arg_16_0.params_.matrix_activity_id) or arg_16_0.selectCamp
		arg_16_0.params_.matrix_activity_id = nil
	end

	arg_16_0:RefreshUI()
	arg_16_0.rotationDiagram:SetData(arg_16_0.selectCamp)

	arg_16_0.timer = Timer.New(function()
		arg_16_0:RefrenTime()
	end, 1, -1)

	arg_16_0.timer:Start()
	SetActive(arg_16_0.m_particle, true)
	manager.redPoint:bindUIandKey(arg_16_0.m_clueBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, arg_16_0.main_matrix_activity_id))
end

function var_0_0.RefreshUI(arg_18_0)
	arg_18_0.campController:SetSelectedIndex(arg_18_0.selectCamp - 1)

	local var_18_0 = arg_18_0.subActivityIdList[arg_18_0.selectCamp]

	arg_18_0.m_scoreLab.text = ActivityMatrixData:GetMatrixScore(var_18_0)

	arg_18_0:RefrenTime()

	local var_18_1 = ActivityCfg[var_18_0]

	arg_18_0.rankActivityId = -1

	for iter_18_0, iter_18_1 in ipairs(var_18_1.sub_activity_list) do
		if ActivityCfg[iter_18_1] and ActivityTemplateConst.SINGLE_MATRIX_RANK == ActivityCfg[iter_18_1].activity_template then
			arg_18_0.rankActivityId = iter_18_1

			break
		end
	end

	if arg_18_0.rankActivityId == -1 then
		SetActive(arg_18_0.m_rankBtn.gameObject, false)
	else
		SetActive(arg_18_0.m_rankBtn.gameObject, true)
	end

	manager.redPoint:SetRedPointIndependent(arg_18_0.m_rewardBtn.transform, ActivityMatrixData:GetMatrixPointCanReward(var_18_0))
	ActivityMatrixAction.SetActivityMtairxRead(arg_18_0.main_matrix_activity_id, var_18_0)

	if arg_18_0.selectCamp == 3 then
		arg_18_0.noticeController:SetSelectedIndex(1)
	else
		arg_18_0.noticeController:SetSelectedIndex(0)
	end

	local var_18_2 = ActivityMatrixCfg[var_18_0]
	local var_18_3 = var_18_2.preconditions

	if not ActivityMatrixData:GetIsClearance(var_18_3) or not ActivityData:GetActivityIsOpen(var_18_0) then
		arg_18_0.particleController:SetSelectedIndex(0)
	elseif MatrixConst.STATE_TYPE.NOTSTARTED ~= ActivityMatrixData:GetGameState(var_18_0) then
		arg_18_0.particleController:SetSelectedIndex(2)

		arg_18_0.m_enterText_1.text = GetTips("ACTIVITY_MATRIX_PERFORM_TIPS")
		arg_18_0.m_enterText_2.text = GetTips("ACTIVITY_MATRIX_PERFORM_TIPS")
		arg_18_0.m_enterText_3.text = GetTips("ACTIVITY_MATRIX_PERFORM_TIPS")
	else
		arg_18_0.particleController:SetSelectedIndex(1)

		arg_18_0.m_enterText_1.text = GetTips("ACTIVITY_MATRIX_ENTER_TIPS")
		arg_18_0.m_enterText_2.text = GetTips("ACTIVITY_MATRIX_ENTER_TIPS")
		arg_18_0.m_enterText_3.text = GetTips("ACTIVITY_MATRIX_ENTER_TIPS")
	end

	arg_18_0.m_titleText.text = GetI18NText(var_18_2.name)

	local var_18_4 = arg_18_0.selectCamp
	local var_18_5 = false

	for iter_18_2 = var_18_4 + 1, var_18_4 + 3 do
		local var_18_6 = iter_18_2 % arg_18_0.maxCamp
		local var_18_7 = arg_18_0.subActivityIdList[var_18_6]

		if ActivityMatrixAction.CheckSubReadRedPonit(var_18_7) or ActivityMatrixData:GetMatrixPointCanReward(var_18_7) then
			var_18_5 = true

			break
		end
	end

	manager.redPoint:SetRedPointIndependent(arg_18_0.m_rightBtn.transform, var_18_5)

	local var_18_8 = false

	for iter_18_3 = var_18_4 - 1, var_18_4 - 2, -1 do
		local var_18_9 = (iter_18_3 + arg_18_0.maxCamp) % arg_18_0.maxCamp

		if var_18_9 == 0 then
			var_18_9 = arg_18_0.maxCamp
		end

		local var_18_10 = arg_18_0.subActivityIdList[var_18_9]

		if ActivityMatrixAction.CheckSubReadRedPonit(var_18_10) or ActivityMatrixData:GetMatrixPointCanReward(var_18_10) then
			var_18_8 = true

			break
		end
	end

	manager.redPoint:SetRedPointIndependent(arg_18_0.m_leftBtn.transform, var_18_8)
end

function var_0_0.RefrenTime(arg_19_0)
	local var_19_0 = manager.time:GetServerTime()
	local var_19_1 = ActivityData:GetActivityData(arg_19_0.main_matrix_activity_id)

	if var_19_1 and var_19_0 < var_19_1.stopTime then
		arg_19_0.m_mainTimeLab.text = manager.time:GetLostTimeStr(var_19_1.stopTime)
	else
		arg_19_0.m_mainTimeLab.text = GetTips("TIME_OVER")
	end

	local var_19_2 = arg_19_0.subActivityIdList[arg_19_0.selectCamp]
	local var_19_3 = ActivityMatrixCfg[var_19_2].preconditions
	local var_19_4 = ActivityMatrixCfg[var_19_3]

	if var_19_3 ~= 0 and not ActivityMatrixData:GetIsClearance(var_19_3) then
		arg_19_0.entranceController:SetSelectedIndex(0)

		arg_19_0.m_timeLab.text = string.format(GetTips("ACTIVITY_MATRIX_PRECONDITIONS"), GetI18NText(var_19_4.name))

		return
	end

	if ActivityData:GetActivityIsOpen(var_19_2) then
		arg_19_0.entranceController:SetSelectedIndex(1)
	else
		arg_19_0.entranceController:SetSelectedIndex(0)

		local var_19_5 = ActivityData:GetActivityData(var_19_2)

		if var_19_5 and var_19_0 < var_19_5.startTime then
			arg_19_0.m_timeLab.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_19_5.startTime))
		else
			arg_19_0.m_timeLab.text = GetTips("TIME_OVER")
		end
	end
end

function var_0_0.OnExit(arg_20_0)
	manager.windowBar:HideBar()

	if arg_20_0.timer then
		arg_20_0.timer:Stop()

		arg_20_0.timer = nil
	end

	arg_20_0.clickTime = 0

	manager.redPoint:unbindUIandKey(arg_20_0.m_clueBtn.transform, string.format("%s_%s", RedPointConst.ACTIVITY_MATRIX_CLUE, arg_20_0.main_matrix_activity_id))
end

function var_0_0.OnReceivePointReward(arg_21_0)
	local var_21_0 = arg_21_0.subActivityIdList[arg_21_0.selectCamp]

	manager.redPoint:SetRedPointIndependent(arg_21_0.m_rewardBtn.transform, ActivityMatrixData:GetMatrixPointCanReward(var_21_0))
end

function var_0_0.Dispose(arg_22_0)
	arg_22_0.rotationDiagram:Dispose()
	var_0_0.super.Dispose(arg_22_0)
end

return var_0_0
