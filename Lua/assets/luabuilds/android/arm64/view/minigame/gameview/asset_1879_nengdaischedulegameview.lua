local NengDaiScheduleGameView = class("NengDaiScheduleGameView", import("view.base.BaseUI"))
local var_0_1 = 70
local var_0_2 = 105
local var_0_3 = 3
local var_0_4 = 10
local var_0_5 = 2
local var_0_7 = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12
}
local var_0_9 = {
	"study",
	"study",
	"study",
	"sport",
	"sport",
	"sport",
	"housework",
	"housework",
	"housework",
	"entertainment",
	"entertainment",
	"entertainment"
}
local var_0_10 = {
	"阅读",
	"画画",
	"学习",
	"舞蹈",
	"排球",
	"跑步",
	"打扫",
	"做饭",
	"洗衣服",
	"游戏",
	"散步",
	"睡觉"
}
local var_0_11 = {
	study = "学习",
	sport = "运动",
	housework = "家务",
	entertainment = "娱乐"
}

function NengDaiScheduleGameView:getUIName()
	return "NengDaiScheduleGameView"
end

function NengDaiScheduleGameView:didEnter()
	self:initData()
	self:initUI()
	self:readyStart()
	self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
		operationCode = "GAME_READY",
		miniGameId = var_0_1
	})

	return
end

function NengDaiScheduleGameView:initData()
	local var_3_0 = Application.targetFrameRate or 60

	if var_3_0 > 60 then
		var_3_0 = 60
	end

	self.stepCount = 1 / var_3_0 * 0.9
	self.realTimeStartUp = Time.realtimeSinceStartup
	self.timer = Timer.New(function()
		if Time.realtimeSinceStartup - self.realTimeStartUp > self.stepCount then
			self:onTimer()

			self.realTimeStartUp = Time.realtimeSinceStartup
		end

		return
	end, 1 / var_3_0, -1)

	for iter_3_0 = 1, #var_0_10 do
		var_0_10[iter_3_0] = i18n("dorm3d_nengdai_minigame_behavior" .. iter_3_0)
	end

	var_0_11.study = i18n("dorm3d_nengdai_minigame_behavior_type1")
	var_0_11.sport = i18n("dorm3d_nengdai_minigame_behavior_type2")
	var_0_11.housework = i18n("dorm3d_nengdai_minigame_behavior_type3")
	var_0_11.entertainment = i18n("dorm3d_nengdai_minigame_behavior_type4")

	return
end

function NengDaiScheduleGameView:onTimer()
	self.deltaTime = Time.realtimeSinceStartup - self.realTimeStartUp

	if not self.startSettlement then
		self.gameTime = self.gameTime - self.deltaTime
		self.gameStepTime = self.gameStepTime + self.deltaTime

		if self.gameTime < 0 then
			self.gameTime = 0
		end
	end

	if self.showFlag then
		self.showTime = self.showTime + self.deltaTime

		if self.showTime >= var_0_3 then
			self.showTime = self.showTime - var_0_3

			self:ChangeMotion()
		end
	end

	if self.chooseFlag then
		self.chooseTime = self.chooseTime - self.deltaTime

		if self.chooseTime <= 0 then
			if #self.playerChoosedScheduleList < 3 * self.round then
				for iter_5_0 = #self.playerChoosedScheduleList + 1, 3 * self.round do
					self.playerChoosedScheduleList[iter_5_0] = 0
				end
			end

			self:ChangeMotion()
		end
	end

	if self.roundSettleFlag then
		self.roundSettleTime = self.roundSettleTime + self.deltaTime

		if self.roundSettleTime >= var_0_5 then
			self.roundSettleTime = self.roundSettleTime - var_0_5

			self:ChangeMotion()
		end
	end

	local var_5_0 = math.ceil(self.gameTime)

	setText(self.gameUITime, string.format("%02d", (math.floor(var_5_0 / 60))) .. ":" .. string.format("%02d", var_5_0 % 60))
	self:GamingLogic()

	if self.gameTime <= 0 then
		self:onGameOver()
	end

	return
end

