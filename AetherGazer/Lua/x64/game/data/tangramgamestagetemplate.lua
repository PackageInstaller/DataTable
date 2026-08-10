TangramGameStageTemplate = class("TangramGameStageTemplate")

function TangramGameStageTemplate.Ctor(arg_1_0, arg_1_1)
	arg_1_0.stageID = arg_1_1.stage_id
	arg_1_0.stageType = ActivityTangramGameStageCfg[arg_1_0.stageID].stage_type
	arg_1_0.finishChipList = {}

	if arg_1_1.tips_id_list then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.tips_id_list) do
			table.insert(arg_1_0.finishChipList, iter_1_1)
		end
	end

	arg_1_0.isFin = false
	arg_1_0.isWatch = arg_1_1.is_animation_finish or false

	arg_1_0:UpdataFinState()
end

function TangramGameStageTemplate.UpdataStageProcess(arg_2_0, arg_2_1)
	arg_2_0.finishChipList = arg_2_1

	arg_2_0:UpdataFinState()
end

function TangramGameStageTemplate.UpdataFinState(arg_3_0)
	if arg_3_0.stageType == TangramGameConst.stageType.thread or arg_3_0.stageType == TangramGameConst.stageType.specialThread then
		if #arg_3_0.finishChipList == ActivityTangramGameStageCfg[arg_3_0.stageID].clue_num then
			arg_3_0.isFin = true

			manager.notify:Invoke(TANGRAM_GAME_STAGE_CLEAR, arg_3_0.stageID)
		end
	elseif arg_3_0.stageType == TangramGameConst.stageType.decode then
		arg_3_0.isFin = true

		for iter_3_0, iter_3_1 in ipairs(ActivityTangramGameStageCfg[arg_3_0.stageID].answer) do
			if iter_3_1 ~= arg_3_0.finishChipList[iter_3_0] then
				arg_3_0.isFin = false

				break
			end
		end
	end
end

function TangramGameStageTemplate.GetInferenceStageWatchPlay(arg_4_0)
	if arg_4_0.stageType == TangramGameConst.stageType.decode then
		return arg_4_0.isWatch
	else
		Debug.LogError("非推理关卡" .. arg_4_0.stageID)
	end
end
