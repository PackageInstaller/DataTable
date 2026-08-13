class = var_0_10000

local var_0_0 = "IslandBookAwardListBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "IslandBookAwardListBox"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_1.Find(var_2_0, "title")
	local var_2_2 = var_1.GetComponent

	typeof = var_4
	Text = var_1_10006
	arg_2_0.titleTxt = var_2_2(var_2_1, var_4(var_1_10006))

	local var_2_3 = arg_2_0.titleTxt

	i18n = var_1_10002
	var_2_3.text = var_1_10002("island_book_award_title")

	local var_2_4 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_4, "close")
	setActive = var_1

	local var_2_5 = arg_2_0._tf

	var_1(var_3.Find(var_2_5, "tpl"), false)

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_1.Find(var_2_6, "scrollrect")

	arg_2_0.scrollRect = var_1.GetComponent(var_2_7, "LScrollRect")

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

	return
end

function var_0_1.OnInitItem(arg_7_0, arg_7_1)
	return
end

function var_0_1.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.ids[arg_8_1 + 1]
	local var_8_1 = arg_8_2.transform

	pg = var_1_10005

	local var_8_2 = var_1_10005.island_collection_reward[var_8_0]

	Drop = var_1_10006

	local var_8_3 = var_1_10006.Create(var_8_2.award_display)

	updateCustomDrop = var_1_10007

	var_1_10007(var_8_1:Find("drop"), var_8_3, {
		style = "island"
	})

	onButton = var_1_10007

	var_1_10007(arg_8_0, var_8_1, function()
		local var_9_0 = arg_8_0.contextData
		local var_9_1 = var_0.ShowMsgBox
		local var_9_2 = {}

		i18n = var_2_10004
		var_9_2.title = var_2_10004("island_word_desc")
		IslandMsgBox = var_4
		var_9_2.type = var_4.TYPE_COMMON_DROP_DESCRIBE
		var_9_2.dropData = var_8_3

		var_9_1(var_9_0, var_9_2)

		return
	end)

	setText = var_1_10007

	local var_8_4 = var_8_1:Find("level")

	string = var_10

	var_1_10007(var_8_4, var_10.format("%02d", var_8_2.level))

	setText = var_1_10007

	var_1_10007(var_8_1:Find("desc"), var_8_2.describe)

	table = var_1_10007

	local var_8_5 = var_1_10007.contains(arg_8_0.gotIds, var_8_0)

	setActive = var_8

	var_8(var_8_1:Find("drop/got"), var_8_5)

	setGray = var_8

	var_8(var_8_1, not var_8_5, true)

	return
end

function var_0_1.Show(arg_10_0)
	var_0_1.super.Show(arg_10_0)

	getProxy = var_1
	IslandProxy = var_3

	local var_10_0 = var_1(var_3)
	local var_10_1 = var_1.GetIsland(var_10_0)
	local var_10_2 = var_1.GetBookAgency(var_10_1)

	arg_10_0.ids = var_1.GetPointAwardIds(var_10_2, arg_10_0.contextData.type)
	arg_10_0.gotIds = var_1:GetPointAwardGotIds(arg_10_0.contextData.type)

	local var_10_3 = arg_10_0.scrollRect

	var_2.SetTotalCount(var_10_3, #arg_10_0.ids, -1)

	pg = var_2

	local var_10_4 = var_2.UIMgr.GetInstance()

	var_2.BlurPanel(var_10_4, arg_10_0._tf)

	return
end

function var_0_1.Hide(arg_11_0)
	var_0_1.super.Hide(arg_11_0)

	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_11_0, arg_11_0._tf, arg_11_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:Hide()

	ClearLScrollrect = var_1

	var_1(arg_12_0.scrollRect)

	return
end

return var_0_1
