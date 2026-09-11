local SnowballGameInfoSubView = class("SnowballGameInfoSubView", BaseView)

function SnowballGameInfoSubView:Ctor(arg_1_1)
	SnowballGameInfoSubView.super.Ctor(self)

	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.bubbleDisplayCountdown = 0

	self:BindCfgUI()

	self.modeController = ControllerUtil.GetController(self.transform_, "mode")
	self.hitList = {}
	self.scoreBubble = {}

	self:BindCfgUI(self.scoreBubble_, self.scoreBubble)

	self.scoreBubble.obj = self.scoreBubble_
	self.scoreBubble.trs = self.scoreBubble_.transform
	self.scoreBubble.modeController = ControllerUtil.GetController(self.scoreBubble_.transform, "type")

	function self.scoreBubble:Show(arg_2_1, arg_2_2, arg_2_3)
		self.obj:SetActive(false)

		self.bubbleDisplayCountdown = 2.5

		local var_2_0 = string.format("%+d", arg_2_2)

		self.score1_.text = var_2_0
		self.score2_.text = var_2_0
		self.score3_.text = var_2_0

		self.modeController:SetSelectedState(arg_2_1)

		local var_2_1, var_2_2 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.trs.parent, UnityEngine.RectTransformUtility.WorldToScreenPoint(UnityEngine.Camera.main, arg_2_3), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, nil)

		self.trs.localPosition = var_2_2

		self.obj:SetActive(true)
	end

	function self.scoreBubble:Hide()
		self.obj:SetActive(false)
	end
end

function SnowballGameInfoSubView:Update(arg_4_1)
	if not self.started then
		return
	end

	self.totalTime = math.max(0, self.totalTime - arg_4_1)
	self.time_.text = string.format("%2d", math.ceil(self.totalTime))
	self.countdown = math.max(0, self.countdown - arg_4_1)

	if self.countdown < 5 and self.modeController:GetSelectedState() == "times" then
		self.modeController:SetSelectedState("refresh")
	end

	if self.modeController:GetSelectedState() == "times" then
		self.waveTimeBar_.fillAmount = 1 - self.countdown / self.curWaveDuration
	else
		self.countdownText_.text = GetTipsF(self.hasNextWave and "ACTIVITY_SNOWBALL_REFRESH_ENEMY" or "ACTIVITY_SNOWBALL_GAME_END", math.ceil(self.countdown))
	end

	local var_4_0 = self.bubbleDisplayCountdown - arg_4_1

	if self.bubbleDisplayCountdown >= 0 and var_4_0 < 0 then
		self.scoreBubble:Hide()
	end

	self.bubbleDisplayCountdown = var_4_0
end

function SnowballGameInfoSubView:OnEnter(arg_5_1)
	self.score = 0
	self.started = false
	self.level = arg_5_1.level
	self.totalTime = SnowballGameCfg[self.level].time_limit
	self.hitGuest = 0

	self:RegistEventListener(SNOWBALL_GAME_HIT, handler(self, self.UpdateScore))
	self:RegistEventListener(SNOWBALL_GAME_TARGET_NEW_WAVE, handler(self, self.UpdateWave))
	self:RegistEventListener(SNOWBALL_GAME_PLAYER_HIT_GUEST, function()
		self.hitGuest = self.hitGuest + 1
	end)

	self.score_.text = string.format("%d", self.score)
end

function SnowballGameInfoSubView:OnExit()
	self.hitList = {}

	self:RemoveAllEventListener()
	self.scoreBubble:Hide()
end

function SnowballGameInfoSubView:OnGameStart()
	self.started = true
	self.hitGuest = 0
	self.score = 0
	self.score_.text = string.format("%d", self.score)
end

function SnowballGameInfoSubView:UpdateScore(arg_9_1, arg_9_2, arg_9_3)
	local var_9_1 = SnowballGameUnitCfg[arg_9_1.cfgID].unit_type
	local var_9_2 = (GameSetting.activity_snowball_score.value[SnowballGameUnitCfg[arg_9_1.cfgID].unit_type] or 0) + GameSetting.activity_snowball_score_acc_bonus.value[arg_9_2 and 2 or 1] + (GameSetting.activity_snowball_score_row_bonus.value[arg_9_1.row] or 0)

	self.score = self.score + ((GameSetting.activity_snowball_score.value[SnowballGameUnitCfg[arg_9_1.cfgID].unit_type] or 0) + GameSetting.activity_snowball_score_acc_bonus.value[arg_9_2 and 2 or 1] + (GameSetting.activity_snowball_score_row_bonus.value[arg_9_1.row] or 0))
	self.hitList[arg_9_1.cfgID] = self.hitList[arg_9_1.cfgID] == nil and 1 or self.hitList[arg_9_1.cfgID] + 1
	self.score_.text = string.format("%d", self.score)

	self.scoreBubble:Show(var_9_1, var_9_2, arg_9_3)
end

function SnowballGameInfoSubView:UpdateWave(arg_10_1)
	self.wave_.text = GetTipsF("ACTIVITY_SNOWBALL_ENEMY_WAVE_NUMS", arg_10_1 + 1, #SnowballGameCfg[self.level].refresh_enemy + 1)

	local var_10_0 = nullable(SnowballGameCfg, self.level, "refresh_enemy", arg_10_1 + 1, 4)

	self.curWaveDuration = var_10_0 or self.totalTime
	self.countdown = self.curWaveDuration
	self.hasNextWave = var_10_0 ~= nil

	self.modeController:SetSelectedState("times")
end

function SnowballGameInfoSubView:RecordFinishTime()
	self.restTimeAfterFinish = self.totalTime
end

function SnowballGameInfoSubView:CalcRestTimeAfterFinish()
	return self.restTimeAfterFinish or 0
end

return SnowballGameInfoSubView
