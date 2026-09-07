local CourtYardStorey = class("CourtYardStorey", import("..map.CourtYardPlaceableArea"))

function CourtYardStorey:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	CourtYardStorey.super.Ctor(self, arg_1_1, arg_1_4)

	self.id = arg_1_2
	self.style = arg_1_3
	self.level = 1
	self.furnitures = {}
	self.ships = {}
	self.canEidt = false
	self.recoder = CourtYardStoreyRecorder.New(self)
	self.composeChecker = CourtYardStoreyComposeChecker.New(self)

	return
end

function CourtYardStorey:GetStyle()
	return self.style
end

function CourtYardStorey:SetLevel(arg_3_1)
	self.level = arg_3_1

	self:UpdateMinRange(Vector2(CourtYardConst.MAX_STOREY_LEVEL * CourtYardConst.OPEN_AREA_PRE_LEVEL - (self.level - 1) * CourtYardConst.OPEN_AREA_PRE_LEVEL, CourtYardConst.MAX_STOREY_LEVEL * CourtYardConst.OPEN_AREA_PRE_LEVEL - (self.level - 1) * CourtYardConst.OPEN_AREA_PRE_LEVEL))
	self:DispatchEvent(CourtYardEvent.UPDATE_STOREY, arg_3_1)

	return
end

function CourtYardStorey:LevelUp()
	self:SetLevel(self.level + 1)
	self:DispatchEvent(CourtYardEvent.UPDATE_FLOORPAPER, self.floorPaper)
	self:DispatchEvent(CourtYardEvent.UPDATE_WALLPAPER, self.wallPaper)

	return
end

function CourtYardStorey:SetWallPaper(arg_5_1)
	self.wallPaper = arg_5_1

	self:DispatchEvent(CourtYardEvent.UPDATE_WALLPAPER, arg_5_1)
	self.composeChecker:Check()

	return
end

function CourtYardStorey:SetFloorPaper(arg_6_1)
	self.floorPaper = arg_6_1

	self:DispatchEvent(CourtYardEvent.UPDATE_FLOORPAPER, arg_6_1)
	self.composeChecker:Check()

	return
end

function CourtYardStorey:GetWallPaper()
	return self.wallPaper
end

function CourtYardStorey:GetFloorPaper()
	return self.floorPaper
end

function CourtYardStorey:GetFurnitures()
	return self.furnitures
end

function CourtYardStorey:GetAllFurniture()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self.furnitures) do
		var_10_0[iter_10_1.id] = iter_10_1
	end

	if self.floorPaper then
		var_10_0[self.floorPaper.id] = self.floorPaper
	end

	if self.wallPaper then
		var_10_0[self.wallPaper.id] = self.wallPaper
	end

	return var_10_0
end

function CourtYardStorey:GetShips()
	return self.ships
end

function CourtYardStorey:GetShip(arg_12_1)
	return self.ships[arg_12_1]
end

function CourtYardStorey:GetFurniture(arg_13_1)
	return self.furnitures[arg_13_1]
end

function CourtYardStorey:CanAddFurniture(arg_14_1)
	return true
end

function CourtYardStorey:AddFurniture(arg_15_1, arg_15_2)
	self.furnitures[arg_15_1.id] = arg_15_1

	self:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_15_1, arg_15_2)
	self:AddItem(arg_15_1)
	self.composeChecker:Check()

	if arg_15_1:CanTouch() and arg_15_1:TriggerTouchDefault() then
		self:ClickFurniture(arg_15_1.id)
	end

	if not arg_15_2 then
		self:RefreshCombineFruniture(arg_15_1.configId)
	end

	return
end

function CourtYardStorey:RefreshCombineFruniture(arg_16_1)
	local var_16_0 = {
		arg_16_1
	}

	if type(pg.furniture_data_template[arg_16_1].spine_combine_action_replace) == "table" then
		for iter_16_0, iter_16_1 in pairs(pg.furniture_data_template[arg_16_1].spine_combine_action_replace) do
			for iter_16_2, iter_16_3 in ipairs(iter_16_1[1]) do
				table.insert(var_16_0, iter_16_3)
			end
		end
	end

	for iter_16_4, iter_16_5 in pairs(self.furnitures) do
		if table.contains(var_16_0, iter_16_5.configId) then
			iter_16_5:RefreshState()
		end
	end

	return
end

function CourtYardStorey:AddPaper(arg_17_1)
	local var_17_0 = arg_17_1:GetType()

	if var_17_0 == Furniture.TYPE_WALLPAPER then
		self:SetWallPaper(arg_17_1)
	elseif var_17_0 == Furniture.TYPE_FLOORPAPER then
		self:SetFloorPaper(arg_17_1)
	end

	return
end

function CourtYardStorey:AddChildFurniture(arg_18_1, arg_18_2)
	self.furnitures[arg_18_1.id] = arg_18_1

	self:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_18_1)
	self:DispatchEvent(CourtYardEvent.CHILD_ITEM, arg_18_1, self.furnitures[arg_18_2])
	self.furnitures[arg_18_2]:AddChild(arg_18_1)

	return
end

function CourtYardStorey:Update()
	self:CheckShipState()
	self:CheckFurnitureState()

	return
end

