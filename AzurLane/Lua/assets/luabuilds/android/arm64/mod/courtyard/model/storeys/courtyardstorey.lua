class = var_0_10000

local var_0_0 = "CourtYardStorey"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..map.CourtYardPlaceableArea"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_4)

	arg_1_0.id = arg_1_2
	arg_1_0.style = arg_1_3
	arg_1_0.level = 1
	arg_1_0.furnitures = {}
	arg_1_0.ships = {}
	arg_1_0.canEidt = false
	CourtYardStoreyRecorder = var_5
	arg_1_0.recoder = var_5.New(arg_1_0)
	CourtYardStoreyComposeChecker = var_5
	arg_1_0.composeChecker = var_5.New(arg_1_0)

	return
end

function var_0_1.GetStyle(arg_2_0)
	return arg_2_0.style
end

function var_0_1.SetLevel(arg_3_0, arg_3_1)
	arg_3_0.level = arg_3_1
	CourtYardConst = var_1_10002

	local var_3_0 = var_1_10002.MAX_STOREY_LEVEL

	CourtYardConst = var_1_10003

	local var_3_1 = var_3_0 * var_1_10003.OPEN_AREA_PRE_LEVEL
	local var_3_2 = arg_3_0.level - 1

	CourtYardConst = var_1_10004

	local var_3_3 = var_3_1 - var_3_2 * var_1_10004.OPEN_AREA_PRE_LEVEL
	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.UpdateMinRange

	Vector2 = var_1_10007

	var_3_5(var_3_4, var_1_10007(var_3_3, var_3_3))

	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.DispatchEvent

	CourtYardEvent = var_7

	var_3_7(var_3_6, var_7.UPDATE_STOREY, arg_3_1)

	return
end

function var_0_1.LevelUp(arg_4_0)
	local var_4_0 = arg_4_0.level + 1

	arg_4_0:SetLevel(var_4_0)

	local var_4_1 = arg_4_0
	local var_4_2 = arg_4_0.DispatchEvent

	CourtYardEvent = var_5

	var_4_2(var_4_1, var_5.UPDATE_FLOORPAPER, arg_4_0.floorPaper)

	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.DispatchEvent

	CourtYardEvent = var_5

	var_4_4(var_4_3, var_5.UPDATE_WALLPAPER, arg_4_0.wallPaper)

	return
end

function var_0_1.SetWallPaper(arg_5_0, arg_5_1)
	arg_5_0.wallPaper = arg_5_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_5_1(var_5_0, var_1_10005.UPDATE_WALLPAPER, arg_5_1)

	local var_5_2 = arg_5_0.composeChecker

	var_2.Check(var_5_2)

	return
end

function var_0_1.SetFloorPaper(arg_6_0, arg_6_1)
	arg_6_0.floorPaper = arg_6_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.DispatchEvent

	CourtYardEvent = var_1_10005

	var_6_1(var_6_0, var_1_10005.UPDATE_FLOORPAPER, arg_6_1)

	local var_6_2 = arg_6_0.composeChecker

	var_2.Check(var_6_2)

	return
end

function var_0_1.GetWallPaper(arg_7_0)
	return arg_7_0.wallPaper
end

function var_0_1.GetFloorPaper(arg_8_0)
	return arg_8_0.floorPaper
end

function var_0_1.GetFurnitures(arg_9_0)
	return arg_9_0.furnitures
end

function var_0_1.GetAllFurniture(arg_10_0)
	local var_10_0 = {}

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.furnitures) do
		var_10_0[iter_10_1.id] = iter_10_1
	end

	if arg_10_0.floorPaper then
		var_10_0[arg_10_0.floorPaper.id] = arg_10_0.floorPaper
	end

	if arg_10_0.wallPaper then
		var_10_0[arg_10_0.wallPaper.id] = arg_10_0.wallPaper
	end

	return var_10_0
end

function var_0_1.GetShips(arg_11_0)
	return arg_11_0.ships
end

function var_0_1.GetShip(arg_12_0, arg_12_1)
	return arg_12_0.ships[arg_12_1]
end

function var_0_1.GetFurniture(arg_13_0, arg_13_1)
	return arg_13_0.furnitures[arg_13_1]
end

function var_0_1.CanAddFurniture(arg_14_0, arg_14_1)
	return true
end

