local var_0_0 = class("CoreVerificationDoubleChallengeResultViewMode3", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Core_verification_new/Mode3/Core_verification_ResultUI03"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddListener()
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.stageData = arg_4_0.params_.stageData
	arg_4_0.stageId = arg_4_0.stageData:GetStageId()
	arg_4_0.stageType = arg_4_0.stageData:GetType()
	arg_4_0.isMultiple = arg_4_0.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	arg_4_0:RenderView()
end

function var_0_0.OnExit(arg_5_0)
	var_0_0.super.OnExit(arg_5_0)
end

function var_0_0.Dispose(arg_6_0)
	if arg_6_0.scrollHelper_ then
		arg_6_0.scrollHelper_:Dispose()

		arg_6_0.scrollHelper_ = nil
	end

	arg_6_0:RemoveExpTween()

	for iter_6_0 = 1, 3 do
		arg_6_0.heroModule[iter_6_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.InitUI(arg_7_0)
	arg_7_0:BindCfgUI()

	arg_7_0.heroModule = {
		BattleSettlementHeroHeadModule.New(arg_7_0.heroHead1Obj_),
		BattleSettlementHeroHeadModule.New(arg_7_0.heroHead2Obj_),
		(BattleSettlementHeroHeadModule.New(arg_7_0.heroHead3Obj_))
	}
end

function var_0_0.AddListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		arg_8_0:CloseFunc()
	end)
	arg_8_0:AddBtnListener(arg_8_0.statisticsBtn_, nil, function()
		arg_8_0:GoToBattleStatistics()
	end)
end

function var_0_0.RenderView(arg_11_0)
	arg_11_0:RefreshMyExpS()
	arg_11_0:RefreshHeroS()
	arg_11_0:RenderCommonUI()
	arg_11_0:RefreshBattleTime()
	arg_11_0:RefreshChallegeUI()
end

function var_0_0.RefreshChallegeUI(arg_12_0)
	local var_12_0 = CoreVerificationChallengeMode3Data:GetChallengeStage()
	local var_12_1 = arg_12_0.params_.stageData.serverTeamPlayer

	arg_12_0.playerNameText_.text = var_12_1.nick
	arg_12_0.curScoreText_.text = var_12_0.recently_challenge_value or 0
	arg_12_0.scoreText_.text = CoreVerificationChallengeMode3Data:GetMaxPoint()
	arg_12_0.stageNameText_.text = GetI18NText(CoreVerificationClMode3Cfg[arg_12_0.stageId].stage_name)

	local var_12_2 = CoreVerificationChallengeTools.GetMaxIllustrated()

	arg_12_0.affixIcon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", "TextureConfig/Core_verification_new/Emblem/", var_12_2))
end

function var_0_0.RenderCommonUI(arg_13_0)
	local var_13_0 = true
	local var_13_1 = BattleStageTools.GetStageCfg(arg_13_0.stageType, arg_13_0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY

	SetActive(arg_13_0.statisticsBtn_.gameObject, var_13_1)
end

function var_0_0.RefreshBattleTime(arg_14_0)
	local var_14_0 = BattleStageTools.GetStageCfg(arg_14_0.stageType, arg_14_0.stageId)

	SetActive(arg_14_0.battleTimeText_.gameObject, var_14_0.tag ~= BattleConst.BATTLE_TAG.STORY)

	if var_14_0.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	arg_14_0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		arg_14_0:GetBattleTime() or "00"
	})
end

function var_0_0.RefreshHeroS(arg_15_0)
	local var_15_0, var_15_1 = arg_15_0.stageData:GetHeroTeam()
	local var_15_2 = arg_15_0.stageData:GetSystemHeroTeam()

	if var_15_0[2] == 0 then
		table.remove(var_15_0, 2)
		table.remove(var_15_1, 2)
		table.insert(var_15_0, 0)
		table.insert(var_15_1, 0)
	end

	local var_15_3 = arg_15_0.params_.battleResult.heroDataCollect

	for iter_15_0 = 1, 3 do
		if not var_15_0[iter_15_0] or var_15_0[iter_15_0] == 0 then
			arg_15_0.heroModule[iter_15_0]:SetHeroData(nil)
			arg_15_0.heroModule[iter_15_0]:ShowCaptain(false)
		else
			arg_15_0.heroModule[iter_15_0]:ShowCaptain(iter_15_0 == 1)

			local var_15_4 = arg_15_0.stageData:GetHeroDataByPos(iter_15_0)

			arg_15_0.heroModule[iter_15_0]:SetHeroData({
				id = var_15_4.id,
				using_skin = var_15_4.using_skin,
				star = var_15_4.star or 0
			})

			if var_15_3[iter_15_0] and arg_15_0:NeedAddExp() then
				arg_15_0.heroModule[iter_15_0]:PlayLevelUpTween(var_15_3[iter_15_0].oldLv, var_15_3[iter_15_0].newLv, var_15_3[iter_15_0].oldPersent, var_15_3[iter_15_0].newPersent, 2)
			else
				arg_15_0.heroModule[iter_15_0]:ShowLevel(var_15_4.level, 1)
			end
		end
	end
end

