local var_0_0 = class("AuctionGameMainRoundOverLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameMainRoundOverUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.boardItemList = {}

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0:OverlayPanel(arg_3_0._tf, {
		pbList = {
			arg_3_0.uiBg
		}
	})

	local var_3_0 = AuctionGameTools.GetPlayerNoSortList(getProxy(AuctionGameProxy):GetRound())

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		arg_3_0.boardItemList[iter_3_0] = AuctionGameMainRoundOverPlayer.New(arg_3_0[string.format("uiPlayerTf%s", iter_3_0)], arg_3_0)

		arg_3_0.boardItemList[iter_3_0]:didEnter(iter_3_1.data)
	end

	for iter_3_2 = #var_3_0 + 1, 4 do
		setActive(arg_3_0[string.format("uiPlayerTf%s", iter_3_2)], false)
	end

	return
end

function var_0_0.willExit(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.boardItemList) do
		iter_4_1:willExit()
	end

	arg_4_0.boardItemList = nil

	arg_4_0:UnOverlayPanel(arg_4_0._tf)

	return
end

function var_0_0.onBackPressed(arg_5_0)
	return
end

return var_0_0
