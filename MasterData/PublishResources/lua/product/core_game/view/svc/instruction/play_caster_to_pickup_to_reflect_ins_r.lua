require("base_ins_r")
_class("PlayCasterToPickupToReflectInstruction", BaseInstruction)
PlayCasterToPickupToReflectInstruction = PlayCasterToPickupToReflectInstruction

function PlayCasterToPickupToReflectInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._flyTime = tonumber(paramList.flyTime)
  self._flySpeed = tonumber(paramList.flySpeed)
  self._offsetX = tonumber(paramList.offsetX)
  self._offsetY = tonumber(paramList.offsetY)
  self._offsetZ = tonumber(paramList.offsetZ)
  self._offsetX2 = tonumber(paramList.offsetX2)
  self._offsetY2 = tonumber(paramList.offsetY2)
  self._offsetZ2 = tonumber(paramList.offsetZ2)
  if not self._effectID or not Cfg.cfg_effect[self._effectID] then
    Log.exception(self._className, "effectID无效: ", tostring(self._effectID))
  end
  if not self._flySpeed or not self._flyTime then
    Log.exception(self._className, "flySpeed与flyTime不可为空")
  end
end

function PlayCasterToPickupToReflectInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  return t
end

function PlayCasterToPickupToReflectInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local beginPos = casterEntity:GetPosition()
  local pickUpGridPos, reflectGridPos
  local renderPickUpComponent = casterEntity:RenderPickUpComponent()
  if renderPickUpComponent then
    pickUpGridPos = renderPickUpComponent:GetLastPickUpGridPos()
    reflectGridPos = renderPickUpComponent:GetReflectPos()
  end
  if not pickUpGridPos then
    Log.exception(self._className, "没有点选位置")
    return
  end
  local world = casterEntity:GetOwnerWorld()
  local rbsvc = world:GetService("BoardRender")
  local targetPos1 = rbsvc:GridPos2RenderPos(pickUpGridPos)
  local beginGridPos = rbsvc:BoardRenderPos2GridPos(beginPos)
  local fxsvc = world:GetService("Effect")
  local tran = casterEntity:View():GetGameObject().transform
  local renderPos = tran:TransformPoint(Vector3(self._offsetX, self._offsetY, self._offsetZ))
  local eFx = fxsvc:CreatePositionEffect(self._effectID, renderPos)
  eFx:SetDirection(targetPos1 - renderPos)
  YIELD(TT)
  if not eFx or not eFx:View() then
    return
  end
  local go = eFx:View():GetGameObject()
  local tsfm = go.transform
  local seq = DG.Tweening.DOTween.Sequence()
  local t1 = tsfm:DOMove(targetPos1, self._flyTime * 0.001, false)
  seq:Append(t1)
  local targetPos2 = rbsvc:GridPos2RenderPos(reflectGridPos)
  local dir = targetPos2 - targetPos1
  dir = dir:Normalize()
  targetPos2 = targetPos2 + dir * 9
  local dis = Vector3.Distance(targetPos1, targetPos2)
  local flyTime2 = dis * self._flySpeed
  local t2 = tsfm:DOMove(targetPos2, flyTime2 * 0.001, false)
  seq:Append(t2)
end
