ys = ys or {}

local var_0_0 = ys
local var_0_6 = ys.Battle.BattleConst
local var_0_8 = class("BattleColumnAreaBulletUnit", ys.Battle.BattleAreaBulletUnit)

var_0_8.__name = "BattleColumnAreaBulletUnit"
ys.Battle.BattleColumnAreaBulletUnit = var_0_8
var_0_8.AreaType = ys.Battle.BattleConst.AreaType.COLUMN

function var_0_8.InitCldComponent(arg_1_0)
	local var_1_0 = arg_1_0:GetTemplate().cld_box
	local var_1_1 = arg_1_0:GetTemplate().cld_offset

	arg_1_0._cldComponent = var_0_0.Battle.BattleColumnCldComponent.New(var_1_0[1], var_1_0[3])

	arg_1_0._cldComponent:SetCldData({
		type = var_0_6.CldType.AOE,
		UID = arg_1_0:GetUniqueID(),
		IFF = arg_1_0:GetIFF()
	})

	return
end

function var_0_8.GetBoxSize(arg_2_0)
	local var_2_0 = arg_2_0._cldComponent:GetCldBoxSize()

	return Vector3(var_2_0.range, var_2_0.range, var_2_0.tickness)
end

return
