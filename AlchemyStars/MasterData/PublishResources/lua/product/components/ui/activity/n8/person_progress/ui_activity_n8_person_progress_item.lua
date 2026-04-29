_class("UIActivityN8PersonProgressItem", UICustomWidget)
UIActivityN8PersonProgressItem = UIActivityN8PersonProgressItem

function UIActivityN8PersonProgressItem:_GetComponents()
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._iconObj = self:GetGameObject("icon")
  self._countBgObj = self:GetGameObject("countBg")
  self._countBg_grayObj = self:GetGameObject("countBg_gray")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
  self._countTextObj = self:GetGameObject("countText")
end

function UIActivityN8PersonProgressItem:OnShow(uiParams)
end

function UIActivityN8PersonProgressItem:OnHide()
  self._tipsCallback = nil
end

function UIActivityN8PersonProgressItem:SetData(index, roleAsset, tipsCallback, gray)
  self:_GetComponents()
  self._index = index
  self._roleAsset = roleAsset
  self._tipsCallback = tipsCallback
  self._gray = gray
  self._cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if self._cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._roleAsset.assetid)
    return
  end
  local icon = self._cfg_item.Icon
  local count = self._roleAsset.count
  local itemId = self._roleAsset.assetid
  self:SetIcon(icon, itemId)
  self:SetIconGrey(icon, "icon", gray)
  self:SetCount("", count, true)
end

function UIActivityN8PersonProgressItem:iconOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end

function UIActivityN8PersonProgressItem:SetIcon(name, itemId)
  if not string.isnullorempty(name) then
    self:ShowIcon(true, itemId)
    self._iconImg:LoadImage(name)
  else
    self:ShowIcon(false)
  end
end

function UIActivityN8PersonProgressItem:ShowIcon(show, itemId)
  self._iconObj:SetActive(show)
  self:SetIconOffset(itemId)
end

function UIActivityN8PersonProgressItem:SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(0, 0)
  else
    self._iconRect.anchoredPosition = Vector2(0, 5)
  end
end

function UIActivityN8PersonProgressItem:_IsPet(id)
  local cfg = Cfg.cfg_pet({ID = id})
  return cfg and true or false
end

function UIActivityN8PersonProgressItem:SetIconGrey(name, widgetName, gray)
  if string.isnullorempty(name) then
    return
  end
  local obj = self:GetUIComponent("RawImage", widgetName)
  if not self._EMIMat then
    self._EMIMat = UnityEngine.Material:New(obj.material)
  end
  local texture = obj.material.mainTexture
  obj.material = self._EMIMat
  obj.material.mainTexture = texture
  if gray == 1 then
    obj.material:SetFloat("_LuminosityAmount", 1)
  else
    obj.material:SetFloat("_LuminosityAmount", 0)
  end
  obj.gameObject:SetActive(false)
  obj.gameObject:SetActive(true)
end

function UIActivityN8PersonProgressItem:SetCount(prefix, text, showZeroFlag)
  if text ~= nil then
    local show = false
    if type(text) == "number" then
      local num = text
      show = 0 < num or showZeroFlag
      local str = prefix .. HelperProxy:GetInstance():FormatItemCount(num)
      self._countText:SetText(str)
    elseif type(text) == "string" then
      show = not string.isnullorempty(text)
      self._countText:SetText(text)
    end
    self:ShowCountGroup(show)
  else
    self:ShowCountGroup(false)
  end
end

function UIActivityN8PersonProgressItem:ShowCountGroup(show)
  self._countTextObj:SetActive(show)
  self._countBgObj:SetActive(show and self._gray ~= 1)
  self._countBg_grayObj:SetActive(show and self._gray == 1)
end
