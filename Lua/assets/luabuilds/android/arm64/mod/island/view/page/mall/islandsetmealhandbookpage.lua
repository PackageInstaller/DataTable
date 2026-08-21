local var_0_0 = class("IslandSetMealHandbookPage", import("...base.IslandBasePage"))

function var_0_0.getUIName(arg_1_0)
	return "IslandSetMealHandbookUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("top/back")
	arg_2_0.setMealList = UIItemList.New(arg_2_0._tf:Find("setMealList/Viewport/Content"), arg_2_0._tf:Find("setMealList/Viewport/Content/setMealTpl"))
	arg_2_0.detail = arg_2_0._tf:Find("detail")
	arg_2_0.detailName = arg_2_0.detail:Find("name/text")
	arg_2_0.formulaList1 = arg_2_0.detail:Find("formulaList1")
	arg_2_0.formulaList2 = arg_2_0.detail:Find("formulaList2")
	arg_2_0.detailDesc = arg_2_0.detail:Find("desc")
	arg_2_0.conditionList = UIItemList.New(arg_2_0.detail:Find("conditionList"), arg_2_0.detail:Find("conditionList/condition"))

	setActive(arg_2_0.detail, false)
	setText(arg_2_0._tf:Find("top/title/Text"), i18n("island_setmeal_title"))
	setText(arg_2_0._tf:Find("top/title/Text/en"), i18n1("HANDBOOK"))
	setText(arg_2_0._tf:Find("detail/condition"), i18n("island_tech_detail_unlocktitle"))
	setText(arg_2_0._tf:Find("detail/decoration2/text"), i18n("island_setmeal_benifit_title"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_combo.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	arg_3_0:InitData()

	return
end

function var_0_0.InitData(arg_6_0)
	arg_6_0.formulaNums = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetFormulaNums()
	arg_6_0.formulas = {}

	for iter_6_0, iter_6_1 in ipairs(pg.island_combo.all) do
		local var_6_0 = Clone(pg.island_formula[iter_6_1])

		var_6_0.unlock_condition = pg.island_combo[iter_6_1].unlock_condition
		var_6_0.is_hide = pg.island_combo[iter_6_1].is_hide

		table.insert(arg_6_0.formulas, var_6_0)
	end

	table.sort(arg_6_0.formulas, CompareFuncs({
		function(arg_7_0)
			local var_7_0 = arg_7_0.is_hide == 1
			local var_7_1 = true
			local var_7_2 = true

			for iter_7_0, iter_7_1 in ipairs(arg_7_0.unlock_condition) do
				local var_7_3 = iter_7_1[1]
				local var_7_4 = iter_7_1[2]

				if not arg_6_0.formulaNums[iter_7_1[1]] or arg_6_0.formulaNums[var_7_3] < 1 then
					var_7_1 = false
				end

				if not arg_6_0.formulaNums[var_7_3] or var_7_4 > arg_6_0.formulaNums[var_7_3] then
					var_7_2 = false
				end
			end

			return (not var_7_0 and var_7_1 or var_7_0 and var_7_2) and 0 or 1
		end,
		function(arg_8_0)
			return arg_8_0.id
		end
	}))

	return
end

function var_0_0.SetFormulaList(arg_9_0)
	arg_9_0.setMealList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = arg_9_0.formulas[arg_10_1 + 1]
			local var_10_1 = arg_9_0.formulas[arg_10_1 + 1].is_hide == 1
			local var_10_2 = true
			local var_10_3 = true

			for iter_10_0, iter_10_1 in ipairs(arg_9_0.formulas[arg_10_1 + 1].unlock_condition) do
				local var_10_4 = iter_10_1[1]
				local var_10_5 = iter_10_1[2]

				if not arg_9_0.formulaNums[iter_10_1[1]] or arg_9_0.formulaNums[var_10_4] < 1 then
					var_10_2 = false
				end

				if not arg_9_0.formulaNums[var_10_4] or var_10_5 > arg_9_0.formulaNums[var_10_4] then
					var_10_3 = false
				end
			end

			local var_10_6 = not var_10_1 and var_10_2 or var_10_1 and var_10_3

			setActive(arg_10_2:Find("special"), var_10_1 and var_10_3)
			setActive(arg_10_2:Find("name"), var_10_6)
			setActive(arg_10_2:Find("IslandItemTpl"), var_10_6)
			setActive(arg_10_2:Find("lock"), not var_10_6)

			if var_10_6 then
				setScrollText(arg_10_2:Find("name/text"), var_10_0.name)
				updateCustomDrop(arg_10_2:Find("IslandItemTpl"), {
					count = 0,
					type = DROP_TYPE_ISLAND_ITEM,
					id = var_10_0.item_id
				})
			end

			if var_10_6 then
				onToggle(arg_9_0, arg_10_2, function(arg_11_0)
					setActive(arg_10_2:Find("select"), arg_11_0)

					if arg_11_0 then
						arg_9_0:SetDetail(var_10_0)
					end

					return
				end, SFX_PANEL)
			else
				removeOnToggle(arg_10_2)
			end
		end

		return
	end)
	arg_9_0.setMealList:align(#arg_9_0.formulas)

	return
end

function var_0_0.SetDetail(arg_12_0, arg_12_1)
	setActive(arg_12_0.detail, true)
	setScrollText(arg_12_0.detailName, arg_12_1.name)
	setActive(arg_12_0.formulaList1, #arg_12_1.unlock_condition == 2)
	setActive(arg_12_0.formulaList2, #arg_12_1.unlock_condition == 3)

	if #arg_12_1.unlock_condition == 2 then
		for iter_12_0 = 1, 2 do
			GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[arg_12_1.unlock_condition[iter_12_0][1]].item_id].icon, "", arg_12_0.formulaList1:Find("formula" .. iter_12_0 .. "/icon"))
		end
	elseif #arg_12_1.unlock_condition == 3 then
		for iter_12_1 = 1, 3 do
			GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[arg_12_1.unlock_condition[iter_12_1][1]].item_id].icon, "", arg_12_0.formulaList2:Find("formula" .. iter_12_1 .. "/icon"))
		end
	end

	local var_12_0 = true

	arg_12_0.conditionList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = arg_12_1.unlock_condition[arg_13_1 + 1][2]

			setScrollText(arg_13_2:Find("name/text"), i18n("island_combo_produced") .. pg.island_formula[arg_12_1.unlock_condition[arg_13_1 + 1][1]].name)

			local var_13_1 = arg_12_0.formulaNums[arg_12_1.unlock_condition[arg_13_1 + 1][1]] or 0

			setActive(arg_13_2:Find("notComplete"), var_13_1 < var_13_0)
			setActive(arg_13_2:Find("complete"), var_13_0 <= var_13_1)

			if var_13_0 < var_13_1 then
				formulaNum = var_13_0
			end

			setText(arg_13_2:Find("count"), i18n("island_combo_produced_times", "" .. var_13_1 .. "/" .. var_13_0))

			if var_13_1 < var_13_0 then
				var_12_0 = false
			end
		end

		return
	end)
	arg_12_0.conditionList:align(#arg_12_1.unlock_condition)

	if var_12_0 == true then
		setText(arg_12_0.detailDesc, i18n("island_combo_unlock"))
	else
		local var_12_2 = arg_12_1.desc or ""

		var_12_1(arg_12_0.detailDesc, var_12_2)
	end

	return
end

function var_0_0.OnShow(arg_14_0)
	arg_14_0:InitData()
	arg_14_0:SetFormulaList()
	pg.UIMgr.GetInstance():BlurPanel(arg_14_0._tf)

	return
end

function var_0_0.OnHide(arg_15_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_15_0._tf)

	return
end

function var_0_0.OnDestroy(arg_16_0)
	arg_16_0:OnHide()

	return
end

return var_0_0
