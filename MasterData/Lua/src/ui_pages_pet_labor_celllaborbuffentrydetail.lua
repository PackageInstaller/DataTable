local module = class("cellLaborBuffEntryDetail", G_UIModuleBase)
local IsPc = L_DeviceTpl:getIsPc()
local UseClickSelect = not IsPc and not IS_EDITOR

function module.bind()
  return {
    img_icon = "",
    txt_detailDesc = "",
    go_hover = false
  }
end

function module:open()
  if UseClickSelect then
    L_PetStore:listenCallFunc(L_PetStore.event.triggerLaborDescPoint, self.syncMobileSelectState, self)
  end
  self.bind.img_icon = self.bind.titleIcon
  self.bind.txt_detailDesc = self.bind.detailDesc
end

function module:close()
  if UseClickSelect then
    L_PetStore:unListenCallFunc(L_PetStore.event.triggerLaborDescPoint, self.syncMobileSelectState, self)
  end
end

function module:syncMobileSelectState(info)
  if not UseClickSelect or info == nil or info.laborId ~= self.bind.laborId then
    return
  end
  self.bind.go_hover = info.id == self.bind.id and info.isShow or false
end

function module.methods()
  return {
    onClick = function(self)
      if not UseClickSelect then
        self:SendEvent(true)
        return
      end
      self:SendEvent(not self.bind.go_hover)
    end,
    onPointEnter_content = function(self)
      if UseClickSelect then
        return
      end
      self:SendEvent(true)
    end,
    onPointExit_content = function(self)
      if UseClickSelect then
        return
      end
      self:SendEvent(false)
    end
  }
end

function module:SendEvent(_isHover)
  self.bind.go_hover = _isHover
  L_PetStore:call(L_PetStore.event.triggerLaborDescPoint, {
    id = self.bind.id,
    laborId = self.bind.laborId,
    isShow = _isHover
  })
end

return module
