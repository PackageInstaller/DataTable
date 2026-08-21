local var_0_0 = class("NengDaiScheduleGameView", import("view.base.BaseUI"))
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

function var_0_0.getUIName(arg_1_0)
	return "NengDaiScheduleGameView"
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:readyStart()
	arg_2_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
		operationCode = "GAME_READY",
		miniGameId = var_0_1
	})

	return
end

function var_0_0.initData(arg_3_0)
	local var_3_0 = Application.targetFrameRate or 60

	if var_3_0 > 60 then
		var_3_0 = 60
	end

	arg_3_0.stepCount = 1 / var_3_0 * 0.9
	arg_3_0.realTimeStartUp = Time.realtimeSinceStartup
	arg_3_0.timer = Timer.New(function()
		if Time.realtimeSinceStartup - arg_3_0.realTimeStartUp > arg_3_0.stepCount then
			arg_3_0:onTimer()

			arg_3_0.realTimeStartUp = Time.realtimeSinceStartup
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

function var_0_0.onTimer(arg_5_0)
	arg_5_0.deltaTime = Time.realtimeSinceStartup - arg_5_0.realTimeStartUp

	if not arg_5_0.startSettlement then
		arg_5_0.gameTime = arg_5_0.gameTime - arg_5_0.deltaTime
		arg_5_0.gameStepTime = arg_5_0.gameStepTime + arg_5_0.deltaTime

		if arg_5_0.gameTime < 0 then
			arg_5_0.gameTime = 0
		end
	end

	if arg_5_0.showFlag then
		arg_5_0.showTime = arg_5_0.showTime + arg_5_0.deltaTime

		if arg_5_0.showTime >= var_0_3 then
			arg_5_0.showTime = arg_5_0.showTime - var_0_3

			arg_5_0:ChangeMotion()
		end
	end

	if arg_5_0.chooseFlag then
		arg_5_0.chooseTime = arg_5_0.chooseTime - arg_5_0.deltaTime

		if arg_5_0.chooseTime <= 0 then
			if #arg_5_0.playerChoosedScheduleList < 3 * arg_5_0.round then
				for iter_5_0 = #arg_5_0.playerChoosedScheduleList + 1, 3 * arg_5_0.round do
					arg_5_0.playerChoosedScheduleList[iter_5_0] = 0
				end
			end

			arg_5_0:ChangeMotion()
		end
	end

	if arg_5_0.roundSettleFlag then
		arg_5_0.roundSettleTime = arg_5_0.roundSettleTime + arg_5_0.deltaTime

		if arg_5_0.roundSettleTime >= var_0_5 then
			arg_5_0.roundSettleTime = arg_5_0.roundSettleTime - var_0_5

			arg_5_0:ChangeMotion()
		end
	end

	local var_5_0 = math.ceil(arg_5_0.gameTime)

	setText(arg_5_0.gameUITime, string.format("%02d", (math.floor(var_5_0 / 60))) .. ":" .. string.format("%02d", var_5_0 % 60))
	arg_5_0:GamingLogic()

	if arg_5_0.gameTime <= 0 then
		arg_5_0:onGameOver()
	end

	return
end

function var_0_0.initUI(arg_6_0)
	arg_6_0.bgTf = arg_6_0._tf:Find("bg")
	arg_6_0.clickMask = arg_6_0._tf:Find("clickMask")
	arg_6_0.gameUI = arg_6_0._tf:Find("ui/gameUI")
	arg_6_0.gameTop = arg_6_0.gameUI:Find("top")
	arg_6_0.gameUIScore = arg_6_0.gameTop:Find("score/text")
	arg_6_0.gameUITime = arg_6_0.gameTop:Find("time/text")
	arg_6_0.gameUILeave = arg_6_0.gameUI:Find("btnLeave")

	setActive(arg_6_0.gameTop, false)
	onButton(arg_6_0, arg_6_0.gameUILeave, function()
		arg_6_0:checkGameExit()

		return
	end, SFX_PANEL)

	arg_6_0.gamingUI = arg_6_0._tf:Find("gamingUI")
	arg_6_0.gamingShow = arg_6_0.gamingUI:Find("show")
	arg_6_0.gamingChoose = arg_6_0.gamingUI:Find("choose")
	arg_6_0.gamingSettlement = arg_6_0.gamingUI:Find("settlement")

	setActive(arg_6_0.gamingShow, true)
	setActive(arg_6_0.gamingChoose, true)
	setActive(arg_6_0.gamingSettlement, false)
	setActive(arg_6_0.gamingUI, false)
	setText(arg_6_0.gamingSettlement:Find("dayList/Monday"), i18n("dorm3d_nengdai_minigame_day1"))
	setText(arg_6_0.gamingSettlement:Find("dayList/Tuesday"), i18n("dorm3d_nengdai_minigame_day2"))
	setText(arg_6_0.gamingSettlement:Find("dayList/Wednesday"), i18n("dorm3d_nengdai_minigame_day3"))
	setText(arg_6_0.gamingSettlement:Find("dayList/Thursday"), i18n("dorm3d_nengdai_minigame_day4"))
	setText(arg_6_0.gamingSettlement:Find("dayList/Friday"), i18n("dorm3d_nengdai_minigame_day5"))
	setText(arg_6_0.gamingSettlement:Find("dayList/Saturday"), i18n("dorm3d_nengdai_minigame_day6"))
	setText(arg_6_0.gamingSettlement:Find("dayList/Sunday"), i18n("dorm3d_nengdai_minigame_day7"))
	setText(arg_6_0.gamingChoose:Find("state1"), i18n("dorm3d_nengdai_minigame_remember"))
	setText(arg_6_0.gamingChoose:Find("state2/text"), i18n("dorm3d_nengdai_minigame_choose"))

	for iter_6_0 = 0, 8 do
		local var_6_0 = arg_6_0.gamingChoose:Find("scheduleList"):GetChild(iter_6_0):GetChild(0)

		for iter_6_1 = 0, 11 do
			local var_6_1 = var_6_0:GetChild(iter_6_1)

			setText(var_6_1:GetChild(0), var_0_10[iter_6_1 + 1])
		end
	end

	arg_6_0.count = arg_6_0._tf:Find("count")

	setActive(arg_6_0.count, true)
	arg_6_0.count:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_6_0:gameStart()

		return
	end)

	return
