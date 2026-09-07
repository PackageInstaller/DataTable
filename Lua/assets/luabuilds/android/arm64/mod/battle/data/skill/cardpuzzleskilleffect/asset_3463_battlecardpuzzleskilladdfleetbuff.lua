ys = ys or {}

local var_0_0 = ys
local BattleCardPuzzleSkillAddFleetBuff = class("BattleCardPuzzleSkillAddFleetBuff", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillAddFleetBuff = BattleCardPuzzleSkillAddFleetBuff
BattleCardPuzzleSkillAddFleetBuff.__name = "BattleCardPuzzleSkillAddFleetBuff"

function BattleCardPuzzleSkillAddFleetBuff:Ctor(arg_1_1, arg_1_2)
	BattleCardPuzzleSkillAddFleetBuff.super.Ctor(self, arg_1_1, arg_1_2)

	self._fleetBuffID = self._tempData.arg_list.fleet_buff_id
	self._initStack = self._tempData.arg_list.init_stack or 1

	return
end

function BattleCardPuzzleSkillAddFleetBuff:SkillEffectHandler()
	self:GetCardPuzzleComponent():GetBuffManager():AttachCardPuzzleBuff((var_0_0.Battle.BattleFleetBuffUnit.New(self._fleetBuffID)))
	self:Finale()

	return
end

return
