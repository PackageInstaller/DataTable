_class("UIActivityBattlePassRewardCell", UICustomWidget)
UIActivityBattlePassRewardCell = UIActivityBattlePassRewardCell
local UIActivityBattlePassRewardCellState = {
  EState_Lock = 1,
  EState_Claim = 2,
  EState_Received = 3
}
_enum("UIActivityBattlePassRewardCellState", UIActivityBattlePassRewardCellState)

function UIActivityBattlePassRewardCell:_GetComponents()
  self._bgStandardObj = self:GetGameObject("bgStandard")
  self._bgEliteObj = self:GetGameObject("bgElite")
  self._bgStandard_PreviewObj = self:GetGameObject("bgStandard_Preview")
  self._bgElite_PreviewObj = self:GetGameObject("bgElite_Preview")
  self._bgStandard_Preview2Obj = self:GetGameObject("bgStandard_Preview2")
  self._bgElite_Preview2Obj = self:GetGameObject("bgElite_Preview2")
  self._iconImg = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRawImg = self:GetUIComponent("RawImage", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._iconObj = self:GetGameObject("icon")
  self._fgSpecial = self:GetGameObject("fgSpecial")
  self._countBgObj = self:GetGameObject("countBg")
  self._countBg_SpecialObj = self:GetGameObject("countBg_Special")
  self._countTextObj = self:GetGameObject("countText")
  self._countText = self:GetUIComponent("UILocalizationText", "countText")
  self._fixedStandardObj = self:GetGameObject("fixedStandard")
  self._fixedEliteObj = self:GetGameObject("fixedElite")
  self._fixedEliteLockObj = self:GetGameObject("fixedEliteLock")
  self._state_NotStart = self:GetGameObject("state_NotStart")
  self._state_Completed = self:GetGameObject("state_Completed")
  self._state_Taken = self:GetGameObject("state_Taken")
end

function UIActivityBattlePassRewardCell:_SetDefault()
  self._bgStandardObj:SetActive(false)
  self._bgEliteObj:SetActive(false)
  self._bgStandard_PreviewObj:SetActive(false)
  self._bgElite_PreviewObj:SetActive(false)
  self._bgStandard_Preview2Obj:SetActive(false)
  self._bgElite_Preview2Obj:SetActive(false)
  self._iconObj:SetActive(false)
  self._fgSpecial:SetActive(false)
  self._countTextObj:SetActive(false)
  self._fixedStandardObj:SetActive(false)
  self._fixedEliteObj:SetActive(false)
  self._fixedEliteLockObj:SetActive(false)
  self._state_NotStart:SetActive(false)
  self._state_Completed:SetActive(false)
  self._state_Taken:SetActive(false)
end

function UIActivityBattlePassRewardCell:SetData_Fixed(adv, component)
  self:_GetComponents()
  self._adv = adv
  self._component = component
  self._info = component:ComponentInfo()
  self:_SetDefault()
  local obj = adv and self._fixedEliteObj or self._fixedStandardObj
  obj:SetActive(true)
  self._fixedEliteLockObj:SetActive(adv and not self._info.m_unlock_advanced_reward)
end

function UIActivityBattlePassRewardCell:SetData(index, adv, special, component, clickCallback, tipCallback, matRes)
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
  self:_SetDefault()
  local obj = adv and self._bgEliteObj or self._bgStandardObj
  obj:SetActive(true)
  self._iconObj:SetActive(true)
  self._countTextObj:SetActive(true)
  self:_SetItemIcon()
  self:_SetState()
  self:_SetSpecial(adv, special)
end

function UIActivityBattlePassRewardCell:OnShow(uiParams)
  self._atlas = self:GetAsset("UIBattlePass.spriteatlas", LoadType.SpriteAtlas)
end

function UIActivityBattlePassRewardCell:OnHide()
  if self._EMIMatResRequest then
    self._EMIMat = nil
    self._EMIMatResRequest:Dispose()
    self._EMIMatResRequest = nil
  end
end

function UIActivityBattlePassRewardCell:_SetSpecial(adv, special)
  self._bgStandardObj:SetActive(adv == false and special == false)
  self._bgEliteObj:SetActive(adv == true and special == false)
  self._bgStandard_PreviewObj:SetActive(adv == false and special == true)
  self._bgElite_PreviewObj:SetActive(adv == true and special == true)
  self._bgStandard_Preview2Obj:SetActive(adv == false and special == true)
  self._bgElite_Preview2Obj:SetActive(adv == true and special == true)
  local isSkinBg = false
  local itemId = self._roleAsset.assetid
  local petModule = self:GetModule(PetModule)
  if petModule:IsPetSkinID(itemId) then
    isSkinBg = true
  end
  self._countBgObj:SetActive(not isSkinBg)
  self._countBg_SpecialObj:SetActive(isSkinBg)
end

function UIActivityBattlePassRewardCell:_CheckState(adv)
  if adv and not self._info.m_unlock_advanced_reward then
    return UIActivityBattlePassRewardCellState.EState_Lock
  end
  if self._index > self._info.m_current_level then
    return UIActivityBattlePassRewardCellState.EState_Lock
  end
  local received = adv and self._info.m_received_advanced_lv or self._info.m_received_normal_lv
  for _, v in ipairs(received) do
    if v == self._index then
      return UIActivityBattlePassRewardCellState.EState_Received
    end
  end
  return UIActivityBattlePassRewardCellState.EState_Claim
end

function UIActivityBattlePassRewardCell:_SetState()
  self._state_NotStart:SetActive(self._state == UIActivityBattlePassRewardCellState.EState_Lock)
  self._state_Completed:SetActive(self._state == UIActivityBattlePassRewardCellState.EState_Claim)
  self._state_Taken:SetActive(self._state == UIActivityBattlePassRewardCellState.EState_Received)
end

function UIActivityBattlePassRewardCell:_SetItemIcon()
  local icon = self._cfg_item.Icon
  local count = self._roleAsset.count
  local itemId = self._roleAsset.assetid
  self:SetIcon(icon, itemId)
  self:SetCount(count, true)
  local petModule = self:GetModule(PetModule)
  if petModule:IsPetSkinID(itemId) then
    self._fgSpecial:SetActive(true)
  end
end

function UIActivityBattlePassRewardCell:SetIcon(name, itemId)
  if not string.isnullorempty(name) then
    self:ShowIcon(true, itemId)
    self._iconImg:LoadImage(name)
    self:_SetRawImageGray(self._state == UIActivityBattlePassRewardCellState.EState_Received)
  else
    self:ShowIcon(false)
  end
end

function UIActivityBattlePassRewardCell:_SetRawImageGray(gray)
  if not self._EMIMat then
    self._EMIMat = UnityEngine.Material:New(self._iconRawImg.material)
  end
  if gray then
    local texture = self._iconRawImg.material.mainTexture
    self._iconRawImg.material = self._EMIMat
    self._iconRawImg.material.mainTexture = texture
    self._iconRawImg.material:SetFloat("_LuminosityAmount", 1)
  else
    self._iconRawImg.material:SetFloat("_LuminosityAmount", 0)
  end
  self._iconObj:SetActive(false)
  self._iconObj:SetActive(true)
end

function UIActivityBattlePassRewardCell:ShowIcon(show, itemId)
  self._iconObj:SetActive(show)
  self:SetIconOffset(itemId)
end

function UIActivityBattlePassRewardCell:SetIconOffset(itemId)
  if self:_IsPet(itemId) then
    self._iconRect.anchoredPosition = Vector2(0, 0)
  else
    self._iconRect.anchoredPosition = Vector2(0, 5)
  end
end

function UIActivityBattlePassRewardCell:_IsPet(id)
  local cfg = Cfg.cfg_pet({ID = id})
  return cfg and true or false
end

function UIActivityBattlePassRewardCell:SetCount(text, showZeroFlag)
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
  end
end

function UIActivityBattlePassRewardCell:bgOnClick(go)
  if self._state == UIActivityBattlePassRewardCellState.EState_Claim then
    if self._clickCallback then
      self._clickCallback(self._index, self._adv)
    end
  elseif self._tipCallback then
    self._tipCallback(self._roleAsset.assetid, go.transform.position)
  end
end
