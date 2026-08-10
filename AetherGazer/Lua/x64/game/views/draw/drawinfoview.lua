local var_0_0 = class("DrawInfoView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/PoolInfoPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.probabilityCfgList = {}
	arg_4_0.items = {}
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgmask_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	local var_7_0 = arg_7_0.params_.poolId
	local var_7_1 = DrawData:GetPoolData(var_7_0)

	arg_7_0:RefreshData(var_7_0, var_7_1)
end

function var_0_0.RefreshData(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = DrawPoolCfg[arg_8_1]

	if not var_8_0 then
		return
	end

	arg_8_0.labDetailNote_.text = GetI18NText(var_8_0.detail_note)

	local var_8_1 = arg_8_0:GetProbabilityList(arg_8_1, arg_8_2)
	local var_8_2 = #var_8_1

	for iter_8_0 = 1, var_8_2 do
		if not arg_8_0.items[iter_8_0] then
			local var_8_3 = Object.Instantiate(arg_8_0.item_, arg_8_0.itemParent_)

			arg_8_0.items[iter_8_0] = DrawProbabilityItem.New(var_8_3)
		end

		local var_8_4 = var_8_1[iter_8_0]

		arg_8_0.items[iter_8_0]:RefreshData(var_8_4)
	end

	for iter_8_1 = var_8_2 + 1, #arg_8_0.items do
		arg_8_0.items[iter_8_1]:Show(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.layout_6)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.layout_5)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.layout_4)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.layout_1)
end

function var_0_0.GetProbabilityList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = DrawPoolCfg[arg_9_1].pool_type
	local var_9_1 = {}

	if var_9_0 == 2 then
		local var_9_2 = {}

		var_9_2.define = "DRAW_POOL_PROBABILITY_FIVE_WEAPON"
		var_9_2.poolId = arg_9_1
		var_9_2.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_1].desc
		var_9_2.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_2].desc
		var_9_2.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_3].desc
		var_9_2.itemid_ = {}

		if arg_9_2.s_up_item then
			for iter_9_0, iter_9_1 in ipairs(arg_9_2.s_up_item) do
				table.insert(var_9_2.itemid_, iter_9_1)
			end

			if arg_9_2.s_other_item then
				for iter_9_2, iter_9_3 in ipairs(arg_9_2.s_other_item) do
					table.insert(var_9_2.itemid_, iter_9_3)
				end
			end
		else
			for iter_9_4, iter_9_5 in ipairs(arg_9_2.s_other_item) do
				table.insert(var_9_2.itemid_, iter_9_5)
			end
		end

		table.insert(var_9_1, var_9_2)

		local var_9_3 = {}

		var_9_3.define = "DRAW_POOL_PROBABILITY_FOUR_WEAPON"
		var_9_3.poolId = arg_9_1
		var_9_3.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_1].desc
		var_9_3.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_2].desc
		var_9_3.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_3].desc
		var_9_3.itemid_ = {}

		if arg_9_2.a_up_item then
			for iter_9_6, iter_9_7 in ipairs(arg_9_2.a_up_item) do
				table.insert(var_9_3.itemid_, iter_9_7)
			end

			if arg_9_2.a_other_item then
				for iter_9_8, iter_9_9 in ipairs(arg_9_2.a_other_item) do
					table.insert(var_9_3.itemid_, iter_9_9)
				end
			end
		else
			for iter_9_10, iter_9_11 in ipairs(arg_9_2.a_other_item) do
				table.insert(var_9_3.itemid_, iter_9_11)
			end
		end

		table.insert(var_9_1, var_9_3)

		local var_9_4 = {}

		var_9_4.define = "DRAW_POOL_PROBABILITY_THREE_WEAPON"
		var_9_4.poolId = arg_9_1
		var_9_4.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_1].desc
		var_9_4.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_2].desc
		var_9_4.itemid_ = {}

		if arg_9_2.b_item then
			for iter_9_12, iter_9_13 in ipairs(arg_9_2.b_item) do
				if DrawItemCfg[iter_9_13].pool_id ~= 301 then
					table.insert(var_9_4.itemid_, iter_9_13)
				end
			end
		end

		table.insert(var_9_1, var_9_4)
	else
		local var_9_5 = {}

		var_9_5.define = "DRAW_POOL_PROBABILITY_S"
		var_9_5.poolId = arg_9_1
		var_9_5.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_1].desc
		var_9_5.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_2].desc
		var_9_5.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_3].desc
		var_9_5.itemid_ = {}

		if arg_9_2.s_up_item then
			for iter_9_14, iter_9_15 in ipairs(arg_9_2.s_up_item) do
				table.insert(var_9_5.itemid_, iter_9_15)
			end

			if arg_9_2.s_other_item then
				for iter_9_16, iter_9_17 in ipairs(arg_9_2.s_other_item) do
					table.insert(var_9_5.itemid_, iter_9_17)
				end
			end
		else
			for iter_9_18, iter_9_19 in ipairs(arg_9_2.s_other_item) do
				table.insert(var_9_5.itemid_, iter_9_19)
			end
		end

		table.insert(var_9_1, var_9_5)

		local var_9_6 = {}

		var_9_6.define = "DRAW_POOL_PROBABILITY_A"
		var_9_6.poolId = arg_9_1
		var_9_6.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc
		var_9_6.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc
		var_9_6.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc
		var_9_6.itemid_ = {}

		if arg_9_2.a_up_item then
			for iter_9_20, iter_9_21 in ipairs(arg_9_2.a_up_item) do
				table.insert(var_9_6.itemid_, iter_9_21)
			end

			if arg_9_2.a_other_item then
				for iter_9_22, iter_9_23 in ipairs(arg_9_2.a_other_item) do
					table.insert(var_9_6.itemid_, iter_9_23)
				end
			end
		else
			for iter_9_24, iter_9_25 in ipairs(arg_9_2.a_other_item) do
				table.insert(var_9_6.itemid_, iter_9_25)
			end
		end

		table.insert(var_9_1, var_9_6)

		local var_9_7 = {}

		var_9_7.define = "DRAW_POOL_PROBABILITY_B"
		var_9_7.poolId = arg_9_1
		var_9_7.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc
		var_9_7.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc
		var_9_7.itemid_ = {}

		if arg_9_2.b_item then
			for iter_9_26, iter_9_27 in ipairs(arg_9_2.b_item) do
				if DrawItemCfg[iter_9_27].pool_id == 301 then
					table.insert(var_9_7.itemid_, iter_9_27)
				end
			end
		end

		table.insert(var_9_1, var_9_7)

		local var_9_8 = {}

		var_9_8.define = "DRAW_POOL_PROBABILITY_C"
		var_9_8.poolId = arg_9_1
		var_9_8.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc
		var_9_8.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc
		var_9_8.itemid_ = {}

		if arg_9_2.b_item then
			for iter_9_28, iter_9_29 in ipairs(arg_9_2.b_item) do
				if DrawItemCfg[iter_9_29].pool_id ~= 301 then
					table.insert(var_9_8.itemid_, iter_9_29)
				end
			end
		end

		table.insert(var_9_1, var_9_8)
	end

	arg_9_0.probabilityCfgList[arg_9_1] = var_9_1

	return var_9_1
end

function var_0_0.Dispose(arg_10_0)
	if arg_10_0.items then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.items) do
			iter_10_1:Dispose()
		end

		arg_10_0.items = nil
	end

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
