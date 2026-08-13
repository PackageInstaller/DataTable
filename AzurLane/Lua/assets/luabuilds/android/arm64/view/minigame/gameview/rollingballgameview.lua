class = var_0_10000

local var_0_0 = "RollingBallGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/boat_drag"
local var_0_4 = "event:/ui/break_out_full"
local var_0_5 = "event:/ui/sx-good"
local var_0_6 = "event:/ui/sx-perfect"
local var_0_7 = "event:/ui/sx-jishu"
local var_0_8 = "event:/ui/furnitrue_save"

function var_0_1.getUIName(arg_1_0)
	return "RollingBallGameUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.GetMGData(var_2_0)
	local var_2_2 = arg_2_0
	local var_2_3 = arg_2_0.GetMGHubData(var_2_2)

	findTF = var_2_0
	arg_2_0.tplScoreTip = var_2_0(arg_2_0._tf, "tplScoreTip")
	findTF = var_3
	arg_2_0.tplRemoveEffect = var_3(arg_2_0._tf, "sanxiaoxiaoshi")
	findTF = var_3
	arg_2_0.effectUI = var_3(arg_2_0._tf, "effectUI")
	findTF = var_3
	arg_2_0.tplEffect = var_3(arg_2_0._tf, "tplEffect")
	findTF = var_3
	arg_2_0.effectPoolTf = var_3(arg_2_0._tf, "effectPool")
	arg_2_0.effectPool = {}
	arg_2_0.effectDatas = {}
	findTF = var_3
	arg_2_0.effectTargetPosition = var_3(arg_2_0.effectUI, "effectTargetPos").localPosition
	findTF = var_3
	arg_2_0.rollingUI = var_3(arg_2_0._tf, "rollingUI")
	findTF = var_3
	arg_2_0.rollingEffectUI = var_3(arg_2_0._tf, "rollingEffectUI")
	findTF = var_3
	arg_2_0.tplGrid = var_3(arg_2_0._tf, "tplRollingGrid")
	findTF = var_3
	arg_2_0.gridPoolTf = var_3(arg_2_0._tf, "gridPool")
	arg_2_0.gridsPool = {}
	arg_2_0.gridDic = {}
	arg_2_0.fillGridDic = {}
	arg_2_0.startFlag = false
	findTF = var_3

	local var_2_4 = var_3(arg_2_0.rollingUI, "dragAlphaGrid")

	RollingBallGrid = var_2_2
	arg_2_0.dragAlphaGrid = var_2_2.New(var_2_4)
	setActive = var_4

	local var_2_5 = arg_2_0.dragAlphaGrid

	var_4(var_6.getTf(var_2_5), false)

	Timer = var_4
	arg_2_0.timer = var_4.New(function()
		local var_3_0 = arg_2_0

		var_0.onTimer(var_3_0)

		return
	end, 0.016666666666666666, -1)

	local var_2_6 = 1

	RollingBallConst = var_5

	for iter_2_0 = var_2_6, var_5.horizontal do
		arg_2_0.gridDic[iter_2_0] = {}
		arg_2_0.fillGridDic[iter_2_0] = {}

		local var_2_7 = 1

		RollingBallConst = var_9

		for iter_2_1 = var_2_7, var_9.vertical do
			table = var_1_10012

			var_1_10012.insert(arg_2_0.gridDic[iter_2_0], false)
		end
	end

	local var_2_8 = arg_2_0._tf

	arg_2_0.goodEffect = var_4.Find(var_2_8, "sanxiaoGood")

	local var_2_9 = arg_2_0._tf

	arg_2_0.greatEffect = var_4.Find(var_2_9, "sanxiaoGreat")

	local var_2_10 = arg_2_0._tf

	arg_2_0.perfectEffect = var_4.Find(var_2_10, "sanxiaoPerfect")
	findTF = var_4
	arg_2_0.caidaiTf = var_4(arg_2_0._tf, "zhuanzhu_caidai")
	setActive = var_4

	var_4(arg_2_0.caidaiTf, false)

	findTF = var_4
	arg_2_0.startUI = var_4(arg_2_0._tf, "startUI")
	onButton = var_4

	local var_2_11 = arg_2_0

	findTF = var_7

	local var_2_12 = var_7(arg_2_0.startUI, "btnStart")

	local function var_2_13()
		if not arg_2_0.startFlag then
			setActive = var_0

			var_0(arg_2_0.startUI, false)

			local var_4_0 = arg_2_0

			var_0.gameStart(var_4_0)
		end

		return
	end

	SFX_CONFIRM = var_9

	var_4(var_2_11, var_2_12, var_2_13, var_9)

	onButton = var_4

	local var_2_14 = arg_2_0

	findTF = var_2_12

	local var_2_15 = var_2_12(arg_2_0.startUI, "btnRule")

	local function var_2_16()
		pg = var_2_10000

		local var_5_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_5_1 = var_0.ShowMsgBox
		local var_5_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_5_2.type = var_2_10004
		pg = var_2_10004
		var_5_2.helps = var_2_10004.gametip.help_rollingBallGame.tip

		var_5_1(var_5_0, var_5_2)

		return
	end

	SFX_CONFIRM = var_9

	var_4(var_2_14, var_2_15, var_2_16, var_9)

	setActive = var_4

	var_4(arg_2_0.startUI, true)

	findTF = var_4
	arg_2_0.scoreUI = var_4(arg_2_0._tf, "scoreUI")
	findTF = var_4
	arg_2_0.labelCurScore = var_4(arg_2_0.scoreUI, "labelCur")
	findTF = var_4
	arg_2_0.labelHigh = var_4(arg_2_0.scoreUI, "labelHigh")
	findTF = var_4
	arg_2_0.scoreNew = var_4(arg_2_0.scoreUI, "new")
	onButton = var_4

	local var_2_17 = arg_2_0

	findTF = var_7

	local var_2_18 = var_7(arg_2_0.scoreUI, "btnEnd")

	local function var_2_19()
		setActive = var_2_10000

		var_2_10000(arg_2_0.scoreUI, false)

		setActive = var_2_10000

		var_2_10000(arg_2_0.startUI, true)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_2_17, var_2_18, var_2_19, var_9)

	setActive = var_4

	var_4(arg_2_0.scoreUI, false)

	findTF = var_4
	arg_2_0.downProgress = var_4(arg_2_0._tf, "downProgress")
	findTF = var_4

	local var_2_20 = var_4(arg_2_0.downProgress, "Slider")
	local var_2_21 = var_4.GetComponent

	typeof = var_7
	Slider = var_9
	arg_2_0.downTimeSlider = var_2_21(var_2_20, var_7(var_9))
	findTF = var_4
	arg_2_0.labelGameTime = var_4(arg_2_0._tf, "labelGameTime")
	findTF = var_4
	arg_2_0.labelGameScore = var_4(arg_2_0._tf, "labelGameScore")
	findTF = var_4
	arg_2_0.endLess = var_4(arg_2_0._tf, "endLess")
	setActive = var_4

	var_4(arg_2_0.endLess, true)

	findTF = var_4
	arg_2_0.closeUI = var_4(arg_2_0._tf, "closeUI")
	setActive = var_4

	var_4(arg_2_0.closeUI, false)

	onButton = var_4

	local var_2_22 = arg_2_0

	findTF = var_7

	local var_2_23 = var_7(arg_2_0.closeUI, "btnOk")

	local function var_2_24()
		if not arg_2_0.countStart then
			local var_7_0 = arg_2_0

			var_0.closeView(var_7_0)
		end

		return
	end

	SFX_CONFIRM = var_9

	var_4(var_2_22, var_2_23, var_2_24, var_9)

	onButton = var_4

	local var_2_25 = arg_2_0

	findTF = var_2_23

	local var_2_26 = var_2_23(arg_2_0.closeUI, "btnCancel")

	local function var_2_27()
		setActive = var_2_10000

		var_2_10000(arg_2_0.closeUI, false)

		return
	end

	SFX_CANCEL = var_9

	var_4(var_2_25, var_2_26, var_2_27, var_9)

	findTF = var_4
	arg_2_0.overLight = var_4(arg_2_0._tf, "overLight")
	setActive = var_4

	var_4(arg_2_0.overLight, false)

	onButton = var_4

	local var_2_28 = arg_2_0

	findTF = var_7

	local var_2_29 = var_7(arg_2_0._tf, "btnClose")

	local function var_2_30()
		if not arg_2_0.startFlag then
			local var_9_0 = arg_2_0

			var_0.closeView(var_9_0)
		else
			setActive = var_0

			var_0(arg_2_0.closeUI, true)
		end

		return
	end

	SFX_CANCEL = var_9

	var_4(var_2_28, var_2_29, var_2_30, var_9)

	return
end

function var_0_1.getGameTimes(arg_10_0)
	return arg_10_0:GetMGHubData().count
end

