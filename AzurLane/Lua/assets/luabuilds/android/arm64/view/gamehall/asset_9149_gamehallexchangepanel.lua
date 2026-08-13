class = var_0_10000

local var_0_0 = var_0_10000("GameHallExchangePanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._parentTf = arg_1_2
	arg_1_0._event = arg_1_3
	pg = var_1_10004

	local var_1_0 = var_1_10004.player_resource

	GameRoomProxy = var_1_10005

	local var_1_1 = var_1_0[var_1_10005.coin_res_id].itemid

	Item = var_5
	arg_1_0.itemCfg = var_5.getConfigData(var_1_1)
	pg = var_5
	arg_1_0.coinMax = var_5.gameset.game_coin_max.key_value
	pg = var_5
	arg_1_0.gameCoinGold = var_5.gameset.game_coin_gold.description
	findTF = var_5

	local var_1_2

	var_1_2, updateDrop = var_5(arg_1_0._tf, "window/single_item_panel/iconPos/icon"), var_1_10006

	local var_1_3 = {
		id = var_1_1
	}

	DROP_TYPE_ITEM = var_1_10010
	var_1_3.type = var_1_10010

	var_1_10006(var_1_2, var_1_3)

	setText = var_1_10006
	findTF = var_1_2

	var_1_10006(var_1_2(arg_1_0._tf, "window/single_item_panel/name_mode/name_mask/name"), arg_1_0.itemCfg.name)

	setText = var_1_10006
	findTF = var_8

	local var_1_4 = var_8(arg_1_0._tf, "window/single_item_panel/own/label")

	i18n = var_9

	var_1_10006(var_1_4, var_9("word_own1"))

	onButton = var_1_10006

	local var_1_5 = arg_1_0._event

	findTF = var_9

	var_1_10006(var_1_5, var_9(arg_1_0._tf, "bg"), function()
		local var_2_0 = arg_1_0

		var_0.setVisible(var_2_0, false)

		return
	end)

	onButton = var_1_10006

	local var_1_6 = arg_1_0._event

	findTF = var_9

	var_1_10006(var_1_6, var_9(arg_1_0._tf, "top/btnBack"), function()
		local var_3_0 = arg_1_0

		var_0.setVisible(var_3_0, false)

		return
	end)

	onButton = var_1_10006

	local var_1_7 = arg_1_0._event

	findTF = var_9

	var_1_10006(var_1_7, var_9(arg_1_0._tf, "window/btnCancel"), function()
		local var_4_0 = arg_1_0

		var_0.setVisible(var_4_0, false)

		return
	end)

	onButton = var_1_10006

	local var_1_8 = arg_1_0._event

	findTF = var_9

	var_1_10006(var_1_8, var_9(arg_1_0._tf, "window/btnConfirm"), function()
		local var_5_0 = arg_1_0.costPrice

		if arg_1_0.myGold < var_5_0 then
			pg = var_1

			local var_5_1 = var_1.TipsMgr.GetInstance()
			local var_5_2 = var_1.ShowTips

			i18n = var_2_10004

			var_5_2(var_5_1, var_2_10004("ship_remould_no_gold"))
		else
			local var_5_3 = arg_1_0

			var_1.exchangeCoin(var_5_3)

			local var_5_4 = arg_1_0

			var_1.setVisible(var_5_4, false)
		end

		return
	end)

	findTF = var_1_10006
	arg_1_0.disCount = var_1_10006(arg_1_0._tf, "window/discount")
	findTF = var_6
	arg_1_0.disCountText = var_6(arg_1_0._tf, "window/discount/Text")
	onButton = var_6

	local var_1_9 = arg_1_0._event

	findTF = var_9

	var_6(var_1_9, var_9(arg_1_0._tf, "window/count_select/value_bg/left"), function()
		arg_1_0.coinCount = arg_1_0.coinCount - 1

		local var_6_0 = arg_1_0

		var_0.coinCountChange(var_6_0)

		return
	end)

	onButton = var_6

	local var_1_10 = arg_1_0._event

	findTF = var_9

	var_6(var_1_10, var_9(arg_1_0._tf, "window/count_select/value_bg/right"), function()
		arg_1_0.coinCount = arg_1_0.coinCount + 1

		local var_7_0 = arg_1_0

		var_0.coinCountChange(var_7_0)

		return
	end)

	onButton = var_6

	local var_1_11 = arg_1_0._event

	findTF = var_9

	var_6(var_1_11, var_9(arg_1_0._tf, "window/count_select/max"), function()
		arg_1_0.coinCount = arg_1_0.coinMax - arg_1_0.myCoinCount

		local var_8_0 = arg_1_0

		var_0.coinCountChange(var_8_0)

		return
	end)

	setText = var_6
	findTF = var_1_11

	local var_1_12 = var_1_11(arg_1_0._tf, "window/btnConfirm/pic")

	i18n = var_9

	var_6(var_1_12, var_9("word_ok"))

	setText = var_6
	findTF = var_1_12

	local var_1_13 = var_1_12(arg_1_0._tf, "window/btnCancel/pic")

	i18n = var_9

	var_6(var_1_13, var_9("word_cancel"))

	setText = var_6
	findTF = var_1_13

	local var_1_14 = var_1_13(arg_1_0._tf, "top/bg/infomation/title")

	i18n = var_9

	var_6(var_1_14, var_9("title_info"))

	setActive = var_6
	findTF = var_1_14

	local var_1_15 = var_1_14(arg_1_0._tf, "top/bg/infomation/title_en")

	PLATFORM_CODE = var_9
	PLATFORM_US = var_10

	var_6(var_1_15, var_9 ~= var_10)

	return
end

function var_0_0.exchangeCoin(arg_9_0)
	if arg_9_0.coinCount == 0 then
		return
	end

	local var_9_0 = arg_9_0._event
	local var_9_1 = var_1.emit

	GameHallMediator = var_1_10004

	var_9_1(var_9_0, var_1_10004.EXCHANGE_COIN, {
		price = arg_9_0.costPrice,
		times = arg_9_0.coinCount
	})

	return
end

function var_0_0.coinCountChange(arg_10_0)
	if arg_10_0.coinCount < 0 then
		arg_10_0.coinCount = 0
	end

	if arg_10_0.coinCount + arg_10_0.myCoinCount > arg_10_0.coinMax then
		arg_10_0.coinCount = arg_10_0.coinMax - arg_10_0.myCoinCount
	end

	local var_10_0 = 0

	for iter_10_0 = 1, arg_10_0.coinCount do
		var_1_10006 = arg_10_0.payCoinCount + iter_10_0
		var_10_0 = var_10_0 + arg_10_0:getPriceByCount(var_1_10006)
	end

	arg_10_0.costPrice = var_10_0

	local var_10_1

	if var_10_0 < arg_10_0.myGold then
		COLOR_GREEN = var_10_1
	else
		COLOR_RED = var_10_1
	end

	setText = var_3
	findTF = iter_10_0

	local var_10_2 = iter_10_0(arg_10_0._tf, "window/count_select/desc_txt")

	i18n = var_1_10006

	var_3(var_10_2, var_1_10006("charge_game_room_coin_tip", var_10_0, arg_10_0.coinCount, var_10_1, arg_10_0.itemCfg.name))

	setText = var_3
	findTF = var_10_2

	var_3(var_10_2(arg_10_0._tf, "window/count_select/value_bg/value"), arg_10_0.coinCount)

	local var_10_3 = arg_10_0:getDiscount(arg_10_0.coinCount + arg_10_0.payCoinCount)

	setActive = var_4

	var_4(arg_10_0.disCount, var_10_3 ~= 0)

	setText = var_4

	var_4(arg_10_0.disCountText, var_10_3 .. "%OFF")

	return
end

function var_0_0.getDiscount(arg_11_0, arg_11_1)
	if arg_11_1 <= 0 then
		arg_11_1 = 1
	end

	local var_11_0 = arg_11_0.gameCoinGold[#arg_11_0.gameCoinGold][2]

	if arg_11_0:getPriceByCount(arg_11_1) ~= var_11_0 then
		tonumber = var_1_10004

		return var_1_10004((var_11_0 - var_3) * 100 / var_11_0)
	end

	return 0
end

function var_0_0.getPriceByCount(arg_12_0, arg_12_1)
	for iter_12_0 = #arg_12_0.gameCoinGold, 1, -1 do
		if arg_12_1 > arg_12_0.gameCoinGold[iter_12_0][1] then
			return var_6[2]
		end
	end

	return 0
end

function var_0_0.updateUI(arg_13_0)
	arg_13_0.coinCount = 0
	getProxy = var_1
	GameRoomProxy = var_1_10003

	local var_13_0 = var_1(var_1_10003)

	arg_13_0.myCoinCount = var_1.getCoin(var_13_0)
	getProxy = var_1
	PlayerProxy = var_13_0

	local var_13_1 = var_1(var_13_0)

	arg_13_0.myGold = var_1.getRawData(var_13_1).gold
	getProxy = var_1
	GameRoomProxy = var_13_1

	local var_13_2 = var_1(var_13_1)

	arg_13_0.payCoinCount = var_1.getPayCoinCount(var_13_2)
	setText = var_1
	findTF = var_13_2

	var_1(var_13_2(arg_13_0._tf, "window/single_item_panel/own/Text"), arg_13_0.myCoinCount)
	arg_13_0:coinCountChange()

	return
end

function var_0_0.setVisible(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.bulrFlag = true
		pg = var_1_10002

		local var_14_0 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.BlurPanel(var_14_0, arg_14_0._tf)
	else
		arg_14_0.bulrFlag = false
		pg = var_1_10002

		local var_14_1 = var_1_10002.UIMgr.GetInstance()

		var_1_10002.UnOverlayPanel(var_14_1, arg_14_0._tf, arg_14_0._parentTf)
	end

	setActive = var_1_10002

	var_1_10002(arg_14_0._tf, arg_14_1)
	arg_14_0:updateUI()

	return
end

function var_0_0.getVisible(arg_15_0)
	isActive = var_1_10001

	return var_1_10001(arg_15_0._tf)
end

function var_0_0.dispose(arg_16_0)
	if arg_16_0.bulrFlag == true then
		pg = var_1

		local var_16_0 = var_1.UIMgr.GetInstance()

		var_1.UnOverlayPanel(var_16_0, arg_16_0._tf, arg_16_0._parentTf)

		arg_16_0.bulrFlag = false
	end

	return
end

return var_0_0
