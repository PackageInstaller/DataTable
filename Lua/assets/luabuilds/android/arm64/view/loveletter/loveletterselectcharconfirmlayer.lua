local var_0_0 = class("LoveLetterSelectCharConfirmLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "LoveLetterGroupSelectUI"
end

var_0_0.optionsPath = {}

function var_0_0.init(arg_2_0)
	setText(arg_2_0.btnCancel:Find("cancel"), i18n("text_cancel"))
	setText(arg_2_0.btnConfirm:Find("confirm"), i18n("text_confirm"))
	onButton(arg_2_0, arg_2_0.btnCancel, function()
		arg_2_0:closeView()

		return
	end, SFX_CANCEL)
	onButton(arg_2_0, arg_2_0.btnConfirm, function()
		arg_2_0:emit(LoveLetterSelectCharConfirmMediator.SELECT_CHAR, arg_2_0.ll.groupId)

		return
	end, SFX_CONFIRM)
	arg_2_0:BlurPanel(arg_2_0._tf)

	return
end

function var_0_0.SetLoveLetter(arg_5_0, arg_5_1)
	arg_5_0.ll = getProxy(LoveLetterProxy):GetGroupData(arg_5_1)

	return
end

function var_0_0.SetActivity(arg_6_0, arg_6_1)
	arg_6_0.activity = getProxy(ActivityProxy):getActivityById(arg_6_1)

	if arg_6_0.contextData.isRepair then
		setText(arg_6_0.textHelp, i18n("loveletter2018_ui_3"))
	else
		local var_6_0, var_6_1 = arg_6_0.activity:GetChangeCount()

		setText(arg_6_0.textHelp, i18n("loveactivity_ui_12", var_6_1 - var_6_0, var_6_1))
	end

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0:UpdateDisplay()

	return
end

function var_0_0.UpdateDisplay(arg_8_0)
	arg_8_0:UpdatePainting()

	if arg_8_0.contextData.isRepair then
		setText(arg_8_0.textInfo, i18n("loveletter2018_ui_2", arg_8_0.ll:GetName()))
	else
		setText(arg_8_0.textInfo, i18n("loveactivity_ui_11", setColorStr(arg_8_0.ll:GetName(), "#f3709e")))
	end

	return
end

function var_0_0.UpdatePainting(arg_9_0)
	local var_9_0 = arg_9_0.ll:GetPainting()

	if arg_9_0.paint == var_9_0 then
		return
	end

	if arg_9_0.paint then
		retPaintingPrefab(arg_9_0.rtPainting, arg_9_0.paint)

		arg_9_0.paint = nil
	end

	arg_9_0.paint = var_9_0

	setPaintingPrefabAsync(arg_9_0.rtPainting, arg_9_0.paint, "biandui")

	return
end

function var_0_0.willExit(arg_10_0)
	arg_10_0:UnOverlayPanel(arg_10_0._tf)

	if arg_10_0.paint then
		retPaintingPrefab(arg_10_0.rtPainting, arg_10_0.paint)

		arg_10_0.paint = nil
	end

	return
end

return var_0_0
