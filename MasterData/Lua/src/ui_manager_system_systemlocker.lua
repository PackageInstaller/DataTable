local this = class("systemLocker")
local _systemTpl = L_GameTpl:getSystemUnlockTpl()
local _lockPath = "Program/System/pre_systemLock.prefab"
local _halfWidth = 12.5
local _halfHeight = 18.5

function this:ctor(systemId)
  self.systemId = systemId
  self.preLock = nil
  self.callback = nil
  self.register = nil
  self.obj = nil
end

function this:unlock()
  self:triggerCallback()
end

function this:addRevertHandle(handle)
  table.insert(self.revertList, handle)
end

function this:setCallback(callback, register, obj)
  self.callback = callback
  self.register = register
  self.obj = obj
end

function this:triggerCallback()
  if self.callback == nil then
    return
  end
  if self.obj and self.obj:IsNull() then
    return
  end
  if self.register then
    self.callback(self.register, self.systemId, true)
  else
    self.callback(self.systemId, true)
  end
end

function this:onDestroy()
end

function this:tryShowOrHide(dependent, isUnlock)
  local isNeedShow = L_SystemUnlockManager:tryShowOrHide(self.systemId, dependent, isUnlock)
  return isNeedShow
end

function this:grayTransform(isGray)
end

function this:addLockIcon(dependTrans, lockType, offset)
  if self.preLock == nil then
    self.preLock = L_ResPool:syncGameObject(_lockPath)
  end
  local rt = dependTrans:GetComponent(C_RectTransform)
  local rtPos = L_Vector3.getPos(rt)
  self.originPos = L_Vector3.getTemp(rtPos.x, rtPos.y, rtPos.z)
  local preTrans = self.preLock.tranform
  preTrans:SetParent(rt)
  offset = offset or L_Vector3.getTemp()
  if lockType == L_SystemConst.lockType.bottom then
    local height = rt.sizeDelta.y * 0.5 + _halfHeight
    offset.y = offset.y - height
    rtPos.y = rtPos.y + height * 0.5
  elseif lockType == L_SystemConst.lockType.top then
    local height = rt.sizeDelta.y * 0.5 + _halfHeight
    offset.y = offset.y + height
    rtPos.y = rtPos.y - height * 0.5
  elseif lockType == L_SystemConst.lockType.right then
    local width = rt.sizeDelta.x * 0.5 + _halfWidth
    offset.x = offset.x + width
    rtPos.x = rtPos.x - width * 0.5
  else
    local width = rt.sizeDelta.x * 0.5 + _halfWidth
    offset.x = offset.x - width
    rtPos.x = rtPos.x + width * 0.5
  end
  L_Vector3.setPos(rt, rtPos)
  L_Vector3.setLocalPos(preTrans, offset)
end

function this:removeLockIcon()
  if self.preLock == nil then
    return
  end
  local dependent = self.preLock.transform.parent
  C_BoundGameObject.Destroy(self.preLock)
  self.preLock = nil
  L_Vector3.setPos(dependent, self.originPos)
end

return this