function CourtYardStorey:AddShip(arg_20_1)
	arg_20_1:ChangeState(CourtYardShip.STATE_IDLE)

	self.ships[arg_20_1.id] = arg_20_1

	self:DispatchEvent(CourtYardEvent.CREATE_ITEM, arg_20_1)
	self:AddItem(arg_20_1)

	return
end

function CourtYardStorey:GetPlaceableArea(arg_21_1)
	return (arg_21_1:HasParent() or nil) and (arg_21_1:GetParent():GetPlaceableArea() or self)
end

function CourtYardStorey:RemoveShip(arg_22_1)
	self:GetPlaceableArea(arg_22_1):RemoveItem(arg_22_1)
	self.ships[arg_22_1.id]:Dispose()

	self.ships[arg_22_1.id] = nil

	self:DispatchEvent(CourtYardEvent.DETORY_ITEM, arg_22_1)

	if self.ships[arg_22_1.id + CourtYardConst.DOUBLE_SKIN_ADD] then
		self:RemoveShip(self.ships[arg_22_1.id + CourtYardConst.DOUBLE_SKIN_ADD])
	end

	return
end

function CourtYardStorey:ExitShip(arg_23_1)
	if self.ships[arg_23_1] then
		self:RemoveShip(self.ships[arg_23_1])
	end

	return
end

function CourtYardStorey:CheckShipState()
	for iter_24_0, iter_24_1 in pairs(self:GetShips()) do
		local var_24_0 = iter_24_1:GetState()

		if var_24_0 == CourtYardShip.STATE_MOVE then
			self:ReadyMoveShip(iter_24_1.id)
		elseif var_24_0 == CourtYardShip.STATE_MOVING_HALF then
			self:MoveShipToNextPosition(iter_24_1.id)
		end
	end

	return
end

function CourtYardStorey:ReadyMoveShip(arg_25_1)
	local var_25_0 = false
	local var_25_1 = false
	local var_25_2 = false

	if CourtYardCalcUtil.HalfProbability() then
		if self.ships[arg_25_1]:HasParent() then
			if self.ships[arg_25_1]:GetParent():IsType(Furniture.TYPE_ARCH) then
				var_25_0 = self:ShipExitArch(self.ships[arg_25_1])

				goto label_25_0
			end
		end

		var_25_1 = self:ShipEnterArch(self.ships[arg_25_1])

		if not var_25_1 then
			var_25_2 = self:ShipAddFollower(self.ships[arg_25_1])
		end
	end

	::label_25_0::

	if not var_25_0 and not var_25_1 and not var_25_2 then
		self:RandomNextShipPosition(arg_25_1)
	end

	return
end

function CourtYardStorey:ShipAddFollower(arg_26_1)
	local var_26_0 = self:GetFurnituresByType(Furniture.TYPE_FOLLOWER)

	local function var_26_1(arg_27_0)
		return _.detect(var_26_0, function(arg_28_0)
			return _.any(arg_28_0:GetArea(), function(arg_29_0)
				return arg_29_0 == arg_27_0
			end)
		end)
	end

	local function var_26_2()
		local var_30_0 = arg_26_1:GetInterActionData()

		if var_30_0 ~= nil then
			var_30_0:Stop()
		end

		return
	end

	for iter_26_0, iter_26_1 in ipairs(arg_26_1:GetAroundPositions()) do
		local var_26_3 = var_26_1(iter_26_1)

		if var_26_3 and var_26_3:CanFollower(arg_26_1) then
			var_26_2()
			self:RemoveItemAndRefresh(var_26_3)
			var_26_3:GetInteractionSlot():Occupy(var_26_3, arg_26_1, self)

			return true
		end
	end

	return false
end

function CourtYardStorey:ShipExitArch(arg_31_1)
	local var_31_0 = self:GetNextPositionForMove(arg_31_1)

	if var_31_0 then
		local var_31_1 = arg_31_1:GetParent()

		var_31_1:RemoveChild(arg_31_1)
		self:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, arg_31_1, var_31_1)
		self:DispatchEvent(CourtYardEvent.EXIT_ARCH, arg_31_1, var_31_1)
		self:LockPosition(var_31_0)
		arg_31_1:UnClear(true)
		arg_31_1:Move(var_31_0)

		return true
	end

	return false
end

function CourtYardStorey:ShipEnterArch(arg_32_1)
	local function var_32_0(arg_33_0, arg_33_1)
		self:RemoveItem(arg_32_1)
		self:DispatchEvent(CourtYardEvent.CHILD_ITEM, arg_32_1, arg_33_0)
		self:DispatchEvent(CourtYardEvent.ENTER_ARCH, arg_32_1, arg_33_0)
		arg_33_0:AddChild(arg_32_1)
		arg_32_1:Move(arg_33_1)

		return
	end

	for iter_32_0, iter_32_1 in ipairs(arg_32_1:GetAroundPositions()) do
		local var_32_1 = self:GetParentForItem(arg_32_1, iter_32_1)

		if var_32_1 and var_32_1:IsType(Furniture.TYPE_ARCH) then
			var_32_0(var_32_1, iter_32_1)

			return true
		end
	end

	return false
end

