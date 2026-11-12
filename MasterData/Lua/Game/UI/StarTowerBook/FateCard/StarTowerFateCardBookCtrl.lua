local StarTowerFateCardBookCtrl = class("StarTowerFateCardBookCtrl", BaseCtrl)
StarTowerFateCardBookCtrl._mapNodeConfig = {
  goBundle = {},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_FateCard_Title_01"
  },
  bundleLSV = {
    sComponentName = "LoopScrollView"
  },
  goCardList = {},
  togLSV = {
    sComponentName = "LoopScrollView"
  },
  goCardItem = {
    nCount = 8,
    sCtrlName = "Game.UI.StarTowerBook.FateCard.FateCardBookItemCtrl"
  },
  btnCard = {
    nCount = 8,
    sComponentName = "UIButton",
    callback = "OnBtnClick_CardItem"
  },
  imgEmpty = {},
  goRightCardList = {},
  txtCollectCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Collect"
  },
  txtCollectCount = {sComponentName = "TMP_Text"},
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnReceiveReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  imgDotBg = {nCount = 8},
  imgDot = {nCount = 8},
  animPage = {sNodeName = "imgBook", sComponentName = "Animator"},
  goLeftCardList = {},
  goBlur = {},
  goCardDetail = {},
  animCardDetail = {
    sNodeName = "goCardDetail",
    sComponentName = "Animator"
  },
  btnBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_Bg"
  },
  fateCardDetail = {
    sCtrlName = "Game.UI.StarTower.FateCard.FateCardItemCtrl"
  },
  goFateCardDetail = {
    sNodeName = "fateCardDetail"
  },
  btnToggleStarTower = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  btnToggleSurvivor = {
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl"
  },
  togST = {
    sNodeName = "btnToggleStarTower",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CardTypeStarTower"
  },
  togSV = {
    sNodeName = "btnToggleSurvivor",
    sComponentName = "UIButton",
    callback = "OnBtnClick_CardTypeSurvivor"
  },
  txtArea = {sComponentName = "TMP_Text"},
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_Close_Tip"
  },
  goCardTip = {},
  btnTipBg = {
    sComponentName = "Button",
    callback = "OnBtnClick_TipBg"
  },
  txtUnlockTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_Book_FateCard_Unlock_Tip"
  },
  txtUnlockTip = {sComponentName = "TMP_Text"},
  redDotReward = {},
  btnReceiveAllFateCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveAllFateCard"
  },
  TMPReceiveAllFateCardTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Btn_ReceiveAll"
  }
}
StarTowerFateCardBookCtrl._mapEventConfig = {
  ReceiveFateCardBookReward = "OnEvent_ReceiveFateCardBookReward"
}
StarTowerFateCardBookCtrl._mapRedDotConfig = {}

function StarTowerFateCardBookCtrl:ResetNewRedDot(nBundleId)
  if self.mapBundleList ~= nil then
    if nBundleId then
      local tbCardList = self.mapBundleList[nBundleId].tbCardList
      if tbCardList then
        for _, card in ipairs(tbCardList) do
          RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_New, card.nId, false)
        end
      end
    else
      for _, v in pairs(self.mapBundleList) do
        for _, card in ipairs(v.tbCardList) do
          RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_New, card.nId, false)
        end
      end
    end
  end
end

function StarTowerFateCardBookCtrl:Init()
  self.animRoot:Play("StarTowerBookFateCard_in", 0, 0)
  CS.WwiseAudioManager.Instance:PlaySound("ui_rogueBook_page_drag")
  self.nBundleId = 0
  self.nSelectIndex = 0
  self.nCurPage = 0
  self.nCurCardId = 0
  self:RefreshBundleList()
  self:RefreshReceiveAllBtn()
  self._mapNode.btnToggleStarTower:SetText(ConfigTable.GetUIText("LevelMenu_Startower"))
  self._mapNode.btnToggleSurvivor:SetText(ConfigTable.GetUIText("LevelMenu_Vampire"))
end

