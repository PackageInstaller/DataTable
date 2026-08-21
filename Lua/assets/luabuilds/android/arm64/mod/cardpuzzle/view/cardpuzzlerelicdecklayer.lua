local var_0_0 = class("CardPuzzleRelicDeckLayer", BaseUI)

function var_0_0.getUIName(arg_1_0)
	return "CardTowerGiftDeckUI"
end

function var_0_0.isLayer(arg_2_0)
	return false
end

function var_0_0.init(arg_3_0)
	arg_3_0.giftListRect = arg_3_0._tf:Find("Container")
	arg_3_0.giftListComp = arg_3_0.giftListRect:GetComponent("LScrollRect")

	function arg_3_0.giftListComp.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = CardPuzzleRelicView.New((tf(arg_4_1)))

		var_4_0:SetData(arg_3_0.gifts[arg_4_0 + 1])
		var_4_0:UpdateView()
		onButton(arg_3_0, arg_4_1, function()
			arg_3_0:ShowRelicDetail(arg_4_0)

			return
		end, SFX_PANEL)
		TweenItemAlphaAndWhite(arg_4_1)

		return
	end

	return
end

function var_0_0.ShowRelicDetail(arg_6_0, arg_6_1)
	arg_6_0:emit(CardPuzzleRelicDeckMediator.SHOW_GIFT, {
		giftData = arg_6_0.gifts[arg_6_1 + 1]
	})

	return
end

function var_0_0.SetGifts(arg_7_0, arg_7_1)
	arg_7_0.gifts = arg_7_1

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0.giftListComp:SetTotalCount(#arg_8_0.gifts)

	return
end

function var_0_0.OnBackward(arg_9_0)
	arg_9_0:closeView()

	return true
end

function var_0_0.willExit(arg_10_0)
	pg.m02:sendNotification(CardTowerStageMediator.CARDTOWER_STAGE_REMOVE_SUBVIEW, arg_10_0._tf)

	return
end

return var_0_0
