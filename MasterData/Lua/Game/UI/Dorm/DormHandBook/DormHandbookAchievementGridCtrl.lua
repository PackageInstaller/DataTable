local DormHandbookAchievementGridCtrl = class("DormHandbookAchievementGridCtrl", BaseCtrl)
local nTotalLength = 411
local ntotalHeight = 37
DormHandbookAchievementGridCtrl._mapNodeConfig = {
  imgSelect = {},
  imgIcon = {sNodeName = "imgIconCup", sComponentName = "Image"},
  TMPTitle = {sComponentName = "TMP_Text"},
  TMPDesc = {sComponentName = "TMP_Text"},
  TMPDate = {sComponentName = "TMP_Text"},
  txtProgress = {sComponentName = "TMP_Text"},
  rtProgressFill = {
    sComponentName = "RectTransform"
  },
  Item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 3
  },
  btnItem = {
    sNodeName = "btnItem",
    sComponentName = "UIButton",
    nCount = 3,
    callback = "OnBtnClick_Item"
  },
  goRed = {}
}
DormHandbookAchievementGridCtrl._mapEventConfig = {}
DormHandbookAchievementGridCtrl._mapRedDotConfig = {}

function DormHandbookAchievementGridCtrl:Awake()
end

function DormHandbookAchievementGridCtrl:FadeIn()
end

function DormHandbookAchievementGridCtrl:FadeOut()
end

function DormHandbookAchievementGridCtrl:OnEnable()
end

function DormHandbookAchievementGridCtrl:OnDisable()
end

function DormHandbookAchievementGridCtrl:OnDestroy()
end

function DormHandbookAchievementGridCtrl:OnRelease()
end

function DormHandbookAchievementGridCtrl:Refresh(nAchievementId, bReceived, nTotal)
  local mapAchievementCfgData = ConfigTable.GetData("DormAchievement", nAchievementId)
  if mapAchievementCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.mapAchievementCfg = mapAchievementCfgData
  local nTime = PlayerData.PlayerDormData:GetDormAchievementCompleteTime(nAchievementId)
  if 0 < nTime then
    self._mapNode.TMPDate.gameObject:SetActive(true)
    local sTime = os.date("%Y/%m/%d", nTime)
    NovaAPI.SetTMPText(self._mapNode.TMPDate, sTime)
  else
    self._mapNode.TMPDate.gameObject:SetActive(false)
  end
  self.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, mapAchievementCfgData.Title)
  NovaAPI.SetTMPText(self._mapNode.TMPDesc, mapAchievementCfgData.Desc)
  self:SetPngSprite(self._mapNode.imgIcon, mapAchievementCfgData.Icon)
  local nGoal = mapAchievementCfgData.CompleteParams[1]
  if nGoal == nil then
    nGoal = 1
  end
  local nShowCur = nTotal >= nGoal and nGoal or nTotal
  if bReceived then
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("Quest_Complete"))
    self._mapNode.rtProgressFill.sizeDelta = Vector2(nTotalLength, ntotalHeight)
  else
    self._mapNode.rtProgressFill.sizeDelta = Vector2(nShowCur / nGoal * nTotalLength, ntotalHeight)
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", nShowCur, nGoal))
  end
  self.bCanReceive = nTotal >= nGoal and not bReceived
  self._mapNode.imgSelect:SetActive(self.bCanReceive)
  self._mapNode.goRed:SetActive(self.bCanReceive)
  for i = 1, 3 do
    local nTid = mapAchievementCfgData["Tid" .. i]
    local nQty = mapAchievementCfgData["Qty" .. i]
    self._mapNode.Item[i].gameObject:SetActive(nTid ~= nil and 0 < nTid)
    if nTid ~= nil and 0 < nTid then
      self._mapNode.Item[i]:SetItem(nTid, nil, nQty, nil, bReceived)
    end
  end
end

function DormHandbookAchievementGridCtrl:OnBtnClick_Item(btn, nIdx)
  local nTid = self.mapAchievementCfg["Tid" .. nIdx]
  UTILS.ClickItemGridWithTips(nTid, self._mapNode.Item[nIdx].gameObject, true, false, false)
end

return DormHandbookAchievementGridCtrl
