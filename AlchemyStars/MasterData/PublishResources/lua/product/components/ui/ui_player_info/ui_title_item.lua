_class("UITitleItem", UICustomWidget)
UITitleItem = UITitleItem

function UITitleItem:OnShow(uiParams)
  self:AttachEvent(GameEventType.OnTitleItemSelect, self.Select)
  self:AttachEvent(GameEventType.OnPlayerTitleInfoChanged, self.TitleChange)
  self:_GetComponents()
end

function UITitleItem:SetData(data)
  self._itemid = data.itemid
  self._icon = data.icon
  self._lock = data.lock
  self._using = data.using
  self._callback = data.callback
  self:RevertState()
  self:_OnValue()
end

function UITitleItem:_GetComponents()
  self._iconImage = self:GetUIComponent("RawImageLoader", "iconImage")
  self._emptyObj = self:GetGameObject("emptyObj")
  self._iconObj = self:GetGameObject("iconImage")
  self._usingObj = self:GetGameObject("usingObj")
  self._lockObj = self:GetGameObject("lockObj")
  self._selectObj = self:GetGameObject("selectObj")
  self._newObj = self:GetGameObject("newObj")
  self._noTitleIconObj = self:GetGameObject("noTitleIconObj")
end

function UITitleItem:RevertState()
  self._noTitleIconObj:SetActive(false)
  self._emptyObj:SetActive(false)
  self._iconObj:SetActive(false)
  self._usingObj:SetActive(false)
  self._selectObj:SetActive(false)
  self._lockObj:SetActive(false)
end

function UITitleItem:_OnValue()
  if self._itemid < 0 then
    self._emptyObj:SetActive(true)
  else
    if self._itemid == 0 then
      self._noTitleIconObj:SetActive(true)
    else
      self._iconObj:SetActive(true)
      self._iconImage:LoadImage(self._icon)
    end
    self._usingObj:SetActive(self._using)
    self._selectObj:SetActive(self._using)
    self._lockObj:SetActive(self._lock)
    self:_SetRed()
  end
end

function UITitleItem:OnHide()
end

function UITitleItem:_SetRed()
  self._redState = false
  if self._itemid then
    local itemModule = GameGlobal.GetModule(ItemModule)
    local item_data
    local items = itemModule:GetItemByTempId(self._itemid)
    if items and table.count(items) > 0 then
      for key, value in pairs(items) do
        item_data = value
        break
      end
    end
    if item_data then
      self._redState = item_data:IsNewOverlay()
      self._pstid = item_data:GetID()
    end
  end
  self._newObj:SetActive(self._redState)
end

function UITitleItem:iconOnClick()
  if self._callback then
    self._callback(self._itemid)
  end
  if self._redState then
    self:StartTask(function(TT)
      if self._itemid and self._pstid then
        local itemModule = GameGlobal.GetModule(ItemModule)
        itemModule:SetItemUnnewOverlay(TT, self._pstid)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshPlayerInfoRedPoint)
      end
    end)
    self._redState = false
    self._newObj:SetActive(self._redState)
  end
end

function UITitleItem:noTitleIconOnClick()
  if self._callback then
    self._callback(self._itemid)
  end
end

function UITitleItem:Select(itemid)
  local select = self._itemid == itemid
  self._selectObj:SetActive(select)
end

function UITitleItem:TitleChange(itemid)
  local using = self._itemid == itemid
  self._usingObj:SetActive(using)
end
