class = var_0_10000

local var_0_0 = "IslandSetMealHandbookPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSetMealHandbookUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "top/back")
	UIItemList = var_1

	local var_2_1 = var_1.New
	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "setMealList/Viewport/Content")
	local var_2_4 = arg_2_0._tf

	arg_2_0.setMealList = var_2_1(var_2_3, var_4.Find(var_2_4, "setMealList/Viewport/Content/setMealTpl"))

	local var_2_5 = arg_2_0._tf

	arg_2_0.detail = var_1.Find(var_2_5, "detail")

	local var_2_6 = arg_2_0.detail

	arg_2_0.detailName = var_1.Find(var_2_6, "name/text")

	local var_2_7 = arg_2_0.detail

	arg_2_0.formulaList1 = var_1.Find(var_2_7, "formulaList1")

	local var_2_8 = arg_2_0.detail

	arg_2_0.formulaList2 = var_1.Find(var_2_8, "formulaList2")

	local var_2_9 = arg_2_0.detail

	arg_2_0.detailDesc = var_1.Find(var_2_9, "desc")
	UIItemList = var_1

	local var_2_10 = var_1.New
	local var_2_11 = arg_2_0.detail
	local var_2_12 = var_3.Find(var_2_11, "conditionList")
	local var_2_13 = arg_2_0.detail

	arg_2_0.conditionList = var_2_10(var_2_12, var_4.Find(var_2_13, "conditionList/condition"))
	setActive = var_1

	var_1(arg_2_0.detail, false)

	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_3.Find(var_2_14, "top/title/Text")

	i18n = var_4

	var_1(var_2_15, var_4("island_setmeal_title"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_3.Find(var_2_16, "top/title/Text/en")

	i18n1 = var_4

	var_1(var_2_17, var_4("HANDBOOK"))

	setText = var_1

	local var_2_18 = arg_2_0._tf
	local var_2_19 = var_3.Find(var_2_18, "detail/condition")

	i18n = var_4

	var_1(var_2_19, var_4("island_tech_detail_unlocktitle"))

	setText = var_1

	local var_2_20 = arg_2_0._tf
	local var_2_21 = var_3.Find(var_2_20, "detail/decoration2/text")

	i18n = var_4

	var_1(var_2_21, var_4("island_setmeal_benifit_title"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/title/help")

	local function var_3_3()
		pg = var_2_10000

		local var_4_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_4_1 = var_0.ShowMsgBox
		local var_4_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_4_2.type = var_2_10004
		pg = var_2_10004
		var_4_2.helps = var_2_10004.gametip.island_help_combo.tip

		var_4_1(var_4_0, var_4_2)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.closeBtn

	local function var_3_6()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_4, var_3_5, var_3_6, var_3_1)
	arg_3_0:InitData()

	return
end

function var_0_1.InitData(arg_6_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.GetIsland(var_6_0)
	local var_6_2 = var_1.GetBuildingAgency(var_6_1)

	arg_6_0.formulaNums = var_1.GetFormulaNums(var_6_2)
	arg_6_0.formulas = {}
	ipairs = var_1
	pg = var_6_2

	for iter_6_0, iter_6_1 in var_1(var_6_2.island_combo.all) do
		Clone = var_1_10006
		pg = var_1_10008
		var_1_10006 = var_1_10006(var_1_10008.island_formula[iter_6_1])
		pg = var_1_10007
		var_1_10006.unlock_condition = var_1_10007.island_combo[iter_6_1].unlock_condition
		pg = var_1_10007
		var_1_10006.is_hide = var_1_10007.island_combo[iter_6_1].is_hide
		table = var_1_10007

		var_1_10007.insert(arg_6_0.formulas, var_1_10006)
	end

	table = var_1

	local var_6_3 = var_1.sort
	local var_6_4 = arg_6_0.formulas

	CompareFuncs = iter_6_0

	var_6_3(var_6_4, iter_6_0({
		function(arg_7_0)
			local var_7_0 = arg_7_0.is_hide == 1
			local var_7_1 = true
			local var_7_2 = true

			ipairs = var_2_10005

			for iter_7_0, iter_7_1 in var_2_10005(var_1.unlock_condition) do
				local var_7_3 = iter_7_1[1]
				local var_7_4 = iter_7_1[2]

				if not arg_6_0.formulaNums[var_7_3] or arg_6_0.formulaNums[var_7_3] < 1 then
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

function var_0_1.SetFormulaList(arg_9_0)
	local var_9_0 = arg_9_0.setMealList

	var_1.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventUpdate then
			local var_10_0 = arg_9_0.formulas[arg_10_1 + 1].is_hide == 1
			local var_10_1 = true
			local var_10_2 = true

			ipairs = var_2_10007

			for iter_10_0, iter_10_1 in var_2_10007(var_3.unlock_condition) do
				local var_10_3 = iter_10_1[1]
				local var_10_4 = iter_10_1[2]

				if not arg_9_0.formulaNums[var_10_3] or arg_9_0.formulaNums[var_10_3] < 1 then
					var_10_1 = false
				end

				if not arg_9_0.formulaNums[var_10_3] or var_10_4 > arg_9_0.formulaNums[var_10_3] then
					var_10_2 = false
				end
			end

			local var_10_5 = not var_10_0 and var_10_1 or var_10_0 and var_10_2

			setActive = var_10_6

			var_10_6(arg_10_2:Find("special"), var_10_0 and var_10_2)

			setActive = var_10_6

			var_10_6(arg_10_2:Find("name"), var_10_5)

			setActive = var_10_6

			var_10_6(arg_10_2:Find("IslandItemTpl"), var_10_5)

			setActive = var_10_6

			var_10_6(arg_10_2:Find("lock"), not var_10_5)

			local var_10_6, var_10_7

			if var_10_5 then
				setScrollText = var_10_6

				var_10_6(arg_10_2:Find("name/text"), var_3.name)

				var_10_6 = {
					count = 0
				}
				DROP_TYPE_ISLAND_ITEM = var_9
				var_10_6.type = var_9
				var_10_6.id = var_3.item_id
				updateCustomDrop = var_9
				var_10_7 = arg_10_2

				var_9(arg_10_2.Find(var_10_7, "IslandItemTpl"), var_10_6)
			end

			if var_10_5 then
				onToggle = var_10_6

				local var_10_8 = arg_9_0
				local var_10_9 = arg_10_2

				local function var_10_10(arg_11_0)
					setActive = var_3_10001

					local var_11_0 = arg_10_2

					var_3_10001(var_3.Find(var_11_0, "select"), arg_11_0)

					if arg_11_0 then
						local var_11_1 = arg_9_0

						var_1.SetDetail(var_11_1, var_0)
					end

					return
				end

				SFX_PANEL = var_10_7

				var_10_6(var_10_8, var_10_9, var_10_10, var_10_7)
			else
				removeOnToggle = var_10_6

				var_10_6(arg_10_2)
			end
		end

		return
	end)

	local var_9_1 = arg_9_0.setMealList

	var_1.align(var_9_1, #arg_9_0.formulas)

	return
end

function var_0_1.SetDetail(arg_12_0, arg_12_1)
	setActive = var_1_10002

	var_1_10002(arg_12_0.detail, true)

	setScrollText = var_1_10002

	var_1_10002(arg_12_0.detailName, arg_12_1.name)

	setActive = var_1_10002

	var_1_10002(arg_12_0.formulaList1, #arg_12_1.unlock_condition == 2)

	setActive = var_1_10002

	var_1_10002(arg_12_0.formulaList2, #arg_12_1.unlock_condition == 3)

	if #arg_12_1.unlock_condition == 2 then
		for iter_12_0 = 1, 2 do
			pg = var_1_10006
			var_1_10006 = var_1_10006.island_formula[arg_12_1.unlock_condition[iter_12_0][1]]
			pg = var_7

			local var_12_0 = var_7.island_item_data_template[var_1_10006.item_id]

			GetImageSpriteFromAtlasAsync = var_8

			local var_12_1 = "island/" .. var_12_0.icon
			local var_12_2 = ""
			local var_12_3 = arg_12_0.formulaList1

			var_8(var_12_1, var_12_2, var_12.Find(var_12_3, "formula" .. iter_12_0 .. "/icon"))
		end
	elseif #arg_12_1.unlock_condition == 3 then
		for iter_12_1 = 1, 3 do
			pg = var_1_10006
			var_1_10006 = var_1_10006.island_formula[arg_12_1.unlock_condition[iter_12_1][1]]
			pg = var_7

			local var_12_4 = var_7.island_item_data_template[var_1_10006.item_id]

			GetImageSpriteFromAtlasAsync = var_8

			local var_12_5 = "island/" .. var_12_4.icon
			local var_12_6 = ""
			local var_12_7 = arg_12_0.formulaList2

			var_8(var_12_5, var_12_6, var_12.Find(var_12_7, "formula" .. iter_12_1 .. "/icon"))
		end
	end

	local var_12_8 = true
	local var_12_9 = arg_12_0.conditionList

	var_3.make(var_12_9, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventUpdate then
			local var_13_0 = arg_12_1.unlock_condition[arg_13_1 + 1][1]
			local var_13_1 = arg_12_1.unlock_condition[arg_13_1 + 1][2]

			pg = var_5

			local var_13_2 = var_5.island_formula[var_13_0]

			setScrollText = var_2_10006

			local var_13_3 = arg_13_2:Find("name/text")

			i18n = var_2_10009

			var_2_10006(var_13_3, var_2_10009("island_combo_produced") .. var_13_2.name)

			local var_13_4

			if not arg_12_0.formulaNums[var_13_0] then
				var_13_4 = 0
			end

			setActive = var_2_10007

			var_2_10007(arg_13_2:Find("notComplete"), var_13_4 < var_13_1)

			setActive = var_2_10007

			var_2_10007(arg_13_2:Find("complete"), var_13_1 <= var_13_4)

			if var_13_1 < var_13_4 then
				var_13_1 = formulaNum
			end

			setText = var_2_10007

			local var_13_5 = arg_13_2:Find("count")

			i18n = var_10

			var_2_10007(var_13_5, var_10("island_combo_produced_times", "" .. var_13_4 .. "/" .. var_13_1))

			if var_13_4 < var_13_1 then
				var_12_8 = false
			end
		end

		return
	end)

	local var_12_10 = arg_12_0.conditionList

	var_3.align(var_12_10, #arg_12_1.unlock_condition)

	if var_12_8 == true then
		setText = var_3

		local var_12_11 = arg_12_0.detailDesc

		i18n = var_6

		var_3(var_12_11, var_6("island_combo_unlock"))
	else
		setText = var_3

		local var_12_12 = arg_12_0.detailDesc
		local var_12_13

		if not arg_12_1.desc then
			var_12_13 = ""
		end

		var_3(var_12_12, var_12_13)
	end

	return
end

function var_0_1.OnShow(arg_14_0)
	arg_14_0:InitData()
	arg_14_0:SetFormulaList()

	pg = var_1

	local var_14_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_14_0, arg_14_0._tf)

	return
end

function var_0_1.OnHide(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0._tf)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	arg_16_0:OnHide()

	return
end

return var_0_1
