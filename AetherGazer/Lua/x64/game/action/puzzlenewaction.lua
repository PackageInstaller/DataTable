local var_0_0 = {}
local var_0_1 = false
local var_0_2 = {}

manager.net:Bind(65301, function(arg_1_0)
	local var_1_0 = arg_1_0.activity_id

	if ActivityTools.GetActivityType(var_1_0) ~= ActivityTemplateConst.PUZZLE_NEW then
		return
	end

	if not var_0_2[var_1_0] then
		var_0_2[var_1_0] = true

		PuzzleNewTools.InitConfig(var_1_0)
	end

	PuzzleNewData:InitData(arg_1_0)

	if not var_0_1 then
		var_0_0.InitRedPoint(var_1_0)

		var_0_1 = true
	end

	PuzzleNewData:RefreshPlayRedPoint(var_1_0)
	PuzzleNewData:RefreshPieceRedPoint(var_1_0)
end)

function var_0_0.MovePuzzle(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = {
		activity_id = arg_2_0,
		puzzle_id = arg_2_1,
		target_position = arg_2_2
	}

	manager.net:SendWithLoadingNew(65302, var_2_0, 65303, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			PuzzleNewData:RefreshPlayRedPoint(arg_2_0)

			if arg_2_3 ~= nil then
				arg_2_3()
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

function var_0_0.ReceiveRegionReward(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {
		activity_id = arg_4_0,
		award_id = arg_4_1
	}

	manager.net:SendWithLoadingNew(65304, var_4_0, 65305, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			PuzzleNewData:SetRegionReceivedList(arg_4_0, arg_4_1)
			var_0_0.InitRedPoint(arg_4_0)
			manager.notify:CallUpdateFunc(PUZZLE_NEW_REGION_RECEIVED, arg_4_1, arg_5_0.reward_list)
		else
			ShowTips(arg_5_0.result)
		end
	end)
end

var_0_0.OPERATION_TYPE = {
	CHECK = 3,
	PUT = 2,
	CHECK_TIPS = 5,
	AUTO_PUT = 6
}

function var_0_0.Operation(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {
		activity_id = arg_6_0,
		type = arg_6_1
	}

	if arg_6_1 == var_0_0.OPERATION_TYPE.CHECK or arg_6_1 == var_0_0.OPERATION_TYPE.CHECK_TIPS then
		var_6_0.extra = arg_6_3
	end

	manager.net:SendWithLoadingNew(65306, var_6_0, 65307, function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			if arg_6_1 == var_0_0.OPERATION_TYPE.PUT then
				PuzzleNewData:RefreshPieceRedPoint(arg_6_0)
				PuzzleNewData:RefreshPlayRedPoint(arg_6_0)
				manager.notify:CallUpdateFunc(PUZZLE_NEW_UPDATE)
			elseif arg_6_1 == var_0_0.OPERATION_TYPE.AUTO_PUT then
				PuzzleNewData:RefreshPlayRedPoint(arg_6_0)
				manager.notify:CallUpdateFunc(PUZZLE_NEW_UPDATE)
			elseif arg_6_1 == var_0_0.OPERATION_TYPE.CHECK then
				PuzzleNewData:SetCurCheckList(arg_6_0, arg_6_3)
				manager.notify:CallUpdateFunc(PUZZLE_NEW_CHECK_UPDATE)
			elseif arg_6_1 == var_0_0.OPERATION_TYPE.CHECK_TIPS then
				PuzzleNewData:SetCheckTipsList(arg_6_0, arg_6_3)
				manager.notify:CallUpdateFunc(PUZZLE_NEW_CHECK_UPDATE)
			end

			if arg_6_2 ~= nil then
				arg_6_2()
			end
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.InitRedPoint(arg_8_0)
	local var_8_0 = not PuzzleNewData:IsCompleted(arg_8_0)
	local var_8_1
	local var_8_2
	local var_8_3
	local var_8_4 = {}
	local var_8_5 = string.format("%s_%d", RedPointConst.PUZZLE_NEW, arg_8_0)
	local var_8_6 = string.format("%s_%d", RedPointConst.PUZZLE_NEW_PLAY, arg_8_0)
	local var_8_7 = string.format("%s_%d", RedPointConst.PUZZLE_NEW_PIECE, arg_8_0)

	manager.redPoint:addGroup(var_8_6, {
		var_8_7
	})

	var_8_4[#var_8_4 + 1] = var_8_6

	if var_8_0 then
		local var_8_8
		local var_8_9
		local var_8_10 = ActivityCfg[arg_8_0].sub_activity_list

		for iter_8_0, iter_8_1 in ipairs(var_8_10) do
			if ActivityCfg[iter_8_1].activity_template == ActivityTemplateConst.TASK then
				var_8_9 = iter_8_1

				break
			end
		end

		local var_8_11 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_8_9)

		var_8_4[#var_8_4 + 1] = var_8_11
	end

	manager.redPoint:addGroup(var_8_5, var_8_4)
end

return var_0_0
