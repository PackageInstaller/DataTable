local var_0_0 = class("MultHeartDemonCombineView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Resident/Acitvity_SoloHeartDemon/SoloHeartDemon_VSUI"
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

	arg_4_0.controller = arg_4_0.controller_:GetController("defen")
	arg_4_0.difficultController = arg_4_0.controller_:GetController("difficult")
	arg_4_0.itemList = {}
	arg_4_0.leftBtnList_ = {}

	for iter_4_0 = 1, 6 do
		arg_4_0.leftBtnList_[iter_4_0] = MultHeartDemonCombatItem.New(arg_4_0["item" .. iter_4_0 .. "Go_"])
	end
end

function var_0_0.GetPlayerAndAIIndex(arg_5_0)
	local var_5_0 = 1
	local var_5_1 = 1

	for iter_5_0 = 1, 3 do
		if arg_5_0.heroList[iter_5_0] == nil or arg_5_0.heroList[iter_5_0] == 0 or arg_5_0.data.heroHPList and arg_5_0.data.heroHPList[arg_5_0.heroList[iter_5_0]] == 0 then
			var_5_0 = var_5_0 + 1
		end

		if arg_5_0.data.heroHPList and arg_5_0.data.heroHPList[arg_5_0.cfg.heart_damon_id[iter_5_0]] == 0 then
			var_5_1 = var_5_1 + 1
		end
	end

	return var_5_0, var_5_1
end

function var_0_0.IsInChallengeTime(arg_6_0)
	local var_6_0 = ActivityData:GetActivityRefreshTime(arg_6_0.activityId)

	return ActivityData:GetActivityIsOpen(arg_6_0.activityId) and var_6_0 > manager.time:GetServerTime()
end

function var_0_0.AddUIListener(arg_7_0)
	local var_7_0 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)

	local function var_7_1()
		if not arg_7_0:IsInChallengeTime() then
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")

			return
		end

		if not arg_7_0.heroList[1] or not arg_7_0.heroList[2] or not arg_7_0.heroList[3] then
			ShowTips("MULTI_HEART_DEMON_HERO_NOT_ENOUGH")

			return
		end

		local var_8_0, var_8_1 = arg_7_0:GetPlayerAndAIIndex()

		if var_8_0 == 4 then
			return
		end

		local var_8_2 = arg_7_0.cfg.stage_id[arg_7_0.difficult][2][var_8_1]
		local var_8_3 = BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.MULT_HEART_DEMON, var_8_2, {
			activityID = arg_7_0.activityId,
			heroID = arg_7_0.heroList[var_8_0],
			difficult = arg_7_0.difficult
		})
		local var_8_4

		if arg_7_0.isLock == false then
			local var_8_5 = {}

			for iter_8_0, iter_8_1 in ipairs(var_8_3.data.heroIdList) do
				local var_8_6 = HeroStandardSystemCfg[iter_8_1]
				local var_8_7
				local var_8_8

				if var_8_6 then
					var_8_7 = MultHeartDemonData:GetDataByPara("trialProxy")
					var_8_8 = var_8_6.hero_id
				else
					var_8_7 = var_7_0
					var_8_8 = iter_8_1
				end

				local var_8_9 = var_8_7:GetHeroAllAttribute(var_8_8)

				var_8_5[iter_8_0] = {
					hero_id = iter_8_1,
					hero_max_hp = var_8_9[HeroConst.HERO_ATTRIBUTE.STA]
				}
			end

			var_8_4 = MultHeartDemonAction.SaveTeam({
				activity_id = arg_7_0.activityId,
				hero_id_list = arg_7_0.heroList,
				difficulty = arg_7_0.difficult,
				hero_max_hp = var_8_5
			})
		else
			var_8_4 = deferred.new(function(arg_9_0)
				arg_9_0:resolve({
					result = TipsCfg.get_id_list_by_define.SUCCESS
				})
			end)
		end

		var_8_4:next(function(arg_10_0)
			if isSuccess(arg_10_0.result) then
				BattleController.GetInstance():LaunchBattle(var_8_3, nil, function()
					MultHeartDemonAction.SendDataToServer({
						stage_id = var_8_2,
						boss_hp_rate = BattleMultiHeartDemonCfg[var_8_2].attribute_factor[3]
					})
				end)
			end
		end)
	end

	arg_7_0:AddBtnListener(arg_7_0.infoBtn_, nil, function()
		JumpTools.GoToSystem("/multHeartDemonReport", {
			activityId = arg_7_0.activityId,
			difficult = arg_7_0.difficult,
			data = arg_7_0.data
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.giveUpBtn_, nil, function()
		if arg_7_0:IsInChallengeTime() then
			ShowMessageBox({
				isTop = true,
				content = GetTips("MULTI_HEART_DEMON_GIVE_UP_CONFIRM_TIPS"),
				OkCallback = function()
					MultHeartDemonAction.Reset({
						difficulty = arg_7_0.difficult,
						activity_id = arg_7_0.activityId
					})
				end
			})
		else
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.overBtn_, nil, function()
		if arg_7_0:IsInChallengeTime() then
			MultHeartDemonAction.ResetPromise({
				difficulty = arg_7_0.difficult,
				activity_id = arg_7_0.activityId
			}):next(function(arg_16_0)
				if arg_16_0 then
					arg_7_0.Back()
				end
			end)
		else
			ShowTips("MULTI_HEART_DEMON_REFRESH_TIPS")
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.fightBtn_, nil, var_7_1)
	arg_7_0:AddBtnListener(arg_7_0.fight2Btn_, nil, var_7_1)
end

function var_0_0.UpdateView(arg_17_0)
	if arg_17_0.params_.isMain then
		arg_17_0.params_.isMain = false
		arg_17_0.animator_.enabled = true
	else
		arg_17_0.animator_.enabled = false
	end

	local var_17_0 = arg_17_0.isLock and MultHeartDemonData:CheckDifficultyCanEnter(arg_17_0.difficult)

	arg_17_0:RefreshHeroList()

	arg_17_0.titleTxt_.text = GetTips(arg_17_0.difficult == 1 and "MULTI_HEART_DEMON_STAGE_EASY_NAME" or "MULTI_HEART_DEMON_STAGE_HARD_NAME")

	arg_17_0:UpdateScore()
	SetActive(arg_17_0.giveUpBtn_, false)

	if arg_17_0.isLock then
		SetActive(arg_17_0.giveUpBtn_, true)
	end

	SetActive(arg_17_0.infoBtn_.gameObject, arg_17_0.isLock == true)
	SetActive(arg_17_0.overBtn_.gameObject, var_17_0)

	arg_17_0.rawImage1_.color = arg_17_0.difficult == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)
	arg_17_0.rawImage3_.color = arg_17_0.difficult == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)
	arg_17_0.rawImage2_.color = arg_17_0.difficult == 1 and Color(0.266, 0.403, 0.607) or Color(0.509, 0.38, 1)

	SetActive(arg_17_0.fightBtn_.gameObject, arg_17_0.difficult == 1)
	SetActive(arg_17_0.fight2Btn_.gameObject, arg_17_0.difficult == 2)

	arg_17_0.fight1Txt_.text = GetTips(arg_17_0.isLock and "POLYHEDRON_LOBBY_BUTTON_CONTINUE" or "ACTIVITY_HERO_ENHANCE_BUTTON_BEGIN")
	arg_17_0.fight2Txt_.text = GetTips(arg_17_0.isLock and "POLYHEDRON_LOBBY_BUTTON_CONTINUE" or "ACTIVITY_HERO_ENHANCE_BUTTON_BEGIN")

	arg_17_0.difficultController:SetSelectedState(arg_17_0.difficult == 1 and "normal" or "hard")

	if var_17_0 then
		SetActive(arg_17_0.giveUpBtn_, false)
		SetActive(arg_17_0.fightBtn_.gameObject, false)
		SetActive(arg_17_0.fight2Btn_.gameObject, false)
	end
