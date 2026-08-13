class = var_0_10000

local var_0_0 = "CourtYardEffectAgent"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardAgent"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.effects = {}
	arg_1_0.counts = {}

	return
end

function var_0_1.EnableEffect(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0

	if arg_2_0.effects[arg_2_1] then
		var_2_0 = arg_2_0.counts

		local var_2_1

		if not arg_2_0.counts[arg_2_1] then
			var_2_1 = 0
		end

		var_2_0[arg_2_1] = var_2_1 + 1

		return
	end

	pg = var_2_0

	local var_2_2 = var_2_0.UIMgr.GetInstance()

	var_2.LoadingOn(var_2_2)

	PoolMgr = var_2

	local var_2_3 = var_2.GetInstance()

	var_2.GetPrefab(var_2_3, "ui/" .. arg_2_1, arg_2_1, true, function(arg_3_0)
		pg = var_2_10001

		local var_3_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOff(var_3_0)

		if not arg_2_0.effects or arg_2_0.effects[arg_2_1] then
			PoolMgr = var_1

			local var_3_1 = var_1.GetInstance()

			var_1.ReturnPrefab(var_3_1, "ui/" .. arg_2_1, arg_2_1, arg_3_0)

			return
		end

		arg_3_0.name = arg_2_1
		setParent = var_1

		var_1(arg_3_0, arg_2_0.effectContainer)

		setActive = var_1

		var_1(arg_3_0, true)

		arg_2_0.effects[arg_2_1] = arg_3_0

		local var_3_2 = arg_2_0.counts
		local var_3_3 = arg_2_1
		local var_3_4

		if not arg_2_0.counts[arg_2_1] then
			var_3_4 = 0
		end

		var_3_2[var_3_3] = var_3_4 + 1

		return
	end)

	return
end

function var_0_1.DisableEffect(arg_4_0, arg_4_1)
	if not arg_4_0.effects[arg_4_1] then
		return
	end

	local var_4_0 = arg_4_0.counts
	local var_4_1

	if not arg_4_0.counts[arg_4_1] then
		var_4_1 = 0
	end

	var_4_0[arg_4_1] = var_4_1 - 1

	if arg_4_0.counts[arg_4_1] <= 0 then
		findTF = var_2

		if var_2(arg_4_0.effectContainer, arg_4_1) then
			PoolMgr = var_3

			local var_4_2 = var_3.GetInstance()

			var_3.ReturnPrefab(var_4_2, "ui/" .. arg_4_1, arg_4_1, var_2.gameObject)

			arg_4_0.effects[arg_4_1] = nil
		end
	end

	return
end

function var_0_1.Dispose(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0.effects) do
		PoolMgr = var_1_10006

		local var_5_0 = var_1_10006.GetInstance()

		var_1_10006.ReturnPrefab(var_5_0, "ui/" .. iter_5_0, iter_5_0, iter_5_1)
	end

	arg_5_0.effects = nil
	arg_5_0.counts = nil

	return
end

return var_0_1
