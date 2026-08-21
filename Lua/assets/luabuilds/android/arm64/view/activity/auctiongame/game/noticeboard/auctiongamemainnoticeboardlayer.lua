local var_0_0 = class("AuctionGameMainNoticeBoardLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "AuctionGameMainNoticeBoardUI"
end

function var_0_0.init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiCloseBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)
	onButton(arg_2_0, arg_2_0.uiBgBtn, function()
		arg_2_0:closeView()

		return
	end, SOUND_BACK)

	arg_2_0.boardItemList = {}

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:OverlayPanel(arg_5_0._tf, {
		pbList = {
			arg_5_0.uiBg
		}
	})

	local var_5_0 = getProxy(AuctionGameProxy):GetPlayerList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		arg_5_0.boardItemList[iter_5_0] = AuctionGameMainNoticeBoardPlayer.New(arg_5_0[string.format("uiPlayerTf%s", iter_5_0)], arg_5_0)

		arg_5_0.boardItemList[iter_5_0]:didEnter(iter_5_0)
	end

	for iter_5_2 = #var_5_0 + 1, 4 do
		setActive(arg_5_0[string.format("uiPlayerTf%s", iter_5_2)], false)
	end

	return
end

function var_0_0.willExit(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.boardItemList) do
		iter_6_1:willExit()
	end

	arg_6_0.boardItemList = nil

	arg_6_0:UnOverlayPanel(arg_6_0._tf)

	return
end

return var_0_0
