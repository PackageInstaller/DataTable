local var_0_0 = {
	GetCfg = function(arg_1_0)
		local var_1_0 = IchiBanUICfg.get_id_list_by_activity_id[arg_1_0]

		if var_1_0 == nil then
			-- block empty
		end

		local var_1_1 = var_1_0[1]

		return IchiBanUICfg[var_1_1]
	end
}

function var_0_0.GetEntraceUIName(arg_2_0)
	return var_0_0.GetCfg(arg_2_0).entrace_prefab_path
end

function var_0_0.GetCurrencyID(arg_3_0)
	local var_3_0 = IchiBanTeaserCfg.get_id_list_by_activity_id[arg_3_0][1]

	return IchiBanTeaserCfg[var_3_0].lottery_id
end

function var_0_0.GetDesc(arg_4_0)
	return (GetTips("ICHIBAN_ENTRANCE_RULE"))
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

function var_0_0.GetLevelPosReward(arg_7_0, arg_7_1)
	local var_7_0 = IchiBanTeaserCfg[arg_7_0]
	local var_7_1 = var_7_0.activity_id
	local var_7_2 = var_7_0.level
	local var_7_3 = IchiBanData:GetIchiBanData(var_7_1, var_7_2, arg_7_1)

	if var_7_3 == nil then
		return nil
	end

	return var_7_0.reward[var_7_3]
end

function var_0_0.IsGotAllLevelReward(arg_8_0)
	local var_8_0 = IchiBanTeaserCfg[arg_8_0]
	local var_8_1 = var_8_0.activity_id
	local var_8_2 = var_8_0.level

	return #IchiBanData:GetIchiBanDataList(var_8_1, var_8_2) >= #var_8_0.reward
end

function var_0_0.GetMaxRaffleCnt(arg_9_0)
	local var_9_0 = IchiBanTools.GetCurrencyID(arg_9_0)
	local var_9_1 = ItemTools.getItemNum(var_9_0)

	if var_9_1 <= 0 then
		return 0
	end

	local var_9_2 = var_0_0.GetUnRaffleCnt(arg_9_0)

	return var_9_1 < var_9_2 and var_9_1 or var_9_2
end

function var_0_0.GetUnRaffleCnt(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[arg_10_0]) do
		local var_10_1 = IchiBanTeaserCfg[iter_10_1]
		local var_10_2 = IchiBanData:GetIchiBanDataList(arg_10_0, var_10_1.level)

		var_10_0 = var_10_0 + #var_10_1.reward - #var_10_2
	end

	return var_10_0
end

function var_0_0.NeedPlayItemAnimator(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.activity_id
	local var_11_1 = arg_11_0.level
	local var_11_2 = IchiBanData:GetUISeqList(var_11_0)
	local var_11_3 = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_2) do
		if iter_11_1.level == var_11_1 then
			var_11_3 = var_11_3 + 1
		end
	end

	local var_11_4 = #IchiBanData:GetIchiBanDataList(var_11_0, var_11_1)

	return arg_11_1 <= var_11_4 and arg_11_1 > var_11_4 - var_11_3
end

return var_0_0
