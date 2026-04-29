_class("UIActivityGraveRobberItemIcon", UICustomWidget)
UIActivityGraveRobberItemIcon = UIActivityGraveRobberItemIcon

function UIActivityGraveRobberItemIcon:_GetComponents()
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._iconObj = self:GetGameObject("icon")
  self._countBgObj = self:GetGameObject("countBg")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
  self._countTextObj = self:GetGameObject("countText")
end

function UIActivityGraveRobberItemIcon:SetData(index, roleAsset, callback)
  self:_GetComponents()
  self._index = index
  self._roleAsset = roleAsset
  self._callback = callback
  self._cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if self._cfg_item == nil then
    self:GetGameObject():SetActive(false)
    return
  end
  self:_OnValue()
end

function UIActivityGraveRobberItemIcon:OnShow(uiParams)
end

function UIActivityGraveRobberItemIcon:OnHide()
  self._callback = nil
end

function UIActivityGraveRobberItemIcon:_OnValue()
  local icon = self._cfg_item.Icon
  local count = self._roleAsset.count
  local itemId = self._roleAsset.assetid
  self:SetIcon(icon, itemId)
end

function UIActivityGraveRobberItemIcon:iconOnClick(go)
  if self._callback then
    self._callback(self._roleAsset.assetid, go.transform.position)
  end
end

function UIActivityGraveRobberItemIcon:SetIcon(name, itemId)
  if not string.isnullorempty(name) then
    self:ShowIcon(true, itemId)
    self._iconImg:LoadImage(name)
  else
    self:ShowIcon(false)
  end
end

function UIActivityGraveRobberItemIcon:ShowIcon(show, itemId)
  self._iconObj:SetActive(show)
  self:SetIconOffset(itemId)
end

function UIActivityGraveRobberItemIcon:SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(0, 0)
  else
    self._iconRect.anchoredPosition = Vector2(0, 5)
  end
end

function UIActivityGraveRobberItemIcon:_IsPet(id)
  local cfg = Cfg.cfg_pet({ID = id})
  return cfg and true or false
end

function UIActivityGraveRobberItemIcon:SetCount(text, showZeroFlag)
  if text ~= nil then
    local show = false
    if type(text) == "number" then
      local num = text
      show = 0 < num or showZeroFlag
      self._countText:SetText(HelperProxy:GetInstance():FormatItemCount(num))
    elseif type(text) == "string" then
      show = not string.isnullorempty(text)
      self._countText:SetText(text)
    end
    self:ShowCountGroup(show)
  else
    self:ShowCountGroup(false)
  end
end

function UIActivityGraveRobberItemIcon:ShowCountGroup(show)
  self._countTextObj:SetActive(show)
  self._countBgObj:SetActive(show)
end
