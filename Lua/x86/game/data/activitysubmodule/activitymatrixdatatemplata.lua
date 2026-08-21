ActivityMatrixTools = {}

function ActivityMatrixTools.GetCoinItem(arg_1_0)
	local var_1_0 = ActivityMatrixCfg[arg_1_0]
	local var_1_1 = var_1_0 and var_1_0.setting_template_id
	local var_1_2 = ActivityMatrixSettingTemplateCfg.get_id_list_by_template_id[var_1_1]

	if var_1_2 then
		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			if ActivityMatrixSettingTemplateCfg[iter_1_1].type == 15 then
				return ActivityMatrixSettingTemplateCfg[iter_1_1].value[1] or 0
			end
		end
	end

	return 26
end

ActivityMatrixHeroTemplate = class("ActivityMatrixHeroTemplate", MatrixHeroTemplate)

function ActivityMatrixHeroTemplate.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.activity_id = arg_2_1

	ActivityMatrixHeroTemplate.super.Ctor(arg_2_0, arg_2_2, arg_2_3)
end

function ActivityMatrixHeroTemplate.GetWeaponServantEffectLevel(arg_3_0)
	return ActivityMatrixData:GetWeaponServantLevel(arg_3_0.activity_id) or 1
end

ActivityMatrixPhaseTemplate = class("ActivityMatrixPhaseTemplate")

function ActivityMatrixPhaseTemplate.Ctor(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.activity_id = arg_4_1
	arg_4_0.phase_id = arg_4_2.phase_id
	arg_4_0.event_id_list = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_2.event_id_list) do
		table.insert(arg_4_0.event_id_list, iter_4_1)
	end

	local var_4_0 = arg_4_2.event

	arg_4_0.cur_event_id = var_4_0.event_id
	arg_4_0.envent_params = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_0.params) do
		table.insert(arg_4_0.envent_params, iter_4_3)
	end

	local var_4_1 = arg_4_2.reward

	arg_4_0.reward_items = {}

	for iter_4_4, iter_4_5 in ipairs(var_4_1.matrix_item_id_list) do
		table.insert(arg_4_0.reward_items, iter_4_5)
	end

	arg_4_0.give_up_item_id = var_4_1.give_up_matrix_item_id
end

function ActivityMatrixPhaseTemplate.GetPhase(arg_5_0)
	return arg_5_0.phase_id
end

function ActivityMatrixPhaseTemplate.GetParams(arg_6_0)
	if MatrixConst.PHASE_TYPE.CHOSE == arg_6_0.phase_id then
		return arg_6_0.event_id_list
	elseif MatrixConst.PHASE_TYPE.ACTION == arg_6_0.phase_id then
		return {
			arg_6_0.cur_event_id
		}
	elseif MatrixConst.PHASE_TYPE.REWARD == arg_6_0.phase_id then
		return arg_6_0.reward_items
	else
		return {}
	end
end

function ActivityMatrixPhaseTemplate.GetData(arg_7_0)
	local var_7_0 = ActivityMatrixEventTemplateCfg[arg_7_0.cur_event_id]

	if MatrixConst.EVENT_TYPE.SHOP == var_7_0.event_type then
		local var_7_1 = arg_7_0.envent_params[1]
		local var_7_2 = {}
		local var_7_3 = #arg_7_0.envent_params

		for iter_7_0 = 2, var_7_3 do
			local var_7_4 = arg_7_0.envent_params[iter_7_0]

			if var_7_4 and var_7_4 ~= 0 then
				local var_7_5 = MatrixItemCfg[var_7_4].price[1]
				local var_7_6 = var_7_5[1]
				local var_7_7 = var_7_5[2]
				local var_7_8 = 1
				local var_7_9 = iter_7_0 - 1

				if var_7_9 == 1 then
					var_7_8 = 1 - ActivityMatrixData:GetFirstGoodsDiscount(arg_7_0.activity_id) / 1000

					local var_7_10 = var_7_7 * ActivityMatrixData:GetFirstGoodsDiscount(arg_7_0.activity_id) / 1000

					var_7_7 = math.floor(var_7_7 - var_7_10)
				end

				table.insert(var_7_2, {
					index = var_7_9,
					id = var_7_4,
					discount = var_7_8,
					priceId = var_7_6,
					priceNum = var_7_7,
					priceOriginal = var_7_5[2]
				})
			end
		end

		return var_7_1, var_7_2
	else
		return arg_7_0.envent_params[1] or 0
	end
end

function ActivityMatrixPhaseTemplate.GetShops(arg_8_0)
	return {}
end

function ActivityMatrixPhaseTemplate.GetGiveUpItemId(arg_9_0)
	return arg_9_0.give_up_item_id or 0
