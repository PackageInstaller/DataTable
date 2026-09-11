local var_0_0 = {
	GetCfg = function(arg_1_0)
		if IchiBanUICfg.get_id_list_by_activity_id[arg_1_0] == nil then
			-- block empty
		end

		return IchiBanUICfg[IchiBanUICfg.get_id_list_by_activity_id[arg_1_0][1]]
	end
}

function var_0_0.GetEntraceUIName(arg_2_0)
	return var_0_0.GetCfg(arg_2_0).entrace_prefab_path
end

function var_0_0.GetCurrencyID(arg_3_0)
	return IchiBanTeaserCfg[IchiBanTeaserCfg.get_id_list_by_activity_id[arg_3_0][1]].lottery_id
end

function var_0_0.GetDesc(arg_4_0)
	return (GetTips("ICHIBAN_ENTRANCE_RULE"))
end

function var_0_0.GetTaskActivityID(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(ActivityCfg[arg_5_0].sub_activity_list) do
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
	local var_7_0 = IchiBanData:GetIchiBanData(IchiBanTeaserCfg[arg_7_0].activity_id, IchiBanTeaserCfg[arg_7_0].level, arg_7_1)

	if var_7_0 == nil then
		return nil
	end

	return IchiBanTeaserCfg[arg_7_0].reward[var_7_0]
end

function var_0_0.IsGotAllLevelReward(arg_8_0)
	return #IchiBanData:GetIchiBanDataList(IchiBanTeaserCfg[arg_8_0].activity_id, IchiBanTeaserCfg[arg_8_0].level) >= #IchiBanTeaserCfg[arg_8_0].reward
end

function var_0_0.GetMaxRaffleCnt(arg_9_0)
	local var_9_0 = ItemTools.getItemNum((IchiBanTools.GetCurrencyID(arg_9_0)))

	if var_9_0 <= 0 then
		return 0
	end

	local var_9_1 = var_0_0.GetUnRaffleCnt(arg_9_0)

	return var_9_0 < var_9_1 and var_9_0 or var_9_1
end

function var_0_0.GetUnRaffleCnt(arg_10_0)
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in ipairs(IchiBanTeaserCfg.get_id_list_by_activity_id[arg_10_0]) do
		var_10_0 = var_10_0 + #IchiBanTeaserCfg[iter_10_1].reward - #IchiBanData:GetIchiBanDataList(arg_10_0, IchiBanTeaserCfg[iter_10_1].level)
	end

	return var_10_0
end

function var_0_0:NeedPlayItemAnimator(arg_11_1)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs((IchiBanData:GetUISeqList(self.activity_id))) do
		if iter_11_1.level == self.level then
			var_11_0 = var_11_0 + 1
		end
	end

	local var_11_1 = #IchiBanData:GetIchiBanDataList(self.activity_id, self.level)

	return arg_11_1 <= var_11_1 and arg_11_1 > var_11_1 - var_11_0
end

return var_0_0
