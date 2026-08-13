class = var_0_10000

local var_0_0 = "AuctionGameMainRoundOverLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainRoundOverUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.boardItemList = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = arg_3_0

	arg_3_0.OverlayPanel(var_3_0, arg_3_0._tf, {
		pbList = {
			arg_3_0.uiBg
		}
	})

	getProxy = var_1
	AuctionGameProxy = var_3_0

	local var_3_1 = var_1(var_3_0)

	AuctionGameTools = var_3_0

	local var_3_2 = var_3_0.GetPlayerNoSortList(var_3_1:GetRound())

	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(var_3_2) do
		var_1_10008 = arg_3_0.boardItemList
		AuctionGameMainRoundOverPlayer = var_1_10009
		var_1_10009 = var_1_10009.New
		string = var_1_10010
		var_1_10008[iter_3_0] = var_1_10009(arg_3_0[var_1_10010.format("uiPlayerTf%s", iter_3_0)], arg_3_0)
		var_1_10009 = arg_3_0.boardItemList[iter_3_0]

		var_1_10008.didEnter(var_1_10009, iter_3_1.data)
	end

	for iter_3_2 = #var_3_2 + 1, 4 do
		setActive = iter_3_1
		string = var_1_10008

		iter_3_1(arg_3_0[var_1_10008.format("uiPlayerTf%s", iter_3_2)], false)
	end

	return
end

function var_0_1.willExit(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.boardItemList) do
		iter_4_1:willExit()
	end

	arg_4_0.boardItemList = nil

	arg_4_0:UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_1.onBackPressed(arg_5_0)
	return
end

return var_0_1
