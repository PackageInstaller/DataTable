ys = ys or {}
ys.Battle.BattleBuffAddAircraftOrb = class("BattleBuffAddAircraftOrb", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffAddAircraftOrb.__name = "BattleBuffAddAircraftOrb"

local var_0_0 = ys.Battle.BattleBuffAddAircraftOrb

function ys.Battle.BattleBuffAddAircraftOrb.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffAddAircraftOrb:SetArgs(arg_2_1, arg_2_2)
	self._buffID = self._tempData.arg_list.buff_id
	self._rant = self._tempData.arg_list.rant or 10000
	self._level = self._tempData.arg_list.level or 1
	self._buffLevel = self._tempData.arg_list.buff_level or 1

	return
end

function ys.Battle.BattleBuffAddAircraftOrb:onAircraftCreate(arg_3_1, arg_3_2, arg_3_3)
	if not self:equipIndexRequire(arg_3_3.equipIndex) then
		return
	end

	local var_3_0 = {
		buffID = self._buffID,
		rant = self._rant,
		level = self._level,
		buff_level = self._buffLevel
	}

	for iter_3_0, iter_3_1 in ipairs((arg_3_3.aircraft:GetWeapon())) do
		iter_3_1:SetBulletOrbData(var_3_0)
	end

	return
end

return
