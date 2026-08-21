local var_0_0 = class("OreContainerControl")

var_0_0.BREAK_MOVE_TIME = 0.5

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.binder = arg_1_1
	arg_1_0._tf = arg_1_2

	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0:AddListener()

	arg_2_0.deliverSpeed = 50
	arg_2_0.mainTF = arg_2_0._tf:Find("Container_1/break")

	return
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0.binder:bind(OreGameConfig.EVENT_DELIVER, function(arg_4_0, arg_4_1)
		arg_3_0:PlayDeliverAnim(arg_4_1.status, arg_4_1.pos, arg_4_1.oreTF)

		return
	end)
	arg_3_0.binder:bind(OreGameConfig.EVENT_PLAY_CONTAINER_HIT, function(arg_5_0, arg_5_1)
		arg_3_0:PlayHitAnim(arg_5_1.status, arg_5_1.pos, arg_5_1.hitPos, arg_5_1.oreTF)

		return
	end)

	return
end

var_0_0.DeliveOffsetY = {
	-7,
	-7,
	-16
}

function var_0_0.PlayDeliverAnim(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.mainTF = arg_6_0._tf:Find("Container_" .. arg_6_1 .. "/deliver")

	setAnchoredPosition(arg_6_0.mainTF, {
		x = arg_6_2.x,
		y = arg_6_2.y + var_0_0.DeliveOffsetY[arg_6_1]
	})
	setActive(arg_6_0.mainTF, true)

	local var_6_0 = arg_6_0.mainTF:Find("ore/pos")

	removeAllChildren(var_6_0)
	cloneTplTo(arg_6_3, var_6_0)
	arg_6_0.mainTF:Find("BK/Image"):GetComponent(typeof(Animator)):Play("Deliver_2_Lift_BK")
	arg_6_0.mainTF:Find("FR/Image"):GetComponent(typeof(Animator)):Play("Deliver_2_Lift_FR")

	arg_6_0.deliverTime = 0

	return
end

var_0_0.moveRata = {
	1,
	1.2,
	1.5
}

function var_0_0.PlayHitAnim(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_1 == OreAkashiControl.STATUS_NULL then
		return
	end

	arg_7_0.mainTF = arg_7_0._tf:Find("Container_" .. arg_7_1 .. "/break")

	setAnchoredPosition(arg_7_0.mainTF, arg_7_2)
	setActive(arg_7_0.mainTF, true)

	local var_7_0 = arg_7_0.mainTF.parent:Find("ore/pos")

	removeAllChildren(var_7_0)

	arg_7_0.orePosList = {}
	arg_7_0.oreTFs = cloneTplTo(arg_7_4, var_7_0):Find("oreTF")
	arg_7_0.hitPos = {
		x = -arg_7_3.x * var_0_0.moveRata[arg_7_1],
		y = -arg_7_3.y * var_0_0.moveRata[arg_7_1]
	}

	setAnchoredPosition(var_7_0, Vector2(arg_7_2.x + arg_7_0.hitPos.x, arg_7_2.y + arg_7_0.hitPos.y))
	arg_7_0.mainTF:Find("main/Image"):GetComponent(typeof(Animator)):Play("Break")

	arg_7_0.breakTime = 0

	eachChild(arg_7_0.oreTFs, function(arg_8_0)
		arg_7_0.orePosList[arg_8_0.name] = {
			x = math.random(50) - 25,
			y = math.random(50) - 25
		}

		return
	end)

	return
end

function var_0_0.Reset(arg_9_0)
	arg_9_0.deliverTime = nil
	arg_9_0.breakTime = nil
	arg_9_0.oreTFs = nil

	setActive(arg_9_0.mainTF, false)
	setActive(arg_9_0.mainTF.parent:Find("ore/pos"), false)
	removeAllChildren(arg_9_0.mainTF.parent:Find("ore/pos"))
	setAnchoredPosition(arg_9_0.mainTF, Vector2(0, 0))

	return
end

function var_0_0.OnTimer(arg_10_0, arg_10_1)
	if arg_10_0.deliverTime then
		setAnchoredPosition(arg_10_0.mainTF, {
			x = arg_10_0.mainTF.anchoredPosition.x,
			y = arg_10_0.mainTF.anchoredPosition.y - arg_10_1 * arg_10_0.deliverSpeed
		})

		arg_10_0.deliverTime = arg_10_0.deliverTime + arg_10_1

		if arg_10_0.mainTF.anchoredPosition.y < -230 then
			removeAllChildren(arg_10_0.mainTF:Find("ore/pos"))
			arg_10_0:Reset()
		end
	end

	if arg_10_0.breakTime then
		setAnchoredPosition(arg_10_0.mainTF, {
			x = arg_10_0.mainTF.anchoredPosition.x + arg_10_0.hitPos.x * arg_10_1 / var_0_0.BREAK_MOVE_TIME,
			y = arg_10_0.mainTF.anchoredPosition.y + arg_10_0.hitPos.y * arg_10_1 / var_0_0.BREAK_MOVE_TIME
		})

		arg_10_0.breakTime = arg_10_0.breakTime + arg_10_1

		if arg_10_0.breakTime >= var_0_0.BREAK_MOVE_TIME / 3 then
			if not isActive(arg_10_0.mainTF.parent:Find("ore/pos")) then
				setActive(arg_10_0.mainTF.parent:Find("ore/pos"), true)
			end

			eachChild(arg_10_0.oreTFs, function(arg_11_0)
				setAnchoredPosition(arg_11_0, {
					x = arg_11_0.anchoredPosition.x + arg_10_0.orePosList[arg_11_0.name].x * arg_10_1 / (var_0_0.BREAK_MOVE_TIME * 2 / 3),
					y = arg_11_0.anchoredPosition.y + arg_10_0.orePosList[arg_11_0.name].y * arg_10_1 / (var_0_0.BREAK_MOVE_TIME * 2 / 3)
				})

				return
			end)
		end

		if arg_10_0.breakTime >= var_0_0.BREAK_MOVE_TIME then
			arg_10_0:Reset()
		end
	end

	return
end

return var_0_0
