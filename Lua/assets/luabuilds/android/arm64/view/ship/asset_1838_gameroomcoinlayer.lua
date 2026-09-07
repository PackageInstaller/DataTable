local GameRoomCoinLayer = class("GameRoomCoinLayer", import("..base.BaseUI"))

function GameRoomCoinLayer:getUIName()
	return "GameRoomCoinUI"
end

function GameRoomCoinLayer:init()
	self.totalCount = 0
	self.curCount = 0
	self.maxCoin = 0

	return
end

function GameRoomCoinLayer:didEnter()
	self.ad = findTF(self._tf, "ad")
	self.window = findTF(self._tf, "ad/window")
	self.text = findTF(self._tf, "ad/window/text")
	self.window.anchoredPosition = Vector2(self.contextData.position[1], self.contextData.position[2])
	self.maxCoin = self.contextData.coin_max

	onButton(self, findTF(self.window, "add"), function()
		if self.lockCount then
			return
		end

		self.curCount = self.curCount + 1

		self:updateCount()

		return
	end)
	onButton(self, findTF(self.window, "sub"), function()
		if self.lockCount then
			return
		end

		self.curCount = self.curCount - 1

		self:updateCount()

		return
	end)

	local var_3_0 = getProxy(GameRoomProxy)

	if var_3_0:lastMonthlyTicket() == 0 or var_3_0:lastTicketMax() == 0 then
		self.curCount = 0
		self.lockCount = true
	else
		self.curCount = 1
		self.lockCount = false
	end

	self:updateUI()

	return
end

function GameRoomCoinLayer:changeVisible(arg_6_1)
	setActive(self.window, arg_6_1)
	self:updateUI()

	return
end

function GameRoomCoinLayer:updateUI()
	self:updateCoin()
	self:updateCount()

	return
end

function GameRoomCoinLayer:updateCoin()
	local var_8_0 = getProxy(GameRoomProxy):getCoin()

	var_8_0 = var_8_0 or 0
	self.totalCount = var_8_0

	if self.curCount > self.totalCount then
		self.curCount = 0
	end

	return
end

function GameRoomCoinLayer:updateCount()
	if self.curCount > self.maxCoin then
		self.curCount = self.maxCoin
	end

	if self.curCount > self.totalCount then
		self.curCount = self.totalCount
	end

	if self.curCount < 0 then
		self.curCount = 0
	end

	setText(self.text, self.curCount .. "/" .. self.totalCount)
	self:emit(GameRoomCoinMediator.CHANGE_COIN_NUM, self.curCount)

	return
end

function GameRoomCoinLayer:onBackPressed()
	return
end

function GameRoomCoinLayer:willExit()
	return
end

return GameRoomCoinLayer
