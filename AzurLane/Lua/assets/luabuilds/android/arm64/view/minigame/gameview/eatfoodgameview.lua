class = var_0_10000

local var_0_0 = "EatFoodGameView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..BaseMiniGameView"))
local var_0_2 = "xinnong-1"
local var_0_3 = "event:/ui/ddldaoshu2"
local var_0_4 = "event:/ui/zhengque"
local var_0_5 = "event:/ui/shibai2"
local var_0_6 = "event:/ui/deshou"
local var_0_7 = "event:/ui/shibai"
local var_0_8 = 60
local var_0_9 = "ui/eatfoodgameui_atlas"
local var_0_10 = "salvage_tips"
local var_0_11 = 2.5
local var_0_12 = 3.75
local var_0_13 = {
	0,
	600
}
local var_0_14 = {
	150,
	150,
	150,
	140,
	140,
	140,
	130,
	130,
	130,
	120,
	120,
	120,
	110,
	110,
	100
}
local var_0_15 = {
	8,
	8,
	9,
	9,
	10,
	10,
	11,
	11,
	12,
	12,
	13,
	13,
	14,
	15,
	16,
	17,
	18,
	20
}
local var_0_16 = 400
local var_0_17 = 1
local var_0_18 = "event touch"
local var_0_19 = {
	15,
	25,
	40,
	75
}
local var_0_20 = {
	500,
	300,
	150,
	50
}
local var_0_21 = {
	-400,
	-300,
	-200,
	-100
}
local var_0_22 = {
	20,
	40,
	60,
	100
}
local var_0_23 = 0.8
local var_0_24 = 0.05
local var_0_25 = 1.4
local var_0_26 = {
	{
		id = 1,
		next_time = {
			3.5,
			4
		}
	},
	{
		id = 2,
		next_time = {
			3.5,
			4
		}
	},
	{
		id = 4,
		next_time = {
			3.5,
			4
		}
	}
}
local var_0_27 = 2
local var_0_28 = {
	1,
	3
}
local var_0_29 = 15
local var_0_30 = {
	3,
	6,
	9,
	11,
	13,
	15
}
local var_0_31 = 10
local var_0_32 = {
	{
		id = 3
	}
}
local var_0_33 = "event game over"

local function var_0_34(arg_1_0, arg_1_1)
	local var_1_0 = {
		ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			setActive = var_1

			var_1(arg_2_0._tf, false)

			findTF = var_1
			arg_2_0.sliderTouch = var_1(arg_2_0._tf, "touch")
			setActive = var_1

			var_1(arg_2_0.sliderTouch, true)

			findTF = var_1
			arg_2_0.sliderRange = var_1(arg_2_0._tf, "range")

			local var_2_0 = arg_2_0.sliderRange

			Vector2 = var_2_10002
			var_2_0.anchoredPosition = var_2_10002(var_0_16, 0)

			return
		end,
		start = function(arg_3_0)
			arg_3_0.sliderIndex = 1
			arg_3_0.nextSliderTime = var_0_12
			Vector2 = var_1
			arg_3_0.sliderTouchPos = var_1(var_0_13[1], 0)

			arg_3_0:setSliderBarVisible(false)

			return
		end,
		step = function(arg_4_0)
			if arg_4_0.nextSliderTime then
				local var_4_0 = arg_4_0.nextSliderTime

				Time = var_2_10002
				arg_4_0.nextSliderTime = var_4_0 - var_2_10002.deltaTime

				if arg_4_0.nextSliderTime <= 0 then
					arg_4_0:setSliderBarVisible(true)
					arg_4_0:startSliderBar()

					arg_4_0.nextSliderTime = arg_4_0.nextSliderTime + var_0_11
				end
			end

			if arg_4_0.sliderBeginning then
				arg_4_0.sliderTouchPos.x = arg_4_0.sliderTouchPos.x + arg_4_0.speed
				arg_4_0.sliderTouch.anchoredPosition = arg_4_0.sliderTouchPos

				if arg_4_0.sliderTouchPos.x > var_0_13[2] then
					arg_4_0:touch(false)
				end
			end

			return
		end,
		setSliderBarVisible = function(arg_5_0, arg_5_1)
			setActive = var_2_10002

			var_2_10002(arg_5_0._tf, arg_5_1)

			return
		end,
		startSliderBar = function(arg_6_0)
			if arg_6_0.sliderIndex > #var_0_14 then
				arg_6_0.sliderIndex = 1
			end

			arg_6_0.sliderWidth = var_0_14[arg_6_0.sliderIndex]
			arg_6_0.speed = var_0_15[arg_6_0.sliderIndex]
			arg_6_0.sliderTouchPos.x = var_0_13[1]
			arg_6_0.sliderBeginning = true

			local var_6_0 = arg_6_0.sliderRange

			Vector2 = var_2
			var_6_0.sizeDelta = var_2(arg_6_0.sliderWidth, arg_6_0.sliderRange.sizeDelta.y)

			return
		end,
		touch = function(arg_7_0, arg_7_1)
			if not arg_7_0.sliderBeginning then
				return
			end

			arg_7_0.sliderBeginning = false

			local var_7_0 = arg_7_0

			arg_7_0.setSliderBarVisible(var_7_0, false)

			local var_7_1 = false
			local var_7_2 = 0

			math = var_7_0

			local var_7_3

			if var_7_0.abs(arg_7_0.sliderTouchPos.x - var_0_16) < arg_7_0.sliderWidth / 2 then
				var_7_2 = arg_7_0:getScore(var_4)
				arg_7_0.sliderIndex = arg_7_0.sliderIndex + 1
				var_7_3 = true
			else
				if arg_7_0.sliderTouchPos.x < 100 or arg_7_0.sliderTouchPos.x > var_0_13[2] - 100 then
					var_7_2 = arg_7_0:getSubScore(arg_7_0.sliderTouchPos.x)
				end

				arg_7_0.nextSliderTime = arg_7_0.nextSliderTime + var_0_17
				var_7_3 = false
			end

			if var_7_3 then
				pg = var_5

				local var_7_4 = var_5.CriMgr.GetInstance()

				var_5.PlaySoundEffect_V3(var_7_4, var_0_6)
			else
				pg = var_5

				local var_7_5 = var_5.CriMgr.GetInstance()

				var_5.PlaySoundEffect_V3(var_7_5, var_0_7)
			end

			if arg_7_1 then
				local var_7_6 = arg_7_0._event

				var_5.emit(var_7_6, var_0_18, {
					flag = var_7_3,
					score = var_7_2
				}, function()
					return
				end)
			end

			return
		end,
		getSubScore = function(arg_9_0, arg_9_1)
			local var_9_0

			if arg_9_1 <= 100 then
				var_9_0 = arg_9_1
			else
				var_9_0 = var_0_13[2] - arg_9_1
			end

			for iter_9_0 = 1, #var_0_22 do
				if var_9_0 < var_0_22[iter_9_0] then
					return var_0_21[iter_9_0]
				end
			end

			return 0
		end,
		getScore = function(arg_10_0, arg_10_1)
			for iter_10_0 = 1, #var_0_19 do
				if arg_10_1 < var_0_19[iter_10_0] then
					return var_0_20[iter_10_0]
				end
			end

			return 0
		end,
		destroy = function(arg_11_0)
			return
		end
	}

	var_2.ctor(var_1_0)

	return var_2
