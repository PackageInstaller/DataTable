local var_0_0 = singletonClass("OsirisPlayGameData")
local OsirisPlayGameTempHeroData = require("game.data.OsirisPlayGameTempHeroData")
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = 1
local var_0_5 = {}
local var_0_6
local var_0_7 = 0
local var_0_8 = 0
local var_0_9 = {}
local var_0_10 = {}

function var_0_0.InitRedPointGroup(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}

	if ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME) then
		for iter_1_0, iter_1_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK].sub_activity_list) do
			table.insert(var_1_0, RedPointConst.OSIRIS_PLAY_GAME_TASK_TAG .. iter_1_1)

			local var_1_2 = {}

			for iter_1_2, iter_1_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_1_1]) do
				table.insert(var_1_2, RedPointConst.OSIRIS_PLAY_GAME_TASK_ITEM .. iter_1_3)
			end

			manager.redPoint:addGroup(RedPointConst.OSIRIS_PLAY_GAME_TASK_TAG .. iter_1_1, var_1_2)
		end

		if AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK] then
			for iter_1_4, iter_1_5 in ipairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK]) do
				table.insert(var_1_1, RedPointConst.OSIRIS_PLAY_GAME_POINT_REWARD .. iter_1_5)
			end
		end
	end

	manager.redPoint:addGroup(RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK, var_1_0)
	manager.redPoint:addGroup(RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK, var_1_1)
	manager.notify:RegistListener(OSIRIS_TASK_UPDATE, function()
		var_0_0:UpdateOsirisTaskRedPoint()
	end)
	manager.notify:RegistListener(RECEIVE_POINT_REWARD, function()
		var_0_0:UpdateRecordRedPoint()
	end)
	manager.redPoint:addGroup(RedPointConst.OSIRIS_PLAY_GAME_MAIN .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME, {
		RedPointConst.OSIRIS_PLAY_GAME_TASK_ALL .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK,
		RedPointConst.OSIRIS_PLAY_GAME_LEVEL_REWARD .. "_" .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME
	})
	var_0_0:UpdateOsirisTaskRedPoint()
	var_0_0:UpdateRecordRedPoint()
end

function var_0_0.UpdateOsirisTaskRedPoint(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(ActivityCfg[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK].sub_activity_list) do
		local var_4_0 = ActivityData:GetActivityIsOpen(iter_4_1)

		for iter_4_2, iter_4_3 in pairs(AssignmentCfg.get_id_list_by_activity_id[iter_4_1]) do
			if var_4_0 then
				local var_4_1 = TaskData2:GetTaskProgress(iter_4_3)

				if TaskData2:GetTaskComplete(iter_4_3) then
					manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_TASK_ITEM .. iter_4_3, 0)
				elseif var_4_1 >= AssignmentCfg[iter_4_3].need then
					manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_TASK_ITEM .. iter_4_3, 1)
				else
					manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_TASK_ITEM .. iter_4_3, 0)
				end
			else
				manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_TASK_ITEM .. iter_4_3, 0)
			end
		end
	end

	if AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK] then
		local var_4_3 = ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK)

		for iter_4_4, iter_4_5 in ipairs(AssignmentCfg.get_id_list_by_activity_id[ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME_ACCUMULATE_TASK]) do
			if var_4_3 then
				local var_4_4 = TaskData2:GetTaskProgress(iter_4_5)

				if TaskData2:GetTaskComplete(iter_4_5) then
					manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_POINT_REWARD .. iter_4_5, 0)
				elseif var_4_4 >= AssignmentCfg[iter_4_5].need then
					manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_POINT_REWARD .. iter_4_5, 1)
				else
					manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_POINT_REWARD .. iter_4_5, 0)
				end
			else
				manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_POINT_REWARD .. iter_4_5, 0)
			end
		end
	end
end

function var_0_0.Init(arg_5_0, arg_5_1)
	var_0_2 = {}
	var_0_3 = {}
	var_0_5 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.pass_stages) do
		table.insert(var_0_2, iter_5_1)

		var_0_5[iter_5_1.stage_id] = var_0_5[iter_5_1.stage_id] or 1
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_1.pass_chapters) do
		table.insert(var_0_3, iter_5_3)
	end

	OsirisPlayGameTempHeroData:Init()
	var_0_0:InitTempHeroData()
end

function var_0_0.UpdatePassStages(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1.pass_stages) do
		local var_6_0 = false

		for iter_6_2, iter_6_3 in ipairs(var_0_2) do
			if iter_6_1.stage_id == iter_6_3.stage_id then
				var_6_0 = true
			end
		end

		if not var_6_0 then
			table.insert(var_0_2, iter_6_1)
		end
	end

	var_0_0:InitTempHeroData()
end

function var_0_0.UpdatePassChapters(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1.pass_chapters) do
		table.insert(var_0_3, iter_7_1)
	end
end

function var_0_0.UpdateCurStageInfo(arg_8_0, arg_8_1)
	var_0_6 = arg_8_1.pass_stage

	for iter_8_0, iter_8_1 in ipairs(var_0_2) do
		if iter_8_1.stage_id == var_0_6.stage_id and var_0_2[iter_8_0].point <= var_0_6.point then
			var_0_2[iter_8_0] = var_0_6
		end
	end
end

