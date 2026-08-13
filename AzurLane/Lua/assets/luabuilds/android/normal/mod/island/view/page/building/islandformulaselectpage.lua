class = var_0_10000

local var_0_0 = "IslandFormulaSelectPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandFormulaSelectNewUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "top/back")

	local var_2_1 = arg_2_0._tf

	arg_2_0.title = var_1.Find(var_2_1, "top/title")

	local var_2_2 = arg_2_0._tf

	arg_2_0.rightInfo = var_1.Find(var_2_2, "rightInfo")

	local var_2_3 = arg_2_0._tf

	arg_2_0.rightInfoEmpty = var_1.Find(var_2_3, "rightInfo_empty")

	local var_2_4 = arg_2_0._tf

	arg_2_0.currentformulaIcon = var_1.Find(var_2_4, "rightInfo/formula/currentformula")

	local var_2_5 = arg_2_0._tf

	arg_2_0.sureBtn = var_1.Find(var_2_5, "rightInfo/sure")

	local var_2_6 = arg_2_0._tf

	arg_2_0.formulaItem = var_1.Find(var_2_6, "rightInfo/formula")

	local var_2_7 = arg_2_0.formulaItem

	arg_2_0.curCountTips = var_1.Find(var_2_7, "curCount")

	local var_2_8 = arg_2_0.formulaItem

	arg_2_0.addCountTips = var_1.Find(var_2_8, "addCount")

	local var_2_9 = arg_2_0.formulaItem

	arg_2_0.reduceBtn = var_1.Find(var_2_9, "limit/reduce")

	local var_2_10 = arg_2_0.formulaItem

	arg_2_0.addBtn = var_1.Find(var_2_10, "limit/add")

	local var_2_11 = arg_2_0.formulaItem

	arg_2_0.maxBtn = var_1.Find(var_2_11, "limit/max")

	local var_2_12 = arg_2_0.formulaItem

	arg_2_0.curCountNumSlider = var_1.Find(var_2_12, "limit/num_bg")

	local var_2_13 = arg_2_0.formulaItem

	arg_2_0.extraProduct = var_1.Find(var_2_13, "extra")

	local var_2_14 = arg_2_0.extraProduct

	arg_2_0.extraProductIcon = var_1.Find(var_2_14, "icon")

	local var_2_15 = arg_2_0.extraProductIcon

	arg_2_0.extraProductNum = var_1.Find(var_2_15, "product_count_bg/product_count")

	local var_2_16 = arg_2_0.extraProduct

	arg_2_0.extraProductName = var_1.Find(var_2_16, "Text")

	local var_2_17 = arg_2_0.extraProduct

	arg_2_0.extraProductAddnum = var_1.Find(var_2_17, "Text/addCount")

	local var_2_18 = arg_2_0.sureBtn

	arg_2_0.needTimeText = var_1.Find(var_2_18, "adapt/time/time_text")

	local var_2_19 = arg_2_0.formulaItem

	arg_2_0.barLimit = var_1.Find(var_2_19, "limit/hasLimit")
	UIItemList = var_1

	local var_2_20 = var_1.New
	local var_2_21 = arg_2_0.extraProduct
	local var_2_22 = var_2.Find(var_2_21, "process")
	local var_2_23 = arg_2_0.extraProduct

	arg_2_0.extraProductList = var_2_20(var_2_22, var_3.Find(var_2_23, "process/item"))
	UIItemList = var_1

	local var_2_24 = var_1.New
	local var_2_25 = arg_2_0._tf
	local var_2_26 = var_2.Find(var_2_25, "formulaView/content")
	local var_2_27 = arg_2_0._tf

	arg_2_0.uiList = var_2_24(var_2_26, var_3.Find(var_2_27, "formulaView/content/tpl"))
	UIItemList = var_1

	local var_2_28 = var_1.New
	local var_2_29 = arg_2_0._tf
	local var_2_30 = var_2.Find(var_2_29, "rightInfo/formula/needItem/content")
	local var_2_31 = arg_2_0._tf

	arg_2_0.costuiList = var_2_28(var_2_30, var_3.Find(var_2_31, "rightInfo/formula/needItem/content/IslandItemTpl"))
	setText = var_1

	local var_2_32 = arg_2_0._tf
	local var_2_33 = var_2.Find(var_2_32, "top/title/Text")

	i18n = var_2_32

	var_1(var_2_33, var_2_32("island_select_product"))

	setText = var_1

	local var_2_34 = arg_2_0.formulaItem
	local var_2_35 = var_2.Find(var_2_34, "tips")

	i18n = var_2_34

	var_1(var_2_35, var_2_34("island_production_count"))

	pg = var_1
	arg_2_0.baseEffectSpeed = var_1.island_set.base_efficiency.key_value_int

	local var_2_36 = arg_2_0.rightInfo

	arg_2_0.selectShipTf = var_1.Find(var_2_36, "selectShip")

	local var_2_37 = arg_2_0.selectShipTf

	arg_2_0.selectShipName = var_1.Find(var_2_37, "info/name")

	local var_2_38 = arg_2_0.selectShipTf

	arg_2_0.selectShipLv = var_1.Find(var_2_38, "info/lv")

	local var_2_39 = arg_2_0.selectShipTf

	arg_2_0.selectShipIcon = var_1.Find(var_2_39, "bg/icon")

	local var_2_40 = arg_2_0.selectShipTf

	arg_2_0.skillTf = var_1.Find(var_2_40, "skill")

	local var_2_41 = arg_2_0.skillTf

	arg_2_0.skillInUse = var_1.Find(var_2_41, "skillBg/skillTabBg/skill_bright")

	local var_2_42 = arg_2_0.skillTf

	arg_2_0.skillUnUse = var_1.Find(var_2_42, "skillBg/skillTabBg/skill_dark")

	local var_2_43 = arg_2_0.skillTf
	local var_2_44 = var_1.Find(var_2_43, "skillBg/skillText")
	local var_2_45 = var_1.GetComponent

	typeof = var_3
	Text = var_4
	arg_2_0.skillName = var_2_45(var_2_44, var_3(var_4))

	local var_2_46 = arg_2_0.selectShipTf

	arg_2_0.energyBarTf = var_1.Find(var_2_46, "ener_bar")

	local var_2_47 = arg_2_0.selectShipTf

	arg_2_0.energyBarUseTf = var_1.Find(var_2_47, "ener_bar_1")

	local var_2_48 = arg_2_0.selectShipTf

	arg_2_0.energy_countTf = var_1.Find(var_2_48, "energy_count")

	local var_2_49 = arg_2_0.sureBtn

	arg_2_0.enoughSureBg = var_1.Find(var_2_49, "okBg")

	local var_2_50 = arg_2_0.sureBtn

	arg_2_0.notenoughSureBg = var_1.Find(var_2_50, "notBg")

	local var_2_51 = arg_2_0.rightInfo
	local var_2_52 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.animationPlayer = var_2_52(var_2_51, var_3(var_4))

	local var_2_53 = arg_2_0.selectShipTf

	arg_2_0.addExpTF = var_1.Find(var_2_53, "exp")

	local var_2_54 = arg_2_0.selectShipTf

	arg_2_0.addExp = var_1.Find(var_2_54, "exp/addExp")

	return
end

