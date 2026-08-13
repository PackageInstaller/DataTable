class = var_0_10000

local var_0_0 = "RopingCowGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = "story-richang-westdaily"
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_4 = "event:/ui/niujiao"
local var_0_5 = "event:/ui/taosheng"
local var_0_6 = 60
local var_0_7 = {
	{
		20,
		{
			0,
			0.25
		}
	},
	{
		40,
		{
			0.5,
			0.5
		}
	},
	{
		50,
		{
			0.5,
			1
		}
	},
	{
		60,
		{
			1,
			1.5
		}
	}
}
local var_0_8 = {
	{
		speed = 800,
		score = 300
	},
	{
		speed = 700,
		score = 200
	},
	{
		speed = 600,
		score = 100
	},
	{
		speed = 500,
		score = 50
	}
}
local var_0_9 = {
	{
		20,
		{
			300,
			300,
			200,
			200
		}
	},
	{
		40,
		{
			200,
			300,
			300,
			200
		}
	},
	{
		50,
		{
			150,
			250,
			300,
			300
		}
	},
	{
		60,
		{
			100,
			100,
			400,
			400
		}
	}
}
local var_0_10 = {
	-50,
	50
}
local var_0_11 = 0.75
local var_0_12 = 1700
local var_0_13 = 4
local var_0_14 = 0
local var_0_15 = 1
local var_0_16 = 2
local var_0_17 = "cow_event_capture"
local var_0_18 = "player_event_capture"
local var_0_19 = "player_event_get"
local var_0_20 = "player_event_miss"
local var_0_21 = "player_event_cd"
local var_0_22 = "idol"
local var_0_23 = "miss"
local var_0_24 = "get"
local var_0_25 = "throw"
local var_0_26 = "event_capture"
local var_0_27 = "scene_item_type_time"
local var_0_28 = "scene_item_type_event"
local var_0_29 = {
	{
		name = "backGround/2/jiujiuA",
		type = var_0_27,
		params = {
			15,
			20
		},
		states = {
			1,
			2,
			3
		}
	},
	{
		name = "backGround/2/jiujiuB",
		type = var_0_27,
		params = {
			15,
			20
		},
		states = {
			1,
			2
		}
	},
	{
		name = "backGround/2/jiujiuC",
		trigger = true,
		type = var_0_27,
		params = {
			15,
			20
		}
	},
	{
		name = "backGround/3/jiujiuD",
		trigger = true,
		type = var_0_27,
		params = {
			20,
			22
		}
	},
	{
		name = "backGround/3/train",
		trigger = true,
		type = var_0_27,
		params = {
			20,
			23
		}
	},
	{
		name = "backGround/2/saloon",
		type = var_0_27,
		params = {
			15,
			20
		},
		states = {
			1,
			2,
			3
		}
	},
	{
		name = "backGround/1/meow",
		type = var_0_27,
		params = {
			15,
			20
		},
		states = {
			1,
			2
		}
	},
	{
		name = "backGround/1/sheriff",
		type = var_0_28,
		events = {
			var_0_20,
			var_0_19,
			var_0_21
		},
		states = {
			1,
			2,
			3
		}
	}
}
local var_0_30 = "state"
local var_0_31 = "trigger"

