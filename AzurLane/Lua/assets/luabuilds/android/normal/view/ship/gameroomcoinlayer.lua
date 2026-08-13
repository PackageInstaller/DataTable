class = var_0_10000

local var_0_0 = "GameRoomCoinLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "GameRoomCoinUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0.totalCount = 0
	arg_2_0.curCount = 0
	arg_2_0.maxCoin = 0

	return
end

function var_0_1.didEnter(arg_3_0)
	findTF = var_1_10001
	arg_3_0.ad = var_1_10001(arg_3_0._tf, "ad")
	findTF = var_1
	arg_3_0.window = var_1(arg_3_0._tf, "ad/window")
	findTF = var_1
	arg_3_0.text = var_1(arg_3_0._tf, "ad/window/text")

	local var_3_0 = arg_3_0.contextData.position
	local var_3_1 = arg_3_0.window

	Vector2 = var_3
	var_3_1.anchoredPosition = var_3(var_3_0[1], var_3_0[2])
	arg_3_0.maxCoin = arg_3_0.contextData.coin_max
	onButton = var_2

	local var_3_2 = arg_3_0

	findTF = var_4

	var_2(var_3_2, var_4(arg_3_0.window, "add"), function()
		if arg_3_0.lockCount then
			return
		end

		arg_3_0.curCount = arg_3_0.curCount + 1

		local var_4_0 = arg_3_0

		var_0.updateCount(var_4_0)

		return
	end)

	onButton = var_2

	local var_3_3 = arg_3_0

	findTF = var_4

	var_2(var_3_3, var_4(arg_3_0.window, "sub"), function()
		if arg_3_0.lockCount then
			return
		end

		arg_3_0.curCount = arg_3_0.curCount - 1

		local var_5_0 = arg_3_0

		var_0.updateCount(var_5_0)

		return
	end)

	getProxy = var_2
	GameRoomProxy = var_3_3

	local var_3_4 = var_2(var_3_3)

	if var_2.lastMonthlyTicket(var_3_4) == 0 or var_2:lastTicketMax() == 0 then
		arg_3_0.curCount = 0
		arg_3_0.lockCount = true
	else
		arg_3_0.curCount = 1
		arg_3_0.lockCount = false
	end

	arg_3_0:updateUI()

	return
end

function var_0_1.changeVisible(arg_6_0, arg_6_1)
	setActive = var_1_10002

	var_1_10002(arg_6_0.window, arg_6_1)
	arg_6_0:updateUI()

	return
end

function var_0_1.updateUI(arg_7_0)
	arg_7_0:updateCoin()
	arg_7_0:updateCount()

	return
end

function var_0_1.updateCoin(arg_8_0)
	getProxy = var_1_10001
	GameRoomProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1

	if not var_1.getCoin(var_8_0) then
		var_8_1 = 0
	end

	arg_8_0.totalCount = var_8_1

	if arg_8_0.curCount > arg_8_0.totalCount then
		arg_8_0.curCount = 0
	end

	return
end

function var_0_1.updateCount(arg_9_0)
	if arg_9_0.curCount > arg_9_0.maxCoin then
		arg_9_0.curCount = arg_9_0.maxCoin
	end

	if arg_9_0.curCount > arg_9_0.totalCount then
		arg_9_0.curCount = arg_9_0.totalCount
	end

	if arg_9_0.curCount < 0 then
		arg_9_0.curCount = 0
	end

	setText = var_1

	var_1(arg_9_0.text, arg_9_0.curCount .. "/" .. arg_9_0.totalCount)

	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.emit

	GameRoomCoinMediator = var_3

	var_9_1(var_9_0, var_3.CHANGE_COIN_NUM, arg_9_0.curCount)

	return
end

function var_0_1.onBackPressed(arg_10_0)
	return
end

function var_0_1.willExit(arg_11_0)
	return
end

return var_0_1
