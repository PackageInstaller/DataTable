_class("DiscoveryStage", Object)
DiscoveryStage = DiscoveryStage

function DiscoveryStage:Constructor()
  self.id = 0
  self.type = DiscoveryStageType.FightNormal
  self.stageIdx = ""
  self.name = ""
  self.icon = ""
  self.desc = ""
  self.longDesc = ""
  self.cg = ""
  self.need_power = 0
  self.awards = {}
  self.enemies = {}
  self.story = nil
  self.state = nil
  self.star = 0
  self.three_star_condition = {}
  self.nodeId = 0
  self.prevStageId = {}
  self.unlockTimestamp = 0
  self._module = GameGlobal.GetModule(MissionModule)
  self._data = self._module:GetDiscoveryData()
  self.sectionId = 0
end

function DiscoveryStage:Init(id, nodeId)
  self.id = id
  self.nodeId = nodeId
  local cfg = Cfg.cfg_mission[id]
  if cfg then
    if cfg.Type == 1 then
      self.type = DiscoveryStageType.FightNormal
    elseif cfg.Type == 2 then
      self.type = DiscoveryStageType.FightBoss
    else
      self.type = DiscoveryStageType.Plot
    end
    self.stageIdx = DiscoveryStage.GetStageIndexString(id)
    self.name = StringTable.Get(cfg.Name)
    self.icon = cfg.Icon
    self.desc = StringTable.Get(cfg.Desc)
    self.longDesc = StringTable.Get(cfg.Desc .. "_long")
    self.need_power = cfg.NeedPower
    self.prevStageId = cfg.NeedMissionList
    self.unlockTimestamp = cfg.UnlockTime or 0
    self:FormatAwards(cfg)
    self.enemies = cfg.MonsterList
    local ids = {
      cfg.ThreeStarCondition1,
      cfg.ThreeStarCondition2,
      cfg.ThreeStarCondition3
    }
    for i, v in ipairs(ids) do
      local cond = StageCondition:New()
      cond:Init(i, v)
      table.insert(self.three_star_condition, cond)
    end
    self.sectionId = cfg.Section
  end
  local cfg_mission_chapter = Cfg.cfg_mission_chapter({
    MissionID = self.id
  })[1]
  if cfg_mission_chapter then
    self.cg = cfg_mission_chapter.BG
  end
  self.story = DiscoveryStoryList:New()
  self.story:Init(self.id)
end

function DiscoveryStage.GetStageIndexString(stageid)
  if stageid == nil then
    return ""
  end
  local cfgs = Cfg.cfg_mission_chapter({MissionID = stageid})
  if cfgs and #cfgs == 1 then
    local id = cfgs[1].WayPointID
    local waypointCfg = Cfg.cfg_waypoint[id]
    if not waypointCfg then
      Log.fatal("Key not found in cfg_waypoint:", id)
      return ""
    end
    return StringTable.Get(waypointCfg.Name)
  else
    Log.fatal("cfg_mission_chapter error, MissionID:", stageid)
    return ""
  end
end

