_class("UIMiniGameRewardItem", UICustomWidget)
UIMiniGameRewardItem = UIMiniGameRewardItem

function UIMiniGameRewardItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIMiniGameRewardItem:_GetComponents()
  self._uiItem = self:GetUIComponent("UISelectObjectPath", "uiitem")
  self._lock = self:GetGameObject("Lock")
end

function UIMiniGameRewardItem:SetData(data, scoretype, missioninfo, callback)
  self._item = self._uiItem:SpawnObject("UIItem")
  self._item:SetForm(UIItemForm.Base, UIItemScale.Level1)
  self._item:SetClickCallBack(function(go)
    self:ShowTips(go)
  end)
  self._itemid = data[1]
  self._itemCount = data[2]
  self._missionInfo = missioninfo
  self._scoreType = scoretype
  self._callback = callback
  self:_OnValue()
end

function UIMiniGameRewardItem:_OnValue()
  local cfg = Cfg.cfg_item[self._itemid]
  if cfg == nil then
    Log.fatal("cfg_item is nil." .. self._itemid)
  end
  local icon = cfg.Icon
  local quality = cfg.Color
  local text1 = self._itemCount
  self._item:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = self._itemid
  })
  self:RefreshUIInfo(self._missionInfo)
end

function UIMiniGameRewardItem:RefreshUIInfo(missioninfo)
  self._missionInfo = missioninfo
  local state = self._missionInfo.reward_mask & self._scoreType ~= 0 and self._missionInfo.mission_grade >= self._scoreType
  self._lock:SetActive(state)
end

function UIMiniGameRewardItem:ShowTips(go)
  if self._callback then
    self._callback(self._itemid, go.transform.position)
  end
end
