local this = class("loadingBehavior_saveFormation", require("ui.manager.loading.behavior.loadingBehavior"))

function this:bind()
  return {}
end

function this.methods()
  return {}
end

function this:open(...)
  this.super.open(self, ...)
  L_PlayerManager:addListener(L_PlayerManager.event.setMainControl, self.updateProgressMax, self, nil, 0)
end

function this:close()
  this.super.close(self)
  L_PlayerManager:removeListener(L_PlayerManager.event.setMainControl, self.updateProgressMax)
end

function this:updateProgressMax()
  if self.bindComponents ~= nil and self.bindComponents.anim ~= nil then
    self.bindComponents.anim:Play("anim_formation_loading_out")
  end
  self.timerDic.max = Timer.once(0.233, self.complete, self, self.gameObject)
end

return this
