local var_0_0 = singletonClass("AutoChessBattleSimulator")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.actionLink = nil
	arg_1_0.status = AutoChessConst.BATTLE_STATUS.IDLE
	arg_1_0.gameType = AutoChessConst.GAME_TYPE.PVE
	arg_1_0.blackboard = nil
	arg_1_0.timer = nil
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.status = AutoChessConst.BATTLE_STATUS.IDLE
	arg_2_0.gameType = arg_2_1
	arg_2_0.blackboard = AutoChessBattleBlackboard.New()

	arg_2_0.blackboard:Init(arg_2_1)
	arg_2_0:InitGlobalData(arg_2_0.gameType)
	AutoChessBattleRenderer.GetInstance():Init(arg_2_0.blackboard)

	arg_2_0.isGuidePaused = false
	arg_2_0.onTimeOverHandler = handler(arg_2_0, arg_2_0.OnTimeOver)
	arg_2_0.onLoginHandler = handler(arg_2_0, arg_2_0.OnLogin)

	manager.notify:RegistListener(AUTO_CHESS_TIME_OVER, arg_2_0.onTimeOverHandler)
	manager.notify:RegistListener(ON_LOGIN, arg_2_0.onLoginHandler)

	arg_2_0.isInit = true

	arg_2_0:CreateNetTimer()
end

function var_0_0.InitBattleData(arg_3_0, arg_3_1)
	arg_3_0:InitGlobalData(arg_3_1)
end

function var_0_0.InitGlobalData(arg_4_0, arg_4_1)
	arg_4_0.gameStatus = AutoChessData:GetGameStatus(arg_4_1)

	if AutoChessTools.IsPrepareStatus(arg_4_0.gameStatus) then
		AutoChessData:InitGlobalPrepareData(arg_4_1)
	else
		AutoChessData:InitGlobalBattleData(arg_4_1)
	end
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.status = AutoChessConst.BATTLE_STATUS.IDLE
	arg_5_0.gameType = AutoChessConst.GAME_TYPE.PVE
	arg_5_0.isInit = false

	manager.notify:RemoveListener(AUTO_CHESS_TIME_OVER, arg_5_0.onTimeOverHandler)
	manager.notify:RemoveListener(ON_LOGIN, arg_5_0.onLoginHandler)
	arg_5_0:StopTimer()

	if arg_5_0.blackboard then
		arg_5_0.blackboard:Dispose()

		arg_5_0.blackboard = nil
	end

	AutoChessBattleRenderer.GetInstance():Dispose()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.actionLink or {}) do
		iter_5_1:Dispose()
	end

	arg_5_0.actionLink = nil

	if arg_5_0.netTimer_ then
		arg_5_0.netTimer_:Stop()

		arg_5_0.netTimer_ = nil
	end
end

function var_0_0.OnTimeOver(arg_6_0)
	if AutoChessData:GetTotalSettlePlayerData() and arg_6_0.status == AutoChessConst.BATTLE_STATUS.PAUSE then
		arg_6_0:StopSimulator()
	end
end

function var_0_0.OnLogin(arg_7_0)
	print("AutoChessBattleSimulator:OnLogin()")
	AutoChessData:SetIsCanReconnectAutoChess(true)
	AutoChessTools.QuitGame(arg_7_0.gameType, false, {
		isShowQuitPop = true
	})
end

function var_0_0.CreateNetTimer(arg_8_0)
	if arg_8_0.netTimer_ then
		arg_8_0.netTimer_:Stop()

		arg_8_0.netTimer_ = nil
	end

	arg_8_0.netTimer_ = Timer.New(function()
		manager.net:ForceReconnect()
	end, 1, -1)

	arg_8_0.netTimer_:Start()
end

function var_0_0.GetBlackboard(arg_10_0)
	return arg_10_0.blackboard
end

function var_0_0.StartBattleSimulator(arg_11_0)
	if not arg_11_0.isInit then
		return
	end

	arg_11_0:SetupActionLink()
	arg_11_0.actionLink:Start()

	if arg_11_0.status ~= AutoChessConst.BATTLE_STATUS.PAUSE then
		arg_11_0.status = AutoChessConst.BATTLE_STATUS.PLAYING
	end

	arg_11_0:StartTimer()
	arg_11_0:StartGuideTimer()
end

function var_0_0.Update(arg_12_0)
	if not arg_12_0.isInit then
		return
	end

	if arg_12_0.actionLink == nil then
		Debug.LogError("AutoChessBattleSimulator:Update() actionLink is nil")

		return
	end

	arg_12_0:UpdateLogic()
	arg_12_0:UpdateRender()

	if arg_12_0.status == AutoChessConst.BATTLE_STATUS.END then
		arg_12_0:StopSimulator()
	end
end

function var_0_0.UpdateLogic(arg_13_0)
	if arg_13_0.actionLink:Execute() == AutoChessConst.ACTION_NODE_STATUS.FINISH then
		arg_13_0.status = AutoChessConst.BATTLE_STATUS.END
	end
end

function var_0_0.UpdateRender(arg_14_0)
	AutoChessBattleRenderer.GetInstance():Update()
end

function var_0_0.StopSimulator(arg_15_0)
	arg_15_0:ResetSimulator()

	if not AutoChessTools.IsPrepareStatus() then
		AutoChessTools.GoToSettleView(arg_15_0.gameType)
		arg_15_0:StopGuideTimer()
	end
end

function var_0_0.ResetSimulator(arg_16_0)
	arg_16_0.status = AutoChessConst.BATTLE_STATUS.IDLE

	arg_16_0:StopTimer()
	AutoChessBattleRenderer.GetInstance():Stop()
