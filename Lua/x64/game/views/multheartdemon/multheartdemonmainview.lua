local var_0_0 = class("MultHeartDemonMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/Acitvity_SoloHeartDemon"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.difficultyBtnControllerList = {}
	arg_4_0.difficultyBtnControllerList[1] = arg_4_0.difficultyController1_:GetController("select")
	arg_4_0.difficultyBtnControllerList[2] = arg_4_0.difficultyController2_:GetController("select")
	arg_4_0.rankController = ControllerUtil.GetController(arg_4_0.rankGo_.transform, "state")
	arg_4_0.list = LuaList.New(handler(arg_4_0, arg_4_0.SetListItem), arg_4_0.list_, MultHeartDemonListItem)
end

function var_0_0.SetListItem(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.rankData.rankList[arg_5_1]

	arg_5_2:SetData(var_5_0, arg_5_1, 1)
end

function var_0_0.IsLocked(arg_6_0)
	return arg_6_0:CheckIsChallengeTime() and MultHeartDemonData:GetDataByPara("isLock")
end

function var_0_0.AddUIListener(arg_7_0)
	for iter_7_0 = 1, 2 do
		arg_7_0:AddBtnListener(arg_7_0["difficultyBtn" .. iter_7_0 .. "_"], nil, function()
			if arg_7_0.selectDifficulty == iter_7_0 then
				return
			end

			local var_8_0 = arg_7_0:IsLocked()

			if MultHeartDemonData:GetDataByPara("difficultyData")[3 - iter_7_0] ~= nil and var_8_0 then
				ShowTips("MULTI_HEART_DEMON_CHALLENGE_HAS_BEGUN")

				return
			end

			arg_7_0:UpdateSelectedDifficultyParams(iter_7_0)
			arg_7_0.animator_:Play(arg_7_0.selectDifficulty == 1 and "change_blue" or "change_red", 0, 0)
			arg_7_0:UpdateView()
			arg_7_0:UpdateDifficultyControllerState()
		end)
	end

	arg_7_0:AddBtnListener(arg_7_0.fightBtn_, nil, function()
		JumpTools.GoToSystem("/MultHeartDemonCombine", {
			isMain = true,
			activityId = arg_7_0.activityId,
			difficult = arg_7_0.selectDifficulty
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.fight2Btn_, nil, function()
		JumpTools.GoToSystem("/MultHeartDemonCombine", {
			isMain = true,
			activityId = arg_7_0.activityId,
			difficult = arg_7_0.selectDifficulty
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.rewardBtn_, nil, function()
		if ActivityData:GetActivityIsOpen(arg_7_0.activityId) then
			JumpTools.GoToSystem("/multHeartDemonReward", {
				activityId = arg_7_0.activityId
			})
		else
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.listGoBtn_, nil, function()
		JumpTools.GoToSystem("/multHeartDemonRank", {
			activityId = arg_7_0.activityId
		})
	end)
end

function var_0_0.CheckIsChallengeTime(arg_13_0)
	return ActivityData:GetActivityIsOpen(arg_13_0.activityId) and arg_13_0.challengeStage == 0
end

function var_0_0.CheckIsRankProcessingTime(arg_14_0)
	return arg_14_0.challengeStage == 1
end

function var_0_0.CheckIsRankReleaseTime(arg_15_0)
	return arg_15_0.challengeStage == 2
end

function var_0_0.UpdateSelectedDifficultyParams(arg_16_0, arg_16_1)
	arg_16_0.selectDifficulty = arg_16_1 or arg_16_0.params_.difficulty or arg_16_0.selectDifficulty or 1

	if arg_16_0:IsLocked() then
		if MultHeartDemonData:GetDataByPara("enterFlag") then
			arg_16_0.selectDifficulty = 2
		else
			arg_16_0.selectDifficulty = 1
		end
	end

	arg_16_0.params_.difficulty = arg_16_0.selectDifficulty
end

function var_0_0.UpdateView(arg_17_0)
	arg_17_0.activityId = MultHeartDemonData:GetDataByPara("activityId")
	arg_17_0.challengeStage = MultHeartDemonData:GetDataByPara("challengeStage")
	arg_17_0.maxScore = nullable(MultHeartDemonData:GetDataByPara("maxScore"), 2) or 0
	arg_17_0.remainTime = ActivityData:GetActivityRefreshTime(arg_17_0.activityId)
	arg_17_0.cfg = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[arg_17_0.activityId][1]]

	arg_17_0:UpdateSelectedDifficultyParams()
	arg_17_0:UpdateDifficultyControllerState()
	arg_17_0:OnRankUpdate()
	arg_17_0:LoadModel()

	local var_17_0 = arg_17_0.selectDifficulty == 2 and "SoloHeartDemonUI_00026x" or "SoloHeartDemonUI_00012x"

	arg_17_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureBg/Activity_Resident/Acitvity_SoloHeartDemon/" .. var_17_0)
	arg_17_0.easyTxt_.text = GetTips("MULTI_HEART_DEMON_EASY_NAME")
	arg_17_0.hardTxt_.text = GetTips("MULTI_HEART_DEMON_HARD_NAME")

	SetActive(arg_17_0.nameGo1_, arg_17_0.selectDifficulty == 1)
	SetActive(arg_17_0.nameGo2_, arg_17_0.selectDifficulty == 2)
	SetActive(arg_17_0.list.gameObject, arg_17_0.selectDifficulty == 2)
	SetActive(arg_17_0.normalEffect_, arg_17_0.selectDifficulty == 1)
	SetActive(arg_17_0.hardEffect_, arg_17_0.selectDifficulty == 2)

	arg_17_0.rawImage1_.color = arg_17_0.selectDifficulty == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)
	arg_17_0.rawImage2_.color = arg_17_0.selectDifficulty == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)
	arg_17_0.maxScoreTxt_.text = GetTipsF("ACTIVITY_LINKGAME_SCORE_RECORDER", arg_17_0.maxScore)

	arg_17_0:UpdateBtnAvailableByActivityTime()
	arg_17_0:StartTimer(function()
		arg_17_0:UpdateBtnAvailableByActivityTime()
	end)
	SetActive(arg_17_0.rankGo_, not arg_17_0:CheckIsRankProcessingTime())
end

function var_0_0.UpdateBtnAvailableByActivityTime(arg_19_0)
	if arg_19_0:CheckIsChallengeTime() then
		local var_19_0 = manager.time:GetLostTimeStrWith2Unit(arg_19_0.remainTime)

		arg_19_0.remainTxt2_.text = TimeMgr.WrapTimeStrWithTips(var_19_0, "MULTI_HEART_DEMON_CHALLENGE_TIME")

		local var_19_1 = arg_19_0:IsLocked()

		SetActive(arg_19_0.ashGo_, false)
		SetActive(arg_19_0.fightBtn_.gameObject, arg_19_0.selectDifficulty == 1)
		SetActive(arg_19_0.fight2Btn_.gameObject, arg_19_0.selectDifficulty == 2)
		SetActive(arg_19_0.fight1Go_, var_19_1 and MultHeartDemonData:GetDataByPara("difficultyData")[1] ~= nil)
		SetActive(arg_19_0.fight2Go_, var_19_1 and MultHeartDemonData:GetDataByPara("difficultyData")[2] ~= nil and MultHeartDemonData:GetDataByPara("difficultyData")[1] == nil)
	else
		arg_19_0.remainTxt2_.text = GetTips("MULTI_HEART_DEMON_REFRESH_TIPS")

		SetActive(arg_19_0.ashGo_, true)
		SetActive(arg_19_0.fightBtn_.gameObject, false)
		SetActive(arg_19_0.fight2Btn_.gameObject, false)
		SetActive(arg_19_0.fight1Go_, false)
		SetActive(arg_19_0.fight2Go_, false)
	end
end

function var_0_0.UpdateDifficultyControllerState(arg_20_0)
	for iter_20_0 = 1, 2 do
		arg_20_0.difficultyBtnControllerList[iter_20_0]:SetSelectedState(arg_20_0.selectDifficulty == iter_20_0 and "true" or "false")
	end
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0.exitView_ = false

	arg_21_0.animator_:Play("Acitvity_SoloHeartDemon", 1, 0)
	manager.ui:SetMainCamera("multiHeartDemon")
	arg_21_0:InitBackScene()
	arg_21_0:UpdateView()
	RankAction.QueryCommonRank(RankConst.RANK_ID.MULTHEARTDEMON, nil, nil, 300)
	arg_21_0:BindRedPoint()
	arg_21_0:RegisterEvents()
end

function var_0_0.OnRankUpdate(arg_22_0)
	arg_22_0.rankData = RankData:GetCommonRank(RankConst.RANK_ID.MULTHEARTDEMON)

	arg_22_0.rankController:SetSelectedState("mini")

	if arg_22_0.rankData == nil then
		return
	end

	if #arg_22_0.rankData.rankList >= 5 then
		arg_22_0.rankController:SetSelectedState("all")
	end

	arg_22_0.list:StartScroll(5)
end

function var_0_0.OnMultDemonHeartUpdate(arg_23_0)
	arg_23_0:UpdateView()
end

function var_0_0.BindRedPoint(arg_24_0)
	manager.redPoint:bindUIandKey(arg_24_0.rewardBtn_.transform, RedPointConst.MULT_HEART_DEMON_REWARD)
	manager.redPoint:bindUIandKey(arg_24_0.fightBtn_.transform, RedPointConst.MULT_HEART_DEMON_FIRST_VIEW)
	manager.redPoint:bindUIandKey(arg_24_0.fight2Btn_.transform, RedPointConst.MULT_HEART_DEMON_FIRST_VIEW)
end

function var_0_0.UnbindRedPoint(arg_25_0)
	manager.redPoint:unbindUIandKey(arg_25_0.rewardBtn_.transform, RedPointConst.MULT_HEART_DEMON_REWARD)
	manager.redPoint:unbindUIandKey(arg_25_0.fightBtn_.transform, RedPointConst.MULT_HEART_DEMON_FIRST_VIEW)
	manager.redPoint:unbindUIandKey(arg_25_0.fight2Btn_.transform, RedPointConst.MULT_HEART_DEMON_FIRST_VIEW)
end

function var_0_0.StartTimer(arg_26_0, arg_26_1)
	arg_26_0:StopTimer()

	arg_26_0.updateTimer2_ = Timer.New(arg_26_1, 1, -1, 1)

	arg_26_0.updateTimer2_:Start()
end

function var_0_0.StopTimer(arg_27_0)
	if arg_27_0.updateTimer2_ then
		arg_27_0.updateTimer2_:Stop()

		arg_27_0.updateTimer2_ = nil
	end
end

function var_0_0.OnExit(arg_28_0)
	arg_28_0:RemoveAllEventListener()

	arg_28_0.exitView_ = true

	arg_28_0:UnbindRedPoint()
	manager.windowBar:HideBar()
	arg_28_0:DestroyBackScene()
	arg_28_0:UnloadModel()
	manager.ui:ResetMainCamera()
	arg_28_0:StopTimer()
	SetActive(arg_28_0.hardEffect_, false)
end

function var_0_0.OnTop(arg_29_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		NAVI_BAR
	})
	manager.windowBar:SetGameHelpKey("MULTI_HEART_DEMON_GAMEPLAY_DESC")
end

function var_0_0.Dispose(arg_30_0)
	if arg_30_0.list then
		arg_30_0.list:Dispose()

		arg_30_0.list = nil
	end

	var_0_0.super.Dispose(arg_30_0)
	Object.Destroy(arg_30_0.gameObject_)
end

function var_0_0.RegisterEvents(arg_31_0)
	arg_31_0:RegistEventListener(ACTIVITY_UPDATE, function(arg_32_0)
		if arg_32_0 == arg_31_0.activityId then
			arg_31_0.remainTime = ActivityData:GetActivityRefreshTime(arg_32_0)

			arg_31_0:UpdateBtnAvailableByActivityTime()
		end
	end)
end

function var_0_0.InitBackScene(arg_33_0)
	local var_33_0 = "UI/Common/BackgroundQuad"

	arg_33_0.backGround_ = manager.resourcePool:Get(var_33_0, ASSET_TYPE.SCENE)
	arg_33_0.backGroundTrs_ = arg_33_0.backGround_.transform

	arg_33_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_33_1 = GameDisplayCfg.multi_heart_demon_bg_pos.value

	arg_33_0.backGroundTrs_.localPosition = Vector3(var_33_1[1], var_33_1[2], var_33_1[3])
	arg_33_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_33_2 = GameDisplayCfg.multi_heart_demon_bg_pos.scale

	arg_33_0.backGroundTrs_.localScale = Vector3(var_33_2[1], var_33_2[2], var_33_2[3])
end

function var_0_0.DestroyBackScene(arg_34_0)
	if arg_34_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_34_0.backGround_, ASSET_TYPE.SCENE)

		arg_34_0.backGround_ = nil
	end
end

function var_0_0.UnloadModel(arg_35_0)
	if arg_35_0.bossModelList ~= nil then
		for iter_35_0 = 1, 3 do
			local var_35_0 = arg_35_0.bossModelList[iter_35_0]

			if not isNil(var_35_0) then
				manager.resourcePool:DestroyOrReturn(var_35_0, ASSET_TYPE.TPOSE)
			end

			manager.resourcePool:StopAsyncQuest(arg_35_0.loadList[iter_35_0])

			arg_35_0.currentBossTemplateID = nil
		end

		arg_35_0.bossModelList = nil
		arg_35_0.loadList = nil
	end
end

function var_0_0.LoadModel(arg_36_0)
	if arg_36_0.currentBossTemplateID == arg_36_0.cfg.id then
		return
	end

	arg_36_0:UnloadModel()

	arg_36_0.currentBossTemplateID = arg_36_0.cfg.id

	local var_36_0 = {
		"left",
		"middle",
		"right"
	}
	local var_36_1 = MultHeartDemonUICfg[arg_36_0.cfg.id]

	arg_36_0.loadList = {}
	arg_36_0.bossModelList = {}

	for iter_36_0 = 1, 3 do
		local var_36_2 = var_36_0[iter_36_0]
		local var_36_3 = "Char/" .. var_36_1["model_" .. var_36_2]

		arg_36_0.loadList[iter_36_0] = manager.resourcePool:AsyncLoad(var_36_3, ASSET_TYPE.TPOSE, function(arg_37_0)
			if arg_36_0.exitView_ or arg_36_0.currentBossTemplateID ~= arg_36_0.cfg.id then
				manager.resourcePool:DestroyOrReturn(arg_37_0, ASSET_TYPE.TPOSE)

				return
			end

			local var_37_0 = var_36_1["model_" .. var_36_2 .. "_pos"]
			local var_37_1 = var_36_1["model_" .. var_36_2 .. "_rot"]
			local var_37_2 = var_36_1["model_" .. var_36_2 .. "_scale"]

			arg_36_0.bossModelList[iter_36_0] = arg_37_0
			arg_37_0.transform.localPosition = Vector3(var_37_0[1], var_37_0[2], var_37_0[3])
			arg_37_0.transform.localEulerAngles = Vector3(var_37_1[1], var_37_1[2], var_37_1[3])
			arg_37_0.transform.localScale = Vector3(var_37_2[1], var_37_2[2], var_37_2[3])
		end)
	end
end

return var_0_0
