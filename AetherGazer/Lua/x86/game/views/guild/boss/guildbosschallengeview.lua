local var_0_0 = class("GuildBossChallengeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Club_boss/ClubBossChallengeUI"
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

	arg_5_0.statusController_ = ControllerUtil.GetController(arg_5_0.titleGo_.transform, "status")
	arg_5_0.bonusLockController_ = ControllerUtil.GetController(arg_5_0.bonusLockGo_.transform, "bonusLock")
	arg_5_0.btnOpenController_ = ControllerUtil.GetController(arg_5_0.prepareBtn_.transform, "btnOpen")
	arg_5_0.difficultyController_ = ControllerUtil.GetController(arg_5_0.difficultyGo_.transform, "difficulty")
	arg_5_0.bonusList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexBonusItem), arg_5_0.bonusListGo_, GuildBossChallengeRewardItemView)
	arg_5_0.buffList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexAffixItem), arg_5_0.buffListGo_, AffixItemView)
	arg_5_0.avatarView_ = GuildBossAvatarView.New(arg_5_0.displayGo_)
	arg_5_0.itemList_ = {}
end

function var_0_0.indexBonusItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_0.bonusDataList_[arg_6_1], GuildData:GetBossPersonalScore())
end

function var_0_0.indexAffixItem(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2:SetData(arg_7_0.haveGetBuffList_[arg_7_1])
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.prepareBtn_, nil, function()
		local var_9_0, var_9_1 = GuildData:GetLastTime()

		if var_9_0 == "prepose" then
			ShowTips("CLUB_BOSS_CHALLENGE_NOT_OPEN_TIP")

			return
		end

		arg_8_0:Go("/sectionSelectHero", {
			dest = 6,
			section = GuildData:GetCurrentBossStageId(),
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/guildBossRank", {})
	end)
	arg_8_0:AddBtnListener(arg_8_0.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("guildBossReward", {})
	end)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)
	end)
end

function var_0_0.AddEventListeners(arg_13_0)
	arg_13_0:RegistEventListener(GUILD_BOSS_PERSONAL_REWARD_GET, function()
		arg_13_0:UpdateView()
	end)
	arg_13_0:RegistEventListener(GUILD_EXIT, function()
		arg_13_0:Go("/home")
	end)
end

function var_0_0.OnTop(arg_16_0)
	arg_16_0:UpdateBar()
end

