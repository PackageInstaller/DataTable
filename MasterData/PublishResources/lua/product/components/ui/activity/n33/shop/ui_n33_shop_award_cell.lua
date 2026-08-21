_class("UIN33ShopAwardCell", UICustomWidget)
UIN33ShopAwardCell = UIN33ShopAwardCell
local ECampaignLRType = _ENV.ECampaignLRType

function UIN33ShopAwardCell:OnShow(uiParams)
  self._animCfg = {
    [1] = {
      "uieff_UIN33ShopAwardCell_in",
      333.3333333333333
    }
  }
  self:_GetComponents()
end

function UIN33ShopAwardCell:_GetComponents()
  local typeCount = ECampaignLRType.E_CLRT_rare + 1
  self._nodes = {}
  for i = 1, typeCount do
    local t = {}
    t._objBg = self:GetGameObject("Bg" .. i)
    t._itemIcon = self:GetUIComponent("RawImageLoader", "ItemIcon" .. i)
    t._itemNumText = self:GetUIComponent("UILocalizationText", "ItemNumText" .. i)
    t._restNumText = self:GetUIComponent("UILocalizationText", "RestNumText" .. i)
    self._nodes[i] = t
  end
  self._mask = self:GetGameObject("Mask")
  self._animation = self:GetUIComponent("Animation", "UIN33ShopAwardCell")
  self.go = self:GetGameObject()
end

function UIN33ShopAwardCell:InitN33ShopAwardCellData(data, itemInfoCallback, unlock, yieldTime, isTips)
  if not data then
    self.go:SetActive(false)
    return
  end
  if yieldTime and 0 <= yieldTime then
    self.go:SetActive(false)
    self:ShowAnim(1, yieldTime)
  else
    self.go:SetActive(true)
  end
  self._data = data
  self._rewardType = self._data.m_reward_type + 1
  self._unlock = unlock
  self._itemId = self._data.m_item_id
  self._itemCount = self._data.m_lottery_limit_count
  self._itemRestCount = self._data.m_lottery_count
  self._itemInfoCallback = itemInfoCallback
  self._isTips = isTips
  self:FillUi()
end

function UIN33ShopAwardCell:FillUi()
  for index, value in ipairs(self._nodes) do
    value._objBg:SetActive(index == self._rewardType)
  end
  local node = self._nodes[self._rewardType]
  local itemCfg = Cfg.cfg_item[self._itemId]
  self._mask:SetActive(not self._isTips and self._itemRestCount <= 0)
  if itemCfg then
    local itemCount = self._data.m_count
    node._itemIcon:LoadImage(itemCfg.Icon)
    node._itemNumText:SetText(itemCount)
    if self._itemRestCount and self._itemCount then
      local showTimesTex = self._itemRestCount .. "/" .. self._itemCount
      node._restNumText:SetText(showTimesTex)
    else
      node._restNumText:SetText("")
    end
  end
end

function UIN33ShopAwardCell:OnHide()
  if self._animTask then
    GameGlobal.TaskManager():KillTask(self._animTask)
    self._animTask = nil
  end
end

function UIN33ShopAwardCell:Bg1OnClick(go)
  self:_BgOnClick(go)
end

function UIN33ShopAwardCell:Bg2OnClick(go)
  self:_BgOnClick(go)
end

function UIN33ShopAwardCell:Bg3OnClick(go)
  self:_BgOnClick(go)
end

function UIN33ShopAwardCell:_BgOnClick(go)
  if self._itemInfoCallback then
    self._itemInfoCallback(self._data, nil, self._unlock, nil, true)
  end
end

function UIN33ShopAwardCell:ShowAnim(id, yieldTime)
  if self._animTask then
    GameGlobal.TaskManager():KillTask(self._animTask)
    self._animTask = nil
  end
  local data = self._animCfg[id]
  self._animTask = self:StartTask(function(TT)
    YIELD(TT, yieldTime)
    self.go:SetActive(true)
    self._animation:Play(data[1])
    self._animTask = nil
  end)
end
