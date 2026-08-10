require("game.data.TangramGameStageTemplate")

local var_0_0 = singletonClass("TangramGameData")
local var_0_1
local var_0_2
local var_0_3
local var_0_4

function var_0_0.Init(arg_1_0)
	var_0_1 = nil
	var_0_2 = {}

	arg_1_0:ResetDecodeList()
end

function var_0_0.GetCurRunGameActivityID(arg_2_0)
	return var_0_1
end

function var_0_0.InitTrangraData(arg_3_0, arg_3_1)
	var_0_1 = arg_3_1.activity_id

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.tangram_info_list) do
		local var_3_0 = TangramGameStageTemplate.New(iter_3_1)

		var_0_2[var_3_0.stageID] = var_3_0
	end
end

function var_0_0.GetFinStageIDList(arg_4_0)
	local var_4_0 = {}

	if var_0_2 then
		for iter_4_0, iter_4_1 in pairs(var_0_2) do
			if iter_4_1.isFin then
				table.insert(var_4_0, iter_4_0)
			end
		end
	end

	return var_4_0
end

function var_0_0.GetStageInfoByStageID(arg_5_0, arg_5_1)
	if arg_5_1 then
		if var_0_2 and var_0_2[arg_5_1] then
			return var_0_2[arg_5_1]
		elseif ActivityTangramGameStageCfg[arg_5_1] then
			local var_5_0 = {
				stage_id = arg_5_1
			}
			local var_5_1 = TangramGameStageTemplate.New(var_5_0)

			var_0_2[arg_5_1] = var_5_1

			return var_0_2[arg_5_1]
		else
			print("传入错误关卡id" .. arg_5_1)
		end
	end
end

function var_0_0.CheckStageIsClear(arg_6_0, arg_6_1)
	return arg_6_0:GetStageInfoByStageID(arg_6_1).isFin
end

function var_0_0.GetChapterFinProcess(arg_7_0, arg_7_1)
	local var_7_0 = ActivityTangramGameChapterCfg[arg_7_1]

	if var_7_0 then
		local var_7_1 = var_7_0.puzzle_stage_list
		local var_7_2 = #var_7_1
		local var_7_3 = 0

		for iter_7_0, iter_7_1 in ipairs(var_7_1) do
			if var_0_2[iter_7_1] and var_0_2[iter_7_1].isFin then
				var_7_3 = var_7_3 + 1
			end
		end

		local var_7_4 = false

		if var_7_2 <= var_7_3 then
			var_7_4 = true
		end

		return var_7_4, var_7_3, var_7_2
	end
end

function var_0_0.GetChapterFinTotalProcess(arg_8_0, arg_8_1)
	local var_8_0 = ActivityTangramGameChapterCfg[arg_8_1]
	local var_8_1 = arg_8_0:GetChapterFinProcess(arg_8_1)
	local var_8_2 = arg_8_0:GetStageInfoByStageID(var_8_0.inference_stage_list[1]).isFin

	return var_8_1 and var_8_2, var_8_2
end

function var_0_0.ResetDecodeList(arg_9_0)
	var_0_3 = {}

	for iter_9_0 = 1, #ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.all[1]].puzzle_stage_list do
		var_0_3[iter_9_0] = {
			stageID = 0,
			index = iter_9_0
		}
	end

	var_0_4 = {}
end

function var_0_0.AddStageIDInList(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_2 and var_0_3[arg_10_2].stageID == arg_10_1 and not arg_10_4 then
		var_0_3[arg_10_2].stageID = 0
	elseif arg_10_2 then
		for iter_10_0 = 1, #ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.all[1]].puzzle_stage_list do
			if var_0_3[iter_10_0].stageID and var_0_3[iter_10_0].stageID == arg_10_1 then
				var_0_3[iter_10_0].stageID = 0

				break
			end
		end

		var_0_3[arg_10_2].stageID = arg_10_1
	else
		for iter_10_1 = 1, #ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.all[1]].puzzle_stage_list do
			if not var_0_3[iter_10_1].stageID or var_0_3[iter_10_1].stageID == 0 then
				var_0_3[iter_10_1].stageID = arg_10_1

				break
			end
		end
	end

	if arg_10_3 then
		manager.notify:Invoke(TANGRAM_GAME_DECODE_REFRESH)
	end
end

function var_0_0.GetStageIDinListIndex(arg_11_0, arg_11_1)
	if var_0_3 then
		for iter_11_0 = 1, #ActivityTangramGameChapterCfg[ActivityTangramGameChapterCfg.all[1]].puzzle_stage_list do
			if var_0_3[iter_11_0].stageID == arg_11_1 then
				return iter_11_0
			end
		end
	end
end

function var_0_0.CheckDecodeResult(arg_12_0, arg_12_1)
	local var_12_0 = ActivityTangramGameStageCfg[arg_12_1].answer
	local var_12_1 = true

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		if var_0_3[iter_12_0].stageID ~= iter_12_1 then
			var_12_1 = false

			break
		end
	end

	var_0_4 = {}

	return var_12_1, var_12_0
end

function var_0_0.GetDecodePreocess(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 0

	for iter_13_0, iter_13_1 in ipairs(var_0_3) do
		if iter_13_1.stageID and iter_13_1.stageID > 0 then
			var_13_1 = var_13_1 + 1
		end

		var_13_0 = var_13_0 + 1
	end

	return var_13_1, var_13_0
end

function var_0_0.GetErrorIndexList(arg_14_0, arg_14_1)
	local var_14_0 = ActivityTangramGameStageCfg[arg_14_1].answer
	local var_14_1 = {}

	for iter_14_0, iter_14_1 in ipairs(var_0_3) do
		if iter_14_1.stageID ~= 0 and iter_14_1.stageID ~= var_14_0[iter_14_0] and not var_0_4[iter_14_0] then
			table.insert(var_14_1, iter_14_0)
		end
	end

	return var_14_1
end

function var_0_0.CheckStagePosIsTrue(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1 then
		return true
	end

	local var_15_0 = ActivityTangramGameStageCfg[arg_15_2].answer[arg_15_1]
	local var_15_1 = var_0_3[arg_15_1].stageID

	if var_0_4[arg_15_1] then
		return true
	end

	if var_15_1 == 0 then
		return true
	end

	return var_15_1 == var_15_0
end

function var_0_0.AddStageChangeIndex(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 then
		var_0_4[arg_16_1] = true
	end

	if arg_16_2 then
		var_0_4[arg_16_2] = true
	end
end

function var_0_0.GetDecodeList(arg_17_0)
	return var_0_3
end

return var_0_0