function var_0_1.showScoreUI(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:GetMGData()

	if var_2.GetRuntimeData(var_11_0, "elements") then
		local var_11_1 = #var_2
		local var_11_2

		if not (0 < var_11_1) or not var_2[1] then
			var_11_2 = 0
		end

		if var_11_2 < arg_11_1 then
			setActive = var_11_0

			var_11_0(arg_11_0.scoreNew, true)
		else
			setActive = var_11_0

			var_11_0(arg_11_0.scoreNew, false)
		end

		var_11_2 = arg_11_1 < var_11_2 and var_11_2 or arg_11_1
		setActive = var_11_0

		var_11_0(arg_11_0.scoreUI, true)

		setText = var_11_0

		var_11_0(arg_11_0.labelCurScore, arg_11_1)

		setText = var_11_0

		var_11_0(arg_11_0.labelHigh, var_11_2)
		arg_11_0:StoreDataToServer({
			var_11_2
		})

		if arg_11_0:getGameTimes() > 0 then
			arg_11_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.showCountStart(arg_12_0, arg_12_1)
	findTF = var_1_10002

	local var_12_0 = var_1_10002(arg_12_0._tf, "count")

	setActive = var_1_10003

	var_1_10003(var_12_0, true)

	arg_12_0.countIndex = 3
	arg_12_0.countStart = true
	pg = var_3

	local var_12_1 = var_3.CriMgr.GetInstance()

	var_3.PlaySoundEffect_V3(var_12_1, var_0_2)

	local function var_12_2(arg_13_0)
		local var_13_0 = arg_12_0.countIndex
		local var_13_1 = arg_12_0

		var_13_1.countIndex = arg_12_0.countIndex - 1
		findTF = var_13_1

		local var_13_2 = var_13_1(var_12_0, "show")

		GetComponent = var_3

		local var_13_3 = var_13_2

		typeof = var_2_10006
		CanvasGroup = var_2_10008

		local var_13_4 = var_3(var_13_3, var_2_10006(var_2_10008))

		seriesAsync = var_4

		var_4({
			function(arg_14_0)
				GetSpriteFromAtlasAsync = var_3_10001
				RollingBallConst = var_3_10003

				var_3_10001(var_3_10003.ui_atlas, "count_" .. var_13_0, function(arg_15_0)
					setImageSprite = var_4_10001

					var_4_10001(var_13_2, arg_15_0, true)

					return
				end)

				LeanTween = var_3_10001

				local var_14_0 = var_3_10001.value

				go = var_3

				local var_14_1 = var_14_0(var_3(var_13_2), 0, 1, 0.5)
				local var_14_2 = var_1.setOnUpdate

				System = var_4

				local var_14_3 = var_14_2(var_14_1, var_4.Action_float(function(arg_16_0)
					var_13_4.alpha = arg_16_0

					return
				end))
				local var_14_4 = var_1.setOnComplete

				System = var_4

				var_14_4(var_14_3, var_4.Action(function()
					arg_14_0()

					return
				end))

				return
			end,
			function(arg_18_0)
				LeanTween = var_3_10001

				local var_18_0 = var_3_10001.value

				go = var_3_10003

				local var_18_1 = var_18_0(var_3_10003(var_13_2), 1, 0, 0.5)
				local var_18_2 = var_1.setOnUpdate

				System = var_4

				local var_18_3 = var_18_2(var_18_1, var_4.Action_float(function(arg_19_0)
					var_13_4.alpha = arg_19_0

					return
				end))
				local var_18_4 = var_1.setOnComplete

				System = var_4

				var_18_4(var_18_3, var_4.Action(function()
					arg_18_0()

					return
				end))

				return
			end
		}, arg_13_0)

		return
	end

	local var_12_3 = {}

	for iter_12_0 = 1, 3 do
		table = var_1_10009

		var_1_10009.insert(var_12_3, var_12_2)
	end

	seriesAsync = var_5

	var_5(var_12_3, function()
		local var_21_0 = arg_12_0

		var_21_0.countStart = false
		setActive = var_21_0

		var_21_0(var_12_0, false)
		arg_12_1()

		return
	end)

	return
end

function var_0_1.gameStart(arg_22_0)
	arg_22_0.startFlag = true
	seriesAsync = var_1

	var_1({
		function(arg_23_0)
			local var_23_0 = arg_22_0

			var_1.showCountStart(var_23_0, arg_23_0)

			return
		end,
		function(arg_24_0)
			arg_22_0.moveDatas = {}
			arg_22_0.selectGrid = nil
			arg_22_0.selectEnterGrid = nil

			local var_24_0 = arg_22_0

			Vector3 = var_2
			var_24_0.dragOffsetPos = var_2(0, 0, 0)
			arg_22_0.changeGridsDic = nil

			local var_24_1 = arg_22_0

			RollingBallConst = var_2
			var_24_1.downTime = var_2.downTime
			arg_22_0.comboAmount = 0
			arg_22_0.stopFlag = false
			arg_22_0.onBeginDragTime = nil

			local var_24_2 = arg_22_0
			local var_24_3 = var_1.getGameTimes(var_24_2)

			if 0 < var_24_3 then
				local var_24_4 = arg_22_0

				RollingBallConst = var_2
				var_24_4.gameTime = var_2.gameTime
			else
				local var_24_5 = arg_22_0

				RollingBallConst = var_2
				var_24_5.gameTime = var_2.finishGameTime
			end

			local var_24_6 = arg_22_0

			Time = var_2
			var_24_6.gameTimeReal = var_2.realtimeSinceStartup

			local var_24_7 = arg_22_0

			var_24_7.gameTimeFlag = true
			setActive = var_24_7

			var_24_7(arg_22_0.endLess, false)

			arg_22_0.gameScore = 0

			local var_24_8 = arg_22_0

			var_1.firstInitGrid(var_24_8)

			local var_24_9 = arg_22_0

			var_1.moveGridsBySelfPos(var_24_9, arg_22_0.gridDic)

			local var_24_10 = arg_22_0

			var_1.timerStart(var_24_10)

			return
		end
	}, nil)

	return
end

function var_0_1.gameStop(arg_25_0)
	arg_25_0:timerStop()

	pg = var_1

	local var_25_0 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_25_0, var_0_8)

	for iter_25_0 = #arg_25_0.effectDatas, 1, -1 do
		arg_25_0:returnEffect(arg_25_0.effectDatas[iter_25_0].tf)

		table = var_5

		var_5.remove(arg_25_0.effectDatas, iter_25_0)
	end

	local var_25_1 = 1

	RollingBallConst = var_2

	for iter_25_1 = var_25_1, var_2.horizontal do
		local var_25_2 = 1

		RollingBallConst = var_1_10006

		for iter_25_2 = var_25_2, var_1_10006.vertical do
			if arg_25_0.gridDic[iter_25_1][iter_25_2] then
				local var_25_3 = arg_25_0.gridDic[iter_25_1][iter_25_2]

				var_9.setEventActive(var_25_3, false)
			end
		end
	end

	arg_25_0:clearUI()
	arg_25_0:showScoreUI(arg_25_0.gameScore)

	return
end

function var_0_1.timerStart(arg_26_0)
	if not arg_26_0.timer.running then
		local var_26_0 = arg_26_0.timer

		var_1.Start(var_26_0)
	end

	return
end

function var_0_1.timerStop(arg_27_0)
	if arg_27_0.timer.running then
		local var_27_0 = arg_27_0.timer

		var_1.Stop(var_27_0)
	end

	return
end

function var_0_1.fallingGridDic(arg_28_0)
	local function var_28_0(arg_29_0, arg_29_1)
		local var_29_0 = arg_29_1 + 1

		RollingBallConst = var_2_10003

		for iter_29_0 = var_29_0, var_2_10003.vertical do
			if arg_28_0.gridDic[arg_29_0][iter_29_0] then
				return iter_29_0
			end
		end

		return 0
	end

	local var_28_1 = 1

	RollingBallConst = var_1_10003

	for iter_28_0 = var_28_1, var_1_10003.horizontal do
		local var_28_2 = 1

		RollingBallConst = var_1_10007

		for iter_28_1 = var_28_2, var_1_10007.vertical do
			if not arg_28_0.gridDic[iter_28_0][iter_28_1] then
				RollingBallConst = var_10

				if var_10.vertical - iter_28_1 > 0 and var_28_0(iter_28_0, iter_28_1) > 0 then
					local var_28_3 = arg_28_0.gridDic[iter_28_0][var_11]

					arg_28_0.gridDic[iter_28_0][var_11] = false
					arg_28_0.gridDic[iter_28_0][iter_28_1] = var_28_3

					local var_28_4 = arg_28_0.gridDic[iter_28_0][iter_28_1]

					var_13.setPosData(var_28_4, iter_28_0, iter_28_1)
				end
			end
		end
	end

	return
end

