local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local CommonMonsterWarningCtrl = class("CommonMonsterWarningCtrl", BaseCtrl)
CommonMonsterWarningCtrl._mapNodeConfig = {
  HighThreat = {},
  texHighThreat = {
    sComponentName = "TMP_Text",
    sLanguageId = "CommonMonsterWarning_HighThreat"
  },
  Boss = {},
  texBoss = {
    sComponentName = "TMP_Text",
    sLanguageId = "CommonMonsterWarning_Boss"
  },
  Elite = {},
  texElite = {
    sComponentName = "TMP_Text",
    sLanguageId = "CommonMonsterWarning_Elite"
  },
  TravelTeam = {},
  texTravelTeam = {
    sComponentName = "TMP_Text",
    sLanguageId = "CommonMonsterWarning_TravelTeam"
  }
}
CommonMonsterWarningCtrl._mapEventConfig = {
  Show_HighThreat_Warning = "ShowHighThreat",
  Show_Survivor_Warning = "ShowSurvivorWarning"
}

function CommonMonsterWarningCtrl:Awake()
  self:SetObjDeactive()
end

function CommonMonsterWarningCtrl:ShowHighThreat()
  self._mapNode.HighThreat:SetActive(true)
  WwiseAudioMgr:PlaySound("ui_bossRank_warning_lv3")
  EventManager.Hit("RegionBoss_CloseTime")
  
  local function waitCallback()
    self:SetObjDeactive()
    EventManager.Hit("RegionBoss_StartTime")
    WwiseAudioMgr:PlaySound("ui_bossRank_warning_stop")
  end
  
  self:AddTimer(1, 4, waitCallback, true, true, true, nil)
end

function CommonMonsterWarningCtrl:ShowSurvivorWarning(index)
  if index == 1 then
    self._mapNode.Boss:SetActive(true)
    WwiseAudioMgr:PlaySound("ui_vampire_warning_lv3")
  elseif index == 2 then
    self._mapNode.Elite:SetActive(true)
    WwiseAudioMgr:PlaySound("ui_vampire_warning_lv2")
  elseif index < 0 then
    self._mapNode.TravelTeam:SetActive(true)
    WwiseAudioMgr:PlaySound("ui_vampire_warning_lv1")
  end
  
  local function waitCallback()
    self:SetObjDeactive()
    WwiseAudioMgr:PlaySound("ui_vampire_warning_stop")
  end
  
  self:AddTimer(1, 4, waitCallback, true, true, true, nil)
end

function CommonMonsterWarningCtrl:SetObjDeactive()
  self._mapNode.HighThreat:SetActive(false)
  self._mapNode.Boss:SetActive(false)
  self._mapNode.Elite:SetActive(false)
  self._mapNode.TravelTeam:SetActive(false)
end

return CommonMonsterWarningCtrl