end

function var_0_0.GamingLogic(arg_9_0)
	if not arg_9_0.hasDone then
		arg_9_0.hasDone = true

		if arg_9_0.showFlag then
			setActive(arg_9_0.gamingChoose:Find("state1"), true)
			setActive(arg_9_0.gamingChoose:Find("state2"), false)
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("morningSchedule"):GetChild(0), true, 1)
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("noonSchedule"):GetChild(0), true, 1)
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("nightSchedule"):GetChild(0), true, 1)
			arg_9_0:SetScheduleFrame(arg_9_0.gamingShow:Find("morningSchedule"):GetChild(0), "")
			arg_9_0:SetScheduleFrame(arg_9_0.gamingShow:Find("noonSchedule"):GetChild(0), "")
			arg_9_0:SetScheduleFrame(arg_9_0.gamingShow:Find("nightSchedule"):GetChild(0), "")
			setText(arg_9_0.gamingShow:Find("day"), i18n("dorm3d_nengdai_minigame_day" .. arg_9_0.round))

			for iter_9_0 = 0, 6 do
				local var_9_0 = arg_9_0.gamingShow:Find("dayEng")

				setActive(var_9_0:GetChild(iter_9_0), iter_9_0 + 1 == arg_9_0.round)
			end

			for iter_9_1 = 0, 8 do
				local var_9_1 = arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_1)

				arg_9_0:SetScheduleFrame(var_9_1:GetChild(0), "")
			end

			for iter_9_2 = 0, 8 do
				local var_9_2 = arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_2)

				arg_9_0:ShowSchedule(var_9_2:GetChild(0), false)
			end

			setActive(arg_9_0.gamingShow:Find("scoreAdd"), false)
		elseif arg_9_0.chooseFlag then
			setActive(arg_9_0.gamingChoose:Find("state1"), false)
			setActive(arg_9_0.gamingChoose:Find("state2"), true)
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("morningSchedule"):GetChild(0), true, 0, 0)
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("noonSchedule"):GetChild(0), true, 0, 0)
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("nightSchedule"):GetChild(0), true, 0, 0)

			while #{} < 3 do
				table.insert({}, table.remove({
					0,
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8
				}, (math.random(#{
					0,
					1,
					2,
					3,
					4,
					5,
					6,
					7,
					8
				}))))
			end

			local var_9_3 = 1

			for iter_9_3 = 0, 8 do
				local var_9_5
				local var_9_6

				if table.contains({}, iter_9_3) then
					local var_9_4 = arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0)

					arg_9_0:ShowSchedule(var_9_4, true, 2, arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + var_9_3])

					var_9_3 = var_9_3 + 1

					goto label_9_0

					var_9_5 = arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0)
				end

				arg_9_0:ShowSchedule(var_9_5, true, 2)

				do
					var_9_6 = arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_3)
				end

				::label_9_0::

				onButton(arg_9_0, var_9_6, function()
					if not arg_9_0:IsShowing(arg_9_0.gamingShow:Find("morningSchedule"):GetChild(0)) then
						arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("morningSchedule"):GetChild(0), true, 3, arg_9_0.chooseScheduleList[iter_9_3 + 1])
						arg_9_0:SetScheduleFrame(arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0), "morningChoose")
					elseif not arg_9_0:IsShowing(arg_9_0.gamingShow:Find("noonSchedule"):GetChild(0)) then
						arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("noonSchedule"):GetChild(0), true, 3, arg_9_0.chooseScheduleList[iter_9_3 + 1])
						arg_9_0:SetScheduleFrame(arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0), "noonChoose")
					elseif not arg_9_0:IsShowing(arg_9_0.gamingShow:Find("nightSchedule"):GetChild(0)) then
						arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("nightSchedule"):GetChild(0), true, 3, arg_9_0.chooseScheduleList[iter_9_3 + 1])
						arg_9_0:SetScheduleFrame(arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_3):GetChild(0), "nightChoose")
						arg_9_0:ChangeMotion()
					end

					removeOnButton(arg_9_0.gamingChoose:Find("scheduleList"):GetChild(iter_9_3))

					return
				end, SFX_PANEL)
			end
		elseif arg_9_0.roundSettleFlag then
			setActive(arg_9_0.gamingChoose:Find("state1"), false)
			setActive(arg_9_0.gamingChoose:Find("state2"), false)
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("morningSchedule"):GetChild(0), true, 0, arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + 1])
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("noonSchedule"):GetChild(0), true, 0, arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + 2])
			arg_9_0:ShowSchedule(arg_9_0.gamingShow:Find("nightSchedule"):GetChild(0), true, 0, arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + 3])

			local var_9_7 = 0

			for iter_9_4 = 1, 3 do
				local var_9_8 = "wrong"

				if arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + iter_9_4] == arg_9_0.playerChoosedScheduleList[3 * (arg_9_0.round - 1) + iter_9_4] then
					var_9_7 = var_9_7 + 100
					var_9_8 = "right"
				end

				if iter_9_4 == 1 then
					local var_9_9 = arg_9_0.gamingShow:Find("morningSchedule")

					arg_9_0:SetScheduleFrame(var_9_9:GetChild(0), var_9_8)
				elseif iter_9_4 == 2 then
					local var_9_10 = arg_9_0.gamingShow:Find("noonSchedule")

					arg_9_0:SetScheduleFrame(var_9_10:GetChild(0), var_9_8)
				elseif iter_9_4 == 3 then
					local var_9_11 = arg_9_0.gamingShow:Find("nightSchedule")

					arg_9_0:SetScheduleFrame(var_9_11:GetChild(0), var_9_8)
				end
			end

			arg_9_0.scoreNum = arg_9_0.scoreNum + var_9_7

			setText(arg_9_0.gameUIScore, arg_9_0.scoreNum)
			setActive(arg_9_0.gamingShow:Find("scoreAdd"), true)

			for iter_9_5 = 0, 3 do
				local var_9_12 = arg_9_0.gamingShow:Find("scoreAdd")

				setActive(var_9_12:GetChild(iter_9_5), var_9_7 == 100 * iter_9_5)
			end

			arg_9_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
				operationCode = "ROUND_RESULT",
				success = var_9_7 >= 200,
				miniGameId = var_0_1
			})
		end
	end

	if arg_9_0.showFlag then
		setSlider(arg_9_0.gamingChoose:Find("timeSlider"), 0, var_0_3, var_0_3 - arg_9_0.showTime)
	end

	if arg_9_0.chooseFlag then
		setText(arg_9_0.gamingChoose:Find("state2/chooseTime"), math.ceil(arg_9_0.chooseTime))
		setSlider(arg_9_0.gamingChoose:Find("timeSlider"), 0, var_0_4, arg_9_0.chooseTime)
	end

	return