end

local function var_0_35(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = {
		ctor = function(arg_13_0)
			arg_13_0._charTpls = arg_12_0
			arg_13_0._foodTpl = arg_12_1
			arg_13_0._container = arg_12_2
			arg_13_0._event = arg_12_3

			return
		end,
		start = function(arg_14_0)
			arg_14_0:clear()

			arg_14_0.player = nil
			arg_14_0.chars = {}
			arg_14_0.animateSpeed = var_0_23
			arg_14_0.playerNextStepTimes = {}

			arg_14_0:create()

			return
		end,
		step = function(arg_15_0)
			for iter_15_0 = 1, #arg_15_0.chars do
				if not arg_15_0.chars[iter_15_0].nextTime then
					math = var_6
					var_5.nextTime = var_6.random(var_5.next_time[1], var_5.next_time[2])
				else
					local var_15_0 = var_5.nextTime

					Time = var_2_10007
					var_5.nextTime = var_15_0 - var_2_10007.deltaTime

					if var_5.nextTime <= 0 then
						var_5.nextTime = nil
						var_5.stepIndex = var_5.stepIndex + 1
						table = var_6

						if var_6.contains(var_0_30, var_5.stepIndex) then
							local var_15_1 = var_5.tfAnimator

							var_6.SetTrigger(var_15_1, "next")
						end

						if var_5.stepIndex == var_0_31 then
							local var_15_2 = var_5.tfAnimator

							var_6.SetBool(var_15_2, "eat", false)

							local var_15_3 = var_5.tfAnimator

							var_6.SetBool(var_15_3, "bite", true)
						end

						local var_15_4 = var_5.stepIndex

						if var_0_29 <= var_15_4 then
							arg_15_0:setWinChar(var_5)
						end
					end
				end
			end

			return
		end,
		setWinChar = function(arg_16_0, arg_16_1)
			local var_16_0 = false

			if arg_16_1 then
				var_16_0 = arg_16_1.isPlayer
				arg_16_1.foodState = 6

				local var_16_1 = arg_16_1.foodTfAnimator

				var_3.SetInteger(var_16_1, "state", arg_16_1.foodState)
			end

			if arg_16_0.player == arg_16_1 then
				local var_16_2 = arg_16_0.player.tfAnimator

				var_3.SetTrigger(var_16_2, "victory")
			else
				local var_16_3 = arg_16_0.player.tfAnimator

				var_3.SetTrigger(var_16_3, "defeat")
			end

			for iter_16_0 = 1, #arg_16_0.chars do
				if arg_16_0.chars[iter_16_0] == arg_16_1 then
					local var_16_4 = var_7.tfAnimator

					var_8.SetTrigger(var_16_4, "victory")
				else
					local var_16_5 = var_7.tfAnimator

					var_8.SetTrigger(var_16_5, "defeat")
				end
			end

			local var_16_6 = arg_16_0._event

			var_3.emit(var_16_6, var_0_33, var_16_0, function()
				return
			end)

			return
		end,
		onPlayerTouch = function(arg_18_0, arg_18_1)
			if arg_18_0.player then
				if arg_18_1.flag then
					local var_18_0 = arg_18_0.player

					var_18_0.stepIndex = arg_18_0.player.stepIndex + 1
					table = var_18_0

					if var_18_0.contains(var_0_30, arg_18_0.player.stepIndex) then
						table = var_2

						if not var_2.contains(arg_18_0.playerNextStepTimes, arg_18_0.player.stepIndex) then
							table = var_2

							var_2.insert(arg_18_0.playerNextStepTimes, arg_18_0.player.stepIndex)

							local var_18_1 = arg_18_0.player.tfAnimator

							var_2.SetTrigger(var_18_1, "next")
						end
					end

					if arg_18_0.player.stepIndex == var_0_31 then
						local var_18_2 = arg_18_0.player.tfAnimator

						var_2.SetBool(var_18_2, "eat", false)

						local var_18_3 = arg_18_0.player.tfAnimator

						var_2.SetBool(var_18_3, "bite", true)
					end

					if arg_18_0.player.stepIndex >= var_0_29 then
						arg_18_0:setWinChar(arg_18_0.player)
					end

					arg_18_0.animateSpeed = arg_18_0.animateSpeed + var_0_24

					if arg_18_0.animateSpeed > var_0_25 then
						arg_18_0.animateSpeed = var_0_25
					end

					arg_18_0.player.tfAnimator.speed = arg_18_0.animateSpeed
				else
					arg_18_0.animateSpeed = arg_18_0.animateSpeed - var_0_24

					if arg_18_0.animateSpeed < var_0_23 then
						arg_18_0.animateSpeed = var_0_23
					end

					arg_18_0.player.tfAnimator.speed = arg_18_0.animateSpeed

					local var_18_4 = arg_18_0.player.tfAnimator

					var_2.SetTrigger(var_18_4, "miss")
				end
			end

			return
		end,
		create = function(arg_19_0)
			Clone = var_2_10001

			local var_19_0 = var_2_10001(var_0_32)

			table = var_2_10002

			local var_19_1 = var_2_10002.remove
			local var_19_2 = var_19_0

			math = var_2_10005

			local var_19_3 = var_19_1(var_19_2, var_2_10005.random(1, #var_19_0))

			arg_19_0.player = arg_19_0:getCharById(var_19_3, var_0_27)
			Clone = var_3

			local var_19_4 = var_3(var_0_26)

			for iter_19_0 = 1, #var_0_28 do
				table = var_19_5

				local var_19_5 = var_19_5.remove
				local var_19_6 = var_19_4

				math = var_2_10011
				var_19_5 = var_19_5(var_19_6, var_2_10011.random(1, #var_19_4))
				var_2_10011 = arg_19_0

				local var_19_7 = arg_19_0.getCharById(var_2_10011, var_19_5, var_0_28[iter_19_0])

				table = var_19_6

				var_19_6.insert(arg_19_0.chars, var_19_7)
			end

			return
		end,
		getCharById = function(arg_20_0, arg_20_1, arg_20_2)
			local var_20_0 = {}

			tf = var_2_10004
			instantiate = var_2_10006
			findTF = var_2_10008

			local var_20_1 = var_2_10004(var_2_10006(var_2_10008(arg_20_0._charTpls, "char" .. arg_20_1.id)))

			tf = var_2_10005
			instantiate = var_2_10007

			local var_20_2 = var_2_10005(var_2_10007(arg_20_0._foodTpl))

			setParent = var_6

			local var_20_3 = var_20_1

			findTF = var_9

			local var_20_4 = arg_20_0._container

			tostring = var_12

			var_6(var_20_3, var_9(var_20_4, var_12(arg_20_2)))

			setActive = var_6

			var_6(var_20_1, true)

			setParent = var_6

			local var_20_5 = var_20_2

			findTF = var_9

			local var_20_6 = arg_20_0._container

			tostring = var_12

			var_6(var_20_5, var_9(var_20_6, var_12(arg_20_2)))

			setActive = var_6

			var_6(var_20_2, true)

			Vector2 = var_6
			var_20_2.anchoredPosition = var_6(0, -300)
			Vector2 = var_6
			var_20_1.anchoredPosition = var_6(0, 0)
			var_20_0.tf = var_20_1
			GetComponent = var_6
			findTF = var_8

			local var_20_7 = var_8(var_20_1, "anim")

			typeof = var_9
			Animator = var_11
			var_20_0.tfAnimator = var_6(var_20_7, var_9(var_11))

			local var_20_8 = var_20_0.tfAnimator

			var_20_8.speed = arg_20_0.animateSpeed
			var_20_0.foodTf = var_20_2
			GetComponent = var_20_8
			findTF = var_20_7

			local var_20_9 = var_20_7(var_20_2, "anim")

			typeof = var_9
			Animator = var_11
			var_20_0.foodTfAnimator = var_20_8(var_20_9, var_9(var_11))
			var_20_0.foodTfAnimator.speed = var_0_23
			var_20_0.next_time = arg_20_1.next_time

			if not var_20_0.next_time then
				var_20_0.isPlayer = true
			else
				math = var_6
				var_20_0.nextTime = var_6.random(0, arg_20_1.next_time[2] - arg_20_1.next_time[1]) + arg_20_1.next_time[1] + var_0_12
			end

			var_20_0.foodState = 0
			var_20_0.stepIndex = 0
			GetComponent = var_6
			findTF = var_20_9

			local var_20_10 = var_20_9(var_20_1, "anim")

			typeof = var_9
			DftAniEvent = var_11

			local var_20_11 = var_6(var_20_10, var_9(var_11))

			var_6.SetStartEvent(var_20_11, function()
				var_20_0.foodState = var_20_0.foodState + 1

				local var_21_0 = var_20_0.foodTfAnimator

				var_0.SetInteger(var_21_0, "state", var_20_0.foodState)

				return
			end)
			var_6:SetTriggerEvent(function()
				return
			end)
			var_6:SetEndEvent(function()
				return
			end)

			return var_20_0
		end,
		stop = function(arg_24_0)
			if arg_24_0.player then
				arg_24_0.player.tfAnimator.speed = 0
			end

			if arg_24_0.chars and #arg_24_0.chars > 0 then
				for iter_24_0 = 1, #arg_24_0.chars do
					arg_24_0.chars[iter_24_0].tfAnimator.speed = 0
				end
			end

			return
		end,
		resume = function(arg_25_0)
			if arg_25_0.player then
				arg_25_0.player.tfAnimator.speed = arg_25_0.animateSpeed
			end

			if arg_25_0.chars and #arg_25_0.chars > 0 then
				for iter_25_0 = 1, #arg_25_0.chars do
					arg_25_0.chars[iter_25_0].tfAnimator.speed = var_0_23
				end
			end

			return
		end,
		onTimeOut = function(arg_26_0)
			local var_26_0 = arg_26_0.player
			local var_26_1

			if not arg_26_0.player.stepIndex then
				var_26_1 = 0
			end

			for iter_26_0 = 1, #arg_26_0.chars do
				if var_26_1 < arg_26_0.chars[iter_26_0].stepIndex then
					var_26_0 = arg_26_0.chars[iter_26_0]
					var_26_1 = arg_26_0.chars[iter_26_0].stepIndex
				end
			end

			arg_26_0:setWinChar(var_26_0)

			return
		end,
		clear = function(arg_27_0)
			if arg_27_0.player then
				destroy = var_1

				var_1(arg_27_0.player.tf)

				destroy = var_1

				var_1(arg_27_0.player.foodTf)
			end

			if arg_27_0.chars then
				for iter_27_0 = 1, #arg_27_0.chars do
					destroy = var_2_10005

					var_2_10005(arg_27_0.chars[iter_27_0].tf)

					destroy = var_2_10005

					var_2_10005(arg_27_0.chars[iter_27_0].foodTf)
				end
			end

			return
		end
	}

	var_4.ctor(var_12_0)

	return var_4
end

function var_0_1.getUIName(arg_28_0)
	return "EatFoodGameUI"
end

function var_0_1.getBGM(arg_29_0)
	return var_0_2
end

function var_0_1.didEnter(arg_30_0)
	arg_30_0:initEvent()
	arg_30_0:initData()
	arg_30_0:initUI()
	arg_30_0:initGameUI()
	arg_30_0:readyStart()

	return
end

function var_0_1.OnGetAwardDone(arg_31_0)
	arg_31_0:CheckGet()

	return
end

function var_0_1.OnSendMiniGameOPDone(arg_32_0, arg_32_1)
	return
end

function var_0_1.initEvent(arg_33_0)
	arg_33_0:bind(var_0_33, function(arg_34_0, arg_34_1, arg_34_2)
		local var_34_0 = arg_33_0

		var_3.setGameOver(var_34_0, arg_34_1)

		return
	end)
	arg_33_0:bind(var_0_18, function(arg_35_0, arg_35_1, arg_35_2)
		if arg_35_1.score and arg_35_1.score ~= 0 then
			local var_35_0 = arg_33_0

			var_3.addScore(var_35_0, arg_35_1.score)
		end

		if arg_33_0.charController then
			local var_35_1 = arg_33_0.charController

			var_3.onPlayerTouch(var_35_1, arg_35_1)
		end

		return
	end)

	return
end

function var_0_1.initData(arg_36_0)
	pg = var_1_10001
	arg_36_0.dropData = var_1_10001.mini_game[arg_36_0:GetMGData().id].simple_config_data.drop
	Application = var_1

	local var_36_0

	if not var_1.targetFrameRate then
		var_36_0 = 60
	end

	if 60 < var_36_0 then
		var_36_0 = 60
	end

	Timer = var_2
	arg_36_0.timer = var_2.New(function()
		local var_37_0 = arg_36_0

		var_0.onTimer(var_37_0)

		return
	end, 1 / var_36_0, -1)

	return
end

function var_0_1.initUI(arg_38_0)
	findTF = var_1_10001
	arg_38_0.backSceneTf = var_1_10001(arg_38_0._tf, "scene_container/scene_background")
	findTF = var_1
	arg_38_0.sceneTf = var_1(arg_38_0._tf, "scene_container/scene")
	findTF = var_1
	arg_38_0.bgTf = var_1(arg_38_0._tf, "bg")
	findTF = var_1
	arg_38_0.clickMask = var_1(arg_38_0._tf, "clickMask")
	findTF = var_1
	arg_38_0.countUI = var_1(arg_38_0._tf, "pop/CountUI")
	GetComponent = var_1
	findTF = var_3

	local var_38_0 = var_3(arg_38_0.countUI, "count")

	typeof = var_4
	Animator = var_6
	arg_38_0.countAnimator = var_1(var_38_0, var_4(var_6))
	GetOrAddComponent = var_1
	findTF = var_38_0

	local var_38_1 = var_38_0(arg_38_0.countUI, "count")

	typeof = var_4
	DftAniEvent = var_6
	arg_38_0.countDft = var_1(var_38_1, var_4(var_6))

	local var_38_2 = arg_38_0.countDft

	var_1.SetTriggerEvent(var_38_2, function()
		return
	end)

	local var_38_3 = arg_38_0.countDft

	var_1.SetEndEvent(var_38_3, function()
		setActive = var_2_10000

		var_2_10000(arg_38_0.countUI, false)

		arg_38_0.readyStart = false

		return
	end)

	SetActive = var_1

	var_1(arg_38_0.countUI, false)

	findTF = var_1
	arg_38_0.leaveUI = var_1(arg_38_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_38_4 = arg_38_0

	findTF = var_4

	local var_38_5 = var_4(arg_38_0.leaveUI, "ad/btnOk")

	local function var_38_6()
		local var_41_0 = arg_38_0

		var_0.resumeGame(var_41_0)

		if arg_38_0.charController then
			local var_41_1 = arg_38_0.charController

			var_0.stop(var_41_1)
		end

		local var_41_2 = arg_38_0

		var_0.onGameOver(var_41_2, 0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_38_4, var_38_5, var_38_6, var_6)

	onButton = var_1

	local var_38_7 = arg_38_0

	findTF = var_38_5

	local var_38_8 = var_38_5(arg_38_0.leaveUI, "ad/btnCancel")

	local function var_38_9()
		local var_42_0 = arg_38_0

		var_0.resumeGame(var_42_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_38_7, var_38_8, var_38_9, var_6)

	SetActive = var_1

	var_1(arg_38_0.leaveUI, false)

	findTF = var_1
	arg_38_0.pauseUI = var_1(arg_38_0._tf, "pop/pauseUI")
	onButton = var_1

	local var_38_10 = arg_38_0

	findTF = var_4

	local var_38_11 = var_4(arg_38_0.pauseUI, "ad/btnOk")

	local function var_38_12()
		setActive = var_2_10000

		var_2_10000(arg_38_0.pauseUI, false)

		local var_43_0 = arg_38_0

		var_0.resumeGame(var_43_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_38_10, var_38_11, var_38_12, var_6)

	SetActive = var_1

	var_1(arg_38_0.pauseUI, false)

	findTF = var_1
	arg_38_0.resultUI = var_1(arg_38_0._tf, "pop/resultUI")
	SetActive = var_1

	var_1(arg_38_0.resultUI, false)

	findTF = var_1
	arg_38_0.settlementUI = var_1(arg_38_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_38_13 = arg_38_0

	findTF = var_4

	local var_38_14 = var_4(arg_38_0.settlementUI, "ad/btnOver")

	local function var_38_15()
		setActive = var_2_10000

		var_2_10000(arg_38_0.settlementUI, false)

		local var_44_0 = arg_38_0

		var_0.closeView(var_44_0)

		return
	end

	SFX_CANCEL = var_6

	var_1(var_38_13, var_38_14, var_38_15, var_6)

	SetActive = var_1

	var_1(arg_38_0.settlementUI, false)

	if not arg_38_0.handle then
		UpdateBeat = var_1
		arg_38_0.handle = var_1:CreateListener(arg_38_0.Update, arg_38_0)
	end

	UpdateBeat = var_1

	var_1:AddListener(arg_38_0.handle)

	return
end

function var_0_1.initGameUI(arg_45_0)
	findTF = var_1_10001
	arg_45_0.gameUI = var_1_10001(arg_45_0._tf, "ui/gameUI")
	onButton = var_1

	local var_45_0 = arg_45_0

	findTF = var_4

	var_1(var_45_0, var_4(arg_45_0.gameUI, "topRight/btnStop"), function()
		local var_46_0 = arg_45_0

		var_0.stopGame(var_46_0)

		setActive = var_0

		var_0(arg_45_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_45_1 = arg_45_0

	findTF = var_4

	var_1(var_45_1, var_4(arg_45_0.gameUI, "btnLeave"), function()
		local var_47_0 = arg_45_0

		var_0.stopGame(var_47_0)

		setActive = var_0

		var_0(arg_45_0.leaveUI, true)

		return
	end)

	GetOrAddComponent = var_1
	arg_45_0.dragDelegate = var_1(arg_45_0.sceneTf, "EventTriggerListener")
	arg_45_0.dragDelegate.enabled = true

	local var_45_2 = arg_45_0.dragDelegate

	var_1.AddPointDownFunc(var_45_2, function(arg_48_0, arg_48_1)
		if arg_45_0.sliderController then
			local var_48_0 = arg_45_0.sliderController

			var_2.touch(var_48_0, true)
		end

		return
	end)

	findTF = var_1
	arg_45_0.gameTimeS = var_1(arg_45_0.gameUI, "top/time/s")
	findTF = var_1
	arg_45_0.scoreTf = var_1(arg_45_0.gameUI, "top/score")
	findTF = var_1
	arg_45_0.sceneScoreTf = var_1(arg_45_0.sceneTf, "score")

	local var_45_3 = var_0_34

	findTF = var_3
	arg_45_0.sliderController = var_45_3(var_3(arg_45_0.sceneTf, "collider"), arg_45_0)

	local var_45_4 = var_0_35

	findTF = var_3

	local var_45_5 = var_3(arg_45_0.sceneTf, "tpls")

	findTF = var_4

	local var_45_6 = var_4(arg_45_0.sceneTf, "food")

	findTF = var_5
	arg_45_0.charController = var_45_4(var_45_5, var_45_6, var_5(arg_45_0.sceneTf, "container"), arg_45_0)

	return
end

function var_0_1.Update(arg_49_0)
	arg_49_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_50_0)
	if arg_50_0.gameStop or arg_50_0.settlementFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.updateMenuUI(arg_51_0)
	return
end

function var_0_1.CheckGet(arg_52_0)
	if arg_52_0:getUltimate() == 0 then
		local var_52_0 = arg_52_0

		if arg_52_0.getGameTotalTime(var_52_0) > arg_52_0:getGameUsedTimes() then
			return
		end

		pg = var_52_0

		local var_52_1 = var_52_0.m02
		local var_52_2 = var_3.sendNotification

		GAME = var_1_10006

		local var_52_3 = var_1_10006.SEND_MINI_GAME_OP
		local var_52_4 = {
			hubid = arg_52_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_8
		var_52_4.cmd = var_8.CMD_ULTIMATE
		var_52_4.args1 = {}

		var_52_2(var_52_1, var_52_3, var_52_4)
	end

	return
end

function var_0_1.openMenuUI(arg_53_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_53_0._tf, "scene_container"), false)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_53_0.bgTf, "on"), true)

	setActive = var_1_10001

	var_1_10001(arg_53_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_53_0.menuUI, true)

	return
end

function var_0_1.clearUI(arg_54_0)
	setActive = var_1_10001

	var_1_10001(arg_54_0.sceneTf, false)

	setActive = var_1_10001

	var_1_10001(arg_54_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_54_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_54_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_54_0.gameUI, false)

	return
end

function var_0_1.readyStart(arg_55_0)
	setActive = var_1_10001

	var_1_10001(arg_55_0.countUI, true)

	local var_55_0 = arg_55_0.countAnimator

	var_1.Play(var_55_0, "count")

	pg = var_1

	local var_55_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_55_1, var_0_3)

	arg_55_0.readyStart = true

	arg_55_0:gameStart()

	return
end

function var_0_1.getGameTimes(arg_56_0)
	return arg_56_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_57_0)
	return arg_57_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_58_0)
	return arg_58_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_59_0)
	local var_59_0 = arg_59_0:GetMGHubData()

	return (var_1.getConfig(var_59_0, "reward_need"))
end

function var_0_1.gameStart(arg_60_0)
	setActive = var_1_10001
	findTF = var_1_10003

	var_1_10001(var_1_10003(arg_60_0._tf, "scene_container"), true)

	setActive = var_1_10001
	findTF = var_3

	var_1_10001(var_3(arg_60_0.bgTf, "on"), false)

	setActive = var_1_10001

	var_1_10001(arg_60_0.gameUI, true)

	arg_60_0.gameStartFlag = true
	arg_60_0.scoreNum = 0
	arg_60_0.playerPosIndex = 2
	arg_60_0.gameStepTime = 0
	arg_60_0.gameTime = var_0_8

	if arg_60_0.sliderController then
		local var_60_0 = arg_60_0.sliderController

		var_1.start(var_60_0)
	end

	if arg_60_0.charController then
		local var_60_1 = arg_60_0.charController

		var_1.start(var_60_1)
	end

	arg_60_0:updateGameUI()
	arg_60_0:timerStart()

	return
end

function var_0_1.transformColor(arg_61_0, arg_61_1)
	tonumber = var_1_10002
	string = var_1_10004

	local var_61_0 = var_1_10002(var_1_10004.sub(arg_61_1, 1, 2), 16)

	tonumber = var_1_10003
	string = var_5

	local var_61_1 = var_1_10003(var_5.sub(arg_61_1, 3, 4), 16)

	tonumber = var_4
	string = var_6

	local var_61_2 = var_4(var_6.sub(arg_61_1, 5, 6), 16)

	Color = var_5

	return var_5.New(var_61_0 / 255, var_61_1 / 255, var_61_2 / 255)
end

function var_0_1.addScore(arg_62_0, arg_62_1, arg_62_2)
	setActive = var_1_10003

	var_1_10003(arg_62_0.sceneScoreTf, false)

	if arg_62_1 then
		arg_62_0.scoreNum = arg_62_0.scoreNum + arg_62_1

		local var_62_0

		if not (0 <= arg_62_1) or not ("+" .. arg_62_1) then
			tostring = var_62_0
			var_62_0 = var_62_0(arg_62_1)
		end

		setText = var_1_10004
		findTF = var_6

		var_1_10004(var_6(arg_62_0.sceneScoreTf, "img"), var_62_0)

		setActive = var_1_10004

		var_1_10004(arg_62_0.sceneScoreTf, true)
	end

	arg_62_0:updateGameUI()

	return
end

function var_0_1.onTimer(arg_63_0)
	arg_63_0:gameStep()

	return
end

function var_0_1.gameStep(arg_64_0)
	if not arg_64_0.readyStart then
		local var_64_0 = arg_64_0.gameTime

		Time = var_1_10002
		arg_64_0.gameTime = var_64_0 - var_1_10002.deltaTime

		local var_64_1 = arg_64_0.gameStepTime

		Time = var_2
		arg_64_0.gameStepTime = var_64_1 + var_2.deltaTime
	end

	if arg_64_0.gameTime < 0 then
		arg_64_0.gameTime = 0
	end

	arg_64_0:updateGameUI()

	if arg_64_0.sliderController then
		local var_64_2 = arg_64_0.sliderController

		var_1.step(var_64_2)
	end

	if arg_64_0.charController then
		local var_64_3 = arg_64_0.charController

		var_1.step(var_64_3)
	end

	if arg_64_0.gameTime <= 0 then
		if arg_64_0.charController then
			local var_64_4 = arg_64_0.charController

			var_1.onTimeOut(var_64_4)
		end

		return
	end

	return
end

function var_0_1.timerStart(arg_65_0)
	if not arg_65_0.timer.running then
		local var_65_0 = arg_65_0.timer

		var_1.Start(var_65_0)
	end

	return
end

function var_0_1.timerStop(arg_66_0)
	if arg_66_0.timer.running then
		local var_66_0 = arg_66_0.timer

		var_1.Stop(var_66_0)
	end

	return
end

function var_0_1.updateGameUI(arg_67_0)
	setText = var_1_10001

	var_1_10001(arg_67_0.scoreTf, arg_67_0.scoreNum)

	setText = var_1_10001

	local var_67_0 = arg_67_0.gameTimeS

	math = var_4

	var_1_10001(var_67_0, var_4.ceil(arg_67_0.gameTime))

	return
end

function var_0_1.setGameOver(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0

	arg_68_0.onGameOver(var_68_0, 3.5)

	local var_68_1

	Application = var_1_10003

	local var_68_2

	if not var_1_10003.targetFrameRate then
		var_68_2 = 60
	end

	seriesAsync = var_68_0

	var_68_0({
		function(arg_69_0)
			local var_69_0 = 0

			Timer = var_2_10002
			var_68_1 = var_2_10002.New(function()
				var_69_0 = var_69_0 + 15

				if var_69_0 > 1400 then
					arg_69_0()
				end

				return
			end, 1 / var_68_2, -1)

			local var_69_1 = var_68_1

			var_2.Start(var_69_1)

			return
		end,
		function(arg_71_0)
			if var_68_1 then
				var_2_10003 = var_68_1

				var_1.Stop(var_2_10003)

				var_68_1 = nil
			end

			if arg_68_1 then
				pg = var_1
				var_2_10003 = var_1.CriMgr.GetInstance()

				var_1.PlaySoundEffect_V3(var_2_10003, var_0_4)
			else
				pg = var_1
				var_2_10003 = var_1.CriMgr.GetInstance()

				var_1.PlaySoundEffect_V3(var_2_10003, var_0_5)
			end

			setActive = var_1
			findTF = var_2_10003

			var_1(var_2_10003(arg_68_0.resultUI, "ad/victory"), arg_68_1)

			setActive = var_1
			findTF = var_3

			var_1(var_3(arg_68_0.resultUI, "ad/defeat"), not arg_68_1)

			setActive = var_1

			var_1(arg_68_0.resultUI, true)

			GetComponent = var_1
			findTF = var_3

			local var_71_0 = var_3(arg_68_0.resultUI, "ad")

			typeof = var_4
			Animator = var_6

			local var_71_1 = var_1(var_71_0, var_4(var_6))

			var_1.Play(var_71_1, "settlement", -1, 0)

			local var_71_2 = 0

			Timer = var_71_0
			var_68_1 = var_71_0.New(function()
				var_71_2 = var_71_2 + 15

				if var_71_2 > 1400 then
					setActive = var_0

					var_0(arg_68_0.resultUI, false)
					arg_71_0()
				end

				return
			end, 1 / var_68_2, -1)

			local var_71_3 = var_68_1

			var_3.Start(var_71_3)

			return
		end
	}, function()
		if var_68_1 then
			local var_73_0 = var_68_1

			var_0.Stop(var_73_0)

			var_68_1 = nil
		end

		return
	end)

	return
end

function var_0_1.onGameOver(arg_74_0, arg_74_1)
	if arg_74_0.settlementFlag then
		return
	end

	arg_74_0:timerStop()

	arg_74_0.settlementFlag = true
	setActive = var_2

	var_2(arg_74_0.clickMask, true)

	LeanTween = var_2

	local var_74_0 = var_2.delayedCall

	go = var_4

	local var_74_1 = var_4(arg_74_0._tf)
	local var_74_2 = arg_74_1

	System = var_6

	var_74_0(var_74_1, var_74_2, var_6.Action(function()
		arg_74_0.settlementFlag = false

		local var_75_0 = arg_74_0

		var_75_0.gameStartFlag = false
		setActive = var_75_0

		var_75_0(arg_74_0.clickMask, false)

		local var_75_1 = arg_74_0

		var_0.showSettlement(var_75_1)

		return
	end))

	return
end

function var_0_1.showSettlement(arg_76_0)
	setActive = var_1_10001

	var_1_10001(arg_76_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_3

	local var_76_0 = var_3(arg_76_0.settlementUI, "ad")

	typeof = var_4
	Animator = var_6

	local var_76_1 = var_1_10001(var_76_0, var_4(var_6))

	var_1.Play(var_76_1, "settlement", -1, 0)

	local var_76_2 = arg_76_0:GetMGData()
	local var_76_3 = var_2.GetRuntimeData(var_76_2, "elements")
	local var_76_4 = arg_76_0.scoreNum

	if var_76_3 then
		local var_76_5 = #var_76_3
		local var_76_6

		if not (0 < var_76_5) or not var_76_3[1] then
			var_76_6 = 0
		end

		setActive = var_5
		findTF = var_7

		var_5(var_7(arg_76_0.settlementUI, "ad/new"), var_76_6 < var_76_4)

		if var_76_6 <= var_76_4 then
			var_76_6 = var_76_4

			arg_76_0:StoreDataToServer({
				var_76_6
			})
		end

		findTF = var_5

		local var_76_7 = var_5(arg_76_0.settlementUI, "ad/highText")

		findTF = var_6

		local var_76_8 = var_6(arg_76_0.settlementUI, "ad/currentText")

		setText = var_7

		var_7(var_76_7, var_76_6)

		setText = var_7

		var_7(var_76_8, var_76_4)

		if arg_76_0:getGameTimes() and arg_76_0:getGameTimes() > 0 then
			arg_76_0.sendSuccessFlag = true

			arg_76_0:SendSuccess(0)

			local var_76_9 = arg_76_0:getGameTotalTime()
			local var_76_10 = arg_76_0:getGameUsedTimes()
		end

		return
	end
end

function var_0_1.resumeGame(arg_77_0)
	arg_77_0.gameStop = false
	setActive = var_1

	var_1(arg_77_0.leaveUI, false)

	if arg_77_0.charController then
		local var_77_0 = arg_77_0.charController

		var_1.resume(var_77_0)
	end

	arg_77_0:timerStart()

	return
end

function var_0_1.stopGame(arg_78_0)
	arg_78_0.gameStop = true

	if arg_78_0.charController then
		local var_78_0 = arg_78_0.charController

		var_1.stop(var_78_0)
	end

	arg_78_0:timerStop()

	return
end

function var_0_1.onBackPressed(arg_79_0)
	if not arg_79_0.gameStartFlag then
		arg_79_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_79_0.settlementFlag then
			return
		end

		isActive = var_1

		if var_1(arg_79_0.pauseUI) then
			setActive = var_1

			var_1(arg_79_0.pauseUI, false)
		end

		arg_79_0:stopGame()

		setActive = var_1

		var_1(arg_79_0.leaveUI, true)
	end

	return
end

function var_0_1.willExit(arg_80_0)
	if arg_80_0.handle then
		UpdateBeat = var_1
		var_1_10003 = var_1

		var_1.RemoveListener(var_1_10003, arg_80_0.handle)
	end

	if arg_80_0._tf then
		LeanTween = var_1

		local var_80_0 = var_1.isTweening

		go = var_1_10003

		if var_80_0(var_1_10003(arg_80_0._tf)) then
			LeanTween = var_1

			local var_80_1 = var_1.cancel

			go = var_3

			var_80_1(var_3(arg_80_0._tf))
		end
	end

	if arg_80_0.timer and arg_80_0.timer.running then
		local var_80_2 = arg_80_0.timer

		var_1.Stop(var_80_2)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_80_0.timer = nil

	return
end

return var_0_1