function CourtYardStorey:RandomNextShipPosition(arg_34_1)
	local var_34_0 = self:GetPlaceableArea(self.ships[arg_34_1])
	local var_34_1 = var_34_0:GetNextPositionForMove(self.ships[arg_34_1])

	if not var_34_1 then
		self.ships[arg_34_1]:ChangeState(CourtYardShip.STATE_IDLE)

		return
	end

	var_34_0:LockPosition(var_34_1)
	self.ships[arg_34_1]:Move(var_34_1)

	return
end

function CourtYardStorey:MoveShipToNextPosition(arg_35_1)
	local var_35_0 = self.ships[arg_35_1]
	local var_35_1 = self:GetPlaceableArea(self.ships[arg_35_1])
	local var_35_2 = self.ships[arg_35_1]:GetMarkPosition()

	var_35_1:_ClearLockPosition(self.ships[arg_35_1])

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

function CourtYardStorey:DragShip(arg_36_1)
	local var_36_0 = self.ships[arg_36_1]

	self:GetPlaceableArea(self.ships[arg_36_1]):_ClearLockPosition(self.ships[arg_36_1])

	local var_36_1 = var_36_0:GetPosition()
	local var_36_2 = var_36_0:GetInterActionData()

	if var_36_2 ~= nil or var_36_0:GetState() == CourtYardShip.STATE_INTERACT then
		if isa(var_36_2, CourtYardFollowerSlot) then
			self:RemoveItem(var_36_0)
		end

		var_36_2:Stop()
	elseif var_36_0:HasParent() then
		local var_36_3 = var_36_0:GetParent()

		var_36_3:RemoveChild(var_36_0)
		var_36_0:ChangeState(CourtYardShip.STATE_IDLE)
		self:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, var_36_0, var_36_3)
	else
		self:RemoveItem(var_36_0)
	end

	var_36_0:ChangeState(CourtYardShip.STATE_DRAG)
	var_36_0:UpdateOpFlag(true)
	self:DispatchEvent(CourtYardEvent.SELETED_ITEM, var_36_0, (self:AreaWithInfo(var_36_0, var_36_1, var_36_0:GetOffset())))
	self:DispatchEvent(CourtYardEvent.DRAG_ITEM, var_36_0)

	return
end

function CourtYardStorey:DragingShip(arg_37_1, arg_37_2)
	local var_37_0 = self.ships[arg_37_1]

	if not self.ships[arg_37_1]:GetOpFlag() then
		return
	end

	local var_37_1 = self:GetParentForItem(var_37_0, arg_37_2)
	local var_37_2 = var_37_1 and var_37_1:RawGetOffset() or var_37_0:GetOffset()

	self:DispatchEvent(CourtYardEvent.DRAGING_ITEM, var_37_0, self:AreaWithInfo(var_37_0, arg_37_2, var_37_2, self:GetInterActionFurniture(var_37_0, arg_37_2) or var_37_1), arg_37_2, var_37_2)

	return
end

function CourtYardStorey:DragShipEnd(arg_38_1, arg_38_2)
	local var_38_0 = self.ships[arg_38_1]

	if not self.ships[arg_38_1]:GetOpFlag() then
		return
	end

	local var_38_1 = self:LegalPosition(arg_38_2, var_38_0)
	local var_38_2 = self:GetInterActionFurniture(var_38_0, arg_38_2)
	local var_38_3 = self:GetParentForItem(var_38_0, arg_38_2)
	local var_38_4

	if not var_38_1 and var_38_2 then
		if isa(var_38_2, CourtYardFollowerFurniture) then
			self:RemoveItemAndRefresh(var_38_2)
			self:ResetShip(var_38_0, arg_38_2)
			var_38_0:ChangeState(CourtYardShip.STATE_MOVE)
		end

		var_38_2:GetInteractionSlot():Occupy(var_38_2, var_38_0, self)
	elseif not var_38_1 and var_38_3 then
		var_38_0:SetPosition(arg_38_2)
		self:DispatchEvent(CourtYardEvent.CHILD_ITEM, var_38_0, var_38_3)
		var_38_3:AddChild(var_38_0)
		var_38_0:ChangeState(CourtYardShip.STATE_IDLE)

		var_38_4 = var_38_3:AreaWithInfo(var_38_0, arg_38_2, var_38_3:RawGetOffset(), true)
	else
		local var_38_5 = var_38_1 and arg_38_2 or var_38_0:GetPosition()

		self:ResetShip(var_38_0, var_38_5)

		var_38_4 = self:AreaWithInfo(var_38_0, var_38_5, var_38_0:GetOffset(), true)
	end

	var_38_0:UpdateOpFlag(false)
	self:DispatchEvent(CourtYardEvent.DRAG_ITEM_END, var_38_4)
	self:DispatchEvent(CourtYardEvent.UNSELETED_ITEM, var_38_0)

	return
end

function CourtYardStorey:GetInterActionFurniture(arg_39_1, arg_39_2)
	for iter_39_0, iter_39_1 in pairs(self.furnitures) do
		if iter_39_1:CanInterAction(arg_39_1) and iter_39_1:IsOverlap(arg_39_2) then
			return iter_39_1
		end
	end

	return nil
end

