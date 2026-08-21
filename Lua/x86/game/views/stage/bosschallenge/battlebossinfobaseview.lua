local var_0_0 = class("BattleBossInfoBaseView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.heroLockList_ = {}
	arg_3_0.skillList_ = {}
	arg_3_0.bossModel_ = {}
	arg_3_0.bossAnimatorList_ = {}
	arg_3_0.cacheRootMotionList_ = {}
	arg_3_0.animatorTimer_ = {}
	arg_3_0.loadIndexList_ = {}
	arg_3_0.challengeUpdateHandler_ = handler(arg_3_0, arg_3_0.UpdateBossChallenge)
end

function var_0_0.OnEnter(arg_4_0)
	manager.ui:SetMainCamera("bossChallenge")
	arg_4_0:InitBackScene()

	arg_4_0.exitView_ = false
	arg_4_0.currentBossTemplateID_ = nil

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.notify:RegistListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_4_0.challengeUpdateHandler_)
	BossTools.CheckTimeout()
	arg_4_0:OnEnterExtend()
	arg_4_0:RefreshData()
	arg_4_0:RefreshUI()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0.exitView_ = true

	manager.notify:RemoveListener(BOSS_CHALLENGE_BACK_ENTRACE, arg_5_0.challengeUpdateHandler_)
	arg_5_0:UnloadModel()
	arg_5_0:DestroyBackScene()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)

	arg_6_0.challengeUpdateHandler_ = nil

	for iter_6_0, iter_6_1 in pairs(arg_6_0.heroLockList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.heroLockList_ = nil

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.skillList_) do
		iter_6_3:Dispose()
	end

	arg_6_0.skillList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.RefreshData(arg_8_0)
	return
end

function var_0_0.RefreshUI(arg_9_0)
	arg_9_0:RefreshText()
	arg_9_0:LoadModel()
	arg_9_0:RefreshSkill()
	arg_9_0:RefreshLockHero()
end

function var_0_0.UpdateBossChallenge(arg_10_0)
	BattleBossChallengeAction.BossChallengeBackEntrace()
end

function var_0_0.RefreshText(arg_11_0)
	local var_11_0 = arg_11_0.templateID_
	local var_11_1 = BossChallengeUICfg[var_11_0]

	arg_11_0.textName_.text = GetI18NText(var_11_1.main_name)
	arg_11_0.textDesc_.text = GetI18NText(var_11_1.descripe)
end

function var_0_0.RefreshSkill(arg_12_0)
	local var_12_0 = 1

	for iter_12_0, iter_12_1 in ipairs(BossChallengeUICfg[arg_12_0.templateID_].boss_id_list) do
		local var_12_1 = MonsterCfg[iter_12_1]
		local var_12_2 = GetMonsterSkillDesList({
			iter_12_1
		})

		for iter_12_2 = 1, 6 do
			if var_12_2[iter_12_2] then
				if not arg_12_0.skillList_[var_12_0] then
					arg_12_0.skillList_[var_12_0] = BattleBossChallengeSkillItem.New(arg_12_0.skillItem_, arg_12_0.skillParent_)
				end

				arg_12_0.skillList_[var_12_0]:RefreshUI(var_12_2[iter_12_2])

				var_12_0 = var_12_0 + 1
			end
		end
	end

	for iter_12_3 = var_12_0, #arg_12_0.skillList_ do
		arg_12_0.skillList_[iter_12_3]:Hide()
	end
end

function var_0_0.RefreshLockHero(arg_13_0)
	local var_13_0 = arg_13_0.lockHeroGroup_[arg_13_0.bossIndex_] or {}

	for iter_13_0 = 1, #var_13_0 do
		local var_13_1 = var_13_0[iter_13_0]

		if not arg_13_0.heroLockList_[iter_13_0] then
			arg_13_0.heroLockList_[iter_13_0] = BattleBossChallengeLockHeroItem.New(arg_13_0.heroLockItem_, arg_13_0.heroLockPanel_, var_13_1)
		end

		arg_13_0.heroLockList_[iter_13_0]:SetActive(true, var_13_1)
	end

	for iter_13_1 = #var_13_0 + 1, #arg_13_0.heroLockList_ do
		arg_13_0.heroLockList_[iter_13_1]:SetActive(false)
	end

	arg_13_0.heroLockScroll_.normalizedPosition = Vector2(0, 1)
end

