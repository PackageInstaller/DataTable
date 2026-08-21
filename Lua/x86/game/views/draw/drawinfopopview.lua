local var_0_0 = class("DrawInfoPopView", ReduxView)

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
	arg_4_0.stateCon_ = arg_4_0.controllerEx_:GetController("state")
	arg_4_0.recordView = DrawInfoPopRecordView.New(arg_4_0.recordGo_)
	arg_4_0.bonusController_ = arg_4_0.controllerEx_:GetController("ExtractReturn")
	arg_4_0.pieceController_ = arg_4_0.controllerEx_:GetController("ExtractPiece")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.bgMask_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("info")
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnInfo_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("info")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnMessage_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("message")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnRecord_, nil, function()
		arg_5_0.stateCon_:SetSelectedState("record")
	end)
end

function var_0_0.OnEnter(arg_10_0)
	local var_10_0 = arg_10_0.params_.poolId
	local var_10_1 = DrawData:GetPoolData(var_10_0)

	arg_10_0.ani_:Update(0)
	arg_10_0:RefreshInfo(var_10_0, var_10_1)
	arg_10_0:RefreshMessage(var_10_0, var_10_1)
	arg_10_0:RefreshRecord(var_10_0, var_10_1)
	arg_10_0:RefreshBonus(var_10_0)
	arg_10_0:RefreshPiece(var_10_0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.infoContent_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_0.layout_4)
	TimeTools.StartAfterSeconds(0.033, function()
		arg_10_0.contentTrs_.localPosition = Vector3.New(0, 0, 0)
		arg_10_0.infoContent_.localPosition = Vector3.New(0, 0, 0)
	end, {})
end

function var_0_0.RefreshInfo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = DrawPoolCfg[arg_12_1]

	arg_12_0:SetInfoText(var_12_0, arg_12_2)
end

