_class("UIBreakMatItem", UICustomWidget)
UIBreakMatItem = UIBreakMatItem

function UIBreakMatItem:OnShow()
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
  self.clickCallBack = nil
  self.matID = -1
  self.rect = self:GetUIComponent("RectTransform", "uiitem")
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIAsset")
end

function UIBreakMatItem:OnHide()
  if self.shakeTweener then
    self.shakeTweener:Kill()
  end
  if self.highLightTimer then
    GameGlobal.Timer():CancelEvent(self.highLightTimer)
  end
end

function UIBreakMatItem:SetData(_id, _needCount, single, _clickCallback)
  self.matID = _id
  self.cfgData = Cfg.cfg_item[_id]
  if self.cfgData == nil then
    Log.fatal("item id not found", _id)
  end
  self.curText = nil
  if single then
    self.curText = string.format("<color=#ffd300>%s</color>", _needCount)
  else
    local roleModule = GameGlobal.GetModule(RoleModule)
    local _hadCount = math.floor(roleModule:GetAssetCount(_id))
    self.hadCount = _hadCount
    self.needCount = _needCount
    local enough = _needCount <= _hadCount
    if 9999 < _hadCount then
      _hadCount = "9999+"
    end
    local format
    if enough then
      format = "<color=#ffd300>%s</color><color=#ffffff>/</color><color=#ffd300>%s</color>"
    else
      format = "<color=#ff0000>%s</color><color=#ffffff>/</color><color=#ffffff>%s</color>"
    end
    self.curText = string.format(format, _hadCount, _needCount)
  end
  local icon = self.cfgData.Icon
  local text1 = self.curText
  local quality = self.cfgData.Color
  self.clickCallBack = _clickCallback
  if not self.eventComponent then
    self.uiItem:SetData(self.matID)
    self.eventComponent = self.uiItem:AddComponent(UIAssetComponentEvent)
    self.eventComponent:SetClickCallBack(function(go)
      self:UIItemsWidgetOnClick(go)
    end)
  end
  self.uiItem:SetItemData({
    showBG = true,
    icon = icon,
    text = text1,
    quality = quality
  })
  self.uiItem:SetBgImage(true)
end

function UIBreakMatItem:UIItemsWidgetOnClick(go)
  if self.clickCallBack then
    self.clickCallBack(self.matID, go.transform.position)
  end
end

function UIBreakMatItem:ShakeAndHighlight()
  if self.shakeTweener and self.shakeTweener:IsPlaying() then
    return
  end
  if self.highLightTimer then
    GameGlobal.Timer():CancelEvent(self.highLightTimer)
  end
  if self.shakeTweener then
    self.shakeTweener:Kill()
    self.rect.anchoredPosition = Vector2(0, 0)
  end
  self.uiItem:SetItemData({
    showBG = true,
    icon = self.cfgData.Icon,
    quality = self.cfgData.Color,
    text = string.format("<color=#ff0000>%s/%s</color>", self.hadCount, self.needCount)
  })
  self.uiItem:SetBgImage(true)
  self.shakeTweener = self.rect:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
    self.highLightTimer = GameGlobal.Timer():AddEvent(self._waitTime, function()
      self.uiItem:SetItemData({
        showBG = true,
        icon = self.cfgData.Icon,
        quality = self.cfgData.Color,
        text = self.curText
      })
      self.uiItem:SetBgImage(true)
    end)
  end)
end

function UIBreakMatItem:IsEnough()
  return self.hadCount >= self.needCount
end
