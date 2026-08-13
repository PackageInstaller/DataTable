class = var_0_10000

local var_0_0 = "AuctionGameMainNoticeBoardLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainNoticeBoardUI"
end

function var_0_1.init(arg_2_0)
	onButton = var_1_10001

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.uiCloseBtn

	local function var_2_2()
		local var_3_0 = arg_2_0

		var_0.closeView(var_3_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_0, var_2_1, var_2_2, var_1_10005)

	onButton = var_1_10001

	local var_2_3 = arg_2_0
	local var_2_4 = arg_2_0.uiBgBtn

	local function var_2_5()
		local var_4_0 = arg_2_0

		var_0.closeView(var_4_0)

		return
	end

	SOUND_BACK = var_1_10005

	var_1_10001(var_2_3, var_2_4, var_2_5, var_1_10005)

	arg_2_0.boardItemList = {}

	return
end

function var_0_1.didEnter(arg_5_0)
	local var_5_0 = arg_5_0

	arg_5_0.OverlayPanel(var_5_0, arg_5_0._tf, {
		pbList = {
			arg_5_0.uiBg
		}
	})

	getProxy = var_1
	AuctionGameProxy = var_5_0

	local var_5_1 = var_1(var_5_0)
	local var_5_2 = var_1.GetPlayerList(var_5_1)

	ipairs = var_5_1

	for iter_5_0, iter_5_1 in var_5_1(var_5_2) do
		var_1_10008 = arg_5_0.boardItemList
		AuctionGameMainNoticeBoardPlayer = var_1_10009
		var_1_10009 = var_1_10009.New
		string = var_1_10010
		var_1_10008[iter_5_0] = var_1_10009(arg_5_0[var_1_10010.format("uiPlayerTf%s", iter_5_0)], arg_5_0)
		var_1_10009 = arg_5_0.boardItemList[iter_5_0]

		var_1_10008.didEnter(var_1_10009, iter_5_0)
	end

	for iter_5_2 = #var_5_2 + 1, 4 do
		setActive = iter_5_1
		string = var_1_10008

		iter_5_1(arg_5_0[var_1_10008.format("uiPlayerTf%s", iter_5_2)], false)
	end

	return
end

function var_0_1.willExit(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.boardItemList) do
		iter_6_1:willExit()
	end

	arg_6_0.boardItemList = nil

	arg_6_0:UnOverlayPanel(arg_6_0._tf)

	return
end

return var_0_1
