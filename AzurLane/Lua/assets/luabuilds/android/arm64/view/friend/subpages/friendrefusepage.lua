local var_0_0 = class("FriendRefusePage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "FriendRefuseUI"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.context = arg_3_0._tf:Find("window/frame/Text"):GetComponent(typeof(Text))
	arg_3_0.remind = arg_3_0._tf:Find("window/remind")
	arg_3_0.confirmBtn = arg_3_0._tf:Find("window/confirm_btn")
	arg_3_0.cancelBtn = arg_3_0._tf:Find("window/cancel_btn")
	arg_3_0.closeBtn = arg_3_0._tf:Find("window/top/btnBack")
	arg_3_0.checkLabel = arg_3_0.remind:Find("Text"):GetComponent(typeof(Text))

	onButton(nil, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(nil, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(nil, arg_3_0.closeBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	arg_3_0.isOn = false

	onToggle(nil, arg_3_0.remind, function(arg_7_0)
		arg_3_0.isOn = arg_7_0

		return
	end, SFX_PANEL)
	onButton(nil, arg_3_0.confirmBtn, function()
		if arg_3_0.func then
			arg_3_0.func(arg_3_0.isOn)
		end

		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Show(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	pg.UIMgr.GetInstance():BlurPanel(arg_9_0._tf)

	arg_9_0.func = arg_9_3
	arg_9_0.context.text = arg_9_1

	triggerToggle(arg_9_0.remind, false)
	setActive(arg_9_0._tf, true)

	arg_9_0.checkLabel.text = arg_9_2

	arg_9_0._tf:SetAsLastSibling()

	return
end

function var_0_0.Hide(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf, arg_10_0._parentTf)
	setActive(arg_10_0._tf, false)

	arg_10_0.func = nil
	arg_10_0.context.text = ""
	arg_10_0.checkLabel.text = ""

	return
end

function var_0_0.OnDestroy(arg_11_0)
	arg_11_0:Hide()
	removeOnButton(arg_11_0._tf)
	removeOnButton(arg_11_0.cancelBtn)

	return
end

return var_0_0
