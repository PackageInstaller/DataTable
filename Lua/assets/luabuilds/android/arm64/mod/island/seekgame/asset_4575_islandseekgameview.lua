local IslandSeekGameView = class("IslandSeekGameView", import("Mod.Island.Core.View.IslandView"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function IslandSeekGameView:Init()
	IslandSeekGameView.super.Init(self)

	self.state = var_0_1

	self:Op("NotifiyIsland", ISLAND_EX_EVT.SEEK_GAME_START)

	return
end

function IslandSeekGameView:OnSceneInited()
	self:InitFocusCamera()
	self:DisableOp()

	local var_2_0 = self:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID)

	self.resultView = IslandSeekGameResultView.New(self, var_2_0.data:GetResultUIName())

	var_2_0:OnSceneInitEnd()

	self.isInit = true

	self:OnGameStart()

	return
end

function IslandSeekGameView:AddListeners()
	IslandSeekGameView.super.AddListeners(self)
	self:AddListener(ISLAND_EVT.SEEK_GAME_FAILED, self.OnGameFailed)
	self:AddListener(ISLAND_EVT.SEEK_GAME_SUCCESS, self.OnGameSuccess)

	return
end

function IslandSeekGameView:RemoveListeners()
	IslandSeekGameView.super.RemoveListeners(self)
	self:RemoveListener(ISLAND_EVT.SEEK_GAME_FAILED, self.OnGameFailed)
	self:RemoveListener(ISLAND_EVT.SEEK_GAME_SUCCESS, self.OnGameSuccess)

	return
end

function IslandSeekGameView:OnGameStart()
	if self.state ~= var_0_1 then
		return
	end

	self.state = var_0_2

	IslandCameraMgr.instance:LookAt(self.player._tf)
	self:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID):StartGame()
	self:EnableOp()

	return
end

function IslandSeekGameView:OnGameFailed()
	if self.state ~= var_0_2 then
		return
	end

	self.state = var_0_3

	self:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID):StopGame()
	self:DisableOp()
	self.resultView:Execute("Show")

	return
end

function IslandSeekGameView:OnGameSuccess()
	if self.state ~= var_0_2 then
		return
	end

	self.state = var_0_4

	self:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID):StopGame()

	return
end

function IslandSeekGameView:RestartGame()
	if self.state ~= var_0_3 then
		return
	end

	self.state = var_0_2

	self:GetSystemModule(IslandConst.SEEK_GAME_SYSTEM_ID):RestartGame()
	self.player:ResetPosition()
	self:EnableOp()

	return
end

function IslandSeekGameView:OnEndPerformance()
	IslandSeekGameView.super.OnEndPerformance(self)
	IslandGuideChecker.CheckGuide("ISLAND_GUIDE_30")

	return
end

function IslandSeekGameView:DisableOp()
	self.player:StopMoveHandle()
	self:GetSubView(IslandOpView):TryDisablePlayerOp()
	self:GetSubView(IslandInteractionView):DisableInteraction()
	self:GetSubView(IslandOpView):TryDisable()

	return
end

function IslandSeekGameView:EnableOp()
	self:GetSubView(IslandOpView):TryEnablePlayerOp()
	self:GetSubView(IslandInteractionView):EnableInteraction()
	self:GetSubView(IslandOpView):TryEnable()

	return
end

function IslandSeekGameView:OnDispose()
	self:Op("NotifiyIsland", ISLAND_EX_EVT.SEEK_GAME_END)
	IslandSeekGameView.super.OnDispose(self)

	if self.resultView then
		self.resultView:Dispose()

		self.resultView = nil
	end

	return
end

return IslandSeekGameView
