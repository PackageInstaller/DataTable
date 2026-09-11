local ChessBoardQTEHitBalloon = class("ChessBoardQTEHitBalloon", ReduxView)

function ChessBoardQTEHitBalloon:OnCtor(arg_1_1, arg_1_2)
	self.parent = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:InitCfgData()
	self:Init()
end

function ChessBoardQTEHitBalloon:InitCfgData()
	local var_2_0 = ChessBoardTools.GetChessBoardGameSetting("summer_chessboard_balloon_qte")

	self.gameTime = var_2_0[1]
	self.maxExistCount = var_2_0[2]
	self.winValue = var_2_0[3]
	self.perfectValue = var_2_0[4]
end

local var_0_1 = Vector2(9999, 9999)

function ChessBoardQTEHitBalloon:Init()
	self:BindCfgUI()

	self.balloonList = {}
	self.usePosList = {}
	self.effectList = {}
	self.clickHandle_ = handler(self, self.HitBalloonItem)

	for iter_3_0 = 1, self.maxExistCount do
		self.balloonList[iter_3_0] = ChessBoardQTEBallonItem.New(self[string.format("bubbles%sGo_", iter_3_0)], iter_3_0)

		self.balloonList[iter_3_0]:SetBtnClick(self.clickHandle_)
	end

	for iter_3_1 = 1, self.bubbleeffectlistTrs_.childCount do
		self.effectList[iter_3_1] = self:CreateEffectItem(iter_3_1)
	end

	self.ballWidth = self.bubbles1Go_.transform.sizeDelta.x / 2
	self.ballHeight = self.bubbles1Go_.transform.sizeDelta.y / 2
end

function ChessBoardQTEHitBalloon:CreateEffectItem(arg_4_1)
	local var_4_0 = {
		transform = self.bubbleeffectlistTrs_:GetChild(arg_4_1 - 1)
	}

	var_4_0.animator = var_4_0.transform:GetComponent("Animator")

	return var_4_0
end

function ChessBoardQTEHitBalloon:CheckIsNotMeetPos(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	return math.abs(arg_5_1 - arg_5_3) < self.ballWidth and math.abs(arg_5_2 - arg_5_4) < self.ballHeight - 50
end

function ChessBoardQTEHitBalloon:CalculateBalloonPos(arg_6_1, arg_6_2)
	if not arg_6_1 then
		return var_0_1
	end

	local var_6_0 = self.bubblecontentTrs_.rect.height / 2 - self.ballHeight
	local var_6_1 = self.balloonList[arg_6_2].posX
	local var_6_2 = self.balloonList[arg_6_2].posY

	while 100 > 0 do
		local var_6_3 = math.random(-(self.bubblecontentTrs_.rect.width / 2) + self.ballWidth, self.bubblecontentTrs_.rect.width / 2 - self.ballWidth)
		local var_6_4 = math.random(-(self.bubblecontentTrs_.rect.height / 2) + self.ballHeight, var_6_0)
		local var_6_5 = true

		for iter_6_0, iter_6_1 in pairs(self.balloonList) do
			if self:CheckIsNotMeetPos(var_6_3, var_6_4, iter_6_1.posX or 9999, iter_6_1.posY or 9999) then
				var_6_5 = false

				break
			end
		end

		if var_6_5 then
			var_6_2 = var_6_4
			var_6_1 = var_6_3

			break
		end
	end

	return Vector2(var_6_1, var_6_2)
end

function ChessBoardQTEHitBalloon:HitBalloonItem(arg_7_1)
	if not self.gameStart then
		return
	end

	if arg_7_1.hitState == true then
		return
	end

	self.hitCount = self.hitCount + 1
	arg_7_1.hitState = true

	self:ShowEffect(arg_7_1.transform_.localPosition)
	self:RefreshScore()
	arg_7_1:ClickEffect()
	self:ShowBalloon(arg_7_1.index)
end

function ChessBoardQTEHitBalloon:ShowBalloon(arg_8_1)
	local var_8_0 = self:CalculateBalloonPos(true, arg_8_1)

	self.balloonList[arg_8_1]:SetPos(var_8_0)

	self.balloonList[arg_8_1].hitState = false
	self.balloonList[arg_8_1].posX = var_8_0.x
	self.balloonList[arg_8_1].posY = var_8_0.y
end

function ChessBoardQTEHitBalloon:ShowEffect(arg_9_1)
	for iter_9_0, iter_9_1 in pairs(self.effectList) do
		if iter_9_1.animator:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			iter_9_1.animator:Play("ui_bloom_cx", 0, 0)

			iter_9_1.transform.localPosition = arg_9_1

			break
		end
	end
end

function ChessBoardQTEHitBalloon:RefreshScore()
	self.textnumAni_:Play("Fx_scoretext_cx", 0, 0)

	self.scoreText_.text = self.hitCount
end

function ChessBoardQTEHitBalloon:CountDown()
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

function ChessBoardQTEHitBalloon:InitGame()
	self.gameStart = false

	SetActive(self.gameObject_, true)
	self:InitData()

	self.tipsText_.text = GetTips("CHESSBOARD_GAME_TIPS_3")
end

function ChessBoardQTEHitBalloon:OpenGame()
	self:AddGameTimer()

	self.gameStart = true
end

function ChessBoardQTEHitBalloon:InitData()
	self.nowTimes = self.gameTime
	self.hitCount = 0

	for iter_15_0 = 1, self.maxExistCount do
		self:ShowBalloon(iter_15_0)
	end

	self:RefreshScore()

	self.remaintimeText_.text = string.format("%ss", self.nowTimes)
end

function ChessBoardQTEHitBalloon:OverGame()
	self:StopTimer()
	self.parent:ChangeStage()

	self.gameStart = false
end

function ChessBoardQTEHitBalloon:GetScore()
	return self.hitCount < self.winValue and ChessBoardQTEGameConst.QTEGameResult.Lose or self.hitCount < self.perfectValue and ChessBoardQTEGameConst.QTEGameResult.Win or ChessBoardQTEGameConst.QTEGameResult.Perfect, self.hitCount
end

function ChessBoardQTEHitBalloon:AddGameTimer()
	self:StopTimer()

	self.remaintimeText_.text = string.format("%ss", self.nowTimes)
	self.gameTimer = Timer.New(function()
		self:UpdateTimerShow()
	end, 1, self.gameTime)

	self.gameTimer:Start()
end

function ChessBoardQTEHitBalloon:UpdateTimerShow()
	self.nowTimes = self.nowTimes - 1
	self.remaintimeText_.text = string.format("%ss", self.nowTimes)

	if self.nowTimes == 0 then
		self:OverGame()
	end
end

function ChessBoardQTEHitBalloon:StopTimer()
	if self.gameTimer then
		self.gameTimer:Stop()

		self.gameTimer = nil
	end
end

function ChessBoardQTEHitBalloon:StopCountDownTimer()
	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end
end

function ChessBoardQTEHitBalloon:OnExit()
	for iter_23_0, iter_23_1 in pairs(self.effectList) do
		iter_23_1.animator:Play("ui_bloom_yc", 0, 0)
	end

	self:StopCountDownTimer()
	self:StopTimer()
	SetActive(self.gameObject_, false)
end

function ChessBoardQTEHitBalloon:Dispose()
	for iter_24_0, iter_24_1 in pairs(self.balloonList) do
		iter_24_1:Dispose()

		iter_24_1 = nil
	end

	ChessBoardQTEHitBalloon.super.Dispose(self)
end

return ChessBoardQTEHitBalloon