function var_0_0.RefreshMessage(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:GetProbabilityList(arg_13_1, arg_13_2)
	local var_13_1 = #var_13_0

	for iter_13_0 = 1, var_13_1 do
		if not arg_13_0.items[iter_13_0] then
			local var_13_2 = Object.Instantiate(arg_13_0.msgItem_, arg_13_0.contentTrs_)

			arg_13_0.items[iter_13_0] = DrawInfoMessageItem.New(var_13_2)
		end

		local var_13_3 = var_13_0[iter_13_0]

		arg_13_0.items[iter_13_0]:RefreshData(var_13_3)
	end

	for iter_13_1 = var_13_1 + 1, #arg_13_0.items do
		arg_13_0.items[iter_13_1]:Show(false)
	end
end

function var_0_0.RefreshRecord(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0.recordView:RefreshRecord(arg_14_1, arg_14_2)
end

function var_0_0.OnRequestRecord(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.recordView:RefreshRecord(arg_15_1, arg_15_2)
end

function var_0_0.GetProbabilityList(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = DrawPoolCfg[arg_16_1].pool_type
	local var_16_1 = {}

	if var_16_0 == 2 then
		local var_16_2 = {}

		var_16_2.define = "DRAW_POOL_PROBABILITY_FIVE_WEAPON"
		var_16_2.poolId = arg_16_1
		var_16_2.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_1].desc
		var_16_2.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_2].desc
		var_16_2.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_3].desc
		var_16_2.s_up_servant = {}
		var_16_2.s_all_servant = {}

		if arg_16_2.s_up_item then
			for iter_16_0, iter_16_1 in ipairs(arg_16_2.s_up_item) do
				table.insert(var_16_2.s_up_servant, iter_16_1)
				table.insert(var_16_2.s_all_servant, iter_16_1)
			end

			if arg_16_2.s_other_item then
				for iter_16_2, iter_16_3 in ipairs(arg_16_2.s_other_item) do
					table.insert(var_16_2.s_all_servant, iter_16_3)
				end
			end
		else
			for iter_16_4, iter_16_5 in ipairs(arg_16_2.s_other_item) do
				table.insert(var_16_2.s_all_servant, iter_16_5)
			end
		end

		table.insert(var_16_1, var_16_2)

		local var_16_3 = {}

		var_16_3.define = "DRAW_POOL_PROBABILITY_FOUR_WEAPON"
		var_16_3.poolId = arg_16_1
		var_16_3.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_1].desc
		var_16_3.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_2].desc
		var_16_3.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_3].desc
		var_16_3.a_up_servant = {}
		var_16_3.a_all_servant = {}

		if arg_16_2.a_up_item then
			for iter_16_6, iter_16_7 in ipairs(arg_16_2.a_up_item) do
				table.insert(var_16_3.a_up_servant, iter_16_7)
				table.insert(var_16_3.a_all_servant, iter_16_7)
			end

			if arg_16_2.a_other_item then
				for iter_16_8, iter_16_9 in ipairs(arg_16_2.a_other_item) do
					table.insert(var_16_3.a_all_servant, iter_16_9)
				end
			end
		else
			for iter_16_10, iter_16_11 in ipairs(arg_16_2.a_other_item) do
				table.insert(var_16_3.a_all_servant, iter_16_11)
			end
		end

		table.insert(var_16_1, var_16_3)

		local var_16_4 = {}

		var_16_4.define = "DRAW_POOL_PROBABILITY_THREE_WEAPON"
		var_16_4.poolId = arg_16_1
		var_16_4.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_1].desc
		var_16_4.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_2].desc
		var_16_4.b_servant = {}

		if arg_16_2.b_item then
			for iter_16_12, iter_16_13 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_13].pool_id ~= 301 then
					table.insert(var_16_4.b_servant, iter_16_13)
				end
			end
		end

		table.insert(var_16_1, var_16_4)
	elseif var_16_0 == 8 then
		local var_16_5 = {}

		var_16_5.define = "DRAW_POOL_PROBABILITY_S"
		var_16_5.poolId = arg_16_1
		var_16_5.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_1].desc
		var_16_5.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_2].desc
		var_16_5.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_6].desc
		var_16_5.s_up_probability = arg_16_2.s_up_probability
		var_16_5.s_up_hero = {}
		var_16_5.s_all_hero = {}

		if arg_16_2.s_up_item then
			for iter_16_14, iter_16_15 in ipairs(arg_16_2.s_up_item) do
				table.insert(var_16_5.s_up_hero, iter_16_15)
				table.insert(var_16_5.s_all_hero, iter_16_15)
			end

			if arg_16_2.s_other_item then
				for iter_16_16, iter_16_17 in ipairs(arg_16_2.s_other_item) do
					table.insert(var_16_5.s_all_hero, iter_16_17)
				end
			end
		else
			for iter_16_18, iter_16_19 in ipairs(arg_16_2.s_other_item) do
				table.insert(var_16_5.s_all_hero, iter_16_19)
			end
		end

		table.insert(var_16_1, var_16_5)

		local var_16_6 = {}

		var_16_6.define = "DRAW_POOL_PROBABILITY_A"
		var_16_6.poolId = arg_16_1
		var_16_6.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc
		var_16_6.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc
		var_16_6.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc
		var_16_6.a_up_probability = arg_16_2.a_up_probability
		var_16_6.a_up_hero = {}
		var_16_6.a_all_hero = {}

		if arg_16_2.a_up_item then
			for iter_16_20, iter_16_21 in ipairs(arg_16_2.a_up_item) do
				table.insert(var_16_6.a_up_hero, iter_16_21)
				table.insert(var_16_6.a_all_hero, iter_16_21)
			end

			if arg_16_2.a_other_item then
				for iter_16_22, iter_16_23 in ipairs(arg_16_2.a_other_item) do
					table.insert(var_16_6.a_all_hero, iter_16_23)
				end
			end
		else
			for iter_16_24, iter_16_25 in ipairs(arg_16_2.a_other_item) do
				table.insert(var_16_6.a_all_hero, iter_16_25)
			end
		end

		table.insert(var_16_1, var_16_6)

		local var_16_7 = {}

		var_16_7.define = "DRAW_POOL_PROBABILITY_B"
		var_16_7.poolId = arg_16_1
		var_16_7.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc
		var_16_7.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc
		var_16_7.b_hero = {}

		if arg_16_2.b_item then
			for iter_16_26, iter_16_27 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_27].pool_id == 301 then
					table.insert(var_16_7.b_hero, iter_16_27)
				end
			end
		end

		table.insert(var_16_1, var_16_7)

		local var_16_8 = {}

		var_16_8.define = "DRAW_POOL_PROBABILITY_C"
		var_16_8.poolId = arg_16_1
		var_16_8.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc
		var_16_8.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc
		var_16_8.b_servant = {}

		if arg_16_2.b_item then
			for iter_16_28, iter_16_29 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_29].pool_id ~= 301 then
					table.insert(var_16_8.b_servant, iter_16_29)
				end
			end
		end

		table.insert(var_16_1, var_16_8)
	else
		local var_16_9 = {}

		var_16_9.define = "DRAW_POOL_PROBABILITY_S"
		var_16_9.poolId = arg_16_1
		var_16_9.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_1].desc
		var_16_9.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_2].desc
		var_16_9.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_3].desc
		var_16_9.s_up_probability = arg_16_2.s_up_probability
		var_16_9.s_up_hero = {}
		var_16_9.s_all_hero = {}

		if arg_16_2.s_up_item then
			for iter_16_30, iter_16_31 in ipairs(arg_16_2.s_up_item) do
				table.insert(var_16_9.s_up_hero, iter_16_31)
				table.insert(var_16_9.s_all_hero, iter_16_31)
			end

			if arg_16_2.s_other_item then
				for iter_16_32, iter_16_33 in ipairs(arg_16_2.s_other_item) do
					table.insert(var_16_9.s_all_hero, iter_16_33)
				end
			end
		else
			for iter_16_34, iter_16_35 in ipairs(arg_16_2.s_other_item) do
				table.insert(var_16_9.s_all_hero, iter_16_35)
			end
		end

		table.insert(var_16_1, var_16_9)

		local var_16_10 = {}

		var_16_10.define = "DRAW_POOL_PROBABILITY_A"
		var_16_10.poolId = arg_16_1
		var_16_10.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc
		var_16_10.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc
		var_16_10.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc
		var_16_10.a_up_probability = arg_16_2.a_up_probability
		var_16_10.a_up_hero = {}
		var_16_10.a_all_hero = {}

		if arg_16_2.a_up_item then
			for iter_16_36, iter_16_37 in ipairs(arg_16_2.a_up_item) do
				table.insert(var_16_10.a_up_hero, iter_16_37)
				table.insert(var_16_10.a_all_hero, iter_16_37)
			end

			if arg_16_2.a_other_item then
				for iter_16_38, iter_16_39 in ipairs(arg_16_2.a_other_item) do
					table.insert(var_16_10.a_all_hero, iter_16_39)
				end
			end
		else
			for iter_16_40, iter_16_41 in ipairs(arg_16_2.a_other_item) do
				table.insert(var_16_10.a_all_hero, iter_16_41)
			end
		end

		table.insert(var_16_1, var_16_10)

		local var_16_11 = {}

		var_16_11.define = "DRAW_POOL_PROBABILITY_B"
		var_16_11.poolId = arg_16_1
		var_16_11.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc
		var_16_11.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc
		var_16_11.b_hero = {}

		if arg_16_2.b_item then
			for iter_16_42, iter_16_43 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_43].pool_id == 301 then
					table.insert(var_16_11.b_hero, iter_16_43)
				end
			end
		end

		table.insert(var_16_1, var_16_11)

		local var_16_12 = {}

		var_16_12.define = "DRAW_POOL_PROBABILITY_C"
		var_16_12.poolId = arg_16_1
		var_16_12.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc
		var_16_12.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc
		var_16_12.b_servant = {}

		if arg_16_2.b_item then
			for iter_16_44, iter_16_45 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_45].pool_id ~= 301 then
					table.insert(var_16_12.b_servant, iter_16_45)
				end
			end
		end

		table.insert(var_16_1, var_16_12)
	end

	arg_16_0.probabilityCfgList[arg_16_1] = var_16_1

	return var_16_1
