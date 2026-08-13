class = var_0_10000

local var_0_0 = "IslandSetCardPhotoBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandSetCardPhotoBox"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_2.Find(var_2_0, "frame/title")

	i18n = var_2_0

	var_1_10001(var_2_1, var_2_0("island_card_choose_photo"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "frame/close")

	local var_2_3 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_3, "cancel")
	setText = var_1

	local var_2_4 = arg_2_0.cancelBtn
	local var_2_5 = var_2.Find(var_2_4, "Text")

	i18n = var_2_4

	var_1(var_2_5, var_2_4("word_cancel"))

	local var_2_6 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_6, "confirm")
	setText = var_1

	local var_2_7 = arg_2_0.confirmBtn
	local var_2_8 = var_2.Find(var_2_7, "Text")

	i18n = var_2_7

	var_1(var_2_8, var_2_7("word_ok"))

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_1.Find(var_2_9, "scrollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_10, "LScrollRect")

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
	local var_5_1 = arg_5_0.closeBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.cancelBtn

	local function var_5_5()
		local var_7_0 = arg_5_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	onButton = var_1_10001

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.confirmBtn

	local function var_5_8()
		local var_8_0 = arg_5_0
		local var_8_1 = var_0.emit

		IslandSelfCardMediator = var_2_10002

		var_8_1(var_8_0, var_2_10002.SET_CARD_PHOTO, arg_5_0.selectedId)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10005)

	arg_5_0.cards = {}

	return
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	IslandCardPhotoCard = var_1_10002

	local var_9_0 = var_1_10002.New(arg_9_1)

	arg_9_0.cards[arg_9_1] = var_9_0

	return
end

function var_0_1.OnUpdateItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	if not arg_10_0.cards[arg_10_2] then
		arg_10_0:OnInitItem(arg_10_2)

		var_10_0 = arg_10_0.cards[arg_10_2]
	end

	if arg_10_0.ids[arg_10_1 + 1] then
		var_10_0:Update(var_4, arg_10_0.selectedId)
	end

	onButton = var_5

	local var_10_1 = arg_10_0
	local var_10_2 = var_10_0._go

	local function var_10_3()
		pairs = var_2_10000

		for iter_11_0, iter_11_1 in var_2_10000(arg_10_0.cards) do
			iter_11_1:UpdateSelected(nil)
		end

		arg_10_0.selectedId = var_0

		local var_11_0 = var_10_0

		var_0.UpdateSelected(var_11_0, arg_10_0.selectedId)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_10_1, var_10_2, var_10_3, var_1_10009)

	return
end

function var_0_1.Show(arg_12_0, arg_12_1, arg_12_2)
	var_0_1.super.Show(arg_12_0)

	arg_12_0.ids = arg_12_1
	table = var_3

	var_3.sort(arg_12_0.ids)

	arg_12_0.selectedId = arg_12_2

	local var_12_0 = arg_12_0.scrollRect

	var_3.SetTotalCount(var_12_0, #arg_12_0.ids, -1)

	pg = var_3

	local var_12_1 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_12_1, arg_12_0._tf)

	return
end

function var_0_1.Hide(arg_13_0)
	var_0_1.super.Hide(arg_13_0)

	pg = var_1

	local var_13_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_13_0, arg_13_0._tf, arg_13_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_14_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_14_0.scrollRect)

	pairs = var_1_10001

	for iter_14_0, iter_14_1 in var_1_10001(arg_14_0.cards) do
		iter_14_1:Dispose()
	end

	arg_14_0.cards = {}
	pg = var_1

	local var_14_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_14_0, arg_14_0._tf, arg_14_0._parentTf)

	return
end

return var_0_1
