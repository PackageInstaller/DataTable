class = var_0_10000

local var_0_0 = "IslandTicketStoragePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.IslandBasePage"))

var_0_1.SORT_TYPES = {
	SPEED_UP = 2,
	VALID = 1
}

function var_0_1.getUIName(arg_1_0)
	return "IslandTicketStorageUI"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "frame/title")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("island_ticket_storage_title"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.ascToggleTF = var_1.Find(var_2_2, "toggle_asc")

	local var_2_3 = arg_2_0._tf

	arg_2_0.sortToggleTF = var_1.Find(var_2_3, "toggle_sort")

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_1.Find(var_2_4, "sort_panel")
	local var_2_6 = var_1.GetComponent

	typeof = var_3
	Animation = var_4
	arg_2_0.sortPanelAnim = var_2_6(var_2_5, var_3(var_4))

	local var_2_7 = arg_2_0._tf

	arg_2_0.sortByValidBtn = var_1.Find(var_2_7, "sort_panel/valid")
	setText = var_1

	local var_2_8 = arg_2_0.sortByValidBtn
	local var_2_9 = var_2.Find(var_2_8, "Text")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("island_ticket_sort_valid"))

	local var_2_10 = arg_2_0._tf

	arg_2_0.sortBySpeedupBtn = var_1.Find(var_2_10, "sort_panel/speedup")
	setText = var_1

	local var_2_11 = arg_2_0.sortBySpeedupBtn
	local var_2_12 = var_2.Find(var_2_11, "Text")

	i18n = var_2_11

	var_1(var_2_12, var_2_11("island_ticket_sort_speedup"))

	local var_2_13 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_13, "confirm")
	setText = var_1

	local var_2_14 = arg_2_0.confirmBtn
	local var_2_15 = var_2.Find(var_2_14, "Text")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("word_ok"))

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_1.Find(var_2_16, "scrollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_17, "LScrollRect")

	function arg_2_0.scrollRect.onInitItem(arg_3_0)
		local var_3_0 = arg_2_0

		var_1.OnInitItem(var_3_0, arg_3_0)

		return
	end

	function arg_2_0.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = arg_2_0

		var_2.OnUpdateItem(var_4_0, arg_4_0, arg_4_1)

		return
	end

	return
end

function var_0_1.OnInit(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf
	local var_5_2 = var_3.Find(var_5_1, "frame/title/help")

	local function var_5_3()
		local var_6_0 = arg_5_0
		local var_6_1 = var_0.ShowMsgBox
		local var_6_2 = {}

		IslandMsgBox = var_2_10003
		var_6_2.type = var_2_10003.TYPE_WHITOUT_BTN
		i18n = var_3
		var_6_2.content = var_3("island_helpbtn_speedup")

		var_6_1(var_6_0, var_6_2)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_0, var_5_2, var_5_3, var_5)

	onButton = var_1_10001

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0._tf
	local var_5_6 = var_3.Find(var_5_5, "frame/close")

	local function var_5_7()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_4, var_5_6, var_5_7, var_5)

	onButton = var_1_10001

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0._tf
	local var_5_10 = var_3.Find(var_5_9, "mask")

	local function var_5_11()
		local var_8_0 = arg_5_0

		var_0.Hide(var_8_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_8, var_5_10, var_5_11, var_5)

	onButton = var_1_10001

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.confirmBtn

	local function var_5_14()
		local var_9_0 = arg_5_0

		var_0.Hide(var_9_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_12, var_5_13, var_5_14, var_5)

	onToggle = var_1_10001

	local var_5_15 = arg_5_0
	local var_5_16 = arg_5_0.ascToggleTF

	local function var_5_17(arg_10_0)
		arg_5_0.isAsc = arg_10_0

		local var_10_0 = arg_5_0

		var_1.SetTotalCount(var_10_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_15, var_5_16, var_5_17, var_5)

	onToggle = var_1_10001

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.sortToggleTF

	local function var_5_20(arg_11_0)
		local var_11_0 = arg_11_0 and "anim_IslandTicketStorageUI_sort_in" or "anim_IslandTicketStorageUI_sort_out"
		local var_11_1 = arg_5_0.sortPanelAnim

		var_2.Play(var_11_1, var_11_0)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_18, var_5_19, var_5_20, var_5)

	onButton = var_1_10001

	local var_5_21 = arg_5_0
	local var_5_22 = arg_5_0.sortByValidBtn

	local function var_5_23()
		local var_12_0 = arg_5_0

		var_12_0.sortType = var_0_1.SORT_TYPES.VALID
		setText = var_12_0

		local var_12_1 = arg_5_0.sortToggleTF
		local var_12_2 = var_1.Find(var_12_1, "Text")

		i18n = var_12_1

		var_12_0(var_12_2, var_12_1("island_ticket_sort_valid"))

		triggerToggle = var_12_0

		var_12_0(arg_5_0.sortToggleTF, false)

		local var_12_3 = arg_5_0

		var_0.SetTotalCount(var_12_3)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_21, var_5_22, var_5_23, var_5)

	onButton = var_1_10001

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.sortBySpeedupBtn

	local function var_5_26()
		local var_13_0 = arg_5_0

		var_13_0.sortType = var_0_1.SORT_TYPES.SPEED_UP
		setText = var_13_0

		local var_13_1 = arg_5_0.sortToggleTF
		local var_13_2 = var_1.Find(var_13_1, "Text")

		i18n = var_13_1

		var_13_0(var_13_2, var_13_1("island_ticket_sort_speedup"))

		triggerToggle = var_13_0

		var_13_0(arg_5_0.sortToggleTF, false)

		local var_13_3 = arg_5_0

		var_0.SetTotalCount(var_13_3)

		return
	end

	SFX_PANEL = var_5

	var_1_10001(var_5_24, var_5_25, var_5_26, var_5)

	arg_5_0.cards = {}

	return