local function var_0_32(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._tplCows = arg_1_0
			arg_2_0._container = arg_1_1
			arg_2_0._event = arg_1_2
			arg_2_0.cows = {}
			arg_2_0.cowWeights = {}

			for iter_2_0 = 1, #var_0_9 do
				arg_2_0.cowWeights[iter_2_0] = {}

				local var_2_0 = var_0_9[iter_2_0][2]
				local var_2_1 = 0

				ipairs = var_2_10007

				for iter_2_1, iter_2_2 in var_2_10007(var_2_0) do
					var_2_1 = var_2_1 + iter_2_2
					table = var_2_10012

					var_2_10012.insert(arg_2_0.cowWeights[iter_2_0], var_2_1)
				end
			end

			return
		end,
		start = function(arg_3_0)
			arg_3_0.nextCreateTime = 0
			arg_3_0.lastTime = var_0_6

			arg_3_0:clear()

			return
		end,
		step = function(arg_4_0, arg_4_1)
			local var_4_0 = arg_4_0.lastTime

			Time = var_2_10003
			arg_4_0.lastTime = var_4_0 - var_2_10003.deltaTime

			if arg_4_1 > arg_4_0.nextCreateTime then
				arg_4_0.nextCreateTime = arg_4_1 + arg_4_0:getNextCreateCowTime()

				arg_4_0:createCow()
			end

			for iter_4_0 = 1, #arg_4_0.cows do
				local var_4_1 = arg_4_0.cows[iter_4_0].tf.anchoredPosition.x
				local var_4_2 = var_6.anchoredPosition.x
				local var_4_3 = arg_4_0.cows[iter_4_0].data.speed

				Time = var_2_10011
				var_8.x = var_4_2 - var_4_3 * var_2_10011.deltaTime

				local var_4_4 = var_8.x

				if var_4_1 >= 0 and var_4_4 <= 0 then
					arg_4_0:setCowAniamtion(var_6, var_0_16)
				end

				var_6.anchoredPosition = var_8
			end

			for iter_4_1 = #arg_4_0.cows, 1, -1 do
				local var_4_5 = arg_4_0.cows[iter_4_1].tf.anchoredPosition

				if var_6.anchoredPosition.x <= -var_0_12 then
					table = var_8

					local var_4_6 = var_8.remove(arg_4_0.cows, iter_4_1)

					arg_4_0:cowLeave(var_4_6.tf)
				end
			end

			return
		end,
		captureCow = function(arg_5_0, arg_5_1)
			local var_5_0

			for iter_5_0 = #arg_5_0.cows, 1, -1 do
				local var_5_1 = arg_5_0.cows[iter_5_0].tf.anchoredPosition

				if var_7.anchoredPosition.x >= var_0_10[1] and var_7.anchoredPosition.x <= var_0_10[2] then
					if not var_5_0 then
						var_5_0 = iter_5_0
					elseif arg_5_0.cows[var_5_0].tf.anchoredPosition.x - var_7.anchoredPosition.x >= 0 then
						var_5_0 = iter_5_0
					end
				end
			end

			if var_5_0 then
				table = var_3

				local var_5_2 = var_3.remove(arg_5_0.cows, var_5_0)

				arg_5_0:setCowAniamtion(var_5_2.tf, var_0_15)

				if arg_5_1 then
					arg_5_1(true)
				end

				pg = var_4

				local var_5_3 = var_4.CriMgr.GetInstance()

				var_4.PlaySoundEffect_V3(var_5_3, var_0_4)

				local var_5_4 = arg_5_0._event

				var_4.emit(var_5_4, var_0_17, var_5_2.data.score)
			elseif arg_5_1 then
				arg_5_1(false)
			end

			return
		end,
		clear = function(arg_6_0)
			for iter_6_0 = 1, #arg_6_0.cows do
				Destroy = var_2_10005

				var_2_10005(arg_6_0.cows[iter_6_0].tf)
			end

			arg_6_0.cows = {}

			return
		end,
		destroy = function(arg_7_0)
			arg_7_0:clear()

			return
		end,
		createCow = function(arg_8_0)
			local var_8_0 = arg_8_0
			local var_8_1 = arg_8_0.getCowWeightIndex(var_8_0)
			local var_8_2 = arg_8_0.cowWeights[var_8_1]

			math = var_8_0

			local var_8_3 = var_8_0.random(0, var_8_2[#var_8_2])
			local var_8_4

			for iter_8_0 = 1, #var_8_2 do
				if var_8_3 < var_8_2[iter_8_0] then
					var_8_4 = iter_8_0

					break
				end
			end

			if not var_8_4 then
				math = var_5
				var_8_4 = var_5.random(1, #var_0_8)
			end

			tf = var_5
			Instantiate = var_7

			local var_8_5 = var_5(var_7(arg_8_0._tplCows[var_8_4]))

			SetActive = var_6

			var_6(var_8_5, true)

			SetParent = var_6

			var_6(var_8_5, arg_8_0._container)

			Vector3 = var_6
			var_8_5.anchoredPosition = var_6(var_0_12, 0, 0)

			arg_8_0:setCowAniamtion(var_8_5, var_0_14)

			Clone = var_6

			local var_8_6 = var_6(var_0_8[var_8_4])

			GetOrAddComponent = var_7
			findTF = var_9

			local var_8_7 = var_9(var_8_5, "anim")

			typeof = var_10
			DftAniEvent = var_12

			local var_8_8 = var_7(var_8_7, var_10(var_12))

			var_7.SetEndEvent(var_8_8, function()
				local var_9_0 = arg_8_0

				var_0.cowLeave(var_9_0, var_8_5)

				return
			end)

			table = var_8

			var_8.insert(arg_8_0.cows, {
				tf = var_8_5,
				data = var_8_6
			})

			return
		end,
		getCowWeightIndex = function(arg_10_0)
			for iter_10_0 = 1, #var_0_9 do
				if arg_10_0.lastTime and arg_10_0.lastTime < var_0_9[iter_10_0][1] then
					return iter_10_0
				end
			end

			return #var_0_9
		end,
		getNextCreateCowTime = function(arg_11_0)
			local var_11_0

			for iter_11_0 = 1, #var_0_7 do
				if arg_11_0.lastTime < var_0_7[iter_11_0][1] then
					local var_11_1 = 0.3 + var_0_7[iter_11_0][2][1]

					math = var_7

					return var_11_1 + var_7.random() * (var_1[2] - var_1[1])
				end
			end

			local var_11_2 = var_0_7[#var_0_7][2]

			math = var_2

			return var_2.random(var_11_2[1], var_11_2[2])
		end,
		setCowAniamtion = function(arg_12_0, arg_12_1, arg_12_2)
			GetComponent = var_2_10003
			findTF = var_2_10005

			local var_12_0 = var_2_10005(arg_12_1, "anim")

			typeof = var_2_10006
			Animator = var_8

			local var_12_1 = var_2_10003(var_12_0, var_2_10006(var_8))

			var_3.SetInteger(var_12_1, "state", arg_12_2)

			return
		end,
		cowLeave = function(arg_13_0, arg_13_1)
			Destroy = var_2_10002

			var_2_10002(arg_13_1)

			return
		end
	}

	var_3.ctor(var_1_0)

	return var_3
end

local function var_0_33(arg_14_0, arg_14_1)
	local var_14_0 = {
		ctor = function(arg_15_0)
			arg_15_0._playerTf = arg_14_0
			arg_15_0._initPosition = arg_15_0._playerTf.anchoredPosition
			GetComponent = var_1
			findTF = var_2_10003

			local var_15_0 = var_2_10003(arg_15_0._playerTf, "img")

			typeof = var_2_10004
			Animator = var_6
			arg_15_0._animator = var_1(var_15_0, var_2_10004(var_6))

			local var_15_1 = arg_15_0

			arg_15_0.setPlayerAnim(var_15_1, var_0_22)

			arg_15_0._event = arg_14_1
			GetOrAddComponent = var_1
			findTF = var_15_1

			local var_15_2 = var_15_1(arg_15_0._playerTf, "img")

			typeof = var_4
			DftAniEvent = var_6
			arg_15_0.playerDft = var_1(var_15_2, var_4(var_6))

			local var_15_3 = arg_15_0.playerDft

			var_1.SetTriggerEvent(var_15_3, function()
				local var_16_0 = arg_15_0._event

				var_0.emit(var_16_0, var_0_26, nil, function(arg_17_0)
					if arg_17_0 then
						local var_17_0 = arg_15_0

						var_1.setPlayerAnim(var_17_0, var_0_24)

						local var_17_1 = arg_15_0._event

						var_1.emit(var_17_1, var_0_19)
					else
						local var_17_2 = arg_15_0

						var_1.setPlayerAnim(var_17_2, var_0_23)
					end

					return
				end)

				return
			end)

			local var_15_4 = arg_15_0.playerDft

			var_1.SetEndEvent(var_15_4, function()
				local var_18_0 = arg_15_0._event

				var_0.emit(var_18_0, var_0_20)

				return
			end)

			return
		end,
		throw = function(arg_19_0)
			if arg_19_0.captureCdTime then
				return
			end

			arg_19_0.captureCdTime = var_0_11

			arg_19_0:setPlayerAnim(var_0_25)

			pg = var_1

			local var_19_0 = var_1.CriMgr.GetInstance()

			var_1.PlaySoundEffect_V3(var_19_0, var_0_5)

			return
		end,
		setPlayerAnim = function(arg_20_0, arg_20_1)
			local var_20_0 = arg_20_0._animator

			var_2.SetTrigger(var_20_0, arg_20_1)

			return
		end,
		start = function(arg_21_0)
			arg_21_0.captureCdTime = 0

			return
		end,
		getThrowTime = function(arg_22_0)
			return arg_22_0.captureCdTime
		end,
		step = function(arg_23_0, arg_23_1)
			if arg_23_0.captureCdTime then
				if arg_23_0.captureCdTime < 0 then
					arg_23_0.captureCdTime = nil

					arg_23_0:setPlayerAnim(var_0_22)

					local var_23_0 = arg_23_0._event

					var_2.emit(var_23_0, var_0_21)
				else
					local var_23_1 = arg_23_0.captureCdTime

					Time = var_3
					arg_23_0.captureCdTime = var_23_1 - var_3.deltaTime
				end
			end

			return
		end,
		destory = function(arg_24_0)
			return
		end
	}

	var_2.ctor(var_14_0)

	return var_2
end

local function var_0_34(arg_25_0)
	local var_25_0 = {
		ctor = function(arg_26_0)
			arg_26_0._backSceneTf = arg_25_0

			if not arg_26_0.sceneItems then
				arg_26_0.sceneItems = {}

				for iter_26_0 = 1, #var_0_29 do
					findTF = var_2_10005
					var_2_10005 = var_2_10005(arg_26_0._backSceneTf, var_0_29[iter_26_0].name)
					table = var_2_10006

					var_2_10006.insert(arg_26_0.sceneItems, {
						tf = var_2_10005,
						data = var_0_29[iter_26_0]
					})
				end
			end

			return
		end,
		onEventHandle = function(arg_27_0, arg_27_1)
			for iter_27_0 = 1, #arg_27_0.sceneItems do
				local var_27_0 = arg_27_0.sceneItems[iter_27_0].data
				local var_27_1 = arg_27_0.sceneItems[iter_27_0].tf

				if var_27_0.type == var_0_28 then
					local var_27_2 = var_27_0.events

					ipairs = var_9

					for iter_27_1, iter_27_2 in var_9(var_27_2) do
						if iter_27_2 == arg_27_1 and var_27_0.states then
							arg_27_0:changeSceneItemAnim(var_0_30, var_27_0.states[iter_27_1], var_27_1)
						end
					end
				end
			end

			return
		end,
		step = function(arg_28_0, arg_28_1)
			for iter_28_0 = 1, #arg_28_0.sceneItems do
				local var_28_0 = arg_28_0.sceneItems[iter_28_0].data
				local var_28_1 = var_6.tf

				if var_28_0.type == var_0_27 then
					if not var_6.time then
						math = var_9
						var_6.time = var_9.random(var_28_0.params[1], var_28_0.params[2])
					else
						local var_28_2 = var_6.time

						if 0 < var_28_2 then
							var_28_2 = var_6.time
							Time = var_10
							var_6.time = var_28_2 - var_10.deltaTime
						else
							math = var_28_2
							var_6.time = var_28_2.random(var_28_0.params[1], var_28_0.params[2])

							if var_28_0.states then
								local var_28_3 = arg_28_0
								local var_28_4 = arg_28_0.changeSceneItemAnim
								local var_28_5 = var_0_30
								local var_28_6 = var_28_0.states

								math = var_2_10014

								var_28_4(var_28_3, var_28_5, var_28_6[var_2_10014.random(1, #var_28_0.states)], var_28_1)
							elseif var_28_0.trigger then
								arg_28_0:changeSceneItemAnim(var_0_31, nil, var_28_1)
							end
						end
					end
				end
			end

			return
		end,
		changeSceneItemAnim = function(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
			GetComponent = var_2_10004

			local var_29_0 = arg_29_3

			typeof = var_2_10007
			Animator = var_2_10009

			local var_29_1 = var_2_10004(var_29_0, var_2_10007(var_2_10009))

			if arg_29_1 == var_0_30 then
				var_29_1:SetInteger("state", arg_29_2)
			elseif arg_29_1 == var_0_31 then
				var_29_1:SetTrigger("trigger")
			end

			return
		end
	}

	var_1.ctor(var_25_0)

	return var_1
end

function var_0_1.getUIName(arg_30_0)
	return "GameRoomRopingCowUI"
end

function var_0_1.getBGM(arg_31_0)
	return var_0_2
end

function var_0_1.didEnter(arg_32_0)
	arg_32_0:initEvent()
	arg_32_0:initData()
	arg_32_0:initUI()
	arg_32_0:initGameUI()
	arg_32_0:updateMenuUI()
	arg_32_0:openMenuUI()

	return
end

function var_0_1.initEvent(arg_33_0)
	arg_33_0:bind(var_0_17, function(arg_34_0, arg_34_1, arg_34_2)
		local var_34_0 = arg_33_0

		var_3.addScore(var_34_0, arg_34_1)

		local var_34_1 = arg_33_0

		var_3.onEventHandle(var_34_1, var_0_17)

		return
	end)
	arg_33_0:bind(var_0_26, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_33_0._cowController then
			local var_35_0 = arg_33_0._cowController

			var_3.captureCow(var_35_0, arg_35_2)
		end

		local var_35_1 = arg_33_0

		var_3.onEventHandle(var_35_1, var_0_26)

		return
	end)
	arg_33_0:bind(var_0_19, function(arg_36_0, arg_36_1, arg_36_2)
		local var_36_0 = arg_33_0

		var_3.onEventHandle(var_36_0, var_0_19)

		return
	end)
	arg_33_0:bind(var_0_20, function(arg_37_0, arg_37_1, arg_37_2)
		local var_37_0 = arg_33_0

		var_3.onEventHandle(var_37_0, var_0_20)

		return
	end)
	arg_33_0:bind(var_0_21, function(arg_38_0, arg_38_1, arg_38_2)
		local var_38_0 = arg_33_0

		var_3.onEventHandle(var_38_0, var_0_21)

		return
	end)

	return
end

function var_0_1.onEventHandle(arg_39_0, arg_39_1)
	if arg_39_0._sceneItemController then
		local var_39_0 = arg_39_0._sceneItemController

		var_2.onEventHandle(var_39_0, arg_39_1)
	end

	return
end

function var_0_1.initData(arg_40_0)
	Application = var_1_10001

	local var_40_0

	if not var_1_10001.targetFrameRate then
		var_40_0 = 60
	end

	if 60 < var_40_0 then
		var_40_0 = 60
	end

	Timer = var_2
	arg_40_0.timer = var_2.New(function()
		local var_41_0 = arg_40_0

		var_0.onTimer(var_41_0)

		return
	end, 1 / var_40_0, -1)

	return
end

function var_0_1.initUI(arg_42_0)
	findTF = var_1_10001
	arg_42_0.backSceneTf = var_1_10001(arg_42_0._tf, "scene_background")
	findTF = var_1
	arg_42_0.sceneTf = var_1(arg_42_0._tf, "scene")
	findTF = var_1
	arg_42_0.clickMask = var_1(arg_42_0._tf, "clickMask")
	findTF = var_1
	arg_42_0.countUI = var_1(arg_42_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_42_0 = var_3(arg_42_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_42_0.countAnimator = var_1(var_42_0, var_4(var_6))
	GetOrAddComponent = var_1
	findTF = var_42_0

	local var_42_1 = var_42_0(arg_42_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_42_0.countDft = var_1(var_42_1, var_4(var_6))

	local var_42_2 = arg_42_0.countDft

	var_1.SetTriggerEvent(var_42_2, function()
		return
	end)

	local var_42_3 = arg_42_0.countDft

	var_1.SetEndEvent(var_42_3, function()
		setActive = var_2_10000

		var_2_10000(arg_42_0.countUI, false)

		local var_44_0 = arg_42_0

		var_0.gameStart(var_44_0)

		return
	end)

	findTF = var_1
	arg_42_0.leaveUI = var_1(arg_42_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_42_4 = arg_42_0

	findTF = var_4

	local var_42_5 = var_4(arg_42_0.leaveUI, "ad/btnOk")

	local function var_42_6()
		local var_45_0 = arg_42_0

		var_0.resumeGame(var_45_0)

		local var_45_1 = arg_42_0

		var_0.onGameOver(var_45_1)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_42_4, var_42_5, var_42_6, var_6)

	onButton = var_1

	local var_42_7 = arg_42_0

	findTF = var_42_5

	local var_42_8 = var_42_5(arg_42_0.leaveUI, "ad/btnCancel")

	local function var_42_9()
		local var_46_0 = arg_42_0

		var_0.resumeGame(var_46_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_42_7, var_42_8, var_42_9, var_6)

	findTF = var_1
	arg_42_0.pauseUI = var_1(arg_42_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_42_10 = arg_42_0

	findTF = var_4

	local var_42_11 = var_4(arg_42_0.pauseUI, "ad/btnOk")

	local function var_42_12()
		setActive = var_2_10000

		var_2_10000(arg_42_0.pauseUI, false)

		local var_47_0 = arg_42_0

		var_0.resumeGame(var_47_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_42_10, var_42_11, var_42_12, var_6)

	findTF = var_1
	arg_42_0.settlementUI = var_1(arg_42_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_42_13 = arg_42_0

	findTF = var_4

	local var_42_14 = var_4(arg_42_0.settlementUI, "ad/btnOver")

	local function var_42_15()
		setActive = var_2_10000

		var_2_10000(arg_42_0.settlementUI, false)

		local var_48_0 = arg_42_0

		var_0.openMenuUI(var_48_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_42_13, var_42_14, var_42_15, var_6)

	findTF = var_1
	arg_42_0.menuUI = var_1(arg_42_0._tf, "pop/menuUI")
	GetComponent = var_1
	findTF = var_3

	local var_42_16 = var_3(arg_42_0.menuUI, "battList")

	typeof = var_4
	ScrollRect = var_6
	arg_42_0.battleScrollRect = var_1(var_42_16, var_4(var_6))
	arg_42_0.totalTimes = arg_42_0:getGameTotalTime()

	local var_42_17 = arg_42_0:getGameUsedTimes() - 4 < 0 and 0 or arg_42_0:getGameUsedTimes() - 4

	scrollTo = var_2

	var_2(arg_42_0.battleScrollRect, 0, 1 - var_42_17 / (arg_42_0.totalTimes - 4))

	onButton = var_2

	local var_42_18 = arg_42_0

	findTF = var_5

	local var_42_19 = var_5(arg_42_0.menuUI, "rightPanelBg/arrowUp")

	local function var_42_20()
		local var_49_0 = arg_42_0.battleScrollRect.normalizedPosition.y + 1 / (arg_42_0.totalTimes - 4)

		if 1 < var_49_0 then
			var_49_0 = 1
		end

		scrollTo = var_1

		var_1(arg_42_0.battleScrollRect, 0, var_49_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_42_18, var_42_19, var_42_20, var_7)

	onButton = var_2

	local var_42_21 = arg_42_0

	findTF = var_42_19

	local var_42_22 = var_42_19(arg_42_0.menuUI, "rightPanelBg/arrowDown")

	local function var_42_23()
		local var_50_0

		if arg_42_0.battleScrollRect.normalizedPosition.y - 1 / (arg_42_0.totalTimes - 4) < 0 then
			var_50_0 = 0
		end

		scrollTo = var_1

		var_1(arg_42_0.battleScrollRect, 0, var_50_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_42_21, var_42_22, var_42_23, var_7)

	onButton = var_2

	local var_42_24 = arg_42_0

	findTF = var_42_22

	local var_42_25 = var_42_22(arg_42_0.menuUI, "btnBack")

	local function var_42_26()
		local var_51_0 = arg_42_0

		var_0.closeView(var_51_0)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_42_24, var_42_25, var_42_26, var_7)

	onButton = var_2

	local var_42_27 = arg_42_0

	findTF = var_42_25

	local var_42_28 = var_42_25(arg_42_0.menuUI, "btnRule")

	local function var_42_29()
		pg = var_2_10000

		local var_52_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_52_1 = var_0.ShowMsgBox
		local var_52_2 = {}

		MSGBOX_TYPE_HELP = var_2_10004
		var_52_2.type = var_2_10004

		local var_52_3 = arg_42_0

		var_52_2.helps = var_4.getGameRoomData(var_52_3).game_help

		var_52_1(var_52_0, var_52_2)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_42_27, var_42_28, var_42_29, var_7)

	onButton = var_2

	local var_42_30 = arg_42_0

	findTF = var_42_28

	local var_42_31 = var_42_28(arg_42_0.menuUI, "btnStart")

	local function var_42_32()
		setActive = var_2_10000

		var_2_10000(arg_42_0.menuUI, false)

		local var_53_0 = arg_42_0

		var_0.openCoinLayer(var_53_0, false)

		local var_53_1 = arg_42_0

		var_0.readyStart(var_53_1)

		return
	end

	SFX_CANCEL = var_7

	var_2(var_42_30, var_42_31, var_42_32, var_7)

	findTF = var_2

	local var_42_33 = var_2(arg_42_0.menuUI, "tplBattleItem")

	if not arg_42_0.handle then
		UpdateBeat = var_3
		arg_42_0.handle = var_3:CreateListener(arg_42_0.Update, arg_42_0)
	end

	UpdateBeat = var_3

	var_3:AddListener(arg_42_0.handle)

	return
end

function var_0_1.initGameUI(arg_54_0)
	findTF = var_1_10001
	arg_54_0.gameUI = var_1_10001(arg_54_0._tf, "ui/gameUI")
	onButton = var_1

	local var_54_0 = arg_54_0

	findTF = var_4

	var_1(var_54_0, var_4(arg_54_0.gameUI, "topRight/btnStop"), function()
		local var_55_0 = arg_54_0

		var_0.stopGame(var_55_0)

		setActive = var_0

		var_0(arg_54_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_54_1 = arg_54_0

	findTF = var_4

	var_1(var_54_1, var_4(arg_54_0.gameUI, "btnLeave"), function()
		local var_56_0 = arg_54_0

		var_0.stopGame(var_56_0)

		setActive = var_0

		var_0(arg_54_0.leaveUI, true)

		return
	end)

	findTF = var_1
	arg_54_0.gameTimeS = var_1(arg_54_0.gameUI, "top/time/s")
	findTF = var_1
	arg_54_0.scoreTf = var_1(arg_54_0.gameUI, "top/score")
	findTF = var_1
	arg_54_0.btnCapture = var_1(arg_54_0.gameUI, "btnCapture")
	GetOrAddComponent = var_1
	arg_54_0.captureButton = var_1(arg_54_0.btnCapture, "EventTriggerListener")

	local var_54_2 = arg_54_0.captureButton

	var_1.AddPointDownFunc(var_54_2, function(arg_57_0, arg_57_1)
		if arg_54_0._playerController then
			local var_57_0 = arg_54_0._playerController

			var_2.throw(var_57_0)
		end

		return
	end)

	findTF = var_1

	local var_54_3 = var_1(arg_54_0.sceneTf, "cowContainer")
	local var_54_4 = {}

	for iter_54_0 = 1, var_0_13 do
		findTF = var_54_5

		local var_54_5 = var_54_5(arg_54_0.sceneTf, "cow" .. iter_54_0)

		table = var_1_10008

		var_1_10008.insert(var_54_4, var_54_5)
	end

	findTF = var_3
	arg_54_0.sceneScoreTf = var_3(arg_54_0.sceneTf, "score")

	local var_54_6 = var_0_33

	findTF = var_5
	arg_54_0._playerController = var_54_6(var_5(arg_54_0.sceneTf, "player"), arg_54_0)
	arg_54_0._cowController = var_0_32(var_54_4, var_54_3, arg_54_0)
	arg_54_0._sceneItemController = var_0_34(arg_54_0.backSceneTf)

	return
end

function var_0_1.Update(arg_58_0)
	arg_58_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_59_0)
	if arg_59_0.gameStop or arg_59_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		Input = var_1

		local var_59_0 = var_1.GetKeyDown

		KeyCode = var_1_10003

		if var_59_0(var_1_10003.S) and arg_59_0._playerController then
			local var_59_1 = arg_59_0._playerController

			var_1.throw(var_59_1)
		end
	end

	return
end

function var_0_1.updateMenuUI(arg_60_0)
	local var_60_0 = arg_60_0:getGameUsedTimes()
	local var_60_1 = arg_60_0:getGameTimes()

	return
end

function var_0_1.CheckGet(arg_61_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_61_0.menuUI, "got"), false)

	if arg_61_0:getUltimate() then
		local var_61_0 = arg_61_0

		if arg_61_0.getUltimate(var_61_0) ~= 0 then
			setActive = var_1
			findTF = var_61_0

			var_1(var_61_0(arg_61_0.menuUI, "got"), true)
		end
	end

	if arg_61_0:getUltimate() == 0 then
		local var_61_1 = arg_61_0

		if arg_61_0.getGameTotalTime(var_61_1) > arg_61_0:getGameUsedTimes() then
			return
		end

		pg = var_61_1

		local var_61_2 = var_61_1.m02
		local var_61_3 = var_3.sendNotification

		GAME = var_6

		local var_61_4 = var_6.SEND_MINI_GAME_OP
		local var_61_5 = {
			hubid = arg_61_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_8
		var_61_5.cmd = var_8.CMD_ULTIMATE
		var_61_5.args1 = {}

		var_61_3(var_61_2, var_61_4, var_61_5)

		setActive = var_61_3
		findTF = var_61_2

		var_61_3(var_61_2(arg_61_0.menuUI, "got"), true)
	end

	return
end

function var_0_1.openMenuUI(arg_62_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_62_0._tf, "scene_front"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_62_0._tf, "scene_background"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_62_0._tf, "scene"), false)

	setActive = var_1_10001

	var_1_10001(arg_62_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_62_0.menuUI, true)
	arg_62_0:openCoinLayer(true)
	arg_62_0:updateMenuUI()

	return
end

function var_0_1.clearUI(arg_63_0)
	setActive = var_1_10001

	var_1_10001(arg_63_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_63_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_63_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_63_0.menuUI, false)
	arg_63_0:openCoinLayer(false)

	setActive = var_1

	var_1(arg_63_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_64_0)
	setActive = var_1_10001

	var_1_10001(arg_64_0.countUI, true)

	local var_64_0 = arg_64_0.countAnimator

	var_1.Play(var_64_0, "count")

	pg = var_1

	local var_64_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_64_1, var_0_3)

	return
end

function var_0_1.gameStart(arg_65_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_65_0._tf, "scene_front"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_65_0._tf, "scene_background"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_65_0._tf, "scene"), true)

	setActive = var_1_10001

	var_1_10001(arg_65_0.gameUI, true)

	arg_65_0.gameStartFlag = true
	arg_65_0.scoreNum = 0
	arg_65_0.playerPosIndex = 2
	arg_65_0.gameStepTime = 0
	arg_65_0.heart = 3
	arg_65_0.gameTime = var_0_6

	if arg_65_0._cowController then
		local var_65_0 = arg_65_0._cowController

		var_1.start(var_65_0)
	end

	if arg_65_0._playerController then
		local var_65_1 = arg_65_0._playerController

		var_1.start(var_65_1)
	end

	arg_65_0:updateGameUI()
	arg_65_0:timerStart()

	return
end

function var_0_1.getGameTimes(arg_66_0)
	return arg_66_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_67_0)
	return arg_67_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_68_0)
	return arg_68_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_69_0)
	local var_69_0 = arg_69_0:GetMGHubData()

	return (var_1.getConfig(var_69_0, "reward_need"))
end

function var_0_1.changeSpeed(arg_70_0, arg_70_1)
	return
end

function var_0_1.onTimer(arg_71_0)
	arg_71_0:gameStep()

	return
end

function var_0_1.gameStep(arg_72_0)
	local var_72_0 = arg_72_0.gameTime

	Time = var_1_10002
	arg_72_0.gameTime = var_72_0 - var_1_10002.deltaTime

	if arg_72_0.gameTime < 0 then
		arg_72_0.gameTime = 0
	end

	local var_72_1 = arg_72_0.gameStepTime

	Time = var_2
	arg_72_0.gameStepTime = var_72_1 + var_2.deltaTime

	if arg_72_0._cowController then
		local var_72_2 = arg_72_0._cowController

		var_1.step(var_72_2, arg_72_0.gameStepTime)
	end

	if arg_72_0._playerController then
		local var_72_3 = arg_72_0._playerController

		var_1.step(var_72_3, arg_72_0.gameStepTime)
	end

	if arg_72_0._sceneItemController then
		local var_72_4 = arg_72_0._sceneItemController

		var_1.step(var_72_4, arg_72_0.gameStepTime)
	end

	arg_72_0:updateGameUI()

	if arg_72_0.gameTime <= 0 then
		arg_72_0:onGameOver()

		return
	end

	return
end

function var_0_1.timerStart(arg_73_0)
	if not arg_73_0.timer.running then
		local var_73_0 = arg_73_0.timer

		var_1.Start(var_73_0)
	end

	return
end

function var_0_1.timerStop(arg_74_0)
	if arg_74_0.timer.running then
		local var_74_0 = arg_74_0.timer

		var_1.Stop(var_74_0)
	end

	return
end

function var_0_1.updateGameUI(arg_75_0)
	setText = var_1_10001

	var_1_10001(arg_75_0.scoreTf, arg_75_0.scoreNum)

	setText = var_1_10001

	local var_75_0 = arg_75_0.gameTimeS

	math = var_4

	var_1_10001(var_75_0, var_4.ceil(arg_75_0.gameTime))

	if not arg_75_0.captureCdMaskImg then
		GetComponent = var_1
		findTF = var_75_0

		local var_75_1 = var_75_0(arg_75_0.btnCapture, "cd")

		typeof = var_4
		Image = var_6
		arg_75_0.captureCdMaskImg = var_1(var_75_1, var_4(var_6))
	end

	if arg_75_0._playerController then
		local var_75_2 = arg_75_0._playerController

		if var_1.getThrowTime(var_75_2) and var_1 > 0 then
			local var_75_3 = var_1 / var_0_11

			arg_75_0.captureCdMaskImg.fillAmount = var_75_3
		else
			arg_75_0.captureCdMaskImg.fillAmount = 0
		end
	end

	return
end

function var_0_1.addScore(arg_76_0, arg_76_1)
	arg_76_0.scoreNum = arg_76_0.scoreNum + arg_76_1

	if arg_76_0.scoreNum < 0 then
		arg_76_0.scoreNum = 0
	end

	setActive = var_2

	var_2(arg_76_0.sceneScoreTf, false)

	for iter_76_0 = 0, arg_76_0.sceneScoreTf.childCount - 1 do
		local var_76_0 = arg_76_0.sceneScoreTf
		local var_76_1 = var_6.GetChild(var_76_0, iter_76_0).name

		tostring = var_76_0

		if var_76_1 == var_76_0(arg_76_1) then
			setActive = var_76_1

			var_76_1(var_6, true)
		else
			setActive = var_76_1

			var_76_1(var_6, false)
		end
	end

	setActive = var_2

	var_2(arg_76_0.sceneScoreTf, true)

	return
end

function var_0_1.onGameOver(arg_77_0)
	if arg_77_0.settlementFlag then
		return
	end

	arg_77_0:timerStop()

	arg_77_0.settlementFlag = true
	setActive = var_1

	var_1(arg_77_0.sceneScoreTf, false)

	setActive = var_1

	var_1(arg_77_0.clickMask, true)

	local var_77_0

	if arg_77_0._cowController then
		var_77_0 = arg_77_0._cowController

		var_1.clear(var_77_0)
	end

	LeanTween = var_1

	local var_77_1 = var_1.delayedCall

	go = var_77_0

	local var_77_2 = var_77_0(arg_77_0._tf)
	local var_77_3 = 0.1

	System = var_5

	var_77_1(var_77_2, var_77_3, var_5.Action(function()
		arg_77_0.settlementFlag = false

		local var_78_0 = arg_77_0

		var_78_0.gameStartFlag = false
		setActive = var_78_0

		var_78_0(arg_77_0.clickMask, false)

		local var_78_1 = arg_77_0

		var_0.showSettlement(var_78_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_79_0)
	setActive = var_1_10001

	var_1_10001(arg_79_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_79_0 = var_3(arg_79_0.settlementUI, "ad")

	typeof = var_4
	Animator = var_6

	local var_79_1 = var_1_10001(var_79_0, var_4(var_6))

	var_1.Play(var_79_1, "settlement", -1, 0)

	local var_79_2 = arg_79_0.scoreNum

	getProxy = var_79_0
	GameRoomProxy = var_5

	local var_79_3 = var_79_0(var_5)
	local var_79_4 = var_3.getRoomScore(var_79_3, arg_79_0:getGameRoomData().id)

	setActive = var_79_1
	findTF = var_6

	var_79_1(var_6(arg_79_0.settlementUI, "ad/new"), var_79_4 < var_79_2)

	if var_79_4 <= var_79_2 then
		var_79_4 = var_79_2

		arg_79_0:StoreDataToServer({
			var_79_4
		})
	end

	findTF = var_79_1

	local var_79_5 = var_79_1(arg_79_0.settlementUI, "ad/highText")

	findTF = var_79_3

	local var_79_6 = var_79_3(arg_79_0.settlementUI, "ad/currentText")

	setText = var_6

	var_6(var_79_5, var_79_4)

	setText = var_6

	var_6(var_79_6, var_79_2)

	arg_79_0.sendSuccessFlag = true

	arg_79_0:SendSuccess(var_79_2 or 0)

	return
end

function var_0_1.resumeGame(arg_80_0)
	arg_80_0.gameStop = false
	setActive = var_1

	var_1(arg_80_0.leaveUI, false)
	arg_80_0:changeSpeed(1)
	arg_80_0:timerStart()

	return
end

function var_0_1.stopGame(arg_81_0)
	arg_81_0.gameStop = true

	arg_81_0:timerStop()
	arg_81_0:changeSpeed(0)

	return
end

function var_0_1.checkOverflow(arg_82_0, arg_82_1, arg_82_2)
	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_82_0 = var_1_10003(var_1_10005)
	local var_82_1 = var_3.getRawData(var_82_0)

	pg = var_1_10005

	local var_82_2 = var_1_10005.gameset.urpt_chapter_max.description[1]

	LOCK_UR_SHIP = var_82_0

	if var_82_0 then
		var_82_0 = 0
	else
		getProxy = var_82_0
		BagProxy = var_1_10008

		local var_82_3 = var_82_0(var_1_10008)

		var_82_0 = var_82_0.GetLimitCntById(var_82_3, var_82_2)
	end

	Task = var_1_10007

	local var_82_4, var_82_5 = var_1_10007.StaticJudgeOverflow(var_82_1.gold, var_82_1.oil, var_82_0, true, true, {
		arg_82_1
	})

	if var_82_4 then
		pg = var_9

		local var_82_6 = var_9.MsgboxMgr.GetInstance()
		local var_82_7 = var_9.ShowMsgBox
		local var_82_8 = {}

		MSGBOX_TYPE_ITEM_BOX = var_13
		var_82_8.type = var_13
		i18n = var_13
		var_82_8.content = var_13("award_max_warning_minigame")
		var_82_8.items = var_82_5
		var_82_8.onYes = arg_82_2

		var_82_7(var_82_6, var_82_8)
	else
		arg_82_2()
	end

	return
end

function var_0_1.onBackPressed(arg_83_0)
	if not arg_83_0.gameStartFlag then
		arg_83_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_83_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_83_0.pauseUI) then
			setActive = var_1

			var_1(arg_83_0.pauseUI, false)
		end

		arg_83_0:stopGame()

		setActive = var_1

		var_1(arg_83_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_84_0)
	if arg_84_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_84_0.handle)
	end

	if arg_84_0._tf then
		LeanTween = var_1

		local var_84_0 = var_1.isTweening

		go = var_1_10003

		if var_84_0(var_1_10003(arg_84_0._tf)) then
			LeanTween = var_1

			local var_84_1 = var_1.cancel

			go = var_3

			var_84_1(var_3(arg_84_0._tf))
		end
	end

	if arg_84_0.timer and arg_84_0.timer.running then
		local var_84_2 = arg_84_0.timer

		var_1.Stop(var_84_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_84_0.timer = nil

	return
end

return var_0_1
