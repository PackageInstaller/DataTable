_class("UIPetEquipUpLvItem", UICustomWidget)
UIPetEquipUpLvItem = UIPetEquipUpLvItem

function UIPetEquipUpLvItem:Constructor()
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
end

function UIPetEquipUpLvItem:OnShow(uiParams)
  self._rect = self:GetUIComponent("RectTransform", "uiitem")
  self._uiItemPool = self:GetUIComponent("UISelectObjectPath", "uiitem")
end

function UIPetEquipUpLvItem:SetData(itemInfo)
  local itemid = itemInfo[1]
  local roleModule = self:GetModule(RoleModule)
  local count = roleModule:GetAssetCount(itemid)
  local needCount = itemInfo[2]
  self._matInfo = UIPetEquipUpLvItemData:New(itemid, count, needCount)
  self._uiItem = self._uiItemPool:SpawnObject("UIItem")
  self._uiItem:SetForm(UIItemForm.Base, UIItemScale.Level2)
  self._uiItem:SetClickCallBack(function()
    self:_ShowTipBtnOnClick()
  end)
  self:_UIItemSetData()
end

function UIPetEquipUpLvItem:_ShowTipBtnOnClick()
  self:ShowDialog("UIItemGetPathController", self._matInfo.id, nil, nil, self._matInfo.needCount)
end

function UIPetEquipUpLvItem:FlushCount()
  local roleModule = self:GetModule(RoleModule)
  local count = roleModule:GetAssetCount(self._matInfo.id)
  self._matInfo:FlushCount(count)
  self:_UIItemSetData()
end

function UIPetEquipUpLvItem:_UIItemSetData()
  local itemConfig = Cfg.cfg_item[self._matInfo.id]
  if not itemConfig then
    Log.error("###[UIPetEquipUpLvItem] cfg_item is nil ! id --> ", self._matInfo.id)
    return
  end
  local itemId = self._matInfo.id
  local icon = itemConfig.Icon
  local quality = itemConfig.Color
  local str, showCount
  if self._matInfo.count > 9999 then
    showCount = "9999+"
  elseif self._matInfo.count < 0 then
    showCount = 0
  else
    showCount = self._matInfo.count
  end
  if self._matInfo:CheckEnough() then
    str = "<color=#ffd300>" .. showCount .. "</color><color=#ffffff>/</color><color=#ffd300>" .. self._matInfo.needCount .. "</color>"
  else
    str = "<color=#ff0000>" .. showCount .. "</color><color=#ffffff>/</color><color=#ffffff>" .. self._matInfo.needCount .. "</color>"
  end
  self._uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = str,
    itemId = itemId
  })
end

function UIPetEquipUpLvItem:Blink()
  if self.tweer and self.tweer:IsPlaying() then
    return
  end
  local showCount
  if self._matInfo.count > 9999 then
    showCount = "9999+"
  elseif self._matInfo.count < 0 then
    showCount = 0
  else
    showCount = self._matInfo.count
  end
  local str = "<color=#ff0000>" .. showCount .. "/" .. self._matInfo.needCount .. "</color>"
  self._uiItem:SetData({text1 = str})
  self.tweer = self._rect:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
    self:StartTimer()
  end)
end

function UIPetEquipUpLvItem:StartTimer()
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
    self.event = nil
  end
  self.event = GameGlobal.Timer():AddEvent(self._waitTime, function()
    local str, showCount
    if self._matInfo.count > 9999 then
      showCount = "9999+"
    elseif self._matInfo.count < 0 then
      showCount = 0
    else
      showCount = self._matInfo.count
    end
    if self._matInfo:CheckEnough() then
      str = "<color=#ffd300>" .. showCount .. "</color><color=#ffffff>/</color><color=#ffd300>" .. self._matInfo.needCount .. "</color>"
    else
      str = "<color=#ff0000>" .. showCount .. "</color><color=#ffffff>/</color><color=#ffffff>" .. self._matInfo.needCount .. "</color>"
    end
    self._uiItem:SetData({text1 = str})
  end)
end

function UIPetEquipUpLvItem:CheckEnough()
  return self._matInfo:CheckEnough()
end

function UIPetEquipUpLvItem:GetGapsCount()
  local needCount = self._matInfo.needCount
  local count = self._matInfo.count
  local id = self._matInfo.id
  if needCount > count then
    local mat = {}
    mat.id = id
    mat.count = needCount - count
    return mat
  end
end

function UIPetEquipUpLvItem:OnHide()
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
    self.event = nil
  end
  if self.tweer then
    self.tweer:Kill(false)
    self.tweer = nil
  end
  self._uiitem = nil
  self._rect = nil
  self._matInfo = nil
  self._waitTime = nil
  self._shakeX = nil
  self._shakeY = nil
end

_class("UIPetEquipUpLvItemData", Object)
UIPetEquipUpLvItemData = UIPetEquipUpLvItemData

function UIPetEquipUpLvItemData:Constructor(id, count, needCount)
  self.id = id
  self.count = count
  self.needCount = needCount
end

function UIPetEquipUpLvItemData:FlushCount(count)
  self.count = count
end

function UIPetEquipUpLvItemData:CheckEnough()
  return self.count >= self.needCount
end
