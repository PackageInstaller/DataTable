ys = ys or {}

local BattleSkillTeleport = class("BattleSkillTeleport", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillTeleport = BattleSkillTeleport
BattleSkillTeleport.__name = "BattleSkillTeleport"

function BattleSkillTeleport:Ctor(arg_1_1, arg_1_2)
	BattleSkillTeleport.super.Ctor(self, arg_1_1, arg_1_2)

	return
end

function BattleSkillTeleport:DoDataEffect(arg_2_1, arg_2_2)
	arg_2_1:SetPosition((self.calcCorrdinate(self._tempData.arg_list, arg_2_1, arg_2_2)))

	return
end

function BattleSkillTeleport:DoDataEffectWithoutTarget(arg_3_1)
	arg_3_1:SetPosition((self.calcCorrdinate(self._tempData.arg_list, arg_3_1)))

	return
end

return
