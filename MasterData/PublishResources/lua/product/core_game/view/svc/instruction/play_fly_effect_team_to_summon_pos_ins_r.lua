require("base_ins_r")
_class("PlayFlyEffectTeamToSummonPosInstruction", BaseInstruction)
PlayFlyEffectTeamToSummonPosInstruction = PlayFlyEffectTeamToSummonPosInstruction

function PlayFlyEffectTeamToSummonPosInstruction:Constructor(paramList)
  self._flyEffectID = tonumber(paramList.flyEffectID)
  self._flyTime = tonumber(paramList.flyTime)
  self._finalWaitTime = tonumber(paramList.finalWaitTime)
  self._flyTrace = tonumber(paramList.flyTrace)
  self._isBlock = tonumber(paramList.isBlock) or 1
end

function PlayFlyEffectTeamToSummonPosInstruction:GetCacheResource()
  local t = {}
  if self._flyEffectID and self._flyEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._flyEffectID].ResPath,
      8
    })
  end
  return t
end

function PlayFlyEffectTeamToSummonPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.SummonEverything)
  if not resultArray then
    Log.fatal("PlayFlyEffectTeamToSummonPosInstruction: Get SummonEverything result failed.")
    return
  end
  local targetGridPosArray = {}
  for _, result in ipairs(resultArray) do
    local pos = result:GetSummonPos()
    table.insert(targetGridPosArray, pos)
  end
  local teamEntity = world:Player():GetCurrentTeamEntity()
  local teamGridPos = teamEntity:GetGridPosition()
  local effectStarPos = teamEntity:View():GetGameObject().transform.position
  local taskIDList = {}
  for _, targetGridPos in ipairs(targetGridPosArray) do
    local nTaskID = GameGlobal.TaskManager():CoreGameStartTask(self._DoFly, self, world, targetGridPos, teamGridPos, effectStarPos)
    table.insert(taskIDList, nTaskID)
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDList) do
    YIELD(TT)
  end
end

function PlayFlyEffectTeamToSummonPosInstruction:_DoFly(TT, world, targetGridPos, teamGridPos, effectStarPos)
  local dir = targetGridPos - teamGridPos
  local effectService = world:GetService("Effect")
  local effectEntity = effectService:CreatePositionEffect(self._flyEffectID, effectStarPos)
  effectEntity:SetDirection(dir)
  local boardServiceRender = world:GetService("BoardRender")
  local targetPos = boardServiceRender:GridPos2RenderPos(targetGridPos)
  local distance = Vector3.Distance(effectStarPos, targetPos)
  local flyTime = self._flyTime
  if effectEntity == nil or effectEntity:View() == nil then
    return
  end
  local go = effectEntity:View():GetGameObject()
  local doTween
  if self._flyTrace == FlyEffectTraceType.LineTrace then
    doTween = go.transform:DOMove(targetPos, flyTime * 0.001, false)
  elseif self._flyTrace == FlyEffectTraceType.JumpTrace then
    local jumpPower = math.sqrt(distance)
    doTween = go.transform:DOJump(targetPos, jumpPower, 1, flyTime * 0.001, false)
  elseif self._flyTrace == FlyEffectTraceType.ScaleTrace then
    go.transform.localScale = Vector3(1, 1, distance)
  elseif self._flyTrace == FlyEffectTraceType.TimeScaleTrace then
    doTween = go.transform:DOScaleZ(distance, flyTime / 1000.0)
  end
  if doTween then
    doTween:SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
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
    if not doTween then
      world:DestroyEntity(effectEntity)
    end
  else
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      YIELD(TT, totalWaitTime)
      if not doTween then
        world:DestroyEntity(effectEntity)
      end
    end)
  end
end
