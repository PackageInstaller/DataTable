local var_0_0 = {}

manager.net:Bind(60101, function(arg_1_0)
	PuzzleData:InitData(arg_1_0)
end)

var_0_0.OPERATION_TYPE = {
	receive = 4,
	complete = 5,
	help = 2,
	reset = 3,
	move = 1
}

function var_0_0.Operate(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {
		activity_id = arg_2_0,
		operate_type = arg_2_1
	}

	if arg_2_3 ~= nil then
		var_2_0.puzzle_id = arg_2_3
	end

	manager.net:SendWithLoadingNew(60102, var_2_0, 60103, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			if arg_2_2 ~= nil then
				if arg_2_1 == var_0_0.OPERATION_TYPE.help then
					arg_2_2(true)
				elseif arg_2_1 == var_0_0.OPERATION_TYPE.complete then
					arg_2_2(false)
				else
					arg_2_2(arg_2_3, arg_3_0)
				end
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

function var_0_0.InitRedPointKey(arg_4_0)
	local var_4_0 = ActivityData:GetActivityData(arg_4_0).subActivityIdList
	local var_4_1 = {}
	local var_4_2

	for iter_4_0, iter_4_1 in pairs(var_4_0) do
		local var_4_3 = {}

		var_4_3[#var_4_3 + 1] = string.format("%s_%s_%s_normal", RedPointConst.ACTIVITY_PUZZLE, arg_4_0, iter_4_1)
		var_4_3[#var_4_3 + 1] = string.format("%s_%s_%s_video", RedPointConst.ACTIVITY_PUZZLE, arg_4_0, iter_4_1)

		local var_4_4 = string.format("%s_%s_%s", RedPointConst.ACTIVITY_PUZZLE, arg_4_0, iter_4_1)

		manager.redPoint:addGroup(var_4_4, var_4_3)

		var_4_1[#var_4_1 + 1] = var_4_4
	end

	manager.redPoint:addGroup(string.format("%s_%s", RedPointConst.ACTIVITY_PUZZLE, arg_4_0), var_4_1)
end

return var_0_0
