require("base_ins_r")
_class("PlayFlyEffectCrossToGridEdgesInstruction", BaseInstruction)
PlayFlyEffectCrossToGridEdgesInstruction = PlayFlyEffectCrossToGridEdgesInstruction

function PlayFlyEffectCrossToGridEdgesInstruction:Constructor(paramList)
  self._waitTimeStart = tonumber(paramList.waitTimeStart)
  self._limitDistance = tonumber(paramList.limitDistance) or 1
  self._offsetX = tonumber(paramList.offsetx) or 0
  self._offsetY = tonumber(paramList.offsety) or 0
  self._offsetZ = tonumber(paramList.offsetz) or 0
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._flySpeed = tonumber(paramList.flySpeed)
  if paramList.flyTime then
    self._flyTime = tonumber(paramList.flyTime)
  end
  if paramList.ignoreYield then
    self._ignoreYield = tonumber(paramList.ignoreYield)
  end
  if paramList.finalWaitTime then
    self._finalWaitTime = tonumber(paramList.finalWaitTime)
  end
  self._flyTrace = tonumber(paramList.flyTrace)
  self._flyEaseType = paramList.flyEaseType
  self._jumpPower = tonumber(paramList.jumpPower)
end

function PlayFlyEffectCrossToGridEdgesInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local playSkillService = world:GetService("PlaySkill")
  local effectService = world:GetService("Effect")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridDataArray = scopeResult:GetAttackRange()
  local gridEdgePos = {}
  local castGridPos = casterEntity:GridLocation().Position
  local targetGirdList, maxLength, maxGridCount = InnerGameSortGridHelperRender:SortGrid(gridDataArray, castGridPos)
  local casterEntityReal = casterEntity
  local tran
  if casterEntityReal:HasSuperEntity() and casterEntityReal:SuperEntityComponent():IsUseSuperEntityView() then
    tran = casterEntityReal:GetSuperEntity():View():GetGameObject().transform
  else
    tran = casterEntityReal:View():GetGameObject().transform
  end
  local effectStarPos = tran:TransformPoint(Vector3(self._offsetX, self._offsetY, self._offsetZ))
  if self._waitTimeStart and self._waitTimeStart > 0 then
    YIELD(TT, self._waitTimeStart)
  end
  local taskIDList = {}
  for dir = 1, 8 do
    local t = targetGirdList[dir]
    if 0 < #t.gridList then
      local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoCrossToGridEdges, self, effectService, world, t, castGridPos, effectStarPos)
      table.insert(taskIDList, nTaskID)
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function PlayFlyEffectCrossToGridEdgesInstruction:_DoCrossToGridEdges(TT, effectService, world, t, castGridPos, effectStarPos)
  local gridPosStart = castGridPos
  local gridPosEnd = t.gridList[#t.gridList]
  local girdDis = (gridPosEnd - gridPosStart).magnitude
  if girdDis < self._limitDistance then
    return
  end
  local dir = gridPosEnd - gridPosStart
  local effectEntity = world:GetService("Effect"):CreatePositionEffect(self._flyEffectID, effectStarPos)
  effectEntity:SetDirection(dir)
  local boardServiceRender = world:GetService("BoardRender")
  local targetPos = boardServiceRender:GridPos2RenderPos(gridPosEnd)
  targetPos.y = effectStarPos.y
  local distance = Vector3.Distance(effectStarPos, targetPos)
  local flyTime = 0
  if self._flySpeed then
    flyTime = distance * self._flySpeed
  end
  if not self._ignoreYield then
    YIELD(TT)
  end
  if effectEntity == nil or effectEntity:View() == nil then
    return
  end
  local go = effectEntity:View():GetGameObject()
  local dotween
  if self._flyTrace == FlyEffectTraceType.LineTrace then
    if flyTime == 0 and self._flyTime then
      flyTime = self._flyTime
    end
    dotween = go.transform:DOMove(targetPos, flyTime / 1000.0, false)
    if self._flyEaseType then
      local easyType = DG.Tweening.Ease[self._flyEaseType]
      dotween:SetEase(easyType)
    end
  elseif self._flyTrace == FlyEffectTraceType.JumpTrace then
    local jumpPower = self._jumpPower or math.sqrt(distance)
    flyTime = self._flyTime or flyTime
    dotween = go.transform:DOJump(targetPos, jumpPower, 1, flyTime * 0.001, false)
  elseif self._flyTrace == FlyEffectTraceType.ScaleTrace then
    go.transform.localScale = Vector3(1, 1, distance)
  elseif self._flyTrace == FlyEffectTraceType.TimeScaleTrace then
    if self._flyTime then
      flyTime = self._flyTime
    end
    local changeScaleRoot = go
    if self._changeScaleRoot then
      changeScaleRoot = GameObjectHelper.FindChild(go.transform, self._changeScaleRoot)
    end
    dotween = changeScaleRoot.transform:DOScaleZ(distance, flyTime / 1000.0)
  end
  if dotween then
    dotween:SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
      if self._finalWaitTime and self._finalWaitTime > 0 then
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          YIELD(TT, self._finalWaitTime)
          if go then
            go:SetActive(false)
          end
          world:DestroyEntity(effectEntity)
        end)
      else
        go:SetActive(false)
        world:DestroyEntity(effectEntity)
      end
    end)
  end
  local totalWaitTime = flyTime
  if self._finalWaitTime and self._finalWaitTime > 0 then
    totalWaitTime = totalWaitTime + self._finalWaitTime
  end
  if self._isBlock == 1 then
    YIELD(TT, totalWaitTime)
    if not dotween then
      world:DestroyEntity(effectEntity)
    end
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, totalWaitTime)
      if not dotween then
        world:DestroyEntity(effectEntity)
      end
    end)
  end
end

function PlayFlyEffectCrossToGridEdgesInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      8
    })
  end
  return t
end
