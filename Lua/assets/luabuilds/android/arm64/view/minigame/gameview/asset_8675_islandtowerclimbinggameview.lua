local IslandTowerClimbingGameView = class("IslandTowerClimbingGameView", import("..BaseMiniGameView"))

function IslandTowerClimbingGameView:getUIName()
	return "IslandTowerClimbingUI"
end

function IslandTowerClimbingGameView:GetMGData()
	return getProxy(MiniGameProxy):GetMiniGameData(self.contextData.miniGameId):clone()
end

function IslandTowerClimbingGameView:GetMGHubData()
	return getProxy(MiniGameProxy):GetHubByGameId(self.contextData.miniGameId)
end

function IslandTowerClimbingGameView:didEnter()
	if not Physics2D.autoSimulation then
		Physics2D.autoSimulation = true
		self.isChangeAutoSimulation = true
	end

	self:Start()

	self.backBtn = findTF(self._tf, "overview/back")

	onButton(self, self.backBtn, function()
		self:emit(IslandTowerClimbingGameView.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, findTF(self._tf, "overview/item"), function()
		self:emit(BaseMiniGameMediator.OPEN_SUB_LAYER, {
			mediator = IslandGameLimitMediator,
			viewComponent = IslandGameLimitLayer,
			data = {
				type = IslandGameLimitLayer.limit_type_jiujiu
			}
		})

		return
	end, SFX_CANCEL)

	self.itemConfig = Item.getConfigData(pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_client.item_id)

	LoadImageSpriteAsync(self.itemConfig.icon, findTF(self._tf, "overview/item/img"), true)

	self.hub_id = pg.activity_template[ActivityConst.ISLAND_GAME_ID].config_id

	local var_4_0 = getProxy(MiniGameProxy):GetHubByHubId(self.hub_id).count

	var_4_0 = var_4_0 or 0
	self.itemNums = var_4_0

	setText(findTF(self._tf, "overview/item/num"), self.itemNums)

	return
end

function IslandTowerClimbingGameView:Start()
	self.controller = TowerClimbingController.New()

	self.controller.view:SetUI(self._go)
	self.controller:SetCallBack(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
		local var_8_0 = self:GetMGData():GetRuntimeData("elements")

		var_8_0 = var_8_0 or {}

		for iter_8_0 = 1, arg_8_3 do
			if iter_8_0 > #var_8_0 then
				table.insert(var_8_0, 0)
			end
		end

		if arg_8_0 >= var_8_0[arg_8_3] then
			var_8_0[arg_8_3] = arg_8_0

			self:StoreDataToServer(var_8_0)
			self:updateHighScore()
		end

		if self:getGameTimes() and self:getGameTimes() > 0 then
			self.sendSuccessFlag = true

			self:SendSuccess(0)
		end

		return
	end, function(arg_9_0, arg_9_1)
		return
	end)
	self.controller:SetUp((self:PackData()))

	return
end

function IslandTowerClimbingGameView:updateHighScore()
	local var_10_0 = self:GetMGData():GetRuntimeData("elements")

	var_10_0 = var_10_0 or {}

	if self.controller then
		-- block empty
	end

	self.controller:updateHighScore(var_10_0)

	return
end

function IslandTowerClimbingGameView:OnSendMiniGameOPDone(arg_11_1)
	local var_11_0 = getProxy(MiniGameProxy):GetHubByHubId(self.hub_id).count

	var_11_0 = var_11_0 or 0
	self.itemNums = var_11_0

	setText(findTF(self._tf, "overview/item/num"), self.itemNums)
	self:updateHighScore()

	return
end

function IslandTowerClimbingGameView:getGameTimes()
	return self:GetMGHubData().count
end

function IslandTowerClimbingGameView:GetTowerClimbingPageAndScore()
	return 0, 1, {
		0,
		0,
		0
	}
end

function IslandTowerClimbingGameView.GetAwardScores()
	return (_.map(pg.mini_game[MiniGameDataCreator.TowerClimbingGameID].simple_config_data, function(arg_15_0)
		return arg_15_0[1]
	end))
end

function IslandTowerClimbingGameView:PackData()
	local var_16_0, var_16_1, var_16_2 = IslandTowerClimbingGameView.GetTowerClimbingPageAndScore((self:GetMGData():GetRuntimeData("elements")))

	print(var_16_0, "-", var_16_1)

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = self._tf.rect.width,
		screenHeight = self._tf.rect.height,
		higestscore = var_16_0,
		pageIndex = var_16_1,
		mapScores = var_16_2,
		awards = IslandTowerClimbingGameView.GetAwardScores()
	}
end

function IslandTowerClimbingGameView:onBackPressed()
	if self.controller and self.controller:onBackPressed() then
		return
	end

	self:emit(IslandTowerClimbingGameView.ON_BACK)

	return
end

function IslandTowerClimbingGameView:willExit()
	if self.controller then
		self.controller:Dispose()
	end

	if self.isChangeAutoSimulation then
		Physics2D.autoSimulation = false
		self.isChangeAutoSimulation = nil
	end

	return
end

return IslandTowerClimbingGameView
