local SummerTangramGameData = class("SummerTangramGameData", (import("..SummerChessBoardGameUIBaseData")))

function SummerTangramGameData:GotoGameWindow()
	if ActivityData:GetActivityIsOpen(self.activityID_) then
		local var_1_0 = {}

		var_1_0.chapterID = self.chapterID or 101

		JumpTools.OpenPageByJump("/tangramGameMainView", var_1_0)
	end
end

function SummerTangramGameData:GetTaskIDList(arg_2_1)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs({
		{
			chapterID = ActivityTangramGameChapterCfg.all[1],
			taskID = ActivityConst.ACTIVITY_3_5_TANGRAM_GAME_TASK1
		},
		{
			chapterID = ActivityTangramGameChapterCfg.all[2],
			taskID = ActivityConst.ACTIVITY_3_5_TANGRAM_GAME_TASK2
		}
	}) do
		if ActivityData:GetActivityIsOpen(iter_2_1.taskID) then
			if iter_2_1.chapterID == ActivityTangramGameChapterCfg.all[1] then
				for iter_2_2, iter_2_3 in ipairs(AssignmentCfg.get_id_list_by_activity_id[iter_2_1.taskID] or {}) do
					table.insert(var_2_0, iter_2_3)
				end
			elseif TangramGameTools:CheckChapterIsOpen(iter_2_1.chapterID) then
				for iter_2_4, iter_2_5 in ipairs(AssignmentCfg.get_id_list_by_activity_id[iter_2_1.taskID] or {}) do
					table.insert(var_2_0, iter_2_5)
				end
			end
		end
	end

	return var_2_0
end

return SummerTangramGameData
