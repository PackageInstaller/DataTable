class = var_0_10000

local var_0_0 = "IslandHandPlantUnit"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSlotBaseUnit"))
local var_0_2 = {
	Planting = 3,
	Locked = 1,
	Delegate = 5,
	CanHarvest = 4,
	CanPlant = 2
}
local var_0_3 = PlantStateType

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:InitData()

	pg = var_3
	arg_1_0.emptyName = var_3.island_set.farm_empty_state_info.key_value_varchar[1]
	pg = var_3
	arg_1_0.emptyIcon = var_3.island_set.farm_empty_state_info.key_value_varchar[2]

	return
end

function var_0_1.InitData(arg_2_0)
	arg_2_0.handDate = arg_2_0.data.slotData
	arg_2_0.slotType = arg_2_0.data.slotType
	arg_2_0.slotState = arg_2_0:GetPlantStateType()

	local var_2_0 = arg_2_0.data
	local var_2_1

	if not var_1.GetEndProductEndTime(var_2_0) then
		var_2_1 = 0
	end

	pg = var_2_0

	local var_2_2 = var_2_0.TimeMgr.GetInstance()
	local var_2_3 = var_2_1 - var_2.GetServerTime(var_2_2)

	if 0 < var_2_3 then
		Timer = var_3
		arg_2_0.stateTimer = var_3.New(function()
			local var_3_0 = arg_2_0
			local var_3_1 = arg_2_0

			var_3_0.slotState = var_1.GetPlantStateType(var_3_1)

			local var_3_2 = arg_2_0
			local var_3_3 = var_0.NotifiyCore

			ISLAND_EVT = var_3_1

			local var_3_4 = var_3_1.UPDATE_HUD

			tonumber = var_2_10003

			var_3_3(var_3_2, var_3_4, var_2_10003(arg_2_0.id))

			return
		end, var_2_3, 1)

		local var_2_4 = arg_2_0.stateTimer

		var_3.Start(var_2_4)
	end

	return
end

function var_0_1.GetPlantType(arg_4_0)
	return arg_4_0.slotState
end

function var_0_1.LoadProductItemByPath(arg_5_0, arg_5_1)
	if arg_5_0.productItemGo then
		arg_5_0:UnLoadSceneItemRes(arg_5_0.productItemPath, arg_5_0.productItemGo)
	end

	arg_5_0.productItemPath = arg_5_1

	local function var_5_0(arg_6_0)
		setParent = var_2_10001

		local var_6_0 = arg_6_0
		local var_6_1 = arg_5_0

		var_2_10001(var_6_0, var_3.GetView(var_6_1).root)

		arg_6_0.transform.position = arg_5_0.position
		arg_6_0.transform.eulerAngles = arg_5_0.rotation
		arg_5_0.productItemGo = arg_6_0

		return
	end

	arg_5_0:LoadSceneItemRes(arg_5_0.productItemPath, var_5_0)

	return
end

function var_0_1.InitProductItem(arg_7_0)
	local var_7_0 = arg_7_0.data

	if not var_1.GetProductProcess(var_7_0) or #var_1 == 0 then
		return
	end

	local var_7_1 = #var_1

	local function var_7_2()
		local var_8_0 = var_0[arg_7_0.processIndex].model

		pg = var_1

		local var_8_1 = var_1.island_unit_item[var_8_0].model
		local var_8_2 = arg_7_0

		var_2.LoadProductItemByPath(var_8_2, var_8_1)

		if arg_7_0.processIndex < var_7_1 then
			local var_8_3 = var_0[arg_7_0.processIndex + 1].startTime

			pg = var_3

			local var_8_4 = var_3.TimeMgr.GetInstance()
			local var_8_5 = var_8_3 - var_3.GetServerTime(var_8_4)
			local var_8_6 = arg_7_0

			Timer = var_2_10005
			var_8_6.delayTimer = var_2_10005.New(function()
				arg_7_0.processIndex = arg_7_0.processIndex + 1

				var_7_2()

				return
			end, var_8_5, 1)

			local var_8_7 = arg_7_0.delayTimer

			var_4.Start(var_8_7)
		end

		return
	end

	pg = var_1_10004

	local var_7_3 = var_1_10004.TimeMgr.GetInstance()
	local var_7_4 = var_4.GetServerTime(var_7_3)

	for iter_7_0 = var_7_1, 1, -1 do
		if var_7_4 >= var_1[iter_7_0].startTime or iter_7_0 == 1 then
			arg_7_0.processIndex = iter_7_0

			var_7_2()

			break
		end
	end

	return