end

local function var_0_1(arg_18_0, arg_18_1)
	if arg_18_0 == nil then
		return 0
	end

	local var_18_0 = 0

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		var_18_0 = var_18_0 + (nullable(arg_18_1, iter_18_1) or 100)
	end

	return GameSetting.multi_heart_demon_hpscore.value[1] * var_18_0 / 100
end

function var_0_0.UpdateScore(arg_19_0)
	local var_19_0 = 0

	if arg_19_0.isLock then
		arg_19_0.controller:SetSelectedState("state1")

		for iter_19_0, iter_19_1 in pairs(arg_19_0.data.stageData or {}) do
			var_19_0 = var_19_0 + iter_19_1.maxScore
		end

		if MultHeartDemonData:CheckDifficultyCanEnter(arg_19_0.difficult) then
			local var_19_1 = var_0_1(arg_19_0.data.heroIdList, arg_19_0.data.heroHPList)

			arg_19_0.maxScoreTxt_.text = GetTipsF("MULTI_HEART_DEMON_TOTAL_SCORE_2", var_19_0 + var_19_1, var_19_0, var_19_1)
		else
			arg_19_0.maxScoreTxt_.text = var_19_0
		end
	else
		arg_19_0.controller:SetSelectedState("state0")

		local var_19_2 = nullable(MultHeartDemonData:GetDataByPara("maxScore"), arg_19_0.difficult) or 0

		arg_19_0.allTxt_.text = var_19_2
	end
