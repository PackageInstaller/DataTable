local TowerClimbingGameView = class("TowerClimbingGameView", import("..BaseMiniGameView"))

function TowerClimbingGameView:getUIName()
	return "TowerClimbingUI"
end

function TowerClimbingGameView:GetMGData()
	return getProxy(MiniGameProxy):GetMiniGameData(self.contextData.miniGameId):clone()
end

function TowerClimbingGameView:GetMGHubData()
	return getProxy(MiniGameProxy):GetHubByGameId(self.contextData.miniGameId)
end

function TowerClimbingGameView:didEnter()
	onButton(self, self._tf:Find("overview/back"), function()
		self:emit(TowerClimbingGameView.ON_BACK)

		return
	end, SFX_PANEL)
	onButton(self, self._tf:Find("overview/collection"), function()
		self:emit(TowerClimbingMediator.ON_COLLECTION)

		return
	end, SFX_PANEL)

	if LOCK_TOWERCLIMBING_AWARD then
		setActive(self._tf:Find("overview/collection"), false)
	end

	return
end

function TowerClimbingGameView:UpdateTip()
	local var_7_0 = TowerClimbingCollectionLayer.New()

	var_7_0:SetData((self:GetMGData()))
	setActive(self._tf:Find("overview/collection/tip"), (_.any({
		1,
		2,
		3
	}, function(arg_8_0)
		return var_7_0:GetAwardState(arg_8_0) == 1
	end)))

	return
end

function TowerClimbingGameView:Start()
	self.controller = TowerClimbingController.New()

	self.controller.view:SetUI(self._go)
	self.controller:SetCallBack(function(arg_10_0, arg_10_1, arg_10_2)
		self:emit(TowerClimbingMediator.ON_FINISH, arg_10_0, arg_10_2, arg_10_1)

		return
	end, function(arg_11_0, arg_11_1)
		print("record map score:", arg_11_0, arg_11_1)
		self:emit(TowerClimbingMediator.ON_RECORD_MAP_SCORE, arg_11_0, arg_11_1)

		return
	end)
	self.controller:SetUp((self:PackData()))
	self:UpdateTip()

	return
end

function TowerClimbingGameView:OnSendMiniGameOPDone(arg_12_1)
	if arg_12_1.hubid == 9 and arg_12_1.cmd == MiniGameOPCommand.CMD_SPECIAL_GAME and arg_12_1.argList[1] == MiniGameDataCreator.TowerClimbingGameID and arg_12_1.argList[2] == 1 then
		self:Start()
	elseif arg_12_1.hubid == 9 and arg_12_1.cmd == MiniGameOPCommand.CMD_COMPLETE or arg_12_1.hubid == 9 and arg_12_1.cmd == MiniGameOPCommand.CMD_SPECIAL_GAME and (arg_12_1.argList[2] == 3 or arg_12_1.argList[2] == 4) then
		self.controller:NetUpdateData((self:PackData()))
		self:UpdateTip()
	end

	return
end

function TowerClimbingGameView:GetTowerClimbingPageAndScore()
	local var_13_0 = self[1] or {}

	for iter_13_0 = #var_13_0 + 1, 3 do
		table.insert(var_13_0, {
			value = 0,
			value2 = 0,
			key = iter_13_0
		})
	end

	table.sort(var_13_0, function(arg_14_0, arg_14_1)
		return arg_14_0.key < arg_14_1.key
	end)

	local var_13_1 = TowerClimbingGameView.GetAwardScores()
	local var_13_2 = 0
	local var_13_3 = 1

	for iter_13_1, iter_13_2 in ipairs(var_13_0) do
		local var_13_4 = var_13_1[iter_13_2.key][#var_13_1[iter_13_2.key]]

		if var_13_4 > iter_13_2.value2 or iter_13_1 == #var_13_0 and var_13_4 <= iter_13_2.value2 then
			var_13_2 = iter_13_2.value2
			var_13_3 = iter_13_2.key

			break
		end
	end

	local var_13_5 = {}
	local var_13_6 = self[2] or {}

	for iter_13_3 = #var_13_6 + 1, 3 do
		table.insert(var_13_6, {
			value = 0,
			key = iter_13_3
		})
	end

	table.sort(var_13_6, function(arg_15_0, arg_15_1)
		return arg_15_0.key < arg_15_1.key
	end)

	for iter_13_4, iter_13_5 in ipairs(var_13_6) do
		var_13_5[iter_13_5.key] = iter_13_5.value
	end

	return var_13_2, var_13_3, var_13_5
end

function TowerClimbingGameView.GetAwardScores()
	return (_.map(pg.mini_game[MiniGameDataCreator.TowerClimbingGameID].simple_config_data, function(arg_17_0)
		return arg_17_0[1]
	end))
end

function TowerClimbingGameView:PackData()
	local var_18_0, var_18_1, var_18_2 = TowerClimbingGameView.GetTowerClimbingPageAndScore((self:GetMGData():GetRuntimeData("kvpElements")))

	print(var_18_0, "-", var_18_1)

	return {
		npcName = "TowerClimbingManjuu",
		life = 3,
		shipId = 107031,
		screenWidth = self._tf.rect.width,
		screenHeight = self._tf.rect.height,
		higestscore = var_18_0,
		pageIndex = var_18_1,
		mapScores = var_18_2,
		awards = TowerClimbingGameView.GetAwardScores()
	}
end

function TowerClimbingGameView:onBackPressed()
	if self.controller:onBackPressed() then
		return
	end

	self:emit(TowerClimbingGameView.ON_BACK)

	return
end

function TowerClimbingGameView:willExit()
	self.controller:Dispose()

	return
end

return TowerClimbingGameView
