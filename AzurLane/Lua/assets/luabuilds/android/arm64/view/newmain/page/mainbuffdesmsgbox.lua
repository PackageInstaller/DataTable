class = var_0_10000

local var_0_0 = "MainBuffDesMsgbox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MainBuffDescMsgboxUI"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.singleBuffMask = var_1.Find(var_2_0, "bg")

	local var_2_1 = arg_2_0._tf

	arg_2_0.singleSureBtn = var_1.Find(var_2_1, "window/top/btnBack")

	local var_2_2 = arg_2_0._tf

	arg_2_0.singleCloseBtn = var_1.Find(var_2_2, "window/sure_btn")

	local var_2_3 = arg_2_0._tf

	arg_2_0.singleDescContent = var_1.Find(var_2_3, "window/panel/intro_view/Viewport/Content")

	local var_2_4 = arg_2_0._tf

	arg_2_0.singleDescTpl = var_1.Find(var_2_4, "window/panel/intro_view/buff_desc_tpl")

	local var_2_5 = arg_2_0._tf

	arg_2_0.f2aPanel = var_1.Find(var_2_5, "window/panel/icon/f_to_a")

	local var_2_6 = arg_2_0._tf

	arg_2_0.sPanel = var_1.Find(var_2_6, "window/panel/icon/s_ss")

	local var_2_7 = arg_2_0._tf

	arg_2_0.sssPanel = var_1.Find(var_2_7, "window/panel/icon/sss")

	local var_2_8 = arg_2_0._tf

	arg_2_0.lvBarImages = var_1.Find(var_2_8, "bg/lv_bars")

	local var_2_9 = arg_2_0._tf

	arg_2_0.lvTagImages = var_1.Find(var_2_9, "bg/lv_tags")
	setText = var_1

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_3.Find(var_2_10, "window/top/bg/infomation/title")

	i18n = var_4

	var_1(var_2_11, var_4("words_information"))

	setText = var_1

	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_3.Find(var_2_12, "window/sure_btn/pic")

	i18n = var_4

	var_1(var_2_13, var_4("text_confirm"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.singleBuffMask

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.singleCloseBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	onButton = var_1_10001

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.singleSureBtn

	local function var_3_8()
		local var_6_0 = arg_3_0

		var_0.Hide(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_6, var_3_7, var_3_8, var_1_10006)

	return
end

function var_0_1.Show(arg_7_0, arg_7_1)
	var_0_1.super.Show(arg_7_0)

	pg = var_2

	local var_7_0 = var_2.UIMgr.GetInstance()

	var_2.OverlayPanel(var_7_0, arg_7_0._tf)

	getProxy = var_2
	ActivityProxy = var_7_0

	local var_7_1 = var_2(var_7_0)
	local var_7_2 = var_2.RawGetActivityById(var_7_1, arg_7_1)

	assert = var_1_10003

	var_1_10003(var_7_2, "activity should exist" .. arg_7_1)

	ActivityPtData = var_1_10003
	arg_7_0.ptData = var_1_10003.New(var_7_2)

	arg_7_0:UpdateLevelPanel()
	arg_7_0:UpdateContent()

	return
end

function var_0_1.UpdateContent(arg_8_0)
	local var_8_0 = arg_8_0.ptData
	local var_8_1 = var_1.GetCurBuffInfos(var_8_0)

	ipairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(var_8_1 or {}) do
		local var_8_2

		if iter_8_0 <= arg_8_0.singleDescContent.childCount then
			local var_8_3 = arg_8_0.singleDescContent

			var_8_2 = var_8.GetChild(var_8_3, iter_8_0 - 1)
		else
			cloneTplTo = var_8
			var_8_2 = var_8(arg_8_0.singleDescTpl, arg_8_0.singleDescContent)
		end

		setText = var_8

		local var_8_4 = var_8_2

		pg = var_1_10011
		var_1_10011 = var_1_10011.benefit_buff_template[iter_8_1.id].name
		pg = var_12

		var_8(var_8_4, var_1_10011 .. var_12.benefit_buff_template[iter_8_1.id].desc)
	end

	return
end

function var_0_1.UpdateLevelPanel(arg_9_0)
	local var_9_0 = arg_9_0.ptData
	local var_9_1, var_9_2 = var_1.GetBuffLevelProgress(var_9_0)

	arg_9_0.curPanel = nil

	if var_9_1 == 9 then
		arg_9_0.curPanel = arg_9_0.sssPanel
	elseif 6 < var_9_1 then
		arg_9_0.curPanel = arg_9_0.sPanel
	else
		arg_9_0.curPanel = arg_9_0.f2aPanel
	end

	setActive = var_3

	var_3(arg_9_0.f2aPanel, arg_9_0.curPanel == arg_9_0.f2aPanel)

	setActive = var_3

	var_3(arg_9_0.sPanel, arg_9_0.curPanel == arg_9_0.sPanel)

	setActive = var_3

	var_3(arg_9_0.sssPanel, arg_9_0.curPanel == arg_9_0.sssPanel)

	setImageSprite = var_3

	local var_9_3 = arg_9_0.curPanel
	local var_9_4 = var_5.Find(var_9_3, "bar")
	local var_9_5 = arg_9_0.lvBarImages
	local var_9_6 = var_6.Find(var_9_5, var_9_1)
	local var_9_7 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_3(var_9_4, var_9_7(var_9_6, var_9(var_1_10011)).sprite)

	setImageSprite = var_3

	local var_9_8 = arg_9_0.curPanel
	local var_9_9 = var_5.Find(var_9_8, "lv_tag")
	local var_9_10 = arg_9_0.lvTagImages
	local var_9_11 = var_6.Find(var_9_10, var_9_1)
	local var_9_12 = var_6.GetComponent

	typeof = var_9
	Image = var_1_10011

	var_3(var_9_9, var_9_12(var_9_11, var_9(var_1_10011)).sprite, true)

	setSlider = var_3

	var_3(arg_9_0.curPanel, 0, 1, var_9_2)

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	pg = var_1

	local var_10_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	return
end

return var_0_1
