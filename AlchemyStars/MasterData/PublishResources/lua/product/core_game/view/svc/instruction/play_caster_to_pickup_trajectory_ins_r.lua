require("base_ins_r")
_class("PlayCasterToPickupTrajectoryInstruction", BaseInstruction)
PlayCasterToPickupTrajectoryInstruction = PlayCasterToPickupTrajectoryInstruction

function PlayCasterToPickupTrajectoryInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._flySpeed = tonumber(paramList.flySpeed)
  self._flyTime = tonumber(paramList.flyTime)
  if not self._effectID or not Cfg.cfg_effect[self._effectID] then
    Log.exception(self._className, "effectID无效: ", tostring(self._effectID))
  end
  if not self._flySpeed and not self._flyTime then
    Log.exception(self._className, "flySpeed与flyTime不可同时为空")
  end
end

function PlayCasterToPickupTrajectoryInstruction:GetCacheResource()
  local t = {}
  if self._effectID then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function PlayCasterToPickupTrajectoryInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local beginPos = casterEntity:GetPosition()
  local targetGridPos = phaseContext:GetCurGridPos()
  if not targetGridPos then
    local renderPickUpComponent = casterEntity:RenderPickUpComponent()
    if renderPickUpComponent then
      local pickUpGridArray = renderPickUpComponent:GetAllValidPickUpGridPos()
      targetGridPos = pickUpGridArray[1]
    end
  end
  if not targetGridPos then
    Log.exception(self._className, "没有点选位置")
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local rbsvc = world:GetService("BoardRender")
  local targetPos = rbsvc:GridPos2RenderPos(targetGridPos)
  local beginGridPos = rbsvc:BoardRenderPos2GridPos(beginPos)
  local fxsvc = world:GetService("Effect")
  local eFx = fxsvc:CreateCommonGridEffect(self._effectID, beginGridPos, targetGridPos - beginGridPos)
  YIELD(TT)
  if not eFx or not eFx:View() then
    return
  end
  local flyTime = self._flyTime
  if not flyTime then
    local dis = Vector3.Distance(beginPos, targetPos)
    flyTime = dis * self._flySpeed
  end
  local go = eFx:View():GetGameObject()
  local tsfm = go.transform
  local dotween = tsfm:DOMove(targetPos, flyTime * 0.001, false)
  if dotween then
    dotween:SetEase(DG.Tweening.Ease.InOutSine):OnComplete(function()
      go:SetActive(false)
      world:DestroyEntity(eFx)
    end)
  end
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    YIELD(TT, flyTime)
    if not dotween then
      world:DestroyEntity(eFx)
    end
  end)
end
