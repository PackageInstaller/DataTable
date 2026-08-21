local var_0_0 = class("CurlingGameView", import("..BaseMiniGameView"))
local var_0_1 = "event:/ui/ddldaoshu2"
local var_0_2 = "event:/ui/taosheng"
local var_0_3 = "event:/ui/minigame_hitcake"
local var_0_4 = "event:/ui/zhengque"
local var_0_5 = "event:/ui/shibai"
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 3
local var_0_9 = {
	20,
	40,
	60
}
local var_0_10 = 4
local var_0_11 = Vector2(-720, 0)
local var_0_12 = {
	-250,
	250
}
local var_0_13 = Vector2(-250, -42)
local var_0_14 = {
	1,
	10,
	30
}
local var_0_15 = 0.2
local var_0_16 = false
local var_0_17 = {
	cube = 0.2,
	miner = 0.2,
	walker = 0.1,
	oil = 0.2,
	wall = 0
}
local var_0_18 = {
	cube = 2,
	miner = 2,
	walker = 2,
	oil = 2,
	wall = 0
}
local var_0_19 = {
	0.5,
	5,
	10
}
local var_0_20 = {
	0.5,
	5,
	10
}
local var_0_21 = Vector2(400, -600)
local var_0_22 = Vector2(400, 500)
local var_0_23 = 2
local var_0_24 = 3
local var_0_25 = 4
local var_0_26 = Vector2(617, -108)
local var_0_27 = 0.7
local var_0_28 = {
	111,
	222,
	333
}
local var_0_29 = {
	3000,
	2000,
	1000
}
local var_0_33 = 4
local var_0_34 = {
	cube = 300,
	miner = 300,
	walker = 900,
	oil = 300,
	wall = 100
}
local var_0_35 = 1
local var_0_36 = {
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
	}
}

;({})[1] = 1
;({})[2] = 2
;({})[3] = 3
;({})[4] = 4
;({
	appear = 1
}).path = {}
;({
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
	}
}).walker = {
	appear = 1
}

local var_0_37 = {
	miner = 3.5,
	cube = 3.5,
	walker = 4.5,
	oil = 3.5
}
local var_0_38 = true
local var_0_39 = "event_push"
local var_0_40 = "event_speed"
local var_0_41 = "event_hit"
local var_0_42 = "event_result"
local var_0_43 = "event_next"
local var_0_44 = "event_game_pause"
local var_0_45 = "event_game_resume"
local var_0_46 = "event_add_score"

