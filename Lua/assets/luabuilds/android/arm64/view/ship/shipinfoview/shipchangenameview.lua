local var_0_0 = class("ShipChangeNameView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "ShipChangeNameView"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0._renamePanel = arg_2_0._tf
	arg_2_0._renameConfirmBtn = arg_2_0._renamePanel:Find("frame/queren")
	arg_2_0._renameCancelBtn = arg_2_0._renamePanel:Find("frame/cancel")
	arg_2_0._renameRevert = arg_2_0._renamePanel:Find("frame/revert_button")
	arg_2_0._renameCloseBtn = arg_2_0._renamePanel:Find("frame/close_btn")

	setText(findTF(arg_2_0._tf, "frame/name_field/Placeholder"), i18n("rename_input"))
	onButton(arg_2_0, arg_2_0._renameConfirmBtn, function()
		arg_2_0:emit(ShipMainMediator.RENAME_SHIP, arg_2_0:GetShipVO().id, (getInputText(findTF(arg_2_0._renamePanel, "frame/name_field"))))

		return
	end, SFX_CONFIRM)
	onButton(arg_2_0, arg_2_0._renameRevert, function()
		if arg_2_0:GetShipVO():isRemoulded() then
			local var_4_0 = pg.ship_skin_template[arg_2_0:GetShipVO():getRemouldSkinId()].name or pg.ship_data_statistics[arg_2_0:GetShipVO().configId].name

			setInputText(findTF(arg_2_0._renamePanel, "frame/name_field"), var_4_0)

			return
		end
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._renameCloseBtn, function()
		arg_2_0:DisplayRenamePanel(false)

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._renameCancelBtn, function()
		arg_2_0:DisplayRenamePanel(false)

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.SetShareData(arg_7_0, arg_7_1)
	arg_7_0.shareData = arg_7_1

	return
end

function var_0_0.GetShipVO(arg_8_0)
	if arg_8_0.shareData and arg_8_0.shareData.shipVO then
		return arg_8_0.shareData.shipVO
	end

	return nil
end

function var_0_0.DisplayRenamePanel(arg_9_0, arg_9_1)
	arg_9_0.isOpenRenamePanel = arg_9_1

	SetActive(arg_9_0._renamePanel, arg_9_1)

	if arg_9_1 then
		pg.UIMgr.GetInstance():BlurPanel(arg_9_0._renamePanel)
		setInputText(findTF(arg_9_0._renamePanel, "frame/name_field"), (arg_9_0:GetShipVO():getName()))
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._renamePanel, arg_9_0._tf)
	end

	return
end

function var_0_0.OnDestroy(arg_10_0)
	arg_10_0.shareData = nil

	return
end

return var_0_0
