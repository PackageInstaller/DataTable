local var_0_0 = singletonClass("AutoChessBattleSimulator")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.actionLink = nil
	arg_1_0.status = AutoChessConst.BATTLE_STATUS.IDLE
	arg_1_0.gameType = AutoChessConst.GAME_TYPE.PVE
	arg_1_0.blackboard = nil
	arg_1_0.timer = nil
end

function var_0_0:Init(arg_2_1)
	self.status = AutoChessConst.BATTLE_STATUS.IDLE
	self.gameType = arg_2_1
	self.blackboard = AutoChessBattleBlackboard.New()

	self.blackboard:Init(arg_2_1)
	self:InitGlobalData(self.gameType)
	AutoChessBattleRenderer.GetInstance():Init(self.blackboard)

	self.isGuidePaused = false
	self.onTimeOverHandler = handler(self, self.OnTimeOver)
	self.onLoginHandler = handler(self, self.OnLogin)

	manager.notify:RegistListener(AUTO_CHESS_TIME_OVER, self.onTimeOverHandler)
	manager.notify:RegistListener(ON_LOGIN, self.onLoginHandler)

	self.isInit = true

	self:CreateNetTimer()
end

function var_0_0:InitBattleData(arg_3_1)
	self:InitGlobalData(arg_3_1)
end

function var_0_0:InitGlobalData(arg_4_1)
	self.gameStatus = AutoChessData:GetGameStatus(arg_4_1)

	if AutoChessTools.IsPrepareStatus(self.gameStatus) then
		AutoChessData:InitGlobalPrepareData(arg_4_1)
	else
		AutoChessData:InitGlobalBattleData(arg_4_1)
	end
end

function var_0_0:Dispose()
	self.status = AutoChessConst.BATTLE_STATUS.IDLE
	self.gameType = AutoChessConst.GAME_TYPE.PVE
	self.isInit = false

	manager.notify:RemoveListener(AUTO_CHESS_TIME_OVER, self.onTimeOverHandler)
	manager.notify:RemoveListener(ON_LOGIN, self.onLoginHandler)
	self:StopTimer()

	if self.blackboard then
		self.blackboard:Dispose()

		self.blackboard = nil
	end

	AutoChessBattleRenderer.GetInstance():Dispose()

	for iter_5_0, iter_5_1 in ipairs(self.actionLink or {}) do
		iter_5_1:Dispose()
	end

	self.actionLink = nil

	if self.netTimer_ then
		self.netTimer_:Stop()

		self.netTimer_ = nil
	end
end

function var_0_0:OnTimeOver()
	if AutoChessData:GetTotalSettlePlayerData() and self.status == AutoChessConst.BATTLE_STATUS.PAUSE then
		self:StopSimulator()
	end
end

function var_0_0:OnLogin()
	print("AutoChessBattleSimulator:OnLogin()")
	AutoChessData:SetIsCanReconnectAutoChess(true)
	AutoChessTools.QuitGame(self.gameType, false, {
		isShowQuitPop = true
	})
end

function var_0_0:CreateNetTimer()
	if self.netTimer_ then
		self.netTimer_:Stop()

		self.netTimer_ = nil
	end

	self.netTimer_ = Timer.New(function()
		manager.net:ForceReconnect()
	end, 1, -1)

	self.netTimer_:Start()
end

function var_0_0:GetBlackboard()
	return self.blackboard
end

function var_0_0:StartBattleSimulator()
	if not self.isInit then
		return
	end

	self:SetupActionLink()
	self.actionLink:Start()

	if self.status ~= AutoChessConst.BATTLE_STATUS.PAUSE then
		self.status = AutoChessConst.BATTLE_STATUS.PLAYING
	end

	self:StartTimer()
	self:StartGuideTimer()
end

function var_0_0:Update()
	if not self.isInit then
		return
	end

	if self.actionLink == nil then
		Debug.LogError("AutoChessBattleSimulator:Update() actionLink is nil")

		return
	end

	self:UpdateLogic()
	self:UpdateRender()

	if self.status == AutoChessConst.BATTLE_STATUS.END then
		self:StopSimulator()
	end
end

function var_0_0:UpdateLogic()
	if self.actionLink:Execute() == AutoChessConst.ACTION_NODE_STATUS.FINISH then
		self.status = AutoChessConst.BATTLE_STATUS.END
	end
end

function var_0_0.UpdateRender(arg_14_0)
	AutoChessBattleRenderer.GetInstance():Update()
end

function var_0_0:StopSimulator()
	self:ResetSimulator()

	if not AutoChessTools.IsPrepareStatus() then
		AutoChessTools.GoToSettleView(self.gameType)
		self:StopGuideTimer()
	end
