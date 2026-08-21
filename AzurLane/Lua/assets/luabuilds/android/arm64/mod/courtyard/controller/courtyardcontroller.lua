local var_0_0 = class("CourtYardController")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.bridge = arg_1_1
	arg_1_0.system = arg_1_2.system
	arg_1_0.storeyId = arg_1_2.storeyId
	arg_1_0.storeyDatas = arg_1_2.storeys
	arg_1_0.storey = arg_1_0:System2Storey(arg_1_2)
	arg_1_0.isInit = false

	return
end

function var_0_0.GetBridge(arg_2_0)
	return arg_2_0.bridge
end

function var_0_0.IsLoaed(arg_3_0)
	return arg_3_0.isInit
end

function var_0_0.SetUp(arg_4_0)
	local var_4_0 = arg_4_0.storeyDatas[arg_4_0.storeyId]

	arg_4_0.storey:SetLevel(arg_4_0.storeyDatas[arg_4_0.storeyId].level)

	if not var_4_0.furnitures[1] or not var_0_0.IsFloorPaper(var_4_0.furnitures[1]) then
		arg_4_0.storey:SetFloorPaper(nil)
	end

	local var_4_1 = math.ceil(#var_4_0.furnitures / 3)

	for iter_4_0, iter_4_1 in ipairs(var_4_0.furnitures) do
		table.insert({}, function(arg_5_0)
			arg_4_0:AddFurniture({
				id = iter_4_1.id,
				configId = iter_4_1.configId,
				dir = iter_4_1.dir,
				parent = iter_4_1.parent,
				position = iter_4_1.position,
				date = iter_4_1.date
			}, true)

			if (iter_4_0 - 1) % var_4_1 == 0 then
				onNextTick(arg_5_0)
			else
				arg_5_0()
			end

			return
		end)
	end

	for iter_4_2, iter_4_3 in ipairs(var_4_0.ships) do
		table.insert({}, function(arg_6_0)
			local var_6_0 = var_4_0.popList[iter_4_3.id] or {}
			local var_6_2 = var_6_0[1] or 0
			local var_6_3 = var_6_0[2] or 0

			var_6_1(arg_4_0, iter_4_3, var_6_2, var_6_3)
			onNextTick(arg_6_0)

			return
		end)
	end

	seriesAsync({}, function()
		if arg_4_0.storey then
			arg_4_0.storey:DispatchEvent(CourtYardEvent.INITED)
		end

		arg_4_0.isInit = true

		arg_4_0:SendNotification(CourtYardEvent._INITED)

		return
	end)

	return
end

function var_0_0.Update(arg_8_0)
	if arg_8_0.storey then
		arg_8_0.storey:Update()
	end

	return
end

function var_0_0.GetStorey(arg_9_0)
	return arg_9_0.storey
end

function var_0_0.AddFurniture(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0.storey then
		return
	end

	local var_10_1 = arg_10_0:DataToFurnitureVO(arg_10_1)

	var_10_1.selectedFlag = arg_10_1.selected

	if not arg_10_0.storey:CanAddFurniture(var_10_1) then
		return
	end

	local var_10_2 = var_10_1:GetType()

	if arg_10_1.parent and arg_10_1.parent ~= 0 then
		local var_10_3 = arg_10_1.dir or 1

		var_10_1:Init(arg_10_1.position, var_10_3)
		arg_10_0.storey:AddChildFurniture(var_10_1, arg_10_1.parent)
	elseif var_10_2 == Furniture.TYPE_WALLPAPER or var_10_2 == Furniture.TYPE_FLOORPAPER then
		arg_10_0.storey:AddPaper(var_10_1)
	else
		local var_10_4 = arg_10_1.position or arg_10_0.storey:GetEmptyArea(var_10_1)

		if not var_10_4 then
			arg_10_0.storey:DispatchEvent(CourtYardEvent.ADD_ITEM_FAILED)
		elseif var_10_4 and var_10_0(var_10_1, var_10_4) then
			local var_10_5 = arg_10_1.dir or 1

			var_10_1:Init(var_10_4, var_10_5)
			arg_10_0.storey:AddFurniture(var_10_1, arg_10_2)
		else
			arg_10_0:SendNotification(CourtYardEvent._ADD_ITEM_FAILED, var_10_1.id)
		end
	end

	arg_10_0:CheckChange()

	return
end

function var_0_0.AddShip(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_0.storey then
		return
	end

	local var_12_0 = arg_12_0:DataToShip(arg_12_1, arg_12_2, arg_12_3)

	if arg_12_1:IsDoubleSkin() then
		var_12_0:SetSide(1)

		local var_12_1 = arg_12_0:DataToShip(arg_12_1, 0, 0)

		var_12_1.id = var_12_1.id + CourtYardConst.DOUBLE_SKIN_ADD

		var_12_1:SetSide(2)
		arg_12_0:CreateShip(var_12_0)
		arg_12_0:CreateShip(var_12_1)
	else
		arg_12_0:CreateShip(var_12_0)
	end

	return
end

function var_0_0.CreateShip(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.storey:GetRandomPosition(arg_13_1)

	if var_13_0 then
		arg_13_1:SetPosition(var_13_0)
		arg_13_0.storey:AddShip(arg_13_1)
	else
		arg_13_0:SendNotification(CourtYardEvent._NO_POS_TO_ADD_SHIP, arg_13_1.id)
	end

	return
end

function var_0_0.AddVisitorShip(arg_14_0, arg_14_1)
	if not arg_14_0.storey then
		return
	end

	local var_14_0 = arg_14_0:DataToVisitorShip(arg_14_1)
	local var_14_1 = arg_14_0.storey:GetRandomPosition(var_14_0)

	if var_14_1 then
		var_14_0:SetPosition(var_14_1)
		arg_14_0.storey:AddShip(var_14_0)
	end

	return
end

function var_0_0.ExitShip(arg_15_0, arg_15_1)
	arg_15_0.storey:ExitShip(arg_15_1)

	return
end

function var_0_0.Extend(arg_16_0)
	arg_16_0:SendNotification(CourtYardEvent._EXTEND)

	return
end

function var_0_0.LevelUp(arg_17_0)
	arg_17_0.storey:LevelUp(id)

	return
end

function var_0_0.DragShip(arg_18_0, arg_18_1)
	arg_18_0.storey:DragShip(arg_18_1)
	arg_18_0:SendNotification(CourtYardEvent._DRAG_ITEM)

	return
end

function var_0_0.DragingShip(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.storey:DragingShip(arg_19_1, arg_19_2)

	return
end

function var_0_0.DragShipEnd(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.storey:DragShipEnd(arg_20_1, arg_20_2)
	arg_20_0:SendNotification(CourtYardEvent._DRAG_ITEM_END)

	return
end

function var_0_0.TouchShip(arg_21_0, arg_21_1)
	arg_21_0.storey:TouchShip(arg_21_1)
	arg_21_0:SendNotification(CourtYardEvent._TOUCH_SHIP, arg_21_1)

	return
end

function var_0_0.GetShipInimacy(arg_22_0, arg_22_1)
	arg_22_0:SendNotification(GAME.BACKYARD_ADD_INTIMACY, arg_22_1)

	return
end

function var_0_0.GetShipCoin(arg_23_0, arg_23_1)
	arg_23_0:SendNotification(GAME.BACKYARD_ADD_MONEY, arg_23_1)

	return
end

function var_0_0.ClearShipCoin(arg_24_0, arg_24_1)
	arg_24_0.storey:ClearShipCoin(arg_24_1)

	return
end

function var_0_0.ClearShipIntimacy(arg_25_0, arg_25_1)
	arg_25_0.storey:ClearShipIntimacy(arg_25_1)

	return
end

function var_0_0.UpdateShipCoinAndIntimacy(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0.storey:UpdateShipCoin(arg_26_1, arg_26_2)
	arg_26_0.storey:UpdateShipIntimacy(arg_26_1, arg_26_3)

	return
end

function var_0_0.AddShipExp(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0.storey:AddShipExp(arg_27_1, arg_27_2)

	return
end

function var_0_0.ShipAnimtionFinish(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0.storey:ShipAnimtionFinish(arg_28_1, arg_28_2)

	return
end

function var_0_0.GetMaxCntForShip(arg_29_0)
	return #arg_29_0.storey:GetEmptyPositions(CourtYardShip.New(arg_29_0, Ship.New({
		id = 999,
		configId = 100001
	}))) + table.getCount(arg_29_0.storey:GetShips())
end

function var_0_0.SelectFurnitureByConfigId(arg_30_0, arg_30_1)
	if arg_30_0.storey.wallPaper and arg_30_0.storey.wallPaper.configId == arg_30_1 then
		return
	end

	if arg_30_0.storey.floorPaper and arg_30_0.storey.floorPaper.configId == arg_30_1 then
		return
	end

	local var_30_0

	for iter_30_0, iter_30_1 in pairs(arg_30_0.storey.furnitures) do
		if iter_30_1.configId == arg_30_1 then
			var_30_0 = iter_30_1

			break
		end
	end

	if var_30_0 then
		arg_30_0:SelectFurniture(var_30_0.id)
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("courtyard_tip_furniture_not_in_layer"))
	end

	return
end

function var_0_0.SelectFurniture(arg_31_0, arg_31_1)
	if arg_31_0.storey:InEidtMode() then
		arg_31_0.storey:SelectFurniture(arg_31_1)

		local var_31_0 = arg_31_0.storey:GetFurniture(arg_31_1)

		if var_31_0:GetOpFlag() then
			arg_31_0:SendNotification(CourtYardEvent._FURNITURE_SELECTED, var_31_0.configId)
		end
	else
		arg_31_0.storey:ClickFurniture(arg_31_1)
	end

	return
end

function var_0_0.PlayFurnitureVoice(arg_32_0, arg_32_1)
	arg_32_0.storey:PlayFurnitureVoice(arg_32_1)

	return
end

function var_0_0.PlayMusicalInstruments(arg_33_0, arg_33_1)
	arg_33_0.storey:PlayMusicalInstruments(arg_33_1)

	return
end

function var_0_0.StopPlayMusicalInstruments(arg_34_0, arg_34_1)
	arg_34_0.storey:StopPlayMusicalInstruments(arg_34_1)

	return
end

function var_0_0.PlayFurnitureBg(arg_35_0, arg_35_1)
	arg_35_0.storey:PlayFurnitureBg(arg_35_1)

	return
end

function var_0_0.UnSelectFurniture(arg_36_0, arg_36_1)
	arg_36_0.storey:UnSelectFurniture(arg_36_1)

	if not arg_36_0.storey:GetFurniture(arg_36_1):GetOpFlag() then
		arg_36_0:SendNotification(CourtYardEvent._FURNITURE_SELECTED, -99999)
	end

	return
end

function var_0_0.BeginDragFurniture(arg_37_0, arg_37_1)
	arg_37_0.storey:BeginDragFurniture(arg_37_1)
	arg_37_0:SendNotification(CourtYardEvent._DRAG_ITEM)

	return
end

function var_0_0.DragingFurniture(arg_38_0, arg_38_1, arg_38_2)
	arg_38_0.storey:DragingFurniture(arg_38_1, arg_38_2)

	return
end

function var_0_0.DragFurnitureEnd(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0.storey:DragFurnitureEnd(arg_39_1, arg_39_2)
	arg_39_0:CheckChange()
	arg_39_0:SendNotification(CourtYardEvent._DRAG_ITEM_END)

	return
end

function var_0_0.FurnitureAnimtionFinish(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0.storey:FurnitureAnimtionFinish(arg_40_1, arg_40_2)

	return
end

function var_0_0.RotateFurniture(arg_41_0, arg_41_1)
	arg_41_0.storey:RotateFurniture(arg_41_1)
	arg_41_0:CheckChange()

	return
end

function var_0_0.RemoveFurniture(arg_42_0, arg_42_1)
	arg_42_0.storey:RemoveFurniture(arg_42_1)
	arg_42_0:CheckChange()

	return
end

function var_0_0.RemovePaper(arg_43_0, arg_43_1)
	arg_43_0.storey:RemovePaper(arg_43_1)
	arg_43_0:CheckChange()

	return
end

function var_0_0.ClearFurnitures(arg_44_0)
	arg_44_0.storey:RemoveAllFurniture()
	arg_44_0:CheckChange()

	return
end

function var_0_0.SaveFurnitures(arg_45_0)
	if arg_45_0.storey.recoder:HasChange() then
		arg_45_0:SendNotification(GAME.PUT_FURNITURE, {
			tip = true,
			furnsPos = arg_45_0.storey:ToTable()
		})
	end

	arg_45_0:ExitEditMode()

	return
end

function var_0_0.GetStoreyData(arg_46_0)
	return (arg_46_0.storey:ToTable())
end

function var_0_0.RestoreFurnitures(arg_47_0)
	arg_47_0:ClearFurnitures()

	for iter_47_0, iter_47_1 in ipairs((arg_47_0.storey.recoder:GetHeadSample())) do
		arg_47_0:AddFurniture(iter_47_1)
	end

	arg_47_0:ExitEditMode()

	return
end

function var_0_0.EnterEditMode(arg_48_0)
	arg_48_0.storey:EnterEditMode()
	arg_48_0:SendNotification(CourtYardEvent._ENTER_MODE)

	return
end

function var_0_0.ExitEditMode(arg_49_0)
	arg_49_0.storey:ExitEditMode()
	arg_49_0:SendNotification(CourtYardEvent._EXIT_MODE)

	return
end

function var_0_0.CheckChange(arg_50_0)
	local var_50_0, var_50_1 = arg_50_0.storey:GetDirty()

	if var_50_0 and var_50_1 then
		arg_50_0:SendNotification(CourtYardEvent._SYN_FURNITURE, {
			var_50_0,
			var_50_1
		})
	end

	return
end

function var_0_0.Quit(arg_51_0)
	if arg_51_0.storey:InEidtMode() then
		if arg_51_0.storey.recoder:HasChange() then
			arg_51_0.storey:DispatchEvent(CourtYardEvent.REMIND_SAVE)
		else
			arg_51_0:ExitEditMode()
		end
	else
		arg_51_0:SendNotification(CourtYardEvent._QUIT)
	end

	return
end

function var_0_0.IsVisit(arg_52_0)
	return arg_52_0.system == CourtYardConst.SYSTEM_VISIT
end

function var_0_0.IsFeast(arg_53_0)
	return arg_53_0.system == CourtYardConst.SYSTEM_FEAST
end

function var_0_0.IsEditModeOrIsVisit(arg_54_0)
	return arg_54_0:IsVisit() or arg_54_0.storey:InEidtMode()
end

function var_0_0.Receive(arg_55_0, arg_55_1, ...)
	if not arg_55_0.storey then
		return
	end

	arg_55_0[arg_55_1](arg_55_0, ...)

	return
end

function var_0_0.OnTakeThemePhoto(arg_56_0)
	if arg_56_0.storey then
		arg_56_0.storey:DispatchEvent(CourtYardEvent.TAKE_PHOTO)
	end

	return
end

function var_0_0.OnEndTakeThemePhoto(arg_57_0)
	if arg_57_0.storey then
		arg_57_0.storey:DispatchEvent(CourtYardEvent.END_TAKE_PHOTO)
	end

	return
end

function var_0_0.OnApplicationPaused(arg_58_0)
	if arg_58_0.storey then
		arg_58_0.storey:StopAllDragState()
		arg_58_0:SendNotification(CourtYardEvent._DRAG_ITEM_END)
	end

	return
end

function var_0_0.OnOpenLayerOrCloseLayer(arg_59_0, arg_59_1, arg_59_2)
	if not arg_59_0.storey then
		return
	end

	arg_59_0.storey:DispatchEvent(CourtYardEvent.OPEN_LAYER, arg_59_1)

	return
end

function var_0_0.OnBackPressed(arg_60_0)
	if arg_60_0.storey then
		arg_60_0.storey:DispatchEvent(CourtYardEvent.BACK_PRESSED)
	end

	return
end

function var_0_0.Dispose(arg_61_0)
	if arg_61_0.storey then
		arg_61_0.storey:Dispose()

		arg_61_0.storey = nil
	end

	return
end

function var_0_0.IsFloorPaper(arg_62_0)
	return pg.furniture_data_template[arg_62_0.configId].type == Furniture.TYPE_FLOORPAPER
end

function var_0_0.DataToFurnitureVO(arg_63_0, arg_63_1)
	if pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_WALLPAPER or pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_FLOORPAPER then
		return CourtYardPaper.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_FOLLOWER then
		return CourtYardFollowerFurniture.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_RANDOM_CONTROLLER then
		return CourtYardRandomControllerFurniture.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_MAT then
		return CourtYardMatFurniture.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_TRANSPORT then
		return CourtYardTransportFurniture.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_WALL_MAT then
		return CourtYardWallMatFurniture.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_STAGE or pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_ARCH then
		return CourtYardStageFurniture.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_MOVEABLE then
		return CourtYardMoveableFurniture.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].belong == 1 and pg.furniture_data_template[arg_63_1.configId].canputon == 1 then
		return CourtYardCanPutFurniture.New(arg_63_0, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].belong > 1 then
		return CourtYardWallFurniture.New(arg_63_0, arg_63_1)
	else
		return CourtYardFurniture.New(arg_63_0, arg_63_1)
	end

	return
end

function var_0_0.DataToShip(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	if arg_64_0.system == CourtYardConst.SYSTEM_FEAST then
		return CourtYardFeastShip.New(arg_64_0, arg_64_1)
	else
		return CourtYardShip.New(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	end

	return
end

function var_0_0.DataToVisitorShip(arg_65_0, arg_65_1)
	return CourtYardVisitorShip.New(arg_65_0, arg_65_1)
end

function var_0_0.System2Storey(arg_66_0, arg_66_1)
	local var_66_0 = Vector4(arg_66_1.mapSize.z + 1, arg_66_1.mapSize.w + 1, arg_66_1.mapSize.x, arg_66_1.mapSize.y)

	if arg_66_1.system == CourtYardConst.SYSTEM_OUTSIDE then
		return CourtYardOutStorey.New(arg_66_0, arg_66_1.storeyId, arg_66_1.style, var_66_0)
	else
		return CourtYardStorey.New(arg_66_0, arg_66_1.storeyId, arg_66_1.style, var_66_0)
	end

	return
end

function var_0_0.SendNotification(arg_67_0, ...)
	if arg_67_0.bridge then
		arg_67_0.bridge:SendNotification(...)
	end

	return
end

return var_0_0
