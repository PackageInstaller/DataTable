local var_0_0 = {}

manager.net:Bind(65301, function(arg_1_0)
	local var_1_0 = arg_1_0.activity_id

	if ActivityTools.GetActivityType(var_1_0) ~= ActivityTemplateConst.TANGRAM_PUZZLE then
		return
	end

	if not TangramPuzzleData:IsInited(var_1_0) then
		TangramPuzzleTools.InitConfig(var_1_0)
	end

	TangramPuzzleData:InitData(arg_1_0)
	var_0_0.InitRedPoint(var_1_0)
	var_0_0.RefreshClueRedPoint(var_1_0)
end)

function var_0_0.MovePuzzle(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = TangramPuzzleData:GetCurPuzzleDic(arg_2_0)[arg_2_1]
	local var_2_1 = {
		activity_id = arg_2_0,
		puzzle_id = var_2_0,
		target_position = arg_2_2
	}

	manager.net:SendWithLoadingNew(65302, var_2_1, 65303, function(arg_3_0)
		if isSuccess(arg_3_0.result) then
			TangramPuzzleData:ExchangePuzzle(arg_2_0, arg_2_1, arg_2_2)
			manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_MOVE, arg_2_1, arg_2_2)

			if arg_2_3 ~= nil then
				arg_2_3(arg_2_1, arg_2_2)
			end
		else
			ShowTips(arg_3_0.result)
		end
	end)
end

function var_0_0.RotateRegion(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = TangramPuzzleTools.GetPuzzleGlobalIndexListByRegionID(arg_4_0)[arg_4_1]
	local var_4_1 = arg_4_2 > 0
	local var_4_2 = var_4_0[1]
	local var_4_3

	if var_4_1 == true then
		var_4_3 = var_4_0[2]
	else
		var_4_3 = var_4_0[#var_4_0]
	end

	local var_4_4 = TangramPuzzleData:GetCurPuzzleDic(arg_4_0)[var_4_2]
	local var_4_5 = {
		activity_id = arg_4_0,
		puzzle_id = var_4_4,
		target_position = var_4_3
	}

	manager.net:SendWithLoadingNew(65302, var_4_5, 65303, function(arg_5_0)
		if isSuccess(arg_5_0.result) then
			TangramPuzzleData:RetateRegion(arg_4_0, arg_4_1, arg_4_2)
			manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_REGION_ROTATE, arg_4_1, arg_4_2)
		else
			ShowTips(arg_5_0.result)
		end
	end)
end

function var_0_0.ReceiveRegionReward(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {
		activity_id = arg_6_0,
		award_id = arg_6_1
	}

	manager.net:SendWithLoadingNew(65304, var_6_0, 65305, function(arg_7_0)
		if isSuccess(arg_7_0.result) then
			TangramPuzzleData:SetRegionReceivedDic(arg_6_0, arg_6_1)
			var_0_0.RefreshClueRedPoint(arg_6_0)
			manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_REGION_RECEIVED, arg_6_1, arg_7_0.reward_list)
		else
			ShowTips(arg_7_0.result)
		end
	end)
end

function var_0_0.ReceiveFinalReward(arg_8_0)
	local var_8_0 = {
		activity_id = arg_8_0,
		award_id = {
			0
		}
	}

	manager.net:SendWithLoadingNew(65304, var_8_0, 65305, function(arg_9_0)
		if isSuccess(arg_9_0.result) then
			local var_9_0 = arg_9_0.reward_list

			getReward2(var_9_0)
			TangramPuzzleData:SetRegionReceivedDic(arg_8_0, {
				0
			})
			manager.notify:CallUpdateFunc(TANGRAM_PUUZLE_FINAL_REWARD_RECEIVED)
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

var_0_0.OPERATION_TYPE = {
	FULL_AUTO_PUT = 8,
	CLUE = 3
}

function var_0_0.Operation(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = {
		activity_id = arg_10_0,
		type = arg_10_1
	}

	if arg_10_1 == var_0_0.OPERATION_TYPE.CLUE then
		var_10_0.extra = arg_10_2.clueID
	elseif arg_10_1 == var_0_0.OPERATION_TYPE.ROTATE then
		var_10_0.extra = arg_10_2.regionID
	end

	manager.net:SendWithLoadingNew(65306, var_10_0, 65307, function(arg_11_0)
		if isSuccess(arg_11_0.result) then
			if arg_10_1 == var_0_0.OPERATION_TYPE.FULL_AUTO_PUT then
				manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_AUTO_PUT)
			elseif arg_10_1 == var_0_0.OPERATION_TYPE.CLUE then
				local var_11_0 = var_10_0.extra

				TangramPuzzleData:SetCurClueDic(arg_10_0, var_11_0)
				var_0_0.RefreshClueRedPoint(arg_10_0)

				if TangramPuzzleTools.IsAllClueCompleted(arg_10_0) then
					var_0_0.InitRedPoint(arg_10_0)
				end

				manager.notify:CallUpdateFunc(TANGRAM_PUZZLE_CLUE_UPDATE)
			end

			if arg_10_3 ~= nil then
				arg_10_3()
			end
		else
			ShowTips(arg_11_0.result)
		end
	end)
end

function var_0_0.InitRedPoint(arg_12_0)
	local var_12_0 = not TangramPuzzleTools.IsAllClueCompleted(arg_12_0)
	local var_12_1 = string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE, arg_12_0)
	local var_12_2 = string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE_CLUE, arg_12_0)
	local var_12_3 = {
		var_12_2
	}

	if var_12_0 then
		local var_12_4
		local var_12_5 = ActivityCfg[arg_12_0].sub_activity_list

		for iter_12_0, iter_12_1 in ipairs(var_12_5) do
			if ActivityCfg[iter_12_1].activity_template == ActivityTemplateConst.TASK then
				var_12_4 = iter_12_1

				break
			end
		end

		local var_12_6 = string.format("%s_%d", RedPointConst.ACTIVITY_TASK, var_12_4)

		var_12_3[#var_12_3 + 1] = var_12_6
	end

	manager.redPoint:addGroup(var_12_1, var_12_3, false)
end

function var_0_0.RefreshClueRedPoint(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = TangramPuzzleData:GetCurClueDic(arg_13_0)
	local var_13_2 = TangramPuzzleTools.GetClueListByRegionType(arg_13_0)

	for iter_13_0, iter_13_1 in pairs(var_13_2) do
		local var_13_3 = false

		if TangramPuzzleTools.IsAllRegionReceived(arg_13_0, iter_13_0) then
			for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
				if not var_13_1[iter_13_3] then
					var_13_3 = true
					var_13_0 = 1

					break
				end
			end
		end

		if var_13_3 then
			break
		end
	end

	manager.redPoint:setTip(string.format("%s_%d", RedPointConst.TANGRAM_PUZZLE_CLUE, arg_13_0), var_13_0)
end

return var_0_0
