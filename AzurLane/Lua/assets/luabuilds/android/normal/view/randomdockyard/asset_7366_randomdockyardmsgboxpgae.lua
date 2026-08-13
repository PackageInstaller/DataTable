class = var_0_10000

local var_0_0 = "RandomDockYardMsgBoxPgae"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "RandomDockYardMsgBoxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_0, "frame/top/btnBack")

	local var_2_1 = arg_2_0._tf

	arg_2_0.cancelBtn = var_1.Find(var_2_1, "frame/cancel_button")

	local var_2_2 = arg_2_0._tf

	arg_2_0.confirmBtn = var_1.Find(var_2_2, "frame/confirm_button")

	local var_2_3 = arg_2_0._tf
	local var_2_4 = var_1.Find(var_2_3, "frame/sliders")

	arg_2_0.scrollrect = var_1.GetComponent(var_2_4, "LScrollRect")

	local var_2_5 = arg_2_0._tf
	local var_2_6 = var_1.Find(var_2_5, "frame/top/title_list/infomation/title")
	local var_2_7 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleTxt = var_2_7(var_2_6, var_3(var_1_10004))

	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_1.Find(var_2_8, "frame/top/title_list/infomation/title_en")
	local var_2_10 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.titleEnTxt = var_2_10(var_2_9, var_3(var_1_10004))

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_1.Find(var_2_11, "frame/label/Text")
	local var_2_13 = var_1.GetComponent

	typeof = var_3
	Text = var_1_10004
	arg_2_0.subTitleTxt = var_2_13(var_2_12, var_3(var_1_10004))
	setText = var_1

	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_2.Find(var_2_14, "frame/confirm_button/pic")

	i18n = var_2_14

	var_1(var_2_15, var_2_14("text_confirm"))

	setText = var_1

	local var_2_16 = arg_2_0._tf
	local var_2_17 = var_2.Find(var_2_16, "frame/cancel_button/pic")

	i18n = var_2_16

	var_1(var_2_17, var_2_16("text_cancel"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.closeBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0._tf

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10005)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.cancelBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10005)

	onButton = var_1_10001

	local var_3_9 = arg_3_0
	local var_3_10 = arg_3_0.confirmBtn

	local function var_3_11()
		if arg_3_0.callback then
			arg_3_0.callback()
		end

		local var_7_0 = arg_3_0

		var_0.Hide(var_7_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_3_9, var_3_10, var_3_11, var_1_10005)

	arg_3_0.cards = {}

	function arg_3_0.scrollrect.onUpdateItem(arg_8_0, arg_8_1)
		local var_8_0 = arg_3_0

		var_2.OnUpdateItem(var_8_0, arg_8_0, arg_8_1)

		return
	end

	function arg_3_0.scrollrect.onInitItem(arg_9_0)
		local var_9_0 = arg_3_0

		var_1.OnInitItem(var_9_0, arg_9_0)

		return
	end

	return
end

function var_0_1.OnInitItem(arg_10_0, arg_10_1)
	RandomDockYardCard = var_1_10002

	local var_10_0 = var_1_10002.New(arg_10_1)

	arg_10_0.cards[arg_10_1] = var_10_0

	return
end

function var_0_1.OnUpdateItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0

	if not arg_11_0.cards[arg_11_2] then
		var_1_10005 = arg_11_0

		arg_11_0.OnInitItem(var_1_10005, arg_11_2)

		var_11_0 = arg_11_0.cards[arg_11_2]
	end

	getProxy = var_1_10004
	BayProxy = var_1_10005

	local var_11_1 = var_1_10004(var_1_10005)
	local var_11_2 = var_4.RawGetShipById(var_11_1, arg_11_0.shipIds[arg_11_1 + 1])

	var_11_0:Update(var_11_2, false)

	return
end

function var_0_1.Flush(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_0:Show()
	arg_12_0:UpdateTitle(arg_12_1)
	arg_12_0:UpdateSubTitle(arg_12_2)
	arg_12_0:UpdateList(arg_12_3)

	arg_12_0.callback = arg_12_4

	return
end

function var_0_1.UpdateTitle(arg_13_0, arg_13_1)
	arg_13_0.titleTxt.text = arg_13_1.cn
	arg_13_0.titleEnTxt.text = arg_13_1.en

	return
end

function var_0_1.UpdateSubTitle(arg_14_0, arg_14_1)
	arg_14_0.subTitleTxt.text = arg_14_1

	return
end

function var_0_1.UpdateList(arg_15_0, arg_15_1)
	arg_15_0.shipIds = arg_15_1

	local var_15_0 = arg_15_0.scrollrect

	var_2.SetTotalCount(var_15_0, #arg_15_0.shipIds)

	return
end

function var_0_1.Show(arg_16_0)
	var_0_1.super.Show(arg_16_0)

	pg = var_1

	local var_16_0 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_16_0, arg_16_0._tf)

	return
end

function var_0_1.Hide(arg_17_0)
	arg_17_0.callback = nil
	arg_17_0.shipIds = nil
	pairs = var_1

	for iter_17_0, iter_17_1 in var_1(arg_17_0.cards) do
		iter_17_1:Dispose()
	end

	arg_17_0.cards = {}

	var_0_1.super.Hide(arg_17_0)

	pg = var_1

	local var_17_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_17_0, arg_17_0._tf, arg_17_0._parentTf)

	return
end

function var_0_1.OnDestroy(arg_18_0)
	arg_18_0:Hide()

	return
end

return var_0_1