end

function var_0_0.ChangeMotion(arg_11_0)
	if arg_11_0.showFlag then
		arg_11_0.hasDone = false
		arg_11_0.showFlag = false
		arg_11_0.chooseFlag = true
		arg_11_0.roundSettleFlag = false
		arg_11_0.chooseTime = 10

		table.insertto(arg_11_0.RandomPool, var_0_7)
	elseif arg_11_0.chooseFlag then
		arg_11_0.hasDone = false
		arg_11_0.showFlag = false
		arg_11_0.chooseFlag = false
		arg_11_0.roundSettleFlag = true
	elseif arg_11_0.roundSettleFlag then
		if arg_11_0.round == 7 then
			arg_11_0:onGameOver()
		else
			arg_11_0.hasDone = false
			arg_11_0.showFlag = true
			arg_11_0.chooseFlag = false
			arg_11_0.roundSettleFlag = false
			arg_11_0.round = arg_11_0.round + 1
			arg_11_0.chooseScheduleList = {}
			arg_11_0.RandomPool = Clone(var_0_7)
		end
	end

	return
end

function var_0_0.ShowSchedule(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_2 then
		if not arg_12_4 then
			local var_12_0 = math.random(#arg_12_0.RandomPool)

			arg_12_4 = arg_12_0.RandomPool[var_12_0]

			table.remove(arg_12_0.RandomPool, var_12_0)
		end

		if arg_12_3 == 1 then
			table.insert(arg_12_0.showScheduleList, arg_12_4)
		end

		if arg_12_3 == 2 then
			table.insert(arg_12_0.chooseScheduleList, arg_12_4)
		end

		if arg_12_3 == 3 then
			table.insert(arg_12_0.playerChoosedScheduleList, arg_12_4)
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

function var_0_0.SetScheduleFrame(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0 = 13, arg_13_1.childCount - 1 do
		setActive(arg_13_1:GetChild(iter_13_0), arg_13_1:GetChild(iter_13_0).name == arg_13_2)
	end

	return
end

function var_0_0.IsShowing(arg_14_0, arg_14_1)
	return not isActive(arg_14_1:GetChild(12))
end

function var_0_0.readyStart(arg_15_0)
	arg_15_0.scoreNum = 0
	arg_15_0.gameTime = var_0_2
	arg_15_0.gameStepTime = 0
	arg_15_0.showTime = 0
	arg_15_0.roundSettleTime = 0
	arg_15_0.hasDone = false
	arg_15_0.showFlag = true
	arg_15_0.chooseFlag = false
	arg_15_0.roundSettleFlag = false
	arg_15_0.showScheduleList = {}
	arg_15_0.chooseScheduleList = {}
	arg_15_0.playerChoosedScheduleList = {}
	arg_15_0.RandomPool = Clone(var_0_7)
	arg_15_0.round = 1

	arg_15_0.count:GetComponent(typeof(Animator)):Play("count")

	return
end

function var_0_0.gameStart(arg_16_0)
	arg_16_0.gameStartFlag = true

	setActive(arg_16_0.count, false)
	setActive(arg_16_0.gameTop, true)
	setActive(arg_16_0.gamingUI, true)
	setText(arg_16_0.gameUIScore, arg_16_0.scoreNum)
	arg_16_0:timerStart()

	return
end

function var_0_0.timerStart(arg_17_0)
	if not arg_17_0.timer.running then
		arg_17_0.realTimeStartUp = Time.realtimeSinceStartup

		arg_17_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_18_0)
	if arg_18_0.timer.running then
		arg_18_0.timer:Stop()
	end

	return
end

function var_0_0.pauseGame(arg_19_0)
	arg_19_0.gameStop = true

	arg_19_0:timerStop()

	return
end

function var_0_0.resumeGame(arg_20_0)
	arg_20_0.gameStop = false

	arg_20_0:timerStart()

	return
end

function var_0_0.onGameOver(arg_21_0)
	arg_21_0:timerStop()
	setActive(arg_21_0.clickMask, true)
	setActive(arg_21_0.gameTop, false)
	LeanTween.delayedCall(go(arg_21_0._tf), 0.1, System.Action(function()
		arg_21_0.gameStartFlag = false

		setActive(arg_21_0.clickMask, false)
		arg_21_0:GameSettlement()
		arg_21_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
			operationCode = "GAME_RESULT",
			score = arg_21_0.scoreNum,
			miniGameId = var_0_1
		})

		return
	end))

	return
