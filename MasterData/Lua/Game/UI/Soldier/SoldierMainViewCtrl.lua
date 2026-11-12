local SoldierMainViewCtrl = class("SoldierMainViewCtrl", BaseCtrl)
local RedDotManager = require("GameCore.RedDot.RedDotManager")
local ClientManager = CS.ClientManager
local TimerManager = require("GameCore.Timer.TimerManager")
SoldierMainViewCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btn_Handbook = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Handbook"
  },
  txt_Handbook = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Handbook"
  },
  txt_HandbookNum = {sComponentName = "TMP_Text"},
  redDot_Handbook = {},
  redDot_Handbook_New = {},
  btn_Recommend = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Recommend"
  },
  txt_Recommend = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend"
  },
  btn_Level = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Level"
  },
  txt_Level = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Level"
  },
  txt_Lv = {sComponentName = "TMP_Text", sLanguageId = "Soldier_Lv"},
  txt_LevelNum = {sComponentName = "TMP_Text"},
  rtItemReward = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txt_NextReward = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_NextReward"
  },
  imgNextReward = {},
  imgItemEmpty = {},
  txt_Empty = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_NoNextReward"
  },
  redDot_Level = {},
  redDot_Level_New = {},
  btn_Tech = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Tech"
  },
  txt_Tech = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Tech"
  },
  txt_TechNum = {sComponentName = "TMP_Text"},
  redDot_TechNum = {},
  redDot_TechNum_New = {},
  btn_Notice = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Notice"
  },
  txt_Notice = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Notice"
  },
  redDot_Recommend = {},
  redDot_Recommend_New = {},
  btn_Go = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txt_Go = {sComponentName = "TMP_Text", sLanguageId = "Soldier_Go"},
  txtGoGrade = {sComponentName = "TMP_Text"},
  imgGoGrade = {sComponentName = "Image"},
  redDot_Go = {},
  redDot_Go_New = {},
  goBattleHint = {},
  TMPBattleLeave = {sComponentName = "TMP_Text"},
  grpDate = {},
  txtActivityDate = {sComponentName = "TMP_Text"},
  txtActivityTime = {sComponentName = "TMP_Text"}
}
SoldierMainViewCtrl._mapEventConfig = {
  [EventId.ClosePanel] = "OnEvent_ClosePanel",
  StoryDialog_DialogEnd = "OnEvent_StoryDialog_DialogEnd"
}
SoldierMainViewCtrl._mapRedDotConfig = {
  [RedDotDefine.Soldier_TotalReward] = {
    sNodeName = "redDot_Level"
  },
  [RedDotDefine.Soldier_TechNum] = {
    sNodeName = "redDot_TechNum"
  }
}

function SoldierMainViewCtrl:FadeIn()
end

function SoldierMainViewCtrl:Awake()
  self._mapNode.redDot_Handbook:SetActive(false)
  self._mapNode.redDot_Handbook_New:SetActive(false)
  self._mapNode.btn_Notice.gameObject:SetActive(false)
  self._mapNode.grpDate.gameObject:SetActive(false)
  self._mapNode.redDot_Recommend:SetActive(false)
  self._mapNode.redDot_Recommend_New:SetActive(false)
  self._mapNode.redDot_Go:SetActive(false)
  self._mapNode.redDot_Go_New:SetActive(false)
  self._mapNode.btn_Recommend.gameObject:SetActive(false)
  self._mapNode.btn_Level.gameObject:SetActive(false)
  self._mapNode.btn_Tech.gameObject:SetActive(false)
  self._mapNode.btn_Go.gameObject:SetActive(false)
  self._mapNode.btn_Notice.gameObject:SetActive(false)
  self._mapNode.btn_Handbook.gameObject:SetActive(false)
  EventManager.Hit(EventId.SetTransition)
end

function SoldierMainViewCtrl:OnEnable()
  PlayerData.SoldierData:RequestSoldierSeasonInfo(function()
    if self._mapNode ~= nil and self._mapNode.btn_Recommend ~= nil then
      self._mapNode.btn_Recommend.gameObject:SetActive(true)
      self._mapNode.btn_Level.gameObject:SetActive(true)
      self._mapNode.btn_Tech.gameObject:SetActive(true)
      self._mapNode.btn_Go.gameObject:SetActive(true)
      self._mapNode.btn_Handbook.gameObject:SetActive(true)
      self:OnRefreshSoldierSeasonInfo()
    end
  end)
  PlayerData.SoldierData:SendSoldierTechDetailReq(function()
    if self._mapNode ~= nil and self._mapNode.btn_Recommend ~= nil then
      self:RefreshTechnology()
    end
  end)
end

function SoldierMainViewCtrl:OnDisable()
  if self.remainTimer ~= nil then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
  end
end