end

function var_0_0.OnEnter(arg_20_0)
	arg_20_0:UpdateData()
	arg_20_0:UpdateView()
	arg_20_0:CheckIsOver()
end

function var_0_0.CheckIsOver(arg_21_0)
	if arg_21_0.params_.isOver then
		arg_21_0.params_.isOver = nil

		if MultHeartDemonData:CheckDifficultyCanEnter(arg_21_0.difficult) then
			SetActive(arg_21_0.overBtn_.gameObject, true)
			TimeTools.StartAfterSeconds(1, function()
				JumpTools.OpenPageByJump("MultHeartDemonOver")
			end, {})
		end
	end
end

function var_0_0.UpdateData(arg_23_0)
	arg_23_0.activityId = MultHeartDemonData:GetDataByPara("activityId")
	arg_23_0.isLock = MultHeartDemonData:GetDataByPara("isLock") or false
	arg_23_0.difficult = arg_23_0.params_.difficult
	arg_23_0.cfg = MultHeartDemonCfg[MultHeartDemonCfg.get_id_list_by_activity_id[arg_23_0.activityId][1]]
	arg_23_0.data = MultHeartDemonData:GetDataByPara("difficultyData")

	if arg_23_0.data then
		arg_23_0.data = arg_23_0.data[arg_23_0.difficult] or {}
	end

	arg_23_0.heroList = arg_23_0.data.heroIdList or {}
end

function var_0_0.OnMultDemonHeartSaveTeam(arg_24_0)
	arg_24_0:UpdateData()
	arg_24_0:UpdateView()
end

function var_0_0.OnMultDemonHeartUpdate(arg_25_0)
	arg_25_0:UpdateData()
	arg_25_0:UpdateView()
end

function var_0_0.OnExit(arg_26_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_27_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("MULTI_HEART_DEMON_GAMEPLAY_DESC")
end

function var_0_0.RefreshHeroList(arg_28_0)
	local var_28_0, var_28_1 = arg_28_0:GetPlayerAndAIIndex()
	local var_28_2 = arg_28_0.cfg.stage_id[arg_28_0.difficult][2][var_28_1]

	for iter_28_0, iter_28_1 in pairs(arg_28_0.leftBtnList_) do
		iter_28_1:SetData(arg_28_0.data, iter_28_0, arg_28_0.heroList, arg_28_0.cfg, arg_28_0.difficult, arg_28_0.activityId, var_28_0, var_28_1, var_28_2, handler(arg_28_0, arg_28_0.ClickFunction), handler(arg_28_0, arg_28_0.ClickSwapFunction))
	end
end

function var_0_0.ClickFunction(arg_29_0, arg_29_1)
	if arg_29_1 == arg_29_0.swapIndex then
		arg_29_0.swapIndex = nil

		arg_29_0:RefreshHeroList()
	else
		arg_29_0.swapIndex = arg_29_1

		local var_29_0 = arg_29_0.leftBtnList_[arg_29_1]:IsEmptySlot()

		for iter_29_0 = 1, 3 do
			local var_29_1 = var_29_0 and arg_29_0.leftBtnList_[iter_29_0]:IsEmptySlot()

			arg_29_0.leftBtnList_[iter_29_0]:SetSwapEnabled(iter_29_0 ~= arg_29_0.swapIndex and not var_29_1)
			arg_29_0.leftBtnList_[iter_29_0]:SetHighlighted(iter_29_0 == arg_29_0.swapIndex)
		end
	end
end

function var_0_0.ClickSwapFunction(arg_30_0, arg_30_1)
	if arg_30_0.swapIndex == nil or arg_30_0.swapIndex == arg_30_1 then
		return
	end

	arg_30_0.heroList[arg_30_1], arg_30_0.heroList[arg_30_0.swapIndex] = arg_30_0.heroList[arg_30_0.swapIndex], arg_30_0.heroList[arg_30_1]

	local var_30_0 = MultHeartDemonData:GetDataByPara("heroTempData")[arg_30_0.difficult]

	var_30_0[arg_30_1], var_30_0[arg_30_0.swapIndex] = var_30_0[arg_30_0.swapIndex], var_30_0[arg_30_1]
	arg_30_0.swapIndex = nil

	arg_30_0:RefreshHeroList()
end

function var_0_0.Dispose(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.leftBtnList_) do
		iter_31_1:Dispose()
	end

	arg_31_0.leftBtnList_ = nil

	var_0_0.super.Dispose(arg_31_0)
	Object.Destroy(arg_31_0.gameObject_)
end

return var_0_0
