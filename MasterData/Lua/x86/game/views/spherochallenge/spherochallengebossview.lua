local SPHeroChallengeBossView = class("SPHeroChallengeBossView", import(".SPHeroChallengeBattleStageBaseView"))

function SPHeroChallengeBossView:UIName()
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBossUI"
end

function SPHeroChallengeBossView:Init()
	self.super.Init(self)

	self.lockController = self.controller:GetController("lock")
	self.openController = self.controller:GetController("open")
	self.stageInfoController = self.controller:GetController("stageInfo")
	self.buttonItem = {}

	for iter_2_0 = 1, 2 do
		self.buttonItem[iter_2_0] = SPHeroChallengeBossStageItem.New(self["bossitem" .. iter_2_0 .. "Go_"])

		self.buttonItem[iter_2_0]:RegisterClickCallBack(handler(self, self.ShowStageInfoView))
	end

	self:AddListeners()

	self.challengeTimeController_ = self.controller:GetController("challengeTime")
end

function SPHeroChallengeBossView:OnEnter()
	self:RegisterEvents()
	self:RefreshView()
end

function SPHeroChallengeBossView:RegisterEvents()
	self:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_BOSS, function()
		local var_5_0, var_5_1 = SPHeroChallengeTools:GetChapterIsOpen(SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].bossChapter)

		self.params_.showFlag = var_5_0

		self:RefreshView()
	end)
	self:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_CHALLENGE, function()
		self:RefreshPlayTime()
	end)
end

function SPHeroChallengeBossView:OnExit()
	self.selectStage = nil

	self:RemoveAllEventListener()
end

function SPHeroChallengeBossView:AddListeners()
	self:AddBtnListener(self.equiptipBtn_, nil, function()
		if self.equipSuit then
			ShowPopEquipSuit(self.equipSuit, true)
		end
	end)
	self:AddBtnListener(self.timeInfoBtn, nil, function()
		if self.challengeTimeController_:GetSelectedState() == "show" then
			self.challengeTimeController_:SetSelectedState("showTip")

			self.infoTipText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")
		else
			self.challengeTimeController_:SetSelectedState("show")
		end
	end)
end

function SPHeroChallengeBossView:ShowStageInfoView(arg_11_1)
	if SPHeroChallengeTools:CheckBossActivityIsOpen() then
		JumpTools.OpenPageByJump("spHeroChallengeSectionView", {
			section = arg_11_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
			activityId = self.activityID,
			challengeType = SpHeroChallengeConst.ChapterType.boss
		})

		self.selectStage = arg_11_1

		self:RefreshStageItem()
	else
		ShowTips("SOLO_NOT_OPEN")
	end
end

function SPHeroChallengeBossView:RefreshView()
	self.info = SPHeroChallengeData:GetCurActivityInfo()
	self.activityID = SPHeroChallengeData:GetActivityID()

	self:RefreshLockState()
	self:RefreshOpenState()
	self:RefreshErosion()
	self:RefreshStageItem()
	self:RefreshEquipInfo()
	self:RefreshPlayTime()

	if self:IsOpenSectionView() then
		self.stageInfoController:SetSelectedState("open")
	else
		self.stageInfoController:SetSelectedState("close")
	end
end

function SPHeroChallengeBossView:OnUpdate()
	if self:IsOpenSectionView() then
		self.stageInfoController:SetSelectedState("open")
	else
		self.stageInfoController:SetSelectedState("close")
	end
end

function SPHeroChallengeBossView:IsOpenSectionView()
	return self:IsOpenRoute("spHeroChallengeSectionView")
end

function SPHeroChallengeBossView:RefreshPlayTime()
	self.totalNum, self.curNum = SPHeroChallengeData:GetCurActivityInfo():GetChallengeTimes()
	self.challengeTime.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REMAIN_TIME"), self.totalNum - self.curNum <= 0 and string.format("<color='#FF000B'>%d</color>", tostring(self.totalNum - self.curNum)) or tostring(self.totalNum - self.curNum), tonumber(1))
end

function SPHeroChallengeBossView:RefreshErosion()
	local var_16_0 = self.info:GetBossErosiveness()

	self.percenttextText_.text = var_16_0 .. "%"
	self.sliderImg_.fillAmount = var_16_0 / 100
end

function SPHeroChallengeBossView:RefreshOpenState()
	self.bossActivityID = SPHeroChallengeData.activityCfg[self.activityID].bossActivityID

	if ActivityData:GetActivityIsOpen(self.bossActivityID) and self.info.bossStart then
		self.openController:SetSelectedState("unlock")
	else
		self.openController:SetSelectedState("lock")

		self.lockdescText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BOSS_OPEN_TIME")
	end
end

function SPHeroChallengeBossView:RefreshLockState()
	if not self.params_.showFlag then
		self.lockController:SetSelectedState("not")

		if self.params_.reason then
			self.lockText.text = not self.info.bossStart and (SPHeroChallengeTools:GetChapterIsOpen(SPHeroChallengeData.activityCfg[self.activityID].storyChapter) and SPHeroChallengeTools:GetChapterIsOpen(SPHeroChallengeData.activityCfg[self.activityID].trainChapter) and GetTips("ACTIVITY_HERO_CHALLENGE_BOSS_OPEN_TIME") or GetTips("ACTIVITY_HERO_CHALLENGE_LOCK_TIP")) or GetTips(self.params_.reason)
		end
	else
		self.lockController:SetSelectedState("open")
	end
end

function SPHeroChallengeBossView:RefreshStageItem()
	if self.buttonItem then
		for iter_19_0, iter_19_1 in ipairs(self.buttonItem) do
			iter_19_1:RefreshUI(BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.boss][iter_19_0], self.selectStage)
		end
	end
end

function SPHeroChallengeBossView:RefreshEquipInfo()
	if ActivityRewardPoolCfg.get_id_list_by_activity_id[self.bossActivityID][1] then
		local var_20_0 = 0
		local var_20_1 = SPHeroChallengeData:GetCurActivityInfo()
		local var_20_2 = 0

		if var_20_1.equipList then
			var_20_2 = #var_20_1.equipList
		end

		local var_20_3 = 1

		for iter_20_0, iter_20_1 in ipairs(ActivityRewardPoolItemCfg.get_id_list_by_activity_id[ActivityRewardPoolCfg.get_id_list_by_activity_id[self.bossActivityID][1]]) do
			var_20_0 = var_20_0 + ActivityRewardPoolItemCfg[iter_20_1].reward[2] * ActivityRewardPoolItemCfg[iter_20_1].total
			var_20_3 = ActivityRewardPoolItemCfg[iter_20_1].reward[1]
		end

		self.numText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_EQUIP_NUM"), var_20_2, var_20_0)
		self.equipSuit = EquipCfg[var_20_3].suit

		if EquipSuitCfg[self.equipSuit] then
			SetSpriteWithoutAtlasAsync(self.iconImg_, SpritePathCfg.EquipIcon_s.path .. EquipSuitCfg[self.equipSuit].equip_skill_icon)

			self.nameText_.text = EquipSuitCfg[self.equipSuit].name
		end
	end
end

function SPHeroChallengeBossView:Dispose()
	if self.buttonItem then
		for iter_21_0, iter_21_1 in pairs(self.buttonItem) do
			iter_21_1:Dispose()
		end

		self.buttonItem = nil
	end

	self.super.Dispose(self)
end

return SPHeroChallengeBossView
