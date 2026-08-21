ys = ys or {}

local var_0_0 = class("BattleSpecialWeapon", ys.Battle.BattleWeaponUnit)

ys.Battle.BattleSpecialWeapon = var_0_0
var_0_0.__name = "BattleSpecialWeapon"

function var_0_0.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function var_0_0.CheckPreCast(arg_2_0)
	if not arg_2_0._tmpData.bullet_ID[1] then
		arg_2_0._castInfo = {
			weapon = arg_2_0
		}

		return true
	end

	local var_2_0 = arg_2_0._dataProxy:GetSeqCenter():NewSeq("precast")
	local var_2_1 = var_0.Battle.NodeData.New(arg_2_0._host, {
		weapon = arg_2_0
	}, var_2_0)

	pg.NodeMgr.GetInstance():GenNode(var_2_1, pg.BattleNodesCfg[arg_2_0._tmpData.bullet_ID[1]], var_2_0)

	local var_2_2 = var_2_1:GetData()

	if var_2_2.targets[1] == nil then
		return false
	end

	arg_2_0._castInfo = var_2_2

	return true
end

function var_0_0.Fire(arg_3_0)
	assert(arg_3_0._castInfo ~= nil, "需要指定施法信息，有特殊需求可默认指定为{ weapon = self }")

	local var_3_1 = arg_3_0._dataProxy:GetSeqCenter():NewSeq("cast")
	local var_3_2 = var_0.Battle.NodeData.New(arg_3_0._host, arg_3_0._castInfo, var_3_1)

	pg.NodeMgr.GetInstance():GenNode(var_3_2, pg.BattleNodesCfg[arg_3_0._tmpData.barrage_ID[1]], var_3_1)
	arg_3_0._host:SetCurNodeList(var_3_2:GetAllSeq())

	arg_3_0._currentState = arg_3_0.STATE_ATTACK
	arg_3_0._castInfo = nil

	arg_3_0:CheckAndShake()
	var_3_1:Add(var_0.Battle.CallbackNode.New(function()
		arg_3_0:EnterCoolDown()

		return
	end))

	return true
end

return
