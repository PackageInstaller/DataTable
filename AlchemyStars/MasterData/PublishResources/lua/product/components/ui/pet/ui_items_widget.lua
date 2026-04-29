_class("UIItemsWidget", UICustomWidget)
UIItemsWidget = UIItemsWidget

function UIItemsWidget:OnShow()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self._root = self:GetUIComponent("RectTransform", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self.uiItem:SetClickCallBack(function(go)
    self:UIItemsWidgetOnClick(go)
  end)
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  self.clickCallBack = nil
  self.matID = -1
  self.enough = false
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
end

function UIItemsWidget:OnHide()
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChanged)
  if self.shakeTweener then
    self.shakeTweener:Kill()
    self.shakeTweener = nil
  end
  if self.highLightTimer then
    GameGlobal.Timer():CancelEvent(self.highLightTimer)
    self.highLightTimer = nil
  end
end

function UIItemsWidget:SetData(_id, _needCount, _clickCallback, _singleValue)
  self.matID = _id
  self.needCount = _needCount
  self.clickCallBack = _clickCallback
  self.singleValue = _singleValue
  self.cfgData = Cfg.cfg_item[_id]
  self.roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  self.icon = self.cfgData.Icon
  self.quality = self.cfgData.Color
  self:RefreshCount()
  if self.matID == RoleAssetID.RoleAssetFirefly then
    self:AttachEvent(GameEventType.AircraftOnFireFlyChanged, self.RefreshCount)
  end
end

function UIItemsWidget:RefreshCount()
  local _hadCount = math.floor(self.roleModule:GetAssetCount(self.matID))
  self._text = nil
  if self.singleValue then
    self._text = self.needCount
  else
    local enough = _hadCount >= self.needCount
    self.enough = enough
    local cuStr = self.needCount
    local chStr = _hadCount
    if 9999 < _hadCount then
      chStr = "9999+"
    end
    self.chStr = chStr
    local showStr
    if _hadCount >= self.needCount then
      showStr = "<color=#ffd300>" .. chStr .. "</color><color=#ffffff>/</color><color=#ffd300>" .. cuStr .. "</color>"
    else
      showStr = "<color=#ff0000>" .. chStr .. "</color><color=#ffffff>/</color><color=#ffffff>" .. cuStr .. "</color>"
    end
    self._text = showStr
  end
  self.uiItem:SetData({
    icon = self.icon,
    quality = self.quality,
    text1 = self._text,
    itemId = self.matID
  })
end

function UIItemsWidget:ShakeAndHighlight()
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIMaterialNotEnough)
  if self.shakeTweener then
    self.shakeTweener:Kill()
    self._root.anchoredPosition = Vector2(0, 0)
  end
  if self.highLightTimer then
    GameGlobal.Timer():CancelEvent(self.highLightTimer)
  end
  local head = self.chStr
  local tail = self.needCount
  local text1 = "<color=#ff0000>" .. head .. "/" .. tail .. "</color>"
  self.uiItem:SetData({text1 = text1})
  self.shakeTweener = self._root:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
    self.highLightTimer = GameGlobal.Timer():AddEvent(self._waitTime, function()
      self.uiItem:SetData({
        text1 = self._text
      })
    end)
  end)
end

function UIItemsWidget:IsMatEnough()
  return self.enough
end

function UIItemsWidget:UIItemsWidgetOnClick(go)
  if self.clickCallBack then
    self.clickCallBack(self.matID, go.transform.position)
  end
end

function UIItemsWidget:OnItemCountChanged()
  self:RefreshCount()
end
