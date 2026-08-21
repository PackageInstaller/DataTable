local var_0_0 = class("IslandDelegateEffectMgr", import(".IslandBaseUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.effectPath = pg.island_unit_item[1018].model
	arg_1_0.selectEffectPath = pg.island_unit_item[1019].model
	arg_1_0.effectDic = {}
	arg_1_0.effectIsShow = {}

	return
end

function var_0_0.LoadDelegatePreviewRole(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.modelData = arg_2_1

	local var_2_0 = Vector3(pg.island_world_objects[arg_2_2].param.position[1], pg.island_world_objects[arg_2_2].param.position[2], pg.island_world_objects[arg_2_2].param.position[3])
	local var_2_1 = Vector3(pg.island_world_objects[arg_2_2].param.rotation[1], pg.island_world_objects[arg_2_2].param.rotation[2], pg.island_world_objects[arg_2_2].param.rotation[3])

	arg_2_0:GetPoolMgr():GetCharacter(arg_2_1.model, arg_2_1.animator, function(arg_3_0)
		arg_2_0.role = arg_3_0
		arg_2_0.role.transform.eulerAngles = var_2_1
		arg_2_0.role.transform.position = var_2_0

		GraphicsInterface.Instance:SetSelectedTransparency(arg_2_0.role.transform:GetChild(0).gameObject, pg.island_set.delegate_role_transparency.key_value_int / 100, true)

		return
	end)

	return
end

function var_0_0.UnLoadDelegatePreviewRole(arg_4_0)
	if arg_4_0.role then
		GraphicsInterface.Instance:SetSelectedTransparency(arg_4_0.role.transform:GetChild(0).gameObject, 0, false)
		arg_4_0:GetPoolMgr():ReturnCharacter(arg_4_0.modelData.model, arg_4_0.modelData.animator, arg_4_0.role)

		arg_4_0.modelData = nil
		arg_4_0.role = nil
	end

	return
end

function var_0_0.UpdatePositionAndRotation(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_1.transform.rotation = arg_5_3
	arg_5_1.transform.position = arg_5_2

	return
end

function var_0_0.SelectSlotEffectShow(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_1 == arg_6_2

	arg_6_0.effectIsShow[arg_6_1] = arg_6_1 == arg_6_2

	if not var_6_0 then
		if arg_6_0.effectDic[arg_6_1] then
			setActive(arg_6_0.effectDic[arg_6_1], true)
			arg_6_0:UpdatePositionAndRotation(arg_6_0.effectDic[arg_6_1], arg_6_3, arg_6_4)

			return
		end

		arg_6_0:GetPoolMgr():GetDelegateEffect(arg_6_0.effectPath, function(arg_7_0)
			if arg_6_0.effectIsShow[arg_6_1] then
				return
			end

			setParent(arg_7_0, arg_6_0:GetView().root)

			arg_6_0.effectDic[arg_6_1] = arg_7_0

			arg_6_0:UpdatePositionAndRotation(arg_7_0, arg_6_3, arg_6_4)

			return
		end)
	else
		if arg_6_0.effectDic[arg_6_1] then
			setActive(arg_6_0.effectDic[arg_6_1], false)
		end

		if arg_6_0.selectEffect then
			arg_6_0:UpdatePositionAndRotation(arg_6_0.selectEffect, arg_6_3, arg_6_4)

			return
		end

		arg_6_0:GetPoolMgr():GetDelegateEffect(arg_6_0.selectEffectPath, function(arg_8_0)
			if not arg_6_0.effectIsShow[arg_6_1] then
				return
			end

			setParent(arg_8_0, arg_6_0:GetView().root)

			arg_6_0.selectEffect = arg_8_0

			arg_6_0:UpdatePositionAndRotation(arg_8_0, arg_6_3, arg_6_4)

			return
		end)
	end

	return
end

function var_0_0.RecycleAllSlotEffct(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.effectIsShow) do
		arg_9_0.effectIsShow[iter_9_0] = false
	end

	arg_9_0.effectIsShow = {}

	for iter_9_2, iter_9_3 in pairs(arg_9_0.effectDic) do
		if not IsNil(iter_9_3) then
			arg_9_0:GetPoolMgr():ReturnDelegateEffect(arg_9_0.effectPath, iter_9_3)
		end
	end

	arg_9_0.effectDic = {}

	if not IsNil(arg_9_0.selectEffect) then
		arg_9_0:GetPoolMgr():ReturnDelegateEffect(arg_9_0.selectEffect, arg_9_0.selectEffect)
	end

	arg_9_0.selectEffect = nil

	return
end

function var_0_0.OnDestroy(arg_10_0)
	arg_10_0:RecycleAllSlotEffct()

	return
end

return var_0_0
