local var_0_0 = class("GameRoomCoinLayer", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "GameRoomCoinUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.totalCount = 0
	arg_2_0.curCount = 0
	arg_2_0.maxCoin = 0

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.ad = findTF(arg_3_0._tf, "ad")
	arg_3_0.window = findTF(arg_3_0._tf, "ad/window")
	arg_3_0.text = findTF(arg_3_0._tf, "ad/window/text")
	arg_3_0.window.anchoredPosition = Vector2(arg_3_0.contextData.position[1], arg_3_0.contextData.position[2])
	arg_3_0.maxCoin = arg_3_0.contextData.coin_max

	onButton(arg_3_0, findTF(arg_3_0.window, "add"), function()
		if arg_3_0.lockCount then
			return
		end

		arg_3_0.curCount = arg_3_0.curCount + 1

		arg_3_0:updateCount()

		return
	end)
	onButton(arg_3_0, findTF(arg_3_0.window, "sub"), function()
		if arg_3_0.lockCount then
			return
		end

		arg_3_0.curCount = arg_3_0.curCount - 1

		arg_3_0:updateCount()

		return
	end)

	local var_3_0 = getProxy(GameRoomProxy)

	if var_3_0:lastMonthlyTicket() == 0 or var_3_0:lastTicketMax() == 0 then
		arg_3_0.curCount = 0
		arg_3_0.lockCount = true
	else
		arg_3_0.curCount = 1
		arg_3_0.lockCount = false
	end

	arg_3_0:updateUI()

	return
end

function var_0_0.changeVisible(arg_6_0, arg_6_1)
	setActive(arg_6_0.window, arg_6_1)
	arg_6_0:updateUI()

	return
end

function var_0_0.updateUI(arg_7_0)
	arg_7_0:updateCoin()
	arg_7_0:updateCount()

	return
end

function var_0_0.updateCoin(arg_8_0)
	local var_8_0 = getProxy(GameRoomProxy):getCoin()

	var_8_0 = var_8_0 or 0
	arg_8_0.totalCount = var_8_0

	if arg_8_0.curCount > arg_8_0.totalCount then
		arg_8_0.curCount = 0
	end

	return
end

function var_0_0.updateCount(arg_9_0)
	if arg_9_0.curCount > arg_9_0.maxCoin then
		arg_9_0.curCount = arg_9_0.maxCoin
	end

	if arg_9_0.curCount > arg_9_0.totalCount then
		arg_9_0.curCount = arg_9_0.totalCount
	end

	if arg_9_0.curCount < 0 then
		arg_9_0.curCount = 0
	end

	setText(arg_9_0.text, arg_9_0.curCount .. "/" .. arg_9_0.totalCount)
	arg_9_0:emit(GameRoomCoinMediator.CHANGE_COIN_NUM, arg_9_0.curCount)

	return
end

function var_0_0.onBackPressed(arg_10_0)
	return
end

function var_0_0.willExit(arg_11_0)
	return
end

return var_0_0
