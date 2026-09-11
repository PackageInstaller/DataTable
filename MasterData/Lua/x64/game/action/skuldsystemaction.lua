local var_0_0 = {}

manager.net:Bind(24051, function(arg_1_0)
	SkuldSystemData:SetData(arg_1_0)
end)

function var_0_0.QuerySkuldPizzleCompelet(arg_2_0)
	manager.net:SendWithLoadingNew(24054, {
		activity_id = ActivityConst.ACTIVITY_SKULD_MAIN,
		id = arg_2_0
	}, 24055, var_0_0.OnQuerySkuldPizzleCompelet)
end

function var_0_0:OnQuerySkuldPizzleCompelet(arg_3_1)
	if isSuccess(self.result) then
		SkuldSystemData:PassLevel(arg_3_1.id)

		if SkuldStageCfg[arg_3_1.id].type[2] then
			if SkuldPuzzleStageCfg[SkuldStageCfg[arg_3_1.id].type[2]].walking == 0 then
				JumpTools.OpenPageByJump("skuldPuzzleSettleView", {
					levelID = arg_3_1.id,
					rewardList = self.reward_list
				}, nil, true)
			else
				JumpTools.OpenPageByJump("/skuldWalkPerformanceView", {
					stage_id = SkuldStageCfg[arg_3_1.id].type[2],
					levelID = arg_3_1.id,
					isFirst = not SkuldSystemData:GetLevelIDIsClear(arg_3_1.id),
					rewardList = self.reward_list
				}, nil, true)
			end
		end
	end
end

function var_0_0.SendMark(arg_4_0)
	local var_4_0 = SkuldSystemData:GetClinetKeyByDefine(arg_4_0)

	SkuldSystemData:SetClientKey(var_4_0)
	manager.net:SendWithLoadingNew(24052, {
		activity_id = ActivityConst.ACTIVITY_SKULD_MAIN,
		key = var_4_0
	}, 24053, var_0_0.OnSendMark)
end

function var_0_0.InitRedPoint()
	SkuldSystemData:InitRedPointGroup()
	SkuldSystemData:UpdateSkuldTaskRedPoint()
	SkuldSystemData:UpdateSkuldPointRewardRedPoint()
	SkuldSystemData:UpdateSkuldStageArchiveRed()
end

function var_0_0.OnSendMark(arg_6_0, arg_6_1)
	return
end

local var_0_1 = {
	PIECE = 2,
	BATTLE = 1
}

function var_0_0.OpenSkuldBattle(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1 = arg_7_1 or BattleConst.STAGE_TYPE_NEW.SKULD

	if SkuldSystemData:GetLevelIDIsOpen(arg_7_0) then
		if SkuldStageCfg[arg_7_0].type[1] == var_0_1.BATTLE then
			SkuldSystemData:CacheSkuldIconNum()

			if BattleStageTools.GetStageCfg(arg_7_1, SkuldStageCfg[arg_7_0].type[2]).tag == BattleConst.BATTLE_TAG.STORY then
				BattleController.GetInstance():LaunchStoryBattle(arg_7_1, SkuldStageCfg[arg_7_0].type[2], 0)
			else
				JumpTools.OpenPageByJump("/sectionSelectHero", {
					section = SkuldStageCfg[arg_7_0].type[2],
					sectionType = arg_7_1
				}, nil, arg_7_2 or false)
			end
		elseif SkuldStageCfg[arg_7_0].type[1] == var_0_1.PIECE then
			JumpTools.OpenPageByJump("/skuldPuzzleGameView", {
				stageID = SkuldStageCfg[arg_7_0].type[2],
				levelID = arg_7_0
			}, nil, arg_7_2 or false)
		end
	else
		ShowTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

function var_0_0.RefreshAudio()
	manager.audio:PlayUIAudio(ChapterAudioCfg[ChapterTools.GetSkuildAudio()].bgm_id)
end

return var_0_0
