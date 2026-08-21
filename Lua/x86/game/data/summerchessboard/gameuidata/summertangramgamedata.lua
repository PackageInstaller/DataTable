local var_0_0 = import("..SummerChessBoardGameUIBaseData")
local var_0_1 = class("SummerTangramGameData", var_0_0)

function var_0_1.GotoGameWindow(arg_1_0)
	local var_1_0 = arg_1_0.activityID_

	if ActivityData:GetActivityIsOpen(var_1_0) then
		JumpTools.OpenPageByJump("/tangramGameMainView", {
			chapterID = arg_1_0.chapterID or 101
		})
	end
end

function var_0_1.GetTaskIDList(arg_2_0, arg_2_1)
	local var_2_0 = {
		{
			chapterID = ActivityTangramGameChapterCfg.all[1],
			taskID = ActivityConst.ACTIVITY_3_5_TANGRAM_GAME_TASK1
		},
		{
			chapterID = ActivityTangramGameChapterCfg.all[2],
			taskID = ActivityConst.ACTIVITY_3_5_TANGRAM_GAME_TASK2
		}
	}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if ActivityData:GetActivityIsOpen(iter_2_1.taskID) then
			if iter_2_1.chapterID == ActivityTangramGameChapterCfg.all[1] then
				local var_2_2 = AssignmentCfg.get_id_list_by_activity_id[iter_2_1.taskID] or {}

				for iter_2_2, iter_2_3 in ipairs(var_2_2) do
					table.insert(var_2_1, iter_2_3)
				end
			elseif TangramGameTools:CheckChapterIsOpen(iter_2_1.chapterID) then
				local var_2_3 = AssignmentCfg.get_id_list_by_activity_id[iter_2_1.taskID] or {}

				for iter_2_4, iter_2_5 in ipairs(var_2_3) do
					table.insert(var_2_1, iter_2_5)
				end
			end
		end
	end

	return var_2_1
end

return var_0_1
