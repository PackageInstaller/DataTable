class = var_0_10000

local var_0_0 = "GameRoomHalloweenView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..BaseMiniGameView"))
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 1
local var_0_5 = 2
local var_0_6 = 1
local var_0_7 = 2
local var_0_8 = 1
local var_0_9 = 2
local var_0_10 = {
	{
		3,
		5
	},
	{
		2,
		3
	},
	{
		1.5,
		3
	},
	{
		1,
		2.5
	},
	{
		1,
		2
	},
	{
		0.8,
		1.4
	}
}
local var_0_11 = {
	30,
	80,
	120,
	160,
	180
}
local var_0_12 = {
	4,
	6
}
local var_0_13 = {
	0,
	30
}
local var_0_14 = 0.5
local var_0_15 = {
	{
		10,
		13
	},
	{
		7,
		10
	}
}
local var_0_16 = {
	30
}
local var_0_17 = {
	0,
	3
}
local var_0_18 = {
	1,
	2
}
local var_0_19 = {
	100,
	100,
	100,
	100
}
local var_0_20 = {
	0,
	0,
	0,
	0,
	0,
	0,
	0
}
local var_0_21 = {
	3,
	3.5,
	4,
	4.8,
	5.6,
	6.6,
	8.4
}
local var_0_22 = {
	30,
	80,
	120,
	140,
	160,
	180
}
local var_0_23 = {
	3,
	3.5,
	4,
	4.5,
	4.7,
	5
}
local var_0_24 = {
	30,
	80,
	120,
	160,
	180
}
local var_0_25 = 3
local var_0_26 = {
	110,
	193,
	1170,
	193
}
local var_0_27 = {
	117,
	848,
	1167,
	848
}

Vector2 = var_0_10027

local var_0_28 = var_0_10027(90, 244)
local var_0_29 = 200
local var_0_30 = 5
local var_0_31 = 0
local var_0_32 = 1000000
local var_0_33 = 50000
local var_0_34 = "event:/ui/getcandy"
local var_0_35 = "event:/ui/jackboom"
local var_0_36 = "event:/ui/ddldaoshu2"

local function var_0_37(arg_1_0)
	return
end

function var_0_1.getUIName(arg_2_0)
	return "GameRoomHalloweenUI"
end

function var_0_1.getBGM(arg_3_0)
	return "backyard"
end

