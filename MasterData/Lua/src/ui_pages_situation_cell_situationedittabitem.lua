local this = class("situationEditTabItem", G_UIModuleBase)

function this.bind()
  return {
    tabId = nil,
    imgIcon = nil,
    txtTabName = "",
    txtInfo = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
    end
  }
end

function this:open()
  L_SituationStore:listenCallFunc(L_SituationStore.event.objCountChanged, self.onCountChanged, self)
end

function this:refreshInfo()
  if self.bind.tabId == L_Const.situationGroup.env then
    return
  end
  local max = L_SituationManager.countLimit[self.bind.tabId]
  self.bind.txtInfo = string.format("%d/%d", L_SituationManager:getCount(self.bind.tabId), max)
end

function this:onCountChanged(type)
  if type == self.bind.tabId then
    self:refreshInfo()
  end
end

function this:close()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.objCountChanged, self.onCountChanged, self)
end

return this