end

function var_0_0.GameSettlement(arg_23_0)
	setActive(arg_23_0.gamingShow, false)
	setActive(arg_23_0.gamingChoose, false)
	setActive(arg_23_0.gamingSettlement, true)

	for iter_23_0 = 0, 20 do
		local var_23_0 = arg_23_0.gamingSettlement:Find("scheduleResultList"):GetChild(iter_23_0):GetChild(0)

		arg_23_0:ShowSchedule(var_23_0, true, 0, arg_23_0.playerChoosedScheduleList[iter_23_0 + 1])
	end

	arg_23_0.scoreNum = arg_23_0.scoreNum + 10 * math.ceil(arg_23_0.gameTime)

	setText(arg_23_0.gamingSettlement:Find("currentScore/Text"), arg_23_0.scoreNum)

	local var_23_1 = getProxy(PlayerProxy):getPlayerId()
	local var_23_2 = PlayerPrefs.GetInt("mg_score_" .. tostring(var_23_1) .. "_" .. var_0_1) or 0

	setActive(arg_23_0.gamingSettlement:Find("currentScore/new"), var_23_2 < arg_23_0.scoreNum)

	if var_23_2 < arg_23_0.scoreNum then
		var_23_2 = arg_23_0.scoreNum

		PlayerPrefs.SetInt("mg_score_" .. tostring(var_23_1) .. "_" .. var_0_1, arg_23_0.scoreNum)
	end

	setText(arg_23_0.gamingSettlement:Find("highestScore/Text"), var_23_2)

	local var_23_3 = math.ceil(arg_23_0.gameTime)

	setText(arg_23_0.gamingSettlement:Find("remainingTime/Text"), string.format("%02d", (math.floor(var_23_3 / 60))) .. ":" .. string.format("%02d", var_23_3 % 60))
	setText(arg_23_0.gamingSettlement:Find("result/Text"), arg_23_0:GetEvaluation())

	return