end

function var_0_1.CanCheckByPlayer(arg_10_0)
	local var_10_0 = arg_10_0.data.slotType

	IslandProductConst = var_1_10002

	return var_10_0 == var_1_10002.ProductSlotType.HandPlant and arg_10_0.data.slotData ~= nil
end

function var_0_1.OnStart(arg_11_0)
	arg_11_0:HighLightDisPlayHandle()
	arg_11_0:InitProductItem()
	arg_11_0:InitEffectItem()

	return
end

function var_0_1.InitEffectItem(arg_12_0)
	local var_12_0 = arg_12_0.slotState

	PlantStateType = var_1_10002

	if var_12_0 ~= var_1_10002.Planting then
		local var_12_1 = arg_12_0.slotState

		PlantStateType = var_2

		if var_12_1 ~= var_2.CanHarvest then
			return
		end
	end

	local function var_12_2()
		local var_13_0 = arg_12_0.handDate.formula_id

		pg = var_2_10001

		local var_13_1 = var_2_10001.island_formula[var_13_0].collectable_vfx
		local var_13_2 = arg_12_0

		pg = var_2_10003
		var_13_2.effectPath = var_2_10003.island_unit_item[var_13_1].model

		local function var_13_3(arg_14_0)
			setParent = var_3_10001

			local var_14_0 = arg_14_0
			local var_14_1 = arg_12_0

			var_3_10001(var_14_0, var_3.GetView(var_14_1).root)

			arg_12_0.effectGo = arg_14_0
			arg_12_0.effectGo.transform.position = arg_12_0.position
			arg_12_0.effectGo.transform.eulerAngles = arg_12_0.rotation

			return
		end

		local var_13_4 = arg_12_0

		var_3.LoadSceneEffectItemRes(var_13_4, arg_12_0.effectPath, var_13_3)

		return
	end

	local var_12_3 = arg_12_0.data
	local var_12_4

	if not var_2.GetEndProductEndTime(var_12_3) then
		var_12_4 = 0
	end

	pg = var_12_3

	local var_12_5 = var_12_3.TimeMgr.GetInstance()
	local var_12_6 = var_12_4 - var_3.GetServerTime(var_12_5)

	if 0 < var_12_6 then
		Timer = var_4
		arg_12_0.effectTimer = var_4.New(function()
			var_12_2()

			return
		end, var_12_6, 1)

		local var_12_7 = arg_12_0.effectTimer

		var_4.Start(var_12_7)
	else
		var_12_2()
	end

	return
end

