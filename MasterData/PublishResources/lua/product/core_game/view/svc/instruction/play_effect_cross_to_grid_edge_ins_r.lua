require("base_ins_r")
_class("PlayEffectCrossToGridEdgesInstruction", BaseInstruction)
PlayEffectCrossToGridEdgesInstruction = PlayEffectCrossToGridEdgesInstruction

function PlayEffectCrossToGridEdgesInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._waitTimeStart = tonumber(paramList.waitTimeStart)
  self._waitTimeEnd = tonumber(paramList.waitTimeEnd)
  self._limitDistance = tonumber(paramList.limitDistance) or 1
end

function PlayEffectCrossToGridEdgesInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local effectService = world:GetService("Effect")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridDataArray = scopeResult:GetAttackRange()
  local gridEdgePos = {}
  local castPos = casterEntity:GridLocation().Position
  local targetGirdList, _, maxGridCount = InnerGameSortGridHelperRender:SortGrid(gridDataArray, castPos)
  for dir = 1, 8 do
    local t = targetGirdList[dir]
    if #t.gridList > 0 then
      local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoCrossToGridEdges, self, effectService, world, t)
    end
  end
end

function PlayEffectCrossToGridEdgesInstruction:_DoCrossToGridEdges(TT, effectService, world, t)
  local gridPosStart = t.gridList[1]
  local gridPosEnd = t.gridList[#t.gridList]
  local distance = (gridPosEnd - gridPosStart).magnitude
  if distance < self._limitDistance then
    return
  end
  local entityEffect = effectService:CreateWorldPositionDirectionEffect(self._effectID, gridPosStart, t.direction)
  YIELD(TT, self._waitTimeStart)
  entityEffect:SetPosition(gridPosEnd)
  YIELD(TT, self._waitTimeEnd)
  world:DestroyEntity(entityEffect)
end

function PlayEffectCrossToGridEdgesInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end
