_class("UIActivityBattlePassN5ItemIconReward", UICustomWidget)
UIActivityBattlePassN5ItemIconReward = UIActivityBattlePassN5ItemIconReward

function UIActivityBattlePassN5ItemIconReward:_GetComponents()
  self._iconObj = self:GetGameObject("icon")
  self._fixedStandardObj = self:GetGameObject("fixedStandard")
  self._fixedEliteObj = self:GetGameObject("fixedElite")
  self._fixedEliteLockObj = self:GetGameObject("state_Lock")
  self._state_NotStart = self:GetGameObject("state_NotStart")
  self._state_Completed = self:GetGameObject("state_Completed")
  self._state_Taken = self:GetGameObject("state_Taken")
end

function UIActivityBattlePassN5ItemIconReward:OnShow(uiParams)
end

function UIActivityBattlePassN5ItemIconReward:_SetDefault()
  self._iconObj:SetActive(false)
  self._fixedStandardObj:SetActive(false)
  self._fixedEliteObj:SetActive(false)
  self._fixedEliteLockObj:SetActive(false)
  self._state_NotStart:SetActive(false)
  self._state_Completed:SetActive(false)
  self._state_Taken:SetActive(false)
end

function UIActivityBattlePassN5ItemIconReward:SetData_Fixed(adv, component)
  self:_GetComponents()
  self._adv = adv
  self._component = component
  self._info = component:ComponentInfo()
  self:_SetDefault()
  local obj = adv and self._fixedEliteObj or self._fixedStandardObj
  obj:SetActive(true)
  self._fixedEliteLockObj:SetActive(adv and not self._info.m_unlock_advanced_reward)
end

function UIActivityBattlePassN5ItemIconReward:SetData(index, adv, component, clickCallback, tipCallback)
  self._scale = scale or UIItemScale.Level2
  self:_GetComponents()
  self._index = index
  self._adv = adv
  self._component = component
  self._info = component:ComponentInfo()
  self._clickCallback = clickCallback
  self._tipCallback = tipCallback
  self._state = self:_CheckState(adv)
  local rewards = {}
  if not adv then
    rewards = self._component:GetNormalRewards()
  else
    rewards = self._component:GetAdvancedRewards()
  end
  self._roleAsset = rewards[self._index]
  self._cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if self._cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._roleAsset.assetid)
    return
  end
  local cfg_item = Cfg.cfg_item[self._roleAsset.assetid]
  if cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. self._roleAsset.assetid)
    return
  end
  self._cg = cfg_item.Icon
  self._colorEnum = cfg_item.Color
  self:_SetState()
  self:_SetIcon()
  self._fixedEliteLockObj:SetActive(adv and not self._info.m_unlock_advanced_reward)
end

function UIActivityBattlePassN5ItemIconReward:OnHide()
  self._cg = nil
  self._index = nil
  self._callback = nil
end

function UIActivityBattlePassN5ItemIconReward:_SetIcon()
  local sop = self:GetUIComponent("UISelectObjectPath", "uiitem")
  local uiItem = sop:SpawnObject("UIItem")
  uiItem:SetForm(UIItemForm.Base, self._scale)
  uiItem:SetClickCallBack(function(go)
    self:bgOnClick(go)
  end)
  local _icon = self._cg
  local _quality = self._colorEnum
  local _text1 = self._roleAsset.count
  local _itemId = self._roleAsset.assetid
  uiItem:SetData({
    icon = _icon,
    quality = _quality,
    text1 = _text1,
    itemId = _itemId
  })
end

local UIActivityBattlePassN5ItemIconRewardState = {
  EState_Lock = 1,
  EState_Claim = 2,
  EState_Received = 3
}
_enum("UIActivityBattlePassN5ItemIconRewardState", UIActivityBattlePassN5ItemIconRewardState)

function UIActivityBattlePassN5ItemIconReward:_CheckState(adv)
  if adv and not self._info.m_unlock_advanced_reward then
    return UIActivityBattlePassN5ItemIconRewardState.EState_Lock
  end
  if self._index > self._info.m_current_level then
    return UIActivityBattlePassN5ItemIconRewardState.EState_Lock
  end
  local received = adv and self._info.m_received_advanced_lv or self._info.m_received_normal_lv
  for _, v in ipairs(received) do
    if v == self._index then
      return UIActivityBattlePassN5ItemIconRewardState.EState_Received
    end
  end
  return UIActivityBattlePassN5ItemIconRewardState.EState_Claim
end

function UIActivityBattlePassN5ItemIconReward:_SetState()
  self._state_NotStart:SetActive(self._state == UIActivityBattlePassN5ItemIconRewardState.EState_Lock)
  self._state_Completed:SetActive(self._state == UIActivityBattlePassN5ItemIconRewardState.EState_Claim)
  self._state_Taken:SetActive(self._state == UIActivityBattlePassN5ItemIconRewardState.EState_Received)
end

function UIActivityBattlePassN5ItemIconReward:bgOnClick(go)
  if self._state == UIActivityBattlePassN5ItemIconRewardState.EState_Claim then
    if self._clickCallback then
      self._clickCallback(self._index, self._adv)
    end
  elseif self._tipCallback then
    self._tipCallback(self._roleAsset.assetid, go.transform.position)
  end
end
