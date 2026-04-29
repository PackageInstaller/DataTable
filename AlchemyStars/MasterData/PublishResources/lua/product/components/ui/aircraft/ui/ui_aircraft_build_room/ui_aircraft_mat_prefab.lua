_class("UIAircraftMatPrefab", UICustomWidget)
UIAircraftMatPrefab = UIAircraftMatPrefab

function UIAircraftMatPrefab:OnShow(uiParams)
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
  self._roleModule = self:GetModule(RoleModule)
  self._rect = self:GetUIComponent("RectTransform", "rect")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIItem")
  self.uiItem:SetForm(UIItemForm.Base)
  self.uiItem:SetClickCallBack(function(go)
    self:itemOnClick(go)
  end)
end

function UIAircraftMatPrefab:SetData(index, matInfo, callback)
  self._index = index
  self._matInfo = matInfo
  self._callback = callback
  self:RefreshData()
  if self.matID == RoleAssetID.RoleAssetFirefly then
    self:AttachEvent(GameEventType.AircraftOnFireFlyChanged, self.RefreshCount)
  end
end

function UIAircraftMatPrefab:RefreshData()
  self._matID = self._matInfo._matID
  local countStr
  self._text1 = ""
  if self._roleModule then
    self._matCountHave = math.floor(self._roleModule:GetAssetCount(self._matInfo._matID))
    self._matCountUpper = self._matInfo._count
    local cuStr = self._matCountUpper
    local chStr = self._matCountHave
    if self._matCountHave > 9999 then
      chStr = "9999+"
    end
    self.chStr = chStr
    local showStr
    if self._matCountHave >= self._matCountUpper then
      showStr = "<color=#ffd300>" .. chStr .. "</color><color=#ffffff>/</color><color=#ffd300>" .. cuStr .. "</color>"
    else
      showStr = "<color=#ff0000>" .. chStr .. "</color><color=#ffffff>/</color><color=#ffffff>" .. cuStr .. "</color>"
    end
    self._text1 = showStr
  end
  local icon = ""
  local quality = ""
  local itemId = self._matInfo._matID
  local cfg = Cfg.cfg_item[self._matInfo._matID]
  if cfg then
    quality = cfg.Color
    icon = cfg.Icon
  else
    Log.fatal("###cfg is nil,item_id = " .. self._matInfo._matID)
  end
  self.uiItem:SetData({
    icon = icon,
    quality = quality,
    text1 = self._text1,
    itemId = itemId
  })
end

function UIAircraftMatPrefab:CheckCountEnough()
  return self._matCountHave >= self._matCountUpper
end

function UIAircraftMatPrefab:Blink()
  if self._matCountHave < self._matCountUpper then
    if self._tweener then
      self._tweener:Kill()
    end
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
      self._rect.anchoredPosition = Vector2(0, 0)
    end
    local head = self.chStr
    local tail = self._matCountUpper
    local text1 = "<color=#ff0000>" .. head .. "/" .. tail .. "</color>"
    self.uiItem:SetData({text1 = text1})
    self._tweener = self._rect:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
      self._event = GameGlobal.Timer():AddEvent(self._waitTime, function()
        self.uiItem:SetData({
          text1 = self._text1
        })
      end)
    end)
  end
end

function UIAircraftMatPrefab:OnHide()
  if self._tweener then
    self._tweener:Kill()
  end
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
  end
end

function UIAircraftMatPrefab:Constructor()
  self._matCountHave = 0
  self._matCountUpper = 0
  self._matID = 0
  self._callback = nil
end

function UIAircraftMatPrefab:Dispose()
  self._matCountHave = 0
  self._matCountUpper = 0
  self._matID = 0
  self._callback = nil
  self._tweener = nil
  self._event = nil
  self._atlas = nil
end

function UIAircraftMatPrefab:itemOnClick(go)
  if self._callback then
    self._callback(self._matID, go.transform.position)
  end
end
