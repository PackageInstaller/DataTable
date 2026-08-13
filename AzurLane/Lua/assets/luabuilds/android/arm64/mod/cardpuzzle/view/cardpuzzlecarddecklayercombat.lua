class = var_0_10000

local var_0_0 = "CardTowerCardDeckLayerCombat"

CardPuzzleCardDeckLayer = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "CardTowerCardDeckCombat"
end

function var_0_1.init(arg_2_0)
	var_0_1.super.init(arg_2_0)

	local var_2_0 = arg_2_0._tf

	arg_2_0.labelCH = var_1.Find(var_2_0, "label/ch")

	local var_2_1 = arg_2_0._tf

	arg_2_0.labelEN = var_1.Find(var_2_1, "label/en")
	setText = var_1

	local var_2_2 = arg_2_0.labelEN

	i18n = var_4

	var_1(var_2_2, var_4("card_battle_card details"))

	local var_2_3 = arg_2_0._tf

	arg_2_0.switchToggle = var_1.Find(var_2_3, "switch_toggle/toggle")
	setText = var_1

	local var_2_4 = arg_2_0._tf
	local var_2_5 = var_3.Find(var_2_4, "switch_toggle/toggle/hand")

	i18n = var_4

	var_1(var_2_5, var_4("card_battle_card details_switchto_deck"))

	setText = var_1

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_3.Find(var_2_6, "switch_toggle/toggle/deck")

	i18n = var_4

	var_1(var_2_7, var_4("card_battle_card details_switchto_hand"))

	onToggle = var_1

	var_1(arg_2_0, arg_2_0.switchToggle, function(arg_3_0)
		if arg_3_0 then
			local var_3_0 = arg_2_0

			var_1.showHand(var_3_0)
		else
			local var_3_1 = arg_2_0

			var_1.showDeck(var_3_1)
		end

		return
	end)

	local var_2_8 = arg_2_0._tf

	arg_2_0.empty = var_1.Find(var_2_8, "empty")
	setText = var_1

	local var_2_9 = arg_2_0._tf
	local var_2_10 = var_3.Find(var_2_9, "empty/label_en")

	i18n = var_4

	var_1(var_2_10, var_4("card_battle_card_empty_en"))

	setText = var_1

	local var_2_11 = arg_2_0._tf
	local var_2_12 = var_3.Find(var_2_11, "empty/label_ch")

	i18n = var_4

	var_1(var_2_12, var_4("card_battle_card_empty_ch"))

	onButton = var_1

	local var_2_13 = arg_2_0
	local var_2_14 = arg_2_0._tf
	local var_2_15 = var_4.Find(var_2_14, "backBtn")

	local function var_2_16()
		local var_4_0 = arg_2_0

		var_0.OnBackward(var_4_0)

		return
	end

	SFX_PANEL = var_2_14

	var_1(var_2_13, var_2_15, var_2_16, var_2_14)

	return
end

function var_0_1.showHand(arg_5_0)
	setText = var_1_10001

	local var_5_0 = arg_5_0.labelCH

	i18n = var_1_10004

	var_1_10001(var_5_0, var_1_10004("card_battle_card details_hand"))

	arg_5_0.cards = arg_5_0.hand

	arg_5_0:RefreshCards()

	return
end

function var_0_1.showDeck(arg_6_0)
	setText = var_1_10001

	local var_6_0 = arg_6_0.labelCH

	i18n = var_1_10004

	var_1_10001(var_6_0, var_1_10004("card_battle_card details_deck"))

	arg_6_0.cards = arg_6_0.deck

	arg_6_0:RefreshCards()

	return
end

function var_0_1.didEnter(arg_7_0)
	triggerToggle = var_1_10001

	var_1_10001(arg_7_0.switchToggle, false)

	return
end

function var_0_1.SetCards(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.deck = arg_8_1
	arg_8_0.hand = arg_8_2

	return
end

function var_0_1.RefreshCards(arg_9_0)
	setActive = var_1_10001

	var_1_10001(arg_9_0.empty, #arg_9_0.cards == 0)

	local var_9_0 = arg_9_0.cardListComp

	var_1.SetTotalCount(var_9_0, #arg_9_0.cards)

	return
end

function var_0_1.OnBackward(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.emit

	CardPuzzleCardDeckMediator = var_1_10004

	var_10_1(var_10_0, var_1_10004.CLOSE_LAYER)

	return var_0_1.super.OnBackward(arg_10_0)
end

function var_0_1.willExit(arg_11_0)
	return
end

return var_0_1
