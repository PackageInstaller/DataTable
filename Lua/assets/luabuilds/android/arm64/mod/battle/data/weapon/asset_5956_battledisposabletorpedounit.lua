ys = ys or {}

local var_0_0 = ys
local BattleDisposableTorpedoUnit = class("BattleDisposableTorpedoUnit", ys.Battle.BattleManualTorpedoUnit)

ys.Battle.BattleDisposableTorpedoUnit = BattleDisposableTorpedoUnit
BattleDisposableTorpedoUnit.__name = "BattleDisposableTorpedoUnit"

function BattleDisposableTorpedoUnit:Ctor()
	BattleDisposableTorpedoUnit.super.Ctor(self)

	return
end

function BattleDisposableTorpedoUnit:EnterCoolDown()
	return
end

function BattleDisposableTorpedoUnit:Fire()
	BattleDisposableTorpedoUnit.super.Fire(self)
	self._playerTorpedoVO:Deduct(self)
	self._playerTorpedoVO:DispatchOverLoadChange()

	return true
end

function BattleDisposableTorpedoUnit:OverHeat()
	self._currentState = self.STATE_OVER_HEAT

	return
end

function BattleDisposableTorpedoUnit:GetType()
	return var_0_0.Battle.BattleConst.EquipmentType.DISPOSABLE_TORPEDO
end

function BattleDisposableTorpedoUnit:createMajorEmitter(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	return BattleDisposableTorpedoUnit.super.createMajorEmitter(self, 1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
end

return
