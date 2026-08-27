local base = UIBaseWindow
local UIReinforceCardFriendSup = class("UIReinforceCardFriendSup", base)
local UINReinforceCardFriendSupItem = require("Game.Reinforce.UI.CardSet.FriendSupport.UINReinforceCardFriendSupItem")
local cs_ResLoader = CS.ResLoader

function UIReinforceCardFriendSup:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction)
  UIUtil.AddValueChangedListener(self.ui.Tog_JustShowFriend, self, self.OnClickOnlyFriendTog)
  UIUtil.AddButtonListener(self.ui.Btn_RefreshList, self, self.OnClickRefreshBtn)
  self.objNetworkCtrl = NetworkManager:GetNetwork(NetworkTypeID.Object)
  self.resloader = cs_ResLoader.Create()
  self.friendsBanData = nil
  self.nextFreshTm = nil
  self.allSupportCardDic = {}
  self.strangerUserInfoDic = {}
  self.__isOnlyShowFriend = false
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnInstantiateItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
end

function UIReinforceCardFriendSup:InitReinforceCardFriendSupport(actFrameId, allCardData, curUID, onSelectCallback)
  function self.onSelectCallback(cardData, bool)
    if onSelectCallback ~= nil then
      onSelectCallback(cardData, bool)
    end
    UIUtil.OnClickBackByUiTab(self)
  end
  
  self.allCardData = allCardData
  self.curUID = curUID
  self.actFrameId = actFrameId
  self.cardItemDic = {}
  self:RefreshSupportCardDic()
end

function UIReinforceCardFriendSup:RefreshSupportCardDic(isForeceRefresh)
  self.allCardData:GetAllSupportFactCardData(function(allSupportCardDic, nextFreshTm, friendsBanData, strangerUserInfoDic)
    self.allSupportCardDic = allSupportCardDic
    self.friendsBanData = friendsBanData
    self.nextFreshTm = nextFreshTm
    self.strangerUserInfoDic = strangerUserInfoDic
    self:RefreshSupportCardItem()
    self:RfreshSupportTimeLimit()
    self:StartRefreshTimer()
  end, isForeceRefresh)
end

function UIReinforceCardFriendSup:RefreshSupportCardItem()
  local SupportCardList = {}
  for userUID, dic in pairs(self.allSupportCardDic) do
    if not self.__isOnlyShowFriend or self.strangerUserInfoDic[userUID] == nil then
      for uid, cardData in pairs(dic) do
        table.insert(SupportCardList, cardData)
      end
    end
  end
  local isHaveCard = 0 < #SupportCardList
  self.ui.EmptyList:SetActive(not isHaveCard)
  if not isHaveCard then
    self.ui.scrollRect.totalCount = 0
    self.ui.scrollRect:RefillCells()
    return
  end
  table.sort(SupportCardList, function(a, b)
    local a_score = a:GetRfCdInfiniteCoe()
    local b_score = b:GetRfCdInfiniteCoe()
    if a_score ~= b_score then
      return a_score > b_score
    end
    local a_buffNum = #a:GetRfCdBuffList()
    local b_buffNum = #b:GetRfCdBuffList()
    if a_buffNum ~= b_buffNum then
      return a_buffNum > b_buffNum
    end
    local a_chipNum = #a:GetRfCdFacFmtChipList()
    local b_chipNum = #b:GetRfCdFacFmtChipList()
    if a_chipNum ~= b_chipNum then
      return a_chipNum > b_chipNum
    end
    local a_UID = a:GetRfCdUID()
    local b_UID = b:GetRfCdUID()
    return a_UID > b_UID
  end)
  self.supportCardList = SupportCardList
  self.ui.scrollRect.totalCount = #self.supportCardList
  self.ui.scrollRect:RefillCells()
end

function UIReinforceCardFriendSup:__OnInstantiateItem(go)
  local cardItem = UINReinforceCardFriendSupItem.New()
  cardItem:Init(go)
  cardItem:InitSupportFacCard(self.resloader, self.onSelectCallback)
  self.cardItemDic[go] = cardItem
end

function UIReinforceCardFriendSup:__OnChangeItem(go, index)
  local cardItem = self.cardItemDic[go]
  if cardItem == nil then
    return
  end
  local cardIndex = index + 1
  local cardData = self.supportCardList[cardIndex]
  cardItem:RefreshSupportFacCard(cardData)
end

function UIReinforceCardFriendSup:RfreshSupportTimeLimit()
  local totalLimitNum = self.allCardData:GetRfEpMainCfg().daily_friend_frequency
  local counterElem = ControllerManager:GetController(ControllerTypeId.TimePass):getCounterElemData(proto_object_CounterModule.CounterModuleMyUseFriendFactorNum, 0)
  local usedTimes = 0
  if counterElem ~= nil and counterElem.nextExpiredTm > PlayerDataCenter.timestamp then
    usedTimes = counterElem.times
  end
  self.ui.Tex_Residue.text = tostring(totalLimitNum - usedTimes)
end

function UIReinforceCardFriendSup:StartRefreshTimer()
  self:RefreshRefreshBtn()
  if self.tiemerId ~= nil then
    TimerManager:StopTimer(self.tiemerId)
    self.tiemerId = nil
  end
  self.tiemerId = TimerManager:StartTimer(1, self.RefreshRefreshBtn, self, false, false, true)
end

function UIReinforceCardFriendSup:RefreshRefreshBtn()
  local leftRefreshTime = math.floor((self.nextFreshTm or 0) - PlayerDataCenter.timestamp)
  if 0 < leftRefreshTime then
    self.ui.Tex_Refresh:SetIndex(1, tostring(leftRefreshTime))
    self.ui.Btn_RefreshList.interactable = false
  else
    self.ui.Tex_Refresh:SetIndex(0)
    self.ui.Btn_RefreshList.interactable = true
  end
end

function UIReinforceCardFriendSup:OnClickOnlyFriendTog(isOn)
  self.__isOnlyShowFriend = isOn
  self.ui.Obj_Tog:SetActive(isOn)
  self:RefreshSupportCardItem()
end

function UIReinforceCardFriendSup:OnClickRefreshBtn()
  self:RefreshSupportCardDic(true)
end

function UIReinforceCardFriendSup:BackAction()
  self:Delete()
end

function UIReinforceCardFriendSup:OnDelete()
  if self.tiemerId ~= nil then
    TimerManager:StopTimer(self.tiemerId)
    self.tiemerId = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  base.OnDelete(self)
end

return UIReinforceCardFriendSup