function NengDaiScheduleGameView:initUI()
	self.bgTf = self._tf:Find("bg")
	self.clickMask = self._tf:Find("clickMask")
	self.gameUI = self._tf:Find("ui/gameUI")
	self.gameTop = self.gameUI:Find("top")
	self.gameUIScore = self.gameTop:Find("score/text")
	self.gameUITime = self.gameTop:Find("time/text")
	self.gameUILeave = self.gameUI:Find("btnLeave")

	setActive(self.gameTop, false)
	onButton(self, self.gameUILeave, function()
		self:checkGameExit()

		return
	end, SFX_PANEL)

	self.gamingUI = self._tf:Find("gamingUI")
	self.gamingShow = self.gamingUI:Find("show")
	self.gamingChoose = self.gamingUI:Find("choose")
	self.gamingSettlement = self.gamingUI:Find("settlement")

	setActive(self.gamingShow, true)
	setActive(self.gamingChoose, true)
	setActive(self.gamingSettlement, false)
	setActive(self.gamingUI, false)
	setText(self.gamingSettlement:Find("dayList/Monday"), i18n("dorm3d_nengdai_minigame_day1"))
	setText(self.gamingSettlement:Find("dayList/Tuesday"), i18n("dorm3d_nengdai_minigame_day2"))
	setText(self.gamingSettlement:Find("dayList/Wednesday"), i18n("dorm3d_nengdai_minigame_day3"))
	setText(self.gamingSettlement:Find("dayList/Thursday"), i18n("dorm3d_nengdai_minigame_day4"))
	setText(self.gamingSettlement:Find("dayList/Friday"), i18n("dorm3d_nengdai_minigame_day5"))
	setText(self.gamingSettlement:Find("dayList/Saturday"), i18n("dorm3d_nengdai_minigame_day6"))
	setText(self.gamingSettlement:Find("dayList/Sunday"), i18n("dorm3d_nengdai_minigame_day7"))
	setText(self.gamingChoose:Find("state1"), i18n("dorm3d_nengdai_minigame_remember"))
	setText(self.gamingChoose:Find("state2/text"), i18n("dorm3d_nengdai_minigame_choose"))

	for iter_6_0 = 0, 8 do
		local var_6_0 = self.gamingChoose:Find("scheduleList"):GetChild(iter_6_0):GetChild(0)

		for iter_6_1 = 0, 11 do
			setText(var_6_0:GetChild(iter_6_1):GetChild(0), var_0_10[iter_6_1 + 1])
		end
	end

	self.count = self._tf:Find("count")

	setActive(self.count, true)
	self.count:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		self:gameStart()

		return
	end)

	return
end

