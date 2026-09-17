local this = class("cellQuickRoulette", G_UIModuleBase)

function this.bind()
  return {
    go_empty = false,
    txt_index = nil,
    go_normal = false,
    img_icon = nil,
    txt_num = "",
    activeSelectBg = false
  }
end

function this.methods()
  return {
    onClick_select = function(self)
      self:emit("onClick_select", self.bind)
    end
  }
end

function this:open()
  this.super.open(self)
  self:initCell(true)
end

function this:initCell(isInit)
  if not self.isBind then
    return
  end
  self._guid = L_QuickRouletteStore:getGuidByIndex(self.bind.index)
  local isEmpty = math.isEmpty(self._guid)
  local isDataChange = self._lastGuid ~= self._guid
  if isDataChange or isInit then
    self.bind.go_empty = isEmpty
    self.bind.go_normal = not isEmpty
  end
  if not isEmpty then
    self.itemInfo = L_QuickRouletteManager:getItemInfo(self._guid)
    self.bind.img_icon = self.itemInfo.icon
    self.bind.txt_num = tostring(self.itemInfo.num)
  else
    self.bind.txt_index = tostring(self.bind.index)
    self.bind.txt_num = ""
  end
  local isSelect = L_QuickRouletteStore:getCurSelectIndex() == self.bind.index
  self.bind.activeSelectBg = isSelect and self.bind.showSelect
  self._lastGuid = self._guid
end

return this
