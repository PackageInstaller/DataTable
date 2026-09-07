local GuessForkGameView = class("GuessForkGameView", import("..BaseMiniGameView"))
local var_0_1 = {
	100,
	50
}
local var_0_2 = {
	10
}
local var_0_3 = {
	20
}
local var_0_4 = {
	3,
	3,
	3,
	4,
	4,
	4,
	5,
	5,
	5,
	6,
	6,
	6,
	7,
	7,
	7,
	8,
	8,
	8,
	8,
	9,
	9,
	9,
	9,
	9,
	10,
	10,
	10,
	10,
	10,
	10,
	11,
	11,
	11,
	11,
	11,
	12
}
local var_0_5 = {
	1000,
	200
}
local var_0_6 = 10000
local var_0_7 = 2
local var_0_9 = "event:/ui/ddldaoshu2"
local var_0_10 = "event:/ui/taosheng"
local var_0_11 = "event:/ui/zhengque"
local var_0_12 = "event:/ui/shibai"
local var_0_13 = "backyard"
local var_0_14 = {
	"Cup_B",
	"Cup_G",
	"Cup_P",
	"Cup_R",
	"Cup_Y"
}
local var_0_15 = 3
local var_0_16 = 0.5
local var_0_17 = "Thinking_Loop"
local var_0_18 = {
	"Select_L",
	"Select_M",
	"Select_R"
}
local var_0_19 = {
	"Correct_L",
	"Correct_M",
	"Correct_R"
}
local var_0_20 = {
	"Incorrect_L",
	"Incorrect_M",
	"Incorrect_R"
}
local var_0_21 = "Manjuu_Correct"
local var_0_22 = {
	"Ayanami",
	"Cheshire",
	"Eldridge",
	"Formidable",
	"Javelin",
	"Laffey",
	"LeMalin",
	"Merkuria",
	"PingHai",
	"Roon",
	"Saratoga",
	"Shiratsuyu",
	"Yukikaze",
	"Z23"
}

function GuessForkGameView:getUIName()
	return "GuessForkGameUI"
end

function GuessForkGameView:getBGM()
	return var_0_13
end

function GuessForkGameView:init()
	self.countUI = self._tf:Find("count_ui")
	self.countAnimator = self.countUI:Find("count_bg/count"):GetComponent(typeof(Animator))
	self.countDft = self.countUI:Find("count_bg/count"):GetComponent(typeof(DftAniEvent))

	self.countDft:SetEndEvent(function()
		setActive(self.countUI, false)
		self:startGame()

		return
	end)

	self.pauseUI = self._tf:Find("pause_ui")
	self.resuemBtn = self.pauseUI:Find("box/sure_btn")

	setText(self.pauseUI:Find("box/content"), i18n("idolmaster_game_tip1"))

	self.exitUI = self._tf:Find("exit_ui")
	self.exitSureBtn = self.exitUI:Find("box/sure_btn")
	self.exitCancelBtn = self.exitUI:Find("box/cancel_btn")

	setText(self.exitUI:Find("box/content"), i18n("idolmaster_game_tip2"))

	self.endUI = self._tf:Find("end_ui")
	self.endSureBtn = self.endUI:Find("box/sure_btn")

	setText(self.endUI:Find("box/cur_score"), i18n("idolmaster_game_tip3"))

	self.endScoreTxt = self.endUI:Find("box/cur_score/score")
	self.newTag = self.endScoreTxt:Find("new")

	setText(self.endUI:Find("box/highest_score"), i18n("idolmaster_game_tip4"))

	self.highestScoreTxt = self.endUI:Find("box/highest_score/score")
	self.gameUI = self._tf:Find("game_ui")
	self.returnBtn = self.gameUI:Find("top/return_btn")
	self.pauseBtn = self.gameUI:Find("top/pause_btn")
	self.roundTxt = self.gameUI:Find("top/title/round/num")
	self.roundNum = 0
	self.curScoreTxt = self.gameUI:Find("top/title/score_title/score")
	self.curScore = 0

	setText(self.curScoreTxt, self.curScore)

	self.curTimeTxt = self.gameUI:Find("top/time_bg/time")
	self.curTime = 0

	setText(self.gameUI:Find("top/title/score_title"), i18n("idolmaster_game_tip5"))

	self.correctBar = self.gameUI:Find("correct_bar")
	self.failBar = self.gameUI:Find("fail_bar")
	self.manjuu = self.gameUI:Find("play/manjuu")
	self.manjuuAnimator = self.manjuu:GetComponent(typeof(Animator))
	self.manjuuDft = self.manjuu:GetComponent(typeof(DftAniEvent))
	self.result = self.gameUI:Find("result")
	self.resultAnimator = self.result:GetComponent(typeof(Animator))
	self.resultDft = self.result:GetComponent(typeof(DftAniEvent))
	self.scoreAni = self.gameUI:Find("score")
	self.cupContainer = self.gameUI:Find("cup_container")
	self.fork = self.gameUI:Find("fork")
	self.isGuessTime = false

	return
