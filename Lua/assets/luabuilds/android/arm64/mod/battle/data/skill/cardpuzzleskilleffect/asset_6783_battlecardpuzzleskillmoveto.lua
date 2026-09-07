ys = ys or {}

local BattleCardPuzzleSkillMoveTo = class("BattleCardPuzzleSkillMoveTo", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillMoveTo = BattleCardPuzzleSkillMoveTo
BattleCardPuzzleSkillMoveTo.__name = "BattleCardPuzzleSkillMoveTo"

function BattleCardPuzzleSkillMoveTo:Ctor(arg_1_1)
	BattleCardPuzzleSkillMoveTo.super.Ctor(self, arg_1_1)

	return
end

function BattleCardPuzzleSkillMoveTo:HoldForInput()
	return false
end

function BattleCardPuzzleSkillMoveTo:SkillEffectHandler()
	local var_3_0 = self:GetCardPuzzleComponent():TakeoverMovecontroller(self._card:GetInputPoint(), function()
		self:Finale()

		return
	end)

	return
end

function BattleCardPuzzleSkillMoveTo:Finale()
	BattleCardPuzzleSkillMoveTo.super.Finale(self)
	self:GetCardPuzzleComponent():ReturnMovecontroller()

	return
end

return
