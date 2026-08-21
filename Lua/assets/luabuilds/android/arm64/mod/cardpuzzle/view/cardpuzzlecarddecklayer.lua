local var_0_0 = class("CardPuzzleCardDeckLayer", BaseUI)

function var_0_0.getUIName(arg_1_0)
	return "CardTowerCardDeckUI"
end

function var_0_0.isLayer(arg_2_0)
	return false
end

function var_0_0.init(arg_3_0)
	arg_3_0.cardListRect = arg_3_0._tf:Find("Container")
	arg_3_0.cardListComp = arg_3_0.cardListRect:GetComponent("LScrollRect")

	function arg_3_0.cardListComp.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = CardPuzzleCardView.New((tf(arg_4_1):GetChild(0)))

		var_4_0:SetData(arg_3_0.cards[arg_4_0 + 1])
		var_4_0:UpdateView()
		onButton(arg_3_0, arg_4_1, function()
			arg_3_0:ShowCardDetail(arg_4_0)

			return
		end, SFX_PANEL)

		return
	end

	return
end

function var_0_0.ShowCardDetail(arg_6_0, arg_6_1)
	arg_6_0:emit(CardPuzzleCardDeckMediator.SHOW_CARD, {
		cardData = arg_6_0.cards[arg_6_1 + 1]
	})

	return
end

function var_0_0.SetCards(arg_7_0, arg_7_1)
	arg_7_0.cards = arg_7_1

	return
end

function var_0_0.didEnter(arg_8_0)
	arg_8_0:RefreshCards()

	return
end

function var_0_0.RefreshCards(arg_9_0)
	arg_9_0.cardListComp:SetTotalCount(#arg_9_0.cards)

	return
end

function var_0_0.OnBackward(arg_10_0)
	arg_10_0:closeView()

	return true
end

function var_0_0.willExit(arg_11_0)
	pg.m02:sendNotification(CardTowerStageMediator.CARDTOWER_STAGE_REMOVE_SUBVIEW, arg_11_0._tf)

	return
end

return var_0_0
