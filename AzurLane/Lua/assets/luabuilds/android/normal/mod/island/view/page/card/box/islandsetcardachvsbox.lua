class = var_0_10000

local var_0_0 = "IslandSetCardAchvsBox"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.MAX_CNT = 4

function var_0_1.getUIName(arg_1_0)
	return "IslandSetCardAchvsBox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "frame/title")
	local var_2_2 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_2(var_2_1, var_3(var_1_10004))

	local var_2_3 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_3, "frame/close")

	local var_2_4 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_4, "cancel")
	setText = var_1

	local var_2_5 = arg_2_0.cancelBtn
	local var_2_6 = var_2.Find(var_2_5, "Text")

	i18n = var_2_5

	var_1(var_2_6, var_2_5("word_cancel"))

	local var_2_7 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_7, "confirm")
	setText = var_1

	local var_2_8 = arg_2_0.confirmBtn
	local var_2_9 = var_2.Find(var_2_8, "Text")

	i18n = var_2_8

	var_1(var_2_9, var_2_8("word_ok"))

	local var_2_10 = arg_2_0._tf

	arg_2_0.emptyTF = var_1.Find(var_2_10, "empty")
	setText = var_1

	local var_2_11 = arg_2_0.emptyTF

	i18n = var_3

	var_1(var_2_11, var_3("island_card_no_achieve_tip"))

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_1.Find(var_2_12, "scrollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_13, "LScrollRect")

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
		getProxy = var_2_10000
		IslandProxy = var_2_10001

		local var_8_0 = var_2_10000(var_2_10001)
		local var_8_1 = var_0.GetIsland(var_8_0)
		local var_8_2 = var_0.GetAchievementAgency(var_8_1)
		local var_8_3 = var_0.UpdataAchLv(var_8_2, arg_5_0.selectedIds)
		local var_8_4 = arg_5_0
		local var_8_5 = var_1.emit

		IslandSelfCardMediator = var_2_10003

		var_8_5(var_8_4, var_2_10003.SET_CARD_ACHVS, var_8_3)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_5_6, var_5_7, var_5_8, var_1_10005)

	arg_5_0.cards = {}

	return
end

function var_0_1.OnInitItem(arg_9_0, arg_9_1)
	IslandCardAchvCard = var_1_10002

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
		var_10_0:Update(var_4, arg_10_0.selectedIds)
	end

	onButton = var_5

	local var_10_1 = arg_10_0
	local var_10_2 = var_10_0._go

	local function var_10_3()
		table = var_2_10000

		if not var_2_10000.contains(arg_10_0.selectedIds, var_0) and #arg_10_0.selectedIds == var_0_1.MAX_CNT then
			return
		end

		if var_0 then
			table = var_1

			var_1.removebyvalue(arg_10_0.selectedIds, var_0)
		else
			table = var_1

			var_1.insert(arg_10_0.selectedIds, var_0)
		end

		pairs = var_1

		for iter_11_0, iter_11_1 in var_1(arg_10_0.cards) do
			iter_11_1:UpdateSelected(arg_10_0.selectedIds)
		end

		local var_11_0 = arg_10_0

		var_1.UpdateTitle(var_11_0)

		return
	end

	SFX_PANEL = var_1_10009

	var_5(var_10_1, var_10_2, var_10_3, var_1_10009)

	return
end

function var_0_1.GetNewSelectedIds(arg_12_0, arg_12_1)
	local var_12_0 = {}

	return
end

function var_0_1.Show(arg_13_0, arg_13_1, arg_13_2)
	var_0_1.super.Show(arg_13_0)

	arg_13_0.ids = arg_13_1
	arg_13_0.selectedIds = arg_13_2

	local var_13_0 = arg_13_0.scrollRect

	var_3.SetTotalCount(var_13_0, #arg_13_0.ids, -1)

	setActive = var_3

	var_3(arg_13_0.emptyTF, #arg_13_0.ids == 0)
	arg_13_0:UpdateTitle()

	pg = var_3

	local var_13_1 = var_3.UIMgr.GetInstance()

	var_3.BlurPanel(var_13_1, arg_13_0._tf)

	return
end

function var_0_1.UpdateTitle(arg_14_0)
	local var_14_0 = arg_14_0.titleTxt

	i18n = var_1_10002
	var_14_0.text = var_1_10002("island_card_choose_achievement", #arg_14_0.selectedIds)

	return
end

function var_0_1.Hide(arg_15_0)
	var_0_1.super.Hide(arg_15_0)

	pg = var_1

	local var_15_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_15_0, arg_15_0._tf, arg_15_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_16_0)
	ClearLScrollrect = var_1_10001

	var_1_10001(arg_16_0.scrollRect)

	pairs = var_1_10001

	for iter_16_0, iter_16_1 in var_1_10001(arg_16_0.cards) do
		iter_16_1:Dispose()
	end

	arg_16_0.cards = {}
	pg = var_1

	local var_16_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_16_0, arg_16_0._tf, arg_16_0._parentTf)

	return
end

return var_0_1
