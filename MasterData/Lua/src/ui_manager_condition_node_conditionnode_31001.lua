local this = class("conditionNode_31001", require(L_R.condition .. "conditionNode"))

function this:ctor(condition)
  this.super.ctor(self, condition)
  self._refreshHandle = self._refreshHandle or handler(self, self.refresh)
  C_NestCoopStoreEvent.instance:Listen(C_ENestStoreEvent.RefreshLevelStarSuccessNum, self._refreshHandle)
  self.autoDestroy = false
end

function this:onDestroy()
  if self._refreshHandle ~= nil then
    C_NestCoopStoreEvent.instance:Cancel(C_ENestStoreEvent.RefreshLevelStarSuccessNum, self._refreshHandle)
    self._refreshHandle = nil
  end
  this.super.onDestroy(self)
end

function this:refresh()
  self.super.refresh(self)
end

function this.checkFunc(condition)
  local targetTier = condition[2]
  local needNum = condition[3]
  if targetTier ~= nil then
    local curPassNum = C_NestCoopStore.GetTargetStarSucceedCountByLua(targetTier)
    return needNum <= curPassNum
  else
    return false
  end
end

return this