end

function var_0_0.GetEvaluation(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0.playerChoosedScheduleList) do
		if iter_24_1 ~= 0 then
			({
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
			})[iter_24_1] = ({
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
			})[iter_24_1] + 1
			;({
				study = 0,
				sport = 0,
				housework = 0,
				entertainment = 0
			})[var_0_9[iter_24_1]] = ({
				study = 0,
				sport = 0,
				housework = 0,
				entertainment = 0
			})[var_0_9[iter_24_1]] + 1
		end
	end

	for iter_24_2, iter_24_3 in ipairs({
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
	}) do
		if iter_24_3 > 16 then
			return var_0_10[iter_24_2] .. i18n("dorm3d_nengdai_minigame_evaluate2")
		elseif iter_24_3 > 11 then
			return var_0_10[iter_24_2] .. i18n("dorm3d_nengdai_minigame_evaluate1")
		end
	end

	for iter_24_4, iter_24_5 in pairs({
		study = 0,
		sport = 0,
		housework = 0,
		entertainment = 0
	}) do
		if iter_24_5 > 20 then
			return i18n("dorm3d_nengdai_minigame_evaluate4") .. var_0_11[iter_24_4]
		elseif iter_24_5 > 11 then
			return i18n("dorm3d_nengdai_minigame_evaluate3") .. var_0_11[iter_24_4]
		end
	end

	return i18n("dorm3d_nengdai_minigame_evaluate5")
end

function var_0_0.checkGameExit(arg_25_0)
	if not arg_25_0.gameStartFlag then
		arg_25_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
			operationCode = "GAME_CLOSE",
			doTrack = true,
			miniGameId = var_0_1
		})
		arg_25_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_25_0.gameStop then
			return
		end

		arg_25_0:pauseGame()

		if arg_25_0.contextData.isDorm3d then
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_MSGBOX, {
				contentText = i18n("mini_game_leave"),
				onConfirm = function()
					arg_25_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
						operationCode = "GAME_CLOSE",
						doTrack = false,
						miniGameId = var_0_1
					})
					arg_25_0:emit(var_0_0.ON_BACK_PRESSED)

					return
				end,
				onClose = function()
					arg_25_0:resumeGame()

					return
				end
			})
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("mini_game_leave"),
				onYes = function()
					arg_25_0:emit(Dorm3dMiniGameMediator.GAME_OPERATION, {
						operationCode = "GAME_CLOSE",
						doTrack = false,
						miniGameId = var_0_1
					})
					arg_25_0:emit(var_0_0.ON_BACK_PRESSED)

					return
				end,
				onNo = function()
					arg_25_0:resumeGame()

					return
				end
			})
		end
	end

	return
end

function var_0_0.getMiniGameData(arg_30_0)
	arg_30_0._mgData = arg_30_0._mgData or getProxy(MiniGameProxy):GetMiniGameData(var_0_1)

	return arg_30_0._mgData
end

function var_0_0.onBackPressed(arg_31_0)
	arg_31_0:checkGameExit()

	return
end

function var_0_0.willExit(arg_32_0)
	if arg_32_0.timer and arg_32_0.timer.running then
		arg_32_0.timer:Stop()
	end

	arg_32_0.timer = nil

	return
end

return var_0_0
