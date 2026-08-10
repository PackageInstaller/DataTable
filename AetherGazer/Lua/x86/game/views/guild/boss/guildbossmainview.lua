local var_0_0 = class("GuildBossMainView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club_boss/ClubBossmain"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.indexController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "index")
	arg_5_0.difficultyController_ = ControllerUtil.GetController(arg_5_0.difficultyBtn_.transform, "difficulty")
	arg_5_0.lockedController_ = ControllerUtil.GetController(arg_5_0.difficultyBtn_.transform, "locked")
	arg_5_0.checkedController_ = ControllerUtil.GetController(arg_5_0.firstBonusBtn_.transform, "checked")
	arg_5_0.statusController_ = ControllerUtil.GetController(arg_5_0.gameObject_.transform, "status")
	arg_5_0.nameList_ = {
		arg_5_0.nameLabel1_,
		arg_5_0.nameLabel2_,
		arg_5_0.nameLabel3_,
		arg_5_0.nameLabel4_,
		arg_5_0.nameLabel5_
	}
	arg_5_0.btnList_ = {
		arg_5_0.challengeBtn1_,
		arg_5_0.challengeBtn2_,
		arg_5_0.challengeBtn3_,
		arg_5_0.challengeBtn4_,
		arg_5_0.challengeBtn5_
	}
	arg_5_0.progressBarList_ = {
		arg_5_0.progressBar1_,
		arg_5_0.progressBar2_,
		arg_5_0.progressBar3_,
		arg_5_0.progressBar4_,
		arg_5_0.progressBar5_
	}
	arg_5_0.progressLabelList_ = {
		arg_5_0.progressLabel1_,
		arg_5_0.progressLabel2_,
		arg_5_0.progressLabel3_,
		arg_5_0.progressLabel4_,
		arg_5_0.progressLabel5_
	}
	arg_5_0.lockedBtnList_ = {
		arg_5_0.lockedBtn1_,
		arg_5_0.lockedBtn2_,
		arg_5_0.lockedBtn3_,
		arg_5_0.lockedBtn4_,
		arg_5_0.lockedBtn5_
	}
	arg_5_0.affixList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.buffListGo_, AffixItemView)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.haveGetBuffList_[arg_6_1])
end

function var_0_0.AddUIListener(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.lockedBtnList_) do
		arg_7_0:AddBtnListener(iter_7_1, nil, function()
			ShowTips("CLUB_BOSS_PREPOSE_FINISH_TIP")
		end)
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.btnList_) do
		arg_7_0:AddBtnListener(iter_7_3, nil, function()
			arg_7_0:EnterLevel(iter_7_2)
		end)
	end

	arg_7_0:AddBtnListener(arg_7_0.bgBtn_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)

		if arg_7_0:IsOpenSectionView() then
			JumpTools.Back()
			arg_7_0.indexController_:SetSelectedIndex(0)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.bossBtn_, nil, function()
		JumpTools.OpenPageByJump("/guildBossChallenge", {})
	end)
	arg_7_0:AddBtnListener(arg_7_0.firstBonusBtn_, nil, function()
		if GuildData:CanGetBonus() then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 3, 1)

			return
		end

		local var_12_0 = ClubBossPreposeCfg[1].personal_reward

		JumpTools.OpenPageByJump("rewardPreview", {
			rewardList = var_12_0
		}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
	arg_7_0:AddBtnListener(arg_7_0.difficultyBtn_, nil, function()
		if not GuildData:IsCaptainOrDeputy() then
			ShowTips("CLUB_BOSS_DIFFICULTY_CANT_TIP")

			return
		end

		local var_13_0, var_13_1 = GuildData:GetLastTime()

		arg_7_0.statusController_:SetSelectedState(var_13_0)

		if var_13_0 == "challenge" then
			ShowTips("CLUB_BOSS_DIFFICULTY_EXPIRED_TIP")

			return
		end

		JumpTools.OpenPageByJump("guildDifficultChose", {})
	end)
	arg_7_0:AddBtnListener(arg_7_0.helpSettingBtn_, nil, function()
		JumpTools.OpenPageByJump("/guildBossSetAssistant", {
			canUseMultiMode = false,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT
		})
	end)
	arg_7_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		if arg_7_0:IsOpenSectionView() then
			JumpTools.Back()
		end

		arg_7_0.drag_ = true
	end))
	arg_7_0.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		arg_7_0.drag_ = false
	end))
end

function var_0_0.AddEventListeners(arg_17_0)
	arg_17_0:RegistEventListener(GUILD_BOSS_INIT, function()
		arg_17_0.haveGetBuffList_ = GuildData:GetHaveGetBossBuffList()
		arg_17_0.stageDataList_ = GuildData:GetPreInfoList()

		arg_17_0:UpdateView()
	end)
	arg_17_0:RegistEventListener(GUILD_BOSS_BONUS_GET, function()
		arg_17_0:UpdateFirstBonusCheck()
	end)
	arg_17_0:RegistEventListener(GUILD_EXIT, function()
		arg_17_0:Go("/home")
	end)
	arg_17_0:RegistEventListener(GUILD_BOSS_DIFFICULTY_CHANGE, function()
		arg_17_0:UpdateView()
	end)
end

function var_0_0.EnterLevel(arg_22_0, arg_22_1)
	arg_22_0.indexController_:SetSelectedIndex(arg_22_1)

	local var_22_0 = arg_22_0.stageDataList_[arg_22_1].stage_id

	JumpTools.OpenPageByJump("guildBossSectionInfo", {
		index = arg_22_1,
		section = var_22_0,
		sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE,
		activityId = arg_22_0.params_.activityId,
		preData = arg_22_0.stageDataList_[arg_22_1]
	})
