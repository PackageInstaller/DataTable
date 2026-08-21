local var_0_0 = class("Dorm3dFurnitureConfirmWindow", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dFurnitureConfirmWindow"
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("Window/Confirm"), function()
		arg_3_0:closeView()
		existCall(arg_3_0.contextData.onYes)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf:Find("Window/Cancel"), function()
		arg_3_0:closeView()
		existCall(arg_3_0.contextData.onNo)

		return
	end, SFX_CANCEL)
	onButton(arg_3_0, arg_3_0._tf:Find("Mask"), function()
		arg_3_0:closeView()
		existCall(arg_3_0.contextData.onClose)

		return
	end)
	onButton(arg_3_0, arg_3_0._tf:Find("Window/Close"), function()
		arg_3_0:closeView()
		existCall(arg_3_0.contextData.onClose)

		return
	end, SFX_CANCEL)
	setText(arg_3_0._tf:Find("Window/Title"), arg_3_0.contextData.title)
	setText(arg_3_0._tf:Find("Window/Content"), arg_3_0.contextData.content)
	setText(arg_3_0._tf:Find("Window/Confirm/Text"), i18n("msgbox_text_confirm"))
	setText(arg_3_0._tf:Find("Window/Cancel/Text"), i18n("msgbox_text_cancel"))

	return
end

function var_0_0.willExit(arg_8_0)
	return
end

return var_0_0
