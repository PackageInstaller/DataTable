local nProgress1Length = 256
local nProgress2Length = 243
local nProgress3Length = 265
local SoldierLevelNodeItemCtrl = class("SoldierLevelNodeItemCtrl", BaseCtrl)
SoldierLevelNodeItemCtrl._mapNodeConfig = {
  imgActProgressBg = {nCount = 3},
  rtActProgressFill = {
    nCount = 3,
    sComponentName = "RectTransform"
  },
  imgStarNode = {},
  txtTimeTips = {sComponentName = "TMP_Text"},
  txtTimeTipsTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_RewardLevel_TimeTipsTitle"
  },
  goNodeItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnNodeItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_NodeItem"
  },
  imgOkay = {},
  txtOkay = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_RewardLevel_Okay"
  },
  txtNmlValue = {sComponentName = "TMP_Text"},
  txtNmlspecial = {sComponentName = "TMP_Text"},
  imgMultiSelected1 = {},
  imgMultiSelected2 = {},
  imgMultiSelected3 = {}
}
SoldierLevelNodeItemCtrl._mapEventConfig = {}
SoldierLevelNodeItemCtrl._mapRedDotConfig = {}

function SoldierLevelNodeItemCtrl:SetNode(mapData, nNodeIndex, nTotalCount, nType, nActProgress)
  self.mapData = mapData
  self.nNodeIndex = nNodeIndex
  self.nTotalCount = nTotalCount
  self.nType = nType
  for i = 1, 3 do
    self._mapNode.imgActProgressBg[i].gameObject:SetActive(false)
    self._mapNode.rtActProgressFill[i].gameObject:SetActive(false)
  end
  if nNodeIndex == 1 then
    self._mapNode.imgActProgressBg[1].gameObject:SetActive(true)
    self._mapNode.rtActProgressFill[1].gameObject:SetActive(true)
    self.nProgressLength = nProgress1Length
    self.progressFill = self._mapNode.rtActProgressFill[1]
  elseif nNodeIndex == nTotalCount then
    self._mapNode.imgActProgressBg[3].gameObject:SetActive(true)
    self._mapNode.rtActProgressFill[3].gameObject:SetActive(true)
    self.nProgressLength = nProgress3Length
    self.progressFill = self._mapNode.rtActProgressFill[3]
  else
    self._mapNode.imgActProgressBg[2].gameObject:SetActive(true)
    self._mapNode.rtActProgressFill[2].gameObject:SetActive(true)
    self.nProgressLength = nProgress2Length
    self.progressFill = self._mapNode.rtActProgressFill[2]
  end
  self._mapNode.btnNodeItem.gameObject:SetActive(nNodeIndex ~= nTotalCount)
  self._mapNode.txtTimeTipsTitle.gameObject:SetActive(nNodeIndex == nTotalCount)
  local progressFill = self.progressFill.transform:Find("imgActProgress"):GetComponent("RectTransform")
  if nNodeIndex < nTotalCount then
    progressFill.anchoredPosition = Vector2(-((1.0 - nActProgress) * self.nProgressLength), progressFill.anchoredPosition.y)
    self._mapNode.imgStarNode:SetActive(1 <= nActProgress)
    self._mapNode.goNodeItem:SetItem(self.mapData.RewardId, nil, self.mapData.RewardQty, nil, nType == 1)
    self._mapNode.imgOkay:SetActive(nType == 2)
    self._mapNode.txtNmlValue.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtNmlValue, self.mapData.Level)
    self._mapNode.txtNmlspecial.gameObject:SetActive(self.mapData.KeyReward)
    NovaAPI.SetTMPText(self._mapNode.txtNmlspecial, self.mapData.Level)
    self._mapNode.imgMultiSelected3:SetActive(self.mapData.KeyReward)
  else
    progressFill.anchoredPosition = Vector2(-((1.0 - nActProgress) * self.nProgressLength), progressFill.anchoredPosition.y)
    self._mapNode.txtNmlValue.gameObject:SetActive(false)
    self._mapNode.imgStarNode:SetActive(1 <= nActProgress)
  end
  self._mapNode.imgMultiSelected1:SetActive(nType == 2)
end

function SoldierLevelNodeItemCtrl:OnBtnClick_NodeItem()
  if self.nType == 2 then
    PlayerData.SoldierData:RequestGetTotalReward()
  else
    UTILS.ClickItemGridWithTips(self.mapData.RewardId, self._mapNode.btnNodeItem.transform, true, true, false)
  end
end

return SoldierLevelNodeItemCtrl
