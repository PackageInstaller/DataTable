local var_0_0 = class("SelectSkinMsgbox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SelectSkinMsgboxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("window/button_container/cancel")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("window/button_container/confirm")
	arg_2_0.contentTxt = arg_2_0._tf:Find("window/frame/content"):GetComponent(typeof(Text))
	arg_2_0.leftItemTr = arg_2_0._tf:Find("window/frame/left")
	arg_2_0.rightItemTr = arg_2_0._tf:Find("window/frame/right")
	arg_2_0.leftNameTxt = arg_2_0.leftItemTr:Find("name_bg/Text"):GetComponent(typeof(Text))
	arg_2_0.rightNameTxt = arg_2_0.rightItemTr:Find("name_bg/Text"):GetComponent(typeof(Text))

	setText(arg_2_0.cancelBtn:Find("pic"), i18n("msgbox_text_cancel"))
	setText(arg_2_0.confirmBtn:Find("pic"), i18n("msgbox_text_confirm"))
	setText(arg_2_0._tf:Find("window/top/bg/infomation/title"), i18n("title_info"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("bg"), function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_7_0, arg_7_1)
	var_0_0.super.Show(arg_7_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	arg_7_0.contentTxt.text = arg_7_1.content

	updateDrop(arg_7_0.leftItemTr, arg_7_1.leftDrop)
	updateDrop(arg_7_0.rightItemTr, arg_7_1.rightDrop)

	arg_7_0.leftNameTxt.text = arg_7_1.leftDrop:getConfig("name")
	arg_7_0.rightNameTxt.text = arg_7_1.rightDrop:getConfig("name")

	onButton(arg_7_0, arg_7_0.confirmBtn, function()
		arg_7_0:Hide()

		if arg_7_1.onYes then
			arg_7_1.onYes()
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Hide(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)
	var_0_0.super.Hide(arg_9_0)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	if arg_10_0:isShowing() then
		arg_10_0:Hide()
	end

	return
end

return var_0_0
