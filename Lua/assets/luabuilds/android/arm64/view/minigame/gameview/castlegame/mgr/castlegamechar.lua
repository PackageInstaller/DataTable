local var_0_0 = class("CastleGameChar")
local var_0_1 = Vector3(0, 0)
local var_0_2 = "qiye_6_SkeletonData"
local var_0_3 = 3
local var_0_4 = "activity_run"
local var_0_5 = "walk"
local var_0_6 = "activity_wait"
local var_0_7 = "tuozhuai2"
local var_0_8 = "tuozhuai2"
local var_0_9 = "dead"
local var_0_10 = Vector3(0, 0, -1)

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

	arg_2_0.charTf = tf(instantiate(arg_2_0._charTpl))
	arg_2_0.speed = Vector3(0, 0, 0)
	arg_2_0.colliderTf = findTF(arg_2_0.charTf, "zPos/collider")
	arg_2_0.collider = GetComponent(arg_2_0.colliderTf, typeof(BoxCollider2D))
	arg_2_0.zPos = findTF(arg_2_0.charTf, "zPos")
	arg_2_0.raycastPoints = {}

	for iter_2_0 = 1, var_0_3 do
		table.insert(arg_2_0.raycastPoints, Vector3(0, 0, 0))
	end

	CastleGameVo.LoadSkeletonData(var_0_2, function(arg_3_0)
		arg_3_0.transform.localScale = Vector3(1, 1, 1)
		arg_3_0.transform.localPosition = Vector3(0, 0, 0)

		arg_3_0:SetActive(true)
		SetParent(tf(arg_3_0), findTF(arg_2_0.charTf, "zPos/char"))

		arg_2_0.graphic = arg_3_0:GetComponent("SkeletonGraphic")
		arg_2_0.anim = arg_3_0:GetComponent(typeof(SpineAnimUI))
		arg_2_0.charTf.anchoredPosition = var_0_1
		arg_2_0.zPos.anchoredPosition = Vector2(0, var_0_1.z)

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
		arg_4_0.speed = Vector3(0, 0, 0)
	end

	if arg_4_0.char.floor then
		arg_4_0:setContent(findTF(arg_4_0.char.floor.tf, "zPos/top"))
	end

	return
end

function var_0_0.setOutLandPoint(arg_5_0, arg_5_1)
	arg_5_0.outlandPoint = arg_5_1
	arg_5_0.outlandPoint.exlb = Vector2(arg_5_0.outlandPoint.lb.x + 2, arg_5_0.outlandPoint.lb.y)
	arg_5_0.outlandPoint.exlt = Vector2(arg_5_0.outlandPoint.lt.x, arg_5_0.outlandPoint.lt.y - 2)
	arg_5_0.outlandPoint.exrt = Vector2(arg_5_0.outlandPoint.rt.x - 2, arg_5_0.outlandPoint.rt.y)
	arg_5_0.outlandPoint.exrb = Vector2(arg_5_0.outlandPoint.rb.x, arg_5_0.outlandPoint.rb.y + 2)

	return
end

function var_0_0.step(arg_6_0)
	if arg_6_0.timeToOver and arg_6_0.timeToOver > 0 then
		arg_6_0.timeToOver = arg_6_0.timeToOver - CastleGameVo.deltaTime

		if arg_6_0.timeToOver <= 0 then
			arg_6_0.timeToOver = nil

			arg_6_0._event:emit(CastleGameView.GAME_OVER)
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
	arg_8_0.charTf.anchoredPosition.x = arg_8_0.charTf.anchoredPosition.x + arg_8_0.speed.x * CastleGameVo.deltaTime
	arg_8_0.charTf.anchoredPosition.y = arg_8_0.charTf.anchoredPosition.y + arg_8_0.speed.y * CastleGameVo.deltaTime

	local var_8_0, var_8_1 = arg_8_0:checkOutland(arg_8_0.charTf.anchoredPosition)

	if var_8_0 and var_8_1 then
		arg_8_0.charTf.anchoredPosition = var_8_1

		arg_8_0:updateDirect(var_8_1)
	end

	arg_8_0.zPos.anchoredPosition.y = arg_8_0.zPos.anchoredPosition.y + arg_8_0.speed.z * CastleGameVo.deltaTime
	arg_8_0.zPos.anchoredPosition = arg_8_0.zPos.anchoredPosition

	return
end

function var_0_0.updateDirect(arg_9_0, arg_9_1)
	if arg_9_1.x ~= 0 then
		local var_9_0 = arg_9_0.speed.x > 0 and 1 or -1

		if arg_9_0.charTf.localScale.x ~= (arg_9_0.speed.x > 0 and 1 or -1) then
			arg_9_0.charTf.localScale = Vector3(var_9_0, 1, 1)
			arg_9_0.charDirect = var_9_0
		end
	end

	return
end

function var_0_0.checkOutland(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.outlandPoint then
		if CastleGameVo.PointLeftLine(arg_10_1, arg_10_0.outlandPoint.lb, arg_10_0.outlandPoint.lt) then
			local var_10_0, var_10_1 = CastleGameVo.PointFootLine(arg_10_1, arg_10_0.outlandPoint.exlb, arg_10_0.outlandPoint.exlt)

			if var_10_1 then
				return arg_10_0:checkOutland(var_10_0, var_10_1)
			else
				return false
			end
		end

		if CastleGameVo.PointLeftLine(arg_10_1, arg_10_0.outlandPoint.rb, arg_10_0.outlandPoint.lb) then
			local var_10_2, var_10_3 = CastleGameVo.PointFootLine(arg_10_1, arg_10_0.outlandPoint.exrb, arg_10_0.outlandPoint.exlb)

			if var_10_3 then
				return arg_10_0:checkOutland(var_10_2)
			else
				return false
			end
		end

		if CastleGameVo.PointLeftLine(arg_10_1, arg_10_0.outlandPoint.lt, arg_10_0.outlandPoint.rt) then
			local var_10_4, var_10_5 = CastleGameVo.PointFootLine(arg_10_1, arg_10_0.outlandPoint.exlt, arg_10_0.outlandPoint.exrt)

			if var_10_5 then
				return arg_10_0:checkOutland(var_10_4)
			else
				return false
			end
		end

		if CastleGameVo.PointLeftLine(arg_10_1, arg_10_0.outlandPoint.rt, arg_10_0.outlandPoint.rb) then
			local var_10_6, var_10_7 = CastleGameVo.PointFootLine(arg_10_1, arg_10_0.outlandPoint.exrt, arg_10_0.outlandPoint.exrb)

			if var_10_7 then
				return arg_10_0:checkOutland(var_10_6)
			else
				return false
			end
		end
	end

	return true, arg_10_1
end

function var_0_0.updateSpeed(arg_11_0)
	if arg_11_0.addSpeedTime and arg_11_0.addSpeedTime > 0 then
		arg_11_0.addSpeedTime = arg_11_0.addSpeedTime - CastleGameVo.deltaTime

		if arg_11_0.addSpeedTime <= 0 then
			arg_11_0.addSpeedTime = nil
			arg_11_0.addSpeed = 0
		end
	end

	if not arg_11_0.inGround then
		local var_11_0 = arg_11_0.speed

		if arg_11_0.speed.z > -1500 then
			var_11_0.z = arg_11_0.speed.z - 20 or -1500

			if false then
				if arg_11_0.inBubble then
					arg_11_0.speed.x = 0
					arg_11_0.speed.y = 0
					arg_11_0.speed.z = 0

					print("角色在气泡中，无法移动")
				elseif arg_11_0.fail then
					arg_11_0.speed.x = 0
					arg_11_0.speed.y = 0
					arg_11_0.speed.z = 0

					print("被车撞了，无法移动")
				elseif CastleGameVo.joyStickData then
					arg_11_0.speed.x = CastleGameVo.joyStickData.x * (CastleGameVo.char_speed + arg_11_0.addSpeed)
					arg_11_0.speed.y = CastleGameVo.joyStickData.y * (CastleGameVo.char_speed + arg_11_0.addSpeed)
					arg_11_0.speed.x = math.abs(arg_11_0.speed.x) < CastleGameVo.char_speed_min and 0 or arg_11_0.speed.x
					arg_11_0.speed.y = math.abs(arg_11_0.speed.y) < CastleGameVo.char_speed_min and 0 or arg_11_0.speed.y

					arg_11_0:updateDirect(arg_11_0.speed)
				else
					arg_11_0.speed.x = 0
					arg_11_0.speed.y = 0
				end
			end

			return
		end
	end
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
		local var_12_1 = math.max(math.abs(arg_12_0.speed.x), math.abs(arg_12_0.speed.y))

		var_12_0 = var_12_1 > 120 and var_0_4 or var_12_1 > 0 and var_0_5 or var_0_6
	end

	if arg_12_0.action ~= var_12_0 then
		arg_12_0:changeAnimAction(arg_12_0.anim, var_12_0, 0)
	end

	return
end

function var_0_0.setScore(arg_13_0, arg_13_1)
	if arg_13_1.data.speed >= arg_13_0.addSpeed then
		arg_13_0.addSpeed = arg_13_1.data.speed
	end

	arg_13_0.addSpeedTime = arg_13_1.data.time

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

	setParent(arg_15_0.charTf, arg_15_0._content, true)

	arg_15_0.charTf.localScale = Vector3(1, 1, 1)

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
	arg_17_0.zPos.anchoredPosition = Vector2(0, var_0_1.y)

	setActive(arg_17_0.charTf, true)

	arg_17_0.inGround = true
	arg_17_0.inBubble = false
	arg_17_0.fail = false
	arg_17_0.timeToOver = nil
	arg_17_0.speed = Vector3(0, 0, 0)
	arg_17_0.addSpeed = 0
	arg_17_0.addSpeedTime = 0

	arg_17_0:changeAnimAction(arg_17_0.anim, var_0_6, 0)

	return
end

function var_0_0.clear(arg_18_0)
	return
end

function var_0_0.checkPlayerOutScreen(arg_19_0)
	if math.abs(arg_19_0.zPos.anchoredPosition.y) > 2000 then
		arg_19_0._event:emit(CastleGameView.GAME_OVER)
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

	arg_23_0.anim:GetAnimationState():SetAnimation(0, var_0_9, false)

	return
end

function var_0_0.changeAnimAction(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	arg_24_0.action = arg_24_2

	arg_24_1:SetActionCallBack(nil)
	arg_24_1:SetAction(arg_24_2, 0)
	arg_24_1:SetActionCallBack(function(arg_25_0)
		if arg_25_0 == "finish" then
			if arg_24_3 == 1 then
				arg_24_1:SetActionCallBack(nil)
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
