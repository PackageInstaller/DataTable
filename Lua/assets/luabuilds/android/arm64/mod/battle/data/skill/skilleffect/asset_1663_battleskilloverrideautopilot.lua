ys = ys or {}

local BattleSkillOverrideAutoPilot = class("BattleSkillOverrideAutoPilot", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillOverrideAutoPilot = BattleSkillOverrideAutoPilot
BattleSkillOverrideAutoPilot.__name = "BattleSkillOverrideAutoPilot"

function BattleSkillOverrideAutoPilot:Ctor(arg_1_1, arg_1_2)
	BattleSkillOverrideAutoPilot.super.Ctor(self, arg_1_1, arg_1_2)

	self._AIID = self._tempData.arg_list.ai_id

	return
end

function BattleSkillOverrideAutoPilot:DoDataEffect(arg_2_1)
	local var_2_0 = arg_2_1:GetFleetVO()

	if not var_2_0 then
		return
	end

	var_2_0:OverrideJoyStickAutoBot(self._AIID)

	return
end

function BattleSkillOverrideAutoPilot:DataEffectWithoutTarget(arg_3_1)
	self:DoDataEffect(arg_3_1)

	return
end

return
