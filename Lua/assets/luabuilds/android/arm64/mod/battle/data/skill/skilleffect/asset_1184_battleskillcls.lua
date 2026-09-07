ys = ys or {}

local var_0_0 = ys
local BattleSkillCLS = class("BattleSkillCLS", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillCLS = BattleSkillCLS
BattleSkillCLS.__name = "BattleSkillCLS"
BattleSkillCLS.TYPE_BULLET = 1
BattleSkillCLS.TYPE_AIRCRAFT = 2
BattleSkillCLS.TYPE_MINION = 3
BattleSkillCLS.TYPE_AOE = 4

function BattleSkillCLS:Ctor(arg_1_1)
	BattleSkillCLS.super.Ctor(self, arg_1_1, lv)

	self._clsTypeList = self._tempData.arg_list.typeList or {}

	return
end

function BattleSkillCLS:DoDataEffect(arg_2_1)
	self:doCls(arg_2_1)

	return
end

function BattleSkillCLS:DoDataEffectWithoutTarget(arg_3_1)
	self:doCls(arg_3_1)

	return
end

function BattleSkillCLS:doCls(arg_4_1)
	local var_4_0 = var_0_0.Battle.BattleDataProxy.GetInstance()
	local var_4_1 = arg_4_1:GetIFF() * -1

	for iter_4_0, iter_4_1 in ipairs(self._clsTypeList) do
		if iter_4_1 == BattleSkillCLS.TYPE_BULLET then
			var_4_0:CLSBullet(var_4_1)
		elseif iter_4_1 == BattleSkillCLS.TYPE_AIRCRAFT then
			var_4_0:CLSAircraft(var_4_1)
		elseif iter_4_1 == BattleSkillCLS.TYPE_MINION then
			var_4_0:CLSMinion()
		elseif iter_4_1 == BattleSkillCLS.TYPE_AOE then
			var_4_0:CLSAOE()
		end
	end

	return
end

return
