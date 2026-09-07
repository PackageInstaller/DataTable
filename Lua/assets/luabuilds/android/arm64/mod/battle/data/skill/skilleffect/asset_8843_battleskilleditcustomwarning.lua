ys = ys or {}

local var_0_0 = ys
local BattleSkillEditCustomWarning = class("BattleSkillEditCustomWarning", ys.Battle.BattleSkillEffect)

ys.Battle.BattleSkillEditCustomWarning = BattleSkillEditCustomWarning
BattleSkillEditCustomWarning.__name = "BattleSkillEditCustomWarning"
BattleSkillEditCustomWarning.OP_ADD = 1
BattleSkillEditCustomWarning.OP_REMOVE = 0
BattleSkillEditCustomWarning.OP_REMOVE_PERMANENT = -1
BattleSkillEditCustomWarning.OP_REMOVE_TEMPLATE = -2

function BattleSkillEditCustomWarning:Ctor(arg_1_1)
	BattleSkillEditCustomWarning.super.Ctor(self, arg_1_1, lv)

	self._labelData = {
		op = self._tempData.arg_list.op,
		key = self._tempData.arg_list.key,
		x = self._tempData.arg_list.x,
		y = self._tempData.arg_list.y,
		dialogue = self._tempData.arg_list.dialogue,
		duration = self._tempData.arg_list.duration
	}

	return
end

function BattleSkillEditCustomWarning:DoDataEffect()
	self:doEditWarning()

	return
end

function BattleSkillEditCustomWarning:DoDataEffectWithoutTarget()
	self:doEditWarning()

	return
end

function BattleSkillEditCustomWarning:doEditWarning()
	var_0_0.Battle.BattleDataProxy.GetInstance():DispatchCustomWarning(self._labelData)

	return
end

return
