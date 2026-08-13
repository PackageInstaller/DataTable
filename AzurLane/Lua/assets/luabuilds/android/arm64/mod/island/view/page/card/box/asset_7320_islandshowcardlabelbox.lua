class = var_0_10000

local var_0_0 = "IslandShowCardLabelBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandShowCardLabelBox"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_3.Find(var_2_0, "frame/title")

	i18n = var_1_10004

	var_1_10001(var_2_1, var_1_10004("island_card_label_list"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_2, "frame/close")

	local var_2_3 = arg_2_0._tf

	arg_2_0.emptyTF = var_1.Find(var_2_3, "empty")
	setText = var_1

	local var_2_4 = arg_2_0.emptyTF

	i18n = var_4

	var_1(var_2_4, var_4("island_card_no_label_tip"))

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "scrollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_6, "LScrollRect")

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

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	arg_5_0.cards = {}

	return
end

function var_0_1.OnInitItem(arg_7_0, arg_7_1)
	IslandCardShowLabelCard = var_1_10002

	local var_7_0 = var_1_10002.New(arg_7_1)

	arg_7_0.cards[arg_7_1] = var_7_0

	return
end

function var_0_1.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0

	if not arg_8_0.cards[arg_8_2] then
		arg_8_0:OnInitItem(arg_8_2)

		var_8_0 = arg_8_0.cards[arg_8_2]
	end

	if arg_8_0.labelList[arg_8_1 + 1] then
		var_8_0:Update(var_4.id, var_4.num)
	end

	return
end

function var_0_1.Show(arg_9_0, arg_9_1)
	var_0_1.super.Show(arg_9_0)

	arg_9_0.labelList = arg_9_1

	local var_9_0 = arg_9_0.scrollRect

	var_2.SetTotalCount(var_9_0, #arg_9_0.labelList, -1)

	setActive = var_2

	var_2(arg_9_0.emptyTF, #arg_9_0.labelList == 0)

	pg = var_2

	local var_9_1 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_9_1, arg_9_0._tf)

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_11_0.scrollRect)

	pairs = var_1_10001

	for iter_11_0, iter_11_1 in var_1_10001(arg_11_0.cards) do
		iter_11_1:Dispose()
	end

	arg_11_0.cards = {}
	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf, arg_11_0._parentTf)

	return
end

return var_0_1
