local ReversePacmanGameController = class("ReversePacmanGameController")

ReversePacmanGameController.MAX_DIALOGUE_CNT = 30

function ReversePacmanGameController:Ctor(arg_1_1, arg_1_2)
	self.binder = arg_1_1
	self._tf = arg_1_2

	self:InitTF()
	self:InitControl()
	self:AddListener()
	self:InitTimer()

	return
end

function ReversePacmanGameController:InitTF(arg_2_1)
	self.timeText = self._tf:Find("time/Text"):GetComponent(typeof(Text))
	self.dialogueTpl = self._tf:Find("panel/tpl")

	setActive(self.dialogueTpl, false)

	self.dialogueContainer = self._tf:Find("panel/view/content")

	return
end

function ReversePacmanGameController:SetUp(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	self.levelId = arg_3_1
	self.shipIds = arg_3_2
	self.buffIds = arg_3_3
	self.buffCnts = arg_3_4
	self.eduBuffCnt = arg_3_5

	self.mapControl:SetUp(self.levelId)
	self.roleControl:SetUp(self.shipIds, self.mapControl, self.eduBuffCnt)
	self.buffControl:SetUp(self.buffIds, self.buffCnts, self.mapControl, self)

	self.durationTime = self.mapControl:GetDuration()
	self.remainTime = self.durationTime
	self.ratingThresholds = self.mapControl:GetRatingThresholds()
	self.gameplayTimeScale = ReversePacmanConst.GetGameplayTimeScale(self.remainTime)
	self.fastGameplayTipShown = false

	self:StartGame()

	return
end

function ReversePacmanGameController:InitControl()
	self.mapControl = ReversePacmanMapControl.New(self.binder, self._tf)
	self.roleControl = ReversePacmanRoleControl.New(self.binder, self._tf)
	self.buffControl = ReversePacmanBuffControl.New(self.binder, self._tf)

	return
end

function ReversePacmanGameController:AddListener()
	self.binder:bind(ReversePacmanConst.EVENT.CAPTURE, function(arg_6_0, arg_6_1)
		if self.roleControl:CheckGameEnd() then
			self:EndGame(ReversePacmanConst.RESULT_TYPE.SUCCESS)
		end

		return
	end)
	self.binder:bind(ReversePacmanConst.EVENT.GRAPH_CHANGED, function(arg_7_0, arg_7_1)
		if self.roleControl:CheckAllMonstersTrapped() then
			self:EndGame(ReversePacmanConst.RESULT_TYPE.SUCCESS)
		end

		return
	end)
	self.binder:bind(ReversePacmanConst.EVENT.SHIP_PERFORMANCE, function(arg_8_0, arg_8_1)
		self:AddDialogue(arg_8_1)

		return
	end)
	self.binder:bind(ReversePacmanConst.EVENT.PICK, function(arg_9_0, arg_9_1)
		self:PauseGame()
		LeanTween.delayedCall(self:GetGameplayDuration(1), System.Action(function()
			self:ResumeGame()

			return
		end))

		return
	end)

	return
end

function ReversePacmanGameController:InitTimer()
	self.timer = Timer.New(function()
		self:OnTimer(ReversePacmanConst.TIME_INTERVAL)

		return
	end, ReversePacmanConst.TIME_INTERVAL, -1)

	return
end

function ReversePacmanGameController:UpdateTimeUI()
	self.timeText.text = pg.TimeMgr.GetInstance():DescCDTimeForMinute(self.remainTime)

	return
end

function ReversePacmanGameController:AddDialogue(arg_14_1)
	self.dialogueCount = (self.dialogueCount or 0) + 1

	local var_14_1 = cloneTplTo(self.dialogueTpl, self.dialogueContainer, "dialogue_" .. self.dialogueCount)
	local var_14_2 = arg_14_1.shipId and pg.activity_chasing_character[arg_14_1.shipId]

	if var_14_2 then
		LoadImageSpriteAsync(var_14_2.sd_avatar, var_14_1:Find("icon"))
	end

	setText(var_14_1:Find("dialogue/Text"), (arg_14_1.ship:GetWordByType(arg_14_1.type)))
	scrollToBottom(self.dialogueContainer)

	self.dialogues = self.dialogues or {}

	table.insert(self.dialogues, var_14_1)

	if #self.dialogues > ReversePacmanGameController.MAX_DIALOGUE_CNT then
		local var_14_3 = table.remove(self.dialogues, 1)

		if var_14_3 then
			Destroy(var_14_3.gameObject)
		end
	end

	return
end

function ReversePacmanGameController:StartGame()
	self.gameEnded = false
	self.isPause = false

	self:StartTimer()

	return
end

function ReversePacmanGameController:EndGame(arg_16_1)
	if self.gameEnded then
		return
	end

	self.gameEnded = true

	if self.roleControl then
		self.roleControl:SetGameEnded(true)
	end

	self:PauseGame()
	LeanTween.delayedCall(self:GetGameplayDuration(1), System.Action(function()
		self.roleControl:Hide()
		self.binder:GameOver({
			result = arg_16_1,
			useTime = calcFloor(self.durationTime - self.remainTime),
			grade = ReversePacmanConst.GetGrade(self.remainTime, self.durationTime, self.ratingThresholds),
			shipCnt = self.roleControl:GetShipCnt(),
			monsterCnt = self.roleControl:GetCapturedMonsterCnt()
		})

		return
	end))

	return
end

function ReversePacmanGameController:CanCastBuff(arg_18_1, arg_18_2)
	if not arg_18_2 or not self.mapControl:IsWalkable(arg_18_2.x, arg_18_2.y) then
		return false
	end

	if arg_18_1 == ReversePacmanConst.BUFF.BLOCK and self.roleControl:IsCellOccupied(arg_18_2) then
		return false
	end

	return true
end

function ReversePacmanGameController:IsAllMonstersTrapped()
	return self.roleControl:CheckAllMonstersTrapped()
end

function ReversePacmanGameController:StartTimer()
	if not self.timer.running then
		self.timer:Start()
	end

	return
end

function ReversePacmanGameController:StopTimer()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function ReversePacmanGameController:PauseGame()
	self.isPause = true

	self:StopTimer()

	return
end

function ReversePacmanGameController:ResumeGame()
	if self.gameEnded then
		return
	end

	self.isPause = false

	self:StartTimer()

	return
end

function ReversePacmanGameController:IsPause()
	return self.isPause
end

function ReversePacmanGameController:OnTimer(arg_25_1)
	if self.gameEnded then
		return
	end

	local var_25_0 = self.gameplayTimeScale or ReversePacmanConst.GAMEPLAY_TIME_SCALE.NORMAL

	self.gameplayTimeScale = ReversePacmanConst.GetGameplayTimeScale(self.remainTime)

	if not self.fastGameplayTipShown and var_25_0 ~= ReversePacmanConst.GAMEPLAY_TIME_SCALE.FAST and self.gameplayTimeScale == ReversePacmanConst.GAMEPLAY_TIME_SCALE.FAST then
		self.fastGameplayTipShown = true

		pg.TipsMgr.GetInstance():ShowTips(i18n("reverse_pacman_game_speed_up_tip"))
	end

	local var_25_1 = arg_25_1 * self.gameplayTimeScale

	self.remainTime = self.remainTime - arg_25_1 * self.gameplayTimeScale

	self:UpdateTimeUI()

	if self.remainTime <= 0 then
		self.remainTime = 0

		self:UpdateTimeUI()
		self:EndGame(ReversePacmanConst.RESULT_TYPE.FAIL)

		return
	end

	self.mapControl:Update(var_25_1)
	self.roleControl:Update(var_25_1)
	self.buffControl:Update(var_25_1)

	return
end

function ReversePacmanGameController:GetGameplayTimeScale()
	return self.gameplayTimeScale or ReversePacmanConst.GAMEPLAY_TIME_SCALE.NORMAL
end

function ReversePacmanGameController:GetGameplayDuration(arg_27_1)
	return arg_27_1 / self:GetGameplayTimeScale()
end

function ReversePacmanGameController:Dispose()
	if self.timer then
		if self.timer.running then
			self.timer:Stop()
		end

		self.timer = nil
	end

	self.mapControl:Dispose()
	self.roleControl:Dispose()
	self.buffControl:Dispose()

	return
end

return ReversePacmanGameController
