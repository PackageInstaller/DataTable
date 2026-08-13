class = var_0_10000

local var_0_0 = "CurlingGameView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = "event:/ui/ddldaoshu2"
local var_0_3 = "event:/ui/taosheng"
local var_0_4 = "event:/ui/minigame_hitcake"
local var_0_5 = "event:/ui/zhengque"
local var_0_6 = "event:/ui/shibai"
local var_0_7 = 1
local var_0_8 = 2
local var_0_9 = 3
local var_0_10 = {
	20,
	40,
	60
}
local var_0_11 = 4

Vector2 = var_0_10011

local var_0_12 = var_0_10011(-720, 0)
local var_0_13 = {
	-250,
	250
}

Vector2 = var_13

local var_0_14 = var_13(-250, -42)
local var_0_15 = {
	1,
	10,
	30
}
local var_0_16 = 0.2
local var_0_17 = false
local var_0_18 = {
	cube = 0.2,
	miner = 0.2,
	walker = 0.1,
	oil = 0.2,
	wall = 0
}
local var_0_19 = {
	cube = 2,
	miner = 2,
	walker = 2,
	oil = 2,
	wall = 0
}
local var_0_20 = {
	0.5,
	5,
	10
}
local var_0_21 = {
	0.5,
	5,
	10
}

Vector2 = var_0_10021

local var_0_22 = var_0_10021(400, -600)

Vector2 = var_22

local var_0_23 = var_22(400, 500)
local var_0_24 = 1
local var_0_25 = 2
local var_0_26 = 3
local var_0_27 = 4

Vector2 = var_0_10027

local var_0_28 = var_0_10027(617, -108)
local var_0_29 = 0.7
local var_0_30 = {
	111,
	222,
	333
}
local var_0_31 = {
	3000,
	2000,
	1000
}
local var_0_32 = 1
local var_0_33 = 2
local var_0_34 = 3
local var_0_35 = 4
local var_0_36 = {
	cube = 300,
	miner = 300,
	walker = 900,
	oil = 300,
	wall = 100
}
local var_0_37 = 1
local var_0_38 = {
	oil = {
		{
			appear = 0.8,
			num = 1
		},
		{
			appear = 0.1,
			num = 1
		}
	},
	cube = {
		{
			appear = 0.8,
			num = 1
		},
		{
			appear = 0.1,
			num = 1
		}
	},
	miner = {
		{
			appear = 1,
			num = 1
		},
		{
			appear = 0.1,
			num = 1
		}
	},
	walker = {
		appear = 1,
		path = {
			var_0_24,
			var_0_25,
			var_0_26,
			var_0_27
		}
	}
}
local var_0_39 = {
	miner = 3.5,
	cube = 3.5,
	walker = 4.5,
	oil = 3.5
}
local var_0_40 = true
local var_0_41 = "event_push"
local var_0_42 = "event_speed"
local var_0_43 = "event_hit"
local var_0_44 = "event_result"
local var_0_45 = "event_next"
local var_0_46 = "event_game_pause"
local var_0_47 = "event_game_resume"
local var_0_48 = "event_add_score"

local function var_0_49(arg_1_0, arg_1_1)
	local var_1_0 = {
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			findTF = var_1
			arg_2_0.powerTF = var_1(arg_2_0._tf, "power")
			GetComponent = var_1

			local var_2_0 = arg_2_0.powerTF

			typeof = var_3
			Slider = var_2_10004
			arg_2_0.powerSlider = var_1(var_2_0, var_3(var_2_10004))

			arg_2_0:InitPowerSlider()

			GetComponent = var_1

			local var_2_1 = arg_2_0._tf

			typeof = var_3
			Animator = var_2_10004
			arg_2_0.animator = var_1(var_2_1, var_3(var_2_10004))
			GetComponent = var_1

			local var_2_2 = arg_2_0._tf

			typeof = var_3
			DftAniEvent = var_2_10004
			arg_2_0.aniDft = var_1(var_2_2, var_3(var_2_10004))

			local var_2_3 = arg_2_0.aniDft

			var_1.SetTriggerEvent(var_2_3, function()
				local var_3_0 = arg_2_0

				var_0.Push(var_3_0)

				return
			end)

			GetOrAddComponent = var_1
			arg_2_0.dragTrigger = var_1(arg_2_0._tf, "EventTriggerListener")

			local var_2_4 = arg_2_0.dragTrigger

			var_1.AddPointDownFunc(var_2_4, function(arg_4_0, arg_4_1)
				if not arg_2_0.canClick then
					return
				end

				arg_2_0.canClick = false
				arg_2_0.charging = true
				arg_2_0.originScreenY = arg_4_1.position.y
				arg_2_0.originY = arg_2_0._tf.anchoredPosition.y

				local var_4_0 = arg_2_0

				var_2.Charge(var_4_0)

				return
			end)

			local var_2_5 = arg_2_0.dragTrigger

			var_1.AddDragFunc(var_2_5, function(arg_5_0, arg_5_1)
				if not arg_2_0.charging then
					return
				end

				local var_5_0 = arg_5_1.position.y - arg_2_0.originScreenY + arg_2_0.originY >= var_0_13[1] and var_5_0 or var_0_13[1]

				var_5_0 = var_5_0 <= var_0_13[2] and var_5_0 or var_0_13[2]
				setLocalPosition = var_4

				local var_5_1 = arg_2_0._tf

				Vector2 = var_3_10006

				var_4(var_5_1, var_3_10006(arg_2_0._tf.anchoredPosition.x, var_5_0))

				return
			end)

			local var_2_6 = arg_2_0.dragTrigger

			var_1.AddPointUpFunc(var_2_6, function(arg_6_0, arg_6_1)
				if not arg_2_0.charging then
					return
				end

				arg_2_0.charging = false

				local var_6_0 = arg_2_0.animator

				var_2.SetInteger(var_6_0, "Throw", arg_2_0.phase)

				local var_6_1 = arg_2_0.animator

				var_2.SetInteger(var_6_1, "Charge", 0)

				return
			end)

			local var_2_7 = arg_2_0._event

			var_1.bind(var_2_7, var_0_44, function(arg_7_0, arg_7_1, arg_7_2)
				local var_7_0 = arg_2_0.animator

				var_3.SetInteger(var_7_0, "Result", arg_7_1.result)

				return
			end)

			local var_2_8 = arg_2_0._event

			var_1.bind(var_2_8, var_0_45, function(arg_8_0, arg_8_1, arg_8_2)
				local var_8_0 = arg_2_0

				var_3.Reset(var_8_0)

				local var_8_1 = arg_2_0

				var_3.Start(var_8_1)

				return
			end)
			arg_2_0:Reset()

			return
		end,
		Start = function(arg_9_0)
			arg_9_0.canClick = true

			return
		end,
		Reset = function(arg_10_0)
			setActive = var_2_10001

			var_2_10001(arg_10_0.powerTF, false)

			setLocalPosition = var_2_10001

			var_2_10001(arg_10_0._tf, var_0_12)

			local var_10_0 = arg_10_0.animator

			var_1.SetInteger(var_10_0, "Charge", 0)

			local var_10_1 = arg_10_0.animator

			var_1.SetInteger(var_10_1, "Throw", 0)

			local var_10_2 = arg_10_0.animator

			var_1.SetInteger(var_10_2, "Result", 0)

			local var_10_3 = arg_10_0.animator

			var_1.Play(var_10_3, "WaitA")

			arg_10_0.power = 0
			arg_10_0.phase = 0
			arg_10_0.charging = false
			arg_10_0.canClick = false
			arg_10_0.powerSlider.value = 0

			return
		end,
		InitPowerSlider = function(arg_11_0)
			local var_11_0 = 24
			local var_11_1 = 162
			local var_11_2 = var_0_10[1] / var_0_10[3] * var_11_1

			findTF = var_4

			local var_11_3 = var_4(arg_11_0.powerTF, "progress/green")

			Vector2 = var_5
			var_11_3.sizeDelta = var_5(var_11_2, var_11_0)

			local var_11_4 = (var_0_10[2] - var_0_10[1]) / var_0_10[3] * var_11_1

			findTF = var_5

			local var_11_5 = var_5(arg_11_0.powerTF, "progress/green/yellow")

			Vector2 = var_6
			var_11_5.sizeDelta = var_6(var_11_4, var_11_0)

			local var_11_6 = (var_0_10[3] - var_0_10[2]) / var_0_10[3] * var_11_1

			findTF = var_6

			local var_11_7 = var_6(arg_11_0.powerTF, "progress/green/yellow/red")

			Vector2 = var_7
			var_11_7.sizeDelta = var_7(var_11_6, var_11_0)

			return
		end,
		Charge = function(arg_12_0)
			setActive = var_2_10001

			var_2_10001(arg_12_0.powerTF, true)

			setActive = var_2_10001
			findTF = var_2

			var_2_10001(var_2(arg_12_0.powerTF, "binghu_huoyan"), false)

			arg_12_0.phase = var_0_7

			local var_12_0 = arg_12_0.animator

			var_1.SetInteger(var_12_0, "Charge", arg_12_0.phase)

			LeanTween = var_1

			local var_12_1 = var_1.value

			go = var_12_0

			local var_12_2 = var_12_1(var_12_0(arg_12_0._tf), arg_12_0.power, var_0_10[3], var_0_11)
			local var_12_3 = var_1.setOnUpdate

			System = var_3

			var_12_3(var_12_2, var_3.Action_float(function(arg_13_0)
				arg_12_0.power = arg_13_0
				arg_12_0.powerSlider.value = arg_12_0.power / var_0_10[3]

				local var_13_1

				if arg_12_0.phase == var_0_7 then
					local var_13_0 = arg_12_0.power

					if var_0_10[1] <= var_13_0 then
						arg_12_0.phase = var_0_8
						var_13_1 = arg_12_0.animator

						var_1.SetInteger(var_13_1, "Charge", arg_12_0.phase)

						goto label_13_0
					end
				end

				if arg_12_0.phase == var_0_8 then
					local var_13_2 = arg_12_0.power

					if var_0_10[2] <= var_13_2 then
						arg_12_0.phase = var_0_9
						var_13_1 = arg_12_0.animator

						var_1.SetInteger(var_13_1, "Charge", arg_12_0.phase)

						setActive = var_1
						findTF = var_13_1

						var_1(var_13_1(arg_12_0.powerTF, "binghu_huoyan"), true)
					end
				end

				::label_13_0::

				if not arg_12_0.charging then
					LeanTween = var_1

					local var_13_3 = var_1.cancel

					go = var_13_1

					var_13_3(var_13_1(arg_12_0._tf))
				end

				return
			end))

			return
		end,
		Push = function(arg_14_0)
			local var_14_0 = arg_14_0._event

			var_1.emit(var_14_0, var_0_41, {
				power = arg_14_0.power
			})

			setActive = var_1

			var_1(arg_14_0.powerTF, false)

			return
		end
	}

	var_2.Ctor(var_1_0)

	return var_2
