class = var_0_10000

local var_0_0 = var_0_10000("OreContainerControl")

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

	local var_2_0 = arg_2_0._tf

	arg_2_0.mainTF = var_1.Find(var_2_0, "Container_1/break")

	return
end

function var_0_0.AddListener(arg_3_0)
	local var_3_0 = arg_3_0.binder
	local var_3_1 = var_1.bind

	OreGameConfig = var_1_10003

	var_3_1(var_3_0, var_1_10003.EVENT_DELIVER, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_3_0

		var_2.PlayDeliverAnim(var_4_0, arg_4_1.status, arg_4_1.pos, arg_4_1.oreTF)

		return
	end)

	local var_3_2 = arg_3_0.binder
	local var_3_3 = var_1.bind

	OreGameConfig = var_3

	var_3_3(var_3_2, var_3.EVENT_PLAY_CONTAINER_HIT, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_3_0

		var_2.PlayHitAnim(var_5_0, arg_5_1.status, arg_5_1.pos, arg_5_1.hitPos, arg_5_1.oreTF)

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
	local var_6_0 = arg_6_0._tf

	arg_6_0.mainTF = var_4.Find(var_6_0, "Container_" .. arg_6_1 .. "/deliver")
	setAnchoredPosition = var_4

	var_4(arg_6_0.mainTF, {
		x = arg_6_2.x,
		y = arg_6_2.y + var_0_0.DeliveOffsetY[arg_6_1]
	})

	setActive = var_4

	var_4(arg_6_0.mainTF, true)

	local var_6_1 = arg_6_0.mainTF
	local var_6_2 = var_4.Find(var_6_1, "ore/pos")

	removeAllChildren = var_6_1

	var_6_1(var_6_2)

	cloneTplTo = var_6_1

	var_6_1(arg_6_3, var_6_2)

	local var_6_3 = arg_6_0.mainTF
	local var_6_4 = var_5.Find(var_6_3, "BK/Image")
	local var_6_5 = var_5.GetComponent

	typeof = var_7
	Animator = var_8

	local var_6_6 = var_6_5(var_6_4, var_7(var_8))

	var_5.Play(var_6_6, "Deliver_2_Lift_BK")

	local var_6_7 = arg_6_0.mainTF
	local var_6_8 = var_5.Find(var_6_7, "FR/Image")
	local var_6_9 = var_5.GetComponent

	typeof = var_7
	Animator = var_8

	local var_6_10 = var_6_9(var_6_8, var_7(var_8))

	var_5.Play(var_6_10, "Deliver_2_Lift_FR")

	arg_6_0.deliverTime = 0

	return
end

var_0_0.moveRata = {
	1,
	1.2,
	1.5
}

function var_0_0.PlayHitAnim(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	OreAkashiControl = var_1_10005

	if arg_7_1 == var_1_10005.STATUS_NULL then
		return
	end

	local var_7_0 = arg_7_0._tf

	arg_7_0.mainTF = var_5.Find(var_7_0, "Container_" .. arg_7_1 .. "/break")
	setAnchoredPosition = var_5

	var_5(arg_7_0.mainTF, arg_7_2)

	setActive = var_5

	var_5(arg_7_0.mainTF, true)

	local var_7_1 = arg_7_0.mainTF.parent
	local var_7_2 = var_5.Find(var_7_1, "ore/pos")

	removeAllChildren = var_7_1

	var_7_1(var_7_2)

	arg_7_0.orePosList = {}
	cloneTplTo = var_6

	local var_7_3 = var_6(arg_7_4, var_7_2)

	arg_7_0.oreTFs = var_6.Find(var_7_3, "oreTF")
	arg_7_0.hitPos = {
		x = -arg_7_3.x * var_0_0.moveRata[arg_7_1],
		y = -arg_7_3.y * var_0_0.moveRata[arg_7_1]
	}
	setAnchoredPosition = var_6

	local var_7_4 = var_7_2

	Vector2 = var_8

	var_6(var_7_4, var_8(arg_7_2.x + arg_7_0.hitPos.x, arg_7_2.y + arg_7_0.hitPos.y))

	local var_7_5 = arg_7_0.mainTF
	local var_7_6 = var_6.Find(var_7_5, "main/Image")
	local var_7_7 = var_6.GetComponent

	typeof = var_8
	Animator = var_9

	local var_7_8 = var_7_7(var_7_6, var_8(var_9))

	var_6.Play(var_7_8, "Break")

	arg_7_0.breakTime = 0
	eachChild = var_6

	var_6(arg_7_0.oreTFs, function(arg_8_0)
		local var_8_0 = arg_7_0.orePosList
		local var_8_1 = arg_8_0.name
		local var_8_2 = {}

		math = var_2_10004
		var_8_2.x = var_2_10004.random(50) - 25
		math = var_4
		var_8_2.y = var_4.random(50) - 25
		var_8_0[var_8_1] = var_8_2

		return
	end)

	return
end

function var_0_0.Reset(arg_9_0)
	arg_9_0.deliverTime = nil
	arg_9_0.breakTime = nil
	arg_9_0.oreTFs = nil
	setActive = var_1

	var_1(arg_9_0.mainTF, false)

	setActive = var_1

	local var_9_0 = arg_9_0.mainTF.parent

	var_1(var_2.Find(var_9_0, "ore/pos"), false)

	removeAllChildren = var_1

	local var_9_1 = arg_9_0.mainTF.parent

	var_1(var_2.Find(var_9_1, "ore/pos"))

	setAnchoredPosition = var_1

	local var_9_2 = arg_9_0.mainTF

	Vector2 = var_9_1

	var_1(var_9_2, var_9_1(0, 0))

	return
end

function var_0_0.OnTimer(arg_10_0, arg_10_1)
	if arg_10_0.deliverTime then
		local var_10_0 = arg_10_1 * arg_10_0.deliverSpeed

		setAnchoredPosition = var_1_10003

		var_1_10003(arg_10_0.mainTF, {
			x = arg_10_0.mainTF.anchoredPosition.x,
			y = arg_10_0.mainTF.anchoredPosition.y - var_10_0
		})

		arg_10_0.deliverTime = arg_10_0.deliverTime + arg_10_1

		if arg_10_0.mainTF.anchoredPosition.y < -230 then
			removeAllChildren = var_3

			local var_10_1 = arg_10_0.mainTF

			var_3(var_4.Find(var_10_1, "ore/pos"))
			arg_10_0:Reset()
		end
	end

	if arg_10_0.breakTime then
		local var_10_2 = {
			x = arg_10_0.mainTF.anchoredPosition.x + arg_10_0.hitPos.x * arg_10_1 / var_0_0.BREAK_MOVE_TIME,
			y = arg_10_0.mainTF.anchoredPosition.y + arg_10_0.hitPos.y * arg_10_1 / var_0_0.BREAK_MOVE_TIME
		}

		setAnchoredPosition = var_3

		var_3(arg_10_0.mainTF, var_10_2)

		arg_10_0.breakTime = arg_10_0.breakTime + arg_10_1

		if arg_10_0.breakTime >= var_0_0.BREAK_MOVE_TIME / 3 then
			isActive = var_3

			local var_10_3 = arg_10_0.mainTF.parent

			if not var_3(var_4.Find(var_10_3, "ore/pos")) then
				setActive = var_3

				local var_10_4 = arg_10_0.mainTF.parent

				var_3(var_4.Find(var_10_4, "ore/pos"), true)
			end

			eachChild = var_3

			var_3(arg_10_0.oreTFs, function(arg_11_0)
				local var_11_0 = arg_10_0.orePosList[arg_11_0.name]
				local var_11_1 = {
					x = arg_11_0.anchoredPosition.x + var_11_0.x * arg_10_1 / (var_0_0.BREAK_MOVE_TIME * 2 / 3),
					y = arg_11_0.anchoredPosition.y + var_11_0.y * arg_10_1 / (var_0_0.BREAK_MOVE_TIME * 2 / 3)
				}

				setAnchoredPosition = var_3

				var_3(arg_11_0, var_11_1)

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
