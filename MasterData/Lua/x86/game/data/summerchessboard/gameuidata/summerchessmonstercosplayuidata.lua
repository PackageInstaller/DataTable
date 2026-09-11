local SummerBlisterUIData = class("SummerBlisterUIData", (import("..SummerChessBoardGameUIBaseData")))

function SummerBlisterUIData:GotoGameWindow()
	JumpTools.OpenPageByJump("/MonsterCosplayStage", nil)
end

function SummerBlisterUIData:GetTaskIDList(arg_2_1)
	local function var_2_0(arg_3_0, arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_0) do
			if iter_3_1 then
				table.insert(arg_3_1, iter_3_0)
			end
		end

		return arg_3_1
	end

	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(ActivityCfg[arg_2_1].sub_activity_list) do
		if ActivityData:GetActivityIsOpen(iter_2_1) then
			local var_2_2 = TaskData2:GetTaskIDListByActivity(iter_2_1)

			if iter_2_0 == 2 then
				if IsConditionAchieved(ActivitySummerChessConditionCfg[32].condition) then
					var_2_1 = var_2_0(var_2_2, var_2_1)
				end
			else
				var_2_1 = var_2_0(var_2_2, var_2_1)
			end
		end
	end

	table.sort(var_2_1, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	return var_2_1
end

return SummerBlisterUIData
