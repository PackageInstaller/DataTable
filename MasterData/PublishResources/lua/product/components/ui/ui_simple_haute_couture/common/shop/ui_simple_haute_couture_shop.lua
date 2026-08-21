_class("UISimpleHauteCoutureShop", UIController)
UISimpleHauteCoutureShop = UISimpleHauteCoutureShop

function UISimpleHauteCoutureShop:OnShow(uiParams)
  self._campaign = uiParams[1]
  self._shopComponent = self._campaign:GetComponent(ECampaignPetSkinComponentID.SHOPEXCHANGE)
  self._shopCmpInfo = self._shopComponent:GetComponentInfo()
  self._randomLotteryComponent = self._campaign:GetComponent(ECampaignPetSkinComponentID.RANDOMLOTTERY)
  self._cfgMap = self._randomLotteryComponent:GetFirstCfg()
  self._cfgMain = self._randomLotteryComponent:GetCfgMain()
  self:AttachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
  self:_GetComponents()
  self:_InitUI()
end

function UISimpleHauteCoutureShop:OnHide()
  self:DetachEvent(GameEventType.ActivityShopBuySuccess, self.RefreshUI)
end

function UISimpleHauteCoutureShop:_GetComponents()
  local btns = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  local backBtn = btns:SpawnObject("UINewCommonTopButton")
  backBtn:SetData(function()
    self:Close()
  end, nil, function()
    self:SwitchState(UIStateType.UIMain)
  end, false)
  self._smallLoader = self:GetUIComponent("UISelectObjectPath", "SmallList")
  self._bigLoader = self:GetUIComponent("UISelectObjectPath", "Big")
  self._topContent = self:GetUIComponent("UISelectObjectPath", "topContent")
  self._topTips = self:GetUIComponent("UISelectObjectPath", "toptips")
  self._topTipsInfo = self._topTips:SpawnObject("UITopTipsContext")
end

function UISimpleHauteCoutureShop:Close()
  self:CloseDialog()
end

function UISimpleHauteCoutureShop:_InitUI()
  local topMenu = self._topContent:SpawnObject("UISimpleHauteCoutureTopMenu")
  topMenu:SetData(self._topTipsInfo, self._cfgMap.CostItemID, RoleAssetID.RoleAssetDiamond, self._cfgMain.ScoreID, function()
  end, true, true)
  self:RefreshGoodList(true)
end

function UISimpleHauteCoutureShop:RefreshUI()
  self:RefreshGoodList(false)
end

function UISimpleHauteCoutureShop:RefreshGoodList(playAnim)
  local bigList = {}
  local smallList = {}
  for _, itemInfo in ipairs(self._shopCmpInfo.m_exchange_item_list) do
    local isSpecial = itemInfo.m_is_special
    if isSpecial then
      bigList[#bigList + 1] = itemInfo
    else
      smallList[#smallList + 1] = itemInfo
    end
  end
  if playAnim then
    self:StartTask(self.CreateItemAnim, self, bigList, smallList, self._shopComponent)
  else
    self._bigLoader:SpawnObjects("UISimpleHauteCoutureShopItem", #bigList)
    local items = self._bigLoader:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(bigList[i], self._shopComponent, self._randomLotteryComponent, function(itemInfo)
        self:ExchangeItem(itemInfo)
      end)
    end
    self._smallLoader:SpawnObjects("UISimpleHauteCoutureShopItem", #smallList)
    local items = self._smallLoader:GetAllSpawnList()
    for i = 1, #items do
      items[i]:Refresh(smallList[i], self._shopComponent, self._randomLotteryComponent, function(itemInfo)
        self:ExchangeItem(itemInfo)
      end)
    end
  end
end

function UISimpleHauteCoutureShop:CreateItemAnim(TT, bigList, smallList, shopCom)
  self:Lock("UISimpleHauteCouturShop_CreateItemAnim")
  self._bigLoader:SpawnObjects("UISimpleHauteCoutureShopItem", #bigList)
  local items = self._bigLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  for i = 1, #items do
    items[i]:Refresh(bigList[i], shopCom, self._randomLotteryComponent, function(itemInfo)
      self:ExchangeItem(itemInfo)
    end)
    YIELD(TT, 80)
  end
  self._smallLoader:SpawnObjects("UISimpleHauteCoutureShopItem", #smallList)
  local items = self._smallLoader:GetAllSpawnList()
  for i = 1, #items do
    items[i]:SetVisible(false)
  end
  for i = 1, #items do
    items[i]:Refresh(smallList[i], shopCom, self._randomLotteryComponent, function(itemInfo)
      self:ExchangeItem(itemInfo)
    end)
    YIELD(TT, 80)
  end
  self:UnLock("UISimpleHauteCouturShop_CreateItemAnim")
end

function UISimpleHauteCoutureShop:ExchangeItem(itemInfo)
  local uiItemData = DCampaignShopItemBase:New()
  uiItemData:Refresh(itemInfo, self._shopComponent)
  local useNormalDlg = false
  if not uiItemData:IsUnLimit() then
    local remainCount = uiItemData:GetRemainCount()
    if remainCount <= 0 then
      return
    end
    if remainCount == 1 then
      useNormalDlg = true
    end
  end
  if uiItemData.isSpecial then
    self:ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUT_ACTIVITY_DETAIL, self._cfgMain.SkinID, uiItemData, function()
      if useNormalDlg then
        self:ShowDialog("UICampaignShopConfirmNormalController", uiItemData)
      else
        self:ShowDialog("UICampaignShopConfirmDetailController", uiItemData)
      end
    end)
  elseif useNormalDlg then
    self:ShowDialog("UICampaignShopConfirmNormalController", uiItemData)
  else
    self:ShowDialog("UICampaignShopConfirmDetailController", uiItemData)
  end
end

function UISimpleHauteCoutureShop:GetItemCountStr(byteCount, count, preColor, countColor)
  local dight = 0
  local tmpCount = count
  if tmpCount < 0 then
    tmpCount = -tmpCount
  end
  while 0 < tmpCount do
    tmpCount = math.floor(tmpCount / 10)
    dight = dight + 1
  end
  local pre = ""
  if 0 <= count then
    for i = 1, byteCount - dight do
      pre = pre .. "0"
    end
  else
    for i = 1, byteCount - dight - 1 do
      pre = pre .. "0"
    end
  end
  if 0 < count then
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  elseif count == 0 then
    return string.format("<color=" .. preColor .. ">%s</color>", pre)
  else
    return string.format("<color=" .. preColor .. ">%s</color><color=" .. countColor .. ">%s</color>", pre, count)
  end
end

function UISimpleHauteCoutureShop:_RandomIndex(index)
  local t = {}
  for i = 1, 5 do
    if i ~= index then
      t[#t + 1] = i
    end
  end
  return t[math.random(1, #t)]
end

function UISimpleHauteCoutureShop:CheckComponentStatus(component)
  if not component then
    return ActivityComponentStatus.Close, 0
  end
  local info = component:GetComponentInfo()
  if not info then
    return ActivityComponentStatus.Close, 0
  end
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  if curTime >= info.m_close_time then
    return ActivityComponentStatus.Close, 0
  end
  local opentTime = info.m_open_time
  local unLockTime = info.m_unlock_time
  local time = opentTime
  if unLockTime > time then
    time = unLockTime
  end
  if curTime > time then
    if not info.m_b_unlock then
      return ActivityComponentStatus.MissionLock, 0
    end
    return ActivityComponentStatus.Open, info.m_close_time - curTime
  end
  return ActivityComponentStatus.TimeLock, time - curTime
end
