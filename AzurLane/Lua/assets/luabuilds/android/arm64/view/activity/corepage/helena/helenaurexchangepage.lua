local var_0_0 = class("HelenaUrExchangePage", import("view.activity.CorePage.CoreURExchangeTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0._btnExchange = arg_1_0._tf:Find("AD/btn_exchange_on")
	arg_1_0._btnExchange_off = arg_1_0._tf:Find("AD/btn_exchange_off")
	arg_1_0._msgBoxBtnCancel = arg_1_0._msgBox:Find("msg_box/btn_cancel")
	arg_1_0._msgBoxBtnConfirm = arg_1_0._msgBox:Find("msg_box/btn_confirm")
	arg_1_0._msgBoxLabel = arg_1_0._msgBox:Find("msg_box/label/text_cn")
	arg_1_0._msgBoxItem = arg_1_0._msgBox:Find("msg_box/item/IconTpl")
	arg_1_0._msgBoxItemName = arg_1_0._msgBox:Find("msg_box/item/name")
	arg_1_0._msgBoxItemDesc = arg_1_0._msgBox:Find("msg_box/item/desc")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	onButton(arg_2_0, arg_2_0._btnExchange, function()
		local var_3_0 = Drop.Create({
			arg_2_0.curGoods.commodity_type,
			arg_2_0.curGoods.commodity_id,
			1
		})

		updateDrop(arg_2_0._msgBoxItem, var_3_0)
		setText(arg_2_0._msgBoxItemName, var_3_0:getName())
		setText(arg_2_0._msgBoxItemDesc, var_3_0.desc)
		pg.UIMgr.GetInstance():BlurPanel(arg_2_0._msgBox)
		setActive(arg_2_0._msgBox, true)

		arg_2_0.isMsgBoxShow = true

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0._btnExchange_off, function()
		setActive(arg_2_0._ptTip, true)

		arg_2_0.leantween = LeanTween.delayedCall(1, System.Action(function()
			setActive(arg_2_0._ptTip, false)

			return
		end)).uniqueId

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	arg_6_0:UpdateExchangeStatus()
	arg_6_0.uilist:align(#arg_6_0.taskConfig)
	arg_6_0:UpdatePtCount()
	setActive(arg_6_0._btnExchange:Find("red"), arg_6_0.canExchange)
	setActive(arg_6_0._btnExchange, arg_6_0.canExchange)
	setActive(arg_6_0._btnExchange_off, not arg_6_0.canExchange)

	return
end

return var_0_0
