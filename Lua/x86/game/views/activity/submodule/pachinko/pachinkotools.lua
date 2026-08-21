local var_0_0 = {
	GetCfg = function(arg_1_0)
		local var_1_0 = PaChinKoUICfg.get_id_list_by_activity_id[arg_1_0]

		if var_1_0 == nil then
			-- block empty
		end

		local var_1_1 = var_1_0[1]

		return PaChinKoUICfg[var_1_1]
	end
}

function var_0_0.GetEntranceUIName(arg_2_0)
	return var_0_0.GetCfg(arg_2_0).entrance_prefab_path
end

function var_0_0.GetCurrencyID(arg_3_0)
	local var_3_0 = PaChinKoSignCfg.get_id_list_by_activity_id[arg_3_0][1]

	return PaChinKoSignCfg[var_3_0].ball_id
end

function var_0_0.GetDesc(arg_4_0)
	return (GetTips("PACHINKO_ENTRANCE_RULE"))
end

function var_0_0.GetTaskActivityID(arg_5_0)
	local var_5_0 = ActivityCfg[arg_5_0]

	for iter_5_0, iter_5_1 in ipairs(var_5_0.sub_activity_list) do
		if ActivityCfg[iter_5_1].activity_template == ActivityTemplateConst.TASK then
			return iter_5_1
		end
	end

	return arg_5_0
end

function var_0_0.GetMainUIName(arg_6_0)
	return var_0_0.GetCfg(arg_6_0).main_prefab_path
end

function var_0_0.GetLevelRewardList(arg_7_0, arg_7_1)
	return PaChinKoSignCfg.get_id_list_by_activity_id_level[arg_7_0][arg_7_1]
end

function var_0_0.GetReceiveCnt(arg_8_0, arg_8_1)
	return PaChinKoData:GetRewardData(arg_8_0)[arg_8_1] or 0
end

function var_0_0.IsGetAllReward(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(PaChinKoSignCfg.get_id_list_by_activity_id_level[arg_9_0]) do
		if not var_0_0.IsGetAllLevelReward(arg_9_0, iter_9_0) then
			return false
		end
	end

	return true
end

function var_0_0.IsGetAllHightReward(arg_10_0)
	local var_10_0 = PaChinKoSignCfg.get_id_list_by_activity_id_level[arg_10_0]

	for iter_10_0 = 1, #var_10_0 - 1 do
		if not var_0_0.IsGetAllLevelReward(arg_10_0, iter_10_0) then
			return false
		end
	end

	return true
end

function var_0_0.IsGetAllLevelReward(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(PaChinKoSignCfg.get_id_list_by_activity_id_level[arg_11_0][arg_11_1]) do
		local var_11_0 = PaChinKoSignCfg[iter_11_1]

		if var_0_0.GetReceiveCnt(arg_11_0, iter_11_1) < var_11_0.count then
			return false
		end
	end

	return true
end

function var_0_0.GetPrizeDistribution(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(PaChinKoSignCfg.get_id_list_by_activity_id_level[arg_12_0]) do
		if var_0_0.IsGetAllLevelReward(arg_12_0, iter_12_0) then
			table.insert(var_12_0, 1, 0)
		else
			table.insert(var_12_0, 1, 1)
		end
	end

	for iter_12_2, iter_12_3 in ipairs(PaChinKoStageCfg.get_id_list_by_activity_id[arg_12_0]) do
		if table.equal(PaChinKoStageCfg[iter_12_3].prize_left, var_12_0, "all") then
			return PaChinKoStageCfg[iter_12_3].prize_distribution
		end
	end

	return {
		0,
		0,
		0
	}
end

function var_0_0.IsClearLevelPrize(arg_13_0, arg_13_1)
	return var_0_0.IsGetAllLevelReward(arg_13_0, arg_13_1)
end

function var_0_0.GetBallOffset(arg_14_0)
	local var_14_0 = PaChinKoData:GetRewardList(arg_14_0)
	local var_14_1 = GameSetting.pachinko_pity.value
	local var_14_2 = 3
	local var_14_3 = var_14_1[1]

	for iter_14_0 = #var_14_0, 1, -1 do
		if PaChinKoSignCfg[var_14_0[iter_14_0]].level == var_14_2 then
			var_14_3 = var_14_3 - 1
		else
			break
		end
	end

	local var_14_4 = math.random(0, 99)
	local var_14_5 = false

	if var_14_4 < 50 + (var_14_3 <= 0 and var_14_1[2] or 0) then
		var_14_5 = true
	end

	local var_14_6 = GameSetting.pachinko_add_force_range.value
	local var_14_7 = math.random(var_14_6[1], var_14_6[2]) * (var_14_5 and -0.01 or 0.01)

	return Vector2.New(var_14_7, 0)
end

function var_0_0.GetBubbleText(arg_15_0, arg_15_1)
	local var_15_0 = PaChinKoTextCfg.get_id_list_by_type_condition[1]
	local var_15_1 = 1

	if arg_15_0 == PaChinKoMainView.MODEL_STATE.INTERACTIVE then
		var_15_1 = 1
	elseif arg_15_0 == PaChinKoMainView.MODEL_STATE.PRIZE then
		if arg_15_1 == 2 then
			var_15_1 = 3
		elseif arg_15_1 == 3 then
			var_15_1 = 2
		else
			return
		end
	elseif arg_15_0 == PaChinKoMainView.MODEL_STATE.OVER then
		var_15_1 = 4
	end

	local var_15_2 = math.random(1, #var_15_0[var_15_1])
	local var_15_3 = var_15_0[var_15_1][var_15_2]

	return PaChinKoTextCfg[var_15_3].dialogue
end

return var_0_0
