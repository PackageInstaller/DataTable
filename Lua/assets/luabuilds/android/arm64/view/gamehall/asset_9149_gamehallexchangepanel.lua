local GameHallExchangePanel = class("GameHallExchangePanel")

function GameHallExchangePanel:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tf = arg_1_1
	self._parentTf = arg_1_2
	self._event = arg_1_3
	self.itemCfg = Item.getConfigData(pg.player_resource[GameRoomProxy.coin_res_id].itemid)
	self.coinMax = pg.gameset.game_coin_max.key_value
	self.gameCoinGold = pg.gameset.game_coin_gold.description

	updateDrop(findTF(self._tf, "window/single_item_panel/iconPos/icon"), {
		id = pg.player_resource[GameRoomProxy.coin_res_id].itemid,
		type = DROP_TYPE_ITEM
	})
	setText(findTF(self._tf, "window/single_item_panel/name_mode/name_mask/name"), self.itemCfg.name)
	setText(findTF(self._tf, "window/single_item_panel/own/label"), i18n("word_own1"))
	onButton(self._event, findTF(self._tf, "bg"), function()
		self:setVisible(false)

		return
	end)
	onButton(self._event, findTF(self._tf, "top/btnBack"), function()
		self:setVisible(false)

		return
	end)
	onButton(self._event, findTF(self._tf, "window/btnCancel"), function()
		self:setVisible(false)

		return
	end)
	onButton(self._event, findTF(self._tf, "window/btnConfirm"), function()
		if self.costPrice > self.myGold then
			pg.TipsMgr.GetInstance():ShowTips(i18n("ship_remould_no_gold"))
		else
			self:exchangeCoin()
			self:setVisible(false)
		end

		return
	end)

	self.disCount = findTF(self._tf, "window/discount")
	self.disCountText = findTF(self._tf, "window/discount/Text")

	onButton(self._event, findTF(self._tf, "window/count_select/value_bg/left"), function()
		self.coinCount = self.coinCount - 1

		self:coinCountChange()

		return
	end)
	onButton(self._event, findTF(self._tf, "window/count_select/value_bg/right"), function()
		self.coinCount = self.coinCount + 1

		self:coinCountChange()

		return
	end)
	onButton(self._event, findTF(self._tf, "window/count_select/max"), function()
		self.coinCount = self.coinMax - self.myCoinCount

		self:coinCountChange()

		return
	end)
	setText(findTF(self._tf, "window/btnConfirm/pic"), i18n("word_ok"))
	setText(findTF(self._tf, "window/btnCancel/pic"), i18n("word_cancel"))
	setText(findTF(self._tf, "top/bg/infomation/title"), i18n("title_info"))
	setActive(findTF(self._tf, "top/bg/infomation/title_en"), PLATFORM_CODE ~= PLATFORM_US)

	return
end

function GameHallExchangePanel:exchangeCoin()
	if self.coinCount == 0 then
		return
	end

	self._event:emit(GameHallMediator.EXCHANGE_COIN, {
		price = self.costPrice,
		times = self.coinCount
	})

	return
end

function GameHallExchangePanel:coinCountChange()
	if self.coinCount < 0 then
		self.coinCount = 0
	end

	if self.coinCount + self.myCoinCount > self.coinMax then
		self.coinCount = self.coinMax - self.myCoinCount
	end

	local var_10_0 = 0

	for iter_10_0 = 1, self.coinCount do
		var_10_0 = var_10_0 + self:getPriceByCount(self.payCoinCount + iter_10_0)
	end

	self.costPrice = var_10_0

	setText(findTF(self._tf, "window/count_select/desc_txt"), i18n("charge_game_room_coin_tip", var_10_0, self.coinCount, var_10_0 < self.myGold and COLOR_GREEN or COLOR_RED, self.itemCfg.name))
	setText(findTF(self._tf, "window/count_select/value_bg/value"), self.coinCount)

	local var_10_2 = self:getDiscount(self.coinCount + self.payCoinCount)

	setActive(self.disCount, var_10_2 ~= 0)
	setText(self.disCountText, var_10_2 .. "%OFF")

	return
end

function GameHallExchangePanel:getDiscount(arg_11_1)
	if arg_11_1 <= 0 then
		arg_11_1 = 1
	end

	local var_11_0 = self.gameCoinGold[#self.gameCoinGold][2]
	local var_11_1 = self:getPriceByCount(arg_11_1)

	if var_11_1 ~= self.gameCoinGold[#self.gameCoinGold][2] then
		return tonumber((var_11_0 - var_11_1) * 100 / var_11_0)
	end

	return 0
end

function GameHallExchangePanel:getPriceByCount(arg_12_1)
	for iter_12_0 = #self.gameCoinGold, 1, -1 do
		if arg_12_1 > self.gameCoinGold[iter_12_0][1] then
			return self.gameCoinGold[iter_12_0][2]
		end
	end

	return 0
end

function GameHallExchangePanel:updateUI()
	self.coinCount = 0
	self.myCoinCount = getProxy(GameRoomProxy):getCoin()
	self.myGold = getProxy(PlayerProxy):getRawData().gold
	self.payCoinCount = getProxy(GameRoomProxy):getPayCoinCount()

	setText(findTF(self._tf, "window/single_item_panel/own/Text"), self.myCoinCount)
	self:coinCountChange()

	return
end

function GameHallExchangePanel:setVisible(arg_14_1)
	if arg_14_1 then
		self.bulrFlag = true

		pg.UIMgr.GetInstance():BlurPanel(self._tf)
	else
		self.bulrFlag = false

		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)
	end

	setActive(self._tf, arg_14_1)
	self:updateUI()

	return
end

function GameHallExchangePanel:getVisible()
	return isActive(self._tf)
end

function GameHallExchangePanel:dispose()
	if self.bulrFlag == true then
		pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

		self.bulrFlag = false
	end

	return
end

return GameHallExchangePanel