end

function var_0_0.OnTop(arg_23_0)
	arg_23_0:UpdateBar()
	arg_23_0.indexController_:SetSelectedIndex(0)
end

function var_0_0.OnBehind(arg_24_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_25_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function var_0_0.OnEnter(arg_26_0)
	arg_26_0:AddEventListeners()
	GuildAction.RequestClubBossInfo(GuildData:GetGuildInfo().id)
	saveData("guild_boss", "prepose", 0)
	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)
	manager.redPoint:bindUIandKey(arg_26_0.bossRedPointContainer_, RedPointConst.GUILD_BOSS_BOSS_BTN, {
		x = 0,
		y = 0
	})
	GuildAction.GetAssistBriefInfo(GuildData:GetGuildInfo().id)
	arg_26_0:AddGuildBossTimer()

	if arg_26_0.params_.isEnter then
		arg_26_0.animator_:Play("ClubBossmain", -1, 0)

		arg_26_0.animator_.speed = 1
	else
		local var_26_0 = arg_26_0.animator_:GetCurrentAnimatorClipInfo(0)

		arg_26_0.animator_:Play(var_26_0[0].clip.name, 0, var_26_0[0].clip.length)

		arg_26_0.animator_.speed = 0
	end

	arg_26_0.params_.isEnter = nil
end

function var_0_0.OnExit(arg_27_0)
	manager.redPoint:unbindUIandKey(arg_27_0.bossRedPointContainer_, RedPointConst.GUILD_BOSS_BOSS_BTN)
	arg_27_0:RemoveAllEventListener()
	arg_27_0:StopGuildBossTimer()
	manager.windowBar:HideBar()
end

function var_0_0.UpdateView(arg_28_0)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0.stageDataList_) do
		arg_28_0.nameList_[iter_28_0].text = GetI18NText(ClubBossPreposeCfg[iter_28_0].name)

		local var_28_0 = ClubBossPreposeCfg[iter_28_0].point_max
		local var_28_1 = iter_28_1.score
		local var_28_2 = math.min(var_28_1, var_28_0)

		arg_28_0.progressBarList_[iter_28_0].fillAmount = var_28_2 / var_28_0

		local var_28_3 = 100 * var_28_2 / var_28_0

		arg_28_0.progressLabelList_[iter_28_0].text = string.format("%d", var_28_3)
	end

	arg_28_0.affixList_:StartScroll(#arg_28_0.haveGetBuffList_)

	arg_28_0.timeLabel_.text = string.format("%d/%d", GuildData:GetBossLastTime(), GameSetting.club_boss_prepose_max.value[1])

	local var_28_4 = GuildData:GetBossDifficulty()

	arg_28_0.difficultyText_.text = GetTips("CLUB_BOSS_DIFFICULTY_" .. GetI18NText(var_28_4))

	arg_28_0:UpdateGuildBossTimer()
	arg_28_0:UpdateFirstBonusCheck()
end

function var_0_0.UpdateFirstBonusCheck(arg_29_0)
	if GuildData:IsGetFirstBossBonus() then
		arg_29_0.checkedController_:SetSelectedState("true")
	elseif GuildData:CanGetBonus() then
		arg_29_0.checkedController_:SetSelectedState("canGet")
	else
		arg_29_0.checkedController_:SetSelectedState("false")
	end
end

function var_0_0.OnMainHomeViewTop(arg_30_0)
	return
end

function var_0_0.IsOpenSectionView(arg_31_0)
	return arg_31_0:IsOpenRoute("guildBossSectionInfo")
end

function var_0_0.UpdateGuildBossTimer(arg_32_0)
	local var_32_0, var_32_1 = GuildData:GetLastTime()

	arg_32_0.statusController_:SetSelectedState(var_32_0)

	if var_32_0 == "prepose" then
		arg_32_0.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
		arg_32_0.openTimeText_.text = GetTips("GONGHUIBOSS_LIEXIZHENGZHAO")
		arg_32_0.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_32_1)

		arg_32_0.lockedController_:SetSelectedState("false")
	else
		arg_32_0.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
		arg_32_0.openTimeText_.text = GetTips("GONGHUIBOSS_LIEXIKAIFANG")
		arg_32_0.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_32_1)

		arg_32_0.lockedController_:SetSelectedState(GuildData:IsCaptainOrDeputy() and "true" or "false")
	end
end

function var_0_0.AddGuildBossTimer(arg_33_0)
	if arg_33_0.guildBossTimer_ == nil then
		arg_33_0.guildBossTimer_ = Timer.New(function()
			arg_33_0:UpdateGuildBossTimer()
		end, 1, -1)
	end

	arg_33_0.guildBossTimer_:Start()
end

function var_0_0.StopGuildBossTimer(arg_35_0)
	if arg_35_0.guildBossTimer_ then
		arg_35_0.guildBossTimer_:Stop()

		arg_35_0.guildBossTimer_ = nil
	end
end

function var_0_0.Dispose(arg_36_0)
	if arg_36_0.affixList_ then
		arg_36_0.affixList_:Dispose()

		arg_36_0.affixList_ = nil
	end

	if arg_36_0.payTimer_ ~= nil then
		arg_36_0.payTimer_:Stop()

		arg_36_0.payTimer_ = nil
	end

	var_0_0.super.Dispose(arg_36_0)
end

return var_0_0
