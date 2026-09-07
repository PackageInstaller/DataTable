local IslandCheaterTavernGameView = class("IslandCheaterTavernGameView", import("Mod.Island.Core.View.IslandView"))

function IslandCheaterTavernGameView:Init()
	IslandCheaterTavernGameView.super.Init(self)

	return
end

function IslandCheaterTavernGameView:OnSceneInited()
	return
end

function IslandCheaterTavernGameView:CreateViews()
	self.views = {}

	return
end

function IslandCheaterTavernGameView:AfterCoreInit()
	if self.weatherSystem then
		self.weatherSystem:Dispose()
	end

	self.weatherSystem = IslandWeatherSystem.New(self)

	self:InitSceneGameObject()

	self.isSceneLoaded = true

	self:PlayBGM()

	return
end

function IslandCheaterTavernGameView:IsLoaded()
	return _.all(self.views, function(arg_6_0)
		return arg_6_0:IsLoaded()
	end) and _.all(self:GetAllUnits(), function(arg_7_0)
		return arg_7_0:IsLoaded()
	end)
end

function IslandCheaterTavernGameView:IsInit()
	return self.isInit
end

function IslandCheaterTavernGameView:AddListeners()
	self:AddListener(ISLAND_EVT.GEN_UNIT, self.OnGenUnit)
	self:AddListener(ISLAND_EVT.RMOVE_UNIT, self.OnRemoveUnit)
	self:AddListener(ISLAND_EVT.INIT_CHEATERTAVERN_CAMERA, self.OnInitCamera)
	self:AddListener(CheaterTavernEvent.PLAYER_QUESTION_ANIMATION, self.OnPlayerQuestion)
	self:AddListener(CheaterTavernEvent.SHOOT_AND_TURN_TABLE, self.OnPlayerShoot)
	self:AddListener(CheaterTavernEvent.PLAYER_OUT_ANIMATION, self.OnPlayerOut)
	self:AddListener(CheaterTavernEvent.FIRST_TAKE_SHOOT_TIPS, self.OnFirstTakeShootTip)
	self:AddListener(CheaterTavernEvent.CLOSE_PREPARE_MAIN_PAGE, self.OnCloseCheaterMainPage)
	self:AddListener(CheaterTavernEvent.PLAY_ROOM_EXIT_ROOM_DONE, self.OnExitRoomDone)
	self:AddListener(CheaterTavernEvent.INITPLAYER_DATA_DONE, self.OnInitPlayerDone)
	self:AddListener(CheaterTavernEvent.PLAY_WIN_ANIMATION, self.OnPlayWinAnimation)

	return
end

function IslandCheaterTavernGameView:RemoveListeners()
	self:RemoveListener(ISLAND_EVT.GEN_UNIT, self.OnGenUnit)
	self:RemoveListener(ISLAND_EVT.RMOVE_UNIT, self.OnRemoveUnit)
	self:RemoveListener(ISLAND_EVT.INIT_CHEATERTAVERN_CAMERA, self.OnInitCamera)
	self:RemoveListener(CheaterTavernEvent.PLAYER_QUESTION_ANIMATION, self.OnPlayerQuestion)
	self:RemoveListener(CheaterTavernEvent.SHOOT_AND_TURN_TABLE, self.OnPlayerShoot)
	self:RemoveListener(CheaterTavernEvent.PLAYER_OUT_ANIMATION, self.OnPlayerOut)
	self:RemoveListener(CheaterTavernEvent.FIRST_TAKE_SHOOT_TIPS, self.OnFirstTakeShootTip)
	self:RemoveListener(CheaterTavernEvent.CLOSE_PREPARE_MAIN_PAGE, self.OnCloseCheaterMainPage)
	self:RemoveListener(CheaterTavernEvent.PLAY_ROOM_EXIT_ROOM_DONE, self.OnExitRoomDone)
	self:RemoveListener(CheaterTavernEvent.INITPLAYER_DATA_DONE, self.OnInitPlayerDone)
	self:RemoveListener(CheaterTavernEvent.PLAY_WIN_ANIMATION, self.OnPlayWinAnimation)

	return
end

function IslandCheaterTavernGameView:OnInitCamera(arg_11_1)
	print("todo:lookSeet0" .. Time.frameCount)
	CheatTavernCameraMgr.instance:ActiveVirtualCamera("lookSeet0" .. arg_11_1)

	CheatTavernCameraMgr.instance._mainCamera.enabled = true

	return
end

function IslandCheaterTavernGameView:PlayBGM()
	if not self.isSceneLoaded then
		return
	end

	IslandCheaterTavernGameView.super.PlayBGM(self)

	return
end

function IslandCheaterTavernGameView:OnCloseCheaterMainPage()
	self:NotifiyMeditor(IslandBaseMediator.SWITCH_MAP, self:GetSelfIsland():GetLastExitPosition().mapId)

	return
end

function IslandCheaterTavernGameView:OnFirstTakeShootTip(arg_14_1)
	local var_14_0 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskTableId)

	if var_14_0 then
		var_14_0:OnFirstTakeShootTip(arg_14_1)
	end

	return
