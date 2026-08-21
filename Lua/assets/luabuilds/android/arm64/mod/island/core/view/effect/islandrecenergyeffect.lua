local var_0_0 = class("IslandRecEnergyEffect")

var_0_0.TYPE = 1

local var_0_1 = 5
local var_0_2 = Vector3(0, 2, 0)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.root = arg_1_1:Find("root")
	arg_1_0.tpl = arg_1_1:Find("tpls/RecEnergyTpl")

	setActive(arg_1_0.tpl, false)

	arg_1_0.pool = {}
	arg_1_0.active = {}

	return
end

function var_0_0.GetType(arg_2_0)
	return var_0_0.TYPE
end

function var_0_0.GetObject(arg_3_0)
	local var_3_0 = table.remove(arg_3_0.pool)

	if not var_3_0 or IsNil(var_3_0) then
		var_3_0 = Object.Instantiate(arg_3_0.tpl.gameObject)
	end

	var_3_0.transform:SetParent(arg_3_0.root, false)

	arg_3_0.active[var_3_0] = {
		expireTime = 0
	}

	setActive(var_3_0, true)

	return var_3_0, {
		expireTime = 0
	}
end

function var_0_0.Recycle(arg_4_0, arg_4_1)
	if not arg_4_1 or IsNil(arg_4_1) or not arg_4_0.active or not arg_4_0.active[arg_4_1] then
		return
	end

	arg_4_0.active[arg_4_1] = nil

	setActive(arg_4_1, false)
	arg_4_1.transform:SetParent(arg_4_0.root, false)

	arg_4_1.transform.localPosition = Vector3.zero

	table.insert(arg_4_0.pool, arg_4_1)

	return
end

function var_0_0.GetLocalPosition(arg_5_0, arg_5_1)
	return IslandCalcUtil.WorldPosition2LocalPosition(arg_5_0.root, arg_5_1._go.transform.position + var_0_2), arg_5_1._go.transform.position + var_0_2
end

function var_0_0.Play(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_1._go then
		return
	end

	local var_6_0, var_6_1 = arg_6_0:GetObject()

	var_6_1.unit = arg_6_1
	var_6_1.expireTime = Time.time + var_0_1
	var_6_0.transform.localPosition = arg_6_0:GetLocalPosition(arg_6_1)

	local var_6_2 = var_6_0.transform:Find("Text")

	if var_6_2 then
		local var_6_4 = var_6_2

		if arg_6_2 then
			local var_6_5 = arg_6_2.value or 0

			var_6_3(var_6_4, var_6_5)

			return
		end
	end
end

function var_0_0.Update(arg_7_0)
	local var_7_0 = arg_7_0.active or {}

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if IsNil(iter_7_0) then
			arg_7_0.active[iter_7_0] = nil
		elseif Time.time >= iter_7_1.expireTime or not iter_7_1.unit or IsNil(iter_7_1.unit._go) then
			arg_7_0:Recycle(iter_7_0)
		else
			local var_7_1, var_7_2 = arg_7_0:GetLocalPosition(iter_7_1.unit)
			local var_7_3 = IslandCalcUtil.IsInViewport(var_7_2)

			setActive(iter_7_0, var_7_3)

			if var_7_3 then
				iter_7_0.transform.localPosition = var_7_1
			end
		end
	end

	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0.active = nil
	arg_8_0.pool = nil
	arg_8_0.root = nil
	arg_8_0.tpl = nil

	return
end

return var_0_0
