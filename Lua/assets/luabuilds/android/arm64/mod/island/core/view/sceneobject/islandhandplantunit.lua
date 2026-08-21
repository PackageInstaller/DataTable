local var_0_0 = class("IslandHandPlantUnit", import(".IslandSlotBaseUnit"))

PlantStateType = {
	Planting = 3,
	Locked = 1,
	Delegate = 5,
	CanHarvest = 4,
	CanPlant = 2
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:InitData()

	arg_1_0.emptyName = pg.island_set.farm_empty_state_info.key_value_varchar[1]
	arg_1_0.emptyIcon = pg.island_set.farm_empty_state_info.key_value_varchar[2]

	return
end

function var_0_0.InitData(arg_2_0)
	arg_2_0.handDate = arg_2_0.data.slotData
	arg_2_0.slotType = arg_2_0.data.slotType
	arg_2_0.slotState = arg_2_0:GetPlantStateType()

	local var_2_0 = arg_2_0.data:GetEndProductEndTime() or 0
	local var_2_1 = pg.TimeMgr.GetInstance()
	local var_2_2 = var_2_0 - var_2_1:GetServerTime()

	if var_2_2 > 0 then
		arg_2_0.stateTimer = Timer.New(function()
			arg_2_0.slotState = arg_2_0:GetPlantStateType()

			arg_2_0:NotifiyCore(ISLAND_EVT.UPDATE_HUD, tonumber(arg_2_0.id))

			return
		end, var_2_2, 1)

		arg_2_0.stateTimer:Start()
	end

	return
end

function var_0_0.GetPlantType(arg_4_0)
	return arg_4_0.slotState
end

function var_0_0.LoadProductItemByPath(arg_5_0, arg_5_1)
	if arg_5_0.productItemGo then
		arg_5_0:UnLoadSceneItemRes(arg_5_0.productItemPath, arg_5_0.productItemGo)
	end

	arg_5_0.productItemPath = arg_5_1

	arg_5_0:LoadSceneItemRes(arg_5_0.productItemPath, function(arg_6_0)
		setParent(arg_6_0, arg_5_0:GetView().root)

		arg_6_0.transform.position = arg_5_0.position
		arg_6_0.transform.eulerAngles = arg_5_0.rotation
		arg_5_0.productItemGo = arg_6_0

		return
	end)

	return
end

function var_0_0.InitProductItem(arg_7_0)
	local var_7_0 = arg_7_0.data:GetProductProcess()
	local var_7_1, var_7_2

	if not var_7_0 or #var_7_0 == 0 then
		do return end

		function var_7_1()
			arg_7_0:LoadProductItemByPath(pg.island_unit_item[var_7_0[arg_7_0.processIndex].model].model)

			if arg_7_0.processIndex < var_0 then
				arg_7_0.delayTimer = Timer.New(function()
					arg_7_0.processIndex = arg_7_0.processIndex + 1

					var_7_1()

					return
				end, var_7_0[arg_7_0.processIndex + 1].startTime - pg.TimeMgr.GetInstance():GetServerTime(), 1)

				arg_7_0.delayTimer:Start()
			end

			return
		end

		var_7_2 = pg.TimeMgr.GetInstance():GetServerTime()
	end

	for iter_7_0 = #var_7_0, 1, -1 do
		if var_7_2 >= var_7_0[iter_7_0].startTime or iter_7_0 == 1 then
			arg_7_0.processIndex = iter_7_0

			;(function()
				arg_7_0:LoadProductItemByPath(pg.island_unit_item[var_7_0[arg_7_0.processIndex].model].model)

				if arg_7_0.processIndex < var_0 then
					arg_7_0.delayTimer = Timer.New(function()
						arg_7_0.processIndex = arg_7_0.processIndex + 1

						var_7_1()

						return
					end, var_7_0[arg_7_0.processIndex + 1].startTime - pg.TimeMgr.GetInstance():GetServerTime(), 1)

					arg_7_0.delayTimer:Start()
				end

				return
			end)()

			break
		end
	end

	return
end

function var_0_0.CanCheckByPlayer(arg_10_0)
	return arg_10_0.data.slotType == IslandProductConst.ProductSlotType.HandPlant and arg_10_0.data.slotData ~= nil
end

function var_0_0.OnStart(arg_11_0)
	arg_11_0:HighLightDisPlayHandle()
	arg_11_0:InitProductItem()
	arg_11_0:InitEffectItem()

	return
end

function var_0_0.InitEffectItem(arg_12_0)
	if arg_12_0.slotState ~= PlantStateType.Planting and arg_12_0.slotState ~= PlantStateType.CanHarvest then
		return
	end

	local function var_12_0()
		arg_12_0.effectPath = pg.island_unit_item[pg.island_formula[arg_12_0.handDate.formula_id].collectable_vfx].model

		arg_12_0:LoadSceneEffectItemRes(arg_12_0.effectPath, function(arg_14_0)
			setParent(arg_14_0, arg_12_0:GetView().root)

			arg_12_0.effectGo = arg_14_0
			arg_12_0.effectGo.transform.position = arg_12_0.position
			arg_12_0.effectGo.transform.eulerAngles = arg_12_0.rotation

			return
		end)

		return
	end

	local var_12_1 = arg_12_0.data:GetEndProductEndTime() or 0
	local var_12_2 = pg.TimeMgr.GetInstance()
	local var_12_3 = var_12_1 - var_12_2:GetServerTime()

	if var_12_3 > 0 then
		arg_12_0.effectTimer = Timer.New(function()
			var_12_0()

			return
		end, var_12_3, 1)

		arg_12_0.effectTimer:Start()
	else
		var_12_0()
	end

	return
end

function var_0_0.SetHighLight(arg_16_0, arg_16_1)
	arg_16_0.data:SetHighLight(arg_16_1)

	if not arg_16_0._go then
		return
	end

	local var_16_0 = GetOrAddComponent(arg_16_0._go, "HighlightController")

	if arg_16_1 then
		var_16_0:HighlightOn()
	else
		var_16_0:HighlightOff()
	end

	return
end

function var_0_0.HighLightDisPlayHandle(arg_17_0)
	if arg_17_0.data:GetHighLight() then
		GetOrAddComponent(arg_17_0._go, "HighlightController"):HighlightOn()
	end

	return
end

function var_0_0.CanPlant(arg_18_0)
	return arg_18_0.slotState == PlantStateType.CanPlant
end

function var_0_0.CanHarvest(arg_19_0)
	return arg_19_0.slotState == PlantStateType.CanHarvest
end

function var_0_0.GetHudInfo(arg_20_0)
	if table.contains({
		PlantStateType.Locked,
		PlantStateType.Delegate
	}, arg_20_0.slotState) then
		({}).needShowHud = false

		return {}
	end

	;({}).needShowHud = true

	local var_20_0 = arg_20_0.handDate:GetPlantFormulaId()

	if not var_20_0 then
		({}).name = arg_20_0.emptyName
		;({}).itemIcon = "island/" .. arg_20_0.emptyIcon
	else
		local var_20_1 = pg.island_formula[var_20_0]

		;({}).name = pg.island_formula[var_20_0].name
		;({}).itemIcon = "island/" .. pg.island_item_data_template[var_20_1.item_id].icon
	end

	;({}).hudState = {}

	if arg_20_0.slotState == PlantStateType.CanPlant then
		({}).hudState.stateText = i18n("island_production_plantable")
	elseif arg_20_0.slotState == PlantStateType.Planting then
		({}).hudState.stateEndTime = arg_20_0.handDate.end_time
	else
		({}).hudState.stateText = i18n("island_production_harvestable")
	end

	return {}
end

function var_0_0.GetPlantStateType(arg_21_0)
	if arg_21_0.data.slotType ~= IslandProductConst.ProductSlotType.HandPlant then
		return PlantStateType.Delegate
	end

	if not arg_21_0.handDate then
		return PlantStateType.Locked
	end

	if arg_21_0.handDate.state == 0 then
		return PlantStateType.CanPlant
	else
		local var_21_0 = arg_21_0.handDate.end_time - pg.TimeMgr.GetInstance():GetServerTime()

		if var_21_0 <= 0 then
			return PlantStateType.CanHarvest
		else
			return PlantStateType.Planting
		end
	end

	return
end

function var_0_0.OnDispose(arg_22_0)
	var_0_0.super.OnDispose(arg_22_0)

	if arg_22_0.effectGo then
		arg_22_0:UnLoadSceneItemRes(arg_22_0.effectPath, arg_22_0.effectGo)
	end

	if arg_22_0.productItemGo then
		arg_22_0:UnLoadSceneItemRes(arg_22_0.productItemPath, arg_22_0.productItemGo)
	end

	if arg_22_0.delayTimer then
		arg_22_0.delayTimer:Stop()

		arg_22_0.delayTimer = nil
	end

	if arg_22_0.effectTimer then
		arg_22_0.effectTimer:Stop()

		arg_22_0.effectTimer = nil
	end

	if arg_22_0.stateTimer then
		arg_22_0.stateTimer:Stop()

		arg_22_0.stateTimer = nil
	end

	return
end

function var_0_0.DelegateSlotStartPerform(arg_23_0)
	arg_23_0.data:StartDelegateSlotPerform()
	arg_23_0:InitProductItem()

	return
end

return var_0_0
