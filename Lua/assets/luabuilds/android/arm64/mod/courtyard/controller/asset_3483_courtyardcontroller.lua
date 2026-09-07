local CourtYardController = class("CourtYardController")

function CourtYardController:Ctor(arg_1_1, arg_1_2)
	self.bridge = arg_1_1
	self.system = arg_1_2.system
	self.storeyId = arg_1_2.storeyId
	self.storeyDatas = arg_1_2.storeys
	self.storey = self:System2Storey(arg_1_2)
	self.isInit = false

	return
end

function CourtYardController:GetBridge()
	return self.bridge
end

function CourtYardController:IsLoaed()
	return self.isInit
end

function CourtYardController:SetUp()
	local var_4_0 = self.storeyDatas[self.storeyId]

	self.storey:SetLevel(self.storeyDatas[self.storeyId].level)

	if not var_4_0.furnitures[1] or not CourtYardController.IsFloorPaper(var_4_0.furnitures[1]) then
		self.storey:SetFloorPaper(nil)
	end

	local var_4_1 = math.ceil(#var_4_0.furnitures / 3)
	local var_4_2 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0.furnitures) do
		table.insert(var_4_2, function(arg_5_0)
			self:AddFurniture({
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
		table.insert(var_4_2, function(arg_6_0)
			local var_6_0 = var_4_0.popList[iter_4_3.id] or {}

			self:AddShip(iter_4_3, var_6_0[1] or 0, var_6_0[2] or 0)
			onNextTick(arg_6_0)

			return
		end)
	end

	seriesAsync(var_4_2, function()
		if self.storey then
			self.storey:DispatchEvent(CourtYardEvent.INITED)
		end

		self.isInit = true

		self:SendNotification(CourtYardEvent._INITED)

		return
	end)

	return
end

function CourtYardController:Update()
	if self.storey then
		self.storey:Update()
	end

	return
end

function CourtYardController:GetStorey()
	return self.storey
end

function CourtYardController:AddFurniture(arg_10_1, arg_10_2)
	if not self.storey then
		return
	end

	local function var_10_0(arg_11_0, arg_11_1)
		local var_11_0 = self:DataToFurnitureVO(arg_10_1)

		var_11_0:Init(arg_11_1, arg_10_1.dir or 1)

		return self.storey:IsLegalAreaForFurniture(var_11_0, arg_11_1)
	end

	local var_10_1 = self:DataToFurnitureVO(arg_10_1)

	var_10_1.selectedFlag = arg_10_1.selected

	if not self.storey:CanAddFurniture(var_10_1) then
		return
	end

	local var_10_2 = var_10_1:GetType()

	if arg_10_1.parent and arg_10_1.parent ~= 0 then
		var_10_1:Init(arg_10_1.position, arg_10_1.dir or 1)
		self.storey:AddChildFurniture(var_10_1, arg_10_1.parent)
	elseif var_10_2 == Furniture.TYPE_WALLPAPER or var_10_2 == Furniture.TYPE_FLOORPAPER then
		self.storey:AddPaper(var_10_1)
	else
		local var_10_4 = arg_10_1.position or self.storey:GetEmptyArea(var_10_1)

		if not var_10_4 then
			self.storey:DispatchEvent(CourtYardEvent.ADD_ITEM_FAILED)
		elseif var_10_4 and var_10_0(var_10_1, var_10_4) then
			var_10_1:Init(var_10_4, arg_10_1.dir or 1)
			self.storey:AddFurniture(var_10_1, arg_10_2)
		else
			self:SendNotification(CourtYardEvent._ADD_ITEM_FAILED, var_10_1.id)
		end
	end

	self:CheckChange()

	return
end

function CourtYardController:AddShip(arg_12_1, arg_12_2, arg_12_3)
	if not self.storey then
		return
	end

	local var_12_0 = self:DataToShip(arg_12_1, arg_12_2, arg_12_3)

	if arg_12_1:IsDoubleSkin() then
		var_12_0:SetSide(1)

		local var_12_1 = self:DataToShip(arg_12_1, 0, 0)

		var_12_1.id = var_12_1.id + CourtYardConst.DOUBLE_SKIN_ADD

		var_12_1:SetSide(2)
		self:CreateShip(var_12_0)
		self:CreateShip(var_12_1)
	else
		self:CreateShip(var_12_0)
	end

	return
end

function CourtYardController:CreateShip(arg_13_1)
	local var_13_0 = self.storey:GetRandomPosition(arg_13_1)

	if var_13_0 then
		arg_13_1:SetPosition(var_13_0)
		self.storey:AddShip(arg_13_1)
	else
		self:SendNotification(CourtYardEvent._NO_POS_TO_ADD_SHIP, arg_13_1.id)
	end

	return
end

function CourtYardController:AddVisitorShip(arg_14_1)
	if not self.storey then
		return
	end

	local var_14_0 = self:DataToVisitorShip(arg_14_1)
	local var_14_1 = self.storey:GetRandomPosition(var_14_0)

	if var_14_1 then
		var_14_0:SetPosition(var_14_1)
		self.storey:AddShip(var_14_0)
	end

	return
end

function CourtYardController:ExitShip(arg_15_1)
	self.storey:ExitShip(arg_15_1)

	return
end

function CourtYardController:Extend()
	self:SendNotification(CourtYardEvent._EXTEND)

	return
end

function CourtYardController:LevelUp()
	self.storey:LevelUp(id)

	return
end

function CourtYardController:DragShip(arg_18_1)
	self.storey:DragShip(arg_18_1)
	self:SendNotification(CourtYardEvent._DRAG_ITEM)

	return
end

function CourtYardController:DragingShip(arg_19_1, arg_19_2)
	self.storey:DragingShip(arg_19_1, arg_19_2)

	return
end

function CourtYardController:DragShipEnd(arg_20_1, arg_20_2)
	self.storey:DragShipEnd(arg_20_1, arg_20_2)
	self:SendNotification(CourtYardEvent._DRAG_ITEM_END)

	return
end

function CourtYardController:TouchShip(arg_21_1)
	self.storey:TouchShip(arg_21_1)
	self:SendNotification(CourtYardEvent._TOUCH_SHIP, arg_21_1)

	return
end

function CourtYardController:GetShipInimacy(arg_22_1)
	self:SendNotification(GAME.BACKYARD_ADD_INTIMACY, arg_22_1)

	return
end

function CourtYardController:GetShipCoin(arg_23_1)
	self:SendNotification(GAME.BACKYARD_ADD_MONEY, arg_23_1)

	return
end

function CourtYardController:ClearShipCoin(arg_24_1)
	self.storey:ClearShipCoin(arg_24_1)

	return
end

function CourtYardController:ClearShipIntimacy(arg_25_1)
	self.storey:ClearShipIntimacy(arg_25_1)

	return
end

function CourtYardController:UpdateShipCoinAndIntimacy(arg_26_1, arg_26_2, arg_26_3)
	self.storey:UpdateShipCoin(arg_26_1, arg_26_2)
	self.storey:UpdateShipIntimacy(arg_26_1, arg_26_3)

	return
end

function CourtYardController:AddShipExp(arg_27_1, arg_27_2)
	self.storey:AddShipExp(arg_27_1, arg_27_2)

	return
end

function CourtYardController:ShipAnimtionFinish(arg_28_1, arg_28_2)
	self.storey:ShipAnimtionFinish(arg_28_1, arg_28_2)

	return
end

function CourtYardController:GetMaxCntForShip()
	return #self.storey:GetEmptyPositions(CourtYardShip.New(self, Ship.New({
		id = 999,
		configId = 100001
	}))) + table.getCount(self.storey:GetShips())
