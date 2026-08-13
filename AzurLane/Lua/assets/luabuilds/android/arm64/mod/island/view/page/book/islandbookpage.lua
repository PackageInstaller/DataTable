class = var_0_10000

local var_0_0 = "IslandBookPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.IslandBasePage"))

function var_0_1.getUIName(arg_1_0)
	return "IslandBookUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "top/title/Text")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("island_guide"))

	setText = var_1_10001

	local var_2_2 = arg_2_0._tf
	local var_2_3 = var_3.Find(var_2_2, "top/title/Text/en")

	i18n = var_4

	var_1_10001(var_2_3, var_4("island_guide_en"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.charBtn = var_1.Find(var_2_4, "view/content/char")

	local var_2_5 = arg_2_0.charBtn

	arg_2_0.charTip = var_1.Find(var_2_5, "tip")

	local var_2_6 = arg_2_0._tf

	arg_2_0.npcBtn = var_1.Find(var_2_6, "view/content/npc")

	local var_2_7 = arg_2_0.npcBtn

	arg_2_0.npcTip = var_1.Find(var_2_7, "tip")

	local var_2_8 = arg_2_0._tf

	arg_2_0.itemBtn = var_1.Find(var_2_8, "view/content/item")

	local var_2_9 = arg_2_0.itemBtn

	arg_2_0.itemTip = var_1.Find(var_2_9, "tip")

	local var_2_10 = arg_2_0._tf

	arg_2_0.fishBtn = var_1.Find(var_2_10, "view/content/fish")

	local var_2_11 = arg_2_0.fishBtn

	arg_2_0.fishTip = var_1.Find(var_2_11, "tip")

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "top/back")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	onButton = var_1_10001

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.charBtn

	local function var_3_6()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.OpenPage

		IslandBookCharPage = var_2_10003

		var_5_1(var_5_0, var_2_10003)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_4, var_3_5, var_3_6, var_3_1)

	onButton = var_1_10001

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.npcBtn

	local function var_3_9()
		local var_6_0 = arg_3_0
		local var_6_1 = var_0.OpenPage

		IslandBookNpcPage = var_2_10003

		var_6_1(var_6_0, var_2_10003)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_7, var_3_8, var_3_9, var_3_1)

	onButton = var_1_10001

	local var_3_10 = arg_3_0
	local var_3_11 = arg_3_0.itemBtn

	local function var_3_12()
		local var_7_0 = arg_3_0
		local var_7_1 = var_0.OpenPage

		IslandBookItemPage = var_2_10003

		var_7_1(var_7_0, var_2_10003)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_10, var_3_11, var_3_12, var_3_1)

	onButton = var_1_10001

	local var_3_13 = arg_3_0
	local var_3_14 = arg_3_0.fishBtn

	local function var_3_15()
		local var_8_0 = arg_3_0
		local var_8_1 = var_0.OpenPage

		IslandBookFishPage = var_2_10003

		var_8_1(var_8_0, var_2_10003)

		return
	end

	SFX_PANEL = var_3_1

	var_1_10001(var_3_13, var_3_14, var_3_15, var_3_1)

	return
end

function var_0_1.AddListeners(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.AddListener

	GAME = var_1_10004

	var_9_1(var_9_0, var_1_10004.ISLAND_UNLOCK_ILLUSTRATION_DONE, arg_9_0.FlushTips)

	local var_9_2 = arg_9_0
	local var_9_3 = arg_9_0.AddListener

	GAME = var_4

	var_9_3(var_9_2, var_4.ISLAND_GET_COLLECT_POINT_DONE, arg_9_0.FlushTips)

	local var_9_4 = arg_9_0
	local var_9_5 = arg_9_0.AddListener

	GAME = var_4

	var_9_5(var_9_4, var_4.ISLAND_GET_POINT_AWARD_DONE, arg_9_0.FlushTips)

	return
end

function var_0_1.RemoveListeners(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.RemoveListener

	GAME = var_1_10004

	var_10_1(var_10_0, var_1_10004.ISLAND_UNLOCK_ILLUSTRATION_DONE, arg_10_0.FlushTips)

	local var_10_2 = arg_10_0
	local var_10_3 = arg_10_0.RemoveListener

	GAME = var_4

	var_10_3(var_10_2, var_4.ISLAND_GET_COLLECT_POINT_DONE, arg_10_0.FlushTips)

	local var_10_4 = arg_10_0
	local var_10_5 = arg_10_0.RemoveListener

	GAME = var_4

	var_10_5(var_10_4, var_4.ISLAND_GET_POINT_AWARD_DONE, arg_10_0.FlushTips)

	return
end

function var_0_1.OnShow(arg_11_0)
	arg_11_0:FlushTips()

	return
end

function var_0_1.FlushTips(arg_12_0)
	setActive = var_1_10001

	local var_12_0 = arg_12_0.fishBtn

	IslandMainBtnTipHelper = var_1_10004

	var_1_10001(var_12_0, var_1_10004.IsUnlock("book_fish"))

	getProxy = var_1_10001
	IslandProxy = var_12_0

	local var_12_1 = var_1_10001(var_12_0)
	local var_12_2 = var_1.GetIsland(var_12_1)

	arg_12_0.bookAgency = var_1.GetBookAgency(var_12_2)
	setActive = var_1

	local var_12_3 = arg_12_0.charTip
	local var_12_4 = arg_12_0.bookAgency
	local var_12_5 = var_4.IsTipFromTypes
	local var_12_6 = {}

	IslandIllustration = var_1_10008
	var_12_6[1] = var_1_10008.TYPES.CHAR

	var_1(var_12_3, var_12_5(var_12_4, var_12_6))

	setActive = var_1

	local var_12_7 = arg_12_0.npcTip
	local var_12_8 = arg_12_0.bookAgency
	local var_12_9 = var_4.IsTipFromTypes
	local var_12_10 = {}

	IslandIllustration = var_8
	var_12_10[1] = var_8.TYPES.NPC

	var_1(var_12_7, var_12_9(var_12_8, var_12_10))

	setActive = var_1

	local var_12_11 = arg_12_0.itemTip
	local var_12_12 = arg_12_0.bookAgency
	local var_12_13 = var_4.IsTipFromTypes
	local var_12_14 = {}

	IslandIllustration = var_8
	var_12_14[1] = var_8.TYPES.ITEM

	var_1(var_12_11, var_12_13(var_12_12, var_12_14))

	setActive = var_1

	local var_12_15 = arg_12_0.fishTip
	local var_12_16 = arg_12_0.bookAgency
	local var_12_17 = var_4.IsTipFromTypes
	local var_12_18 = {}

	IslandIllustration = var_8
	var_12_18[1] = var_8.TYPES.FISH

	var_1(var_12_15, var_12_17(var_12_16, var_12_18))

	return
end

return var_0_1
