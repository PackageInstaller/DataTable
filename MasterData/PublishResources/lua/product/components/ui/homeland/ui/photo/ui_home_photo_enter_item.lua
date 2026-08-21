_class("UIHomePhotoEnterItem", UICustomWidget)
UIHomePhotoEnterItem = UIHomePhotoEnterItem

function UIHomePhotoEnterItem:OnShow(uiParams)
  self._title = self:GetUIComponent("UILocalizationText", "title")
  self._count = self:GetUIComponent("UILocalizationText", "count")
  self._rateTex = self:GetUIComponent("UILocalizationText", "rateTex")
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._rate = self:GetUIComponent("Image", "rate")
  self._go = self:GetGameObject("rect")
  self._tr = self._go.transform
  self._selectGo = self:GetGameObject("select")
end

function UIHomePhotoEnterItem:Active(active)
  self._go:SetActive(active)
end

function UIHomePhotoEnterItem:SetData(data)
  self._data = data
  local title = self._data.title
  self._title:SetText(StringTable.Get(title))
  local icon = self._data.icon
  self._icon:LoadImage(icon)
  local count, max = self:GetCount()
  self._count:SetText(count .. "/" .. max)
  local rate
  if max <= 0 then
    Log.error("###[UIHomePhotoEnterItem] max == 0 ! title --> ", title)
    rate = 0
  else
    rate = count / max
  end
  local rateTex = math.floor(rate * 100 + 0.5)
  self._rate.fillAmount = rate
  self._rateTex:SetText(rateTex .. "%")
  self._tr.localScale = Vector3(0.9, 0.9, 0.9)
end

function UIHomePhotoEnterItem:GetCount()
  local itemModule = self:GetModule(ItemModule)
  local group = self._data.group
  local cfg = Cfg.cfg_item_photo({Group = group})
  if cfg and next(cfg) then
    local unlockCount = 0
    for i = 1, #cfg do
      local _cfg = cfg[i]
      local itemid = _cfg.ID
      local count = itemModule:GetItemCount(itemid)
      if 0 < count then
        unlockCount = unlockCount + 1
      end
    end
    local maxCount = #cfg
    return unlockCount, maxCount
  else
    return 0, 0
  end
end

function UIHomePhotoEnterItem:btnOnClick(go)
  local group = self._data.group
  self:Lock("UIHomePhotoEnterItem:btnOnClick")
  if self._tweener then
    self._tweener:Kill(true)
  end
  self._selectGo:SetActive(true)
  self._tweener = self._tr:DOScale(1, 0.1):OnComplete(function()
    self:UnLock("UIHomePhotoEnterItem:btnOnClick")
    self:ShowDialog("UIHomePhotoInfoController", group, function()
      self:OnDialogClose()
    end)
    self._tr.localScale = Vector3(1, 1, 1)
    self._selectGo:SetActive(false)
  end)
end

function UIHomePhotoEnterItem:OnDialogClose()
  self:Lock("UIHomePhotoEnterItem:_OnDialogClose")
  if self._tweener then
    self._tweener:Kill(true)
  end
  self._tr:DOScale(0.9, 0.1):OnComplete(function()
    self:UnLock("UIHomePhotoEnterItem:_OnDialogClose")
    self._tr.localScale = Vector3(0.9, 0.9, 0.9)
  end)
end

function UIHomePhotoEnterItem:OnHide()
  if self._tweener then
    self._tweener:Kill(true)
    self._tweener = nil
  end
end
