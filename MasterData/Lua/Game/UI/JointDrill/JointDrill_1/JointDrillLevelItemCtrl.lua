local JointDrillLevelItemCtrl = class("JointDrillLevelItemCtrl", BaseCtrl)
local ClientManager = CS.ClientManager.Instance
JointDrillLevelItemCtrl._mapNodeConfig = {
  btnGrid = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  imgLevelBg = {sComponentName = "Image"},
  txtDifficulty = {sComponentName = "TMP_Text"},
  imgSimulate = {},
  txtSimulate = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Btn_Start_Challenge_Simulate"
  },
  imgChallengeTime = {},
  txtChallengeTime = {sComponentName = "TMP_Text"},
  goBossInfo = {},
  imgBossHpBg = {
    sComponentName = "RectTransform"
  },
  imgBossHp = {sComponentName = "Image"},
  txtBossHp = {sComponentName = "TMP_Text"},
  imgTimeout = {},
  txtTimeout = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Challenge_TimeOut"
  },
  imgMaskInBattle = {},
  txtInBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Challenge_OnGoing"
  },
  imgMaskLock = {},
  txtLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "JointDrill_Level_Lock"
  },
  imgTagBg = {},
  txtTag = {sComponentName = "TMP_Text"}
}
JointDrillLevelItemCtrl._mapEventConfig = {}
JointDrillLevelItemCtrl._mapRedDotConfig = {}

function JointDrillLevelItemCtrl:SetItem(mapLevelCfg)
  self.nLevelId = mapLevelCfg.Id
  self.nCurLevelId = PlayerData.JointDrill_1:GetJointDrillLevelId()
  self.bInBattle = PlayerData.JointDrill_1:CheckJointDrillInBattle()
  self.bCurBattle = self.nCurLevelId == mapLevelCfg.Id
  if self.bCurBattle and self.bInBattle then
    self:SetPngSprite(self._mapNode.imgLevelBg, mapLevelCfg.LevelImageGoing)
    local mapBossInfo = PlayerData.JointDrill_1:GetJointDrillBossInfo()
    NovaAPI.SetTMPText(self._mapNode.txtBossHp, string.format("%s/%s", self:ThousandsNumber(mapBossInfo.nHp), self:ThousandsNumber(mapBossInfo.nHpMax)))
    NovaAPI.SetImageFillAmount(self._mapNode.imgBossHp, mapBossInfo.nHp / mapBossInfo.nHpMax)
    local bSimulate = PlayerData.JointDrill_1:GetBattleSimulate()
    self._mapNode.imgSimulate.gameObject:SetActive(bSimulate)
    local nStartTime = PlayerData.JointDrill_1:GetJointDrillStartTime()
    local nEndTime = nStartTime + ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max")
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    self._mapNode.imgTimeout.gameObject:SetActive(nEndTime <= nCurTime)
    if nEndTime > nCurTime then
      self:RefreshChallengeTime()
    end
  else
    self:SetPngSprite(self._mapNode.imgLevelBg, mapLevelCfg.LevelImage)
  end
  local nDiff = mapLevelCfg.Difficulty
  NovaAPI.SetTMPText(self._mapNode.txtDifficulty, ConfigTable.GetUIText("JointDrill_Difficulty_Name_" .. nDiff))
  self.bUnlock = PlayerData.JointDrill_1:IsJointDrillUnlock(self.nLevelId)
  self._mapNode.imgMaskLock.gameObject:SetActive(not self.bUnlock)
  self._mapNode.imgMaskInBattle.gameObject:SetActive(self.bUnlock and self.bInBattle and not self.bCurBattle)
  self._mapNode.imgTagBg.gameObject:SetActive(mapLevelCfg.SubName ~= "")
  NovaAPI.SetTMPText(self._mapNode.txtTag, mapLevelCfg.SubName)
end

function JointDrillLevelItemCtrl:RefreshChallengeTime()
  local nStartTime = PlayerData.JointDrill_1:GetJointDrillStartTime()
  local nCloseTime = math.floor(nStartTime + ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max"))
  
  local function refreshTime()
    local nCurTime = ClientManager.serverTimeStamp
    local nRemainTime = nCloseTime - nCurTime
    if nRemainTime <= 0 then
      nRemainTime = 0
      if self.timeTimer ~= nil then
        self.timeTimer:Cancel()
        self.timeTimer = nil
      end
      self._mapNode.imgChallengeTime.gameObject:SetActive(false)
      self._mapNode.imgTimeout.gameObject:SetActive(true)
    end
    local tbTime = timeFormat_Table(nRemainTime)
    local sTime = ""
    if 0 < tbTime.min then
      sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_3"), tbTime.min, tbTime.sec)
    else
      sTime = orderedFormat(ConfigTable.GetUIText("JointDrill_Challenge_Time_4"), tbTime.sec)
    end
    NovaAPI.SetTMPText(self._mapNode.txtChallengeTime, sTime)
  end
  
  refreshTime()
  if self.timeTimer == nil then
    self.timeTimer = self:AddTimer(0, 1, refreshTime, true, true, true)
  end
end

function JointDrillLevelItemCtrl:Awake()
end

function JointDrillLevelItemCtrl:OnEnable()
end

function JointDrillLevelItemCtrl:OnDisable()
  if self.timeTimer ~= nil then
    self.timeTimer:Cancel()
    self.timeTimer = nil
  end
end

function JointDrillLevelItemCtrl:OnDestroy()
end

function JointDrillLevelItemCtrl:OnBtnClick_Item()
  if not self.bUnlock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_Lock_Tip"))
    return
  end
  if not self.bCurBattle and self.bInBattle then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("JointDrill_InBattle_Tip"))
    return
  end
  if self.bInBattle and self.bCurBattle then
    local nStartTime = PlayerData.JointDrill_1:GetJointDrillStartTime()
    local nCloseTime = math.floor(nStartTime + ConfigTable.GetConfigNumber("JointDrill_Challenge_Time_Max"))
    local nCurTime = ClientManager.serverTimeStamp
    if nCloseTime <= nCurTime then
      local function callback()
        if PlayerData.JointDrill_1:CheckJointDrillInBattle() then
          PlayerData.JointDrill_1:JointDrillGameOver(nil, true)
        else
          EventManager.Hit("RefreshJointDrillLevel")
        end
      end
      
      PlayerData.Activity:SendActivityDetailMsg(callback, true)
      return
    end
  end
  EventManager.Hit("SelectJointDrillLevel", self.nLevelId)
end

return JointDrillLevelItemCtrl
