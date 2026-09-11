local BattleBossInfoBaseView = class("BattleBossInfoBaseView", ReduxView)

function BattleBossInfoBaseView:UIName()
	return
end

function BattleBossInfoBaseView:UIParent()
	return manager.ui.uiMain.transform
end

function BattleBossInfoBaseView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.heroLockList_ = {}
	self.skillList_ = {}
	self.bossModel_ = {}
	self.bossAnimatorList_ = {}
	self.cacheRootMotionList_ = {}
	self.animatorTimer_ = {}
	self.loadIndexList_ = {}
	self.challengeUpdateHandler_ = handler(self, self.UpdateBossChallenge)
end

function BattleBossInfoBaseView:OnEnter()
	manager.ui:SetMainCamera("bossChallenge")
	self:InitBackScene()

	self.exitView_ = false
	self.currentBossTemplateID_ = nil

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, self.challengeUpdateHandler_)
	BossTools.CheckTimeout()
	self:OnEnterExtend()
	self:RefreshData()
	self:RefreshUI()
end

function BattleBossInfoBaseView:OnExit()
	self.exitView_ = true

	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, self.challengeUpdateHandler_)
	self:UnloadModel()
	self:DestroyBackScene()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function BattleBossInfoBaseView:Dispose()
	BattleBossInfoBaseView.super.Dispose(self)

	self.challengeUpdateHandler_ = nil

	for iter_6_0, iter_6_1 in pairs(self.heroLockList_) do
		iter_6_1:Dispose()
	end

	self.heroLockList_ = nil

	for iter_6_2, iter_6_3 in ipairs(self.skillList_) do
		iter_6_3:Dispose()
	end

	self.skillList_ = nil
end

function BattleBossInfoBaseView:AddListeners()
	return
end

function BattleBossInfoBaseView:RefreshData()
	return
end

function BattleBossInfoBaseView:RefreshUI()
	self:RefreshText()
	self:LoadModel()
	self:RefreshSkill()
	self:RefreshLockHero()
end

function BattleBossInfoBaseView:UpdateBossChallenge()
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function BattleBossInfoBaseView:RefreshText()
	self.textName_.text = GetI18NText(BossChallengeUICfg[self.templateID_].main_name)
	self.textDesc_.text = GetI18NText(BossChallengeUICfg[self.templateID_].descripe)
end

function BattleBossInfoBaseView:RefreshSkill()
	local var_12_0 = 1

	for iter_12_0, iter_12_1 in ipairs(BossChallengeUICfg[self.templateID_].boss_id_list) do
		local var_12_2 = GetMonsterSkillDesList({
			iter_12_1
		})

		for iter_12_2 = 1, 6 do
			if var_12_2[iter_12_2] then
				self.skillList_[var_12_0] = self.skillList_[var_12_0] or BattleBossChallengeSkillItem.New(self.skillItem_, self.skillParent_)

				self.skillList_[var_12_0]:RefreshUI(var_12_2[iter_12_2])

				var_12_0 = var_12_0 + 1
			end
		end
	end

	for iter_12_3 = var_12_0, #self.skillList_ do
		self.skillList_[iter_12_3]:Hide()
	end
end

function BattleBossInfoBaseView:RefreshLockHero()
	local var_13_0 = self.lockHeroGroup_[self.bossIndex_] or {}

	for iter_13_0 = 1, #var_13_0 do
		self.heroLockList_[iter_13_0] = self.heroLockList_[iter_13_0] or BattleBossChallengeLockHeroItem.New(self.heroLockItem_, self.heroLockPanel_, var_13_0[iter_13_0])

		self.heroLockList_[iter_13_0]:SetActive(true, var_13_0[iter_13_0])
	end

	for iter_13_1 = #var_13_0 + 1, #self.heroLockList_ do
		self.heroLockList_[iter_13_1]:SetActive(false)
	end

	self.heroLockScroll_.normalizedPosition = Vector2(0, 1)
end

