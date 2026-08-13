class = var_0_10000

local var_0_0 = var_0_10000("CourtYardController")

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
	local var_4_1 = arg_4_0.storey

	var_2.SetLevel(var_4_1, var_4_0.level)

	if not var_4_0.furnitures[1] or not var_0_0.IsFloorPaper(var_2) then
		local var_4_2 = arg_4_0.storey

		var_1_10003.SetFloorPaper(var_4_2, nil)
	end

	math = var_1_10003

	local var_4_3 = var_1_10003.ceil(#var_4_0.furnitures / 3)
	local var_4_4 = {}

	ipairs = var_5

	for iter_4_0, iter_4_1 in var_5(var_4_0.furnitures) do
		table = var_1_10010

		var_1_10010.insert(var_4_4, function(arg_5_0)
			local var_5_0 = arg_4_0

			var_1.AddFurniture(var_5_0, {
				id = iter_4_1.id,
				configId = iter_4_1.configId,
				dir = iter_4_1.dir,
				parent = iter_4_1.parent,
				position = iter_4_1.position,
				date = iter_4_1.date
			}, true)

			if (iter_4_0 - 1) % var_4_3 == 0 then
				onNextTick = var_1

				var_1(arg_5_0)
			else
				arg_5_0()
			end

			return
		end)
	end

	ipairs = var_5

	for iter_4_2, iter_4_3 in var_5(var_4_0.ships) do
		table = var_1_10010

		var_1_10010.insert(var_4_4, function(arg_6_0)
			local var_6_0

			if not var_4_0.popList[iter_4_3.id] then
				var_6_0 = {}
			end

			local var_6_1 = arg_4_0
			local var_6_2 = var_2.AddShip
			local var_6_3 = iter_4_3
			local var_6_4

			if not var_6_0[1] then
				var_6_4 = 0
			end

			local var_6_5

			if not var_6_0[2] then
				var_6_5 = 0
			end

			var_6_2(var_6_1, var_6_3, var_6_4, var_6_5)

			onNextTick = var_6_2

			var_6_2(arg_6_0)

			return
		end)
	end

	seriesAsync = var_5

	var_5(var_4_4, function()
		if arg_4_0.storey then
			local var_7_0 = arg_4_0.storey
			local var_7_1 = var_0.DispatchEvent

			CourtYardEvent = var_2_10003

			var_7_1(var_7_0, var_2_10003.INITED)
		end

		arg_4_0.isInit = true

		local var_7_2 = arg_4_0
		local var_7_3 = var_0.SendNotification

		CourtYardEvent = var_2_10003

		var_7_3(var_7_2, var_2_10003._INITED)

		return
	end)

	return
end

function var_0_0.Update(arg_8_0)
	if arg_8_0.storey then
		local var_8_0 = arg_8_0.storey

		var_1.Update(var_8_0)
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

	local function var_10_0(arg_11_0, arg_11_1)
		local var_11_0 = arg_10_0
		local var_11_1 = var_2.DataToFurnitureVO(var_11_0, arg_10_1)
		local var_11_2 = var_2.Init
		local var_11_3 = arg_11_1
		local var_11_4

		if not arg_10_1.dir then
			var_11_4 = 1
		end

		var_11_2(var_11_1, var_11_3, var_11_4)

		local var_11_5 = arg_10_0.storey

		return var_3.IsLegalAreaForFurniture(var_11_5, var_2, arg_11_1)
	end

	local var_10_1 = arg_10_0:DataToFurnitureVO(arg_10_1)

	var_10_1.selectedFlag = arg_10_1.selected

	local var_10_2 = arg_10_0.storey

	if not var_5.CanAddFurniture(var_10_2, var_10_1) then
		return
	end

	local var_10_3 = var_10_1:GetType()
	local var_10_5

	if arg_10_1.parent and arg_10_1.parent ~= 0 then
		local var_10_4 = var_10_1

		var_10_5 = var_10_1.Init

		local var_10_6 = arg_10_1.position

		if not arg_10_1.dir then
			var_1_10010 = 1
		end

		var_10_5(var_10_4, var_10_6, var_1_10010)

		local var_10_7 = arg_10_0.storey

		var_10_5.AddChildFurniture(var_10_7, var_10_1, arg_10_1.parent)

		goto label_10_0
	end

	Furniture = var_10_5

	if var_10_3 ~= var_10_5.TYPE_WALLPAPER then
		Furniture = var_6

		if var_10_3 == var_6.TYPE_FLOORPAPER then
			local var_10_8 = arg_10_0.storey

			var_6.AddPaper(var_10_8, var_10_1)
		else
			local var_10_10

			if not arg_10_1.position then
				local var_10_9 = arg_10_0.storey

				var_10_10 = var_6.GetEmptyArea(var_10_9, var_10_1)
			end

			if not var_10_10 then
				local var_10_11 = arg_10_0.storey
				local var_10_12 = var_7.DispatchEvent

				CourtYardEvent = var_1_10010

				var_10_12(var_10_11, var_1_10010.ADD_ITEM_FAILED)
			elseif var_10_10 and var_10_0(var_10_1, var_10_10) then
				local var_10_13 = var_10_1
				local var_10_14 = var_10_1.Init

				var_1_10010 = var_10_10

				local var_10_15

				if not arg_10_1.dir then
					var_10_15 = 1
				end

				var_10_14(var_10_13, var_1_10010, var_10_15)

				local var_10_16 = arg_10_0.storey

				var_7.AddFurniture(var_10_16, var_10_1, arg_10_2)
			else
				local var_10_17 = arg_10_0
				local var_10_18 = arg_10_0.SendNotification

				CourtYardEvent = var_1_10010

				var_10_18(var_10_17, var_1_10010._ADD_ITEM_FAILED, var_10_1.id)
			end
		end

		::label_10_0::

		arg_10_0:CheckChange()

		return
	end
end

function var_0_0.AddShip(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_0.storey then
		return
	end

	local var_12_0 = arg_12_0:DataToShip(arg_12_1, arg_12_2, arg_12_3)

	if arg_12_1:IsDoubleSkin() then
		var_12_0:SetSide(1)

		local var_12_1 = arg_12_0
		local var_12_2 = arg_12_0.DataToShip(var_12_1, arg_12_1, 0, 0).id

		CourtYardConst = var_12_1
		var_5.id = var_12_2 + var_12_1.DOUBLE_SKIN_ADD

		var_5:SetSide(2)
		arg_12_0:CreateShip(var_12_0)
		arg_12_0:CreateShip(var_5)
	else
		arg_12_0:CreateShip(var_12_0)
	end

	return
end

function var_0_0.CreateShip(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.storey

	if var_2.GetRandomPosition(var_13_0, arg_13_1) then
		arg_13_1:SetPosition(var_2)

		local var_13_1 = arg_13_0.storey

		var_3.AddShip(var_13_1, arg_13_1)
	else
		local var_13_2 = arg_13_0
		local var_13_3 = arg_13_0.SendNotification

		CourtYardEvent = var_1_10006

		var_13_3(var_13_2, var_1_10006._NO_POS_TO_ADD_SHIP, arg_13_1.id)
	end

	return
end

function var_0_0.AddVisitorShip(arg_14_0, arg_14_1)
	if not arg_14_0.storey then
		return
	end

	local var_14_0 = arg_14_0:DataToVisitorShip(arg_14_1)
	local var_14_1 = arg_14_0.storey

	if var_3.GetRandomPosition(var_14_1, var_14_0) then
		var_14_0:SetPosition(var_3)

		local var_14_2 = arg_14_0.storey

		var_4.AddShip(var_14_2, var_14_0)
	end

	return
end

function var_0_0.ExitShip(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.storey

	var_2.ExitShip(var_15_0, arg_15_1)

	return
end

function var_0_0.Extend(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.SendNotification

	CourtYardEvent = var_1_10004

	var_16_1(var_16_0, var_1_10004._EXTEND)

	return
end

function var_0_0.LevelUp(arg_17_0)
	local var_17_0 = arg_17_0.storey
	local var_17_1 = var_1.LevelUp

	id = var_1_10004

	var_17_1(var_17_0, var_1_10004)

	return
end

function var_0_0.DragShip(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.storey

	var_2.DragShip(var_18_0, arg_18_1)

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_0.SendNotification

	CourtYardEvent = var_5

	var_18_2(var_18_1, var_5._DRAG_ITEM)

	return
end

function var_0_0.DragingShip(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.storey

	var_3.DragingShip(var_19_0, arg_19_1, arg_19_2)

	return
end

function var_0_0.DragShipEnd(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.storey

	var_3.DragShipEnd(var_20_0, arg_20_1, arg_20_2)

	local var_20_1 = arg_20_0
	local var_20_2 = arg_20_0.SendNotification

	CourtYardEvent = var_6

	var_20_2(var_20_1, var_6._DRAG_ITEM_END)

	return
end

function var_0_0.TouchShip(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0.storey

	var_2.TouchShip(var_21_0, arg_21_1)

	local var_21_1 = arg_21_0
	local var_21_2 = arg_21_0.SendNotification

	CourtYardEvent = var_5

	var_21_2(var_21_1, var_5._TOUCH_SHIP, arg_21_1)

	return
end

function var_0_0.GetShipInimacy(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0
	local var_22_1 = arg_22_0.SendNotification

	GAME = var_1_10005

	var_22_1(var_22_0, var_1_10005.BACKYARD_ADD_INTIMACY, arg_22_1)

	return
end

function var_0_0.GetShipCoin(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0
	local var_23_1 = arg_23_0.SendNotification

	GAME = var_1_10005

	var_23_1(var_23_0, var_1_10005.BACKYARD_ADD_MONEY, arg_23_1)

	return
end

function var_0_0.ClearShipCoin(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.storey

	var_2.ClearShipCoin(var_24_0, arg_24_1)

	return
end

function var_0_0.ClearShipIntimacy(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.storey

	var_2.ClearShipIntimacy(var_25_0, arg_25_1)

	return
end

function var_0_0.UpdateShipCoinAndIntimacy(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0.storey

	var_4.UpdateShipCoin(var_26_0, arg_26_1, arg_26_2)

	local var_26_1 = arg_26_0.storey

	var_4.UpdateShipIntimacy(var_26_1, arg_26_1, arg_26_3)

	return
end

function var_0_0.AddShipExp(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0.storey

	var_3.AddShipExp(var_27_0, arg_27_1, arg_27_2)

	return
end

function var_0_0.ShipAnimtionFinish(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_0.storey

	var_3.ShipAnimtionFinish(var_28_0, arg_28_1, arg_28_2)

	return
end

function var_0_0.GetMaxCntForShip(arg_29_0)
	local var_29_0 = arg_29_0.storey
	local var_29_1 = var_1.GetEmptyPositions

	CourtYardShip = var_1_10004

	local var_29_2 = var_1_10004.New
	local var_29_3 = arg_29_0

	Ship = var_1_10007

	local var_29_4 = #var_29_1(var_29_0, var_29_2(var_29_3, var_1_10007.New({
		id = 999,
		configId = 100001
	})))

	table = var_29_0

	local var_29_5 = var_29_0.getCount
	local var_29_6 = arg_29_0.storey

	return var_29_4 + var_29_5(var_5.GetShips(var_29_6))
end

function var_0_0.SelectFurnitureByConfigId(arg_30_0, arg_30_1)
	if arg_30_0.storey.wallPaper and arg_30_0.storey.wallPaper.configId == arg_30_1 then
		return
	end

	if arg_30_0.storey.floorPaper and arg_30_0.storey.floorPaper.configId == arg_30_1 then
		return
	end

	local var_30_0

	pairs = var_1_10003

	for iter_30_0, iter_30_1 in var_1_10003(arg_30_0.storey.furnitures) do
		if iter_30_1.configId == arg_30_1 then
			var_30_0 = iter_30_1

			break
		end
	end

	if var_30_0 then
		arg_30_0:SelectFurniture(var_30_0.id)
	else
		pg = var_3

		local var_30_1 = var_3.TipsMgr.GetInstance()
		local var_30_2 = var_3.ShowTips

		i18n = iter_30_0

		var_30_2(var_30_1, iter_30_0("courtyard_tip_furniture_not_in_layer"))
	end

	return
end

function var_0_0.SelectFurniture(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.storey

	if var_2.InEidtMode(var_31_0) then
		local var_31_1 = arg_31_0.storey

		var_2.SelectFurniture(var_31_1, arg_31_1)

		local var_31_2 = arg_31_0.storey
		local var_31_3 = var_2.GetFurniture(var_31_2, arg_31_1)

		if var_2.GetOpFlag(var_31_3) then
			local var_31_4 = arg_31_0
			local var_31_5 = arg_31_0.SendNotification

			CourtYardEvent = var_1_10006

			var_31_5(var_31_4, var_1_10006._FURNITURE_SELECTED, var_2.configId)
		end
	else
		local var_31_6 = arg_31_0.storey

		var_2.ClickFurniture(var_31_6, arg_31_1)
	end

	return
end

function var_0_0.PlayFurnitureVoice(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.storey

	var_2.PlayFurnitureVoice(var_32_0, arg_32_1)

	return
end

function var_0_0.PlayMusicalInstruments(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0.storey

	var_2.PlayMusicalInstruments(var_33_0, arg_33_1)

	return
end

function var_0_0.StopPlayMusicalInstruments(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.storey

	var_2.StopPlayMusicalInstruments(var_34_0, arg_34_1)

	return
end

function var_0_0.PlayFurnitureBg(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.storey

	var_2.PlayFurnitureBg(var_35_0, arg_35_1)

	return
end

function var_0_0.UnSelectFurniture(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0.storey

	var_2.UnSelectFurniture(var_36_0, arg_36_1)

	local var_36_1 = arg_36_0.storey
	local var_36_2 = var_2.GetFurniture(var_36_1, arg_36_1)

	if not var_2.GetOpFlag(var_36_2) then
		local var_36_3 = arg_36_0
		local var_36_4 = arg_36_0.SendNotification

		CourtYardEvent = var_1_10006

		var_36_4(var_36_3, var_1_10006._FURNITURE_SELECTED, -99999)
	end

	return
end

function var_0_0.BeginDragFurniture(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_0.storey

	var_2.BeginDragFurniture(var_37_0, arg_37_1)

	local var_37_1 = arg_37_0
	local var_37_2 = arg_37_0.SendNotification

	CourtYardEvent = var_5

	var_37_2(var_37_1, var_5._DRAG_ITEM)

	return
end

function var_0_0.DragingFurniture(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0.storey

	var_3.DragingFurniture(var_38_0, arg_38_1, arg_38_2)

	return
end

function var_0_0.DragFurnitureEnd(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0.storey

	var_3.DragFurnitureEnd(var_39_0, arg_39_1, arg_39_2)
	arg_39_0:CheckChange()

	local var_39_1 = arg_39_0
	local var_39_2 = arg_39_0.SendNotification

	CourtYardEvent = var_6

	var_39_2(var_39_1, var_6._DRAG_ITEM_END)

	return
end

function var_0_0.FurnitureAnimtionFinish(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0.storey

	var_3.FurnitureAnimtionFinish(var_40_0, arg_40_1, arg_40_2)

	return
end

function var_0_0.RotateFurniture(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.storey

	var_2.RotateFurniture(var_41_0, arg_41_1)
	arg_41_0:CheckChange()

	return
end

function var_0_0.RemoveFurniture(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_0.storey

	var_2.RemoveFurniture(var_42_0, arg_42_1)
	arg_42_0:CheckChange()

	return
end

function var_0_0.RemovePaper(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0.storey

	var_2.RemovePaper(var_43_0, arg_43_1)
	arg_43_0:CheckChange()

	return
end

function var_0_0.ClearFurnitures(arg_44_0)
	local var_44_0 = arg_44_0.storey

	var_1.RemoveAllFurniture(var_44_0)
	arg_44_0:CheckChange()

	return
end

function var_0_0.SaveFurnitures(arg_45_0)
	local var_45_0 = arg_45_0.storey.recoder

	if var_1.HasChange(var_45_0) then
		local var_45_1 = arg_45_0.storey
		local var_45_2 = var_1.ToTable(var_45_1)
		local var_45_3 = arg_45_0
		local var_45_4 = arg_45_0.SendNotification

		GAME = var_1_10005

		var_45_4(var_45_3, var_1_10005.PUT_FURNITURE, {
			tip = true,
			furnsPos = var_45_2
		})
	end

	arg_45_0:ExitEditMode()

	return
end

function var_0_0.GetStoreyData(arg_46_0)
	local var_46_0 = arg_46_0.storey

	return (var_1.ToTable(var_46_0))
end

function var_0_0.RestoreFurnitures(arg_47_0)
	arg_47_0:ClearFurnitures()

	local var_47_0 = arg_47_0.storey.recoder
	local var_47_1 = var_1.GetHeadSample(var_47_0)

	ipairs = var_1_10002

	for iter_47_0, iter_47_1 in var_1_10002(var_47_1) do
		arg_47_0:AddFurniture(iter_47_1)
	end

	arg_47_0:ExitEditMode()

	return
end

function var_0_0.EnterEditMode(arg_48_0)
	local var_48_0 = arg_48_0.storey

	var_1.EnterEditMode(var_48_0)

	local var_48_1 = arg_48_0
	local var_48_2 = arg_48_0.SendNotification

	CourtYardEvent = var_1_10004

	var_48_2(var_48_1, var_1_10004._ENTER_MODE)

	return
end

function var_0_0.ExitEditMode(arg_49_0)
	local var_49_0 = arg_49_0.storey

	var_1.ExitEditMode(var_49_0)

	local var_49_1 = arg_49_0
	local var_49_2 = arg_49_0.SendNotification

	CourtYardEvent = var_1_10004

	var_49_2(var_49_1, var_1_10004._EXIT_MODE)

	return
end

function var_0_0.CheckChange(arg_50_0)
	local var_50_0 = arg_50_0.storey
	local var_50_1, var_50_2 = var_1.GetDirty(var_50_0)

	if var_50_1 and var_50_2 then
		local var_50_3 = arg_50_0
		local var_50_4 = arg_50_0.SendNotification

		CourtYardEvent = var_1_10006

		var_50_4(var_50_3, var_1_10006._SYN_FURNITURE, {
			var_50_1,
			var_50_2
		})
	end

	return
end

function var_0_0.Quit(arg_51_0)
	local var_51_0 = arg_51_0.storey

	if var_1.InEidtMode(var_51_0) then
		local var_51_1 = arg_51_0.storey.recoder

		if var_1.HasChange(var_51_1) then
			local var_51_2 = arg_51_0.storey
			local var_51_3 = var_1.DispatchEvent

			CourtYardEvent = var_1_10004

			var_51_3(var_51_2, var_1_10004.REMIND_SAVE)
		else
			arg_51_0:ExitEditMode()
		end
	else
		local var_51_4 = arg_51_0
		local var_51_5 = arg_51_0.SendNotification

		CourtYardEvent = var_1_10004

		var_51_5(var_51_4, var_1_10004._QUIT)
	end

	return
end

function var_0_0.IsVisit(arg_52_0)
	local var_52_0 = arg_52_0.system

	CourtYardConst = var_1_10002

	return var_52_0 == var_1_10002.SYSTEM_VISIT
end

function var_0_0.IsFeast(arg_53_0)
	local var_53_0 = arg_53_0.system

	CourtYardConst = var_1_10002

	return var_53_0 == var_1_10002.SYSTEM_FEAST
end

function var_0_0.IsEditModeOrIsVisit(arg_54_0)
	local var_54_1

	if not arg_54_0:IsVisit() then
		local var_54_0 = arg_54_0.storey

		var_54_1 = var_1.InEidtMode(var_54_0)
	end

	return var_54_1
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
		local var_56_0 = arg_56_0.storey
		local var_56_1 = var_1.DispatchEvent

		CourtYardEvent = var_1_10004

		var_56_1(var_56_0, var_1_10004.TAKE_PHOTO)
	end

	return
end

function var_0_0.OnEndTakeThemePhoto(arg_57_0)
	if arg_57_0.storey then
		local var_57_0 = arg_57_0.storey
		local var_57_1 = var_1.DispatchEvent

		CourtYardEvent = var_1_10004

		var_57_1(var_57_0, var_1_10004.END_TAKE_PHOTO)
	end

	return
end

function var_0_0.OnApplicationPaused(arg_58_0)
	if arg_58_0.storey then
		local var_58_0 = arg_58_0.storey

		var_1.StopAllDragState(var_58_0)

		local var_58_1 = arg_58_0
		local var_58_2 = arg_58_0.SendNotification

		CourtYardEvent = var_1_10004

		var_58_2(var_58_1, var_1_10004._DRAG_ITEM_END)
	end

	return
end

function var_0_0.OnOpenLayerOrCloseLayer(arg_59_0, arg_59_1, arg_59_2)
	if not arg_59_0.storey then
		return
	end

	local var_59_0 = arg_59_0.storey
	local var_59_1 = var_3.DispatchEvent

	CourtYardEvent = var_1_10006

	var_59_1(var_59_0, var_1_10006.OPEN_LAYER, arg_59_1)

	return
end

function var_0_0.OnBackPressed(arg_60_0)
	if arg_60_0.storey then
		local var_60_0 = arg_60_0.storey
		local var_60_1 = var_1.DispatchEvent

		CourtYardEvent = var_1_10004

		var_60_1(var_60_0, var_1_10004.BACK_PRESSED)
	end

	return
end

function var_0_0.Dispose(arg_61_0)
	if arg_61_0.storey then
		local var_61_0 = arg_61_0.storey

		var_1.Dispose(var_61_0)

		arg_61_0.storey = nil
	end

	return
end

function var_0_0.IsFloorPaper(arg_62_0)
	pg = var_1_10001

	local var_62_0 = var_1_10001.furniture_data_template[arg_62_0.configId].type

	Furniture = var_1_10003

	return var_62_0 == var_1_10003.TYPE_FLOORPAPER
end

function var_0_0.DataToFurnitureVO(arg_63_0, arg_63_1)
	pg = var_1_10002

	local var_63_0 = var_1_10002.furniture_data_template[arg_63_1.configId].type

	Furniture = var_1_10004

	if var_63_0 ~= var_1_10004.TYPE_WALLPAPER then
		var_63_0 = var_2.type
		Furniture = var_4

		if var_63_0 == var_4.TYPE_FLOORPAPER then
			CourtYardPaper = var_63_0

			do return var_63_0.New(arg_63_0, arg_63_1) end

			goto label_63_0
		end

		local var_63_1 = var_2.type

		Furniture = var_4

		if var_63_1 == var_4.TYPE_FOLLOWER then
			CourtYardFollowerFurniture = var_63_1

			do return var_63_1.New(arg_63_0, arg_63_1) end

			goto label_63_0
		end

		local var_63_2 = var_2.type

		Furniture = var_4

		if var_63_2 == var_4.TYPE_RANDOM_CONTROLLER then
			CourtYardRandomControllerFurniture = var_63_2

			do return var_63_2.New(arg_63_0, arg_63_1) end

			goto label_63_0
		end

		local var_63_3 = var_2.type

		Furniture = var_4

		if var_63_3 == var_4.TYPE_MAT then
			CourtYardMatFurniture = var_63_3

			do return var_63_3.New(arg_63_0, arg_63_1) end

			goto label_63_0
		end

		local var_63_4 = var_2.type

		Furniture = var_4

		if var_63_4 == var_4.TYPE_TRANSPORT then
			CourtYardTransportFurniture = var_63_4

			do return var_63_4.New(arg_63_0, arg_63_1) end

			goto label_63_0
		end

		local var_63_5 = var_2.type

		Furniture = var_4

		if var_63_5 == var_4.TYPE_WALL_MAT then
			CourtYardWallMatFurniture = var_63_5

			do return var_63_5.New(arg_63_0, arg_63_1) end

			goto label_63_0
		end

		local var_63_6 = var_2.type

		Furniture = var_4

		if var_63_6 ~= var_4.TYPE_STAGE then
			var_63_6 = var_2.type
			Furniture = var_4

			if var_63_6 == var_4.TYPE_ARCH then
				CourtYardStageFurniture = var_63_6

				return var_63_6.New(arg_63_0, arg_63_1)
			else
				local var_63_7 = var_2.type

				Furniture = var_4

				if var_63_7 == var_4.TYPE_MOVEABLE then
					CourtYardMoveableFurniture = var_63_7

					return var_63_7.New(arg_63_0, arg_63_1)
				elseif var_2.belong == 1 and var_2.canputon == 1 then
					CourtYardCanPutFurniture = var_3

					return var_3.New(arg_63_0, arg_63_1)
				elseif var_2.belong > 1 then
					CourtYardWallFurniture = var_3

					return var_3.New(arg_63_0, arg_63_1)
				else
					CourtYardFurniture = var_3

					return var_3.New(arg_63_0, arg_63_1)
				end
			end

			::label_63_0::

			return
		end
	end
end

function var_0_0.DataToShip(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	local var_64_0 = arg_64_0.system

	CourtYardConst = var_1_10005

	if var_64_0 == var_1_10005.SYSTEM_FEAST then
		CourtYardFeastShip = var_64_0

		return var_64_0.New(arg_64_0, arg_64_1)
	else
		CourtYardShip = var_64_0

		return var_64_0.New(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	end

	return
end

function var_0_0.DataToVisitorShip(arg_65_0, arg_65_1)
	CourtYardVisitorShip = var_1_10002

	return var_1_10002.New(arg_65_0, arg_65_1)
end

function var_0_0.System2Storey(arg_66_0, arg_66_1)
	Vector4 = var_1_10002

	local var_66_0 = var_1_10002(arg_66_1.mapSize.z + 1, arg_66_1.mapSize.w + 1, arg_66_1.mapSize.x, arg_66_1.mapSize.y)
	local var_66_1 = arg_66_1.system

	CourtYardConst = var_4

	if var_66_1 == var_4.SYSTEM_OUTSIDE then
		CourtYardOutStorey = var_66_1

		return var_66_1.New(arg_66_0, arg_66_1.storeyId, arg_66_1.style, var_66_0)
	else
		CourtYardStorey = var_66_1

		return var_66_1.New(arg_66_0, arg_66_1.storeyId, arg_66_1.style, var_66_0)
	end

	return
end

function var_0_0.SendNotification(arg_67_0, ...)
	if arg_67_0.bridge then
		local var_67_0 = arg_67_0.bridge

		var_1.SendNotification(var_67_0, ...)
	end

	return
end

return var_0_0
