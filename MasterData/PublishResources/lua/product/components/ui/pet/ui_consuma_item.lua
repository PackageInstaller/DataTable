_class("UIConsumaItem", UICustomWidget)
UIConsumaItem = UIConsumaItem

function UIConsumaItem:Constructor()
  self._consumItemInfo = nil
  self._itemIndex = nil
  self._waitTime = Cfg.cfg_global.shakeWaitTime.IntValue or 2000
  self._shakeX = Cfg.cfg_global.shakeOffsetX.IntValue or 10
  self._shakeY = Cfg.cfg_global.shakeOffsetY.IntValue or 10
end

function UIConsumaItem:OnShow()
  self._itemGo = self:GetUIComponent("RectTransform", "item")
  self._affinityGo = self:GetGameObject("affinity")
  self._roleModule = GameGlobal.GameLogic():GetModule(RoleModule)
  self.textFormat = "%s<sprite=spirit_xie1_frame /><color=#000000>%s</color>"
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIAsset")
end

function UIConsumaItem:OnHide()
  self:Release()
  if self.tweer then
    self.tweer:Kill(false)
  end
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
end

function UIConsumaItem:Dispose()
end

function UIConsumaItem:Release()
  self._consumItemInfo = nil
  self._itemIndex = nil
end

function UIConsumaItem:showTipBtnOnClick(go)
  if self._consumItemInfo == nil or self._consumItemInfo.ConditionType == "Level" or self._consumItemInfo == nil or self._consumItemInfo.ConditionType == "Affinity" then
    return
  end
  self._callBack(self._consumItemInfo.ID, self._consumItemInfo.condition, self.uiItem:GetBtn().transform.position)
end

function UIConsumaItem:SetData(petInfo, tConsumItemInfo, itemIndex, onlyShowNeed, callBack)
  if tConsumItemInfo == nil then
    return
  end
  self._callBack = callBack
  self._petInfo = petInfo
  self._itemIndex = itemIndex
  self._consumItemInfo = tConsumItemInfo
  if not self.eventComponent then
    self.uiItem:SetData(self._consumItemInfo.ID)
    self.eventComponent = self.uiItem:AddComponent(UIAssetComponentEvent)
    self.levelComponent = self.uiItem:AddComponent(UIAssetComponentLevel)
    self.eventComponent:SetClickCallBack(function(go)
      self:showTipBtnOnClick(go)
    end)
  end
  self._onlyShowNeed = onlyShowNeed
  self:ShowTex()
end

function UIConsumaItem:RefreshItemCount()
  self:ShowTex()
end

function UIConsumaItem:ShowTex()
  local isShow = false
  local content
  local bagNum = 0
  self._str = ""
  if self._consumItemInfo.ConditionType == "Level" then
    local petLevel = self._petInfo:GetPetLevel()
    isShow = petLevel >= self._consumItemInfo.condition
    bagNum = petLevel
    if self._onlyShowNeed then
      self._str = "<color=#ffd300>" .. self._consumItemInfo.condition .. "</color>"
    elseif isShow then
      self._str = "<color=#ffd300>" .. petLevel .. "</color><color=#ffffff>/</color><color=#ffd300>" .. self._consumItemInfo.condition .. "</color>"
    else
      self._str = "<color=#ff0000>" .. petLevel .. "</color><color=#ffffff>/</color><color=#ffffff>" .. self._consumItemInfo.condition .. "</color>"
    end
    self.uiItem:SetItemData({
      showBG = true,
      text = self._str,
      quality = 1
    })
    self.levelComponent:SetLevel(petLevel)
    self.uiItem:SetBgImage(true)
    self._affinityGo:SetActive(false)
  elseif self._consumItemInfo.ConditionType == "Affinity" then
    local affinityLevel = self._petInfo:GetPetAffinityLevel()
    isShow = affinityLevel >= self._consumItemInfo.condition
    bagNum = affinityLevel
    if self._onlyShowNeed then
      self._str = "<color=#ffd300>" .. self._consumItemInfo.condition .. "</color>"
    elseif isShow then
      self._str = "<color=#ffd300>" .. affinityLevel .. "</color><color=#ffffff>/</color><color=#ffd300>" .. self._consumItemInfo.condition .. "</color>"
    else
      self._str = "<color=#ff0000>" .. affinityLevel .. "</color><color=#ffffff>/</color><color=#ffffff>" .. self._consumItemInfo.condition .. "</color>"
    end
    self.uiItem:SetItemData({
      showBG = true,
      text = self._str,
      quality = 1
    })
    self._affinityGo:SetActive(true)
  else
    bagNum = self._roleModule:GetAssetCount(self._consumItemInfo.ID)
    local itemConfig = Cfg.cfg_item[self._consumItemInfo.ID]
    local itemId = self._consumItemInfo.ID
    local icon = itemConfig.Icon
    local quality = itemConfig.Color
    local isShow = bagNum >= self._consumItemInfo.condition
    if 9999 < bagNum then
      bagNum = "9999+"
    elseif bagNum < 0 then
      bagNum = "0"
    end
    if self._onlyShowNeed then
      self._str = "<color=#ffd300>" .. self._consumItemInfo.condition .. "</color>"
    elseif isShow then
      self._str = "<color=#ffd300>" .. bagNum .. "</color><color=#ffffff>/</color><color=#ffd300>" .. self._consumItemInfo.condition .. "</color>"
    else
      self._str = "<color=#ff0000>" .. bagNum .. "</color><color=#ffffff>/</color><color=#ffffff>" .. self._consumItemInfo.condition .. "</color>"
    end
    self.uiItem:SetItemData({
      showBG = true,
      icon = icon,
      quality = quality,
      text = self._str
    })
    self.uiItem:SetBgImage(true)
    self._affinityGo:SetActive(false)
  end
