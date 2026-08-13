class = var_0_10000

local var_0_0 = "IslandSlotBaseUnit"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSceneUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.GetHudInfo(arg_2_0)
	local var_2_0 = {}

	var_2_0.needShowHud = true

	return var_2_0
end

function var_0_1.LoadSceneItemRes(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetPoolMgr()

	var_3.GetSceneProductItem(var_3_0, arg_3_1, arg_3_2)

	return
end

function var_0_1.UnLoadSceneItemRes(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:GetPoolMgr()

	var_3.ReturnSceneProductItem(var_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_1.LoadSceneEffectItemRes(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:GetPoolMgr()

	var_3.GetSceneProductEffect(var_5_0, arg_5_1, arg_5_2)

	return
end

function var_0_1.UnLoadSceneEffecttemRes(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:GetPoolMgr()

	var_3.ReturnSceneProductEffect(var_6_0, arg_6_1, arg_6_2)

	return
end

return var_0_1