end

ActivityMartixUserTemplata = class("ActivityMartixUserTemplata")

function ActivityMartixUserTemplata.Ctor(arg_10_0, arg_10_1)
	arg_10_0:SetData(arg_10_1)

	arg_10_0.battle_hero_id_list_cache = nil
end

function ActivityMartixUserTemplata.SetData(arg_11_0, arg_11_1)
	arg_11_0.activity_id = arg_11_1.activity_id
	arg_11_0.game_state = arg_11_1.game_state
	arg_11_0.got_reward_list = {}

	local var_11_0 = arg_11_1.got_reward_list or {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		table.insert(arg_11_0.got_reward_list, iter_11_1)
	end

	arg_11_0.point = arg_11_1.point
	arg_11_0.success_times = arg_11_1.success_times

	local var_11_1 = arg_11_1.progress

	arg_11_0:UpdateProcess(var_11_1)
end

function ActivityMartixUserTemplata.UpdateProcess(arg_12_0, arg_12_1)
	if MatrixConst.STATE_TYPE.NOTSTARTED == arg_12_0.game_state then
		return
	end

	arg_12_0.tier_id = arg_12_1.tier_id
	arg_12_0.artifact_list = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.artifact_list) do
		local var_12_0 = iter_12_1.id
		local var_12_1 = iter_12_1.wins

		table.insert(arg_12_0.artifact_list, {
			id = var_12_0,
			wins = var_12_1
		})
	end

	arg_12_0.phase = ActivityMatrixPhaseTemplate.New(arg_12_0.activity_id, arg_12_1.phase)
	arg_12_0.matrix_hero_net_rec = {}
	arg_12_0.matrix_hero_id_net_rec = {}

	for iter_12_2, iter_12_3 in ipairs(arg_12_1.hero_list) do
		local var_12_2 = iter_12_3.hero_id
		local var_12_3 = HeroStandardSystemCfg[var_12_2]

		if var_12_3 then
			local var_12_4 = var_12_3.hero_id
			local var_12_5 = ActivityMatrixHeroTemplate.New(arg_12_0.activity_id, var_12_4, var_12_2)

			var_12_5:InitData(iter_12_3)

			arg_12_0.matrix_hero_net_rec[var_12_4] = var_12_5

			table.insert(arg_12_0.matrix_hero_id_net_rec, var_12_4)
		end
	end

	arg_12_0.custom_affix_id_list = {}

	for iter_12_4, iter_12_5 in ipairs(arg_12_1.custom_affix_id_list) do
		table.insert(arg_12_0.custom_affix_id_list, iter_12_5)
	end

	arg_12_0.attribute_list = {}

	for iter_12_6, iter_12_7 in ipairs(arg_12_1.attribute_list) do
		local var_12_6 = iter_12_7.id
		local var_12_7 = iter_12_7.value

		arg_12_0.attribute_list[var_12_6] = var_12_7
	end

	arg_12_0.stackable_item_list = {}

	for iter_12_8, iter_12_9 in ipairs(arg_12_1.stackable_item_list) do
		arg_12_0.stackable_item_list[iter_12_9.stackable_item_type] = iter_12_9.stackable_item_num
	end
end

function ActivityMartixUserTemplata.GetMatrixCoint(arg_13_0)
	return arg_13_0.stackable_item_list and arg_13_0.stackable_item_list[1] or 0
end

function ActivityMartixUserTemplata.GetMatrixScore(arg_14_0)
	return arg_14_0.point
end

function ActivityMartixUserTemplata.OnReceivePointReward(arg_15_0, arg_15_1)
	table.insert(arg_15_0.got_reward_list, arg_15_1)
end

function ActivityMartixUserTemplata.GetIsClearance(arg_16_0)
	if arg_16_0.success_times == nil then
		return false
	end

	return arg_16_0.success_times > 0
end

ActivityMartixOverTemplata = class("ActivityMartixUserTemplata")

function ActivityMartixOverTemplata.Ctor(arg_17_0, arg_17_1)
	arg_17_0:SetData(arg_17_1)
end

function ActivityMartixOverTemplata.SetData(arg_18_0, arg_18_1)
	arg_18_0.currencyList_ = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.item_list) do
		arg_18_0.currencyList_[iter_18_1.stackable_item_type] = iter_18_1.stackable_item_num
	end

	arg_18_0.currentClearTime_ = arg_18_1.clear_time
	arg_18_0.minClearTime_ = arg_18_1.min_clear_time or arg_18_1.clear_time
	arg_18_0.point = arg_18_1.point
	arg_18_0.success_times = arg_18_1.success_times
end
