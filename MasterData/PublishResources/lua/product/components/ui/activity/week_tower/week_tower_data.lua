local WeekTowerMissionBattleStatus = {
  Pass = 1,
  Battle = 2,
  Lock = 3
}
_enum("WeekTowerMissionBattleStatus", WeekTowerMissionBattleStatus)
_class("WeekTowerDiffData", Object)
WeekTowerDiffData = WeekTowerDiffData

function WeekTowerDiffData:Constructor(lock, missionList, diff)
  self._lock = lock
  self._misisonList = missionList
  self._diff = diff
  self._sprites = {}
  local sprite1, sprite2, sprite3
  if diff == WeekTowerDiffEnum.Easy then
    sprite1 = "lose_dificultad_btn03"
    sprite2 = "lose_dificultad_btn02"
    sprite3 = "lose_dificultad_btn01"
    self._name = "str_week_tower_easy"
    self._upColor = "#b1ac96"
  elseif diff == WeekTowerDiffEnum.Normal then
    sprite1 = "lose_dificultad_btn06"
    sprite2 = "lose_dificultad_btn05"
    sprite3 = "lose_dificultad_btn04"
    self._name = "str_week_tower_norm"
    self._upColor = "#797a7f"
  elseif diff == WeekTowerDiffEnum.Diff then
    sprite1 = "lose_dificultad_btn09"
    sprite2 = "lose_dificultad_btn08"
    sprite3 = "lose_dificultad_btn07"
    self._name = "str_week_tower_diff"
    self._upColor = "#867979"
  end
  self._sprites[1] = sprite1
  self._sprites[2] = sprite2
  self._sprites[3] = sprite3
end

function WeekTowerDiffData:MissionList()
  return self._misisonList
end

function WeekTowerDiffData:Lock()
  return self._lock
end

function WeekTowerDiffData:Sprites()
  return self._sprites
end

function WeekTowerDiffData:Name()
  return StringTable.Get(self._name)
end

function WeekTowerDiffData:UpColor()
  return self._upColor
end

_class("WeekTowerMissionData", Object)
WeekTowerMissionData = WeekTowerMissionData

function WeekTowerMissionData:Constructor(cfg, pass, passInfo)
  if pass then
    self:SetPassState(WeekTowerMissionBattleStatus.Pass)
  else
    self:SetPassState(WeekTowerMissionBattleStatus.Lock)
  end
  local cfg_line_mission = cfg
  self._id = cfg_line_mission.CampaignMissionId
  local cfg_campaign_mission = Cfg.cfg_campaign_mission[self._id]
  if not cfg_campaign_mission then
    Log.error("###[WeekTowerMissionData] cfg_campaign_mission is nil ! id --> ", self._id)
  end
  self._levelid = cfg_campaign_mission.FightLevel
  self._type = cfg_campaign_mission.Type
  self._word = cfg_campaign_mission.BaseWordBuff
  self._award = self:_GetSortedArr(AwardType.First, cfg_campaign_mission, StageAwardType.First)
  local nameStr = cfg.DependName
  if nameStr then
    local nameStrs = string.split(nameStr, "|")
    self._missionName = StringTable.Get(nameStrs[2])
    self._missionName2 = StringTable.Get(nameStrs[1])
  else
    self._missionName = ""
    self._missionName2 = ""
  end
  self._recommendLv = cfg_campaign_mission.RecommendLV
  self._recommendGrade = cfg_campaign_mission.RecommendAwaken
  local params = cfg_line_mission.CustomParams
  if not params or table.count(params) <= 0 then
    Log.error("###[WeekTowerMissionData] CustomParams is nil ! id --> ", self._id)
  end
  self._diff = params[1][1]
  self._groupIdx = params[1][2]
  self._groupInnerIdx = params[1][3]
  if not cfg_line_mission.NodePrefabName then
    Log.error("###[WeekTowerMissionData] NodePrefabName is nil ! id --> ", self._id)
  end
  self._widgetName = cfg_line_mission.NodePrefabName
  self._starCount = 0
  self._threeStarCondition = {}
  local ids = {
    cfg_campaign_mission.ThreeStarCondition1,
    cfg_campaign_mission.ThreeStarCondition2,
    cfg_campaign_mission.ThreeStarCondition3
  }
  for i, v in ipairs(ids) do
    local cond = StageCondition:New()
    cond:Init(i, v)
    if passInfo then
      local star = passInfo.star
      local getStar = star & 1 << i - 1 ~= 0
      if getStar then
        self._starCount = self._starCount + 1
        cond:FlushSatisfy(true)
      end
    end
    table.insert(self._threeStarCondition, cond)
  end
  local cfg_com_line_mission = Cfg.cfg_component_line_mission({
    CampaignMissionId = self._id
  })
  if cfg_com_line_mission and next(cfg_com_line_mission) then
    local cfg = cfg_com_line_mission[1]
    local openTime = cfg.OpenTime
    if openTime then
      self._openTime = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(openTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    end
  end
end

function WeekTowerMissionData:_GetSortedArr(awardType, cfg, stageAwardType)
  local list = UICommonHelper:GetInstance():GetDropByAwardType(awardType, cfg)
  local vecSort = SortedArray:New(Algorithm.COMPARE_CUSTOM, DiscoveryStage._LessComparer)
  if list then
    for i, v in ipairs(list) do
      local award = Award:New()
      award:InitWithCount(v.ItemID, v.Count, v.Type)
      award:FlushType(stageAwardType)
      vecSort:Insert(award)
    end
  end
  return vecSort.elements
end

function WeekTowerMissionData:GetDiff()
  return self._diff
end

function WeekTowerMissionData:SetPassState(state)
  self._pass = state
end

function WeekTowerMissionData:GetPassTime()
  return self._pass
end

function WeekTowerMissionData:GetLevelID()
  return self._levelid
end

function WeekTowerMissionData:GetType()
  return self._type
end

function WeekTowerMissionData:GetID()
  return self._id
end

function WeekTowerMissionData:GetWord()
  return self._word
end

function WeekTowerMissionData:GetAward()
  return self._award
end

function WeekTowerMissionData:GetMissionName()
  return self._missionName
end

function WeekTowerMissionData:GetMissionName2()
  return self._missionName2
end

function WeekTowerMissionData:GetRecommendLv()
  return self._recommendLv
end

function WeekTowerMissionData:GetRecommendGrade()
  return self._recommendGrade
end

function WeekTowerMissionData:GetNodeUpOrDown()
  return self._groupIdx % 2
end

function WeekTowerMissionData:GetWidgetName()
  return self._widgetName
end

function WeekTowerMissionData:ShowLineY()
  local groupIdx = self._groupIdx
  if groupIdx ~= 1 and self._groupInnerIdx == 1 then
    return true
  end
  return false
end

function WeekTowerMissionData:GetNodeIcon()
  return self._icon
end

function WeekTowerMissionData:GetNodeIconMask()
  return self._iconMask
end

function WeekTowerMissionData:Get3StarConditions()
  return self._threeStarCondition
end

function WeekTowerMissionData:GetStarCount()
  return self._starCount
end

function WeekTowerMissionData:OpenTime()
  return self._openTime
end