local function var_0_38(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}
	local var_4_1 = {
		{
			0,
			4
		},
		{
			4,
			6
		}
	}
	local var_4_2 = 1
	local var_4_3 = -1

	var_4_0.charactorTf = arg_4_0
	var_4_0.moveRanges = arg_4_1
	var_4_0.scene = arg_4_2
	var_4_0.speedX = 0
	var_4_0.direct = 0
	var_4_0.moveRightFlag = false
	var_4_0.moveLeftFlag = false
	var_4_0.charactorIdleCallback = false

	function var_4_0.ctor(arg_5_0)
		findTF = var_2_10001
		arg_5_0.collider = var_2_10001(arg_5_0.charactorTf, "collider")
		findTF = var_1
		arg_5_0.follow = var_1(arg_5_0.charactorTf, "follow")
		GetComponent = var_1
		findTF = var_2

		local var_5_0 = var_2(arg_5_0.charactorTf, "char")

		typeof = var_3
		Animator = var_4
		arg_5_0.charAnimator = var_1(var_5_0, var_3(var_4))
		findTF = var_1
		arg_5_0.posLight = var_1(arg_5_0.charactorTf, "posLight")
		GetComponent = var_1
		findTF = var_2

		local var_5_1 = var_2(arg_5_0.posLight, "char")

		typeof = var_3
		Animator = var_4
		arg_5_0.lightCharAnimator = var_1(var_5_1, var_3(var_4))
		GetComponent = var_1
		findTF = var_5_1

		local var_5_2 = var_5_1(arg_5_0.posLight, "char")

		typeof = var_3
		DftAniEvent = var_4
		arg_5_0.lightCharDft = var_1(var_5_2, var_3(var_4))
		GetComponent = var_1
		findTF = var_5_2

		local var_5_3 = var_5_2(arg_5_0.posLight, "light")

		typeof = var_3
		Animator = var_4
		arg_5_0.lightEffectAnimator = var_1(var_5_3, var_3(var_4))
		GetComponent = var_1
		findTF = var_5_3

		local var_5_4 = var_5_3(arg_5_0.charactorTf, "char")

		typeof = var_3
		DftAniEvent = var_4
		arg_5_0.charactorDft = var_1(var_5_4, var_3(var_4))

		local var_5_5 = arg_5_0.charactorDft

		var_1.SetEndEvent(var_5_5, function(arg_6_0)
			local var_6_0 = arg_5_0

			var_1.onAnimationEnd(var_6_0)

			return
		end)
		arg_5_0:clearData()

		return
	end

	function var_4_0.clearData(arg_7_0)
		arg_7_0.inAction = false
		arg_7_0.direct = 0
		arg_7_0.directType = var_4_2
		arg_7_0.currentDirectType = nil
		arg_7_0.ghostFlag = false
		arg_7_0.ghostPlayFlag = false
		arg_7_0.speedRangeIndex = 1
		arg_7_0.maxSpeed = var_0_12[arg_7_0.speedRangeIndex]
		arg_7_0.playLightFlag = false
		arg_7_0.moveLeftFlag = false
		arg_7_0.moveRightFlag = false
		arg_7_0.speedX = 0

		return
	end

	function var_4_0.setGhostFlag(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_1 and (arg_8_0.ghostFlag or arg_8_0.ghostPlayFlag) then
			return
		end

		arg_8_0:ghostAniCallback(true)

		function arg_8_0.aniCallback(arg_9_0)
			if not arg_9_0 then
				arg_8_0.ghostFlag = arg_8_1
			else
				arg_8_0.ghostFlag = false
			end

			if arg_8_2 then
				arg_8_2()
			end

			return
		end

		if arg_8_1 then
			arg_8_0:playGhostDrump()
		else
			arg_8_0:hideDrumpGhost()

			arg_8_0.ghostPlayFlag = false
			arg_8_0.ghostFlag = false
		end

		return
	end

	function var_4_0.playLight(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0.playLightFlag or arg_10_0.inAction then
			if arg_10_1 then
				arg_10_1(false)
			end

			return
		end

		arg_10_0.playLightFlag = true
		setActive = var_3

		var_3(arg_10_0.posLight, true)

		local var_10_0 = arg_10_0.lightCharDft

		var_3.SetEndEvent(var_10_0, function()
			arg_10_0.playLightFlag = false

			return
		end)

		local var_10_1 = arg_10_0.lightCharDft

		var_3.SetTriggerEvent(var_10_1, function()
			if arg_10_1 then
				arg_10_1(true)
			end

			return
		end)

		if arg_10_2 == var_0_4 then
			local var_10_2 = arg_10_0.lightCharAnimator

			var_3.Play(var_10_2, "charLight", -1, 0)

			local var_10_3 = arg_10_0.lightEffectAnimator

			var_3.Play(var_10_3, "lightOn", -1, 0)
		elseif arg_10_2 == var_0_5 then
			local var_10_4 = arg_10_0.lightCharAnimator

			var_3.Play(var_10_4, "charUnLight", -1, 0)

			local var_10_5 = arg_10_0.lightEffectAnimator

			var_3.Play(var_10_5, "lightOff", -1, 0)
		end

		return
	end

	function var_4_0.ghostAniCallback(arg_13_0, arg_13_1)
		if arg_13_0.aniCallback then
			arg_13_0.aniCallback(arg_13_1)

			arg_13_0.aniCallback = nil
		end

		return
	end

	function var_4_0.hideDrumpGhost(arg_14_0)
		findTF = var_2_10001

		local var_14_0 = var_2_10001(arg_14_0.charactorTf, "ghostContainer/posGhost")

		setActive = var_2

		var_2(var_14_0, false)

		return
	end

	function var_4_0.getGhostFlag(arg_15_0)
		local var_15_0

		if not arg_15_0.ghostFlag then
			var_15_0 = arg_15_0.ghostPlayFlag
		end

		return var_15_0
	end

	function var_4_0.getActionFlag(arg_16_0)
		return arg_16_0.inAction
	end

	function var_4_0.playGhostDrump(arg_17_0)
		arg_17_0.ghostPlayFlag = true
		findTF = var_1

		local var_17_0 = var_1(arg_17_0.charactorTf, "ghostContainer/posGhost")

		setActive = var_2

		var_2(var_17_0, true)

		GetComponent = var_2

		local var_17_1 = var_17_0

		typeof = var_4
		Animator = var_2_10005

		local var_17_2 = var_2(var_17_1, var_4(var_2_10005))

		GetComponent = var_17_1

		local var_17_3 = var_17_0

		typeof = var_2_10005
		DftAniEvent = var_2_10006

		local var_17_4 = var_17_1(var_17_3, var_2_10005(var_2_10006))

		var_3.SetEndEvent(var_17_4, function()
			local var_18_0 = arg_17_0

			var_0.ghostAniCallback(var_18_0)

			setActive = var_0

			var_0(var_17_0, false)

			arg_17_0.ghostPlayFlag = false

			if arg_17_0.inSpecial then
				arg_17_0.currentDirectType = nil

				local var_18_1 = arg_17_0

				var_0.checkPlayerAnimation(var_18_1, true)

				arg_17_0.inSpecial = false
			end

			return
		end)
		var_17_2:Play("drump", -1, 0)

		findTF = var_4

		local var_17_5

		var_17_5, GetComponent = var_4(var_17_0, "drumpGhost/char"), var_5
		typeof = var_7
		Animator = var_8

		local var_17_6 = var_5(var_17_5, var_7(var_8))

		var_5.SetInteger(var_17_6, "state_type", 0)
		var_5:SetInteger("state_type", 3)

		return
	end

	function var_4_0.boom(arg_19_0)
		if arg_19_0.inAction then
			return
		end

		local var_19_0 = "boom"

		if arg_19_0.currentDirectType == var_0_2 then
			var_19_0 = var_19_0 .. "_left"
		else
			var_19_0 = var_19_0 .. "_right"
		end

		if arg_19_0.ghostFlag then
			var_19_0 = var_19_0 .. "_ghost"
		end

		arg_19_0:PlayAniamtion(var_19_0, function()
			local var_20_0 = arg_19_0

			var_0.checkPlayerAnimation(var_20_0, true)

			arg_19_0.inAction = false

			return
		end)

		arg_19_0.inAction = true

		return
	end

	function var_4_0.fail(arg_21_0, arg_21_1)
		if arg_21_0.inAction then
			return
		end

		local var_21_0 = "fail"

		if arg_21_0.currentDirectType == var_0_2 then
			var_21_0 = var_21_0 .. "_left"
		else
			var_21_0 = var_21_0 .. "_right"
		end

		if arg_21_1 == var_0_8 then
			var_21_0 = var_21_0 .. "_miss"
		elseif arg_21_1 == var_0_9 then
			var_21_0 = var_21_0 .. "_boom"
		end

		if arg_21_0.ghostFlag then
			var_21_0 = var_21_0 .. "_ghost"
		end

		arg_21_0:PlayAniamtion(var_21_0, function()
			arg_21_0.inAction = false

			return
		end)

		arg_21_0.inAction = true

		return
	end

	function var_4_0.gameOver(arg_23_0)
		arg_23_0.moveFlag = false

		if arg_23_0.charactorIdleCallback then
			arg_23_0.charactorIdleCallback(false)
		end

		return
	end

	function var_4_0.start(arg_24_0)
		arg_24_0.moveFlag = true
		arg_24_0.startTime = var_0_31

		arg_24_0:clearData()

		return
	end

	function var_4_0.step(arg_25_0)
		if not arg_25_0.moveFlag then
			return
		end

		if not arg_25_0.inAction then
			if arg_25_0.direct ~= 0 then
				local var_25_0 = arg_25_0.maxSpeed

				math = var_2_10002

				if var_25_0 - var_2_10002.abs(arg_25_0.speedX) < var_0_14 then
					arg_25_0.speedX = arg_25_0.maxSpeed * arg_25_0.direct
				else
					math = var_1

					if var_1.abs(arg_25_0.speedX) ~= arg_25_0.maxSpeed then
						math = var_1
						arg_25_0.speedX = (var_1.abs(arg_25_0.speedX) + var_0_14) * arg_25_0.direct
					end
				end

				local var_25_1 = arg_25_0.ghostFlag and 0.5 or 1
				local var_25_2

				if arg_25_0.charactorTf.localPosition.x + arg_25_0.speedX * var_25_1 < arg_25_0.moveRanges[1] then
					var_25_2 = arg_25_0.moveRanges[1]
				end

				if var_25_2 > arg_25_0.moveRanges[3] then
					var_25_2 = arg_25_0.moveRanges[3]
				end

				local var_25_3 = arg_25_0.charactorTf

				Vector3 = var_2_10004
				var_25_3.localPosition = var_2_10004(var_25_2, arg_25_0.charactorTf.localPosition.y, arg_25_0.charactorTf.localPosition.z)
			end

			arg_25_0:checkPlayerAnimation()
		end

		if arg_25_0.speedRangeIndex < #var_0_13 then
			for iter_25_0 = #var_0_13, 1, -1 do
				if var_0_31 - arg_25_0.startTime > var_0_13[iter_25_0] and arg_25_0.speedRangeIndex ~= iter_25_0 then
					var_0_37("角色速度提升")

					arg_25_0.speedRangeIndex = iter_25_0
					arg_25_0.maxSpeed = var_0_12[arg_25_0.speedRangeIndex]

					break
				end
			end
		end

		if arg_25_0.speedX == 0 and not arg_25_0.ghostFlag and not arg_25_0.inAction then
			if arg_25_0.specialTime then
				if var_0_31 - arg_25_0.specialTime >= 7 then
					arg_25_0.specialTime = nil
					arg_25_0.inSpecial = true

					arg_25_0:PlayAniamtion("special", function()
						arg_25_0.currentDirectType = nil

						local var_26_0 = arg_25_0

						var_0.checkPlayerAnimation(var_26_0, true)

						arg_25_0.inSpecial = false

						return
					end)
				end
			else
				arg_25_0.specialTime = var_0_31
			end
		else
			arg_25_0.specialTime = nil
		end

		if arg_25_0.speedX == 0 and not arg_25_0.inAction then
			if arg_25_0.idleTime then
				if var_0_31 - arg_25_0.idleTime >= 5 then
					arg_25_0.idleTime = nil

					if arg_25_0.charactorIdleCallback then
						arg_25_0.charactorIdleCallback(true)
					end
				end
			else
				arg_25_0.idleTime = var_0_31
			end
		else
			arg_25_0.idleTime = nil

			if arg_25_0.charactorIdleCallback then
				arg_25_0.charactorIdleCallback(false)
			end
		end

		return
	end

	function var_4_0.checkPlayerAnimation(arg_27_0, arg_27_1)
		if arg_27_0.currentDirectType ~= arg_27_0.directType or arg_27_1 then
			arg_27_0.currentDirectType = arg_27_0.directType

			if arg_27_0.currentDirectType == var_0_3 then
				arg_27_0:PlayAniamtion("idle_right")
			else
				arg_27_0:PlayAniamtion("idle_left")
			end
		end

		local var_27_0

		if arg_27_0.speedX == 0 then
			var_27_0 = 0
		else
			for iter_27_0 = 1, #var_4_1 do
				local var_27_1 = var_4_1[iter_27_0]

				math = var_2_10008

				if var_2_10008.abs(arg_27_0.speedX) ~= 0 and arg_27_0.maxSpeed > var_27_1[1] and arg_27_0.maxSpeed <= var_27_1[2] then
					var_27_0 = iter_27_0
				end
			end
		end

		local var_27_2 = arg_27_0.charAnimator

		if var_3.GetInteger(var_27_2, "speed_type") ~= var_27_0 then
			local var_27_3 = arg_27_0.charAnimator

			var_3.SetInteger(var_27_3, "speed_type", var_27_0)
		end

		local var_27_4 = arg_27_0.charAnimator

		if var_3.GetBool(var_27_4, "ghost") ~= arg_27_0.ghostFlag then
			local var_27_5 = arg_27_0.charAnimator

			var_3.SetBool(var_27_5, "ghost", arg_27_0.ghostFlag)
		end

		return
	end

	function var_4_0.PlayAniamtion(arg_28_0, arg_28_1, arg_28_2)
		var_0_37("开始播放动作:" .. arg_28_1)

		local var_28_0 = arg_28_0.charAnimator

		var_3.Play(var_28_0, arg_28_1, -1, 0)

		if arg_28_0.onAniCallback then
			var_0_37(arg_28_0.onAniamtionName .. "的animation被" .. arg_28_1 .. "中断")
		end

		arg_28_0.onAniamtionName = arg_28_1
		arg_28_0.onAniCallback = arg_28_2

		return
	end

	function var_4_0.onAnimationEnd(arg_29_0)
		var_0_37("动作播放结束:" .. arg_29_0.onAniamtionName)

		if arg_29_0.onAniCallback then
			local var_29_0 = arg_29_0.onAniCallback

			arg_29_0.onAniCallback = nil

			var_29_0()
		end

		return
	end

	function var_4_0.onDirectChange(arg_30_0, arg_30_1, arg_30_2)
		if not arg_30_0.moveFlag then
			return
		end

		if arg_30_0.inSpecial then
			arg_30_0.currentDirectType = nil

			arg_30_0:checkPlayerAnimation(true)

			arg_30_0.inSpecial = false
		end

		if arg_30_1 == var_0_2 then
			arg_30_0.moveLeftFlag = arg_30_2
		elseif arg_30_1 == var_0_3 then
			arg_30_0.moveRightFlag = arg_30_2
		end

		local var_30_0

		if arg_30_2 then
			var_30_0 = arg_30_1 == var_0_2 and var_4_3 or var_4_2
		else
			var_30_0 = arg_30_0.moveRightFlag and 1 or arg_30_0.moveLeftFlag and -1 or 0
		end

		if arg_30_0.direct ~= var_30_0 or var_30_0 == 0 then
			arg_30_0.speedX = 0
		end

		arg_30_0.direct = var_30_0

		if arg_30_0.direct ~= 0 then
			local var_30_1

			if arg_30_0.direct ~= var_4_3 or not var_0_2 then
				var_30_1 = var_0_3
			end

			arg_30_0.directType = var_30_1
		end

		return
	end

	function var_4_0.getCollider(arg_31_0)
		if not arg_31_0.collider then
			-- block empty
		end

		local var_31_0 = arg_31_0.collider.sizeDelta.x
		local var_31_1 = arg_31_0.collider.sizeDelta.y
		local var_31_2 = arg_31_0.collider.position
		local var_31_3 = arg_31_0.scene

		var_4.x = var_4.InverseTransformPoint(var_31_3, var_31_2.x, var_31_2.y, 0).x - var_31_0 / 2

		return {
			pos = var_4,
			width = var_31_0,
			height = var_31_1
		}
	end

	function var_4_0.getFollowPos(arg_32_0)
		return arg_32_0.follow.position
	end

	function var_4_0.getLeavePos(arg_33_0)
		local var_33_0

		if arg_33_0.ghostPlayFlag then
			findTF = var_2
			var_33_0 = var_2(arg_33_0.charactorTf, "ghostContainer/posGhost").position

			var_0_37("播放动画中，获取幽灵当前位置")
		else
			if not arg_33_0.leavePos then
				findTF = var_2
				arg_33_0.leavePos = var_2(arg_33_0.charactorTf, "posGhostLeave")
			end

			var_33_0 = arg_33_0.leavePos.position

			var_0_37("播放动画结束，获取头顶位置")
		end

		return var_33_0
	end

	function var_4_0.clearDirect(arg_34_0)
		arg_34_0.direct = 0
		arg_34_0.speedX = 0

		return
	end

	var_4_0:ctor()

	return var_4_0
end

local function var_0_39(arg_35_0, arg_35_1)
	local var_35_0 = {
		moveTf = arg_35_0,
		useLightTf = arg_35_1
	}

	var_35_0.initFlag = false
	var_35_0.direct = 0
	var_35_0.pointChangeCallback = nil
	var_35_0.pointUpCallback = nil
	var_35_0.pointLightCallback = nil
	var_35_0.lightTime = nil

	function var_35_0.Ctor(arg_36_0)
		GetOrAddComponent = var_2_10001
		arg_36_0.buttonDelegate = var_2_10001(arg_36_0.useLightTf, "EventTriggerListener")

		local var_36_0 = arg_36_0.buttonDelegate

		var_1.AddPointDownFunc(var_36_0, function(arg_37_0, arg_37_1)
			local var_37_0

			if not arg_36_0.lightTime or var_0_31 - arg_36_0.lightTime > var_0_30 then
				var_37_0 = var_0_4
				arg_36_0.lightTime = var_0_31
			else
				var_37_0 = var_0_5
			end

			if arg_36_0.pointLightCallback then
				arg_36_0.pointLightCallback(var_37_0)
			end

			return
		end)

		GetOrAddComponent = var_1
		findTF = var_36_0
		arg_36_0.delegateLeft = var_1(var_36_0(arg_36_0.moveTf, "left"), "EventTriggerListener")
		GetOrAddComponent = var_1
		findTF = var_2
		arg_36_0.delegateRight = var_1(var_2(arg_36_0.moveTf, "right"), "EventTriggerListener")

		local var_36_1 = arg_36_0.delegateLeft

		var_1.AddPointDownFunc(var_36_1, function(arg_38_0, arg_38_1)
			if arg_36_0.pointChangeCallback then
				arg_36_0.pointChangeCallback(var_0_2)
			end

			return
		end)

		local var_36_2 = arg_36_0.delegateRight

		var_1.AddPointDownFunc(var_36_2, function(arg_39_0, arg_39_1)
			if arg_36_0.pointChangeCallback then
				arg_36_0.pointChangeCallback(var_0_3)
			end

			return
		end)

		local var_36_3 = arg_36_0.delegateLeft

		var_1.AddPointUpFunc(var_36_3, function(arg_40_0, arg_40_1)
			if arg_36_0.pointUpCallback then
				arg_36_0.pointUpCallback(var_0_2)
			end

			return
		end)

		local var_36_4 = arg_36_0.delegateRight

		var_1.AddPointUpFunc(var_36_4, function(arg_41_0, arg_41_1)
			if arg_36_0.pointUpCallback then
				arg_36_0.pointUpCallback(var_0_3)
			end

			return
		end)

		arg_36_0.initFlag = true

		return
	end

	function var_35_0.callbackDirect(arg_42_0, arg_42_1, arg_42_2)
		if not arg_42_2 then
			return
		end

		local var_42_0 = arg_42_0:getPointFromEventData(arg_42_1)

		var_0_37(var_42_0.x .. "  " .. var_42_0.y)

		local var_42_1 = arg_42_0:getDirect(var_42_0)

		arg_42_2(var_42_1)

		return
	end

	function var_35_0.getPointFromEventData(arg_43_0, arg_43_1)
		if not arg_43_0.uiCam then
			GameObject = var_2

			local var_43_0 = var_2.Find("UICamera")

			arg_43_0.uiCam = var_2.GetComponent(var_43_0, "Camera")
		end

		local var_43_1 = arg_43_0.uiCam
		local var_43_2 = var_2.ScreenToWorldPoint(var_43_1, arg_43_1.position)
		local var_43_3 = arg_43_0.moveTf

		return (var_3.InverseTransformPoint(var_43_3, var_43_2))
	end

	function var_35_0.getDirect(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_0.moveTf.sizeDelta.x
		local var_44_1 = arg_44_0.moveTf.sizeDelta.y

		if arg_44_1.x >= 0 then
			return var_0_3
		else
			return var_0_2
		end

		return
	end

	function var_35_0.changeRemind(arg_45_0, arg_45_1)
		arg_45_0.remindFlag = arg_45_1
		GetComponent = var_2_10002

		local var_45_0 = arg_45_0.useLightTf

		typeof = var_2_10004
		Animator = var_2_10005

		local var_45_1 = var_2_10002(var_45_0, var_2_10004(var_2_10005))

		if arg_45_1 then
			isActive = var_45_0
			findTF = var_4

			if var_45_0(var_4(arg_45_0.useLightTf, "light")) then
				var_45_1:Play("useLightRemind", -1, 0)

				goto label_45_0
			end
		end

		var_45_1:Play("useLightIdle", -1, 0)

		::label_45_0::

		return
	end

	function var_35_0.start(arg_46_0)
		setActive = var_2_10001
		findTF = var_2_10002

		var_2_10001(var_2_10002(arg_46_0.useLightTf, "light"), true)

		arg_46_0.lightTime = nil

		return
	end

	function var_35_0.step(arg_47_0)
		if arg_47_0.lightTime then
			local var_47_0 = var_0_31 - arg_47_0.lightTime

			if var_0_30 < var_47_0 then
				isActive = var_47_0
				findTF = var_2_10002

				if not var_47_0(var_2_10002(arg_47_0.useLightTf, "light")) then
					setActive = var_47_0
					findTF = var_2_10002

					var_47_0(var_2_10002(arg_47_0.useLightTf, "light"), true)

					var_2_10002 = arg_47_0

					arg_47_0.changeRemind(var_2_10002, arg_47_0.remindFlag)
				end
			else
				isActive = var_47_0
				findTF = var_2_10002

				if var_47_0(var_2_10002(arg_47_0.useLightTf, "light")) then
					setActive = var_1
					findTF = var_2

					var_1(var_2(arg_47_0.useLightTf, "light"), false)
				end
			end

			return
		end
	end

	function var_35_0.gameOver(arg_48_0)
		setActive = var_2_10001
		findTF = var_2_10002

		var_2_10001(var_2_10002(arg_48_0.useLightTf, "light"), false)

		return
	end

	function var_35_0.destroy(arg_49_0)
		if arg_49_0.delegateLeft then
			ClearEventTrigger = var_1

			var_1(arg_49_0.delegateLeft)
		end

		if arg_49_0.delegateRight then
			ClearEventTrigger = var_1

			var_1(arg_49_0.delegateRight)
		end

		return
	end

	var_35_0:Ctor()

	return var_35_0
end

local function var_0_40(arg_50_0, arg_50_1)
	local var_50_0 = {
		_tf = arg_50_0,
		moveRange = arg_50_1
	}

	var_50_0.targetX = nil
	var_50_0.speedX = 1
	var_50_0.dropCallback = nil
	var_50_0.dropNum = 0

	function var_50_0.Ctor(arg_51_0)
		GetComponent = var_2_10001
		findTF = var_2_10002

		local var_51_0 = var_2_10002(arg_51_0._tf, "char/body")

		typeof = var_3
		Animator = var_4
		arg_51_0.bodyAnimator = var_2_10001(var_51_0, var_3(var_4))
		GetComponent = var_1
		findTF = var_51_0

		local var_51_1 = var_51_0(arg_51_0._tf, "char/body")

		typeof = var_3
		DftAniEvent = var_4
		arg_51_0.bodyDft = var_1(var_51_1, var_3(var_4))

		local var_51_2 = arg_51_0.bodyDft

		var_1.SetEndEvent(var_51_2, function()
			local var_52_0 = arg_51_0

			var_0.dropEnd(var_52_0)

			return
		end)

		local var_51_3 = arg_51_0.bodyDft

		var_1.SetTriggerEvent(var_51_3, function()
			local var_53_0 = arg_51_0

			var_0.dropItem(var_53_0)

			return
		end)

		return
	end

	function var_50_0.start(arg_54_0)
		arg_54_0.moveFlag = true
		arg_54_0.speedLevel = 1

		return
	end

	function var_50_0.gameOver(arg_55_0)
		arg_55_0.moveFlag = false

		return
	end

	function var_50_0.step(arg_56_0)
		if not arg_56_0.moveFlag then
			return
		end

		if arg_56_0.targetX then
			local var_56_0

			if arg_56_0.targetX ~= arg_56_0._tf.localPosition.x then
				var_56_0 = arg_56_0.targetX

				if arg_56_0._tf.localPosition.x < var_56_0 then
					var_56_0 = arg_56_0._tf
					Vector3 = var_2
					var_56_0.localPosition = var_2(arg_56_0._tf.localPosition.x + arg_56_0:getSpeed(), arg_56_0._tf.localPosition.y, arg_56_0._tf.localPosition.z)
				else
					var_56_0 = arg_56_0._tf
					Vector3 = var_2
					var_56_0.localPosition = var_2(arg_56_0._tf.localPosition.x - arg_56_0:getSpeed(), arg_56_0._tf.localPosition.y, arg_56_0._tf.localPosition.z)
				end
			end

			math = var_56_0

			if var_56_0.abs(arg_56_0.targetX - arg_56_0._tf.localPosition.x) <= arg_56_0:getSpeed() then
				arg_56_0.targetX = nil
			end
		end

		if not arg_56_0.targetX then
			arg_56_0:setNextTarget()
		end

		if arg_56_0.speedLevel < #var_0_23 and var_0_24[arg_56_0.speedLevel] < var_0_31 then
			arg_56_0.speedLevel = arg_56_0.speedLevel + 1
		end

		return
	end

	function var_50_0.getSpeed(arg_57_0)
		return var_0_23[arg_57_0.speedLevel]
	end

	function var_50_0.dropItem(arg_58_0)
		if arg_58_0.dropCallback then
			arg_58_0.dropCallback()
		end

		return
	end

	function var_50_0.dropEnd(arg_59_0)
		if arg_59_0.dropNum > 0 then
			arg_59_0.dropNum = arg_59_0.dropNum - 1
		end

		local var_59_0 = arg_59_0.bodyAnimator

		var_1.SetInteger(var_59_0, "dropNums", arg_59_0.dropNum)

		return
	end

	function var_50_0.addDropNum(arg_60_0)
		arg_60_0.dropNum = arg_60_0.dropNum + 1

		local var_60_0 = arg_60_0.bodyAnimator

		var_1.SetInteger(var_60_0, "dropNums", arg_60_0.dropNum)

		return
	end

	function var_50_0.setNextTarget(arg_61_0)
		if not arg_61_0.targetX then
			if arg_61_0._tf.localPosition.x < arg_61_0.moveRange[3] / 3 then
				math = var_2
				arg_61_0.targetX = var_2.random(arg_61_0.moveRange[3] * 2 / 3, arg_61_0.moveRange[3])
			else
				math = var_2
				arg_61_0.targetX = var_2.random(arg_61_0.moveRange[1], arg_61_0.moveRange[3] / 3)
			end
		end

		local var_61_0 = arg_61_0._tf.localPosition.x

		if arg_61_0.targetX < var_61_0 then
			local var_61_1 = arg_61_0._tf

			Vector3 = var_2
			var_61_1.localScale = var_2(-1, 1, 1)
		else
			local var_61_2 = arg_61_0._tf

			Vector3 = var_2
			var_61_2.localScale = var_2(1, 1, 1)
		end

		return
	end

	function var_50_0.getDropWorldPos(arg_62_0)
		if not arg_62_0.posDrop then
			findTF = var_1
			arg_62_0.posDrop = var_1(arg_62_0._tf, "char/posDrop")
		end

		return arg_62_0.posDrop.position
	end

	function var_50_0.clear(arg_63_0)
		arg_63_0.dropNum = 0
		arg_63_0.dropCallback = nil

		return
	end

	var_50_0:Ctor()

	return var_50_0
end

local function var_0_41()
	local var_64_0 = {}

	var_64_0.speedLevel = 1
	var_64_0.dropRequestCallback = nil

	function var_64_0.start(arg_65_0)
		arg_65_0.startFlag = true
		arg_65_0.speedLevel = 1
		arg_65_0.startTime = var_0_31

		return
	end

	function var_64_0.gameOver(arg_66_0)
		arg_66_0.startFlag = false
		arg_66_0.stepTime = nil
		arg_66_0.speedLevel = nil

		return
	end

	function var_64_0.step(arg_67_0)
		if not arg_67_0.startFlag then
			return
		end

		if not arg_67_0.stepTime then
			local var_67_0 = arg_67_0.startTime

			math = var_2_10002
			arg_67_0.stepTime = var_67_0 + var_2_10002.random() * (var_0_10[arg_67_0.speedLevel][1] - var_0_10[arg_67_0.speedLevel][2]) + var_0_10[arg_67_0.speedLevel][1]
		else
			local var_67_1 = var_0_31

			if arg_67_0.stepTime <= var_67_1 then
				local var_67_2 = var_0_31

				math = var_2
				arg_67_0.stepTime = var_67_2 + var_2.random(var_0_10[arg_67_0.speedLevel][1], var_0_10[arg_67_0.speedLevel][2])

				if arg_67_0.dropRequestCallback then
					arg_67_0.dropRequestCallback()
				end
			end
		end

		if arg_67_0.speedLevel <= #var_0_11 then
			if not arg_67_0.nextSpeedUpTime then
				arg_67_0.nextSpeedUpTime = arg_67_0.startTime + var_0_11[arg_67_0.speedLevel]
			end

			if var_0_31 >= arg_67_0.nextSpeedUpTime then
				arg_67_0.speedLevel = arg_67_0.speedLevel + 1

				local var_67_3

				if not (arg_67_0.speedLevel <= #var_0_11) or not (var_0_31 + var_0_11[arg_67_0.speedLevel]) then
					var_67_3 = nil
				end

				arg_67_0.nextSpeedUpTime = var_67_3
			end
		end

		return
	end

	return var_64_0
end

local function var_0_42(arg_68_0, arg_68_1)
	local var_68_0 = {
		flyer = arg_68_0,
		scene = arg_68_1,
		dropItems = {}
	}

	var_68_0.lostCallback = nil
	var_68_0.boomCallback = nil
	var_68_0.dropSpeedUpCallback = nil

	function var_68_0.start(arg_69_0)
		arg_69_0.startFlag = true
		arg_69_0.speedLevel = 1
		arg_69_0.nextSpeedUpTime = nil
		arg_69_0.startTime = var_0_31

		return
	end

	function var_68_0.gameOver(arg_70_0)
		arg_70_0.startFlag = false

		for iter_70_0 = #arg_70_0.dropItems, 1, -1 do
			local var_70_0 = arg_70_0.dropItems[iter_70_0].tf

			table = var_2_10006
			var_2_10006 = var_2_10006.remove(arg_70_0.dropItems, iter_70_0)

			arg_70_0:returnDropItem(var_2_10006)
		end

		return
	end

	function var_68_0.createDropItem(arg_71_0)
		local var_71_0 = arg_71_0:getDropItem()
		local var_71_1 = arg_71_0.flyer
		local var_71_2 = var_2.getDropWorldPos(var_71_1)
		local var_71_3 = arg_71_0.scene
		local var_71_4 = var_3.InverseTransformPoint(var_71_3, var_71_2)

		var_71_0.tf.localPosition = var_71_4

		if not arg_71_0.dropItems then
			arg_71_0.dropItems = {}
		end

		table = var_4

		var_4.insert(arg_71_0.dropItems, var_71_0)

		return
	end

	function var_68_0.getDropItem(arg_72_0)
		if not arg_72_0.dropItemPool then
			arg_72_0.dropItemPool = {}
		end

		local var_72_0
		local var_72_1 = #arg_72_0.dropItemPool

		if 0 < var_72_1 then
			table = var_72_1
			var_72_0 = var_72_1.remove(arg_72_0.dropItemPool, 1)
		else
			tf = var_72_1
			instantiate = var_3
			findTF = var_2_10004
			var_72_1 = var_72_1(var_3(var_2_10004(arg_72_0.scene, "tplItem")))
			SetParent = var_3

			var_3(var_72_1, arg_72_0.scene, false)

			var_72_0 = {
				tf = var_72_1
			}
		end

		math = var_72_1

		local var_72_2

		if not (var_72_1.random(var_0_18[1], var_0_18[2]) <= var_0_18[1]) or not var_0_7 then
			var_72_2 = var_0_6
		end

		var_72_0.type = var_72_2
		var_72_0.speed = var_0_21[arg_72_0.speedLevel]
		setActive = var_3

		var_3(var_72_0.tf, true)
		arg_72_0:setItemData(var_72_0, var_72_2)

		return var_72_0
	end

	function var_68_0.setItemData(arg_73_0, arg_73_1, arg_73_2)
		local var_73_0 = arg_73_1.tf

		findTF = var_2_10004

		local var_73_1 = var_2_10004(var_73_0, "candy")

		findTF = var_5

		local var_73_2 = var_5(var_73_0, "boom")

		arg_73_1.score = 0

		local var_73_3

		if arg_73_2 == var_0_6 then
			setActive = var_73_3

			var_73_3(var_73_1, true)

			setActive = var_73_3

			var_73_3(var_73_2, false)

			math = var_73_3
			var_73_3 = var_73_3.random(var_0_17[1], var_0_17[2])
			GetComponent = var_7
			findTF = var_8

			local var_73_4 = var_8(var_73_1, "img")

			typeof = var_9
			Animator = var_10

			local var_73_5 = var_7(var_73_4, var_9(var_10))

			var_7.SetInteger(var_73_5, "type", var_73_3)
			var_7:Play("candyIdle", -1, 0)

			arg_73_1.score = var_0_19[var_73_3 + 1]
		else
			setActive = var_73_3

			var_73_3(var_73_1, false)

			setActive = var_73_3

			var_73_3(var_73_2, true)
		end

		return
	end

	function var_68_0.returnDropItem(arg_74_0, arg_74_1)
		setActive = var_2_10002

		var_2_10002(arg_74_1.tf, false)

		table = var_2_10002

		var_2_10002.insert(arg_74_0.dropItemPool, arg_74_1)

		return
	end

	function var_68_0.step(arg_75_0)
		if not arg_75_0.startFlag then
			return
		end

		if arg_75_0.speedLevel <= #var_0_22 then
			if not arg_75_0.nextSpeedUpTime then
				arg_75_0.nextSpeedUpTime = arg_75_0.startTime + var_0_22[arg_75_0.speedLevel]
			end

			if var_0_31 >= arg_75_0.nextSpeedUpTime then
				arg_75_0.speedLevel = arg_75_0.speedLevel + 1

				local var_75_0

				if not (arg_75_0.speedLevel <= #var_0_22) or not (arg_75_0.startTime + var_0_22[arg_75_0.speedLevel]) then
					var_75_0 = nil
				end

				arg_75_0.nextSpeedUpTime = var_75_0

				if arg_75_0.dropSpeedUpCallback then
					arg_75_0.dropSpeedUpCallback()
				end
			end
		end

		if arg_75_0.dropItems and #arg_75_0.dropItems > 0 then
			for iter_75_0 = #arg_75_0.dropItems, 1, -1 do
				local var_75_1 = arg_75_0.dropItems[iter_75_0].tf
				local var_75_2 = arg_75_0.dropItems[iter_75_0].speed + var_0_20[arg_75_0.speedLevel]

				arg_75_0.dropItems[iter_75_0].speed = var_75_2

				if var_75_1.localPosition.y <= var_0_29 then
					table = var_7

					if var_7.remove(arg_75_0.dropItems, iter_75_0).type == var_0_6 and arg_75_0.lostCallback then
						arg_75_0:playItemLost(var_7)
						arg_75_0.lostCallback()
					else
						arg_75_0:returnDropItem(var_7)
					end
				else
					Vector3 = var_7
					var_75_1.localPosition = var_7(var_75_1.localPosition.x, var_75_1.localPosition.y - var_75_2, var_75_1.localPosition.z)
				end
			end
		end

		return
	end

	function var_68_0.dropItemCollider(arg_76_0, arg_76_1)
		for iter_76_0 = #arg_76_0.dropItems, 1, -1 do
			table = var_2_10006

			if var_2_10006.contains(arg_76_1, iter_76_0) then
				table = var_2_10006
				var_2_10006 = var_2_10006.remove(arg_76_0.dropItems, iter_76_0)

				arg_76_0:playItemEffect(var_2_10006)
			end
		end

		return
	end

	function var_68_0.playItemEffect(arg_77_0, arg_77_1)
		if arg_77_1.type == var_0_6 then
			pg = var_3
			var_2_10004 = var_3.CriMgr.GetInstance()

			var_3.PlaySoundEffect_V3(var_2_10004, var_0_34)

			GetComponent = var_3
			findTF = var_2_10004
			var_2_10004 = var_2_10004(arg_77_1.tf, "candy/img")
			typeof = var_5
			Animator = var_6

			local var_77_0 = var_3(var_2_10004, var_5(var_6))

			GetComponent = var_2_10004
			findTF = var_5

			local var_77_1 = var_5(arg_77_1.tf, "candy/img")

			typeof = var_6
			DftAniEvent = var_7

			local var_77_2 = var_2_10004(var_77_1, var_6(var_7))

			var_2_10004.SetEndEvent(var_77_2, function()
				local var_78_0 = arg_77_0

				var_0.returnDropItem(var_78_0, arg_77_1)

				return
			end)
			var_77_0:SetTrigger("effect")
		elseif var_2 == var_0_7 then
			GetComponent = var_3
			findTF = var_2_10004

			local var_77_3 = var_2_10004(arg_77_1.tf, "boom/img")

			typeof = var_5
			Animator = var_6

			local var_77_4 = var_3(var_77_3, var_5(var_6))

			GetComponent = var_77_3
			findTF = var_5

			local var_77_5 = var_5(arg_77_1.tf, "boom/img")

			typeof = var_6
			DftAniEvent = var_7

			local var_77_6 = var_77_3(var_77_5, var_6(var_7))

			var_4.SetEndEvent(var_77_6, function()
				local var_79_0 = arg_77_0

				var_0.returnDropItem(var_79_0, arg_77_1)

				return
			end)

			pg = var_5

			local var_77_7 = var_5.CriMgr.GetInstance()

			var_5.PlaySoundEffect_V3(var_77_7, var_0_35)
			var_4:SetTriggerEvent(function()
				if arg_77_0.boomCallback then
					arg_77_0.boomCallback()
				end

				return
			end)
			var_77_4:SetTrigger("effect")
		end

		return
	end

	function var_68_0.playItemLost(arg_81_0, arg_81_1)
		if arg_81_1.type == var_0_6 then
			GetComponent = var_3
			findTF = var_2_10004

			local var_81_0 = var_2_10004(arg_81_1.tf, "candy/img")

			typeof = var_5
			Animator = var_6

			local var_81_1 = var_3(var_81_0, var_5(var_6))

			findTF = var_81_0

			local var_81_2 = var_81_0(arg_81_1.tf, "candy/candy_glow")

			GetComponent = var_5
			findTF = var_6

			local var_81_3 = var_6(arg_81_1.tf, "candy/img")

			typeof = var_7
			DftAniEvent = var_8

			local var_81_4 = var_5(var_81_3, var_7(var_8))
			local var_81_5 = var_81_1:GetLayerIndex("newLayer")

			var_81_4:SetEndEvent(function()
				setActive = var_3_10000

				var_3_10000(var_81_2, false)

				local var_82_0 = arg_81_0

				var_0.returnDropItem(var_82_0, arg_81_1)

				return
			end)
			var_81_4:SetTriggerEvent(function()
				setActive = var_3_10000

				var_3_10000(var_81_2, true)

				return
			end)
			var_81_1:Play("candyLost", var_81_5, 0)
		end

		return
	end

	function var_68_0.getDropItemsCollider(arg_84_0)
		if not arg_84_0.dropItems then
			return
		end

		local var_84_0 = {}

		for iter_84_0 = 1, #arg_84_0.dropItems do
			findTF = var_2_10006

			local var_84_1 = var_2_10006(arg_84_0.dropItems[iter_84_0].tf, "collider").sizeDelta.x
			local var_84_2 = var_2_10006.sizeDelta.y
			local var_84_3 = var_2_10006.position

			table = var_2_10010

			var_2_10010.insert(var_84_0, {
				x = var_84_3.x,
				y = var_84_3.y,
				width = var_84_1,
				height = var_84_2,
				index = iter_84_0,
				type = arg_84_0.dropItems[iter_84_0].type,
				score = arg_84_0.dropItems[iter_84_0].score
			})
		end

		return var_84_0
	end

	return var_68_0
end

local function var_0_43(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = {
		charactor = arg_85_0,
		dropItemController = arg_85_1,
		scene = arg_85_2
	}

	var_85_0.colliderDropItemCallback = nil

	function var_85_0.start(arg_86_0)
		arg_86_0.startFlag = true

		return
	end

	function var_85_0.gameOver(arg_87_0)
		arg_87_0.startFlag = false

		return
	end

	function var_85_0.step(arg_88_0)
		if not arg_88_0.startFlag then
			return
		end

		arg_88_0:checkCollider()

		return
	end

	function var_85_0.checkCollider(arg_89_0)
		local var_89_0 = {}
		local var_89_1 = arg_89_0.dropItemController
		local var_89_2 = var_2.getDropItemsCollider(var_89_1)
		local var_89_3 = arg_89_0.charactor
		local var_89_4 = var_3.getCollider(var_89_3).pos

		if var_89_2 and #var_89_2 > 0 then
			for iter_89_0 = 1, #var_89_2 do
				local var_89_5 = var_89_2[iter_89_0]
				local var_89_6 = arg_89_0.scene
				local var_89_7 = var_10.InverseTransformPoint(var_89_6, var_89_5.x, var_89_5.y, 0)

				if arg_89_0:checkRectCollider(var_89_4, var_89_7, var_3, var_89_5) then
					table = var_11

					var_11.insert(var_89_0, var_89_5.index)

					if arg_89_0.colliderDropItemCallback then
						arg_89_0.colliderDropItemCallback(var_89_5)
					end
				end
			end
		end

		if #var_89_0 > 0 then
			local var_89_8 = arg_89_0.dropItemController

			var_5.dropItemCollider(var_89_8, var_89_0)
		end

		return
	end

	function var_85_0.checkRectCollider(arg_90_0, arg_90_1, arg_90_2, arg_90_3, arg_90_4)
		local var_90_0 = arg_90_1.x
		local var_90_1 = arg_90_1.y
		local var_90_2 = arg_90_3.width
		local var_90_3 = arg_90_3.height
		local var_90_4 = arg_90_2.x
		local var_90_5 = arg_90_2.y
		local var_90_6 = arg_90_4.width
		local var_90_7 = arg_90_4.height

		if var_90_4 <= var_90_0 and var_90_0 >= var_90_4 + var_90_6 then
			return false
		elseif var_90_0 <= var_90_4 and var_90_4 >= var_90_0 + var_90_2 then
			return false
		elseif var_90_5 <= var_90_1 and var_90_1 >= var_90_5 + var_90_7 then
			return false
		elseif var_90_1 <= var_90_5 and var_90_5 >= var_90_1 + var_90_3 then
			return false
		else
			return true
		end

		return
	end

	return var_85_0
end

local function var_0_44(arg_91_0)
	local var_91_0 = {
		_tf = arg_91_0
	}

	var_91_0.speedLevel = 1
	var_91_0.createGhostCallback = nil
	var_91_0.ghostSpeedUpCallback = nil

	function var_91_0.start(arg_92_0)
		arg_92_0.startFlag = true
		arg_92_0.speedLevel = 1
		arg_92_0.startTime = var_0_31
		GetComponent = var_1
		findTF = var_2_10002

		local var_92_0 = var_2_10002(arg_92_0._tf, "char")

		typeof = var_3
		Animator = var_4
		arg_92_0.bossAnimator = var_1(var_92_0, var_3(var_4))
		findTF = var_1
		arg_92_0.tip = var_1(arg_92_0._tf, "tip")

		return
	end

	function var_91_0.gameOver(arg_93_0)
		arg_93_0.startFlag = false
		arg_93_0.stepTime = nil
		setActive = var_1

		var_1(arg_93_0.tip, false)

		local var_93_0 = arg_93_0.bossAnimator

		var_1.SetInteger(var_93_0, "state_type", 0)

		return
	end

	function var_91_0.step(arg_94_0)
		if not arg_94_0.startFlag then
			return
		end

		if not arg_94_0.stepTime then
			local var_94_0 = arg_94_0.startTime

			math = var_2_10002
			arg_94_0.stepTime = var_94_0 + var_2_10002.random(var_0_15[arg_94_0.speedLevel][1], var_0_15[arg_94_0.speedLevel][2])
		else
			local var_94_1 = var_0_31

			if arg_94_0.stepTime <= var_94_1 then
				local var_94_2 = var_0_31

				math = var_2
				arg_94_0.stepTime = var_94_2 + var_2.random(var_0_15[arg_94_0.speedLevel][1], var_0_15[arg_94_0.speedLevel][2])

				if arg_94_0.createGhostCallback then
					arg_94_0.createGhostCallback()
				end
			end
		end

		if arg_94_0.speedLevel <= #var_0_16 then
			if not arg_94_0.nextSpeedUpTime then
				arg_94_0.nextSpeedUpTime = arg_94_0.startTime + var_0_16[arg_94_0.speedLevel]
			end

			if var_0_31 >= arg_94_0.nextSpeedUpTime then
				arg_94_0.speedLevel = arg_94_0.speedLevel + 1

				local var_94_3

				if not (arg_94_0.speedLevel <= #var_0_16) or not (arg_94_0.nextSpeedUpTime + var_0_16[arg_94_0.speedLevel]) then
					var_94_3 = nil
				end

				arg_94_0.nextSpeedUpTime = var_94_3

				if arg_94_0.ghostSpeedUpCallback then
					arg_94_0.ghostSpeedUpCallback()
				end

				local var_94_4 = var_0_37
				local var_94_5 = "幽灵生成速度提升"
				local var_94_6

				if not arg_94_0.nextSpeedUpTime then
					var_94_6 = "(已经达到最高速度)"
				end

				var_94_4(var_94_5 .. var_94_6)
			end
		end

		return
	end

	function var_91_0.showTip(arg_95_0, arg_95_1)
		LeanTween = var_2_10002

		local var_95_0 = var_2_10002.isTweening

		go = var_2_10003

		local var_95_1

		if var_95_0(var_2_10003(arg_95_0.tip)) then
			LeanTween = var_95_1
			var_95_1 = var_95_1.cancel
			go = var_3

			var_95_1(var_3(arg_95_0.tip))
		end

		setActive = var_95_1
		findTF = var_3

		var_95_1(var_3(arg_95_0.tip, "img1"), false)

		setActive = var_95_1
		findTF = var_3

		var_95_1(var_3(arg_95_0.tip, "img2"), false)

		setActive = var_95_1
		findTF = var_3

		var_95_1(var_3(arg_95_0.tip, "img" .. arg_95_1), true)

		setActive = var_95_1

		var_95_1(arg_95_0.tip, true)

		LeanTween = var_95_1

		local var_95_2 = var_95_1.delayedCall

		go = var_3

		local var_95_3 = var_3(arg_95_0.tip)
		local var_95_4 = 10

		System = var_5

		var_95_2(var_95_3, var_95_4, var_5.Action(function()
			setActive = var_3_10000

			var_3_10000(arg_95_0.tip, false)

			return
		end))

		return
	end

	function var_91_0.onCreate(arg_97_0)
		local var_97_0 = arg_97_0.bossAnimator

		var_1.SetInteger(var_97_0, "state_type", 3)

		return
	end

	function var_91_0.onCatch(arg_98_0)
		local var_98_0 = arg_98_0.bossAnimator

		var_1.SetInteger(var_98_0, "state_type", 2)

		return
	end

	function var_91_0.onGhostDestroy(arg_99_0)
		local var_99_0 = arg_99_0.bossAnimator

		var_1.SetInteger(var_99_0, "state_type", 1)

		local var_99_1 = var_0_31

		math = var_99_0
		arg_99_0.stepTime = var_99_1 + var_99_0.random(var_0_15[arg_99_0.speedLevel][1], var_0_15[arg_99_0.speedLevel][2])

		return
	end

	function var_91_0.destory(arg_100_0)
		LeanTween = var_2_10001

		local var_100_0 = var_2_10001.isTweening

		go = var_2_10002

		if var_100_0(var_2_10002(arg_100_0.tip)) then
			LeanTween = var_1

			local var_100_1 = var_1.cancel

			go = var_2

			var_100_1(var_2(arg_100_0.tip))
		end

		return
	end

	return var_91_0
end

local function var_0_45(arg_101_0, arg_101_1, arg_101_2)
	local var_101_0 = {}
	local var_101_1 = 4

	var_101_0.tplGhost = arg_101_0
	var_101_0.charactor = arg_101_1
	var_101_0.scene = arg_101_2
	var_101_0.catchCharactorCallback = nil

	function var_101_0.start(arg_102_0)
		arg_102_0.startFlag = true

		return
	end

	function var_101_0.gameOver(arg_103_0)
		arg_103_0.startFlag = false

		if not arg_103_0.ghostChilds then
			return
		end

		for iter_103_0 = #arg_103_0.ghostChilds, 1, -1 do
			local var_103_0 = arg_103_0.ghostChilds[iter_103_0]

			arg_103_0:removeChild(var_103_0)
		end

		return
	end

	function var_101_0.step(arg_104_0)
		if not arg_104_0.startFlag or not arg_104_0.ghostChilds then
			return
		end

		local var_104_0 = arg_104_0.charactor
		local var_104_1 = var_1.getFollowPos(var_104_0)
		local var_104_2 = arg_104_0.scene
		local var_104_3 = var_2.InverseTransformPoint(var_104_2, var_104_1)

		for iter_104_0 = #arg_104_0.ghostChilds, 1, -1 do
			local var_104_4 = arg_104_0.ghostChilds[iter_104_0]

			isActive = var_2_10008

			if var_2_10008(var_104_4) then
				var_2_10008 = var_104_4.anchoredPosition

				local var_104_5 = 0
				local var_104_6 = 0
				local var_104_7 = false
				local var_104_8 = false

				math = var_2_10013

				if var_2_10013.abs(var_104_3.x - var_2_10008.x) > 10 then
					var_104_5 = var_101_1 * (var_104_3.x > var_2_10008.x and 1 or -1)
				else
					var_104_7 = true
				end

				math = var_2_10013

				if var_2_10013.abs(var_104_3.y - var_2_10008.y) > 10 then
					var_104_6 = var_101_1 * (var_104_3.y > var_2_10008.y and 1 or -1)
				else
					var_104_8 = true
				end

				local var_104_9 = arg_104_0.charactor

				if not var_2_10013.getGhostFlag(var_104_9) then
					local var_104_10 = arg_104_0.charactor

					if not var_2_10013.getActionFlag(var_104_10) and var_104_8 and var_104_7 then
						setActive = var_2_10013

						var_2_10013(var_104_4, false)

						if arg_104_0.catchCharactorCallback then
							arg_104_0.catchCharactorCallback(var_104_4)
						end

						return
					end
				end

				var_2_10008.x = var_2_10008.x + var_104_5
				var_2_10008.y = var_2_10008.y + var_104_6
				var_2_10013 = arg_104_0.ghostChilds[iter_104_0]
				var_2_10013.anchoredPosition = var_2_10008
			end
		end

		return
	end

	function var_101_0.removeChild(arg_105_0, arg_105_1)
		for iter_105_0 = 1, #arg_105_0.ghostChilds do
			if arg_105_1 == arg_105_0.ghostChilds[iter_105_0] then
				table = var_6

				local var_105_0 = var_6.remove(arg_105_0.ghostChilds, iter_105_0)

				arg_105_0:returnGhost(var_105_0)

				return
			end
		end

		return
	end

	function var_101_0.createGhost(arg_106_0)
		if not arg_106_0.ghostChilds then
			arg_106_0.ghostChilds = {}
		end

		if not (#arg_106_0.ghostChilds > 0) then
			local var_106_0 = arg_101_1

			if var_1.getGhostFlag(var_106_0) then
				return false
			end

			local var_106_1 = arg_106_0:getGhostChild()

			var_106_1.anchoredPosition = var_0_28
			GetComponent = var_2
			findTF = var_2_10003

			local var_106_2 = var_2_10003(var_106_1, "char")

			typeof = var_4
			Animator = var_5

			local var_106_3 = var_2(var_106_2, var_4(var_5))

			var_2.SetInteger(var_106_3, "state_type", 1)

			table = var_3

			var_3.insert(arg_106_0.ghostChilds, var_106_1)

			return true
		end
	end

	function var_101_0.getGhostChild(arg_107_0)
		if not arg_107_0.ghostPool then
			arg_107_0.ghostPool = {}
		end

		local var_107_0
		local var_107_1 = #arg_107_0.ghostPool

		if 0 < var_107_1 then
			table = var_107_1
			var_107_0 = var_107_1.remove(arg_107_0.ghostPool, #arg_107_0.ghostPool)
		else
			tf = var_107_1
			instantiate = var_3
			var_107_0 = var_107_1(var_3(arg_107_0.tplGhost))
			SetParent = var_107_1

			var_107_1(var_107_0, arg_107_0.scene, false)
		end

		setActive = var_107_1

		var_107_1(var_107_0, true)

		return var_107_0
	end

	function var_101_0.returnGhost(arg_108_0, arg_108_1)
		setActive = var_2_10002

		var_2_10002(arg_108_1, false)

		table = var_2_10002

		var_2_10002.insert(arg_108_0.ghostPool, arg_108_1)

		return
	end

	function var_101_0.createGhostLight(arg_109_0, arg_109_1)
		if not arg_109_0.lightGhost then
			tf = var_2
			instantiate = var_2_10003
			arg_109_0.lightGhost = var_2(var_2_10003(arg_109_0.tplGhost))

			local var_109_0 = arg_109_0.lightGhost

			var_109_0.name = "lightGhost"
			GetComponent = var_109_0
			findTF = var_3

			local var_109_1 = var_3(arg_109_0.lightGhost, "char")

			typeof = var_4
			Animator = var_5
			arg_109_0.lightAnimator = var_109_0(var_109_1, var_4(var_5))
			GetComponent = var_2
			findTF = var_109_1

			local var_109_2 = var_109_1(arg_109_0.lightGhost, "char")

			typeof = var_4
			DftAniEvent = var_5

			local var_109_3 = var_2(var_109_2, var_4(var_5))

			var_2.SetEndEvent(var_109_3, function()
				setActive = var_3_10000

				var_3_10000(arg_109_0.lightGhost, false)

				return
			end)

			setParent = var_3

			var_3(arg_109_0.lightGhost, arg_109_0.scene)
		end

		local var_109_4 = arg_109_0.charactor

		if var_2.getGhostFlag(var_109_4) then
			local var_109_5 = arg_109_0.lightGhost
			local var_109_6 = arg_109_0.scene
			local var_109_7 = var_3.InverseTransformPoint
			local var_109_8 = arg_109_0.charactor

			var_109_5.anchoredPosition = var_109_7(var_109_6, var_5.getLeavePos(var_109_8))
			setActive = var_109_5

			var_109_5(arg_109_0.lightGhost, true)

			local var_109_9 = arg_109_0.lightAnimator

			var_2.SetInteger(var_109_9, "state_type", 0)

			local var_109_10 = arg_109_0.lightAnimator

			var_2.SetInteger(var_109_10, "state_type", 2)
			arg_109_1(true)
		else
			arg_109_1(false)
		end

		return
	end

	return var_101_0
end

local function var_0_46(arg_111_0, arg_111_1)
	local var_111_0 = {
		eyeTf = arg_111_0
	}
	local var_111_1 = 3

	function var_111_0.changeEyeShow(arg_112_0, arg_112_1)
		return
	end

	function var_111_0.start(arg_113_0)
		if not arg_113_0.eyes then
			arg_113_0.eyes = {}

			for iter_113_0 = 1, 3 do
				table = var_2_10005
				var_2_10005 = var_2_10005.insert

				local var_113_0 = arg_113_0.eyes

				findTF = var_2_10007

				var_2_10005(var_113_0, var_2_10007(arg_113_0.eyeTf, "eye" .. iter_113_0))
			end
		end

		arg_113_0.centerX = (var_0_26[3] - var_0_26[1]) / 2
		arg_113_0.halfRnage = (var_0_26[3] - var_0_26[1]) / 2

		arg_113_0:changeEyeShow(true)

		return
	end

	function var_111_0.step(arg_114_0)
		local var_114_0 = (arg_111_1.anchoredPosition.x - var_0_26[1] - arg_114_0.centerX) / arg_114_0.halfRnage * var_111_1

		for iter_114_0 = 1, #arg_114_0.eyes do
			setAnchoredPosition = var_2_10007
			findTF = var_2_10008
			var_2_10008 = var_2_10008(arg_114_0.eyes[iter_114_0], "img")
			Vector3 = var_9

			var_2_10007(var_2_10008, var_9(var_114_0, 0, 0))
		end

		return
	end

	function var_111_0.gameOver(arg_115_0)
		return
	end

	return var_111_0
end

function var_0_1.init(arg_116_0)
	arg_116_0:initUI()
	arg_116_0:initData()

	return
end

function var_0_1.initUI(arg_117_0)
	onButton = var_1_10001

	local var_117_0 = arg_117_0

	findTF = var_1_10003

	local var_117_1 = var_1_10003(arg_117_0._tf, "conLeft/btnClose")

	local function var_117_2()
		if not arg_117_0.gameStartFlag then
			local var_118_0 = arg_117_0

			var_0.closeView(var_118_0)
		else
			setActive = var_0

			var_0(arg_117_0.leaveUI, true)

			local var_118_1 = arg_117_0

			var_0.timerStop(var_118_1)

			arg_117_0.gameStartFlag = false
		end

		return
	end

	SFX_CANCEL = var_117_3

	var_1_10001(var_117_0, var_117_1, var_117_2, var_117_3)

	findTF = var_1_10001
	arg_117_0.playerIdleTip = var_1_10001(arg_117_0._tf, "idleTip")
	setActive = var_1

	var_1(arg_117_0.playerIdleTip, false)

	arg_117_0.hearts = {}

	for iter_117_0 = 1, var_0_25 do
		table = var_117_3

		local var_117_3 = var_117_3.insert
		local var_117_4 = arg_117_0.hearts

		findTF = var_1_10007

		var_117_3(var_117_4, var_1_10007(arg_117_0._tf, "conRight/heart/heart" .. iter_117_0))
	end

	findTF = var_1
	arg_117_0.wanshengjie = var_1(arg_117_0._tf, "wanshengjie")
	setActive = var_1

	var_1(arg_117_0.wanshengjie, false)

	findTF = var_1
	arg_117_0.scoreText = var_1(arg_117_0._tf, "conRight/score/text")
	findTF = var_1
	arg_117_0.scene = var_1(arg_117_0._tf, "scene")
	findTF = var_1
	arg_117_0.countUI = var_1(arg_117_0._tf, "pop/CountUI")
	findTF = var_1
	arg_117_0.settlementUI = var_1(arg_117_0._tf, "pop/SettleMentUI")
	onButton = var_1

	local var_117_5 = arg_117_0

	findTF = var_3

	local var_117_6 = var_3(arg_117_0.settlementUI, "ad/btnOver")

	local function var_117_7()
		local var_119_0 = arg_117_0

		var_0.clearUI(var_119_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_117_5, var_117_6, var_117_7, var_5)

	findTF = var_1
	arg_117_0.leaveUI = var_1(arg_117_0._tf, "pop/LeaveUI")
	onButton = var_1

	local var_117_8 = arg_117_0

	findTF = var_3

	local var_117_9 = var_3(arg_117_0.leaveUI, "ad/btnOk")

	local function var_117_10()
		setActive = var_2_10000

		var_2_10000(arg_117_0.leaveUI, false)

		local var_120_0 = arg_117_0

		var_0.gameOver(var_120_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_117_8, var_117_9, var_117_10, var_5)

	onButton = var_1

	local var_117_11 = arg_117_0

	findTF = var_117_9

	local var_117_12 = var_117_9(arg_117_0.leaveUI, "ad/btnCancel")

	local function var_117_13()
		setActive = var_2_10000

		var_2_10000(arg_117_0.leaveUI, false)

		local var_121_0 = arg_117_0

		var_0.timerStart(var_121_0)

		arg_117_0.gameStartFlag = true

		return
	end

	SFX_CANCEL = var_5

	var_1(var_117_11, var_117_12, var_117_13, var_5)

	findTF = var_1
	arg_117_0.menuUI = var_1(arg_117_0._tf, "pop/MenuUI")
	setActive = var_1

	var_1(arg_117_0.menuUI, true)

	onButton = var_1

	local var_117_14 = arg_117_0

	findTF = var_3

	local var_117_15 = var_3(arg_117_0.menuUI, "ad/btnStart")

	local function var_117_16()
		setActive = var_2_10000

		var_2_10000(arg_117_0.menuUI, false)

		local var_122_0 = arg_117_0

		var_0.openCoinLayer(var_122_0, false)

		local var_122_1 = arg_117_0

		var_0.gameReadyStart(var_122_1)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_117_14, var_117_15, var_117_16, var_5)

	onButton = var_1

	local var_117_17 = arg_117_0

	findTF = var_117_15

	local var_117_18 = var_117_15(arg_117_0.menuUI, "ad/btnBack")

	local function var_117_19()
		local var_123_0 = arg_117_0

		var_0.closeView(var_123_0)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_117_17, var_117_18, var_117_19, var_5)

	onButton = var_1

	local var_117_20 = arg_117_0

	findTF = var_117_18

	local var_117_21 = var_117_18(arg_117_0.menuUI, "ad/btnRule")

	local function var_117_22()
		pg = var_2_10000

		local var_124_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_124_1 = var_0.ShowMsgBox
		local var_124_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_124_2.type = var_2_10003

		local var_124_3 = arg_117_0

		var_124_2.helps = var_3.getGameRoomData(var_124_3).game_help

		var_124_1(var_124_0, var_124_2)

		return
	end

	SFX_CANCEL = var_5

	var_1(var_117_20, var_117_21, var_117_22, var_5)

	return
end

function var_0_1.initData(arg_125_0)
	Timer = var_1_10001
	arg_125_0.timer = var_1_10001.New(function()
		local var_126_0 = arg_125_0

		var_0.onTimer(var_126_0)

		return
	end, 0.016666666666666666, -1)

	local var_125_0 = var_0_38

	findTF = var_2
	arg_125_0.charactor = var_125_0(var_2(arg_125_0.scene, "charactor"), var_0_26, arg_125_0.scene)

	function arg_125_0.charactor.charactorIdleCallback(arg_127_0)
		setActive = var_2_10001

		var_2_10001(arg_125_0.playerIdleTip, arg_127_0)

		return
	end

	local var_125_1 = var_0_40

	findTF = var_2
	arg_125_0.flyer = var_125_1(var_2(arg_125_0.scene, "flyCharactor"), var_0_27)

	function arg_125_0.flyer.dropCallback()
		local var_128_0 = arg_125_0

		var_0.onCreateDropItem(var_128_0)

		return
	end

	local var_125_2 = var_0_39

	findTF = var_2

	local var_125_3 = var_2(arg_125_0._tf, "controller")

	findTF = var_3
	arg_125_0.controllerUI = var_125_2(var_125_3, var_3(arg_125_0._tf, "conRight/useLight"))

	function arg_125_0.controllerUI.pointChangeCallback(arg_129_0)
		local var_129_0 = arg_125_0

		var_1.onControllerDirectChange(var_129_0, arg_129_0)

		return
	end

	function arg_125_0.controllerUI.pointUpCallback(arg_130_0)
		local var_130_0 = arg_125_0

		var_1.onControllerDirectUp(var_130_0, arg_130_0)

		return
	end

	function arg_125_0.controllerUI.pointLightCallback(arg_131_0)
		local var_131_0 = arg_125_0

		var_1.onUseLight(var_131_0, arg_131_0)

		return
	end

	arg_125_0.dropControl = var_0_41()

	function arg_125_0.dropControl.dropRequestCallback()
		local var_132_0 = arg_125_0

		var_0.onRequestDrop(var_132_0)

		return
	end

	arg_125_0.dropItemController = var_0_42(arg_125_0.flyer, arg_125_0.scene)

	function arg_125_0.dropItemController.lostCallback()
		local var_133_0 = arg_125_0

		var_0.lostCandy(var_133_0)

		return
	end

	function arg_125_0.dropItemController.boomCallback()
		local var_134_0 = arg_125_0

		var_0.touchBoom(var_134_0)

		return
	end

	function arg_125_0.dropItemController.dropSpeedUpCallback()
		local var_135_0 = arg_125_0

		var_0.dropSpeedUp(var_135_0)

		return
	end

	arg_125_0.dropColliderControll = var_0_43(arg_125_0.charactor, arg_125_0.dropItemController, arg_125_0.scene)

	function arg_125_0.dropColliderControll.colliderDropItemCallback(arg_136_0)
		local var_136_0 = arg_125_0

		var_1.addScore(var_136_0, arg_136_0.score)

		return
	end

	local var_125_4 = var_0_44

	findTF = var_2
	arg_125_0.ghostBossController = var_125_4(var_2(arg_125_0._tf, "ghostBoss"))

	function arg_125_0.ghostBossController.createGhostCallback()
		local var_137_0 = arg_125_0

		var_0.createGhost(var_137_0)

		return
	end

	function arg_125_0.ghostBossController.ghostSpeedUpCallback()
		if arg_125_0.eyesController then
			local var_138_0 = arg_125_0.eyesController

			var_0.changeEyeShow(var_138_0, false)
		end

		return
	end

	local var_125_5 = var_0_45

	findTF = var_2
	arg_125_0.ghostChildController = var_125_5(var_2(arg_125_0.scene, "tplGhost"), arg_125_0.charactor, arg_125_0.scene)

	function arg_125_0.ghostChildController.catchCharactorCallback(arg_139_0)
		local var_139_0 = arg_125_0

		var_1.onGhostCatch(var_139_0, arg_139_0)

		return
	end

	local var_125_6 = var_0_46

	findTF = var_2

	local var_125_7 = var_2(arg_125_0._tf, "bg/eyes")

	findTF = var_3
	arg_125_0.eyesController = var_125_6(var_125_7, var_3(arg_125_0.scene, "charactor"))

	if not arg_125_0.handle then
		UpdateBeat = var_1
		arg_125_0.handle = var_1:CreateListener(arg_125_0.Update, arg_125_0)
	end

	UpdateBeat = var_1

	local var_125_8 = var_1

	var_1.AddListener(var_125_8, arg_125_0.handle)

	GetComponent = var_1
	findTF = var_125_8

	local var_125_9 = var_125_8(arg_125_0.countUI, "count")

	typeof = var_3
	Animator = var_4
	arg_125_0.countAnimator = var_1(var_125_9, var_3(var_4))
	GetComponent = var_1
	findTF = var_125_9

	local var_125_10 = var_125_9(arg_125_0.countUI, "count")

	typeof = var_3
	DftAniEvent = var_4
	arg_125_0.countDft = var_1(var_125_10, var_3(var_4))

	local var_125_11 = arg_125_0.countDft

	var_1.SetTriggerEvent(var_125_11, function()
		return
	end)

	local var_125_12 = arg_125_0.countDft

	var_1.SetEndEvent(var_125_12, function()
		setActive = var_2_10000

		var_2_10000(arg_125_0.countUI, false)

		local var_141_0 = arg_125_0

		var_0.gameStart(var_141_0)

		return
	end)

	return
end

function var_0_1.gameReadyStart(arg_142_0)
	setActive = var_1_10001

	var_1_10001(arg_142_0.menuUI, false)

	setActive = var_1_10001

	var_1_10001(arg_142_0.countUI, true)

	local var_142_0 = arg_142_0.countAnimator

	var_1.Play(var_142_0, "count")

	pg = var_1

	local var_142_1 = var_1.CriMgr.GetInstance()

	var_1.PlaySoundEffect_V3(var_142_1, var_0_36)

	return
end

function var_0_1.gameStart(arg_143_0)
	arg_143_0.heartNum = var_0_25
	arg_143_0.scoreNum = 0
	arg_143_0.gameStartFlag = true
	var_0_31 = 0
	setActive = var_1

	var_1(arg_143_0.scene, true)
	arg_143_0:updateUI()

	local var_143_0 = arg_143_0.charactor

	var_1.start(var_143_0)

	local var_143_1 = arg_143_0.flyer

	var_1.start(var_143_1)

	local var_143_2 = arg_143_0.dropControl

	var_1.start(var_143_2)

	local var_143_3 = arg_143_0.dropItemController

	var_1.start(var_143_3)

	local var_143_4 = arg_143_0.dropColliderControll

	var_1.start(var_143_4)

	local var_143_5 = arg_143_0.ghostBossController

	var_1.start(var_143_5)

	local var_143_6 = arg_143_0.ghostChildController

	var_1.start(var_143_6)

	local var_143_7 = arg_143_0.controllerUI

	var_1.start(var_143_7)

	local var_143_8 = arg_143_0.eyesController

	var_1.start(var_143_8)
	arg_143_0:timerStart()

	return
end

function var_0_1.timerStart(arg_144_0)
	if not arg_144_0.timer.running then
		local var_144_0 = arg_144_0.timer

		var_1.Start(var_144_0)
	end

	setActive = var_1

	var_1(arg_144_0.wanshengjie, true)

	return
end

function var_0_1.timerStop(arg_145_0)
	if arg_145_0.timer.running then
		local var_145_0 = arg_145_0.timer

		var_1.Stop(var_145_0)
	end

	setActive = var_1

	var_1(arg_145_0.wanshengjie, false)

	return
end

function var_0_1.getGameTimes(arg_146_0)
	return arg_146_0:GetMGHubData().count
end

function var_0_1.getSoundData(arg_147_0, arg_147_1)
	CueData = var_1_10002

	local var_147_0 = var_1_10002.GetCueData()

	pg = var_1_10003
	var_147_0.channelName = var_1_10003.CriMgr.C_GALLERY_MUSIC
	arg_147_0.cueData.cueSheetName = arg_147_1
	arg_147_0.cueData.cueName = ""

	return
end

function var_0_1.onTimer(arg_148_0)
	var_0_31 = var_0_31 + arg_148_0.timer.duration

	local var_148_0 = arg_148_0.charactor

	var_1.step(var_148_0)

	local var_148_1 = arg_148_0.flyer

	var_1.step(var_148_1)

	local var_148_2 = arg_148_0.dropControl

	var_1.step(var_148_2)

	local var_148_3 = arg_148_0.dropItemController

	var_1.step(var_148_3)

	local var_148_4 = arg_148_0.dropColliderControll

	var_1.step(var_148_4)

	local var_148_5 = arg_148_0.ghostBossController

	var_1.step(var_148_5)

	local var_148_6 = arg_148_0.ghostChildController

	var_1.step(var_148_6)

	local var_148_7 = arg_148_0.controllerUI

	var_1.step(var_148_7)

	local var_148_8 = arg_148_0.eyesController

	var_1.step(var_148_8)

	return
end

function var_0_1.updateUI(arg_149_0)
	for iter_149_0 = 1, #arg_149_0.hearts do
		if iter_149_0 <= arg_149_0.heartNum then
			setActive = var_5
			findTF = var_1_10006

			var_5(var_1_10006(arg_149_0.hearts[iter_149_0], "img"), true)
		else
			setActive = var_5
			findTF = var_1_10006

			var_5(var_1_10006(arg_149_0.hearts[iter_149_0], "img"), false)
		end
	end

	if not arg_149_0.showOverTip and (arg_149_0.scoreNum >= var_0_32 or var_0_31 * 1000 >= var_0_33) and arg_149_0.ghostBossController then
		arg_149_0.showOverTip = true

		local var_149_0 = arg_149_0.ghostBossController

		var_1.showTip(var_149_0, 2)
	end

	setText = var_1

	var_1(arg_149_0.scoreText, arg_149_0.scoreNum)

	return
end

function var_0_1.dropSpeedUp(arg_150_0)
	if arg_150_0.ghostBossController then
		local var_150_0 = arg_150_0.ghostBossController

		var_1.showTip(var_150_0, 1)
	end

	return
end

function var_0_1.loseHeart(arg_151_0, arg_151_1)
	if arg_151_0.heartNum and arg_151_0.heartNum > 0 then
		arg_151_0.heartNum = arg_151_0.heartNum - 1

		arg_151_0:updateUI()

		if arg_151_0.heartNum == 0 then
			local var_151_0

			if arg_151_1 ~= var_0_6 or not var_0_8 then
				var_151_0 = var_0_9
			end

			local var_151_1 = arg_151_0.charactor

			var_3.fail(var_151_1, var_151_0)

			if var_151_0 == var_0_9 then
				local var_151_2 = arg_151_0.ghostChildController

				var_3.createGhostLight(var_151_2, function(arg_152_0)
					if arg_152_0 then
						local var_152_0 = arg_151_0.ghostBossController

						var_1.onGhostDestroy(var_152_0)
					end

					return
				end)

				local var_151_3 = arg_151_0.charactor

				var_3.setGhostFlag(var_151_3, false)
			end

			arg_151_0.gameStartFlag = false

			local var_151_4 = arg_151_0

			arg_151_0.timerStop(var_151_4)

			LeanTween = var_3

			local var_151_5 = var_3.delayedCall

			go = var_151_4

			local var_151_6 = var_151_4(arg_151_0._tf)
			local var_151_7 = 3

			System = var_1_10006

			var_151_5(var_151_6, var_151_7, var_1_10006.Action(function()
				local var_153_0 = arg_151_0

				var_0.gameOver(var_153_0)

				return
			end))
		elseif arg_151_1 == var_0_7 then
			local var_151_8 = arg_151_0.charactor

			var_2.boom(var_151_8)
		end
	end

	return
end

function var_0_1.addScore(arg_154_0, arg_154_1)
	arg_154_0.scoreNum = arg_154_0.scoreNum + arg_154_1

	arg_154_0:updateUI()

	return
end

function var_0_1.gameOver(arg_155_0)
	local var_155_0 = arg_155_0.charactor

	var_1.gameOver(var_155_0)

	local var_155_1 = arg_155_0.flyer

	var_1.gameOver(var_155_1)

	local var_155_2 = arg_155_0.dropControl

	var_1.gameOver(var_155_2)

	local var_155_3 = arg_155_0.dropItemController

	var_1.gameOver(var_155_3)

	local var_155_4 = arg_155_0.dropColliderControll

	var_1.gameOver(var_155_4)

	local var_155_5 = arg_155_0.ghostBossController

	var_1.gameOver(var_155_5)

	local var_155_6 = arg_155_0.ghostChildController

	var_1.gameOver(var_155_6)

	local var_155_7 = arg_155_0.controllerUI

	var_1.gameOver(var_155_7)

	local var_155_8 = arg_155_0.eyesController

	var_1.gameOver(var_155_8)
	arg_155_0:SendSuccess(arg_155_0.scoreNum)
	arg_155_0:showSettlement()

	return
end

function var_0_1.showSettlement(arg_156_0)
	setActive = var_1_10001

	var_1_10001(arg_156_0.settlementUI, true)

	GetComponent = var_1_10001
	findTF = var_2

	local var_156_0 = var_2(arg_156_0.settlementUI, "ad")

	typeof = var_3
	Animator = var_4

	local var_156_1 = var_1_10001(var_156_0, var_3(var_4))

	var_1.Play(var_156_1, "settlement", -1, 0)

	local var_156_2 = arg_156_0.scoreNum

	getProxy = var_156_1
	GameRoomProxy = var_4

	local var_156_3 = var_156_1(var_4)
	local var_156_4

	if var_3.getRoomScore(var_156_3, arg_156_0:getGameRoomData().id) <= var_156_2 then
		var_156_4 = var_156_2

		arg_156_0:StoreDataToServer({
			var_156_4
		})
	end

	findTF = var_156_3

	local var_156_5 = var_156_3(arg_156_0.settlementUI, "ad/highText")

	findTF = var_5

	local var_156_6 = var_5(arg_156_0.settlementUI, "ad/currentText")

	setText = var_6

	var_6(var_156_5, var_156_4)

	setText = var_6

	var_6(var_156_6, var_156_2)

	return
end

function var_0_1.lostCandy(arg_157_0)
	arg_157_0:loseHeart(var_0_6)

	return
end

function var_0_1.touchBoom(arg_158_0)
	arg_158_0:loseHeart(var_0_7)

	return
end

function var_0_1.createGhost(arg_159_0)
	if arg_159_0.ghostChildController then
		local var_159_0 = arg_159_0.ghostChildController

		if var_1.createGhost(var_159_0) then
			local var_159_1 = arg_159_0.ghostBossController

			var_2.onCreate(var_159_1)
		end
	end

	return
end

function var_0_1.onCreateDropItem(arg_160_0)
	if arg_160_0.dropItemController then
		local var_160_0 = arg_160_0.dropItemController

		var_1.createDropItem(var_160_0)
	end

	return
end

function var_0_1.onRequestDrop(arg_161_0)
	if arg_161_0.flyer then
		local var_161_0 = arg_161_0.flyer

		var_1.addDropNum(var_161_0)
	end

	return
end

function var_0_1.onGhostCatch(arg_162_0, arg_162_1)
	local var_162_0 = arg_162_0.charactor

	if not var_2.getGhostFlag(var_162_0) then
		local var_162_1 = arg_162_0.charactor

		var_2.setGhostFlag(var_162_1, true, function()
			local var_163_0 = arg_162_0.ghostChildController

			var_0.removeChild(var_163_0, arg_162_1)

			return
		end)

		local var_162_2 = arg_162_0.controllerUI

		var_2.changeRemind(var_162_2, true)

		local var_162_3 = arg_162_0.ghostBossController

		var_2.onCatch(var_162_3)
	end

	return
end

function var_0_1.onUseLight(arg_164_0, arg_164_1)
	if not arg_164_0.gameStartFlag then
		return
	end

	local var_164_0 = arg_164_0.charactor

	var_2.playLight(var_164_0, function(arg_165_0)
		if arg_165_0 and arg_164_1 == var_0_4 then
			local var_165_0 = arg_164_0.ghostChildController

			var_1.createGhostLight(var_165_0, function(arg_166_0)
				if arg_166_0 then
					local var_166_0 = arg_164_0.ghostBossController

					var_1.onGhostDestroy(var_166_0)

					local var_166_1 = arg_164_0.controllerUI

					var_1.changeRemind(var_166_1, false)
				end

				return
			end)

			local var_165_1 = arg_164_0.charactor

			var_1.setGhostFlag(var_165_1, false)
		end

		return
	end, arg_164_1)

	return
end

function var_0_1.onColliderItem(arg_167_0, arg_167_1)
	var_0_37("碰撞到了物品，数量:" .. #arg_167_1)

	return
end

function var_0_1.onControllerDirectChange(arg_168_0, arg_168_1)
	arg_168_0:changeDirect(arg_168_1, true)

	return
end

function var_0_1.onControllerDirectUp(arg_169_0, arg_169_1)
	arg_169_0:changeDirect(arg_169_1, false)

	return
end

function var_0_1.changeDirect(arg_170_0, arg_170_1, arg_170_2)
	if arg_170_0.gameStartFlag then
		local var_170_0 = arg_170_0.charactor

		var_3.onDirectChange(var_170_0, arg_170_1, arg_170_2)
	end

	return
end

function var_0_1.Update(arg_171_0)
	arg_171_0:AddDebugInput()

	return
end

function var_0_1.AddDebugInput(arg_172_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		Input = var_1_10001

		local var_172_0 = var_1_10001.GetKeyDown

		KeyCode = var_1_10002

		local var_172_1

		if var_172_0(var_1_10002.A) then
			var_172_1 = arg_172_0

			arg_172_0.changeDirect(var_172_1, var_0_2, true)
		end

		Input = var_1

		local var_172_2 = var_1.GetKeyUp

		KeyCode = var_172_1

		local var_172_3

		if var_172_2(var_172_1.A) then
			var_172_3 = arg_172_0

			arg_172_0.changeDirect(var_172_3, var_0_2, false)
		end

		Input = var_1

		local var_172_4 = var_1.GetKeyDown

		KeyCode = var_172_3

		local var_172_5

		if var_172_4(var_172_3.D) then
			var_172_5 = arg_172_0

			arg_172_0.changeDirect(var_172_5, var_0_3, true)
		end

		Input = var_1

		local var_172_6 = var_1.GetKeyUp

		KeyCode = var_172_5

		if var_172_6(var_172_5.D) then
			arg_172_0:changeDirect(var_0_3, false)
		end
	end

	return
end

function var_0_1.clearUI(arg_173_0)
	setActive = var_1_10001

	var_1_10001(arg_173_0.scene, false)

	setActive = var_1_10001

	var_1_10001(arg_173_0.settlementUI, false)

	setActive = var_1_10001

	var_1_10001(arg_173_0.countUI, false)

	setActive = var_1_10001

	var_1_10001(arg_173_0.menuUI, true)
	arg_173_0:openCoinLayer(true)

	return
end

function var_0_1.onBackPressed(arg_174_0)
	if not arg_174_0.gameStartFlag then
		arg_174_0:emit(var_0_1.ON_BACK_PRESSED)
	else
		setActive = var_1

		var_1(arg_174_0.leaveUI, true)
		arg_174_0:timerStop()

		arg_174_0.gameStartFlag = false
	end

	return
end

function var_0_1.willExit(arg_175_0)
	if arg_175_0.timer and arg_175_0.timer.running then
		var_1_10002 = arg_175_0.timer

		var_1.Stop(var_1_10002)
	end

	LeanTween = var_1

	local var_175_0 = var_1.isTweening

	go = var_1_10002

	if var_175_0(var_1_10002(arg_175_0._tf)) then
		LeanTween = var_1

		local var_175_1 = var_1.cancel

		go = var_2

		var_175_1(var_2(arg_175_0._tf))
	end

	return
end

return var_0_1
