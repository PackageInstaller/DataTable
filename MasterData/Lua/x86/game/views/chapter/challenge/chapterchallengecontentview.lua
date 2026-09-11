local ChapterChallengeContentView = class("ChapterChallengeContentView", import("..ChapterBaseContentView"))

function ChapterChallengeContentView:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	ChapterChallengeContentView.super.OnCtor(self, arg_1_1, arg_1_2)

	self.initedItemIdList = {}
	self.refreshSortItemHandler_ = handler(self, self.RefreshSortItem)
end

function ChapterChallengeContentView:OnEnter()
	ChapterChallengeContentView.super.OnEnter(self)
	manager.notify:RegistListener(CHALLENGE_CONTENT_REFRESH, self.refreshSortItemHandler_)
end

function ChapterChallengeContentView:OnExit()
	ChapterChallengeContentView.super.OnExit(self)
	manager.notify:RemoveListener(CHALLENGE_CONTENT_REFRESH, self.refreshSortItemHandler_)
end

function ChapterChallengeContentView:RefreshMapItems()
	for iter_4_0 = 1, #ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_] do
		if ChapterTools.IsChapterSystemLock(ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_4_0]) then
			-- block empty
		elseif ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_4_0] == BattleConst.DAMAGE_TEST_CHAPTER_ID and OperationData:IsFunctionStoped(OperationConst.OPERATION_STOP.DAMAGE_TEST) then
			-- block empty
		elseif self.initedItemIdList[ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_4_0]] then
			-- block empty
		else
			local var_4_0 = self:CreateItem(ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_4_0])

			if var_4_0 then
				table.insert(self.itemList_, {
					virtualItem = ChapterBaseVirtualItemView.New(self.mapVirtualItem_, self.itemParent_),
					renderItem = var_4_0
				})

				self.initedItemIdList[ChapterClientCfg.get_id_list_by_toggle[self.chapterToggle_][iter_4_0]] = true
			end
		end
	end
end

function ChapterChallengeContentView:CreateItem(arg_5_1)
	local var_5_0

	if ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER then
		var_5_0 = ChapterChallengeTownItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE then
		var_5_0 = ChapterChallengeBossItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MYTHIC then
		var_5_0 = ChapterChallengeMythicItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_MATRIX then
		var_5_0 = ChapterChallengeMatrixItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING or ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING then
		var_5_0 = ChapterChallengeTeachItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_CHESS then
		var_5_0 = ChapterChallengeWarChessItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAMAGE_TEST then
		var_5_0 = ChapterChallengeDamageTestItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ABYSS then
		var_5_0 = ChapterChallengeAbyssItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.SOLO_HEART_DEMON then
		var_5_0 = ChapterChallengeSoloHeartDemonItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ADVANCE_TEST then
		if AdvanceTestData:GetIsActivityOpen() then
			var_5_0 = ChapterChallengeAdvanceTestItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
		end
	elseif ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1 then
		if SPHeroChallengeTools:CheckActivityIsOpen(ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1) then
			var_5_0 = ChapterSPHeroChallengeItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
		end
	else
		var_5_0 = ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.CORE_VERIFICATION and ChapterChallengeCoreVerificationItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_) or ChapterCfg[ChapterClientCfg[arg_5_1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.CHALLENGE_ROGUE_TEAM and ChapterChallengeRogueTeamItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_) or ChapterChallengeItemView.New(self.mapItem_, self.itemParent_, arg_5_1, self.chapterToggle_)
	end

	return var_5_0
end

function ChapterChallengeContentView:Dispose()
	self.refreshSortItemHandler_ = nil

	ChapterChallengeContentView.super.Dispose(self)
end

return ChapterChallengeContentView
