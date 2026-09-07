local IslandMinigameCore = class("IslandMinigameCore", import(".IslandCore"))

function IslandMinigameCore:Ctor(arg_1_1, arg_1_2, arg_1_3)
	IslandMinigameCore.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3)

	self.showBalance = arg_1_3

	return
end

function IslandMinigameCore:SetIslandViewCoponent(arg_2_1)
	self.viewCoponent = arg_2_1

	return
end

function IslandMinigameCore:SetIsReconected(arg_3_1)
	self.isReconected = arg_3_1

	return
end

function IslandMinigameCore:OnInit()
	self:LoadMiniGameMainPage()

	return
end

function IslandMinigameCore:GetSceneLoader()
	return IslandMiniGameSceneLoader.New()
end

function IslandMinigameCore:Update()
	if not self:IsInit() then
		return
	end

	self.controller:Update()
	self.view:Update()

	if self.callback and self.view:IsLoaded() and self.miniGameUILoaded then
		Timer.New(function()
			if self.isReconected then
				pg.m02:sendNotification(GAME.PLAY_ROOM_ALL_LOAD_OVER)
			else
				pg.m02:sendNotification(GAME.PLAY_ROOM_LOAD_SCENE_COMPLETE)
			end

			return
		end, 2, 0):Start()
		self.callback()

		self.callback = nil
	end

	if self.initCallback and self.view:IsInit() then
		self.initCallback()

		self.initCallback = nil
	end

	return
end

function IslandMinigameCore:OnChangeMiniGameScene(arg_8_1)
	if arg_8_1 then
		setActive(self.miniGameUI, true)
		self.viewCoponent:OpenPage(IslandCheaterTavernMainPage, self.miniGameUI, isReConnected)
		onNextTick(function()
			self.view:AfterCoreInit()

			if self.isReconected then
				pg.m02:sendNotification(GAME.ISLAND_CHEATER_RECONECTING)
			end

			return
		end)
	else
		CheatTavernCameraMgr.instance._mainCamera.enabled = false

		self.viewCoponent:OpenPage(IslandCheaterTavernMainPage, self.miniGameUI, isReConnected)

		CheatTavernCameraMgr.instance._mainCamera.enabled = true
	end

	return
end

function IslandMinigameCore:LoadMiniGameMainPage()
	self.miniGameUI = nil
	self.miniGameUILoaded = false

	PoolMgr.GetInstance():GetUI(self:GetMiniGameUI(), true, function(arg_11_0)
		self.miniGameUILoaded = true
		self.miniGameUI = arg_11_0

		self.viewCoponent:SetUIParent(self.miniGameUI)
		setActive(self.miniGameUI, false)

		return
	end)

	return
end

function IslandMinigameCore:GetMiniGameUI()
	return "IslandCheaterTavernMainUI"
end

function IslandMinigameCore:Dispose(arg_13_1)
	IslandMinigameCore.super.Dispose(self, arg_13_1)
	GameObject.Destroy(self.miniGameUI)

	return
end

return IslandMinigameCore