end

function var_0_0:ResetSimulator()
	self.status = AutoChessConst.BATTLE_STATUS.IDLE

	self:StopTimer()
	AutoChessBattleRenderer.GetInstance():Stop()
end

function var_0_0:Pause()
	if self.status == AutoChessConst.BATTLE_STATUS.PAUSE then
		return
	end

	self.status = AutoChessConst.BATTLE_STATUS.PAUSE

	AutoChessBattleRenderer.GetInstance():Pause()
	self:StopTimer()
end

function var_0_0:Resume()
	if self.status == AutoChessConst.BATTLE_STATUS.PLAYING then
		return
	end

	self.status = AutoChessConst.BATTLE_STATUS.PLAYING

	AutoChessBattleRenderer.GetInstance():Resume()
	self:StartTimer()
end

function var_0_0:Skip()
	AutoChessBattleRenderer.GetInstance():Pause()
	self:StopSimulator()
end

function var_0_0:UpdateSettleData()
	AutoChessData:GetBattleData(self.gameType):UpdateSettleData()
end

function var_0_0:IsPlaying()
	return self.status == AutoChessConst.BATTLE_STATUS.PLAYING
end

function var_0_0:ShotDown()
	self.status = AutoChessConst.BATTLE_STATUS.END

	self:Dispose()
end

function var_0_0:GetStatus()
	return self.status
end

function var_0_0:SetupActionLink()
	if not self.isInit then
		return
	end

	self.actionLink = AutoChessActionLink.New()

	if AutoChessTools.IsPrepareStatus((self.blackboard:GetGameStatus())) then
		self:SetupPrepareActionLink()
	else
		self:SetupBattleActionLink()
	end
end

function var_0_0:SetupPrepareActionLink()
	if not self.isInit then
		return
	end

	local var_25_0 = self.blackboard:GetPrepareData()
	local var_25_1 = AutoChessRoundNode.New()

	var_25_1.Init(var_25_0, self.actionLink, self.blackboard)
	var_25_1:InitRoundData((var_25_0:GetRoundPrepareData()))
	self.actionLink:AddNode(var_25_1)
end

function var_0_0:AddPrepareActionNode(arg_26_1, arg_26_2)
	if not self.isInit then
		return
	end

	local var_26_0 = AutoChessRoundBattleDataTemplate.New()

	var_26_0:Init({
		group_id = arg_26_1,
		action_list = arg_26_2
	})

	local var_26_1 = AutoChessRoundNode.New()

	var_26_1:Init(self.actionLink, self.blackboard)
	var_26_1:InitRoundData(var_26_0)
	self.actionLink:AddNode(var_26_1)
end

function var_0_0:SetupBattleActionLink()
	if not self.isInit then
		return
	end

	local var_27_0 = self.blackboard:GetBattleData()

	for iter_27_0 = 1, var_27_0.maxRound do
		if var_27_0.roundBattleDataDic[iter_27_0] then
			local var_27_1 = AutoChessRoundNode.New()

			var_27_1:Init(self.actionLink, self.blackboard)
			var_27_1:InitRoundData(var_27_0.roundBattleDataDic[iter_27_0])
			self.actionLink:AddNode(var_27_1)
		else
			Debug.LogError("AutoChessBattleSimulator:SetupBattleActionLink roundData is nil, round:" .. tostring(iter_27_0))
		end
	end

	AutoChessBattleRecord.InitBattleRecord(var_27_0.roundBattleDataDic)
end

function var_0_0:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function var_0_0:StartTimer()
	self:StopTimer()

	if self.status == AutoChessConst.BATTLE_STATUS.PAUSE then
		return
	end

	if self.actionLink.status ~= AutoChessConst.ACTION_NODE_STATUS.RUNNING then
		return
	end

	self.timer = FrameTimer.New(function()
		self:Update()
	end, 1, -1)

	self.timer:Start()
end

function var_0_0:StartGuideTimer()
	if AutoChessData:GetGameStatus(self.gameType) == AutoChessConst.GAME_STATUS.PREPARE then
		return
	end

	self.startTimer_ = {}
	self.startTimer_ = Timer.New(function()
		if manager.guide:IsPlaying() then
			self:Pause()

			self.isGuidePaused = true
		elseif self.isGuidePaused then
			self.isGuidePaused = false

			self:Resume()
		end
	end, 0.33, -1)

	self.startTimer_:Start()
end

function var_0_0:StopGuideTimer()
	if self.startTimer_ then
		self.startTimer_:Stop()

		self.startTimer_ = nil
	end
end

function var_0_0:InitBattleRecord()
	AutoChessBattleRecord.InitBattleRecord(self.blackboard:GetBattleData())
end

return var_0_0