end

function CourtYardController:SelectFurnitureByConfigId(arg_30_1)
	if self.storey.wallPaper and self.storey.wallPaper.configId == arg_30_1 then
		return
	end

	if self.storey.floorPaper and self.storey.floorPaper.configId == arg_30_1 then
		return
	end

	local var_30_0

	for iter_30_0, iter_30_1 in pairs(self.storey.furnitures) do
		if iter_30_1.configId == arg_30_1 then
			var_30_0 = iter_30_1

			break
		end
	end

	if var_30_0 then
		self:SelectFurniture(var_30_0.id)
	else
		pg.TipsMgr.GetInstance():ShowTips(i18n("courtyard_tip_furniture_not_in_layer"))
	end

	return
end

function CourtYardController:SelectFurniture(arg_31_1)
	if self.storey:InEidtMode() then
		self.storey:SelectFurniture(arg_31_1)

		local var_31_0 = self.storey:GetFurniture(arg_31_1)

		if var_31_0:GetOpFlag() then
			self:SendNotification(CourtYardEvent._FURNITURE_SELECTED, var_31_0.configId)
		end
	else
		self.storey:ClickFurniture(arg_31_1)
	end

	return
end

function CourtYardController:PlayFurnitureVoice(arg_32_1)
	self.storey:PlayFurnitureVoice(arg_32_1)

	return