function DiscoveryStage:FormatAwards(cfg)
  self.awards = {}
  if not self:HasPassThreeStar() then
    local awardsStar = self:GetSortedArr(AwardType.ThreeStar, cfg, StageAwardType.Star)
    if awardsStar then
      for i, v in ipairs(awardsStar) do
        self.awards[#self.awards + 1] = v
      end
    end
  end
  if not self:HasFirstPass() then
    local awardsFirst = self:GetSortedArr(AwardType.First, cfg, StageAwardType.First)
    if awardsFirst then
      for i, v in ipairs(awardsFirst) do
        self.awards[#self.awards + 1] = v
      end
    end
  end
  local normalArr = self:GetSortedArr(AwardType.Pass, cfg, StageAwardType.Normal)
  if normalArr then
    for i, v in ipairs(normalArr) do
      self.awards[#self.awards + 1] = v
    end
  end
end

function DiscoveryStage:GetSortedArr(awardType, cfg, stageAwardType)
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

function DiscoveryStage:HasPassThreeStar()
  for index, value in ipairs(self.three_star_condition) do
    if not value.satisfy then
      return false
    end
  end
  return true
end

function DiscoveryStage:HasFirstPass()
  return self.state == DiscoveryStageState.Nomal
end

function DiscoveryStage._LessComparer(nItemIDA, nItemIDB)
  return -1
end

function DiscoveryStage:UpdateStar(star)
  self.star = star or 0
end

function DiscoveryStage:UpdateState(state)
  self.state = state
  local cfg = Cfg.cfg_mission[self.id]
  self:FormatAwards(cfg)
end

function DiscoveryStage:UpdateCondition(conditions)
  local l_cur_star_num = 0
  for index, value in ipairs(self.three_star_condition) do
    if value.satisfy == true then
      l_cur_star_num = l_cur_star_num + 1
    end
  end
  local l_finish_star_num = #conditions
  for index, value in ipairs(self.three_star_condition) do
    if l_finish_star_num == l_cur_star_num then
      value:FlushSatisfy(false)
    end
    for i, v in ipairs(conditions) do
      if v == index then
        value:FlushSatisfy(true)
      end
    end
  end
  local cfg = Cfg.cfg_mission[self.id]
  self:FormatAwards(cfg)
end

function DiscoveryStage:IsThereStory()
  if self.story then
    return self.story:Count() > 0
  end
  return false
end

function DiscoveryStage:GetChapter()
  local chapter = self._data:GetChapterByStageId(self.id)
  if chapter then
    return chapter
  end
  return self._data:GetLastChapter()
end

function DiscoveryStage:NeedLevel()
  local cfg = Cfg.cfg_mission[self.id]
  if cfg then
    return cfg.NeedLevel
  end
  return 0
end

function DiscoveryStage:LevelReach()
  if GameSingle then
    return true
  end
  local roleModule = GameGlobal.GetModule(RoleModule)
  local lv = roleModule:GetLevel()
  if lv >= self:NeedLevel() then
    return true
  end
end

function DiscoveryStage:IsGuideStage()
  return DiscoveryStage.IsGuideStageId(self.id)
end

function DiscoveryStage.IsGuideStageId(id)
  if Cfg.cfg_mission_guide()[id] then
    return true
  end
  return false
end

_class("StageCondition", Object)
StageCondition = StageCondition

function StageCondition:Constructor()
  self.id = 0
  self.content = ""
  self.satisfy = false
  self._module = GameGlobal.GetModule(MissionModule)
end

function StageCondition:Init(idx, id)
  self.id = id or 0
  local desc = self._module:Get3StarConditionDesc(id, "FFA222") or ""
  self.content = desc
end

function StageCondition:FlushSatisfy(isSatisfy)
  self.satisfy = isSatisfy or false
end

_class("DiscoveryStoryList", Object)
DiscoveryStoryList = DiscoveryStoryList

function DiscoveryStoryList:Constructor()
  self.stageId = 0
  self.list = {}
  self._cfg = Cfg.cfg_mission_story
end

function DiscoveryStoryList:Init(stageId)
  local cfgv = self._cfg[stageId]
  self.stageId = stageId
  if cfgv and cfgv.StoryID then
    for i, v in ipairs(cfgv.StoryID) do
      local story = DiscoveryStory:New()
      story:Init(v, cfgv.StoryActiveType[i])
      table.insert(self.list, story)
    end
  end
end

function DiscoveryStoryList:GetStoryByStoryType(storyType)
  if not self.list then
    return
  end
  for i, v in ipairs(self.list) do
    if v.activeType == storyType then
      return v
    end
  end
end

function DiscoveryStoryList:Count()
  if not self.list then
    return 0
  end
  return table.count(self.list)
end

_class("DiscoveryStory", Object)
DiscoveryStory = DiscoveryStory

function DiscoveryStory:Constructor()
  self.id = 0
  self.activeType = nil
end

function DiscoveryStory:Init(storyId, storyType)
  self.id = storyId
  if storyType == 1 then
    self.activeType = StoryTriggerType.BeforeFight
  elseif storyType == 2 then
    self.activeType = StoryTriggerType.AfterFight
  elseif storyType == 3 then
    self.activeType = StoryTriggerType.Node
  elseif storyType == 4 then
    self.activeType = StoryTriggerType.BattleBefore
  elseif storyType == 5 then
    self.activeType = StoryTriggerType.BattleAfter
  end
end

local DiscoveryStageState = {Nomal = 0, CanPlay = 1}
_enum("DiscoveryStageState", DiscoveryStageState)
local DiscoveryStageType = {
  FightNormal = 1,
  FightBoss = 2,
  Plot = 3,
  Node = 4,
  SNode = 5
}
_enum("DiscoveryStageType", DiscoveryStageType)
local StoryTriggerType = {
  BeforeFight = 1,
  AfterFight = 2,
  Node = 3,
  BattleBefore = 4,
  BattleAfter = 5
}
_enum("StoryTriggerType", StoryTriggerType)
_class("UISerialAutoFightOptionCampParams", Object)
UISerialAutoFightOptionCampParams = UISerialAutoFightOptionCampParams

function UISerialAutoFightOptionCampParams:Constructor(pointComp, campType, forceTitleState, needTicket, componentId, campaignMissionParams)
  self._pointComp = pointComp
  self._campType = campType
  self._forceTitleState = forceTitleState
  self._needTicket = needTicket
  self._componentId = componentId
  self._campaignMissionParams = campaignMissionParams
end