function NengDaiScheduleGameView:GamingLogic()
	if not self.hasDone then
		self.hasDone = true

		if self.showFlag then
			setActive(self.gamingChoose:Find("state1"), true)
			setActive(self.gamingChoose:Find("state2"), false)
			self:ShowSchedule(self.gamingShow:Find("morningSchedule"):GetChild(0), true, 1)
			self:ShowSchedule(self.gamingShow:Find("noonSchedule"):GetChild(0), true, 1)
			self:ShowSchedule(self.gamingShow:Find("nightSchedule"):GetChild(0), true, 1)
			self:SetScheduleFrame(self.gamingShow:Find("morningSchedule"):GetChild(0), "")
			self:SetScheduleFrame(self.gamingShow:Find("noonSchedule"):GetChild(0), "")
			self:SetScheduleFrame(self.gamingShow:Find("nightSchedule"):GetChild(0), "")
			setText(self.gamingShow:Find("day"), i18n("dorm3d_nengdai_minigame_day" .. self.round))

			for iter_9_0 = 0, 6 do
				setActive(self.gamingShow:Find("dayEng"):GetChild(iter_9_0), iter_9_0 + 1 == self.round)
			end

			for iter_9_1 = 0, 8 do
				self:SetScheduleFrame(self.gamingChoose:Find("scheduleList"):GetChild(iter_9_1):GetChild(0), "")
			end

			for iter_9_2 = 0, 8 do
				self:ShowSchedule(self.gamingChoose:Find("scheduleList"):GetChild(iter_9_2):GetChild(0), false)
			end

			setActive(self.gamingShow:Find("scoreAdd"), false)
		elseif self.chooseFlag then
			setActive(self.gamingChoose:Find("state1"), false)
			setActive(self.gamingChoose:Find("state2"), true)
			self:ShowSchedule(self.gamingShow:Find("morningSchedule"):GetChild(0), true, 0, 0)
			self:ShowSchedule(self.gamingShow:Find("noonSchedule"):GetChild(0), true, 0, 0)
			self:ShowSchedule(self.gamingShow:Find("nightSchedule"):GetChild(0), true, 0, 0)

			local var_9_0 = {}
			local var_9_1 = {
				0,
				1,
				2,
				3,
				4,
				5,
				6,
				7,
				8
			}

			while #var_9_0 < 3 do
				table.insert(var_9_0, table.remove(var_9_1, (math.random(#var_9_1))))
			end

			local var_9_2 = 1

			for iter_9_3 = 0, 8 do
				if table.contains(var_9_0, iter_9_3) then
					self:ShowSchedule(self.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0), true, 2, self.showScheduleList[3 * (self.round - 1) + var_9_2])

					var_9_2 = var_9_2 + 1
				end

				local var_9_3

				do
					self:ShowSchedule(self.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0), true, 2)

					var_9_3 = self.gamingChoose:Find("scheduleList"):GetChild(iter_9_3)
				end

				onButton(self, var_9_3, function()
					if not self:IsShowing(self.gamingShow:Find("morningSchedule"):GetChild(0)) then
						self:ShowSchedule(self.gamingShow:Find("morningSchedule"):GetChild(0), true, 3, self.chooseScheduleList[iter_9_3 + 1])
						self:SetScheduleFrame(self.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0), "morningChoose")
					elseif not self:IsShowing(self.gamingShow:Find("noonSchedule"):GetChild(0)) then
						self:ShowSchedule(self.gamingShow:Find("noonSchedule"):GetChild(0), true, 3, self.chooseScheduleList[iter_9_3 + 1])
						self:SetScheduleFrame(self.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0), "noonChoose")
					elseif not self:IsShowing(self.gamingShow:Find("nightSchedule"):GetChild(0)) then
						self:ShowSchedule(self.gamingShow:Find("nightSchedule"):GetChild(0), true, 3, self.chooseScheduleList[iter_9_3 + 1])
						self:SetScheduleFrame(self.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0), "nightChoose")
						self:ChangeMotion()
					end

					removeOnButton(self.gamingChoose:Find("scheduleList"):GetChild(iter_9_3))

					return
				end, SFX_PANEL)
			end
		elseif self.roundSettleFlag then
			setActive(self.gamingChoose:Find("state1"), false)
			setActive(self.gamingChoose:Find("state2"), false)
			self:ShowSchedule(self.gamingShow:Find("morningSchedule"):GetChild(0), true, 0, self.showScheduleList[3 * (self.round - 1) + 1])
			self:ShowSchedule(self.gamingShow:Find("noonSchedule"):GetChild(0), true, 0, self.showScheduleList[3 * (self.round - 1) + 2])
			self:ShowSchedule(self.gamingShow:Find("nightSchedule"):GetChild(0), true, 0, self.showScheduleList[3 * (self.round - 1) + 3])

			local var_9_4 = 0

			for iter_9_4 = 1, 3 do
				local var_9_5 = "wrong"

				if self.showScheduleList[3 * (self.round - 1) + iter_9_4] == self.playerChoosedScheduleList[3 * (self.round - 1) + iter_9_4] then
					var_9_4 = var_9_4 + 100
					var_9_5 = "right"
				end

				if iter_9_4 == 1 then
					self:SetScheduleFrame(self.gamingShow:Find("morningSchedule"):GetChild(0), var_9_5)
				elseif iter_9_4 == 2 then
					self:SetScheduleFrame(self.gamingShow:Find("noonSchedule"):GetChild(0), var_9_5)
				elseif iter_9_4 == 3 then
					self:SetScheduleFrame(self.gamingShow:Find("nightSchedule"):GetChild(0), var_9_5)
				end
			end

			self.scoreNum = self.scoreNum + var_9_4

			setText(self.gameUIScore, self.scoreNum)
			setActive(self.gamingShow:Find("scoreAdd"), true)

			for iter_9_5 = 0, 3 do
				setActive(self.gamingShow:Find("scoreAdd"):GetChild(iter_9_5), var_9_4 == 100 * iter_9_5)
			end

			self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
				operationCode = "ROUND_RESULT",
				success = var_9_4 >= 200,
				miniGameId = var_0_1
			})
		end
	end

	if self.showFlag then
		setSlider(self.gamingChoose:Find("timeSlider"), 0, var_0_3, var_0_3 - self.showTime)
	end

	if self.chooseFlag then
		setText(self.gamingChoose:Find("state2/chooseTime"), math.ceil(self.chooseTime))
		setSlider(self.gamingChoose:Find("timeSlider"), 0, var_0_4, self.chooseTime)
	end

	return