function var_0_0.OnBehind(arg_17_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_18_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function var_0_0.InitData(arg_19_0)
	arg_19_0.haveGetBuffList_ = GuildData:GetHaveGetBossBuffList()
	arg_19_0.bonusDataList_ = deepClone(ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward)

	table.sort(arg_19_0.bonusDataList_, function(arg_20_0, arg_20_1)
		return arg_20_0[1] > arg_20_1[1]
	end)
end

function var_0_0.OnEnter(arg_21_0)
	arg_21_0:InitData()
	arg_21_0:AddEventListeners()
	manager.ui:SetMainCamera("clubBoss")

	if arg_21_0.avatarView_ then
		arg_21_0.avatarView_:OnEnter()
	end

	arg_21_0:UpdateView()
	saveData("guild_boss", "challenge", 0)
	GuildAction.GetAssistBriefInfo(GuildData:GetGuildInfo().id)
	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
	manager.redPoint:bindUIandKey(arg_21_0.rewardNoticeContainer_, RedPointConst.GUILD_BOSS_COMMON_BONUS, {
		x = 0,
		y = 0
	})
	arg_21_0:AddGuildBossTimer()
end

function var_0_0.OnExit(arg_22_0)
	manager.ui:ResetMainCamera()
	manager.redPoint:unbindUIandKey(arg_22_0.rewardNoticeContainer_, RedPointConst.GUILD_BOSS_COMMON_BONUS)
	arg_22_0:RemoveAllEventListener()

	if arg_22_0.avatarView_ then
		arg_22_0.avatarView_:OnExit()
	end

	arg_22_0:StopGuildBossTimer()
	manager.windowBar:HideBar()
end

function var_0_0.OnMainHomeViewTop(arg_23_0)
	return
end

local var_0_1 = {
	"CLUB_BOSS_DIFFICULTY_1",
	"CLUB_BOSS_DIFFICULTY_2",
	"CLUB_BOSS_DIFFICULTY_3",
	"CLUB_BOSS_DIFFICULTY_4"
}

function var_0_0.UpdateView(arg_24_0)
	local var_24_0 = GuildData:GetCurBossId()
	local var_24_1 = MonsterCfg[var_24_0]

	arg_24_0.bossNameLabel_.text = GetMonsterName({
		var_24_0
	})
	arg_24_0.bossDescribeLabel_.text = GetI18NText(var_24_1.desc)

	arg_24_0.bonusList_:StartScroll(#arg_24_0.bonusDataList_)
	arg_24_0.buffList_:StartScroll(#arg_24_0.haveGetBuffList_)
	arg_24_0.avatarView_:SetBossID(GuildData:GetBossData().challengeInfo.boss_id)

	local var_24_2 = GuildData:GetBossPersonalScore() / ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward[4][1]
	local var_24_3 = math.min(var_24_2, 1)

	arg_24_0.scoreSlider.fillAmount = var_24_3
	arg_24_0.currentScoreLabel_.text = GuildData:GetBossPersonalScore()

	local var_24_4 = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp
	local var_24_5 = GuildData:GetCurrentBossDamage()
	local var_24_6 = GuildData:GetCurrentBossRemainHp()

	arg_24_0.expProgressLabel_.text = var_24_6
	arg_24_0.expProgressLabel2_.text = "/ " .. var_24_4

	arg_24_0.sliderGo_:GetComponent("SplineProgressBar"):SetValue(var_24_6 / var_24_4)

	local var_24_7 = deepClone(ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward)
	local var_24_8 = false

	for iter_24_0 = #var_24_7, 1, -1 do
		local var_24_9 = var_24_7[iter_24_0]

		if GuildData:GetBossPersonalScore() >= var_24_9[1] then
			arg_24_0.bonusLockController_:SetSelectedIndex(iter_24_0)

			var_24_8 = true

			break
		end
	end

	if not var_24_8 then
		arg_24_0.bonusLockController_:SetSelectedIndex(0)
	end

	arg_24_0:UpdateGuildBossTimer()

	local var_24_10 = GuildData:GetBossDifficulty()

	arg_24_0.difficultyController_:SetSelectedIndex(var_24_10 - 1)

	arg_24_0.difficulty_.text = GetTips(var_0_1[var_24_10])

	arg_24_0:UpdateData()
	arg_24_0:RefreshSkill()
end

function var_0_0.UpdateData(arg_25_0)
	arg_25_0.skillList_ = GetMonsterSkillDesList({
		GuildData:GetCurBossId()
	})
end

function var_0_0.RefreshSkill(arg_26_0)
	local var_26_0 = GuildData:GetCurBossId()

	for iter_26_0 = 1, 6 do
		if arg_26_0.skillList_[iter_26_0] then
			arg_26_0:UpdateItem(iter_26_0, arg_26_0.skillList_[iter_26_0])
		elseif arg_26_0.itemList_[iter_26_0] then
			arg_26_0.itemList_[iter_26_0]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_0.skillContainer_)
end

function var_0_0.UpdateItem(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0.itemList_[arg_27_1] then
		arg_27_0.itemList_[arg_27_1] = BattleBossChallengeSkillItem.New(arg_27_0.skillItemGo_, arg_27_0.skillContainer_)
	end

	arg_27_0.itemList_[arg_27_1]:RefreshUI(arg_27_2)
end

function var_0_0.UpdateGuildBossTimer(arg_28_0)
	local var_28_0, var_28_1 = GuildData:GetLastTime()

	arg_28_0.statusController_:SetSelectedState(var_28_0)

	if var_28_0 == "prepose" then
		arg_28_0.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
		arg_28_0.titleText_.text = GetTips("CLUB_BOSS_OPEN_1")
		arg_28_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_28_1)

		arg_28_0.btnOpenController_:SetSelectedState("false")

		arg_28_0.buttonText_.text = GetTips("CLUB_BOSS_START_1")
	else
		arg_28_0.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
		arg_28_0.titleText_.text = GetTips("CLUB_BOSS_OPEN_2")
		arg_28_0.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_28_1)

		arg_28_0.btnOpenController_:SetSelectedState("true")

		arg_28_0.buttonText_.text = GetTips("CLUB_BOSS_START_2")
	end
end

function var_0_0.AddGuildBossTimer(arg_29_0)
	if arg_29_0.guildBossTimer_ == nil then
		arg_29_0.guildBossTimer_ = Timer.New(function()
			arg_29_0:UpdateGuildBossTimer()
		end, 1, -1)
	end

	arg_29_0.guildBossTimer_:Start()
end

function var_0_0.StopGuildBossTimer(arg_31_0)
	if arg_31_0.guildBossTimer_ then
		arg_31_0.guildBossTimer_:Stop()

		arg_31_0.guildBossTimer_ = nil
	end
end

function var_0_0.Dispose(arg_32_0)
	if arg_32_0.bonusList_ then
		arg_32_0.bonusList_:Dispose()

		arg_32_0.bonusList_ = nil
	end

	if arg_32_0.buffList_ then
		arg_32_0.buffList_:Dispose()

		arg_32_0.buffList_ = nil
	end

	if arg_32_0.avatarView_ then
		arg_32_0.avatarView_:Dispose()

		arg_32_0.avatarView_ = nil
	end

	if arg_32_0.itemList_ then
		for iter_32_0, iter_32_1 in pairs(arg_32_0.itemList_) do
			iter_32_1:Dispose()
		end

		arg_32_0.itemList_ = {}
	end

	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0
