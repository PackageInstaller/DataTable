local var_0_0 = class("SPHeroChallengeBossView", import(".SPHeroChallengeBattleStageBaseView"))

function var_0_0.UIName(arg_1_0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeBossUI"
end

function var_0_0.Init(arg_2_0)
	arg_2_0.super.Init(arg_2_0)

	arg_2_0.lockController = arg_2_0.controller:GetController("lock")
	arg_2_0.openController = arg_2_0.controller:GetController("open")
	arg_2_0.stageInfoController = arg_2_0.controller:GetController("stageInfo")
	arg_2_0.buttonItem = {}

	for iter_2_0 = 1, 2 do
		arg_2_0.buttonItem[iter_2_0] = SPHeroChallengeBossStageItem.New(arg_2_0["bossitem" .. iter_2_0 .. "Go_"])

		arg_2_0.buttonItem[iter_2_0]:RegisterClickCallBack(handler(arg_2_0, arg_2_0.ShowStageInfoView))
	end

	arg_2_0:AddListeners()

	arg_2_0.challengeTimeController_ = arg_2_0.controller:GetController("challengeTime")
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0:RegisterEvents()
	arg_3_0:RefreshView()
end

function var_0_0.RegisterEvents(arg_4_0)
	arg_4_0:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_BOSS, function()
		local var_5_0 = SPHeroChallengeData:GetActivityID()
		local var_5_1 = SPHeroChallengeData.activityCfg[var_5_0].bossChapter
		local var_5_2, var_5_3 = SPHeroChallengeTools:GetChapterIsOpen(var_5_1)

		arg_4_0.params_.showFlag = var_5_2

		arg_4_0:RefreshView()
	end)
	arg_4_0:RegistEventListener(SP_HERO_CHALLENGE_UPDATE_CHALLENGE, function()
		arg_4_0:RefreshPlayTime()
	end)
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0.selectStage = nil

	arg_7_0:RemoveAllEventListener()
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.equiptipBtn_, nil, function()
		if arg_8_0.equipSuit then
			ShowPopEquipSuit(arg_8_0.equipSuit, true)
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.timeInfoBtn, nil, function()
		if arg_8_0.challengeTimeController_:GetSelectedState() == "show" then
			arg_8_0.challengeTimeController_:SetSelectedState("showTip")

			arg_8_0.infoTipText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")
		else
			arg_8_0.challengeTimeController_:SetSelectedState("show")
		end
	end)
end

function var_0_0.ShowStageInfoView(arg_11_0, arg_11_1)
	if SPHeroChallengeTools:CheckBossActivityIsOpen() then
		JumpTools.OpenPageByJump("spHeroChallengeSectionView", {
			section = arg_11_1,
			sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
			activityId = arg_11_0.activityID,
			challengeType = SpHeroChallengeConst.ChapterType.boss
		})

		arg_11_0.selectStage = arg_11_1

		arg_11_0:RefreshStageItem()
	else
		ShowTips("SOLO_NOT_OPEN")
	end
end

function var_0_0.RefreshView(arg_12_0)
	arg_12_0.info = SPHeroChallengeData:GetCurActivityInfo()
	arg_12_0.activityID = SPHeroChallengeData:GetActivityID()

	arg_12_0:RefreshLockState()
	arg_12_0:RefreshOpenState()
	arg_12_0:RefreshErosion()
	arg_12_0:RefreshStageItem()
	arg_12_0:RefreshEquipInfo()
	arg_12_0:RefreshPlayTime()

	if arg_12_0:IsOpenSectionView() then
		arg_12_0.stageInfoController:SetSelectedState("open")
	else
		arg_12_0.stageInfoController:SetSelectedState("close")
	end
end

function var_0_0.OnUpdate(arg_13_0)
	if arg_13_0:IsOpenSectionView() then
		arg_13_0.stageInfoController:SetSelectedState("open")
	else
		arg_13_0.stageInfoController:SetSelectedState("close")
	end
end

function var_0_0.IsOpenSectionView(arg_14_0)
	return arg_14_0:IsOpenRoute("spHeroChallengeSectionView")
end