end

function var_0_1.OnInitItem(arg_14_0, arg_14_1)
	IslandTicketCard = var_1_10002

	local var_14_0 = var_1_10002.New(arg_14_1)

	arg_14_0.cards[arg_14_1] = var_14_0

	return
end

function var_0_1.OnUpdateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0

	if not arg_15_0.cards[arg_15_2] then
		arg_15_0:OnInitItem(arg_15_2)

		var_15_0 = arg_15_0.cards[arg_15_2]
	end

	local var_15_1 = arg_15_0.displays[arg_15_1 + 1]

	var_15_0:Update(var_15_1)

	return
end

function var_0_1.OnShow(arg_16_0)
	local var_16_0 = arg_16_0

	arg_16_0.BlurPanel(var_16_0)

	getProxy = var_1
	IslandProxy = var_16_0

	local var_16_1 = var_1(var_16_0)
	local var_16_2 = var_1.GetIsland(var_16_1)

	arg_16_0.ticketAgency = var_1.GetTicketAgency(var_16_2)

	local var_16_3 = arg_16_0.ticketAgency

	arg_16_0.displays = var_1.GetAllTicketList(var_16_3)
	arg_16_0.isAsc = true
	arg_16_0.sortType = var_0_1.SORT_TYPES.SPEED_UP
	triggerButton = var_1

	var_1(arg_16_0.sortBySpeedupBtn)

	return
end

function var_0_1.SetTotalCount(arg_17_0)
	if arg_17_0.sortType == var_0_1.SORT_TYPES.VALID then
		arg_17_0:SortByValid()
	elseif arg_17_0.sortType == var_0_1.SORT_TYPES.SPEED_UP then
		arg_17_0:SortBySpeedup()
	end

	local var_17_0 = arg_17_0.scrollRect

	var_1.SetTotalCount(var_17_0, #arg_17_0.displays, -1)

	return
end

function var_0_1.SortBySpeedup(arg_18_0)
	local var_18_0 = arg_18_0.isAsc and 1 or -1

	table = var_1_10002

	local var_18_1 = var_1_10002.sort
	local var_18_2 = arg_18_0.displays

	CompareFuncs = var_1_10004

	var_18_1(var_18_2, var_1_10004({
		function(arg_19_0)
			return var_18_0 * arg_19_0:GetTime()
		end,
		function(arg_20_0)
			return var_18_0 * (arg_20_0:IsForever() and 1 or 0)
		end,
		function(arg_21_0)
			return var_18_0 * arg_21_0:GetEndTime()
		end,
		function(arg_22_0)
			return var_18_0 * arg_22_0.id
		end
	}))

	return
end

function var_0_1.SortByValid(arg_23_0)
	local var_23_0 = arg_23_0.isAsc and 1 or -1

	table = var_1_10002

	local var_23_1 = var_1_10002.sort
	local var_23_2 = arg_23_0.displays

	CompareFuncs = var_1_10004

	var_23_1(var_23_2, var_1_10004({
		function(arg_24_0)
			return var_23_0 * (arg_24_0:IsForever() and 1 or 0)
		end,
		function(arg_25_0)
			return var_23_0 * arg_25_0:GetEndTime()
		end,
		function(arg_26_0)
			return var_23_0 * arg_26_0:GetTime()
		end,
		function(arg_27_0)
			return var_23_0 * arg_27_0.id
		end
	}))

	return
end

function var_0_1.OnHide(arg_28_0)
	arg_28_0:UnBlurPanel()

	return
end

function var_0_1.OnDestroy(arg_29_0)
	arg_29_0:OnHide()

	ClearLScrollrect = var_1

	var_1(arg_29_0.scrollRect)

	pairs = var_1

	for iter_29_0, iter_29_1 in var_1(arg_29_0.cards) do
		iter_29_1:Dispose()
	end

	arg_29_0.cards = {}

	return
end

return var_0_1