function var_0_0.GetCurStageInfo(arg_9_0)
	return var_0_6
end

function var_0_0.GetPassStages(arg_10_0)
	return var_0_2
end

function var_0_0.GetPassChapters(arg_11_0)
	return var_0_3
end

function var_0_0.IsPassChaptersById(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(var_0_3) do
		if iter_12_1 == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetPassStagesNumByChapterId(arg_13_0, arg_13_1)
	local var_13_0 = 0

	for iter_13_0, iter_13_1 in ipairs(var_0_2) do
		if arg_13_1 == ActivityGeneralityStageCfg[ActivityGeneralityStageCfg.get_id_list_by_stage_id[iter_13_1.stage_id][1]].chapter_id then
			var_13_0 = var_13_0 + 1
		end
	end

	return var_13_0
end

function var_0_0.IsPassStagesByStageId(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(var_0_2) do
		if arg_14_1 == iter_14_1.stage_id then
			return true
		end
	end

	return false
end

function var_0_0.InitTempHeroData(arg_15_0)
	OsirisPlayGameTempHeroData:ModifyAllHeroInfo(var_0_2)
end

function var_0_0.SetHeroDataTypeByPos(arg_16_0, arg_16_1)
	var_0_4 = arg_16_1
end

function var_0_0.GetCurHeroDataType(arg_17_0)
	return var_0_4
end

function var_0_0.SetPassStageClearTimes(arg_18_0, arg_18_1)
	var_0_5[arg_18_1] = not var_0_5[arg_18_1] and 0 or 1
end

function var_0_0.GetPassStageClearTimes(arg_19_0)
	return var_0_5
end

function var_0_0.GetPassStageClearTimesByStageId(arg_20_0, arg_20_1)
	return var_0_5[arg_20_1]
end

function var_0_0.GetStageInfoById(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(var_0_2) do
		if iter_21_1.stage_id == arg_21_1 then
			return iter_21_1
		end
	end

	return {}
end

function var_0_0.SetPlayStory(arg_22_0, arg_22_1)
	saveData("osirisPlayGame", "playStory" .. arg_22_1, 1)
end

function var_0_0.GetPlayStory(arg_23_0, arg_23_1)
	return (getData("osirisPlayGame", "playStory" .. arg_23_1))
end

function var_0_0:InitActivityPointData(arg_24_1)
	if arg_24_1.activity_id == ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME then
		var_0_7 = arg_24_1.activity_id
		var_0_8 = arg_24_1.point
		var_0_9 = arg_24_1.reward_list or {}

		self:UpdateTaskStateList()
		self:UpdateRecordRedPoint()
	end
end

function var_0_0.UpdateTaskStateList(arg_25_0)
	for iter_25_0, iter_25_1 in ipairs(ActivityPointRewardCfg.get_id_list_by_activity_id[var_0_7] or {}) do
		local var_25_0 = {
			state = 0,
			id = iter_25_1
		}

		if var_0_8 >= ActivityPointRewardCfg[iter_25_1].need then
			var_25_0.state = 1
		end

		if table.indexof(var_0_9, iter_25_1) then
			var_25_0.state = 2
		end

		if not var_0_10[iter_25_0] then
			table.insert(var_0_10, var_25_0)
		else
			var_0_10[iter_25_0] = var_25_0
		end
	end

	table.sort(var_0_10, function(arg_26_0, arg_26_1)
		local var_26_0

		if ActivityPointRewardCfg[arg_26_0.id] then
			var_26_0 = ActivityPointRewardCfg[arg_26_0.id].need or 0

			local var_26_1

			if ActivityPointRewardCfg[arg_26_1.id] then
				var_26_1 = ActivityPointRewardCfg[arg_26_1.id].need or 0
			end
		end

		return var_26_0 < var_26_1
	end)
end

function var_0_0:RefreshTaskData(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(var_0_10) do
		for iter_27_2, iter_27_3 in ipairs(arg_27_1) do
			if iter_27_1.id == iter_27_3 then
				var_0_10[iter_27_0].state = 2
			end
		end
	end

	manager.notify:Invoke(OSIRISPLAYGAME_UPDATE_TASK)
	self:UpdateRecordRedPoint()
end

function var_0_0.GetNum(arg_28_0)
	return var_0_8
end

function var_0_0.IsCompleteID(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(var_0_10) do
		if iter_29_1.id == arg_29_1 then
			return iter_29_1.state
		end
	end

	return 0
end

function var_0_0.GetList(arg_30_0)
	return var_0_10
end

function var_0_0.UpdateRecordRedPoint(arg_31_0)
	local var_31_0 = false

	for iter_31_0, iter_31_1 in ipairs(var_0_10) do
		if var_0_10[iter_31_0].state == 1 then
			var_31_0 = true

			break
		end
	end

	manager.redPoint:setTip(RedPointConst.OSIRIS_PLAY_GAME_LEVEL_REWARD .. "_" .. ActivityConst.ACTIVITY_OSIRIS_PLAY_GAME, var_31_0 and 1 or 0)
end

local var_0_11 = 0

function var_0_0.SetFirstUnlock(arg_32_0, arg_32_1)
	var_0_11 = arg_32_1
end

function var_0_0.GetFirstUnlock(arg_33_0)
	return var_0_11
end

return var_0_0