function var_0_0.RefreshPlayTime(arg_15_0)
	arg_15_0.totalNum, arg_15_0.curNum = SPHeroChallengeData:GetCurActivityInfo():GetChallengeTimes()

	local var_15_0 = arg_15_0.totalNum - arg_15_0.curNum
	local var_15_1

	if var_15_0 <= 0 then
		var_15_1 = string.format("<color='#FF000B'>%d</color>", tostring(var_15_0))
	else
		var_15_1 = tostring(var_15_0)
	end

	arg_15_0.challengeTime.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REMAIN_TIME"), var_15_1, tonumber(1))
end

function var_0_0.RefreshErosion(arg_16_0)
	local var_16_0 = arg_16_0.info:GetBossErosiveness()

	arg_16_0.percenttextText_.text = var_16_0 .. "%"
	arg_16_0.sliderImg_.fillAmount = var_16_0 / 100
end

function var_0_0.RefreshOpenState(arg_17_0)
	arg_17_0.bossActivityID = SPHeroChallengeData.activityCfg[arg_17_0.activityID].bossActivityID

	if ActivityData:GetActivityIsOpen(arg_17_0.bossActivityID) and arg_17_0.info.bossStart then
		arg_17_0.openController:SetSelectedState("unlock")
	else
		arg_17_0.openController:SetSelectedState("lock")

		arg_17_0.lockdescText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BOSS_OPEN_TIME")
	end
end

function var_0_0.RefreshLockState(arg_18_0)
	if not arg_18_0.params_.showFlag then
		arg_18_0.lockController:SetSelectedState("not")

		if arg_18_0.params_.reason then
			if not arg_18_0.info.bossStart then
				local var_18_0 = SPHeroChallengeData.activityCfg[arg_18_0.activityID]

				if SPHeroChallengeTools:GetChapterIsOpen(var_18_0.storyChapter) and SPHeroChallengeTools:GetChapterIsOpen(var_18_0.trainChapter) then
					arg_18_0.lockText.text = GetTips("ACTIVITY_HERO_CHALLENGE_BOSS_OPEN_TIME")
				else
					arg_18_0.lockText.text = GetTips("ACTIVITY_HERO_CHALLENGE_LOCK_TIP")
				end
			else
				arg_18_0.lockText.text = GetTips(arg_18_0.params_.reason)
			end
		end
	else
		arg_18_0.lockController:SetSelectedState("open")
	end
end

function var_0_0.RefreshStageItem(arg_19_0)
	if arg_19_0.buttonItem then
		local var_19_0 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[SpHeroChallengeConst.BattleSubType.boss]

		for iter_19_0, iter_19_1 in ipairs(arg_19_0.buttonItem) do
			iter_19_1:RefreshUI(var_19_0[iter_19_0], arg_19_0.selectStage)
		end
	end
end

function var_0_0.RefreshEquipInfo(arg_20_0)
	local var_20_0 = ActivityRewardPoolCfg.get_id_list_by_activity_id[arg_20_0.bossActivityID][1]

	if var_20_0 then
		local var_20_1 = ActivityRewardPoolItemCfg.get_id_list_by_activity_id[var_20_0]
		local var_20_2 = 0
		local var_20_3 = SPHeroChallengeData:GetCurActivityInfo()
		local var_20_4 = 0

		if var_20_3.equipList then
			var_20_4 = #var_20_3.equipList
		end

		local var_20_5 = 1

		for iter_20_0, iter_20_1 in ipairs(var_20_1) do
			var_20_2 = var_20_2 + ActivityRewardPoolItemCfg[iter_20_1].reward[2] * ActivityRewardPoolItemCfg[iter_20_1].total
			var_20_5 = ActivityRewardPoolItemCfg[iter_20_1].reward[1]
		end

		arg_20_0.numText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_EQUIP_NUM"), var_20_4, var_20_2)
		arg_20_0.equipSuit = EquipCfg[var_20_5].suit

		local var_20_6 = EquipSuitCfg[arg_20_0.equipSuit]

		if var_20_6 then
			SetSpriteWithoutAtlasAsync(arg_20_0.iconImg_, SpritePathCfg.EquipIcon_s.path .. var_20_6.equip_skill_icon)

			arg_20_0.nameText_.text = var_20_6.name
		end
	end
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.buttonItem then
		for iter_21_0, iter_21_1 in pairs(arg_21_0.buttonItem) do
			iter_21_1:Dispose()
		end

		arg_21_0.buttonItem = nil
	end

	arg_21_0.super.Dispose(arg_21_0)
end

return var_0_0
