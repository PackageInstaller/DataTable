local var_0_0 = class("AuctionGameCollectionInfoLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameCollectionInfoUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0.uiBgBtn
		}
	})
	setText(arg_2_0.uiCancelText, i18n("auction_cancel"))
	setText(arg_2_0.uiConfirmText, i18n("auction_confirm"))
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiBgBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiCancelBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiConfirmBtn, function()
		arg_2_0:closeView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0.auctionGameCollectionItem = AuctionGameCollectionItem.New(arg_7_0.uiItemTf, arg_7_0)

	arg_7_0.auctionGameCollectionItem:didEnter(arg_7_0.contextData.id)

	return
end

function var_0_0.willExit(arg_8_0)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)
	arg_8_0.auctionGameCollectionItem:willExit()

	arg_8_0.auctionGameCollectionItem = nil

	return
end

return var_0_0
