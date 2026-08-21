local var_0_0 = class("IslandHandCollectUnit", import(".IslandSlotBaseUnit"))
local var_0_1 = require("Framework.toLua.UnityEngine.Vector3")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.slotData = arg_1_0.data.slotData
	arg_1_0.formulaId = pg.island_production_slot[arg_1_0.slotData.configId].formula[1]
	arg_1_0.maxHp = pg.island_formula[arg_1_0.formulaId].hitpoint
	arg_1_0.currentHp = arg_1_0.maxHp

	return
end

function var_0_0.OnAttach(arg_2_0, arg_2_1)
	var_0_0.super.OnAttach(arg_2_0, arg_2_1)

	arg_2_0._tf = arg_2_0._go.transform

	return
end

function var_0_0.OnStart(arg_3_0)
	arg_3_0:UpdateHandCollet()

	return
end

function var_0_0.LoadEffectItem(arg_4_0)
	local var_4_0 = var_0_1(pg.island_formula[arg_4_0.formulaId].vfx_offset[1][1], pg.island_formula[arg_4_0.formulaId].vfx_offset[1][2], pg.island_formula[arg_4_0.formulaId].vfx_offset[1][3])
	local var_4_1 = Quaternion.Euler(pg.island_formula[arg_4_0.formulaId].vfx_offset[2][1], pg.island_formula[arg_4_0.formulaId].vfx_offset[2][2], pg.island_formula[arg_4_0.formulaId].vfx_offset[2][3])

	arg_4_0.effectPath = pg.island_unit_item[pg.island_formula[arg_4_0.formulaId].collectable_vfx].model

	arg_4_0:LoadSceneEffectItemRes(arg_4_0.effectPath, function(arg_5_0)
		setParent(arg_5_0, arg_4_0:GetView().root)

		arg_4_0.effectGo = arg_5_0
		arg_4_0.effectGo.transform.position = arg_4_0._tf:TransformPoint(var_4_0)
		arg_4_0.effectGo.transform.rotation = arg_4_0._tf.rotation * var_4_1

		return
	end)

	return
end

function var_0_0.UpdateHandCollet(arg_6_0)
	if arg_6_0.slotData:GetCanCollectTimeStamps() <= 0 then
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

function var_0_0.GetToolId(arg_7_0)
	local var_7_0
	local var_7_1 = getProxy(IslandProxy):GetIsland():GetAblityAgency()

	for iter_7_0, iter_7_1 in ipairs(pg.island_production_place[pg.island_production_slot[arg_7_0.slotData.configId].place].tool_list) do
		if pg.island_animation_attachments[iter_7_1].unlock == 0 then
			var_7_0 = iter_7_1
		end

		if var_7_1:IsUnlockCollectTool(iter_7_1) then
			var_7_0 = iter_7_1
		end
	end

	return var_7_0
end

function var_0_0.GetAnimatorTrigger(arg_8_0)
	if pg.island_production_slot[arg_8_0.slotData.configId].place == IslandProductConst.MinePlaceId then
		return IslandConst.MINING_FLAG
	else
		return IslandConst.LOP_FLAG
	end

	return
end

function var_0_0.TakeDamage(arg_9_0, arg_9_1)
	if arg_9_0.currentHp then
		arg_9_0.currentHp = arg_9_0.currentHp - arg_9_1
	end

	return
end

function var_0_0.ResetHp(arg_10_0)
	arg_10_0.currentHp = arg_10_0.maxHp

	return
end

function var_0_0.CheckCanStartColloct(arg_11_0)
	if arg_11_0.slotData:GetCanCollectTimeStamps() ~= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_production_log_recover", ((function(arg_12_0)
			return string.format("%02d:%02d:%02d", math.floor(arg_12_0 / 16), math.floor(arg_12_0 % 16 / 60), arg_12_0 % 60)
		end)(arg_11_0.slotData:GetCanCollectTimeStamps() - pg.TimeMgr.GetInstance():GetServerTime()))))

		return false
	end

	return true
end

function var_0_0.GetHudInfo(arg_13_0)
	if not arg_13_0.slotData then
		({}).needShowHud = false

		return {}
	end

	;({}).needShowHud = true

	local var_13_0 = pg.island_formula[arg_13_0.formulaId]

	;({}).name = pg.island_formula[arg_13_0.formulaId].name

	local var_13_1 = arg_13_0.slotData:GetCanCollectTimeStamps() == 0 and 1 or 0

	;({}).numProcess = string.format("%d/%d", var_13_1, 1)
	;({}).itemIcon = "island/" .. pg.island_item_data_template[var_13_0.item_id].icon

	if var_13_1 == 0 then
		({}).process = 0
	elseif arg_13_0.maxHp ~= 0 then
		({}).process = arg_13_0.currentHp / arg_13_0.maxHp
	end

	return {}
end

function var_0_0.TakeAttack(arg_14_0)
	arg_14_0:NotifiyIsland(IslandProxy.GEN_RECYCLEITEM, {
		id = arg_14_0.id,
		unitId = pg.island_formula[arg_14_0.formulaId].affected_vfx[1],
		position = arg_14_0.position,
		rotation = arg_14_0.rotation,
		recycleAssetType = IslandDelayRecycleUnitBuilder.RecycleType.ProductEffect,
		delayRecycleTime = pg.island_formula[arg_14_0.formulaId].affected_vfx[2],
		behaviourTree = {}
	})

	if arg_14_0.maxHp ~= 0 then
		arg_14_0:TakeDamage(pg.island_animation_attachments[arg_14_0:GetToolId()].attack)
		arg_14_0:NotifiyCore(ISLAND_EVT.UPDATE_HUD, tonumber(arg_14_0.id))

		if arg_14_0.currentHp < 0 then
			arg_14_0.slotData:StartColloct()
		end
	else
		arg_14_0.slotData:StartColloct()
	end

	return
end

function var_0_0.OnDispose(arg_15_0)
	var_0_0.super.OnDispose(arg_15_0)

	if arg_15_0.effectGo then
		arg_15_0:UnLoadSceneItemRes(arg_15_0.effectPath, arg_15_0.effectGo)
	end

	arg_15_0.hasEffect = false

	return
end

return var_0_0