function var_0_0.RefreshMyExpS(arg_16_0)
	local var_16_0 = arg_16_0.stageData:GetAddUserExp() * arg_16_0.stageData:GetMultiple()
	local var_16_1 = arg_16_0.stageData:GetActivityID()
	local var_16_2 = arg_16_0.params_.battleResult.oldPlayerEXPInfo
	local var_16_3 = var_16_2.userLevel
	local var_16_4 = var_16_2.remain_exp
	local var_16_5 = ActivityData:GetActivityData(var_16_1)

	if var_16_1 ~= 0 and (not var_16_5 or not var_16_5:IsActivitying()) or not arg_16_0:NeedAddExp() then
		var_16_0 = 0
	end

	local var_16_6 = LvTools.GetMaxTotalExp("user_level_exp")
	local var_16_7 = math.min(var_16_0, var_16_6 - var_16_2.total_exp)

	if var_16_7 < 0 then
		var_16_7 = 0
	end

	local var_16_8, var_16_9 = LvTools.CheckExp(var_16_3, var_16_4 + var_16_7, "user_level_exp")

	if var_16_3 > 30 and var_16_8 - var_16_3 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(var_16_4), tostring(var_16_7), tostring(var_16_3), tostring(var_16_8)))
	end

	arg_16_0.expTxt_.text = string.format("EXP+%d", var_16_7)

	if LvTools.GetIsMaxLv(var_16_8, "user") then
		arg_16_0.lvNumTxt_.text = "--/--"
	else
		arg_16_0.lvNumTxt_.text = table.concat({
			var_16_9,
			"/",
			GameLevelSetting[var_16_8].user_level_exp
		})
	end

	local var_16_10 = math.floor(var_16_4 / GameLevelSetting[var_16_3].user_level_exp * 1000) / 1000
	local var_16_11 = math.floor(var_16_9 / GameLevelSetting[var_16_8].user_level_exp * 1000) / 1000

	var_16_10 = var_16_10 > 0.99 and 0.99 or var_16_10
	var_16_11 = var_16_11 > 0.99 and 0.99 or var_16_11

	if var_16_0 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if var_16_3 == var_16_8 and math.abs(var_16_10 - var_16_11) < 0.0001 then
		arg_16_0:SetExpWithoutTween(var_16_8, var_16_11)
	else
		arg_16_0:StartExpTween(var_16_3, var_16_8, var_16_10, var_16_11)
	end
end

function var_0_0.RenderUserData(arg_17_0, arg_17_1)
	local var_17_0, var_17_1 = math.modf(arg_17_1)
	local var_17_2 = GameLevelSetting[var_17_0].user_level_exp

	arg_17_0.levelTxt_.text = string.format("%d", var_17_0)

	if LvTools.GetIsMaxLv(var_17_0, "user") then
		arg_17_0.expSlider_.value = 1
	else
		arg_17_0.expSlider_.value = var_17_1
	end
end

function var_0_0.RemoveExpTween(arg_18_0)
	if arg_18_0.expTween_ then
		arg_18_0.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(arg_18_0.gameObject_)

		arg_18_0.expTween_ = nil
	end
end

function var_0_0.StartExpTween(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_0:RemoveExpTween()

	local var_19_0 = -1

	arg_19_0.tween_ = LeanTween.value(arg_19_0.expSlider_.gameObject, arg_19_1 + arg_19_3, arg_19_2 + arg_19_4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
		local var_20_0 = math.modf(arg_20_0)

		if var_19_0 == -1 then
			var_19_0 = var_20_0
		end

		if var_20_0 ~= var_19_0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			var_19_0 = var_20_0
		end

		arg_19_0:RenderUserData(arg_20_0)
	end)):setOnComplete(LuaHelper.VoidAction(function()
		arg_19_0:CheckLevelUp()
		arg_19_0:RemoveExpTween()
	end))
end

function var_0_0.SetExpWithoutTween(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:RenderUserData(arg_22_1 + arg_22_2)
end

function var_0_0.GetPlayerInfo(arg_23_0)
	return PlayerData:GetPlayerInfo()
end

function var_0_0.GetBattleTime(arg_24_0)
	local var_24_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

	return manager.time:DescCdTime2(var_24_0)
end

function var_0_0.CheckLevelUp(arg_25_0)
	local var_25_0 = arg_25_0:GetLevelUpInfoList()

	if #var_25_0 > 0 then
		PlayerAction.LevelUpFinish()
		JumpTools.OpenPageByJump("levelUp", {
			levelUpInfoList = var_25_0
		})
	end
end

function var_0_0.GetLevelUpInfoList(arg_26_0)
	return PlayerData:GetlevelUpInfos()
end

function var_0_0.NeedAddExp(arg_27_0)
	return true
end

function var_0_0.GetRewardData(arg_28_0)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_0.params_.rewardList) do
		table.insert(var_28_0, iter_28_1)
	end

	return var_28_0
end

function var_0_0.OnTop(arg_29_0)
	SetActive(arg_29_0.gameObject_, true)

	arg_29_0.toStat_ = false
end

function var_0_0.OnBehind(arg_30_0)
	if arg_30_0.toStat_ then
		SetActive(arg_30_0.gameObject_, false)
	end
end

function var_0_0.GoToBattleStatistics(arg_31_0)
	arg_31_0.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = arg_31_0.params_.stageData,
		battleTime = arg_31_0:GetBattleTime(),
		hasSnapshot_ = arg_31_0.hasSnapshot_
	})
end

function var_0_0.ShowVitalityBox(arg_32_0, arg_32_1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(arg_32_1)
	else
		arg_32_1()
	end
end

function var_0_0.ShowEquipBox(arg_33_0, arg_33_1)
	if needShowBagFullBox() then
		showEquipSendMail(arg_33_1)
	else
		arg_33_1()
	end
end

function var_0_0.CloseFunc(arg_34_0)
	OperationRecorder.Record(arg_34_0.class.__cname, "closeCombat")
	arg_34_0:ShowVitalityBox(function()
		arg_34_0:ShowEquipBox(function()
			BattleInstance.QuitBattle(arg_34_0.params_.stageData)
		end)
	end)
end

return var_0_0
