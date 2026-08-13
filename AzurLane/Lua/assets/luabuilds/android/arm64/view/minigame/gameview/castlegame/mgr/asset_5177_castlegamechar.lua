class = var_0_10000

local var_0_0 = var_0_10000("CastleGameChar")

Vector3 = var_0_10001

local var_0_1 = var_0_10001(0, 0)
local var_0_2 = "qiye_6_SkeletonData"
local var_0_3 = 3
local var_0_4 = "activity_run"
local var_0_5 = "walk"
local var_0_6 = "activity_wait"
local var_0_7 = "tuozhuai2"
local var_0_8 = "tuozhuai2"
local var_0_9 = "dead"

Vector3 = var_0_10010

local var_0_10 = var_0_10010(0, 0, -1)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._charTpl = arg_1_1
	arg_1_0._event = arg_1_2

	arg_1_0:initChar()

	return
end

function var_0_0.initChar(arg_2_0)
	if arg_2_0.char then
		return
	end

	tf = var_1
	instantiate = var_1_10003
	arg_2_0.charTf = var_1(var_1_10003(arg_2_0._charTpl))
	Vector3 = var_1
	arg_2_0.speed = var_1(0, 0, 0)
	findTF = var_1
	arg_2_0.colliderTf = var_1(arg_2_0.charTf, "zPos/collider")
	GetComponent = var_1

	local var_2_0 = arg_2_0.colliderTf

	typeof = var_4
	BoxCollider2D = var_1_10006
	arg_2_0.collider = var_1(var_2_0, var_4(var_1_10006))
	findTF = var_1
	arg_2_0.zPos = var_1(arg_2_0.charTf, "zPos")
	arg_2_0.raycastPoints = {}

	for iter_2_0 = 1, var_0_3 do
		table = var_2_1

		local var_2_1 = var_2_1.insert
		local var_2_2 = arg_2_0.raycastPoints

		Vector3 = var_1_10008

		var_2_1(var_2_2, var_1_10008(0, 0, 0))
	end

	CastleGameVo = var_1

	var_1.LoadSkeletonData(var_0_2, function(arg_3_0)
		local var_3_0 = arg_3_0.transform

		Vector3 = var_2_10002
		var_3_0.localScale = var_2_10002(1, 1, 1)

		local var_3_1 = arg_3_0.transform

		Vector3 = var_2
		var_3_1.localPosition = var_2(0, 0, 0)

		local var_3_2 = arg_3_0

		arg_3_0.SetActive(var_3_2, true)

		SetParent = var_1
		tf = var_3_2

		local var_3_3 = var_3_2(arg_3_0)

		findTF = var_4

		var_1(var_3_3, var_4(arg_2_0.charTf, "zPos/char"))

		arg_2_0.graphic = arg_3_0:GetComponent("SkeletonGraphic")

		local var_3_4 = arg_2_0
		local var_3_5 = arg_3_0
		local var_3_6 = arg_3_0.GetComponent

		typeof = var_5
		SpineAnimUI = var_7
		var_3_4.anim = var_3_6(var_3_5, var_5(var_7))
		arg_2_0.charTf.anchoredPosition = var_0_1

		local var_3_7 = arg_2_0.zPos

		Vector2 = var_2
		var_3_7.anchoredPosition = var_2(0, var_0_1.z)

		return
	end)

	arg_2_0.char = {
		tf = arg_2_0.charTf,
		bound = {}
	}

	return
end

function var_0_0.setInGround(arg_4_0, arg_4_1)
	arg_4_0.inGround = arg_4_1

	if not arg_4_0.inGround then
		Vector3 = var_2
		arg_4_0.speed = var_2(0, 0, 0)
	end

	if arg_4_0.char.floor then
		local var_4_0 = arg_4_0.char.floor.tf
		local var_4_1 = arg_4_0
		local var_4_2 = arg_4_0.setContent

		findTF = var_1_10006

		var_4_2(var_4_1, var_1_10006(var_4_0, "zPos/top"))
	end

	return
end

