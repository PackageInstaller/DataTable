local var_0_0 = class("CardPuzzleRelicDetailLayer", BaseUI)

function var_0_0.getUIName(arg_1_0)
	return "CardTowerGiftDetailUI"
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf:Find("BG"), function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	setImageSprite(arg_3_0._tf:Find("Gift/Icon"), LoadSprite(arg_3_0.contextData.giftData:GetIconPath(), ""))
	setText(arg_3_0._tf:Find("Gift/Name"), arg_3_0.contextData.giftData:GetName())
	setText(arg_3_0._tf:Find("Gift/Desc"), arg_3_0.contextData.giftData:GetDesc())
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.willExit(arg_5_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_5_0._tf)

	return
end

return var_0_0
