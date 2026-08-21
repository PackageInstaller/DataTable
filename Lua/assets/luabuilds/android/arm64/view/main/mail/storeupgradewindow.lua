local var_0_0 = class("StoreUpgradeWindow", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MailStoreExtendMsgboxUI"
end

function var_0_0.OnInit(arg_2_0)
	onButton(arg_2_0, arg_2_0._tf:Find("bg"), function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")

	onButton(arg_2_0, arg_2_0.closeBtn, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.btnDiamond = arg_2_0._tf:Find("window/button_container/btn_diamond")

	onButton(arg_2_0, arg_2_0.btnDiamond, function()
		arg_2_0:emit(MailMediator.ON_EXTEND_STORE, true)
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	arg_2_0.btnGold = arg_2_0._tf:Find("window/button_container/btn_gold")

	onButton(arg_2_0, arg_2_0.btnGold, function()
		arg_2_0:emit(MailMediator.ON_EXTEND_STORE, false)
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	setText(arg_2_0._tf:Find("window/top/bg/infomation/title"), i18n("mail_boxroom_extend_title"))
	setText(arg_2_0._tf:Find("window/frame/tip/Text"), i18n("mail_boxroom_extend_tips"))
	setText(arg_2_0.btnGold:Find("Text"), i18n("mail_buy_button"))
	setText(arg_2_0.btnDiamond:Find("Text"), i18n("mail_buy_button"))
	setText(arg_2_0._tf:Find("window/frame/price/Text"), i18n("mail_all_price"))

	return
end

function var_0_0.UpdateInfo(arg_7_0)
	local var_7_0 = arg_7_0._tf:Find("window/frame")
	local var_7_1 = getProxy(PlayerProxy):getRawData()
	local var_7_2, var_7_3 = var_7_1:GetExtendStoreCost()

	setText(var_7_0:Find("gold/before"), pg.mail_storeroom[var_7_1.mailStoreLevel].gold_store)
	setText(var_7_0:Find("gold/after"), pg.mail_storeroom[var_7_1.mailStoreLevel + 1].gold_store)
	setText(var_7_0:Find("oil/before"), pg.mail_storeroom[var_7_1.mailStoreLevel].oil_store)
	setText(var_7_0:Find("oil/after"), pg.mail_storeroom[var_7_1.mailStoreLevel + 1].oil_store)
	setText(var_7_0:Find("oil/name"), i18n("mail_oil_res"))
	setText(var_7_0:Find("gold/name"), i18n("mail_gold_res"))
	setActive(var_7_0:Find("price/price_diamond"), var_7_2)

	local var_7_5 = var_7_0:Find("price/price_diamond/Text")

	if var_7_2 then
		local var_7_6 = var_7_2.count or 0

		var_7_4(var_7_5, var_7_6)
		setActive(var_7_0:Find("price/price_gold"), var_7_3)

		local var_7_8 = var_7_0:Find("price/price_gold/Text")

		if var_7_3 then
			local var_7_9 = var_7_3.count or 0

			var_7_7(var_7_8, var_7_9)
			setActive(var_7_0:Find("price/line"), var_7_2 and var_7_3)
			setActive(arg_7_0.btnDiamond, var_7_2)
			setActive(arg_7_0.btnGold, var_7_3)

			return
		end
	end
end

function var_0_0.Show(arg_8_0)
	var_0_0.super.Show(arg_8_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)
	arg_8_0:UpdateInfo()

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
