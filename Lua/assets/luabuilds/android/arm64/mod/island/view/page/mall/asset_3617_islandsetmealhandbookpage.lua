local IslandSetMealHandbookPage = class("IslandSetMealHandbookPage", import("...base.IslandBasePage"))

function IslandSetMealHandbookPage:getUIName()
	return "IslandSetMealHandbookUI"
end

function IslandSetMealHandbookPage:OnLoaded()
	self.closeBtn = self._tf:Find("top/back")
	self.setMealList = UIItemList.New(self._tf:Find("setMealList/Viewport/Content"), self._tf:Find("setMealList/Viewport/Content/setMealTpl"))
	self.detail = self._tf:Find("detail")
	self.detailName = self.detail:Find("name/text")
	self.formulaList1 = self.detail:Find("formulaList1")
	self.formulaList2 = self.detail:Find("formulaList2")
	self.detailDesc = self.detail:Find("desc")
	self.conditionList = UIItemList.New(self.detail:Find("conditionList"), self.detail:Find("conditionList/condition"))

	setActive(self.detail, false)
	setText(self._tf:Find("top/title/Text"), i18n("island_setmeal_title"))
	setText(self._tf:Find("top/title/Text/en"), i18n1("HANDBOOK"))
	setText(self._tf:Find("detail/condition"), i18n("island_tech_detail_unlocktitle"))
	setText(self._tf:Find("detail/decoration2/text"), i18n("island_setmeal_benifit_title"))

	return
end

function IslandSetMealHandbookPage:OnInit()
	onButton(self, self._tf:Find("top/title/help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.island_help_combo.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.closeBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)
	self:InitData()

	return
end

function IslandSetMealHandbookPage:InitData()
	self.formulaNums = getProxy(IslandProxy):GetIsland():GetBuildingAgency():GetFormulaNums()
	self.formulas = {}

	for iter_6_0, iter_6_1 in ipairs(pg.island_combo.all) do
		local var_6_0 = Clone(pg.island_formula[iter_6_1])

		var_6_0.unlock_condition = pg.island_combo[iter_6_1].unlock_condition
		var_6_0.is_hide = pg.island_combo[iter_6_1].is_hide

		table.insert(self.formulas, var_6_0)
	end

	table.sort(self.formulas, CompareFuncs({
		function(arg_7_0)
			local var_7_0 = arg_7_0.is_hide == 1
			local var_7_1 = true
			local var_7_2 = true

			for iter_7_0, iter_7_1 in ipairs(arg_7_0.unlock_condition) do
				local var_7_3 = iter_7_1[1]

				if not self.formulaNums[iter_7_1[1]] or self.formulaNums[var_7_3] < 1 then
					var_7_1 = false
				end

				if not self.formulaNums[var_7_3] or iter_7_1[2] > self.formulaNums[var_7_3] then
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

function IslandSetMealHandbookPage:SetFormulaList()
	self.setMealList:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = self.formulas[arg_10_1 + 1]
			local var_10_1 = self.formulas[arg_10_1 + 1].is_hide == 1
			local var_10_2 = true
			local var_10_3 = true

			for iter_10_0, iter_10_1 in ipairs(self.formulas[arg_10_1 + 1].unlock_condition) do
				local var_10_4 = iter_10_1[1]

				if not self.formulaNums[iter_10_1[1]] or self.formulaNums[var_10_4] < 1 then
					var_10_2 = false
				end

				if not self.formulaNums[var_10_4] or iter_10_1[2] > self.formulaNums[var_10_4] then
					var_10_3 = false
				end
			end

			local var_10_5 = not var_10_1 and var_10_2 or var_10_1 and var_10_3

			setActive(arg_10_2:Find("special"), var_10_1 and var_10_3)
			setActive(arg_10_2:Find("name"), var_10_5)
			setActive(arg_10_2:Find("IslandItemTpl"), var_10_5)
			setActive(arg_10_2:Find("lock"), not var_10_5)

			if var_10_5 then
				setScrollText(arg_10_2:Find("name/text"), var_10_0.name)
				updateCustomDrop(arg_10_2:Find("IslandItemTpl"), {
					count = 0,
					type = DROP_TYPE_ISLAND_ITEM,
					id = var_10_0.item_id
				})
			end

			if var_10_5 then
				onToggle(self, arg_10_2, function(arg_11_0)
					setActive(arg_10_2:Find("select"), arg_11_0)

					if arg_11_0 then
						self:SetDetail(var_10_0)
					end

					return
				end, SFX_PANEL)
			else
				removeOnToggle(arg_10_2)
			end
		end

		return
	end)
	self.setMealList:align(#self.formulas)

	return
end

function IslandSetMealHandbookPage:SetDetail(arg_12_1)
	setActive(self.detail, true)
	setScrollText(self.detailName, arg_12_1.name)
	setActive(self.formulaList1, #arg_12_1.unlock_condition == 2)
	setActive(self.formulaList2, #arg_12_1.unlock_condition == 3)

	if #arg_12_1.unlock_condition == 2 then
		for iter_12_0 = 1, 2 do
			GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[arg_12_1.unlock_condition[iter_12_0][1]].item_id].icon, "", self.formulaList1:Find("formula" .. iter_12_0 .. "/icon"))
		end
	elseif #arg_12_1.unlock_condition == 3 then
		for iter_12_1 = 1, 3 do
			GetImageSpriteFromAtlasAsync("island/" .. pg.island_item_data_template[pg.island_formula[arg_12_1.unlock_condition[iter_12_1][1]].item_id].icon, "", self.formulaList2:Find("formula" .. iter_12_1 .. "/icon"))
		end
	end

	local var_12_0 = true

	self.conditionList:make(function(arg_13_0, arg_13_1, arg_13_2)
		if arg_13_0 == UIItemList.EventUpdate then
			local var_13_0 = arg_12_1.unlock_condition[arg_13_1 + 1][2]

			setScrollText(arg_13_2:Find("name/text"), i18n("island_combo_produced") .. pg.island_formula[arg_12_1.unlock_condition[arg_13_1 + 1][1]].name)

			local var_13_1 = self.formulaNums[arg_12_1.unlock_condition[arg_13_1 + 1][1]] or 0

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
	self.conditionList:align(#arg_12_1.unlock_condition)

	if var_12_0 == true then
		setText(self.detailDesc, i18n("island_combo_unlock"))
	else
		setText(self.detailDesc, (not arg_12_1.desc or nil) and "")
	end

	return
end

function IslandSetMealHandbookPage:OnShow()
	self:InitData()
	self:SetFormulaList()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function IslandSetMealHandbookPage:OnHide()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function IslandSetMealHandbookPage:OnDestroy()
	self:OnHide()

	return
end

return IslandSetMealHandbookPage
