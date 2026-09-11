local DrawInfoPopView = class("DrawInfoPopView", ReduxView)

function DrawInfoPopView:UIName()
	return "Widget/System/Pool/PoolInfoPopUI"
end

function DrawInfoPopView:UIParent()
	return manager.ui.uiPop.transform
end

function DrawInfoPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function DrawInfoPopView:InitUI()
	self:BindCfgUI()

	self.probabilityCfgList = {}
	self.items = {}
	self.stateCon_ = self.controllerEx_:GetController("state")
	self.recordView = DrawInfoPopRecordView.New(self.recordGo_)
	self.bonusController_ = self.controllerEx_:GetController("ExtractReturn")
	self.pieceController_ = self.controllerEx_:GetController("ExtractPiece")
end

function DrawInfoPopView:AddUIListener()
	self:AddBtnListener(self.bgMask_, nil, function()
		self.stateCon_:SetSelectedState("info")
		self:Back()
	end)
	self:AddBtnListener(self.btnInfo_, nil, function()
		self.stateCon_:SetSelectedState("info")
	end)
	self:AddBtnListener(self.btnMessage_, nil, function()
		self.stateCon_:SetSelectedState("message")
	end)
	self:AddBtnListener(self.btnRecord_, nil, function()
		self.stateCon_:SetSelectedState("record")
	end)
end

function DrawInfoPopView:OnEnter()
	local var_10_0 = DrawData:GetPoolData(self.params_.poolId)

	self.ani_:Update(0)
	self:RefreshInfo(self.params_.poolId, var_10_0)
	self:RefreshMessage(self.params_.poolId, var_10_0)
	self:RefreshRecord(self.params_.poolId, var_10_0)
	self:RefreshBonus(self.params_.poolId)
	self:RefreshPiece(self.params_.poolId)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_1)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.infoContent_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_2)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_3)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.layout_4)
	TimeTools.StartAfterSeconds(0.033, function()
		self.contentTrs_.localPosition = Vector3.New(0, 0, 0)
		self.infoContent_.localPosition = Vector3.New(0, 0, 0)
	end, {})
end

function DrawInfoPopView:RefreshInfo(arg_12_1, arg_12_2)
	self:SetInfoText(DrawPoolCfg[arg_12_1], arg_12_2)
end

function DrawInfoPopView:RefreshMessage(arg_13_1, arg_13_2)
	local var_13_0 = self:GetProbabilityList(arg_13_1, arg_13_2)

	for iter_13_0 = 1, #var_13_0 do
		self.items[iter_13_0] = self.items[iter_13_0] or DrawInfoMessageItem.New((Object.Instantiate(self.msgItem_, self.contentTrs_)))

		self.items[iter_13_0]:RefreshData(var_13_0[iter_13_0])
	end

	for iter_13_1 = #var_13_0 + 1, #self.items do
		self.items[iter_13_1]:Show(false)
	end
end

function DrawInfoPopView:RefreshRecord(arg_14_1, arg_14_2)
	self.recordView:RefreshRecord(arg_14_1, arg_14_2)
end

function DrawInfoPopView:OnRequestRecord(arg_15_1, arg_15_2)
	self.recordView:RefreshRecord(arg_15_1, arg_15_2)
end

