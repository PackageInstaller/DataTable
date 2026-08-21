local var_0_0 = class("AuctionGameMainMsgLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameMainMsgUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0.uiBgBtn
		}
	})
	setText(arg_2_0.uiCancelText, i18n("auction_cancel"))
	setText(arg_2_0.uiConfirmText, i18n("auction_confirm"))
	onButton(arg_2_0, arg_2_0.uiBgBtn, function()
		arg_2_0:OnCloseBtn()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:OnCloseBtn()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiCancelBtn, function()
		arg_2_0:OnCloseBtn()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiConfirmBtn, function()
		existCall(arg_2_0.contextData.comformCallback)
		arg_2_0:closeView()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_7_0)
	setText(arg_7_0.uiContentText, arg_7_0.contextData.content)

	return
end

function var_0_0.OnCloseBtn(arg_8_0)
	existCall(arg_8_0.contextData.cancelCallback)
	arg_8_0:closeView()

	return
end

function var_0_0.willExit(arg_9_0)
	arg_9_0:UnOverlayPanel(arg_9_0._tf)

	return
end

return var_0_0
