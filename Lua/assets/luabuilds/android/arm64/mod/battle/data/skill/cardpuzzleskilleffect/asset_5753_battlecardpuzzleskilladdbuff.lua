ys = ys or {}

local var_0_0 = ys
local BattleCardPuzzleSkillAddBuff = class("BattleCardPuzzleSkillAddBuff", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillAddBuff = BattleCardPuzzleSkillAddBuff
BattleCardPuzzleSkillAddBuff.__name = "BattleCardPuzzleSkillAddBuff"

function BattleCardPuzzleSkillAddBuff:Ctor(arg_1_1, arg_1_2)
	BattleCardPuzzleSkillAddBuff.super.Ctor(self, arg_1_1, arg_1_2)

	self._buffID = self._tempData.arg_list.buff_id

	return
end

function BattleCardPuzzleSkillAddBuff:SkillEffectHandler(arg_2_1)
	for iter_2_0, iter_2_1 in ipairs((self:GetTarget())) do
		if iter_2_1:IsAlive() then
			iter_2_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(self._buffID, 1, self._caster)))
		end
	end

	self:Finale()

	return
end

return
