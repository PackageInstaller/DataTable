class = var_0_10000

local var_0_0 = "AuctionGameCollectionInfoLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameCollectionInfoUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:OverlayPanel(arg_2_0._tf, {
		pbList = {
			arg_2_0.uiBgBtn
		}
	})

	setText = var_1

	local var_2_0 = arg_2_0.uiCancelText

	i18n = var_3

	var_1(var_2_0, var_3("auction_cancel"))

	setText = var_1

	local var_2_1 = arg_2_0.uiConfirmText

	i18n = var_3

	var_1(var_2_1, var_3("auction_confirm"))

	onButton = var_1

	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.uiCloseBtn

	local function var_2_4()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_5

	var_1(var_2_2, var_2_3, var_2_4, var_5)

	onButton = var_1

	local var_2_5 = arg_2_0
	local var_2_6 = arg_2_0.uiBgBtn

	local function var_2_7()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SOUND_BACK = var_5

	var_1(var_2_5, var_2_6, var_2_7, var_5)

	onButton = var_1

	local var_2_8 = arg_2_0
	local var_2_9 = arg_2_0.uiCancelBtn

	local function var_2_10()
		local var_5_0 = arg_2_0

		var_0.closeView(var_5_0)

		return
	end

	SOUND_BACK = var_5

	var_1(var_2_8, var_2_9, var_2_10, var_5)

	onButton = var_1

	local var_2_11 = arg_2_0
	local var_2_12 = arg_2_0.uiConfirmBtn

	local function var_2_13()
		local var_6_0 = arg_2_0

		var_0.closeView(var_6_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_2_11, var_2_12, var_2_13, var_5)

	return
end

function var_0_1.didEnter(arg_7_0)
	AuctionGameCollectionItem = var_1_10001
	arg_7_0.auctionGameCollectionItem = var_1_10001.New(arg_7_0.uiItemTf, arg_7_0)

	local var_7_0 = arg_7_0.auctionGameCollectionItem

	var_1.didEnter(var_7_0, arg_7_0.contextData.id)

	return
end

function var_0_1.willExit(arg_8_0)
	arg_8_0:UnOverlayPanel(arg_8_0._tf)

	local var_8_0 = arg_8_0.auctionGameCollectionItem

	var_1.willExit(var_8_0)

	arg_8_0.auctionGameCollectionItem = nil

	return
end

return var_0_1
