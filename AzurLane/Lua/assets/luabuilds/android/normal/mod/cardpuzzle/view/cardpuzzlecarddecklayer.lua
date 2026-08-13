class = var_0_10000

local var_0_0 = "CardPuzzleCardDeckLayer"

BaseUI = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

function var_0_1.getUIName(arg_1_0)
	return "CardTowerCardDeckUI"
end

function var_0_1.isLayer(arg_2_0)
	return false
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.cardListRect = var_1.Find(var_3_0, "Container")

	local var_3_1 = arg_3_0.cardListRect

	arg_3_0.cardListComp = var_1.GetComponent(var_3_1, "LScrollRect")

	function arg_3_0.cardListComp.onUpdateItem(arg_4_0, arg_4_1)
		tf = var_2_10002

		local var_4_0 = var_2_10002(arg_4_1)
		local var_4_1 = var_2.GetChild(var_4_0, 0)

		CardPuzzleCardView = var_4_0

		local var_4_2 = var_4_0.New(var_4_1)

		var_3.SetData(var_4_2, arg_3_0.cards[arg_4_0 + 1])
		var_3:UpdateView()

		onButton = var_4

		local var_4_3 = arg_3_0
		local var_4_4 = arg_4_1

		local function var_4_5()
			local var_5_0 = arg_3_0

			var_0.ShowCardDetail(var_5_0, arg_4_0)

			return
		end

		SFX_PANEL = var_2_10008

		var_4(var_4_3, var_4_4, var_4_5, var_2_10008)

		return
	end

	return
end

function var_0_1.ShowCardDetail(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.emit

	CardPuzzleCardDeckMediator = var_1_10004

	var_6_1(var_6_0, var_1_10004.SHOW_CARD, {
		cardData = arg_6_0.cards[arg_6_1 + 1]
	})

	return
end

function var_0_1.SetCards(arg_7_0, arg_7_1)
	arg_7_0.cards = arg_7_1

	return
end

function var_0_1.didEnter(arg_8_0)
	arg_8_0:RefreshCards()

	return
end

function var_0_1.RefreshCards(arg_9_0)
	local var_9_0 = arg_9_0.cardListComp

	var_1.SetTotalCount(var_9_0, #arg_9_0.cards)

	return
end

function var_0_1.OnBackward(arg_10_0)
	arg_10_0:closeView()

	return true
end

function var_0_1.willExit(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.m02
	local var_11_1 = var_1.sendNotification

	CardTowerStageMediator = var_1_10003

	var_11_1(var_11_0, var_1_10003.CARDTOWER_STAGE_REMOVE_SUBVIEW, arg_11_0._tf)

	return
end

return var_0_1
