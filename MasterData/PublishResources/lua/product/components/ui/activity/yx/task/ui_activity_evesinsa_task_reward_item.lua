_class("UIActivityEveSinsaTaskRewardItem", UICustomWidget)
UIActivityEveSinsaTaskRewardItem = UIActivityEveSinsaTaskRewardItem

function UIActivityEveSinsaTaskRewardItem:_GetComponents()
  self._iconImg = self:GetUIComponent("RawImageLoader", "_icon")
  self._iconRect = self:GetUIComponent("RectTransform", "_icon")
  self._iconObj = self:GetGameObject("_icon")
  self._numTex = self:GetUIComponent("UILocalizationText", "_numTex")
  self._numTexObj = self:GetGameObject("_numTex")
  self._numTexBgObj = self:GetGameObject("_numTexBg")
end

function UIActivityEveSinsaTaskRewardItem:OnShow(uiParams)
end

function UIActivityEveSinsaTaskRewardItem:SetData(index, cfg, callback)
  self:_GetComponents()
  self._index = index
  self._cfg = cfg
  self._callback = callback
  local cfg_item = Cfg.cfg_item[self._cfg.assetid]
  if cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._cfg.assetid)
    return
  end
  self._cg = cfg_item.Icon
  self._colorEnum = cfg_item.Color
  self:_OnValue()
end

function UIActivityEveSinsaTaskRewardItem:OnHide()
  self._cg = nil
  self._index = nil
  self._callback = nil
end

function UIActivityEveSinsaTaskRewardItem:_OnValue()
  local icon = self._cg
  local num = self._cfg.count
  local itemId = self._cfg.assetid
  self:SetIcon(icon, itemId)
  self:SetNumText(num, true)
end

function UIActivityEveSinsaTaskRewardItem:iconOnClick(go)
  if self._callback then
    self._callback(self._cfg.assetid, go.transform.position)
  end
end

function UIActivityEveSinsaTaskRewardItem:SetIcon(name, itemId)
  if not string.isnullorempty(name) then
    self:ShowIcon(true, itemId)
    self._iconImg:LoadImage(name)
  else
    self:ShowIcon(false)
  end
end

function UIActivityEveSinsaTaskRewardItem:ShowIcon(show, itemId)
  self._iconObj:SetActive(show)
  self:SetIconOffset(itemId)
end

function UIActivityEveSinsaTaskRewardItem:SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(0, 0)
  else
    self._iconRect.anchoredPosition = Vector2(0, 5)
  end
end

function UIActivityEveSinsaTaskRewardItem:_IsPet(id)
  local cfg = Cfg.cfg_pet({ID = id})
  return cfg and true or false
end

function UIActivityEveSinsaTaskRewardItem:SetNumText(text, showNumber)
  if text ~= nil then
    local show = false
    if type(text) == "number" then
      local num = text
      show = 0 < num or showNumber
      self._numTex:SetText(HelperProxy:GetInstance():FormatItemCount(num))
    elseif type(text) == "string" then
      show = not string.isnullorempty(text)
      self._numTex:SetText(text)
    end
    self:ShowNumText(show)
  else
    self:ShowNumText(false)
  end
end

function UIActivityEveSinsaTaskRewardItem:ShowNumText(show)
  self._numTexObj:SetActive(show)
  self._numTexBgObj:SetActive(show)
end
