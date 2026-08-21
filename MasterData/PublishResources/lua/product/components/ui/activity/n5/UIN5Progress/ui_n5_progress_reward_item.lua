_class("UIN5ProgressRewardItem", UICustomWidget)
UIN5ProgressRewardItem = UIN5ProgressRewardItem

function UIN5ProgressRewardItem:OnShow(uiParams)
end

function UIN5ProgressRewardItem:InitWidget()
  self._iconImg = self:GetUIComponent("RawImageLoader", "_icon")
  self._iconRawImg = self:GetUIComponent("RawImage", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "_icon")
  self._iconObj = self:GetGameObject("_icon")
  self._numTex = self:GetUIComponent("UILocalizationText", "_numTex")
  self._numTexBg = self:GetUIComponent("Image", "_numTexBg")
  self._numTexObj = self:GetGameObject("_numTex")
  self._numTexBgObj = self:GetGameObject("_numTexBg")
  self._redPointArea = self:GetGameObject("_redPointArea")
  self._bigAwardArea = self:GetGameObject("_bigAwardArea")
  if self._iconObj then
    self:AddUICustomEventListener(UICustomUIEventListener.Get(self._iconObj), UIEvent.BeginDrag, function(pointData)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.N5ProgressScrollDragBegin)
    end)
  end
end

function UIN5ProgressRewardItem:SetData(index, state, bSpecial, cfg, callback)
  self:InitWidget()
  self._index = index
  self._state = state
  self._isSpecialAward = bSpecial
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

function UIN5ProgressRewardItem:OnHide()
  self._cg = nil
  self._index = nil
  self._callback = nil
end

function UIN5ProgressRewardItem:_OnValue()
  local icon = self._cg
  local num = self._cfg.count
  local itemId = self._cfg.assetid
  self:SetIcon(icon, itemId)
  self:SetNumText(num, true)
  self._redPointArea:SetActive(self._state == UIActivityProgressRewardState.STATE_UNLOCK)
  self._bigAwardArea:SetActive(self._isSpecialAward)
  self:_SetGray(self._state == UIActivityProgressRewardState.STATE_RECEIVED)
end

function UIN5ProgressRewardItem:iconOnClick(go)
  if self._callback then
    self._callback(self._cfg.assetid, go.transform.position)
  end
end

function UIN5ProgressRewardItem:SetIcon(name, itemId)
  if not string.isnullorempty(name) then
    self:ShowIcon(true, itemId)
    self._iconImg:LoadImage(name)
  else
    self:ShowIcon(false)
  end
end

function UIN5ProgressRewardItem:ShowIcon(show, itemId)
  self._iconObj:SetActive(show)
  self:SetIconOffset(itemId)
end

function UIN5ProgressRewardItem:SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(0, 0)
  else
    self._iconRect.anchoredPosition = Vector2(0, 5)
  end
end

function UIN5ProgressRewardItem:_SetGray(bGray)
  local tarColor = Color.white
  if bGray then
    tarColor = Color(1, 1, 1, 0.4)
  end
  self._iconImg:SetColor(tarColor)
  self._numTexBg.color = tarColor
end

function UIN5ProgressRewardItem:_IsPet(id)
  local cfg = Cfg.cfg_pet({ID = id})
  return cfg and true or false
end

function UIN5ProgressRewardItem:SetNumText(text, showNumber)
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

function UIN5ProgressRewardItem:ShowNumText(show)
  self._numTexObj:SetActive(show)
  self._numTexBgObj:SetActive(show)
end