function DrawInfoPopView:GetProbabilityList(arg_16_1, arg_16_2)
	local var_16_0 = {}

	if DrawPoolCfg[arg_16_1].pool_type == 2 then
		local var_16_1 = {}

		var_16_1.define = "DRAW_POOL_PROBABILITY_FIVE_WEAPON"
		var_16_1.poolId = arg_16_1
		var_16_1.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_1].desc
		var_16_1.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_2].desc
		var_16_1.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FIVE_WEAPON_3].desc
		var_16_1.s_up_servant = {}
		var_16_1.s_all_servant = {}

		if arg_16_2.s_up_item then
			for iter_16_0, iter_16_1 in ipairs(arg_16_2.s_up_item) do
				table.insert(var_16_1.s_up_servant, iter_16_1)
				table.insert(var_16_1.s_all_servant, iter_16_1)
			end

			if arg_16_2.s_other_item then
				for iter_16_2, iter_16_3 in ipairs(arg_16_2.s_other_item) do
					table.insert(var_16_1.s_all_servant, iter_16_3)
				end
			end
		else
			for iter_16_4, iter_16_5 in ipairs(arg_16_2.s_other_item) do
				table.insert(var_16_1.s_all_servant, iter_16_5)
			end
		end

		table.insert(var_16_0, var_16_1)

		local var_16_2 = {}

		var_16_2.define = "DRAW_POOL_PROBABILITY_FOUR_WEAPON"
		var_16_2.poolId = arg_16_1
		var_16_2.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_1].desc
		var_16_2.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_2].desc
		var_16_2.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_FOUR_WEAPON_3].desc
		var_16_2.a_up_servant = {}
		var_16_2.a_all_servant = {}

		if arg_16_2.a_up_item then
			for iter_16_6, iter_16_7 in ipairs(arg_16_2.a_up_item) do
				table.insert(var_16_2.a_up_servant, iter_16_7)
				table.insert(var_16_2.a_all_servant, iter_16_7)
			end

			if arg_16_2.a_other_item then
				for iter_16_8, iter_16_9 in ipairs(arg_16_2.a_other_item) do
					table.insert(var_16_2.a_all_servant, iter_16_9)
				end
			end
		else
			for iter_16_10, iter_16_11 in ipairs(arg_16_2.a_other_item) do
				table.insert(var_16_2.a_all_servant, iter_16_11)
			end
		end

		table.insert(var_16_0, var_16_2)

		local var_16_3 = {}

		var_16_3.define = "DRAW_POOL_PROBABILITY_THREE_WEAPON"
		var_16_3.poolId = arg_16_1
		var_16_3.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_1].desc
		var_16_3.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_THREE_WEAPON_2].desc
		var_16_3.b_servant = {}

		if arg_16_2.b_item then
			for iter_16_12, iter_16_13 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_13].pool_id ~= 301 then
					table.insert(var_16_3.b_servant, iter_16_13)
				end
			end
		end

		table.insert(var_16_0, var_16_3)
	elseif DrawPoolCfg[arg_16_1].pool_type == 8 then
		local var_16_4 = {}

		var_16_4.define = "DRAW_POOL_PROBABILITY_S"
		var_16_4.poolId = arg_16_1
		var_16_4.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_1].desc
		var_16_4.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_2].desc
		var_16_4.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_6].desc
		var_16_4.s_up_probability = arg_16_2.s_up_probability
		var_16_4.s_up_hero = {}
		var_16_4.s_all_hero = {}

		if arg_16_2.s_up_item then
			for iter_16_14, iter_16_15 in ipairs(arg_16_2.s_up_item) do
				table.insert(var_16_4.s_up_hero, iter_16_15)
				table.insert(var_16_4.s_all_hero, iter_16_15)
			end

			if arg_16_2.s_other_item then
				for iter_16_16, iter_16_17 in ipairs(arg_16_2.s_other_item) do
					table.insert(var_16_4.s_all_hero, iter_16_17)
				end
			end
		else
			for iter_16_18, iter_16_19 in ipairs(arg_16_2.s_other_item) do
				table.insert(var_16_4.s_all_hero, iter_16_19)
			end
		end

		table.insert(var_16_0, var_16_4)

		local var_16_5 = {}

		var_16_5.define = "DRAW_POOL_PROBABILITY_A"
		var_16_5.poolId = arg_16_1
		var_16_5.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc
		var_16_5.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc
		var_16_5.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc
		var_16_5.a_up_probability = arg_16_2.a_up_probability
		var_16_5.a_up_hero = {}
		var_16_5.a_all_hero = {}

		if arg_16_2.a_up_item then
			for iter_16_20, iter_16_21 in ipairs(arg_16_2.a_up_item) do
				table.insert(var_16_5.a_up_hero, iter_16_21)
				table.insert(var_16_5.a_all_hero, iter_16_21)
			end

			if arg_16_2.a_other_item then
				for iter_16_22, iter_16_23 in ipairs(arg_16_2.a_other_item) do
					table.insert(var_16_5.a_all_hero, iter_16_23)
				end
			end
		else
			for iter_16_24, iter_16_25 in ipairs(arg_16_2.a_other_item) do
				table.insert(var_16_5.a_all_hero, iter_16_25)
			end
		end

		table.insert(var_16_0, var_16_5)

		local var_16_6 = {}

		var_16_6.define = "DRAW_POOL_PROBABILITY_B"
		var_16_6.poolId = arg_16_1
		var_16_6.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc
		var_16_6.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc
		var_16_6.b_hero = {}

		if arg_16_2.b_item then
			for iter_16_26, iter_16_27 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_27].pool_id == 301 then
					table.insert(var_16_6.b_hero, iter_16_27)
				end
			end
		end

		table.insert(var_16_0, var_16_6)

		local var_16_7 = {}

		var_16_7.define = "DRAW_POOL_PROBABILITY_C"
		var_16_7.poolId = arg_16_1
		var_16_7.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc
		var_16_7.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc
		var_16_7.b_servant = {}

		if arg_16_2.b_item then
			for iter_16_28, iter_16_29 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_29].pool_id ~= 301 then
					table.insert(var_16_7.b_servant, iter_16_29)
				end
			end
		end

		table.insert(var_16_0, var_16_7)
	else
		local var_16_8 = {}

		var_16_8.define = "DRAW_POOL_PROBABILITY_S"
		var_16_8.poolId = arg_16_1
		var_16_8.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_1].desc
		var_16_8.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_2].desc
		var_16_8.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_S_3].desc
		var_16_8.s_up_probability = arg_16_2.s_up_probability
		var_16_8.s_up_hero = {}
		var_16_8.s_all_hero = {}

		if arg_16_2.s_up_item then
			for iter_16_30, iter_16_31 in ipairs(arg_16_2.s_up_item) do
				table.insert(var_16_8.s_up_hero, iter_16_31)
				table.insert(var_16_8.s_all_hero, iter_16_31)
			end

			if arg_16_2.s_other_item then
				for iter_16_32, iter_16_33 in ipairs(arg_16_2.s_other_item) do
					table.insert(var_16_8.s_all_hero, iter_16_33)
				end
			end
		else
			for iter_16_34, iter_16_35 in ipairs(arg_16_2.s_other_item) do
				table.insert(var_16_8.s_all_hero, iter_16_35)
			end
		end

		table.insert(var_16_0, var_16_8)

		local var_16_9 = {}

		var_16_9.define = "DRAW_POOL_PROBABILITY_A"
		var_16_9.poolId = arg_16_1
		var_16_9.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_1].desc
		var_16_9.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_2].desc
		var_16_9.probability2 = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_A_3].desc
		var_16_9.a_up_probability = arg_16_2.a_up_probability
		var_16_9.a_up_hero = {}
		var_16_9.a_all_hero = {}

		if arg_16_2.a_up_item then
			for iter_16_36, iter_16_37 in ipairs(arg_16_2.a_up_item) do
				table.insert(var_16_9.a_up_hero, iter_16_37)
				table.insert(var_16_9.a_all_hero, iter_16_37)
			end

			if arg_16_2.a_other_item then
				for iter_16_38, iter_16_39 in ipairs(arg_16_2.a_other_item) do
					table.insert(var_16_9.a_all_hero, iter_16_39)
				end
			end
		else
			for iter_16_40, iter_16_41 in ipairs(arg_16_2.a_other_item) do
				table.insert(var_16_9.a_all_hero, iter_16_41)
			end
		end

		table.insert(var_16_0, var_16_9)

		local var_16_10 = {}

		var_16_10.define = "DRAW_POOL_PROBABILITY_B"
		var_16_10.poolId = arg_16_1
		var_16_10.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_1].desc
		var_16_10.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_B_2].desc
		var_16_10.b_hero = {}

		if arg_16_2.b_item then
			for iter_16_42, iter_16_43 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_43].pool_id == 301 then
					table.insert(var_16_10.b_hero, iter_16_43)
				end
			end
		end

		table.insert(var_16_0, var_16_10)

		local var_16_11 = {}

		var_16_11.define = "DRAW_POOL_PROBABILITY_C"
		var_16_11.poolId = arg_16_1
		var_16_11.name = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_1].desc
		var_16_11.probability = TipsCfg[TipsCfg.get_id_list_by_define.DRAW_POOL_PROBABILITY_C_2].desc
		var_16_11.b_servant = {}

		if arg_16_2.b_item then
			for iter_16_44, iter_16_45 in ipairs(arg_16_2.b_item) do
				if DrawItemCfg[iter_16_45].pool_id ~= 301 then
					table.insert(var_16_11.b_servant, iter_16_45)
				end
			end
		end

		table.insert(var_16_0, var_16_11)
	end

	self.probabilityCfgList[arg_16_1] = var_16_0

	return var_16_0
