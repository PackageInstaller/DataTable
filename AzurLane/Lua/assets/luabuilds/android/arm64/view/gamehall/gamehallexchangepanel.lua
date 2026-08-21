local var_0_0 = class("GameHallExchangePanel")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tf = arg_1_1
	arg_1_0._parentTf = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.itemCfg = Item.getConfigData(pg.player_resource[GameRoomProxy.coin_res_id].itemid)
	arg_1_0.coinMax = pg.gameset.game_coin_max.key_value
	arg_1_0.gameCoinGold = pg.gameset.game_coin_gold.description

	updateDrop(findTF(arg_1_0._tf, "window/single_item_panel/iconPos/icon"), {
		id = pg.player_resource[GameRoomProxy.coin_res_id].itemid,
		type = DROP_TYPE_ITEM
	})
	setText(findTF(arg_1_0._tf, "window/single_item_panel/name_mode/name_mask/name"), arg_1_0.itemCfg.name)
	setText(findTF(arg_1_0._tf, "window/single_item_panel/own/label"), i18n("word_own1"))
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "bg"), function()
		arg_1_0:setVisible(false)

		return
	end)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "top/btnBack"), function()
		arg_1_0:setVisible(false)

		return
	end)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "window/btnCancel"), function()
		arg_1_0:setVisible(false)

		return
	end)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "window/btnConfirm"), function()
		if arg_1_0.costPrice > arg_1_0.myGold then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_remould_no_gold"))
		else
			arg_1_0:exchangeCoin()
			arg_1_0:setVisible(false)
		end

		return
	end)

	arg_1_0.disCount = findTF(arg_1_0._tf, "window/discount")
	arg_1_0.disCountText = findTF(arg_1_0._tf, "window/discount/Text")

	onButton(arg_1_0._event, findTF(arg_1_0._tf, "window/count_select/value_bg/left"), function()
		arg_1_0.coinCount = arg_1_0.coinCount - 1

		arg_1_0:coinCountChange()

		return
	end)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "window/count_select/value_bg/right"), function()
		arg_1_0.coinCount = arg_1_0.coinCount + 1

		arg_1_0:coinCountChange()

		return
	end)
	onButton(arg_1_0._event, findTF(arg_1_0._tf, "window/count_select/max"), function()
		arg_1_0.coinCount = arg_1_0.coinMax - arg_1_0.myCoinCount

		arg_1_0:coinCountChange()

		return
	end)
	setText(findTF(arg_1_0._tf, "window/btnConfirm/pic"), i18n("word_ok"))
	setText(findTF(arg_1_0._tf, "window/btnCancel/pic"), i18n("word_cancel"))
	setText(findTF(arg_1_0._tf, "top/bg/infomation/title"), i18n("title_info"))
	setActive(findTF(arg_1_0._tf, "top/bg/infomation/title_en"), PLATFORM_CODE ~= PLATFORM_US)

	return
end

function var_0_0.exchangeCoin(arg_9_0)
	if arg_9_0.coinCount == 0 then
		return
	end

	arg_9_0._event:emit(GameHallMediator.EXCHANGE_COIN, {
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
		var_10_0 = var_10_0 + arg_10_0:getPriceByCount(arg_10_0.payCoinCount + iter_10_0)
	end

	arg_10_0.costPrice = var_10_0

	setText(findTF(arg_10_0._tf, "window/count_select/desc_txt"), i18n("charge_game_room_coin_tip", var_10_0, arg_10_0.coinCount, var_10_1, arg_10_0.itemCfg.name))
	setText(findTF(arg_10_0._tf, "window/count_select/value_bg/value"), arg_10_0.coinCount)

	local var_10_2 = arg_10_0:getDiscount(arg_10_0.coinCount + arg_10_0.payCoinCount)

	setActive(arg_10_0.disCount, var_10_2 ~= 0)
	setText(arg_10_0.disCountText, var_10_2 .. "%OFF")

	return
end

function var_0_0.getDiscount(arg_11_0, arg_11_1)
	if arg_11_1 <= 0 then
		arg_11_1 = 1
	end

	local var_11_0 = arg_11_0.gameCoinGold[#arg_11_0.gameCoinGold][2]
	local var_11_1 = arg_11_0:getPriceByCount(arg_11_1)

	if var_11_1 ~= arg_11_0.gameCoinGold[#arg_11_0.gameCoinGold][2] then
		return tonumber((var_11_0 - var_11_1) * 100 / var_11_0)
	end

	return 0
end

function var_0_0.getPriceByCount(arg_12_0, arg_12_1)
	for iter_12_0 = #arg_12_0.gameCoinGold, 1, -1 do
		if arg_12_1 > arg_12_0.gameCoinGold[iter_12_0][1] then
			return arg_12_0.gameCoinGold[iter_12_0][2]
		end
	end

	return 0
end

function var_0_0.updateUI(arg_13_0)
	arg_13_0.coinCount = 0
	arg_13_0.myCoinCount = getProxy(GameRoomProxy):getCoin()
	arg_13_0.myGold = getProxy(PlayerProxy):getRawData().gold
	arg_13_0.payCoinCount = getProxy(GameRoomProxy):getPayCoinCount()

	setText(findTF(arg_13_0._tf, "window/single_item_panel/own/Text"), arg_13_0.myCoinCount)
	arg_13_0:coinCountChange()

	return
end

function var_0_0.setVisible(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.bulrFlag = true

		pg.UIMgr.GetInstance():BlurPanel(arg_14_0._tf)
	else
		arg_14_0.bulrFlag = false

		pg.UIMgr.GetInstance():UnOverlayPanel(arg_14_0._tf, arg_14_0._parentTf)
	end

	setActive(arg_14_0._tf, arg_14_1)
	arg_14_0:updateUI()

	return
end

function var_0_0.getVisible(arg_15_0)
	return isActive(arg_15_0._tf)
end

function var_0_0.dispose(arg_16_0)
	if arg_16_0.bulrFlag == true then
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_16_0._tf, arg_16_0._parentTf)

		arg_16_0.bulrFlag = false
	end

	return
end

return var_0_0
