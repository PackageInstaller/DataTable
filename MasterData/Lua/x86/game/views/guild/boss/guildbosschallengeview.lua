local GuildBossChallengeView = class("GuildBossChallengeView", ReduxView)

function GuildBossChallengeView:UIName()
	return "Widget/System/Club_boss/ClubBossChallengeUI"
end

function GuildBossChallengeView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildBossChallengeView:OnCtor()
	return
end

function GuildBossChallengeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossChallengeView:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.titleGo_.transform, "status")
	self.bonusLockController_ = ControllerUtil.GetController(self.bonusLockGo_.transform, "bonusLock")
	self.btnOpenController_ = ControllerUtil.GetController(self.prepareBtn_.transform, "btnOpen")
	self.difficultyController_ = ControllerUtil.GetController(self.difficultyGo_.transform, "difficulty")
	self.bonusList_ = LuaList.New(handler(self, self.indexBonusItem), self.bonusListGo_, GuildBossChallengeRewardItemView)
	self.buffList_ = LuaList.New(handler(self, self.indexAffixItem), self.buffListGo_, AffixItemView)
	self.avatarView_ = GuildBossAvatarView.New(self.displayGo_)
	self.itemList_ = {}
end

function GuildBossChallengeView:indexBonusItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.bonusDataList_[arg_6_1], GuildData:GetBossPersonalScore())
end

function GuildBossChallengeView:indexAffixItem(arg_7_1, arg_7_2)
	arg_7_2:SetData(self.haveGetBuffList_[arg_7_1])
end

function GuildBossChallengeView:AddUIListener()
	self:AddBtnListener(self.prepareBtn_, nil, function()
		local var_9_0, var_9_1 = GuildData:GetLastTime()

		if var_9_0 == "prepose" then
			ShowTips("CLUB_BOSS_CHALLENGE_NOT_OPEN_TIP")

			return
		end

		self:Go("/sectionSelectHero", {
			dest = 6,
			section = GuildData:GetCurrentBossStageId(),
			sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_CHALLENGE
		})
	end)
	self:AddBtnListener(self.rankBtn_, nil, function()
		JumpTools.OpenPageByJump("/guildBossRank", {})
	end)
	self:AddBtnListener(self.rewardBtn_, nil, function()
		JumpTools.OpenPageByJump("guildBossReward", {})
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)
	end)
end

function GuildBossChallengeView:AddEventListeners()
	self:RegistEventListener(GUILD_BOSS_PERSONAL_REWARD_GET, function()
		self:UpdateView()
	end)
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function GuildBossChallengeView:OnTop()
	self:UpdateBar()
end

function GuildBossChallengeView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildBossChallengeView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function GuildBossChallengeView:InitData()
	self.haveGetBuffList_ = GuildData:GetHaveGetBossBuffList()
	self.bonusDataList_ = deepClone(ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward)

	table.sort(self.bonusDataList_, function(arg_20_0, arg_20_1)
		return arg_20_0[1] > arg_20_1[1]
	end)
end

function GuildBossChallengeView:OnEnter()
	self:InitData()
	self:AddEventListeners()
	manager.ui:SetMainCamera("clubBoss")

	if self.avatarView_ then
		self.avatarView_:OnEnter()
	end

	self:UpdateView()
	saveData("guild_boss", "challenge", 0)
	GuildAction.GetAssistBriefInfo(GuildData:GetGuildInfo().id)
	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_CHALLENGE_OPEN, 0)
	manager.redPoint:bindUIandKey(self.rewardNoticeContainer_, RedPointConst.GUILD_BOSS_COMMON_BONUS, {
		x = 0,
		y = 0
	})
	self:AddGuildBossTimer()
end

function GuildBossChallengeView:OnExit()
	manager.ui:ResetMainCamera()
	manager.redPoint:unbindUIandKey(self.rewardNoticeContainer_, RedPointConst.GUILD_BOSS_COMMON_BONUS)
	self:RemoveAllEventListener()

	if self.avatarView_ then
		self.avatarView_:OnExit()
	end

	self:StopGuildBossTimer()
	manager.windowBar:HideBar()
end

function GuildBossChallengeView:OnMainHomeViewTop()
	return
end

local var_0_1 = {
	"CLUB_BOSS_DIFFICULTY_1",
	"CLUB_BOSS_DIFFICULTY_2",
	"CLUB_BOSS_DIFFICULTY_3",
	"CLUB_BOSS_DIFFICULTY_4"
}

