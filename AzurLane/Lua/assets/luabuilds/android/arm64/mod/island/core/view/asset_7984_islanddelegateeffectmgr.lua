class = var_0_10000

local var_0_0 = "IslandDelegateEffectMgr"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2
	arg_1_0.effectPath = var_2.island_unit_item[1018].model
	pg = var_2
	arg_1_0.selectEffectPath = var_2.island_unit_item[1019].model
	arg_1_0.effectDic = {}
	arg_1_0.effectIsShow = {}

	return
end

function var_0_1.LoadDelegatePreviewRole(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.modelData = arg_2_1
	pg = var_1_10003

	local var_2_0 = var_1_10003.island_world_objects[arg_2_2].param.position

	Vector3 = var_1_10004

	local var_2_1 = var_1_10004(var_2_0[1], var_2_0[2], var_2_0[3])

	pg = var_1_10005

	local var_2_2 = var_1_10005.island_world_objects[arg_2_2].param.rotation

	Vector3 = var_6

	local var_2_3 = var_6(var_2_2[1], var_2_2[2], var_2_2[3])
	local var_2_4 = arg_2_0:GetPoolMgr()

	var_7.GetCharacter(var_2_4, arg_2_1.model, arg_2_1.animator, function(arg_3_0)
		arg_2_0.role = arg_3_0
		arg_2_0.role.transform.eulerAngles = var_2_3

		local var_3_0 = arg_2_0.role.transform

		var_3_0.position = var_2_1
		pg = var_3_0

		local var_3_1 = var_3_0.island_set.delegate_role_transparency.key_value_int / 100

		GraphicsInterface = var_2

		local var_3_2 = var_2.Instance
		local var_3_3 = var_2.SetSelectedTransparency
		local var_3_4 = arg_2_0.role.transform

		var_3_3(var_3_2, var_5.GetChild(var_3_4, 0).gameObject, var_3_1, true)

		return
	end)

	return
end

function var_0_1.UnLoadDelegatePreviewRole(arg_4_0)
	if arg_4_0.role then
		GraphicsInterface = var_1

		local var_4_0 = var_1.Instance
		local var_4_1 = var_1.SetSelectedTransparency
		local var_4_2 = arg_4_0.role.transform

		var_4_1(var_4_0, var_4.GetChild(var_4_2, 0).gameObject, 0, false)

		local var_4_3 = arg_4_0:GetPoolMgr()

		var_1.ReturnCharacter(var_4_3, arg_4_0.modelData.model, arg_4_0.modelData.animator, arg_4_0.role)

		arg_4_0.modelData = nil
		arg_4_0.role = nil
	end

	return
end

function var_0_1.UpdatePositionAndRotation(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_1.transform.rotation = arg_5_3
	arg_5_1.transform.position = arg_5_2

	return
end

function var_0_1.SelectSlotEffectShow(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	local var_6_0 = arg_6_1 == arg_6_2

	arg_6_0.effectIsShow[arg_6_1] = var_6_0

	if not var_6_0 then
		if arg_6_0.effectDic[arg_6_1] then
			setActive = var_1_10007

			var_1_10007(var_6, true)
			arg_6_0:UpdatePositionAndRotation(var_6, arg_6_3, arg_6_4)

			return
		end

		local var_6_1 = arg_6_0:GetPoolMgr()

		var_7.GetDelegateEffect(var_6_1, arg_6_0.effectPath, function(arg_7_0)
			if arg_6_0.effectIsShow[arg_6_1] then
				return
			end

			setParent = var_1

			local var_7_0 = arg_7_0
			local var_7_1 = arg_6_0

			var_1(var_7_0, var_4.GetView(var_7_1).root)

			arg_6_0.effectDic[arg_6_1] = arg_7_0

			local var_7_2 = arg_6_0

			var_1.UpdatePositionAndRotation(var_7_2, arg_7_0, arg_6_3, arg_6_4)

			return
		end)
	else
		if arg_6_0.effectDic[arg_6_1] then
			setActive = var_6

			var_6(arg_6_0.effectDic[arg_6_1], false)
		end

		if arg_6_0.selectEffect then
			arg_6_0:UpdatePositionAndRotation(arg_6_0.selectEffect, arg_6_3, arg_6_4)

			return
		end

		local var_6_2 = arg_6_0:GetPoolMgr()

		var_6.GetDelegateEffect(var_6_2, arg_6_0.selectEffectPath, function(arg_8_0)
			if not arg_6_0.effectIsShow[arg_6_1] then
				return
			end

			setParent = var_1

			local var_8_0 = arg_8_0
			local var_8_1 = arg_6_0

			var_1(var_8_0, var_4.GetView(var_8_1).root)

			arg_6_0.selectEffect = arg_8_0

			local var_8_2 = arg_6_0

			var_1.UpdatePositionAndRotation(var_8_2, arg_8_0, arg_6_3, arg_6_4)

			return
		end)
	end

	return
end

function var_0_1.RecycleAllSlotEffct(arg_9_0)
	pairs = var_1_10001

	for iter_9_0, iter_9_1 in var_1_10001(arg_9_0.effectIsShow) do
		var_1_10006 = arg_9_0.effectIsShow
		var_1_10006[iter_9_0] = false
	end

	arg_9_0.effectIsShow = {}
	pairs = var_1

	for iter_9_2, iter_9_3 in var_1(arg_9_0.effectDic) do
		IsNil = var_1_10006

		if not var_1_10006(iter_9_3) then
			local var_9_0 = arg_9_0:GetPoolMgr()

			var_1_10006.ReturnDelegateEffect(var_9_0, arg_9_0.effectPath, iter_9_3)
		end
	end

	arg_9_0.effectDic = {}
	IsNil = var_1

	if not var_1(arg_9_0.selectEffect) then
		local var_9_1 = arg_9_0:GetPoolMgr()

		var_1.ReturnDelegateEffect(var_9_1, arg_9_0.selectEffect, arg_9_0.selectEffect)
	end

	arg_9_0.selectEffect = nil

	return
end

function var_0_1.OnDestroy(arg_10_0)
	arg_10_0:RecycleAllSlotEffct()

	return
end

return var_0_1
