local GameHallScene = class("GameHallScene", import("..base.BaseUI"))

GameHallScene.open_with_list = false

function GameHallScene:getUIName()
	return "GameHallUI"
end

function GameHallScene:init()
	return
end

function GameHallScene:didEnter()
	self:initTopUI()
	self:initHomeUI()

	local var_3_0 = findTF(self._tf, "ad/container")

	self.charController = GameHallContainerUI.New(var_3_0)
	self.freeCoinTf = findTF(var_3_0, "content/top/free")

	onButton(self, self.freeCoinTf, function()
		local var_4_0 = getProxy(GameRoomProxy)

		if var_4_0 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("game_icon_max_full"))
		elseif pg.gameset.game_coin_max.key_value - var_4_0:getCoin() < pg.gameset.game_coin_initial.key_value then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("game_icon_max"),
				onYes = function()
					self:emit(GameHallMediator.GET_WEEKLY_COIN)

					return
				end,
				onNo = function()
					return
				end
			})
		else
			self:emit(GameHallMediator.GET_WEEKLY_COIN)
		end

		return
	end, SFX_CONFIRM)

	self.listPanelTf = findTF(self._tf, "ad/listPanel")
	self.listPanel = GameHallListPanel.New(self.listPanelTf, self)

	self.listPanel:setVisible(GameHallScene.open_with_list)

	GameHallScene.open_with_list = false
	self.exchangePanelTf = findTF(self._tf, "ad/exchangePanel")
	self.parentTf = findTF(self._tf, "ad")
	self.exchangePanel = GameHallExchangePanel.New(self.exchangePanelTf, self.parentTf, self)

	self:openExchangePanel(false)
	self:changeTitle(false)

	local var_3_1 = Application.targetFrameRate or 60

	if var_3_1 > 60 then
		var_3_1 = 60
	end

	self.timer = Timer.New(function()
		self:onTimer()

		return
	end, 1 / var_3_1, -1)

	self.timer:Start()
	self:updateUI()

	return
end

function GameHallScene:initTopUI()
	self.btnBack = findTF(self._tf, "ad/topPanel/btnBack")
	self.btnHome = findTF(self._tf, "ad/topPanel/btnHome")
	self.btnHelp = findTF(self._tf, "ad/topPanel/btnHelp")
	self.btnCoin = findTF(self._tf, "ad/topPanel/coin")
	self.textCoin = findTF(self._tf, "ad/topPanel/coin/text")
	self.coinMax = pg.gameset.game_coin_max.key_value
	self.textCoinMaxTF = findTF(self._tf, "ad/topPanel/coin/max")

	setText(self.textCoinMaxTF, "MAX:" .. self.coinMax)
	onButton(self, self.btnCoin, function()
		self:openExchangePanel(true)

		return
	end)
	onButton(self, self.btnBack, function()
		if self.listPanel:getVisible() then
			self.listPanel:setVisible(false)
			self:changeTitle(false)
			pg.SystemGuideMgr.GetInstance():Play(self)

			return
		end

		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnHome, function()
		self:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.game_room_help.tip
		})

		return
	end, SFX_CANCEL)

	return
end

function GameHallScene:openExchangePanel(arg_13_1)
	self.exchangePanel:setVisible(arg_13_1)

	return
end

function GameHallScene:ResUISettings()
	return {
		showType = bit.bor(PlayerResUI.TYPE_OIL, PlayerResUI.TYPE_GOLD)
	}
end

function GameHallScene:initHomeUI()
	self.btnShop = findTF(self._tf, "ad/btnShop")
	self.btnPlay = findTF(self._tf, "ad/btnPlay")

	onButton(self, self.btnPlay, function()
		self.listPanel:setVisible(true)
		self:changeTitle(true)

		return
	end, SFX_CANCEL)
	onButton(self, self.btnShop, function()
		self:emit(GameHallMediator.OPEN_GAME_SHOP)

		return
	end, SFX_CANCEL)

	self.topShop = findTF(self._tf, "ad/container/content/top/btnShop")
	self.topGame = findTF(self._tf, "ad/container/content/top/btnGameList")

	onButton(self, self.topGame, function()
		self.listPanel:setVisible(true)
		self:changeTitle(true)

		return
	end, SFX_CANCEL)
	onButton(self, self.topShop, function()
		self:emit(GameHallMediator.OPEN_GAME_SHOP)

		return
	end, SFX_CANCEL)

	return
end

function GameHallScene:updateUI()
	setActive(self.freeCoinTf, (getProxy(GameRoomProxy):getWeekly()))
	setText(self.textCoin, (getProxy(GameRoomProxy):getCoin()))

	return
end

function GameHallScene:onTimer()
	self.charController:step()

	return
end

function GameHallScene:changeTitle(arg_22_1)
	setActive(findTF(self._tf, "ad/topPanel/title_list"), arg_22_1)
	setActive(findTF(self._tf, "ad/topPanel/title_main"), not arg_22_1)

	return
end

function GameHallScene:onBackPressed()
	if self.listPanel:getVisible() then
		self.listPanel:setVisible(false)
		self:changeTitle(false)

		return
	end

	if self.exchangePanel:getVisible() then
		self.exchangePanel:setVisible(false)

		return
	end

	self:emit(GameHallScene.ON_BACK_PRESSED)

	return
end

function GameHallScene:willExit()
	self.charController:Dispose()

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.listPanel:getVisible() then
		GameHallScene.open_with_list = true
	end

	self.exchangePanel:dispose()
	self.listPanel:dispose()

	return
end

return GameHallScene
