_class("UIChooseMainBgItem", UICustomWidget)
UIChooseMainBgItem = UIChooseMainBgItem

function UIChooseMainBgItem:OnShow()
  self:AttachEvent(GameEventType.ChangeMainBg, self.Select)
  self:_GetComponents()
end

function UIChooseMainBgItem:SetData(id, itemid, type, using, select, bgName, name, callback)
  self._id = id
  self._itemid = itemid
  self._type = type
  self._using = using
  self._select = select
  self._name = name
  self._bgName = bgName
  self._callback = callback
  self:_OnValue()
end

function UIChooseMainBgItem:_GetComponents()
  self._nameTex = self:GetUIComponent("UILocalizationText", "name")
  self._bg = self:GetUIComponent("RawImageLoader", "bg")
  self._selectObj = self:GetGameObject("select")
  self._usingGo = self:GetGameObject("using")
  self._red = self:GetGameObject("red")
  self._empty = self:GetGameObject("empty")
  self._rect = self:GetGameObject("rect")
end

function UIChooseMainBgItem:_OnValue()
  self._empty:SetActive(self._id == 99999)
  self._rect:SetActive(self._id ~= 99999)
  if self._id == 99999 then
  else
    if self._bgName then
      self._bg:LoadImage(self._bgName)
    end
    if self._name then
      self._nameTex:SetText(StringTable.Get(self._name))
    end
    self._usingGo:SetActive(self._using)
    self._selectObj:SetActive(self._select)
    self:SetRed()
  end
end

function UIChooseMainBgItem:SetRed()
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
    self._redState = item_data:IsNewOverlay()
    self._pstid = item_data:GetID()
  end
  self._red:SetActive(self._redState)
end

function UIChooseMainBgItem:bgOnClick(go)
  if self._callback then
    self._callback(self._id, self._type)
  end
  if self._redState then
    self:StartTask(function(TT)
      if self._itemid and self._pstid then
        local itemModule = GameGlobal.GetModule(ItemModule)
        itemModule:SetItemUnnewOverlay(TT, self._pstid)
      end
    end)
    self._redState = false
    self._red:SetActive(self._redState)
  end
end

function UIChooseMainBgItem:GetID()
  return self._id
end

function UIChooseMainBgItem:GetUsing()
  return self._using
end

function UIChooseMainBgItem:Select(type, id)
  local select = self._id == id
  self._selectObj:SetActive(select)
end
