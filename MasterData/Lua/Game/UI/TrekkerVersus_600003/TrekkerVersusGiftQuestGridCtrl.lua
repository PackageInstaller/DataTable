local TrekkerVersusGiftQuestGridCtrl = class("TrekkerVersusGiftQuestGridCtrl", BaseCtrl)
TrekkerVersusGiftQuestGridCtrl._mapNodeConfig = {
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
TrekkerVersusGiftQuestGridCtrl._mapEventConfig = {}
TrekkerVersusGiftQuestGridCtrl._mapRedDotConfig = {}

function TrekkerVersusGiftQuestGridCtrl:Awake()
end

function TrekkerVersusGiftQuestGridCtrl:FadeIn()
end

function TrekkerVersusGiftQuestGridCtrl:FadeOut()
end

function TrekkerVersusGiftQuestGridCtrl:OnEnable()
end

function TrekkerVersusGiftQuestGridCtrl:OnDisable()
end

function TrekkerVersusGiftQuestGridCtrl:OnDestroy()
end

function TrekkerVersusGiftQuestGridCtrl:OnRelease()
end

function TrekkerVersusGiftQuestGridCtrl:Refresh(mapQuestData, actData, nActId)
  self._mapActData = actData
  self.nActId = nActId
  local mapQuestCfgData = ConfigTable.GetData("TravelerDuelChallengeQuest", mapQuestData.Id)
  if mapQuestCfgData == nil then
    return
  end
  self.cfgData = mapQuestCfgData
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, mapQuestCfgData.Title)
  self._mapNode.btnReceive.gameObject:SetActive(mapQuestData.Status == 1)
  self._mapNode.btnJump.gameObject:SetActive(mapQuestData.Status == 0 and 0 < #self.cfgData.AffixJumpTo)
  self._mapNode.TMPIncomplete.gameObject:SetActive(mapQuestData.Status == 0)
  self._mapNode.imgComplete:SetActive(mapQuestData.Status == 2)
  self._mapNode.maskComplete:SetActive(mapQuestData.Status == 2)
  for i = 1, 3 do
    local sFieldName1 = "AwardItemTid" .. i
    local sFieldName2 = "AwardItemNum" .. i
    local nItemTid = mapQuestCfgData[sFieldName1]
    local nCount = mapQuestCfgData[sFieldName2]
    if 0 < nItemTid then
      self._mapNode.btnItem[i].gameObject:SetActive(true)
      self._mapNode.item[i]:SetItem(nItemTid, nil, nCount, nil, mapQuestData.Status == 2, nil, nil, true)
    else
      self._mapNode.btnItem[i].gameObject:SetActive(false)
    end
  end
end

function TrekkerVersusGiftQuestGridCtrl:OnBtnClick_Item(btn, nIdx)
  local sFieldName1 = "AwardItemTid" .. nIdx
  local sFieldName2 = "AwardItemNum" .. nIdx
  local nItemTid = self.cfgData[sFieldName1]
  local nCount = self.cfgData[sFieldName2]
  UTILS.ClickItemGridWithTips(nItemTid, btn.transform, true, true, false)
end

function TrekkerVersusGiftQuestGridCtrl:OnBtnClick_JumpTo(btn)
  EventManager.Hit("TrekkerVersusAffixJump", self.cfgData.AffixJumpTo)
end

function TrekkerVersusGiftQuestGridCtrl:OnBtnClick_Receive()
  self._mapActData:ReceiveQuestReward(self.nActId)
end

return TrekkerVersusGiftQuestGridCtrl