end

function CourtYardController:PlayMusicalInstruments(arg_33_1)
	self.storey:PlayMusicalInstruments(arg_33_1)

	return
end

function CourtYardController:StopPlayMusicalInstruments(arg_34_1)
	self.storey:StopPlayMusicalInstruments(arg_34_1)

	return
end

function CourtYardController:PlayFurnitureBg(arg_35_1)
	self.storey:PlayFurnitureBg(arg_35_1)

	return
end

function CourtYardController:UnSelectFurniture(arg_36_1)
	self.storey:UnSelectFurniture(arg_36_1)

	if not self.storey:GetFurniture(arg_36_1):GetOpFlag() then
		self:SendNotification(CourtYardEvent._FURNITURE_SELECTED, -99999)
	end

	return
end

function CourtYardController:BeginDragFurniture(arg_37_1)
	self.storey:BeginDragFurniture(arg_37_1)
	self:SendNotification(CourtYardEvent._DRAG_ITEM)

	return
end

function CourtYardController:DragingFurniture(arg_38_1, arg_38_2)
	self.storey:DragingFurniture(arg_38_1, arg_38_2)

	return
end

function CourtYardController:DragFurnitureEnd(arg_39_1, arg_39_2)
	self.storey:DragFurnitureEnd(arg_39_1, arg_39_2)
	self:CheckChange()
	self:SendNotification(CourtYardEvent._DRAG_ITEM_END)

	return
end

function CourtYardController:FurnitureAnimtionFinish(arg_40_1, arg_40_2)
	self.storey:FurnitureAnimtionFinish(arg_40_1, arg_40_2)

	return
end

function CourtYardController:RotateFurniture(arg_41_1)
	self.storey:RotateFurniture(arg_41_1)
	self:CheckChange()

	return
end

function CourtYardController:RemoveFurniture(arg_42_1)
	self.storey:RemoveFurniture(arg_42_1)
	self:CheckChange()

	return
end

function CourtYardController:RemovePaper(arg_43_1)
	self.storey:RemovePaper(arg_43_1)
	self:CheckChange()

	return
end

function CourtYardController:ClearFurnitures()
	self.storey:RemoveAllFurniture()
	self:CheckChange()

	return
end

function CourtYardController:SaveFurnitures()
	if self.storey.recoder:HasChange() then
		self:SendNotification(GAME.PUT_FURNITURE, {
			tip = true,
			furnsPos = self.storey:ToTable()
		})
	end

	self:ExitEditMode()

	return
end

function CourtYardController:GetStoreyData()
	return (self.storey:ToTable())
end

function CourtYardController:RestoreFurnitures()
	self:ClearFurnitures()

	for iter_47_0, iter_47_1 in ipairs((self.storey.recoder:GetHeadSample())) do
		self:AddFurniture(iter_47_1)
	end

	self:ExitEditMode()

	return
end

function CourtYardController:EnterEditMode()
	self.storey:EnterEditMode()
	self:SendNotification(CourtYardEvent._ENTER_MODE)

	return
end

function CourtYardController:ExitEditMode()
	self.storey:ExitEditMode()
	self:SendNotification(CourtYardEvent._EXIT_MODE)

	return
end

function CourtYardController:CheckChange()
	local var_50_0, var_50_1 = self.storey:GetDirty()

	if var_50_0 and var_50_1 then
		self:SendNotification(CourtYardEvent._SYN_FURNITURE, {
			var_50_0,
			var_50_1
		})
	end

	return
end

