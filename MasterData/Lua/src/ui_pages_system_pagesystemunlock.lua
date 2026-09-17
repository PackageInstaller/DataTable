local this = class("pageSystemUnlock", G_UIPageBase)
local _systemTpl = L_GameTpl:getSystemUnlockTpl()

function this.bind()
  return {
    imgSystem = "",
    txtTip = "",
    txtSystemName = "",
    active_btn = false
  }
end

function this.methods()
  return {
    btnClick = function(self)
      self:doNext()
      if self.timer then
        self.timer.consume = self.timer.duration
      end
    end
  }
end

function this:preOpen()
  self.systemIds = {}
  L_AudioUtil.playSound("Play_SFX_System_HUD_General_SystemUnlock")
  self:doNext(true)
  self.timer = Timer.repeated(2, self.doNext, self)
end

function this:refreshUI(systemId)
  local tpl = _systemTpl:getTplById(systemId)
  if tpl then
    self.bind.txtTip = _systemTpl:getUnlockTips(tpl)
    self.bind.txtSystemName = _systemTpl:getName(tpl)
    self.bind.imgSystem = _systemTpl:getIcon(tpl)
  end
end

function this:doNext(noAnim)
  self.bind.active_btn = false
  local systemId = C_IntegrateMgr.SystemUnlockModule:DeQueueSystemUnlockId()
  if systemId and systemId ~= 0 then
    table.insert(self.systemIds, systemId)
    self:refreshUI(systemId)
    if not noAnim then
      L_AudioUtil.playSound("Play_SFX_System_HUD_General_SystemUnlock")
      self.blendDefinition:OpenReset()
      self.blendDefinition:PlayOpen(function()
        self.bind.active_btn = true
      end)
    end
  else
    L_UI:close("pageSystemUnlock")
  end
end

function this:escHandle()
end

function this:close()
  if self.timer then
    Timer.remove(self.timer)
    self.timer = nil
  end
  if C_GameFlow.inLoading then
    for i = #self.systemIds, 1, -1 do
      C_IntegrateMgr.SystemUnlockModule:reEnqueueToFront(self.systemIds[i])
    end
  else
    for _, id in ipairs(self.systemIds) do
      C_IntegrateMgr.SystemUnlockModule:dispathchGuideTriggerEvent(id)
    end
  end
  C_IntegrateMgr.SystemUnlockModule:onSystemUnlockPageClosed()
end

return this