function CourtYardStorey:TouchShip(arg_40_1)
	self:GetPlaceableArea(self.ships[arg_40_1]):_ClearLockPosition(self.ships[arg_40_1])
	self.ships[arg_40_1]:ChangeState(CourtYardShip.STATE_TOUCH)

	return
end

function CourtYardStorey:UpdateShipIntimacy(arg_41_1, arg_41_2)
	if not self.ships[arg_41_1] then
		return
	end

	self.ships[arg_41_1]:ChangeInimacy(arg_41_2)

	return
end

function CourtYardStorey:UpdateShipCoin(arg_42_1, arg_42_2)
	if not self.ships[arg_42_1] then
		return
	end

	self.ships[arg_42_1]:ChangeCoin(arg_42_2)

	return
end

function CourtYardStorey:ClearShipIntimacy(arg_43_1, arg_43_2)
	if not self.ships[arg_43_1] then
		return
	end

	self:GetPlaceableArea(self.ships[arg_43_1]):_ClearLockPosition(self.ships[arg_43_1])
	self.ships[arg_43_1]:ClearInimacy(arg_43_2)

	return
end

function CourtYardStorey:ClearShipCoin(arg_44_1)
	if not self.ships[arg_44_1] then
		return
	end

	self:GetPlaceableArea(self.ships[arg_44_1]):_ClearLockPosition(self.ships[arg_44_1])
	self.ships[arg_44_1]:ClearCoin(value)

	return
end

function CourtYardStorey:AddShipExp(arg_45_1, arg_45_2)
	if not self.ships[arg_45_1] then
		return
	end

	self.ships[arg_45_1]:AddExp(arg_45_2)

	return
end

function CourtYardStorey:ShipAnimtionFinish(arg_46_1, arg_46_2)
	if arg_46_2 == CourtYardShip.STATE_TOUCH or arg_46_2 == CourtYardShip.STATE_GETAWARD then
		self.ships[arg_46_1]:ChangeState(CourtYardShip.STATE_IDLE)
	elseif arg_46_2 == CourtYardShip.STATE_INTERACT then
		local var_46_0 = self.ships[arg_46_1]:GetInterActionData()

		if var_46_0 then
			var_46_0:Continue(self.ships[arg_46_1])
		end
	end

	return
end

function CourtYardStorey:ResetShip(arg_47_1, arg_47_2)
	local function var_47_0(arg_48_0, arg_48_1)
		arg_48_0:SetPosition(arg_48_1)
		arg_48_0:ChangeState(CourtYardShip.STATE_IDLE)
		self:AddItem(arg_48_0)

		return
	end

	if self:LegalPosition(arg_47_2, arg_47_1) then
		var_47_0(arg_47_1, arg_47_2)
	else
		local var_47_1 = self:GetRandomPosition(arg_47_1)

		if var_47_1 then
			var_47_0(arg_47_1, var_47_1)
		else
			self:RemoveShip(arg_47_1)
			self:GetHost():SendNotification(CourtYardEvent._NO_POS_TO_ADD_SHIP, arg_47_1.id)
		end
	end

	return
end

function CourtYardStorey:SelectFurniture(arg_49_1)
	if not self.canEidt then
		return
	end

	local var_49_0 = self.furnitures[arg_49_1]

	if self.furnitures[arg_49_1]:GetOpFlag() then
		return
	end

	local var_49_1 = _.detect(_.values(self.furnitures), function(arg_50_0)
		return arg_50_0:GetOpFlag()
	end)

	if var_49_1 then
		self:UnSelectFurniture(var_49_1.id)
	end

	local var_49_2 = self:AreaWithInfo(var_49_0, var_49_0:GetPosition(), var_49_0:GetOffset(), true)

	var_49_0:UpdateOpFlag(true)
	self:DispatchEvent(CourtYardEvent.SELETED_ITEM, var_49_0, var_49_2)

	return
end

function CourtYardStorey:ClickFurniture(arg_51_1)
	if self.furnitures[arg_51_1]:HasDescription() then
		self:DispatchEvent(CourtYardEvent.SHOW_FURNITURE_DESC, self.furnitures[arg_51_1])
	elseif self.furnitures[arg_51_1]:CanTouch() then
		if self.furnitures[arg_51_1]:GetTouchBg() then
			self:CheckFurnitureTouchBG(self.furnitures[arg_51_1])
		end

		if not self.furnitures[arg_51_1]:IsTouchState() then
			self.furnitures[arg_51_1]:ChangeState(CourtYardFurniture.STATE_TOUCH)
			self:DispatchEvent(CourtYardEvent.ON_TOUCH_ITEM, self.furnitures[arg_51_1])
		else
			self.furnitures[arg_51_1]:ChangeState(CourtYardFurniture.STATE_IDLE)
			self:DispatchEvent(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, self.furnitures[arg_51_1])
		end
	end

	return
end

function CourtYardStorey:CheckFurnitureTouchBG(arg_52_1)
	for iter_52_0, iter_52_1 in pairs(self.furnitures) do
		if iter_52_1.id ~= arg_52_1.id and iter_52_1:IsTouchState() and iter_52_1:GetTouchBg() then
			iter_52_1:ChangeState(CourtYardFurniture.STATE_IDLE)
			self:DispatchEvent(CourtYardEvent.ON_CANCEL_TOUCH_ITEM, iter_52_1)
		end
	end

	return