end

function GuessForkGameView:didEnter()
	onButton(self, self.pauseBtn, function()
		setActive(self.pauseUI, true)
		self:pauseGame()

		return
	end, SFX_PANEL)
	onButton(self, self.resuemBtn, function()
		setActive(self.pauseUI, false)
		self:resumeGame()

		return
	end, SFX_PANEL)
	onButton(self, self.returnBtn, function()
		setActive(self.exitUI, true)
		self:pauseGame()

		return
	end, SFX_PANEL)
	onButton(self, self.exitSureBtn, function()
		setActive(self.exitUI, false)
		self:enterResultUI()

		return
	end, SFX_PANEL)
	onButton(self, self.exitCancelBtn, function()
		setActive(self.exitUI, false)
		self:resumeGame()

		return
	end, SFX_PANEL)
	onButton(self, self.endSureBtn, function()
		self:emit(GuessForkGameView.ON_BACK)

		return
	end, SFX_PANEL)
	eachChild(self.cupContainer, function(arg_12_0)
		onButton(self, arg_12_0, function()
			if not self.isGuessTime then
				return
			end

			setActive(arg_12_0:Find("select"), true)

			self.isGuessTime = false
			self.selectIndex = tonumber((string.gsub(arg_12_0.name, "cup_", "")))

			self:endRound(self.selectIndex == self.forkIndex)

			return
		end, SFX_PANEL)

		return
	end)
	self:initGameData()
	setActive(self.countUI, true)
	self.countAnimator:Play("countDown")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_9)

	return
end