end

function UIConsumaItem:DOShakePosition()
  if self.tweer and self.tweer:IsPlaying() then
    return
  end
  self:StopTween()
  if self._consumItemInfo.ConditionType == "Level" then
    local petLevel = self._petInfo:GetPetLevel()
    local str = "<color=#ff0000>" .. petLevel .. "/" .. self._consumItemInfo.condition .. "</color>"
    self.uiItem:SetItemData({
      showBG = true,
      quality = 1,
      text = str
    })
    self.levelComponent:SetLevel(petLevel)
    self.uiItem:SetBgImage(true)
    self._affinityGo:SetActive(false)
  elseif self._consumItemInfo.ConditionType == "Affinity" then
    local petAffinity = self._petInfo:GetPetAffinityLevel()
    local str = "<color=#ff0000>" .. petAffinity .. "/" .. self._consumItemInfo.condition .. "</color>"
    self.uiItem:SetItemData({
      showBG = true,
      quality = 1,
      text = str
    })
    self.uiItem:SetBgImage(true)
    self._affinityGo:SetActive(false)
  else
    local bagNum = self._roleModule:GetAssetCount(self._consumItemInfo.ID)
    local str = "<color=#ff0000>" .. bagNum .. "/" .. self._consumItemInfo.condition .. "</color>"
    local itemConfig = Cfg.cfg_item[self._consumItemInfo.ID]
    local icon = itemConfig.Icon
    local quality = itemConfig.Color
    self.uiItem:SetItemData({
      showBG = true,
      icon = icon,
      quality = quality,
      text = str
    })
    self.uiItem:SetBgImage(true)
    self._affinityGo:SetActive(false)
  end
  self.tweer = self._itemGo:DOShakePosition(1, Vector3(self._shakeX, self._shakeY, 0)):OnComplete(function()
    self:StartTimer()
  end)
end

function UIConsumaItem:StopTween()
  if self.tweer then
    self.tweer:Kill(false)
    if self._itemGo then
      self._itemGo.anchoredPosition = Vector2(0, 0)
    end
  end
  if self.event then
    GameGlobal.Timer():CancelEvent(self.event)
  end
end

function UIConsumaItem:StartTimer()
  self.event = GameGlobal.Timer():AddEvent(self._waitTime, function()
    if self._consumItemInfo.ConditionType == "Level" then
      local petLevel = self._petInfo:GetPetLevel()
      self.uiItem:SetItemData({
        showBG = true,
        quality = 1,
        text = self._str
      })
      self.levelComponent:SetLevel(petLevel)
      self.uiItem:SetBgImage(true)
      self._affinityGo:SetActive(false)
    else
      local itemConfig = Cfg.cfg_item[self._consumItemInfo.ID]
      local icon = itemConfig.Icon
      local quality = itemConfig.Color
      self.uiItem:SetItemData({
        showBG = true,
        icon = icon,
        quality = quality,
        text = self._str
      })
      self.uiItem:SetBgImage(true)
      self._affinityGo:SetActive(false)
    end
  end)
end

function UIConsumaItem:GetBtn()
  return self.uiItem:GetBtn()
end

function UIConsumaItem:ClickItemForGuide()
  self:showTipBtnOnClick(self:GetBtn())
end