end

function CourtYardStorey:PlayMusicalInstruments(arg_53_1)
	self:MuteAll()
	self:DispatchEvent(CourtYardEvent.FURNITURE_PLAY_MUSICALINSTRUMENTS, self.furnitures[arg_53_1])

	return
end

function CourtYardStorey:StopPlayMusicalInstruments(arg_54_1)
	self:DispatchEvent(CourtYardEvent.FURNITURE_STOP_PLAY_MUSICALINSTRUMENTS, self.furnitures[arg_54_1])

	return
end

function CourtYardStorey:PlayFurnitureVoice(arg_55_1)
	local var_55_0 = _.select(self.furnitures[arg_55_1].musicDatas, function(arg_56_0)
		return arg_56_0.voiceType == 1
	end)

	if #var_55_0 > 0 then
		local var_55_1 = var_55_0[math.random(1, #var_55_0)]

		self:DispatchEvent(CourtYardEvent.ON_ITEM_PLAY_MUSIC, var_55_1.voice, var_55_1.voiceType)
	end

	return
end

function CourtYardStorey:PlayFurnitureBg(arg_57_1)
	local var_57_0 = self:StopPrevFurnitureVoice()

	if var_57_0 and var_57_0.id == self.furnitures[arg_57_1].id then
		return
	end

	self.furnitures[arg_57_1]:ChangeState(CourtYardFurniture.STATE_PLAY_MUSIC)

	local var_57_1 = self.furnitures[arg_57_1]:GetMusicData()

	if var_57_1 then
		self:DispatchEvent(CourtYardEvent.ON_ITEM_PLAY_MUSIC, var_57_1.voice, var_57_1.voiceType)
	end

	return
end

function CourtYardStorey:MuteAll()
	for iter_58_0, iter_58_1 in pairs(self.furnitures) do
		if iter_58_1:GetMusicData() then
			local var_58_0 = iter_58_1:GetMusicData()

			self:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_58_0.voice, var_58_0.voiceType)
			iter_58_1:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
		end
	end

	self:DispatchEvent(CourtYardEvent.FURNITURE_MUTE_ALL)

	return
end

function CourtYardStorey:StopPrevFurnitureVoice()
	local var_59_0

	for iter_59_0, iter_59_1 in pairs(self.furnitures) do
		local var_59_1 = iter_59_1:GetMusicData()

		if var_59_1 and var_59_1.voiceType == 2 then
			var_59_0 = iter_59_1
		end
	end

	if var_59_0 then
		local var_59_2 = var_59_0:GetMusicData()

		self:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_59_2.voice, var_59_2.voiceType)
		var_59_0:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
	end

	return var_59_0
end

function CourtYardStorey:FurnitureAnimtionFinish(arg_60_1, arg_60_2)
	local var_60_0 = self.furnitures[arg_60_1]

	if arg_60_2 == CourtYardFurniture.STATE_TOUCH then
		self.furnitures[arg_60_1]:ChangeState(CourtYardFurniture.STATE_IDLE)
	elseif arg_60_2 == CourtYardFurniture.STATE_INTERACT then
		_.each(self.furnitures[arg_60_1]:GetUsingSlots(), function(arg_61_0)
			arg_61_0:Continue(var_60_0)

			return
		end)
	elseif arg_60_2 == CourtYardFurniture.STATE_TOUCH_PREPARE then
		self.furnitures[arg_60_1]:_ChangeState(CourtYardFurniture.STATE_TOUCH)
	end

	return
end

function CourtYardStorey:BeginDragFurniture(arg_62_1)
	if not self.canEidt then
		return
	end

	local var_62_0 = self.furnitures[arg_62_1]

	if not self.furnitures[arg_62_1]:GetOpFlag() then
		return
	end

	var_62_0:ChangeState(CourtYardFurniture.STATE_DRAG)

	if var_62_0:HasParent() then
		local var_62_1 = var_62_0:GetParent()

		var_62_1:RemoveChild(var_62_0)
		self:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, var_62_0, var_62_1)
	else
		self:RemoveItem(var_62_0)
		self:DispatchEvent(CourtYardEvent.DRAG_ITEM, var_62_0)
	end

	return
end

function CourtYardStorey:DragingFurniture(arg_63_1, arg_63_2)
	if not self.canEidt then
		return
	end

	local var_63_0 = self.furnitures[arg_63_1]

	if not self.furnitures[arg_63_1]:GetOpFlag() then
		return
	end

	if isa(var_63_0, CourtYardWallFurniture) then
		arg_63_2 = var_63_0:NormalizePosition(arg_63_2, self.minSizeX)
	end

	local var_63_1 = self:GetParentForItem(var_63_0, arg_63_2)
	local var_63_2 = var_63_1 and var_63_1:RawGetOffset() or var_63_0:GetOffset()

	self:DispatchEvent(CourtYardEvent.DRAGING_ITEM, var_63_0, var_63_1 and var_63_1:AreaWithInfo(var_63_0, arg_63_2, var_63_2) or self:AreaWithInfo(var_63_0, arg_63_2, var_63_2), arg_63_2, var_63_2)

	return
end