end

local function var_0_50(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {
		Ctor = function(arg_16_0)
			arg_16_0.tpls = arg_15_0
			arg_16_0._event = arg_15_2
			arg_16_0.player = arg_15_1
			arg_16_0.scene = arg_16_0.player.parent

			local var_16_0 = arg_16_0._event

			var_1.bind(var_16_0, var_0_41, function(arg_17_0, arg_17_1, arg_17_2)
				if arg_16_0.isPush then
					return
				end

				local var_17_0 = arg_16_0

				var_3.Push(var_17_0, arg_17_1.power)

				return
			end)

			local var_16_1 = arg_16_0._event

			var_1.bind(var_16_1, var_0_45, function(arg_18_0, arg_18_1, arg_18_2)
				local var_18_0 = arg_16_0

				var_3.Reset(var_18_0)

				local var_18_1 = arg_16_0

				var_3.Start(var_18_1)

				return
			end)

			local var_16_2 = arg_16_0._event

			var_1.bind(var_16_2, var_0_46, function(arg_19_0, arg_19_1, arg_19_2)
				local var_19_0 = arg_16_0

				var_3.Pause(var_19_0)

				return
			end)

			local var_16_3 = arg_16_0._event

			var_1.bind(var_16_3, var_0_47, function(arg_20_0, arg_20_1, arg_20_2)
				local var_20_0 = arg_16_0

				var_3.Resume(var_20_0)

				return
			end)
			arg_16_0:Reset()

			return
		end,
		Start = function(arg_21_0)
			return
		end,
		RandomRole = function(arg_22_0)
			if arg_22_0._tf then
				local var_22_0 = arg_22_0._tf

				var_1.SetParent(var_22_0, arg_22_0.tpls, false)

				setActive = var_1

				var_1(arg_22_0._tf, false)
			end

			math = var_1

			local var_22_1 = var_1.random(1, 4)
			local var_22_2 = arg_22_0.tpls

			arg_22_0._tf = var_2.GetChild(var_22_2, var_22_1 - 1)
			setActive = var_2

			var_2(arg_22_0._tf, true)

			findTF = var_2
			arg_22_0.speedTF = var_2(arg_22_0._tf, "speed")
			setActive = var_2

			var_2(arg_22_0.speedTF, var_0_17)

			GetComponent = var_2

			local var_22_3 = arg_22_0._tf

			typeof = var_4
			Animator = var_2_10005
			arg_22_0.animator = var_2(var_22_3, var_4(var_2_10005))
			GetComponent = var_2
			arg_22_0.rigbody = var_2(arg_22_0._tf, "Rigidbody2D")

			local var_22_4 = arg_22_0.rigbody

			Vector2 = var_3
			var_22_4.velocity = var_3.zero
			GetComponent = var_22_4
			arg_22_0.phyItem = var_22_4(arg_22_0._tf, "Physics2DItem")

			local var_22_5 = arg_22_0.phyItem.CollisionEnter

			var_2.RemoveAllListeners(var_22_5)

			local var_22_6 = arg_22_0.phyItem.CollisionEnter

			var_2.AddListener(var_22_6, function(arg_23_0)
				local var_23_0 = arg_22_0

				var_1.OnCollision(var_23_0, arg_23_0)

				return
			end)

			return
		end,
		Reset = function(arg_24_0)
			local var_24_0 = arg_24_0

			arg_24_0.RandomRole(var_24_0)

			local var_24_1 = arg_24_0.rigbody

			Vector2 = var_24_0
			var_24_1.velocity = var_24_0.zero

			local var_24_2 = arg_24_0._tf
			local var_24_3 = var_1.SetParent

			findTF = var_2_10003

			var_24_3(var_24_2, var_2_10003(arg_24_0.player, "chargePos"), false)

			setText = var_24_3

			var_24_3(arg_24_0.speedTF, 0)

			setLocalPosition = var_24_3

			local var_24_4 = arg_24_0._tf

			Vector2 = var_3

			var_24_3(var_24_4, var_3.zero)

			setLocalScale = var_24_3

			local var_24_5 = arg_24_0._tf

			Vector2 = var_3

			var_24_3(var_24_5, var_3.one)

			local var_24_6 = arg_24_0.animator

			var_1.Play(var_24_6, "Neutral")

			local var_24_7 = arg_24_0.animator

			var_1.SetBool(var_24_7, "Stop", false)

			local var_24_8 = arg_24_0.animator

			var_1.SetInteger(var_24_8, "Result", 0)

			local var_24_9 = arg_24_0.animator

			var_1.SetInteger(var_24_9, "SpeedPhase", 0)

			arg_24_0.isPush = false
			arg_24_0.isStop = true
			arg_24_0.phase = 0

			return
		end,
		Step = function(arg_25_0)
			if var_0_17 then
				setText = var_1

				local var_25_0 = arg_25_0.speedTF
				local var_25_1 = arg_25_0.rigbody.velocity

				var_1(var_25_0, var_3.Magnitude(var_25_1))
			end

			if not arg_25_0.isPush or arg_25_0.isStop then
				return
			end

			local var_25_2 = arg_25_0:GetSpeed()
			local var_25_3 = arg_25_0._event

			var_2.emit(var_25_3, var_0_42, {
				speed = var_25_2
			})

			if var_25_2 > var_0_15[1] then
				local var_25_4 = arg_25_0.animator

				var_2.SetInteger(var_25_4, "SpeedPhase", 1)
			elseif var_25_2 > var_0_15[2] then
				local var_25_5 = arg_25_0.animator

				var_2.SetInteger(var_25_5, "SpeedPhase", 2)
			elseif var_25_2 > var_0_15[3] then
				local var_25_6 = arg_25_0.animator

				var_2.SetInteger(var_25_6, "SpeedPhase", 3)
			end

			if var_25_2 < var_0_16 then
				local var_25_7 = arg_25_0.animator

				var_2.SetBool(var_25_7, "Stop", true)

				arg_25_0.isStop = true

				arg_25_0:Result()
			end

			return
		end,
		Push = function(arg_26_0, arg_26_1)
			pg = var_2_10002

			local var_26_0 = var_2_10002.CriMgr.GetInstance()

			var_2.PlaySoundEffect_V3(var_26_0, var_0_3)

			arg_26_0.isPush = true
			arg_26_0.isStop = false

			local var_26_1 = arg_26_0._tf

			var_2.SetParent(var_26_1, arg_26_0.scene, true)

			Vector2 = var_2

			local var_26_2 = var_2(var_0_14.x - arg_26_0._tf.anchoredPosition.x, var_0_14.y - arg_26_0._tf.anchoredPosition.y)
			local var_26_3 = arg_26_0.rigbody
			local var_26_4 = var_26_2:Normalize()

			var_26_3.velocity = var_4.Mul(var_26_4, arg_26_1)

			arg_26_0:Slip()

			return
		end,
		Slip = function(arg_27_0)
			local var_27_0 = arg_27_0.animator

			var_1.SetBool(var_27_0, "Stop", false)

			arg_27_0.isStop = false

			return
		end,
		OnCollision = function(arg_28_0, arg_28_1)
			local var_28_0 = arg_28_0.animator

			var_2.SetTrigger(var_28_0, "Hit")

			local var_28_1 = arg_28_0._event

			var_2.emit(var_28_1, var_0_43)

			pg = var_2

			local var_28_2 = var_2.CriMgr.GetInstance()

			var_2.PlaySoundEffect_V3(var_28_2, var_0_4)

			local var_28_3 = arg_28_1.collider.gameObject.name
			local var_28_4 = 0

			Vector2 = var_4

			local var_28_5 = var_4(1, 0)

			Vector2 = var_5

			local var_28_6 = var_5(arg_28_0.rigbody.velocity.x, arg_28_0.rigbody.velocity.y)

			if var_28_3 == "wall" then
				var_28_6:Mul(var_0_18.wall)

				var_28_4 = var_0_36.wall

				var_28_5:Mul(var_0_19.wall)
			elseif var_28_3 == "oil" then
				var_28_6:Mul(var_0_18.oil)

				var_28_4 = var_0_36.oil

				var_28_5:Mul(var_0_19.oil)
			elseif var_28_3 == "cube" then
				var_28_6:Mul(var_0_18.cube)

				var_28_4 = var_0_36.cube

				var_28_5:Mul(var_0_19.cube)
			elseif var_28_3 == "miner" then
				var_28_6:Mul(var_0_18.miner)

				var_28_4 = var_0_36.miner

				var_28_5:Mul(var_0_19.miner)
			elseif var_28_3 == "walker" then
				var_28_6:Mul(var_0_18.walker)

				var_28_4 = var_0_36.walker

				var_28_5:Mul(var_0_19.walker)
			end

			local var_28_7 = arg_28_0.rigbody
			local var_28_8 = arg_28_0.rigbody.velocity

			var_28_7.velocity = var_7.Sub(var_28_8, var_28_6)

			local var_28_9 = arg_28_0.rigbody
			local var_28_10 = arg_28_0.rigbody.velocity

			var_28_9.velocity = var_7.Add(var_28_10, var_28_5)

			local var_28_11 = arg_28_0._tf.anchoredPosition
			local var_28_12 = arg_28_0._event

			var_7.emit(var_28_12, var_0_48, {
				score = var_28_4,
				pos = var_28_11
			})

			return
		end,
		Result = function(arg_29_0)
			Vector2 = var_2_10001

			local var_29_0 = var_2_10001(arg_29_0._tf.anchoredPosition.x, arg_29_0._tf.anchoredPosition.y / var_0_29)

			Vector2 = var_2

			local var_29_1 = var_2.Distance(var_0_28, var_29_0)
			local var_29_2 = 0
			local var_29_3 = var_29_1 <= var_0_30[1] and 1 or var_29_1 <= var_0_30[2] and 2 or var_29_1 <= var_0_30[3] and 3 or 4
			local var_29_4 = arg_29_0.animator

			var_4.SetInteger(var_29_4, "Result", var_29_3)

			local var_29_5 = arg_29_0._event

			var_4.emit(var_29_5, var_0_44, {
				result = var_29_3
			})

			if var_29_3 == 0 or var_29_3 == 4 then
				pg = var_4

				local var_29_6 = var_4.CriMgr.GetInstance()

				var_4.PlaySoundEffect_V3(var_29_6, var_0_6)
			else
				pg = var_4

				local var_29_7 = var_4.CriMgr.GetInstance()

				var_4.PlaySoundEffect_V3(var_29_7, var_0_5)
			end

			return
		end,
		Pause = function(arg_30_0)
			arg_30_0.speedRecord = arg_30_0.rigbody.velocity

			local var_30_0 = arg_30_0.rigbody

			Vector2 = var_2_10002
			var_30_0.velocity = var_2_10002.zero
			arg_30_0.animator.speed = 0

			return
		end,
		Resume = function(arg_31_0)
			arg_31_0.rigbody.velocity = arg_31_0.speedRecord
			arg_31_0.animator.speed = 1

			return
		end,
		GetSpeed = function(arg_32_0)
			local var_32_0 = arg_32_0.rigbody.velocity

			return var_1.Magnitude(var_32_0)
		end
	}

	var_3.Ctor(var_15_0)

	return var_3
end

local function var_0_51(arg_33_0, arg_33_1)
	local var_33_0 = {
		Ctor = function(arg_34_0)
			arg_34_0._tf = arg_33_0
			arg_34_0._event = arg_33_1
			GetComponent = var_1

			local var_34_0 = arg_34_0._tf

			typeof = var_2_10003
			Animator = var_2_10004
			arg_34_0.animator = var_1(var_34_0, var_2_10003(var_2_10004))

			local var_34_1 = arg_34_0._event

			var_1.bind(var_34_1, var_0_41, function(arg_35_0, arg_35_1, arg_35_2)
				local var_35_0 = arg_34_0

				var_3.TurnLeft(var_35_0)

				return
			end)

			local var_34_2 = arg_34_0._event

			var_1.bind(var_34_2, var_0_43, function(arg_36_0, arg_36_1, arg_36_2)
				local var_36_0 = arg_34_0

				var_3.Hit(var_36_0)

				return
			end)

			local var_34_3 = arg_34_0._event

			var_1.bind(var_34_3, var_0_44, function(arg_37_0, arg_37_1, arg_37_2)
				local var_37_0 = arg_34_0

				var_3.Result(var_37_0, arg_37_1.result)

				return
			end)

			local var_34_4 = arg_34_0._event

			var_1.bind(var_34_4, var_0_45, function(arg_38_0, arg_38_1, arg_38_2)
				local var_38_0 = arg_34_0

				var_3.Reset(var_38_0)

				local var_38_1 = arg_34_0

				var_3.Start(var_38_1)

				return
			end)

			return
		end,
		Start = function(arg_39_0)
			return
		end,
		Reset = function(arg_40_0)
			local var_40_0 = arg_40_0.animator

			var_1.SetInteger(var_40_0, "Result", 0)

			local var_40_1 = arg_40_0.animator

			var_1.Play(var_40_1, "WaitA")

			return
		end,
		TurnLeft = function(arg_41_0)
			local var_41_0 = arg_41_0.animator

			var_1.SetTrigger(var_41_0, "TurnLeft")

			return
		end,
		Result = function(arg_42_0, arg_42_1)
			local var_42_0 = arg_42_0.animator

			var_2.SetInteger(var_42_0, "Result", arg_42_1)

			return
		end,
		Hit = function(arg_43_0)
			local var_43_0 = arg_43_0.animator

			var_1.SetTrigger(var_43_0, "Hit")

			return
		end
	}

	var_2.Ctor(var_33_0)

	return var_2
end

local function var_0_52(arg_44_0, arg_44_1)
	local var_44_0 = {
		Ctor = function(arg_45_0)
			arg_45_0._tf = arg_44_0
			arg_45_0._event = arg_44_1
			GetComponent = var_1

			local var_45_0 = arg_45_0._tf

			typeof = var_2_10003
			Animator = var_2_10004
			arg_45_0.animator = var_1(var_45_0, var_2_10003(var_2_10004))

			local var_45_1 = arg_45_0._event

			var_1.bind(var_45_1, var_0_45, function(arg_46_0, arg_46_1, arg_46_2)
				local var_46_0 = arg_45_0

				var_3.NextRound(var_46_0)

				return
			end)
			arg_45_0:Reset()

			return
		end,
		Start = function(arg_47_0)
			arg_47_0:NextRound()

			return
		end,
		Reset = function(arg_48_0)
			local var_48_0 = arg_48_0.animator

			var_1.SetInteger(var_48_0, "Round", 0)

			local var_48_1 = arg_48_0.animator

			var_1.Play(var_48_1, "IdleA")

			arg_48_0.roundNum = 1

			return
		end,
		NextRound = function(arg_49_0)
			local var_49_0 = arg_49_0.animator

			var_1.SetInteger(var_49_0, "Round", arg_49_0.roundNum)

			if arg_49_0.roundNum == 3 then
				arg_49_0.roundNum = 1
			else
				arg_49_0.roundNum = arg_49_0.roundNum + 1
			end

			return
		end
	}

	var_2.Ctor(var_44_0)

	return var_2
end

local function var_0_53(arg_50_0, arg_50_1)
	local var_50_0 = {
		Ctor = function(arg_51_0)
			arg_51_0._tf = arg_50_0
			arg_51_0._event = arg_50_1
			arg_51_0.config = var_0_38.miner
			GetComponent = var_1

			local var_51_0 = arg_51_0._tf

			typeof = var_2_10003
			Animator = var_2_10004
			arg_51_0.animator = var_1(var_51_0, var_2_10003(var_2_10004))
			GetComponent = var_1
			arg_51_0.phyItem = var_1(arg_51_0._tf, "Physics2DItem")

			local var_51_1 = arg_51_0.phyItem.CollisionEnter

			var_1.AddListener(var_51_1, function(arg_52_0)
				local var_52_0 = arg_51_0

				var_1.OnCollision(var_52_0)

				return
			end)

			GetComponent = var_1
			findTF = var_51_1
			arg_51_0.phyGrazeItem = var_1(var_51_1(arg_51_0._tf, "GrazeCollider"), "Physics2DItem")

			local var_51_2 = arg_51_0.phyGrazeItem.TriggerEnter

			var_1.AddListener(var_51_2, function(arg_53_0)
				local var_53_0 = arg_51_0

				var_1.OnGrazeTrigger(var_53_0, arg_53_0)

				return
			end)

			local var_51_3 = arg_51_0._event

			var_1.bind(var_51_3, var_0_42, function(arg_54_0, arg_54_1, arg_54_2)
				arg_51_0.hitSpeed = arg_54_1.speed

				return
			end)
			arg_51_0:Reset()

			return
		end,
		Start = function(arg_55_0)
			return
		end,
		Reset = function(arg_56_0)
			arg_56_0.isClash = false
			arg_56_0.hitSpeed = 0

			return
		end,
		OnCollision = function(arg_57_0)
			arg_57_0.isClash = true

			local var_57_0 = 0

			if arg_57_0.hitSpeed > var_0_20[3] then
				var_57_0 = 3
			elseif arg_57_0.hitSpeed > var_0_20[2] then
				var_57_0 = 2
			elseif arg_57_0.hitSpeed > var_0_20[1] then
				var_57_0 = 1
			end

			local var_57_1 = arg_57_0.animator

			var_2.SetInteger(var_57_1, "Speed", var_57_0)

			local var_57_2 = arg_57_0.animator

			var_2.SetTrigger(var_57_2, "Clash")

			return
		end,
		OnGrazeTrigger = function(arg_58_0, arg_58_1)
			if arg_58_1.gameObject.name ~= "Ayanami" then
				return
			end

			onDelayTick = var_2

			var_2(function()
				if arg_58_0.isClash then
					return
				end

				local var_59_0 = arg_58_0.animator

				var_0.SetTrigger(var_59_0, "Graze")

				return
			end, 0.3)

			return
		end
	}

	var_2.Ctor(var_50_0)

	return var_2
end

local function var_0_54(arg_60_0, arg_60_1)
	local var_60_0 = {}
	local var_60_1 = 1000

	function var_60_0.Ctor(arg_61_0)
		arg_61_0._tf = arg_60_0
		arg_61_0._event = arg_60_1
		arg_61_0.config = var_0_38.walker
		arg_61_0.obstacleTF = arg_61_0._tf.parent
		findTF = var_1
		arg_61_0.bgFrontTF = var_1(arg_61_0.obstacleTF.parent.parent, "bg_front")
		GetComponent = var_1

		local var_61_0 = arg_61_0._tf

		typeof = var_3
		Animator = var_2_10004
		arg_61_0.animator = var_1(var_61_0, var_3(var_2_10004))
		GetComponent = var_1
		arg_61_0.rigbody = var_1(arg_61_0._tf, "Rigidbody2D")
		GetComponent = var_1
		arg_61_0.phyItem = var_1(arg_61_0._tf, "Physics2DItem")

		local var_61_1 = arg_61_0.phyItem.CollisionEnter

		var_1.AddListener(var_61_1, function(arg_62_0)
			local var_62_0 = arg_61_0

			var_1.OnCollision(var_62_0, arg_62_0)

			return
		end)

		local var_61_2 = arg_61_0._event

		var_1.bind(var_61_2, var_0_42, function(arg_63_0, arg_63_1, arg_63_2)
			arg_61_0.hitSpeed = arg_63_1.speed

			return
		end)

		local var_61_3 = arg_61_0._event

		var_1.bind(var_61_3, var_0_46, function(arg_64_0, arg_64_1, arg_64_2)
			local var_64_0 = arg_61_0

			var_3.Pause(var_64_0)

			return
		end)

		local var_61_4 = arg_61_0._event

		var_1.bind(var_61_4, var_0_47, function(arg_65_0, arg_65_1, arg_65_2)
			local var_65_0 = arg_61_0

			var_3.Resume(var_65_0)

			return
		end)

		return
	end

	function var_60_0.SetPath(arg_66_0, arg_66_1)
		arg_66_0.pathType = arg_66_1

		return
	end

	function var_60_0.Start(arg_67_0)
		arg_67_0:WalkPath()

		return
	end

	function var_60_0.Reset(arg_68_0)
		setActive = var_2_10001

		var_2_10001(arg_68_0._tf, false)

		setLocalPosition = var_2_10001

		local var_68_0 = arg_68_0._tf

		Vector2 = var_3

		var_2_10001(var_68_0, var_3(-1400, 0))

		local var_68_1 = arg_68_0.rigbody

		Vector2 = var_68_0
		var_68_1.velocity = var_68_0.zero
		arg_68_0.isJumpDown = false
		arg_68_0.isJumpUp = false
		arg_68_0.isForwardNorth = false
		arg_68_0.isForwardSouth = false
		arg_68_0.hitSpeed = 0
		arg_68_0.pathType = 0

		return
	end

	function var_60_0.OnCollision(arg_69_0, arg_69_1)
		local var_69_0 = arg_69_0.animator

		var_2.SetTrigger(var_69_0, "Clash")

		local var_69_1 = 0

		if arg_69_0.hitSpeed > var_0_21[3] then
			var_69_1 = 3
		elseif arg_69_0.hitSpeed > var_0_21[2] then
			var_69_1 = 2
		elseif arg_69_0.hitSpeed > var_0_21[1] then
			var_69_1 = 1
		end

		local var_69_2 = arg_69_0.animator

		var_3.SetInteger(var_69_2, "Speed", var_69_1)

		local var_69_3 = arg_69_0.rigbody

		Vector2 = var_69_2
		var_69_3.velocity = var_69_2.zero

		return
	end

	function var_60_0.WalkPath(arg_70_0)
		if arg_70_0.pathType == var_0_26 or arg_70_0.pathType == var_0_27 then
			setLocalPosition = var_1

			var_1(arg_70_0._tf, var_0_22)

			local var_70_0 = arg_70_0._tf

			var_1.SetParent(var_70_0, arg_70_0.bgFrontTF, false)

			arg_70_0.isForwardNorth = true

			local var_70_1 = arg_70_0.animator

			var_1.SetBool(var_70_1, "IsNorth", true)
			arg_70_0:WalkNorth()
		elseif arg_70_0.pathType == var_0_24 or arg_70_0.pathType == var_0_25 then
			setLocalPosition = var_1

			var_1(arg_70_0._tf, var_0_23)

			local var_70_2 = arg_70_0._tf

			var_1.SetParent(var_70_2, arg_70_0.obstacleTF, false)

			arg_70_0.isForwardSouth = true

			local var_70_3 = arg_70_0.animator

			var_1.SetBool(var_70_3, "IsSouth", true)
			arg_70_0:WalkSouth()
		end

		return
	end

	function var_60_0.WalkNorth(arg_71_0)
		local var_71_0 = arg_71_0.animator

		var_1.SetTrigger(var_71_0, "WalkN")

		local var_71_1 = arg_71_0.rigbody

		Vector2 = var_71_0
		var_71_1.velocity = var_71_0(0, 1.5)

		return
	end

	function var_60_0.JumpNorth(arg_72_0)
		local var_72_0 = arg_72_0.animator

		var_1.SetTrigger(var_72_0, "JumpN")

		if arg_72_0.isJumpUp then
			arg_72_0:WalkNorth()
		elseif arg_72_0.pathType == var_0_27 then
			arg_72_0:WalkNorthwest()
		else
			arg_72_0:WalkNorth()
		end

		return
	end

	function var_60_0.WalkNorthwest(arg_73_0)
		local var_73_0 = arg_73_0.animator

		var_1.SetTrigger(var_73_0, "WalkNW")

		local var_73_1 = arg_73_0.rigbody

		Vector2 = var_73_0
		var_73_1.velocity = var_73_0(-1.5, 1.5)

		return
	end

	function var_60_0.WalkSouth(arg_74_0)
		local var_74_0 = arg_74_0.animator

		var_1.SetTrigger(var_74_0, "WalkS")

		local var_74_1 = arg_74_0.rigbody

		Vector2 = var_74_0
		var_74_1.velocity = var_74_0(0, -1.5)

		return
	end

	function var_60_0.JumpSouth(arg_75_0)
		local var_75_0 = arg_75_0.animator

		var_1.SetTrigger(var_75_0, "JumpS")

		if arg_75_0.isJumpDown then
			arg_75_0:WalkSouth()
		elseif arg_75_0.pathType == var_0_25 then
			arg_75_0:WalkSouthwest()
		else
			arg_75_0:WalkSouth()
		end

		return
	end

	function var_60_0.WalkSouthwest(arg_76_0)
		local var_76_0 = arg_76_0.animator

		var_1.SetTrigger(var_76_0, "WalkSW")

		local var_76_1 = arg_76_0.rigbody

		Vector2 = var_76_0
		var_76_1.velocity = var_76_0(-1.5, -1.5)

		return
	end

	function var_60_0.Step(arg_77_0)
		if arg_77_0._tf.anchoredPosition.y > var_60_1 or var_1 < -var_60_1 then
			local var_77_0 = arg_77_0.rigbody

			Vector2 = var_2_10003
			var_77_0.velocity = var_2_10003.zero

			return
		end

		if arg_77_0.isForwardNorth then
			if not arg_77_0.isJumpDown and var_1 >= -470 then
				arg_77_0.isJumpDown = true

				arg_77_0:JumpNorth()

				onDelayTick = var_2

				var_2(function()
					local var_78_0 = arg_77_0._tf

					var_0.SetParent(var_78_0, arg_77_0.obstacleTF, false)

					return
				end, 0.3)
			end

			if not arg_77_0.isJumpUp and var_1 >= 310 then
				arg_77_0.isJumpUp = true

				arg_77_0:JumpNorth()
			end
		end

		if arg_77_0.isForwardSouth then
			if not arg_77_0.isJumpUp and var_1 <= 370 then
				arg_77_0.isJumpUp = true

				arg_77_0:JumpSouth()
			end

			if not arg_77_0.isJumpDown and var_1 <= -420 then
				arg_77_0.isJumpDown = true

				arg_77_0:JumpSouth()

				onDelayTick = var_2

				var_2(function()
					local var_79_0 = arg_77_0._tf

					var_0.SetParent(var_79_0, arg_77_0.bgFrontTF, false)

					return
				end, 0.3)
			end
		end

		return
	end

	function var_60_0.Pause(arg_80_0)
		arg_80_0.speedRecord = arg_80_0.rigbody.velocity

		local var_80_0 = arg_80_0.rigbody

		Vector2 = var_2_10002
		var_80_0.velocity = var_2_10002.zero
		arg_80_0.animator.speed = 0

		return
	end

	function var_60_0.Resume(arg_81_0)
		arg_81_0.rigbody.velocity = arg_81_0.speedRecord
		arg_81_0.animator.speed = 1

		return
	end

	var_60_0:Ctor()

	return var_60_0
end

function var_0_1.getUIName(arg_82_0)
	return "CurlingGameUI"
end

function var_0_1.didEnter(arg_83_0)
	arg_83_0:initEvent()
	arg_83_0:initData()
	arg_83_0:initUI()
	arg_83_0:initGameUI()
	arg_83_0:initController()
	arg_83_0:updateMainUI()
	arg_83_0:openMainUI()
	arg_83_0:AutoFitScreen()

	return
end

function var_0_1.AutoFitScreen(arg_84_0)
	Screen = var_1_10001

	local var_84_0 = var_1_10001.width

	Screen = var_1_10002

	local var_84_1 = var_84_0 / var_1_10002.height
	local var_84_2 = 1.7777777777777777
	local var_84_3 = arg_84_0._tf
	local var_84_4 = var_3.Find(var_84_3, "bg_back")
	local var_84_5 = 2331
	local var_84_6 = var_84_4.rect.height
	local var_84_7

	if var_84_2 <= var_84_1 then
		var_1_10007 = 1080 * var_84_1
		math = var_1_10008
		var_84_7 = var_1_10008.clamp(var_1_10007 / var_84_5, 1, 2)
	else
		var_1_10007 = 0 / var_84_1
		math = var_1_10008
		var_84_7 = var_1_10008.clamp(var_1_10007 / var_84_6, 1, 2)
	end

	setLocalScale = var_1_10007

	var_1_10007(arg_84_0._tf, {
		x = var_84_7,
		y = var_84_7,
		z = var_84_7
	})

	return
end

function var_0_1.initEvent(arg_85_0)
	arg_85_0:bind(var_0_44, function(arg_86_0, arg_86_1, arg_86_2)
		if arg_86_1.result ~= var_0_35 then
			local var_86_0 = arg_85_0

			var_3.addScore(var_86_0, var_0_31[arg_86_1.result])
		end

		local var_86_1 = arg_85_0

		var_3.obsFadeOut(var_86_1)

		onDelayTick = var_3

		var_3(function()
			local var_87_0 = arg_85_0

			var_0.nextRoundGame(var_87_0)

			return
		end, var_0_37)

		return
	end)
	arg_85_0:bind(var_0_48, function(arg_88_0, arg_88_1, arg_88_2)
		if arg_88_1.score and arg_88_1.score ~= 0 then
			local var_88_0 = arg_85_0

			var_3.addScore(var_88_0, arg_88_1.score, arg_88_1.pos)
		end

		return
	end)

	return
end

function var_0_1.initData(arg_89_0)
	Application = var_1_10001

	local var_89_0

	if not var_1_10001.targetFrameRate then
		var_89_0 = 60
	end

	if var_89_0 > 60 then
		var_89_0 = 60
	end

	arg_89_0.needManualSimulate = true
	Timer = var_2
	arg_89_0.timer = var_2.New(function()
		local var_90_0 = arg_89_0

		var_0.onTimer(var_90_0)

		if arg_89_0.needManualSimulate then
			Physics2D = var_0

			var_0.Simulate(1 / var_89_0)
		end

		return
	end, 1 / var_89_0, -1)

	return
end

function var_0_1.initUI(arg_91_0)
	local var_91_0 = arg_91_0._tf

	arg_91_0.clickMask = var_1.Find(var_91_0, "ui/click_mask")

	local var_91_1 = arg_91_0._tf

	arg_91_0.mainUI = var_1.Find(var_91_1, "ui/main_ui")
	GetComponent = var_1
	findTF = var_91_1

	local var_91_2 = var_91_1(arg_91_0.mainUI, "item_list")

	typeof = var_3
	ScrollRect = var_4
	arg_91_0.listScrollRect = var_1(var_91_2, var_3(var_4))
	onButton = var_1

	local var_91_3 = arg_91_0
	local var_91_4 = arg_91_0.mainUI
	local var_91_5 = var_3.Find(var_91_4, "skin_btn")

	local function var_91_6()
		pg = var_2_10000

		local var_92_0 = var_2_10000.mini_game
		local var_92_1 = arg_91_0
		local var_92_2 = var_92_0[var_1.GetMGData(var_92_1).id].simple_config_data.skin_shop_id

		pg = var_1

		local var_92_3 = var_1.m02
		local var_92_4 = var_1.sendNotification

		GAME = var_2_10003

		local var_92_5 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_92_4(var_92_3, var_92_5, var_2_10004.SKINSHOP, {
			skinId = var_92_2
		})

		return
	end

	SFX_PANEL = var_5

	var_1(var_91_3, var_91_5, var_91_6, var_5)

	onButton = var_1

	local var_91_7 = arg_91_0
	local var_91_8 = arg_91_0.mainUI
	local var_91_9 = var_3.Find(var_91_8, "return_btn")

	local function var_91_10()
		local var_93_0 = arg_91_0

		var_0.emit(var_93_0, var_0_1.ON_BACK_PRESSED)

		return
	end

	SFX_PANEL = var_5

	var_1(var_91_7, var_91_9, var_91_10, var_5)

	onButton = var_1

	local var_91_11 = arg_91_0
	local var_91_12 = arg_91_0.mainUI
	local var_91_13 = var_3.Find(var_91_12, "main_btn")

	local function var_91_14()
		local var_94_0 = arg_91_0

		var_0.emit(var_94_0, var_0_1.ON_HOME)

		return
	end

	SFX_PANEL = var_5

	var_1(var_91_11, var_91_13, var_91_14, var_5)

	onButton = var_1

	local var_91_15 = arg_91_0
	local var_91_16 = arg_91_0.mainUI
	local var_91_17 = var_3.Find(var_91_16, "help_btn")

	local function var_91_18()
		pg = var_2_10000

		local var_95_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_95_1 = var_0.ShowMsgBox
		local var_95_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_95_2.type = var_2_10003
		pg = var_2_10003
		var_95_2.helps = var_2_10003.gametip.CurlingGame_tips1.tip

		var_95_1(var_95_0, var_95_2)

		return
	end

	SFX_PANEL = var_5

	var_1(var_91_15, var_91_17, var_91_18, var_5)

	onButton = var_1

	local var_91_19 = arg_91_0
	local var_91_20 = arg_91_0.mainUI
	local var_91_21 = var_3.Find(var_91_20, "start_btn")

	local function var_91_22()
		local var_96_0 = arg_91_0

		var_0.readyStart(var_96_0)

		return
	end

	SFX_PANEL = var_5

	var_1(var_91_19, var_91_21, var_91_22, var_5)

	onButton = var_1

	local var_91_23 = arg_91_0
	local var_91_24 = arg_91_0.mainUI
	local var_91_25 = var_3.Find(var_91_24, "rank_btn")

	local function var_91_26()
		return
	end

	SFX_PANEL = var_5

	var_1(var_91_23, var_91_25, var_91_26, var_5)

	arg_91_0.totalTimes = arg_91_0:getGameTotalTime()

	local var_91_27, var_91_28

	if arg_91_0:getGameUsedTimes() - 4 < 0 then
		var_91_27 = 0
	else
		var_91_28 = arg_91_0
		var_91_27 = arg_91_0.getGameUsedTimes(var_91_28) - 4
	end

	scrollTo = var_91_28

	var_91_28(arg_91_0.listScrollRect, 0, 1 - var_91_27 / (arg_91_0.totalTimes - 4))

	onButton = var_91_28

	local var_91_29 = arg_91_0
	local var_91_30 = arg_91_0.mainUI
	local var_91_31 = var_4.Find(var_91_30, "right_panel/arrows_up")

	local function var_91_32()
		local var_98_0 = arg_91_0.listScrollRect.normalizedPosition.y + 1 / (arg_91_0.totalTimes - 4)

		if 1 < var_98_0 then
			var_98_0 = 1
		end

		scrollTo = var_1

		var_1(arg_91_0.listScrollRect, 0, var_98_0)

		return
	end

	SFX_PANEL = var_6

	var_91_28(var_91_29, var_91_31, var_91_32, var_6)

	onButton = var_91_28

	local var_91_33 = arg_91_0
	local var_91_34 = arg_91_0.mainUI
	local var_91_35 = var_4.Find(var_91_34, "right_panel/arrows_down")

	local function var_91_36()
		local var_99_0

		if arg_91_0.listScrollRect.normalizedPosition.y - 1 / (arg_91_0.totalTimes - 4) < 0 then
			var_99_0 = 0
		end

		scrollTo = var_1

		var_1(arg_91_0.listScrollRect, 0, var_99_0)

		return
	end

	SFX_PANEL = var_6

	var_91_28(var_91_33, var_91_35, var_91_36, var_6)

	local var_91_37 = arg_91_0.mainUI
	local var_91_38 = var_2.Find(var_91_37, "item_tpl")

	arg_91_0.itemList = {}
	pg = var_3

	local var_91_39 = var_3.mini_game[arg_91_0:GetMGData().id].simple_config_data.drop

	for iter_91_0 = 1, #var_91_39 do
		tf = var_1_10008
		instantiate = var_1_10009
		var_1_10008 = var_1_10008(var_1_10009(var_91_38))
		var_1_10008.name = "item_" .. iter_91_0
		setParent = var_1_10009

		local var_91_40 = var_1_10008
		local var_91_41 = arg_91_0.mainUI

		var_1_10009(var_91_40, var_11.Find(var_91_41, "item_list/Viewport/Content"))

		var_1_10009 = iter_91_0
		GetSpriteFromAtlasAsync = var_91_40

		var_91_40("ui/minigameui/curlinggameui_atlas", "text_" .. var_1_10009, function(arg_100_0)
			setImageSprite = var_2_10001

			local var_100_0 = var_1_10008

			var_2_10001(var_2.Find(var_100_0, "bg/text"), arg_100_0, true)

			return
		end)

		setActive = var_91_40

		var_91_40(var_1_10008, true)

		table = var_91_40

		var_91_40.insert(arg_91_0.itemList, var_1_10008)

		local var_91_42 = var_1_10008:Find("award")
		local var_91_43 = {
			type = var_91_39[iter_91_0][1],
			id = var_91_39[iter_91_0][2],
			count = var_91_39[iter_91_0][3]
		}

		updateDrop = var_12

		var_12(var_91_42, var_91_43)

		onButton = var_12

		local var_91_44 = arg_91_0
		local var_91_45 = var_91_42

		local function var_91_46()
			local var_101_0 = arg_91_0
			local var_101_1 = var_0.emit

			BaseUI = var_2_10002

			var_101_1(var_101_0, var_2_10002.ON_DROP, var_91_43)

			return
		end

		SFX_PANEL = var_1_10016

		var_12(var_91_44, var_91_45, var_91_46, var_1_10016)
	end

	findTF = var_4
	arg_91_0.rankUI = var_4(arg_91_0._tf, "ui/rank_ui")

	local var_91_47 = arg_91_0

	arg_91_0.openRankUI(var_91_47, false)

	GetComponent = var_4
	findTF = var_91_47

	local var_91_48 = var_91_47(arg_91_0.rankUI, "ad/img/score")

	typeof = var_6
	Image = var_7

	local var_91_49 = var_4(var_91_48, var_6(var_7))

	var_4.SetNativeSize(var_91_49)

	findTF = var_4
	arg_91_0._rankImg = var_4(arg_91_0.rankUI, "ad/img")
	findTF = var_4
	arg_91_0._rankBtnClose = var_4(arg_91_0.rankUI, "ad/btnClose")
	findTF = var_4
	arg_91_0._rankContent = var_4(arg_91_0.rankUI, "ad/list/content")
	findTF = var_4
	arg_91_0._rankItemTpl = var_4(arg_91_0.rankUI, "ad/list/content/itemTpl")
	findTF = var_4
	arg_91_0._rankEmpty = var_4(arg_91_0.rankUI, "ad/empty")
	findTF = var_4
	arg_91_0._rankDesc = var_4(arg_91_0.rankUI, "ad/desc")
	arg_91_0._rankItems = {}
	setActive = var_4

	var_4(arg_91_0._rankItemTpl, false)

	onButton = var_4

	local var_91_50 = arg_91_0._event

	findTF = var_6

	local var_91_51 = var_6(arg_91_0.rankUI, "ad/close")

	local function var_91_52()
		local var_102_0 = arg_91_0

		var_0.openRankUI(var_102_0, false)

		return
	end

	SFX_CANCEL = var_8

	var_4(var_91_50, var_91_51, var_91_52, var_8)

	onButton = var_4

	local var_91_53 = arg_91_0._event
	local var_91_54 = arg_91_0._rankBtnClose

	local function var_91_55()
		local var_103_0 = arg_91_0

		var_0.openRankUI(var_103_0, false)

		return
	end

	SFX_CANCEL = var_8

	var_4(var_91_53, var_91_54, var_91_55, var_8)

	setText = var_4

	local var_91_56 = arg_91_0._rankDesc

	i18n = var_91_54

	var_4(var_91_56, var_91_54("pipe_minigame_rank"))

	local var_91_57 = arg_91_0._tf

	arg_91_0.countUI = var_4.Find(var_91_57, "ui/count_ui")
	GetComponent = var_4

	local var_91_58 = arg_91_0.countUI
	local var_91_59 = var_5.Find(var_91_58, "count")

	typeof = var_91_58
	Animator = var_7
	arg_91_0.countAnimator = var_4(var_91_59, var_91_58(var_7))
	GetOrAddComponent = var_4

	local var_91_60 = arg_91_0.countUI
	local var_91_61 = var_5.Find(var_91_60, "count")

	typeof = var_91_60
	DftAniEvent = var_7
	arg_91_0.countDft = var_4(var_91_61, var_91_60(var_7))

	local var_91_62 = arg_91_0.countDft

	var_4.SetTriggerEvent(var_91_62, function()
		return
	end)

	local var_91_63 = arg_91_0.countDft

	var_4.SetEndEvent(var_91_63, function()
		setActive = var_2_10000

		var_2_10000(arg_91_0.countUI, false)

		local var_105_0 = arg_91_0

		var_0.startGame(var_105_0)

		return
	end)

	local var_91_64 = arg_91_0._tf

	arg_91_0.pauseUI = var_4.Find(var_91_64, "ui/pause_ui")
	onButton = var_4

	local var_91_65 = arg_91_0
	local var_91_66 = arg_91_0.pauseUI
	local var_91_67 = var_6.Find(var_91_66, "ad/panel/sure_btn")

	local function var_91_68()
		setActive = var_2_10000

		var_2_10000(arg_91_0.pauseUI, false)

		local var_106_0 = arg_91_0

		var_0.resumeGame(var_106_0)

		return
	end

	SFX_PANEL = var_8

	var_4(var_91_65, var_91_67, var_91_68, var_8)

	local var_91_69 = arg_91_0._tf

	arg_91_0.returnUI = var_4.Find(var_91_69, "ui/return_ui")
	onButton = var_4

	local var_91_70 = arg_91_0
	local var_91_71 = arg_91_0.returnUI
	local var_91_72 = var_6.Find(var_91_71, "ad/panel/sure_btn")

	local function var_91_73()
		setActive = var_2_10000

		var_2_10000(arg_91_0.returnUI, false)

		local var_107_0 = arg_91_0

		var_0.resumeGame(var_107_0)

		local var_107_1 = arg_91_0

		var_0.endGame(var_107_1)

		return
	end

	SFX_PANEL = var_8

	var_4(var_91_70, var_91_72, var_91_73, var_8)

	onButton = var_4

	local var_91_74 = arg_91_0
	local var_91_75 = arg_91_0.returnUI
	local var_91_76 = var_6.Find(var_91_75, "ad/panel/cancel_btn")

	local function var_91_77()
		setActive = var_2_10000

		var_2_10000(arg_91_0.returnUI, false)

		local var_108_0 = arg_91_0

		var_0.resumeGame(var_108_0)

		return
	end

	SFX_PANEL = var_8

	var_4(var_91_74, var_91_76, var_91_77, var_8)

	local var_91_78 = arg_91_0._tf

	arg_91_0.endUI = var_4.Find(var_91_78, "ui/end_ui")
	onButton = var_4

	local var_91_79 = arg_91_0
	local var_91_80 = arg_91_0.endUI
	local var_91_81 = var_6.Find(var_91_80, "ad/panel/end_btn")

	local function var_91_82()
		setActive = var_2_10000

		var_2_10000(arg_91_0.endUI, false)

		local var_109_0 = arg_91_0

		var_0.openMainUI(var_109_0)

		return
	end

	SFX_PANEL = var_8

	var_4(var_91_79, var_91_81, var_91_82, var_8)

	if not arg_91_0.handle then
		UpdateBeat = var_4
		arg_91_0.handle = var_4:CreateListener(arg_91_0.Update, arg_91_0)
	end

	UpdateBeat = var_4

	var_4:AddListener(arg_91_0.handle)

	return
end

function var_0_1.initGameUI(arg_110_0)
	local var_110_0 = arg_110_0._tf

	arg_110_0.gameUI = var_1.Find(var_110_0, "ui/game_ui")

	local var_110_1 = arg_110_0.gameUI

	arg_110_0.roundTF = var_1.Find(var_110_1, "score_panel/round_text")

	local var_110_2 = arg_110_0.gameUI

	arg_110_0.scoreTF = var_1.Find(var_110_2, "score_panel/score_text")
	onButton = var_1

	local var_110_3 = arg_110_0
	local var_110_4 = arg_110_0.gameUI

	var_1(var_110_3, var_3.Find(var_110_4, "pause_btn"), function()
		local var_111_0 = arg_110_0

		var_0.pauseGame(var_111_0)

		setActive = var_0

		var_0(arg_110_0.pauseUI, true)

		return
	end)

	onButton = var_1

	local var_110_5 = arg_110_0
	local var_110_6 = arg_110_0.gameUI

	var_1(var_110_5, var_3.Find(var_110_6, "return_btn"), function()
		local var_112_0 = arg_110_0

		var_0.pauseGame(var_112_0)

		setActive = var_0

		var_0(arg_110_0.returnUI, true)

		return
	end)

	local var_110_7 = arg_110_0.gameUI

	arg_110_0.scoreGroup = var_1.Find(var_110_7, "score_group")
	setActive = var_1

	local var_110_8 = arg_110_0._tf

	var_1(var_2.Find(var_110_8, "bg_front/wall"), var_0_40)

	return
end

function var_0_1.initController(arg_113_0)
	local var_113_0 = arg_113_0._tf

	arg_113_0.scene = var_1.Find(var_113_0, "scene")

	local var_113_1 = arg_113_0._tf

	arg_113_0.gridTF = var_1.Find(var_113_1, "ui/grid")

	local var_113_2 = var_0_49
	local var_113_3 = arg_113_0.scene

	arg_113_0.player = var_113_2(var_2.Find(var_113_3, "player"), arg_113_0)

	local var_113_4 = arg_113_0.scene

	arg_113_0.phy = var_1.Find(var_113_4, "Ayanami_phy")

	local var_113_5 = arg_113_0.scene

	arg_113_0.drawDot = var_1.Find(var_113_5, "draw_dot")

	local var_113_6 = arg_113_0.scene

	arg_113_0.curlingTpls = var_1.Find(var_113_6, "curling_Tpl")
	arg_113_0.curling = var_0_50(arg_113_0.curlingTpls, arg_113_0.player._tf, arg_113_0)

	local var_113_7 = var_0_51
	local var_113_8 = arg_113_0._tf

	arg_113_0.ofunya = var_113_7(var_2.Find(var_113_8, "bg_back/07_Ofunya"), arg_113_0)

	local var_113_9 = var_0_52
	local var_113_10 = arg_113_0._tf

	arg_113_0.manjuu = var_113_9(var_2.Find(var_113_10, "bg_back/08_Manjuu"), arg_113_0)

	local var_113_11 = var_0_54
	local var_113_12 = arg_113_0.scene

	arg_113_0.walker = var_113_11(var_2.Find(var_113_12, "obstacle/walker"), arg_113_0)

	local var_113_13 = arg_113_0._tf

	arg_113_0.obsTF = var_1.Find(var_113_13, "scene/obstacle")
	GetComponent = var_1

	local var_113_14 = arg_113_0.obsTF

	typeof = var_3
	CanvasGroup = var_4
	arg_113_0.obsCanvas = var_1(var_113_14, var_3(var_4))

	local var_113_15 = arg_113_0._tf

	arg_113_0.obsTpl = var_1.Find(var_113_15, "scene/obstacle_Tpl")

	local var_113_16 = arg_113_0.obsTF

	arg_113_0.minerGroups = var_1.Find(var_113_16, "miner_groups")

	local var_113_17 = arg_113_0.obsTF

	arg_113_0.oilGroups = var_1.Find(var_113_17, "oil_groups")

	local var_113_18 = arg_113_0.obsTF

	arg_113_0.cubeGroups = var_1.Find(var_113_18, "cube_groups")

	return
end

function var_0_1.updateMainUI(arg_114_0)
	local var_114_0 = arg_114_0:getGameUsedTimes()
	local var_114_1 = arg_114_0:getGameTimes()

	for iter_114_0 = 1, #arg_114_0.itemList do
		setActive = var_1_10007

		local var_114_2 = arg_114_0.itemList[iter_114_0]

		var_1_10007(var_8.Find(var_114_2, "lock"), false)

		setActive = var_1_10007

		local var_114_3 = arg_114_0.itemList[iter_114_0]

		var_1_10007(var_8.Find(var_114_3, "finish"), false)

		if iter_114_0 <= var_114_0 then
			setActive = var_1_10007

			local var_114_4 = arg_114_0.itemList[iter_114_0]

			var_1_10007(var_8.Find(var_114_4, "finish"), true)
		elseif iter_114_0 == var_114_0 + 1 and 1 <= var_114_1 then
			-- block empty
		elseif var_114_0 < iter_114_0 and iter_114_0 <= var_114_0 + var_114_1 then
			-- block empty
		else
			setActive = var_1_10007

			local var_114_5 = arg_114_0.itemList[iter_114_0]

			var_1_10007(var_8.Find(var_114_5, "lock"), true)
		end
	end

	arg_114_0.totalTimes = arg_114_0:getGameTotalTime()

	local var_114_6 = 1 - (arg_114_0:getGameUsedTimes() - 3 < 0 and 0 or arg_114_0:getGameUsedTimes() - 3) / (arg_114_0.totalTimes - 4)

	if 1 < var_114_6 then
		var_114_6 = 1
	end

	scrollTo = var_5

	var_5(arg_114_0.listScrollRect, 0, var_114_6)
	arg_114_0:checkGet()

	return
end

function var_0_1.updateRankUI(arg_115_0, arg_115_1)
	for iter_115_0 = 1, #arg_115_1 do
		var_1_10006 = nil

		if #arg_115_0._rankItems < iter_115_0 then
			tf = var_7
			instantiate = var_1_10008

			local var_115_0 = var_7(var_1_10008(arg_115_0._rankItemTpl))

			setActive = var_1_10008

			var_1_10008(var_115_0, false)

			setParent = var_1_10008

			var_1_10008(var_115_0, arg_115_0._rankContent)

			table = var_1_10008

			var_1_10008.insert(arg_115_0._rankItems, var_115_0)
		end

		var_1_10006 = arg_115_0._rankItems[iter_115_0]
		var_1_10008 = arg_115_0

		arg_115_0.setRankItemData(var_1_10008, var_1_10006, arg_115_1[iter_115_0], iter_115_0)

		setActive = var_7

		var_7(var_1_10006, true)
	end

	for iter_115_1 = #arg_115_1 + 1, #arg_115_0._rankItems do
		setActive = var_1_10006

		var_1_10006(arg_115_0._rankItems, false)
	end

	setActive = var_2

	var_2(arg_115_0._rankEmpty, #arg_115_1 == 0)

	setActive = var_2

	var_2(arg_115_0._rankImg, #arg_115_1 > 0)

	return
end

function var_0_1.checkGet(arg_116_0)
	if arg_116_0:getUltimate() == 0 then
		local var_116_0 = arg_116_0:getGameTotalTime()
		local var_116_1 = arg_116_0

		if var_116_0 > arg_116_0.getGameUsedTimes(var_116_1) then
			return
		end

		pg = var_116_1

		local var_116_2 = var_116_1.m02
		local var_116_3 = var_3.sendNotification

		GAME = var_1_10005

		local var_116_4 = var_1_10005.SEND_MINI_GAME_OP
		local var_116_5 = {
			hubid = arg_116_0:GetMGHubData().id
		}

		MiniGameOPCommand = var_7
		var_116_5.cmd = var_7.CMD_ULTIMATE
		var_116_5.args1 = {}

		var_116_3(var_116_2, var_116_4, var_116_5)
	end

	return
end

function var_0_1.openMainUI(arg_117_0)
	setActive = var_1_10001

	var_1_10001(arg_117_0.gameUI, false)

	setActive = var_1_10001

	var_1_10001(arg_117_0.mainUI, true)
	arg_117_0:updateMainUI()

	return
end

function var_0_1.openRankUI(arg_118_0, arg_118_1)
	setActive = var_1_10002

	var_1_10002(arg_118_0.rankUI, arg_118_1)

	if arg_118_1 then
		local var_118_0 = arg_118_0
		local var_118_1 = arg_118_0.GetMGData(var_118_0).id

		pg = var_118_0

		local var_118_2 = var_118_0.m02
		local var_118_3 = var_3.sendNotification

		GAME = var_1_10005

		var_118_3(var_118_2, var_1_10005.MINI_GAME_FRIEND_RANK, {
			id = var_118_1,
			callback = function(arg_119_0)
				local var_119_0 = {}

				for iter_119_0 = 1, #arg_119_0 do
					local var_119_1 = {}

					pairs = var_2_10007

					for iter_119_1, iter_119_2 in var_2_10007(arg_119_0[iter_119_0]) do
						var_119_1[iter_119_1] = iter_119_2
					end

					table = var_2_10007

					var_2_10007.insert(var_119_0, var_119_1)
				end

				table = var_2

				var_2.sort(var_119_0, function(arg_120_0, arg_120_1)
					if arg_120_0.score ~= arg_120_1.score then
						return arg_120_0.score > arg_120_1.score
					elseif arg_120_0.time_data ~= arg_120_1.time_data then
						return arg_120_0.time_data > arg_120_1.time_data
					else
						return arg_120_0.player_id < arg_120_1.player_id
					end

					return
				end)

				local var_119_2 = arg_118_0

				var_2.updateRankUI(var_119_2, var_119_0)

				return
			end
		})
	end

	return
end

function var_0_1.readyStart(arg_121_0)
	setActive = var_1_10001

	var_1_10001(arg_121_0.mainUI, false)

	setActive = var_1_10001

	var_1_10001(arg_121_0.countUI, true)

	local var_121_0 = arg_121_0.countAnimator

	var_1.Play(var_121_0, "count")

	pg = var_1

	local var_121_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_121_1, var_0_2)
	arg_121_0:resetGame()

	return
end

function var_0_1.resetGame(arg_122_0)
	arg_122_0.gameStartFlag = false
	arg_122_0.gamePause = false
	arg_122_0.gameEndFlag = false
	arg_122_0.scoreNum = 0
	arg_122_0.roundNum = 1

	local var_122_0 = arg_122_0.player

	var_1.Reset(var_122_0)

	local var_122_1 = arg_122_0.curling

	var_1.Reset(var_122_1)

	local var_122_2 = arg_122_0.ofunya

	var_1.Reset(var_122_2)

	local var_122_3 = arg_122_0.manjuu

	var_1.Reset(var_122_3)

	local var_122_4 = arg_122_0.walker

	var_1.Reset(var_122_4)

	return
end

function var_0_1.startGame(arg_123_0)
	setActive = var_1_10001

	var_1_10001(arg_123_0.gameUI, true)
	arg_123_0:CoordinateGrid(arg_123_0.gridTF)

	arg_123_0.gameStartFlag = true

	local var_123_0 = arg_123_0.player

	var_1.Start(var_123_0)

	local var_123_1 = arg_123_0.curling

	var_1.Start(var_123_1)

	local var_123_2 = arg_123_0.ofunya

	var_1.Start(var_123_2)

	local var_123_3 = arg_123_0.manjuu

	var_1.Start(var_123_3)
	arg_123_0:staticObsStart()
	arg_123_0:updateGameUI()
	arg_123_0:timerStart()

	return
end

function var_0_1.staticObsStart(arg_124_0)
	setActive = var_1_10001

	var_1_10001(arg_124_0.obsTF, true)

	arg_124_0.obsCanvas.alpha = 1

	local var_124_0 = arg_124_0.walker

	var_1.Reset(var_124_0)

	math = var_1

	local var_124_2

	if var_1.random() <= var_0_38.walker.appear then
		setActive = var_124_2

		var_124_2(arg_124_0.walker._tf, true)

		setLocalScale = var_124_2

		local var_124_1 = arg_124_0.walker._tf

		Vector2 = var_5

		var_124_2(var_124_1, var_5(var_0_39.walker, var_0_39.walker))

		var_124_2 = var_2.path
		math = var_124_1
		var_124_2 = var_124_2[var_124_1.random(1, #var_2.path)]

		local var_124_3 = arg_124_0.walker

		var_4.SetPath(var_124_3, var_124_2)

		local var_124_4 = {}

		if var_124_2 == var_0_27 then
			var_124_4 = {
				8,
				11,
				12,
				14,
				15,
				18,
				17,
				21
			}
		elseif var_124_2 == var_0_25 then
			var_124_4 = {
				5,
				9,
				10,
				14,
				15,
				19,
				20,
				24
			}
		end

		local function var_124_5(arg_125_0)
			ipairs = var_2_10001

			for iter_125_0, iter_125_1 in var_2_10001(var_124_4) do
				if arg_125_0 == iter_125_1 then
					return true
				end
			end

			return false
		end

		local var_124_6 = {}

		ipairs = var_7

		for iter_124_0, iter_124_1 in var_7(arg_124_0.grids) do
			if not var_124_5(iter_124_0) then
				table = var_12

				var_12.insert(var_124_6, iter_124_1)
			end
		end

		arg_124_0.grids = var_124_6
		var_1_10008 = arg_124_0.walker

		var_7.Start(var_1_10008)
	end

	removeAllChildren = var_124_2

	var_124_2(arg_124_0.oilGroups)

	ipairs = var_124_2

	for iter_124_2, iter_124_3 in var_124_2(var_0_38.oil) do
		math = var_1_10008

		if var_1_10008.random() <= iter_124_3.appear then
			for iter_124_4 = 1, iter_124_3.num do
				cloneTplTo = var_1_10013

				local var_124_7 = arg_124_0.obsTpl

				var_1_10013 = var_1_10013(var_14.Find(var_124_7, "oil_Tpl"), arg_124_0.oilGroups, "oil")
				setActive = var_14

				var_14(var_1_10013, true)

				math = var_14

				local var_124_8 = var_14.random(1, #arg_124_0.grids)

				setLocalPosition = var_15

				local var_124_9 = var_1_10013

				Vector2 = var_1_10017

				var_15(var_124_9, var_1_10017(arg_124_0.grids[var_124_8].x, arg_124_0.grids[var_124_8].y))

				setLocalScale = var_15

				local var_124_10 = var_1_10013

				Vector2 = var_1_10017

				var_15(var_124_10, var_1_10017(var_0_39.oil, var_0_39.oil))

				table = var_15

				var_15.remove(arg_124_0.grids, var_124_8)
			end
		end
	end

	removeAllChildren = var_3

	var_3(arg_124_0.cubeGroups)

	ipairs = var_3

	for iter_124_5, iter_124_6 in var_3(var_0_38.cube) do
		math = var_1_10008

		if var_1_10008.random() <= iter_124_6.appear then
			for iter_124_7 = 1, iter_124_6.num do
				cloneTplTo = var_1_10013

				local var_124_11 = arg_124_0.obsTpl

				var_1_10013 = var_1_10013(var_14.Find(var_124_11, "cube_Tpl"), arg_124_0.cubeGroups, "cube")
				setActive = var_14

				var_14(var_1_10013, true)

				math = var_14

				local var_124_12 = var_14.random(1, #arg_124_0.grids)

				setLocalPosition = var_15

				local var_124_13 = var_1_10013

				Vector2 = var_1_10017

				var_15(var_124_13, var_1_10017(arg_124_0.grids[var_124_12].x, arg_124_0.grids[var_124_12].y))

				setLocalScale = var_15

				local var_124_14 = var_1_10013

				Vector2 = var_1_10017

				var_15(var_124_14, var_1_10017(var_0_39.cube, var_0_39.cube))

				table = var_15

				var_15.remove(arg_124_0.grids, var_124_12)
			end
		end
	end

	removeAllChildren = var_3

	var_3(arg_124_0.minerGroups)

	arg_124_0.minerControls = {}
	ipairs = var_3

	for iter_124_8, iter_124_9 in var_3(var_0_38.miner) do
		math = var_1_10008

		if var_1_10008.random() <= iter_124_9.appear then
			for iter_124_10 = 1, iter_124_9.num do
				cloneTplTo = var_1_10013

				local var_124_15 = arg_124_0.obsTpl

				var_1_10013 = var_1_10013(var_14.Find(var_124_15, "miner_Tpl"), arg_124_0.minerGroups, "miner")
				setActive = var_14

				var_14(var_1_10013, true)

				local var_124_16 = var_0_53(var_1_10013, arg_124_0)

				table = var_15

				var_15.insert(arg_124_0.minerControls, var_124_16)

				math = var_15

				local var_124_17 = var_15.random(1, #arg_124_0.grids)

				setLocalPosition = var_16

				local var_124_18 = var_1_10013

				Vector2 = var_1_10018

				var_16(var_124_18, var_1_10018(arg_124_0.grids[var_124_17].x, arg_124_0.grids[var_124_17].y))

				setLocalScale = var_16

				local var_124_19 = var_1_10013

				Vector2 = var_1_10018

				var_16(var_124_19, var_1_10018(var_0_39.miner, var_0_39.miner))

				table = var_16

				var_16.remove(arg_124_0.grids, var_124_17)
			end
		end
	end

	return
end

function var_0_1.obsFadeOut(arg_126_0)
	local var_126_0 = arg_126_0
	local var_126_1 = arg_126_0.managedTween

	LeanTween = var_1_10003

	local var_126_2 = var_1_10003.value

	local function var_126_3()
		setActive = var_2_10000

		var_2_10000(arg_126_0.obsTF, false)

		return
	end

	go = var_1_10005

	local var_126_4 = var_126_1(var_126_0, var_126_2, var_126_3, var_1_10005(arg_126_0.obsTF), 1, 0, 0.5)
	local var_126_5 = var_1.setOnUpdate

	System = var_126_2

	var_126_5(var_126_4, var_126_2.Action_float(function(arg_128_0)
		arg_126_0.obsCanvas.alpha = arg_128_0

		return
	end))

	return
end

function var_0_1.Update(arg_129_0)
	arg_129_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_130_0)
	if arg_130_0.gamePause or arg_130_0.gameEndFlag then
		return
	end

	IsUnityEditor = var_1

	if var_1 then
		-- block empty
	end

	return
end

function var_0_1.changeSpeed(arg_131_0, arg_131_1)
	return
end

function var_0_1.onTimer(arg_132_0)
	local var_132_0 = arg_132_0.curling

	var_1.Step(var_132_0)

	local var_132_1 = arg_132_0.walker

	var_1.Step(var_132_1)
	arg_132_0:updateGameUI()

	return
end

function var_0_1.timerStart(arg_133_0)
	if not arg_133_0.timer.running then
		local var_133_0 = arg_133_0.timer

		var_1.Start(var_133_0)
	end

	return
end

function var_0_1.timerStop(arg_134_0)
	if arg_134_0.timer.running then
		local var_134_0 = arg_134_0.timer

		var_1.Stop(var_134_0)
	end

	return
end

function var_0_1.updateGameUI(arg_135_0)
	setText = var_1_10001

	var_1_10001(arg_135_0.scoreTF, arg_135_0.scoreNum)

	setText = var_1_10001

	var_1_10001(arg_135_0.roundTF, "Round " .. arg_135_0.roundNum)

	return
end

function var_0_1.addScore(arg_136_0, arg_136_1, arg_136_2)
	cloneTplTo = var_1_10003

	local var_136_0 = arg_136_0.gameUI
	local var_136_1 = var_1_10003(var_4.Find(var_136_0, "score_tf"), arg_136_0.scoreGroup)

	if arg_136_2 then
		setLocalPosition = var_4

		var_4(var_136_1, arg_136_2)
	else
		setLocalPosition = var_4

		local var_136_2 = var_136_1

		Vector2 = var_6

		var_4(var_136_2, var_6(432, 144))
	end

	setActive = var_4

	var_4(var_136_1, false)

	setActive = var_4

	var_4(var_136_1, true)

	setText = var_4

	var_4(var_136_1, "+" .. arg_136_1)

	arg_136_0.scoreNum = arg_136_0.scoreNum + arg_136_1

	return
end

function var_0_1.pauseGame(arg_137_0)
	arg_137_0.gamePause = true

	arg_137_0:timerStop()
	arg_137_0:changeSpeed(0)
	arg_137_0:pauseManagedTween()
	arg_137_0:emit(var_0_46)

	return
end

function var_0_1.resumeGame(arg_138_0)
	arg_138_0.gamePause = false

	arg_138_0:changeSpeed(1)
	arg_138_0:timerStart()
	arg_138_0:resumeManagedTween()
	arg_138_0:emit(var_0_47)

	return
end

function var_0_1.nextRoundGame(arg_139_0)
	removeAllChildren = var_1_10001

	var_1_10001(arg_139_0.scoreGroup)

	if arg_139_0.roundNum == 3 then
		arg_139_0:endGame()
	else
		arg_139_0.roundNum = arg_139_0.roundNum + 1

		arg_139_0:CoordinateGrid(arg_139_0.gridTF)
		arg_139_0:staticObsStart()
		arg_139_0:emit(var_0_45)
	end

	return
end

function var_0_1.endGame(arg_140_0)
	if arg_140_0.gameEndFlag then
		return
	end

	arg_140_0:timerStop()

	arg_140_0.gameEndFlag = true
	setActive = var_1

	var_1(arg_140_0.clickMask, true)

	local var_140_0 = arg_140_0
	local var_140_1 = arg_140_0.managedTween

	LeanTween = var_3

	var_140_1(var_140_0, var_3.delayedCall, function()
		arg_140_0.gameEndFlag = false

		local var_141_0 = arg_140_0

		var_141_0.gameStartFlag = false
		setActive = var_141_0

		var_141_0(arg_140_0.clickMask, false)

		local var_141_1 = arg_140_0

		var_0.showEndUI(var_141_1)

		return
	end, 0.1, nil)

	return
end

function var_0_1.showEndUI(arg_142_0)
	setActive = var_1_10001

	var_1_10001(arg_142_0.endUI, true)

	local var_142_0 = arg_142_0.scoreNum

	getProxy = var_2
	MiniGameProxy = var_3

	local var_142_1 = var_2(var_3)
	local var_142_2 = var_2.GetHighScore
	local var_142_3 = arg_142_0
	local var_142_4

	if not var_142_2(var_142_1, arg_142_0.GetMGData(var_142_3).id) or not (#var_2 > 0) or not var_2[1] then
		var_142_4 = 0
	end

	if var_2 then
		local var_142_5 = #var_2
		local var_142_6

		if not (1 < var_142_5) or not var_2[2] then
			var_142_6 = 0
		end

		setActive = var_142_3

		local var_142_7 = arg_142_0.endUI

		var_142_3(var_6.Find(var_142_7, "ad/panel/cur_score/new"), var_142_4 < var_142_0)

		if var_142_4 <= var_142_0 then
			var_142_4 = var_142_0
			getProxy = var_142_3
			MiniGameProxy = var_6

			local var_142_8 = var_142_3(var_6)

			var_5.UpdataHighScore(var_142_8, arg_142_0:GetMGData().id, {
				var_142_4,
				var_142_6
			})
		end

		local var_142_9 = arg_142_0.endUI
		local var_142_10 = var_5.Find(var_142_9, "ad/panel/highest_score")
		local var_142_11 = arg_142_0.endUI
		local var_142_12 = var_6.Find(var_142_11, "ad/panel/cur_score")

		setText = var_142_11

		var_142_11(var_142_10, var_142_4)

		setText = var_142_11

		var_142_11(var_142_12, var_142_0)

		if arg_142_0:getGameTimes() and arg_142_0:getGameTimes() > 0 then
			arg_142_0:SendSuccess(0)
		end

		return
	end
end

function var_0_1.CoordinateGrid(arg_143_0, arg_143_1)
	Vector2 = var_1_10002

	local var_143_0 = var_1_10002(150, 150)
	local var_143_1 = arg_143_1.rect.width
	local var_143_2 = arg_143_1.rect.height

	Vector2 = var_1_10005

	local var_143_3 = var_1_10005(arg_143_1.anchoredPosition.x - var_143_1 / 2, arg_143_1.anchoredPosition.y - var_143_2 / 2)

	math = var_6

	local var_143_4 = var_6.modf(var_143_2 / var_143_0.y)
	local var_143_5 = var_143_2 % var_143_0.y / (var_143_4 + 1)

	math = var_8

	local var_143_6 = var_8.modf(var_143_1 / var_143_0.x)
	local var_143_7 = var_143_1 % var_143_0.x / (var_143_6 + 1)

	arg_143_0.grids = {}

	for iter_143_0 = 1, var_143_6 do
		for iter_143_1 = 1, var_143_4 do
			local var_143_8 = var_143_3.x + iter_143_0 * (var_143_7 + var_143_0.x) - var_143_0.x / 2
			local var_143_9 = var_143_3.y + iter_143_1 * (var_143_5 + var_143_0.y) - var_143_0.y / 2

			table = var_20

			local var_143_10 = var_20.insert
			local var_143_11 = arg_143_0.grids

			Vector2 = var_1_10022

			var_143_10(var_143_11, var_1_10022(var_143_8, var_143_9))
		end
	end

	return
end

function var_0_1.getGameTimes(arg_144_0)
	return arg_144_0:GetMGHubData().count
end

function var_0_1.getGameUsedTimes(arg_145_0)
	return arg_145_0:GetMGHubData().usedtime
end

function var_0_1.getUltimate(arg_146_0)
	return arg_146_0:GetMGHubData().ultimate
end

function var_0_1.getGameTotalTime(arg_147_0)
	local var_147_0 = arg_147_0:GetMGHubData()

	return (var_1.getConfig(var_147_0, "reward_need"))
end

function var_0_1.onBackPressed(arg_148_0)
	if not arg_148_0.gameStartFlag then
		arg_148_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		if arg_148_0.gameEndFlag then
			return
		end

		isActive = var_1

		if var_1(arg_148_0.pauseUI) then
			setActive = var_1

			var_1(arg_148_0.pauseUI, false)
		end

		arg_148_0:pauseGame()

		setActive = var_1

		var_1(arg_148_0.returnUI, true)
	end

	return
end

function var_0_1.willExit(arg_149_0)
	if arg_149_0.handle then
		UpdateBeat = var_1

		var_1:RemoveListener(arg_149_0.handle)
	end

	arg_149_0:cleanManagedTween()

	if arg_149_0.timer and arg_149_0.timer.running then
		local var_149_0 = arg_149_0.timer

		var_1.Stop(var_149_0)
	end

	Time = var_1
	var_1.timeScale = 1
	arg_149_0.timer = nil

	return
end

return var_0_1