end

function var_0_0.SetInfoText(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_1.draw_pool_desc

	arg_17_0.infoTxt_.text = GetTips(arg_17_1.draw_pool_desc)

	if var_17_0 == "DRAW_POOL_DESC_TEMP_1" then
		local var_17_1 = arg_17_2.s_up_item[1]
		local var_17_2 = DrawItemCfg[var_17_1].item_id
		local var_17_3 = HeroTools.GetHeroFullName(var_17_2)

		arg_17_0.infoTxt_.text = string.format(GetTips(var_17_0), var_17_3, var_17_3)

		return
	elseif var_17_0 == "DRAW_POOL_DESC_TEMP_2" then
		arg_17_0:DescModule(arg_17_1, arg_17_2)

		return
	elseif var_17_0 == "DRAW_POOL_DESC_TEMP_3" then
		arg_17_0:DescModule(arg_17_1, arg_17_2)

		return
	elseif var_17_0 == "DRAW_POOL_DESC_TEMP_4" or var_17_0 == "DRAW_POOL_DESC_TEMP_8" or var_17_0 == "DRAW_POOL_DESC_TEMP_12" then
		arg_17_0:DescModule(arg_17_1, arg_17_2)

		return
	elseif var_17_0 == "DRAW_POOL_DESC_TEMP_5" or var_17_0 == "DRAW_POOL_DESC_TEMP_10" then
		arg_17_0:DescModule(arg_17_1, arg_17_2)

		return
	elseif var_17_0 == "DRAW_POOL_DESC_TEMP_6" then
		arg_17_0:DescModule(arg_17_1, arg_17_2)

		return
	elseif var_17_0 == "DRAW_POOL_DESC_TEMP_11" then
		arg_17_0:DescModule(arg_17_1, arg_17_2)

		return
	elseif var_17_0 == "DRAW_POOL_DESC_TEMP_7" or var_17_0 == "DRAW_POOL_DESC_TEMP_9" or var_17_0 == "DRAW_POOL_DESC_TEMP_13" then
		arg_17_0:DescModule(arg_17_1, arg_17_2)

		return
	end
end

function var_0_0.DescModule(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2.s_up_probability .. "%"
	local var_18_1 = arg_18_1.draw_pool_desc
	local var_18_2 = GetI18NText(arg_18_1.name)
	local var_18_3 = arg_18_2.s_up_item[1]

	if DrawItemCfg[var_18_3] == nil then
		Debug.LogError(string.format("配置表 DrawItemCfg 找不到 id : %s ", var_18_3))

		return
	end

	local var_18_4 = DrawItemCfg[var_18_3].item_id
	local var_18_5 = HeroTools.GetHeroFullName(var_18_4)

	if var_18_1 == "DRAW_POOL_DESC_TEMP_11" then
		local var_18_6 = DrawPoolCfg[arg_18_0.params_.poolId]
		local var_18_7 = ""

		for iter_18_0 = 1, #var_18_6.optional_detail do
			var_18_7 = var_18_7 .. string.format("<color=#E78300>「%s」</color>", HeroTools.GetHeroFullName(var_18_6.optional_detail[iter_18_0]))

			if iter_18_0 ~= #var_18_6.optional_detail then
				var_18_7 = var_18_7 .. "、"
			end
		end

		arg_18_0.infoTxt_.text = string.format(GetTips(var_18_1), var_18_7, var_18_0)

		return
	end

	if arg_18_2.a_up_item[1] ~= nil then
		local var_18_8 = arg_18_2.a_up_item[1]
		local var_18_9 = DrawItemCfg[var_18_8].item_id
		local var_18_10 = HeroTools.GetHeroFullName(var_18_9)
		local var_18_11 = arg_18_2.a_up_item[2]
		local var_18_12 = DrawItemCfg[var_18_11].item_id
		local var_18_13 = HeroTools.GetHeroFullName(var_18_12)
		local var_18_14 = arg_18_2.a_up_item[3]
		local var_18_15 = DrawItemCfg[var_18_14].item_id
		local var_18_16 = HeroTools.GetHeroFullName(var_18_15)
		local var_18_17 = arg_18_2.a_up_probability .. "%"

		arg_18_0.infoTxt_.text = string.format(GetTips(var_18_1), var_18_2, var_18_5, var_18_10, var_18_13, var_18_16, var_18_2, var_18_0, var_18_5, var_18_17, var_18_10, var_18_13, var_18_16, var_18_2)
	else
		arg_18_0.infoTxt_.text = string.format(GetTips(var_18_1), var_18_2, var_18_5, var_18_2, var_18_0, var_18_5, var_18_2)
	end
end

function var_0_0.RefreshBonus(arg_19_0, arg_19_1)
	local var_19_0 = DrawTools.GetDrawBonusActivityIDList()
	local var_19_1 = DrawTools.HasDrawBonusPoolID(var_19_0, arg_19_1)

	if var_19_1 then
		arg_19_0.bonusController_:SetSelectedState("on")

		local var_19_2 = ActivityDrawBonusCfg[var_19_1]

		arg_19_0.bonusTitleText_.text = var_19_2.draw_title
		arg_19_0.bonusInfoText_.text = var_19_2.draw_desc
	else
		arg_19_0.bonusController_:SetSelectedState("off")
	end
end

function var_0_0.RefreshPiece(arg_20_0, arg_20_1)
	local var_20_0 = DrawTools.GetDrawPieceActivityIDList()
	local var_20_1 = DrawTools.HasDrawPiecePoolID(var_20_0, arg_20_1)

	if var_20_1 then
		arg_20_0.pieceController_:SetSelectedState("on")

		local var_20_2 = ActivityDrawPieceCfg[var_20_1]

		arg_20_0.pieceTitleText_.text = var_20_2.draw_title
		arg_20_0.pieceInfoText_.text = var_20_2.draw_desc
	else
		arg_20_0.pieceController_:SetSelectedState("off")
	end
end

function var_0_0.Dispose(arg_21_0)
	var_0_0.super.Dispose(arg_21_0)
	arg_21_0.recordView:Dispose()

	if arg_21_0.items then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0.items) do
			iter_21_1:Dispose()
		end

		arg_21_0.items = nil
	end

	if arg_21_0.probabilityCfgList then
		for iter_21_2, iter_21_3 in ipairs(arg_21_0.probabilityCfgList) do
			iter_21_3 = nil
		end
	end
end

return var_0_0