end

function NengDaiScheduleGameView:ChangeMotion()
	if self.showFlag then
		self.hasDone = false
		self.showFlag = false
		self.chooseFlag = true
		self.roundSettleFlag = false
		self.chooseTime = 10

		table.insertto(self.RandomPool, var_0_7)
	elseif self.chooseFlag then
		self.hasDone = false
		self.showFlag = false
		self.chooseFlag = false
		self.roundSettleFlag = true
	elseif self.roundSettleFlag then
		if self.round == 7 then
			self:onGameOver()
		else
			self.hasDone = false
			self.showFlag = true
			self.chooseFlag = false
			self.roundSettleFlag = false
			self.round = self.round + 1
			self.chooseScheduleList = {}
			self.RandomPool = Clone(var_0_7)
		end
	end

	return
end

function NengDaiScheduleGameView:ShowSchedule(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_2 then
		if not arg_12_4 then
			local var_12_0 = math.random(#self.RandomPool)

			arg_12_4 = self.RandomPool[var_12_0]

			table.remove(self.RandomPool, var_12_0)
		end

		if arg_12_3 == 1 then
			table.insert(self.showScheduleList, arg_12_4)
		end

		if arg_12_3 == 2 then
			table.insert(self.chooseScheduleList, arg_12_4)
		end

		if arg_12_3 == 3 then
			table.insert(self.playerChoosedScheduleList, arg_12_4)
		end

		for iter_12_0 = 0, 11 do
			setActive(arg_12_1:GetChild(iter_12_0), iter_12_0 == arg_12_4 - 1)
		end

		setActive(arg_12_1:GetChild(12), false)

		if arg_12_4 == 0 then
			setActive(arg_12_1:GetChild(12), true)
		end
	else
		setActive(arg_12_1:GetChild(12), true)
	end

	return
end

function NengDaiScheduleGameView:SetScheduleFrame(arg_13_1, arg_13_2)
	for iter_13_0 = 13, arg_13_1.childCount - 1 do
		setActive(arg_13_1:GetChild(iter_13_0), arg_13_1:GetChild(iter_13_0).name == arg_13_2)
	end

	return
end

function NengDaiScheduleGameView:IsShowing(arg_14_1)
	return not isActive(arg_14_1:GetChild(12))
end

function NengDaiScheduleGameView:readyStart()
	self.scoreNum = 0
	self.gameTime = var_0_2
	self.gameStepTime = 0
	self.showTime = 0
	self.roundSettleTime = 0
	self.hasDone = false
	self.showFlag = true
	self.chooseFlag = false
	self.roundSettleFlag = false
	self.showScheduleList = {}
	self.chooseScheduleList = {}
	self.playerChoosedScheduleList = {}
	self.RandomPool = Clone(var_0_7)
	self.round = 1

	self.count:GetComponent(typeof(Animator)):Play("count")

	return
end

function NengDaiScheduleGameView:gameStart()
	self.gameStartFlag = true

	setActive(self.count, false)
	setActive(self.gameTop, true)
	setActive(self.gamingUI, true)
	setText(self.gameUIScore, self.scoreNum)
	self:timerStart()

	return
end

function NengDaiScheduleGameView:timerStart()
	if not self.timer.running then
		self.realTimeStartUp = Time.realtimeSinceStartup

		self.timer:Start()
	end

	return
end

function NengDaiScheduleGameView:timerStop()
	if self.timer.running then
		self.timer:Stop()
	end

	return
end

function NengDaiScheduleGameView:pauseGame()
	self.gameStop = true

	self:timerStop()

	return
end

function NengDaiScheduleGameView:resumeGame()
	self.gameStop = false

	self:timerStart()

	return
end

function NengDaiScheduleGameView:onGameOver()
	self:timerStop()
	setActive(self.clickMask, true)
	setActive(self.gameTop, false)
	LeanTween.delayedCall(go(self._tf), 0.1, System.Action(function()
		self.gameStartFlag = false

		setActive(self.clickMask, false)
		self:GameSettlement()
		self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
			operationCode = "GAME_RESULT",
			score = self.scoreNum,
			miniGameId = var_0_1
		})

		return
	end))

	return
end

