local var_0_0 = class("IslandBaseHudView", import(".IslandBaseOpView"))

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.parent = arg_1_0._tf:Find("parent")
	arg_1_0.unitHudRoot = arg_1_0._tf:Find("parent/unitHud")
	arg_1_0.unitHudDic = {}
	arg_1_0.views = {}

	arg_1_0:SubViewInit()

	return
end

function var_0_0.GetUIParent(arg_2_0, arg_2_1)
	return arg_2_0:GetView().hudContainer
end

function var_0_0.GetSubView(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.views) do
		if isa(iter_3_1, arg_3_1) then
			return iter_3_1
		end
	end

	return nil
end

function var_0_0.OnUpdate(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.views) do
		iter_4_1:Update()
	end

	return
end

function var_0_0.OnLateUpdate(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.unitHudDic) do
		local var_5_0 = arg_5_0:UnitKey2unitData(iter_5_0)
		local var_5_1 = arg_5_0:GetView():GetUnitModuleWithType(var_5_0.type, var_5_0.id)

		if var_5_1 then
			local var_5_2 = var_5_1._go or nil

			if var_5_1 and not IsNil(var_5_2) then
				local var_5_3 = var_5_2.transform.position + arg_5_0:GetHeadOffset() * var_5_2.transform.rotation
				local var_5_4 = IslandCalcUtil.IsInViewport(var_5_3)

				setActive(iter_5_1, var_5_4)

				if var_5_4 then
					arg_5_0:UpdateTplPosition(var_5_2, iter_5_1, var_5_3)
				end
			end
		end
	end

	return
end

function var_0_0.UpdateTplPosition(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_2.transform.localPosition = IslandCalcUtil.WorldPosition2LocalPosition(arg_6_0.parent, arg_6_3)

	return
end

function var_0_0.GetUnitHudRoot(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.unitHudDic[arg_7_1.key]

	if IsNil(arg_7_0.unitHudDic[arg_7_1.key]) then
		var_7_0 = Object.Instantiate(arg_7_0.unitHudRoot, arg_7_0.parent)
		var_7_0.name = arg_7_1.key

		setActive(var_7_0, true)

		arg_7_0.unitHudDic[arg_7_1.key] = var_7_0
	end

	return var_7_0.transform
end

function var_0_0.GenUnitData(arg_8_0, arg_8_1, arg_8_2)
	return {
		id = arg_8_1,
		type = arg_8_2,
		key = arg_8_2 .. "_" .. arg_8_1
	}
end

function var_0_0.UnitKey2unitData(arg_9_0, arg_9_1)
	local var_9_0 = string.split(arg_9_1, "_")

	return {
		id = tonumber(var_9_0[2]),
		type = tonumber(var_9_0[1])
	}
end

function var_0_0.OnDispose(arg_10_0)
	var_0_0.super.OnDispose(arg_10_0)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.unitHudDic) do
		Object.Destroy(iter_10_1.gameObject)
	end

	arg_10_0.unitHudDic = nil

	return
end

function var_0_0.SubViewInit(arg_11_0)
	return
end

function var_0_0.GetHeadOffset(arg_12_0)
	assert(false, "overwrite me!!!!")

	return
end

return var_0_0
