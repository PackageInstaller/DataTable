local var_0_0 = class("IslandSlotBaseUnit", import(".IslandSceneUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_0.GetHudInfo(arg_2_0)
	({}).needShowHud = true

	return {}
end

function var_0_0.LoadSceneItemRes(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:GetPoolMgr():GetSceneProductItem(arg_3_1, arg_3_2)

	return
end

function var_0_0.UnLoadSceneItemRes(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:GetPoolMgr():ReturnSceneProductItem(arg_4_1, arg_4_2)

	return
end

function var_0_0.LoadSceneEffectItemRes(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:GetPoolMgr():GetSceneProductEffect(arg_5_1, arg_5_2)

	return
end

function var_0_0.UnLoadSceneEffecttemRes(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:GetPoolMgr():ReturnSceneProductEffect(arg_6_1, arg_6_2)

	return
end

return var_0_0
