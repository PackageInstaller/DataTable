local GameRoomPileGameView = class("GameRoomPileGameView", import("..BaseMiniGameView"))

function GameRoomPileGameView:getUIName()
	return "GameRoomPileGameUI"
end

function GameRoomPileGameView:init()
	self.backBtn = self._tf:Find("overview/back")

	return
end

function GameRoomPileGameView:didEnter()
	onButton(self, self.backBtn, function()
		self:emit(GameRoomPileGameView.ON_BACK)

		return
	end, SFX_PANEL)

	self.controller = PileGameController.New()

	self.controller.view:SetUI(self._go)
	self.controller:SetUp(self:PackData(), function(arg_5_0, arg_5_1)
		local var_5_0 = self:GetMGHubData()

		self:SendSuccess(arg_5_0)

		return
	end)
	self.controller:setGameStartCallback(function(arg_6_0)
		self:openCoinLayer(arg_6_0)

		return
	end)

	return
end

function GameRoomPileGameView:PackData()
	if self:getGameRoomData() then
		self.gameHelpTip = self:getGameRoomData().game_help
	end

	return {
		highestScore = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id),
		screen = Vector2(self._tf.rect.width, self._tf.rect.height),
		tip = self.gameHelpTip
	}
end

function GameRoomPileGameView:OnGetAwardDone(arg_8_1)
	return
end

function GameRoomPileGameView:onBackPressed()
	if self.controller:onBackPressed() then
		return
	end

	self:emit(GameRoomPileGameView.ON_BACK)

	return
end

function GameRoomPileGameView:willExit()
	self.controller:Dispose()

	return
end

return GameRoomPileGameView
