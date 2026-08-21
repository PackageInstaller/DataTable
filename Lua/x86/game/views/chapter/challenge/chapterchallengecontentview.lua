local var_0_0 = class("ChapterChallengeContentView", import("..ChapterBaseContentView"))

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.OnCtor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.initedItemIdList = {}
	arg_1_0.refreshSortItemHandler_ = handler(arg_1_0, arg_1_0.RefreshSortItem)
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
	manager.notify:RegistListener(CHALLENGE_CONTENT_REFRESH, arg_2_0.refreshSortItemHandler_)
end

function var_0_0.OnExit(arg_3_0)
	var_0_0.super.OnExit(arg_3_0)
	manager.notify:RemoveListener(CHALLENGE_CONTENT_REFRESH, arg_3_0.refreshSortItemHandler_)
end

function var_0_0.RefreshMapItems(arg_4_0)
	local var_4_0 = arg_4_0.chapterToggle_
	local var_4_1 = ChapterClientCfg.get_id_list_by_toggle[var_4_0]

	for iter_4_0 = 1, #var_4_1 do
		local var_4_2 = var_4_1[iter_4_0]

		if ChapterTools.IsChapterSystemLock(var_4_2) then
			-- block empty
		elseif var_4_2 == BattleConst.DAMAGE_TEST_CHAPTER_ID and OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.DAMAGE_TEST) then
			-- block empty
		elseif arg_4_0.initedItemIdList[var_4_2] then
			-- block empty
		else
			local var_4_3 = arg_4_0:CreateItem(var_4_2)

			if var_4_3 then
				table.insert(arg_4_0.itemList_, {
					virtualItem = ChapterBaseVirtualItemView.New(arg_4_0.mapVirtualItem_, arg_4_0.itemParent_),
					renderItem = var_4_3
				})

				arg_4_0.initedItemIdList[var_4_2] = true
			end
		end
	end
end

function var_0_0.CreateItem(arg_5_0, arg_5_1)
	local var_5_0
	local var_5_1 = ChapterClientCfg[arg_5_1].chapter_list[1]
	local var_5_2 = ChapterCfg[var_5_1]

	if var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER then
		var_5_0 = ChapterChallengeTownItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		var_5_0 = ChapterChallengeBossItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
		var_5_0 = ChapterChallengeMythicItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		var_5_0 = ChapterChallengeMatrixItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING or var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
		var_5_0 = ChapterChallengeTeachItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		var_5_0 = ChapterChallengeWarChessItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAMAGE_TEST then
		var_5_0 = ChapterChallengeDamageTestItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
		var_5_0 = ChapterChallengeAbyssItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		var_5_0 = ChapterChallengeSoloHeartDemonItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		if AdvanceTestData:GetIsActivityOpen() then
			var_5_0 = ChapterChallengeAdvanceTestItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
		end
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 then
		if SPHeroChallengeTools:CheckActivityIsOpen(ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1) then
			var_5_0 = ChapterSPHeroChallengeItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
		end
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION then
		var_5_0 = ChapterChallengeCoreVerificationItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	elseif var_5_2.type == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM then
		var_5_0 = ChapterChallengeRogueTeamItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	else
		var_5_0 = ChapterChallengeItemView.New(arg_5_0.mapItem_, arg_5_0.itemParent_, arg_5_1, arg_5_0.chapterToggle_)
	end

	return var_5_0
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.refreshSortItemHandler_ = nil

	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