function SoldierMainViewCtrl:OnRefreshSoldierSeasonInfo()
  self:RefreshTechnology()
  self.nCurChallengeId = PlayerData.SoldierData:GetHighestChallengeId()
  local mapChallengeData = ConfigTable.GetData("SoldierGradeChallenge", self.nCurChallengeId)
  if mapChallengeData ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtGoGrade, mapChallengeData.Name)
    self:SetPngSprite(self._mapNode.imgGoGrade, mapChallengeData.Icon)
  end
  local nTotalRewardLevel, nRewardExp, nNextLevelExp, mapNextLevelTotalReward = PlayerData.SoldierData:GetTotalRewardLevel()
  NovaAPI.SetTMPText(self._mapNode.txt_LevelNum, nTotalRewardLevel)
  if mapNextLevelTotalReward ~= nil then
    self._mapNode.rtItemReward.gameObject:SetActive(true)
    self._mapNode.imgItemEmpty.gameObject:SetActive(false)
    self._mapNode.rtItemReward:SetItem(mapNextLevelTotalReward.Tid, nil, mapNextLevelTotalReward.Qty)
  else
    self._mapNode.rtItemReward.gameObject:SetActive(false)
    self._mapNode.imgItemEmpty.gameObject:SetActive(true)
  end
  local curGradeChallengeId = PlayerData.SoldierData:GetCurGradeChallengeId()
  if curGradeChallengeId == 0 then
    self._mapNode.goBattleHint:SetActive(false)
  else
    self._mapNode.goBattleHint:SetActive(true)
    local nStage, nNodeIndex = PlayerData.SoldierData:GetCurChallengeState()
    local mapChallengeCfg = ConfigTable.GetData("SoldierGradeChallenge", curGradeChallengeId)
    local sDifficulty
    if mapChallengeCfg ~= nil then
      sDifficulty = mapChallengeCfg.Name
    end
    local sText = orderedFormat(ConfigTable.GetUIText("Soldier_MainView_OnGoingInfo"), sDifficulty, nStage, nNodeIndex)
    NovaAPI.SetTMPText(self._mapNode.TMPBattleLeave, sText)
  end
  if PlayerData.Guide:CheckGuideFinishById(501) then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_502")
  end
  if not PlayerData.Guide:CheckGuideFinishById(501) then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_501")
  end
end

function SoldierMainViewCtrl:RefreshDate()
  local actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Soldier)
  if actData == nil then
    return
  end
  local actCfg = ConfigTable.GetData("Activity", actData.nActId)
  local nOpenTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(actCfg.StartTime)
  local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(actCfg.EndTime)
  local nOpenYear = tonumber(os.date("%Y", nOpenTime))
  local nOpenMonth = tonumber(os.date("%m", nOpenTime))
  local nOpenDay = tonumber(os.date("%d", nOpenTime))
  local nEndYear = tonumber(os.date("%Y", nEndTime))
  local nEndMonth = tonumber(os.date("%m", nEndTime))
  local nEndDay = tonumber(os.date("%d", nEndTime))
  local strOpenDay = string.format("%d", nOpenDay)
  local strEndDay = string.format("%d", nEndDay)
  local dateStr = string.format("%s/%s/%s ~ %s/%s/%s", nOpenYear, nOpenMonth, strOpenDay, nEndYear, nEndMonth, strEndDay)
  NovaAPI.SetTMPText(self._mapNode.txtActivityDate, dateStr)
end

function SoldierMainViewCtrl:RefreshTimeout()
  local actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Soldier)
  if actData == nil then
    return
  end
  local endTime = actData:GetActEndTime()
  local curTime = ClientManager.Instance.serverTimeStamp
  local remainTime = endTime - curTime
  if remainTime < 0 then
    TimerManager.Remove(self.remainTimer)
    self.remainTimer = nil
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_Invalid_Tip_1"),
      callbackConfirm = function()
        EventManager.Hit(EventId.ClosePanel, PanelId.ActivityList)
      end
    })
    return
  end
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Activity_Remain_Time_Day") or "", day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtActivityTime, sTimeStr)
end

function SoldierMainViewCtrl:RefreshTechnology()
  local nTotal, nActive = PlayerData.SoldierData:GetTechActiveNodeCount()
  NovaAPI.SetTMPText(self._mapNode.txt_TechNum, string.format("%d/%d", nActive, nTotal))
end

function SoldierMainViewCtrl:OnBtnClick_Handbook()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierHandbookSelectPanel)
end

function SoldierMainViewCtrl:OnBtnClick_Recommend()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierRecommendPanel)
end

function SoldierMainViewCtrl:OnBtnClick_Go()
  local curGradeChallengeId = PlayerData.SoldierData:GetCurGradeChallengeId()
  if curGradeChallengeId == 0 then
    EventManager.Hit(EventId.OpenPanel, PanelId.SoldierLevelSelectPanel)
  else
    PlayerData.SoldierData:EnterSoldier()
  end
end

function SoldierMainViewCtrl:OnBtnClick_Tech()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierTechPanel)
end

function SoldierMainViewCtrl:OnBtnClick_Notice()
  local msg = {
    nType = AllEnum.MessageBox.Desc,
    sContent = "",
    sTitle = ConfigTable.GetUIText("Activity_Btn_Detail")
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function SoldierMainViewCtrl:OnBtnClick_Level()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierLevelRewardPanel)
end

function SoldierMainViewCtrl:OnEvent_StoryDialog_DialogEnd()
  if not PlayerData.Guide:CheckGuideFinishById(502) then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_502")
  end
end

return SoldierMainViewCtrl
