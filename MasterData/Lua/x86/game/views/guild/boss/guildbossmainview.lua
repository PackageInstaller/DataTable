local GuildBossMainView = class("GuildBossMainView", ReduxView)

function GuildBossMainView:UIName()
	return "Widget/System/Club_boss/ClubBossmain"
end

function GuildBossMainView:UIParent()
	return manager.ui.uiMain.transform
end

function GuildBossMainView:OnCtor()
	return
end

function GuildBossMainView:Init()
	self:InitUI()
	self:AddUIListener()
end

function GuildBossMainView:InitUI()
	self:BindCfgUI()

	self.indexController_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
	self.difficultyController_ = ControllerUtil.GetController(self.difficultyBtn_.transform, "difficulty")
	self.lockedController_ = ControllerUtil.GetController(self.difficultyBtn_.transform, "locked")
	self.checkedController_ = ControllerUtil.GetController(self.firstBonusBtn_.transform, "checked")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")
	self.nameList_ = {
		self.nameLabel1_,
		self.nameLabel2_,
		self.nameLabel3_,
		self.nameLabel4_,
		self.nameLabel5_
	}
	self.btnList_ = {
		self.challengeBtn1_,
		self.challengeBtn2_,
		self.challengeBtn3_,
		self.challengeBtn4_,
		self.challengeBtn5_
	}
	self.progressBarList_ = {
		self.progressBar1_,
		self.progressBar2_,
		self.progressBar3_,
		self.progressBar4_,
		self.progressBar5_
	}
	self.progressLabelList_ = {
		self.progressLabel1_,
		self.progressLabel2_,
		self.progressLabel3_,
		self.progressLabel4_,
		self.progressLabel5_
	}
	self.lockedBtnList_ = {
		self.lockedBtn1_,
		self.lockedBtn2_,
		self.lockedBtn3_,
		self.lockedBtn4_,
		self.lockedBtn5_
	}
	self.affixList_ = LuaList.New(handler(self, self.indexItem), self.buffListGo_, AffixItemView)
end

function GuildBossMainView:indexItem(arg_6_1, arg_6_2)
	arg_6_2:SetData(self.haveGetBuffList_[arg_6_1])
end

function GuildBossMainView:AddUIListener()
	for iter_7_0, iter_7_1 in ipairs(self.lockedBtnList_) do
		self:AddBtnListener(iter_7_1, nil, function()
			ShowTips("CLUB_BOSS_PREPOSE_FINISH_TIP")
		end)
	end

	for iter_7_2, iter_7_3 in ipairs(self.btnList_) do
		self:AddBtnListener(iter_7_3, nil, function()
			self:EnterLevel(iter_7_2)
		end)
	end

	self:AddBtnListener(self.bgBtn_, nil, function()
		manager.notify:Invoke(CLICK_AFFIX)

		if self:IsOpenSectionView() then
			JumpTools.Back()
			self.indexController_:SetSelectedIndex(0)
		end
	end)
	self:AddBtnListener(self.bossBtn_, nil, function()
		JumpTools.OpenPageByJump("/guildBossChallenge", {})
	end)
	self:AddBtnListener(self.firstBonusBtn_, nil, function()
		local var_12_0

		if GuildData:CanGetBonus() then
			GuildAction.GetGuildBossReward(GuildData:GetGuildInfo().id, 3, 1)

			do return end

			var_12_0 = {}
		end

		var_12_0.rewardList = ClubBossPreposeCfg[1].personal_reward

		JumpTools.OpenPageByJump("rewardPreview", var_12_0, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
	end)
	self:AddBtnListener(self.difficultyBtn_, nil, function()
		if not GuildData:IsCaptainOrDeputy() then
			ShowTips("CLUB_BOSS_DIFFICULTY_CANT_TIP")

			return
		end

		local var_13_0, var_13_1 = GuildData:GetLastTime()

		self.statusController_:SetSelectedState(var_13_0)

		if var_13_0 == "challenge" then
			ShowTips("CLUB_BOSS_DIFFICULTY_EXPIRED_TIP")

			return
		end

		JumpTools.OpenPageByJump("guildDifficultChose", {})
	end)
	self:AddBtnListener(self.helpSettingBtn_, nil, function()
		JumpTools.OpenPageByJump("/guildBossSetAssistant", {
			canUseMultiMode = false,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT
		})
	end)
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		if self:IsOpenSectionView() then
			JumpTools.Back()
		end

		self.drag_ = true
	end))
	self.eventTrigger_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function(arg_16_0, arg_16_1)
		self.drag_ = false
	end))
end

function GuildBossMainView:AddEventListeners()
	self:RegistEventListener(GUILD_BOSS_INIT, function()
		self.haveGetBuffList_ = GuildData:GetHaveGetBossBuffList()
		self.stageDataList_ = GuildData:GetPreInfoList()

		self:UpdateView()
	end)
	self:RegistEventListener(GUILD_BOSS_BONUS_GET, function()
		self:UpdateFirstBonusCheck()
	end)
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
	self:RegistEventListener(GUILD_BOSS_DIFFICULTY_CHANGE, function()
		self:UpdateView()
	end)
end

