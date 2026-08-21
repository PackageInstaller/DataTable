_class("UIHauteSelectInfo", UICustomWidget)
UIHauteSelectInfo = UIHauteSelectInfo

function UIHauteSelectInfo:OnShow()
  self._lockName = "OpenSelectInfoLock"
  self._pos = self:GetGameObject("pos")
  local passEvent = self._pos:GetComponent("PassEventComponent")
  passEvent:SetClickCallback(function()
    self:CloseOnClick()
  end)
  self._selectInfo = self:GetUIComponent("RectTransform", "select_info")
  self:GetOffset()
  self._canvasGroup = self:GetUIComponent("CanvasGroup", "select_info")
  self._selectInfo.anchoredPosition = Vector2(10000, 0)
  self._pos:SetActive(false)
  self._common = self:GetGameObject("common")
  self._common:SetActive(false)
  self._itemInfoName = self:GetUIComponent("UILocalizationText", "txt_item_name")
  self._itemInfoDesc = self:GetUIComponent("UILocalizationText", "txt_item_simple_desc")
  self._itemInfoCount = self:GetUIComponent("UILocalizationText", "txt_item_own_count")
  self._enter = false
  self._exit = false
  self._isDispose = false
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self.uiItem = sop:SpawnObject("UIHauteItem")
  self._showGo = self._common
  self._showName = self._itemInfoName
  self._showCount = self._itemInfoCount
  self._showItem = self.uiItem
  self._showDes = self._itemInfoDesc
  self._showGo:SetActive(true)
end

function UIHauteSelectInfo:SetCustomPos(pos)
  self._pos:SetActive(true)
  self._selectInfo.localScale = Vector3(1, 1, 1)
  self._selectInfo.position = pos
  local index = 0
  if 0 < self._selectInfo.anchoredPosition.x then
    if 0 < self._selectInfo.anchoredPosition.y then
      index = 1
    else
      index = 4
    end
  elseif 0 < self._selectInfo.anchoredPosition.y then
    index = 2
  else
    index = 3
  end
  self._selectInfo.anchoredPosition = Vector2(self._selectInfo.anchoredPosition.x + self._showAnchorPositions[index].x, self._selectInfo.anchoredPosition.y + self._showAnchorPositions[index].y)
end

function UIHauteSelectInfo:GetOffset()
  self._offsetX = self._selectInfo.rect.width * 0.5
  self._offsetY = self._selectInfo.rect.height * 0.5
  self._showAnchorPositions = {}
  self._showAnchorPositions[1] = Vector2(-50 - self._offsetX, -50 - self._offsetY)
  self._showAnchorPositions[2] = Vector2(50 + self._offsetX, -50 - self._offsetY)
  self._showAnchorPositions[3] = Vector2(50 + self._offsetX, 50 + self._offsetY)
  self._showAnchorPositions[4] = Vector2(-50 - self._offsetX, 50 + self._offsetY)
end

function UIHauteSelectInfo:SetData(item_id, pos, des)
  if not self._canvasGroup then
    return
  end
  if self._isDispose then
    return
  end
  local itemConfig = Cfg.cfg_item[item_id]
  if not itemConfig then
    return
  end
  local itemModule = GameGlobal.GetModule(ItemModule)
  if not itemModule then
    return
  end
  self._pos:SetActive(true)
  self._showName:SetText(StringTable.Get(itemConfig.Name))
  local roleModule = GameGlobal.GetModule(RoleModule)
  local c = roleModule:GetAssetCount(item_id)
  self._showCount:SetText(StringTable.Get("str_item_public_owned") .. self:_FormatItemCount(c))
  if des then
    self._showDes:SetText(des)
  else
    self._showDes:SetText(StringTable.Get(itemConfig.Intro))
  end
  local icon = itemConfig.Icon
  local quality = itemConfig.Color
  local itemId = itemConfig.ID
  if self._isHomelandItem then
    local item = self._showItem
    item:Flush(NewRoleAsset(itemId, ""), nil, true)
  else
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = itemId
    roleAsset.count = itemModule:GetItemCount(itemId)
    self._showItem:Flush(roleAsset, nil, false)
  end
  self._selectInfo.localScale = Vector3(1, 1, 1)
  self._canvasGroup.alpha = 0
  self._selectInfo.position = pos
  local index = 0
  if 0 < self._selectInfo.anchoredPosition.x then
    if 0 < self._selectInfo.anchoredPosition.y then
      index = 1
    else
      index = 4
    end
  elseif 0 < self._selectInfo.anchoredPosition.y then
    index = 2
  else
    index = 3
  end
  self._selectInfo.anchoredPosition = Vector2(self._selectInfo.anchoredPosition.x + self._showAnchorPositions[index].x, self._selectInfo.anchoredPosition.y + self._showAnchorPositions[index].y)
  self:Lock(self._lockName)
  GameGlobal.TaskManager():StartTask(self.PlayAnimation, self)
end

function UIHauteSelectInfo:PlayAnimation(TT)
  if not self._canvasGroup then
    return
  end
  if self._isDispose then
    return
  end
  self._enter = true
  local a = 0
  while a < 1 do
    a = a + 0.1
    if 1 < a then
      a = 1
    end
    if not self._canvasGroup then
      return
    end
    if self._isDispose then
      return
    end
    self._canvasGroup.alpha = a
    YIELD(TT)
  end
  YIELD(TT)
  self._enter = false
  self:UnLock(self._lockName)
end

function UIHauteSelectInfo:CloseOnClick()
  self._pos:SetActive(false)
end

function UIHauteSelectInfo:OnHide()
  self._isDispose = true
end

function UIHauteSelectInfo:OncloseOnClick(TT)
  if not self._canvasGroup then
    return
  end
  if self._enter == true then
    return
  end
  if self._exit == true then
    return
  end
  self._exit = true
  local a = 1
  if self._tweenerClose then
    self._tweenerClose:Kill()
  end
  self._tweenerClose = self._selectInfo:DOScale(Vector3(3, 3, 3), 0.3)
  self._tweenerClose:OnComplete(function()
    if not self._canvasGroup then
      return
    end
    if self._isDispose then
      return
    end
    a = 0
    self._canvasGroup.alpha = 0
    self._selectInfo.anchoredPosition = Vector2(10000, 0)
    self._selectInfo.localScale = Vector3(1, 1, 1)
    self._pos:SetActive(false)
    if self._exit == true then
      self._exit = false
    end
    return
  end)
  while 0 < a do
    if self._isDispose then
      return
    end
    a = a - 0.05
    if a < 0 then
      a = 0
    end
    if not self._canvasGroup then
      return
    end
    self._canvasGroup.alpha = a
    YIELD(TT)
  end
  if self._isDispose then
    return
  end
  YIELD(TT)
  self._exit = false
end

function UIHauteSelectInfo:_FormatItemCount(itemCount)
  return HelperProxy:GetInstance():FormatItemCount(itemCount)
end

function UIHauteSelectInfo:Bg1OnClick(go)
end

function UIHauteSelectInfo:Bg2OnClick(go)
end
