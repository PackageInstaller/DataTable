_class("UIHomePhotoInfoItem", UICustomWidget)
UIHomePhotoInfoItem = UIHomePhotoInfoItem

function UIHomePhotoInfoItem:OnShow(uiParams)
  self._itemModule = GameGlobal.GetModule(ItemModule)
  self._lock = self:GetGameObject("lock")
  self._select = self:GetGameObject("select")
  self._go = self:GetGameObject()
  self._new = self:GetGameObject("new")
  self._uiitem = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self._itemPool = self._uiitem:SpawnObject("UIItemHomeland")
  self._anim = self:GetUIComponent("Animation", "UIHomePhotoInfoItem")
  self:AttachEvent(GameEventType.OnUIHomePhotoItemClick, self.OnUIHomePhotoItemClick)
end

function UIHomePhotoInfoItem:OnUIHomePhotoItemClick(idx)
  self._select:SetActive(idx == self._idx)
end

function UIHomePhotoInfoItem:Active(active)
  self._go:SetActive(active)
end

function UIHomePhotoInfoItem:SetData(idx, item, cb, number2color, anim)
  self._idx = idx
  self._cb = cb
  self._item = item
  local count = self._item.count
  self._lock:SetActive(count <= 0)
  if self._item then
    local rolaAsset = RoleAsset:New()
    rolaAsset.assetid = self._item.showID
    rolaAsset.count = ""
    self._itemPool:Flush(rolaAsset, function()
      self:btnOnClick()
    end, true)
  end
  self:Red()
  if anim then
    self._anim:Play()
  end
end

function UIHomePhotoInfoItem:Red()
  local item_data
  local items = self._itemModule:GetItemByTempId(self._item.countID)
  if items and table.count(items) > 0 then
    for key, value in pairs(items) do
      item_data = value
      break
    end
  end
  if item_data then
    self._redState = item_data:IsNew()
    self._pstid = item_data:GetID()
  else
    self._pstid = nil
    self._redState = false
  end
  self._new:SetActive(self._redState)
end

function UIHomePhotoInfoItem:btnOnClick(go)
  if self._cb then
    self._cb(self._idx)
  end
  if self._redState then
    self:StartTask(function(TT)
      if self._item and self._pstid then
        self._itemModule:SetItemUnnew(TT, self._pstid)
      end
    end)
    self._redState = false
    self._new:SetActive(self._redState)
  end
end