function var_0_1.firstInitGrid(arg_30_0)
	local var_30_0 = 1

	RollingBallConst = var_1_10002

	for iter_30_0 = var_30_0, var_1_10002.horizontal do
		arg_30_0.fillGridDic[iter_30_0] = {}

		local var_30_1 = 1

		RollingBallConst = var_6

		for iter_30_1 = var_30_1, var_6.vertical do
			if not arg_30_0.gridDic[iter_30_0][iter_30_1] then
				local var_30_2 = {}

				if iter_30_0 > 2 then
					local var_30_3 = arg_30_0.gridDic[iter_30_0 - 2][iter_30_1]
					local var_30_4 = var_10.getType(var_30_3)
					local var_30_5 = arg_30_0.gridDic[iter_30_0 - 1][iter_30_1]

					if var_30_4 == var_11.getType(var_30_5) then
						table = var_30_4

						local var_30_6 = var_30_4.insert
						local var_30_7 = var_30_2
						local var_30_8 = arg_30_0.gridDic[iter_30_0 - 2][iter_30_1]

						var_30_6(var_30_7, var_13.getType(var_30_8))
					end
				end

				if iter_30_1 > 2 then
					local var_30_9 = arg_30_0.gridDic[iter_30_0][iter_30_1 - 2]
					local var_30_10 = var_10.getType(var_30_9)
					local var_30_11 = arg_30_0.gridDic[iter_30_0][iter_30_1 - 1]

					if var_30_10 == var_11.getType(var_30_11) then
						table = var_30_10

						local var_30_12 = var_30_10.insert
						local var_30_13 = var_30_2
						local var_30_14 = arg_30_0.gridDic[iter_30_0][iter_30_1 - 2]

						var_30_12(var_30_13, var_13.getType(var_30_14))
					end
				end

				local var_30_15 = arg_30_0:createGrid(arg_30_0:getRandomType(var_30_2), iter_30_0, iter_30_1)

				arg_30_0.gridDic[iter_30_0][iter_30_1] = var_30_15

				arg_30_0:setFillGridPosition(var_30_15, iter_30_0, #arg_30_0.fillGridDic[iter_30_0])

				table = var_11

				var_11.insert(arg_30_0.fillGridDic[iter_30_0], var_30_15)
			end
		end
	end

	return
end

function var_0_1.fillEmptyGrid(arg_31_0)
	local var_31_0 = 1

	RollingBallConst = var_1_10002

	for iter_31_0 = var_31_0, var_1_10002.horizontal do
		arg_31_0.fillGridDic[iter_31_0] = {}

		local var_31_1 = 1

		RollingBallConst = var_6

		for iter_31_1 = var_31_1, var_6.vertical do
			if not arg_31_0.gridDic[iter_31_0][iter_31_1] then
				local var_31_2 = arg_31_0:createGrid(arg_31_0:getRandomType(), iter_31_0, iter_31_1)

				arg_31_0.gridDic[iter_31_0][iter_31_1] = var_31_2

				arg_31_0:setFillGridPosition(var_31_2, iter_31_0, #arg_31_0.fillGridDic[iter_31_0])

				table = var_10

				var_10.insert(arg_31_0.fillGridDic[iter_31_0], var_31_2)
			end
		end
	end

	return
end

function var_0_1.setFillGridPosition(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	local var_32_0 = arg_32_2 - 1

	RollingBallConst = var_1_10005

	local var_32_1 = var_32_0 * var_1_10005.grid_width

	RollingBallConst = var_5

	local var_32_2 = var_5.vertical + arg_32_3

	RollingBallConst = var_1_10006

	local var_32_3 = var_32_2 * var_1_10006.grid_height

	arg_32_1:setPosition(var_32_1, var_32_3)

	return
end

function var_0_1.onTimer(arg_33_0)
	for iter_33_0 = #arg_33_0.moveDatas, 1, -1 do
		local var_33_0 = arg_33_0.moveDatas[iter_33_0].grid
		local var_33_1 = var_6.getPosition(var_33_0).x
		local var_33_2 = var_6:getPosition().y
		local var_33_3 = var_1_10005.endX
		local var_33_4 = var_1_10005.endY

		if var_33_1 == var_33_3 and var_33_2 == var_33_4 then
			var_1_10013 = var_6

			var_6.setEventActive(var_1_10013, true)

			table = var_11

			var_11.remove(arg_33_0.moveDatas, iter_33_0)
		else
			local var_33_5
			local var_33_6

			math = var_1_10013
			var_1_10013 = var_1_10013.abs(var_33_3 - var_33_1)
			RollingBallConst = var_1_10014

			if var_1_10013 < var_1_10014.moveSpeed or var_33_3 == var_33_1 then
				var_33_5 = var_33_3 - var_33_1
			elseif var_33_1 < var_33_3 then
				RollingBallConst = var_1_10013
				var_33_5 = var_1_10013.moveSpeed
			elseif var_33_3 < var_33_1 then
				RollingBallConst = var_1_10013
				var_33_5 = -var_1_10013.moveSpeed
			end

			math = var_1_10013
			var_1_10013 = var_1_10013.abs(var_33_4 - var_33_2)
			RollingBallConst = var_1_10014

			if var_1_10013 < var_1_10014.moveSpeed or var_33_2 == var_33_4 then
				var_33_6 = 0
				var_33_2 = var_33_4
			elseif var_33_2 < var_33_4 then
				RollingBallConst = var_1_10013
				var_33_6 = var_1_10013.moveSpeed
			elseif var_33_4 < var_33_2 then
				RollingBallConst = var_1_10013
				var_33_6 = -var_1_10013.moveSpeed
			end

			var_6:setPosition(var_33_1 + var_33_5, var_33_2 + var_33_6)
		end
	end

	for iter_33_1 = #arg_33_0.effectDatas, 1, -1 do
		local var_33_7 = arg_33_0.effectDatas[iter_33_1].tf.localPosition

		var_1_10005.ax = (arg_33_0.effectTargetPosition.x - var_33_7.x) * 0.002
		var_1_10005.ay = (arg_33_0.effectTargetPosition.y - var_33_7.y) * 0.002
		var_1_10005.vx = var_1_10005.vx + var_1_10005.ax
		var_1_10005.vy = var_1_10005.vy + var_1_10005.ay
		var_33_7.x = var_33_7.x + var_1_10005.vx
		var_33_7.y = var_33_7.y + var_1_10005.vy
		var_1_10005.tf.localPosition = var_33_7

		if var_33_7.x < arg_33_0.effectTargetPosition.x then
			arg_33_0:returnEffect(var_1_10005.tf)

			table = var_7

			var_7.remove(arg_33_0.effectDatas, iter_33_1)
		end
	end

	if arg_33_0.onBeginDragTime and arg_33_0.downTime > 0 then
		Time = var_1

		local var_33_8 = (var_1.realtimeSinceStartup - arg_33_0.onBeginDragTime) * 1000

		arg_33_0.downTime = arg_33_0.downTime - var_33_8
		Time = var_2
		arg_33_0.onBeginDragTime = var_2.realtimeSinceStartup

		if arg_33_0.downTime <= 0 then
			arg_33_0.downTime = 0

			if arg_33_0.selectGrid then
				var_1_10005 = arg_33_0.selectGrid

				var_2.onEndDrag(var_1_10005)

				var_1_10005 = arg_33_0

				arg_33_0.onGridUp(var_1_10005, var_2)

				var_1_10005 = var_2

				var_2.addUpCallback(var_1_10005, function(arg_34_0, arg_34_1)
					local var_34_0 = arg_33_0

					var_2.onGridUp(var_34_0, var_0)

					return
				end)

				var_1_10005 = var_2

				var_2.addDragCallback(var_1_10005, function(arg_35_0, arg_35_1)
					local var_35_0 = arg_33_0

					var_2.onGridDrag(var_35_0, var_0, arg_35_0, arg_35_1)

					return
				end)
			end
		end
	end

	local var_33_9 = arg_33_0.downTimeSlider
	local var_33_10 = arg_33_0.downTime

	RollingBallConst = var_3
	var_33_9.value = var_33_10 / var_3.downTime

	local var_33_11

	if arg_33_0.gameTimeFlag and arg_33_0.gameTime > 0 then
		isActive = var_33_11

		if not var_33_11(arg_33_0.closeUI) then
			Time = var_33_11
			var_33_11 = (var_33_11.realtimeSinceStartup - arg_33_0.gameTimeReal) * 1000
			arg_33_0.gameTime = arg_33_0.gameTime - var_33_11

			if arg_33_0.gameTime > 0 and arg_33_0.gameTime <= 8000 then
				isActive = var_2

				if not var_2(arg_33_0.overLight) then
					setActive = var_2

					var_2(arg_33_0.overLight, true)
				end
			end

			if arg_33_0.gameTime <= 0 then
				arg_33_0.gameTime = 0
				setActive = var_2

				var_2(arg_33_0.overLight, false)

				arg_33_0.stopFlag = true
			end
		end
	end

	Time = var_33_11
	arg_33_0.gameTimeReal = var_33_11.realtimeSinceStartup
	math = var_1

	local var_33_12 = var_1.floor(arg_33_0.gameTime / 60000) < 10 and "0" .. var_33_12 or var_33_12

	math = var_2

	local var_33_13 = var_2.floor(arg_33_0.gameTime % 60000 / 1000) < 10 and "0" .. var_33_13 or var_33_13

	math = var_3

	local var_33_14 = var_3.floor

	math = var_1_10005

	local var_33_15 = var_33_14(var_1_10005.floor(arg_33_0.gameTime % 1000) / 10) < 10 and "0" .. var_33_15 or var_33_15

	setText = var_4

	var_4(arg_33_0.labelGameTime, var_33_12 .. ":" .. var_33_13 .. ":" .. var_33_15)

	if #arg_33_0.moveDatas == 0 then
		if arg_33_0.stopFlag then
			arg_33_0:gameStop()

			return
		end

		if arg_33_0.checkSuccesFlag then
			arg_33_0.checkSuccesFlag = false

			arg_33_0:checkSuccessGrid()
		end

		if arg_33_0.isMoveing then
			arg_33_0.isMoveing = false
		end
	elseif not arg_33_0.isMoveing then
		arg_33_0.isMoveing = true
	end

	return
end

function var_0_1.moveGridsByChangeDic(arg_36_0)
	arg_36_0.moveDatas = {}

	for iter_36_0 = 1, #arg_36_0.changeGridsDic do
		local var_36_0 = arg_36_0.changeGridsDic[iter_36_0]

		for iter_36_1 = 1, #var_36_0 do
			if var_36_0[iter_36_1].grid ~= arg_36_0.selectGrid then
				arg_36_0:moveGridToPos(var_10.grid, var_10.posX, var_10.posY)
			end
		end
	end

	if #arg_36_0.moveDatas > 0 then
		arg_36_0:timerStart()
	end

	return
end

function var_0_1.moveGridsBySelfPos(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0.moveDatas = {}

	for iter_37_0 = 1, #arg_37_1 do
		for iter_37_1 = 1, #arg_37_1[iter_37_0] do
			if arg_37_1[iter_37_0][iter_37_1] and var_11 ~= arg_37_2 then
				arg_37_0:moveGridToPos(var_11, var_11:getPosData())
			end
		end
	end

	if #arg_37_0.moveDatas > 0 then
		arg_37_0:timerStart()
	end

	return
end

function var_0_1.moveGridToPos(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_1:getPosition().x
	local var_38_1 = arg_38_1
	local var_38_2 = arg_38_1.getPosition(var_38_1).y
	local var_38_3 = arg_38_2 - 1

	RollingBallConst = var_38_1

	local var_38_4 = var_38_3 * var_38_1.grid_width
	local var_38_5 = arg_38_3 - 1

	RollingBallConst = var_1_10008

	local var_38_6 = var_38_5 * var_1_10008.grid_height

	math = var_8

	local var_38_7 = var_8.floor(var_38_4)

	math = var_1_10009

	if var_38_7 == var_1_10009.floor(arg_38_2) then
		math = var_38_7

		local var_38_8 = var_38_7.floor(var_38_6)

		math = var_9

		if var_38_8 == var_9.floor(arg_38_3) then
			return
		end
	end

	arg_38_1:setEventActive(false)

	local var_38_9 = {
		grid = arg_38_1,
		endX = var_38_4,
		endY = var_38_6
	}

	table = var_9

	var_9.insert(arg_38_0.moveDatas, var_38_9)

	return
end

function var_0_1.updateMoveGridDic(arg_39_0)
	for iter_39_0 = 1, #arg_39_0.changeGridsDic do
		local var_39_0 = arg_39_0.changeGridsDic[iter_39_0]

		for iter_39_1 = 1, #var_39_0 do
			if var_39_0[iter_39_1].grid then
				local var_39_1 = var_10.grid

				var_11.setPosData(var_39_1, var_10.posX, var_10.posY)
			end
		end
	end

	arg_39_0:sortGridDic()

	return
end

function var_0_1.sortGridDic(arg_40_0)
	local var_40_0 = {}

	local function var_40_1(arg_41_0, arg_41_1)
		for iter_41_0 = 1, #var_40_0 do
			local var_41_0 = var_40_0[iter_41_0]
			local var_41_1, var_41_2 = var_6.getPosData(var_41_0)

			if var_41_1 == arg_41_0 and var_41_2 == arg_41_1 then
				table = var_41_0

				return var_41_0.remove(var_40_0, iter_41_0)
			end
		end

		return nil
	end

	for iter_40_0 = 1, #arg_40_0.gridDic do
		for iter_40_1 = 1, #arg_40_0.gridDic[iter_40_0] do
			local var_40_2 = arg_40_0.gridDic[iter_40_0][iter_40_1]

			var_1_10012 = nil

			if var_40_2 ~= iter_40_0 or var_1_10012 ~= iter_40_1 then
				table = var_1_10013

				var_1_10013.insert(var_40_0, arg_40_0.gridDic[iter_40_0][iter_40_1])

				var_1_10013 = arg_40_0.gridDic[iter_40_0]
				var_1_10013[iter_40_1] = false
			end
		end
	end

	for iter_40_2 = 1, #arg_40_0.gridDic do
		for iter_40_3 = 1, #arg_40_0.gridDic[iter_40_2] do
			if arg_40_0.gridDic[iter_40_2][iter_40_3] == false then
				local var_40_3 = var_40_1(iter_40_2, iter_40_3)

				assert = var_1_10012

				var_1_10012(var_40_3 ~= nil, "异常，位置x:" .. iter_40_2 .. "y:" .. iter_40_3 .. "处珠子不存在，考虑是否在交换位置时设置了错误的格子数据")

				var_1_10012 = arg_40_0.gridDic[iter_40_2]
				var_1_10012[iter_40_3] = var_40_3
			end
		end
	end

	return
end

function var_0_1.checkSuccessGrid(arg_42_0)
	local var_42_0

	arg_42_0:updateRemoveFlag()

	arg_42_0.gameTimeFlag = false

	local var_42_1 = {}

	seriesAsync = var_1_10003

	var_1_10003({
		function(arg_43_0)
			local var_43_0 = 1

			RollingBallConst = var_2_10002

			for iter_43_0 = var_43_0, var_2_10002.horizontal do
				local var_43_1 = 1

				RollingBallConst = var_2_10006

				for iter_43_1 = var_43_1, var_2_10006.vertical do
					local var_43_2 = arg_42_0.gridDic[iter_43_0][iter_43_1]

					var_9.setEventActive(var_43_2, false)

					if var_9:getRemoveFlagV() or var_9:getRemoveFlagH() then
						local var_43_3 = var_9:getRemoveId()
						local var_43_4, var_43_5 = var_9:getPosData()

						if not var_42_1[var_43_3] then
							var_42_1[var_43_3] = {
								amount = 0,
								posList = {}
							}
						end

						local var_43_6 = var_42_1[var_43_3]

						var_43_6.amount = var_42_1[var_43_3].amount + 1
						table = var_43_6

						var_43_6.insert(var_42_1[var_43_3].posList, {
							x = var_43_4,
							y = var_43_5
						})

						local var_43_7 = arg_42_0

						var_13.returnGrid(var_43_7, var_9)

						arg_42_0.gridDic[iter_43_0][iter_43_1] = false

						if not var_42_0 then
							var_42_0 = true
						end
					end
				end
			end

			arg_43_0()

			return
		end,
		function(arg_44_0)
			if var_42_0 then
				LeanTween = var_1

				local var_44_0 = var_1.delayedCall

				go = var_2_10003

				local var_44_1 = var_2_10003(arg_42_0.rollingUI)
				local var_44_2 = 0.7

				System = var_5

				var_44_0(var_44_1, var_44_2, var_5.Action(function()
					arg_44_0()

					return
				end))

				local var_44_3 = arg_42_0

				var_1.updateScore(var_44_3, var_42_1)

				local var_44_4 = arg_42_0

				var_1.updateCombo(var_44_4)

				pg = var_1

				local var_44_5 = var_1.CriMgr.GetInstance()

				var_1.PlaySoundEffect_V3(var_44_5, var_0_4)
			else
				arg_42_0.comboAmount = 0

				arg_44_0()
			end

			return
		end,
		function(arg_46_0)
			if not arg_42_0.stopFlag then
				local var_46_0 = arg_42_0

				var_1.fallingGridDic(var_46_0)

				local var_46_1 = arg_42_0

				var_1.fillEmptyGrid(var_46_1)

				local var_46_2 = arg_42_0

				var_1.moveGridsBySelfPos(var_46_2, arg_42_0.gridDic, nil)

				if var_42_0 then
					arg_42_0.checkSuccesFlag = true
				end
			end

			arg_46_0()

			return
		end
	}, function()
		arg_42_0.gameTimeFlag = true

		return
	end)

	return
end

function var_0_1.updateCombo(arg_48_0)
	setActive = var_1_10001

	var_1_10001(arg_48_0.goodEffect, false)

	setActive = var_1_10001

	var_1_10001(arg_48_0.greatEffect, false)

	setActive = var_1_10001

	var_1_10001(arg_48_0.perfectEffect, false)

	local var_48_0

	if arg_48_0.comboAmount == 2 then
		setActive = var_1

		var_1(arg_48_0.goodEffect, true)

		pg = var_1
		var_48_0 = var_1.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_48_0, var_0_5)
	elseif arg_48_0.comboAmount == 3 then
		setActive = var_1

		var_1(arg_48_0.greatEffect, true)

		pg = var_1
		var_48_0 = var_1.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_48_0, var_0_5)
	elseif arg_48_0.comboAmount >= 4 then
		setActive = var_1

		var_1(arg_48_0.perfectEffect, true)

		pg = var_1
		var_48_0 = var_1.CriMgr.GetInstance()

		var_1.PlaySoundEffect_V3(var_48_0, var_0_6)
	end

	if arg_48_0.comboAmount > 1 then
		LeanTween = var_1

		local var_48_1 = var_1.isTweening

		go = var_48_0

		local var_48_2

		if var_48_1(var_48_0(arg_48_0.caidaiTf)) then
			LeanTween = var_48_2
			var_48_2 = var_48_2.cancel
			go = var_3

			var_48_2(var_3(arg_48_0.caidaiTf))
		end

		LeanTween = var_48_2

		local var_48_3 = var_48_2.delayedCall

		go = var_3

		local var_48_4 = var_3(arg_48_0.caidaiTf)
		local var_48_5 = 3

		System = var_5

		var_48_3(var_48_4, var_48_5, var_5.Action(function()
			setActive = var_2_10000

			var_2_10000(arg_48_0.caidaiTf, false)

			return
		end))

		setActive = var_48_3

		var_48_3(arg_48_0.caidaiTf, true)
	end

	return
end

function var_0_1.updateScore(arg_50_0, arg_50_1)
	pairs = var_1_10002

	for iter_50_0, iter_50_1 in var_1_10002(arg_50_1) do
		arg_50_0.comboAmount = arg_50_0.comboAmount + 1
	end

	local var_50_0 = 10 * arg_50_0.comboAmount
	local var_50_1 = 0

	pairs = var_4

	for iter_50_2, iter_50_3 in var_4(arg_50_1) do
		local var_50_2

		var_50_1 = var_50_1 + var_50_0 * (iter_50_3.amount == 3 and 1 or iter_50_3.amount == 4 and 1.5 or 2) * iter_50_3.amount

		local var_50_3 = var_50_0 * var_9

		for iter_50_4 = 1, #iter_50_3.posList do
			arg_50_0:addGridScoreTip(iter_50_3.posList[iter_50_4], var_50_3)
			arg_50_0:addRemoveEffect(iter_50_3.posList[iter_50_4])
		end
	end

	LeanTween = var_4

	local var_50_4 = var_4.delayedCall

	go = var_6

	local var_50_5 = var_6(arg_50_0.labelGameScore)
	local var_50_6 = 0.7

	System = var_8

	var_50_4(var_50_5, var_50_6, var_8.Action(function()
		LeanTween = var_2_10000

		local var_51_0 = var_2_10000.isTweening

		go = var_2_10002

		if var_51_0(var_2_10002(arg_50_0.labelGameScore)) then
			LeanTween = var_0

			local var_51_1 = var_0.cancel

			go = var_2

			var_51_1(var_2(arg_50_0.labelGameScore))
		end

		local var_51_2 = arg_50_0.gameScore
		local var_51_3 = arg_50_0.gameScore + var_50_1

		LeanTween = var_2

		local var_51_4 = var_2.value

		go = var_4

		local var_51_5 = var_51_4(var_4(arg_50_0.labelGameScore), var_51_2, var_51_3, 1.7)
		local var_51_6 = var_2.setOnUpdate

		System = var_5

		local var_51_7 = var_51_6(var_51_5, var_5.Action_float(function(arg_52_0)
			setText = var_3_10001

			local var_52_0 = arg_50_0.labelGameScore

			math = var_3_10004

			var_3_10001(var_52_0, var_3_10004.floor(arg_52_0))

			return
		end))
		local var_51_8 = var_2.setOnComplete

		System = var_5

		var_51_8(var_51_7, var_5.Action(function()
			setText = var_3_10000

			var_3_10000(arg_50_0.labelGameScore, var_51_3)

			return
		end))

		local var_51_9 = arg_50_0

		var_51_9.gameScore = var_51_3
		pg = var_51_9

		local var_51_10 = var_51_9.CriMgr.GetInstance()

		var_2.PlaySoundEffect_V3(var_51_10, var_0_7)

		return
	end))

	return
end

function var_0_1.updateRemoveFlag(arg_54_0)
	local var_54_0 = 1

	RollingBallConst = var_1_10002

	for iter_54_0 = var_54_0, var_1_10002.horizontal do
		local var_54_1 = 1

		RollingBallConst = var_1_10006

		for iter_54_1 = var_54_1, var_1_10006.vertical do
			local var_54_2 = arg_54_0.gridDic[iter_54_0][iter_54_1]

			arg_54_0:checkGridRemove(var_54_2, iter_54_0, iter_54_1)
		end
	end

	return
end

function var_0_1.checkGridRemove(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	if not arg_55_1:getRemoveFlagH() then
		RollingBallConst = var_4

		if arg_55_2 < var_4.horizontal - 1 then
			local var_55_0 = 0
			local var_55_1 = true
			local var_55_2
			local var_55_3 = {}
			local var_55_4 = arg_55_2

			RollingBallConst = var_1_10009

			for iter_55_0 = var_55_4, var_1_10009.horizontal do
				local var_55_5 = arg_55_1:getType()
				local var_55_6 = arg_55_0.gridDic[iter_55_0][arg_55_3]

				if var_55_5 == var_13.getType(var_55_6) and var_55_1 then
					var_55_0 = var_55_0 + 1
					table = var_55_5

					var_55_5.insert(var_55_3, arg_55_0.gridDic[iter_55_0][arg_55_3])

					local var_55_7 = arg_55_0.gridDic[iter_55_0][arg_55_3]

					if var_12.getRemoveId(var_55_7) then
						local var_55_8 = arg_55_0.gridDic[iter_55_0][arg_55_3]

						var_55_2 = var_12.getRemoveId(var_55_8)
					end
				else
					var_55_1 = false
				end
			end

			if var_55_0 and var_55_0 >= 3 then
				var_55_2 = var_55_2 or arg_55_0:getGridRemoveId()

				for iter_55_1 = 1, #var_55_3 do
					local var_55_9 = var_55_3[iter_55_1]

					var_12.setRemoveFlagH(var_55_9, true, var_55_2)
				end
			end
		end
	end

	if not arg_55_1:getRemoveFlagV() then
		RollingBallConst = var_4

		if arg_55_3 < var_4.vertical - 1 then
			local var_55_10 = 0
			local var_55_11 = true
			local var_55_12
			local var_55_13 = {}
			local var_55_14 = arg_55_3

			RollingBallConst = var_1_10009

			for iter_55_2 = var_55_14, var_1_10009.vertical do
				local var_55_15 = arg_55_1:getType()
				local var_55_16 = arg_55_0.gridDic[arg_55_2][iter_55_2]

				if var_55_15 == var_13.getType(var_55_16) and var_55_11 then
					var_55_10 = var_55_10 + 1
					table = var_55_15

					var_55_15.insert(var_55_13, arg_55_0.gridDic[arg_55_2][iter_55_2])

					local var_55_17 = arg_55_0.gridDic[arg_55_2][iter_55_2]

					if var_12.getRemoveId(var_55_17) then
						local var_55_18 = arg_55_0.gridDic[arg_55_2][iter_55_2]

						var_55_12 = var_12.getRemoveId(var_55_18)
					end
				else
					var_55_11 = false
				end
			end

			if var_55_10 and var_55_10 >= 3 then
				var_55_12 = var_55_12 or arg_55_0:getGridRemoveId()

				for iter_55_3 = 1, #var_55_13 do
					local var_55_19 = var_55_13[iter_55_3]

					var_12.setRemoveFlagV(var_55_19, true, var_55_12)
				end
			end
		end
	end

	return
end

function var_0_1.onGridDown(arg_56_0, arg_56_1)
	if arg_56_0.isMoveing or arg_56_0.selectGrid or #arg_56_0.moveDatas > 0 then
		return
	end

	pg = var_2

	local var_56_0 = var_2.CriMgr.GetInstance()

	var_2.PlaySoundEffect_V3(var_56_0, var_0_3)

	arg_56_0.selectGrid = arg_56_1

	local var_56_1 = arg_56_0.selectGrid
	local var_56_2 = var_2.getTf(var_56_1)

	var_2.SetAsLastSibling(var_56_2)

	return
end

function var_0_1.onGridUp(arg_57_0, arg_57_1)
	arg_57_0.selectGrid = nil

	if arg_57_0.changeGridsDic then
		arg_57_0:updateMoveGridDic()

		arg_57_0.changeGridsDic = nil
	end

	arg_57_0:clearDragAlpha()

	arg_57_0.onBeginDragTime = nil

	arg_57_0:moveGridsBySelfPos(arg_57_0.gridDic, nil)

	arg_57_0.checkSuccesFlag = true
	RollingBallConst = var_2
	arg_57_0.downTime = var_2.downTime

	return
end

function var_0_1.checkChangePos(arg_58_0, arg_58_1)
	local var_58_0, var_58_1 = arg_58_1:getPosData()
	local var_58_2 = arg_58_0.selectGrid
	local var_58_3, var_58_4 = var_4.getPosData(var_58_2)

	if arg_58_1 == arg_58_0.selectGrid or var_58_3 ~= var_58_0 and var_58_4 ~= var_58_1 then
		arg_58_0:moveGridsBySelfPos(arg_58_0.gridDic, arg_58_0.selectGrid)

		arg_58_0.selectEnterGrid = nil
		arg_58_0.changeGridsDic = nil
		arg_58_0.changePosX, arg_58_0.changePosY = nil
	else
		if arg_58_0.changePosX == var_58_0 and arg_58_0.changePosY == var_58_1 then
			return
		end

		arg_58_0.changePosX, arg_58_0.changePosY = var_58_0, var_58_1

		arg_58_0:updateEnterGrid(arg_58_0.changePosX, arg_58_0.changePosY)
		arg_58_0:moveGridsByChangeDic()
	end

	return
end

function var_0_1.onGridBeginDrag(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	if arg_59_0.isMoveing or not arg_59_0.selectGrid or arg_59_1 ~= arg_59_0.selectGrid then
		return
	end

	Time = var_4
	arg_59_0.onBeginDragTime = var_4.realtimeSinceStartup
	RollingBallConst = var_4
	arg_59_0.downTime = var_4.downTime

	local var_59_0 = arg_59_0.selectGrid
	local var_59_1 = var_4.getTf(var_59_0)
	local var_59_2 = arg_59_0.selectGrid
	local var_59_3, var_59_4 = var_5.getPosData(var_59_2)
	local var_59_5 = arg_59_0.selectGrid
	local var_59_6 = var_7.getType(var_59_5)

	arg_59_0:setDragAlpha(var_59_3, var_59_4, var_59_6)

	arg_59_0.changePosX, arg_59_0.changePosY = nil
	arg_59_0.dragOffsetPos.x = arg_59_3.position.x - var_59_1.transform.localPosition.x
	arg_59_0.dragOffsetPos.y = arg_59_3.position.y - var_59_1.transform.localPosition.y

	return
end

function var_0_1.onGridDrag(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	if not arg_60_0.selectGrid or arg_60_1 ~= arg_60_0.selectGrid then
		return
	end

	if not arg_60_0.uiCam then
		GameObject = var_4

		local var_60_0 = var_4.Find("UICamera")

		arg_60_0.uiCam = var_4.GetComponent(var_60_0, "Camera")
	end

	local var_60_1 = arg_60_0.uiCam
	local var_60_2 = var_4.ScreenToWorldPoint(var_60_1, arg_60_3.position)
	local var_60_3 = arg_60_0.rollingUI
	local var_60_4 = var_5.InverseTransformPoint(var_60_3, var_60_2).x

	RollingBallConst = var_60_3

	local var_60_5 = var_60_4 - var_60_3.grid_width / 2
	local var_60_6 = var_5.y

	RollingBallConst = var_8

	local var_60_7 = var_60_6 - var_8.grid_height / 2

	if var_60_5 < 0 then
		var_60_5 = 0
	end

	if var_60_7 < 0 then
		var_60_7 = 0
	end

	RollingBallConst = var_8

	local var_60_8 = var_8.horizontal - 1

	RollingBallConst = var_1_10009

	local var_60_9

	if var_60_8 * var_1_10009.grid_width < var_60_5 then
		RollingBallConst = var_60_9
		var_60_9 = var_60_9.horizontal - 1
		RollingBallConst = var_9
		var_60_5 = var_60_9 * var_9.grid_width
	end

	RollingBallConst = var_60_9

	local var_60_10 = var_60_9.vertical - 1

	RollingBallConst = var_9

	if var_60_10 * var_9.grid_height < var_60_7 then
		RollingBallConst = var_8

		local var_60_11 = var_8.vertical - 1

		RollingBallConst = var_9
		var_60_7 = var_60_11 * var_9.grid_height
	end

	local var_60_12 = arg_60_0.selectGrid

	var_8.changePosition(var_60_12, var_60_5, var_60_7)

	local var_60_13 = arg_60_0
	local var_60_14 = arg_60_0.getGridByPosition
	local var_60_15 = arg_60_0.selectGrid

	if var_60_14(var_60_13, var_11.getPosition(var_60_15)) and var_8 ~= arg_60_0.selectGrid then
		local var_60_16, var_60_17 = var_8:getPosData()
		local var_60_18 = arg_60_0.selectGrid
		local var_60_19, var_60_20 = var_11.getPosData(var_60_18)
		local var_60_21 = var_60_16 - var_60_19
		local var_60_22 = var_60_17 - var_60_20

		math = var_1_10015

		local var_60_23 = var_1_10015.abs(var_60_21)

		math = var_1_10016

		if var_60_23 + var_1_10016.abs(var_60_22) == 1 then
			arg_60_0:updateMove(var_60_16, var_60_17)
		else
			math = var_15

			local var_60_24 = var_15.abs(var_60_21)

			math = var_16

			if var_60_24 > var_16.abs(var_60_22) then
				if var_60_21 > 0 then
					var_60_16 = var_60_19 + 1
				end

				if var_60_21 < 0 then
					var_60_16 = var_60_19 - 1
				end

				arg_60_0:updateMove(var_60_16, var_60_20)
			else
				if var_60_22 > 0 then
					var_60_17 = var_60_20 + 1
				end

				if var_60_22 < 0 then
					var_60_17 = var_60_20 - 1
				end

				arg_60_0:updateMove(var_60_19, var_60_17)
			end
		end
	end

	return
end

function var_0_1.updateMove(arg_61_0, arg_61_1, arg_61_2)
	RollingBallConst = var_1_10003

	if not (var_1_10003.horizontal < arg_61_1) then
		RollingBallConst = var_3

		if arg_61_2 > var_3.vertical then
			return
		end

		arg_61_0:changeDragGrid(arg_61_1, arg_61_2)
		arg_61_0:updateMoveGridDic()

		arg_61_0.changeGridsDic = nil

		arg_61_0:moveGridsBySelfPos(arg_61_0.gridDic, arg_61_0.selectGrid)

		local var_61_0 = arg_61_0
		local var_61_1 = arg_61_0.setDragAlpha
		local var_61_2 = arg_61_1
		local var_61_3 = arg_61_2
		local var_61_4 = arg_61_0.selectGrid

		var_61_1(var_61_0, var_61_2, var_61_3, var_8.getType(var_61_4))

		return
	end
end

function var_0_1.getGridByPosition(arg_62_0, arg_62_1)
	math = var_1_10002

	local var_62_0 = var_1_10002.floor
	local var_62_1 = arg_62_1.x

	RollingBallConst = var_1_10005

	local var_62_2 = var_62_1 + var_1_10005.grid_width / 2

	RollingBallConst = var_5

	local var_62_3 = var_62_0(var_62_2 / var_5.grid_width) + 1

	math = var_1_10003

	local var_62_4 = var_1_10003.floor
	local var_62_5 = arg_62_1.y

	RollingBallConst = var_1_10006

	local var_62_6 = var_62_5 + var_1_10006.grid_height / 2

	RollingBallConst = var_6

	local var_62_7 = var_62_4(var_62_6 / var_6.grid_height) + 1

	if 1 <= var_62_3 then
		RollingBallConst = var_4

		if var_62_3 <= var_4.horizontal and 1 <= var_62_7 then
			RollingBallConst = var_4

			if var_62_7 <= var_4.vertical then
				return arg_62_0.gridDic[var_62_3][var_62_7]
			end
		end
	end

	return nil
end

function var_0_1.updateEnterGrid(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0.selectGrid
	local var_63_1, var_63_2 = var_3.getPosData(var_63_0)

	arg_63_0.changeGridsDic = {}

	for iter_63_0 = 1, #arg_63_0.gridDic do
		arg_63_0.changeGridsDic[iter_63_0] = {}

		for iter_63_1 = 1, #arg_63_0.gridDic[iter_63_0] do
			if iter_63_0 ~= var_63_1 and iter_63_1 ~= var_63_2 then
				table = var_1_10013

				var_1_10013.insert(arg_63_0.changeGridsDic[iter_63_0], {
					grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
					posX = iter_63_0,
					posY = iter_63_1
				})
			elseif iter_63_0 == var_63_1 and iter_63_1 == var_63_2 then
				table = var_1_10013

				var_1_10013.insert(arg_63_0.changeGridsDic[iter_63_0], {
					grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
					posX = arg_63_1,
					posY = arg_63_2
				})
			elseif iter_63_0 == var_63_1 then
				if var_63_2 < iter_63_1 and iter_63_1 <= arg_63_2 then
					table = var_1_10013

					var_1_10013.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1 - 1
					})
				elseif iter_63_1 < var_63_2 and arg_63_2 <= iter_63_1 then
					table = var_1_10013

					var_1_10013.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1 + 1
					})
				else
					table = var_1_10013

					var_1_10013.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1
					})
				end
			elseif iter_63_1 == var_63_2 then
				if var_63_1 < iter_63_0 and iter_63_0 <= arg_63_1 then
					table = var_1_10013

					var_1_10013.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0 - 1,
						posY = iter_63_1
					})
				elseif iter_63_0 < var_63_1 and arg_63_1 <= iter_63_0 then
					table = var_1_10013

					var_1_10013.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0 + 1,
						posY = iter_63_1
					})
				else
					table = var_1_10013

					var_1_10013.insert(arg_63_0.changeGridsDic[iter_63_0], {
						grid = arg_63_0.gridDic[iter_63_0][iter_63_1],
						posX = iter_63_0,
						posY = iter_63_1
					})
				end
			end
		end
	end

	return
