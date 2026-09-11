local var_0_0 = singletonClass("ActivityPtScrollData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}

function var_0_0.Init(arg_1_0)
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
	var_0_4 = {}
end

function var_0_0:SetData(arg_2_1)
	local var_2_0 = {
		activityID = arg_2_1.activity_id
	}

	var_2_0.clearList = arg_2_1.clear_stage_list or {}
	var_2_0.buff_id = arg_2_1.buff_id
	var_2_0.up_select = arg_2_1.up_select
	var_2_0.filter_up = arg_2_1.up_select
	var_2_0.poolID = arg_2_1.index
	var_2_0.clear_times = arg_2_1.clear_times
	var_0_1[arg_2_1.activity_id] = var_2_0

	if arg_2_1.up_select == 0 then
		manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_2_1.activity_id, 0)

		if not ActivityPtRouletteRandomCfg[arg_2_1.index] then
			return
		end

		var_0_1[arg_2_1.activity_id].filter_up = ActivityPtRouletteRandomCfg[arg_2_1.index].equip_suit_list[1] or 0

		if (getData("activityPtScroll", "last_check_up") or 0) >= ActivityData:GetActivityData(arg_2_1.activity_id).startTime then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_2_1.activity_id, 0)
		end

		local var_2_1

		do
			manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_UP_SELECT .. "_" .. arg_2_1.activity_id, 1)

			var_2_1 = RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. arg_2_1.activity_id
		end
	end

	manager.redPoint:setTip(var_2_1, GameSetting.activity_pt_roulette_task_times.value[1] <= arg_2_1.clear_times and 1 or 0)
	self:RefreshAffix(arg_2_1.activity_id)
end

function var_0_0:RefreshAffix(arg_3_1)
	self:RefreshAffixMap(arg_3_1)
	self:RefreshAffixList(arg_3_1)
end

function var_0_0.RefreshAffixMap(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(ActivityPtRouletteStageCfg.get_id_list_by_activity_id[arg_4_1]) do
		if ActivityPtRouletteStageCfg[iter_4_1].mode == 2 then
			break
		end
	end

	var_0_3[arg_4_1] = {}
	var_0_3[arg_4_1].all = {}

	for iter_4_2, iter_4_3 in ipairs(ActivityPtRouletteRandomCfg[var_0_1[arg_4_1].poolID].affix_list) do
		var_0_3[arg_4_1][ActivityPtRouletteAffixCfg[iter_4_3].affix_list[1]] = {
			type = 0,
			useless = false,
			affix = ActivityPtRouletteAffixCfg[iter_4_3].affix_list[1],
			level = ActivityPtRouletteAffixCfg[iter_4_3].affix_list[2],
			target = ActivityPtRouletteAffixCfg[iter_4_3].affix_list[3]
		}

		table.insert(var_0_3[arg_4_1].all, ActivityPtRouletteAffixCfg[iter_4_3].affix_list[1])
	end

	for iter_4_4, iter_4_5 in ipairs(ActivityPtRouletteRandomCfg[var_0_1[arg_4_1].poolID].random_affix_list) do
		for iter_4_6, iter_4_7 in ipairs(iter_4_5[2]) do
			var_0_3[arg_4_1][ActivityPtRouletteAffixCfg[iter_4_7].affix_list[1]] = {
				useless = false,
				type = iter_4_5[1],
				affix = ActivityPtRouletteAffixCfg[iter_4_7].affix_list[1],
				level = ActivityPtRouletteAffixCfg[iter_4_7].affix_list[2],
				target = ActivityPtRouletteAffixCfg[iter_4_7].affix_list[3]
			}

			table.insert(var_0_3[arg_4_1].all, ActivityPtRouletteAffixCfg[iter_4_7].affix_list[1])
		end
	end

	for iter_4_8, iter_4_9 in ipairs(ActivityPtRouletteRandomCfg[var_0_1[arg_4_1].poolID].roulette_desc) do
		var_0_3[arg_4_1][iter_4_9] = {
			target = 0,
			useless = true,
			level = 1,
			type = ActivityPtRouletteTipsCfg[iter_4_9].icon,
			affix = iter_4_9
		}

		table.insert(var_0_3[arg_4_1].all, iter_4_9)
	end
end

function var_0_0:RefreshAffixList(arg_5_1)
	local var_5_0 = self:GetChooseAffixID(arg_5_1)

	var_0_2[arg_5_1] = deepClone(var_0_3[arg_5_1].all)

	table.remove(var_0_2[arg_5_1], table.indexof(var_0_2[arg_5_1], var_5_0))

	for iter_5_0 = #var_0_2[arg_5_1], 1, -1 do
		var_0_2[arg_5_1][#var_0_2[arg_5_1]] = table.remove(var_0_2[arg_5_1], (math.random(iter_5_0)))
	end

	table.insert(var_0_2[arg_5_1], #var_0_2[arg_5_1] / 2 + 1, var_5_0)
end

function var_0_0.GetChooseAffixID(arg_6_0, arg_6_1)
	return ActivityPtRouletteAffixCfg[var_0_1[arg_6_1].buff_id].affix_list[1]
end

function var_0_0.GetAffixList(arg_7_0, arg_7_1)
	return var_0_2[arg_7_1]
end

function var_0_0.GetAffixInfo(arg_8_0, arg_8_1, arg_8_2)
	return var_0_3[arg_8_1][arg_8_2]
end

function var_0_0.SetLastStage(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	var_0_4[arg_9_1] = {
		type = arg_9_2,
		index = arg_9_3
	}
end

function var_0_0.GetLastStage(arg_10_0, arg_10_1)
	return var_0_4[arg_10_1]
end

function var_0_0.SetClearList(arg_11_0, arg_11_1, arg_11_2)
	if not table.indexof(var_0_1[arg_11_1].clearList, arg_11_2) then
		table.insert(var_0_1[arg_11_1].clearList, arg_11_2)
	end
end

function var_0_0.GetClearList(arg_12_0, arg_12_1)
	return var_0_1[arg_12_1].clearList
end

function var_0_0.SetUpSelect(arg_13_0, arg_13_1, arg_13_2)
	var_0_1[arg_13_1].up_select = arg_13_2

	if arg_13_2 ~= 0 then
		var_0_1[arg_13_1].filter_up = arg_13_2
	end
end

function var_0_0.GetUpSelect(arg_14_0, arg_14_1)
	return var_0_1[arg_14_1].up_select, var_0_1[arg_14_1].filter_up
end

function var_0_0.GetPoolID(arg_15_0, arg_15_1)
	return var_0_1[arg_15_1].poolID
end

function var_0_0.GetClearTime(arg_16_0, arg_16_1)
	return var_0_1[arg_16_1].clear_times
end

function var_0_0.AddClearTime(arg_17_0, arg_17_1, arg_17_2)
	var_0_1[arg_17_1].clear_times = var_0_1[arg_17_1].clear_times + arg_17_2

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. arg_17_1, GameSetting.activity_pt_roulette_task_times.value[1] <= var_0_1[arg_17_1].clear_times and 1 or 0)
end

function var_0_0.ModifyClearTime(arg_18_0, arg_18_1, arg_18_2)
	var_0_1[arg_18_1].clear_times = arg_18_2

	manager.redPoint:setTip(RedPointConst.ACTIVITY_PT_SCROLL_INFINITY_TASK .. "_" .. arg_18_1, GameSetting.activity_pt_roulette_task_times.value[1] <= var_0_1[arg_18_1].clear_times and 1 or 0)
end

return var_0_0
