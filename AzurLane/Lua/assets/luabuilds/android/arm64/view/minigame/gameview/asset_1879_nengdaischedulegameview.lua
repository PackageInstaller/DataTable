class = var_0_10000

local var_0_0 = "NengDaiScheduleGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))
local var_0_2 = 70
local var_0_3 = 105
local var_0_4 = 3
local var_0_5 = 10
local var_0_6 = 2
local var_0_7 = 7
local var_0_8 = {
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
	"read",
	"draw",
	"study",
	"dance",
	"volleyball",
	"run",
	"clean",
	"cook",
	"washClothes",
	"game",
	"walk",
	"sleep"
}
local var_0_10 = {
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
local var_0_11 = {
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
local var_0_12 = {
	study = "学习",
	sport = "运动",
	housework = "家务",
	entertainment = "娱乐"
}

function var_0_1.getUIName(arg_1_0)
	return "NengDaiScheduleGameView"
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0:initData()
	arg_2_0:initUI()
	arg_2_0:readyStart()

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.emit

	Dorm3dMiniGameMediator = var_1_10004

	var_2_1(var_2_0, var_1_10004.GAME_OPERATION, {
		operationCode = "GAME_READY",
		miniGameId = var_0_2
	})

	return
end

function var_0_1.initData(arg_3_0)
	Application = var_1_10001

	local var_3_0

	if not var_1_10001.targetFrameRate then
		var_3_0 = 60
	end

	if var_3_0 > 60 then
		var_3_0 = 60
	end

	arg_3_0.stepCount = 1 / var_3_0 * 0.9
	Time = var_2
	arg_3_0.realTimeStartUp = var_2.realtimeSinceStartup
	Timer = var_2
	arg_3_0.timer = var_2.New(function()
		Time = var_2_10000

		local var_4_0 = var_2_10000.realtimeSinceStartup - arg_3_0.realTimeStartUp

		if arg_3_0.stepCount < var_4_0 then
			local var_4_1 = arg_3_0

			var_0.onTimer(var_4_1)

			local var_4_2 = arg_3_0

			Time = var_1
			var_4_2.realTimeStartUp = var_1.realtimeSinceStartup
		end

		return
	end, 1 / var_3_0, -1)

	for iter_3_0 = 1, #var_0_11 do
		local var_3_1 = var_0_11

		i18n = var_1_10007
		var_3_1[iter_3_0] = var_1_10007("dorm3d_nengdai_minigame_behavior" .. iter_3_0)
	end

	local var_3_2 = var_0_12

	i18n = var_3
	var_3_2.study = var_3("dorm3d_nengdai_minigame_behavior_type1")

	local var_3_3 = var_0_12

	i18n = var_3
	var_3_3.sport = var_3("dorm3d_nengdai_minigame_behavior_type2")

	local var_3_4 = var_0_12

	i18n = var_3
	var_3_4.housework = var_3("dorm3d_nengdai_minigame_behavior_type3")

	local var_3_5 = var_0_12

	i18n = var_3
	var_3_5.entertainment = var_3("dorm3d_nengdai_minigame_behavior_type4")

	return
end

function var_0_1.onTimer(arg_5_0)
	Time = var_1_10001
	arg_5_0.deltaTime = var_1_10001.realtimeSinceStartup - arg_5_0.realTimeStartUp

	if not arg_5_0.startSettlement then
		arg_5_0.gameTime = arg_5_0.gameTime - arg_5_0.deltaTime
		arg_5_0.gameStepTime = arg_5_0.gameStepTime + arg_5_0.deltaTime

		if arg_5_0.gameTime < 0 then
			arg_5_0.gameTime = 0
		end
	end

	if arg_5_0.showFlag then
		arg_5_0.showTime = arg_5_0.showTime + arg_5_0.deltaTime

		local var_5_0 = arg_5_0.showTime

		if var_0_4 <= var_5_0 then
			arg_5_0.showTime = arg_5_0.showTime - var_0_4

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

	local var_5_1

	if arg_5_0.roundSettleFlag then
		arg_5_0.roundSettleTime = arg_5_0.roundSettleTime + arg_5_0.deltaTime
		var_5_1 = arg_5_0.roundSettleTime

		if var_0_6 <= var_5_1 then
			arg_5_0.roundSettleTime = arg_5_0.roundSettleTime - var_0_6

			arg_5_0:ChangeMotion()
		end
	end

	math = var_5_1

	local var_5_2 = var_5_1.ceil(arg_5_0.gameTime)

	math = var_2

	local var_5_3 = var_2.floor(var_5_2 / 60)
	local var_5_4 = var_5_2 % 60

	setText = var_4

	local var_5_5 = arg_5_0.gameUITime

	string = var_1_10007

	local var_5_6 = var_1_10007.format("%02d", var_5_3)
	local var_5_7 = ":"

	string = var_9

	var_4(var_5_5, var_5_6 .. var_5_7 .. var_9.format("%02d", var_5_4))
	arg_5_0:GamingLogic()

	if arg_5_0.gameTime <= 0 then
		arg_5_0:onGameOver()
	end

	return
end

function var_0_1.initUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.bgTf = var_1.Find(var_6_0, "bg")

	local var_6_1 = arg_6_0._tf

	arg_6_0.clickMask = var_1.Find(var_6_1, "clickMask")

	local var_6_2 = arg_6_0._tf

	arg_6_0.gameUI = var_1.Find(var_6_2, "ui/gameUI")

	local var_6_3 = arg_6_0.gameUI

	arg_6_0.gameTop = var_1.Find(var_6_3, "top")

	local var_6_4 = arg_6_0.gameTop

	arg_6_0.gameUIScore = var_1.Find(var_6_4, "score/text")

	local var_6_5 = arg_6_0.gameTop

	arg_6_0.gameUITime = var_1.Find(var_6_5, "time/text")

	local var_6_6 = arg_6_0.gameUI

	arg_6_0.gameUILeave = var_1.Find(var_6_6, "btnLeave")
	setActive = var_1

	var_1(arg_6_0.gameTop, false)

	onButton = var_1

	local var_6_7 = arg_6_0
	local var_6_8 = arg_6_0.gameUILeave

	local function var_6_9()
		local var_7_0 = arg_6_0

		var_0.checkGameExit(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_6_7, var_6_8, var_6_9, var_1_10006)

	local var_6_10 = arg_6_0._tf

	arg_6_0.gamingUI = var_1.Find(var_6_10, "gamingUI")

	local var_6_11 = arg_6_0.gamingUI

	arg_6_0.gamingShow = var_1.Find(var_6_11, "show")

	local var_6_12 = arg_6_0.gamingUI

	arg_6_0.gamingChoose = var_1.Find(var_6_12, "choose")

	local var_6_13 = arg_6_0.gamingUI

	arg_6_0.gamingSettlement = var_1.Find(var_6_13, "settlement")
	setActive = var_1

	var_1(arg_6_0.gamingShow, true)

	setActive = var_1

	var_1(arg_6_0.gamingChoose, true)

	setActive = var_1

	var_1(arg_6_0.gamingSettlement, false)

	setActive = var_1

	var_1(arg_6_0.gamingUI, false)

	setText = var_1

	local var_6_14 = arg_6_0.gamingSettlement
	local var_6_15 = var_3.Find(var_6_14, "dayList/Monday")

	i18n = var_4

	var_1(var_6_15, var_4("dorm3d_nengdai_minigame_day1"))

	setText = var_1

	local var_6_16 = arg_6_0.gamingSettlement
	local var_6_17 = var_3.Find(var_6_16, "dayList/Tuesday")

	i18n = var_4

	var_1(var_6_17, var_4("dorm3d_nengdai_minigame_day2"))

	setText = var_1

	local var_6_18 = arg_6_0.gamingSettlement
	local var_6_19 = var_3.Find(var_6_18, "dayList/Wednesday")

	i18n = var_4

	var_1(var_6_19, var_4("dorm3d_nengdai_minigame_day3"))

	setText = var_1

	local var_6_20 = arg_6_0.gamingSettlement
	local var_6_21 = var_3.Find(var_6_20, "dayList/Thursday")

	i18n = var_4

	var_1(var_6_21, var_4("dorm3d_nengdai_minigame_day4"))

	setText = var_1

	local var_6_22 = arg_6_0.gamingSettlement
	local var_6_23 = var_3.Find(var_6_22, "dayList/Friday")

	i18n = var_4

	var_1(var_6_23, var_4("dorm3d_nengdai_minigame_day5"))

	setText = var_1

	local var_6_24 = arg_6_0.gamingSettlement
	local var_6_25 = var_3.Find(var_6_24, "dayList/Saturday")

	i18n = var_4

	var_1(var_6_25, var_4("dorm3d_nengdai_minigame_day6"))

	setText = var_1

	local var_6_26 = arg_6_0.gamingSettlement
	local var_6_27 = var_3.Find(var_6_26, "dayList/Sunday")

	i18n = var_4

	var_1(var_6_27, var_4("dorm3d_nengdai_minigame_day7"))

	setText = var_1

	local var_6_28 = arg_6_0.gamingChoose
	local var_6_29 = var_3.Find(var_6_28, "state1")

	i18n = var_4

	var_1(var_6_29, var_4("dorm3d_nengdai_minigame_remember"))

	setText = var_1

	local var_6_30 = arg_6_0.gamingChoose
	local var_6_31 = var_3.Find(var_6_30, "state2/text")

	i18n = var_4

	var_1(var_6_31, var_4("dorm3d_nengdai_minigame_choose"))

	for iter_6_0 = 0, 8 do
		local var_6_32 = arg_6_0.gamingChoose
		local var_6_33 = var_5.Find(var_6_32, "scheduleList")
		local var_6_34 = var_5.GetChild(var_6_33, iter_6_0)
		local var_6_35 = var_5.GetChild(var_6_34, 0)

		for iter_6_1 = 0, 11 do
			setText = var_1_10010

			local var_6_36 = var_6_35:GetChild(iter_6_1)

			var_1_10010(var_12.GetChild(var_6_36, 0), var_0_11[iter_6_1 + 1])
		end
	end

	local var_6_37 = arg_6_0._tf

	arg_6_0.count = var_1.Find(var_6_37, "count")
	setActive = var_1

	var_1(arg_6_0.count, true)

	local var_6_38 = arg_6_0.count
	local var_6_39 = var_1.GetComponent

	typeof = var_4
	DftAniEvent = var_6

	local var_6_40 = var_6_39(var_6_38, var_4(var_6))

	var_1.SetEndEvent(var_6_40, function()
		local var_8_0 = arg_6_0

		var_0.gameStart(var_8_0)

		return
	end)

	return
end

function var_0_1.GamingLogic(arg_9_0)
	if not arg_9_0.hasDone then
		arg_9_0.hasDone = true

		if arg_9_0.showFlag then
			setActive = var_1

			local var_9_0 = arg_9_0.gamingChoose

			var_1(var_3.Find(var_9_0, "state1"), true)

			setActive = var_1

			local var_9_1 = arg_9_0.gamingChoose

			var_1(var_3.Find(var_9_1, "state2"), false)

			local var_9_2 = arg_9_0
			local var_9_3 = arg_9_0.ShowSchedule
			local var_9_4 = arg_9_0.gamingShow
			local var_9_5 = iter_9_2.Find(var_9_4, "morningSchedule")

			var_9_3(var_9_2, iter_9_2.GetChild(var_9_5, 0), true, 1)

			local var_9_6 = arg_9_0
			local var_9_7 = arg_9_0.ShowSchedule
			local var_9_8 = arg_9_0.gamingShow
			local var_9_9 = iter_9_2.Find(var_9_8, "noonSchedule")

			var_9_7(var_9_6, iter_9_2.GetChild(var_9_9, 0), true, 1)

			local var_9_10 = arg_9_0
			local var_9_11 = arg_9_0.ShowSchedule
			local var_9_12 = arg_9_0.gamingShow
			local var_9_13 = iter_9_2.Find(var_9_12, "nightSchedule")

			var_9_11(var_9_10, iter_9_2.GetChild(var_9_13, 0), true, 1)

			local var_9_14 = arg_9_0
			local var_9_15 = arg_9_0.SetScheduleFrame
			local var_9_16 = arg_9_0.gamingShow
			local var_9_17 = iter_9_2.Find(var_9_16, "morningSchedule")

			var_9_15(var_9_14, iter_9_2.GetChild(var_9_17, 0), "")

			local var_9_18 = arg_9_0
			local var_9_19 = arg_9_0.SetScheduleFrame
			local var_9_20 = arg_9_0.gamingShow
			local var_9_21 = iter_9_2.Find(var_9_20, "noonSchedule")

			var_9_19(var_9_18, iter_9_2.GetChild(var_9_21, 0), "")

			local var_9_22 = arg_9_0
			local var_9_23 = arg_9_0.SetScheduleFrame
			local var_9_24 = arg_9_0.gamingShow
			local var_9_25 = iter_9_2.Find(var_9_24, "nightSchedule")

			var_9_23(var_9_22, iter_9_2.GetChild(var_9_25, 0), "")

			setText = var_9_23

			local var_9_26 = arg_9_0.gamingShow
			local var_9_27 = var_3.Find(var_9_26, "day")

			i18n = iter_9_2

			var_9_23(var_9_27, iter_9_2("dorm3d_nengdai_minigame_day" .. arg_9_0.round))

			for iter_9_2 = 0, 6 do
				setActive = var_9_26

				local var_9_28 = arg_9_0.gamingShow
				local var_9_29 = var_7.Find(var_9_28, "dayEng")
				local var_9_30 = var_7.GetChild(var_9_29, iter_9_2)

				var_1_10008 = iter_9_2 + 1 == arg_9_0.round

				var_9_26(var_9_30, var_1_10008)
			end

			for iter_9_2 = 0, 8 do
				local var_9_31 = arg_9_0
				local var_9_32 = arg_9_0.SetScheduleFrame
				local var_9_33 = arg_9_0.gamingChoose
				local var_9_34 = var_1_10008.Find(var_9_33, "scheduleList")
				local var_9_35 = var_1_10008.GetChild(var_9_34, iter_9_2)

				var_9_32(var_9_31, var_1_10008.GetChild(var_9_35, 0), "")
			end

			for iter_9_2 = 0, 8 do
				local var_9_36 = arg_9_0
				local var_9_37 = arg_9_0.ShowSchedule
				local var_9_38 = arg_9_0.gamingChoose
				local var_9_39 = var_1_10008.Find(var_9_38, "scheduleList")
				local var_9_40 = var_1_10008.GetChild(var_9_39, iter_9_2)

				var_9_37(var_9_36, var_1_10008.GetChild(var_9_40, 0), false)
			end

			setActive = var_1

			local var_9_41 = arg_9_0.gamingShow

			var_1(var_3.Find(var_9_41, "scoreAdd"), false)
		elseif arg_9_0.chooseFlag then
			setActive = var_1

			local var_9_42 = arg_9_0.gamingChoose

			var_1(var_3.Find(var_9_42, "state1"), false)

			setActive = var_1

			local var_9_43 = arg_9_0.gamingChoose

			var_1(var_3.Find(var_9_43, "state2"), true)

			local var_9_44 = arg_9_0
			local var_9_45 = arg_9_0.ShowSchedule
			local var_9_46 = arg_9_0.gamingShow
			local var_9_47 = iter_9_2.Find(var_9_46, "morningSchedule")

			var_9_45(var_9_44, iter_9_2.GetChild(var_9_47, 0), true, 0, 0)

			local var_9_48 = arg_9_0
			local var_9_49 = arg_9_0.ShowSchedule
			local var_9_50 = arg_9_0.gamingShow
			local var_9_51 = iter_9_2.Find(var_9_50, "noonSchedule")

			var_9_49(var_9_48, iter_9_2.GetChild(var_9_51, 0), true, 0, 0)

			local var_9_52 = arg_9_0
			local var_9_53 = arg_9_0.ShowSchedule
			local var_9_54 = arg_9_0.gamingShow
			local var_9_55 = iter_9_2.Find(var_9_54, "nightSchedule")

			var_9_53(var_9_52, iter_9_2.GetChild(var_9_55, 0), true, 0, 0)

			local var_9_56 = {}
			local var_9_57 = {
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

			while #var_9_56 < 3 do
				math = var_9_58

				local var_9_58 = var_9_58.random(#var_9_57)

				table = iter_9_2
				iter_9_2 = iter_9_2.insert

				local var_9_59 = var_9_56

				table = var_7

				iter_9_2(var_9_59, var_7.remove(var_9_57, var_9_58))
			end

			local var_9_60 = 1

			for iter_9_3 = 0, 8 do
				table = var_1_10008

				if var_1_10008.contains(var_9_56, iter_9_3) then
					local var_9_61 = arg_9_0

					var_1_10008 = arg_9_0.ShowSchedule

					local var_9_62 = arg_9_0.gamingChoose
					local var_9_63 = var_11.Find(var_9_62, "scheduleList")
					local var_9_64 = var_11.GetChild(var_9_63, iter_9_3)

					var_1_10008(var_9_61, var_11.GetChild(var_9_64, 0), true, 2, arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + var_9_60])

					var_9_60 = var_9_60 + 1
				else
					local var_9_65 = arg_9_0

					var_1_10008 = arg_9_0.ShowSchedule

					local var_9_66 = arg_9_0.gamingChoose
					local var_9_67 = var_11.Find(var_9_66, "scheduleList")
					local var_9_68 = var_11.GetChild(var_9_67, iter_9_3)

					var_1_10008(var_9_65, var_11.GetChild(var_9_68, 0), true, 2)
				end

				onButton = var_1_10008

				local var_9_69 = arg_9_0
				local var_9_70 = arg_9_0.gamingChoose
				local var_9_71 = var_11.Find(var_9_70, "scheduleList")
				local var_9_72 = var_11.GetChild(var_9_71, iter_9_3)

				local function var_9_73()
					local var_10_0 = arg_9_0
					local var_10_1 = var_0.IsShowing
					local var_10_2 = arg_9_0.gamingShow
					local var_10_3 = var_3.Find(var_10_2, "morningSchedule")
					local var_10_5

					if not var_10_1(var_10_0, var_3.GetChild(var_10_3, 0)) then
						local var_10_4 = arg_9_0

						var_10_5 = var_10_5.ShowSchedule

						local var_10_6 = arg_9_0.gamingShow
						local var_10_7 = var_3.Find(var_10_6, "morningSchedule")

						var_10_5(var_10_4, var_3.GetChild(var_10_7, 0), true, 3, arg_9_0.chooseScheduleList[iter_9_3 + 1])

						local var_10_8 = arg_9_0

						var_10_5 = var_10_5.SetScheduleFrame

						local var_10_9 = arg_9_0.gamingChoose
						local var_10_10 = var_3.Find(var_10_9, "scheduleList")
						local var_10_11 = var_3.GetChild(var_10_10, iter_9_3)

						var_10_5(var_10_8, var_3.GetChild(var_10_11, 0), "morningChoose")
					else
						local var_10_12 = arg_9_0

						var_10_5 = var_10_5.IsShowing

						local var_10_13 = arg_9_0.gamingShow
						local var_10_14 = var_3.Find(var_10_13, "noonSchedule")

						if not var_10_5(var_10_12, var_3.GetChild(var_10_14, 0)) then
							local var_10_15 = arg_9_0

							var_10_5 = var_10_5.ShowSchedule

							local var_10_16 = arg_9_0.gamingShow
							local var_10_17 = var_3.Find(var_10_16, "noonSchedule")

							var_10_5(var_10_15, var_3.GetChild(var_10_17, 0), true, 3, arg_9_0.chooseScheduleList[iter_9_3 + 1])

							local var_10_18 = arg_9_0

							var_10_5 = var_10_5.SetScheduleFrame

							local var_10_19 = arg_9_0.gamingChoose
							local var_10_20 = var_3.Find(var_10_19, "scheduleList")
							local var_10_21 = var_3.GetChild(var_10_20, iter_9_3)

							var_10_5(var_10_18, var_3.GetChild(var_10_21, 0), "noonChoose")
						else
							local var_10_22 = arg_9_0

							var_10_5 = var_10_5.IsShowing

							local var_10_23 = arg_9_0.gamingShow
							local var_10_24 = var_3.Find(var_10_23, "nightSchedule")

							if not var_10_5(var_10_22, var_3.GetChild(var_10_24, 0)) then
								local var_10_25 = arg_9_0

								var_10_5 = var_10_5.ShowSchedule

								local var_10_26 = arg_9_0.gamingShow
								local var_10_27 = var_3.Find(var_10_26, "nightSchedule")

								var_10_5(var_10_25, var_3.GetChild(var_10_27, 0), true, 3, arg_9_0.chooseScheduleList[iter_9_3 + 1])

								local var_10_28 = arg_9_0

								var_10_5 = var_10_5.SetScheduleFrame

								local var_10_29 = arg_9_0.gamingChoose
								local var_10_30 = var_3.Find(var_10_29, "scheduleList")
								local var_10_31 = var_3.GetChild(var_10_30, iter_9_3)

								var_10_5(var_10_28, var_3.GetChild(var_10_31, 0), "nightChoose")

								local var_10_32 = arg_9_0

								var_10_5.ChangeMotion(var_10_32)
							end
						end
					end

					removeOnButton = var_10_5

					local var_10_33 = arg_9_0.gamingChoose
					local var_10_34 = var_2.Find(var_10_33, "scheduleList")

					var_10_5(var_2.GetChild(var_10_34, iter_9_3))

					return
				end

				SFX_PANEL = var_9_71

				var_1_10008(var_9_69, var_9_72, var_9_73, var_9_71)
			end
		elseif arg_9_0.roundSettleFlag then
			setActive = var_1

			local var_9_74 = arg_9_0.gamingChoose

			var_1(var_3.Find(var_9_74, "state1"), false)

			setActive = var_1

			local var_9_75 = arg_9_0.gamingChoose

			var_1(var_3.Find(var_9_75, "state2"), false)

			local var_9_76 = arg_9_0
			local var_9_77 = arg_9_0.ShowSchedule
			local var_9_78 = arg_9_0.gamingShow
			local var_9_79 = iter_9_2.Find(var_9_78, "morningSchedule")

			var_9_77(var_9_76, iter_9_2.GetChild(var_9_79, 0), true, 0, arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + 1])

			local var_9_80 = arg_9_0
			local var_9_81 = arg_9_0.ShowSchedule
			local var_9_82 = arg_9_0.gamingShow
			local var_9_83 = iter_9_2.Find(var_9_82, "noonSchedule")

			var_9_81(var_9_80, iter_9_2.GetChild(var_9_83, 0), true, 0, arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + 2])

			local var_9_84 = arg_9_0
			local var_9_85 = arg_9_0.ShowSchedule
			local var_9_86 = arg_9_0.gamingShow
			local var_9_87 = iter_9_2.Find(var_9_86, "nightSchedule")

			var_9_85(var_9_84, iter_9_2.GetChild(var_9_87, 0), true, 0, arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + 3])

			local var_9_88 = 0

			for iter_9_4 = 1, 3 do
				local var_9_89 = "wrong"

				if arg_9_0.showScheduleList[3 * (arg_9_0.round - 1) + iter_9_4] == arg_9_0.playerChoosedScheduleList[3 * (arg_9_0.round - 1) + iter_9_4] then
					var_9_88 = var_9_88 + 100
					var_9_89 = "right"
				end

				if iter_9_4 == 1 then
					local var_9_90 = arg_9_0
					local var_9_91 = arg_9_0.SetScheduleFrame
					local var_9_92 = arg_9_0.gamingShow
					local var_9_93 = var_10.Find(var_9_92, "morningSchedule")

					var_9_91(var_9_90, var_10.GetChild(var_9_93, 0), var_9_89)
				elseif iter_9_4 == 2 then
					local var_9_94 = arg_9_0
					local var_9_95 = arg_9_0.SetScheduleFrame
					local var_9_96 = arg_9_0.gamingShow
					local var_9_97 = var_10.Find(var_9_96, "noonSchedule")

					var_9_95(var_9_94, var_10.GetChild(var_9_97, 0), var_9_89)
				elseif iter_9_4 == 3 then
					local var_9_98 = arg_9_0
					local var_9_99 = arg_9_0.SetScheduleFrame
					local var_9_100 = arg_9_0.gamingShow
					local var_9_101 = var_10.Find(var_9_100, "nightSchedule")

					var_9_99(var_9_98, var_10.GetChild(var_9_101, 0), var_9_89)
				end
			end

			arg_9_0.scoreNum = arg_9_0.scoreNum + var_9_88
			setText = var_2

			var_2(arg_9_0.gameUIScore, arg_9_0.scoreNum)

			setActive = var_2

			local var_9_102 = arg_9_0.gamingShow

			var_2(iter_9_2.Find(var_9_102, "scoreAdd"), true)

			for iter_9_5 = 0, 3 do
				setActive = var_9_102

				local var_9_103 = arg_9_0.gamingShow
				local var_9_104 = var_8.Find(var_9_103, "scoreAdd")

				var_9_102(var_8.GetChild(var_9_104, iter_9_5), var_9_88 == 100 * iter_9_5)
			end

			iter_9_2 = arg_9_0

			local var_9_105 = arg_9_0.emit

			Dorm3dMiniGameMediator = iter_9_5

			var_9_105(iter_9_2, iter_9_5.GAME_OPERATION, {
				operationCode = "ROUND_RESULT",
				success = var_9_88 >= 200,
				miniGameId = var_0_2
			})
		end
	end

	if arg_9_0.showFlag then
		setSlider = var_1

		local var_9_106 = arg_9_0.gamingChoose

		var_1(var_3.Find(var_9_106, "timeSlider"), 0, var_0_4, var_0_4 - arg_9_0.showTime)
	end

	if arg_9_0.chooseFlag then
		setText = var_1

		local var_9_107 = arg_9_0.gamingChoose
		local var_9_108 = var_3.Find(var_9_107, "state2/chooseTime")

		math = iter_9_2

		var_1(var_9_108, iter_9_2.ceil(arg_9_0.chooseTime))

		setSlider = var_1

		local var_9_109 = arg_9_0.gamingChoose

		var_1(var_3.Find(var_9_109, "timeSlider"), 0, var_0_5, arg_9_0.chooseTime)
	end

	return