function CourtYardStorey:GetParentForItem(arg_64_1, arg_64_2)
	local var_64_0 = _.select(_.values(self.furnitures), function(arg_65_0)
		return isa(arg_65_0, CourtYardCanPutFurniture) and arg_65_0:CanPutChildInPosition(arg_64_1, arg_64_2)
	end)

	table.sort(var_64_0, function(arg_66_0, arg_66_1)
		return (arg_66_0.parent and 1 or 0) > (arg_66_1.parent and 1 or 0)
	end)

	return var_64_0[1]
end

function CourtYardStorey:DragFurnitureEnd(arg_67_1, arg_67_2)
	if not self.canEidt then
		return
	end

	local var_67_0 = self.furnitures[arg_67_1]

	if not self.furnitures[arg_67_1]:GetOpFlag() then
		return
	end

	var_67_0:ChangeState(CourtYardFurniture.STATE_IDLE)

	if isa(var_67_0, CourtYardWallFurniture) then
		arg_67_2 = var_67_0:NormalizePosition(arg_67_2, self.minSizeX)
	end

	local var_67_1 = self:VerifyDragPositionForFurniture(var_67_0, arg_67_2)

	if not var_67_1 then
		self:RemoveFurniture(arg_67_1)
		self:DispatchEvent(CourtYardEvent.REMOVE_ILLEGALITY_ITEM)

		return
	end

	if isa(var_67_0, CourtYardWallFurniture) then
		var_67_0:UpdatePosition(var_67_1)
	else
		var_67_0:SetPosition(var_67_1)
	end

	local var_67_2 = self:GetParentForItem(var_67_0, var_67_1)
	local var_67_3

	if var_67_2 then
		self:DispatchEvent(CourtYardEvent.CHILD_ITEM, var_67_0, var_67_2)
		var_67_2:AddChild(var_67_0)

		var_67_3 = var_67_2:AreaWithInfo(var_67_0, var_67_1, var_67_2:RawGetOffset(), true)
	else
		self:AddItem(var_67_0)

		var_67_3 = self:AreaWithInfo(var_67_0, var_67_1, var_67_0:GetOffset(), true)
	end

	self:DispatchEvent(CourtYardEvent.DRAG_ITEM_END, var_67_0, var_67_3)

	return
end

function CourtYardStorey:IsLegalAreaForFurniture(arg_68_1, arg_68_2)
	return _.all(arg_68_1:GetAreaByPosition(arg_68_2), function(arg_69_0)
		return self:LegalPosition(arg_69_0, arg_68_1)
	end) or self:GetParentForItem(arg_68_1, arg_68_2) ~= nil
end

function CourtYardStorey:VerifyDragPositionForFurniture(arg_70_1, arg_70_2)
	local var_70_0

	if self:IsLegalAreaForFurniture(arg_70_1, arg_70_2) then
		var_70_0 = arg_70_2
	else
		local var_70_1 = arg_70_1:GetPosition()

		if var_70_1 and isa(arg_70_1, CourtYardWallFurniture) then
			arg_70_1:UpdatePosition(var_70_1)
		end

		if var_70_1 and self:IsLegalAreaForFurniture(arg_70_1, var_70_1) then
			var_70_0 = var_70_1
		else
			if var_70_1 and isa(arg_70_1, CourtYardWallFurniture) then
				arg_70_1:UpdatePosition(arg_70_2)
			end

			var_70_0 = self:GetEmptyArea(arg_70_1)
		end
	end

	return var_70_0
end

function CourtYardStorey:UnSelectFurniture(arg_71_1)
	if not self.furnitures[arg_71_1]:GetOpFlag() then
		return
	end

	self.furnitures[arg_71_1]:UpdateOpFlag(false)
	self:DispatchEvent(CourtYardEvent.UNSELETED_ITEM, self.furnitures[arg_71_1])

	return
end

function CourtYardStorey:RotateFurniture(arg_72_1)
	if self.furnitures[arg_72_1]:DisableRotation() then
		self:DispatchEvent(CourtYardEvent.DISABLE_ROTATE_ITEM)
	elseif not self:CanRotateItem(self.furnitures[arg_72_1]) then
		self:DispatchEvent(CourtYardEvent.ROTATE_ITEM_FAILED)
	else
		local var_72_0 = self.furnitures[arg_72_1]:HasParent()

		if not var_72_0 then
			self:RemoveItem(self.furnitures[arg_72_1])
		end

		self.furnitures[arg_72_1]:Rotate()

		if not var_72_0 then
			self:AddItem(self.furnitures[arg_72_1])
		end

		self:DispatchEvent(CourtYardEvent.ROTATE_ITEM, self.furnitures[arg_72_1], (self:AreaWithInfo(self.furnitures[arg_72_1], self.furnitures[arg_72_1]:GetPosition(), self.furnitures[arg_72_1]:GetOffset())))
	end

	return
end