function GuildBossMainView:EnterLevel(arg_22_1)
	self.indexController_:SetSelectedIndex(arg_22_1)
	JumpTools.OpenPageByJump("guildBossSectionInfo", {
		index = arg_22_1,
		section = self.stageDataList_[arg_22_1].stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.GUILD_BOSS_PREPARE,
		activityId = self.params_.activityId,
		preData = self.stageDataList_[arg_22_1]
	})
end

function GuildBossMainView:OnTop()
	self:UpdateBar()
	self.indexController_:SetSelectedIndex(0)
end

function GuildBossMainView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildBossMainView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function GuildBossMainView:OnEnter()
	self:AddEventListeners()
	GuildAction.RequestClubBossInfo(GuildData:GetGuildInfo().id)
	saveData("guild_boss", "prepose", 0)
	manager.redPoint:setTip(RedPointConst.GUILD_BOSS_PREPOSE_OPEN, 0)
	manager.redPoint:bindUIandKey(self.bossRedPointContainer_, RedPointConst.GUILD_BOSS_BOSS_BTN, {
		x = 0,
		y = 0
	})
	GuildAction.GetAssistBriefInfo(GuildData:GetGuildInfo().id)
	self:AddGuildBossTimer()

	if self.params_.isEnter then
		self.animator_:Play("ClubBossmain", -1, 0)

		self.animator_.speed = 1
	else
		local var_26_0 = self.animator_:GetCurrentAnimatorClipInfo(0)

		self.animator_:Play(var_26_0[0].clip.name, 0, var_26_0[0].clip.length)

		self.animator_.speed = 0
	end

	self.params_.isEnter = nil
end

function GuildBossMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.bossRedPointContainer_, RedPointConst.GUILD_BOSS_BOSS_BTN)
	self:RemoveAllEventListener()
	self:StopGuildBossTimer()
	manager.windowBar:HideBar()
end

function GuildBossMainView:UpdateView()
	for iter_28_0, iter_28_1 in ipairs(self.stageDataList_) do
		self.nameList_[iter_28_0].text = GetI18NText(ClubBossPreposeCfg[iter_28_0].name)

		local var_28_0 = math.min(iter_28_1.score, ClubBossPreposeCfg[iter_28_0].point_max)

		self.progressBarList_[iter_28_0].fillAmount = var_28_0 / ClubBossPreposeCfg[iter_28_0].point_max
		self.progressLabelList_[iter_28_0].text = string.format("%d", 100 * var_28_0 / ClubBossPreposeCfg[iter_28_0].point_max)
	end

	self.affixList_:StartScroll(#self.haveGetBuffList_)

	self.timeLabel_.text = string.format("%d/%d", GuildData:GetBossLastTime(), GameSetting.club_boss_prepose_max.value[1])
	self.difficultyText_.text = GetTips("CLUB_BOSS_DIFFICULTY_" .. GetI18NText((GuildData:GetBossDifficulty())))

	self:UpdateGuildBossTimer()
	self:UpdateFirstBonusCheck()
end

function GuildBossMainView:UpdateFirstBonusCheck()
	if GuildData:IsGetFirstBossBonus() then
		self.checkedController_:SetSelectedState("true")
	elseif GuildData:CanGetBonus() then
		self.checkedController_:SetSelectedState("canGet")
	else
		self.checkedController_:SetSelectedState("false")
	end
end

function GuildBossMainView:OnMainHomeViewTop()
	return
end

function GuildBossMainView:IsOpenSectionView()
	return self:IsOpenRoute("guildBossSectionInfo")
end

function GuildBossMainView:UpdateGuildBossTimer()
	local var_32_0, var_32_1 = GuildData:GetLastTime()

	self.statusController_:SetSelectedState(var_32_0)

	if var_32_0 == "prepose" then
		self.stageLabel_.text = GetTips("CLUB_BOSS_PREPOSE_TIP")
		self.openTimeText_.text = GetTips("GONGHUIBOSS_LIEXIZHENGZHAO")
		self.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_32_1)

		self.lockedController_:SetSelectedState("false")
	else
		self.stageLabel_.text = GetTips("CLUB_BOSS_CHALLENGE_TIP")
		self.openTimeText_.text = GetTips("GONGHUIBOSS_LIEXIKAIFANG")
		self.lastDayLabel_.text = manager.time:GetLostTimeStrWith2Unit(var_32_1)

		self.lockedController_:SetSelectedState(GuildData:IsCaptainOrDeputy() and "true" or "false")
	end
end

function GuildBossMainView:AddGuildBossTimer()
	if self.guildBossTimer_ == nil then
		self.guildBossTimer_ = Timer.New(function()
			self:UpdateGuildBossTimer()
		end, 1, -1)
	end

	self.guildBossTimer_:Start()
end

function GuildBossMainView:StopGuildBossTimer()
	if self.guildBossTimer_ then
		self.guildBossTimer_:Stop()

		self.guildBossTimer_ = nil
	end
end

function GuildBossMainView:Dispose()
	if self.affixList_ then
		self.affixList_:Dispose()

		self.affixList_ = nil
	end

	if self.payTimer_ ~= nil then
		self.payTimer_:Stop()

		self.payTimer_ = nil
	end

	GuildBossMainView.super.Dispose(self)
end

return GuildBossMainView
