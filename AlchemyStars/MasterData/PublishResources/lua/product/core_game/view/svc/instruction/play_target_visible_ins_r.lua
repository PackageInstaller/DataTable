require("base_ins_r")
_class("PlayTargetVisibleInstruction", BaseInstruction)
PlayTargetVisibleInstruction = PlayTargetVisibleInstruction

function PlayTargetVisibleInstruction:Constructor(paramList)
  self._visible = tonumber(paramList.visible)
  local str = paramList.SupportBodySizeList or ""
  if str ~= "" then
    self._SupportBodySizeList = string.split(str, "&")
  end
end

function PlayTargetVisibleInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local targetID = phaseContext:GetCurTargetEntityID()
  local targetEntity = phaseContext._world:GetEntityByID(targetID)
  if not targetEntity then
    return
  end
  if not self:CheckTargetBody(targetEntity) then
    return
  end
  local isShow = self._visible == 1
  local location = targetEntity:Location()
  if location then
    local gridWorldPos = targetEntity:GetPosition()
    local offsetY = isShow and 0 or 1000
    local gridWorldNew = UnityEngine.Vector3.New(gridWorldPos.x, offsetY, gridWorldPos.z)
    targetEntity:SetPosition(gridWorldNew)
  end
  local cHP = targetEntity:HP()
  if not cHP then
    return
  end
  local world = targetEntity:GetOwnerWorld()
  local eidHPBar = cHP:GetHPSliderEntityID()
  local hpBarEntity = world:GetEntityByID(eidHPBar)
  if not hpBarEntity then
    return
  end
  hpBarEntity:SetViewVisible(isShow)
end

function PlayTargetVisibleInstruction:CheckTargetBody(targetEntity)
  if not self._SupportBodySizeList then
    return true
  end
  local bodyCmpt = targetEntity:BodyArea()
  for i, bodySize in ipairs(self._SupportBodySizeList) do
    if bodyCmpt:GetAreaCount() == tonumber(bodySize) then
      return true
    end
  end
  return false
end