function CourtYardStorey:RemoveFurniture(arg_73_1)
	local var_73_0 = self.furnitures[arg_73_1]:HasParent()

	if var_73_0 then
		self.furnitures[arg_73_1]:GetParent():RemoveChild(self.furnitures[arg_73_1])
	end

	local var_73_1 = self.furnitures[arg_73_1].childs or {}

	for iter_73_0 = #var_73_1, 1, -1 do
		self:RemoveFurniture(var_73_1[iter_73_0].id)
	end

	if not var_73_0 then
		self:RemoveItem(self.furnitures[arg_73_1])
	end

	local var_73_2 = self.furnitures[arg_73_1]:GetMusicData()

	if var_73_2 then
		self:DispatchEvent(CourtYardEvent.ON_ITEM_STOP_MUSIC, var_73_2.voice, var_73_2.voiceType)
		self.furnitures[arg_73_1]:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
	end

	self:UnSelectFurniture(arg_73_1)
	self.furnitures[arg_73_1]:Dispose()

	self.furnitures[arg_73_1] = nil

	self:DispatchEvent(CourtYardEvent.DETORY_ITEM, self.furnitures[arg_73_1])
	self.composeChecker:Check()
	self:RefreshCombineFruniture(self.furnitures[arg_73_1].configId)

	return
end

function CourtYardStorey:RemoveAllFurniture()
	for iter_74_0, iter_74_1 in pairs(self.furnitures) do
		if not iter_74_1:HasParent() then
			self:RemoveFurniture(iter_74_1.id)
		end
	end

	self:SetWallPaper(nil)
	self:SetFloorPaper(nil)

	return
end

function CourtYardStorey:RemovePaper(arg_75_1)
	local var_75_0 = self:GetWallPaper()

	if var_75_0 and var_75_0.id == arg_75_1 then
		self:SetWallPaper(nil)
	end

	local var_75_1 = self:GetFloorPaper()

	if var_75_1 and var_75_1.id == arg_75_1 then
		self:SetFloorPaper(nil)
	end

	return
end

function CourtYardStorey:CheckFurnitureState()
	for iter_76_0, iter_76_1 in pairs(self.furnitures) do
		if iter_76_1:IsType(Furniture.TYPE_MOVEABLE) and iter_76_1:IsReadyMove() then
			self:ReadyMoveFurniture(iter_76_1.id)
		end
	end

	return
end

function CourtYardStorey:ReadyMoveFurniture(arg_77_1)
	local var_77_0 = self:GetNextPositionForMove(self.furnitures[arg_77_1])

	if not var_77_0 then
		self.furnitures[arg_77_1]:Rest()

		return
	end

	if self.furnitures[arg_77_1]:IsDifferentDirection(var_77_0) and self:CanRotateItem(self.furnitures[arg_77_1]) then
		self:RotateFurniture(arg_77_1)
	end

	self.furnitures[arg_77_1]:Move(var_77_0)
	self:RemoveItem(self.furnitures[arg_77_1])
	self.furnitures[arg_77_1]:SetPosition(var_77_0)
	self:AddItemAndRefresh(self.furnitures[arg_77_1])

	return
end

function CourtYardStorey:GetFurnituresByType(arg_78_1)
	local var_78_0 = {}

	for iter_78_0, iter_78_1 in pairs(self.furnitures) do
		if iter_78_1:IsType(arg_78_1) then
			table.insert(var_78_0, iter_78_1)
		end
	end

	return var_78_0
end

function CourtYardStorey:EnterEditMode()
	self.canEidt = true

	for iter_79_0, iter_79_1 in pairs(self.ships) do
		if iter_79_1:GetState() == CourtYardShip.STATE_DRAG then
			self:DragShipEnd(iter_79_1.id, Vector2(-1, -1))
		end

		self:GetPlaceableArea(iter_79_1):_ClearLockPosition(iter_79_1)

		if iter_79_1:HasParent() then
			local var_79_0 = iter_79_1:GetParent()

			var_79_0:RemoveChild(iter_79_1)
			self:DispatchEvent(CourtYardEvent.UN_CHILD_ITEM, iter_79_1, var_79_0)
		else
			self:RemoveItem(iter_79_1)
		end

		iter_79_1:ChangeState(CourtYardShip.STATE_STOP)
	end

	for iter_79_2, iter_79_3 in pairs(self.furnitures) do
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
			self:ClickFurniture(iter_79_3.id)
		end
	end

	self.recoder:BeginCheckChange()
	self:DispatchEvent(CourtYardEvent.ENTER_EDIT_MODE)

	return
end

function CourtYardStorey:ExitEditMode()
	for iter_80_0, iter_80_1 in pairs(self.ships) do
		if iter_80_1:ShouldResetPosition() then
			self:ResetShip(iter_80_1, (iter_80_1:GetPosition()))
		end
	end

	for iter_80_2, iter_80_3 in pairs(self.furnitures) do
		if iter_80_3:IsType(Furniture.TYPE_MOVEABLE) and iter_80_3:IsStop() then
			iter_80_3:ReStart()

			if iter_80_3:CanTouch() then
				self:ClickFurniture(iter_80_3.id)
			end
		end
	end

	local var_80_0 = _.detect(_.values(self.furnitures), function(arg_81_0)
		return arg_81_0:GetOpFlag()
	end)

	if var_80_0 then
		self:UnSelectFurniture(var_80_0.id)
	end

	self.canEidt = false

	self.recoder:EndCheckChange()
	self:DispatchEvent(CourtYardEvent.EXIT_EDIT_MODE)

	return
end

function CourtYardStorey:InEidtMode()
	return self.canEidt
