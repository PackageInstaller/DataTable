class = var_0_10000

local var_0_0 = var_0_10000("PileGameModel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1
	arg_1_0.items = {}
	arg_1_0.level = 0
	arg_1_0.score = 0
	arg_1_0.failedCnt = 0
	Vector2 = var_2
	arg_1_0.deathLine = var_2(0, 0)
	Vector2 = var_2
	arg_1_0.safeLine = var_2(0, 0)
	arg_1_0.highestScore = 0
	Vector2 = var_2
	arg_1_0.screen = var_2(0, 0)
	PileGameConst = var_2
	arg_1_0.maxFailedCnt = var_2.MAX_FAILED_CNT

	return
end

function var_0_0.NetData(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_1.highestScore then
		var_2_0 = 0
	end

	arg_2_0.highestScore = var_2_0
	Vector2 = var_2_0
	arg_2_0.screen = var_2_0(arg_2_1.screen.x, arg_2_1.screen.y)

	return
end

function var_0_0.UpdateHighestScore(arg_3_0)
	if arg_3_0.score > arg_3_0.highestScore then
		arg_3_0.highestScore = arg_3_0.score
	end

	return
end

function var_0_0.RandomPile(arg_4_0)
	math = var_1_10001

	local var_4_0 = var_1_10001.random
	local var_4_1 = 1

	PileGameConst = var_1_10003

	local var_4_2 = var_4_0(var_4_1, #var_1_10003.Prefabs)

	PileGameConst = var_4_1

	return var_4_1.Prefabs[var_4_2]
end

function var_0_0.AddHeadPile(arg_5_0)
	PileGameConst = var_1_10001

	local var_5_0 = var_1_10001.HEAD

	return arg_5_0:AddPile(var_5_0)
end

function var_0_0.AddPileByRandom(arg_6_0)
	local var_6_0 = arg_6_0:RandomPile()

	return arg_6_0:AddPile(var_6_0)
end

function var_0_0.AddPile(arg_7_0, arg_7_1)
	arg_7_0.level = arg_7_0.level + 1

	local var_7_0 = arg_7_0:GetSpeed()
	local var_7_1 = {
		onTheMove = false,
		gname = arg_7_1.name,
		name = arg_7_0.level
	}

	Vector3 = var_4

	local var_7_2 = 0

	PileGameConst = var_1_10006
	var_7_1.position = var_4(var_7_2, var_1_10006.START_Y, 0)
	Vector3 = var_4
	PileGameConst = var_7_2

	local var_7_3 = -var_7_2.MAX_SLIDE_DISTANCE

	PileGameConst = var_6
	var_7_1.leftMaxPosition = var_4(var_7_3, var_6.START_Y, 0)
	Vector3 = var_4
	PileGameConst = var_7_3

	local var_7_4 = var_7_3.MAX_SLIDE_DISTANCE

	PileGameConst = var_6
	var_7_1.rightMaxPosition = var_4(var_7_4, var_6.START_Y, 0)
	var_7_1.speed = var_7_0
	PileGameConst = var_4
	var_7_1.dropSpeed = var_4.DROP_SPEED
	Vector2 = var_4
	var_7_1.sizeDelta = var_4(arg_7_1.size[1], arg_7_1.size[2])
	PileGameConst = var_4
	var_7_1.pivot = var_4.ITEM_PIVOT

	local var_7_5 = {}

	Vector2 = var_5
	var_7_5.offset = var_5(arg_7_1.boundary[1], arg_7_1.boundary[2])
	Vector2 = var_5
	var_7_5.sizeDelta = var_5(arg_7_1.boundary[3], arg_7_1.boundary[4])
	var_7_1.collider = var_7_5

	local var_7_6

	if not arg_7_1.speActionCount then
		var_7_6 = 0
	end

	var_7_1.speActionCount = var_7_6
	table = var_7_6

	var_7_6.insert(arg_7_0.items, var_7_1)

	return var_7_1
end

function var_0_0.GetSpeed(arg_8_0)
	PileGameConst = var_1_10001

	local var_8_0 = var_1_10001.SLIDE_SPEED

	PileGameConst = var_1_10002

	local var_8_1 = var_1_10002.SLIDE_GROWTH[1]

	PileGameConst = var_1_10003

	local var_8_2 = var_1_10003.SLIDE_GROWTH[2]

	math = var_1_10004

	return var_8_0 * (1 + var_1_10004.floor(arg_8_0.level / var_8_1) * var_8_2)
end

function var_0_0.AddGround(arg_9_0)
	local var_9_0 = {}

	Vector3 = var_1_10002
	var_9_0.position = var_1_10002(0, -arg_9_0.screen.y / 2, 0)
	PileGameConst = var_2
	var_9_0.pivot = var_2.GROUND_PIVOT
	PileGameConst = var_2
	var_9_0.sizeDelta = var_2.GROUND_SIZE
	arg_9_0.ground = var_9_0

	return
end

function var_0_0.AddDeathLineRight(arg_10_0)
	local var_10_0 = arg_10_0.deathLine

	PileGameConst = var_1_10002
	var_10_0.x = -var_1_10002.DEATH_LINE_DISTANCE

	return
end

function var_0_0.AddDeathLineLeft(arg_11_0)
	local var_11_0 = arg_11_0.deathLine

	PileGameConst = var_1_10002
	var_11_0.y = var_1_10002.DEATH_LINE_DISTANCE

	return
end

function var_0_0.AddSafeLineRight(arg_12_0)
	local var_12_0 = arg_12_0.safeLine

	PileGameConst = var_1_10002
	var_12_0.x = -var_1_10002.SAFE_LINE_DISTANCE

	return
end

function var_0_0.AddSafeLineLeft(arg_13_0)
	local var_13_0 = arg_13_0.safeLine

	PileGameConst = var_1_10002
	var_13_0.y = var_1_10002.SAFE_LINE_DISTANCE

	return
end

function var_0_0.IsStopDrop(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:IsOnGround(arg_14_1)
	local var_14_1 = arg_14_0:OnPrevItem(arg_14_1)

	return var_14_0 or var_14_1
end

function var_0_0.IsOnGround(arg_15_0, arg_15_1)
	return arg_15_1.position.y <= arg_15_0.ground.position.y
end

function var_0_0.GetIndex(arg_16_0)
	return #arg_16_0.items
end

function var_0_0.OnPrevItem(arg_17_0, arg_17_1)
	if #arg_17_0.items - 1 > 0 then
		local var_17_0 = arg_17_0.items[var_3]

		return arg_17_0:IsOverlap(arg_17_1, var_17_0)
	end

	return
end

function var_0_0.IsOverTailItem(arg_18_0, arg_18_1)
	if arg_18_0.items[#arg_18_0.items - 1] then
		return arg_18_0:IsOverItem(arg_18_1, var_2)
	end

	return false
end

function var_0_0.IsOverItem(arg_19_0, arg_19_1, arg_19_2)
	Vector2 = var_1_10003

	local var_19_0 = var_1_10003(arg_19_1.position.x + (0.5 - arg_19_1.pivot.x) * arg_19_1.sizeDelta.x + arg_19_1.collider.offset.x, arg_19_1.position.y + (0.5 - arg_19_1.pivot.y) * arg_19_1.sizeDelta.y + arg_19_1.collider.offset.y)

	return arg_19_2.position.y + (0.5 - arg_19_2.pivot.y) * arg_19_2.sizeDelta.y + arg_19_2.collider.offset.y + arg_19_2.collider.sizeDelta.y / 2 >= var_19_0.y - arg_19_1.collider.sizeDelta.y / 2
end

function var_0_0.IsOverlap(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0:IsOverItem(arg_20_1, arg_20_2) then
		Vector2 = var_3

		local var_20_0 = var_3(arg_20_1.position.x + (0.5 - arg_20_1.pivot.x) * arg_20_1.sizeDelta.x + arg_20_1.collider.offset.x, arg_20_1.position.y + (0.5 - arg_20_1.pivot.y) * arg_20_1.sizeDelta.y + arg_20_1.collider.offset.y)
		local var_20_1 = arg_20_2.position.x + (0.5 - arg_20_2.pivot.x) * arg_20_2.sizeDelta.x + arg_20_2.collider.offset.x

		Vector2 = var_5

		local var_20_2 = var_5(var_20_1 - arg_20_2.collider.sizeDelta.x / 2, var_20_1 + arg_20_2.collider.sizeDelta.x / 2)

		return var_20_0.x >= var_20_2.x and var_20_0.x <= var_20_2.y
	end

	return
end

function var_0_0.CanDropOnPrev(arg_21_0, arg_21_1)
	local var_21_0 = #arg_21_0.items - 1

	if 0 < var_21_0 then
		Vector2 = var_4

		local var_21_1 = var_4(arg_21_1.position.x + (0.5 - arg_21_1.pivot.x) * arg_21_1.sizeDelta.x + arg_21_1.collider.offset.x, arg_21_1.position.y + (0.5 - arg_21_1.pivot.y) * arg_21_1.sizeDelta.y + arg_21_1.collider.offset.y)
		local var_21_2 = arg_21_0.items[var_21_0].position.x + (0.5 - var_5.pivot.x) * var_5.sizeDelta.x + var_5.collider.offset.x

		Vector2 = var_7

		local var_21_3 = var_7(var_21_2 - var_5.collider.sizeDelta.x / 2, var_21_2 + var_5.collider.sizeDelta.x / 2)

		return var_21_1.x >= var_21_3.x and var_21_1.x <= var_21_3.y
	end

	return
end

function var_0_0.AddFailedCnt(arg_22_0)
	arg_22_0.failedCnt = arg_22_0.failedCnt + 1

	return
end

function var_0_0.RemoveTailItem(arg_23_0)
	table = var_1_10001

	var_1_10001.remove(arg_23_0.items, #arg_23_0.items)

	return
end

function var_0_0.AddScore(arg_24_0)
	arg_24_0.score = arg_24_0.score + 1

	return
end

function var_0_0.IsMaxfailedCnt(arg_25_0)
	return arg_25_0.maxFailedCnt == arg_25_0.failedCnt
end

function var_0_0.IsOverDeathLine(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_1.position.x - arg_26_1.collider.sizeDelta.x / 2 <= arg_26_0.deathLine.x
	local var_26_1 = var_2 + arg_26_1.collider.sizeDelta.x / 2 >= arg_26_0.deathLine.y

	return var_26_0 or var_26_1
end

function var_0_0.ShouldSink(arg_27_0)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.GetIndex(var_27_0)

	PileGameConst = var_27_0

	return var_27_1 == var_27_0.SINK_LEVEL + 1
end

function var_0_0.GetPrevItem(arg_28_0, arg_28_1)
	arg_28_1 = arg_28_1 - 1

	return arg_28_0.items[arg_28_1]
end

function var_0_0.GetNextPos(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.items[arg_29_1]
	local var_29_1 = arg_29_0:GetPrevItem(arg_29_1)
	local var_29_2 = 0

	if var_29_1 then
		var_29_2 = var_29_1.position.y + var_29_1.sizeDelta.y
	else
		var_29_2 = var_29_0.position.y - var_29_0.sizeDelta.y
	end

	Vector3 = var_5

	return var_5(var_29_0.position.x, var_29_2, 0)
end

function var_0_0.IsExceedingTheHighestScore(arg_30_0)
	return arg_30_0.score - arg_30_0.highestScore == 1
end

function var_0_0.RemoveFirstItem(arg_31_0)
	table = var_1_10001

	return var_1_10001.remove(arg_31_0.items, 1)
end

function var_0_0.GetFirstItem(arg_32_0)
	return arg_32_0.items[1]
end

function var_0_0.GetTailItem(arg_33_0)
	return arg_33_0.items[#arg_33_0.items]
end

function var_0_0.GetDropArea(arg_34_0, arg_34_1)
	local var_34_0
	local var_34_1 = arg_34_1.position.x - arg_34_1.collider.sizeDelta.x / 2
	local var_34_2 = arg_34_1.position.x + arg_34_1.collider.sizeDelta.x / 2

	if var_34_1 <= arg_34_0.deathLine.x or arg_34_0.deathLine.y <= var_34_2 then
		PileGameController = var_5
		var_34_0 = var_5.DROP_AREA_DANGER
	elseif var_34_1 <= arg_34_0.safeLine.x or arg_34_0.safeLine.y <= var_34_2 then
		PileGameController = var_5
		var_34_0 = var_5.DROP_AREA_WARN
	else
		PileGameController = var_5
		var_34_0 = var_5.DROP_AREA_SAFE
	end

	return var_34_0
end

function var_0_0.GetInitPos(arg_35_0)
	local var_35_0 = {}

	PileGameConst = var_1_10002

	local var_35_1 = var_1_10002.SHAKE_DIS
	local var_35_2 = arg_35_0.score

	PileGameConst = var_1_10004

	local var_35_3 = var_35_1 + var_35_2 * var_1_10004.SHAKE_DIS_RATIO

	ipairs = var_3

	for iter_35_0, iter_35_1 in var_3(arg_35_0.items) do
		table = var_1_10008

		var_1_10008.insert(var_35_0, {
			iter_35_1,
			iter_35_1.position.x - var_35_3,
			iter_35_1.position.x + var_35_3
		})
	end

	return var_35_0
end

function var_0_0.Clear(arg_36_0)
	arg_36_0.level = 0
	arg_36_0.score = 0
	arg_36_0.failedCnt = 0
	arg_36_0.items = {}

	return
end

function var_0_0.Dispose(arg_37_0)
	arg_37_0:Clear()

	return
end

return var_0_0
