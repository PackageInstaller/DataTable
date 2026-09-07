local IslandSlotBaseUnit = class("IslandSlotBaseUnit", import(".IslandSceneUnit"))

function IslandSlotBaseUnit:Ctor(arg_1_1, arg_1_2)
	IslandSlotBaseUnit.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function IslandSlotBaseUnit:GetHudInfo()
	local var_2_0 = {}

	var_2_0.needShowHud = true

	return var_2_0
end

function IslandSlotBaseUnit:LoadSceneItemRes(arg_3_1, arg_3_2)
	self:GetPoolMgr():GetSceneProductItem(arg_3_1, arg_3_2)

	return
end

function IslandSlotBaseUnit:UnLoadSceneItemRes(arg_4_1, arg_4_2)
	self:GetPoolMgr():ReturnSceneProductItem(arg_4_1, arg_4_2)

	return
end

function IslandSlotBaseUnit:LoadSceneEffectItemRes(arg_5_1, arg_5_2)
	self:GetPoolMgr():GetSceneProductEffect(arg_5_1, arg_5_2)

	return
end

function IslandSlotBaseUnit:UnLoadSceneEffecttemRes(arg_6_1, arg_6_2)
	self:GetPoolMgr():ReturnSceneProductEffect(arg_6_1, arg_6_2)

	return
end

return IslandSlotBaseUnit
