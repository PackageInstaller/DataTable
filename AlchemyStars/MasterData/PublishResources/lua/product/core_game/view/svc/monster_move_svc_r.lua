require("base_service")
_class("MonsterMoveServiceRender", BaseService)
MonsterMoveServiceRender = MonsterMoveServiceRender

function MonsterMoveServiceRender:Constructor(world)
  self.world = world
end

function MonsterMoveServiceRender:_DoRenderTrapBeforeMonster(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end

function MonsterMoveServiceRender:_DoRenderPlayMonsterAction(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoMainAIRountine(TT)
end

function MonsterMoveServiceRender:_DoRenderTrapAfterMonster(TT)
  local playAISvc = self._world:GetService("PlayAI")
  if playAISvc == nil then
    return
  end
  playAISvc:DoCommonRountine(TT)
end