function var_0_1.AddListeners(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.AddListener

	GAME = var_1_10003

	var_3_1(var_3_0, var_1_10003.ISLAND_SHOP_OP_DONE, arg_3_0.RefreshCurrentSelectFormula)

	return
end

function var_0_1.RemoveListeners(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.RemoveListener

	GAME = var_1_10003

	var_4_1(var_4_0, var_1_10003.ISLAND_SHOP_OP_DONE, arg_4_0.RefreshCurrentSelectFormula)

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_3.Find(var_5_1, "top/title/help")

	local function var_5_3()
		pg = var_2_10000

		local var_6_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_6_2.type = var_2_10003
		pg = var_2_10003
		var_6_2.helps = var_2_10003.gametip.island_help_commission.tip

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.backBtn

	local function var_5_6()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		existCall = var_0

		var_0(arg_5_0.cancelFunc)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_4, var_5_5, var_5_6, var_5)

	onButton = var_1_10001

	local var_5_7 = arg_5_0
	local var_5_8 = arg_5_0.reduceBtn

	local function var_5_9()
		arg_5_0.curSelectCount = arg_5_0.curSelectCount - 1

		local var_8_0

		if not arg_5_0.addDelegateFormulaTimes or not (arg_5_0.addDelegateFormulaTimes + 1) then
			var_8_0 = 1
		end

		arg_5_0.curSelectCount = var_8_0 > arg_5_0.curSelectCount and var_8_0 or arg_5_0.curSelectCount

		local var_8_1 = arg_5_0

		var_1.RefreshCost(var_8_1)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_7, var_5_8, var_5_9, var_5)

	onButton = var_1_10001

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.addBtn

	local function var_5_12()
		local var_9_0 = arg_5_0.curSelectCount + 1

		if arg_5_0.addDelegateFormulaTimes then
			local var_9_1 = arg_5_0
			local var_9_2 = var_1.CheckCanAddMaxTimes(var_9_1) + arg_5_0.addDelegateFormulaTimes > arg_5_0.productMaxTime and arg_5_0.productMaxTime or var_9_2

			var_9_0 = var_9_2 < var_9_0 and var_9_2 or var_9_0

			if var_9_0 < arg_5_0.addDelegateFormulaTimes + 1 then
				var_9_0 = arg_5_0.addDelegateFormulaTimes + 1
			end

			arg_5_0.curSelectCount = var_9_0
		else
			local var_9_3 = arg_5_0
			local var_9_4 = var_1.CheckCanAddMaxTimes(var_9_3)

			arg_5_0.curSelectCount = var_9_4 < var_9_0 and var_9_4 or var_9_0

			if arg_5_0.curSelectCount < 1 then
				arg_5_0.curSelectCount = 1
			end
		end

		local var_9_5 = arg_5_0

		var_1.RefreshCost(var_9_5)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_10, var_5_11, var_5_12, var_5)

	onButton = var_1_10001

	local var_5_13 = arg_5_0
	local var_5_14 = arg_5_0.maxBtn

	local function var_5_15()
		if arg_5_0.addDelegateFormulaTimes then
			local var_10_0 = arg_5_0
			local var_10_1 = var_0.CheckCanAddMaxTimes(var_10_0) + arg_5_0.addDelegateFormulaTimes
			local var_10_2 = arg_5_0
			local var_10_3

			if not (var_10_1 > arg_5_0.productMaxTime) or not arg_5_0.productMaxTime then
				var_10_3 = var_10_1
			end

			var_10_2.curSelectCount = var_10_3

			if arg_5_0.curSelectCount < 1 then
				arg_5_0.curSelectCount = 1
			end
		else
			local var_10_4 = arg_5_0
			local var_10_5 = arg_5_0

			var_10_4.curSelectCount = var_1.CheckCanAddMaxTimes(var_10_5)

			if arg_5_0.curSelectCount < 1 then
				arg_5_0.curSelectCount = 1
			end
		end

		local var_10_6 = arg_5_0

		var_0.RefreshCost(var_10_6)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_13, var_5_14, var_5_15, var_5)

	onSlider = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.curCountNumSlider, function(arg_11_0)
		if arg_5_0.addDelegateFormulaTimes then
			local var_11_0 = arg_5_0
			local var_11_1 = var_1.CheckCanAddMaxTimes(var_11_0) + arg_5_0.addDelegateFormulaTimes > arg_5_0.productMaxTime and arg_5_0.productMaxTime or var_11_1

			arg_11_0 = var_11_1 < arg_11_0 and var_11_1 or arg_11_0

			if arg_11_0 < arg_5_0.addDelegateFormulaTimes + 1 then
				arg_11_0 = arg_5_0.addDelegateFormulaTimes + 1
			end

			arg_5_0.curSelectCount = arg_11_0
		else
			local var_11_2 = arg_5_0
			local var_11_3 = var_1.CheckCanAddMaxTimes(var_11_2)

			arg_5_0.curSelectCount = var_11_3 < arg_11_0 and var_11_3 or arg_11_0

			if arg_5_0.curSelectCount < 1 then
				arg_5_0.curSelectCount = 1
			end
		end

		local var_11_4 = arg_5_0

		var_1.RefreshCost(var_11_4)

		return
	end)

	onButton = var_1_10001

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.skillTf

	local function var_5_18()
		local var_12_0 = arg_5_0
		local var_12_1 = var_0.ShowMsgBox
		local var_12_2 = {}

		IslandMsgBox = var_2_10003
		var_12_2.type = var_2_10003.TYPE_SHIP_SKILL

		local var_12_3 = arg_5_0.selectedShip

		var_12_2.skill = var_3.GetSkill(var_12_3)

		var_12_1(var_12_0, var_12_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_16, var_5_17, var_5_18, var_5)

	local var_5_19 = arg_5_0.uiList

	var_1.make(var_5_19, function(arg_13_0, arg_13_1, arg_13_2)
		UIItemList = var_2_10003

		if arg_13_0 == var_2_10003.EventInit then
			local var_13_0 = arg_5_0

			var_3.InitFormulaItem(var_13_0, arg_13_1, arg_13_2)
		else
			UIItemList = var_3

			if arg_13_0 == var_3.EventUpdate then
				local var_13_1 = arg_5_0

				var_3.UpdateFormulaItem(var_13_1, arg_13_1, arg_13_2)
			end
		end

		return
	end)

	local var_5_20 = arg_5_0.costuiList

	var_1.make(var_5_20, function(arg_14_0, arg_14_1, arg_14_2)
		UIItemList = var_2_10003

		if arg_14_0 == var_2_10003.EventInit then
			local var_14_0 = arg_5_0

			var_3.InitCostItem(var_14_0, arg_14_1, arg_14_2)
		else
			UIItemList = var_3

			if arg_14_0 == var_3.EventUpdate then
				local var_14_1 = arg_5_0

				var_3.UpdateCostItem(var_14_1, arg_14_1, arg_14_2)
			end
		end

		return
	end)

	local var_5_21 = arg_5_0.extraProductList

	var_1.make(var_5_21, function(arg_15_0, arg_15_1, arg_15_2)
		UIItemList = var_2_10003

		if arg_15_0 == var_2_10003.EventInit then
			-- block empty
		else
			UIItemList = var_3

			if arg_15_0 == var_3.EventUpdate then
				local var_15_0 = arg_15_1 < arg_5_0.extraProcess

				setActive = var_2_10004

				var_2_10004(arg_15_2:Find("inprocess"), var_15_0)
			end
		end

		return
	end)

	return