end

function IslandCheaterTavernGameView:OnPlayerQuestion(arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_PLAYER, arg_15_1)

	if var_15_0 then
		var_15_0:OnPlayerQuestion(arg_15_2)
	end

	if arg_15_3 then
		local var_15_1 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskCharIdList[arg_15_3])

		if var_15_1 then
			var_15_1:OnPlayerQuestion()
		end
	end

	return
end

function IslandCheaterTavernGameView:OnPlayWinAnimation(arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_PLAYER, arg_16_1)

	if var_16_0 then
		var_16_0:OnPlayWinAnimation(arg_16_2, arg_16_3)
	end

	if arg_16_2 then
		local var_16_1 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskCharIdList[arg_16_3])

		if var_16_1 then
			var_16_1:OnPlayWinAnimation()
		end
	end

	return
end

function IslandCheaterTavernGameView:OnPlayerShoot(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskTableId)

	if var_17_0 then
		var_17_0:OnShoot(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	end

	return
end

function IslandCheaterTavernGameView:OnPlayerOut(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_PLAYER, arg_18_1)

	if var_18_0 then
		var_18_0:OnPlayerOut(arg_18_1, arg_18_2)
	end

	local var_18_1 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, IslandCheaterTavernConst.deskCharIdList[arg_18_2])

	if var_18_1 then
		var_18_1:OnPlayerOut(arg_18_3)
	end

	return
end

function IslandCheaterTavernGameView:OnExitRoomDone()
	self:ClearSceneObject()
	self:InitSceneGameObject()

	return
end

function IslandCheaterTavernGameView:OnInitPlayerDone()
	for iter_20_0, iter_20_1 in ipairs(IslandCheaterTavernConst.deskCharIdList) do
		local var_20_0 = self:GetUnitModuleWithType(IslandConst.UNIT_LIST_CHEATER_ITEM, iter_20_1)

		if var_20_0 then
			var_20_0:InitDisplayState()
		end
	end

	return
end

function IslandCheaterTavernGameView:ClearSceneObject()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs((self:GetUnitListByKey(IslandConst.UNIT_LIST_PLAYER))) do
		table.insert(var_21_0, iter_21_1.id)
	end

	for iter_21_2, iter_21_3 in ipairs(var_21_0) do
		self:OnRemoveUnit(IslandConst.UNIT_LIST_PLAYER, iter_21_3)
	end

	local var_21_1 = {}

	for iter_21_4, iter_21_5 in ipairs((self:GetUnitListByKey(IslandConst.UNIT_LIST_CHEATER_ITEM))) do
		table.insert(var_21_1, iter_21_5.id)
	end

	for iter_21_6, iter_21_7 in ipairs(var_21_1) do
		self:OnRemoveUnit(IslandConst.UNIT_LIST_CHEATER_ITEM, iter_21_7)
	end

	return
end

function IslandCheaterTavernGameView:InitSceneGameObject()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(IslandCheaterTavernConst.deskCharIdList) do
		if pg.island_world_objects[iter_22_1].unitId > 0 then
			table.insert(var_22_0, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[iter_22_1], {
				typ = IslandConst.UNIT_TYPE_CHEATERTAVERN_CHAIR,
				index = iter_22_0
			})))
		end
	end

	table.insert(var_22_0, (IslandDataConvertor.WorldObj2IslandUnit(pg.island_world_objects[IslandCheaterTavernConst.deskTableId], {
		typ = IslandConst.UNIT_TYPE_CHEATERTAVERN_TABLE
	})))

	for iter_22_2, iter_22_3 in ipairs(var_22_0) do
		self:OnGenUnit(iter_22_3)
	end

	return
end

function IslandCheaterTavernGameView:RestartGame()
	return
end

function IslandCheaterTavernGameView:OnEndPerformance()
	return
end

function IslandCheaterTavernGameView:DisableOp()
	return
end

function IslandCheaterTavernGameView:EnableOp()
	return
end

function IslandCheaterTavernGameView:OnDispose()
	for iter_27_0, iter_27_1 in ipairs(self.views) do
		iter_27_1:Dispose()
	end

	self.weatherSystem:Dispose()

	return
end

function IslandCheaterTavernGameView:OnRemoveUnit(arg_28_1, arg_28_2)
	local var_28_0 = self:GetUnitListByKey(arg_28_1)
	local var_28_1 = 0

	for iter_28_0, iter_28_1 in ipairs(var_28_0 or {}) do
		if iter_28_1.id == arg_28_2 then
			var_28_1 = iter_28_0

			break
		end
	end

	if var_28_1 > 0 then
		self:RemoveUnit(var_28_0[var_28_1])
		var_28_0[var_28_1]:Dispose()
	end

	return
end

function IslandCheaterTavernGameView:OnAllPageClose()
	self.anyPageOpen = false

	return
end

function IslandCheaterTavernGameView:OnAnyPageOpen(arg_30_1)
	self.anyPageOpen = true

	return
end

function IslandCheaterTavernGameView:OnUnTracking(arg_31_1)
	return
end

return IslandCheaterTavernGameView
