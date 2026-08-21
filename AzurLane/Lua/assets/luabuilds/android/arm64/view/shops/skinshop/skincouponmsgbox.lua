local var_0_0 = class("SkinCouponMsgBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "SkinCouponMsgBoxUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("window/button_container/cancel")
	arg_2_0.confirmBtn = arg_2_0._tf:Find("window/button_container/confirm")
	arg_2_0.label1 = arg_2_0._tf:Find("window/frame/Text"):GetComponent(typeof(Text))
	arg_2_0.leftItemTr = arg_2_0._tf:Find("window/frame/left")
	arg_2_0.nameTxt = arg_2_0.leftItemTr:Find("name_bg/Text"):GetComponent(typeof(Text))

	setText(arg_2_0.cancelBtn:Find("pic"), i18n("msgbox_text_cancel"))
	setText(arg_2_0.confirmBtn:Find("pic"), i18n("msgbox_text_confirm"))
	setText(arg_2_0._tf:Find("window/top/bg/infomation/title"), i18n("words_information"))

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

	arg_7_0.settings = arg_7_1

	arg_7_0:UpdateItem(arg_7_1)
	arg_7_0:RegisterBtn(arg_7_1)
	arg_7_0:UpdateContent(arg_7_1)

	return
end

function var_0_0.RegisterBtn(arg_8_0, arg_8_1)
	onButton(arg_8_0, arg_8_0.confirmBtn, function()
		if arg_8_1.onYes then
			arg_8_1.onYes()
		end

		arg_8_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.UpdateContent(arg_10_0, arg_10_1)
	arg_10_0.label1.text = i18n("skin_purchase_confirm", arg_10_1.drop:getName(), arg_10_1.price, arg_10_1.skinName)

	setActive(arg_10_0.label1, false)
	setActive(arg_10_0.label1, true)

	arg_10_0.nameTxt.text = arg_10_1.drop:getName()

	return
end

function var_0_0.UpdateItem(arg_11_0, arg_11_1)
	updateDrop(arg_11_0.leftItemTr, arg_11_1.drop)

	return
end

function var_0_0.Hide(arg_12_0)
	arg_12_0.settings = nil

	var_0_0.super.Hide(arg_12_0)
	arg_12_0:Destroy()

	return
end

function var_0_0.OnDestroy(arg_13_0)
	return
end

return var_0_0