end

function DrawInfoPopView:SetInfoText(arg_17_1, arg_17_2)
	self.infoTxt_.text = GetTips(arg_17_1.draw_pool_desc)

	if arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_1" then
		local var_17_0 = HeroTools.GetHeroFullName(DrawItemCfg[arg_17_2.s_up_item[1]].item_id)

		self.infoTxt_.text = string.format(GetTips(arg_17_1.draw_pool_desc), var_17_0, var_17_0)

		return
	elseif arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_2" then
		self:DescModule(arg_17_1, arg_17_2)

		return
	elseif arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_3" then
		self:DescModule(arg_17_1, arg_17_2)

		return
	elseif arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_4" or arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_8" or arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_12" then
		self:DescModule(arg_17_1, arg_17_2)

		return
	elseif arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_5" or arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_10" then
		self:DescModule(arg_17_1, arg_17_2)

		return
	elseif arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_6" then
		self:DescModule(arg_17_1, arg_17_2)

		return
	elseif arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_11" then
		self:DescModule(arg_17_1, arg_17_2)

		return
	elseif arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_7" or arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_9" or arg_17_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_13" then
		self:DescModule(arg_17_1, arg_17_2)

		return
	end
end

function DrawInfoPopView:DescModule(arg_18_1, arg_18_2)
	local var_18_0 = GetI18NText(arg_18_1.name)

	if DrawItemCfg[arg_18_2.s_up_item[1]] == nil then
		Debug.LogError(string.format("配置表 DrawItemCfg 找不到 id : %s ", arg_18_2.s_up_item[1]))

		return
	end

	local var_18_1 = HeroTools.GetHeroFullName(DrawItemCfg[arg_18_2.s_up_item[1]].item_id)

	if arg_18_1.draw_pool_desc == "DRAW_POOL_DESC_TEMP_11" then
		local var_18_2 = ""

		for iter_18_0 = 1, #DrawPoolCfg[self.params_.poolId].optional_detail do
			var_18_2 = var_18_2 .. string.format("<color=#E78300>「%s」</color>", HeroTools.GetHeroFullName(DrawPoolCfg[self.params_.poolId].optional_detail[iter_18_0]))

			if iter_18_0 ~= #DrawPoolCfg[self.params_.poolId].optional_detail then
				var_18_2 = var_18_2 .. "、"
			end
		end

		self.infoTxt_.text = string.format(GetTips(arg_18_1.draw_pool_desc), var_18_2, arg_18_2.s_up_probability .. "%")

		return
	end

	if arg_18_2.a_up_item[1] ~= nil then
		local var_18_3 = HeroTools.GetHeroFullName(DrawItemCfg[arg_18_2.a_up_item[1]].item_id)
		local var_18_4 = HeroTools.GetHeroFullName(DrawItemCfg[arg_18_2.a_up_item[2]].item_id)
		local var_18_5 = HeroTools.GetHeroFullName(DrawItemCfg[arg_18_2.a_up_item[3]].item_id)

		self.infoTxt_.text = string.format(GetTips(arg_18_1.draw_pool_desc), var_18_0, var_18_1, var_18_3, var_18_4, var_18_5, var_18_0, arg_18_2.s_up_probability .. "%", var_18_1, arg_18_2.a_up_probability .. "%", var_18_3, var_18_4, var_18_5, var_18_0)
	else
		self.infoTxt_.text = string.format(GetTips(arg_18_1.draw_pool_desc), var_18_0, var_18_1, var_18_0, arg_18_2.s_up_probability .. "%", var_18_1, var_18_0)
	end
