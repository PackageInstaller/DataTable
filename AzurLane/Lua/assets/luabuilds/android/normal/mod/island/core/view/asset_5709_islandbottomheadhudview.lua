class = var_0_10000

local var_0_0 = "IslandBottomHeadHudView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseHudView"))

function var_0_1.GetUIName(arg_1_0)
	return "IslandTopHeadHudUI"
end

function var_0_1.GetHeadOffset(arg_2_0)
	Vector3 = var_1_10001

	return var_1_10001(0.5, 1.5, 0)
end

function var_0_1.OnInit(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._tf

	arg_3_0.animationOpTpl = var_2.Find(var_3_0, "tpls/IslandNpcAnimationOpTpl")
	arg_3_0.animationOpTpls = {}
	arg_3_0.animationOpShowFlags = {}
	pg = var_2
	arg_3_0.animationOpShowDistance = var_2.island_set.action_bubble_range.key_value_int

	var_0_1.super.OnInit(arg_3_0, arg_3_1)

	return
end

function var_0_1.OnLateUpdate(arg_4_0)
	var_0_1.super.OnLateUpdate(arg_4_0)

	local var_4_0 = arg_4_0

	if arg_4_0.GetView(var_4_0).player then
		ipairs = var_4_0

		for iter_4_0, iter_4_1 in var_4_0(arg_4_0.animationOpShowFlags) do
			local var_4_1 = arg_4_0.animationOpTpls[iter_4_1]
			local var_4_2 = arg_4_0:UnitKey2unitData(iter_4_1)
			local var_4_3 = arg_4_0:GetView()

			if var_9.GetUnitModuleWithType(var_4_3, var_4_2.type, var_4_2.id) then
				Vector3 = var_4_3

				local var_4_4 = var_4_3.Distance(var_1._go.transform.position, var_9._go.transform.position) <= arg_4_0.animationOpShowDistance

				setActive = var_11

				var_11(var_4_1, var_4_4)
			end
		end
	end

	return
end

function var_0_1.UpdateTplPosition(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	var_0_1.super.UpdateTplPosition(arg_5_0, arg_5_1, arg_5_2, arg_5_3)

	IslandCalcUtil = var_4

	local var_5_0 = var_4.IsBehindCamera(arg_5_1.transform.forward)
	local var_5_1 = arg_5_2.transform

	Vector3 = var_6
	var_5_1.localScale = var_6(var_5_0 and -1 or 1, 1, 1)

	local var_5_2 = arg_5_2.transform
	local var_5_3 = var_5.Find(var_5_2, "aniamtionOpContainer")
	local var_5_4 = var_5.GetChild(var_5_3, 0)
	local var_5_5 = var_5.Find(var_5_4, "Image")

	Vector3 = var_5_4
	var_5_5.localScale = var_5_4(var_5_0 and -1 or 1, 1, 1)

	return
end

function var_0_1.ShowAnimationOp(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:GenUnitData(arg_6_1.id, arg_6_1.unitType)
	local var_6_1 = arg_6_0:GetUnitHudRoot(var_6_0)
	local var_6_2 = var_4.Find(var_6_1, "aniamtionOpContainer")
	local var_6_3

	if not arg_6_0.animationOpTpls[var_6_0.key] then
		Object = var_6_3
		var_6_3 = var_6_3.Instantiate(arg_6_0.animationOpTpl, var_6_2)
	end

	setParent = var_6

	var_6(var_6_3, var_6_2)

	setActive = var_6

	var_6(var_6_3, true)

	pg = var_6

	local var_6_4 = var_6.island_action[arg_6_2]

	assert = var_7

	var_7(var_6_4, "island_action>>>>" .. arg_6_2)

	LoadImageSpriteAsync = var_7

	local var_6_5 = "island/IslandActionIcon/" .. var_6_4.resource
	local var_6_6 = var_6_3.transform

	var_7(var_6_5, var_9.Find(var_6_6, "Image"), false)

	local var_6_7 = arg_6_0.animationOpTpls

	var_6_7[var_6_0.key] = var_6_3
	table = var_6_7

	var_6_7.insert(arg_6_0.animationOpShowFlags, var_6_0.key)

	setActive = var_7

	local var_6_8 = var_6_3.transform

	var_7(var_8.Find(var_6_8, "effect"), false)

	return
end

function var_0_1.UpdateAnimationOpEffect(arg_7_0, arg_7_1, arg_7_2)
	IslandCalcUtil = var_1_10003

	local var_7_0, var_7_1 = var_1_10003.GetTypeAndIdByUniqueId(arg_7_1)
	local var_7_2 = arg_7_0:GenUnitData(var_7_1, var_7_0)

	if not arg_7_0.animationOpTpls[var_7_2.key] then
		return
	end

	setActive = var_7

	local var_7_3 = var_6.transform

	var_7(var_8.Find(var_7_3, "effect"), arg_7_2)

	return
end

function var_0_1.HideAnimationOp(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.GenUnitData(var_8_0, arg_8_1.id, arg_8_1.unitType)

	table = var_8_0

	var_8_0.removebyvalue(arg_8_0.animationOpShowFlags, var_8_1.key)

	if not arg_8_0.animationOpTpls[var_8_1.key] then
		return
	end

	setActive = var_4

	var_4(var_3, false)

	setActive = var_4

	local var_8_2 = var_3.transform

	var_4(var_5.Find(var_8_2, "effect"), false)

	return
end

function var_0_1.OnDispose(arg_9_0)
	var_0_1.super.OnDispose(arg_9_0)

	pairs = var_1

	for iter_9_0, iter_9_1 in var_1(arg_9_0.animationOpTpls) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_9_1)
	end

	arg_9_0.animationOpTpls = nil
	arg_9_0.animationOpShowFlags = nil

	return
end

return var_0_1
