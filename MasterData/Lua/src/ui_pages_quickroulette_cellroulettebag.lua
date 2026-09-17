local this = class("cellRouletteBag", G_UIModuleBase)

function this.bind()
  return {
    cellIconBag = L_Const.ModuleInfo.CellIconBag,
    activeTips = false,
    tipsNum = ""
  }
end

function this.methods()
  return {}
end

function this:refresh()
  self._itemType = self._itemType or self.bind.itemType
  self._itemId = self._itemId or self.bind.itemId
  self._guid = self._guid or self.bind.guid
  if self.modules.cellIconBag then
    if not self._itemType then
      self.modules.cellIconBag:setContentActive(false)
      return
    end
    self.modules.cellIconBag:setGeneralContent(self.bind.itemType, self.bind.itemId, self.bind)
  end
  self:setActive(self.bind.go_active)
end

function this:setActive(active)
  if self.modules.cellIconBag then
    self.modules.cellIconBag:setActive(L_CommonUtil.toBoolean(active))
  end
end

function this:showTips(index)
  local showTips = index and 0 < index
  self.bind.activeTips = L_CommonUtil.toBoolean(showTips)
  if not showTips then
    return
  end
  self.bind.tipsNum = tostring(index)
end

return this
