_class("UIN13BuildRewardItem", UICustomWidget)
UIN13BuildRewardItem = UIN13BuildRewardItem

function UIN13BuildRewardItem:_SetRawImage(widgetName, url)
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(url)
end

function UIN13BuildRewardItem:_SetText(widgetName, txt)
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(txt)
end

function UIN13BuildRewardItem:_GetItemCfg(itemId)
  self._cfg_item = Cfg.cfg_item[itemId]
  if self._cfg_item == nil then
    Log.fatal("UIN13BuildRewardItem:_GetIconUrl() cfg_item is nil ! id --> ", itemId)
    return
  end
  return self._cfg_item
end

function UIN13BuildRewardItem:_GetComponents()
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._iconObj = self:GetGameObject("icon")
  self._countBgObj = self:GetGameObject("count")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
  self._bgGroup = UIWidgetHelper.GetObjGroupByWidgetName(self, {
    {"bg1"},
    {"bg2"},
    {"bg3"},
    {"bg4"},
    {"bg5"},
    {"bg6"}
  })
end

function UIN13BuildRewardItem:OnShow(uiParams)
end

function UIN13BuildRewardItem:OnHide()
  self._tipsCallback = nil
end

function UIN13BuildRewardItem:SetData(index, roleAsset, tipsCallback, gray)
  self:_GetComponents()
  self._index = index
  self._roleAsset = roleAsset
  self._tipsCallback = tipsCallback
  self._gray = gray
  local count = self._roleAsset.count
  local itemId = self._roleAsset.assetid
  self:_SetIcon(itemId)
  self:_SetCount("", count, true)
end

function UIN13BuildRewardItem:iconOnClick(go)
  if self._tipsCallback then
    self._tipsCallback(self._roleAsset.assetid, go.transform.position)
  end
end

function UIN13BuildRewardItem:_SetIcon(itemId)
  local cfg = self:_GetItemCfg(itemId)
  local url = cfg.Icon
  local color = cfg.Color
  if not string.isnullorempty(url) then
    self:_ShowIcon(true, itemId)
    self:_SetRawImage("icon", url)
    UIWidgetHelper.SetObjGroupShow(self._bgGroup, color)
  else
    self:_ShowIcon(false)
  end
end

function UIN13BuildRewardItem:_ShowIcon(show, itemId)
  self._iconObj:SetActive(show)
  self:_SetIconOffset(itemId)
end

function UIN13BuildRewardItem:_SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(0, 0)
  else
    self._iconRect.anchoredPosition = Vector2(0, 5)
  end
end

function UIN13BuildRewardItem:_IsPet(id)
  local cfg = Cfg.cfg_pet({ID = id})
  return cfg and true or false
end

function UIN13BuildRewardItem:_SetCount(prefix, text, showZeroFlag)
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
    self:_ShowCountGroup(show)
  else
    self:_ShowCountGroup(false)
  end
end

function UIN13BuildRewardItem:_ShowCountGroup(show)
  self._countBgObj:SetActive(show)
end
