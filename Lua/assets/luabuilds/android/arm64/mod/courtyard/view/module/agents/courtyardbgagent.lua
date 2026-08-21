local var_0_0 = class("CourtYardBGAgent", import(".CourtYardAgent"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.prefab = nil

	return
end

function var_0_0.Switch(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_2 then
		return
	end

	if arg_2_0.prefab then
		local var_2_0 = arg_2_0.prefab.name or ""

		if arg_2_1 and var_2_0 ~= arg_2_2 then
			arg_2_0:LoadBG(arg_2_2)
		elseif arg_2_1 and var_2_0 == arg_2_2 then
			-- block empty
		elseif not arg_2_1 and var_2_0 == arg_2_2 then
			arg_2_0:Clear()
		else
			assert(false)
		end

		return
	end
end

function var_0_0.LoadBG(arg_3_0, arg_3_1)
	PoolMgr.GetInstance():GetPrefab("BackyardBG/" .. arg_3_1, arg_3_1, true, function(arg_4_0)
		if arg_3_0.exited then
			PoolMgr.GetInstance():ReturnPrefab("BackyardBG/" .. arg_3_1, arg_3_1, arg_4_0)
		end

		arg_4_0.name = arg_3_1

		setParent(arg_4_0, arg_3_0._tf)
		arg_4_0.transform:SetAsFirstSibling()
		setActive(arg_4_0, true)

		arg_3_0.prefab = arg_4_0

		return
	end)

	return
end

function var_0_0.Clear(arg_5_0)
	if arg_5_0.prefab then
		PoolMgr.GetInstance():ReturnPrefab("BackyardBG/" .. arg_5_0.prefab.name, arg_5_0.prefab.name, arg_5_0.prefab)

		arg_5_0.prefab = nil
	end

	return
end

function var_0_0.ClearByName(arg_6_0, arg_6_1)
	if arg_6_0.prefab and arg_6_0.prefab.name == arg_6_1 then
		arg_6_0:Clear()
	end

	return
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0:Clear(true)

	arg_7_0.exited = true

	return
end

return var_0_0
