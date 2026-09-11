ActivityMatrixTools = {}

function ActivityMatrixTools.GetCoinItem(arg_1_0)
	if ActivityMatrixSettingTemplateCfg.get_id_list_by_template_id[ActivityMatrixCfg[arg_1_0] and ActivityMatrixCfg[arg_1_0].setting_template_id] then
		for iter_1_0, iter_1_1 in ipairs(ActivityMatrixSettingTemplateCfg.get_id_list_by_template_id[ActivityMatrixCfg[arg_1_0] and ActivityMatrixCfg[arg_1_0].setting_template_id]) do
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

function ActivityMatrixHeroTemplate:GetWeaponServantEffectLevel()
	return ActivityMatrixData:GetWeaponServantLevel(self.activity_id) or 1
end

ActivityMatrixPhaseTemplate = class("ActivityMatrixPhaseTemplate")

function ActivityMatrixPhaseTemplate:Ctor(arg_4_1, arg_4_2)
	self.activity_id = arg_4_1
	self.phase_id = arg_4_2.phase_id
	self.event_id_list = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_2.event_id_list) do
		table.insert(self.event_id_list, iter_4_1)
	end

	self.cur_event_id = arg_4_2.event.event_id
	self.envent_params = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_2.event.params) do
		table.insert(self.envent_params, iter_4_3)
	end

	self.reward_items = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_2.reward.matrix_item_id_list) do
		table.insert(self.reward_items, iter_4_5)
	end

	self.give_up_item_id = arg_4_2.reward.give_up_matrix_item_id
end

function ActivityMatrixPhaseTemplate:GetPhase()
	return self.phase_id
end

function ActivityMatrixPhaseTemplate:GetParams()
	if MatrixConst.PHASE_TYPE.CHOSE == self.phase_id then
		return self.event_id_list
	elseif MatrixConst.PHASE_TYPE.ACTION == self.phase_id then
		return {
			self.cur_event_id
		}
	elseif MatrixConst.PHASE_TYPE.REWARD == self.phase_id then
		return self.reward_items
	else
		return {}
	end
end

function ActivityMatrixPhaseTemplate:GetData()
	if MatrixConst.EVENT_TYPE.SHOP == ActivityMatrixEventTemplateCfg[self.cur_event_id].event_type then
		local var_7_0 = {}

		for iter_7_0 = 2, #self.envent_params do
			if self.envent_params[iter_7_0] and self.envent_params[iter_7_0] ~= 0 then
				local var_7_1 = MatrixItemCfg[self.envent_params[iter_7_0]].price[1][2]
				local var_7_2 = 1

				if iter_7_0 - 1 == 1 then
					var_7_2 = 1 - ActivityMatrixData:GetFirstGoodsDiscount(self.activity_id) / 1000
					var_7_1 = math.floor(var_7_1 - var_7_1 * ActivityMatrixData:GetFirstGoodsDiscount(self.activity_id) / 1000)
				end

				table.insert(var_7_0, {
					index = iter_7_0 - 1,
					id = self.envent_params[iter_7_0],
					discount = var_7_2,
					priceId = MatrixItemCfg[self.envent_params[iter_7_0]].price[1][1],
					priceNum = var_7_1,
					priceOriginal = MatrixItemCfg[self.envent_params[iter_7_0]].price[1][2]
				})
			end
		end

		return self.envent_params[1], var_7_0
	else
		return self.envent_params[1] or 0
	end
end

function ActivityMatrixPhaseTemplate.GetShops(arg_8_0)
	return {}
end

function ActivityMatrixPhaseTemplate:GetGiveUpItemId()
	return self.give_up_item_id or 0
end

ActivityMartixUserTemplata = class("ActivityMartixUserTemplata")

function ActivityMartixUserTemplata:Ctor(arg_10_1)
	self:SetData(arg_10_1)

	self.battle_hero_id_list_cache = nil
end

function ActivityMartixUserTemplata:SetData(arg_11_1)
	self.activity_id = arg_11_1.activity_id
	self.game_state = arg_11_1.game_state
	self.got_reward_list = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.got_reward_list or {}) do
		table.insert(self.got_reward_list, iter_11_1)
	end

	self.point = arg_11_1.point
	self.success_times = arg_11_1.success_times

	self:UpdateProcess(arg_11_1.progress)
end

function ActivityMartixUserTemplata:UpdateProcess(arg_12_1)
	if MatrixConst.STATE_TYPE.NOTSTARTED == self.game_state then
		return
	end

	self.tier_id = arg_12_1.tier_id
	self.artifact_list = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.artifact_list) do
		table.insert(self.artifact_list, {
			id = iter_12_1.id,
			wins = iter_12_1.wins
		})
	end

	self.phase = ActivityMatrixPhaseTemplate.New(self.activity_id, arg_12_1.phase)
	self.matrix_hero_net_rec = {}
	self.matrix_hero_id_net_rec = {}

	for iter_12_2, iter_12_3 in ipairs(arg_12_1.hero_list) do
		if HeroStandardSystemCfg[iter_12_3.hero_id] then
			local var_12_0 = ActivityMatrixHeroTemplate.New(self.activity_id, HeroStandardSystemCfg[iter_12_3.hero_id].hero_id, iter_12_3.hero_id)

			var_12_0:InitData(iter_12_3)

			self.matrix_hero_net_rec[HeroStandardSystemCfg[iter_12_3.hero_id].hero_id] = var_12_0

			table.insert(self.matrix_hero_id_net_rec, HeroStandardSystemCfg[iter_12_3.hero_id].hero_id)
		end
	end

	self.custom_affix_id_list = {}

	for iter_12_4, iter_12_5 in ipairs(arg_12_1.custom_affix_id_list) do
		table.insert(self.custom_affix_id_list, iter_12_5)
	end

	self.attribute_list = {}

	for iter_12_6, iter_12_7 in ipairs(arg_12_1.attribute_list) do
		self.attribute_list[iter_12_7.id] = iter_12_7.value
	end

	self.stackable_item_list = {}

	for iter_12_8, iter_12_9 in ipairs(arg_12_1.stackable_item_list) do
		self.stackable_item_list[iter_12_9.stackable_item_type] = iter_12_9.stackable_item_num
	end
end

function ActivityMartixUserTemplata:GetMatrixCoint()
	return (self.stackable_item_list or nil) and (self.stackable_item_list[1] or 0)
end

function ActivityMartixUserTemplata:GetMatrixScore()
	return self.point
end

function ActivityMartixUserTemplata:OnReceivePointReward(arg_15_1)
	table.insert(self.got_reward_list, arg_15_1)
end

function ActivityMartixUserTemplata:GetIsClearance()
	if self.success_times == nil then
		return false
	end

	return self.success_times > 0
end

ActivityMartixOverTemplata = class("ActivityMartixUserTemplata")

function ActivityMartixOverTemplata:Ctor(arg_17_1)
	self:SetData(arg_17_1)
end

function ActivityMartixOverTemplata:SetData(arg_18_1)
	self.currencyList_ = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1.item_list) do
		self.currencyList_[iter_18_1.stackable_item_type] = iter_18_1.stackable_item_num
	end

	self.currentClearTime_ = arg_18_1.clear_time
	self.minClearTime_ = arg_18_1.min_clear_time or arg_18_1.clear_time
	self.point = arg_18_1.point
	self.success_times = arg_18_1.success_times
end
