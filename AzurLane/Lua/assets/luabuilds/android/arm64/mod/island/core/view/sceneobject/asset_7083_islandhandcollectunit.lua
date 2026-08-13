class = var_0_10000

local var_0_0 = "IslandHandCollectUnit"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSlotBaseUnit"))

require = var_0_10001

local var_0_2 = var_0_10001("Framework.toLua.UnityEngine.Vector3")

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.slotData = arg_1_0.data.slotData
	pg = var_3
	arg_1_0.formulaId = var_3.island_production_slot[arg_1_0.slotData.configId].formula[1]
	pg = var_3
	arg_1_0.maxHp = var_3.island_formula[arg_1_0.formulaId].hitpoint
	arg_1_0.currentHp = arg_1_0.maxHp

	return
end

function var_0_1.OnAttach(arg_2_0, arg_2_1)
	var_0_1.super.OnAttach(arg_2_0, arg_2_1)

	arg_2_0._tf = arg_2_0._go.transform

	return
end

function var_0_1.OnStart(arg_3_0)
	arg_3_0:UpdateHandCollet()

	return
end

function var_0_1.LoadEffectItem(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.island_formula[arg_4_0.formulaId].collectable_vfx
	local var_4_1 = var_0_2(var_1.vfx_offset[1][1], var_1.vfx_offset[1][2], var_1.vfx_offset[1][3])

	Quaternion = var_1_10004

	local var_4_2 = var_1_10004.Euler(var_1.vfx_offset[2][1], var_1.vfx_offset[2][2], var_1.vfx_offset[2][3])

	pg = var_5
	arg_4_0.effectPath = var_5.island_unit_item[var_4_0].model

	local function var_4_3(arg_5_0)
		setParent = var_2_10001

		local var_5_0 = arg_5_0
		local var_5_1 = arg_4_0

		var_2_10001(var_5_0, var_4.GetView(var_5_1).root)

		arg_4_0.effectGo = arg_5_0

		local var_5_2 = arg_4_0.effectGo.transform
		local var_5_3 = arg_4_0._tf

		var_5_2.position = var_2.TransformPoint(var_5_3, var_4_1)
		arg_4_0.effectGo.transform.rotation = arg_4_0._tf.rotation * var_4_2

		return
	end

	arg_4_0:LoadSceneEffectItemRes(arg_4_0.effectPath, var_4_3)

	return
end

function var_0_1.UpdateHandCollet(arg_6_0)
	local var_6_0 = arg_6_0.slotData

	if var_1.GetCanCollectTimeStamps(var_6_0) <= 0 then
		arg_6_0.hasEffect = true

		arg_6_0:LoadEffectItem()
	else
		if arg_6_0.hasEffect and arg_6_0.effectGo then
			arg_6_0:UnLoadSceneItemRes(arg_6_0.effectPath, arg_6_0.effectGo)
		end

		arg_6_0.hasEffect = false
	end

	return
end

function var_0_1.GetToolId(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.island_production_slot[arg_7_0.slotData.configId].place

	pg = var_2

	local var_7_1 = var_2.island_production_place[var_7_0].tool_list
	local var_7_2

	getProxy = var_1_10004
	IslandProxy = var_1_10006

	local var_7_3 = var_1_10004(var_1_10006)
	local var_7_4 = var_4.GetIsland(var_7_3)
	local var_7_5 = var_4.GetAblityAgency(var_7_4)

	ipairs = var_1_10005

	for iter_7_0, iter_7_1 in var_1_10005(var_7_1) do
		pg = var_1_10010

		if var_1_10010.island_animation_attachments[iter_7_1].unlock == 0 then
			var_7_2 = iter_7_1
		end

		if var_7_5:IsUnlockCollectTool(iter_7_1) then
			var_7_2 = iter_7_1
		end
	end

	return var_7_2
end

function var_0_1.GetAnimatorTrigger(arg_8_0)
	pg = var_1_10001

	local var_8_0 = var_1_10001.island_production_slot[arg_8_0.slotData.configId].place

	IslandProductConst = var_2

	if var_8_0 == var_2.MinePlaceId then
		IslandConst = var_2

		return var_2.MINING_FLAG
	else
		IslandConst = var_2

		return var_2.LOP_FLAG
	end

	return
end

function var_0_1.TakeDamage(arg_9_0, arg_9_1)
	if arg_9_0.currentHp then
		arg_9_0.currentHp = arg_9_0.currentHp - arg_9_1
	end

	return
end

function var_0_1.ResetHp(arg_10_0)
	arg_10_0.currentHp = arg_10_0.maxHp

	return
end

function var_0_1.CheckCanStartColloct(arg_11_0)
	local var_11_0 = arg_11_0.slotData

	if not (var_1.GetCanCollectTimeStamps(var_11_0) == 0) then
		local var_11_1 = arg_11_0.slotData
		local var_11_2 = var_2.GetCanCollectTimeStamps(var_11_1)

		pg = var_11_0

		local var_11_3 = var_11_0.TimeMgr.GetInstance()
		local var_11_4 = var_11_2 - var_3.GetServerTime(var_11_3)
		local var_11_5 = (function(arg_12_0)
			math = var_2_10001

			local var_12_0 = var_2_10001.floor(arg_12_0 / 16)

			math = var_2_10002

			local var_12_1 = var_2_10002.floor(arg_12_0 % 16 / 60)
			local var_12_2 = arg_12_0 % 60

			string = var_4

			return var_4.format("%02d:%02d:%02d", var_12_0, var_12_1, var_12_2)
		end)(var_11_4)

		pg = var_1_10006

		local var_11_6 = var_1_10006.TipsMgr.GetInstance()
		local var_11_7 = var_6.ShowTips

		i18n = var_1_10009

		var_11_7(var_11_6, var_1_10009("island_production_log_recover", var_11_5))

		return false
	end

	return true
end

function var_0_1.GetHudInfo(arg_13_0)
	local var_13_0 = {}

	if not arg_13_0.slotData then
		var_13_0.needShowHud = false

		return var_13_0
	end

	var_13_0.needShowHud = true
	pg = var_2
	var_13_0.name = var_2.island_formula[arg_13_0.formulaId].name

	local var_13_1 = arg_13_0.slotData
	local var_13_2 = var_3.GetCanCollectTimeStamps(var_13_1) == 0 and 1 or 0

	string = var_1_10004
	var_13_0.numProcess = var_1_10004.format("%d/%d", var_13_2, 1)

	local var_13_3 = "island/"

	pg = var_13_1
	var_13_0.itemIcon = var_13_3 .. var_13_1.island_item_data_template[var_2.item_id].icon

	if var_13_2 == 0 then
		var_13_0.process = 0
	elseif arg_13_0.maxHp ~= 0 then
		var_13_0.process = arg_13_0.currentHp / arg_13_0.maxHp
	end

	return var_13_0
end

function var_0_1.TakeAttack(arg_14_0)
	pg = var_1_10001

	local var_14_0 = var_1_10001.island_formula[arg_14_0.formulaId].affected_vfx[1]
	local var_14_1 = arg_14_0
	local var_14_2 = arg_14_0.NotifiyIsland

	IslandProxy = var_1_10006

	local var_14_3 = var_1_10006.GEN_RECYCLEITEM
	local var_14_4 = {
		id = arg_14_0.id,
		unitId = var_14_0,
		position = arg_14_0.position,
		rotation = arg_14_0.rotation
	}

	IslandDelayRecycleUnitBuilder = var_8
	var_14_4.recycleAssetType = var_8.RecycleType.ProductEffect
	var_14_4.delayRecycleTime = var_1.affected_vfx[2]
	var_14_4.behaviourTree = {}

	var_14_2(var_14_1, var_14_3, var_14_4)

	if arg_14_0.maxHp ~= 0 then
		local var_14_5 = arg_14_0:GetToolId()

		pg = var_1_10004

		local var_14_6 = var_1_10004.island_animation_attachments[var_14_5].attack

		arg_14_0:TakeDamage(var_14_6)

		local var_14_7 = arg_14_0
		local var_14_8 = arg_14_0.NotifiyCore

		ISLAND_EVT = var_8

		local var_14_9 = var_8.UPDATE_HUD

		tonumber = var_1_10009

		var_14_8(var_14_7, var_14_9, var_1_10009(arg_14_0.id))

		if arg_14_0.currentHp < 0 then
			local var_14_10 = arg_14_0.slotData

			var_5.StartColloct(var_14_10)
		end
	else
		local var_14_11 = arg_14_0.slotData

		var_3.StartColloct(var_14_11)
	end

	return
end

function var_0_1.OnDispose(arg_15_0)
	var_0_1.super.OnDispose(arg_15_0)

	if arg_15_0.effectGo then
		arg_15_0:UnLoadSceneItemRes(arg_15_0.effectPath, arg_15_0.effectGo)
	end

	arg_15_0.hasEffect = false

	return
end

return var_0_1
