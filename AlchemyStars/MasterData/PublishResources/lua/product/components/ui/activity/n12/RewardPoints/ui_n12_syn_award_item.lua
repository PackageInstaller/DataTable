_class("UIN12SynAwardItem", UICustomWidget)
UIN12SynAwardItem = UIN12SynAwardItem

function UIN12SynAwardItem:OnShow(uiParams)
  self:InitWidget()
end

function UIN12SynAwardItem:InitWidget()
  self._lock1 = self:GetGameObject("_lock1")
  self._lock2 = self:GetGameObject("_lock2")
end

function UIN12SynAwardItem:_SetShow()
  local reward = self:GetUIComponent("UISelectObjectPath", "_item")
  self._reward = reward:SpawnObject("UIItem")
  self._reward:SetForm(UIItemForm.Base, UIItemScale.Level3)
  self._reward:ShowNodes(UIItemNode.Activity, false)
  local cfg_item = Cfg.cfg_item[self._rewardDate[1]]
  if cfg_item == nil then
    return
  end
  self._cg = cfg_item.Icon
  self._colorEnum = cfg_item.Color
  local icon = self._cg
  local quality = self._colorEnum
  local text1 = self._rewardDate[2]
  self._reward:SetData({
    icon = icon,
    quality = quality,
    text1 = text1,
    itemId = self._rewardDate[1]
  })
  self._reward:SetClickCallBack(function(go)
    local tr = go.transform
    local pos = tr.position
    self._callback(self._rewardDate[1], pos)
  end)
end

function UIN12SynAwardItem:_SetState(isshow)
  self._lock1:SetActive(isshow)
  self._lock2:SetActive(isshow)
end

function UIN12SynAwardItem:SetData(reward, state, callback)
  self._rewardDate = reward
  self._callback = callback
  self:_SetShow()
  self:_SetState(state)
end
