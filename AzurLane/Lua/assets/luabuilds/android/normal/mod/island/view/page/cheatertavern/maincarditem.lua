class = var_0_10000

local var_0_0 = var_0_10000("MainCardItem")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.isLoaded = false

	arg_1_0:Init(arg_1_1, arg_1_2, arg_1_3)

	return
end

function var_0_0.Init(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.key = arg_2_1.key
	arg_2_0.id = arg_2_1.id
	arg_2_0.index = arg_2_1.index
	arg_2_0.hasSend = false
	arg_2_0.cardPoolMgr = arg_2_2

	if arg_2_1.allCount then
		arg_2_0:SetAllCount(arg_2_1.allCount)
	end

	if arg_2_3 then
		arg_2_0:SetUIRoot(arg_2_3)
	end

	arg_2_0.mainPlayerSeat = arg_2_1.mainPlayerSeat

	local function var_2_0(arg_3_0)
		local var_3_0 = arg_2_0

		tf = var_2_10002
		var_3_0.tf = var_2_10002(arg_3_0)
		arg_2_0.isLoaded = true

		local var_3_1 = arg_2_0
		local var_3_2 = arg_2_0.tf

		var_3_1.selectedCardTf = var_2.Find(var_3_2, "vfx_bar_kapai01")

		local var_3_3 = arg_2_0
		local var_3_4 = arg_2_0.tf

		var_3_3.unSelectedCardTf = var_2.Find(var_3_4, "vfx_bar_kapai02")

		local var_3_5 = arg_2_0

		var_1.SetSelected(var_3_5, false)

		GetOrAddComponent = var_1

		local var_3_6 = arg_3_0

		typeof = var_3
		CheaterTavernCard = var_4

		local var_3_7 = var_1(var_3_6, var_3(var_4))

		var_3_7.key = arg_2_0.key
		var_3_7.parm = arg_2_0.id

		local var_3_8 = arg_2_0

		var_2.InitCardView(var_3_8)

		return
	end

	local var_2_1 = arg_2_0.cardPoolMgr

	var_5.GetCardGameObjectById(var_2_1, arg_2_0.id, var_2_0)

	return
end

function var_0_0.SetIndex(arg_4_0, arg_4_1)
	arg_4_0.index = arg_4_1

	return
end

function var_0_0.SetUIRoot(arg_5_0, arg_5_1)
	arg_5_0.rootTransform = arg_5_1

	return
end

function var_0_0.SetAllCount(arg_6_0, arg_6_1)
	arg_6_0.allCount = arg_6_1

	return
end

function var_0_0.SetCurveOffsetY(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0.cureveX = arg_7_1
	arg_7_0.cureveY = arg_7_2
	arg_7_0.cureveZ = arg_7_3

	return
end

function var_0_0.InitCardView(arg_8_0)
	if arg_8_0.hasSend then
		return
	end

	setActive = var_1

	var_1(arg_8_0.tf.gameObject, true)

	local var_8_0 = 0.001
	local var_8_1 = arg_8_0.index

	setParent = var_3

	var_3(arg_8_0.tf, arg_8_0.rootTransform, false)

	local var_8_2 = var_8_1 - (arg_8_0.allCount + 1) / 2

	math = var_5

	local var_8_3 = var_5.ceil

	math = var_6

	local var_8_4 = var_8_3(var_6.abs(var_8_2))

	IslandCheaterTavernConst = var_6

	local var_8_5 = var_8_4 * var_6.cardRoationOffset

	if var_8_2 < 0 then
		var_8_5 = -var_8_5
	end

	setLocalRotation = var_7

	local var_8_6 = arg_8_0.tf

	Quaternion = var_1_10009

	var_7(var_8_6, var_1_10009.Euler(0, 180, var_8_5))

	local var_8_7 = arg_8_0.allCount

	IslandCheaterTavernConst = var_8_6

	local var_8_8 = var_8_6.cardWidth

	IslandCheaterTavernConst = var_9

	local var_8_9 = var_9.cardSpace
	local var_8_10 = -(var_8_7 * var_8_8 + (var_8_7 - 1) * var_8_9) / 2 + var_8_8 / 2 + (var_8_1 - 1) * (var_8_8 + var_8_9)
	local var_8_11 = 0.01
	local var_8_12 = -(var_8_2 * var_8_2) * var_8_11

	setLocalPosition = var_1_10015

	local var_8_13 = arg_8_0.tf

	Vector3 = var_1_10017

	var_1_10015(var_8_13, var_1_10017(var_8_10, var_8_12, -var_8_0 * (var_8_1 - 1)))

	setLocalScale = var_1_10015

	local var_8_14 = arg_8_0.tf

	Vector3 = var_17

	var_1_10015(var_8_14, var_17(1, 1, 1))

	return
end

function var_0_0.SetSelected(arg_9_0, arg_9_1)
	arg_9_0.isSelected = arg_9_1

	if arg_9_0.isSelected then
		setLocalPosition = var_2

		local var_9_0 = arg_9_0.tf

		Vector3 = var_1_10004

		var_2(var_9_0, var_1_10004(arg_9_0.tf.localPosition.x, arg_9_0.tf.localPosition.y + 0.02, arg_9_0.tf.localPosition.z))

		setActive = var_2

		var_2(arg_9_0.selectedCardTf, true)

		setActive = var_2

		var_2(arg_9_0.unSelectedCardTf, false)
	else
		setLocalPosition = var_2

		local var_9_1 = arg_9_0.tf

		Vector3 = var_1_10004

		var_2(var_9_1, var_1_10004(arg_9_0.tf.localPosition.x, arg_9_0.tf.localPosition.y - 0.02, arg_9_0.tf.localPosition.z))

		setActive = var_2

		var_2(arg_9_0.selectedCardTf, false)

		setActive = var_2

		var_2(arg_9_0.unSelectedCardTf, true)
	end

	return
end

function var_0_0.Update(arg_10_0)
	if not arg_10_0.isLoaded then
		return
	end

	arg_10_0:UpdateMoveToTable()
	arg_10_0:UpdateFlipTableCard()

	return
end

function var_0_0.UpdateMoveToTable(arg_11_0)
	if not arg_11_0.moveToTable then
		return
	end

	if not arg_11_0.isLoaded then
		return
	end

	Time = var_1
	arg_11_0.deltaTime = var_1.deltaTime + arg_11_0.deltaTime

	local var_11_0 = arg_11_0.deltaTime

	IslandCheaterTavernConst = var_2

	local var_11_1 = var_11_0 / var_2.moveToTableTime
	local var_11_2 = arg_11_0.cureveZ
	local var_11_3 = var_2.Evaluate(var_11_2, var_11_1)

	Vector3 = var_11_2

	local var_11_4 = var_11_2.Lerp(arg_11_0.startPos, arg_11_0.endPos, var_11_3)

	if arg_11_0.mainPlayerSeat == 1 then
		local var_11_5 = var_11_4.z
		local var_11_6 = arg_11_0.cureveX

		var_11_4.z = var_11_5 + var_5.Evaluate(var_11_6, var_11_1) * 0.3
	elseif arg_11_0.mainPlayerSeat == 2 then
		local var_11_7 = var_11_4.x
		local var_11_8 = arg_11_0.cureveX

		var_11_4.x = var_11_7 + var_5.Evaluate(var_11_8, var_11_1) * 0.3
	elseif arg_11_0.mainPlayerSeat == 3 then
		local var_11_9 = var_11_4.z
		local var_11_10 = arg_11_0.cureveX

		var_11_4.z = var_11_9 - var_5.Evaluate(var_11_10, var_11_1) * 0.3
	else
		local var_11_11 = var_11_4.x
		local var_11_12 = arg_11_0.cureveX

		var_11_4.x = var_11_11 - var_5.Evaluate(var_11_12, var_11_1) * 0.3
	end

	local var_11_13 = var_11_4.y
	local var_11_14 = arg_11_0.cureveY

	var_11_4.y = var_11_13 + var_5.Evaluate(var_11_14, var_11_1) * 0.3
	arg_11_0.tf.position = var_11_4

	local var_11_15 = arg_11_0.tf

	Quaternion = var_5
	var_11_15.rotation = var_5.Slerp(arg_11_0.startRotation, arg_11_0.endRotation, var_11_3)

	local var_11_16 = arg_11_0.tf

	Vector3 = var_5
	var_11_16.localScale = var_5.Lerp(arg_11_0.startScale, arg_11_0.endScale, var_11_3)

	if var_11_1 >= 1 then
		arg_11_0.moveToTable = false
		IslandCheaterTavernConst = var_4

		if var_4.putCardTest then
			onDelayTick = var_4

			var_4(function()
				arg_11_0.tf.position = arg_11_0.startPos

				local var_12_0 = arg_11_0

				var_0.SetSelected(var_12_0, false)

				arg_11_0.tf.rotation = arg_11_0.startRotation
				arg_11_0.tf.localScale = arg_11_0.startScale

				return
			end, 1)
		end
	end

	return
end

function var_0_0.MoveToTable(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0.isLoaded then
		return
	end

	setActive = var_3

	var_3(arg_13_0.selectedCardTf, false)

	arg_13_0.hasSend = true
	arg_13_0.moveToTable = true
	arg_13_0.deltaTime = 0
	arg_13_0.startPos = arg_13_0.tf.position
	arg_13_0.startScale = arg_13_0.tf.localScale
	arg_13_0.startRotation = arg_13_0.tf.rotation
	IslandCheaterTavernConst = var_3

	local var_13_0 = var_3.cardWidth * 2
	local var_13_1 = 0
	local var_13_2 = -(arg_13_2 * var_13_0 + (arg_13_2 - 1) * var_13_1) / 2 + var_13_0 / 2 + (arg_13_1 - 1) * (var_13_0 + var_13_1)
	local var_13_3 = 0
	local var_13_4 = 0
	local var_13_5 = 0.001 * arg_13_1

	if arg_13_0.mainPlayerSeat % 2 == 0 then
		var_13_3 = var_13_2
	else
		var_13_4 = var_13_2
	end

	Vector3 = var_11
	arg_13_0.endPos = var_11(6.29 + var_13_3, 0.92 + var_13_5, 2.11 + var_13_4)
	IslandCheaterTavernConst = var_11

	local var_13_6 = var_11.seatRotatonY[arg_13_0.mainPlayerSeat]

	Quaternion = var_12
	arg_13_0.endRotation = var_12.Euler(90, var_13_6, 0)
	Vector3 = var_12
	arg_13_0.endScale = var_12(2, 2, 2)

	return
end

function var_0_0.UpdateFlipTableCard(arg_14_0)
	if not arg_14_0.isFliping then
		return
	end

	local var_14_0 = arg_14_0.flipDeltaTime

	Time = var_1_10002
	arg_14_0.flipDeltaTime = var_14_0 + var_1_10002.deltaTime
	math = var_1

	local var_14_1 = var_1.min
	local var_14_2 = arg_14_0.flipDeltaTime

	IslandCheaterTavernConst = var_1_10003

	local var_14_3 = var_14_1(var_14_2 / var_1_10003.FlipCardTime, 1)

	Mathf = var_2

	local var_14_4 = var_2.Lerp(0, 180, var_14_3)
	local var_14_5 = arg_14_0.tf
	local var_14_6 = arg_14_0.startFlipRotation

	Quaternion = var_5
	var_14_5.rotation = var_14_6 * var_5.AngleAxis(var_14_4, arg_14_0.localUp)

	if var_14_3 >= 1 then
		arg_14_0.isFliping = false
	end

	return
end

function var_0_0.FlipTableCard(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0

	if arg_15_0.id ~= arg_15_1 then
		var_15_0 = arg_15_0.tf.position

		local var_15_1 = arg_15_0.tf.rotation
		local var_15_2 = arg_15_0.tf.localScale
		local var_15_3 = arg_15_0.cardPoolMgr

		var_7.ReturnGameObjectById(var_15_3, arg_15_0.id, arg_15_0.tf.gameObject)

		arg_15_0.tf = nil

		local function var_15_4(arg_16_0)
			arg_15_0.tf = arg_16_0.transform

			local var_16_0 = arg_15_0
			local var_16_1 = arg_15_0.tf

			var_16_0.selectedCardTf = var_2.Find(var_16_1, "vfx_bar_kapai01")
			setActive = var_16_0

			var_16_0(arg_15_0.selectedCardTf, false)

			arg_15_0.tf.position = var_15_0
			arg_15_0.tf.rotation = var_15_1
			arg_15_0.tf.localScale = var_15_2

			return
		end

		local var_15_5 = arg_15_0.cardPoolMgr

		var_8.GetCardGameObjectById(var_15_5, arg_15_1, var_15_4, true)

		arg_15_0.id = arg_15_1
	end

	setParent = var_15_0

	var_15_0(arg_15_0.tf, nil)

	arg_15_0.isFliping = true
	arg_15_0.deltaTime = 0
	arg_15_0.flipDeltaTime = 0
	arg_15_0.startPos = arg_15_0.tf.position
	IslandCheaterTavernConst = var_4

	local var_15_6 = var_4.seatRotatonY[arg_15_0.mainPlayerSeat]

	Quaternion = var_5
	arg_15_0.startFlipRotation = var_5.Euler(90, var_15_6, 0)

	local var_15_7 = arg_15_0.startFlipRotation

	Vector3 = var_6
	arg_15_0.localUp = var_15_7 * var_6.forward
	IslandCheaterTavernConst = var_6

	local var_15_8 = var_6.cardWidth * 2
	local var_15_9 = 0
	local var_15_10 = -(arg_15_3 * var_15_8 + (arg_15_3 - 1) * var_15_9) / 2 + var_15_8 / 2 + (arg_15_2 - 1) * (var_15_8 + var_15_9)
	local var_15_11 = 0
	local var_15_12 = 0
	local var_15_13 = 0.001 * arg_15_2

	if arg_15_0.mainPlayerSeat % 2 == 0 then
		var_15_11 = var_15_10
	else
		var_15_12 = var_15_10
	end

	local var_15_14 = arg_15_0.tf

	Vector3 = var_1_10015
	var_15_14.position = var_1_10015(6.29 + var_15_11, 0.92 + var_15_13, 2.11 + var_15_12)

	return
end

function var_0_0.SetActive(arg_17_0, arg_17_1)
	setActive = var_1_10002

	var_1_10002(arg_17_0.tf, arg_17_1)

	return
end

function var_0_0.Destroy(arg_18_0)
	IsNil = var_1_10001

	if var_1_10001(arg_18_0.tf) then
		return
	end

	arg_18_0.selectedCardTf = nil
	arg_18_0.unSelectedCardTf = nil

	local var_18_0 = arg_18_0.cardPoolMgr

	var_1.ReturnGameObjectById(var_18_0, arg_18_0.id, arg_18_0.tf.gameObject)

	arg_18_0.tf = nil

	return
end

return var_0_0
