local ChessBoardQTEPower = class("ChessBoardQTEPower", ReduxView)

function ChessBoardQTEPower:OnCtor(arg_1_1, arg_1_2)
	self.parent = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:InitCfgData()
	self:Init()
end

function ChessBoardQTEPower:InitCfgData()
	local var_2_0 = ChessBoardTools.GetChessBoardGameSetting("summer_chessboard_power_qte")

	self.gameTime = var_2_0[1]
	self.hitLvBook = {}

	for iter_2_0, iter_2_1 in pairs(var_2_0[2] or {}) do
		self.hitLvBook[iter_2_0 - 1] = iter_2_1
	end

	self.winValue = var_2_0[3]
	self.perfectValue = var_2_0[4]
end

function ChessBoardQTEPower:Init()
	self:BindCfgUI()

	self.cellItemList = {}

	for iter_3_0 = 1, 10 do
		self.cellItemList[iter_3_0] = self[string.format("image%sImg_", iter_3_0)]
	end

	self.bloomAniList = {}

	for iter_3_1 = 1, 10 do
		self.bloomAniList[iter_3_1] = self[string.format("bloom%sAni_", iter_3_1)]
	end

	self:AddBtnListener(self.hitareaBtn_, nil, function()
		self:HitButton()
	end)
end

function ChessBoardQTEPower:HitButton()
	if not self.gameStart then
		return
	end

	local var_5_0 = self.btnAni_:GetCurrentAnimatorStateInfo(0)

	self.btnAni_:Play("ui_Btn_bloom_cx", 0, 0)
	SetActive(self.imgcircleGo_, true)

	self.hitCount = self.hitCount + 1

	if self.hitLvBook[self.hitLv + 1] then
		self.cellItemList[self.hitLv + 1].fillAmount = (self.hitCount - self.hitLvBook[self.hitLv]) / (self.hitLvBook[self.hitLv + 1] - self.hitLvBook[self.hitLv])

		if self.hitCount == self.hitLvBook[self.hitLv + 1] then
			self.hitLv = self.hitLv + 1
		end
	end

	self:PlayClickEffect()
end

function ChessBoardQTEPower:PlayClickEffect()
	for iter_6_0, iter_6_1 in pairs(self.bloomAniList) do
		if iter_6_1:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			iter_6_1:Play("ui_bloom_cx", 0, 0)

			break
		end
	end
end

function ChessBoardQTEPower:CountDown()
	self:StopCountDownTimer()

	local var_7_0 = 3

	self.countDown1Text_.text = 3
	self.countDown2Text_.text = 3

	self.countdownAni_:Play("ui_CountDown1_cx", 0, 0)

	self.countDownTimer = Timer.New(function()
		var_7_0 = var_7_0 - 1

		if var_7_0 == 0 then
			self.parent:ChangeStage()

			self.countDown1Text_.text = ""
			self.countDown2Text_.text = ""
		else
			self.countDown1Text_.text = var_7_0
			self.countDown2Text_.text = var_7_0
		end

		if var_7_0 == 2 then
			self.countdownAni_:Play("ui_CountDown2_cx", 0, 0)
		elseif var_7_0 == 1 then
			self.countdownAni_:Play("ui_CountDown3_cx", 0, 0)
		end

		self.countAni_:Play("ui_textNum01_cx", 0, 0)
	end, 1, 3)

	self.countDownTimer:Start()
end

function ChessBoardQTEPower:InitGame()
	self.gameStart = false

	SetActive(self.gameObject_, true)
	self:InitData()

	self.tipsText_.text = GetTips("CHESSBOARD_GAME_TIPS_1")
end

function ChessBoardQTEPower:OpenGame()
	self:AddGameTimer()

	self.gameStart = true
end

function ChessBoardQTEPower:InitData()
	self.nowTimes = self.gameTime
	self.hitCount = 0
	self.hitLv = 0

	for iter_11_0 = 1, 10 do
		self.cellItemList[iter_11_0].fillAmount = 0
	end

	self.remaintimeText_.text = string.format("%ss", self.nowTimes)
end

function ChessBoardQTEPower:OverGame()
	self:StopTimer()
	self.parent:ChangeStage()

	self.gameStart = false
end

function ChessBoardQTEPower:GetScore()
	return self.hitLv <= self.winValue and ChessBoardQTEGameConst.QTEGameResult.Lose or self.hitLv <= self.perfectValue and ChessBoardQTEGameConst.QTEGameResult.Win or ChessBoardQTEGameConst.QTEGameResult.Perfect, self.hitLv
end

function ChessBoardQTEPower:AddGameTimer()
	self:StopTimer()

	self.nowHitCount = -1
	self.remaintimeText_.text = string.format("%ss", self.nowTimes)
	self.gameTimer = Timer.New(function()
		self:CheckEffectShow()
		self:UpdateTimerShow()
	end, 1, self.gameTime)

	self.gameTimer:Start()
end

function ChessBoardQTEPower:CheckEffectShow()
	if self.nowHitCount >= self.hitCount and self.imgcircleGo_.activeSelf == true then
		SetActive(self.imgcircleGo_, false)
		self.huanAni_:Play("ui_huan_xs", 0, 0)
	end

	self.nowHitCount = self.hitCount
end

function ChessBoardQTEPower:UpdateTimerShow()
	self.nowTimes = self.nowTimes - 1
	self.remaintimeText_.text = string.format("%ss", self.nowTimes)

	if self.nowTimes == 0 then
		self:OverGame()
	end
end

function ChessBoardQTEPower:StopTimer()
	if self.gameTimer then
		self.gameTimer:Stop()

		self.gameTimer = nil
	end
end

function ChessBoardQTEPower:StopCountDownTimer()
	if self.countDownTimer then
		self.countDownTimer:Stop()

		self.countDownTimer = nil
	end
end

function ChessBoardQTEPower:OnExit()
	for iter_20_0, iter_20_1 in pairs(self.bloomAniList) do
		iter_20_1:Play("ui_bloom_yc", 0, 0)
	end

	self:StopTimer()
	self:StopCountDownTimer()
	SetActive(self.gameObject_, false)
end

function ChessBoardQTEPower:Dispose()
	ChessBoardQTEPower.super.Dispose(self)
end

return ChessBoardQTEPower
