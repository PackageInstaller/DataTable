local ChessBoardQTEGameView = class("ChessBoardQTEGameView", ReduxView)
local var_0_1 = {
	gameState = {
		default = "default",
		name = "state",
		start = "start"
	}
}
local var_0_2 = {
	default = 0,
	start = 2,
	gameing = 3,
	settle = 4,
	countDown = 1
}

function ChessBoardQTEGameView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_QTEGameMainUI"
end

function ChessBoardQTEGameView:UIParent()
	return manager.ui.uiMain.transform
end

function ChessBoardQTEGameView:Init()
	self:BindCfgUI()

	self.controller = self.controllerEx_:GetController(var_0_1.gameState.name)
	self.gameViewList = {}
end

function ChessBoardQTEGameView:InitGameType()
	local var_4_0 = self.params_ and self.params_.playGameType

	var_4_0 = var_4_0 or math.random(1, 3)
	self.playGameType = var_4_0
end

function ChessBoardQTEGameView:OnEnter()
	self:InitGameType()

	self.nowStage = var_0_2.default

	self:InitGamePrefab()
	self:ChangeStage()
end

function ChessBoardQTEGameView:InitGamePrefab()
	self.gameViewList[self.playGameType] = self.gameViewList[self.playGameType] or _G[ChessBoardQTEGameConst.QTEGameClass[self.playGameType]].New(self, (Object.Instantiate(Asset.Load(ChessBoardQTEGameConst.QTEGamePrefab[self.playGameType]), self.gamecontentTrs_)))

	self.gameViewList[self.playGameType]:InitGame()
end

function ChessBoardQTEGameView:ChangeStage()
	self.nowStage = self.nowStage + 1

	if self.nowStage == var_0_2.start then
		self:PlayStartState()
	elseif self.nowStage == var_0_2.countDown then
		self:PlayCountDownState()
	elseif self.nowStage == var_0_2.gameing then
		self:PlayGameingState()
	elseif self.nowStage == var_0_2.settle then
		self:PlayGameSettelState()
	end
end

function ChessBoardQTEGameView:PlayStartState()
	self.controller:SetSelectedState(var_0_1.gameState.start)
	self:StopStartTimer()

	self.startTimer = Timer.New(function()
		self:ChangeStage()
	end, 1)

	self.startTimer:Start()
end

function ChessBoardQTEGameView:PlayCountDownState()
	self.gameViewList[self.playGameType]:CountDown()
end

function ChessBoardQTEGameView:PlayGameingState()
	self.controller:SetSelectedState(var_0_1.gameState.default)
	self.gameViewList[self.playGameType]:OpenGame()
end

function ChessBoardQTEGameView:PlayGameSettelState()
	local var_12_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()
	local var_12_1, var_12_2 = self.gameViewList[self.playGameType]:GetScore()
	local var_12_3 = {}

	if ChessBoardLevelCfg[var_12_0] then
		var_12_3.activity_id = ChessBoardLevelCfg[var_12_0].activity or 0
	end

	var_12_3.stage_id = self.playGameType
	var_12_3.result = var_12_1
	var_12_3.score = var_12_2

	SDKTools.SendMessageToSDK("activity_combat_over", var_12_3)
	JumpTools.OpenPageByJump("chessBoardQTEGameOverView", {
		resultType = var_12_1,
		scoreValue = var_12_2
	})
end

function ChessBoardQTEGameView:StopStartTimer()
	if self.startTimer then
		self.startTimer:Stop()

		self.startTimer = nil
	end
end

function ChessBoardQTEGameView:OnTop()
	manager.windowBar:SwitchBar({})
end

function ChessBoardQTEGameView:OnExit()
	for iter_15_0, iter_15_1 in pairs(self.gameViewList) do
		iter_15_1:OnExit()
	end

	self:StopStartTimer()
	manager.windowBar:HideBar()
end

function ChessBoardQTEGameView:Dispose()
	for iter_16_0, iter_16_1 in pairs(self.gameViewList) do
		iter_16_1:Dispose()
	end

	ChessBoardQTEGameView.super.Dispose(self)
end

return ChessBoardQTEGameView
