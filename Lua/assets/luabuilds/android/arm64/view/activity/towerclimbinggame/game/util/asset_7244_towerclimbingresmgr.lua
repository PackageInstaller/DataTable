local TowerClimbingResMgr = class("TowerClimbingResMgr")
local var_0_1 = {
	salatuojia = "TowerClimbingPlayer1"
}

local function var_0_2(arg_1_0)
	return var_0_1[arg_1_0]
end

function TowerClimbingResMgr:GetBlock(arg_2_1)
	PoolMgr.GetInstance():GetUI(self, true, function(arg_3_0)
		arg_2_1(arg_3_0)

		return
	end)

	return
end

function TowerClimbingResMgr:GetPlayer(arg_4_1)
	local var_4_0 = var_0_2(self)

	assert(var_4_0, self)
	PoolMgr.GetInstance():GetUI(var_4_0, true, arg_4_1)

	return
end

function TowerClimbingResMgr:GetGround(arg_5_1)
	PoolMgr.GetInstance():GetUI(self, true, arg_5_1)

	return
end

function TowerClimbingResMgr:ReturnBlock(arg_6_1)
	PoolMgr.GetInstance():ReturnUI(self, arg_6_1)

	return
end

function TowerClimbingResMgr:ReturnPlayer(arg_7_1)
	local var_7_0 = var_0_2(self)

	assert(var_7_0, self)
	PoolMgr.GetInstance():ReturnUI(var_7_0, arg_7_1)

	return
end

function TowerClimbingResMgr:ReturnGround(arg_8_1)
	PoolMgr.GetInstance():ReturnUI(self, arg_8_1)

	return
end

return TowerClimbingResMgr