end

function DrawInfoPopView:RefreshBonus(arg_19_1)
	local var_19_0 = DrawTools.HasDrawBonusPoolID(DrawTools.GetDrawBonusActivityIDList(), arg_19_1)

	if var_19_0 then
		self.bonusController_:SetSelectedState("on")

		self.bonusTitleText_.text = ActivityDrawBonusCfg[var_19_0].draw_title
		self.bonusInfoText_.text = ActivityDrawBonusCfg[var_19_0].draw_desc
	else
		self.bonusController_:SetSelectedState("off")
	end
end

function DrawInfoPopView:RefreshPiece(arg_20_1)
	local var_20_0 = DrawTools.HasDrawPiecePoolID(DrawTools.GetDrawPieceActivityIDList(), arg_20_1)

	if var_20_0 then
		self.pieceController_:SetSelectedState("on")

		self.pieceTitleText_.text = ActivityDrawPieceCfg[var_20_0].draw_title
		self.pieceInfoText_.text = ActivityDrawPieceCfg[var_20_0].draw_desc
	else
		self.pieceController_:SetSelectedState("off")
	end
end

function DrawInfoPopView:Dispose()
	DrawInfoPopView.super.Dispose(self)
	self.recordView:Dispose()

	if self.items then
		for iter_21_0, iter_21_1 in ipairs(self.items) do
			iter_21_1:Dispose()
		end

		self.items = nil
	end

	if self.probabilityCfgList then
		for iter_21_2, iter_21_3 in ipairs(self.probabilityCfgList) do
			iter_21_3 = nil
		end
	end
end

return DrawInfoPopView
