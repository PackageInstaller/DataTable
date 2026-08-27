local base = UIBaseWindow
local UIReinforceCardHandBook = class("UIReinforceCardHandBook", base)
local UIReinforceCardHandBookStoryItem = require("Game.Reinforce.UI.SystemCard.HandBook.UIReinforceCardHandBookStoryItem")
local UIReinForceCardHandBookCardItem = require("Game.Reinforce.UI.SystemCard.HandBook.UIReinforceCardHandBookCardItem")
local UIReinforceCardHandBookToggleItem = require("Game.Reinforce.UI.SystemCard.HandBook.UIReinforceCardHandBookToggleItem")
local ReinforceCardDataSystem = require("Game.Reinforce.Data.ReinforceCardDataSystem")
local ReinforceUtil = require("Game.Reinforce.Util.ReinforceUtil")
local cs_MessageCommon = CS.MessageCommon
local CS_ResLoader = CS.ResLoader

function UIReinforceCardHandBook:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self.OnBtnRulesClick)
  UIUtil.AddButtonListener(self.ui.btn_RewardCheck, self, self.OnBtnStoryRewardReViewClick)
  UIUtil.AddButtonListener(self.ui.btn_BackDraw, self, self.OnBtnPackShopClick)
  UIUtil.AddButtonListener(self.ui.btn_QuickLvlup, self, self.OnBtnBatchUpgradeClick)
  self._toggleItemPool = UIItemPool.New(UIReinforceCardHandBookToggleItem, self.ui.toggleItem, false)
  self._cardItemPool = UIItemPool.New(UIReinForceCardHandBookCardItem, self.ui.cardItem, false)
  self._storyItemPool = UIItemPool.New(UIReinforceCardHandBookStoryItem, self.ui.storyItem, false)
  self._onCardCollectionToggleClicked = BindCallback(self, self.OnSwitchReinforceCardGroup)
  self._resLoader = CS_ResLoader.Create()
  self._OnCardChangeFunc = BindCallback(self, self.OnCardChange)
  MsgCenter:AddListener(eMsgEventId.ReinforceCardSysChange, self._OnCardChangeFunc)
end

function UIReinforceCardHandBook:InitReinforceCardHandBook(actId, actFrameId, closeCallback)
  local actAn24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
  local rfDataAll = actAn24Ctrl:GetActFirstData():GetActAnv24RfCardDataAll()
  self.actId = actId
  self.actFrameId = actFrameId
  self.rfDataAll = rfDataAll
  self.collectCfg = ConfigData.reinforce_collect_card_main[self.actId]
  self.closeCallback = closeCallback
  local collectionCfgList = ConfigData.reinforce_collect_collect_theme[actId]
  self:RefreshTitle()
  local collectionRate, collectionCount = rfDataAll:GetAllCardCollectionPackRate(self.actId)
  self:InitReinforceCardCollectionToggleGroup(collectionCfgList)
  self:UpdateStoryList(ConfigData.reinforce_collect_collect_reward, collectionCount)
  self:UpdateStoryRate(collectionCount)
  local guideId = ConfigData.reinforce_collect_card_main[actId].collect_guide_id
  GuideManager:StartNewTriggerGuide(guideId)
end

function UIReinforceCardHandBook:RefreshTitle()
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(self.collectCfg.collect_name)
end

function UIReinforceCardHandBook:InitReinforceCardCollectionToggleGroup(collectionCfgList)
  self._toggleItemPool:HideAll()
  local defaultSelect
  for themeId, collectionCfg in pairs(collectionCfgList) do
    local toggleItem = self._toggleItemPool:GetOne()
    local isExistCardCanLvUp = self.rfDataAll:IsExistCardCanLvUp(themeId)
    toggleItem:InitReinforceCardHandBookToggleItem(collectionCfg.theme_id, collectionCfg, isExistCardCanLvUp, self._onCardCollectionToggleClicked)
    if defaultSelect == nil then
      defaultSelect = toggleItem
    end
  end
  defaultSelect:SetComRankPageItemIsOn()
end

function UIReinforceCardHandBook:OnSwitchReinforceCardGroup(collectionCfg)
  local themeId = collectionCfg.theme_id
  self.themeId = themeId
  local cardIdList = ConfigData.reinforce_card_card_main.packGroup[self.actFrameId][themeId]
  self:UpdateReinforceCardList(cardIdList)
  self._resLoader:LoadABAssetAsync(collectionCfg.theme_image, function(texture)
    self:UpdatePackImage(texture)
  end)
  local collectionRate = self.rfDataAll:GetCardCollectionPackRate(themeId, self.actId)
  self:UpdatePackCollectionRate(collectionRate)
  self:UpdateQuickLvlup(themeId)
end

function UIReinforceCardHandBook:UpdateReinforceCardList(cardIdList)
  self._cardItemPool:HideAll()
  if cardIdList == nil then
    return
  end
  for index, cardId in ipairs(cardIdList) do
    local cardCfg = ConfigData.reinforce_card_card_main[cardId]
    local reinforceCardData = self.rfDataAll:GetRfCardSysDataById(cardCfg.id)
    local cardItem = self._cardItemPool:GetOne()
    if reinforceCardData == nil then
      reinforceCardData = ReinforceCardDataSystem.New()
      local star = ReinforceUtil.GetCardLowestStar(cardCfg.id)
      reinforceCardData:InitRfCardDataSys(cardCfg.id, nil, star)
    end
    cardItem:InitReinForceCardHandBookCardItem(reinforceCardData, self._resLoader)
  end
end