function var_0_1.AddFurniture(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.furnitures[arg_15_1.id] = arg_15_1

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.DispatchEvent

	CourtYardEvent = var_1_10006

	var_15_1(var_15_0, var_1_10006.CREATE_ITEM, arg_15_1, arg_15_2)
	arg_15_0:AddItem(arg_15_1)

	local var_15_2 = arg_15_0.composeChecker

	var_3.Check(var_15_2)

	if arg_15_1:CanTouch() and arg_15_1:TriggerTouchDefault() then
		arg_15_0:ClickFurniture(arg_15_1.id)
	end

	if not arg_15_2 then
		arg_15_0:RefreshCombineFruniture(arg_15_1.configId)
	end

	return
end

function var_0_1.RefreshCombineFruniture(arg_16_0, arg_16_1)
	pg = var_1_10002

	local var_16_0 = var_1_10002.furniture_data_template[arg_16_1]
	local var_16_1 = {
		arg_16_1
	}

	type = var_1_10004

	if var_1_10004(var_16_0.spine_combine_action_replace) == "table" then
		pairs = var_4

		for iter_16_0, iter_16_1 in var_4(var_16_0.spine_combine_action_replace) do
			ipairs = var_1_10009

			for iter_16_2, iter_16_3 in var_1_10009(iter_16_1[1]) do
				table = var_1_10014

				var_1_10014.insert(var_16_1, iter_16_3)
			end
		end
	end

	pairs = var_4

	for iter_16_4, iter_16_5 in var_4(arg_16_0.furnitures) do
		table = var_1_10009

		if var_1_10009.contains(var_16_1, iter_16_5.configId) then
			iter_16_5:RefreshState()
		end
	end

	return
end

function var_0_1.AddPaper(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:GetType()

	Furniture = var_1_10003

	if var_17_0 == var_1_10003.TYPE_WALLPAPER then
		arg_17_0:SetWallPaper(arg_17_1)
	else
		Furniture = var_3

		if var_17_0 == var_3.TYPE_FLOORPAPER then
			arg_17_0:SetFloorPaper(arg_17_1)
		end
	end

	return
end

function var_0_1.AddChildFurniture(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.furnitures[arg_18_1.id] = arg_18_1

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.DispatchEvent

	CourtYardEvent = var_1_10006

	var_18_1(var_18_0, var_1_10006.CREATE_ITEM, arg_18_1)

	local var_18_2 = arg_18_0.furnitures[arg_18_2]
	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.DispatchEvent

	CourtYardEvent = var_7

	var_18_4(var_18_3, var_7.CHILD_ITEM, arg_18_1, var_18_2)
	var_18_2:AddChild(arg_18_1)

	return
end

function var_0_1.Update(arg_19_0)
	arg_19_0:CheckShipState()
	arg_19_0:CheckFurnitureState()

	return
end

function var_0_1.AddShip(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1
	local var_20_1 = arg_20_1.ChangeState

	CourtYardShip = var_1_10005

	var_20_1(var_20_0, var_1_10005.STATE_IDLE)

	arg_20_0.ships[arg_20_1.id] = arg_20_1

	local var_20_2 = arg_20_0
	local var_20_3 = arg_20_0.DispatchEvent

	CourtYardEvent = var_5

	var_20_3(var_20_2, var_5.CREATE_ITEM, arg_20_1)
	arg_20_0:AddItem(arg_20_1)

	return
end

function var_0_1.GetPlaceableArea(arg_21_0, arg_21_1)
	if arg_21_1:HasParent() then
		local var_21_0 = arg_21_1:GetParent()
		local var_21_1

		if not var_2.GetPlaceableArea(var_21_0) then
			var_21_1 = arg_21_0
		end

		return var_21_1
	end
end

function var_0_1.RemoveShip(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:GetPlaceableArea(arg_22_1)

	var_2.RemoveItem(var_22_0, arg_22_1)

	local var_22_1 = arg_22_0.ships[arg_22_1.id]

	var_3.Dispose(var_22_1)

	arg_22_0.ships[arg_22_1.id] = nil

	local var_22_2 = arg_22_0
	local var_22_3 = arg_22_0.DispatchEvent

	CourtYardEvent = var_6

	var_22_3(var_22_2, var_6.DETORY_ITEM, arg_22_1)

	local var_22_4 = arg_22_0.ships
	local var_22_5 = arg_22_1.id

	CourtYardConst = var_22_2

	if var_22_4[var_22_5 + var_22_2.DOUBLE_SKIN_ADD] then
		local var_22_6 = arg_22_0
		local var_22_7 = arg_22_0.RemoveShip
		local var_22_8 = arg_22_0.ships
		local var_22_9 = arg_22_1.id

		CourtYardConst = var_1_10008

		var_22_7(var_22_6, var_22_8[var_22_9 + var_1_10008.DOUBLE_SKIN_ADD])
	end

	return
end

function var_0_1.ExitShip(arg_23_0, arg_23_1)
	if arg_23_0.ships[arg_23_1] then
		arg_23_0:RemoveShip(var_2)
	end

	return
end

function var_0_1.CheckShipState(arg_24_0)
	pairs = var_1_10001

	for iter_24_0, iter_24_1 in var_1_10001(arg_24_0:GetShips()) do
		local var_24_0 = iter_24_1:GetState()

		CourtYardShip = var_1_10007

		if var_24_0 == var_1_10007.STATE_MOVE then
			arg_24_0:ReadyMoveShip(iter_24_1.id)
		else
			CourtYardShip = var_1_10007

			if var_24_0 == var_1_10007.STATE_MOVING_HALF then
				arg_24_0:MoveShipToNextPosition(iter_24_1.id)
			end
		end
	end

	return
end

function var_0_1.ReadyMoveShip(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.ships[arg_25_1]
	local var_25_1 = false
	local var_25_2 = false
	local var_25_3 = false

	CourtYardCalcUtil = var_1_10006

	if var_1_10006.HalfProbability() then
		if var_25_0:HasParent() then
			local var_25_4 = var_25_0:GetParent()
			local var_25_5 = var_6.IsType

			Furniture = var_1_10009

			if var_25_5(var_25_4, var_1_10009.TYPE_ARCH) then
				var_25_1 = arg_25_0:ShipExitArch(var_25_0)

				goto label_25_0
			end
		end

		if not arg_25_0:ShipEnterArch(var_25_0) then
			var_25_3 = arg_25_0:ShipAddFollower(var_25_0)
		end
	end

	::label_25_0::

	if not var_25_1 and not var_25_2 and not var_25_3 then
		arg_25_0:RandomNextShipPosition(arg_25_1)
	end

	return
end

function var_0_1.ShipAddFollower(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0
	local var_26_1 = arg_26_0.GetFurnituresByType

	Furniture = var_1_10005

	local var_26_2 = var_26_1(var_26_0, var_1_10005.TYPE_FOLLOWER)

	local function var_26_3(arg_27_0)
		_ = var_2_10001

		return var_2_10001.detect(var_26_2, function(arg_28_0)
			local var_28_0 = arg_28_0:GetArea()

			_ = var_3_10002

			return var_3_10002.any(var_28_0, function(arg_29_0)
				return arg_29_0 == arg_27_0
			end)
		end)
	end

	local function var_26_4()
		local var_30_0 = arg_26_1

		if var_0.GetInterActionData(var_30_0) ~= nil then
			var_0:Stop()
		end

		return
	end

	ipairs = var_5

	for iter_26_0, iter_26_1 in var_5(arg_26_1:GetAroundPositions()) do
		if var_26_3(iter_26_1) and var_10:CanFollower(arg_26_1) then
			var_26_4()
			arg_26_0:RemoveItemAndRefresh(var_10)

			local var_26_5 = var_10:GetInteractionSlot()

			var_11.Occupy(var_26_5, var_10, arg_26_1, arg_26_0)

			return true
		end
	end

	return false
end

function var_0_1.ShipExitArch(arg_31_0, arg_31_1)
	if arg_31_0:GetNextPositionForMove(arg_31_1) then
		local var_31_0 = arg_31_1:GetParent()

		var_3.RemoveChild(var_31_0, arg_31_1)

		local var_31_1 = arg_31_0
		local var_31_2 = arg_31_0.DispatchEvent

		CourtYardEvent = var_7

		var_31_2(var_31_1, var_7.UN_CHILD_ITEM, arg_31_1, var_3)

		local var_31_3 = arg_31_0
		local var_31_4 = arg_31_0.DispatchEvent

		CourtYardEvent = var_7

		var_31_4(var_31_3, var_7.EXIT_ARCH, arg_31_1, var_3)
		arg_31_0:LockPosition(var_2)
		arg_31_1:UnClear(true)
		arg_31_1:Move(var_2)

		return true
	end

	return false
end

function var_0_1.ShipEnterArch(arg_32_0, arg_32_1)
	local function var_32_0(arg_33_0, arg_33_1)
		local var_33_0 = arg_32_0

		var_2.RemoveItem(var_33_0, arg_32_1)

		local var_33_1 = arg_32_0
		local var_33_2 = var_2.DispatchEvent

		CourtYardEvent = var_5

		var_33_2(var_33_1, var_5.CHILD_ITEM, arg_32_1, arg_33_0)

		local var_33_3 = arg_32_0
		local var_33_4 = var_2.DispatchEvent

		CourtYardEvent = var_5

		var_33_4(var_33_3, var_5.ENTER_ARCH, arg_32_1, arg_33_0)
		arg_33_0:AddChild(arg_32_1)

		local var_33_5 = arg_32_1

		var_2.Move(var_33_5, arg_33_1)

		return
	end

	ipairs = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10003(arg_32_1:GetAroundPositions()) do
		if arg_32_0:GetParentForItem(arg_32_1, iter_32_1) then
			local var_32_1 = var_8
			local var_32_2 = var_8.IsType

			Furniture = var_12

			if var_32_2(var_32_1, var_12.TYPE_ARCH) then
				var_32_0(var_8, iter_32_1)

				return true
			end
		end
	end

	return false
end

function var_0_1.RandomNextShipPosition(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.ships[arg_34_1]
	local var_34_1 = arg_34_0:GetPlaceableArea(var_34_0)

	if not var_3.GetNextPositionForMove(var_34_1, var_34_0) then
		local var_34_2 = var_34_0
		local var_34_3 = var_34_0.ChangeState

		CourtYardShip = var_1_10008

		var_34_3(var_34_2, var_1_10008.STATE_IDLE)

		return
	end

	var_3:LockPosition(var_4)
	var_34_0:Move(var_4)

	return
end

function var_0_1.MoveShipToNextPosition(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.ships[arg_35_1]
	local var_35_1 = arg_35_0:GetPlaceableArea(var_35_0)
	local var_35_2 = var_35_0:GetMarkPosition()

	var_35_1:_ClearLockPosition(var_35_0)

	if var_35_0:IsUnClear() then
		var_35_0:UnClear(false)
	else
		var_35_1:RemoveItem(var_35_0)
	end

	var_35_0:SetPosition(var_35_2)
	var_35_1:AddItem(var_35_0)

	local var_35_3 = var_35_0
	local var_35_4 = var_35_0.ChangeState

	CourtYardShip = var_8

	var_35_4(var_35_3, var_8.STATE_MOVING_ONE)

	return
end

function var_0_1.DragShip(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.ships[arg_36_1]
	local var_36_1 = arg_36_0:GetPlaceableArea(var_36_0)

	var_3._ClearLockPosition(var_36_1, var_36_0)

	local var_36_2 = var_36_0
	local var_36_3 = var_36_0.GetPosition(var_36_2)
	local var_36_4 = var_36_0

	if var_36_0.GetInterActionData(var_36_4) == nil then
		var_36_2 = var_36_0:GetState()
		CourtYardShip = var_36_4

		if var_36_2 == var_36_4.STATE_INTERACT then
			isa = var_36_2

			local var_36_5 = var_5

			CourtYardFollowerSlot = var_1_10009

			if var_36_2(var_36_5, var_1_10009) then
				arg_36_0:RemoveItem(var_36_0)
			end

			var_5:Stop()
		elseif var_36_0:HasParent() then
			var_1_10009 = var_36_0:GetParent()

			var_6.RemoveChild(var_1_10009, var_36_0)

			var_1_10009 = var_36_0

			local var_36_6 = var_36_0.ChangeState

			CourtYardShip = var_10

			var_36_6(var_1_10009, var_10.STATE_IDLE)

			var_1_10009 = arg_36_0

			local var_36_7 = arg_36_0.DispatchEvent

			CourtYardEvent = var_10

			var_36_7(var_1_10009, var_10.UN_CHILD_ITEM, var_36_0, var_6)
		else
			arg_36_0:RemoveItem(var_36_0)
		end

		local var_36_8 = var_36_0
		local var_36_9 = var_36_0.ChangeState

		CourtYardShip = var_1_10009

		var_36_9(var_36_8, var_1_10009.STATE_DRAG)

		local var_36_10 = arg_36_0:AreaWithInfo(var_36_0, var_36_3, var_36_0:GetOffset())

		var_36_0:UpdateOpFlag(true)

		local var_36_11 = arg_36_0
		local var_36_12 = arg_36_0.DispatchEvent

		CourtYardEvent = var_10

		var_36_12(var_36_11, var_10.SELETED_ITEM, var_36_0, var_36_10)

		local var_36_13 = arg_36_0
		local var_36_14 = arg_36_0.DispatchEvent

		CourtYardEvent = var_10

		var_36_14(var_36_13, var_10.DRAG_ITEM, var_36_0)

		return
	end
end

function var_0_1.DragingShip(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.ships[arg_37_1]

	if not var_3.GetOpFlag(var_37_0) then
		return
	end

	local var_37_1 = arg_37_0:GetParentForItem(var_3, arg_37_2)
	local var_37_2 = arg_37_0:GetInterActionFurniture(var_3, arg_37_2)
	local var_37_3

	if not var_37_1 or not var_37_1:RawGetOffset() then
		var_37_3 = var_3:GetOffset()
	end

	local var_37_4 = arg_37_0:AreaWithInfo(var_3, arg_37_2, var_37_3, var_37_2 or var_37_1)
	local var_37_5 = arg_37_0
	local var_37_6 = arg_37_0.DispatchEvent

	CourtYardEvent = var_11

	var_37_6(var_37_5, var_11.DRAGING_ITEM, var_3, var_37_4, arg_37_2, var_37_3)

	return
end

function var_0_1.DragShipEnd(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0.ships[arg_38_1]

	if not var_3.GetOpFlag(var_38_0) then
		return
	end

	local var_38_1 = arg_38_0:LegalPosition(arg_38_2, var_3)
	local var_38_2 = arg_38_0:GetInterActionFurniture(var_3, arg_38_2)
	local var_38_3 = arg_38_0
	local var_38_4 = arg_38_0.GetParentForItem(var_38_3, var_3, arg_38_2)
	local var_38_5

	if not var_38_1 and var_38_2 then
		isa = var_38_3

		local var_38_6 = var_38_2

		CourtYardFollowerFurniture = var_1_10011

		if var_38_3(var_38_6, var_1_10011) then
			arg_38_0:RemoveItemAndRefresh(var_38_2)
			arg_38_0:ResetShip(var_3, arg_38_2)

			local var_38_7 = var_3
			local var_38_8 = var_3.ChangeState

			CourtYardShip = var_11

			var_38_8(var_38_7, var_11.STATE_MOVE)
		end

		local var_38_9 = var_38_2:GetInteractionSlot()

		var_8.Occupy(var_38_9, var_38_2, var_3, arg_38_0)
	elseif not var_38_1 and var_38_4 then
		var_3:SetPosition(arg_38_2)

		local var_38_10 = arg_38_0
		local var_38_11 = arg_38_0.DispatchEvent

		CourtYardEvent = var_11

		var_38_11(var_38_10, var_11.CHILD_ITEM, var_3, var_38_4)
		var_38_4:AddChild(var_3)

		local var_38_12 = var_3
		local var_38_13 = var_3.ChangeState

		CourtYardShip = var_11

		var_38_13(var_38_12, var_11.STATE_IDLE)

		var_38_5 = var_38_4:AreaWithInfo(var_3, arg_38_2, var_38_4:RawGetOffset(), true)
	else
		local var_38_14 = var_38_1 and arg_38_2 or var_3:GetPosition()

		arg_38_0:ResetShip(var_3, var_38_14)

		var_38_5 = arg_38_0:AreaWithInfo(var_3, var_38_14, var_3:GetOffset(), true)
	end

	var_3:UpdateOpFlag(false)

	local var_38_15 = arg_38_0
	local var_38_16 = arg_38_0.DispatchEvent

	CourtYardEvent = var_11

	var_38_16(var_38_15, var_11.DRAG_ITEM_END, var_38_5)

	local var_38_17 = arg_38_0
	local var_38_18 = arg_38_0.DispatchEvent

	CourtYardEvent = var_11

	var_38_18(var_38_17, var_11.UNSELETED_ITEM, var_3)

	return
end

function var_0_1.GetInterActionFurniture(arg_39_0, arg_39_1, arg_39_2)
	pairs = var_1_10003

	for iter_39_0, iter_39_1 in var_1_10003(arg_39_0.furnitures) do
		if iter_39_1:CanInterAction(arg_39_1) and iter_39_1:IsOverlap(arg_39_2) then
			return iter_39_1
		end
	end

	return nil
end

function var_0_1.TouchShip(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0.ships[arg_40_1]
	local var_40_1 = arg_40_0:GetPlaceableArea(var_40_0)

	var_3._ClearLockPosition(var_40_1, var_40_0)

	local var_40_2 = var_40_0
	local var_40_3 = var_40_0.ChangeState

	CourtYardShip = var_7

	var_40_3(var_40_2, var_7.STATE_TOUCH)

	return
end

function var_0_1.UpdateShipIntimacy(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0.ships[arg_41_1] then
		return
	end

	var_3:ChangeInimacy(arg_41_2)

	return
end

function var_0_1.UpdateShipCoin(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_0.ships[arg_42_1] then
		return
	end

	var_3:ChangeCoin(arg_42_2)

	return
end

function var_0_1.ClearShipIntimacy(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0.ships[arg_43_1] then
		return
	end

	local var_43_0 = arg_43_0:GetPlaceableArea(var_3)

	var_4._ClearLockPosition(var_43_0, var_3)
	var_3:ClearInimacy(arg_43_2)

	return
end

function var_0_1.ClearShipCoin(arg_44_0, arg_44_1)
	if not arg_44_0.ships[arg_44_1] then
		return
	end

	local var_44_0 = arg_44_0:GetPlaceableArea(var_2)

	var_3._ClearLockPosition(var_44_0, var_2)

	local var_44_1 = var_2
	local var_44_2 = var_2.ClearCoin

	value = var_7

	var_44_2(var_44_1, var_7)

	return
end

function var_0_1.AddShipExp(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_0.ships[arg_45_1] then
		return
	end

	var_3:AddExp(arg_45_2)

	return
end

function var_0_1.ShipAnimtionFinish(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = arg_46_0.ships[arg_46_1]

	CourtYardShip = var_1_10004

	if arg_46_2 ~= var_1_10004.STATE_TOUCH then
		CourtYardShip = var_46_2

		local var_46_2

		if arg_46_2 == var_46_2.STATE_GETAWARD then
			local var_46_1 = var_46_0

			var_46_2 = var_46_0.ChangeState
			CourtYardShip = var_1_10007

			var_46_2(var_46_1, var_1_10007.STATE_IDLE)
		else
			CourtYardShip = var_46_2

			if arg_46_2 == var_46_2.STATE_INTERACT and var_46_0:GetInterActionData() then
				var_4:Continue(var_46_0)
			end
		end

		return
	end
end

function var_0_1.ResetShip(arg_47_0, arg_47_1, arg_47_2)
	local function var_47_0(arg_48_0, arg_48_1)
		arg_48_0:SetPosition(arg_48_1)

		local var_48_0 = arg_48_0
		local var_48_1 = arg_48_0.ChangeState

		CourtYardShip = var_5

		var_48_1(var_48_0, var_5.STATE_IDLE)

		local var_48_2 = arg_47_0

		var_2.AddItem(var_48_2, arg_48_0)

		return
	end

	if arg_47_0:LegalPosition(arg_47_2, arg_47_1) then
		var_47_0(arg_47_1, arg_47_2)
	elseif arg_47_0:GetRandomPosition(arg_47_1) then
		var_47_0(arg_47_1, var_4)
	else
		arg_47_0:RemoveShip(arg_47_1)

		local var_47_1 = arg_47_0:GetHost()
		local var_47_2 = var_5.SendNotification

		CourtYardEvent = var_8

		var_47_2(var_47_1, var_8._NO_POS_TO_ADD_SHIP, arg_47_1.id)
	end

	return
end

function var_0_1.SelectFurniture(arg_49_0, arg_49_1)
	if not arg_49_0.canEidt then
		return
	end

	local var_49_0 = arg_49_0.furnitures[arg_49_1]

	if var_2.GetOpFlag(var_49_0) then
		return
	end

	_ = var_3

	local var_49_1 = var_3.detect

	_ = var_49_0

	if var_49_1(var_49_0.values(arg_49_0.furnitures), function(arg_50_0)
		return arg_50_0:GetOpFlag()
	end) then
		arg_49_0:UnSelectFurniture(var_3.id)
	end

	local var_49_2 = var_2:GetPosition()
	local var_49_3 = arg_49_0:AreaWithInfo(var_2, var_49_2, var_2:GetOffset(), true)

	var_2:UpdateOpFlag(true)

	local var_49_4 = arg_49_0
	local var_49_5 = arg_49_0.DispatchEvent

	CourtYardEvent = var_9

	var_49_5(var_49_4, var_9.SELETED_ITEM, var_2, var_49_3)

	return
end

function var_0_1.ClickFurniture(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0.furnitures[arg_51_1]

	if var_2.HasDescription(var_51_0) then
		local var_51_1 = arg_51_0
		local var_51_2 = arg_51_0.DispatchEvent

		CourtYardEvent = var_1_10006

		var_51_2(var_51_1, var_1_10006.SHOW_FURNITURE_DESC, var_2)
	elseif var_2:CanTouch() then
		if var_2:GetTouchBg() then
			arg_51_0:CheckFurnitureTouchBG(var_2)
		end

		if not var_2:IsTouchState() then
			local var_51_3 = var_2
			local var_51_4 = var_2.ChangeState

			CourtYardFurniture = var_1_10007

			var_51_4(var_51_3, var_1_10007.STATE_TOUCH)

			local var_51_5 = arg_51_0
			local var_51_6 = arg_51_0.DispatchEvent

			CourtYardEvent = var_1_10007

			var_51_6(var_51_5, var_1_10007.ON_TOUCH_ITEM, var_2)
		else
			local var_51_7 = var_2
			local var_51_8 = var_2.ChangeState

			CourtYardFurniture = var_1_10007

			var_51_8(var_51_7, var_1_10007.STATE_IDLE)

			local var_51_9 = arg_51_0
			local var_51_10 = arg_51_0.DispatchEvent

			CourtYardEvent = var_7

			var_51_10(var_51_9, var_7.ON_CANCEL_TOUCH_ITEM, var_2)
		end
	end

	return
end

function var_0_1.CheckFurnitureTouchBG(arg_52_0, arg_52_1)
	pairs = var_1_10002

	for iter_52_0, iter_52_1 in var_1_10002(arg_52_0.furnitures) do
		if iter_52_1.id ~= arg_52_1.id and iter_52_1:IsTouchState() and iter_52_1:GetTouchBg() then
			local var_52_0 = iter_52_1
			local var_52_1 = iter_52_1.ChangeState

			CourtYardFurniture = var_1_10010

			var_52_1(var_52_0, var_1_10010.STATE_IDLE)

			local var_52_2 = arg_52_0
			local var_52_3 = arg_52_0.DispatchEvent

			CourtYardEvent = var_1_10010

			var_52_3(var_52_2, var_1_10010.ON_CANCEL_TOUCH_ITEM, iter_52_1)
		end
	end

	return
end

function var_0_1.PlayMusicalInstruments(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0.furnitures[arg_53_1]

	arg_53_0:MuteAll()

	local var_53_1 = arg_53_0
	local var_53_2 = arg_53_0.DispatchEvent

	CourtYardEvent = var_1_10006

	var_53_2(var_53_1, var_1_10006.FURNITURE_PLAY_MUSICALINSTRUMENTS, var_53_0)

	return
end

function var_0_1.StopPlayMusicalInstruments(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0.furnitures[arg_54_1]
	local var_54_1 = arg_54_0
	local var_54_2 = arg_54_0.DispatchEvent

	CourtYardEvent = var_1_10006

	var_54_2(var_54_1, var_1_10006.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, var_54_0)

	return
end

function var_0_1.PlayFurnitureVoice(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0.furnitures[arg_55_1]

	_ = var_1_10003

	if #var_1_10003.select(var_55_0.musicDatas, function(arg_56_0)
		return arg_56_0.voiceType == 1
	end) > 0 then
		math = var_4

		local var_55_1 = var_3[var_4.random(1, #var_3)]
		local var_55_2 = arg_55_0
		local var_55_3 = arg_55_0.DispatchEvent

		CourtYardEvent = var_1_10008

		var_55_3(var_55_2, var_1_10008.ON_ITEM_PLAY_MUSIC, var_55_1.voice, var_55_1.voiceType)
	end

	return
end

function var_0_1.PlayFurnitureBg(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.furnitures[arg_57_1]

	if arg_57_0:StopPrevFurnitureVoice() and var_3.id == var_57_0.id then
		return
	end

	local var_57_1 = var_57_0
	local var_57_2 = var_57_0.ChangeState

	CourtYardFurniture = var_1_10007

	var_57_2(var_57_1, var_1_10007.STATE_PLAY_MUSIC)

	if var_57_0:GetMusicData() then
		local var_57_3 = arg_57_0
		local var_57_4 = arg_57_0.DispatchEvent

		CourtYardEvent = var_1_10008

		var_57_4(var_57_3, var_1_10008.ON_ITEM_PLAY_MUSIC, var_4.voice, var_4.voiceType)
	end

	return
end

function var_0_1.MuteAll(arg_58_0)
	pairs = var_1_10001

	for iter_58_0, iter_58_1 in var_1_10001(arg_58_0.furnitures) do
		if iter_58_1:GetMusicData() then
			local var_58_0 = iter_58_1:GetMusicData()
			local var_58_1 = arg_58_0
			local var_58_2 = arg_58_0.DispatchEvent

			CourtYardEvent = var_1_10011

			var_58_2(var_58_1, var_1_10011.ON_ITEM_STOP_MUSIC, var_58_0.voice, var_58_0.voiceType)

			local var_58_3 = iter_58_1
			local var_58_4 = iter_58_1.ChangeState

			CourtYardFurniture = var_1_10011

			var_58_4(var_58_3, var_1_10011.STATE_STOP_MUSIC)
		end
	end

	local var_58_5 = arg_58_0
	local var_58_6 = arg_58_0.DispatchEvent

	CourtYardEvent = iter_58_0

	var_58_6(var_58_5, iter_58_0.FURNITURE_MUTE_ALL)

	return
end

function var_0_1.StopPrevFurnitureVoice(arg_59_0)
	local var_59_0

	pairs = var_1_10002

	for iter_59_0, iter_59_1 in var_1_10002(arg_59_0.furnitures) do
		if iter_59_1:GetMusicData() and var_7.voiceType == 2 then
			var_59_0 = iter_59_1
		end
	end

	if var_59_0 then
		local var_59_1 = var_59_0:GetMusicData()
		local var_59_2 = arg_59_0
		local var_59_3 = arg_59_0.DispatchEvent

		CourtYardEvent = iter_59_1

		var_59_3(var_59_2, iter_59_1.ON_ITEM_STOP_MUSIC, var_59_1.voice, var_59_1.voiceType)

		local var_59_4 = var_59_0
		local var_59_5 = var_59_0.ChangeState

		CourtYardFurniture = var_6

		var_59_5(var_59_4, var_6.STATE_STOP_MUSIC)
	end

	return var_59_0
end

function var_0_1.FurnitureAnimtionFinish(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_0.furnitures[arg_60_1]

	CourtYardFurniture = var_1_10004

	local var_60_2

	if arg_60_2 == var_1_10004.STATE_TOUCH then
		local var_60_1 = var_60_0

		var_60_2 = var_60_0.ChangeState
		CourtYardFurniture = var_1_10007

		var_60_2(var_60_1, var_1_10007.STATE_IDLE)
	else
		CourtYardFurniture = var_60_2

		local var_60_3

		if arg_60_2 == var_60_2.STATE_INTERACT then
			var_60_3 = var_60_0:GetUsingSlots()
			_ = var_1_10005

			var_1_10005.each(var_60_3, function(arg_61_0)
				arg_61_0:Continue(var_60_0)

				return
			end)
		else
			CourtYardFurniture = var_60_3

			if arg_60_2 == var_60_3.STATE_TOUCH_PREPARE then
				local var_60_4 = var_60_0
				local var_60_5 = var_60_0._ChangeState

				CourtYardFurniture = var_1_10007

				var_60_5(var_60_4, var_1_10007.STATE_TOUCH)
			end
		end
	end

	return
end

function var_0_1.BeginDragFurniture(arg_62_0, arg_62_1)
	if not arg_62_0.canEidt then
		return
	end

	local var_62_0 = arg_62_0.furnitures[arg_62_1]

	if not var_2.GetOpFlag(var_62_0) then
		return
	end

	local var_62_1 = var_2
	local var_62_2 = var_2.ChangeState

	CourtYardFurniture = var_1_10006

	var_62_2(var_62_1, var_1_10006.STATE_DRAG)

	if var_2:HasParent() then
		local var_62_3 = var_2:GetParent()

		var_3.RemoveChild(var_62_3, var_2)

		local var_62_4 = arg_62_0
		local var_62_5 = arg_62_0.DispatchEvent

		CourtYardEvent = var_7

		var_62_5(var_62_4, var_7.UN_CHILD_ITEM, var_2, var_3)
	else
		arg_62_0:RemoveItem(var_2)

		local var_62_6 = arg_62_0
		local var_62_7 = arg_62_0.DispatchEvent

		CourtYardEvent = var_6

		var_62_7(var_62_6, var_6.DRAG_ITEM, var_2)
	end

	return
end

function var_0_1.DragingFurniture(arg_63_0, arg_63_1, arg_63_2)
	if not arg_63_0.canEidt then
		return
	end

	local var_63_0 = arg_63_0.furnitures[arg_63_1]

	if not var_3.GetOpFlag(var_63_0) then
		return
	end

	isa = var_4

	local var_63_1 = var_3

	CourtYardWallFurniture = var_1_10007

	if var_4(var_63_1, var_1_10007) then
		arg_63_2 = var_3:NormalizePosition(arg_63_2, arg_63_0.minSizeX)
	end

	local var_63_2

	if not arg_63_0:GetParentForItem(var_3, arg_63_2) or not var_4:RawGetOffset() then
		var_63_2 = var_3:GetOffset()
	end

	local var_63_3

	if not var_4 or not var_4:AreaWithInfo(var_3, arg_63_2, var_63_2) then
		var_63_3 = arg_63_0:AreaWithInfo(var_3, arg_63_2, var_63_2)
	end

	local var_63_4 = arg_63_0
	local var_63_5 = arg_63_0.DispatchEvent

	CourtYardEvent = var_1_10010

	var_63_5(var_63_4, var_1_10010.DRAGING_ITEM, var_3, var_63_3, arg_63_2, var_63_2)

	return
end

function var_0_1.GetParentForItem(arg_64_0, arg_64_1, arg_64_2)
	_ = var_1_10003

	local var_64_0 = var_1_10003.select

	_ = var_1_10005

	local var_64_1 = var_64_0(var_1_10005.values(arg_64_0.furnitures), function(arg_65_0)
		isa = var_2_10001

		local var_65_0 = arg_65_0

		CourtYardCanPutFurniture = var_2_10004

		local var_65_1

		if var_2_10001(var_65_0, var_2_10004) then
			var_65_1 = arg_65_0:CanPutChildInPosition(arg_64_1, arg_64_2)
		end

		return var_65_1
	end)

	table = var_1_10004

	var_1_10004.sort(var_64_1, function(arg_66_0, arg_66_1)
		return (arg_66_0.parent and 1 or 0) > (arg_66_1.parent and 1 or 0)
	end)

	return var_64_1[1]
end

function var_0_1.DragFurnitureEnd(arg_67_0, arg_67_1, arg_67_2)
	if not arg_67_0.canEidt then
		return
	end

	local var_67_0 = arg_67_0.furnitures[arg_67_1]

	if not var_3.GetOpFlag(var_67_0) then
		return
	end

	local var_67_1 = var_3
	local var_67_2 = var_3.ChangeState

	CourtYardFurniture = var_1_10007

	var_67_2(var_67_1, var_1_10007.STATE_IDLE)

	isa = var_67_2

	local var_67_3 = var_3

	CourtYardWallFurniture = var_7

	if var_67_2(var_67_3, var_7) then
		arg_67_2 = var_3:NormalizePosition(arg_67_2, arg_67_0.minSizeX)
	end

	if not arg_67_0:VerifyDragPositionForFurniture(var_3, arg_67_2) then
		arg_67_0:RemoveFurniture(arg_67_1)

		local var_67_4 = arg_67_0

		var_1_10005 = arg_67_0.DispatchEvent
		CourtYardEvent = var_8

		var_1_10005(var_67_4, var_8.REMOVE_ILLEGALITY_ITEM)

		return
	end

	isa = var_1_10005

	local var_67_5 = var_3

	CourtYardWallFurniture = var_8

	if var_1_10005(var_67_5, var_8) then
		var_3:UpdatePosition(var_4)
	else
		var_3:SetPosition(var_4)
	end

	local var_67_6 = arg_67_0:GetParentForItem(var_3, var_4)
	local var_67_7

	if var_67_6 then
		local var_67_8 = arg_67_0
		local var_67_9 = arg_67_0.DispatchEvent

		CourtYardEvent = var_1_10010

		var_67_9(var_67_8, var_1_10010.CHILD_ITEM, var_3, var_67_6)
		var_67_6:AddChild(var_3)

		var_67_7 = var_67_6:AreaWithInfo(var_3, var_4, var_67_6:RawGetOffset(), true)
	else
		arg_67_0:AddItem(var_3)

		var_67_7 = arg_67_0:AreaWithInfo(var_3, var_4, var_3:GetOffset(), true)
	end

	local var_67_10 = arg_67_0
	local var_67_11 = arg_67_0.DispatchEvent

	CourtYardEvent = var_1_10010

	var_67_11(var_67_10, var_1_10010.DRAG_ITEM_END, var_3, var_67_7)

	return
end

function var_0_1.IsLegalAreaForFurniture(arg_68_0, arg_68_1, arg_68_2)
	_ = var_1_10003

	local var_68_0

	if not var_1_10003.all(arg_68_1:GetAreaByPosition(arg_68_2), function(arg_69_0)
		local var_69_0 = arg_68_0

		return var_1.LegalPosition(var_69_0, arg_69_0, arg_68_1)
	end) then
		var_68_0 = arg_68_0:GetParentForItem(arg_68_1, arg_68_2) ~= nil
	end

	return var_68_0
end

function var_0_1.VerifyDragPositionForFurniture(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0

	if arg_70_0:IsLegalAreaForFurniture(arg_70_1, arg_70_2) then
		var_70_0 = arg_70_2
	else
		if arg_70_1:GetPosition() then
			isa = var_1_10005

			local var_70_1 = arg_70_1

			CourtYardWallFurniture = var_8

			if var_1_10005(var_70_1, var_8) then
				arg_70_1:UpdatePosition(var_4)
			end
		end

		if var_4 and arg_70_0:IsLegalAreaForFurniture(arg_70_1, var_4) then
			var_70_0 = var_4
		else
			if var_4 then
				isa = var_1_10005

				local var_70_2 = arg_70_1

				CourtYardWallFurniture = var_8

				if var_1_10005(var_70_2, var_8) then
					arg_70_1:UpdatePosition(arg_70_2)
				end
			end

			var_70_0 = arg_70_0:GetEmptyArea(arg_70_1)
		end
	end

	return var_70_0
end

function var_0_1.UnSelectFurniture(arg_71_0, arg_71_1)
	local var_71_0 = arg_71_0.furnitures[arg_71_1]

	if not var_2.GetOpFlag(var_71_0) then
		return
	end

	var_2:UpdateOpFlag(false)

	local var_71_1 = arg_71_0
	local var_71_2 = arg_71_0.DispatchEvent

	CourtYardEvent = var_6

	var_71_2(var_71_1, var_6.UNSELETED_ITEM, var_2)

	return
end

function var_0_1.RotateFurniture(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0.furnitures[arg_72_1]

	if var_2.DisableRotation(var_72_0) then
		local var_72_1 = arg_72_0
		local var_72_2 = arg_72_0.DispatchEvent

		CourtYardEvent = var_1_10006

		var_72_2(var_72_1, var_1_10006.DISABLE_ROTATE_ITEM)
	elseif not arg_72_0:CanRotateItem(var_2) then
		local var_72_3 = arg_72_0
		local var_72_4 = arg_72_0.DispatchEvent

		CourtYardEvent = var_6

		var_72_4(var_72_3, var_6.ROTATE_ITEM_FAILED)
	else
		if not var_2:HasParent() then
			arg_72_0:RemoveItem(var_2)
		end

		var_2:Rotate()

		local var_72_5 = arg_72_0:AreaWithInfo(var_2, var_2:GetPosition(), var_2:GetOffset())

		if not var_3 then
			arg_72_0:AddItem(var_2)
		end

		local var_72_6 = arg_72_0
		local var_72_7 = arg_72_0.DispatchEvent

		CourtYardEvent = var_8

		var_72_7(var_72_6, var_8.ROTATE_ITEM, var_2, var_72_5)
	end

	return
end

function var_0_1.RemoveFurniture(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0.furnitures[arg_73_1]

	if var_2.HasParent(var_73_0) then
		local var_73_1 = var_2:GetParent()

		var_4.RemoveChild(var_73_1, var_2)
	end

	local var_73_2

	if not var_2.childs then
		var_73_2 = {}
	end

	for iter_73_0 = #var_73_2, 1, -1 do
		arg_73_0:RemoveFurniture(var_73_2[iter_73_0].id)
	end

	if not var_3 then
		arg_73_0:RemoveItem(var_2)
	end

	if var_2:GetMusicData() then
		local var_73_3 = arg_73_0
		local var_73_4 = arg_73_0.DispatchEvent

		CourtYardEvent = var_1_10009

		var_73_4(var_73_3, var_1_10009.ON_ITEM_STOP_MUSIC, var_5.voice, var_5.voiceType)

		local var_73_5 = var_2
		local var_73_6 = var_2.ChangeState

		CourtYardFurniture = var_9

		var_73_6(var_73_5, var_9.STATE_STOP_MUSIC)
	end

	arg_73_0:UnSelectFurniture(arg_73_1)

	local var_73_7 = var_2.configId
	local var_73_8 = arg_73_0.furnitures[arg_73_1]

	var_7.Dispose(var_73_8)

	arg_73_0.furnitures[arg_73_1] = nil

	local var_73_9 = arg_73_0
	local var_73_10 = arg_73_0.DispatchEvent

	CourtYardEvent = var_1_10010

	var_73_10(var_73_9, var_1_10010.DETORY_ITEM, var_2)

	local var_73_11 = arg_73_0.composeChecker

	var_7.Check(var_73_11)
	arg_73_0:RefreshCombineFruniture(var_73_7)

	return
end

function var_0_1.RemoveAllFurniture(arg_74_0)
	pairs = var_1_10001

	for iter_74_0, iter_74_1 in var_1_10001(arg_74_0.furnitures) do
		if not iter_74_1:HasParent() then
			arg_74_0:RemoveFurniture(iter_74_1.id)
		end
	end

	arg_74_0:SetWallPaper(nil)
	arg_74_0:SetFloorPaper(nil)

	return
end

function var_0_1.RemovePaper(arg_75_0, arg_75_1)
	if arg_75_0:GetWallPaper() and var_2.id == arg_75_1 then
		arg_75_0:SetWallPaper(nil)
	end

	if arg_75_0:GetFloorPaper() and var_3.id == arg_75_1 then
		arg_75_0:SetFloorPaper(nil)
	end

	return
end

function var_0_1.CheckFurnitureState(arg_76_0)
	pairs = var_1_10001

	for iter_76_0, iter_76_1 in var_1_10001(arg_76_0.furnitures) do
		local var_76_0 = iter_76_1
		local var_76_1 = iter_76_1.IsType

		Furniture = var_1_10009

		if var_76_1(var_76_0, var_1_10009.TYPE_MOVEABLE) and iter_76_1:IsReadyMove() then
			arg_76_0:ReadyMoveFurniture(iter_76_1.id)
		end
	end

	return
end

function var_0_1.ReadyMoveFurniture(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_0.furnitures[arg_77_1]

	if not arg_77_0:GetNextPositionForMove(var_77_0) then
		var_77_0:Rest()

		return
	end

	local var_77_1

	if var_77_0:IsDifferentDirection(var_3) then
		var_77_1 = arg_77_0:CanRotateItem(var_77_0)
	end

	if var_77_1 then
		arg_77_0:RotateFurniture(arg_77_1)
	end

	var_77_0:Move(var_3)
	arg_77_0:RemoveItem(var_77_0)
	var_77_0:SetPosition(var_3)
	arg_77_0:AddItemAndRefresh(var_77_0)

	return
end

function var_0_1.GetFurnituresByType(arg_78_0, arg_78_1)
	local var_78_0 = {}

	pairs = var_1_10003

	for iter_78_0, iter_78_1 in var_1_10003(arg_78_0.furnitures) do
		if iter_78_1:IsType(arg_78_1) then
			table = var_8

			var_8.insert(var_78_0, iter_78_1)
		end
	end

	return var_78_0
end

function var_0_1.EnterEditMode(arg_79_0)
	arg_79_0.canEidt = true
	pairs = var_1

	for iter_79_0, iter_79_1 in var_1(arg_79_0.ships) do
		local var_79_0 = iter_79_1:GetState()

		CourtYardShip = var_1_10007

		if var_79_0 == var_1_10007.STATE_DRAG then
			local var_79_1 = arg_79_0
			local var_79_2 = arg_79_0.DragShipEnd

			var_1_10009 = iter_79_1.id
			Vector2 = var_1_10010

			var_79_2(var_79_1, var_1_10009, var_1_10010(-1, -1))
		end

		var_1_10009 = arg_79_0:GetPlaceableArea(iter_79_1)

		var_6._ClearLockPosition(var_1_10009, iter_79_1)

		var_1_10009 = iter_79_1

		if iter_79_1.HasParent(var_1_10009) then
			var_1_10009 = iter_79_1
			var_1_10010 = iter_79_1.GetParent(var_1_10009)

			var_1_10007.RemoveChild(var_1_10010, iter_79_1)

			var_1_10010 = arg_79_0

			local var_79_3 = arg_79_0.DispatchEvent

			CourtYardEvent = var_11

			var_79_3(var_1_10010, var_11.UN_CHILD_ITEM, iter_79_1, var_1_10007)
		else
			var_1_10009 = arg_79_0

			arg_79_0.RemoveItem(var_1_10009, iter_79_1)
		end

		var_1_10009 = iter_79_1
		var_1_10007 = iter_79_1.ChangeState
		CourtYardShip = var_1_10010

		var_1_10007(var_1_10009, var_1_10010.STATE_STOP)
	end

	pairs = var_1

	for iter_79_2, iter_79_3 in var_1(arg_79_0.furnitures) do
		local var_79_4 = iter_79_3
		local var_79_5 = iter_79_3.IsType

		Furniture = var_1_10009

		if var_79_5(var_79_4, var_1_10009.TYPE_TRANSPORT) and iter_79_3:IsUsing() then
			iter_79_3:Stop()
		end

		local var_79_6 = iter_79_3
		local var_79_7 = iter_79_3.IsType

		Furniture = var_1_10009

		if var_79_7(var_79_6, var_1_10009.TYPE_FOLLOWER) and iter_79_3:IsUsing() then
			iter_79_3:Stop()
		end

		local var_79_8 = iter_79_3
		local var_79_9 = iter_79_3.IsType

		Furniture = var_1_10009

		if var_79_9(var_79_8, var_1_10009.TYPE_MOVEABLE) and iter_79_3:IsMoving() then
			iter_79_3:Stop()
		end

		if iter_79_3:IsTouchState() then
			arg_79_0:ClickFurniture(iter_79_3.id)
		end
	end

	local var_79_10 = arg_79_0.recoder

	var_1.BeginCheckChange(var_79_10)

	local var_79_11 = arg_79_0
	local var_79_12 = arg_79_0.DispatchEvent

	CourtYardEvent = iter_79_2

	var_79_12(var_79_11, iter_79_2.ENTER_EDIT_MODE)

	return
end

function var_0_1.ExitEditMode(arg_80_0)
	pairs = var_1_10001

	for iter_80_0, iter_80_1 in var_1_10001(arg_80_0.ships) do
		if iter_80_1:ShouldResetPosition() then
			local var_80_0 = iter_80_1:GetPosition()

			var_1_10009 = arg_80_0

			arg_80_0.ResetShip(var_1_10009, iter_80_1, var_80_0)
		end
	end

	pairs = var_1

	for iter_80_2, iter_80_3 in var_1(arg_80_0.furnitures) do
		local var_80_1 = iter_80_3
		local var_80_2 = iter_80_3.IsType

		Furniture = var_1_10009

		if var_80_2(var_80_1, var_1_10009.TYPE_MOVEABLE) and iter_80_3:IsStop() then
			iter_80_3:ReStart()

			if iter_80_3:CanTouch() then
				arg_80_0:ClickFurniture(iter_80_3.id)
			end
		end
	end

	_ = var_1

	local var_80_3 = var_1.detect

	_ = var_3

	if var_80_3(var_3.values(arg_80_0.furnitures), function(arg_81_0)
		return arg_81_0:GetOpFlag()
	end) then
		arg_80_0:UnSelectFurniture(var_1.id)
	end

	arg_80_0.canEidt = false

	local var_80_4 = arg_80_0.recoder

	var_2.EndCheckChange(var_80_4)

	local var_80_5 = arg_80_0
	local var_80_6 = arg_80_0.DispatchEvent

	CourtYardEvent = var_5

	var_80_6(var_80_5, var_5.EXIT_EDIT_MODE)

	return
end

function var_0_1.InEidtMode(arg_82_0)
	return arg_82_0.canEidt
end

function var_0_1.StopAllDragState(arg_83_0)
	local function var_83_0()
		pairs = var_2_10000

		for iter_84_0, iter_84_1 in var_2_10000(arg_83_0.ships) do
			local var_84_0 = iter_84_1:GetState()

			CourtYardShip = var_2_10006

			if var_84_0 == var_2_10006.STATE_DRAG then
				local var_84_1 = arg_83_0
				local var_84_2 = var_5.DragShipEnd
				local var_84_3 = iter_84_1.id

				Vector2 = var_2_10009

				var_84_2(var_84_1, var_84_3, var_2_10009(-1, -1))
			end
		end

		return
	end

	local function var_83_1()
		pairs = var_2_10000

		for iter_85_0, iter_85_1 in var_2_10000(arg_83_0.furnitures) do
			if iter_85_1:IsDragingState() then
				local var_85_0 = arg_83_0
				local var_85_1 = var_5.DragFurnitureEnd
				local var_85_2 = iter_85_1.id

				Vector2 = var_2_10009

				var_85_1(var_85_0, var_85_2, var_2_10009(-1, -1))

				local var_85_3 = arg_83_0

				var_5.UnSelectFurniture(var_85_3, iter_85_1.id)
			end
		end

		return
	end

	if not arg_83_0:InEidtMode() then
		var_83_0()
	else
		var_83_1()
	end

	return
end

function var_0_1.StartInteraction(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_1
	local var_86_1 = arg_86_1.GetUser(var_86_0)
	local var_86_2 = arg_86_1:GetOwner()

	isa = var_86_0

	local var_86_3 = var_86_2

	CourtYardFurniture = iter_86_0

	if var_86_0(var_86_3, iter_86_0) and var_86_2:GetInterActionBgm() then
		pairs = var_4

		for iter_86_0, iter_86_1 in var_4(arg_86_0.furnitures) do
			if iter_86_1:IsPlayMusicState() then
				local var_86_4 = iter_86_1
				local var_86_5 = iter_86_1.ChangeState

				CourtYardFurniture = var_1_10012

				var_86_5(var_86_4, var_1_10012.STATE_STOP_MUSIC)
			end
		end
	end

	local var_86_6 = arg_86_0
	local var_86_7 = arg_86_0.DispatchEvent

	CourtYardEvent = iter_86_0

	var_86_7(var_86_6, iter_86_0.ITEM_INTERACTION, var_86_1, var_86_2, arg_86_1)

	return
end

function var_0_1.WillClearInteraction(arg_87_0, arg_87_1, arg_87_2)
	local var_87_0 = arg_87_1:GetUser()
	local var_87_1 = arg_87_1:GetOwner()
	local var_87_2 = arg_87_0
	local var_87_3 = arg_87_0.DispatchEvent

	CourtYardEvent = var_1_10008

	var_87_3(var_87_2, var_1_10008.CLEAR_ITEM_INTERACTION, var_87_0, var_87_1, arg_87_1)

	return
end

function var_0_1.ClearInteraction(arg_88_0, arg_88_1, arg_88_2)
	local var_88_0 = arg_88_1
	local var_88_1 = arg_88_1.GetUser(var_88_0)
	local var_88_2 = arg_88_1:GetOwner()

	isa = var_88_0

	local var_88_3 = var_88_1

	CourtYardFollowerFurniture = var_1_10008

	if var_88_0(var_88_3, var_1_10008) then
		arg_88_0:ClearInteractionForFollower(var_88_1, var_88_2, arg_88_1, arg_88_2)
	elseif not arg_88_2 then
		isa = var_5

		local var_88_4 = var_88_2

		CourtYardTransportFurniture = var_1_10008

		if var_5(var_88_4, var_1_10008) then
			arg_88_0:ClearInteractionForTransPort(var_88_1, var_88_2, arg_88_1)
		else
			arg_88_0:ResetShip(var_88_1, var_88_1:GetPosition())
		end
	end

	return
end

function var_0_1.ClearInteractionForFollower(arg_89_0, arg_89_1, arg_89_2, arg_89_3, arg_89_4)
	if not arg_89_0:GetAroundEmptyArea(arg_89_1, arg_89_2:GetPosition()) then
		local var_89_0 = arg_89_0
		local var_89_1 = arg_89_0.DispatchEvent

		CourtYardEvent = var_9

		var_89_1(var_89_0, var_9.REMOVE_ILLEGALITY_ITEM)
		arg_89_0:RemoveFurniture(arg_89_1.id)

		return
	end

	arg_89_1:SetPosition(var_5)
	arg_89_0:AddItemAndRefresh(arg_89_1)

	return
end

function var_0_1.ClearInteractionForTransPort(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	local var_90_0 = arg_90_3

	if arg_90_3.IsFirstTime(var_90_0) then
		local var_90_1 = arg_90_0
		local var_90_2 = arg_90_0.GetFurnituresByType

		Furniture = var_1_10008

		local var_90_3 = var_90_2(var_90_1, var_1_10008.TYPE_TRANSPORT)

		_ = var_90_0

		local var_90_4 = var_90_0.select(var_90_3, function(arg_91_0)
			return arg_91_0.id ~= arg_90_2.id
		end)

		math = var_90_1

		if var_90_4[var_90_1.random(1, #var_90_4)] and var_7:CanInterAction(arg_90_1) then
			local var_90_5 = var_7:GetInteractionSlot()

			var_8.Link(var_90_5, var_7, arg_90_1, arg_90_0)
		else
			arg_90_0:ResetShip(arg_90_1, arg_90_0:GetRandomPosition(arg_90_1))
		end
	else
		arg_90_0:ResetShip(arg_90_1, arg_90_0:GetAroundEmptyPosition(arg_90_2))
	end

	return
end

function var_0_1.LegalPosition(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0

	if var_0_1.super.LegalPosition(arg_92_0, arg_92_1, arg_92_2) then
		var_92_0 = arg_92_2:InActivityRange(arg_92_1)
	end

	return var_92_0
end

function var_0_1.GetLevel(arg_93_0)
	return arg_93_0.level
end

function var_0_1.Dispose(arg_94_0)
	var_0_1.super.Dispose(arg_94_0)

	local var_94_0 = arg_94_0.recoder

	var_1.Dispose(var_94_0)

	arg_94_0.recoder = nil

	local var_94_1 = arg_94_0.composeChecker

	var_1.Dispose(var_94_1)

	arg_94_0.composeChecker = nil
	pairs = var_1

	for iter_94_0, iter_94_1 in var_1(arg_94_0.ships) do
		iter_94_1:Dispose()
	end

	pairs = var_1

	for iter_94_2, iter_94_3 in var_1(arg_94_0.furnitures) do
		iter_94_3:Dispose()
	end

	arg_94_0.ships = nil
	arg_94_0.furnitures = nil

	return
end

function var_0_1.GetDirty(arg_95_0)
	local var_95_0 = arg_95_0.recoder

	return var_1.TakeSample(var_95_0)
end

function var_0_1.ToTable(arg_96_0)
	local var_96_0 = {}

	local function var_96_1(arg_97_0)
		arg_97_0.floor = arg_96_0.id
		var_96_0[arg_97_0.id] = arg_97_0

		return
	end

	pairs = var_1_10003

	for iter_96_0, iter_96_1 in var_1_10003(arg_96_0.furnitures) do
		var_96_1(iter_96_1:ToTable())
	end

	if arg_96_0.wallPaper then
		local var_96_2 = var_96_1
		local var_96_3 = arg_96_0.wallPaper

		var_96_2(var_5.ToTable(var_96_3))
	end

	if arg_96_0.floorPaper then
		local var_96_4 = var_96_1
		local var_96_5 = arg_96_0.floorPaper

		var_96_4(var_5.ToTable(var_96_5))
	end

	return var_96_0
end

return var_0_1