function var_0_0.setOutLandPoint(arg_5_0, arg_5_1)
	arg_5_0.outlandPoint = arg_5_1

	local var_5_0 = arg_5_0.outlandPoint.lb
	local var_5_1 = arg_5_0.outlandPoint.lt
	local var_5_2 = arg_5_0.outlandPoint.rt
	local var_5_3 = arg_5_0.outlandPoint.rb
	local var_5_4 = 2

	Vector2 = var_1_10007

	local var_5_5 = var_1_10007(var_5_0.x + var_5_4, var_5_0.y)

	Vector2 = var_1_10008

	local var_5_6 = var_1_10008(var_5_1.x, var_5_1.y - var_5_4)

	Vector2 = var_9

	local var_5_7 = var_9(var_5_2.x - var_5_4, var_5_2.y)

	Vector2 = var_10

	local var_5_8 = var_10(var_5_3.x, var_5_3.y + var_5_4)

	arg_5_0.outlandPoint.exlb = var_5_5
	arg_5_0.outlandPoint.exlt = var_5_6
	arg_5_0.outlandPoint.exrt = var_5_7
	arg_5_0.outlandPoint.exrb = var_5_8

	return
end

function var_0_0.step(arg_6_0)
	if arg_6_0.timeToOver then
		local var_6_0 = arg_6_0.timeToOver

		if 0 < var_6_0 then
			local var_6_1 = arg_6_0.timeToOver

			CastleGameVo = var_2
			arg_6_0.timeToOver = var_6_1 - var_2.deltaTime

			if arg_6_0.timeToOver <= 0 then
				arg_6_0.timeToOver = nil

				local var_6_2 = arg_6_0._event
				local var_6_3 = var_1.emit

				CastleGameView = var_1_10004

				var_6_3(var_6_2, var_1_10004.GAME_OVER)
			end
		end
	end

	arg_6_0:updateSpeed()
	arg_6_0:updatePosition()
	arg_6_0:updateAnim()
	arg_6_0:checkPlayerOutScreen()

	return
end

function var_0_0.getPoint(arg_7_0)
	if arg_7_0.charTf then
		return nil
	end

	return arg_7_0.charTf.anchoredPosition
end

function var_0_0.updatePosition(arg_8_0)
	local var_8_0 = arg_8_0.charTf.anchoredPosition
	local var_8_1 = arg_8_0.zPos.anchoredPosition
	local var_8_2 = var_8_0.x
	local var_8_3 = arg_8_0.speed.x

	CastleGameVo = var_1_10005
	var_8_0.x = var_8_2 + var_8_3 * var_1_10005.deltaTime

	local var_8_4 = var_8_0.y
	local var_8_5 = arg_8_0.speed.y

	CastleGameVo = var_5
	var_8_0.y = var_8_4 + var_8_5 * var_5.deltaTime

	local var_8_6, var_8_7 = arg_8_0:checkOutland(var_8_0)

	if var_8_6 and var_8_7 then
		arg_8_0.charTf.anchoredPosition = var_8_7
		var_1_10007 = arg_8_0

		arg_8_0.updateDirect(var_1_10007, var_8_7)
	end

	local var_8_8 = var_8_1.y
	local var_8_9 = arg_8_0.speed.z

	CastleGameVo = var_1_10007
	var_8_1.y = var_8_8 + var_8_9 * var_1_10007.deltaTime
	arg_8_0.zPos.anchoredPosition = var_8_1

	return
end

function var_0_0.updateDirect(arg_9_0, arg_9_1)
	if arg_9_1.x ~= 0 then
		local var_9_0 = arg_9_0.speed.x > 0 and 1 or -1

		if arg_9_0.charTf.localScale.x ~= var_9_0 then
			local var_9_1 = arg_9_0.charTf

			Vector3 = var_1_10004
			var_9_1.localScale = var_1_10004(var_9_0, 1, 1)
			arg_9_0.charDirect = var_9_0
		end
	end

	return
end