function NengDaiScheduleGameView:GameSettlement()
	setActive(self.gamingShow, false)
	setActive(self.gamingChoose, false)
	setActive(self.gamingSettlement, true)

	for iter_23_0 = 0, 20 do
		self:ShowSchedule(self.gamingSettlement:Find("scheduleResultList"):GetChild(iter_23_0):GetChild(0), true, 0, self.playerChoosedScheduleList[iter_23_0 + 1])
	end

	self.scoreNum = self.scoreNum + 10 * math.ceil(self.gameTime)

	setText(self.gamingSettlement:Find("currentScore/Text"), self.scoreNum)

	local var_23_0 = getProxy(PlayerProxy):getPlayerId()
	local var_23_1 = PlayerPrefs.GetInt("mg_score_" .. tostring(var_23_0) .. "_" .. var_0_1) or 0

	setActive(self.gamingSettlement:Find("currentScore/new"), var_23_1 < self.scoreNum)

	if var_23_1 < self.scoreNum then
		var_23_1 = self.scoreNum

		PlayerPrefs.SetInt("mg_score_" .. tostring(var_23_0) .. "_" .. var_0_1, self.scoreNum)
	end

	setText(self.gamingSettlement:Find("highestScore/Text"), var_23_1)

	local var_23_2 = math.ceil(self.gameTime)

	setText(self.gamingSettlement:Find("remainingTime/Text"), string.format("%02d", (math.floor(var_23_2 / 60))) .. ":" .. string.format("%02d", var_23_2 % 60))
	setText(self.gamingSettlement:Find("result/Text"), self:GetEvaluation())

	return
end

function NengDaiScheduleGameView:GetEvaluation()
	local var_24_0 = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}
	local var_24_1 = {
		study = 0,
		sport = 0,
		housework = 0,
		entertainment = 0
	}

	for iter_24_0, iter_24_1 in ipairs(self.playerChoosedScheduleList) do
		if iter_24_1 ~= 0 then
			var_24_0[iter_24_1] = var_24_0[iter_24_1] + 1
			var_24_1[var_0_9[iter_24_1]] = var_24_1[var_0_9[iter_24_1]] + 1
		end
	end

	for iter_24_2, iter_24_3 in ipairs(var_24_0) do
		if iter_24_3 > 16 then
			return var_0_10[iter_24_2] .. i18n("dorm3d_nengdai_minigame_evaluate2")
		elseif iter_24_3 > 11 then
			return var_0_10[iter_24_2] .. i18n("dorm3d_nengdai_minigame_evaluate1")
		end
	end

	for iter_24_4, iter_24_5 in pairs(var_24_1) do
		if iter_24_5 > 20 then
			return i18n("dorm3d_nengdai_minigame_evaluate4") .. var_0_11[iter_24_4]
		elseif iter_24_5 > 11 then
			return i18n("dorm3d_nengdai_minigame_evaluate3") .. var_0_11[iter_24_4]
		end
	end

	return i18n("dorm3d_nengdai_minigame_evaluate5")
end

function NengDaiScheduleGameView:checkGameExit()
	if not self.gameStartFlag then
		self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
			operationCode = "GAME_CLOSE",
			doTrack = true,
			miniGameId = var_0_1
		})
		self:emit(NengDaiScheduleGameView.ON_BACK_PRESSED)
	else
		if self.gameStop then
			return
		end

		self:pauseGame()

		if self.contextData.isDorm3d then
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
				contentText = i18n("mini_game_leave"),
				onConfirm = function()
					self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
						operationCode = "GAME_CLOSE",
						doTrack = false,
						miniGameId = var_0_1
					})
					self:emit(NengDaiScheduleGameView.ON_BACK_PRESSED)

					return
				end,
				onClose = function()
					self:resumeGame()

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("mini_game_leave"),
				onYes = function()
					self:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
						operationCode = "GAME_CLOSE",
						doTrack = false,
						miniGameId = var_0_1
					})
					self:emit(NengDaiScheduleGameView.ON_BACK_PRESSED)

					return
				end,
				onNo = function()
					self:resumeGame()

					return
				end
			})
		end
	end

	return
end

function NengDaiScheduleGameView:getMiniGameData()
	self._mgData = self._mgData or getProxy(MiniGameProxy):GetMiniGameData(var_0_1)

	return self._mgData
end

function NengDaiScheduleGameView:onBackPressed()
	self:checkGameExit()

	return
end

function NengDaiScheduleGameView:willExit()
	if self.timer and self.timer.running then
		self.timer:Stop()
	end

	self.timer = nil

	return
end

return NengDaiScheduleGameView
