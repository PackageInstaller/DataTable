local var_0_0 = class("CourtYardStorey", import("..map.CourtYardPlaceableArea"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_4)

	arg_1_0.id = arg_1_2
	arg_1_0.style = arg_1_3
	arg_1_0.level = 1
	arg_1_0.furnitures = {}
	arg_1_0.ships = {}
	arg_1_0.canEidt = false
	arg_1_0.recoder = CourtYardStoreyRecorder.New(arg_1_0)
	arg_1_0.composeChecker = CourtYardStoreyComposeChecker.New(arg_1_0)

	return
end

function var_0_0.GetStyle(arg_2_0)
	return arg_2_0.style
end

function var_0_0.SetLevel(arg_3_0, arg_3_1)
	arg_3_0.level = arg_3_1

	arg_3_0:UpdateMinRange(Vector2(CourtYardConst.MAX_STOREY_LEVEL * CourtYardConst.OPEN_AREA_PRE_LEVEL - (arg_3_0.level - 1) * CourtYardConst.OPEN_AREA_PRE_LEVEL, CourtYardConst.MAX_STOREY_LEVEL * CourtYardConst.OPEN_AREA_PRE_LEVEL - (arg_3_0.level - 1) * CourtYardConst.OPEN_AREA_PRE_LEVEL))
	arg_3_0:DispatchEvent(CourtYardEvent.UPDATE_STOREY, arg_3_1)

	return
end

function var_0_0.LevelUp(arg_4_0)
	arg_4_0:SetLevel(arg_4_0.level + 1)
	arg_4_0:DispatchEvent(CourtYardEvent.UPDATE_FLOORPAPER, arg_4_0.floorPaper)
	arg_4_0:DispatchEvent(CourtYardEvent.UPDATE_WALLPAPER, arg_4_0.wallPaper)

	return
end

function var_0_0.SetWallPaper(arg_5_0, arg_5_1)
	arg_5_0.wallPaper = arg_5_1

	arg_5_0:DispatchEvent(CourtYardEvent.UPDATE_WALLPAPER, arg_5_1)
	arg_5_0.composeChecker:Check()

	return
end

function var_0_0.SetFloorPaper(arg_6_0, arg_6_1)
	arg_6_0.floorPaper = arg_6_1

	arg_6_0:DispatchEvent(CourtYardEvent.UPDATE_FLOORPAPER, arg_6_1)
	arg_6_0.composeChecker:Check()

	return
end

function var_0_0.GetWallPaper(arg_7_0)
	return arg_7_0.wallPaper
end

function var_0_0.GetFloorPaper(arg_8_0)
	return arg_8_0.floorPaper
end

function var_0_0.GetFurnitures(arg_9_0)
	return arg_9_0.furnitures
end

function var_0_0.GetAllFurniture(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.furnitures) do
		({})[iter_10_1.id] = iter_10_1
	end

	if arg_10_0.floorPaper then
		({})[arg_10_0.floorPaper.id] = arg_10_0.floorPaper
	end

	if arg_10_0.wallPaper then
		({})[arg_10_0.wallPaper.id] = arg_10_0.wallPaper
	end

	return {}
end

function var_0_0.GetShips(arg_11_0)
	return arg_11_0.ships
end

function var_0_0.GetShip(arg_12_0, arg_12_1)
	return arg_12_0.ships[arg_12_1]
end

function var_0_0.GetFurniture(arg_13_0, arg_13_1)
	return arg_13_0.furnitures[arg_13_1]
end

function var_0_0.CanAddFurniture(arg_14_0, arg_14_1)
	return true
end

function var_0_0.AddFurniture(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.furnitures[arg_15_1.id] = arg_15_1

	arg_15_0:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_15_1, arg_15_2)
	arg_15_0:AddItem(arg_15_1)
	arg_15_0.composeChecker:Check()

	if arg_15_1:CanTouch() and arg_15_1:TriggerTouchDefault() then
		arg_15_0:ClickFurniture(arg_15_1.id)
	end

	if not arg_15_2 then
		arg_15_0:RefreshCombineFruniture(arg_15_1.configId)
	end

	return
end

function var_0_0.RefreshCombineFruniture(arg_16_0, arg_16_1)
	if type(pg.furniture_data_template[arg_16_1].spine_combine_action_replace) == "table" then
		for iter_16_0, iter_16_1 in pairs(pg.furniture_data_template[arg_16_1].spine_combine_action_replace) do
			for iter_16_2, iter_16_3 in ipairs(iter_16_1[1]) do
				table.insert({
					arg_16_1
				}, iter_16_3)
			end
		end
	end

	for iter_16_4, iter_16_5 in pairs(arg_16_0.furnitures) do
		if table.contains({
			arg_16_1
		}, iter_16_5.configId) then
			iter_16_5:RefreshState()
		end
	end

	return
end

function var_0_0.AddPaper(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:GetType()

	if var_17_0 == Furniture.TYPE_WALLPAPER then
		arg_17_0:SetWallPaper(arg_17_1)
	elseif var_17_0 == Furniture.TYPE_FLOORPAPER then
		arg_17_0:SetFloorPaper(arg_17_1)
	end

	return
end

function var_0_0.AddChildFurniture(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.furnitures[arg_18_1.id] = arg_18_1

	arg_18_0:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_18_1)
	arg_18_0:DispatchEvent(CourtYardEvent.CHILD_ITEM, arg_18_1, arg_18_0.furnitures[arg_18_2])
	arg_18_0.furnitures[arg_18_2]:AddChild(arg_18_1)

	return
end

function var_0_0.Update(arg_19_0)
	arg_19_0:CheckShipState()
	arg_19_0:CheckFurnitureState()

	return
end

function var_0_0.AddShip(arg_20_0, arg_20_1)
	arg_20_1:ChangeState(CourtYardShip.STATE_IDLE)

	arg_20_0.ships[arg_20_1.id] = arg_20_1

	arg_20_0:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_20_1)
	arg_20_0:AddItem(arg_20_1)

	return
end

function var_0_0.GetPlaceableArea(arg_21_0, arg_21_1)
	if arg_21_1:HasParent() then
		return arg_21_1:GetParent():GetPlaceableArea() or arg_21_0
	end
end

function var_0_0.RemoveShip(arg_22_0, arg_22_1)
	arg_22_0:GetPlaceableArea(arg_22_1):RemoveItem(arg_22_1)
	arg_22_0.ships[arg_22_1.id]:Dispose()

	arg_22_0.ships[arg_22_1.id] = nil

	arg_22_0:DispatchEvent(CourtYardEvent.DETORY_ITEM, arg_22_1)

	if arg_22_0.ships[arg_22_1.id + CourtYardConst.DOUBLE_SKIN_ADD] then
		arg_22_0:RemoveShip(arg_22_0.ships[arg_22_1.id + CourtYardConst.DOUBLE_SKIN_ADD])
	end

	return
end

function var_0_0.ExitShip(arg_23_0, arg_23_1)
	if arg_23_0.ships[arg_23_1] then
		arg_23_0:RemoveShip(arg_23_0.ships[arg_23_1])
	end

	return
end

function var_0_0.CheckShipState(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0:GetShips()) do
		local var_24_0 = iter_24_1:GetState()

		if var_24_0 == CourtYardShip.STATE_MOVE then
			arg_24_0:ReadyMoveShip(iter_24_1.id)
		elseif var_24_0 == CourtYardShip.STATE_MOVING_HALF then
			arg_24_0:MoveShipToNextPosition(iter_24_1.id)
		end
	end

	return
end

function var_0_0.ReadyMoveShip(arg_25_0, arg_25_1)
	local var_25_0 = false
	local var_25_1 = false
	local var_25_2 = false

	if CourtYardCalcUtil.HalfProbability() then
		if arg_25_0.ships[arg_25_1]:HasParent() then
			if arg_25_0.ships[arg_25_1]:GetParent():IsType(Furniture.TYPE_ARCH) then
				var_25_0 = arg_25_0:ShipExitArch(arg_25_0.ships[arg_25_1])

				goto label_25_0
			end
		end

		var_25_1 = arg_25_0:ShipEnterArch(arg_25_0.ships[arg_25_1])

		if not var_25_1 then
			var_25_2 = arg_25_0:ShipAddFollower(arg_25_0.ships[arg_25_1])
		end
	end

	::label_25_0::

	if not var_25_0 and not var_25_1 and not var_25_2 then
		arg_25_0:RandomNextShipPosition(arg_25_1)
	end

	return
end

function var_0_0.ShipAddFollower(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:GetFurnituresByType(Furniture.TYPE_FOLLOWER)

	for iter_26_0, iter_26_1 in ipairs(arg_26_1:GetAroundPositions()) do
		local var_26_1 = (function(arg_27_0)
			return _.detect(var_26_0, function(arg_28_0)
				return _.any(arg_28_0:GetArea(), function(arg_29_0)
					return arg_29_0 == arg_27_0
				end)
			end)
		end)(iter_26_1)

		if var_26_1 and var_26_1:CanFollower(arg_26_1) then
			(function()
				local var_30_0 = arg_26_1:GetInterActionData()

				if var_30_0 ~= nil then
					var_30_0:Stop()
				end

				return
			end)()
			arg_26_0:RemoveItemAndRefresh(var_26_1)
			var_26_1:GetInteractionSlot():Occupy(var_26_1, arg_26_1, arg_26_0)

			return true
		end
	end

	return false
end

function var_0_0.ShipExitArch(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:GetNextPositionForMove(arg_31_1)

	if var_31_0 then
		local var_31_1 = arg_31_1:GetParent()

		var_31_1:RemoveChild(arg_31_1)
		arg_31_0:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, arg_31_1, var_31_1)
		arg_31_0:DispatchEvent(CourtYardEvent.EXIT_ARCH, arg_31_1, var_31_1)
		arg_31_0:LockPosition(var_31_0)
		arg_31_1:UnClear(true)
		arg_31_1:Move(var_31_0)

		return true
	end

	return false
end

function var_0_0.ShipEnterArch(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_1:GetAroundPositions()) do
		local var_32_0 = arg_32_0:GetParentForItem(arg_32_1, iter_32_1)

		if var_32_0 and var_32_0:IsType(Furniture.TYPE_ARCH) then
			(function(arg_33_0, arg_33_1)
				arg_32_0:RemoveItem(arg_32_1)
				arg_32_0:DispatchEvent(CourtYardEvent.CHILD_ITEM, arg_32_1, arg_33_0)
				arg_32_0:DispatchEvent(CourtYardEvent.ENTER_ARCH, arg_32_1, arg_33_0)
				arg_33_0:AddChild(arg_32_1)
				arg_32_1:Move(arg_33_1)

				return
			end)(var_32_0, iter_32_1)

			return true
		end
	end

	return false
end

function var_0_0.RandomNextShipPosition(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:GetPlaceableArea(arg_34_0.ships[arg_34_1])
	local var_34_1 = var_34_0:GetNextPositionForMove(arg_34_0.ships[arg_34_1])

	if not var_34_1 then
		arg_34_0.ships[arg_34_1]:ChangeState(CourtYardShip.STATE_IDLE)

		return
	end

	var_34_0:LockPosition(var_34_1)
	arg_34_0.ships[arg_34_1]:Move(var_34_1)

	return
end

function var_0_0.MoveShipToNextPosition(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.ships[arg_35_1]
	local var_35_1 = arg_35_0:GetPlaceableArea(arg_35_0.ships[arg_35_1])
	local var_35_2 = arg_35_0.ships[arg_35_1]:GetMarkPosition()

	var_35_1:_ClearLockPosition(arg_35_0.ships[arg_35_1])

	if var_35_0:IsUnClear() then
		var_35_0:UnClear(false)
	else
		var_35_1:RemoveItem(var_35_0)
	end

	var_35_0:SetPosition(var_35_2)
	var_35_1:AddItem(var_35_0)
	var_35_0:ChangeState(CourtYardShip.STATE_MOVING_ONE)

	return
end

function var_0_0.DragShip(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.ships[arg_36_1]

	arg_36_0:GetPlaceableArea(arg_36_0.ships[arg_36_1]):_ClearLockPosition(arg_36_0.ships[arg_36_1])

	local var_36_1 = var_36_0:GetPosition()
	local var_36_2 = var_36_0:GetInterActionData()

	if var_36_2 ~= nil or var_36_0:GetState() == CourtYardShip.STATE_INTERACT then
		if isa(var_36_2, CourtYardFollowerSlot) then
			arg_36_0:RemoveItem(var_36_0)
		end

		var_36_2:Stop()
	elseif var_36_0:HasParent() then
		local var_36_3 = var_36_0:GetParent()

		var_36_3:RemoveChild(var_36_0)
		var_36_0:ChangeState(CourtYardShip.STATE_IDLE)
		arg_36_0:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, var_36_0, var_36_3)
	else
		arg_36_0:RemoveItem(var_36_0)
	end

	var_36_0:ChangeState(CourtYardShip.STATE_DRAG)
	var_36_0:UpdateOpFlag(true)
	arg_36_0:DispatchEvent(CourtYardEvent.SELETED_ITEM, var_36_0, (arg_36_0:AreaWithInfo(var_36_0, var_36_1, var_36_0:GetOffset())))
	arg_36_0:DispatchEvent(CourtYardEvent.DRAG_ITEM, var_36_0)

	return
end

function var_0_0.DragingShip(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0.ships[arg_37_1]

	if not arg_37_0.ships[arg_37_1]:GetOpFlag() then
		return
	end

	local var_37_1 = arg_37_0:GetParentForItem(var_37_0, arg_37_2)
	local var_37_2 = var_37_1 and var_37_1:RawGetOffset() or var_37_0:GetOffset()

	arg_37_0:DispatchEvent(CourtYardEvent.DRAGING_ITEM, var_37_0, arg_37_0:AreaWithInfo(var_37_0, arg_37_2, var_37_2, arg_37_0:GetInterActionFurniture(var_37_0, arg_37_2) or var_37_1), arg_37_2, var_37_2)

	return
end

function var_0_0.DragShipEnd(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0.ships[arg_38_1]

	if not arg_38_0.ships[arg_38_1]:GetOpFlag() then
		return
	end

	local var_38_1 = arg_38_0:LegalPosition(arg_38_2, var_38_0)
	local var_38_2 = arg_38_0:GetInterActionFurniture(var_38_0, arg_38_2)
	local var_38_3 = arg_38_0:GetParentForItem(var_38_0, arg_38_2)
	local var_38_4

	if not var_38_1 and var_38_2 then
		if isa(var_38_2, CourtYardFollowerFurniture) then
			arg_38_0:RemoveItemAndRefresh(var_38_2)
			arg_38_0:ResetShip(var_38_0, arg_38_2)
			var_38_0:ChangeState(CourtYardShip.STATE_MOVE)
		end

		var_38_2:GetInteractionSlot():Occupy(var_38_2, var_38_0, arg_38_0)
	elseif not var_38_1 and var_38_3 then
		var_38_0:SetPosition(arg_38_2)
		arg_38_0:DispatchEvent(CourtYardEvent.CHILD_ITEM, var_38_0, var_38_3)
		var_38_3:AddChild(var_38_0)
		var_38_0:ChangeState(CourtYardShip.STATE_IDLE)

		var_38_4 = var_38_3:AreaWithInfo(var_38_0, arg_38_2, var_38_3:RawGetOffset(), true)
	else
		local var_38_5 = var_38_1 and arg_38_2 or var_38_0:GetPosition()

		arg_38_0:ResetShip(var_38_0, var_38_5)

		var_38_4 = arg_38_0:AreaWithInfo(var_38_0, var_38_5, var_38_0:GetOffset(), true)
	end

	var_38_0:UpdateOpFlag(false)
	arg_38_0:DispatchEvent(CourtYardEvent.DRAG_ITEM_END, var_38_4)
	arg_38_0:DispatchEvent(CourtYardEvent.UNSELETED_ITEM, var_38_0)

	return
end

function var_0_0.GetInterActionFurniture(arg_39_0, arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.furnitures) do
		if iter_39_1:CanInterAction(arg_39_1) and iter_39_1:IsOverlap(arg_39_2) then
			return iter_39_1
		end
	end

	return nil
end

function var_0_0.TouchShip(arg_40_0, arg_40_1)
	arg_40_0:GetPlaceableArea(arg_40_0.ships[arg_40_1]):_ClearLockPosition(arg_40_0.ships[arg_40_1])
	arg_40_0.ships[arg_40_1]:ChangeState(CourtYardShip.STATE_TOUCH)

	return
end

function var_0_0.UpdateShipIntimacy(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0.ships[arg_41_1] then
		return
	end

	arg_41_0.ships[arg_41_1]:ChangeInimacy(arg_41_2)

	return
end

function var_0_0.UpdateShipCoin(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_0.ships[arg_42_1] then
		return
	end

	arg_42_0.ships[arg_42_1]:ChangeCoin(arg_42_2)

	return
end

function var_0_0.ClearShipIntimacy(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0.ships[arg_43_1] then
		return
	end

	arg_43_0:GetPlaceableArea(arg_43_0.ships[arg_43_1]):_ClearLockPosition(arg_43_0.ships[arg_43_1])
	arg_43_0.ships[arg_43_1]:ClearInimacy(arg_43_2)

	return
end

function var_0_0.ClearShipCoin(arg_44_0, arg_44_1)
	if not arg_44_0.ships[arg_44_1] then
		return
	end

	arg_44_0:GetPlaceableArea(arg_44_0.ships[arg_44_1]):_ClearLockPosition(arg_44_0.ships[arg_44_1])
	arg_44_0.ships[arg_44_1]:ClearCoin(value)

	return
end

function var_0_0.AddShipExp(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_0.ships[arg_45_1] then
		return
	end

	arg_45_0.ships[arg_45_1]:AddExp(arg_45_2)

	return
end

function var_0_0.ShipAnimtionFinish(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_2 == CourtYardShip.STATE_TOUCH or arg_46_2 == CourtYardShip.STATE_GETAWARD then
		arg_46_0.ships[arg_46_1]:ChangeState(CourtYardShip.STATE_IDLE)
	elseif arg_46_2 == CourtYardShip.STATE_INTERACT then
		local var_46_0 = arg_46_0.ships[arg_46_1]:GetInterActionData()

		if var_46_0 then
			var_46_0:Continue(arg_46_0.ships[arg_46_1])
		end
	end

	return
end

function var_0_0.ResetShip(arg_47_0, arg_47_1, arg_47_2)
	if arg_47_0:LegalPosition(arg_47_2, arg_47_1) then
		(function(arg_48_0, arg_48_1)
			arg_48_0:SetPosition(arg_48_1)
			arg_48_0:ChangeState(CourtYardShip.STATE_IDLE)
			arg_47_0:AddItem(arg_48_0)

			return
		end)(arg_47_1, arg_47_2)
	else
		local var_47_0 = arg_47_0:GetRandomPosition(arg_47_1)

		if var_47_0 then
			(function(arg_48_0, arg_48_1)
				arg_48_0:SetPosition(arg_48_1)
				arg_48_0:ChangeState(CourtYardShip.STATE_IDLE)
				arg_47_0:AddItem(arg_48_0)

				return
			end)(arg_47_1, var_47_0)
		else
			arg_47_0:RemoveShip(arg_47_1)
			arg_47_0:GetHost():SendNotification(CourtYardEvent._NO_POS_TO_ADD_SHIP, arg_47_1.id)
		end
	end

	return
end

function var_0_0.SelectFurniture(arg_49_0, arg_49_1)
	if not arg_49_0.canEidt then
		return
	end

	local var_49_0 = arg_49_0.furnitures[arg_49_1]

	if arg_49_0.furnitures[arg_49_1]:GetOpFlag() then
		return
	end

	local var_49_1 = _.detect(_.values(arg_49_0.furnitures), function(arg_50_0)
		return arg_50_0:GetOpFlag()
	end)

	if var_49_1 then
		arg_49_0:UnSelectFurniture(var_49_1.id)
	end

	local var_49_2 = arg_49_0:AreaWithInfo(var_49_0, var_49_0:GetPosition(), var_49_0:GetOffset(), true)

	var_49_0:UpdateOpFlag(true)
	arg_49_0:DispatchEvent(CourtYardEvent.SELETED_ITEM, var_49_0, var_49_2)

	return
end

function var_0_0.ClickFurniture(arg_51_0, arg_51_1)
	if arg_51_0.furnitures[arg_51_1]:HasDescription() then
		arg_51_0:DispatchEvent(CourtYardEvent.SHOW_FURNITURE_DESC, arg_51_0.furnitures[arg_51_1])
	elseif arg_51_0.furnitures[arg_51_1]:CanTouch() then
		if arg_51_0.furnitures[arg_51_1]:GetTouchBg() then
			arg_51_0:CheckFurnitureTouchBG(arg_51_0.furnitures[arg_51_1])
		end

		if not arg_51_0.furnitures[arg_51_1]:IsTouchState() then
			arg_51_0.furnitures[arg_51_1]:ChangeState(CourtYardFurniture.STATE_TOUCH)
			arg_51_0:DispatchEvent(CourtYardEvent.ON_TOUCH_ITEM, arg_51_0.furnitures[arg_51_1])
		else
			arg_51_0.furnitures[arg_51_1]:ChangeState(CourtYardFurniture.STATE_IDLE)
			arg_51_0:DispatchEvent(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, arg_51_0.furnitures[arg_51_1])
		end
	end

	return
end

function var_0_0.CheckFurnitureTouchBG(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in pairs(arg_52_0.furnitures) do
		if iter_52_1.id ~= arg_52_1.id and iter_52_1:IsTouchState() and iter_52_1:GetTouchBg() then
			iter_52_1:ChangeState(CourtYardFurniture.STATE_IDLE)
			arg_52_0:DispatchEvent(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, iter_52_1)
		end
	end

	return
end

function var_0_0.PlayMusicalInstruments(arg_53_0, arg_53_1)
	arg_53_0:MuteAll()
	arg_53_0:DispatchEvent(CourtYardEvent.FURNITURE_PLAY_MUSICALINSTRUMENTS, arg_53_0.furnitures[arg_53_1])

	return
end

function var_0_0.StopPlayMusicalInstruments(arg_54_0, arg_54_1)
	arg_54_0:DispatchEvent(CourtYardEvent.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, arg_54_0.furnitures[arg_54_1])

	return
end

function var_0_0.PlayFurnitureVoice(arg_55_0, arg_55_1)
	local var_55_0 = _.select(arg_55_0.furnitures[arg_55_1].musicDatas, function(arg_56_0)
		return arg_56_0.voiceType == 1
	end)

	if #var_55_0 > 0 then
		local var_55_1 = var_55_0[math.random(1, #var_55_0)]

		arg_55_0:DispatchEvent(CourtYardEvent.ON_ITEM_PLAY_MUSIC, var_55_1.voice, var_55_1.voiceType)
	end

	return
end

function var_0_0.PlayFurnitureBg(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:StopPrevFurnitureVoice()

	if var_57_0 and var_57_0.id == arg_57_0.furnitures[arg_57_1].id then
		return
	end

	arg_57_0.furnitures[arg_57_1]:ChangeState(CourtYardFurniture.STATE_PLAY_MUSIC)

	local var_57_1 = arg_57_0.furnitures[arg_57_1]:GetMusicData()

	if var_57_1 then
		arg_57_0:DispatchEvent(CourtYardEvent.ON_ITEM_PLAY_MUSIC, var_57_1.voice, var_57_1.voiceType)
	end

	return
end

function var_0_0.MuteAll(arg_58_0)
	for iter_58_0, iter_58_1 in pairs(arg_58_0.furnitures) do
		if iter_58_1:GetMusicData() then
			local var_58_0 = iter_58_1:GetMusicData()

			arg_58_0:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_58_0.voice, var_58_0.voiceType)
			iter_58_1:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
		end
	end

	arg_58_0:DispatchEvent(CourtYardEvent.FURNITURE_MUTE_ALL)

	return
end

function var_0_0.StopPrevFurnitureVoice(arg_59_0)
	local var_59_0

	for iter_59_0, iter_59_1 in pairs(arg_59_0.furnitures) do
		local var_59_1 = iter_59_1:GetMusicData()

		if var_59_1 and var_59_1.voiceType == 2 then
			var_59_0 = iter_59_1
		end
	end

	if var_59_0 then
		local var_59_2 = var_59_0:GetMusicData()

		arg_59_0:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_59_2.voice, var_59_2.voiceType)
		var_59_0:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
	end

	return var_59_0
end

function var_0_0.FurnitureAnimtionFinish(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_0.furnitures[arg_60_1]

	if arg_60_2 == CourtYardFurniture.STATE_TOUCH then
		arg_60_0.furnitures[arg_60_1]:ChangeState(CourtYardFurniture.STATE_IDLE)
	elseif arg_60_2 == CourtYardFurniture.STATE_INTERACT then
		_.each(arg_60_0.furnitures[arg_60_1]:GetUsingSlots(), function(arg_61_0)
			arg_61_0:Continue(var_60_0)

			return
		end)
	elseif arg_60_2 == CourtYardFurniture.STATE_TOUCH_PREPARE then
		arg_60_0.furnitures[arg_60_1]:_ChangeState(CourtYardFurniture.STATE_TOUCH)
	end

	return
end

function var_0_0.BeginDragFurniture(arg_62_0, arg_62_1)
	if not arg_62_0.canEidt then
		return
	end

	local var_62_0 = arg_62_0.furnitures[arg_62_1]

	if not arg_62_0.furnitures[arg_62_1]:GetOpFlag() then
		return
	end

	var_62_0:ChangeState(CourtYardFurniture.STATE_DRAG)

	if var_62_0:HasParent() then
		local var_62_1 = var_62_0:GetParent()

		var_62_1:RemoveChild(var_62_0)
		arg_62_0:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, var_62_0, var_62_1)
	else
		arg_62_0:RemoveItem(var_62_0)
		arg_62_0:DispatchEvent(CourtYardEvent.DRAG_ITEM, var_62_0)
	end

	return
end

function var_0_0.DragingFurniture(arg_63_0, arg_63_1, arg_63_2)
	if not arg_63_0.canEidt then
		return
	end

	local var_63_0 = arg_63_0.furnitures[arg_63_1]

	if not arg_63_0.furnitures[arg_63_1]:GetOpFlag() then
		return
	end

	if isa(var_63_0, CourtYardWallFurniture) then
		arg_63_2 = var_63_0:NormalizePosition(arg_63_2, arg_63_0.minSizeX)
	end

	local var_63_1 = arg_63_0:GetParentForItem(var_63_0, arg_63_2)
	local var_63_2 = var_63_1 and var_63_1:RawGetOffset() or var_63_0:GetOffset()
	local var_63_3 = var_63_1 and var_63_1:AreaWithInfo(var_63_0, arg_63_2, var_63_2) or arg_63_0:AreaWithInfo(var_63_0, arg_63_2, var_63_2)

	arg_63_0:DispatchEvent(CourtYardEvent.DRAGING_ITEM, var_63_0, var_63_3, arg_63_2, var_63_2)

	return
end

function var_0_0.GetParentForItem(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = _.select(_.values(arg_64_0.furnitures), function(arg_65_0)
		return isa(arg_65_0, CourtYardCanPutFurniture) and arg_65_0:CanPutChildInPosition(arg_64_1, arg_64_2)
	end)

	table.sort(var_64_0, function(arg_66_0, arg_66_1)
		return (arg_66_0.parent and 1 or 0) > (arg_66_1.parent and 1 or 0)
	end)

	return var_64_0[1]
end

function var_0_0.DragFurnitureEnd(arg_67_0, arg_67_1, arg_67_2)
	if not arg_67_0.canEidt then
		return
	end

	local var_67_0 = arg_67_0.furnitures[arg_67_1]

	if not arg_67_0.furnitures[arg_67_1]:GetOpFlag() then
		return
	end

	var_67_0:ChangeState(CourtYardFurniture.STATE_IDLE)

	if isa(var_67_0, CourtYardWallFurniture) then
		arg_67_2 = var_67_0:NormalizePosition(arg_67_2, arg_67_0.minSizeX)
	end

	local var_67_1 = arg_67_0:VerifyDragPositionForFurniture(var_67_0, arg_67_2)

	if not var_67_1 then
		arg_67_0:RemoveFurniture(arg_67_1)
		arg_67_0:DispatchEvent(CourtYardEvent.REMOVE_ILLEGALITY_ITEM)

		return
	end

	if isa(var_67_0, CourtYardWallFurniture) then
		var_67_0:UpdatePosition(var_67_1)
	else
		var_67_0:SetPosition(var_67_1)
	end

	local var_67_2 = arg_67_0:GetParentForItem(var_67_0, var_67_1)
	local var_67_3

	if var_67_2 then
		arg_67_0:DispatchEvent(CourtYardEvent.CHILD_ITEM, var_67_0, var_67_2)
		var_67_2:AddChild(var_67_0)

		var_67_3 = var_67_2:AreaWithInfo(var_67_0, var_67_1, var_67_2:RawGetOffset(), true)
	else
		arg_67_0:AddItem(var_67_0)

		var_67_3 = arg_67_0:AreaWithInfo(var_67_0, var_67_1, var_67_0:GetOffset(), true)
	end

	arg_67_0:DispatchEvent(CourtYardEvent.DRAG_ITEM_END, var_67_0, var_67_3)

	return
end

function var_0_0.IsLegalAreaForFurniture(arg_68_0, arg_68_1, arg_68_2)
	return _.all(arg_68_1:GetAreaByPosition(arg_68_2), function(arg_69_0)
		return arg_68_0:LegalPosition(arg_69_0, arg_68_1)
	end) or arg_68_0:GetParentForItem(arg_68_1, arg_68_2) ~= nil
end

function var_0_0.VerifyDragPositionForFurniture(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0

	if arg_70_0:IsLegalAreaForFurniture(arg_70_1, arg_70_2) then
		var_70_0 = arg_70_2
	else
		local var_70_1 = arg_70_1:GetPosition()

		if var_70_1 and isa(arg_70_1, CourtYardWallFurniture) then
			arg_70_1:UpdatePosition(var_70_1)
		end

		if var_70_1 and arg_70_0:IsLegalAreaForFurniture(arg_70_1, var_70_1) then
			var_70_0 = var_70_1
		else
			if var_70_1 and isa(arg_70_1, CourtYardWallFurniture) then
				arg_70_1:UpdatePosition(arg_70_2)
			end

			var_70_0 = arg_70_0:GetEmptyArea(arg_70_1)
		end
	end

	return var_70_0
end

function var_0_0.UnSelectFurniture(arg_71_0, arg_71_1)
	if not arg_71_0.furnitures[arg_71_1]:GetOpFlag() then
		return
	end

	arg_71_0.furnitures[arg_71_1]:UpdateOpFlag(false)
	arg_71_0:DispatchEvent(CourtYardEvent.UNSELETED_ITEM, arg_71_0.furnitures[arg_71_1])

	return
end

function var_0_0.RotateFurniture(arg_72_0, arg_72_1)
	if arg_72_0.furnitures[arg_72_1]:DisableRotation() then
		arg_72_0:DispatchEvent(CourtYardEvent.DISABLE_ROTATE_ITEM)
	elseif not arg_72_0:CanRotateItem(arg_72_0.furnitures[arg_72_1]) then
		arg_72_0:DispatchEvent(CourtYardEvent.ROTATE_ITEM_FAILED)
	else
		local var_72_0 = arg_72_0.furnitures[arg_72_1]:HasParent()

		if not var_72_0 then
			arg_72_0:RemoveItem(arg_72_0.furnitures[arg_72_1])
		end

		arg_72_0.furnitures[arg_72_1]:Rotate()

		if not var_72_0 then
			arg_72_0:AddItem(arg_72_0.furnitures[arg_72_1])
		end

		arg_72_0:DispatchEvent(CourtYardEvent.ROTATE_ITEM, arg_72_0.furnitures[arg_72_1], (arg_72_0:AreaWithInfo(arg_72_0.furnitures[arg_72_1], arg_72_0.furnitures[arg_72_1]:GetPosition(), arg_72_0.furnitures[arg_72_1]:GetOffset())))
	end

	return
end

function var_0_0.RemoveFurniture(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0.furnitures[arg_73_1]:HasParent()

	if var_73_0 then
		arg_73_0.furnitures[arg_73_1]:GetParent():RemoveChild(arg_73_0.furnitures[arg_73_1])
	end

	local var_73_1 = arg_73_0.furnitures[arg_73_1].childs or {}

	for iter_73_0 = #var_73_1, 1, -1 do
		arg_73_0:RemoveFurniture(var_73_1[iter_73_0].id)
	end

	if not var_73_0 then
		arg_73_0:RemoveItem(arg_73_0.furnitures[arg_73_1])
	end

	local var_73_2 = arg_73_0.furnitures[arg_73_1]:GetMusicData()

	if var_73_2 then
		arg_73_0:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_73_2.voice, var_73_2.voiceType)
		arg_73_0.furnitures[arg_73_1]:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
	end

	arg_73_0:UnSelectFurniture(arg_73_1)
	arg_73_0.furnitures[arg_73_1]:Dispose()

	arg_73_0.furnitures[arg_73_1] = nil

	arg_73_0:DispatchEvent(CourtYardEvent.DETORY_ITEM, arg_73_0.furnitures[arg_73_1])
	arg_73_0.composeChecker:Check()
	arg_73_0:RefreshCombineFruniture(arg_73_0.furnitures[arg_73_1].configId)

	return
end

function var_0_0.RemoveAllFurniture(arg_74_0)
	for iter_74_0, iter_74_1 in pairs(arg_74_0.furnitures) do
		if not iter_74_1:HasParent() then
			arg_74_0:RemoveFurniture(iter_74_1.id)
		end
	end

	arg_74_0:SetWallPaper(nil)
	arg_74_0:SetFloorPaper(nil)

	return
end

function var_0_0.RemovePaper(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0:GetWallPaper()

	if var_75_0 and var_75_0.id == arg_75_1 then
		arg_75_0:SetWallPaper(nil)
	end

	local var_75_1 = arg_75_0:GetFloorPaper()

	if var_75_1 and var_75_1.id == arg_75_1 then
		arg_75_0:SetFloorPaper(nil)
	end

	return
end

function var_0_0.CheckFurnitureState(arg_76_0)
	for iter_76_0, iter_76_1 in pairs(arg_76_0.furnitures) do
		if iter_76_1:IsType(Furniture.TYPE_MOVEABLE) and iter_76_1:IsReadyMove() then
			arg_76_0:ReadyMoveFurniture(iter_76_1.id)
		end
	end

	return
end

function var_0_0.ReadyMoveFurniture(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_0:GetNextPositionForMove(arg_77_0.furnitures[arg_77_1])

	if not var_77_0 then
		arg_77_0.furnitures[arg_77_1]:Rest()

		return
	end

	local var_77_1 = arg_77_0.furnitures[arg_77_1]:IsDifferentDirection(var_77_0) and arg_77_0:CanRotateItem(arg_77_0.furnitures[arg_77_1])

	if var_77_1 then
		arg_77_0:RotateFurniture(arg_77_1)
	end

	arg_77_0.furnitures[arg_77_1]:Move(var_77_0)
	arg_77_0:RemoveItem(arg_77_0.furnitures[arg_77_1])
	arg_77_0.furnitures[arg_77_1]:SetPosition(var_77_0)
	arg_77_0:AddItemAndRefresh(arg_77_0.furnitures[arg_77_1])

	return
end

function var_0_0.GetFurnituresByType(arg_78_0, arg_78_1)
	for iter_78_0, iter_78_1 in pairs(arg_78_0.furnitures) do
		if iter_78_1:IsType(arg_78_1) then
			table.insert({}, iter_78_1)
		end
	end

	return {}
end

function var_0_0.EnterEditMode(arg_79_0)
	arg_79_0.canEidt = true

	for iter_79_0, iter_79_1 in pairs(arg_79_0.ships) do
		if iter_79_1:GetState() == CourtYardShip.STATE_DRAG then
			arg_79_0:DragShipEnd(iter_79_1.id, Vector2(-1, -1))
		end

		arg_79_0:GetPlaceableArea(iter_79_1):_ClearLockPosition(iter_79_1)

		if iter_79_1:HasParent() then
			local var_79_0 = iter_79_1:GetParent()

			var_79_0:RemoveChild(iter_79_1)
			arg_79_0:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, iter_79_1, var_79_0)
		else
			arg_79_0:RemoveItem(iter_79_1)
		end

		iter_79_1:ChangeState(CourtYardShip.STATE_STOP)
	end

	for iter_79_2, iter_79_3 in pairs(arg_79_0.furnitures) do
		if iter_79_3:IsType(Furniture.TYPE_TRANSPORT) and iter_79_3:IsUsing() then
			iter_79_3:Stop()
		end

		if iter_79_3:IsType(Furniture.TYPE_FOLLOWER) and iter_79_3:IsUsing() then
			iter_79_3:Stop()
		end

		if iter_79_3:IsType(Furniture.TYPE_MOVEABLE) and iter_79_3:IsMoving() then
			iter_79_3:Stop()
		end

		if iter_79_3:IsTouchState() then
			arg_79_0:ClickFurniture(iter_79_3.id)
		end
	end

	arg_79_0.recoder:BeginCheckChange()
	arg_79_0:DispatchEvent(CourtYardEvent.ENTER_EDIT_MODE)

	return
end

function var_0_0.ExitEditMode(arg_80_0)
	for iter_80_0, iter_80_1 in pairs(arg_80_0.ships) do
		if iter_80_1:ShouldResetPosition() then
			arg_80_0:ResetShip(iter_80_1, (iter_80_1:GetPosition()))
		end
	end

	for iter_80_2, iter_80_3 in pairs(arg_80_0.furnitures) do
		if iter_80_3:IsType(Furniture.TYPE_MOVEABLE) and iter_80_3:IsStop() then
			iter_80_3:ReStart()

			if iter_80_3:CanTouch() then
				arg_80_0:ClickFurniture(iter_80_3.id)
			end
		end
	end

	local var_80_0 = _.detect(_.values(arg_80_0.furnitures), function(arg_81_0)
		return arg_81_0:GetOpFlag()
	end)

	if var_80_0 then
		arg_80_0:UnSelectFurniture(var_80_0.id)
	end

	arg_80_0.canEidt = false

	arg_80_0.recoder:EndCheckChange()
	arg_80_0:DispatchEvent(CourtYardEvent.EXIT_EDIT_MODE)

	return
end

function var_0_0.InEidtMode(arg_82_0)
	return arg_82_0.canEidt
end

function var_0_0.StopAllDragState(arg_83_0)
	if not arg_83_0:InEidtMode() then
		(function()
			for iter_84_0, iter_84_1 in pairs(arg_83_0.ships) do
				if iter_84_1:GetState() == CourtYardShip.STATE_DRAG then
					arg_83_0:DragShipEnd(iter_84_1.id, Vector2(-1, -1))
				end
			end

			return
		end)()
	else
		(function()
			for iter_85_0, iter_85_1 in pairs(arg_83_0.furnitures) do
				if iter_85_1:IsDragingState() then
					arg_83_0:DragFurnitureEnd(iter_85_1.id, Vector2(-1, -1))
					arg_83_0:UnSelectFurniture(iter_85_1.id)
				end
			end

			return
		end)()
	end

	return
end

function var_0_0.StartInteraction(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_1:GetOwner()

	if isa(var_86_0, CourtYardFurniture) and var_86_0:GetInterActionBgm() then
		for iter_86_0, iter_86_1 in pairs(arg_86_0.furnitures) do
			if iter_86_1:IsPlayMusicState() then
				iter_86_1:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
			end
		end
	end

	arg_86_0:DispatchEvent(CourtYardEvent.ITEM_INTERACTION, arg_86_1:GetUser(), var_86_0, arg_86_1)

	return
end

function var_0_0.WillClearInteraction(arg_87_0, arg_87_1, arg_87_2)
	arg_87_0:DispatchEvent(CourtYardEvent.CLEAR_ITEM_INTERACTION, arg_87_1:GetUser(), arg_87_1:GetOwner(), arg_87_1)

	return
end

function var_0_0.ClearInteraction(arg_88_0, arg_88_1, arg_88_2)
	local var_88_0 = arg_88_1:GetUser()
	local var_88_1 = arg_88_1:GetOwner()

	if isa(var_88_0, CourtYardFollowerFurniture) then
		arg_88_0:ClearInteractionForFollower(var_88_0, var_88_1, arg_88_1, arg_88_2)
	elseif not arg_88_2 then
		if isa(var_88_1, CourtYardTransportFurniture) then
			arg_88_0:ClearInteractionForTransPort(var_88_0, var_88_1, arg_88_1)
		else
			arg_88_0:ResetShip(var_88_0, var_88_0:GetPosition())
		end
	end

	return
end

function var_0_0.ClearInteractionForFollower(arg_89_0, arg_89_1, arg_89_2, arg_89_3, arg_89_4)
	local var_89_0 = arg_89_0:GetAroundEmptyArea(arg_89_1, arg_89_2:GetPosition())

	if not var_89_0 then
		arg_89_0:DispatchEvent(CourtYardEvent.REMOVE_ILLEGALITY_ITEM)
		arg_89_0:RemoveFurniture(arg_89_1.id)

		return
	end

	arg_89_1:SetPosition(var_89_0)
	arg_89_0:AddItemAndRefresh(arg_89_1)

	return
end

function var_0_0.ClearInteractionForTransPort(arg_90_0, arg_90_1, arg_90_2, arg_90_3)
	if arg_90_3:IsFirstTime() then
		local var_90_0 = _.select(arg_90_0:GetFurnituresByType(Furniture.TYPE_TRANSPORT), function(arg_91_0)
			return arg_91_0.id ~= arg_90_2.id
		end)
		local var_90_1 = math.random(1, #var_90_0)

		if var_90_0[var_90_1] and var_90_0[var_90_1]:CanInterAction(arg_90_1) then
			var_90_0[var_90_1]:GetInteractionSlot():Link(var_90_0[var_90_1], arg_90_1, arg_90_0)
		else
			arg_90_0:ResetShip(arg_90_1, arg_90_0:GetRandomPosition(arg_90_1))
		end
	else
		arg_90_0:ResetShip(arg_90_1, arg_90_0:GetAroundEmptyPosition(arg_90_2))
	end

	return
end

function var_0_0.LegalPosition(arg_92_0, arg_92_1, arg_92_2)
	return var_0_0.super.LegalPosition(arg_92_0, arg_92_1, arg_92_2) and arg_92_2:InActivityRange(arg_92_1)
end

function var_0_0.GetLevel(arg_93_0)
	return arg_93_0.level
end

function var_0_0.Dispose(arg_94_0)
	var_0_0.super.Dispose(arg_94_0)
	arg_94_0.recoder:Dispose()

	arg_94_0.recoder = nil

	arg_94_0.composeChecker:Dispose()

	arg_94_0.composeChecker = nil

	for iter_94_0, iter_94_1 in pairs(arg_94_0.ships) do
		iter_94_1:Dispose()
	end

	for iter_94_2, iter_94_3 in pairs(arg_94_0.furnitures) do
		iter_94_3:Dispose()
	end

	arg_94_0.ships = nil
	arg_94_0.furnitures = nil

	return
end

function var_0_0.GetDirty(arg_95_0)
	return arg_95_0.recoder:TakeSample()
end

function var_0_0.ToTable(arg_96_0)
	local var_96_0 = {}

	for iter_96_0, iter_96_1 in pairs(arg_96_0.furnitures) do
		(function(arg_97_0)
			arg_97_0.floor = arg_96_0.id
			var_96_0[arg_97_0.id] = arg_97_0

			return
		end)(iter_96_1:ToTable())
	end

	if arg_96_0.wallPaper then
		(function(arg_97_0)
			arg_97_0.floor = arg_96_0.id
			var_96_0[arg_97_0.id] = arg_97_0

			return
		end)(arg_96_0.wallPaper:ToTable())
	end

	if arg_96_0.floorPaper then
		(function(arg_97_0)
			arg_97_0.floor = arg_96_0.id
			var_96_0[arg_97_0.id] = arg_97_0

			return
		end)(arg_96_0.floorPaper:ToTable())
	end

	return {}
end

return var_0_0
