class = var_0_10000

local var_0_0 = "CardPuzzleRelicDeckLayer"

BaseUI = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "CardTowerGiftDeckUI"
end

function var_0_1.isLayer(arg_2_0)
	return false
end

function var_0_1.init(arg_3_0)
	local var_3_0 = arg_3_0._tf

	arg_3_0.giftListRect = var_1.Find(var_3_0, "Container")

	local var_3_1 = arg_3_0.giftListRect

	arg_3_0.giftListComp = var_1.GetComponent(var_3_1, "LScrollRect")

	function arg_3_0.giftListComp.onUpdateItem(arg_4_0, arg_4_1)
		tf = var_2_10002

		local var_4_0 = var_2_10002(arg_4_1)

		CardPuzzleRelicView = var_2_10003

		local var_4_1 = var_2_10003.New(var_4_0)

		var_3.SetData(var_4_1, arg_3_0.gifts[arg_4_0 + 1])
		var_3:UpdateView()

		onButton = var_4

		local var_4_2 = arg_3_0
		local var_4_3 = arg_4_1

		local function var_4_4()
			local var_5_0 = arg_3_0

			var_0.ShowRelicDetail(var_5_0, arg_4_0)

			return
		end

		SFX_PANEL = var_2_10009

		var_4(var_4_2, var_4_3, var_4_4, var_2_10009)

		TweenItemAlphaAndWhite = var_4

		var_4(arg_4_1)

		return
	end

	return
end

function var_0_1.ShowRelicDetail(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.emit

	CardPuzzleRelicDeckMediator = var_1_10005

	var_6_1(var_6_0, var_1_10005.SHOW_GIFT, {
		giftData = arg_6_0.gifts[arg_6_1 + 1]
	})

	return
end

function var_0_1.SetGifts(arg_7_0, arg_7_1)
	arg_7_0.gifts = arg_7_1

	return
end

function var_0_1.didEnter(arg_8_0)
	local var_8_0 = arg_8_0.giftListComp

	var_1.SetTotalCount(var_8_0, #arg_8_0.gifts)

	return
end

function var_0_1.OnBackward(arg_9_0)
	arg_9_0:closeView()

	return true
end

function var_0_1.willExit(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.m02
	local var_10_1 = var_1.sendNotification

	CardTowerStageMediator = var_1_10004

	var_10_1(var_10_0, var_1_10004.CARDTOWER_STAGE_REMOVE_SUBVIEW, arg_10_0._tf)

	return
end

return var_0_1