function GuessForkGameView:initGameData()
	local var_14_0 = var_0_14[math.random(#var_0_14)]

	eachChild(self.cupContainer, function(arg_15_0)
		GetSpriteFromAtlasAsync("ui/minigameui/guessforkgameui", var_14_0, function(arg_16_0)
			setImageSprite(arg_15_0:Find("front"), arg_16_0, true)

			return
		end)

		return
	end)

	self.forkIndex = math.random(var_0_15)
	self.selectIndex = nil
	self.roundNum = self.roundNum + 1

	setText(self.roundTxt, self.roundNum)

	self.curTime = var_0_3[self.roundNum] or var_0_3[#var_0_3]

	setText(self.curTimeTxt, self.curTime)
	setActive(self.result, false)

	return
end

function GuessForkGameView:startGame()
	self.manjuuAnimator:Play(var_0_17)

	local var_17_0 = var_0_4[self.roundNum] or var_0_4[#var_0_4]

	self:playForkAni(function()
		self:startSwap(var_17_0)

		return
	end)

	self.gameStartFlag = true

	return
end

function GuessForkGameView:playForkAni(arg_19_1)
	setParent(self.fork, self.cupContainer:Find("cup_" .. self.forkIndex):Find("fork_node"), false)
	setLocalScale(self.fork, Vector3.one)
	setLocalPosition(self.fork, Vector3(0, 50, 0))
	setActive(self.fork, true)
	self:managedTween(LeanTween.delayedCall, function()
		self:managedTween(LeanTween.moveY, function()
			setActive(self.fork, false)

			if arg_19_1 then
				arg_19_1()
			end

			return
		end, self.fork, -20, var_0_16):setEase(LeanTweenType.linear)

		return
	end, 0.5, nil)

	return
end

function GuessForkGameView:startSwap(arg_22_1)
	if arg_22_1 < 1 then
		self.isGuessTime = true

		self:startTimer()

		return
	end

	local var_22_0 = {
		1,
		2,
		3
	}

	table.remove(var_22_0, (math.random(#var_22_0)))
	self:swapCup(self.cupContainer:Find("cup_" .. var_22_0[1]), self.cupContainer:Find("cup_" .. var_22_0[2]), function()
		self:startSwap(arg_22_1 - 1)

		return
	end)

	return
end

function GuessForkGameView:swapCup(arg_24_1, arg_24_2, arg_24_3)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_10)

	local var_24_0 = math.abs(arg_24_2.anchoredPosition.x - arg_24_1.anchoredPosition.x) / (var_0_5[1] + (self.roundNum - 1) * var_0_5[2] < var_0_6 and var_0_5[1] + (self.roundNum - 1) * var_0_5[2] or var_0_6)

	self:managedTween(LeanTween.moveX, nil, arg_24_1, arg_24_2.anchoredPosition.x, var_24_0):setEase(LeanTweenType.linear)
	self:managedTween(LeanTween.moveX, function()
		if arg_24_3 then
			arg_24_3()
		end

		return
	end, arg_24_2, arg_24_1.anchoredPosition.x, var_24_0):setEase(LeanTweenType.linear)

	return
end

function GuessForkGameView:startTimer()
	self.timer = Timer.New(function()
		self.curTime = self.curTime - 1

		if self.curTime <= 0 then
			self:endRound(false)
		end

		setText(self.curTimeTxt, self.curTime)

		return
	end, 1, -1)

	self.timer:Start()

	return
end

function GuessForkGameView:stopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function GuessForkGameView:pauseGame()
	self:pauseManagedTween()

	if self.timer then
		self.timer:Pause()
	end

	self.manjuuAnimator.speed = 0
	self.resultAnimator.speed = 0

	return
end

function GuessForkGameView:resumeGame()
	self:resumeManagedTween()

	if self.timer then
		self.timer:Resume()
	end

	self.manjuuAnimator.speed = 1
	self.resultAnimator.speed = 1

	return
end

function GuessForkGameView:endRound(arg_31_1)
	self:stopTimer()

	if self.selectIndex then
		self:playManjuuAni(arg_31_1)
	else
		self:playTimeOutAni()
		self:endGame()
	end

	return
end

function GuessForkGameView:playManjuuAni(arg_32_1)
	local var_32_0 = self.cupContainer:Find("cup_" .. self.selectIndex)
	local var_32_1 = (var_32_0.anchoredPosition.x + 480) / 480 + 1

	self.manjuuAnimator:Play(var_0_18[(var_32_0.anchoredPosition.x + 480) / 480 + 1])
	self.manjuuDft:SetEndEvent(function()
		self.manjuuDft:SetEndEvent(nil)

		local var_33_0

		if arg_32_1 then
			var_33_0 = var_0_19[var_32_1] or var_0_20[var_32_1]
		end

		setActive(var_32_0:Find("select"), false)
		self.manjuuAnimator:Play(var_33_0)
		self:playResultAni(arg_32_1)

		return
	end)

	return
end

function GuessForkGameView:playResultAni(arg_34_1)
	setParent(self.result, self.cupContainer:Find("cup_" .. self.selectIndex):Find("result_node"), false)
	setLocalScale(self.result, Vector3.one)
	setLocalPosition(self.result, Vector3.zero)
	setActive(self.result, true)

	if arg_34_1 then
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_11)
		self.resultAnimator:Play(var_0_21)
		self.resultDft:SetEndEvent(function()
			self.resultDft:SetEndEvent(nil)
			self:showCorrectBar()

			return
		end)
	else
		pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_12)
		self.resultAnimator:Play(var_0_22[math.random(#var_0_22)])
		self.resultDft:SetEndEvent(function()
			self.resultDft:SetEndEvent(nil)
			self:endGame()

			return
		end)
	end

	return
end

function GuessForkGameView:showCorrectBar()
	setActive(self.correctBar, true)

	self.curScore = self.curScore + (var_0_1[1] + (self.roundNum - 1) * var_0_1[2])

	setText(self.curScoreTxt, self.curScore)
	setLocalPosition(self.scoreAni, Vector3(0, 250, 0))
	setText(self.scoreAni, "+" .. var_0_1[1] + (self.roundNum - 1) * var_0_1[2])
	setActive(self.scoreAni, true)
	LeanTween.moveY(self.scoreAni, 300, 1):setOnComplete(System.Action(function()
		setActive(self.scoreAni, false)

		return
	end))

	local var_37_0 = self.curScore + (var_0_2[self.roundNum] or var_0_2[#var_0_2]) * self.curTime

	LeanTween.value(go(self.curScoreTxt), self.curScore, self.curScore + (var_0_2[self.roundNum] or var_0_2[#var_0_2]) * self.curTime, 0.5):setOnUpdate(System.Action_float(function(arg_39_0)
		setText(self.curScoreTxt, math.ceil(arg_39_0))

		return
	end)):setOnComplete(System.Action(function()
		self.curScore = var_37_0

		setText(self.curScoreTxt, self.curScore)

		return
	end))
	LeanTween.value(go(self.curTimeTxt), self.curTime, 0, 0.5):setOnUpdate(System.Action_float(function(arg_41_0)
		setText(self.curTimeTxt, math.ceil(arg_41_0))

		return
	end)):setOnComplete(System.Action(function()
		self.curScore = var_37_0

		setText(self.curTimeTxt, 0)

		return
	end))
	onButton(self, self.correctBar, function()
		setActive(self.correctBar, false)
		setActive(self.scoreAni, false)
		self:initGameData()
		self:startGame()

		return
	end, SFX_PANEL)
	self:managedTween(LeanTween.delayedCall, function()
		if isActive(self.correctBar) then
			triggerButton(self.correctBar)
		end

		return
	end, var_0_7, nil)

	return
end

function GuessForkGameView:playTimeOutAni()
	setParent(self.result, self.cupContainer:Find("cup_" .. self.forkIndex):Find("result_node"), false)
	setLocalScale(self.result, Vector3.one)
	setLocalPosition(self.result, Vector3.zero)
	setActive(self.result, true)
	self.resultAnimator:Play(var_0_21)
	self.resultDft:SetEndEvent(function()
		self.resultDft:SetEndEvent(nil)

		return
	end)

	return
end

function GuessForkGameView:endGame()
	setActive(self.failBar, true)
	onButton(self, self.failBar, function()
		setActive(self.failBar, false)
		self:enterResultUI()

		return
	end, SFX_PANEL)
	self:managedTween(LeanTween.delayedCall, function()
		if isActive(self.failBar) then
			triggerButton(self.failBar)
		end

		return
	end, var_0_7, nil)

	return
end

function GuessForkGameView:enterResultUI()
	self.gameStartFlag = false

	setActive(self.endUI, true)
	setText(self.endScoreTxt, self.curScore)

	local var_50_0 = self:GetMGData():GetRuntimeData("elements")
	local var_50_1

	if var_50_0 and #var_50_0 > 0 then
		var_50_1 = var_50_0[1] or 0
	end

	setActive(self.newTag, var_50_1 < self.curScore)

	if var_50_1 <= self.curScore then
		var_50_1 = self.curScore

		self:StoreDataToServer({
			self.curScore
		})
	end

	setText(self.highestScoreTxt, var_50_1)

	if self:GetMGHubData().count > 0 then
		self:SendSuccess(0)
	end

	return
end

function GuessForkGameView:OnGetAwardDone(arg_51_1)
	if arg_51_1.cmd == MiniGameOPCommand.CMD_COMPLETE then
		local var_51_0 = self:GetMGHubData()

		if var_51_0.ultimate == 0 and var_51_0.usedtime >= var_51_0:getConfig("reward_need") then
			pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
				hubid = var_51_0.id,
				cmd = MiniGameOPCommand.CMD_ULTIMATE,
				args1 = {}
			})
		end
	end

	return
end

function GuessForkGameView:onBackPressed()
	if not self.gameStartFlag then
		self:emit(GuessForkGameView.ON_BACK_PRESSED)
	else
		setActive(self.exitUI, true)
		self:pauseGame()
	end

	return
end

return GuessForkGameView
