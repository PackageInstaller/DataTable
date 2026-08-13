class = var_0_10000

local var_0_0 = "CourtYardBGAgent"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardAgent"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.prefab = nil

	return
end

function var_0_1.Switch(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_2 then
		return
	end

	local var_2_0

	if not arg_2_0.prefab or not arg_2_0.prefab.name then
		var_2_0 = ""
	end

	if arg_2_1 and var_2_0 ~= arg_2_2 then
		arg_2_0:LoadBG(arg_2_2)
	elseif arg_2_1 and var_2_0 == arg_2_2 then
		-- block empty
	elseif not arg_2_1 and var_2_0 == arg_2_2 then
		arg_2_0:Clear()
	else
		assert = var_1_10004

		var_1_10004(false)
	end

	return
end

function var_0_1.LoadBG(arg_3_0, arg_3_1)
	PoolMgr = var_1_10002

	local var_3_0 = var_1_10002.GetInstance()

	var_2.GetPrefab(var_3_0, "BackyardBG/" .. arg_3_1, arg_3_1, true, function(arg_4_0)
		if arg_3_0.exited then
			PoolMgr = var_1

			local var_4_0 = var_1.GetInstance()

			var_1.ReturnPrefab(var_4_0, "BackyardBG/" .. arg_3_1, arg_3_1, arg_4_0)
		end

		arg_4_0.name = arg_3_1
		setParent = var_1

		var_1(arg_4_0, arg_3_0._tf)

		local var_4_1 = arg_4_0.transform

		var_1.SetAsFirstSibling(var_4_1)

		setActive = var_1

		var_1(arg_4_0, true)

		arg_3_0.prefab = arg_4_0

		return
	end)

	return
end

function var_0_1.Clear(arg_5_0)
	if arg_5_0.prefab then
		local var_5_0 = arg_5_0.prefab.name

		PoolMgr = var_1_10002

		local var_5_1 = var_1_10002.GetInstance()

		var_2.ReturnPrefab(var_5_1, "BackyardBG/" .. var_5_0, var_5_0, arg_5_0.prefab)

		arg_5_0.prefab = nil
	end

	return
end

function var_0_1.ClearByName(arg_6_0, arg_6_1)
	if arg_6_0.prefab and arg_6_0.prefab.name == arg_6_1 then
		arg_6_0:Clear()
	end

	return
end

function var_0_1.Dispose(arg_7_0)
	arg_7_0:Clear(true)

	arg_7_0.exited = true

	return
end

return var_0_1
