local var_0_0 = class("MainBuffDesMsgbox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MainBuffDescMsgboxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.singleBuffMask = arg_2_0._tf:Find("bg")
	arg_2_0.singleSureBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.singleCloseBtn = arg_2_0._tf:Find("window/sure_btn")
	arg_2_0.singleDescContent = arg_2_0._tf:Find("window/panel/intro_view/Viewport/Content")
	arg_2_0.singleDescTpl = arg_2_0._tf:Find("window/panel/intro_view/buff_desc_tpl")
	arg_2_0.f2aPanel = arg_2_0._tf:Find("window/panel/icon/f_to_a")
	arg_2_0.sPanel = arg_2_0._tf:Find("window/panel/icon/s_ss")
	arg_2_0.sssPanel = arg_2_0._tf:Find("window/panel/icon/sss")
	arg_2_0.lvBarImages = arg_2_0._tf:Find("bg/lv_bars")
	arg_2_0.lvTagImages = arg_2_0._tf:Find("bg/lv_tags")

	setText(arg_2_0._tf:Find("window/top/bg/infomation/title"), i18n("words_information"))
	setText(arg_2_0._tf:Find("window/sure_btn/pic"), i18n("text_confirm"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.singleBuffMask, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.singleCloseBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.singleSureBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)
	pg.UIMgr.GetInstance():OverlayPanel(arg_7_0._tf)

	local var_7_0 = getProxy(ActivityProxy):RawGetActivityById(arg_7_1)

	assert(var_7_0, "activity should exist" .. arg_7_1)

	arg_7_0.ptData = ActivityPtData.New(var_7_0)

	arg_7_0:UpdateLevelPanel()
	arg_7_0:UpdateContent()

	return
end

function var_0_0.UpdateContent(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.ptData:GetCurBuffInfos() or {}) do
		local var_8_0 = iter_8_0 <= arg_8_0.singleDescContent.childCount and arg_8_0.singleDescContent:GetChild(iter_8_0 - 1) or cloneTplTo(arg_8_0.singleDescTpl, arg_8_0.singleDescContent)

		setText(var_8_0, pg.benefit_buff_template[iter_8_1.id].name .. pg.benefit_buff_template[iter_8_1.id].desc)
	end

	return
end

function var_0_0.UpdateLevelPanel(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0.ptData:GetBuffLevelProgress()

	arg_9_0.curPanel = nil
	arg_9_0.curPanel = var_9_0 == 9 and arg_9_0.sssPanel or var_9_0 > 6 and arg_9_0.sPanel or arg_9_0.f2aPanel

	setActive(arg_9_0.f2aPanel, arg_9_0.curPanel == arg_9_0.f2aPanel)
	setActive(arg_9_0.sPanel, arg_9_0.curPanel == arg_9_0.sPanel)
	setActive(arg_9_0.sssPanel, arg_9_0.curPanel == arg_9_0.sssPanel)
	setImageSprite(arg_9_0.curPanel:Find("bar"), arg_9_0.lvBarImages:Find(var_9_0):GetComponent(typeof(Image)).sprite)
	setImageSprite(arg_9_0.curPanel:Find("lv_tag"), arg_9_0.lvTagImages:Find(var_9_0):GetComponent(typeof(Image)).sprite, true)
	setSlider(arg_9_0.curPanel, 0, 1, var_9_1)

	return
end

function var_0_0.Hide(arg_10_0)
	var_0_0.super.Hide(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)

	return
end

return var_0_0
