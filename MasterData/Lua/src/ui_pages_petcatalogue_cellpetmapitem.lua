local module = class("cellPetMapItem", G_UIModuleBase)

function module.bind()
  return {
    textW = "",
    textG = "",
    goW = true,
    goG = false,
    goIcon = false,
    goLine = true,
    goSelect = false,
    goStar = false
  }
end

function module.methods()
  return {
    onClick = function(self)
      if self.bind.isLock then
        L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_unlockArea"))
        return
      end
      if self.bind.onClickCb then
        self.bind.onClickCb(self)
      end
    end
  }
end

function module:refresh()
  if self.bind.isLock then
    self.bind.textG = self.bind.name
  else
    self.bind.textW = self.bind.name
  end
  self.bind.goW = not self.bind.isLock
  self.bind.goG = self.bind.isLock
  self.bind.goIcon = self.bind.iconActive
  self.bind.goStar = self.bind.areaId == AzurWorld.areaManager:GetMapAreaId()
end

return module