function StarTowerFateCardBookCtrl:Back()
  if self.bFateCardList then
    self.bFateCardList = false
    self:ResetNewRedDot()
    self._mapNode.goBundle.gameObject:SetActive(true)
    self._mapNode.goCardList.gameObject:SetActive(false)
    self._mapNode.goCardDetail.gameObject:SetActive(false)
    self._mapNode.goCardTip.gameObject:SetActive(false)
    self._mapNode.goBlur.gameObject:SetActive(false)
    self:RefreshReceiveAllBtn()
  else
    EventManager.Hit("ChangeStarTowerBookPanel", AllEnum.StarTowerBookPanelType.Main)
  end
end

function StarTowerFateCardBookCtrl:RefreshBundleList()
  self._mapNode.goBundle.gameObject:SetActive(true)
  self._mapNode.goCardList.gameObject:SetActive(false)
  self._mapNode.goCardDetail.gameObject:SetActive(false)
  self._mapNode.goCardTip.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(false)
  self.mapBundleList = PlayerData.StarTowerBook:GetAllFateCardBundle()
  self.mapSortBundleList = {}
  self.mapBundleTogList = {}
  for nId, v in pairs(self.mapBundleList) do
    table.sort(v.tbCardList, function(a, b)
      return a.nSort < b.nSort
    end)
    table.insert(self.mapSortBundleList, {
      nBundleId = nId,
      tbCardList = v.tbCardList,
      nSort = v.nSort
    })
  end
  table.sort(self.mapSortBundleList, function(a, b)
    return a.nSort < b.nSort
  end)
  self.mapBundleTogList = clone(self.mapSortBundleList)
  local nCount = #self.mapSortBundleList
  if nCount < 8 then
    for i = nCount + 1, 8 do
      table.insert(self.mapSortBundleList, {bEmpty = true})
    end
  end
  self._mapNode.bundleLSV:Init(#self.mapSortBundleList, self, self.OnBundleGridRefresh, self.OnBundleGridClick)
end

function StarTowerFateCardBookCtrl:SelectBundle(bKeepPos, bSetScrollPos)
  self.animRoot:Play("StarTowerBookFateCard_in1", 0, 0)
  self.bFateCardList = true
  self._mapNode.goBundle.gameObject:SetActive(false)
  self._mapNode.goCardList.gameObject:SetActive(true)
  self._mapNode.goCardDetail.gameObject:SetActive(false)
  self._mapNode.goCardTip.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(false)
  self._mapNode.togLSV:Init(#self.mapBundleTogList, self, self.OnTogGridRefresh, self.OnTogGridClick, bKeepPos)
  if bSetScrollPos then
    self._mapNode.togLSV:SetScrollGridPos(self.nSelectIndex - 1, 0.1, 0)
  end
  self.mapCardList = self.mapBundleList[self.nBundleId].tbCardList
  self.nCurPage = 1
  self.nAllPage = math.floor(#self.mapCardList % 8 == 0 and #self.mapCardList / 8 or #self.mapCardList / 8 + 1)
  self:RefreshPageList()
  self:RefreshLeftPage()
  self:RefreshRightPage()
  self._mapNode.btnReceiveAllFateCard.gameObject:SetActive(false)
  for k, v in ipairs(self._mapNode.imgDotBg) do
    v.gameObject:SetActive(k <= self.nAllPage and 1 < self.nAllPage)
  end
  local nCount = 0
  for _, v in ipairs(self.mapCardList) do
    if v.nStatus == AllEnum.FateCardBookStatus.Collect then
      nCount = nCount + 1
    end
  end
  local bCanReceive = RedDotManager.GetValid(RedDotDefine.StarTowerBook_FateCard_Reward, self.nBundleId)
  self._mapNode.btnReward.gameObject:SetActive(not bCanReceive)
  self._mapNode.btnReceiveReward.gameObject:SetActive(bCanReceive)
  NovaAPI.SetTMPText(self._mapNode.txtCollectCount, string.format("%s/%s", nCount, #self.mapCardList))
  RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_FateCard_Reward, self.nBundleId, self._mapNode.redDotReward)
end

function StarTowerFateCardBookCtrl:RefreshPageList()
  self._mapNode.btnLeft.gameObject:SetActive(self.nCurPage > 1)
  self._mapNode.btnRight.gameObject:SetActive(self.nCurPage < self.nAllPage)
  for k, v in ipairs(self._mapNode.imgDot) do
    v.gameObject:SetActive(k == self.nCurPage)
  end
end

function StarTowerFateCardBookCtrl:RefreshLeftPage()
  local nStartIndex = (self.nCurPage - 1) * 8
  for i = 1, 4 do
    local item = self._mapNode.goCardItem[i]
    local nIndex = nStartIndex + i
    item.gameObject:SetActive(self.mapCardList[nIndex] ~= nil)
    if self.mapCardList[nIndex] ~= nil then
      item:InitItem(self.mapCardList[nIndex].nId, self.mapCardList[nIndex].nStatus)
      item:RegisterRedDot()
    end
  end
end

function StarTowerFateCardBookCtrl:RefreshRightPage()
  local bEmpty = true
  local nStartIndex = (self.nCurPage - 1) * 8
  for i = 5, 8 do
    local item = self._mapNode.goCardItem[i]
    local nIndex = nStartIndex + i
    item.gameObject:SetActive(self.mapCardList[nIndex] ~= nil)
    if self.mapCardList[nIndex] ~= nil then
      bEmpty = false
      item:InitItem(self.mapCardList[nIndex].nId, self.mapCardList[nIndex].nStatus)
      item:RegisterRedDot()
    end
  end
  self._mapNode.imgEmpty.gameObject:SetActive(bEmpty)
end

function StarTowerFateCardBookCtrl:OnTogGridRefresh(goGrid, nIndex)
  local imgBundle = goGrid.transform:Find("btnGrid/AnimRoot/imgBundle"):GetComponent("Image")
  local imgNormal = goGrid.transform:Find("btnGrid/AnimRoot/imgNormal")
  local txtNormal = goGrid.transform:Find("btnGrid/AnimRoot/imgNormal/txtNormal"):GetComponent("TMP_Text")
  local imgChoose = goGrid.transform:Find("btnGrid/AnimRoot/imgChoose")
  local txtChoose = goGrid.transform:Find("btnGrid/AnimRoot/imgChoose/txtChoose"):GetComponent("TMP_Text")
  local redDot = goGrid.transform:Find("btnGrid/AnimRoot/redDotTog")
  local nId = self.mapBundleTogList[nIndex + 1].nBundleId
  local bundleCfg = ConfigTable.GetData("StarTowerBookFateCardBundle", nId)
  if bundleCfg ~= nil then
    self:SetPngSprite(imgBundle, bundleCfg.Icon)
    NovaAPI.SetTMPText(txtNormal, bundleCfg.ShortName)
    NovaAPI.SetTMPText(txtChoose, bundleCfg.ShortName)
  end
  imgChoose.gameObject:SetActive(nId == self.nBundleId)
  imgNormal.gameObject:SetActive(nId ~= self.nBundleId)
  RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_FateCard_Bundle_Tog, nId, redDot, nil, nil, true)
end

function StarTowerFateCardBookCtrl:OnTogGridClick(goGrid, nIndex)
  if nIndex + 1 == self.nSelectIndex then
    return
  end
  local goSelect = self._mapNode.togLSV.gameObject.transform:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    local imgChoose = goSelect.transform:Find("btnGrid/AnimRoot/imgChoose")
    imgChoose.gameObject:SetActive(false)
  end
  if self.nBundleId ~= 0 then
    self:ResetNewRedDot(self.nBundleId)
  end
  self.nSelectIndex = nIndex + 1
  self.nBundleId = self.mapBundleTogList[nIndex + 1].nBundleId
  local imgChoose = goGrid.transform:Find("btnGrid/AnimRoot/imgChoose")
  imgChoose.gameObject:SetActive(true)
  self:SelectBundle(true)
end

function StarTowerFateCardBookCtrl:OnBundleGridRefresh(goGrid, nIndex)
  local goItem = goGrid.transform:Find("btnGrid/AnimRoot/goBundleItem")
  local imgNormal = goItem:Find("imgNormal")
  local imgBundle = imgNormal:Find("imgBundle"):GetComponent("Image")
  local imgBundleS = imgNormal:Find("txtBundle/imgBundleS"):GetComponent("Image")
  local txtBundle = imgNormal:Find("txtBundle"):GetComponent("TMP_Text")
  local txtCount = imgNormal:Find("imgCount/txtCount"):GetComponent("TMP_Text")
  local imgEmpty = goItem:Find("imgEmpty")
  local txtEmpty = imgEmpty:Find("txtEmpty"):GetComponent("TMP_Text")
  NovaAPI.SetTMPText(txtEmpty, ConfigTable.GetUIText("StarTower_Book_FateCard_Empty"))
  local mapData = self.mapSortBundleList[nIndex + 1]
  imgNormal.gameObject:SetActive(not mapData.bEmpty)
  imgEmpty.gameObject:SetActive(mapData.bEmpty)
  if not mapData.bEmpty then
    local nBundleId = self.mapSortBundleList[nIndex + 1].nBundleId
    local bundleCfg = ConfigTable.GetData("StarTowerBookFateCardBundle", nBundleId)
    if bundleCfg ~= nil then
      self:SetPngSprite(imgBundle, bundleCfg.Icon .. AllEnum.FateCardBundleIcon.L)
      self:SetPngSprite(imgBundleS, bundleCfg.Icon)
      NovaAPI.SetTMPText(txtBundle, bundleCfg.ShortName)
    end
    local mapCardList = self.mapBundleList[nBundleId].tbCardList
    local nCount = 0
    for _, v in ipairs(mapCardList) do
      if v.nStatus == AllEnum.FateCardBookStatus.Collect then
        nCount = nCount + 1
      end
    end
    NovaAPI.SetTMPText(txtCount, string.format("%s/%s", nCount, #mapCardList))
    local redDot = imgNormal:Find("redDotBundle")
    RedDotManager.RegisterNode(RedDotDefine.StarTowerBook_FateCard_Bundle, nBundleId, redDot, nil, nil, true)
  end
end

function StarTowerFateCardBookCtrl:OnBundleGridClick(goGrid, nIndex)
  local mapBundle = self.mapSortBundleList[nIndex + 1]
  if mapBundle ~= nil and not mapBundle.bEmpty then
    self.nBundleId = mapBundle.nBundleId
    self.nSelectIndex = nIndex + 1
    self:SelectBundle(false, true)
  end
end

function StarTowerFateCardBookCtrl:RefreshReceiveAllBtn()
  self._mapNode.btnReceiveAllFateCard.gameObject:SetActive(false)
  for k, v in pairs(self.mapBundleList) do
    local nBundleId = k
    local bBundleCanReceive = RedDotManager.GetValid(RedDotDefine.StarTowerBook_FateCard_Reward, nBundleId)
    if bBundleCanReceive and not self.bFateCardList then
      self._mapNode.btnReceiveAllFateCard.gameObject:SetActive(true)
      break
    end
  end
end

function StarTowerFateCardBookCtrl:Awake()
  self.animRoot = self.gameObject:GetComponent("Animator")
end

function StarTowerFateCardBookCtrl:FadeIn()
end

function StarTowerFateCardBookCtrl:FadeOut()
end

function StarTowerFateCardBookCtrl:OnEnable()
end

function StarTowerFateCardBookCtrl:OnDisable()
  if self.bFateCardList then
    self:ResetNewRedDot()
  end
end

function StarTowerFateCardBookCtrl:OnDestroy()
end

function StarTowerFateCardBookCtrl:OnRelease()
end

function StarTowerFateCardBookCtrl:OnBtnClick_Left()
  if self.nCurPage <= 1 then
    return
  end
  self.nCurPage = self.nCurPage - 1
  self._mapNode.animPage:Play("FlipBook_Right", 0, 0)
  self:AddTimer(1, 0.3, function()
    self:RefreshRightPage()
  end, true, true, true, nil)
  self:RefreshPageList()
  self:RefreshLeftPage()
end

function StarTowerFateCardBookCtrl:OnBtnClick_Right()
  if self.nCurPage >= self.nAllPage then
    return
  end
  self.nCurPage = self.nCurPage + 1
  self._mapNode.animPage:Play("FlipBook_Left", 0, 0)
  self:AddTimer(1, 0.1, function()
    self:RefreshLeftPage()
  end, true, true, true, nil)
  self:RefreshPageList()
  self:RefreshRightPage()
end

function StarTowerFateCardBookCtrl:OnBtnClick_Reward()
  EventManager.Hit("OpenStarTowerBookQuest", self.nBundleId)
end

function StarTowerFateCardBookCtrl:OnBtnClick_Bg()
  self._mapNode.animCardDetail:Play("goCardDetail_out")
  local nAnimLen = NovaAPI.GetAnimClipLength(self._mapNode.animCardDetail, {
    "goCardDetail_out"
  })
  self:AddTimer(1, nAnimLen, function()
    self._mapNode.goCardDetail.gameObject:SetActive(false)
    self._mapNode.goBlur.gameObject:SetActive(false)
    if self._mapNode.goCardItem[self.nClickIndex] ~= nil then
    end
  end, true, true, true)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
end

function StarTowerFateCardBookCtrl:OnBtnClick_TipBg()
  self._mapNode.goCardTip.gameObject:SetActive(false)
  self._mapNode.goBlur.gameObject:SetActive(false)
end

function StarTowerFateCardBookCtrl:OnBtnClick_CardItem(btn, nIdx)
  local nIndex = (self.nCurPage - 1) * 8 + nIdx
  local cardData = self.mapCardList[nIndex]
  if cardData == nil then
    return
  end
  self.nCurCardId = cardData.nId
  local cardCfg = ConfigTable.GetData("StarTowerBookFateCard", cardData.nId)
  if cardCfg == nil then
    return
  end
  if cardData.nStatus == AllEnum.FateCardBookStatus.Lock then
    NovaAPI.SetTMPText(self._mapNode.txtUnlockTip, cardCfg.UnlockTip)
    self._mapNode.goCardTip.gameObject:SetActive(false)
    self._mapNode.goBlur.gameObject:SetActive(true)
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.goCardTip.gameObject:SetActive(true)
    end
    
    cs_coroutine.start(wait)
  else
    local function animFinishFunc()
      RedDotManager.SetValid(RedDotDefine.StarTowerBook_FateCard_New, cardData.nId, false)
      
      self._mapNode.goCardDetail.gameObject:SetActive(false)
      self._mapNode.goBlur.gameObject:SetActive(true)
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self._mapNode.goCardDetail.gameObject:SetActive(true)
      end
      
      cs_coroutine.start(wait)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
      self:OnBtnClick_CardTypeSurvivor()
      NovaAPI.SetTMPText(self._mapNode.txtArea, ConfigTable.GetUIText("StarTower_Event_Book_Source") .. cardCfg.Source)
    end
    
    self.nClickIndex = nIdx
    if self._mapNode.goCardItem[nIdx] ~= nil then
      self:AddTimer(1, 0.15, animFinishFunc, true, true, true)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.15)
    end
  end
end

function StarTowerFateCardBookCtrl:OnBtnClick_CardTypeStarTower()
  self._mapNode.fateCardDetail = self:BindCtrlByNode(self._mapNode.goFateCardDetail, "Game.UI.StarTower.FateCard.FateCardItemCtrl")
  if self.nCurCardId and self.nCurCardId ~= 0 then
    self._mapNode.fateCardDetail:SetFateCardItem(self.nCurCardId)
  end
  self._mapNode.btnToggleStarTower:SetDefault(true)
  self._mapNode.btnToggleSurvivor:SetDefault(false)
end

function StarTowerFateCardBookCtrl:OnBtnClick_CardTypeSurvivor()
  self._mapNode.fateCardDetail = self:BindCtrlByNode(self._mapNode.goFateCardDetail, "Game.UI.VampireSurvivor.FateCardItemCtrl")
  if self.nCurCardId and self.nCurCardId ~= 0 then
    self._mapNode.fateCardDetail:SetFateCardItem(self.nCurCardId)
  end
  self._mapNode.btnToggleStarTower:SetDefault(false)
  self._mapNode.btnToggleSurvivor:SetDefault(true)
end

function StarTowerFateCardBookCtrl:OnBtnClick_ReceiveAllFateCard()
  PlayerData.StarTowerBook:SendReceiveFateCardAllRewardMsg()
end

function StarTowerFateCardBookCtrl:OnEvent_ReceiveFateCardBookReward()
  local bCanReceive = RedDotManager.GetValid(RedDotDefine.StarTowerBook_FateCard_Reward, self.nBundleId)
  self._mapNode.btnReward.gameObject:SetActive(not bCanReceive)
  self._mapNode.btnReceiveReward.gameObject:SetActive(bCanReceive)
  self:RefreshReceiveAllBtn()
end

return StarTowerFateCardBookCtrl
