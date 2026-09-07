ys = ys or {}

local var_0_0 = ys
local BattleCardPuzzleSkillAddBurnDot = class("BattleCardPuzzleSkillAddBurnDot", ys.Battle.BattleCardPuzzleSkillAddBuff)

ys.Battle.BattleCardPuzzleSkillAddBurnDot = BattleCardPuzzleSkillAddBurnDot
BattleCardPuzzleSkillAddBurnDot.__name = "BattleCardPuzzleSkillAddBurnDot"

function BattleCardPuzzleSkillAddBurnDot:Ctor(arg_1_1, arg_1_2)
	BattleCardPuzzleSkillAddBurnDot.super.Ctor(self, arg_1_1, arg_1_2)

	self._buffID = self._tempData.arg_list.buff_id
	self._stack_count = self._tempData.arg_list.stack_count or 0
	self._stack_ratio = self._tempData.arg_list.stack_ratio or 0

	return
end

function BattleCardPuzzleSkillAddBurnDot:SkillEffectHandler()
	for iter_2_0, iter_2_1 in ipairs((self:GetTarget())) do
		if iter_2_1:IsAlive() then
			local var_2_0 = iter_2_1:GetBuff(self._buffID)
			local var_2_1 = var_0_0.Battle.BattleStackableBuffUnit.New(self._buffID, 1, self._caster, self._stack_count + math.floor((var_2_0 and var_2_0:GetStack() or 0) * self._stack_ratio))
			local var_2_2 = self:GetCardPuzzleComponent():GetAttrManager()

			var_2_1:SetStackCount(var_2_2:GetCurrent("BurnStackCount"))
			var_2_1:SetUnstackCount(var_2_2:GetCurrent("BurnUnStackCount"))
			iter_2_1:AddBuff(var_2_1)
		end
	end

	self:Finale()

	return
end

return