end

function var_0_1.ChangeMotion(arg_11_0)
	if arg_11_0.showFlag then
		arg_11_0.hasDone = false
		arg_11_0.showFlag = false
		arg_11_0.chooseFlag = true
		arg_11_0.roundSettleFlag = false
		arg_11_0.chooseTime = 10
		table = var_1

		var_1.insertto(arg_11_0.RandomPool, var_0_8)
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
			Clone = var_1
			arg_11_0.RandomPool = var_1(var_0_8)
		end
	end

	return
end

function var_0_1.ShowSchedule(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_2 then
		if not arg_12_4 then
			math = var_1_10005
			var_1_10005 = var_1_10005.random(#arg_12_0.RandomPool)
			arg_12_4 = arg_12_0.RandomPool[var_1_10005]
			table = var_6

			var_6.remove(arg_12_0.RandomPool, var_1_10005)
		end

		if arg_12_3 == 1 then
			table = var_1_10005

			var_1_10005.insert(arg_12_0.showScheduleList, arg_12_4)
		end

		if arg_12_3 == 2 then
			table = var_1_10005

			var_1_10005.insert(arg_12_0.chooseScheduleList, arg_12_4)
		end

		if arg_12_3 == 3 then
			table = var_1_10005

			var_1_10005.insert(arg_12_0.playerChoosedScheduleList, arg_12_4)
		end

		for iter_12_0 = 0, 11 do
			setActive = var_1_10009

			var_1_10009(arg_12_1:GetChild(iter_12_0), iter_12_0 == arg_12_4 - 1)
		end

		setActive = var_1_10005

		var_1_10005(arg_12_1:GetChild(12), false)

		if arg_12_4 == 0 then
			setActive = var_1_10005

			var_1_10005(arg_12_1:GetChild(12), true)
		end
	else
		setActive = var_1_10005

		var_1_10005(arg_12_1:GetChild(12), true)
	end

	return
end

function var_0_1.SetScheduleFrame(arg_13_0, arg_13_1, arg_13_2)
	for iter_13_0 = 13, arg_13_1.childCount - 1 do
		setActive = var_1_10007

		var_1_10007(arg_13_1:GetChild(iter_13_0), arg_13_1:GetChild(iter_13_0).name == arg_13_2)
	end

	return
end

function var_0_1.IsShowing(arg_14_0, arg_14_1)
	isActive = var_1_10002

	return not var_1_10002(arg_14_1:GetChild(12))
end

function var_0_1.readyStart(arg_15_0)
	arg_15_0.scoreNum = 0
	arg_15_0.gameTime = var_0_3
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
	Clone = var_1
	arg_15_0.RandomPool = var_1(var_0_8)
	arg_15_0.round = 1

	local var_15_0 = arg_15_0.count
	local var_15_1 = var_1.GetComponent

	typeof = var_1_10004
	Animator = var_1_10006

	local var_15_2 = var_15_1(var_15_0, var_1_10004(var_1_10006))

	var_1.Play(var_15_2, "count")

	return
end

function var_0_1.gameStart(arg_16_0)
	arg_16_0.gameStartFlag = true
	setActive = var_1

	var_1(arg_16_0.count, false)

	setActive = var_1

	var_1(arg_16_0.gameTop, true)

	setActive = var_1

	var_1(arg_16_0.gamingUI, true)

	setText = var_1

	var_1(arg_16_0.gameUIScore, arg_16_0.scoreNum)
	arg_16_0:timerStart()

	return
end

function var_0_1.timerStart(arg_17_0)
	if not arg_17_0.timer.running then
		Time = var_1
		arg_17_0.realTimeStartUp = var_1.realtimeSinceStartup

		local var_17_0 = arg_17_0.timer

		var_1.Start(var_17_0)
	end

	return
end

function var_0_1.timerStop(arg_18_0)
	if arg_18_0.timer.running then
		local var_18_0 = arg_18_0.timer

		var_1.Stop(var_18_0)
	end

	return
end

function var_0_1.pauseGame(arg_19_0)
	arg_19_0.gameStop = true

	arg_19_0:timerStop()

	return
end

function var_0_1.resumeGame(arg_20_0)
	arg_20_0.gameStop = false

	arg_20_0:timerStart()

	return
end

function var_0_1.onGameOver(arg_21_0)
	arg_21_0:timerStop()

	setActive = var_1

	var_1(arg_21_0.clickMask, true)

	setActive = var_1

	var_1(arg_21_0.gameTop, false)

	LeanTween = var_1

	local var_21_0 = var_1.delayedCall

	go = var_3

	local var_21_1 = var_3(arg_21_0._tf)
	local var_21_2 = 0.1

	System = var_5

	var_21_0(var_21_1, var_21_2, var_5.Action(function()
		local var_22_0 = arg_21_0

		var_22_0.gameStartFlag = false
		setActive = var_22_0

		var_22_0(arg_21_0.clickMask, false)

		local var_22_1 = arg_21_0

		var_0.GameSettlement(var_22_1)

		local var_22_2 = arg_21_0
		local var_22_3 = var_0.emit

		Dorm3dMiniGameMediator = var_3

		var_22_3(var_22_2, var_3.GAME_OPERATION, {
			operationCode = "GAME_RESULT",
			score = arg_21_0.scoreNum,
			miniGameId = var_0_2
		})

		return
	end))

	return
end

function var_0_1.GameSettlement(arg_23_0)
	setActive = var_1_10001

	var_1_10001(arg_23_0.gamingShow, false)

	setActive = var_1_10001

	var_1_10001(arg_23_0.gamingChoose, false)

	setActive = var_1_10001

	var_1_10001(arg_23_0.gamingSettlement, true)

	for iter_23_0 = 0, 20 do
		local var_23_0 = arg_23_0
		local var_23_1 = arg_23_0.ShowSchedule
		local var_23_2 = arg_23_0.gamingSettlement
		local var_23_3 = var_8.Find(var_23_2, "scheduleResultList")
		local var_23_4 = var_8.GetChild(var_23_3, iter_23_0)

		var_23_1(var_23_0, var_8.GetChild(var_23_4, 0), true, 0, arg_23_0.playerChoosedScheduleList[iter_23_0 + 1])
	end

	local var_23_5 = arg_23_0.scoreNum

	math = var_2
	arg_23_0.scoreNum = var_23_5 + 10 * var_2.ceil(arg_23_0.gameTime)
	setText = var_1

	local var_23_6 = arg_23_0.gamingSettlement

	var_1(var_3.Find(var_23_6, "currentScore/Text"), arg_23_0.scoreNum)

	getProxy = var_1
	PlayerProxy = var_3

	local var_23_7 = var_1(var_3)
	local var_23_8 = var_1.getPlayerId(var_23_7)

	PlayerPrefs = var_2

	local var_23_9 = var_2.GetInt
	local var_23_10 = "mg_score_"

	tostring = var_23_6

	local var_23_11

	if not var_23_9(var_23_10 .. var_23_6(var_23_8) .. "_" .. var_0_2) then
		var_23_11 = 0
	end

	setActive = var_23_7

	local var_23_12 = arg_23_0.gamingSettlement

	var_23_7(var_5.Find(var_23_12, "currentScore/new"), var_23_11 < arg_23_0.scoreNum)

	local var_23_13

	if var_23_11 < arg_23_0.scoreNum then
		var_23_11 = arg_23_0.scoreNum
		PlayerPrefs = var_23_13
		var_23_13 = var_23_13.SetInt

		local var_23_14 = "mg_score_"

		tostring = var_6

		var_23_13(var_23_14 .. var_6(var_23_8) .. "_" .. var_0_2, var_23_11)
	end

	setText = var_23_13

	local var_23_15 = arg_23_0.gamingSettlement

	var_23_13(var_5.Find(var_23_15, "highestScore/Text"), var_23_11)

	math = var_23_13

	local var_23_16 = var_23_13.ceil(arg_23_0.gameTime)

	math = var_4

	local var_23_17 = var_4.floor(var_23_16 / 60)
	local var_23_18 = var_23_16 % 60

	setText = var_6

	local var_23_19 = arg_23_0.gamingSettlement
	local var_23_20 = var_8.Find(var_23_19, "remainingTime/Text")

	string = var_1_10009

	local var_23_21 = var_1_10009.format("%02d", var_23_17)
	local var_23_22 = ":"

	string = var_11

	var_6(var_23_20, var_23_21 .. var_23_22 .. var_11.format("%02d", var_23_18))

	setText = var_6

	local var_23_23 = arg_23_0.gamingSettlement

	var_6(var_8.Find(var_23_23, "result/Text"), arg_23_0:GetEvaluation())

	return
end

function var_0_1.GetEvaluation(arg_24_0)
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

	ipairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0.playerChoosedScheduleList) do
		if iter_24_1 ~= 0 then
			var_24_0[iter_24_1] = var_24_0[iter_24_1] + 1
			var_24_1[var_8] = var_24_1[var_0_10[iter_24_1]] + 1
		end
	end

	ipairs = var_3

	for iter_24_2, iter_24_3 in var_3(var_24_0) do
		if iter_24_3 > 16 then
			local var_24_2 = var_0_11[iter_24_2]

			i18n = var_1_10009

			return var_24_2 .. var_1_10009("dorm3d_nengdai_minigame_evaluate2")
		elseif iter_24_3 > 11 then
			local var_24_3 = var_0_11[iter_24_2]

			i18n = var_1_10009

			return var_24_3 .. var_1_10009("dorm3d_nengdai_minigame_evaluate1")
		end
	end

	pairs = var_3

	for iter_24_4, iter_24_5 in var_3(var_24_1) do
		if 20 < iter_24_5 then
			i18n = var_8

			return var_8("dorm3d_nengdai_minigame_evaluate4") .. var_0_12[iter_24_4]
		elseif 11 < iter_24_5 then
			i18n = var_8

			return var_8("dorm3d_nengdai_minigame_evaluate3") .. var_0_12[iter_24_4]
		end
	end

	i18n = var_3

	return var_3("dorm3d_nengdai_minigame_evaluate5")
end

function var_0_1.checkGameExit(arg_25_0)
	if not arg_25_0.gameStartFlag then
		local var_25_0 = arg_25_0
		local var_25_1 = arg_25_0.emit

		Dorm3dMiniGameMediator = var_1_10004

		var_25_1(var_25_0, var_1_10004.GAME_OPERATION, {
			operationCode = "GAME_CLOSE",
			doTrack = true,
			miniGameId = var_0_2
		})
		arg_25_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_25_0.gameStop then
			return
		end

		arg_25_0:pauseGame()

		local var_25_3

		if arg_25_0.contextData.isDorm3d then
			pg = var_25_3

			local var_25_2 = var_25_3.NewStyleMsgboxMgr.GetInstance()

			var_25_3 = var_25_3.Show
			pg = var_1_10004

			local var_25_4 = var_1_10004.NewStyleMsgboxMgr.TYPE_MSGBOX

			var_1_10005 = {}
			i18n = var_1_10006
			var_1_10005.contentText = var_1_10006("mini_game_leave")

			function var_1_10005.onConfirm()
				local var_26_0 = arg_25_0
				local var_26_1 = var_0.emit

				Dorm3dMiniGameMediator = var_2_10003

				var_26_1(var_26_0, var_2_10003.GAME_OPERATION, {
					operationCode = "GAME_CLOSE",
					doTrack = false,
					miniGameId = var_0_2
				})

				local var_26_2 = arg_25_0

				var_0.emit(var_26_2, var_0_1.ON_BACK_PRESSED)

				return
			end

			function var_1_10005.onClose()
				local var_27_0 = arg_25_0

				var_0.resumeGame(var_27_0)

				return
			end

			var_25_3(var_25_2, var_25_4, var_1_10005)
		else
			pg = var_25_3

			local var_25_5 = var_25_3.MsgboxMgr.GetInstance()
			local var_25_6 = var_1.ShowMsgBox
			local var_25_7 = {}

			i18n = var_1_10005
			var_25_7.content = var_1_10005("mini_game_leave")

			function var_25_7.onYes()
				local var_28_0 = arg_25_0
				local var_28_1 = var_0.emit

				Dorm3dMiniGameMediator = var_2_10003

				var_28_1(var_28_0, var_2_10003.GAME_OPERATION, {
					operationCode = "GAME_CLOSE",
					doTrack = false,
					miniGameId = var_0_2
				})

				local var_28_2 = arg_25_0

				var_0.emit(var_28_2, var_0_1.ON_BACK_PRESSED)

				return
			end

			function var_25_7.onNo()
				local var_29_0 = arg_25_0

				var_0.resumeGame(var_29_0)

				return
			end

			var_25_6(var_25_5, var_25_7)
		end
	end

	return
end

function var_0_1.getMiniGameData(arg_30_0)
	if not arg_30_0._mgData then
		getProxy = var_1
		MiniGameProxy = var_1_10003

		local var_30_0 = var_1(var_1_10003)

		arg_30_0._mgData = var_1.GetMiniGameData(var_30_0, var_0_2)
	end

	return arg_30_0._mgData
end

function var_0_1.onBackPressed(arg_31_0)
	arg_31_0:checkGameExit()

	return
end

function var_0_1.willExit(arg_32_0)
	if arg_32_0.timer and arg_32_0.timer.running then
		local var_32_0 = arg_32_0.timer

		var_1.Stop(var_32_0)
	end

	arg_32_0.timer = nil

	return
end

return var_0_1
