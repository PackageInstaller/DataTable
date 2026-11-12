local TDCoverCtrl = class("TDCoverCtrl", BaseCtrl)
TDCoverCtrl._mapNodeConfig = {
  TMPOpenTime = {sComponentName = "TMP_Text"},
  btnChallenge = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Challenge"
  },
  btnChallengeOff = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChallengeOff"
  },
  txtBtnChallenge = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "TD_Btn_Challenge"
  },
  txtLockDesc = {sComponentName = "TMP_Text"},
  imgPreview = {},
  txtPreview = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_Cover_Preview"
  }
}
TDCoverCtrl._mapEventConfig = {
  TDLevelSelectIn = "OnEvent_PlayIn",
  TDLevelSelectOut = "OnEvent_PlayOut"
}

function TDCoverCtrl:Refresh(mapChallenge, nLevelId, funcChallenge, bPreview)
  self.funcChallenge = funcChallenge
  local bUnlockLevel, sLock = PlayerData.TravelerDuel:GetTravelerChallengeUnlock()
  local bUnlock = bUnlockLevel and mapChallenge.bUnlock
  if bPreview then
    self._mapNode.btnChallenge.gameObject:SetActive(false)
    self._mapNode.btnChallengeOff.gameObject:SetActive(false)
    self._mapNode.TMPOpenTime.gameObject:SetActive(false)
    self._mapNode.imgPreview:SetActive(true)
  else
    self._mapNode.btnChallenge.gameObject:SetActive(bUnlock)
    self._mapNode.btnChallengeOff.gameObject:SetActive(not bUnlock)
    self._mapNode.TMPOpenTime.gameObject:SetActive(true)
    self._mapNode.imgPreview:SetActive(false)
    if not bUnlock then
      local nPreLevel = ConfigTable.GetData("TravelerDuelBossLevel", nLevelId).PreLevelId
      local mapPreCfg = ConfigTable.GetData("TravelerDuelBossLevel", nPreLevel)
      local bPreLevelSuc = true
      if nPreLevel ~= 0 then
        local nPreStar = PlayerData.TravelerDuel:GetTravelerDuelLevelStar(nPreLevel)
        bPreLevelSuc = 0 < nPreStar
      end
      if bPreLevelSuc == false then
        sLock = orderedFormat(ConfigTable.GetUIText("TD_Lock_PreNormal"), orderedFormat(ConfigTable.GetUIText("Dungeon_Difficulty") or "", mapPreCfg.Name, ConfigTable.GetUIText("Diffculty_" .. mapPreCfg.Difficulty) or ""))
      end
      NovaAPI.SetTMPText(self._mapNode.txtLockDesc, sLock)
    end
    local openYear, openMonth, openDay = self:GetDate(mapChallenge.nOpenTime)
    local closeYear, closeMonth, closeDay = self:GetDate(mapChallenge.nCloseTime)
    NovaAPI.SetTMPText(self._mapNode.TMPOpenTime, string.format("<color=#FFFFFF>%d.%d.%d-%d.%d.%d</color>", openYear, openMonth, openDay, closeYear, closeMonth, closeDay))
  end
end

function TDCoverCtrl:GetDate(nTs)
  local nServerTimeStampWithTimeZone = nTs + CS.ClientManager.Instance.serverTimeZone * 3600
  local nYear = tonumber(os.date("!%Y", nServerTimeStampWithTimeZone))
  local nMonth = tonumber(os.date("!%m", nServerTimeStampWithTimeZone))
  local nDay = tonumber(os.date("!%d", nServerTimeStampWithTimeZone))
  return nYear, nMonth, nDay
end

function TDCoverCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
end

function TDCoverCtrl:OnEnable()
end

function TDCoverCtrl:OnDisable()
end

function TDCoverCtrl:OnDestroy()
end

function TDCoverCtrl:OnBtnClick_Challenge()
  self.ani:Play("ChallengeInfo_in")
  if self.funcChallenge then
    self.funcChallenge()
  end
end

function TDCoverCtrl:OnBtnClick_ChallengeOff()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TD_ChallengeLock"))
end

function TDCoverCtrl:OnEvent_PlayIn(nType)
  if nType == 1 then
    self.ani:Play("TravelerDuelSelect_CoverRoot_in")
  else
    self.ani:Play("TravelerDuelSelect_CoverRoot_switch")
  end
end

function TDCoverCtrl:OnEvent_PlayOut()
  self.ani:Play("TravelerDuelInfo_CoverRoot_in")
end

return TDCoverCtrl
