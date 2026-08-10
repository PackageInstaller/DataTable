local var_0_0 = class("SPHeroChallengeStroyItem", import("game.views.sectionSelect.SectionBaseItem"))

function var_0_0.IsOpenSectionInfo(arg_1_0)
	return arg_1_0:IsOpenRoute("spHeroChallengeSectionView")
end

function var_0_0.InitCustom(arg_2_0)
	SetActive(arg_2_0.collectGo_, false)
	SetActive(arg_2_0.storyIconGo_, false)
end

function var_0_0.OnClick(arg_3_0)
	if not arg_3_0.isLock_ then
		arg_3_0:Go("spHeroChallengeSectionView", {
			challengeType = SpHeroChallengeConst.ChapterType.story,
			sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
			section = arg_3_0.stageID_
		})
	end
end

function var_0_0.RefreshData(arg_4_0)
	return
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = arg_5_0:GetPosition()

	arg_5_0.transform_.localPosition = Vector3(var_5_0[1], var_5_0[2], 0)

	local var_5_1 = SPHeroChallengeData:GetActivityID()
	local var_5_2 = SPHeroChallengeTools:GetStoryOpenStageList(SPHeroChallengeData.activityCfg[var_5_1].storyChapter, BattleVerthandiExclusiveCfg)

	arg_5_0.isLock_ = not table.indexof(var_5_2, arg_5_0.stageID_)

	arg_5_0.isBossController_:SetSelectedState("false")
	SetActive(arg_5_0.gameObject_, not arg_5_0.isLock_)
	arg_5_0:RefreshText()
	arg_5_0:RefreshStar()
end

function var_0_0.GetPosition(arg_6_0)
	local var_6_0 = BattleVerthandiExclusiveCfg[arg_6_0.stageID_]

	return var_6_0 and var_6_0.position or {
		0,
		0
	}
end

function var_0_0.RefreshText(arg_7_0)
	arg_7_0.text_.text = BattleVerthandiExclusiveCfg[arg_7_0.stageID_].name
end

function var_0_0.RefreshStar(arg_8_0)
	if SPHeroChallengeData:GetCurActivityInfo():CheckStoryFinState(arg_8_0.stageID_) then
		for iter_8_0 = 1, 3 do
			arg_8_0.threeStarBarList_[iter_8_0]:SetData(true)
		end
	else
		for iter_8_1 = 1, 3 do
			arg_8_0.threeStarBarList_[iter_8_1]:SetData(false)
		end
	end
end

return var_0_0