function var_0_0.checkOutland(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.outlandPoint then
		local var_10_0 = arg_10_0.outlandPoint.lb
		local var_10_1 = arg_10_0.outlandPoint.lt
		local var_10_2 = arg_10_0.outlandPoint.rt
		local var_10_3 = arg_10_0.outlandPoint.rb
		local var_10_4 = arg_10_0.outlandPoint.exlb
		local var_10_5 = arg_10_0.outlandPoint.exlt
		local var_10_6 = arg_10_0.outlandPoint.exrt
		local var_10_7 = arg_10_0.outlandPoint.exrb

		CastleGameVo = var_1_10011

		local var_10_8

		if var_1_10011.PointLeftLine(arg_10_1, var_10_0, var_10_1) then
			CastleGameVo = var_10_8

			local var_10_9

			var_10_8, var_10_9 = var_10_8.PointFootLine(arg_10_1, var_10_4, var_10_5)

			if var_10_9 then
				return arg_10_0:checkOutland(var_10_8, var_10_9)
			else
				return false
			end
		end

		CastleGameVo = var_10_8

		local var_10_10

		if var_10_8.PointLeftLine(arg_10_1, var_10_3, var_10_0) then
			CastleGameVo = var_10_10

			local var_10_11

			var_10_10, var_10_11 = var_10_10.PointFootLine(arg_10_1, var_10_7, var_10_4)

			if var_10_11 then
				return arg_10_0:checkOutland(var_10_10)
			else
				return false
			end
		end

		CastleGameVo = var_10_10

		local var_10_12

		if var_10_10.PointLeftLine(arg_10_1, var_10_1, var_10_2) then
			CastleGameVo = var_10_12

			local var_10_13

			var_10_12, var_10_13 = var_10_12.PointFootLine(arg_10_1, var_10_5, var_10_6)

			if var_10_13 then
				return arg_10_0:checkOutland(var_10_12)
			else
				return false
			end
		end

		CastleGameVo = var_10_12

		if var_10_12.PointLeftLine(arg_10_1, var_10_2, var_10_3) then
			CastleGameVo = var_11

			local var_10_14, var_10_15 = var_11.PointFootLine(arg_10_1, var_10_6, var_10_7)

			if var_10_15 then
				return arg_10_0:checkOutland(var_10_14)
			else
				return false
			end
		end
	end

	return true, arg_10_1
end

function var_0_0.updateSpeed(arg_11_0)
	if arg_11_0.addSpeedTime then
		local var_11_0 = arg_11_0.addSpeedTime

		if 0 < var_11_0 then
			local var_11_1 = arg_11_0.addSpeedTime

			CastleGameVo = var_2
			arg_11_0.addSpeedTime = var_11_1 - var_2.deltaTime

			if arg_11_0.addSpeedTime <= 0 then
				arg_11_0.addSpeedTime = nil
				arg_11_0.addSpeed = 0
			end
		end
	end

	if not arg_11_0.inGround then
		local var_11_2 = arg_11_0.speed
		local var_11_3

		if not (arg_11_0.speed.z > -1500) or not (arg_11_0.speed.z - 20) then
			var_11_3 = -1500
		end

		var_11_2.z = var_11_3
	elseif arg_11_0.inBubble then
		arg_11_0.speed.x = 0
		arg_11_0.speed.y = 0

		local var_11_4 = arg_11_0.speed

		var_11_4.z = 0
		print = var_11_4

		var_11_4("角色在气泡中，无法移动")
	else
		local var_11_5

		if arg_11_0.fail then
			var_11_5 = arg_11_0.speed
			var_11_5.x = 0
			var_11_5 = arg_11_0.speed
			var_11_5.y = 0
			var_11_5 = arg_11_0.speed
			var_11_5.z = 0
			print = var_11_5

			var_11_5("被车撞了，无法移动")
		else
			CastleGameVo = var_11_5

			if var_11_5.joyStickData then
				CastleGameVo = var_1

				local var_11_6 = var_1.joyStickData.x
				local var_11_7 = var_1.y
				local var_11_8 = arg_11_0.speed
				local var_11_9 = var_1.x

				CastleGameVo = var_1_10006
				var_11_8.x = var_11_9 * (var_1_10006.char_speed + arg_11_0.addSpeed)

				local var_11_10 = arg_11_0.speed
				local var_11_11 = var_1.y

				CastleGameVo = var_6
				var_11_10.y = var_11_11 * (var_6.char_speed + arg_11_0.addSpeed)

				local var_11_12 = arg_11_0.speed

				math = var_5

				local var_11_13 = var_5.abs(arg_11_0.speed.x)

				CastleGameVo = var_6
				var_11_12.x = var_11_13 < var_6.char_speed_min and 0 or arg_11_0.speed.x

				local var_11_14 = arg_11_0.speed

				math = var_5

				local var_11_15 = var_5.abs(arg_11_0.speed.y)

				CastleGameVo = var_6
				var_11_14.y = var_11_15 < var_6.char_speed_min and 0 or arg_11_0.speed.y

				arg_11_0:updateDirect(arg_11_0.speed)
			else
				arg_11_0.speed.x = 0
				arg_11_0.speed.y = 0
			end
		end
	end

	return
end

function var_0_0.updateAnim(arg_12_0)
	local var_12_0

	if not arg_12_0.inGround then
		var_12_0 = var_0_7
	elseif arg_12_0.inBubble then
		var_12_0 = var_0_8
	elseif arg_12_0.fail then
		var_12_0 = var_0_9
	else
		math = var_2

		local var_12_1 = var_2.max

		math = var_1_10004

		local var_12_2 = var_1_10004.abs(arg_12_0.speed.x)

		math = var_1_10005

		if var_12_1(var_12_2, var_1_10005.abs(arg_12_0.speed.y)) > 120 then
			var_12_0 = var_0_4
		elseif var_2 > 0 then
			var_12_0 = var_0_5
		else
			var_12_0 = var_0_6
		end
	end

	if arg_12_0.action ~= var_12_0 then
		arg_12_0:changeAnimAction(arg_12_0.anim, var_12_0, 0)
	end

	return
end

function var_0_0.setScore(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.data.speed
	local var_13_1 = arg_13_1.data.time

	if var_13_0 >= arg_13_0.addSpeed then
		arg_13_0.addSpeed = var_13_0
	end

	arg_13_0.addSpeedTime = var_13_1

	return
end

function var_0_0.setPlayerFail(arg_14_0)
	arg_14_0.fail = true
	arg_14_0.timeToOver = 1

	arg_14_0:playerDead()

	return
end

function var_0_0.setContent(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._content = arg_15_1
	setParent = var_1_10003

	var_1_10003(arg_15_0.charTf, arg_15_0._content, true)

	local var_15_0 = arg_15_0.charTf

	Vector3 = var_1_10004
	var_15_0.localScale = var_1_10004(1, 1, 1)

	if arg_15_2 then
		arg_15_0.charTf.anchoredPosition = arg_15_2
	end

	return
end

function var_0_0.getPoint(arg_16_0)
	return arg_16_0.charTf.anchoredPosition
end

function var_0_0.start(arg_17_0)
	arg_17_0.charTf.anchoredPosition = var_0_1

	local var_17_0 = arg_17_0.zPos

	Vector2 = var_2
	var_17_0.anchoredPosition = var_2(0, var_0_1.y)
	setActive = var_17_0

	var_17_0(arg_17_0.charTf, true)

	arg_17_0.inGround = true
	arg_17_0.inBubble = false
	arg_17_0.fail = false
	arg_17_0.timeToOver = nil
	Vector3 = var_1
	arg_17_0.speed = var_1(0, 0, 0)
	arg_17_0.addSpeed = 0
	arg_17_0.addSpeedTime = 0

	arg_17_0:changeAnimAction(arg_17_0.anim, var_0_6, 0)

	return
end

function var_0_0.clear(arg_18_0)
	return
end

function var_0_0.checkPlayerOutScreen(arg_19_0)
	math = var_1_10001

	if var_1_10001.abs(arg_19_0.zPos.anchoredPosition.y) > 2000 then
		local var_19_0 = arg_19_0._event
		local var_19_1 = var_1.emit

		CastleGameView = var_1_10004

		var_19_1(var_19_0, var_1_10004.GAME_OVER)
	end

	return
end

function var_0_0.setInBubble(arg_20_0, arg_20_1)
	arg_20_0.inBubble = arg_20_1

	if arg_20_1 then
		arg_20_0.lastBubblePos = arg_20_0.char.tf.anchoredPosition
	else
		arg_20_0.char.tf.anchoredPosition = arg_20_0.lastBubblePos
	end

	return
end

function var_0_0.getActionAble(arg_21_0)
	if not arg_21_0.inGround then
		return false
	end

	if arg_21_0.inBubble then
		return false
	end

	if arg_21_0.fail then
		return false
	end

	return true
end

function var_0_0.press(arg_22_0, arg_22_1)
	return
end

function var_0_0.playerDead(arg_23_0)
	arg_23_0.action = var_0_9

	local var_23_0 = arg_23_0.anim
	local var_23_1 = var_1.GetAnimationState(var_23_0)

	var_1.SetAnimation(var_23_1, 0, var_0_9, false)

	return
end

function var_0_0.changeAnimAction(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	arg_24_0.action = arg_24_2

	arg_24_1:SetActionCallBack(nil)
	arg_24_1:SetAction(arg_24_2, 0)
	arg_24_1:SetActionCallBack(function(arg_25_0)
		if arg_25_0 == "finish" then
			if arg_24_3 == 1 then
				local var_25_0 = arg_24_1

				var_1.SetActionCallBack(var_25_0, nil)
			end

			if arg_24_5 then
				arg_24_5()
			end
		end

		return
	end)

	if arg_24_3 ~= 1 and arg_24_5 then
		arg_24_5()
	end

	return
end

function var_0_0.getChar(arg_26_0)
	return arg_26_0.char
end

function var_0_0.getTfs(arg_27_0)
	return {
		arg_27_0.charTf
	}
end

return var_0_0
