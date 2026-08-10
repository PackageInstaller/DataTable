local var_0_0 = class("ChessBoardQTEGameView", ReduxView)
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

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_QTEGameMainUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.controller = arg_3_0.controllerEx_:GetController(var_0_1.gameState.name)
	arg_3_0.gameViewList = {}
end

function var_0_0.InitGameType(arg_4_0)
	local var_4_0 = arg_4_0.params_ and arg_4_0.params_.playGameType

	var_4_0 = var_4_0 or math.random(1, 3)
	arg_4_0.playGameType = var_4_0
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:InitGameType()

	arg_5_0.nowStage = var_0_2.default

	arg_5_0:InitGamePrefab()
	arg_5_0:ChangeStage()
end

function var_0_0.InitGamePrefab(arg_6_0)
	local var_6_0 = arg_6_0.playGameType

	if not arg_6_0.gameViewList[var_6_0] then
		local var_6_1 = _G[ChessBoardQTEGameConst.QTEGameClass[var_6_0]]
		local var_6_2 = ChessBoardQTEGameConst.QTEGamePrefab[var_6_0]
		local var_6_3 = Asset.Load(var_6_2)
		local var_6_4 = Object.Instantiate(var_6_3, arg_6_0.gamecontentTrs_)

		arg_6_0.gameViewList[var_6_0] = var_6_1.New(arg_6_0, var_6_4)
	end

	arg_6_0.gameViewList[var_6_0]:InitGame()
end

function var_0_0.ChangeStage(arg_7_0)
	arg_7_0.nowStage = arg_7_0.nowStage + 1

	if arg_7_0.nowStage == var_0_2.start then
		arg_7_0:PlayStartState()
	elseif arg_7_0.nowStage == var_0_2.countDown then
		arg_7_0:PlayCountDownState()
	elseif arg_7_0.nowStage == var_0_2.gameing then
		arg_7_0:PlayGameingState()
	elseif arg_7_0.nowStage == var_0_2.settle then
		arg_7_0:PlayGameSettelState()
	end
end

function var_0_0.PlayStartState(arg_8_0)
	arg_8_0.controller:SetSelectedState(var_0_1.gameState.start)
	arg_8_0:StopStartTimer()

	arg_8_0.startTimer = Timer.New(function()
		arg_8_0:ChangeStage()
	end, 1)

	arg_8_0.startTimer:Start()
end

function var_0_0.PlayCountDownState(arg_10_0)
	arg_10_0.gameViewList[arg_10_0.playGameType]:CountDown()
end

function var_0_0.PlayGameingState(arg_11_0)
	arg_11_0.controller:SetSelectedState(var_0_1.gameState.default)

	local var_11_0 = arg_11_0.playGameType

	arg_11_0.gameViewList[var_11_0]:OpenGame()
end

function var_0_0.PlayGameSettelState(arg_12_0)
	local var_12_0 = ChessBoardData:GetCurrentPlayingChessBoardLevelID()
	local var_12_1, var_12_2 = arg_12_0.gameViewList[arg_12_0.playGameType]:GetScore()

	SDKTools.SendMessageToSDK("activity_combat_over", {
		activity_id = ChessBoardLevelCfg[var_12_0] and ChessBoardLevelCfg[var_12_0].activity or 0,
		stage_id = arg_12_0.playGameType,
		result = var_12_1,
		score = var_12_2
	})
	JumpTools.OpenPageByJump("chessBoardQTEGameOverView", {
		resultType = var_12_1,
		scoreValue = var_12_2
	})
end

function var_0_0.StopStartTimer(arg_13_0)
	if arg_13_0.startTimer then
		arg_13_0.startTimer:Stop()

		arg_13_0.startTimer = nil
	end
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.OnExit(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.gameViewList) do
		iter_15_1:OnExit()
	end

	arg_15_0:StopStartTimer()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.gameViewList) do
		iter_16_1:Dispose()
	end

	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
