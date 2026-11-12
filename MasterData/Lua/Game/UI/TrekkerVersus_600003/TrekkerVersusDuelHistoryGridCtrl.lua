local TrekkerVersusDuelHistoryGridCtrl = class("TrekkerVersusDuelHistoryGridCtrl", BaseCtrl)
TrekkerVersusDuelHistoryGridCtrl._mapNodeConfig = {
  imgHeadStreamerGrid = {nCount = 2, sComponentName = "Image"},
  txtNameStreamerGrid = {nCount = 2, sComponentName = "TMP_Text"},
  txtHeatStreamerGrid = {nCount = 2, sComponentName = "TMP_Text"},
  txtDuelWinReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_DuelWinReward"
  },
  itemReward = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnItemReward = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  imgDuelEnd = {},
  txtDuelOnGoing = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_DuelOnGoing"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  TMPReceiveGrid = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  imgWin = {}
}
TrekkerVersusDuelHistoryGridCtrl._mapEventConfig = {
  TrekkerVersusDuelQuestRefresh = "OnEvent_TrekkerVersusDuelQuestRefresh"
}
TrekkerVersusDuelHistoryGridCtrl._mapRedDotConfig = {}

function TrekkerVersusDuelHistoryGridCtrl:Awake()
end

function TrekkerVersusDuelHistoryGridCtrl:FadeIn()
end

function TrekkerVersusDuelHistoryGridCtrl:FadeOut()
end

function TrekkerVersusDuelHistoryGridCtrl:OnEnable()
end

function TrekkerVersusDuelHistoryGridCtrl:OnDisable()
end

function TrekkerVersusDuelHistoryGridCtrl:OnDestroy()
end

function TrekkerVersusDuelHistoryGridCtrl:OnRelease()
end

function TrekkerVersusDuelHistoryGridCtrl:Refresh(mapDuelHistoryData, bMain, mapActData, nActId)
  self._mapNode.imgWin:SetActive(not bMain)
  self._mapNode.imgDuelEnd:SetActive(not bMain)
  self._mapNode.txtDuelOnGoing.gameObject:SetActive(bMain)
  self.bMain = bMain
  self.nActId = nActId
  self.mapDuelHistoryData = mapDuelHistoryData
  self.mapActData = mapActData
  self.bReceived = not bMain
  self._mapNode.btnReceive.gameObject:SetActive(not bMain)
  self._mapNode.imgDuelEnd:SetActive(not bMain)
  if mapDuelHistoryData.TargetId ~= nil then
    self.mapDuelData = ConfigTable.GetData("TravelerDuelTarget", mapDuelHistoryData.TargetId)
    local tbDuelRewardReceived = self.mapActData:GetDuelRewardTable()
    self.bReceived = table.indexof(tbDuelRewardReceived, mapDuelHistoryData.TargetId) > 0
    if not bMain then
      self._mapNode.btnReceive.gameObject:SetActive(not self.bReceived)
      self._mapNode.imgDuelEnd:SetActive(self.bReceived)
    end
  end
  local sHeatStr = (ConfigTable.GetUIText("TD_HeatQuestTab") or "") .. ":"
  NovaAPI.SetTMPText(self._mapNode.txtHeatStreamerGrid[1], sHeatStr .. "<space=9>" .. mapDuelHistoryData.SelfHotValue)
  NovaAPI.SetTMPText(self._mapNode.txtHeatStreamerGrid[2], sHeatStr .. "<space=9>" .. mapDuelHistoryData.RivalHotValue)
  local sSelfName = ConfigTable.GetUIText(AllEnum.TrekkerVersusDuelSelfInfo.NameKey) or ""
  NovaAPI.SetTMPText(self._mapNode.txtNameStreamerGrid[1], sSelfName)
  if self.mapDuelData ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtNameStreamerGrid[2], self.mapDuelData.RivalName)
    self:SetPngSprite(self._mapNode.imgHeadStreamerGrid[2], self.mapDuelData.RivalIcon or "")
    for i = 1, 3 do
      local nItemId = self.mapDuelData["ItemId" .. i]
      local nCount = self.mapDuelData["ItemQty" .. i]
      if nItemId ~= nil and 0 < nItemId then
        self._mapNode.itemReward[i].gameObject:SetActive(true)
        self._mapNode.itemReward[i]:SetItem(nItemId, nil, nCount, false, self.bReceived)
      else
        self._mapNode.itemReward[i].gameObject:SetActive(false)
      end
    end
  end
end

function TrekkerVersusDuelHistoryGridCtrl:OnBtnClick_Item(btn, nIdx)
  local sFieldName1 = "ItemId" .. nIdx
  local sFieldName2 = "ItemQty" .. nIdx
  if self.mapDuelData ~= nil then
    local nItemTid = self.mapDuelData[sFieldName1]
    local nCount = self.mapDuelData[sFieldName2]
    UTILS.ClickItemGridWithTips(nItemTid, btn.transform, true, true, false)
  end
end

function TrekkerVersusDuelHistoryGridCtrl:OnBtnClick_JumpTo(btn)
  EventManager.Hit("TrekkerVersusAffixJump", self.cfgData.AffixJumpTo)
end

function TrekkerVersusDuelHistoryGridCtrl:OnBtnClick_Receive(btn)
  EventManager.Hit("TrekkerVersusReceiveHeatQuest", self.nActId, 2)
end

function TrekkerVersusDuelHistoryGridCtrl:OnEvent_TrekkerVersusDuelQuestRefresh()
end

return TrekkerVersusDuelHistoryGridCtrl
