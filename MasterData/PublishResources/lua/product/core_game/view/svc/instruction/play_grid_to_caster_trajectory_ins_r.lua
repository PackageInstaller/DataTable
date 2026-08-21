require("base_ins_r")
_class("PlayGridToCasterTrajectoryInstruction", BaseInstruction)
PlayGridToCasterTrajectoryInstruction = PlayGridToCasterTrajectoryInstruction

function PlayGridToCasterTrajectoryInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._posX = tonumber(paramList.gridPosX)
  self._posY = tonumber(paramList.gridPosY)
  self._flySpeed = tonumber(paramList.flySpeed)
  self._flyTime = tonumber(paramList.flyTime)
  self._destroyWaitTime = tonumber(paramList.destroyWaitTime)
  if not self._effectID or not Cfg.cfg_effect[self._effectID] then
    Log.exception(self._className, "effectID无效: ", tostring(self._effectID))
  end
  if not self._flySpeed and not self._flyTime then
    Log.exception(self._className, "flySpeed与flyTime不可同时为空")
  end
end

function PlayGridToCasterTrajectoryInstruction:GetCacheResource()
  local t = {}
  if self._effectID then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function PlayGridToCasterTrajectoryInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local casterPos = casterEntity:GetGridPosition()
  local targetGridPos = Vector2(self._posX, self._posY)
  local world = casterEntity:GetOwnerWorld()
  local fxsvc = world:GetService("Effect")
  local eFx = fxsvc:CreateWorldPositionDirectionEffect(self._effectID, targetGridPos, casterPos - targetGridPos)
  YIELD(TT)
  if not eFx or not eFx:View() then
    return
  end
  local flyTime = self._flyTime
  if not flyTime then
    local dis = Vector2.Distance(casterPos, targetGridPos)
    flyTime = dis * self._flySpeed
  end
  local go = eFx:View():GetGameObject()
  local tsfm = go.transform
  local dotween = tsfm:DOMove(casterPos, flyTime * 0.001, false)
  if dotween then
    dotween:SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
    end)
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, flyTime)
    YIELD(TT, self._destroyWaitTime)
    go:SetActive(false)
    world:DestroyEntity(eFx)
  end)
end
