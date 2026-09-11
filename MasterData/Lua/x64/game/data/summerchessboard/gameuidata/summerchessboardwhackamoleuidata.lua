local SummerChessBoardWhackAMoleUIData = class("SummerChessBoardWhackAMoleUIData", (import("..SummerChessBoardGameUIBaseData")))

function SummerChessBoardWhackAMoleUIData:GotoGameWindow()
	WhackMoleData:SetSelected(self.activityID_)
	JumpTools.GoToSystem("/whackMoleMain", {
		activityID = self.activityID_
	})
end

function SummerChessBoardWhackAMoleUIData:GetTaskIDList(arg_2_1)
	local var_2_0 = {}
	local var_2_1 = 1

	for iter_2_0 = #WhackMoleTools.GetSessionList(self.activityID_), 2, -1 do
		if not WhackMoleTools.GetSessionIsLock(self.activityID_, iter_2_0) then
			var_2_1 = iter_2_0

			break
		end
	end

	for iter_2_1, iter_2_2 in ipairs(AssignmentCfg.get_id_list_by_activity_id[arg_2_1]) do
		if var_2_1 >= AssignmentCfg[iter_2_2].phase then
			var_2_0[#var_2_0 + 1] = iter_2_2
		end
	end

	return var_2_0
end

return SummerChessBoardWhackAMoleUIData
