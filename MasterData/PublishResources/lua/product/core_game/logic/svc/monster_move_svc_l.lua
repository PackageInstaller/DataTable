require("base_service")
_class("MonsterMoveServiceLogic", BaseService)
MonsterMoveServiceLogic = MonsterMoveServiceLogic

function MonsterMoveServiceLogic:Constructor(world)
end

function MonsterMoveServiceLogic:_DoLogicTrapBeforeMonster()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:StartBeforeMainAI()
end

function MonsterMoveServiceLogic:_DoLogicTrapAfterMonster()
  local trapServiceLogic = self._world:GetService("TrapLogic")
  trapServiceLogic:TrapActionAfterAI()
end

function MonsterMoveServiceLogic:_DoLogicCalcMonsterAction()
  local aiService = self._world:GetService("AI")
  aiService:RunAiLogic_WaitEnd(AILogicPeriodType.Main)
end
