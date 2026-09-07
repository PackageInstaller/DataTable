local GameRoomTowerView = class("GameRoomTowerView", import("..BaseMiniGameView"))

function GameRoomTowerView:getUIName()
	return "GameRoomTowerUI"
end

function GameRoomTowerView:GetMGData()
	return getProxy(MiniGameProxy):GetMiniGameData(self.contextData.miniGameId):clone()
end

function GameRoomTowerView:GetMGHubData()
	return getProxy(MiniGameProxy):GetHubByGameId(self.contextData.miniGameId)
end

function GameRoomTowerView:didEnter()
	self:Start()

	self.backBtn = findTF(self._tf, "overview/back")

	onButton(self, self.backBtn, function()
		self:emit(GameRoomTowerView.ON_BACK)

		return
	end, SFX_PANEL)

	return
end

function GameRoomTowerView:Start()
	self.controller = TowerClimbingController.New()

	self.controller:setGameStateCallback(function()
		self:openCoinLayer(false)

		return
	end, function()
		self:openCoinLayer(true)

		return
	end)
	self.controller:setRoomTip(self:getGameRoomData().game_help)
	self.controller.view:SetUI(self._go)
	self.controller:SetCallBack(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		self.sendSuccessFlag = true

		self:SendSuccess(arg_9_0)

		return
	end, function(arg_10_0, arg_10_1)
		return
	end)
	self.controller:SetUp((self:PackData()))

	return
end

function GameRoomTowerView:updateHighScore()
	local var_11_0 = getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id)

	if self.controller then
		self.controller:updateHighScore({
			var_11_0,
			var_11_0,
			var_11_0
		} or {})
	end

	return
end

function GameRoomTowerView:OnSendMiniGameOPDone(arg_12_1)
	local var_12_0 = getProxy(MiniGameProxy):GetHubByHubId(self.hub_id).count

	var_12_0 = var_12_0 or 0
	self.itemNums = var_12_0

	setText(findTF(self._tf, "overview/item/num"), self.itemNums)
	self:updateHighScore()

	return
end

function GameRoomTowerView:getGameTimes()
	return self:GetMGHubData().count
end

function GameRoomTowerView:GetTowerClimbingPageAndScore()
	return 0, 1, {
		self,
		self,
		self
	}
end

function GameRoomTowerView.GetAwardScores()
	return (_.map(pg.mini_game[MiniGameDataCreator.TowerClimbingGameID].simple_config_data, function(arg_16_0)
		return arg_16_0[1]
	end))
end

function GameRoomTowerView:PackData()
	local var_17_0, var_17_1, var_17_2 = GameRoomTowerView.GetTowerClimbingPageAndScore(getProxy(GameRoomProxy):getRoomScore(self:getGameRoomData().id))

	print(var_17_0, "-", var_17_1)

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = self._tf.rect.width,
		screenHeight = self._tf.rect.height,
		higestscore = var_17_0,
		pageIndex = var_17_1,
		mapScores = var_17_2,
		awards = GameRoomTowerView.GetAwardScores()
	}
end

function GameRoomTowerView:onBackPressed()
	if self.controller and self.controller:onBackPressed() then
		return
	end

	self:emit(GameRoomTowerView.ON_BACK)

	return
end

function GameRoomTowerView:willExit()
	if self.controller then
		self.controller:Dispose()
	end

	return
end

return GameRoomTowerView
