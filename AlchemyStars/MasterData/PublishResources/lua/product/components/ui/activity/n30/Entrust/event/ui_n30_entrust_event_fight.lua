local e = require("ui_n30_entrust_event")
e:Class("N30EntrustEventFight", N30EntrustEvent, EntrustEventType.EntrustEventType_Fight)

function N30EntrustEventFight:Constructor()
end

function N30EntrustEventFight:DebugName()
  return "Fight"
end

function N30EntrustEventFight:GetIconName()
  local isHard = self:ParamHard()
  if isHard and self._isPass then
    return "n30_wt_ld_icon13"
  elseif isHard and self._isLocked then
    return "n30_wt_ld_icon17"
  elseif isHard then
    return "n30_wt_ld_icon09"
  elseif self._isPass then
    return "n30_wt_ld_icon12"
  else
    return "n30_wt_ld_icon08"
  end
end

function N30EntrustEventFight:GetWidgetName()
  return "UIN30EntrustEventFight"
end

_class("UIN30EntrustEventFight", UIN30EntrustEventWidget)
UIN30EntrustEventFight = UIN30EntrustEventFight

function UIN30EntrustEventFight:Constructor()
end

function UIN30EntrustEventFight:OnShow(uiParams)
  self._wordAndElem = self:GetUIComponent("UISelectObjectPath", "wordAndElem")
  self._enemyMsg = self:GetUIComponent("UISelectObjectPath", "enemyMsg")
  self._txtRecommendLv = self:GetUIComponent("UILocalizationText", "txtRecommendLv")
  self._txtConfirm = self:GetUIComponent("UILocalizationText", "txtConfirm")
end

function UIN30EntrustEventFight:OnHide()
end

function UIN30EntrustEventFight:BtnConfirmOnClick(go)
  local cfg = self._event:Cfg()
  local entrustData = self._event:EntrustData()
  local component = entrustData:EntrustComponent()
  component:SetCurLevelId(self._event:Node())
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  ctx:Init(TeamOpenerType.Campaign, {
    cfg.MissionID,
    component:GetCampaignMissionComponentId(),
    component:GetCampaignMissionParamKeyMap()
  })
  self:Lock("DoEnterTeam")
  ctx:ShowDialogUITeams()
end

function UIN30EntrustEventFight:GetIcon()
  if self._event:ParamHard() then
    return "n30_wt_icon04"
  else
    return "n30_wt_icon03"
  end
end

function UIN30EntrustEventFight:Refresh()
  local cfg = self._event:Cfg()
  local cfgMission = Cfg.cfg_campaign_mission[cfg.MissionID]
  local recommendAwaken = cfgMission.RecommendAwaken
  local recommendLv = cfgMission.RecommendLV
  local fightLevel = cfgMission.FightLevel
  local noLv = true
  local isChess = true
  local widgetEnemy = self._enemyMsg:SpawnObject("UIEnemyMsg")
  widgetEnemy:SetData(fightLevel, nil, isChess, noLv)
  local widgetWordAndElem = self._wordAndElem:SpawnObject("UIWordAndElemItem")
  widgetWordAndElem:SetData(cfgMission)
  local txt = StringTable.Get("str_discovery_node_recommend_lv")
  local str1 = txt .. " " .. StringTable.Get("str_pet_config_common_advance") .. recommendAwaken
  txt = recommendAwaken and 0 < recommendAwaken and str1 or txt
  local str2 = txt .. " LV." .. recommendLv
  txt = recommendLv and str2 or txt
  self._txtRecommendLv:SetText(txt)
  local txtKey
  if self._event:IsPass() then
    txtKey = "str_n30_entrust_event_fight_again_btn"
  else
    txtKey = "str_n30_entrust_event_fight_btn"
  end
  self._txtConfirm:SetText(StringTable.Get(txtKey))
end