function GuildBossChallengeView:UpdateView()
	local var_24_0 = GuildData:GetCurBossId()

	self.bossNameLabel_.text = GetMonsterName({
		var_24_0
	})
	self.bossDescribeLabel_.text = GetI18NText(MonsterCfg[var_24_0].desc)

	self.bonusList_:StartScroll(#self.bonusDataList_)
	self.buffList_:StartScroll(#self.haveGetBuffList_)
	self.avatarView_:SetBossID(GuildData:GetBossData().challengeInfo.boss_id)

	self.scoreSlider.fillAmount = math.min(GuildData:GetBossPersonalScore() / ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward[4][1], 1)
	self.currentScoreLabel_.text = GuildData:GetBossPersonalScore()

	local var_24_1 = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp
	local var_24_2 = GuildData:GetCurrentBossDamage()
	local var_24_3 = GuildData:GetCurrentBossRemainHp()

	self.expProgressLabel_.text = var_24_3
	self.expProgressLabel2_.text = "/ " .. var_24_1

	self.sliderGo_:GetComponent("SplineProgressBar"):SetValue(var_24_3 / var_24_1)

	local var_24_4 = deepClone(ClubBossCfg[GuildData:GetBossDifficulty()].personal_reward)
	local var_24_5 = false

	for iter_24_0 = #var_24_4, 1, -1 do
		if GuildData:GetBossPersonalScore() >= var_24_4[iter_24_0][1] then
			self.bonusLockController_:SetSelectedIndex(iter_24_0)

			var_24_5 = true

			break
		end
	end

	if not var_24_5 then
		self.bonusLockController_:SetSelectedIndex(0)
	end

	self:UpdateGuildBossTimer()

	local var_24_6 = GuildData:GetBossDifficulty()

	self.difficultyController_:SetSelectedIndex(var_24_6 - 1)

	self.difficulty_.text = GetTips(var_0_1[var_24_6])

	self:UpdateData()
	self:RefreshSkill()
end

function GuildBossChallengeView:UpdateData()
	self.skillList_ = GetMonsterSkillDesList({
		GuildData:GetCurBossId()
	})
end

function GuildBossChallengeView:RefreshSkill()
	local var_26_0 = GuildData:GetCurBossId()

	for iter_26_0 = 1, 6 do
		if self.skillList_[iter_26_0] then
			self:UpdateItem(iter_26_0, self.skillList_[iter_26_0])
		elseif self.itemList_[iter_26_0] then
			self.itemList_[iter_26_0]:Hide()
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillContainer_)
end

function GuildBossChallengeView:UpdateItem(arg_27_1, arg_27_2)
	self.itemList_[arg_27_1] = self.itemList_[arg_27_1] or BattleBossChallengeSkillItem.New(self.skillItemGo_, self.skillContainer_)

	self.itemList_[arg_27_1]:RefreshUI(arg_27_2)
end

function GuildBossChallengeView:UpdateGuildBossTimer()
	local var_28_0, var_28_1 = GuildData:GetLastTime()

	self.statusController_:SetSelectedState(var_28_0)

	if var_28_0 == "prepose" then
		self.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
		self.titleText_.text = GetTips("CLUB_BOSS_OPEN_1")
		self.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_28_1)

		self.btnOpenController_:SetSelectedState("false")

		self.buttonText_.text = GetTips("CLUB_BOSS_START_1")
	else
		self.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
		self.titleText_.text = GetTips("CLUB_BOSS_OPEN_2")
		self.lastTimeLabel_.text = manager.time:GetLostTimeStr(var_28_1)

		self.btnOpenController_:SetSelectedState("true")

		self.buttonText_.text = GetTips("CLUB_BOSS_START_2")
	end
end

function GuildBossChallengeView:AddGuildBossTimer()
	if self.guildBossTimer_ == nil then
		self.guildBossTimer_ = Timer.New(function()
			self:UpdateGuildBossTimer()
		end, 1, -1)
	end

	self.guildBossTimer_:Start()
end

function GuildBossChallengeView:StopGuildBossTimer()
	if self.guildBossTimer_ then
		self.guildBossTimer_:Stop()

		self.guildBossTimer_ = nil
	end
end

function GuildBossChallengeView:Dispose()
	if self.bonusList_ then
		self.bonusList_:Dispose()

		self.bonusList_ = nil
	end

	if self.buffList_ then
		self.buffList_:Dispose()

		self.buffList_ = nil
	end

	if self.avatarView_ then
		self.avatarView_:Dispose()

		self.avatarView_ = nil
	end

	if self.itemList_ then
		for iter_32_0, iter_32_1 in pairs(self.itemList_) do
			iter_32_1:Dispose()
		end

		self.itemList_ = {}
	end

	GuildBossChallengeView.super.Dispose(self)
end

return GuildBossChallengeView