end

function var_0_0.Pause(arg_17_0)
	if arg_17_0.status == AutoChessConst.BATTLE_STATUS.PAUSE then
		return
	end

	arg_17_0.status = AutoChessConst.BATTLE_STATUS.PAUSE

	AutoChessBattleRenderer.GetInstance():Pause()
	arg_17_0:StopTimer()
end

function var_0_0.Resume(arg_18_0)
	if arg_18_0.status == AutoChessConst.BATTLE_STATUS.PLAYING then
		return
	end

	arg_18_0.status = AutoChessConst.BATTLE_STATUS.PLAYING

	AutoChessBattleRenderer.GetInstance():Resume()
	arg_18_0:StartTimer()
end

function var_0_0.Skip(arg_19_0)
	AutoChessBattleRenderer.GetInstance():Pause()
	arg_19_0:StopSimulator()
end

function var_0_0.UpdateSettleData(arg_20_0)
	AutoChessData:GetBattleData(arg_20_0.gameType):UpdateSettleData()
end

function var_0_0.IsPlaying(arg_21_0)
	return arg_21_0.status == AutoChessConst.BATTLE_STATUS.PLAYING
end

function var_0_0.ShotDown(arg_22_0)
	arg_22_0.status = AutoChessConst.BATTLE_STATUS.END

	arg_22_0:Dispose()
end

function var_0_0.GetStatus(arg_23_0)
	return arg_23_0.status
end

function var_0_0.SetupActionLink(arg_24_0)
	if not arg_24_0.isInit then
		return
	end

	arg_24_0.actionLink = AutoChessActionLink.New()

	local var_24_0 = arg_24_0.blackboard:GetGameStatus()

	if AutoChessTools.IsPrepareStatus(var_24_0) then
		arg_24_0:SetupPrepareActionLink()
	else
		arg_24_0:SetupBattleActionLink()
	end
end

function var_0_0.SetupPrepareActionLink(arg_25_0)
	if not arg_25_0.isInit then
		return
	end

	local var_25_0 = arg_25_0.blackboard:GetPrepareData():GetRoundPrepareData()
	local var_25_1 = AutoChessRoundNode.New()

	var_25_1:Init(arg_25_0.actionLink, arg_25_0.blackboard)
	var_25_1:InitRoundData(var_25_0)
	arg_25_0.actionLink:AddNode(var_25_1)
end

function var_0_0.AddPrepareActionNode(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_0.isInit then
		return
	end

	local var_26_0 = AutoChessRoundBattleDataTemplate.New()

	var_26_0:Init({
		group_id = arg_26_1,
		action_list = arg_26_2
	})

	local var_26_1 = AutoChessRoundNode.New()

	var_26_1:Init(arg_26_0.actionLink, arg_26_0.blackboard)
	var_26_1:InitRoundData(var_26_0)
	arg_26_0.actionLink:AddNode(var_26_1)
end

function var_0_0.SetupBattleActionLink(arg_27_0)
	if not arg_27_0.isInit then
		return
	end

	local var_27_0 = arg_27_0.blackboard:GetBattleData()
	local var_27_1 = var_27_0.maxRound

	for iter_27_0 = 1, var_27_1 do
		local var_27_2 = var_27_0.roundBattleDataDic[iter_27_0]

		if var_27_2 then
			local var_27_3 = AutoChessRoundNode.New()

			var_27_3:Init(arg_27_0.actionLink, arg_27_0.blackboard)
			var_27_3:InitRoundData(var_27_2)
			arg_27_0.actionLink:AddNode(var_27_3)
		else
			Debug.LogError("AutoChessBattleSimulator:SetupBattleActionLink roundData is nil, round:" .. tostring(iter_27_0))
		end
	end

	AutoChessBattleRecord.InitBattleRecord(var_27_0.roundBattleDataDic)
end

function var_0_0.StopTimer(arg_28_0)
	if arg_28_0.timer then
		arg_28_0.timer:Stop()

		arg_28_0.timer = nil
	end
end

function var_0_0.StartTimer(arg_29_0)
	arg_29_0:StopTimer()

	if arg_29_0.status == AutoChessConst.BATTLE_STATUS.PAUSE then
		return
	end

	if arg_29_0.actionLink.status ~= AutoChessConst.ACTION_NODE_STATUS.RUNNING then
		return
	end

	arg_29_0.timer = FrameTimer.New(function()
		arg_29_0:Update()
	end, 1, -1)

	arg_29_0.timer:Start()
end

function var_0_0.StartGuideTimer(arg_31_0)
	if AutoChessData:GetGameStatus(arg_31_0.gameType) == AutoChessConst.GAME_STATUS.PREPARE then
		return
	end

	arg_31_0.startTimer_ = {}
	arg_31_0.startTimer_ = Timer.New(function()
		if manager.guide:IsPlaying() then
			arg_31_0:Pause()

			arg_31_0.isGuidePaused = true
		elseif arg_31_0.isGuidePaused then
			arg_31_0.isGuidePaused = false

			arg_31_0:Resume()
		end
	end, 0.33, -1)

	arg_31_0.startTimer_:Start()
end

function var_0_0.StopGuideTimer(arg_33_0)
	if arg_33_0.startTimer_ then
		arg_33_0.startTimer_:Stop()

		arg_33_0.startTimer_ = nil
	end
end

function var_0_0.InitBattleRecord(arg_34_0)
	AutoChessBattleRecord.InitBattleRecord(arg_34_0.blackboard:GetBattleData())
end

return var_0_0
