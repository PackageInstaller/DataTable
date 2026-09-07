local IslandHandPlantUnit = class("IslandHandPlantUnit", import(".IslandSlotBaseUnit"))

PlantStateType = {
	Planting = 3,
	Locked = 1,
	Delegate = 5,
	CanHarvest = 4,
	CanPlant = 2
}

function IslandHandPlantUnit:Ctor(arg_1_1, arg_1_2)
	IslandHandPlantUnit.super.Ctor(self, arg_1_1, arg_1_2)
	self:InitData()

	self.emptyName = pg.island_set.farm_empty_state_info.key_value_varchar[1]
	self.emptyIcon = pg.island_set.farm_empty_state_info.key_value_varchar[2]

	return
end

function IslandHandPlantUnit:InitData()
	self.handDate = self.data.slotData
	self.slotType = self.data.slotType
	self.slotState = self:GetPlantStateType()

	local var_2_1 = (self.data:GetEndProductEndTime() or 0) - pg.TimeMgr.GetInstance():GetServerTime()

	if var_2_1 > 0 then
		self.stateTimer = Timer.New(function()
			self.slotState = self:GetPlantStateType()

			self:NotifiyCore(ISLAND_EVT.UPDATE_HUD, tonumber(self.id))

			return
		end, var_2_1, 1)

		self.stateTimer:Start()
	end

	return
end

function IslandHandPlantUnit:GetPlantType()
	return self.slotState
end

function IslandHandPlantUnit:LoadProductItemByPath(arg_5_1)
	if self.productItemGo then
		self:UnLoadSceneItemRes(self.productItemPath, self.productItemGo)
	end

	self.productItemPath = arg_5_1

	self:LoadSceneItemRes(self.productItemPath, function(arg_6_0)
		setParent(arg_6_0, self:GetView().root)

		arg_6_0.transform.position = self.position
		arg_6_0.transform.eulerAngles = self.rotation
		self.productItemGo = arg_6_0

		return
	end)

	return
end

function IslandHandPlantUnit:InitProductItem()
	local var_7_0 = self.data:GetProductProcess()

	if not var_7_0 or #var_7_0 == 0 then
		return
	end

	local var_7_1 = #var_7_0

	local function var_7_2()
		self:LoadProductItemByPath(pg.island_unit_item[var_7_0[self.processIndex].model].model)

		if self.processIndex < var_7_1 then
			self.delayTimer = Timer.New(function()
				self.processIndex = self.processIndex + 1

				var_7_2()

				return
			end, var_7_0[self.processIndex + 1].startTime - pg.TimeMgr.GetInstance():GetServerTime(), 1)

			self.delayTimer:Start()
		end

		return
	end

	local var_7_3 = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_7_0 = #var_7_0, 1, -1 do
		if var_7_3 >= var_7_0[iter_7_0].startTime or iter_7_0 == 1 then
			self.processIndex = iter_7_0

			var_7_2()

			break
		end
	end

	return
end

function IslandHandPlantUnit:CanCheckByPlayer()
	return self.data.slotType == IslandProductConst.ProductSlotType.HandPlant and self.data.slotData ~= nil
end

function IslandHandPlantUnit:OnStart()
	self:HighLightDisPlayHandle()
	self:InitProductItem()
	self:InitEffectItem()

	return
end

function IslandHandPlantUnit:InitEffectItem()
	if self.slotState ~= PlantStateType.Planting and self.slotState ~= PlantStateType.CanHarvest then
		return
	end

	local function var_12_0()
		self.effectPath = pg.island_unit_item[pg.island_formula[self.handDate.formula_id].collectable_vfx].model

		self:LoadSceneEffectItemRes(self.effectPath, function(arg_14_0)
			setParent(arg_14_0, self:GetView().root)

			self.effectGo = arg_14_0
			self.effectGo.transform.position = self.position
			self.effectGo.transform.eulerAngles = self.rotation

			return
		end)

		return
	end

	local var_12_2 = (self.data:GetEndProductEndTime() or 0) - pg.TimeMgr.GetInstance():GetServerTime()

	if var_12_2 > 0 then
		self.effectTimer = Timer.New(function()
			var_12_0()

			return
		end, var_12_2, 1)

		self.effectTimer:Start()
	else
		var_12_0()
	end

	return
end

function IslandHandPlantUnit:SetHighLight(arg_16_1)
	self.data:SetHighLight(arg_16_1)

	if not self._go then
		return
	end

	local var_16_0 = GetOrAddComponent(self._go, "HighlightController")

	if arg_16_1 then
		var_16_0:HighlightOn()
	else
		var_16_0:HighlightOff()
	end

	return
end

function IslandHandPlantUnit:HighLightDisPlayHandle()
	if self.data:GetHighLight() then
		GetOrAddComponent(self._go, "HighlightController"):HighlightOn()
	end

	return
end

function IslandHandPlantUnit:CanPlant()
	return self.slotState == PlantStateType.CanPlant
end

function IslandHandPlantUnit:CanHarvest()
	return self.slotState == PlantStateType.CanHarvest
end

function IslandHandPlantUnit:GetHudInfo()
	local var_20_0 = {}

	if table.contains({
		PlantStateType.Locked,
		PlantStateType.Delegate
	}, self.slotState) then
		var_20_0.needShowHud = false

		return var_20_0
	end

	var_20_0.needShowHud = true

	local var_20_1 = self.handDate:GetPlantFormulaId()

	if not var_20_1 then
		var_20_0.name = self.emptyName
		var_20_0.itemIcon = "island/" .. self.emptyIcon
	else
		var_20_0.name = pg.island_formula[var_20_1].name
		var_20_0.itemIcon = "island/" .. pg.island_item_data_template[pg.island_formula[var_20_1].item_id].icon
	end

	var_20_0.hudState = {}

	if self.slotState == PlantStateType.CanPlant then
		var_20_0.hudState.stateText = i18n("island_production_plantable")
	elseif self.slotState == PlantStateType.Planting then
		var_20_0.hudState.stateEndTime = self.handDate.end_time
	else
		var_20_0.hudState.stateText = i18n("island_production_harvestable")
	end

	return var_20_0
end

function IslandHandPlantUnit:GetPlantStateType()
	if self.data.slotType ~= IslandProductConst.ProductSlotType.HandPlant then
		return PlantStateType.Delegate
	end

	if not self.handDate then
		return PlantStateType.Locked
	end

	if self.handDate.state == 0 then
		return PlantStateType.CanPlant
	elseif self.handDate.end_time - pg.TimeMgr.GetInstance():GetServerTime() <= 0 then
		return PlantStateType.CanHarvest
	else
		return PlantStateType.Planting
	end

	return
end

function IslandHandPlantUnit:OnDispose()
	IslandHandPlantUnit.super.OnDispose(self)

	if self.effectGo then
		self:UnLoadSceneItemRes(self.effectPath, self.effectGo)
	end

	if self.productItemGo then
		self:UnLoadSceneItemRes(self.productItemPath, self.productItemGo)
	end

	if self.delayTimer then
		self.delayTimer:Stop()

		self.delayTimer = nil
	end

	if self.effectTimer then
		self.effectTimer:Stop()

		self.effectTimer = nil
	end

	if self.stateTimer then
		self.stateTimer:Stop()

		self.stateTimer = nil
	end

	return
end

function IslandHandPlantUnit:DelegateSlotStartPerform()
	self.data:StartDelegateSlotPerform()
	self:InitProductItem()

	return
end

return IslandHandPlantUnit
