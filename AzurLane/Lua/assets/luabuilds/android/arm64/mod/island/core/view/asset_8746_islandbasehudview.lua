class = var_0_10000

local var_0_0 = "IslandBaseHudView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseOpView"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.parent = var_2.Find(var_1_0, "parent")

	local var_1_1 = arg_1_0._tf

	arg_1_0.unitHudRoot = var_2.Find(var_1_1, "parent/unitHud")
	arg_1_0.unitHudDic = {}
	arg_1_0.views = {}

	arg_1_0:SubViewInit()

	return
end

function var_0_1.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().hudContainer
end

function var_0_1.GetSubView(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.views) do
		isa = var_1_10007

		if var_1_10007(iter_3_1, arg_3_1) then
			return iter_3_1
		end
	end

	return nil
end

function var_0_1.OnUpdate(arg_4_0)
	ipairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.views) do
		iter_4_1:Update()
	end

	return
end

function var_0_1.OnLateUpdate(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.unitHudDic) do
		local var_5_0 = arg_5_0:UnitKey2unitData(iter_5_0)
		local var_5_1 = arg_5_0:GetView()
		local var_5_2

		if not var_7.GetUnitModuleWithType(var_5_1, var_5_0.type, var_5_0.id) or not var_7._go then
			var_5_2 = nil
		end

		if var_7 then
			IsNil = var_5_1

			if not var_5_1(var_5_2) then
				local var_5_3 = var_5_2.transform.position + arg_5_0:GetHeadOffset() * var_5_2.transform.rotation

				IslandCalcUtil = var_10

				local var_5_4 = var_10.IsInViewport(var_5_3)

				setActive = var_11

				var_11(iter_5_1, var_5_4)

				if var_5_4 then
					arg_5_0:UpdateTplPosition(var_5_2, iter_5_1, var_5_3)
				end
			end
		end
	end

	return
end

function var_0_1.UpdateTplPosition(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	IslandCalcUtil = var_1_10004

	local var_6_0 = var_1_10004.WorldPosition2LocalPosition(arg_6_0.parent, arg_6_3)

	arg_6_2.transform.localPosition = var_6_0

	return
end

function var_0_1.GetUnitHudRoot(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.unitHudDic[arg_7_1.key]

	IsNil = var_3

	if var_3(var_7_0) then
		Object = var_3
		var_7_0 = var_3.Instantiate(arg_7_0.unitHudRoot, arg_7_0.parent)
		var_7_0.name = arg_7_1.key
		setActive = var_3

		var_3(var_7_0, true)

		arg_7_0.unitHudDic[arg_7_1.key] = var_7_0
	end

	return var_7_0.transform
end

function var_0_1.GenUnitData(arg_8_0, arg_8_1, arg_8_2)
	return {
		id = arg_8_1,
		type = arg_8_2,
		key = arg_8_2 .. "_" .. arg_8_1
	}
end

function var_0_1.UnitKey2unitData(arg_9_0, arg_9_1)
	string = var_1_10002

	local var_9_0 = var_1_10002.split(arg_9_1, "_")
	local var_9_1 = {}

	tonumber = var_4
	var_9_1.id = var_4(var_9_0[2])
	tonumber = var_4
	var_9_1.type = var_4(var_9_0[1])

	return var_9_1
end

function var_0_1.OnDispose(arg_10_0)
	var_0_1.super.OnDispose(arg_10_0)

	pairs = var_1

	for iter_10_0, iter_10_1 in var_1(arg_10_0.unitHudDic) do
		Object = var_1_10006

		var_1_10006.Destroy(iter_10_1.gameObject)
	end

	arg_10_0.unitHudDic = nil

	return
end

function var_0_1.SubViewInit(arg_11_0)
	return
end

function var_0_1.GetHeadOffset(arg_12_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me!!!!")

	return
end

return var_0_1
