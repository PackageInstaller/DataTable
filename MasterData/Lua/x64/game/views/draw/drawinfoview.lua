local DrawInfoView = class("DrawInfoView", ReduxView)

function DrawInfoView:UIName()
	return "Widget/System/Pool/PoolInfoPopUI"
end

function DrawInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function DrawInfoView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawInfoView:InitUI()
	self:BindCfgUI()

	self.probabilityCfgList = {}
	self.items = {}
end

function DrawInfoView:AddUIListener()
	self:AddBtnListener(self.bgmask_, nil, function()
		self:Back()
	end)
end

function DrawInfoView:OnEnter()
	self:RefreshData(self.params_.poolId, (DrawData:GetPoolData(self.params_.poolId)))
end

function DrawInfoView:RefreshData(arg_8_1, arg_8_2)
	if not DrawPoolCfg[arg_8_1] then
		return
	end

	self.labDetailNote_.text = GetI18NText(DrawPoolCfg[arg_8_1].detail_note)

	local var_8_0 = self:GetProbabilityList(arg_8_1, arg_8_2)

	for iter_8_0 = 1, #var_8_0 do
		self.items[iter_8_0] = self.items[iter_8_0] or DrawProbabilityItem.New((Object.Instantiate(self.item_, self.itemParent_)))

		self.items[iter_8_0]:RefreshData(var_8_0[iter_8_0])
	end

	for iter_8_1 = #var_8_0 + 1, #self.items do
		self.items[iter_8_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_6)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_5)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_1)
end

function DrawInfoView:GetProbabilityList(arg_9_1, arg_9_2)
	local var_9_0 = {}

	if DrawPoolCfg[arg_9_1].pool_type == 2 then
		local var_9_1 = {}

		var_9_1.define = "DRAW_POOL_PROBABILITY_FIVE_WEAPON"
		var_9_1.poolId = arg_9_1
		var_9_1.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_1].desc
		var_9_1.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_2].desc
		var_9_1.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_3].desc
		var_9_1.itemid_ = {}

		if arg_9_2.s_up_item then
			for iter_9_0, iter_9_1 in ipairs(arg_9_2.s_up_item) do
				table.insert(var_9_1.itemid_, iter_9_1)
			end

			if arg_9_2.s_other_item then
				for iter_9_2, iter_9_3 in ipairs(arg_9_2.s_other_item) do
					table.insert(var_9_1.itemid_, iter_9_3)
				end
			end
		else
			for iter_9_4, iter_9_5 in ipairs(arg_9_2.s_other_item) do
				table.insert(var_9_1.itemid_, iter_9_5)
			end
		end

		table.insert(var_9_0, var_9_1)

		local var_9_2 = {}

		var_9_2.define = "DRAW_POOL_PROBABILITY_FOUR_WEAPON"
		var_9_2.poolId = arg_9_1
		var_9_2.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_1].desc
		var_9_2.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_2].desc
		var_9_2.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_3].desc
		var_9_2.itemid_ = {}

		if arg_9_2.a_up_item then
			for iter_9_6, iter_9_7 in ipairs(arg_9_2.a_up_item) do
				table.insert(var_9_2.itemid_, iter_9_7)
			end

			if arg_9_2.a_other_item then
				for iter_9_8, iter_9_9 in ipairs(arg_9_2.a_other_item) do
					table.insert(var_9_2.itemid_, iter_9_9)
				end
			end
		else
			for iter_9_10, iter_9_11 in ipairs(arg_9_2.a_other_item) do
				table.insert(var_9_2.itemid_, iter_9_11)
			end
		end

		table.insert(var_9_0, var_9_2)

		local var_9_3 = {}

		var_9_3.define = "DRAW_POOL_PROBABILITY_THREE_WEAPON"
		var_9_3.poolId = arg_9_1
		var_9_3.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_1].desc
		var_9_3.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_2].desc
		var_9_3.itemid_ = {}

		if arg_9_2.b_item then
			for iter_9_12, iter_9_13 in ipairs(arg_9_2.b_item) do
				if DrawItemCfg[iter_9_13].pool_id ~= 301 then
					table.insert(var_9_3.itemid_, iter_9_13)
				end
			end
		end

		table.insert(var_9_0, var_9_3)
	else
		local var_9_4 = {}

		var_9_4.define = "DRAW_POOL_PROBABILITY_S"
		var_9_4.poolId = arg_9_1
		var_9_4.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_1].desc
		var_9_4.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_2].desc
		var_9_4.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_3].desc
		var_9_4.itemid_ = {}

		if arg_9_2.s_up_item then
			for iter_9_14, iter_9_15 in ipairs(arg_9_2.s_up_item) do
				table.insert(var_9_4.itemid_, iter_9_15)
			end

			if arg_9_2.s_other_item then
				for iter_9_16, iter_9_17 in ipairs(arg_9_2.s_other_item) do
					table.insert(var_9_4.itemid_, iter_9_17)
				end
			end
		else
			for iter_9_18, iter_9_19 in ipairs(arg_9_2.s_other_item) do
				table.insert(var_9_4.itemid_, iter_9_19)
			end
		end

		table.insert(var_9_0, var_9_4)

		local var_9_5 = {}

		var_9_5.define = "DRAW_POOL_PROBABILITY_A"
		var_9_5.poolId = arg_9_1
		var_9_5.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc
		var_9_5.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc
		var_9_5.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc
		var_9_5.itemid_ = {}

		if arg_9_2.a_up_item then
			for iter_9_20, iter_9_21 in ipairs(arg_9_2.a_up_item) do
				table.insert(var_9_5.itemid_, iter_9_21)
			end

			if arg_9_2.a_other_item then
				for iter_9_22, iter_9_23 in ipairs(arg_9_2.a_other_item) do
					table.insert(var_9_5.itemid_, iter_9_23)
				end
			end
		else
			for iter_9_24, iter_9_25 in ipairs(arg_9_2.a_other_item) do
				table.insert(var_9_5.itemid_, iter_9_25)
			end
		end

		table.insert(var_9_0, var_9_5)

		local var_9_6 = {}

		var_9_6.define = "DRAW_POOL_PROBABILITY_B"
		var_9_6.poolId = arg_9_1
		var_9_6.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc
		var_9_6.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc
		var_9_6.itemid_ = {}

		if arg_9_2.b_item then
			for iter_9_26, iter_9_27 in ipairs(arg_9_2.b_item) do
				if DrawItemCfg[iter_9_27].pool_id == 301 then
					table.insert(var_9_6.itemid_, iter_9_27)
				end
			end
		end

		table.insert(var_9_0, var_9_6)

		local var_9_7 = {}

		var_9_7.define = "DRAW_POOL_PROBABILITY_C"
		var_9_7.poolId = arg_9_1
		var_9_7.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc
		var_9_7.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc
		var_9_7.itemid_ = {}

		if arg_9_2.b_item then
			for iter_9_28, iter_9_29 in ipairs(arg_9_2.b_item) do
				if DrawItemCfg[iter_9_29].pool_id ~= 301 then
					table.insert(var_9_7.itemid_, iter_9_29)
				end
			end
		end

		table.insert(var_9_0, var_9_7)
	end

	self.probabilityCfgList[arg_9_1] = var_9_0

	return var_9_0
end

function DrawInfoView:Dispose()
	if self.items then
		for iter_10_0, iter_10_1 in ipairs(self.items) do
			iter_10_1:Dispose()
		end

		self.items = nil
	end

	DrawInfoView.super.Dispose(self)
end

return DrawInfoView
