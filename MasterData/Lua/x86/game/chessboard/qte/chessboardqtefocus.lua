local ChessBoardQTEFocus = class("ChessBoardQTEFocus", ReduxView)

function ChessBoardQTEFocus:OnCtor(arg_1_1, arg_1_2)
	self.parent = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:InitCfgData()
	self:Init()
end

function ChessBoardQTEFocus:InitCfgData()
	local var_2_0 = ChessBoardTools.GetChessBoardGameSetting("summer_chessboard_focus_qte")

	self.rotateSpeed = var_2_0[1]
	self.succeedRangeList = {}
	self.perfectRangeList = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0[2]) do
		self.succeedRangeList[iter_2_0] = iter_2_1[1]
		self.perfectRangeList[iter_2_0] = iter_2_1[2]
	end

	self.winValue = var_2_0[3]
	self.perfectValue = var_2_0[4]
end

function ChessBoardQTEFocus:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.surebtnBtn_, nil, function()
		self:SureBtn()
	end)

	self.progressControllerList = {}

	for iter_3_0 = 1, 3 do
		self.progressControllerList[iter_3_0] = self[string.format("item%sControllerexcollection_", iter_3_0)]:GetController("state")
	end
end

function ChessBoardQTEFocus:SureBtn()
	if not self.gameStart then
		return
	end

	if self.isCheckScore then
		return
	end

	self.hitCount = self.hitCount + 1

	self:CheckScore()
	SetActive(self.pointerEffectGo_, true)

	self.isCheckScore = true

	self:StopDelayTimer()

	self.delayTimer = Timer.New(function()
		self.isCheckScore = false

		if self.hitCount == 3 then
			self:OverGame()
		else
			self:RandomTargetPos()
		end

		SetActive(self.pointerEffectGo_, false)
	end, 0.5)

	self.delayTimer:Start()
end

function ChessBoardQTEFocus:CheckScore()
	local var_7_0 = math.abs((self.targetAngle - self.succeedRangeList[self.hitCount] / 2) % 360 - self.pointAngle)

	if var_7_0 > 180 then
		var_7_0 = 360 - var_7_0
	end

	local var_7_1 = var_7_0 * 2

	if var_7_0 * 2 <= self.perfectRangeList[self.hitCount] then
		self.hitScore = self.hitScore + 2

		self.progressControllerList[self.hitCount]:SetSelectedState("green")
		self:RefreshScore()
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_chess_qte03_good", "")
	elseif var_7_1 <= self.succeedRangeList[self.hitCount] then
		self.hitScore = self.hitScore + 1

		self.progressControllerList[self.hitCount]:SetSelectedState("yellow")
		self:RefreshScore()
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_chess_qte03_normal", "")
	else
		self.progressControllerList[self.hitCount]:SetSelectedState("red")
		manager.audio:PlayEffect("minigame_activity_3_4", "minigame_activity_3_4_chess_qte03_miss", "")
	end
end

function ChessBoardQTEFocus:RandomTargetPos()
	local var_8_0 = math.random(self.pointAngle + self.succeedRangeList[self.hitCount + 1], self.pointAngle - self.succeedRangeList[self.hitCount + 1] + 360) % 360

	self.targetTrs_.eulerAngles.x = 0
	self.targetTrs_.eulerAngles.y = 0
	self.targetTrs_.eulerAngles.z = var_8_0
	self.targetTrs_.eulerAngles = self.targetTrs_.eulerAngles
	self.targetAngle = var_8_0

	self:UpdateImgShow()
end

