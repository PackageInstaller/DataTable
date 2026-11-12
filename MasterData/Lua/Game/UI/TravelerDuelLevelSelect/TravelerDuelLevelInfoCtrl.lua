local TravelerDuelLevelInfoCtrl = class("TravelerDuelLevelInfoCtrl", BaseCtrl)
local nFullLength = 514
TravelerDuelLevelInfoCtrl._mapNodeConfig = {
  TMPDuelLevelInfo = {sComponentName = "TMP_Text"},
  TMPDuelExpInfo = {sComponentName = "TMP_Text"},
  imgExpBarFillMaskInfo = {
    sComponentName = "RectTransform"
  },
  TMPAddInfo = {sComponentName = "TMP_Text"},
  svLevelInfo = {
    sComponentName = "LoopScrollView"
  },
  btnCloseLevelInfoScreen = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  },
  btnCloseLevelInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtTitleCurLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_TitleCurLevel"
  },
  txtTitletxtTitleCurExp = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_LevelExp"
  },
  txtTitleCoinAdd = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_TitleCurCoinAdd"
  }
}
TravelerDuelLevelInfoCtrl._mapEventConfig = {}

function TravelerDuelLevelInfoCtrl:Awake()
end

function TravelerDuelLevelInfoCtrl:FadeIn()
end

function TravelerDuelLevelInfoCtrl:FadeOut()
end

function TravelerDuelLevelInfoCtrl:OnEnable()
  self.tbLevelInfo = {}
  
  local function ForEachLevel(mapData)
    table.insert(self.tbLevelInfo, mapData)
  end
  
  ForEachTableLine(DataTable.TravelerDuelLevel, ForEachLevel)
  
  local function Sort(a, b)
    return a.Id < b.Id
  end
  
  table.sort(self.tbLevelInfo, Sort)
  self.nDuelLevel, self.nDuelExp = PlayerData.TravelerDuel:GetTravelerDuelLevel()
  local mapExp = ConfigTable.GetData("TravelerDuelLevel", self.nDuelLevel + 1)
  self.nTotalExp = 0
  if mapExp ~= nil then
    self.nTotalExp = mapExp.LevelUpExp
  end
  NovaAPI.SetTMPText(self._mapNode.TMPDuelLevelInfo, self.nDuelLevel)
  NovaAPI.SetTMPText(self._mapNode.TMPAddInfo, string.format("%d%%", self.tbLevelInfo[self.nDuelLevel].CoinAdditionProb))
  NovaAPI.SetTMPText(self._mapNode.TMPDuelExpInfo, string.format("<size=37><color=#3b62ae>%d</color></size>/%d", self.nDuelExp, self.nTotalExp))
  if self.nTotalExp > 0 then
    NovaAPI.SetTMPText(self._mapNode.TMPDuelExpInfo, string.format("<size=37><color=#3b62ae>%d</color></size>/%d", self.nDuelExp, self.nTotalExp))
    self._mapNode.imgExpBarFillMaskInfo.sizeDelta = Vector2(nFullLength * (self.nDuelExp / self.nTotalExp), self._mapNode.imgExpBarFillMaskInfo.sizeDelta.y)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPDuelExpInfo, "Max")
    self._mapNode.imgExpBarFillMaskInfo.sizeDelta = Vector2(nFullLength, self._mapNode.imgExpBarFillMaskInfo.sizeDelta.y)
  end
  self.gameObject:SetActive(false)
end

function TravelerDuelLevelInfoCtrl:OnDisable()
end

function TravelerDuelLevelInfoCtrl:OnDestroy()
end

function TravelerDuelLevelInfoCtrl:OnRelease()
end

function TravelerDuelLevelInfoCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIdx = gridIndex + 1
  local tmpLevel = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/TMPLevel"):GetComponent("TMP_Text")
  local TMPLevelAdd = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/TMPLevelAdd"):GetComponent("TMP_Text")
  local imgLevelBgCur = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/imgLevelBgCur").gameObject
  local imgLevelBgCurBg = goGrid.transform:Find("btnGrid/AnimRoot/imgLevelBgCur").gameObject
  local TMPLevelTitle = goGrid.transform:Find("btnGrid/AnimRoot/imgBg/TMPLevelTitle"):GetComponent("TMP_Text")
  local mapLevel = self.tbLevelInfo[nIdx]
  NovaAPI.SetTMPText(tmpLevel, mapLevel.Id)
  NovaAPI.SetTMPText(TMPLevelTitle, ConfigTable.GetUIText("TD_LevelTitle"))
  NovaAPI.SetTMPText(TMPLevelAdd, mapLevel.CoinAdditionProb .. "%")
  imgLevelBgCur:SetActive(mapLevel.Id == self.nDuelLevel)
  imgLevelBgCurBg:SetActive(mapLevel.Id == self.nDuelLevel)
end

function TravelerDuelLevelInfoCtrl:Show()
  self.gameObject:SetActive(true)
  self._mapNode.svLevelInfo:Init(#self.tbLevelInfo, self, self.OnGridRefresh)
end

function TravelerDuelLevelInfoCtrl:OnBtnClick_Close()
  self.gameObject:SetActive(false)
end

return TravelerDuelLevelInfoCtrl
