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

function var_0_0.OnQuerySkuldPizzleCompelet(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		local var_3_0 = arg_3_1.id
		local var_3_1 = not SkuldSystemData:GetLevelIDIsClear(var_3_0)

		SkuldSystemData:PassLevel(var_3_0)

		local var_3_2 = SkuldStageCfg[var_3_0].type[2]

		if var_3_2 then
			local var_3_3 = arg_3_0.reward_list

			if SkuldPuzzleStageCfg[var_3_2].walking == 0 then
				JumpTools.OpenPageByJump("skuldPuzzleSettleView", {
					levelID = var_3_0,
					rewardList = var_3_3
				}, nil, true)
			else
				JumpTools.OpenPageByJump("/skuldWalkPerformanceView", {
					stage_id = var_3_2,
					levelID = var_3_0,
					isFirst = var_3_1,
					rewardList = var_3_3
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
	local var_7_0 = SkuldStageCfg[arg_7_0]
	local var_7_1 = var_7_0.type[2]

	arg_7_1 = arg_7_1 or BattleConst.STAGE_TYPE_NEW.SKULD

	if SkuldSystemData:GetLevelIDIsOpen(arg_7_0) then
		if var_7_0.type[1] == var_0_1.BATTLE then
			local var_7_2 = BattleStageTools.GetStageCfg(arg_7_1, var_7_1)

			SkuldSystemData:CacheSkuldIconNum()

			if var_7_2.tag == BattleConst.BATTLE_TAG.STORY then
				BattleController.GetInstance():LaunchStoryBattle(arg_7_1, var_7_1, 0)
			else
				JumpTools.OpenPageByJump("/sectionSelectHero", {
					section = var_7_1,
					sectionType = arg_7_1
				}, nil, arg_7_2 or false)
			end
		elseif var_7_0.type[1] == var_0_1.PIECE then
			JumpTools.OpenPageByJump("/skuldPuzzleGameView", {
				stageID = var_7_1,
				levelID = arg_7_0
			}, nil, arg_7_2 or false)
		end
	else
		ShowTips("ACTIVITY_ZUMA_OPEN_FRONT")
	end
end

function var_0_0.RefreshAudio()
	local var_8_0 = ChapterTools.GetSkuildAudio()
	local var_8_1 = ChapterAudioCfg[var_8_0]

	manager.audio:PlayUIAudio(var_8_1.bgm_id)
end

return var_0_0