function var_0_0.LoadModel(arg_14_0)
	if arg_14_0.currentBossTemplateID_ == arg_14_0.templateID_ then
		return
	end

	arg_14_0.currentBossTemplateID_ = arg_14_0.templateID_

	arg_14_0:UnloadModel()

	local var_14_0 = BossChallengeUICfg[arg_14_0.templateID_]

	for iter_14_0, iter_14_1 in pairs(var_14_0.boss_id_list) do
		arg_14_0.loadIndexList_[iter_14_0] = manager.resourcePool:AsyncLoad("Char/" .. MonsterCfg[iter_14_1].model_name, ASSET_TYPE.TPOSE, function(arg_15_0)
			if arg_14_0.exitView_ or arg_14_0.currentBossTemplateID_ ~= arg_14_0.templateID_ then
				manager.resourcePool:DestroyOrReturn(arg_15_0, ASSET_TYPE.TPOSE)

				return
			end

			local var_15_0 = var_14_0.model_pos[iter_14_0]
			local var_15_1 = var_14_0.model_rot[iter_14_0]
			local var_15_2 = var_14_0.model_scale[iter_14_0]

			arg_14_0.bossModel_[iter_14_0] = arg_15_0
			arg_14_0.bossModel_[iter_14_0].transform.localPosition = Vector3(var_15_0[1], var_15_0[2], var_15_0[3])
			arg_14_0.bossModel_[iter_14_0].transform.localEulerAngles = Vector3(var_15_1[1], var_15_1[2], var_15_1[3])
			arg_14_0.bossModel_[iter_14_0].transform.localScale = Vector3(var_15_2[1], var_15_2[2], var_15_2[3])
			arg_14_0.bossAnimatorList_[iter_14_0] = arg_14_0.bossModel_[iter_14_0]:GetComponent(typeof(Animator))

			arg_14_0:PlayAppearAnimation(iter_14_0, function()
				arg_14_0.bossAnimatorList_[iter_14_0]:CrossFadeInFixedTime("stand", 0.01)
			end)
		end)
	end
end

function var_0_0.UnloadModel(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.bossModel_) do
		arg_17_0.bossAnimatorList_[iter_17_0].applyRootMotion = arg_17_0.cacheRootMotionList_[iter_17_0]

		manager.resourcePool:DestroyOrReturn(iter_17_1, ASSET_TYPE.TPOSE)
	end

	arg_17_0.bossModel_ = {}
	arg_17_0.bossAnimatorList_ = {}

	for iter_17_2, iter_17_3 in pairs(arg_17_0.loadIndexList_) do
		manager.resourcePool:StopAsyncQuest(iter_17_3)
	end

	arg_17_0.loadIndexList_ = {}

	arg_17_0:StopAllAnimatorTimer()
end

function var_0_0.PlayAppearAnimation(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = BossChallengeUICfg[arg_18_0.templateID_]
	local var_18_1 = arg_18_0.bossAnimatorList_[arg_18_1]

	arg_18_0.cacheRootMotionList_[arg_18_1] = arg_18_0.bossAnimatorList_[arg_18_1].applyRootMotion
	arg_18_0.bossAnimatorList_[arg_18_1].applyRootMotion = false

	if type(var_18_0.appear_ani) == "table" and var_18_0.appear_ani[arg_18_1] ~= "" then
		arg_18_0.bossAnimatorList_[arg_18_1]:Play(var_18_0.appear_ani[arg_18_1])

		local var_18_2

		var_18_2 = FrameTimer.New(function()
			if var_18_1:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
				var_18_2:Stop()
				table.removebyvalue(arg_18_0.animatorTimer_, var_18_2)

				var_18_2 = nil

				arg_18_2()
			end
		end, 1, -1)

		table.insert(arg_18_0.animatorTimer_, var_18_2)
		var_18_2:Start()
	else
		arg_18_2()
	end
end

function var_0_0.StopAllAnimatorTimer(arg_20_0)
	for iter_20_0 = #arg_20_0.animatorTimer_, 1, -1 do
		arg_20_0.animatorTimer_[iter_20_0]:Stop()

		arg_20_0.animatorTimer_[iter_20_0] = nil
	end
end

function var_0_0.InitBackScene(arg_21_0)
	local var_21_0 = "UI/Common/BackgroundQuad"

	arg_21_0.backGround_ = manager.resourcePool:Get(var_21_0, ASSET_TYPE.SCENE)
	arg_21_0.backGroundTrs_ = arg_21_0.backGround_.transform

	arg_21_0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	local var_21_1 = GameDisplayCfg.boss_background_pos.value

	arg_21_0.backGroundTrs_.localPosition = Vector3(var_21_1[1], var_21_1[2], var_21_1[3])
	arg_21_0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)

	local var_21_2 = GameDisplayCfg.boss_background_pos.scale

	arg_21_0.backGroundTrs_.localScale = Vector3(var_21_2[1], var_21_2[2], var_21_2[3])
	arg_21_0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = pureGetSpriteWithoutAtlas("TextureBg/Challenge_Boss/" .. CameraCfg.bossChallenge.pictureName)
end

function var_0_0.DestroyBackScene(arg_22_0)
	if arg_22_0.backGround_ then
		manager.resourcePool:DestroyOrReturn(arg_22_0.backGround_, ASSET_TYPE.SCENE)

		arg_22_0.backGround_ = nil
	end
end

return var_0_0