local function var_0_47(arg_1_0, arg_1_1)
	({
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0.powerTF = findTF(arg_2_0._tf, "power")
			arg_2_0.powerSlider = GetComponent(arg_2_0.powerTF, typeof(Slider))

			arg_2_0:InitPowerSlider()

			arg_2_0.animator = GetComponent(arg_2_0._tf, typeof(Animator))
			arg_2_0.aniDft = GetComponent(arg_2_0._tf, typeof(DftAniEvent))

			arg_2_0.aniDft:SetTriggerEvent(function()
				arg_2_0:Push()

				return
			end)

			arg_2_0.dragTrigger = GetOrAddComponent(arg_2_0._tf, "EventTriggerListener")

			arg_2_0.dragTrigger:AddPointDownFunc(function(arg_4_0, arg_4_1)
				if not arg_2_0.canClick then
					return
				end

				arg_2_0.canClick = false
				arg_2_0.charging = true
				arg_2_0.originScreenY = arg_4_1.position.y
				arg_2_0.originY = arg_2_0._tf.anchoredPosition.y

				arg_2_0:Charge()

				return
			end)
			arg_2_0.dragTrigger:AddDragFunc(function(arg_5_0, arg_5_1)
				if not arg_2_0.charging then
					return
				end

				local var_5_0 = arg_5_1.position.y - arg_2_0.originScreenY + arg_2_0.originY

				var_5_0 = arg_5_1.position.y - arg_2_0.originScreenY + arg_2_0.originY >= var_0_12[1] and var_5_0 or var_0_12[1]
				var_5_0 = var_5_0 <= var_0_12[2] and var_5_0 or var_0_12[2]

				setLocalPosition(arg_2_0._tf, Vector2(arg_2_0._tf.anchoredPosition.x, var_5_0))

				return
			end)
			arg_2_0.dragTrigger:AddPointUpFunc(function(arg_6_0, arg_6_1)
				if not arg_2_0.charging then
					return
				end

				arg_2_0.charging = false

				arg_2_0.animator:SetInteger("Throw", arg_2_0.phase)
				arg_2_0.animator:SetInteger("Charge", 0)

				return
			end)
			arg_2_0._event:bind(var_0_42, function(arg_7_0, arg_7_1, arg_7_2)
				arg_2_0.animator:SetInteger("Result", arg_7_1.result)

				return
			end)
			arg_2_0._event:bind(var_0_43, function(arg_8_0, arg_8_1, arg_8_2)
				arg_2_0:Reset()
				arg_2_0:Start()

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
			setActive(arg_10_0.powerTF, false)
			setLocalPosition(arg_10_0._tf, var_0_11)
			arg_10_0.animator:SetInteger("Charge", 0)
			arg_10_0.animator:SetInteger("Throw", 0)
			arg_10_0.animator:SetInteger("Result", 0)
			arg_10_0.animator:Play("WaitA")

			arg_10_0.power = 0
			arg_10_0.phase = 0
			arg_10_0.charging = false
			arg_10_0.canClick = false
			arg_10_0.powerSlider.value = 0

			return
		end,
		InitPowerSlider = function(arg_11_0)
			findTF(arg_11_0.powerTF, "progress/green").sizeDelta = Vector2(var_0_9[1] / var_0_9[3] * 162, 24)
			findTF(arg_11_0.powerTF, "progress/green/yellow").sizeDelta = Vector2((var_0_9[2] - var_0_9[1]) / var_0_9[3] * 162, 24)
			findTF(arg_11_0.powerTF, "progress/green/yellow/red").sizeDelta = Vector2((var_0_9[3] - var_0_9[2]) / var_0_9[3] * 162, 24)

			return
		end,
		Charge = function(arg_12_0)
			setActive(arg_12_0.powerTF, true)
			setActive(findTF(arg_12_0.powerTF, "binghu_huoyan"), false)

			arg_12_0.phase = var_0_6

			arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
			LeanTween.value(go(arg_12_0._tf), arg_12_0.power, var_0_9[3], var_0_10):setOnUpdate(System.Action_float(function(arg_13_0)
				arg_12_0.power = arg_13_0
				arg_12_0.powerSlider.value = arg_12_0.power / var_0_9[3]

				if arg_12_0.phase == var_0_6 and arg_12_0.power >= var_0_9[1] then
					arg_12_0.phase = var_0_7

					arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
				elseif arg_12_0.phase == var_0_7 and arg_12_0.power >= var_0_9[2] then
					arg_12_0.phase = var_0_8

					arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
					setActive(findTF(arg_12_0.powerTF, "binghu_huoyan"), true)
				end

				if not arg_12_0.charging then
					LeanTween.cancel(go(arg_12_0._tf))
				end

				return
			end))

			return
		end,
		Push = function(arg_14_0)
			arg_14_0._event:emit(var_0_39, {
				power = arg_14_0.power
			})
			setActive(arg_14_0.powerTF, false)

			return
		end
	}).Ctor({
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0.powerTF = findTF(arg_2_0._tf, "power")
			arg_2_0.powerSlider = GetComponent(arg_2_0.powerTF, typeof(Slider))

			arg_2_0:InitPowerSlider()

			arg_2_0.animator = GetComponent(arg_2_0._tf, typeof(Animator))
			arg_2_0.aniDft = GetComponent(arg_2_0._tf, typeof(DftAniEvent))

			arg_2_0.aniDft:SetTriggerEvent(function()
				arg_2_0:Push()

				return
			end)

			arg_2_0.dragTrigger = GetOrAddComponent(arg_2_0._tf, "EventTriggerListener")

			arg_2_0.dragTrigger:AddPointDownFunc(function(arg_4_0, arg_4_1)
				if not arg_2_0.canClick then
					return
				end

				arg_2_0.canClick = false
				arg_2_0.charging = true
				arg_2_0.originScreenY = arg_4_1.position.y
				arg_2_0.originY = arg_2_0._tf.anchoredPosition.y

				arg_2_0:Charge()

				return
			end)
			arg_2_0.dragTrigger:AddDragFunc(function(arg_5_0, arg_5_1)
				if not arg_2_0.charging then
					return
				end

				local var_5_0 = arg_5_1.position.y - arg_2_0.originScreenY + arg_2_0.originY

				var_5_0 = arg_5_1.position.y - arg_2_0.originScreenY + arg_2_0.originY >= var_0_12[1] and var_5_0 or var_0_12[1]
				var_5_0 = var_5_0 <= var_0_12[2] and var_5_0 or var_0_12[2]

				setLocalPosition(arg_2_0._tf, Vector2(arg_2_0._tf.anchoredPosition.x, var_5_0))

				return
			end)
			arg_2_0.dragTrigger:AddPointUpFunc(function(arg_6_0, arg_6_1)
				if not arg_2_0.charging then
					return
				end

				arg_2_0.charging = false

				arg_2_0.animator:SetInteger("Throw", arg_2_0.phase)
				arg_2_0.animator:SetInteger("Charge", 0)

				return
			end)
			arg_2_0._event:bind(var_0_42, function(arg_7_0, arg_7_1, arg_7_2)
				arg_2_0.animator:SetInteger("Result", arg_7_1.result)

				return
			end)
			arg_2_0._event:bind(var_0_43, function(arg_8_0, arg_8_1, arg_8_2)
				arg_2_0:Reset()
				arg_2_0:Start()

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
			setActive(arg_10_0.powerTF, false)
			setLocalPosition(arg_10_0._tf, var_0_11)
			arg_10_0.animator:SetInteger("Charge", 0)
			arg_10_0.animator:SetInteger("Throw", 0)
			arg_10_0.animator:SetInteger("Result", 0)
			arg_10_0.animator:Play("WaitA")

			arg_10_0.power = 0
			arg_10_0.phase = 0
			arg_10_0.charging = false
			arg_10_0.canClick = false
			arg_10_0.powerSlider.value = 0

			return
		end,
		InitPowerSlider = function(arg_11_0)
			findTF(arg_11_0.powerTF, "progress/green").sizeDelta = Vector2(var_0_9[1] / var_0_9[3] * 162, 24)
			findTF(arg_11_0.powerTF, "progress/green/yellow").sizeDelta = Vector2((var_0_9[2] - var_0_9[1]) / var_0_9[3] * 162, 24)
			findTF(arg_11_0.powerTF, "progress/green/yellow/red").sizeDelta = Vector2((var_0_9[3] - var_0_9[2]) / var_0_9[3] * 162, 24)

			return
		end,
		Charge = function(arg_12_0)
			setActive(arg_12_0.powerTF, true)
			setActive(findTF(arg_12_0.powerTF, "binghu_huoyan"), false)

			arg_12_0.phase = var_0_6

			arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
			LeanTween.value(go(arg_12_0._tf), arg_12_0.power, var_0_9[3], var_0_10):setOnUpdate(System.Action_float(function(arg_13_0)
				arg_12_0.power = arg_13_0
				arg_12_0.powerSlider.value = arg_12_0.power / var_0_9[3]

				if arg_12_0.phase == var_0_6 and arg_12_0.power >= var_0_9[1] then
					arg_12_0.phase = var_0_7

					arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
				elseif arg_12_0.phase == var_0_7 and arg_12_0.power >= var_0_9[2] then
					arg_12_0.phase = var_0_8

					arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
					setActive(findTF(arg_12_0.powerTF, "binghu_huoyan"), true)
				end

				if not arg_12_0.charging then
					LeanTween.cancel(go(arg_12_0._tf))
				end

				return
			end))

			return
		end,
		Push = function(arg_14_0)
			arg_14_0._event:emit(var_0_39, {
				power = arg_14_0.power
			})
			setActive(arg_14_0.powerTF, false)

			return
		end
	})

	return {
		Ctor = function(arg_2_0)
			arg_2_0._tf = arg_1_0
			arg_2_0._event = arg_1_1
			arg_2_0.powerTF = findTF(arg_2_0._tf, "power")
			arg_2_0.powerSlider = GetComponent(arg_2_0.powerTF, typeof(Slider))

			arg_2_0:InitPowerSlider()

			arg_2_0.animator = GetComponent(arg_2_0._tf, typeof(Animator))
			arg_2_0.aniDft = GetComponent(arg_2_0._tf, typeof(DftAniEvent))

			arg_2_0.aniDft:SetTriggerEvent(function()
				arg_2_0:Push()

				return
			end)

			arg_2_0.dragTrigger = GetOrAddComponent(arg_2_0._tf, "EventTriggerListener")

			arg_2_0.dragTrigger:AddPointDownFunc(function(arg_4_0, arg_4_1)
				if not arg_2_0.canClick then
					return
				end

				arg_2_0.canClick = false
				arg_2_0.charging = true
				arg_2_0.originScreenY = arg_4_1.position.y
				arg_2_0.originY = arg_2_0._tf.anchoredPosition.y

				arg_2_0:Charge()

				return
			end)
			arg_2_0.dragTrigger:AddDragFunc(function(arg_5_0, arg_5_1)
				if not arg_2_0.charging then
					return
				end

				local var_5_0 = arg_5_1.position.y - arg_2_0.originScreenY + arg_2_0.originY

				var_5_0 = arg_5_1.position.y - arg_2_0.originScreenY + arg_2_0.originY >= var_0_12[1] and var_5_0 or var_0_12[1]
				var_5_0 = var_5_0 <= var_0_12[2] and var_5_0 or var_0_12[2]

				setLocalPosition(arg_2_0._tf, Vector2(arg_2_0._tf.anchoredPosition.x, var_5_0))

				return
			end)
			arg_2_0.dragTrigger:AddPointUpFunc(function(arg_6_0, arg_6_1)
				if not arg_2_0.charging then
					return
				end

				arg_2_0.charging = false

				arg_2_0.animator:SetInteger("Throw", arg_2_0.phase)
				arg_2_0.animator:SetInteger("Charge", 0)

				return
			end)
			arg_2_0._event:bind(var_0_42, function(arg_7_0, arg_7_1, arg_7_2)
				arg_2_0.animator:SetInteger("Result", arg_7_1.result)

				return
			end)
			arg_2_0._event:bind(var_0_43, function(arg_8_0, arg_8_1, arg_8_2)
				arg_2_0:Reset()
				arg_2_0:Start()

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
			setActive(arg_10_0.powerTF, false)
			setLocalPosition(arg_10_0._tf, var_0_11)
			arg_10_0.animator:SetInteger("Charge", 0)
			arg_10_0.animator:SetInteger("Throw", 0)
			arg_10_0.animator:SetInteger("Result", 0)
			arg_10_0.animator:Play("WaitA")

			arg_10_0.power = 0
			arg_10_0.phase = 0
			arg_10_0.charging = false
			arg_10_0.canClick = false
			arg_10_0.powerSlider.value = 0

			return
		end,
		InitPowerSlider = function(arg_11_0)
			findTF(arg_11_0.powerTF, "progress/green").sizeDelta = Vector2(var_0_9[1] / var_0_9[3] * 162, 24)
			findTF(arg_11_0.powerTF, "progress/green/yellow").sizeDelta = Vector2((var_0_9[2] - var_0_9[1]) / var_0_9[3] * 162, 24)
			findTF(arg_11_0.powerTF, "progress/green/yellow/red").sizeDelta = Vector2((var_0_9[3] - var_0_9[2]) / var_0_9[3] * 162, 24)

			return
		end,
		Charge = function(arg_12_0)
			setActive(arg_12_0.powerTF, true)
			setActive(findTF(arg_12_0.powerTF, "binghu_huoyan"), false)

			arg_12_0.phase = var_0_6

			arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
			LeanTween.value(go(arg_12_0._tf), arg_12_0.power, var_0_9[3], var_0_10):setOnUpdate(System.Action_float(function(arg_13_0)
				arg_12_0.power = arg_13_0
				arg_12_0.powerSlider.value = arg_12_0.power / var_0_9[3]

				if arg_12_0.phase == var_0_6 and arg_12_0.power >= var_0_9[1] then
					arg_12_0.phase = var_0_7

					arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
				elseif arg_12_0.phase == var_0_7 and arg_12_0.power >= var_0_9[2] then
					arg_12_0.phase = var_0_8

					arg_12_0.animator:SetInteger("Charge", arg_12_0.phase)
					setActive(findTF(arg_12_0.powerTF, "binghu_huoyan"), true)
				end

				if not arg_12_0.charging then
					LeanTween.cancel(go(arg_12_0._tf))
				end

				return
			end))

			return
		end,
		Push = function(arg_14_0)
			arg_14_0._event:emit(var_0_39, {
				power = arg_14_0.power
			})
			setActive(arg_14_0.powerTF, false)

			return
		end
	}
end

local function var_0_48(arg_15_0, arg_15_1, arg_15_2)
	({
		Ctor = function(arg_16_0)
			arg_16_0.tpls = arg_15_0
			arg_16_0._event = arg_15_2
			arg_16_0.player = arg_15_1
			arg_16_0.scene = arg_16_0.player.parent

			arg_16_0._event:bind(var_0_39, function(arg_17_0, arg_17_1, arg_17_2)
				if arg_16_0.isPush then
					return
				end

				arg_16_0:Push(arg_17_1.power)

				return
			end)
			arg_16_0._event:bind(var_0_43, function(arg_18_0, arg_18_1, arg_18_2)
				arg_16_0:Reset()
				arg_16_0:Start()

				return
			end)
			arg_16_0._event:bind(var_0_44, function(arg_19_0, arg_19_1, arg_19_2)
				arg_16_0:Pause()

				return
			end)
			arg_16_0._event:bind(var_0_45, function(arg_20_0, arg_20_1, arg_20_2)
				arg_16_0:Resume()

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
				arg_22_0._tf:SetParent(arg_22_0.tpls, false)
				setActive(arg_22_0._tf, false)
			end

			arg_22_0._tf = arg_22_0.tpls:GetChild(math.random(1, 4) - 1)

			setActive(arg_22_0._tf, true)

			arg_22_0.speedTF = findTF(arg_22_0._tf, "speed")

			setActive(arg_22_0.speedTF, var_0_16)

			arg_22_0.animator = GetComponent(arg_22_0._tf, typeof(Animator))
			arg_22_0.rigbody = GetComponent(arg_22_0._tf, "Rigidbody2D")
			arg_22_0.rigbody.velocity = Vector2.zero
			arg_22_0.phyItem = GetComponent(arg_22_0._tf, "Physics2DItem")

			arg_22_0.phyItem.CollisionEnter:RemoveAllListeners()
			arg_22_0.phyItem.CollisionEnter:AddListener(function(arg_23_0)
				arg_22_0:OnCollision(arg_23_0)

				return
			end)

			return
		end,
		Reset = function(arg_24_0)
			arg_24_0:RandomRole()

			arg_24_0.rigbody.velocity = Vector2.zero

			arg_24_0._tf:SetParent(findTF(arg_24_0.player, "chargePos"), false)
			setText(arg_24_0.speedTF, 0)
			setLocalPosition(arg_24_0._tf, Vector2.zero)
			setLocalScale(arg_24_0._tf, Vector2.one)
			arg_24_0.animator:Play("Neutral")
			arg_24_0.animator:SetBool("Stop", false)
			arg_24_0.animator:SetInteger("Result", 0)
			arg_24_0.animator:SetInteger("SpeedPhase", 0)

			arg_24_0.isPush = false
			arg_24_0.isStop = true
			arg_24_0.phase = 0

			return
		end,
		Step = function(arg_25_0)
			if var_0_16 then
				setText(arg_25_0.speedTF, arg_25_0.rigbody.velocity:Magnitude())
			end

			if not arg_25_0.isPush or arg_25_0.isStop then
				return
			end

			local var_25_0 = arg_25_0:GetSpeed()

			arg_25_0._event:emit(var_0_40, {
				speed = var_25_0
			})

			if var_25_0 > var_0_14[1] then
				arg_25_0.animator:SetInteger("SpeedPhase", 1)
			elseif var_25_0 > var_0_14[2] then
				arg_25_0.animator:SetInteger("SpeedPhase", 2)
			elseif var_25_0 > var_0_14[3] then
				arg_25_0.animator:SetInteger("SpeedPhase", 3)
			end

			if var_25_0 < var_0_15 then
				arg_25_0.animator:SetBool("Stop", true)

				arg_25_0.isStop = true

				arg_25_0:Result()
			end

			return
		end,
		Push = function(arg_26_0, arg_26_1)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

			arg_26_0.isPush = true
			arg_26_0.isStop = false

			arg_26_0._tf:SetParent(arg_26_0.scene, true)

			arg_26_0.rigbody.velocity = Vector2(var_0_13.x - arg_26_0._tf.anchoredPosition.x, var_0_13.y - arg_26_0._tf.anchoredPosition.y):Normalize():Mul(arg_26_1)

			arg_26_0:Slip()

			return
		end,
		Slip = function(arg_27_0)
			arg_27_0.animator:SetBool("Stop", false)

			arg_27_0.isStop = false

			return
		end,
		OnCollision = function(arg_28_0, arg_28_1)
			arg_28_0.animator:SetTrigger("Hit")
			arg_28_0._event:emit(var_0_41)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

			local var_28_0 = 0
			local var_28_1 = Vector2(1, 0)
			local var_28_2 = Vector2(arg_28_0.rigbody.velocity.x, arg_28_0.rigbody.velocity.y)

			if arg_28_1.collider.gameObject.name == "wall" then
				var_28_2:Mul(var_0_17.wall)

				var_28_0 = var_0_34.wall

				var_28_1:Mul(var_0_18.wall)
			elseif arg_28_1.collider.gameObject.name == "oil" then
				var_28_2:Mul(var_0_17.oil)

				var_28_0 = var_0_34.oil

				var_28_1:Mul(var_0_18.oil)
			elseif arg_28_1.collider.gameObject.name == "cube" then
				var_28_2:Mul(var_0_17.cube)

				var_28_0 = var_0_34.cube

				var_28_1:Mul(var_0_18.cube)
			elseif arg_28_1.collider.gameObject.name == "miner" then
				var_28_2:Mul(var_0_17.miner)

				var_28_0 = var_0_34.miner

				var_28_1:Mul(var_0_18.miner)
			elseif arg_28_1.collider.gameObject.name == "walker" then
				var_28_2:Mul(var_0_17.walker)

				var_28_0 = var_0_34.walker

				var_28_1:Mul(var_0_18.walker)
			end

			arg_28_0.rigbody.velocity = arg_28_0.rigbody.velocity:Sub(var_28_2)
			arg_28_0.rigbody.velocity = arg_28_0.rigbody.velocity:Add(var_28_1)

			arg_28_0._event:emit(var_0_46, {
				score = var_28_0,
				pos = arg_28_0._tf.anchoredPosition
			})

			return
		end,
		Result = function(arg_29_0)
			local var_29_0 = Vector2.Distance(var_0_26, (Vector2(arg_29_0._tf.anchoredPosition.x, arg_29_0._tf.anchoredPosition.y / var_0_27)))
			local var_29_2 = var_29_0 <= var_0_28[1] and 1 or var_29_0 <= var_0_28[2] and 2 or var_29_0 <= var_0_28[3] and 3 or 4

			arg_29_0.animator:SetInteger("Result", var_29_0 <= var_0_28[1] and 1 or var_29_0 <= var_0_28[2] and 2 or var_29_0 <= var_0_28[3] and 3 or 4)
			arg_29_0._event:emit(var_0_42, {
				result = var_29_2
			})

			if var_29_2 == 0 or var_29_2 == 4 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			return
		end,
		Pause = function(arg_30_0)
			arg_30_0.speedRecord = arg_30_0.rigbody.velocity
			arg_30_0.rigbody.velocity = Vector2.zero
			arg_30_0.animator.speed = 0

			return
		end,
		Resume = function(arg_31_0)
			arg_31_0.rigbody.velocity = arg_31_0.speedRecord
			arg_31_0.animator.speed = 1

			return
		end,
		GetSpeed = function(arg_32_0)
			return arg_32_0.rigbody.velocity:Magnitude()
		end
	}).Ctor({
		Ctor = function(arg_16_0)
			arg_16_0.tpls = arg_15_0
			arg_16_0._event = arg_15_2
			arg_16_0.player = arg_15_1
			arg_16_0.scene = arg_16_0.player.parent

			arg_16_0._event:bind(var_0_39, function(arg_17_0, arg_17_1, arg_17_2)
				if arg_16_0.isPush then
					return
				end

				arg_16_0:Push(arg_17_1.power)

				return
			end)
			arg_16_0._event:bind(var_0_43, function(arg_18_0, arg_18_1, arg_18_2)
				arg_16_0:Reset()
				arg_16_0:Start()

				return
			end)
			arg_16_0._event:bind(var_0_44, function(arg_19_0, arg_19_1, arg_19_2)
				arg_16_0:Pause()

				return
			end)
			arg_16_0._event:bind(var_0_45, function(arg_20_0, arg_20_1, arg_20_2)
				arg_16_0:Resume()

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
				arg_22_0._tf:SetParent(arg_22_0.tpls, false)
				setActive(arg_22_0._tf, false)
			end

			arg_22_0._tf = arg_22_0.tpls:GetChild(math.random(1, 4) - 1)

			setActive(arg_22_0._tf, true)

			arg_22_0.speedTF = findTF(arg_22_0._tf, "speed")

			setActive(arg_22_0.speedTF, var_0_16)

			arg_22_0.animator = GetComponent(arg_22_0._tf, typeof(Animator))
			arg_22_0.rigbody = GetComponent(arg_22_0._tf, "Rigidbody2D")
			arg_22_0.rigbody.velocity = Vector2.zero
			arg_22_0.phyItem = GetComponent(arg_22_0._tf, "Physics2DItem")

			arg_22_0.phyItem.CollisionEnter:RemoveAllListeners()
			arg_22_0.phyItem.CollisionEnter:AddListener(function(arg_23_0)
				arg_22_0:OnCollision(arg_23_0)

				return
			end)

			return
		end,
		Reset = function(arg_24_0)
			arg_24_0:RandomRole()

			arg_24_0.rigbody.velocity = Vector2.zero

			arg_24_0._tf:SetParent(findTF(arg_24_0.player, "chargePos"), false)
			setText(arg_24_0.speedTF, 0)
			setLocalPosition(arg_24_0._tf, Vector2.zero)
			setLocalScale(arg_24_0._tf, Vector2.one)
			arg_24_0.animator:Play("Neutral")
			arg_24_0.animator:SetBool("Stop", false)
			arg_24_0.animator:SetInteger("Result", 0)
			arg_24_0.animator:SetInteger("SpeedPhase", 0)

			arg_24_0.isPush = false
			arg_24_0.isStop = true
			arg_24_0.phase = 0

			return
		end,
		Step = function(arg_25_0)
			if var_0_16 then
				setText(arg_25_0.speedTF, arg_25_0.rigbody.velocity:Magnitude())
			end

			if not arg_25_0.isPush or arg_25_0.isStop then
				return
			end

			local var_25_0 = arg_25_0:GetSpeed()

			arg_25_0._event:emit(var_0_40, {
				speed = var_25_0
			})

			if var_25_0 > var_0_14[1] then
				arg_25_0.animator:SetInteger("SpeedPhase", 1)
			elseif var_25_0 > var_0_14[2] then
				arg_25_0.animator:SetInteger("SpeedPhase", 2)
			elseif var_25_0 > var_0_14[3] then
				arg_25_0.animator:SetInteger("SpeedPhase", 3)
			end

			if var_25_0 < var_0_15 then
				arg_25_0.animator:SetBool("Stop", true)

				arg_25_0.isStop = true

				arg_25_0:Result()
			end

			return
		end,
		Push = function(arg_26_0, arg_26_1)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

			arg_26_0.isPush = true
			arg_26_0.isStop = false

			arg_26_0._tf:SetParent(arg_26_0.scene, true)

			arg_26_0.rigbody.velocity = Vector2(var_0_13.x - arg_26_0._tf.anchoredPosition.x, var_0_13.y - arg_26_0._tf.anchoredPosition.y):Normalize():Mul(arg_26_1)

			arg_26_0:Slip()

			return
		end,
		Slip = function(arg_27_0)
			arg_27_0.animator:SetBool("Stop", false)

			arg_27_0.isStop = false

			return
		end,
		OnCollision = function(arg_28_0, arg_28_1)
			arg_28_0.animator:SetTrigger("Hit")
			arg_28_0._event:emit(var_0_41)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

			local var_28_0 = 0
			local var_28_1 = Vector2(1, 0)
			local var_28_2 = Vector2(arg_28_0.rigbody.velocity.x, arg_28_0.rigbody.velocity.y)

			if arg_28_1.collider.gameObject.name == "wall" then
				var_28_2:Mul(var_0_17.wall)

				var_28_0 = var_0_34.wall

				var_28_1:Mul(var_0_18.wall)
			elseif arg_28_1.collider.gameObject.name == "oil" then
				var_28_2:Mul(var_0_17.oil)

				var_28_0 = var_0_34.oil

				var_28_1:Mul(var_0_18.oil)
			elseif arg_28_1.collider.gameObject.name == "cube" then
				var_28_2:Mul(var_0_17.cube)

				var_28_0 = var_0_34.cube

				var_28_1:Mul(var_0_18.cube)
			elseif arg_28_1.collider.gameObject.name == "miner" then
				var_28_2:Mul(var_0_17.miner)

				var_28_0 = var_0_34.miner

				var_28_1:Mul(var_0_18.miner)
			elseif arg_28_1.collider.gameObject.name == "walker" then
				var_28_2:Mul(var_0_17.walker)

				var_28_0 = var_0_34.walker

				var_28_1:Mul(var_0_18.walker)
			end

			arg_28_0.rigbody.velocity = arg_28_0.rigbody.velocity:Sub(var_28_2)
			arg_28_0.rigbody.velocity = arg_28_0.rigbody.velocity:Add(var_28_1)

			arg_28_0._event:emit(var_0_46, {
				score = var_28_0,
				pos = arg_28_0._tf.anchoredPosition
			})

			return
		end,
		Result = function(arg_29_0)
			local var_29_0 = Vector2.Distance(var_0_26, (Vector2(arg_29_0._tf.anchoredPosition.x, arg_29_0._tf.anchoredPosition.y / var_0_27)))
			local var_29_2 = var_29_0 <= var_0_28[1] and 1 or var_29_0 <= var_0_28[2] and 2 or var_29_0 <= var_0_28[3] and 3 or 4

			arg_29_0.animator:SetInteger("Result", var_29_0 <= var_0_28[1] and 1 or var_29_0 <= var_0_28[2] and 2 or var_29_0 <= var_0_28[3] and 3 or 4)
			arg_29_0._event:emit(var_0_42, {
				result = var_29_2
			})

			if var_29_2 == 0 or var_29_2 == 4 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			return
		end,
		Pause = function(arg_30_0)
			arg_30_0.speedRecord = arg_30_0.rigbody.velocity
			arg_30_0.rigbody.velocity = Vector2.zero
			arg_30_0.animator.speed = 0

			return
		end,
		Resume = function(arg_31_0)
			arg_31_0.rigbody.velocity = arg_31_0.speedRecord
			arg_31_0.animator.speed = 1

			return
		end,
		GetSpeed = function(arg_32_0)
			return arg_32_0.rigbody.velocity:Magnitude()
		end
	})

	return {
		Ctor = function(arg_16_0)
			arg_16_0.tpls = arg_15_0
			arg_16_0._event = arg_15_2
			arg_16_0.player = arg_15_1
			arg_16_0.scene = arg_16_0.player.parent

			arg_16_0._event:bind(var_0_39, function(arg_17_0, arg_17_1, arg_17_2)
				if arg_16_0.isPush then
					return
				end

				arg_16_0:Push(arg_17_1.power)

				return
			end)
			arg_16_0._event:bind(var_0_43, function(arg_18_0, arg_18_1, arg_18_2)
				arg_16_0:Reset()
				arg_16_0:Start()

				return
			end)
			arg_16_0._event:bind(var_0_44, function(arg_19_0, arg_19_1, arg_19_2)
				arg_16_0:Pause()

				return
			end)
			arg_16_0._event:bind(var_0_45, function(arg_20_0, arg_20_1, arg_20_2)
				arg_16_0:Resume()

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
				arg_22_0._tf:SetParent(arg_22_0.tpls, false)
				setActive(arg_22_0._tf, false)
			end

			arg_22_0._tf = arg_22_0.tpls:GetChild(math.random(1, 4) - 1)

			setActive(arg_22_0._tf, true)

			arg_22_0.speedTF = findTF(arg_22_0._tf, "speed")

			setActive(arg_22_0.speedTF, var_0_16)

			arg_22_0.animator = GetComponent(arg_22_0._tf, typeof(Animator))
			arg_22_0.rigbody = GetComponent(arg_22_0._tf, "Rigidbody2D")
			arg_22_0.rigbody.velocity = Vector2.zero
			arg_22_0.phyItem = GetComponent(arg_22_0._tf, "Physics2DItem")

			arg_22_0.phyItem.CollisionEnter:RemoveAllListeners()
			arg_22_0.phyItem.CollisionEnter:AddListener(function(arg_23_0)
				arg_22_0:OnCollision(arg_23_0)

				return
			end)

			return
		end,
		Reset = function(arg_24_0)
			arg_24_0:RandomRole()

			arg_24_0.rigbody.velocity = Vector2.zero

			arg_24_0._tf:SetParent(findTF(arg_24_0.player, "chargePos"), false)
			setText(arg_24_0.speedTF, 0)
			setLocalPosition(arg_24_0._tf, Vector2.zero)
			setLocalScale(arg_24_0._tf, Vector2.one)
			arg_24_0.animator:Play("Neutral")
			arg_24_0.animator:SetBool("Stop", false)
			arg_24_0.animator:SetInteger("Result", 0)
			arg_24_0.animator:SetInteger("SpeedPhase", 0)

			arg_24_0.isPush = false
			arg_24_0.isStop = true
			arg_24_0.phase = 0

			return
		end,
		Step = function(arg_25_0)
			if var_0_16 then
				setText(arg_25_0.speedTF, arg_25_0.rigbody.velocity:Magnitude())
			end

			if not arg_25_0.isPush or arg_25_0.isStop then
				return
			end

			local var_25_0 = arg_25_0:GetSpeed()

			arg_25_0._event:emit(var_0_40, {
				speed = var_25_0
			})

			if var_25_0 > var_0_14[1] then
				arg_25_0.animator:SetInteger("SpeedPhase", 1)
			elseif var_25_0 > var_0_14[2] then
				arg_25_0.animator:SetInteger("SpeedPhase", 2)
			elseif var_25_0 > var_0_14[3] then
				arg_25_0.animator:SetInteger("SpeedPhase", 3)
			end

			if var_25_0 < var_0_15 then
				arg_25_0.animator:SetBool("Stop", true)

				arg_25_0.isStop = true

				arg_25_0:Result()
			end

			return
		end,
		Push = function(arg_26_0, arg_26_1)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_2)

			arg_26_0.isPush = true
			arg_26_0.isStop = false

			arg_26_0._tf:SetParent(arg_26_0.scene, true)

			arg_26_0.rigbody.velocity = Vector2(var_0_13.x - arg_26_0._tf.anchoredPosition.x, var_0_13.y - arg_26_0._tf.anchoredPosition.y):Normalize():Mul(arg_26_1)

			arg_26_0:Slip()

			return
		end,
		Slip = function(arg_27_0)
			arg_27_0.animator:SetBool("Stop", false)

			arg_27_0.isStop = false

			return
		end,
		OnCollision = function(arg_28_0, arg_28_1)
			arg_28_0.animator:SetTrigger("Hit")
			arg_28_0._event:emit(var_0_41)
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_3)

			local var_28_0 = 0
			local var_28_1 = Vector2(1, 0)
			local var_28_2 = Vector2(arg_28_0.rigbody.velocity.x, arg_28_0.rigbody.velocity.y)

			if arg_28_1.collider.gameObject.name == "wall" then
				var_28_2:Mul(var_0_17.wall)

				var_28_0 = var_0_34.wall

				var_28_1:Mul(var_0_18.wall)
			elseif arg_28_1.collider.gameObject.name == "oil" then
				var_28_2:Mul(var_0_17.oil)

				var_28_0 = var_0_34.oil

				var_28_1:Mul(var_0_18.oil)
			elseif arg_28_1.collider.gameObject.name == "cube" then
				var_28_2:Mul(var_0_17.cube)

				var_28_0 = var_0_34.cube

				var_28_1:Mul(var_0_18.cube)
			elseif arg_28_1.collider.gameObject.name == "miner" then
				var_28_2:Mul(var_0_17.miner)

				var_28_0 = var_0_34.miner

				var_28_1:Mul(var_0_18.miner)
			elseif arg_28_1.collider.gameObject.name == "walker" then
				var_28_2:Mul(var_0_17.walker)

				var_28_0 = var_0_34.walker

				var_28_1:Mul(var_0_18.walker)
			end

			arg_28_0.rigbody.velocity = arg_28_0.rigbody.velocity:Sub(var_28_2)
			arg_28_0.rigbody.velocity = arg_28_0.rigbody.velocity:Add(var_28_1)

			arg_28_0._event:emit(var_0_46, {
				score = var_28_0,
				pos = arg_28_0._tf.anchoredPosition
			})

			return
		end,
		Result = function(arg_29_0)
			local var_29_0 = Vector2.Distance(var_0_26, (Vector2(arg_29_0._tf.anchoredPosition.x, arg_29_0._tf.anchoredPosition.y / var_0_27)))
			local var_29_2 = var_29_0 <= var_0_28[1] and 1 or var_29_0 <= var_0_28[2] and 2 or var_29_0 <= var_0_28[3] and 3 or 4

			arg_29_0.animator:SetInteger("Result", var_29_0 <= var_0_28[1] and 1 or var_29_0 <= var_0_28[2] and 2 or var_29_0 <= var_0_28[3] and 3 or 4)
			arg_29_0._event:emit(var_0_42, {
				result = var_29_2
			})

			if var_29_2 == 0 or var_29_2 == 4 then
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_5)
			else
				pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_4)
			end

			return
		end,
		Pause = function(arg_30_0)
			arg_30_0.speedRecord = arg_30_0.rigbody.velocity
			arg_30_0.rigbody.velocity = Vector2.zero
			arg_30_0.animator.speed = 0

			return
		end,
		Resume = function(arg_31_0)
			arg_31_0.rigbody.velocity = arg_31_0.speedRecord
			arg_31_0.animator.speed = 1

			return
		end,
		GetSpeed = function(arg_32_0)
			return arg_32_0.rigbody.velocity:Magnitude()
		end
	}
end

local function var_0_49(arg_33_0, arg_33_1)
	({
		Ctor = function(arg_34_0)
			arg_34_0._tf = arg_33_0
			arg_34_0._event = arg_33_1
			arg_34_0.animator = GetComponent(arg_34_0._tf, typeof(Animator))

			arg_34_0._event:bind(var_0_39, function(arg_35_0, arg_35_1, arg_35_2)
				arg_34_0:TurnLeft()

				return
			end)
			arg_34_0._event:bind(var_0_41, function(arg_36_0, arg_36_1, arg_36_2)
				arg_34_0:Hit()

				return
			end)
			arg_34_0._event:bind(var_0_42, function(arg_37_0, arg_37_1, arg_37_2)
				arg_34_0:Result(arg_37_1.result)

				return
			end)
			arg_34_0._event:bind(var_0_43, function(arg_38_0, arg_38_1, arg_38_2)
				arg_34_0:Reset()
				arg_34_0:Start()

				return
			end)

			return
		end,
		Start = function(arg_39_0)
			return
		end,
		Reset = function(arg_40_0)
			arg_40_0.animator:SetInteger("Result", 0)
			arg_40_0.animator:Play("WaitA")

			return
		end,
		TurnLeft = function(arg_41_0)
			arg_41_0.animator:SetTrigger("TurnLeft")

			return
		end,
		Result = function(arg_42_0, arg_42_1)
			arg_42_0.animator:SetInteger("Result", arg_42_1)

			return
		end,
		Hit = function(arg_43_0)
			arg_43_0.animator:SetTrigger("Hit")

			return
		end
	}).Ctor({
		Ctor = function(arg_34_0)
			arg_34_0._tf = arg_33_0
			arg_34_0._event = arg_33_1
			arg_34_0.animator = GetComponent(arg_34_0._tf, typeof(Animator))

			arg_34_0._event:bind(var_0_39, function(arg_35_0, arg_35_1, arg_35_2)
				arg_34_0:TurnLeft()

				return
			end)
			arg_34_0._event:bind(var_0_41, function(arg_36_0, arg_36_1, arg_36_2)
				arg_34_0:Hit()

				return
			end)
			arg_34_0._event:bind(var_0_42, function(arg_37_0, arg_37_1, arg_37_2)
				arg_34_0:Result(arg_37_1.result)

				return
			end)
			arg_34_0._event:bind(var_0_43, function(arg_38_0, arg_38_1, arg_38_2)
				arg_34_0:Reset()
				arg_34_0:Start()

				return
			end)

			return
		end,
		Start = function(arg_39_0)
			return
		end,
		Reset = function(arg_40_0)
			arg_40_0.animator:SetInteger("Result", 0)
			arg_40_0.animator:Play("WaitA")

			return
		end,
		TurnLeft = function(arg_41_0)
			arg_41_0.animator:SetTrigger("TurnLeft")

			return
		end,
		Result = function(arg_42_0, arg_42_1)
			arg_42_0.animator:SetInteger("Result", arg_42_1)

			return
		end,
		Hit = function(arg_43_0)
			arg_43_0.animator:SetTrigger("Hit")

			return
		end
	})

	return {
		Ctor = function(arg_34_0)
			arg_34_0._tf = arg_33_0
			arg_34_0._event = arg_33_1
			arg_34_0.animator = GetComponent(arg_34_0._tf, typeof(Animator))

			arg_34_0._event:bind(var_0_39, function(arg_35_0, arg_35_1, arg_35_2)
				arg_34_0:TurnLeft()

				return
			end)
			arg_34_0._event:bind(var_0_41, function(arg_36_0, arg_36_1, arg_36_2)
				arg_34_0:Hit()

				return
			end)
			arg_34_0._event:bind(var_0_42, function(arg_37_0, arg_37_1, arg_37_2)
				arg_34_0:Result(arg_37_1.result)

				return
			end)
			arg_34_0._event:bind(var_0_43, function(arg_38_0, arg_38_1, arg_38_2)
				arg_34_0:Reset()
				arg_34_0:Start()

				return
			end)

			return
		end,
		Start = function(arg_39_0)
			return
		end,
		Reset = function(arg_40_0)
			arg_40_0.animator:SetInteger("Result", 0)
			arg_40_0.animator:Play("WaitA")

			return
		end,
		TurnLeft = function(arg_41_0)
			arg_41_0.animator:SetTrigger("TurnLeft")

			return
		end,
		Result = function(arg_42_0, arg_42_1)
			arg_42_0.animator:SetInteger("Result", arg_42_1)

			return
		end,
		Hit = function(arg_43_0)
			arg_43_0.animator:SetTrigger("Hit")

			return
		end
	}
end

local function var_0_50(arg_44_0, arg_44_1)
	({
		Ctor = function(arg_45_0)
			arg_45_0._tf = arg_44_0
			arg_45_0._event = arg_44_1
			arg_45_0.animator = GetComponent(arg_45_0._tf, typeof(Animator))

			arg_45_0._event:bind(var_0_43, function(arg_46_0, arg_46_1, arg_46_2)
				arg_45_0:NextRound()

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
			arg_48_0.animator:SetInteger("Round", 0)
			arg_48_0.animator:Play("IdleA")

			arg_48_0.roundNum = 1

			return
		end,
		NextRound = function(arg_49_0)
			arg_49_0.animator:SetInteger("Round", arg_49_0.roundNum)

			arg_49_0.roundNum = arg_49_0.roundNum == 3 and 1 or arg_49_0.roundNum + 1

			return
		end
	}).Ctor({
		Ctor = function(arg_45_0)
			arg_45_0._tf = arg_44_0
			arg_45_0._event = arg_44_1
			arg_45_0.animator = GetComponent(arg_45_0._tf, typeof(Animator))

			arg_45_0._event:bind(var_0_43, function(arg_46_0, arg_46_1, arg_46_2)
				arg_45_0:NextRound()

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
			arg_48_0.animator:SetInteger("Round", 0)
			arg_48_0.animator:Play("IdleA")

			arg_48_0.roundNum = 1

			return
		end,
		NextRound = function(arg_49_0)
			arg_49_0.animator:SetInteger("Round", arg_49_0.roundNum)

			arg_49_0.roundNum = arg_49_0.roundNum == 3 and 1 or arg_49_0.roundNum + 1

			return
		end
	})

	return {
		Ctor = function(arg_45_0)
			arg_45_0._tf = arg_44_0
			arg_45_0._event = arg_44_1
			arg_45_0.animator = GetComponent(arg_45_0._tf, typeof(Animator))

			arg_45_0._event:bind(var_0_43, function(arg_46_0, arg_46_1, arg_46_2)
				arg_45_0:NextRound()

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
			arg_48_0.animator:SetInteger("Round", 0)
			arg_48_0.animator:Play("IdleA")

			arg_48_0.roundNum = 1

			return
		end,
		NextRound = function(arg_49_0)
			arg_49_0.animator:SetInteger("Round", arg_49_0.roundNum)

			arg_49_0.roundNum = arg_49_0.roundNum == 3 and 1 or arg_49_0.roundNum + 1

			return
		end
	}
end

local function var_0_51(arg_50_0, arg_50_1)
	({
		Ctor = function(arg_51_0)
			arg_51_0._tf = arg_50_0
			arg_51_0._event = arg_50_1
			arg_51_0.config = var_0_36.miner
			arg_51_0.animator = GetComponent(arg_51_0._tf, typeof(Animator))
			arg_51_0.phyItem = GetComponent(arg_51_0._tf, "Physics2DItem")

			arg_51_0.phyItem.CollisionEnter:AddListener(function(arg_52_0)
				arg_51_0:OnCollision()

				return
			end)

			arg_51_0.phyGrazeItem = GetComponent(findTF(arg_51_0._tf, "GrazeCollider"), "Physics2DItem")

			arg_51_0.phyGrazeItem.TriggerEnter:AddListener(function(arg_53_0)
				arg_51_0:OnGrazeTrigger(arg_53_0)

				return
			end)
			arg_51_0._event:bind(var_0_40, function(arg_54_0, arg_54_1, arg_54_2)
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

			if arg_57_0.hitSpeed > var_0_19[3] then
				var_57_0 = 3
			elseif arg_57_0.hitSpeed > var_0_19[2] then
				var_57_0 = 2
			elseif arg_57_0.hitSpeed > var_0_19[1] then
				var_57_0 = 1
			end

			arg_57_0.animator:SetInteger("Speed", var_57_0)
			arg_57_0.animator:SetTrigger("Clash")

			return
		end,
		OnGrazeTrigger = function(arg_58_0, arg_58_1)
			if arg_58_1.gameObject.name ~= "Ayanami" then
				return
			end

			onDelayTick(function()
				if arg_58_0.isClash then
					return
				end

				arg_58_0.animator:SetTrigger("Graze")

				return
			end, 0.3)

			return
		end
	}).Ctor({
		Ctor = function(arg_51_0)
			arg_51_0._tf = arg_50_0
			arg_51_0._event = arg_50_1
			arg_51_0.config = var_0_36.miner
			arg_51_0.animator = GetComponent(arg_51_0._tf, typeof(Animator))
			arg_51_0.phyItem = GetComponent(arg_51_0._tf, "Physics2DItem")

			arg_51_0.phyItem.CollisionEnter:AddListener(function(arg_52_0)
				arg_51_0:OnCollision()

				return
			end)

			arg_51_0.phyGrazeItem = GetComponent(findTF(arg_51_0._tf, "GrazeCollider"), "Physics2DItem")

			arg_51_0.phyGrazeItem.TriggerEnter:AddListener(function(arg_53_0)
				arg_51_0:OnGrazeTrigger(arg_53_0)

				return
			end)
			arg_51_0._event:bind(var_0_40, function(arg_54_0, arg_54_1, arg_54_2)
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

			if arg_57_0.hitSpeed > var_0_19[3] then
				var_57_0 = 3
			elseif arg_57_0.hitSpeed > var_0_19[2] then
				var_57_0 = 2
			elseif arg_57_0.hitSpeed > var_0_19[1] then
				var_57_0 = 1
			end

			arg_57_0.animator:SetInteger("Speed", var_57_0)
			arg_57_0.animator:SetTrigger("Clash")

			return
		end,
		OnGrazeTrigger = function(arg_58_0, arg_58_1)
			if arg_58_1.gameObject.name ~= "Ayanami" then
				return
			end

			onDelayTick(function()
				if arg_58_0.isClash then
					return
				end

				arg_58_0.animator:SetTrigger("Graze")

				return
			end, 0.3)

			return
		end
	})

	return {
		Ctor = function(arg_51_0)
			arg_51_0._tf = arg_50_0
			arg_51_0._event = arg_50_1
			arg_51_0.config = var_0_36.miner
			arg_51_0.animator = GetComponent(arg_51_0._tf, typeof(Animator))
			arg_51_0.phyItem = GetComponent(arg_51_0._tf, "Physics2DItem")

			arg_51_0.phyItem.CollisionEnter:AddListener(function(arg_52_0)
				arg_51_0:OnCollision()

				return
			end)

			arg_51_0.phyGrazeItem = GetComponent(findTF(arg_51_0._tf, "GrazeCollider"), "Physics2DItem")

			arg_51_0.phyGrazeItem.TriggerEnter:AddListener(function(arg_53_0)
				arg_51_0:OnGrazeTrigger(arg_53_0)

				return
			end)
			arg_51_0._event:bind(var_0_40, function(arg_54_0, arg_54_1, arg_54_2)
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

			if arg_57_0.hitSpeed > var_0_19[3] then
				var_57_0 = 3
			elseif arg_57_0.hitSpeed > var_0_19[2] then
				var_57_0 = 2
			elseif arg_57_0.hitSpeed > var_0_19[1] then
				var_57_0 = 1
			end

			arg_57_0.animator:SetInteger("Speed", var_57_0)
			arg_57_0.animator:SetTrigger("Clash")

			return
		end,
		OnGrazeTrigger = function(arg_58_0, arg_58_1)
			if arg_58_1.gameObject.name ~= "Ayanami" then
				return
			end

			onDelayTick(function()
				if arg_58_0.isClash then
					return
				end

				arg_58_0.animator:SetTrigger("Graze")

				return
			end, 0.3)

			return
		end
	}
end

local function var_0_52(arg_60_0, arg_60_1)
	local var_60_0 = 1000

	;({}).Ctor = function(arg_61_0)
		arg_61_0._tf = arg_60_0
		arg_61_0._event = arg_60_1
		arg_61_0.config = var_0_36.walker
		arg_61_0.obstacleTF = arg_61_0._tf.parent
		arg_61_0.bgFrontTF = findTF(arg_61_0.obstacleTF.parent.parent, "bg_front")
		arg_61_0.animator = GetComponent(arg_61_0._tf, typeof(Animator))
		arg_61_0.rigbody = GetComponent(arg_61_0._tf, "Rigidbody2D")
		arg_61_0.phyItem = GetComponent(arg_61_0._tf, "Physics2DItem")

		arg_61_0.phyItem.CollisionEnter:AddListener(function(arg_62_0)
			arg_61_0:OnCollision(arg_62_0)

			return
		end)
		arg_61_0._event:bind(var_0_40, function(arg_63_0, arg_63_1, arg_63_2)
			arg_61_0.hitSpeed = arg_63_1.speed

			return
		end)
		arg_61_0._event:bind(var_0_44, function(arg_64_0, arg_64_1, arg_64_2)
			arg_61_0:Pause()

			return
		end)
		arg_61_0._event:bind(var_0_45, function(arg_65_0, arg_65_1, arg_65_2)
			arg_61_0:Resume()

			return
		end)

		return
	end
	;({}).SetPath = function(arg_66_0, arg_66_1)
		arg_66_0.pathType = arg_66_1

		return
	end
	;({}).Start = function(arg_67_0)
		arg_67_0:WalkPath()

		return
	end
	;({}).Reset = function(arg_68_0)
		setActive(arg_68_0._tf, false)
		setLocalPosition(arg_68_0._tf, Vector2(-1400, 0))

		arg_68_0.rigbody.velocity = Vector2.zero
		arg_68_0.isJumpDown = false
		arg_68_0.isJumpUp = false
		arg_68_0.isForwardNorth = false
		arg_68_0.isForwardSouth = false
		arg_68_0.hitSpeed = 0
		arg_68_0.pathType = 0

		return
	end
	;({}).OnCollision = function(arg_69_0, arg_69_1)
		arg_69_0.animator:SetTrigger("Clash")

		local var_69_0 = 0

		if arg_69_0.hitSpeed > var_0_20[3] then
			var_69_0 = 3
		elseif arg_69_0.hitSpeed > var_0_20[2] then
			var_69_0 = 2
		elseif arg_69_0.hitSpeed > var_0_20[1] then
			var_69_0 = 1
		end

		arg_69_0.animator:SetInteger("Speed", var_69_0)

		arg_69_0.rigbody.velocity = Vector2.zero

		return
	end
	;({}).WalkPath = function(arg_70_0)
		if arg_70_0.pathType == var_0_24 or arg_70_0.pathType == var_0_25 then
			setLocalPosition(arg_70_0._tf, var_0_21)
			arg_70_0._tf:SetParent(arg_70_0.bgFrontTF, false)

			arg_70_0.isForwardNorth = true

			arg_70_0.animator:SetBool("IsNorth", true)
			arg_70_0:WalkNorth()
		elseif arg_70_0.pathType == var_0 or arg_70_0.pathType == var_0_23 then
			setLocalPosition(arg_70_0._tf, var_0_22)
			arg_70_0._tf:SetParent(arg_70_0.obstacleTF, false)

			arg_70_0.isForwardSouth = true

			arg_70_0.animator:SetBool("IsSouth", true)
			arg_70_0:WalkSouth()
		end

		return
	end
	;({}).WalkNorth = function(arg_71_0)
		arg_71_0.animator:SetTrigger("WalkN")

		arg_71_0.rigbody.velocity = Vector2(0, 1.5)

		return
	end
	;({}).JumpNorth = function(arg_72_0)
		arg_72_0.animator:SetTrigger("JumpN")

		if arg_72_0.isJumpUp then
			arg_72_0:WalkNorth()
		elseif arg_72_0.pathType == var_0_25 then
			arg_72_0:WalkNorthwest()
		else
			arg_72_0:WalkNorth()
		end

		return
	end
	;({}).WalkNorthwest = function(arg_73_0)
		arg_73_0.animator:SetTrigger("WalkNW")

		arg_73_0.rigbody.velocity = Vector2(-1.5, 1.5)

		return
	end
	;({}).WalkSouth = function(arg_74_0)
		arg_74_0.animator:SetTrigger("WalkS")

		arg_74_0.rigbody.velocity = Vector2(0, -1.5)

		return
	end
	;({}).JumpSouth = function(arg_75_0)
		arg_75_0.animator:SetTrigger("JumpS")

		if arg_75_0.isJumpDown then
			arg_75_0:WalkSouth()
		elseif arg_75_0.pathType == var_0_23 then
			arg_75_0:WalkSouthwest()
		else
			arg_75_0:WalkSouth()
		end

		return
	end
	;({}).WalkSouthwest = function(arg_76_0)
		arg_76_0.animator:SetTrigger("WalkSW")

		arg_76_0.rigbody.velocity = Vector2(-1.5, -1.5)

		return
	end
	;({}).Step = function(arg_77_0)
		if arg_77_0._tf.anchoredPosition.y > var_60_0 or arg_77_0._tf.anchoredPosition.y < -var_60_0 then
			arg_77_0.rigbody.velocity = Vector2.zero

			return
		end

		if arg_77_0.isForwardNorth then
			if not arg_77_0.isJumpDown and arg_77_0._tf.anchoredPosition.y >= -470 then
				arg_77_0.isJumpDown = true

				arg_77_0:JumpNorth()
				onDelayTick(function()
					arg_77_0._tf:SetParent(arg_77_0.obstacleTF, false)

					return
				end, 0.3)
			end

			if not arg_77_0.isJumpUp and arg_77_0._tf.anchoredPosition.y >= 310 then
				arg_77_0.isJumpUp = true

				arg_77_0:JumpNorth()
			end
		end

		if arg_77_0.isForwardSouth then
			if not arg_77_0.isJumpUp and arg_77_0._tf.anchoredPosition.y <= 370 then
				arg_77_0.isJumpUp = true

				arg_77_0:JumpSouth()
			end

			if not arg_77_0.isJumpDown and arg_77_0._tf.anchoredPosition.y <= -420 then
				arg_77_0.isJumpDown = true

				arg_77_0:JumpSouth()
				onDelayTick(function()
					arg_77_0._tf:SetParent(arg_77_0.bgFrontTF, false)

					return
				end, 0.3)
			end
		end

		return
	end
	;({}).Pause = function(arg_80_0)
		arg_80_0.speedRecord = arg_80_0.rigbody.velocity
		arg_80_0.rigbody.velocity = Vector2.zero
		arg_80_0.animator.speed = 0

		return
	end
	;({}).Resume = function(arg_81_0)
		arg_81_0.rigbody.velocity = arg_81_0.speedRecord
		arg_81_0.animator.speed = 1

		return
	end

	;({}):Ctor()

	return {}
end

function var_0_0.getUIName(arg_82_0)
	return "CurlingGameUI"
end

function var_0_0.didEnter(arg_83_0)
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

function var_0_0.AutoFitScreen(arg_84_0)
	local var_84_0 = 1.7777777777777777 <= Screen.width / Screen.height and math.clamp(1080 * (Screen.width / Screen.height) / 2331, 1, 2) or math.clamp(0 / (Screen.width / Screen.height) / arg_84_0._tf:Find("bg_back").rect.height, 1, 2)

	setLocalScale(arg_84_0._tf, {
		x = var_84_0,
		y = var_84_0,
		z = var_84_0
	})

	return
end

function var_0_0.initEvent(arg_85_0)
	arg_85_0:bind(var_0_42, function(arg_86_0, arg_86_1, arg_86_2)
		if arg_86_1.result ~= var_0_33 then
			arg_85_0:addScore(var_0_29[arg_86_1.result])
		end

		arg_85_0:obsFadeOut()
		onDelayTick(function()
			arg_85_0:nextRoundGame()

			return
		end, var_0_35)

		return
	end)
	arg_85_0:bind(var_0_46, function(arg_88_0, arg_88_1, arg_88_2)
		if arg_88_1.score and arg_88_1.score ~= 0 then
			arg_85_0:addScore(arg_88_1.score, arg_88_1.pos)
		end

		return
	end)

	return
end

function var_0_0.initData(arg_89_0)
	local var_89_0 = Application.targetFrameRate or 60

	if var_89_0 > 60 then
		var_89_0 = 60
	end

	arg_89_0.needManualSimulate = true
	arg_89_0.timer = Timer.New(function()
		arg_89_0:onTimer()

		if arg_89_0.needManualSimulate then
			Physics2D.Simulate(1 / var_89_0)
		end

		return
	end, 1 / var_89_0, -1)

	return
end

function var_0_0.initUI(arg_91_0)
	arg_91_0.clickMask = arg_91_0._tf:Find("ui/click_mask")
	arg_91_0.mainUI = arg_91_0._tf:Find("ui/main_ui")
	arg_91_0.listScrollRect = GetComponent(findTF(arg_91_0.mainUI, "item_list"), typeof(ScrollRect))

	onButton(arg_91_0, arg_91_0.mainUI:Find("skin_btn"), function()
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP, {
			skinId = pg.mini_game[arg_91_0:GetMGData().id].simple_config_data.skin_shop_id
		})

		return
	end, SFX_PANEL)
	onButton(arg_91_0, arg_91_0.mainUI:Find("return_btn"), function()
		arg_91_0:emit(var_0_0.ON_BACK_PRESSED)

		return
	end, SFX_PANEL)
	onButton(arg_91_0, arg_91_0.mainUI:Find("main_btn"), function()
		arg_91_0:emit(var_0_0.ON_HOME)

		return
	end, SFX_PANEL)
	onButton(arg_91_0, arg_91_0.mainUI:Find("help_btn"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.CurlingGame_tips1.tip
		})

		return
	end, SFX_PANEL)
	onButton(arg_91_0, arg_91_0.mainUI:Find("start_btn"), function()
		arg_91_0:readyStart()

		return
	end, SFX_PANEL)
	onButton(arg_91_0, arg_91_0.mainUI:Find("rank_btn"), function()
		return
	end, SFX_PANEL)

	arg_91_0.totalTimes = arg_91_0:getGameTotalTime()

	scrollTo(arg_91_0.listScrollRect, 0, 1 - (arg_91_0:getGameUsedTimes() - 4 < 0 and 0 or arg_91_0:getGameUsedTimes() - 4) / (arg_91_0.totalTimes - 4))
	onButton(arg_91_0, arg_91_0.mainUI:Find("right_panel/arrows_up"), function()
		local var_98_0 = arg_91_0.listScrollRect.normalizedPosition.y + 1 / (arg_91_0.totalTimes - 4)

		if arg_91_0.listScrollRect.normalizedPosition.y + 1 / (arg_91_0.totalTimes - 4) > 1 then
			var_98_0 = 1
		end

		scrollTo(arg_91_0.listScrollRect, 0, var_98_0)

		return
	end, SFX_PANEL)
	onButton(arg_91_0, arg_91_0.mainUI:Find("right_panel/arrows_down"), function()
		local var_99_0 = arg_91_0.listScrollRect.normalizedPosition.y - 1 / (arg_91_0.totalTimes - 4)

		if arg_91_0.listScrollRect.normalizedPosition.y - 1 / (arg_91_0.totalTimes - 4) < 0 then
			var_99_0 = 0
		end

		scrollTo(arg_91_0.listScrollRect, 0, var_99_0)

		return
	end, SFX_PANEL)

	local var_91_0 = arg_91_0.mainUI:Find("item_tpl")

	arg_91_0.itemList = {}

	local var_91_1 = pg.mini_game[arg_91_0:GetMGData().id].simple_config_data.drop

	for iter_91_0 = 1, #var_91_1 do
		local var_91_2 = tf(instantiate(var_91_0))

		var_91_2.name = "item_" .. iter_91_0

		setParent(var_91_2, arg_91_0.mainUI:Find("item_list/Viewport/Content"))
		GetSpriteFromAtlasAsync("ui/minigameui/curlinggameui_atlas", "text_" .. iter_91_0, function(arg_100_0)
			setImageSprite(var_91_2:Find("bg/text"), arg_100_0, true)

			return
		end)
		setActive(var_91_2, true)
		table.insert(arg_91_0.itemList, var_91_2)

		local var_91_3 = var_91_2:Find("award")

		updateDrop(var_91_3, {
			type = var_91_1[iter_91_0][1],
			id = var_91_1[iter_91_0][2],
			count = var_91_1[iter_91_0][3]
		})
		onButton(arg_91_0, var_91_3, function()
			arg_91_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)
	end

	arg_91_0.rankUI = findTF(arg_91_0._tf, "ui/rank_ui")

	arg_91_0:openRankUI(false)
	GetComponent(findTF(arg_91_0.rankUI, "ad/img/score"), typeof(Image)):SetNativeSize()

	arg_91_0._rankImg = findTF(arg_91_0.rankUI, "ad/img")
	arg_91_0._rankBtnClose = findTF(arg_91_0.rankUI, "ad/btnClose")
	arg_91_0._rankContent = findTF(arg_91_0.rankUI, "ad/list/content")
	arg_91_0._rankItemTpl = findTF(arg_91_0.rankUI, "ad/list/content/itemTpl")
	arg_91_0._rankEmpty = findTF(arg_91_0.rankUI, "ad/empty")
	arg_91_0._rankDesc = findTF(arg_91_0.rankUI, "ad/desc")
	arg_91_0._rankItems = {}

	setActive(arg_91_0._rankItemTpl, false)
	onButton(arg_91_0._event, findTF(arg_91_0.rankUI, "ad/close"), function()
		arg_91_0:openRankUI(false)

		return
	end, SFX_CANCEL)
	onButton(arg_91_0._event, arg_91_0._rankBtnClose, function()
		arg_91_0:openRankUI(false)

		return
	end, SFX_CANCEL)
	setText(arg_91_0._rankDesc, i18n("pipe_minigame_rank"))

	arg_91_0.countUI = arg_91_0._tf:Find("ui/count_ui")
	arg_91_0.countAnimator = GetComponent(arg_91_0.countUI:Find("count"), typeof(Animator))
	arg_91_0.countDft = GetOrAddComponent(arg_91_0.countUI:Find("count"), typeof(DftAniEvent))

	arg_91_0.countDft:SetTriggerEvent(function()
		return
	end)
	arg_91_0.countDft:SetEndEvent(function()
		setActive(arg_91_0.countUI, false)
		arg_91_0:startGame()

		return
	end)

	arg_91_0.pauseUI = arg_91_0._tf:Find("ui/pause_ui")

	onButton(arg_91_0, arg_91_0.pauseUI:Find("ad/panel/sure_btn"), function()
		setActive(arg_91_0.pauseUI, false)
		arg_91_0:resumeGame()

		return
	end, SFX_PANEL)

	arg_91_0.returnUI = arg_91_0._tf:Find("ui/return_ui")

	onButton(arg_91_0, arg_91_0.returnUI:Find("ad/panel/sure_btn"), function()
		setActive(arg_91_0.returnUI, false)
		arg_91_0:resumeGame()
		arg_91_0:endGame()

		return
	end, SFX_PANEL)
	onButton(arg_91_0, arg_91_0.returnUI:Find("ad/panel/cancel_btn"), function()
		setActive(arg_91_0.returnUI, false)
		arg_91_0:resumeGame()

		return
	end, SFX_PANEL)

	arg_91_0.endUI = arg_91_0._tf:Find("ui/end_ui")

	onButton(arg_91_0, arg_91_0.endUI:Find("ad/panel/end_btn"), function()
		setActive(arg_91_0.endUI, false)
		arg_91_0:openMainUI()

		return
	end, SFX_PANEL)

	arg_91_0.handle = arg_91_0.handle or UpdateBeat:CreateListener(arg_91_0.Update, arg_91_0)

	UpdateBeat:AddListener(arg_91_0.handle)

	return
end

function var_0_0.initGameUI(arg_110_0)
	arg_110_0.gameUI = arg_110_0._tf:Find("ui/game_ui")
	arg_110_0.roundTF = arg_110_0.gameUI:Find("score_panel/round_text")
	arg_110_0.scoreTF = arg_110_0.gameUI:Find("score_panel/score_text")

	onButton(arg_110_0, arg_110_0.gameUI:Find("pause_btn"), function()
		arg_110_0:pauseGame()
		setActive(arg_110_0.pauseUI, true)

		return
	end)
	onButton(arg_110_0, arg_110_0.gameUI:Find("return_btn"), function()
		arg_110_0:pauseGame()
		setActive(arg_110_0.returnUI, true)

		return
	end)

	arg_110_0.scoreGroup = arg_110_0.gameUI:Find("score_group")

	setActive(arg_110_0._tf:Find("bg_front/wall"), var_0_38)

	return
end

function var_0_0.initController(arg_113_0)
	arg_113_0.scene = arg_113_0._tf:Find("scene")
	arg_113_0.gridTF = arg_113_0._tf:Find("ui/grid")
	arg_113_0.player = var_0_47(arg_113_0.scene:Find("player"), arg_113_0)
	arg_113_0.phy = arg_113_0.scene:Find("Ayanami_phy")
	arg_113_0.drawDot = arg_113_0.scene:Find("draw_dot")
	arg_113_0.curlingTpls = arg_113_0.scene:Find("curling_Tpl")
	arg_113_0.curling = var_0_48(arg_113_0.curlingTpls, arg_113_0.player._tf, arg_113_0)
	arg_113_0.ofunya = var_0_49(arg_113_0._tf:Find("bg_back/07_Ofunya"), arg_113_0)
	arg_113_0.manjuu = var_0_50(arg_113_0._tf:Find("bg_back/08_Manjuu"), arg_113_0)
	arg_113_0.walker = var_0_52(arg_113_0.scene:Find("obstacle/walker"), arg_113_0)
	arg_113_0.obsTF = arg_113_0._tf:Find("scene/obstacle")
	arg_113_0.obsCanvas = GetComponent(arg_113_0.obsTF, typeof(CanvasGroup))
	arg_113_0.obsTpl = arg_113_0._tf:Find("scene/obstacle_Tpl")
	arg_113_0.minerGroups = arg_113_0.obsTF:Find("miner_groups")
	arg_113_0.oilGroups = arg_113_0.obsTF:Find("oil_groups")
	arg_113_0.cubeGroups = arg_113_0.obsTF:Find("cube_groups")

	return
end

function var_0_0.updateMainUI(arg_114_0)
	local var_114_0 = arg_114_0:getGameUsedTimes()
	local var_114_1 = arg_114_0:getGameTimes()

	for iter_114_0 = 1, #arg_114_0.itemList do
		setActive(arg_114_0.itemList[iter_114_0]:Find("lock"), false)
		setActive(arg_114_0.itemList[iter_114_0]:Find("finish"), false)

		if iter_114_0 <= var_114_0 then
			setActive(arg_114_0.itemList[iter_114_0]:Find("finish"), true)
		elseif iter_114_0 == var_114_0 + 1 and var_114_1 >= 1 then
			-- block empty
		elseif var_114_0 < iter_114_0 and iter_114_0 <= var_114_0 + var_114_1 then
			-- block empty
		else
			setActive(arg_114_0.itemList[iter_114_0]:Find("lock"), true)
		end
	end

	arg_114_0.totalTimes = arg_114_0:getGameTotalTime()

	local var_114_2 = 1 - (arg_114_0:getGameUsedTimes() - 3 < 0 and 0 or arg_114_0:getGameUsedTimes() - 3) / (arg_114_0.totalTimes - 4)

	if var_114_2 > 1 then
		var_114_2 = 1
	end

	scrollTo(arg_114_0.listScrollRect, 0, var_114_2)
	arg_114_0:checkGet()

	return
end

function var_0_0.updateRankUI(arg_115_0, arg_115_1)
	for iter_115_0 = 1, #arg_115_1 do
		if iter_115_0 > #arg_115_0._rankItems then
			local var_115_1 = tf(instantiate(arg_115_0._rankItemTpl))

			setActive(var_115_1, false)
			setParent(var_115_1, arg_115_0._rankContent)
			table.insert(arg_115_0._rankItems, var_115_1)
		end

		local var_115_2 = arg_115_0._rankItems[iter_115_0]

		arg_115_0:setRankItemData(arg_115_0._rankItems[iter_115_0], arg_115_1[iter_115_0], iter_115_0)
		setActive(var_115_2, true)
	end

	for iter_115_1 = #arg_115_1 + 1, #arg_115_0._rankItems do
		setActive(arg_115_0._rankItems, false)
	end

	setActive(arg_115_0._rankEmpty, #arg_115_1 == 0)
	setActive(arg_115_0._rankImg, #arg_115_1 > 0)

	return
end

function var_0_0.checkGet(arg_116_0)
	if arg_116_0:getUltimate() == 0 then
		if arg_116_0:getGameTotalTime() > arg_116_0:getGameUsedTimes() then
			return
		end

		pg.m02:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = arg_116_0:GetMGHubData().id,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})
	end

	return
end

function var_0_0.openMainUI(arg_117_0)
	setActive(arg_117_0.gameUI, false)
	setActive(arg_117_0.mainUI, true)
	arg_117_0:updateMainUI()

	return
end

function var_0_0.openRankUI(arg_118_0, arg_118_1)
	setActive(arg_118_0.rankUI, arg_118_1)

	if arg_118_1 then
		pg.m02:sendNotification(GAME.MINI_GAME_FRIEND_RANK, {
			id = arg_118_0:GetMGData().id,
			callback = function(arg_119_0)
				for iter_119_0 = 1, #arg_119_0 do
					for iter_119_1, iter_119_2 in pairs(arg_119_0[iter_119_0]) do
						({})[iter_119_1] = iter_119_2
					end

					table.insert({}, {})
				end

				table.sort({}, function(arg_120_0, arg_120_1)
					if arg_120_0.score ~= arg_120_1.score then
						return arg_120_0.score > arg_120_1.score
					elseif arg_120_0.time_data ~= arg_120_1.time_data then
						return arg_120_0.time_data > arg_120_1.time_data
					else
						return arg_120_0.player_id < arg_120_1.player_id
					end

					return
				end)
				arg_118_0:updateRankUI({})

				return
			end
		})
	end

	return
end

function var_0_0.readyStart(arg_121_0)
	setActive(arg_121_0.mainUI, false)
	setActive(arg_121_0.countUI, true)
	arg_121_0.countAnimator:Play("count")
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_0_1)
	arg_121_0:resetGame()

	return
end

function var_0_0.resetGame(arg_122_0)
	arg_122_0.gameStartFlag = false
	arg_122_0.gamePause = false
	arg_122_0.gameEndFlag = false
	arg_122_0.scoreNum = 0
	arg_122_0.roundNum = 1

	arg_122_0.player:Reset()
	arg_122_0.curling:Reset()
	arg_122_0.ofunya:Reset()
	arg_122_0.manjuu:Reset()
	arg_122_0.walker:Reset()

	return
end

function var_0_0.startGame(arg_123_0)
	setActive(arg_123_0.gameUI, true)
	arg_123_0:CoordinateGrid(arg_123_0.gridTF)

	arg_123_0.gameStartFlag = true

	arg_123_0.player:Start()
	arg_123_0.curling:Start()
	arg_123_0.ofunya:Start()
	arg_123_0.manjuu:Start()
	arg_123_0:staticObsStart()
	arg_123_0:updateGameUI()
	arg_123_0:timerStart()

	return
end

function var_0_0.staticObsStart(arg_124_0)
	setActive(arg_124_0.obsTF, true)

	arg_124_0.obsCanvas.alpha = 1

	arg_124_0.walker:Reset()

	if math.random() <= var_0_36.walker.appear then
		setActive(arg_124_0.walker._tf, true)
		setLocalScale(arg_124_0.walker._tf, Vector2(var_0_37.walker, var_0_37.walker))

		local var_124_0 = var_0_36.walker.path[math.random(1, #var_0_36.walker.path)]

		arg_124_0.walker:SetPath(var_124_0)

		local var_124_1 = {}

		if var_124_0 == var_0_25 then
			var_124_1 = {
				8,
				11,
				12,
				14,
				15,
				18,
				17,
				21
			}
		elseif var_124_0 == var_0_23 then
			var_124_1 = {
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

		for iter_124_0, iter_124_1 in ipairs(arg_124_0.grids) do
			if not var_124_2(iter_124_0) then
				table.insert({}, iter_124_1)
			end
		end

		arg_124_0.grids = {}

		arg_124_0.walker:Start()
	end

	removeAllChildren(arg_124_0.oilGroups)

	for iter_124_2, iter_124_3 in ipairs(var_0_36.oil) do
		if math.random() <= iter_124_3.appear then
			for iter_124_4 = 1, iter_124_3.num do
				local var_124_3 = cloneTplTo(arg_124_0.obsTpl:Find("oil_Tpl"), arg_124_0.oilGroups, "oil")

				setActive(var_124_3, true)

				local var_124_4 = math.random(1, #arg_124_0.grids)

				setLocalPosition(var_124_3, Vector2(arg_124_0.grids[var_124_4].x, arg_124_0.grids[var_124_4].y))
				setLocalScale(var_124_3, Vector2(var_0_37.oil, var_0_37.oil))
				table.remove(arg_124_0.grids, var_124_4)
			end
		end
	end

	removeAllChildren(arg_124_0.cubeGroups)

	for iter_124_5, iter_124_6 in ipairs(var_0_36.cube) do
		if math.random() <= iter_124_6.appear then
			for iter_124_7 = 1, iter_124_6.num do
				local var_124_5 = cloneTplTo(arg_124_0.obsTpl:Find("cube_Tpl"), arg_124_0.cubeGroups, "cube")

				setActive(var_124_5, true)

				local var_124_6 = math.random(1, #arg_124_0.grids)

				setLocalPosition(var_124_5, Vector2(arg_124_0.grids[var_124_6].x, arg_124_0.grids[var_124_6].y))
				setLocalScale(var_124_5, Vector2(var_0_37.cube, var_0_37.cube))
				table.remove(arg_124_0.grids, var_124_6)
			end
		end
	end

	removeAllChildren(arg_124_0.minerGroups)

	arg_124_0.minerControls = {}

	for iter_124_8, iter_124_9 in ipairs(var_0_36.miner) do
		if math.random() <= iter_124_9.appear then
			for iter_124_10 = 1, iter_124_9.num do
				local var_124_7 = cloneTplTo(arg_124_0.obsTpl:Find("miner_Tpl"), arg_124_0.minerGroups, "miner")

				setActive(var_124_7, true)
				table.insert(arg_124_0.minerControls, (var_0_51(var_124_7, arg_124_0)))

				local var_124_8 = math.random(1, #arg_124_0.grids)

				setLocalPosition(var_124_7, Vector2(arg_124_0.grids[var_124_8].x, arg_124_0.grids[var_124_8].y))
				setLocalScale(var_124_7, Vector2(var_0_37.miner, var_0_37.miner))
				table.remove(arg_124_0.grids, var_124_8)
			end
		end
	end

	return
end

function var_0_0.obsFadeOut(arg_126_0)
	arg_126_0:managedTween(LeanTween.value, function()
		setActive(arg_126_0.obsTF, false)

		return
	end, go(arg_126_0.obsTF), 1, 0, 0.5):setOnUpdate(System.Action_float(function(arg_128_0)
		arg_126_0.obsCanvas.alpha = arg_128_0

		return
	end))

	return
end

function var_0_0.Update(arg_129_0)
	arg_129_0:AddDebugInput()

	return
end

function var_0_0.AddDebugInput(arg_130_0)
	if arg_130_0.gamePause or arg_130_0.gameEndFlag then
		return
	end

	if IsUnityEditor then
		-- block empty
	end

	return
end

function var_0_0.changeSpeed(arg_131_0, arg_131_1)
	return
end

function var_0_0.onTimer(arg_132_0)
	arg_132_0.curling:Step()
	arg_132_0.walker:Step()
	arg_132_0:updateGameUI()

	return
end

function var_0_0.timerStart(arg_133_0)
	if not arg_133_0.timer.running then
		arg_133_0.timer:Start()
	end

	return
end

function var_0_0.timerStop(arg_134_0)
	if arg_134_0.timer.running then
		arg_134_0.timer:Stop()
	end

	return
end

function var_0_0.updateGameUI(arg_135_0)
	setText(arg_135_0.scoreTF, arg_135_0.scoreNum)
	setText(arg_135_0.roundTF, "Round " .. arg_135_0.roundNum)

	return
end

function var_0_0.addScore(arg_136_0, arg_136_1, arg_136_2)
	local var_136_0 = cloneTplTo(arg_136_0.gameUI:Find("score_tf"), arg_136_0.scoreGroup)

	if arg_136_2 then
		setLocalPosition(var_136_0, arg_136_2)
	else
		setLocalPosition(var_136_0, Vector2(432, 144))
	end

	setActive(var_136_0, false)
	setActive(var_136_0, true)
	setText(var_136_0, "+" .. arg_136_1)

	arg_136_0.scoreNum = arg_136_0.scoreNum + arg_136_1

	return
end

function var_0_0.pauseGame(arg_137_0)
	arg_137_0.gamePause = true

	arg_137_0:timerStop()
	arg_137_0:changeSpeed(0)
	arg_137_0:pauseManagedTween()
	arg_137_0:emit(var_0_44)

	return
end

function var_0_0.resumeGame(arg_138_0)
	arg_138_0.gamePause = false

	arg_138_0:changeSpeed(1)
	arg_138_0:timerStart()
	arg_138_0:resumeManagedTween()
	arg_138_0:emit(var_0_45)

	return
end

function var_0_0.nextRoundGame(arg_139_0)
	removeAllChildren(arg_139_0.scoreGroup)

	if arg_139_0.roundNum == 3 then
		arg_139_0:endGame()
	else
		arg_139_0.roundNum = arg_139_0.roundNum + 1

		arg_139_0:CoordinateGrid(arg_139_0.gridTF)
		arg_139_0:staticObsStart()
		arg_139_0:emit(var_0_43)
	end

	return
end

function var_0_0.endGame(arg_140_0)
	if arg_140_0.gameEndFlag then
		return
	end

	arg_140_0:timerStop()

	arg_140_0.gameEndFlag = true

	setActive(arg_140_0.clickMask, true)
	arg_140_0:managedTween(LeanTween.delayedCall, function()
		arg_140_0.gameEndFlag = false
		arg_140_0.gameStartFlag = false

		setActive(arg_140_0.clickMask, false)
		arg_140_0:showEndUI()

		return
	end, 0.1, nil)

	return
end

function var_0_0.showEndUI(arg_142_0)
	setActive(arg_142_0.endUI, true)

	local var_142_0 = arg_142_0.scoreNum
	local var_142_1 = getProxy(MiniGameProxy):GetHighScore(arg_142_0:GetMGData().id)

	if var_142_1 and #var_142_1 > 0 then
		local var_142_2 = var_142_1[1] or 0

		if var_142_1 and #var_142_1 > 1 then
			local var_142_3 = var_142_1[2] or 0

			setActive(arg_142_0.endUI:Find("ad/panel/cur_score/new"), var_142_2 < var_142_0)

			if var_142_2 <= var_142_0 then
				var_142_2 = var_142_0

				getProxy(MiniGameProxy):UpdataHighScore(arg_142_0:GetMGData().id, {
					var_142_0,
					var_142_3
				})
			end

			setText(arg_142_0.endUI:Find("ad/panel/highest_score"), var_142_2)
			setText(arg_142_0.endUI:Find("ad/panel/cur_score"), var_142_0)

			if arg_142_0:getGameTimes() and arg_142_0:getGameTimes() > 0 then
				arg_142_0:SendSuccess(0)
			end

			return
		end
	end
end

function var_0_0.CoordinateGrid(arg_143_0, arg_143_1)
	local var_143_0 = Vector2(150, 150)
	local var_143_1 = Vector2(arg_143_1.anchoredPosition.x - arg_143_1.rect.width / 2, arg_143_1.anchoredPosition.y - arg_143_1.rect.height / 2)
	local var_143_2 = math.modf(arg_143_1.rect.height / var_143_0.y)
	local var_143_3 = math.modf(arg_143_1.rect.width / var_143_0.x)

	arg_143_0.grids = {}

	for iter_143_0 = 1, var_143_3 do
		for iter_143_1 = 1, var_143_2 do
			table.insert(arg_143_0.grids, Vector2(var_143_1.x + iter_143_0 * (arg_143_1.rect.width % var_143_0.x / (var_143_3 + 1) + var_143_0.x) - var_143_0.x / 2, var_143_1.y + iter_143_1 * (arg_143_1.rect.height % var_143_0.y / (var_143_2 + 1) + var_143_0.y) - var_143_0.y / 2))
		end
	end

	return
end

function var_0_0.getGameTimes(arg_144_0)
	return arg_144_0:GetMGHubData().count
end

function var_0_0.getGameUsedTimes(arg_145_0)
	return arg_145_0:GetMGHubData().usedtime
end

function var_0_0.getUltimate(arg_146_0)
	return arg_146_0:GetMGHubData().ultimate
end

function var_0_0.getGameTotalTime(arg_147_0)
	return (arg_147_0:GetMGHubData():getConfig("reward_need"))
end

function var_0_0.onBackPressed(arg_148_0)
	if not arg_148_0.gameStartFlag then
		arg_148_0:emit(var_0_0.ON_BACK_PRESSED)
	else
		if arg_148_0.gameEndFlag then
			return
		end

		if isActive(arg_148_0.pauseUI) then
			setActive(arg_148_0.pauseUI, false)
		end

		arg_148_0:pauseGame()
		setActive(arg_148_0.returnUI, true)
	end

	return
end

function var_0_0.willExit(arg_149_0)
	if arg_149_0.handle then
		UpdateBeat:RemoveListener(arg_149_0.handle)
	end

	arg_149_0:cleanManagedTween()

	if arg_149_0.timer and arg_149_0.timer.running then
		arg_149_0.timer:Stop()
	end

	Time.timeScale = 1
	arg_149_0.timer = nil

	return
end

return var_0_0