end

function var_0_1.InitFormulaItem(arg_16_0, arg_16_1, arg_16_2)
	onButton = var_1_10003

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_2

	local function var_16_2()
		local var_17_0 = arg_16_0

		var_0.OnSelectFormulaIndex(var_17_0, arg_16_1 + 1)

		return
	end

	SFX_PANEL = var_1_10007

	var_1_10003(var_16_0, var_16_1, var_16_2, var_1_10007)

	return
end

function var_0_1.OnSelectFormulaIndex(arg_18_0, arg_18_1)
	arg_18_0.selectedIdx = arg_18_1
	arg_18_0.selectFormulaId = arg_18_0.formulaList[arg_18_0.selectedIdx]
	pg = var_2
	arg_18_0.formulaCfg = var_2.island_formula[arg_18_0.selectFormulaId]
	arg_18_0.productMaxTime = arg_18_0.formulaCfg.production_limit

	local var_18_0

	if not arg_18_0.addDelegateFormulaTimes or not (arg_18_0.addDelegateFormulaTimes + 1) then
		var_18_0 = 1
	end

	arg_18_0.curSelectCount = var_18_0

	local var_18_1 = arg_18_0.uiList

	var_2.align(var_18_1, #arg_18_0.formulaList)

	return
end

function var_0_1.UpdateFormulaItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_1 + 1

	getProxy = var_1_10004
	IslandProxy = var_1_10005

	local var_19_1 = var_1_10004(var_1_10005)
	local var_19_2 = var_4.GetIsland(var_19_1)
	local var_19_3 = var_4.GetInventoryAgency(var_19_2)
	local var_19_4 = arg_19_0.formulaList[arg_19_1 + 1]

	pg = var_6

	local var_19_5 = var_6.island_formula[var_19_4].item_id

	if var_19_3:GetItemById(var_19_5) then
		local var_19_6 = var_8
		local var_19_7

		if not var_8.GetCount(var_19_6) then
			var_19_7 = 0
		end

		updateCustomDrop = var_19_6

		local var_19_8 = arg_19_2

		Drop = var_1_10012

		local var_19_9 = var_1_10012.New
		local var_19_10 = {}

		DROP_TYPE_ISLAND_ITEM = var_1_10014
		var_19_10.type = var_1_10014
		var_19_10.id = var_19_5
		var_19_10.count = var_19_7

		var_19_6(var_19_8, var_19_9(var_19_10))

		setActive = var_19_6

		var_19_6(arg_19_2:Find("icon_bg/count_bg"), true)

		setScrollTextWithSize = var_19_6

		var_19_6(arg_19_2:Find("name"), arg_19_2:Find("scroll_name/name"), var_6.name, 6)

		setText = var_19_6

		var_19_6(arg_19_2:Find("icon_bg/product_count_bg/product_count"), "×" .. var_6.commission_product[1][2])

		setText = var_19_6

		local var_19_11 = arg_19_2
		local var_19_12 = arg_19_2.Find(var_19_11, "icon_bg/count_bg/count")

		i18n = var_19_11

		var_19_6(var_19_12, var_19_11("island_production_hold", var_19_7))

		if arg_19_0.selectedIdx == var_19_0 then
			arg_19_0:RefreshCurrentSelectFormula()
		end

		setActive = var_10

		var_10(arg_19_2:Find("selected"), arg_19_0.selectedIdx == var_19_0)

		return
	end
end

function var_0_1.InitCostItem(arg_20_0, arg_20_1, arg_20_2)
	return
end

function var_0_1.UpdateCostItem(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.commission_Cost_List[arg_21_1 + 1]

	updateCustomDrop = var_4

	var_4(arg_21_2, var_21_0)

	string = var_4

	local var_21_1 = var_4.format("%d/%d", var_21_0.itemCount, var_21_0.costCount)

	if var_21_0.extraCostCount and var_21_0.extraCostCount > 0 then
		string = var_5
		var_21_1 = var_5.format("%d/(%d<color=#ffae22>+%d</color>)", var_21_0.itemCount, var_21_0.costCount, var_21_0.extraCostCount)
	end

	setActive = var_5

	var_5(arg_21_2:Find("icon_bg/count_bg"), true)

	setText = var_5

	var_5(arg_21_2:Find("icon_bg/count_bg/count"), var_21_1)

	onButton = var_5

	var_5(arg_21_0, arg_21_2:Find("icon_bg/icon"), function()
		local var_22_0 = arg_21_0
		local var_22_1 = var_0.ShowMsgBox
		local var_22_2 = {}

		i18n = var_2_10003
		var_22_2.title = var_2_10003("island_word_desc")
		IslandMsgBox = var_3
		var_22_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
		var_22_2.dropData = var_21_0

		var_22_1(var_22_0, var_22_2)

		return
	end)

	onButton = var_5

	var_5(arg_21_0, arg_21_2:Find("icon_bg/icon"), function()
		local var_23_0 = arg_21_0
		local var_23_1 = var_0.ShowMsgBox
		local var_23_2 = {}

		i18n = var_2_10003
		var_23_2.title = var_2_10003("island_word_desc")
		IslandMsgBox = var_3
		var_23_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
		var_23_2.dropData = var_21_0

		var_23_1(var_23_0, var_23_2)

		return
	end)

	return
end

function var_0_1.RefreshCurrentSelectFormula(arg_24_0)
	local var_24_0 = arg_24_0.formulaCfg.item_id

	Drop = var_1_10002

	local var_24_1 = var_1_10002.New
	local var_24_2 = {
		count = 0
	}

	DROP_TYPE_ISLAND_ITEM = var_1_10004
	var_24_2.type = var_1_10004
	var_24_2.id = var_24_0

	local var_24_3 = var_24_1(var_24_2)
	local var_24_4 = var_2.getConfigTable(var_24_3).rarity

	IslandItemRarity = var_24_3

	local var_24_5 = var_24_3.Rarity2FrameName(var_24_4)
	local var_24_6 = var_2
	local var_24_7 = var_2.getConfigTable(var_24_6).icon

	onButton = var_24_6

	var_24_6(arg_24_0, arg_24_0.currentformulaIcon, function()
		local var_25_0 = arg_24_0
		local var_25_1 = var_0.ShowMsgBox
		local var_25_2 = {}

		i18n = var_2_10003
		var_25_2.title = var_2_10003("island_word_desc")
		IslandMsgBox = var_3
		var_25_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
		var_25_2.dropData = var_0

		var_25_1(var_25_0, var_25_2)

		return
	end)

	GetImageSpriteFromAtlasAsync = var_24_6

	local var_24_8 = "island/islandframe"
	local var_24_9 = var_24_5
	local var_24_10 = arg_24_0.currentformulaIcon

	var_24_6(var_24_8, var_24_9, var_9.Find(var_24_10, "icon_bg"))

	GetImageSpriteFromAtlasAsync = var_24_6

	local var_24_11 = "island/" .. var_24_7
	local var_24_12 = ""
	local var_24_13 = arg_24_0.currentformulaIcon

	var_24_6(var_24_11, var_24_12, var_9.Find(var_24_13, "icon_bg/icon"))
	arg_24_0:RefreshCost()

	return
end

function var_0_1.GetAniExtraGainByConfigName(arg_26_0, arg_26_1)
	local var_26_0 = 0
	local var_26_1 = arg_26_0.placeId

	IslandProductConst = var_1_10004

	if var_26_1 ~= var_1_10004.PasturePlaceId then
		return var_26_0
	end

	getProxy = var_26_1
	IslandProxy = var_4

	local var_26_2 = var_26_1(var_4)
	local var_26_3 = var_3.GetIsland(var_26_2)
	local var_26_4 = var_3.GetBuildingAgency(var_26_3)
	local var_26_5 = var_3.GetBuilding(var_26_4, arg_26_0.placeId)
	local var_26_6 = var_3.GetDelegationSlotData(var_26_5, arg_26_0.slotId)
	local var_26_7 = var_4.GetPartList(var_26_6)

	ipairs = var_26_6

	for iter_26_0, iter_26_1 in var_26_6(var_26_7) do
		pg = var_1_10011
		var_26_0 = var_26_0 + var_1_10011.island_ranch_animal[iter_26_1][arg_26_1]
	end

	return var_26_0
end

function var_0_1.RefreshCost(arg_27_0)
	arg_27_0.commission_Cost_List = {}
	getProxy = var_1
	IslandProxy = var_1_10002

	local var_27_0 = var_1(var_1_10002)
	local var_27_1 = var_1.GetIsland(var_27_0)
	local var_27_2 = var_1.GetInventoryAgency(var_27_1)
	local var_27_3 = arg_27_0
	local var_27_4 = arg_27_0.GetAniExtraGainByConfigName(var_27_3, "efficiency_cost")

	ipairs = var_27_3

	for iter_27_0, iter_27_1 in var_27_3(arg_27_0.formulaCfg.commission_cost) do
		local var_27_5 = iter_27_1[1]
		local var_27_6

		if not var_27_2:GetItemById(var_27_5) or not var_9:GetCount() then
			var_27_6 = 0
		end

		local var_27_7

		if not arg_27_0.addDelegateFormulaTimes or not (arg_27_0.curSelectCount - arg_27_0.addDelegateFormulaTimes) then
			var_27_7 = arg_27_0.curSelectCount
		end

		Drop = var_1_10012
		var_1_10012 = var_1_10012.New

		local var_27_8 = {
			count = 0
		}

		DROP_TYPE_ISLAND_ITEM = var_1_10014
		var_27_8.type = var_1_10014
		var_27_8.id = iter_27_1[1]
		var_27_8.itemCount = var_27_6
		var_27_8.costCount = iter_27_1[2] * var_27_7
		var_27_8.extraCostCount = var_27_4 * var_27_7
		var_1_10012 = var_1_10012(var_27_8)
		table = var_27_8

		var_27_8.insert(arg_27_0.commission_Cost_List, var_1_10012)
	end

	local var_27_9 = arg_27_0.costuiList

	var_3.align(var_27_9, #arg_27_0.commission_Cost_List)
	arg_27_0:RefreshCurSelectCount()
	arg_27_0:RefreshShipEnergy()
	arg_27_0:RefreshCanStart()

	return
end

function var_0_1.CheckCanAddMaxTimes(arg_28_0)
	arg_28_0.commission_Cost_List = {}
	getProxy = var_1
	IslandProxy = var_1_10002

	local var_28_0 = var_1(var_1_10002)
	local var_28_1 = var_1.GetIsland(var_28_0)
	local var_28_2 = var_1.GetInventoryAgency(var_28_1)
	local var_28_3 = arg_28_0.productMaxTime
	local var_28_4 = arg_28_0
	local var_28_5 = arg_28_0.GetAniExtraGainByConfigName(var_28_4, "efficiency_cost")

	ipairs = var_28_4

	for iter_28_0, iter_28_1 in var_28_4(arg_28_0.formulaCfg.commission_cost) do
		local var_28_6 = iter_28_1[1]
		local var_28_7

		if not var_28_2:GetItemById(var_28_6) or not var_10:GetCount() then
			var_28_7 = 0
		end

		local var_28_8 = iter_28_1[2] + var_28_5

		math = var_1_10013
		var_1_10013 = var_1_10013.min

		local var_28_9 = var_28_3

		math = var_1_10015
		var_28_3 = var_1_10013(var_28_9, var_1_10015.floor(var_28_7 / var_28_8))
	end

	local var_28_10 = arg_28_0
	local var_28_11 = arg_28_0.GetOneFormulaEnergyCost(var_28_10)

	math = var_28_10

	local var_28_12 = var_28_10.min

	math = var_6

	local var_28_13 = var_6.floor
	local var_28_14 = arg_28_0.selectedShip

	return (var_28_12(var_28_13(var_7.GetCurrentEnergy(var_28_14) / var_28_11), var_28_3))
end

function var_0_1.RefreshCanStart(arg_29_0)
	local function var_29_0()
		ipairs = var_2_10000

		for iter_30_0, iter_30_1 in var_2_10000(arg_29_0.commission_Cost_List) do
			if iter_30_1.costCount + iter_30_1.extraCostCount > iter_30_1.itemCount then
				return false
			end
		end

		return true
	end

	local function var_29_1()
		local var_31_0

		if not arg_29_0.addDelegateFormulaTimes or not (arg_29_0.curSelectCount - arg_29_0.addDelegateFormulaTimes) then
			var_31_0 = arg_29_0.curSelectCount
		end

		local var_31_1 = arg_29_0
		local var_31_2 = var_1.GetOneFormulaEnergyCost(var_31_1) * var_31_0
		local var_31_3 = arg_29_0.selectedShip

		if var_31_2 > var_3.GetCurrentEnergy(var_31_3) then
			return false
		end

		return true
	end

	local function var_29_2()
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_32_0 = var_2_10000(var_2_10001)
		local var_32_1 = var_0.GetIsland(var_32_0)
		local var_32_2 = var_0.GetBuildingAgency(var_32_1)
		local var_32_3 = var_1.GetBuilding(var_32_2, arg_29_0.placeId)

		pg = var_32_2

		local var_32_4

		if var_32_2.island_production_slot[arg_29_0.slotId].exclusion_slot ~= "" or not {} then
			var_32_4 = var_3.exclusion_slot
		end

		local var_32_5 = {}
		local var_32_6 = false

		ipairs = var_2_10007

		for iter_32_0, iter_32_1 in var_2_10007(var_32_4) do
			if var_32_3:GetHandPlantSlotData(iter_32_1).state == 1 then
				var_32_6 = true
				table = var_12

				var_12.insert(var_32_5, iter_32_1)
			end
		end

		return var_32_6, var_32_5
	end

	if var_29_0() and var_29_1() then
		setActive = var_4

		var_4(arg_29_0.enoughSureBg, true)

		setActive = var_4

		var_4(arg_29_0.notenoughSureBg, false)

		onButton = var_4

		local var_29_3 = arg_29_0
		local var_29_4 = arg_29_0.sureBtn

		local function var_29_5()
			if arg_29_0.addDelegateFormula then
				local var_33_0 = arg_29_0

				pg = var_2_10001
				var_33_0.placeId = var_2_10001.island_production_slot[arg_29_0.slotId].place
				getProxy = var_33_0
				IslandProxy = var_1

				local var_33_1 = var_33_0(var_1)
				local var_33_2 = var_0.GetIsland(var_33_1)
				local var_33_3 = var_0.GetBuildingAgency(var_33_2)

				var_2_10002 = var_0.GetBuilding(var_33_3, arg_29_0.placeId)

				if var_0.GetDelegationSlotData(var_2_10002, arg_29_0.slotId) then
					var_2_10003 = var_1

					if not var_1.GetSlotRoleData(var_2_10003) then
						pg = var_2_10002
						var_2_10003 = var_2_10002.TipsMgr.GetInstance()
						var_2_10002 = var_2_10002.ShowTips
						i18n = var_2_10004

						var_2_10002(var_2_10003, var_2_10004("island_additional_production_tip2"))

						return
					end
				end
			end

			if arg_29_0.formulaToActivityDic[arg_29_0.selectFormulaId] then
				getProxy = var_1
				ActivityProxy = var_2_10002

				local var_33_4 = var_1(var_2_10002)

				if var_1.getActivityById(var_33_4, var_0) then
					var_2_10003 = var_1

					if var_1.isEnd(var_2_10003) then
						pg = var_33_4
						var_2_10003 = var_33_4.TipsMgr.GetInstance()

						local var_33_5 = var_2.ShowTips

						i18n = var_2_10004

						var_33_5(var_2_10003, var_2_10004("island_activity_expired"))

						return
					end

					local var_33_6, var_33_7 = var_29_2()

					if var_33_6 then
						local var_33_8 = arg_29_0

						var_2_10003 = var_2_10003.ShowMsgBox

						local var_33_9 = {}

						IslandMsgBox = var_2_10006
						var_33_9.type = var_2_10006.TYPE_COMMON
						i18n = var_2_10006
						var_33_9.content = var_2_10006("island_production_manually_cancel")

						function var_33_9.onYes()
							pg = var_3_10000

							local var_34_0 = var_3_10000.m02
							local var_34_1 = var_0.sendNotification

							GAME = var_3_10002

							var_34_1(var_34_0, var_3_10002.ISLAND_STOP_HANDLE_PLANT_HALFWAY, {
								build_id = arg_29_0.placeId,
								slot_list = var_33_7
							})

							existCall = var_34_1

							var_34_1(arg_29_0.unLoadCharacterFunc)

							local var_34_2 = arg_29_0
							local var_34_3 = var_0.GetAniExtraGainByConfigName(var_34_2, "efficiency_cost")
							local var_34_4, var_34_5

							if arg_29_0.addDelegateFormula then
								var_34_4 = arg_29_0.curSelectCount - arg_29_0.addDelegateFormulaTimes
								var_34_5 = arg_29_0

								local var_34_6 = var_2.emit

								IslandMediator = var_4

								var_34_6(var_34_5, var_4.ADD_DELEGATION, arg_29_0.placeId, arg_29_0.slotId, var_34_4, var_34_3)
							else
								local var_34_7 = arg_29_0

								var_34_4 = var_34_4.emit
								IslandMediator = var_34_5

								var_34_4(var_34_7, var_34_5.START_DELEGATION, arg_29_0.placeId, arg_29_0.slotId, arg_29_0.selectedShipId, arg_29_0.selectFormulaId, arg_29_0.curSelectCount, var_34_3)
							end

							existCall = var_34_4

							var_34_4(arg_29_0.confirmFunc)

							local var_34_8 = arg_29_0

							var_1.Hide(var_34_8)

							return
						end

						function var_33_9.onNo()
							return
						end

						var_2_10003(var_33_8, var_33_9)

						return
					end

					existCall = var_2_10003

					var_2_10003(arg_29_0.unLoadCharacterFunc)

					local var_33_10 = arg_29_0
					local var_33_11 = var_3.GetAniExtraGainByConfigName(var_33_10, "efficiency_cost")
					local var_33_12

					if arg_29_0.addDelegateFormula then
						var_33_12 = arg_29_0.curSelectCount - arg_29_0.addDelegateFormulaTimes
						var_2_10006 = arg_29_0

						local var_33_13 = var_5.emit

						IslandMediator = var_2_10007

						var_33_13(var_2_10006, var_2_10007.ADD_DELEGATION, arg_29_0.placeId, arg_29_0.slotId, var_33_12, var_33_11)
					else
						local var_33_14 = arg_29_0

						var_33_12 = var_33_12.emit
						IslandMediator = var_2_10006

						var_33_12(var_33_14, var_2_10006.START_DELEGATION, arg_29_0.placeId, arg_29_0.slotId, arg_29_0.selectedShipId, arg_29_0.selectFormulaId, arg_29_0.curSelectCount, var_33_11)
					end

					existCall = var_33_12

					var_33_12(arg_29_0.confirmFunc)

					local var_33_15 = arg_29_0

					var_4.Hide(var_33_15)

					return
				end
			end
		end

		SFX_PANEL = var_1_10008

		var_4(var_29_3, var_29_4, var_29_5, var_1_10008)
	else
		setActive = var_4

		var_4(arg_29_0.enoughSureBg, false)

		setActive = var_4

		var_4(arg_29_0.notenoughSureBg, true)

		onButton = var_4

		local var_29_6 = arg_29_0
		local var_29_7 = arg_29_0.sureBtn

		local function var_29_8()
			pg = var_2_10000

			local var_36_0 = var_2_10000.TipsMgr.GetInstance()
			local var_36_1 = var_0.ShowTips

			i18n = var_2_10002

			var_36_1(var_36_0, var_2_10002("island_production_cost_notenough"))

			return
		end

		SFX_PANEL = var_1_10008

		var_4(var_29_6, var_29_7, var_29_8, var_1_10008)
	end

	return
end

function var_0_1.OnShow(arg_37_0, arg_37_1)
	arg_37_0:BlurPanel()

	arg_37_0.commissionId = arg_37_1.commissionId
	arg_37_0.selectedShipId = arg_37_1.selectedShipId
	arg_37_0.cancelFunc = arg_37_1.cancelFunc
	arg_37_0.confirmFunc = arg_37_1.confirmFunc
	arg_37_0.unLoadCharacterFunc = arg_37_1.unLoadCharacterFunc
	arg_37_0.addDelegateFormula = arg_37_1.addDelegateFormula
	arg_37_0.addDelegateFormulaTimes = arg_37_1.addDelegateFormulaTimes
	arg_37_0.canRewardTime = arg_37_1.canRewardTime
	arg_37_0.selectFormulaId = arg_37_1.selectFormulaId
	setActive = var_2

	var_2(arg_37_0.addExpTF, arg_37_0.selectedShipId ~= 1)

	local var_37_0

	if arg_37_0.addDelegateFormulaTimes then
		setActive = var_2

		var_2(arg_37_0.barLimit, true)

		pg = var_2

		if not var_2.island_formula[arg_37_0.addDelegateFormula].production_limit then
			var_37_0 = 5
		end

		local var_37_1 = arg_37_0.addDelegateFormulaTimes / var_37_0 * 352.6
		local var_37_2 = arg_37_0.barLimit

		Vector2 = var_1_10006
		var_37_2.sizeDelta = var_1_10006(var_37_1, 22)
		setActive = var_37_2

		var_37_2(arg_37_0.addCountTips, true)
	else
		setActive = var_2

		var_2(arg_37_0.barLimit, false)

		setActive = var_2

		var_2(arg_37_0.addCountTips, false)
	end

	if arg_37_0.addDelegateFormulaTimes then
		i18n = var_37_3

		local var_37_3

		if not var_37_3("island_additional_production_tip1") then
			i18n = var_37_3
			var_37_3 = var_37_3("island_production_start")
		end

		setText = var_37_0

		local var_37_4 = arg_37_0.sureBtn

		var_37_0(var_4.Find(var_37_4, "adapt/time/Text"), var_37_3)

		pg = var_37_0
		arg_37_0.slotId = var_37_0.island_production_commission[arg_37_0.commissionId].slot
		pg = var_3
		arg_37_0.placeId = var_3.island_production_slot[arg_37_0.slotId].place
		getProxy = var_3
		IslandProxy = var_4

		local var_37_5 = var_3(var_4)
		local var_37_6 = var_3.GetIsland(var_37_5)
		local var_37_7 = var_3.GetCharacterAgency(var_37_6)

		arg_37_0.selectedShip = var_4.GetShipById(var_37_7, arg_37_0.selectedShipId)

		arg_37_0:InitUnlockedFormulaList()

		if #arg_37_0.formulaList > 0 then
			local var_37_8 = 1

			if arg_37_0.selectFormulaId then
				ipairs = var_6

				for iter_37_0, iter_37_1 in var_6(arg_37_0.formulaList) do
					if iter_37_1 == arg_37_0.selectFormulaId then
						var_37_8 = iter_37_0

						break
					end
				end
			end

			arg_37_0:OnSelectFormulaIndex(var_37_8)

			onNextTick = var_6

			var_6(function()
				local var_38_0 = arg_37_0._tf
				local var_38_1 = var_0.Find(var_38_0, "formulaView/content").sizeDelta.y
				local var_38_2 = arg_37_0._tf
				local var_38_3 = var_2.Find(var_38_2, "formulaView/content/tpl").rect.height

				math = var_38_2

				local var_38_4 = var_38_2.min((var_37_8 - 1) * var_38_3, var_38_1)

				setAnchoredPosition = var_4

				var_4(var_0, {
					y = var_38_4
				})

				return
			end)
		else
			local var_37_9 = arg_37_0.uiList

			var_5.align(var_37_9, #arg_37_0.formulaList)

			setActive = var_5

			var_5(arg_37_0.rightInfo, false)

			setActive = var_5

			var_5(arg_37_0.rightInfoEmpty, true)
		end

		arg_37_0:RefreshShip()

		return
	end
end

function var_0_1.RefreshShip(arg_39_0)
	IslandShip = var_1_10001

	local var_39_0 = var_1_10001.StaticGetPrefab(arg_39_0.selectedShipId)

	GetImageSpriteFromAtlasAsync = var_2

	var_2("SquareIcon/" .. var_39_0, "", arg_39_0.selectShipIcon)

	setText = var_2

	local var_39_1 = arg_39_0.selectShipName
	local var_39_2 = arg_39_0.selectedShip

	var_2(var_39_1, var_4.GetName(var_39_2))

	setText = var_2

	local var_39_3 = arg_39_0.selectShipLv

	string = var_4

	local var_39_4 = var_4.format
	local var_39_5 = "-Lv.%d"
	local var_39_6 = arg_39_0.selectedShip

	var_2(var_39_3, var_39_4(var_39_5, var_6.GetLevel(var_39_6)))

	local var_39_7 = arg_39_0.selectedShip
	local var_39_8 = var_2.GetSkill(var_39_7)
	local var_39_9 = var_2.IsEffectiveInPlace(var_39_8, arg_39_0.placeId)

	setActive = var_39_8

	var_39_8(arg_39_0.skillInUse, var_39_9)

	setActive = var_39_8

	var_39_8(arg_39_0.skillUnUse, not var_39_9)

	setActive = var_39_8

	var_39_8(arg_39_0.skillUnUse, not var_39_9)

	local var_39_10 = arg_39_0.skillName

	string = var_5
	var_39_10.text = var_5.format("%s - %s", var_2:GetName(), "Lv." .. var_2:GetLevel() .. "")

	return
end

function var_0_1.RefreshShipEnergy(arg_40_0)
	local var_40_0

	if not arg_40_0.addDelegateFormulaTimes or not (arg_40_0.curSelectCount - arg_40_0.addDelegateFormulaTimes) then
		var_40_0 = arg_40_0.curSelectCount
	end

	local var_40_1 = arg_40_0:GetOneFormulaEnergyCost() * var_40_0

	if arg_40_0.selectedShipId == 1 then
		var_40_1 = 0
	else
		local var_40_2 = arg_40_0.animationPlayer

		var_4.Play(var_40_2, "anim_IslandFormulaSelectNewUI_bar_Loop")
	end

	setText = var_4

	var_4(arg_40_0.addExp, "EXP+" .. arg_40_0.formulaCfg.ship_exp * var_40_0)

	if arg_40_0.eneryTimer then
		local var_40_3 = arg_40_0.eneryTimer

		var_4.Stop(var_40_3)
	end

	Timer = var_4
	arg_40_0.eneryTimer = var_4.New(function()
		local var_41_0 = arg_40_0.selectedShip
		local var_41_1 = var_0.GetCurrentEnergy(var_41_0)
		local var_41_2 = arg_40_0.selectedShip
		local var_41_3 = var_1.GetMaxEnergy(var_41_2)

		setSlider = var_41_2

		var_41_2(arg_40_0.energyBarTf, 0, 1, (var_41_1 - var_40_1) / var_41_3)

		setSlider = var_41_2

		var_41_2(arg_40_0.energyBarUseTf, 0, 1, var_41_1 / var_41_3)

		setText = var_41_2

		local var_41_4 = arg_40_0.energy_countTf

		string = var_4

		var_41_2(var_41_4, var_4.format("%d-<color=#f7c35f>%d</color>/%d", var_41_1, var_40_1, var_41_3))

		return
	end, 1, -1)

	local var_40_4 = arg_40_0.eneryTimer

	var_4.Start(var_40_4)
	arg_40_0.eneryTimer.func()

	return
end

function var_0_1.InitUnlockedFormulaList(arg_42_0)
	arg_42_0.formulaList = {}
	arg_42_0.formulaToActivityDic = {}

	if arg_42_0.addDelegateFormula then
		table = var_1

		var_1.insert(arg_42_0.formulaList, arg_42_0.addDelegateFormula)

		return
	end

	getProxy = var_1
	IslandProxy = var_1_10002

	local var_42_0 = var_1(var_1_10002)
	local var_42_1 = var_1.GetIsland(var_42_0)
	local var_42_2 = var_1.GetAblityAgency(var_42_1)

	ipairs = var_42_1
	pg = var_1_10003

	local var_42_3

	if not var_1_10003.island_production_slot[arg_42_0.slotId].activity_formula then
		var_42_3 = {}
	end

	for iter_42_0, iter_42_1 in var_42_1(var_42_3) do
		var_1_10007 = iter_42_1[1]
		var_1_10008 = iter_42_1[2]
		getProxy = var_1_10009
		ActivityProxy = var_1_10010
		var_1_10010 = var_1_10009(var_1_10010)

		if var_1_10009.getActivityById(var_1_10010, var_1_10007) then
			var_1_10011 = var_1_10009

			if not var_1_10009.isEnd(var_1_10011) then
				ipairs = var_1_10010
				var_1_10011 = var_1_10008 or {}

				for iter_42_2, iter_42_3 in var_1_10010(var_1_10011) do
					pg = var_1_10015
					var_1_10015 = var_1_10015.island_formula[iter_42_3].unlock_type == 0

					local var_42_4

					if not var_1_10015 then
						::label_42_0::

						var_1_10017 = var_42_2
						var_42_4 = var_42_2.IsUnlockFormuate(var_1_10017, iter_42_3)
					end

					if var_42_4 then
						table = var_1_10017

						var_1_10017.insert(arg_42_0.formulaList, iter_42_3)

						var_1_10017 = arg_42_0.formulaToActivityDic
						var_1_10017[iter_42_3] = var_1_10007
					end
				end
			end
		end
	end

	ipairs = var_2
	pg = var_3

	local var_42_5

	if not var_3.island_production_slot[arg_42_0.slotId].formula then
		var_42_5 = {}
	end

	for iter_42_4, iter_42_5 in var_2(var_42_5) do
		pg = var_1_10007
		var_1_10007 = var_1_10007.island_formula[iter_42_5].unlock_type == 0
		pg = var_1_10008
		var_1_10008 = var_1_10008.island_formula[iter_42_5].unlock_type == -1

		local var_42_6 = true

		if var_1_10008 then
			pg = var_1_10010
			var_1_10010 = var_1_10010.island_combo[iter_42_5].unlock_condition
			getProxy = var_1_10011
			IslandProxy = var_1_10012
			var_1_10012 = var_1_10011(var_1_10012)
			var_1_10012 = var_1_10011.GetIsland(var_1_10012)
			var_1_10012 = var_1_10011.GetBuildingAgency(var_1_10012)
			var_1_10011 = var_1_10011.GetFormulaNums(var_1_10012)
			ipairs = var_1_10012

			for iter_42_6, iter_42_7 in var_1_10012(var_1_10010) do
				local var_42_7 = iter_42_7[1]
				local var_42_8 = iter_42_7[2]

				if not var_1_10011[var_42_7] or var_42_8 > var_1_10011[var_42_7] then
					var_42_6 = false

					break
				end
			end
		end

		if not var_1_10007 then
			::label_42_1::

			var_1_10011 = var_42_2

			if not var_42_2.IsUnlockFormuate(var_1_10011, iter_42_5) then
				var_1_10010 = var_1_10008 and var_42_6
			end
		end

		if var_1_10010 then
			table = var_1_10011

			var_1_10011.insert(arg_42_0.formulaList, iter_42_5)
		end
	end

	return
end

function var_0_1.RefreshCurSelectCount(arg_43_0)
	local var_43_0

	if not arg_43_0.addDelegateFormulaTimes then
		var_43_0 = arg_43_0.curSelectCount
	end

	setText = var_1_10002

	local var_43_1 = arg_43_0.curCountTips

	tostring = var_1_10004

	var_1_10002(var_43_1, var_1_10004(var_43_0))

	local var_43_2

	if not arg_43_0.addDelegateFormulaTimes or not (arg_43_0.curSelectCount - arg_43_0.addDelegateFormulaTimes) then
		var_43_2 = 0
	end

	setText = var_43_1

	var_43_1(arg_43_0.addCountTips, "+" .. var_43_2)

	setSlider = var_43_1

	var_43_1(arg_43_0.curCountNumSlider, 1, arg_43_0.productMaxTime, arg_43_0.curSelectCount)
	arg_43_0:RefreshExtraProduct()

	local var_43_3 = "×" .. arg_43_0.formulaCfg.commission_product[1][2]
	local var_43_4 = arg_43_0:GetAniExtraGainByConfigName("efficiency_gains_num")

	if 0 < var_43_4 then
		string = var_5
		var_43_3 = var_5.format("×(%s<color=#7df39f>+%d</color>)", arg_43_0.formulaCfg.commission_product[1][2], var_43_4)
	end

	setText = var_5

	local var_43_5 = arg_43_0.currentformulaIcon
	local var_43_6 = var_6.Find(var_43_5, "icon_bg/product_count_bg/product_count")
	local var_43_7 = var_43_3

	i18n = var_8

	var_5(var_43_6, var_43_7 .. var_8("island_production_tip"))

	local var_43_8, var_43_9 = arg_43_0:CacaluteProductTime()
	local var_43_10 = 0

	ipairs = var_8

	for iter_43_0, iter_43_1 in var_8(var_43_8) do
		var_43_10 = var_43_10 + iter_43_1
	end

	local var_43_11 = var_43_9 - var_43_10

	pg = var_9

	local var_43_12 = var_9.TimeMgr.GetInstance()
	local var_43_13 = var_9.DescCDTime(var_43_12, var_43_10)
	local var_43_14

	if 0 < var_43_11 then
		string = var_43_14
		var_43_14 = var_43_14.format

		local var_43_15 = "%s(<color=#7df39f>-%s</color>)"
		local var_43_16 = var_43_13

		pg = var_1_10013

		local var_43_17 = var_1_10013.TimeMgr.GetInstance()

		var_43_13 = var_43_14(var_43_15, var_43_16, var_13.DescCDTime(var_43_17, var_43_11))
	end

	setText = var_43_14

	var_43_14(arg_43_0.needTimeText, var_43_13)

	return
end

function var_0_1.RefreshExtraProduct(arg_44_0)
	getProxy = var_1_10001
	IslandProxy = var_1_10002

	local var_44_0 = var_1_10001(var_1_10002)
	local var_44_1 = var_1.GetIsland(var_44_0)
	local var_44_2 = var_1.GetAblityAgency(var_44_1)

	if #arg_44_0.formulaCfg.second_product == 0 or not var_44_2:IsUnlcokSecondProduct(arg_44_0.selectFormulaId) then
		setActive = var_2

		var_2(arg_44_0.extraProduct, false)

		return
	end

	setActive = var_2

	var_2(arg_44_0.extraProduct, true)

	local var_44_3 = arg_44_0.formulaCfg.second_product_display[1][1]
	local var_44_4 = arg_44_0.formulaCfg.second_product_display[1][2]

	pg = var_4

	local var_44_5 = var_4.island_item_data_template[var_44_3]

	Drop = var_1_10005

	local var_44_6 = var_1_10005.New
	local var_44_7 = {
		count = 0
	}

	DROP_TYPE_ISLAND_ITEM = var_1_10007
	var_44_7.type = var_1_10007
	var_44_7.id = var_44_3

	local var_44_8 = var_44_6(var_44_7)

	onButton = var_44_7

	var_44_7(arg_44_0, arg_44_0.extraProductIcon, function()
		local var_45_0 = arg_44_0
		local var_45_1 = var_0.ShowMsgBox
		local var_45_2 = {}

		i18n = var_2_10003
		var_45_2.title = var_2_10003("island_word_desc")
		IslandMsgBox = var_3
		var_45_2.type = var_3.TYPE_COMMON_DROP_DESCRIBE
		var_45_2.dropData = var_44_8

		var_45_1(var_45_0, var_45_2)

		return
	end)

	GetImageSpriteFromAtlasAsync = var_44_7

	var_44_7("island/" .. var_44_5.icon, "", arg_44_0.extraProductIcon)

	local var_44_9 = "×" .. var_44_4
	local var_44_10 = arg_44_0:GetAniExtraGainByConfigName("efficiency_gains_bonus_num")

	if 0 < var_44_10 then
		string = var_8
		var_44_9 = var_8.format("×(%s<color=#7df39f>+%d</color>)", var_44_4, var_44_10)
	end

	setText = var_8

	local var_44_11 = arg_44_0.extraProductNum
	local var_44_12 = var_44_9

	i18n = var_1_10011

	var_8(var_44_11, var_44_12 .. var_1_10011("island_production_tip"))

	pg = var_8

	local var_44_13 = var_8.island_production_slot[arg_44_0.slotId].place

	getProxy = var_9
	IslandProxy = var_10

	local var_44_14 = var_9(var_10)
	local var_44_15 = var_9.GetIsland(var_44_14)
	local var_44_16 = var_9.GetBuildingAgency(var_44_15)
	local var_44_17 = var_10.GetBuilding(var_44_16, var_44_13)
	local var_44_18 = var_10.GetDelegationSlotData(var_44_17, arg_44_0.slotId)
	local var_44_19 = var_11.GetFromulaTatalCount(var_44_18, arg_44_0.formulaCfg.id)
	local var_44_20 = arg_44_0.formulaCfg.second_product[1]
	local var_44_21

	if not arg_44_0.canRewardTime then
		var_44_21 = 0
	end

	local var_44_22 = (var_44_19 + var_44_21) % var_44_20
	local var_44_23

	if not arg_44_0.addDelegateFormulaTimes or not (arg_44_0.curSelectCount - arg_44_0.addDelegateFormulaTimes) then
		var_44_23 = arg_44_0.curSelectCount
	end

	local var_44_24 = var_44_22 + var_44_23

	math = var_1_10019

	local var_44_25 = var_1_10019.floor(var_44_24 / var_44_20)

	arg_44_0.extraProcess = var_44_24 % var_44_20
	setText = var_20

	var_20(arg_44_0.extraProductName, var_44_5.name .. "×" .. var_44_25)

	local var_44_26

	if arg_44_0.addDelegateFormulaTimes then
		setActive = var_44_26

		var_44_26(arg_44_0.extraProductAddnum, true)

		var_44_26 = arg_44_0.curSelectCount - arg_44_0.addDelegateFormulaTimes
		math = var_21

		local var_44_27 = var_21.floor((var_44_22 + var_44_26) / var_44_20)

		setText = var_22

		var_22(arg_44_0.extraProductAddnum, "+" .. var_44_27)
	else
		setActive = var_44_26

		var_44_26(arg_44_0.extraProductAddnum, false)
	end

	local var_44_28 = arg_44_0.extraProductList

	var_20.align(var_44_28, var_44_20)

	return
end

function var_0_1.CacaluteProductTime(arg_46_0)
	local var_46_0

	if not arg_46_0.addDelegateFormulaTimes or not (arg_46_0.curSelectCount - arg_46_0.addDelegateFormulaTimes) then
		var_46_0 = arg_46_0.curSelectCount
	end

	pg = var_1_10002

	local var_46_1 = var_1_10002.island_set.base_efficiency.key_value_int

	math = var_1_10003

	local var_46_2 = var_1_10003.ceil(arg_46_0.formulaCfg.workload / var_46_1)

	IslandProductTimeHelper = var_4

	return var_4.CalculateTimeToProductFormula(arg_46_0.selectedShipId, arg_46_0.selectFormulaId, var_46_0, arg_46_0.placeId, arg_46_0.slotId), var_46_2 * var_46_0
end

function var_0_1.CheckInPlace(arg_47_0, arg_47_1, arg_47_2)
	ipairs = var_1_10003

	for iter_47_0, iter_47_1 in var_1_10003(arg_47_2) do
		if iter_47_1 == arg_47_1 then
			return true
		end
	end

	return false
end

function var_0_1.GetAttrGrade(arg_48_0, arg_48_1)
	pg = var_1_10002

	local var_48_0 = var_1_10002.island_chara_att.all

	pg = var_1_10003

	local var_48_1 = var_48_0[#var_1_10003.island_chara_att.all]

	ipairs = var_3
	pg = var_1_10004

	for iter_48_0, iter_48_1 in var_3(var_1_10004.island_chara_att.all) do
		pg = var_1_10008

		local var_48_2 = var_1_10008.island_chara_att[iter_48_1].range[1]
		local var_48_3 = var_1_10008.range[2]

		if var_48_2 <= arg_48_1 and arg_48_1 <= var_48_3 then
			var_48_1 = iter_48_1

			break
		end
	end

	return var_48_1
end

function var_0_1.GetAttrGrowingValueByBuff(arg_49_0, arg_49_1, arg_49_2)
	ipairs = var_1_10003

	for iter_49_0, iter_49_1 in var_1_10003(arg_49_2) do
		if iter_49_1[1] == arg_49_1 then
			return iter_49_1[2]
		end
	end

	return 0
end

function var_0_1.GetOneFormulaEnergyCost(arg_50_0)
	math = var_1_10001

	local var_50_0 = var_1_10001.floor
	local var_50_1 = arg_50_0.formulaCfg.stamina_cost

	IslandProductCostHelper = var_1_10003

	local var_50_2 = var_50_0(var_50_1 * (1 - var_1_10003.GetReducePercentInPlace(arg_50_0.selectedShipId, arg_50_0.placeId)))

	math = var_2

	return (var_2.max(var_50_2, 1))
end

function var_0_1.OnHide(arg_51_0)
	arg_51_0:UnBlurPanel()

	if arg_51_0.eneryTimer then
		local var_51_0 = arg_51_0.eneryTimer

		var_1.Stop(var_51_0)
	end

	return
end

function var_0_1.OnDisable(arg_52_0)
	arg_52_0:OnHide()

	return
end

function var_0_1.OnDestroy(arg_53_0)
	arg_53_0:OnHide()

	return
end

function var_0_1.Show(arg_54_0, ...)
	arg_54_0:AddListeners()

	local var_54_0 = arg_54_0.islandUIController

	var_1.Show(var_54_0, true)
	arg_54_0:OnShow(...)

	return
end

function var_0_1.Hide(arg_55_0, arg_55_1, arg_55_2)
	defaultValue = var_1_10003

	local var_55_0 = var_1_10003(arg_55_1, true)

	local function var_55_1()
		local var_56_0 = arg_55_0

		var_0.ClosePage(var_56_0, arg_55_0)

		local var_56_1 = arg_55_0

		var_0.RemoveListeners(var_56_1)

		local var_56_2 = arg_55_0

		var_0.OnHide(var_56_2)

		if not arg_55_2 then
			local var_56_3 = arg_55_0

			var_0.OnExit(var_56_3)
		end

		return
	end

	if var_55_0 then
		local var_55_2 = arg_55_0.islandUIController

		var_5.Hide(var_55_2, true, var_55_1)
	else
		var_55_1()
	end

	return
end

return var_0_1
