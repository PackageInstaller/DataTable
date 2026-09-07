ys = ys or {}

local var_0_0 = ys
local var_0_6 = ys.Battle.BattleConst
local BattleColumnAreaBulletUnit = class("BattleColumnAreaBulletUnit", ys.Battle.BattleAreaBulletUnit)

BattleColumnAreaBulletUnit.__name = "BattleColumnAreaBulletUnit"
ys.Battle.BattleColumnAreaBulletUnit = BattleColumnAreaBulletUnit
BattleColumnAreaBulletUnit.AreaType = ys.Battle.BattleConst.AreaType.COLUMN

function BattleColumnAreaBulletUnit:InitCldComponent()
	local var_1_0 = self:GetTemplate().cld_box
	local var_1_1 = self:GetTemplate().cld_offset

	self._cldComponent = var_0_0.Battle.BattleColumnCldComponent.New(var_1_0[1], var_1_0[3])

	self._cldComponent:SetCldData({
		type = var_0_6.CldType.AOE,
		UID = self:GetUniqueID(),
		IFF = self:GetIFF()
	})

	return
end

function BattleColumnAreaBulletUnit:GetBoxSize()
	local var_2_0 = self._cldComponent:GetCldBoxSize()

	return Vector3(var_2_0.range, var_2_0.range, var_2_0.tickness)
end

return
