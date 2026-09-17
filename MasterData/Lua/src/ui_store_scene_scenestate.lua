local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    unlockPoint = {}
  }
end

function this:getAllUnlockPoint()
  return self.data.unlockPoint
end

function this:getPointIsUnlock(pointId)
  local wPosTpl = L_GameTpl:getWorldBorthposTpl()
  local tpl = wPosTpl:getTplById(pointId)
  local isUnlock = tpl and not wPosTpl:getIsLockPoint(tpl) or false
  return isUnlock or self.data.unlockPoint[pointId] == true
end

return this
