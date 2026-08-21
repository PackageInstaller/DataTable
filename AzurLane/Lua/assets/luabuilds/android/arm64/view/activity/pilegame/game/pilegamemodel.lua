local var_0_0 = class("PileGameModel")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.controller = arg_1_1
	arg_1_0.items = {}
	arg_1_0.level = 0
	arg_1_0.score = 0
	arg_1_0.failedCnt = 0
	arg_1_0.deathLine = Vector2(0, 0)
	arg_1_0.safeLine = Vector2(0, 0)
	arg_1_0.highestScore = 0
	arg_1_0.screen = Vector2(0, 0)
	arg_1_0.maxFailedCnt = PileGameConst.MAX_FAILED_CNT

	return
end

function var_0_0.NetData(arg_2_0, arg_2_1)
	arg_2_0.highestScore = arg_2_1.highestScore or 0
	arg_2_0.screen = Vector2(arg_2_1.screen.x, arg_2_1.screen.y)

	return
end

function var_0_0.UpdateHighestScore(arg_3_0)
	if arg_3_0.score > arg_3_0.highestScore then
		arg_3_0.highestScore = arg_3_0.score
	end

	return
end

function var_0_0.RandomPile(arg_4_0)
	return PileGameConst.Prefabs[math.random(1, #PileGameConst.Prefabs)]
end

function var_0_0.AddHeadPile(arg_5_0)
	return arg_5_0:AddPile(PileGameConst.HEAD)
end

function var_0_0.AddPileByRandom(arg_6_0)
	return arg_6_0:AddPile((arg_6_0:RandomPile()))
end

function var_0_0.AddPile(arg_7_0, arg_7_1)
	arg_7_0.level = arg_7_0.level + 1

	local var_7_0 = {
		onTheMove = false,
		gname = arg_7_1.name,
		name = arg_7_0.level,
		position = Vector3(0, PileGameConst.START_Y, 0),
		leftMaxPosition = Vector3(-PileGameConst.MAX_SLIDE_DISTANCE, PileGameConst.START_Y, 0),
		rightMaxPosition = Vector3(PileGameConst.MAX_SLIDE_DISTANCE, PileGameConst.START_Y, 0),
		speed = arg_7_0:GetSpeed(),
		dropSpeed = PileGameConst.DROP_SPEED,
		sizeDelta = Vector2(arg_7_1.size[1], arg_7_1.size[2]),
		pivot = PileGameConst.ITEM_PIVOT,
		collider = {
			offset = Vector2(arg_7_1.boundary[1], arg_7_1.boundary[2]),
			sizeDelta = Vector2(arg_7_1.boundary[3], arg_7_1.boundary[4])
		}
	}

	var_7_0.speActionCount = arg_7_1.speActionCount or 0

	table.insert(arg_7_0.items, var_7_0)

	return var_7_0
end

function var_0_0.GetSpeed(arg_8_0)
	return PileGameConst.SLIDE_SPEED * (1 + math.floor(arg_8_0.level / PileGameConst.SLIDE_GROWTH[1]) * PileGameConst.SLIDE_GROWTH[2])
end

function var_0_0.AddGround(arg_9_0)
	arg_9_0.ground = {
		position = Vector3(0, -arg_9_0.screen.y / 2, 0),
		pivot = PileGameConst.GROUND_PIVOT,
		sizeDelta = PileGameConst.GROUND_SIZE
	}

	return
end

function var_0_0.AddDeathLineRight(arg_10_0)
	arg_10_0.deathLine.x = -PileGameConst.DEATH_LINE_DISTANCE

	return
end

function var_0_0.AddDeathLineLeft(arg_11_0)
	arg_11_0.deathLine.y = PileGameConst.DEATH_LINE_DISTANCE

	return
end

function var_0_0.AddSafeLineRight(arg_12_0)
	arg_12_0.safeLine.x = -PileGameConst.SAFE_LINE_DISTANCE

	return
end

function var_0_0.AddSafeLineLeft(arg_13_0)
	arg_13_0.safeLine.y = PileGameConst.SAFE_LINE_DISTANCE

	return
end

function var_0_0.IsStopDrop(arg_14_0, arg_14_1)
	return arg_14_0:IsOnGround(arg_14_1) or arg_14_0:OnPrevItem(arg_14_1)
end

function var_0_0.IsOnGround(arg_15_0, arg_15_1)
	return arg_15_1.position.y <= arg_15_0.ground.position.y
end

function var_0_0.GetIndex(arg_16_0)
	return #arg_16_0.items
end

function var_0_0.OnPrevItem(arg_17_0, arg_17_1)
	if #arg_17_0.items - 1 > 0 then
		return arg_17_0:IsOverlap(arg_17_1, arg_17_0.items[#arg_17_0.items - 1])
	end

	return
end

function var_0_0.IsOverTailItem(arg_18_0, arg_18_1)
	if arg_18_0.items[#arg_18_0.items - 1] then
		return arg_18_0:IsOverItem(arg_18_1, arg_18_0.items[#arg_18_0.items - 1])
	end

	return false
end

function var_0_0.IsOverItem(arg_19_0, arg_19_1, arg_19_2)
	return arg_19_2.position.y + (0.5 - arg_19_2.pivot.y) * arg_19_2.sizeDelta.y + arg_19_2.collider.offset.y + arg_19_2.collider.sizeDelta.y / 2 >= Vector2(arg_19_1.position.x + (0.5 - arg_19_1.pivot.x) * arg_19_1.sizeDelta.x + arg_19_1.collider.offset.x, arg_19_1.position.y + (0.5 - arg_19_1.pivot.y) * arg_19_1.sizeDelta.y + arg_19_1.collider.offset.y).y - arg_19_1.collider.sizeDelta.y / 2
end

function var_0_0.IsOverlap(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0:IsOverItem(arg_20_1, arg_20_2) then
		local var_20_0 = Vector2(arg_20_1.position.x + (0.5 - arg_20_1.pivot.x) * arg_20_1.sizeDelta.x + arg_20_1.collider.offset.x, arg_20_1.position.y + (0.5 - arg_20_1.pivot.y) * arg_20_1.sizeDelta.y + arg_20_1.collider.offset.y)
		local var_20_1 = Vector2(arg_20_2.position.x + (0.5 - arg_20_2.pivot.x) * arg_20_2.sizeDelta.x + arg_20_2.collider.offset.x - arg_20_2.collider.sizeDelta.x / 2, arg_20_2.position.x + (0.5 - arg_20_2.pivot.x) * arg_20_2.sizeDelta.x + arg_20_2.collider.offset.x + arg_20_2.collider.sizeDelta.x / 2)

		return var_20_0.x >= var_20_1.x and var_20_0.x <= var_20_1.y
	end

	return
end

function var_0_0.CanDropOnPrev(arg_21_0, arg_21_1)
	if #arg_21_0.items - 1 > 0 then
		local var_21_0 = Vector2(arg_21_1.position.x + (0.5 - arg_21_1.pivot.x) * arg_21_1.sizeDelta.x + arg_21_1.collider.offset.x, arg_21_1.position.y + (0.5 - arg_21_1.pivot.y) * arg_21_1.sizeDelta.y + arg_21_1.collider.offset.y)
		local var_21_1 = Vector2(arg_21_0.items[#arg_21_0.items - 1].position.x + (0.5 - arg_21_0.items[#arg_21_0.items - 1].pivot.x) * arg_21_0.items[#arg_21_0.items - 1].sizeDelta.x + arg_21_0.items[#arg_21_0.items - 1].collider.offset.x - arg_21_0.items[#arg_21_0.items - 1].collider.sizeDelta.x / 2, arg_21_0.items[#arg_21_0.items - 1].position.x + (0.5 - arg_21_0.items[#arg_21_0.items - 1].pivot.x) * arg_21_0.items[#arg_21_0.items - 1].sizeDelta.x + arg_21_0.items[#arg_21_0.items - 1].collider.offset.x + arg_21_0.items[#arg_21_0.items - 1].collider.sizeDelta.x / 2)

		return var_21_0.x >= var_21_1.x and var_21_0.x <= var_21_1.y
	end

	return
end

function var_0_0.AddFailedCnt(arg_22_0)
	arg_22_0.failedCnt = arg_22_0.failedCnt + 1

	return
end

function var_0_0.RemoveTailItem(arg_23_0)
	table.remove(arg_23_0.items, #arg_23_0.items)

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
	local var_26_0 = arg_26_1.position.x + arg_26_1.collider.sizeDelta.x / 2 >= arg_26_0.deathLine.y

	return arg_26_1.position.x - arg_26_1.collider.sizeDelta.x / 2 <= arg_26_0.deathLine.x or var_26_0
end

function var_0_0.ShouldSink(arg_27_0)
	return arg_27_0:GetIndex() == PileGameConst.SINK_LEVEL + 1
end

function var_0_0.GetPrevItem(arg_28_0, arg_28_1)
	arg_28_1 = arg_28_1 - 1

	return arg_28_0.items[arg_28_1]
end

function var_0_0.GetNextPos(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.items[arg_29_1]
	local var_29_1 = arg_29_0:GetPrevItem(arg_29_1)
	local var_29_2 = 0

	var_29_2 = var_29_1 and var_29_1.position.y + var_29_1.sizeDelta.y or var_29_0.position.y - var_29_0.sizeDelta.y

	return Vector3(var_29_0.position.x, var_29_2, 0)
end

function var_0_0.IsExceedingTheHighestScore(arg_30_0)
	return arg_30_0.score - arg_30_0.highestScore == 1
end

function var_0_0.RemoveFirstItem(arg_31_0)
	return table.remove(arg_31_0.items, 1)
end

function var_0_0.GetFirstItem(arg_32_0)
	return arg_32_0.items[1]
end

function var_0_0.GetTailItem(arg_33_0)
	return arg_33_0.items[#arg_33_0.items]
end

function var_0_0.GetDropArea(arg_34_0, arg_34_1)
	return (arg_34_1.position.x - arg_34_1.collider.sizeDelta.x / 2 <= arg_34_0.deathLine.x or arg_34_1.position.x + arg_34_1.collider.sizeDelta.x / 2 >= arg_34_0.deathLine.y) and PileGameController.DROP_AREA_DANGER or (arg_34_1.position.x - arg_34_1.collider.sizeDelta.x / 2 <= arg_34_0.safeLine.x or arg_34_1.position.x + arg_34_1.collider.sizeDelta.x / 2 >= arg_34_0.safeLine.y) and PileGameController.DROP_AREA_WARN or PileGameController.DROP_AREA_SAFE
end

function var_0_0.GetInitPos(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.items) do
		table.insert({}, {
			iter_35_1,
			iter_35_1.position.x - (PileGameConst.SHAKE_DIS + arg_35_0.score * PileGameConst.SHAKE_DIS_RATIO),
			iter_35_1.position.x + (PileGameConst.SHAKE_DIS + arg_35_0.score * PileGameConst.SHAKE_DIS_RATIO)
		})
	end

	return {}
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
