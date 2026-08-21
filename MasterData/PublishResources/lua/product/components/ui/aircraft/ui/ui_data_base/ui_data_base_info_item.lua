_class("UIDataBaseInfoItem", UICustomWidget)
UIDataBaseInfoItem = UIDataBaseInfoItem

function UIDataBaseInfoItem:OnShow(uiParams)
  self:GetComponents()
  self:AttachEvent(GameEventType.OnDataBaseInfoUnLock, self._RefreshInfo)
  self:AttachEvent(GameEventType.OnDataBaseInfoItemClick, self._OnDataBaseInfoItemClick)
end

function UIDataBaseInfoItem:GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._red = self:GetGameObject("red")
  self._bg = self:GetUIComponent("Image", "bg")
  self._select = self:GetUIComponent("CanvasGroup", "select")
end

function UIDataBaseInfoItem:SetData(idx, info, sp1, sp2, callback)
  self._idx = idx
  self._sp1 = sp1
  self._sp2 = sp2
  self._info = info
  self._callback = callback
  self:OnValue()
end

function UIDataBaseInfoItem:_OnDataBaseInfoItemClick(idx, anim)
  local alpha
  if idx == self._idx then
    alpha = 1
  else
    alpha = 0
  end
  local time
  if anim then
    time = 0.2
  else
    time = 0
  end
  self._select:DOFade(alpha, time)
end

function UIDataBaseInfoItem:_RefreshInfo()
  self:Red()
  self:Lock()
end

function UIDataBaseInfoItem:OnValue()
  self:Lock()
  self:Red()
  self:Name()
end

function UIDataBaseInfoItem:Lock()
  local lock = self._info:GetLock()
  local sp
  if not lock then
    sp = self._sp1
  else
    sp = self._sp2
  end
  self._bg.sprite = sp
end

function UIDataBaseInfoItem:Red()
  local red = self._info:GetRed()
  self._red:SetActive(red)
end

function UIDataBaseInfoItem:Name()
  self._name:SetText("0" .. self._idx)
end

function UIDataBaseInfoItem:bgOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end