function UIReinforceCardHandBook:UpdatePackImage(texture)
  if texture ~= nil and not IsNull(self.ui.img_PackagePic) then
    self.ui.img_PackagePic.texture = texture
  end
end

function UIReinforceCardHandBook:UpdatePackCollectionRate(collectionRate)
  self.ui.tex_Rate:SetIndex(0, string.format("%.1f", collectionRate * 100))
end

function UIReinforceCardHandBook:UpdateStoryList(storyList, collectionCount)
  self._storyItemPool:HideAll()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  local newReadId = -1
  for i = #storyList, 1, -1 do
    local storyCfg = storyList[i]
    local storyItem = self._storyItemPool:GetOne()
    local isUnlock = collectionCount >= storyCfg.condition
    local isRead = avgPlayCtrl:IsAvgPlayed(storyCfg.story_id)
    if isRead and i > newReadId then
      newReadId = i
    end
    storyItem:InitReinforceCardHandBookStoryItem(self.actId, storyCfg, isUnlock, isRead, self.ui, self.rfDataAll, i == #storyList)
  end
  if newReadId ~= -1 then
    self.ui.rect_storyList.horizontalNormalizedPosition = (newReadId - 1) / (#storyList - 1)
  end
end

function UIReinforceCardHandBook:UpdateStoryRate(collectionCount)
  self.ui.tex_StoryRate:SetIndex(0, tostring(collectionCount))
end

function UIReinforceCardHandBook:UpdateQuickLvlup(themeId)
  local isExistCardCanLvUp = self.rfDataAll:IsExistCardCanLvUp(themeId)
  self.ui.obj_QuickLvlup:SetActive(isExistCardCanLvUp)
end

function UIReinforceCardHandBook:OnBtnStoryRewardReViewClick()
  local rewardListCfg = {}
  local collectionRate, collectionCount = self.rfDataAll:GetAllCardCollectionPackRate(self.actId)
  local pickedScore = 0
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
  for id, cfg in pairs(ConfigData.reinforce_collect_collect_reward) do
    rewardListCfg[id] = {}
    rewardListCfg[id].score = {}
    rewardListCfg[id].score = cfg.condition
    local storyCfg = ConfigData.story_avg[cfg.story_id]
    rewardListCfg[id].rewardIds = storyCfg.rewardIds
    rewardListCfg[id].rewardNums = storyCfg.rewardNums
    if avgPlayCtrl:IsAvgPlayed(cfg.story_id) then
      pickedScore = cfg.condition
    end
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.StageRewardPreview, function(win)
    if win == nil then
    end
    win:InitUIStageRewardPreviewV2(rewardListCfg, pickedScore, collectionCount)
    win:SetRewardReceivedAllFunc(nil)
  end)
end

function UIReinforceCardHandBook:OnBtnPackShopClick()
  if UIManager:GetWindow(UIWindowTypeID.UIReinforceCardPackShop) ~= nil then
    self:Delete()
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardPackShop, function(window)
    if window == nil then
      return
    end
    window:InitReinforceCardPackShop(self.actId, self.actFrameId)
  end)
end

function UIReinforceCardHandBook:OnBtnBatchUpgradeClick()
  local isExistCardCanLvUp = self.rfDataAll:IsExistCardCanLvUp(self.themeId)
  if not isExistCardCanLvUp then
    return
  end
  cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(59003), function()
    local cardIdList = {}
    local allCardDataDic = self.rfDataAll:GetRfCardSysDataDic()
    for cardId, card in pairs(allCardDataDic) do
      if self.themeId == card._rfCdMainCfg.collect_theme and card:IsCanLvUp() then
        table.insert(cardIdList, cardId)
      end
    end
    NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_ReinforceCard_UpgradeMax(cardIdList, function()
      self:OnCardChange()
      for index, cardId in ipairs(cardIdList) do
        for index, item in pairs(self._cardItemPool.listItem) do
          if item._rfCardData.dataId == cardId then
            item:PlayLvUpAnim()
          end
        end
      end
    end)
  end, nil)
end

function UIReinforceCardHandBook:OnBtnRulesClick()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(self.collectCfg.collect_rule, false)
  end)
end

function UIReinforceCardHandBook:OnCardChange()
  local collectionRate, collectionCount = self.rfDataAll:GetAllCardCollectionPackRate(self.actId)
  self:UpdateStoryRate(collectionCount)
  local packCollectionRate = self.rfDataAll:GetCardCollectionPackRate(self.themeId, self.actId)
  self:UpdatePackCollectionRate(packCollectionRate)
  self:UpdateStoryList(ConfigData.reinforce_collect_collect_reward, collectionCount)
  local cardIdList = ConfigData.reinforce_card_card_main.packGroup[self.actFrameId][self.themeId]
  self:UpdateReinforceCardList(cardIdList)
  self:UpdateQuickLvlup(self.themeId)
  self:RefreshRedDot()
end

function UIReinforceCardHandBook:RefreshRedDot()
  for index, item in pairs(self._toggleItemPool.listItem) do
    local isExistCardCanLvUp = self.rfDataAll:IsExistCardCanLvUp(item.index)
    item:RefreshRedDot(isExistCardCanLvUp)
  end
end

function UIReinforceCardHandBook:BackAction()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIReinforceCardHandBook:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ReinforceCardSysChange, self._OnCardChangeFunc)
  self._storyItemPool:DeleteAll()
  self._cardItemPool:DeleteAll()
  self._toggleItemPool:DeleteAll()
  self._storyItemPool = nil
  self._cardItemPool = nil
  self._toggleItemPool = nil
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return UIReinforceCardHandBook
