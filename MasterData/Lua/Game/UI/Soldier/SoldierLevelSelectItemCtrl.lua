local SoldierLevelSelectItemCtrl = class("SoldierLevelSelectItemCtrl", BaseCtrl)
SoldierLevelSelectItemCtrl._mapNodeConfig = {
  rtTag = {},
  txt_Title = {sComponentName = "TMP_Text"},
  txt_DifficultNum = {sComponentName = "TMP_Text"},
  txt_Difficult = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_LevelSelect_Difficulty"
  },
  txt_LvNumLockPreview = {sComponentName = "TMP_Text"},
  txt_LvNumLock = {sComponentName = "TMP_Text"},
  txt_LvNum = {sComponentName = "TMP_Text"},
  txtLvCount = {sComponentName = "TMP_Text"},
  txt_Desc = {nCount = 2, sComponentName = "TMP_Text"},
  btn_Search = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Search"
  },
  rtLockSelect = {},
  rtLockPreview = {},
  imgDescZs = {nCount = 2},
  imgDescLock = {nCount = 2},
  rtDetailList = {
    sComponentName = "RectTransform"
  },
  PickMask = {}
}

function SoldierLevelSelectItemCtrl:SetData(mapData, bUnlock)
  local nCurExp = PlayerData.SoldierData:GetChallengeExp()
  self.nId = mapData.Id
  local mapKeyGrade = ConfigTable.GetData("SoldierKeyGrade", mapData.KeyGradeId)
  if mapKeyGrade ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txt_Title, mapKeyGrade.Name)
  end
  self._mapNode.rtLockSelect.gameObject:SetActive(true)
  self._mapNode.rtLockPreview.gameObject:SetActive(not bUnlock)
  for i = 1, #self._mapNode.imgDescZs do
    self._mapNode.imgDescZs[i].gameObject:SetActive(bUnlock)
    self._mapNode.imgDescLock[i].gameObject:SetActive(not bUnlock)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_LvNum, mapData.Name)
  NovaAPI.SetTMPText(self._mapNode.txt_LvNumLockPreview, mapData.Name)
  NovaAPI.SetTMPText(self._mapNode.txt_LvNumLock, mapData.Name)
  self._mapNode.txtLvCount.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtLvCount, nCurExp .. "/" .. mapData.GradeScore)
  local nHighestChallengeId = PlayerData.SoldierData:GetHighestChallengeId()
  if nHighestChallengeId ~= mapData.Id then
    self._mapNode.txtLvCount.gameObject:SetActive(false)
  else
    self._mapNode.txtLvCount.gameObject:SetActive(true)
    if nCurExp > mapData.GradeScore then
      nCurExp = mapData.GradeScore
    end
    NovaAPI.SetTMPText(self._mapNode.txtLvCount, nCurExp .. "/" .. mapData.GradeScore)
  end
  NovaAPI.SetTMPText(self._mapNode.txt_DifficultNum, mapData.OppoLevelShow)
  local sText = orderedFormat(ConfigTable.GetUIText("Soldier_LevelSelect_InitialHp"), mapData.InitialHp)
  NovaAPI.SetTMPText(self._mapNode.txt_Desc[1], sText)
  local sOppoAttrAddShow = math.floor(tonumber(mapData.OppoAttrAddShow) * 100) .. "%"
  sText = orderedFormat(ConfigTable.GetUIText("Soldier_LevelSelect_OppoAttrAddShow"), sOppoAttrAddShow)
  NovaAPI.SetTMPText(self._mapNode.txt_Desc[2], sText)
  self._mapNode.btn_Search.gameObject:SetActive(false)
  self._mapNode.PickMask.gameObject:SetActive(false)
  self.animRoot = self.gameObject:GetComponent("Animator")
end

function SoldierLevelSelectItemCtrl:SetSelect(bSelect)
  self._mapNode.rtLockSelect.gameObject:SetActive(not bSelect)
  self._mapNode.rtTag.gameObject:SetActive(bSelect)
  if bSelect then
    self.animRoot:Play("SoldierLevelSelectPick", 0, 0)
    self._mapNode.PickMask.gameObject:SetActive(true)
    local nAnimTime = NovaAPI.GetAnimClipLength(self.animRoot, {
      "SoldierLevelSelectPick"
    })
    self:AddTimer(1, nAnimTime, function()
      self._mapNode.PickMask.gameObject:SetActive(false)
    end, true, true, true)
  end
end

function SoldierLevelSelectItemCtrl:GetChallengeId()
  return self.nId
end

function SoldierLevelSelectItemCtrl:OnBtnClick_Search()
end

return SoldierLevelSelectItemCtrl
