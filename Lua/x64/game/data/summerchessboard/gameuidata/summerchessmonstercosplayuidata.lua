local var_0_0 = import("..SummerChessBoardGameUIBaseData")
local var_0_1 = class("SummerBlisterUIData", var_0_0)

function var_0_1.GotoGameWindow(arg_1_0)
	JumpTools.OpenPageByJump("/MonsterCosplayStage", nil)
end

function var_0_1.GetTaskIDList(arg_2_0, arg_2_1)
	local function var_2_0(arg_3_0, arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_0) do
			if iter_3_1 then
				table.insert(arg_3_1, iter_3_0)
			end
		end

		return arg_3_1
	end

	local var_2_1 = ActivityCfg[arg_2_1]
	local var_2_2 = ActivitySummerChessConditionCfg[32].condition
	local var_2_3 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_1.sub_activity_list) do
		if ActivityData:GetActivityIsOpen(iter_2_1) then
			local var_2_4 = TaskData2:GetTaskIDListByActivity(iter_2_1)

			if iter_2_0 == 2 then
				if IsConditionAchieved(var_2_2) then
					var_2_3 = var_2_0(var_2_4, var_2_3)
				end
			else
				var_2_3 = var_2_0(var_2_4, var_2_3)
			end
		end
	end

	table.sort(var_2_3, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	return var_2_3
end

return var_0_1