end

function CourtYardStorey:StopAllDragState()
	if not self:InEidtMode() then
		(function()
			for iter_84_0, iter_84_1 in pairs(self.ships) do
				if iter_84_1:GetState() == CourtYardShip.STATE_DRAG then
					self:DragShipEnd(iter_84_1.id, Vector2(-1, -1))
				end
			end

			return
		end)()
	else
		(function()
			for iter_85_0, iter_85_1 in pairs(self.furnitures) do
				if iter_85_1:IsDragingState() then
					self:DragFurnitureEnd(iter_85_1.id, Vector2(-1, -1))
					self:UnSelectFurniture(iter_85_1.id)
				end
			end

			return
		end)()
	end

	return
end

function CourtYardStorey:StartInteraction(arg_86_1)
	local var_86_0 = arg_86_1:GetOwner()

	if isa(var_86_0, CourtYardFurniture) and var_86_0:GetInterActionBgm() then
		for iter_86_0, iter_86_1 in pairs(self.furnitures) do
			if iter_86_1:IsPlayMusicState() then
				iter_86_1:ChangeState(CourtYardFurniture.STATE_STOP_MUSIC)
			end
		end
	end

	self:DispatchEvent(CourtYardEvent.ITEM_INTERACTION, arg_86_1:GetUser(), var_86_0, arg_86_1)

	return
end

function CourtYardStorey:WillClearInteraction(arg_87_1, arg_87_2)
	self:DispatchEvent(CourtYardEvent.CLEAR_ITEM_INTERACTION, arg_87_1:GetUser(), arg_87_1:GetOwner(), arg_87_1)

	return
end

function CourtYardStorey:ClearInteraction(arg_88_1, arg_88_2)
	local var_88_0 = arg_88_1:GetUser()
	local var_88_1 = arg_88_1:GetOwner()

	if isa(var_88_0, CourtYardFollowerFurniture) then
		self:ClearInteractionForFollower(var_88_0, var_88_1, arg_88_1, arg_88_2)
	elseif not arg_88_2 then
		if isa(var_88_1, CourtYardTransportFurniture) then
			self:ClearInteractionForTransPort(var_88_0, var_88_1, arg_88_1)
		else
			self:ResetShip(var_88_0, var_88_0:GetPosition())
		end
	end

	return
end

function CourtYardStorey:ClearInteractionForFollower(arg_89_1, arg_89_2, arg_89_3, arg_89_4)
	local var_89_0 = self:GetAroundEmptyArea(arg_89_1, arg_89_2:GetPosition())

	if not var_89_0 then
		self:DispatchEvent(CourtYardEvent.REMOVE_ILLEGALITY_ITEM)
		self:RemoveFurniture(arg_89_1.id)

		return
	end

	arg_89_1:SetPosition(var_89_0)
	self:AddItemAndRefresh(arg_89_1)

	return
end

function CourtYardStorey:ClearInteractionForTransPort(arg_90_1, arg_90_2, arg_90_3)
	if arg_90_3:IsFirstTime() then
		local var_90_0 = _.select(self:GetFurnituresByType(Furniture.TYPE_TRANSPORT), function(arg_91_0)
			return arg_91_0.id ~= arg_90_2.id
		end)

		if var_90_0[math.random(1, #var_90_0)] and var_90_0[math.random(1, #var_90_0)]:CanInterAction(arg_90_1) then
			var_90_0[math.random(1, #var_90_0)]:GetInteractionSlot():Link(var_90_0[math.random(1, #var_90_0)], arg_90_1, self)
		else
			self:ResetShip(arg_90_1, self:GetRandomPosition(arg_90_1))
		end
	else
		self:ResetShip(arg_90_1, self:GetAroundEmptyPosition(arg_90_2))
	end

	return
end

function CourtYardStorey:LegalPosition(arg_92_1, arg_92_2)
	return CourtYardStorey.super.LegalPosition(self, arg_92_1, arg_92_2) and arg_92_2:InActivityRange(arg_92_1)
end

function CourtYardStorey:GetLevel()
	return self.level
end

function CourtYardStorey:Dispose()
	CourtYardStorey.super.Dispose(self)
	self.recoder:Dispose()

	self.recoder = nil

	self.composeChecker:Dispose()

	self.composeChecker = nil

	for iter_94_0, iter_94_1 in pairs(self.ships) do
		iter_94_1:Dispose()
	end

	for iter_94_2, iter_94_3 in pairs(self.furnitures) do
		iter_94_3:Dispose()
	end

	self.ships = nil
	self.furnitures = nil

	return
end

function CourtYardStorey:GetDirty()
	return self.recoder:TakeSample()
end

function CourtYardStorey:ToTable()
	local var_96_0 = {}

	local function var_96_1(arg_97_0)
		arg_97_0.floor = self.id
		var_96_0[arg_97_0.id] = arg_97_0

		return
	end

	for iter_96_0, iter_96_1 in pairs(self.furnitures) do
		var_96_1(iter_96_1:ToTable())
	end

	if self.wallPaper then
		var_96_1(self.wallPaper:ToTable())
	end

	if self.floorPaper then
		var_96_1(self.floorPaper:ToTable())
	end

	return var_96_0
end

return CourtYardStorey