function BattleBossInfoBaseView:LoadModel()
	if self.currentBossTemplateID_ == self.templateID_ then
		return
	end

	self.currentBossTemplateID_ = self.templateID_

	self:UnloadModel()

	local var_14_0 = BossChallengeUICfg[self.templateID_]

	for iter_14_0, iter_14_1 in pairs(BossChallengeUICfg[self.templateID_].boss_id_list) do
		self.loadIndexList_[iter_14_0] = manager.resourcePool:AsyncLoad("Char/" .. MonsterCfg[iter_14_1].model_name, ASSET_TYPE.TPOSE, function(arg_15_0)
			if self.exitView_ or self.currentBossTemplateID_ ~= self.templateID_ then
				manager.resourcePool:DestroyOrReturn(arg_15_0, ASSET_TYPE.TPOSE)

				return
			end

			local var_15_0 = var_14_0.model_pos[iter_14_0]

			self.bossModel_[iter_14_0] = arg_15_0
			self.bossModel_[iter_14_0].transform.localPosition = Vector3(var_15_0[1], var_15_0[2], var_15_0[3])
			self.bossModel_[iter_14_0].transform.localEulerAngles = Vector3(var_14_0.model_rot[iter_14_0][1], var_14_0.model_rot[iter_14_0][2], var_14_0.model_rot[iter_14_0][3])
			self.bossModel_[iter_14_0].transform.localScale = Vector3(var_14_0.model_scale[iter_14_0][1], var_14_0.model_scale[iter_14_0][2], var_14_0.model_scale[iter_14_0][3])
			self.bossAnimatorList_[iter_14_0] = self.bossModel_[iter_14_0]:GetComponent(typeof(Animator))

			self:PlayAppearAnimation(iter_14_0, function()
				self.bossAnimatorList_[iter_14_0]:CrossFadeInFixedTime("stand", 0.01)
			end)
		end)
	end
end

function BattleBossInfoBaseView:UnloadModel()
	for iter_17_0, iter_17_1 in pairs(self.bossModel_) do
		self.bossAnimatorList_[iter_17_0].applyRootMotion = self.cacheRootMotionList_[iter_17_0]

		manager.resourcePool:DestroyOrReturn(iter_17_1, ASSET_TYPE.TPOSE)
	end

	self.bossModel_ = {}
	self.bossAnimatorList_ = {}

	for iter_17_2, iter_17_3 in pairs(self.loadIndexList_) do
		manager.resourcePool:StopAsyncQuest(iter_17_3)
	end

	self.loadIndexList_ = {}

	self:StopAllAnimatorTimer()
end

function BattleBossInfoBaseView:PlayAppearAnimation(arg_18_1, arg_18_2)
	local var_18_0 = self.bossAnimatorList_[arg_18_1]

	self.cacheRootMotionList_[arg_18_1] = self.bossAnimatorList_[arg_18_1].applyRootMotion
	self.bossAnimatorList_[arg_18_1].applyRootMotion = false

	if type(BossChallengeUICfg[self.templateID_].appear_ani) == "table" and BossChallengeUICfg[self.templateID_].appear_ani[arg_18_1] ~= "" then
		self.bossAnimatorList_[arg_18_1]:Play(BossChallengeUICfg[self.templateID_].appear_ani[arg_18_1])

		local var_18_1

		var_18_1 = FrameTimer.New(function()
			if var_18_0:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				var_18_1:Stop()
				table.removebyvalue(self.animatorTimer_, var_18_1)

				var_18_1 = nil

				arg_18_2()
			end
		end, 1, -1)

		table.insert(self.animatorTimer_, nil)
		var_18_1:Start()
	else
		arg_18_2()
	end
end

function BattleBossInfoBaseView:StopAllAnimatorTimer()
	for iter_20_0 = #self.animatorTimer_, 1, -1 do
		self.animatorTimer_[iter_20_0]:Stop()

		self.animatorTimer_[iter_20_0] = nil
	end
end

function BattleBossInfoBaseView:InitBackScene()
	self.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	self.backGroundTrs_ = self.backGround_.transform

	self.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	self.backGroundTrs_.localPosition = Vector3(GameDisplayCfg.boss_background_pos.value[1], GameDisplayCfg.boss_background_pos.value[2], GameDisplayCfg.boss_background_pos.value[3])
	self.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	self.backGroundTrs_.localScale = Vector3(GameDisplayCfg.boss_background_pos.scale[1], GameDisplayCfg.boss_background_pos.scale[2], GameDisplayCfg.boss_background_pos.scale[3])
	self.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureBg/Challenge_Boss/" .. CameraCfg.bossChallenge.pictureName)
end

function BattleBossInfoBaseView:DestroyBackScene()
	if self.backGround_ then
		manager.resourcePool:DestroyOrReturn(self.backGround_, ASSET_TYPE.SCENE)

		self.backGround_ = nil
	end
end

return BattleBossInfoBaseView
