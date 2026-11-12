local CookieScoreBoardCtrl = class("CookieScoreBoardCtrl", BaseCtrl)
CookieScoreBoardCtrl._mapNodeConfig = {
  imgModeIcon = {sComponentName = "Image"},
  txtTotalScore = {sComponentName = "TMP_Text"},
  txtScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Score_Title"
  },
  imgNew = {},
  txtCookieCountRes = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Cookie_Count_Score"
  },
  txtCookieCountResNum = {sComponentName = "TMP_Text"},
  txtBoxCountRes = {
    sComponentName = "TMP_Text",
    sLanguageId = "Cookie_Act_Box_Count_Score"
  },
  txtBoxCountResNum = {sComponentName = "TMP_Text"},
  txtCriticalPerfectCountNum = {sComponentName = "TMP_Text"},
  txtPerfectCountNum = {sComponentName = "TMP_Text"},
  txtGoodCountNum = {sComponentName = "TMP_Text"},
  txtMissCountNum = {sComponentName = "TMP_Text"},
  imgFullCombo = {},
  imgAllPerfect = {}
}

function CookieScoreBoardCtrl:Init(nMode, nTotalScore, nCookieCount, nBoxCount, nCriticalPerfectCount, nPerfectCount, nGoodCount, nMissCount, bIsNewRecord, bFullCombo, bAllPerfect, nActId)
  local sIconPath = "UI_Activity/_" .. tostring(nActId or 0)
  self:SetPngSprite(self._mapNode.imgModeIcon, sIconPath .. (AllEnum.CookieModeIcon[nMode] or AllEnum.CookieModeIcon[3]))
  NovaAPI.SetTMPText(self._mapNode.txtTotalScore, tostring(nTotalScore or 0))
  NovaAPI.SetTMPText(self._mapNode.txtCookieCountResNum, tostring(nCookieCount or 0))
  NovaAPI.SetTMPText(self._mapNode.txtBoxCountResNum, tostring(nBoxCount or 0))
  NovaAPI.SetTMPText(self._mapNode.txtCriticalPerfectCountNum, tostring(nCriticalPerfectCount or 0))
  NovaAPI.SetTMPText(self._mapNode.txtPerfectCountNum, "x" .. tostring(nPerfectCount or 0))
  NovaAPI.SetTMPText(self._mapNode.txtGoodCountNum, "x" .. tostring(nGoodCount or 0))
  NovaAPI.SetTMPText(self._mapNode.txtMissCountNum, "x" .. tostring(nMissCount or 0))
  self._mapNode.imgFullCombo:SetActive(bFullCombo == true and bAllPerfect == false and 0 < nCookieCount)
  self._mapNode.imgAllPerfect:SetActive(bAllPerfect == true and bFullCombo == true and 0 < nCookieCount)
  self._mapNode.imgNew:SetActive(bIsNewRecord == true)
end

return CookieScoreBoardCtrl
