ys = ys or {}
ys.Battle.BattleSkillSetCloak = class("BattleSkillSetCloak", ys.Battle.BattleSkillEffect)
ys.Battle.BattleSkillSetCloak.__name = "BattleSkillSetCloak"

local var_0_0 = ys.Battle.BattleSkillSetCloak

function ys.Battle.BattleSkillSetCloak.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, lv)

	arg_1_0._rate = arg_1_0._tempData.arg_list.cloak_rate or 0

	return
end

function ys.Battle.BattleSkillSetCloak.DoDataEffect(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:doSetCloakValue(arg_2_2)

	return
end

function ys.Battle.BattleSkillSetCloak.DoDataEffectWithoutTarget(arg_3_0, arg_3_1)
	arg_3_0:doSetCloakValue(arg_3_1)

	return
end

function ys.Battle.BattleSkillSetCloak.doSetCloakValue(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetCloak()

	if var_4_0 then
		var_4_0:ForceToRate(arg_4_0._rate)
	end

	return
end

return
