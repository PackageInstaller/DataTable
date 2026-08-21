local var_0_0 = class("IslandBottomHeadHudView", import(".IslandBaseHudView"))

function var_0_0.GetUIName(arg_1_0)
	return "IslandTopHeadHudUI"
end

function var_0_0.GetHeadOffset(arg_2_0)
	return Vector3(0.5, 1.5, 0)
end

function var_0_0.OnInit(arg_3_0, arg_3_1)
	arg_3_0.animationOpTpl = arg_3_0._tf:Find("tpls/IslandNpcAnimationOpTpl")
	arg_3_0.animationOpTpls = {}
	arg_3_0.animationOpShowFlags = {}
	arg_3_0.animationOpShowDistance = pg.island_set.action_bubble_range.key_value_int

	var_0_0.super.OnInit(arg_3_0, arg_3_1)

	return
end

function var_0_0.OnLateUpdate(arg_4_0)
	var_0_0.super.OnLateUpdate(arg_4_0)

	local var_4_0 = arg_4_0:GetView().player

	if var_4_0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.animationOpShowFlags) do
			local var_4_1 = arg_4_0.animationOpTpls[iter_4_1]
			local var_4_2 = arg_4_0:UnitKey2unitData(iter_4_1)
			local var_4_3 = arg_4_0:GetView():GetUnitModuleWithType(var_4_2.type, var_4_2.id)

			if var_4_3 then
				setActive(var_4_1, Vector3.Distance(var_4_0._go.transform.position, var_4_3._go.transform.position) <= arg_4_0.animationOpShowDistance)
			end
		end
	end

	return
end

function var_0_0.UpdateTplPosition(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_0.super.UpdateTplPosition(arg_5_0, arg_5_1, arg_5_2, arg_5_3)

	local var_5_0 = IslandCalcUtil.IsBehindCamera(arg_5_1.transform.forward)

	arg_5_2.transform.localScale = Vector3(var_5_0 and -1 or 1, 1, 1)

	local var_5_1 = arg_5_2.transform:Find("aniamtionOpContainer"):GetChild(0)

	var_5_1:Find("Image").localScale = Vector3(var_5_0 and -1 or 1, 1, 1)

	return
end

function var_0_0.ShowAnimationOp(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:GenUnitData(arg_6_1.id, arg_6_1.unitType)
	local var_6_1 = arg_6_0:GetUnitHudRoot(var_6_0):Find("aniamtionOpContainer")
	local var_6_2 = arg_6_0.animationOpTpls[var_6_0.key] or Object.Instantiate(arg_6_0.animationOpTpl, var_6_1)

	setParent(var_6_2, var_6_1)
	setActive(var_6_2, true)
	assert(pg.island_action[arg_6_2], "island_action>>>>" .. arg_6_2)
	LoadImageSpriteAsync("island/IslandActionIcon/" .. pg.island_action[arg_6_2].resource, var_6_2.transform:Find("Image"), false)

	arg_6_0.animationOpTpls[var_6_0.key] = var_6_2

	table.insert(arg_6_0.animationOpShowFlags, var_6_0.key)
	setActive(var_6_2.transform:Find("effect"), false)

	return
end

function var_0_0.UpdateAnimationOpEffect(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0, var_7_1 = IslandCalcUtil.GetTypeAndIdByUniqueId(arg_7_1)
	local var_7_2 = arg_7_0.animationOpTpls[arg_7_0:GenUnitData(var_7_1, var_7_0).key]

	if not var_7_2 then
		return
	end

	setActive(var_7_2.transform:Find("effect"), arg_7_2)

	return
end

function var_0_0.HideAnimationOp(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:GenUnitData(arg_8_1.id, arg_8_1.unitType)

	table.removebyvalue(arg_8_0.animationOpShowFlags, var_8_0.key)

	if not arg_8_0.animationOpTpls[var_8_0.key] then
		return
	end

	setActive(arg_8_0.animationOpTpls[var_8_0.key], false)
	setActive(arg_8_0.animationOpTpls[var_8_0.key].transform:Find("effect"), false)

	return
end

function var_0_0.OnDispose(arg_9_0)
	var_0_0.super.OnDispose(arg_9_0)

	for iter_9_0, iter_9_1 in pairs(arg_9_0.animationOpTpls) do
		Object.Destroy(iter_9_1)
	end

	arg_9_0.animationOpTpls = nil
	arg_9_0.animationOpShowFlags = nil

	return
end

return var_0_0
