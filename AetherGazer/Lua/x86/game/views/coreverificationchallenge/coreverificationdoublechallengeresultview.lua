local var_0_0 = class("CoreVerificationDoubleChallengeResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Core_verification_ResultUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()

	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiList_, CoreVerificationChallengeAffixItemItem)
end

function var_0_0.IndexItem(arg_4_0, arg_4_1, arg_4_2)
	arg_4_2:RefreshUI(arg_4_0.buff_list[arg_4_1])
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.stageData = arg_5_0.params_.stageData
	arg_5_0.stageId = arg_5_0.stageData:GetStageId()
	arg_5_0.stageType = arg_5_0.stageData:GetType()
	arg_5_0.isMultiple = arg_5_0.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	arg_5_0:RenderView()
end

function var_0_0.OnExit(arg_6_0)
	var_0_0.super.OnExit(arg_6_0)
end

function var_0_0.Dispose(arg_7_0)
	if arg_7_0.scrollHelper_ then
		arg_7_0.scrollHelper_:Dispose()

		arg_7_0.scrollHelper_ = nil
	end

	arg_7_0:RemoveExpTween()

	for iter_7_0 = 1, 3 do
		arg_7_0.heroModule[iter_7_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.InitUI(arg_8_0)
	arg_8_0:BindCfgUI()

	arg_8_0.heroModule = {
		BattleSettlementHeroHeadModule.New(arg_8_0.heroHead1Obj_),
		BattleSettlementHeroHeadModule.New(arg_8_0.heroHead2Obj_),
		(BattleSettlementHeroHeadModule.New(arg_8_0.heroHead3Obj_))
	}
end

function var_0_0.AddListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.bgBtn_, nil, function()
		arg_9_0:CloseFunc()
	end)
	arg_9_0:AddBtnListener(arg_9_0.statisticsBtn_, nil, function()
		arg_9_0:GoToBattleStatistics()
	end)
end

function var_0_0.RenderView(arg_12_0)
	arg_12_0:RefreshMyExpS()
	arg_12_0:RefreshHeroS()
	arg_12_0:RenderCommonUI()
	arg_12_0:RefreshBattleTime()
	arg_12_0:RefreshChallegeUI()
end

function var_0_0.IndexItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_0.buff_list[arg_13_1])
end

function var_0_0.RefreshChallegeUI(arg_14_0)
	local var_14_0 = CoreVerificationChallengeData:GetChallengeStage()

	arg_14_0.buff_list = CoreVerificationChallengeData:GetSelectAffixs()

	local var_14_1 = arg_14_0.params_.stageData.serverTeamPlayer

	arg_14_0.playerNameText_.text = var_14_1.nick
	arg_14_0.curScoreText_.text = var_14_0.recently_challenge_value or 0

	local var_14_2 = CoreVerificationChallengeData:GetEfficiencyNum()

	arg_14_0.efficiencyScoreText_.text = var_14_2
	arg_14_0.scoreText_.text = var_14_0.max_challenge_value or 0
	arg_14_0.stageNameText_.text = GetI18NText(CoreVerificationClMode1Cfg[arg_14_0.stageId].stage_name)

	arg_14_0.scrollHelper_:StartScroll(#arg_14_0.buff_list)

	local var_14_3 = CoreVerificationChallengeTools.GetMaxIllustrated()

	arg_14_0.affixIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_14_3))
end

function var_0_0.RenderCommonUI(arg_15_0)
	local var_15_0 = true
	local var_15_1 = BattleStageTools.GetStageCfg(arg_15_0.stageType, arg_15_0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY

	SetActive(arg_15_0.statisticsBtn_.gameObject, var_15_1)
end

function var_0_0.RefreshBattleTime(arg_16_0)
	local var_16_0 = BattleStageTools.GetStageCfg(arg_16_0.stageType, arg_16_0.stageId)

	SetActive(arg_16_0.battleTimeText_.gameObject, var_16_0.tag ~= BattleConst.BATTLE_TAG.STORY)

	if var_16_0.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	arg_16_0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		arg_16_0:GetBattleTime() or "00"
	})
end

function var_0_0.RefreshHeroS(arg_17_0)
	local var_17_0, var_17_1 = arg_17_0.stageData:GetHeroTeam()
	local var_17_2 = arg_17_0.stageData:GetSystemHeroTeam()

	if var_17_0[2] == 0 then
		table.remove(var_17_0, 2)
		table.remove(var_17_1, 2)
		table.insert(var_17_0, 0)
		table.insert(var_17_1, 0)
	end

	local var_17_3 = arg_17_0.params_.battleResult.heroDataCollect

	for iter_17_0 = 1, 3 do
		if not var_17_0[iter_17_0] or var_17_0[iter_17_0] == 0 then
			arg_17_0.heroModule[iter_17_0]:SetHeroData(nil)
			arg_17_0.heroModule[iter_17_0]:ShowCaptain(false)
		else
			arg_17_0.heroModule[iter_17_0]:ShowCaptain(iter_17_0 == 1)

			local var_17_4 = arg_17_0.stageData:GetHeroDataByPos(iter_17_0)

			arg_17_0.heroModule[iter_17_0]:SetHeroData({
				id = var_17_4.id,
				using_skin = var_17_4.using_skin,
				star = var_17_4.star or 0
			})

			if var_17_3[iter_17_0] and arg_17_0:NeedAddExp() then
				arg_17_0.heroModule[iter_17_0]:PlayLevelUpTween(var_17_3[iter_17_0].oldLv, var_17_3[iter_17_0].newLv, var_17_3[iter_17_0].oldPersent, var_17_3[iter_17_0].newPersent, 2)
			else
				arg_17_0.heroModule[iter_17_0]:ShowLevel(var_17_4.level, 1)
			end
		end
	end