function CourtYardController:Quit()
	if self.storey:InEidtMode() then
		if self.storey.recoder:HasChange() then
			self.storey:DispatchEvent(CourtYardEvent.REMIND_SAVE)
		else
			self:ExitEditMode()
		end
	else
		self:SendNotification(CourtYardEvent._QUIT)
	end

	return
end

function CourtYardController:IsVisit()
	return self.system == CourtYardConst.SYSTEM_VISIT
end

function CourtYardController:IsFeast()
	return self.system == CourtYardConst.SYSTEM_FEAST
end

function CourtYardController:IsEditModeOrIsVisit()
	return self:IsVisit() or self.storey:InEidtMode()
end

function CourtYardController:Receive(arg_55_1, ...)
	if not self.storey then
		return
	end

	self[arg_55_1](self, ...)

	return
end

function CourtYardController:OnTakeThemePhoto()
	if self.storey then
		self.storey:DispatchEvent(CourtYardEvent.TAKE_PHOTO)
	end

	return
end

function CourtYardController:OnEndTakeThemePhoto()
	if self.storey then
		self.storey:DispatchEvent(CourtYardEvent.END_TAKE_PHOTO)
	end

	return
end

function CourtYardController:OnApplicationPaused()
	if self.storey then
		self.storey:StopAllDragState()
		self:SendNotification(CourtYardEvent._DRAG_ITEM_END)
	end

	return
end

function CourtYardController:OnOpenLayerOrCloseLayer(arg_59_1, arg_59_2)
	if not self.storey then
		return
	end

	self.storey:DispatchEvent(CourtYardEvent.OPEN_LAYER, arg_59_1)

	return
end

function CourtYardController:OnBackPressed()
	if self.storey then
		self.storey:DispatchEvent(CourtYardEvent.BACK_PRESSED)
	end

	return
end

function CourtYardController:Dispose()
	if self.storey then
		self.storey:Dispose()

		self.storey = nil
	end

	return
end

function CourtYardController:IsFloorPaper()
	return pg.furniture_data_template[self.configId].type == Furniture.TYPE_FLOORPAPER
end

function CourtYardController:DataToFurnitureVO(arg_63_1)
	if pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_WALLPAPER or pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_FLOORPAPER then
		return CourtYardPaper.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_FOLLOWER then
		return CourtYardFollowerFurniture.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_RANDOM_CONTROLLER then
		return CourtYardRandomControllerFurniture.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_MAT then
		return CourtYardMatFurniture.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_TRANSPORT then
		return CourtYardTransportFurniture.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_WALL_MAT then
		return CourtYardWallMatFurniture.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_STAGE or pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_ARCH then
		return CourtYardStageFurniture.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].type == Furniture.TYPE_MOVEABLE then
		return CourtYardMoveableFurniture.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].belong == 1 and pg.furniture_data_template[arg_63_1.configId].canputon == 1 then
		return CourtYardCanPutFurniture.New(self, arg_63_1)
	elseif pg.furniture_data_template[arg_63_1.configId].belong > 1 then
		return CourtYardWallFurniture.New(self, arg_63_1)
	else
		return CourtYardFurniture.New(self, arg_63_1)
	end

	return
end

function CourtYardController:DataToShip(arg_64_1, arg_64_2, arg_64_3)
	if self.system == CourtYardConst.SYSTEM_FEAST then
		return CourtYardFeastShip.New(self, arg_64_1)
	else
		return CourtYardShip.New(self, arg_64_1, arg_64_2, arg_64_3)
	end

	return
end

function CourtYardController:DataToVisitorShip(arg_65_1)
	return CourtYardVisitorShip.New(self, arg_65_1)
end

function CourtYardController:System2Storey(arg_66_1)
	local var_66_0 = Vector4(arg_66_1.mapSize.z + 1, arg_66_1.mapSize.w + 1, arg_66_1.mapSize.x, arg_66_1.mapSize.y)

	if arg_66_1.system == CourtYardConst.SYSTEM_OUTSIDE then
		return CourtYardOutStorey.New(self, arg_66_1.storeyId, arg_66_1.style, var_66_0)
	else
		return CourtYardStorey.New(self, arg_66_1.storeyId, arg_66_1.style, var_66_0)
	end

	return
end

function CourtYardController:SendNotification(...)
	if self.bridge then
		self.bridge:SendNotification(...)
	end

	return
end

return CourtYardController
