_class("UIAircraftRoomFuncItem", UICustomWidget)
UIAircraftRoomFuncItem = UIAircraftRoomFuncItem

function UIAircraftRoomFuncItem:OnShow(uiParams)
  self.title = self:GetUIComponent("UILocalizationText", "TextTitle")
  self.value = self:GetUIComponent("UILocalizationText", "TextValue")
  self.layoutRect = self:GetUIComponent("RectTransform", "layout")
  self.buffFormat = "%s<color=#63ff72>(+%s)</color>"
  self.deBuffFormat = "%s<color=#eb4040>(%s)</color>"
end

function UIAircraftRoomFuncItem:OnHide()
  self:DetachEvent(GameEventType.AircraftOnAtomChanged, self.RefreshAtom)
end

function UIAircraftRoomFuncItem:GetLayoutRect()
  return self.layoutRect
end

function UIAircraftRoomFuncItem:SetAsAtom(name)
  self:DetachEvent(GameEventType.AircraftOnAtomChanged, self.RefreshAtom)
  self.title:SetText(StringTable.Get(name))
  self:RefreshAtom()
  self:AttachEvent(GameEventType.AircraftOnAtomChanged, self.RefreshAtom)
end

function UIAircraftRoomFuncItem:RefreshAtom()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local airModule = GameGlobal.GetModule(AircraftModule)
  local room = airModule:GetSmeltRoom()
  local count = roleModule:GetAtom()
  local ceiling = room:GetStorageMax()
  self.value:SetText(count .. "/" .. ceiling)
end

function UIAircraftRoomFuncItem:SetDataSpecial(name, val, bonus)
  self:DetachEvent(GameEventType.AircraftOnAtomChanged, self.RefreshAtom)
  self.title:SetText(StringTable.Get(name))
  if bonus and 0 < bonus then
    self.value:SetText(string.format(self.buffFormat, val, bonus))
  else
    self.value:SetText(val)
  end
end

function UIAircraftRoomFuncItem:SetData(name, base, add, isInt, isPercent)
  self:DetachEvent(GameEventType.AircraftOnAtomChanged, self.RefreshAtom)
  self.title:SetText(StringTable.Get(name))
  local baseStr, addStr = "", ""
  if isInt then
    baseStr = math.floor(base)
    if add then
      addStr = math.floor(add)
    end
  else
    if base == 0 then
      baseStr = ""
    else
      baseStr = string.format("%.2f", base)
    end
    if add then
      addStr = string.format("%.2f", add)
    end
  end
  if isPercent then
    if base == 0 then
      baseStr = "0%"
    else
      baseStr = math.floor(base * 100) .. "%"
    end
  end
  if add == nil then
    self.value:SetText(baseStr)
  elseif 0 < add then
    self.value:SetText(string.format(self.buffFormat, baseStr, addStr))
  elseif add < 0 then
    self.value:SetText(string.format(self.deBuffFormat, baseStr, addStr))
  else
    self.value:SetText(baseStr)
  end
end
