local WorldStageSyncCardComp = System.NewComponent("WorldStageSyncCardComp")
local SYNC_CARD_UPDATE = CommonDefine.CardSyncType.Update
local SYNC_CARD_ADD = CommonDefine.CardSyncType.Add

function WorldStageSyncCardComp:ctor(stageComp)
  self.syncCardList = {}
  self.stageComp = stageComp
end

function WorldStageSyncCardComp:OnBind(binder)
  self.binder = binder
  binder:BindResponse(self, "World", "OnSyncCard", System.fn(self, self.OnSyncCard))
  binder:BindTimer(0.2, -1, System.fn(self, self.CheckShowSyncCard), nil)
end

function WorldStageSyncCardComp:OnSyncCard(syncData)
  if not IntroductionDataUtils.IsFinish() then
    return
  end
  self.binder:BindTimer(0.15, 0, nil, function()
    for _, card in pairs(syncData) do
      self:_DealSyncCard(card)
    end
  end)
end

function WorldStageSyncCardComp:CheckShowSyncCard()
  local mapEntity = self.stageComp.map
  if not mapEntity or not mapEntity.isShow then
    return
  end
  if bg.battleScene then
    return
  end
  if UIManager.Instance:GetWindow(Urls.WorldStageCardFlyPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.CardFeatureInfoPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.WorldStageShopConfirmPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.WorldStageRelicShowPanel) then
    return
  end
  if UIManager.Instance:GetWindow(Urls.WorldStageRelicThreeSelectPanel) then
    return
  end
  self:ShowCard()
end

function WorldStageSyncCardComp:_DealSyncCard(syncData)
  local syncType = syncData.type
  if syncType ~= SYNC_CARD_ADD and syncType ~= SYNC_CARD_UPDATE then
    return
  end
  if syncType == SYNC_CARD_UPDATE then
    if not self:CheckIsCaredUpdate(syncData) then
      return
    end
  elseif 1 ~= syncData.playAnim then
    return
  end
  CardDataUtils.ClearCardDisplayInfo(syncData.uid)
  local uid = syncData.uid
  local isHave = false
  for index = #self.syncCardList, 1, -1 do
    local oldCard = self.syncCardList[index]
    if oldCard.uid == uid then
      isHave = true
      table.remove(self.syncCardList, index)
    end
  end
  if isHave then
    syncData.type = SYNC_CARD_UPDATE
  end
  table.insert(self.syncCardList, syncData)
end

function WorldStageSyncCardComp:CheckIsCaredUpdate(syncData)
  local card = CardDataUtils.GetCardInfo(syncData.uid)
  if card and card.isShowUpdate then
    return true
  end
end

function WorldStageSyncCardComp:CheckIsForbidShowAdd(syncData)
  local card = CardDataUtils.GetCardInfo(syncData.uid)
  if card and card.isForbidShowAdd then
    return true
  end
  if card and card.isEternalCantChoose then
    return true
  end
end

function WorldStageSyncCardComp:ShowCard()
  local stagePanel = UIManager.Instance:GetWindow(Urls.WorldStageMainPanel)
  if not stagePanel then
    return
  end
  if #self.syncCardList <= 0 then
    return
  end
  local delIndexList = {}
  local type
  local maxShowAddCount = 3
  local maxShowUpdateCount = 1
  local showList = {}
  for i, card in ipairs(self.syncCardList) do
    type = type or card.type
    if card.type == type then
      table.insert(delIndexList, i)
      table.insert(showList, card)
    end
    if type == SYNC_CARD_ADD and maxShowAddCount <= #showList or type == SYNC_CARD_UPDATE and maxShowUpdateCount <= #showList then
      break
    end
  end
  for i = #delIndexList, 1, -1 do
    local delIndex = delIndexList[i]
    table.remove(self.syncCardList, delIndex)
  end
  if #showList <= 0 then
    return
  end
  if type == SYNC_CARD_ADD then
    self:ShowCardAdd(showList)
  end
  if type == SYNC_CARD_UPDATE then
    self:ShowCardUpdate(showList[1])
  end
end

function WorldStageSyncCardComp:ShowCardAdd(showList)
  if self:CheckIsForbidShowAdd(showList[1]) then
    return
  end
  local rewardPanel = UIManager.Instance:GetWindow(Urls.WorldStageBattleRewardPanel)
  if rewardPanel and rewardPanel.cardGroup then
    for _, card in ipairs(showList) do
      for _, enchantInfo in ipairs(rewardPanel.cardGroup) do
        if enchantInfo.cardUid == card.uid then
          return
        end
      end
    end
  end
  local stagePanel = UIManager.Instance:GetWindow(Urls.WorldStageMainPanel)
  if not stagePanel then
    return
  end
  local cardTids = {}
  local cardUids = {}
  for _, card in ipairs(showList) do
    table.insert(cardTids, card.tid)
    table.insert(cardUids, card.uid)
  end
  local worldPos = stagePanel:GetCardBagWorldPos()
  UIManager.Instance:Reopen(Urls.WorldStageCardFlyPanel, cardTids, cardUids, worldPos)
end

function WorldStageSyncCardComp:ShowCardUpdate(card)
  local panelData = {
    cardUid = card.uid,
    cardTid = card.tid,
    cardLevel = card.level,
    cost = card.cost,
    closeCallBack = function()
      if card.closeUrl then
        UIManager.Instance:CloseByUrl(card.closeUrl)
      end
    end
  }
  local cardData = CardDataUtils.GetCardInfo(card.uid)
  if cardData and cardData.runes then
    local runeTid = cardData.runes[1]
    local enchantConfig = DT.EnchantConfig[runeTid] or nil
    if enchantConfig then
      local enchantQuality = enchantConfig.Quality or "White"
      AudioManager.Instance:PostEnchantUpgradeSound(enchantQuality)
    end
  end
  UIManager.Instance:Reopen(Urls.CardFeatureInfoPanel, panelData)
end

function WorldStageSyncCardComp:GetUpdateClosePanel()
end

return WorldStageSyncCardComp