function var_0_1.SetHighLight(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.data

	var_2.SetHighLight(var_16_0, arg_16_1)

	if not arg_16_0._go then
		return
	end

	GetOrAddComponent = var_2

	local var_16_1 = var_2(arg_16_0._go, "HighlightController")

	if arg_16_1 then
		var_16_1:HighlightOn()
	else
		var_16_1:HighlightOff()
	end

	return
end

function var_0_1.HighLightDisPlayHandle(arg_17_0)
	local var_17_0 = arg_17_0.data

	if var_1.GetHighLight(var_17_0) then
		GetOrAddComponent = var_1

		local var_17_1 = var_1(arg_17_0._go, "HighlightController")

		var_1.HighlightOn(var_17_1)
	end

	return
end

function var_0_1.CanPlant(arg_18_0)
	local var_18_0 = arg_18_0.slotState

	PlantStateType = var_1_10002

	return var_18_0 == var_1_10002.CanPlant
end

function var_0_1.CanHarvest(arg_19_0)
	local var_19_0 = arg_19_0.slotState

	PlantStateType = var_1_10002

	return var_19_0 == var_1_10002.CanHarvest
end

function var_0_1.GetHudInfo(arg_20_0)
	local var_20_0 = {}
	local var_20_1 = {}

	PlantStateType = var_1_10003
	var_20_1[1] = var_1_10003.Locked
	PlantStateType = var_3
	var_20_1[2] = var_3.Delegate
	table = var_3

	if var_3.contains(var_20_1, arg_20_0.slotState) then
		var_20_0.needShowHud = false

		return var_20_0
	end

	var_20_0.needShowHud = true

	local var_20_2 = arg_20_0.handDate
	local var_20_3

	if not var_3.GetPlantFormulaId(var_20_2) then
		var_20_0.name = arg_20_0.emptyName
		var_20_0.itemIcon = "island/" .. arg_20_0.emptyIcon
	else
		pg = var_20_2
		var_20_0.name = var_20_2.island_formula[var_3].name
		var_20_3 = "island/"
		pg = var_1_10006
		var_20_0.itemIcon = var_20_3 .. var_1_10006.island_item_data_template[var_4.item_id].icon
	end

	var_20_0.hudState = {}

	local var_20_4 = arg_20_0.slotState

	PlantStateType = var_20_3

	if var_20_4 == var_20_3.CanPlant then
		local var_20_5 = var_20_0.hudState

		i18n = var_5
		var_20_5.stateText = var_5("island_production_plantable")
	else
		local var_20_6 = arg_20_0.slotState

		PlantStateType = var_5

		if var_20_6 == var_5.Planting then
			var_20_0.hudState.stateEndTime = arg_20_0.handDate.end_time
		else
			local var_20_7 = var_20_0.hudState

			i18n = var_5
			var_20_7.stateText = var_5("island_production_harvestable")
		end
	end

	return var_20_0
end

function var_0_1.GetPlantStateType(arg_21_0)
	local var_21_0 = arg_21_0.data.slotType

	IslandProductConst = var_1_10002

	if var_21_0 ~= var_1_10002.ProductSlotType.HandPlant then
		PlantStateType = var_21_0

		return var_21_0.Delegate
	end

	if not arg_21_0.handDate then
		PlantStateType = var_1

		return var_1.Locked
	end

	if arg_21_0.handDate.state == 0 then
		PlantStateType = var_1

		return var_1.CanPlant
	else
		local var_21_1 = arg_21_0.handDate.end_time

		pg = var_2

		local var_21_2 = var_2.TimeMgr.GetInstance()

		if var_21_1 - var_2.GetServerTime(var_21_2) <= 0 then
			PlantStateType = var_2

			return var_2.CanHarvest
		else
			PlantStateType = var_2

			return var_2.Planting
		end
	end

	return
end

function var_0_1.OnDispose(arg_22_0)
	var_0_1.super.OnDispose(arg_22_0)

	if arg_22_0.effectGo then
		arg_22_0:UnLoadSceneItemRes(arg_22_0.effectPath, arg_22_0.effectGo)
	end

	if arg_22_0.productItemGo then
		arg_22_0:UnLoadSceneItemRes(arg_22_0.productItemPath, arg_22_0.productItemGo)
	end

	if arg_22_0.delayTimer then
		local var_22_0 = arg_22_0.delayTimer

		var_1.Stop(var_22_0)

		arg_22_0.delayTimer = nil
	end

	if arg_22_0.effectTimer then
		local var_22_1 = arg_22_0.effectTimer

		var_1.Stop(var_22_1)

		arg_22_0.effectTimer = nil
	end

	if arg_22_0.stateTimer then
		local var_22_2 = arg_22_0.stateTimer

		var_1.Stop(var_22_2)

		arg_22_0.stateTimer = nil
	end

	return
end

function var_0_1.DelegateSlotStartPerform(arg_23_0)
	local var_23_0 = arg_23_0.data

	var_1.StartDelegateSlotPerform(var_23_0)
	arg_23_0:InitProductItem()

	return
end

return var_0_1
