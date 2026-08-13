class = var_0_10000

local var_0_0 = var_0_10000("IslandRecEnergyEffect")

var_0_0.TYPE = 1

local var_0_1 = 5

Vector3 = var_0_10002

local var_0_2 = var_0_10002(0, 2, 0)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.root = arg_1_1:Find("root")
	arg_1_0.tpl = arg_1_1:Find("tpls/RecEnergyTpl")
	setActive = var_2

	var_2(arg_1_0.tpl, false)

	arg_1_0.pool = {}
	arg_1_0.active = {}

	return
end

function var_0_0.GetType(arg_2_0)
	return var_0_0.TYPE
end

function var_0_0.GetObject(arg_3_0)
	table = var_1_10001

	if var_1_10001.remove(arg_3_0.pool) then
		IsNil = var_2

		local var_3_0

		if var_2(var_3_0) then
			Object = var_2
			var_3_0 = var_2.Instantiate(arg_3_0.tpl.gameObject)
		end

		local var_3_1 = var_3_0.transform

		var_2.SetParent(var_3_1, arg_3_0.root, false)

		local var_3_2 = {
			expireTime = 0
		}
		local var_3_3 = arg_3_0.active

		var_3_3[var_3_0] = var_3_2
		setActive = var_3_3

		var_3_3(var_3_0, true)

		return var_3_0, var_3_2
	end
end

function var_0_0.Recycle(arg_4_0, arg_4_1)
	if arg_4_1 then
		IsNil = var_1_10002

		if var_1_10002(arg_4_1) or not arg_4_0.active or not arg_4_0.active[arg_4_1] then
			return
		end

		local var_4_0 = arg_4_0.active

		var_4_0[arg_4_1] = nil
		setActive = var_4_0

		var_4_0(arg_4_1, false)

		local var_4_1 = arg_4_1.transform

		var_2.SetParent(var_4_1, arg_4_0.root, false)

		local var_4_2 = arg_4_1.transform

		Vector3 = var_4_1
		var_4_2.localPosition = var_4_1.zero
		table = var_4_2

		var_4_2.insert(arg_4_0.pool, arg_4_1)

		return
	end
end

function var_0_0.GetLocalPosition(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1._go.transform.position + var_0_2

	IslandCalcUtil = var_3

	return var_3.WorldPosition2LocalPosition(arg_5_0.root, var_5_0), var_5_0
end

function var_0_0.Play(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_1 or not arg_6_1._go then
		return
	end

	local var_6_0, var_6_1 = arg_6_0:GetObject()

	var_6_1.unit = arg_6_1
	Time = var_1_10005
	var_6_1.expireTime = var_1_10005.time + var_0_1

	local var_6_2 = arg_6_0:GetLocalPosition(arg_6_1)

	var_6_0.transform.localPosition = var_6_2

	local var_6_3 = var_6_0.transform

	if var_6.Find(var_6_3, "Text") then
		setText = var_6_3

		local var_6_4 = var_6
		local var_6_5

		if not arg_6_2 or not arg_6_2.value then
			var_6_5 = 0
		end

		var_6_3(var_6_4, var_6_5)
	end

	return
end

function var_0_0.Update(arg_7_0)
	pairs = var_1_10001

	local var_7_0

	if not arg_7_0.active then
		var_7_0 = {}
	end

	for iter_7_0, iter_7_1 in var_1_10001(var_7_0) do
		local var_7_1 = iter_7_1.unit

		IsNil = var_1_10007

		if var_1_10007(iter_7_0) then
			var_1_10007 = arg_7_0.active
			var_1_10007[iter_7_0] = nil

			goto label_7_0
		end

		Time = var_1_10007

		if not (var_1_10007.time >= iter_7_1.expireTime) and var_7_1 then
			IsNil = var_1_10007

			if var_1_10007(var_7_1._go) then
				arg_7_0:Recycle(iter_7_0)
			else
				local var_7_2

				var_1_10007, var_7_2 = arg_7_0:GetLocalPosition(var_7_1)
				IslandCalcUtil = var_9

				local var_7_3 = var_9.IsInViewport(var_7_2)

				setActive = var_10

				var_10(iter_7_0, var_7_3)

				if var_7_3 then
					iter_7_0.transform.localPosition = var_1_10007
				end
			end

			::label_7_0::
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
