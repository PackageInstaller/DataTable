local TrekkerVersusQuestGridCtrl = class("TrekkerVersusQuestGridCtrl", BaseCtrl)
TrekkerVersusQuestGridCtrl._mapNodeConfig = {
  TMPDesc = {sComponentName = "TMP_Text"},
  TMPIncomplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  TMPReceiveGrid = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 3
  },
  btnItem = {
    sNodeName = "btnItem_",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item",
    nCount = 3
  },
  maskComplete = {},
  imgComplete = {},
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  }
}
TrekkerVersusQuestGridCtrl._mapEventConfig = {}
TrekkerVersusQuestGridCtrl._mapRedDotConfig = {}

function TrekkerVersusQuestGridCtrl:Awake()
end

function TrekkerVersusQuestGridCtrl:FadeIn()
end

function TrekkerVersusQuestGridCtrl:FadeOut()
end

function TrekkerVersusQuestGridCtrl:OnEnable()
end

function TrekkerVersusQuestGridCtrl:OnDisable()
end

function TrekkerVersusQuestGridCtrl:OnDestroy()
end

function TrekkerVersusQuestGridCtrl:OnRelease()
end

function TrekkerVersusQuestGridCtrl:Refresh(mapQuestData, actData, nActId)
  self.nActId = nActId
  self._mapActData = actData
  self.mapQuestData = mapQuestData
  local sHeatReachText = ConfigTable.GetUIText("TD_DuelHeatReach")
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, sHeatReachText .. "<space=9>" .. mapQuestData.TargetValue)
  local nStatus = 0
  local nCurHeat = self._mapActData:GetCurHeatValue().nSelfHotValue
  if nCurHeat >= mapQuestData.TargetValue then
    nStatus = 1
  end
  local tbHeatRewardIds = self._mapActData:GetHotValueRewardTable()
  for k, v in pairs(tbHeatRewardIds) do
    if v == mapQuestData.Id then
      nStatus = 2
      break
    end
  end
  self._mapNode.btnReceive.gameObject:SetActive(nStatus == 1)
  self._mapNode.btnJump.gameObject:SetActive(nStatus == 0)
  self._mapNode.TMPIncomplete.gameObject:SetActive(nStatus == 0)
  self._mapNode.imgComplete:SetActive(nStatus == 2)
  self._mapNode.maskComplete:SetActive(nStatus == 2)
  for i = 1, 3 do
    local sFieldName1 = "ItemId" .. i
    local sFieldName2 = "ItemQty" .. i
    local nItemTid = mapQuestData[sFieldName1]
    local nCount = mapQuestData[sFieldName2]
    if 0 < nItemTid then
      self._mapNode.btnItem[i].gameObject:SetActive(true)
      self._mapNode.item[i]:SetItem(nItemTid, nil, nCount, nil, nStatus == 2, nil, nil, true)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
end

function TrekkerVersusQuestGridCtrl:OnBtnClick_Item(btn, nIdx)
  local sFieldName1 = "ItemId" .. nIdx
  local sFieldName2 = "ItemQty" .. nIdx
  local nItemTid = self.mapQuestData[sFieldName1]
  local nCount = self.mapQuestData[sFieldName2]
  UTILS.ClickItemGridWithTips(nItemTid, btn.transform, true, true, false)
end

function TrekkerVersusQuestGridCtrl:OnBtnClick_JumpTo(btn)
  EventManager.Hit("TrekkerVersusHeatQuestJump", 1)
end

function TrekkerVersusQuestGridCtrl:OnBtnClick_Receive()
  EventManager.Hit("TrekkerVersusReceiveHeatQuest", self.nActId, 1)
end

return TrekkerVersusQuestGridCtrl
