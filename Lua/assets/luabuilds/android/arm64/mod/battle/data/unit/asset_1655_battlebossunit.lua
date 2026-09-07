ys = ys or {}

local var_0_0 = ys
local var_0_6 = ys.Battle.BattleUnitEvent
local BattleBossUnit = class("BattleBossUnit", ys.Battle.BattleEnemyUnit)

ys.Battle.BattleBossUnit = BattleBossUnit
BattleBossUnit.__name = "BattleBossUnit"

function BattleBossUnit:Ctor(arg_1_1, arg_1_2)
	BattleBossUnit.super.Ctor(self, arg_1_1, arg_1_2)

	self._isBoss = true

	return
end

function BattleBossUnit:IsBoss()
	return true
end

function BattleBossUnit:BarrierStateChange(arg_3_1, arg_3_2)
	self:DispatchEvent(var_0_0.Event.New(var_0_6.BARRIER_STATE_CHANGE, {
		barrierDurability = arg_3_1,
		barrierDuration = arg_3_2
	}))

	return
end

function BattleBossUnit:UpdateHP(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0 = BattleBossUnit.super.UpdateHP(self, arg_4_1, arg_4_2, arg_4_3, arg_4_4) or 0

	if var_4_0 < 0 then
		for iter_4_0, iter_4_1 in ipairs(self._autoWeaponList) do
			iter_4_1:UpdatePrecastArmor(var_4_0)
		end
	end

	return var_4_0
end

return