end

function var_0_0.RefreshMyExpS(arg_18_0)
	local var_18_0 = arg_18_0.stageData:GetAddUserExp() * arg_18_0.stageData:GetMultiple()
	local var_18_1 = arg_18_0.stageData:GetActivityID()
	local var_18_2 = arg_18_0.params_.battleResult.oldPlayerEXPInfo
	local var_18_3 = var_18_2.userLevel
	local var_18_4 = var_18_2.remain_exp
	local var_18_5 = ActivityData:GetActivityData(var_18_1)

	if var_18_1 ~= 0 and (not var_18_5 or not var_18_5:IsActivitying()) or not arg_18_0:NeedAddExp() then
		var_18_0 = 0
	end

	local var_18_6 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_18_7 = math.min(var_18_0, var_18_6 - var_18_2.total_exp)

	if var_18_7 < 0 then
		var_18_7 = 0
	end

	local var_18_8, var_18_9 = LvTools.CheckExp(var_18_3, var_18_4 + var_18_7, "user_level_exp")

	if var_18_3 > 30 and var_18_8 - var_18_3 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_18_4), tostring(var_18_7), tostring(var_18_3), tostring(var_18_8)))
	end

	arg_18_0.expTxt_.text = string.format("EXP+%d", var_18_7)

	if LvTools.GetIsMaxLv(var_18_8, "user") then
		arg_18_0.lvNumTxt_.text = "--/--"
	else
		arg_18_0.lvNumTxt_.text = table.concat({
			var_18_9,
			"/",
			GameLevelSetting[var_18_8].user_level_exp
		})
	end

	local var_18_10 = math.floor(var_18_4 / GameLevelSetting[var_18_3].user_level_exp * 1000) / 1000
	local var_18_11 = math.floor(var_18_9 / GameLevelSetting[var_18_8].user_level_exp * 1000) / 1000

	var_18_10 = var_18_10 > 0.99 and 0.99 or var_18_10
	var_18_11 = var_18_11 > 0.99 and 0.99 or var_18_11

	if var_18_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if var_18_3 == var_18_8 and math.abs(var_18_10 - var_18_11) < 0.0001 then
		arg_18_0:SetExpWithoutTween(var_18_8, var_18_11)
	else
		arg_18_0:StartExpTween(var_18_3, var_18_8, var_18_10, var_18_11)
	end
end

function var_0_0.RenderUserData(arg_19_0, arg_19_1)
	local var_19_0, var_19_1 = math.modf(arg_19_1)
	local var_19_2 = GameLevelSetting[var_19_0].user_level_exp

	arg_19_0.levelTxt_.text = string.format("%d", var_19_0)

	if LvTools.GetIsMaxLv(var_19_0, "user") then
		arg_19_0.expSlider_.value = 1
	else
		arg_19_0.expSlider_.value = var_19_1
	end
end

function var_0_0.RemoveExpTween(arg_20_0)
	if arg_20_0.expTween_ then
		arg_20_0.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_20_0.gameObject_)

		arg_20_0.expTween_ = nil
	end
end

function var_0_0.StartExpTween(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	arg_21_0:RemoveExpTween()

	local var_21_0 = -1

	arg_21_0.tween_ = LeanTween.value(arg_21_0.expSlider_.gameObject, arg_21_1 + arg_21_3, arg_21_2 + arg_21_4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_22_0)
		local var_22_0 = math.modf(arg_22_0)

		if var_21_0 == -1 then
			var_21_0 = var_22_0
		end

		if var_22_0 ~= var_21_0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_21_0 = var_22_0
		end

		arg_21_0:RenderUserData(arg_22_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_21_0:CheckLevelUp()
		arg_21_0:RemoveExpTween()
	end))
end

function var_0_0.SetExpWithoutTween(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0:RenderUserData(arg_24_1 + arg_24_2)
end

function var_0_0.GetPlayerInfo(arg_25_0)
	return PlayerData:GetPlayerInfo()
end

function var_0_0.GetBattleTime(arg_26_0)
	local var_26_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_26_0)
end

function var_0_0.CheckLevelUp(arg_27_0)
	local var_27_0 = arg_27_0:GetLevelUpInfoList()

	if #var_27_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_27_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_28_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.NeedAddExp(arg_29_0)
	return true
end

function var_0_0.GetRewardData(arg_30_0)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(arg_30_0.params_.rewardList) do
		table.insert(var_30_0, iter_30_1)
	end

	return var_30_0
end

function var_0_0.OnTop(arg_31_0)
	SetActive(arg_31_0.gameObject_, true)

	arg_31_0.toStat_ = false
end

function var_0_0.OnBehind(arg_32_0)
	if arg_32_0.toStat_ then
		SetActive(arg_32_0.gameObject_, false)
	end
end

function var_0_0.GoToBattleStatistics(arg_33_0)
	arg_33_0.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = arg_33_0.params_.stageData,
		battleTime = arg_33_0:GetBattleTime(),
		hasSnapshot_ = arg_33_0.hasSnapshot_
	})
end

function var_0_0.ShowVitalityBox(arg_34_0, arg_34_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_34_1)
	else
		arg_34_1()
	end
end

function var_0_0.ShowEquipBox(arg_35_0, arg_35_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_35_1)
	else
		arg_35_1()
	end
end

function var_0_0.CloseFunc(arg_36_0)
	OperationRecorder.Record(arg_36_0.class.__cname, "closeCombat")
	arg_36_0:ShowVitalityBox(function()
		arg_36_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_36_0.params_.stageData)
		end)
	end)
end

return var_0_0