function ChessBoardQTEFocus:UpdateImgShow()
	if self.succeedRangeList[self.hitCount + 1] and self.perfectRangeList[self.hitCount + 1] then
		self.imgyellowImg_.fillAmount = self.succeedRangeList[self.hitCount + 1] / 360
		self.imggreenImg_.fillAmount = self.perfectRangeList[self.hitCount + 1] / 360
		self.imggreenTrs_.localEulerAngles.x = 0
		self.imggreenTrs_.localEulerAngles.y = 0
		self.imggreenTrs_.localEulerAngles.z = -(self.succeedRangeList[self.hitCount + 1] - self.perfectRangeList[self.hitCount + 1]) / 2
		self.imggreenTrs_.localEulerAngles = self.imggreenTrs_.localEulerAngles
	end
end

function ChessBoardQTEFocus:RefreshScore()
	self.textnumAni_:Play("Fx_scoretext_cx", 0, 0)

	self.scoreText_.text = self.hitScore
end

function ChessBoardQTEFocus:CountDown()
	self:StopCountDownTimer()
	SetActive(self.countDownGo_, true)

	local var_11_0 = 3

	self.countTimeText_.text = 3
	self.countDownTimer = Timer.New(function()
		var_11_0 = var_11_0 - 1

		if var_11_0 == 0 then
			SetActive(self.countDownGo_, false)
			self.parent:ChangeStage()
		else
			self.countTimeText_.text = var_11_0
		end

		self.countAni_:Play("ui_CountDownTime_cx", 0, 0)
	end, 1, 3)

	self.countDownTimer:Start()
end

function ChessBoardQTEFocus:InitGame()
	self.gameStart = false

	self:InitData()
	SetActive(self.gameObject_, true)

	self.tipsText_.text = GetTips("CHESSBOARD_GAME_TIPS_2")
end

function ChessBoardQTEFocus:OpenGame()
	self.gameStart = true

	self:AddGameTimer()
end

function ChessBoardQTEFocus:InitData()
	self.hitCount = 0
	self.hitScore = 0
	self.pointAngle = 0
	self.targetAngle = 0

	for iter_15_0, iter_15_1 in pairs(self.progressControllerList) do
		iter_15_1:SetSelectedState("empty")
	end

	self:RefreshScore()
	self:RandomTargetPos()
	self:UpdateTimerShow()
end

function ChessBoardQTEFocus:OverGame()
	self.gameStart = false

	self:StopTimer()
	self.parent:ChangeStage()
end

function ChessBoardQTEFocus:GetScore()
	return self.hitScore < self.winValue and ChessBoardQTEGameConst.QTEGameResult.Lose or self.hitScore < self.perfectValue and ChessBoardQTEGameConst.QTEGameResult.Win or ChessBoardQTEGameConst.QTEGameResult.Perfect, self.hitScore
end

function ChessBoardQTEFocus:AddGameTimer()
	self:StopTimer()

	self.gameTimer = FrameTimer.New(function()
		self:UpdateTimerShow()
	end, 1, -1)

	self.gameTimer:Start()
end

function ChessBoardQTEFocus:UpdateTimerShow()
	if self.isCheckScore then
		return
	end

	self.pointAngle = (self.pointAngle - self.rotateSpeed) % 360
	self.pointerTrs_.eulerAngles.x = 0
	self.pointerTrs_.eulerAngles.y = 0
	self.pointerTrs_.eulerAngles.z = self.pointAngle
	self.pointerTrs_.eulerAngles = self.pointerTrs_.eulerAngles
end

function ChessBoardQTEFocus:StopCountDownTimer()
	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end
end

function ChessBoardQTEFocus:StopTimer()
	if self.gameTimer then
		self.gameTimer:Stop()

		self.gameTimer = nil
	end
end

function ChessBoardQTEFocus:StopDelayTimer()
	if self.delayTimer then
		self.delayTimer:Stop()

		self.delayTimer = nil
	end
end

function ChessBoardQTEFocus:OnExit()
	self:StopDelayTimer()
	self:StopCountDownTimer()
	self:StopTimer()
	SetActive(self.gameObject_, false)
end

function ChessBoardQTEFocus:Dispose()
	ChessBoardQTEFocus.super.Dispose(self)
end

return ChessBoardQTEFocus
