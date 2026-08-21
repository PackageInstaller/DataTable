local var_0_0 = class("TowerClimbingResMgr")
local var_0_1 = {
	salatuojia = "TowerClimbingPlayer1"
}

local function var_0_2(arg_1_0)
	return var_0_1[arg_1_0]
end

function var_0_0.GetBlock(arg_2_0, arg_2_1)
	PoolMgr.GetInstance():GetUI(arg_2_0, true, function(arg_3_0)
		arg_2_1(arg_3_0)

		return
	end)

	return
end

function var_0_0.GetPlayer(arg_4_0, arg_4_1)
	local var_4_0 = var_0_2(arg_4_0)

	assert(var_4_0, arg_4_0)
	PoolMgr.GetInstance():GetUI(var_4_0, true, arg_4_1)

	return
end

function var_0_0.GetGround(arg_5_0, arg_5_1)
	PoolMgr.GetInstance():GetUI(arg_5_0, true, arg_5_1)

	return
end

function var_0_0.ReturnBlock(arg_6_0, arg_6_1)
	PoolMgr.GetInstance():ReturnUI(arg_6_0, arg_6_1)

	return
end

function var_0_0.ReturnPlayer(arg_7_0, arg_7_1)
	local var_7_0 = var_0_2(arg_7_0)

	assert(var_7_0, arg_7_0)
	PoolMgr.GetInstance():ReturnUI(var_7_0, arg_7_1)

	return
end

function var_0_0.ReturnGround(arg_8_0, arg_8_1)
	PoolMgr.GetInstance():ReturnUI(arg_8_0, arg_8_1)

	return
end

return var_0_0