end

function var_0_1.changeDragGrid(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = arg_64_0.selectGrid
	local var_64_1, var_64_2 = var_3.getPosData(var_64_0)

	arg_64_0.changeGridsDic = {}

	for iter_64_0 = 1, #arg_64_0.gridDic do
		arg_64_0.changeGridsDic[iter_64_0] = {}

		for iter_64_1 = 1, #arg_64_0.gridDic[iter_64_0] do
			if iter_64_0 == arg_64_1 and iter_64_1 == arg_64_2 then
				table = var_1_10013

				var_1_10013.insert(arg_64_0.changeGridsDic[iter_64_0], {
					grid = arg_64_0.gridDic[iter_64_0][iter_64_1],
					posX = var_64_1,
					posY = var_64_2
				})
			elseif iter_64_0 == var_64_1 and iter_64_1 == var_64_2 then
				table = var_1_10013

				var_1_10013.insert(arg_64_0.changeGridsDic[iter_64_0], {
					grid = arg_64_0.gridDic[iter_64_0][iter_64_1],
					posX = arg_64_1,
					posY = arg_64_2
				})
			else
				table = var_1_10013

				var_1_10013.insert(arg_64_0.changeGridsDic[iter_64_0], {
					grid = arg_64_0.gridDic[iter_64_0][iter_64_1],
					posX = iter_64_0,
					posY = iter_64_1
				})
			end
		end
	end

	return
end

function var_0_1.createGrid(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	local var_65_0
	local var_65_1 = #arg_65_0.gridsPool

	if #arg_65_0.gridsPool > 0 then
		table = var_6
		var_65_0 = var_6.remove(arg_65_0.gridsPool, 1)
	else
		RollingBallGrid = var_6

		local var_65_2 = var_6.New

		tf = var_1_10008
		Instantiate = var_1_10010

		local var_65_3 = var_65_2(var_1_10008(var_1_10010(arg_65_0.tplGrid)))

		var_65_0.addDownCallback(var_65_3, function(arg_66_0, arg_66_1)
			local var_66_0 = arg_65_0

			var_2.onGridDown(var_66_0, var_65_0)

			return
		end)
		var_65_0:addUpCallback(function(arg_67_0, arg_67_1)
			local var_67_0 = arg_65_0

			var_2.onGridUp(var_67_0, var_65_0)

			return
		end)
		var_65_0:addBeginDragCallback(function(arg_68_0, arg_68_1)
			local var_68_0 = arg_65_0

			var_2.onGridBeginDrag(var_68_0, var_65_0, arg_68_0, arg_68_1)

			return
		end)
		var_65_0:addDragCallback(function(arg_69_0, arg_69_1)
			local var_69_0 = arg_65_0

			var_2.onGridDrag(var_69_0, var_65_0, arg_69_0, arg_69_1)

			return
		end)

		setActive = var_6

		var_6(var_65_0:getTf(), true)
	end

	var_65_0:setParent(arg_65_0.rollingUI)
	var_65_0:setType(arg_65_1)
	var_65_0:setPosData(arg_65_2, arg_65_3)

	return var_65_0
end

function var_0_1.setDragAlpha(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = arg_70_1 - 1

	RollingBallConst = var_1_10005

	local var_70_1 = var_70_0 * var_1_10005.grid_width
	local var_70_2 = arg_70_2 - 1

	RollingBallConst = var_1_10006

	local var_70_3 = var_70_2 * var_1_10006.grid_height
	local var_70_4 = arg_70_0.dragAlphaGrid

	var_6.setPosition(var_70_4, var_70_1, var_70_3)

	local var_70_5 = arg_70_0.dragAlphaGrid

	var_6.setType(var_70_5, arg_70_3)

	setActive = var_6

	local var_70_6 = arg_70_0.dragAlphaGrid

	var_6(var_8.getTf(var_70_6), true)

	return
end

function var_0_1.clearDragAlpha(arg_71_0)
	setActive = var_1_10001

	local var_71_0 = arg_71_0.dragAlphaGrid

	var_1_10001(var_3.getTf(var_71_0), false)

	return
end

function var_0_1.returnGrid(arg_72_0, arg_72_1)
	arg_72_0:removeGrid(arg_72_1)
	arg_72_1:clearData()
	arg_72_1:setParent(arg_72_0.gridPoolTf)
	arg_72_1:setEventActive(false)

	table = var_2

	var_2.insert(arg_72_0.gridsPool, arg_72_1)

	return
end

function var_0_1.removeGrid(arg_73_0, arg_73_1)
	local var_73_0, var_73_1 = arg_73_1:getPosData()

	if not arg_73_0.gridDic[var_73_0][var_73_1] then
		arg_73_0.gridDic[var_73_0][var_73_1] = false
	end

	return
end

function var_0_1.getRandomType(arg_74_0, arg_74_1)
	if arg_74_1 then
		var_1_10002 = {}

		local var_74_0 = 1

		RollingBallConst = var_1_10004

		for iter_74_0 = var_74_0, var_1_10004.grid_type_amount do
			table = var_1_10007

			if not var_1_10007.contains(arg_74_1, iter_74_0) then
				table = var_1_10007

				var_1_10007.insert(var_1_10002, iter_74_0)
			end
		end

		math = var_74_0

		return var_1_10002[var_74_0.random(1, #var_1_10002)]
	end

	math = var_1_10002

	local var_74_1 = var_1_10002.random
	local var_74_2 = 1

	RollingBallConst = var_1_10005

	return var_74_1(var_74_2, var_1_10005.grid_type_amount)
end

function var_0_1.addGridScoreTip(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = arg_75_1.x
	local var_75_1 = arg_75_1.y
	local var_75_2 = arg_75_0
	local var_75_3 = arg_75_0.getScoreTip(var_75_2)
	local var_75_4 = var_75_0 - 1

	RollingBallConst = var_75_2

	local var_75_5 = var_75_4 * var_75_2.grid_width
	local var_75_6 = var_75_1 - 1

	RollingBallConst = var_1_10008

	local var_75_7 = var_75_6 * var_1_10008.grid_height

	Vector3 = var_8
	var_75_3.localPosition = var_8(var_75_5, var_75_7, 0)
	setText = var_8
	findTF = var_10

	var_8(var_10(var_75_3, "text"), "+" .. arg_75_2)

	LeanTween = var_8

	local var_75_8 = var_8.moveLocalY

	go = var_10

	local var_75_9 = var_75_8(var_10(var_75_3), var_75_7 + 30, 0.5)
	local var_75_10 = var_8.setOnComplete

	System = var_11

	var_75_10(var_75_9, var_11.Action(function()
		local var_76_0 = arg_75_0

		var_0.returnScoreTip(var_76_0, var_75_3)

		return
	end))

	return
end

function var_0_1.addRemoveEffect(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_1.x
	local var_77_1 = arg_77_1.y
	local var_77_2 = arg_77_0
	local var_77_3 = arg_77_0.getRemoveEffect(var_77_2)
	local var_77_4 = var_77_0 - 1

	RollingBallConst = var_77_2

	local var_77_5 = var_77_4 * var_77_2.grid_width
	local var_77_6 = var_77_1 - 1

	RollingBallConst = var_1_10007

	local var_77_7 = var_77_6 * var_1_10007.grid_height

	Vector3 = var_7
	var_77_3.localPosition = var_7(var_77_5 + 50, var_77_7 + 50, -350)
	LeanTween = var_7

	local var_77_8 = var_7.delayedCall

	go = var_9

	local var_77_9 = var_9(var_77_3)
	local var_77_10 = 0.7

	System = var_11

	var_77_8(var_77_9, var_77_10, var_11.Action(function()
		local var_78_0 = arg_77_0

		var_0.returnRemoveEffect(var_78_0, var_77_3)

		return
	end))

	return
end

function var_0_1.getRemoveEffect(arg_79_0)
	if not arg_79_0.removeEffectPool then
		arg_79_0.removeEffectPool = {}
		arg_79_0.removeEffects = {}
	end

	local var_79_0

	if #arg_79_0.removeEffectPool > 1 then
		table = var_2
		var_79_0 = var_2.remove(arg_79_0.removeEffectPool, #arg_79_0.removeEffectPool)
	else
		tf = var_2
		Instantiate = var_1_10004
		var_79_0 = var_2(var_1_10004(arg_79_0.tplRemoveEffect))
		setParent = var_2

		var_2(var_79_0, arg_79_0.rollingEffectUI, false)

		table = var_2

		var_2.insert(arg_79_0.removeEffects, var_79_0)
	end

	setActive = var_2

	var_2(var_79_0, true)

	return var_79_0
end

function var_0_1.returnRemoveEffect(arg_80_0, arg_80_1)
	setActive = var_1_10002

	var_1_10002(arg_80_1, false)

	table = var_1_10002

	var_1_10002.insert(arg_80_0.removeEffectPool, arg_80_1)

	return
end

function var_0_1.getScoreTip(arg_81_0)
	if not arg_81_0.scoreTipPool then
		arg_81_0.scoreTipPool = {}
		arg_81_0.scoreTips = {}
	end

	local var_81_0

	if #arg_81_0.scoreTipPool > 1 then
		table = var_2
		var_81_0 = var_2.remove(arg_81_0.scoreTipPool, #arg_81_0.scoreTipPool)
	else
		tf = var_2
		Instantiate = var_1_10004
		var_81_0 = var_2(var_1_10004(arg_81_0.tplScoreTip))
		setParent = var_2

		var_2(var_81_0, arg_81_0.rollingEffectUI, false)

		table = var_2

		var_2.insert(arg_81_0.scoreTips, var_81_0)
	end

	setActive = var_2

	var_2(var_81_0, true)

	return var_81_0
end

function var_0_1.returnScoreTip(arg_82_0, arg_82_1)
	setActive = var_1_10002

	var_1_10002(arg_82_1, false)

	table = var_1_10002

	var_1_10002.insert(arg_82_0.scoreTipPool, arg_82_1)

	return
end

function var_0_1.addEffect(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0.effectUI
	local var_83_1 = var_2.InverseTransformPoint(var_83_0, arg_83_1)
	local var_83_2 = arg_83_0:getEffect()

	setParent = var_83_0

	var_83_0(var_83_2, arg_83_0.effectUI, false)

	setActive = var_83_0

	var_83_0(var_83_2, true)

	var_83_2.localPosition = var_83_1
	table = var_83_0

	var_83_0.insert(arg_83_0.effectDatas, {
		vx = 2,
		ax = 0,
		ay = 0,
		vy = 2,
		tf = var_83_2
	})

	return
end

function var_0_1.clearUI(arg_84_0)
	arg_84_0.moveDatas = {}
	arg_84_0.startFlag = false
	arg_84_0.stopFlag = false
	setText = var_1

	var_1(arg_84_0.labelGameScore, "0000")

	setText = var_1

	var_1(arg_84_0.labelGameTime, "")

	setActive = var_1

	var_1(arg_84_0.endLess, true)

	local var_84_0 = arg_84_0.downTimeSlider

	var_84_0.value = 1
	setActive = var_84_0

	var_84_0(arg_84_0.closeUI, false)

	setActive = var_84_0

	var_84_0(arg_84_0.overLight, false)
	arg_84_0:clearDragAlpha()

	for iter_84_0 = #arg_84_0.effectDatas, 1, -1 do
		local var_84_1 = arg_84_0.effectDatas[iter_84_0].tf

		arg_84_0:returnEffect(var_84_1)

		table = var_1_10006

		var_1_10006.remove(arg_84_0.effectDatas, iter_84_0)
	end

	local var_84_2 = 1

	RollingBallConst = var_2

	for iter_84_1 = var_84_2, var_2.horizontal do
		local var_84_3 = 1

		RollingBallConst = var_1_10006

		for iter_84_2 = var_84_3, var_1_10006.vertical do
			if arg_84_0.gridDic[iter_84_1][iter_84_2] then
				arg_84_0:returnGrid(arg_84_0.gridDic[iter_84_1][iter_84_2])

				arg_84_0.gridDic[iter_84_1][iter_84_2] = false
			end
		end
	end

	return
end

function var_0_1.getEffect(arg_85_0)
	if #arg_85_0.effectPool > 0 then
		table = var_1

		return var_1.remove(arg_85_0.effectPool, #arg_85_0.effectPool)
	end

	tf = var_1
	Instantiate = var_1_10003

	return (var_1(var_1_10003(arg_85_0.tplEffect)))
end

function var_0_1.returnEffect(arg_86_0, arg_86_1)
	SetParent = var_1_10002

	var_1_10002(arg_86_1, arg_86_0.effectPoolTf, false)

	table = var_1_10002

	var_1_10002.insert(arg_86_0.effectPool, arg_86_1)

	return
end

function var_0_1.getGridRemoveId(arg_87_0)
	if not arg_87_0.removeId then
		arg_87_0.removeId = 0
	end

	arg_87_0.removeId = arg_87_0.removeId + 1
	tostring = var_1

	return var_1(arg_87_0.removeId)
end

function var_0_1.onBackPressed(arg_88_0)
	if not arg_88_0.startFlag then
		arg_88_0:emit(var_0_1.ON_BACK_PRESSED)
	end

	return
end

function var_0_1.willExit(arg_89_0)
	if arg_89_0.timer and arg_89_0.timer.running then
		var_1_10003 = arg_89_0.timer

		var_1.Stop(var_1_10003)
	end

	LeanTween = var_1

	local var_89_0 = var_1.isTweening

	go = var_1_10003

	local var_89_1

	if var_89_0(var_1_10003(arg_89_0.caidaiTf)) then
		LeanTween = var_89_1
		var_89_1 = var_89_1.cancel
		go = var_3

		var_89_1(var_3(arg_89_0.caidaiTf))
	end

	LeanTween = var_89_1

	local var_89_2 = var_89_1.isTweening

	go = var_3

	local var_89_3

	if var_89_2(var_3(arg_89_0.labelGameScore)) then
		LeanTween = var_89_3
		var_89_3 = var_89_3.cancel
		go = var_3

		var_89_3(var_3(arg_89_0.labelGameScore))
	end

	LeanTween = var_89_3

	local var_89_4 = var_89_3.isTweening

	go = var_3

	if var_89_4(var_3(arg_89_0.rollingUI)) then
		LeanTween = var_1

		local var_89_5 = var_1.cancel

		go = var_3

		var_89_5(var_3(arg_89_0.rollingUI))
	end

	if arg_89_0.scoreTips then
		for iter_89_0 = 1, #arg_89_0.scoreTips do
			LeanTween = var_89_6

			local var_89_6 = var_89_6.isTweening

			go = var_1_10007

			if var_89_6(var_1_10007(arg_89_0.scoreTips[iter_89_0])) then
				LeanTween = var_89_6
				var_89_6 = var_89_6.cancel
				go = var_1_10007

				var_89_6(var_1_10007(arg_89_0.scoreTips[iter_89_0]))
			end
		end
	end

	if arg_89_0.removeEffects then
		for iter_89_1 = 1, #arg_89_0.removeEffects do
			LeanTween = var_89_6
			var_89_6 = var_89_6.isTweening
			go = var_1_10007

			if var_89_6(var_1_10007(arg_89_0.removeEffects[iter_89_1])) then
				LeanTween = var_89_6
				var_89_6 = var_89_6.cancel
				go = var_1_10007

				var_89_6(var_1_10007(arg_89_0.removeEffects[iter_89_1]))
			end
		end
	end

	arg_89_0.timer = nil

	return
end

return var_0_1
