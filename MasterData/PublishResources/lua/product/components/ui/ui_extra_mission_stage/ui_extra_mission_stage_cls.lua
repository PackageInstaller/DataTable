_class("UIExtraMissionStage", Object)
UIExtraMissionStage = UIExtraMissionStage

function UIExtraMissionStage:Constructor()
  self.id = 0
  self.name = ""
  self.desc = ""
  self.chapterIdxName = ""
  self.chapterIdxNameEn = ""
  self.chapterName = ""
  self.chapterNameEn = ""
  self.icon = ""
  self.need_power = 0
  self.three_star_condition = {}
  self.nodeId = 0
  self.awards = {}
  self.enemies = {}
  self.story = {}
  self._extraMissionModule = GameGlobal.GetModule(ExtMissionModule)
end

function UIExtraMissionStage:Init(id, idxStr, nameStr, storyList)
  self.id = id
  self._cfg = Cfg.cfg_extra_mission[id]
  if self._cfg then
    self.name = StringTable.Get(self._cfg.Name)
    self.icon = self._cfg.Icon
    self.desc = self._cfg.Desc
    self.need_power = self._cfg.NeedPower
    if self._cfg.Action == 1 then
      self.action = StageActionType.Fight
    else
      self.action = StageActionType.Conversation
    end
    local idStr = self._cfg.ThreeStarAwardItemList
    local starCount = table.count(string.split(idStr, "|"))
    self.awards = {
      idStr = self._cfg.ThreeStarAwardItemList .. "|" .. self._cfg.AwardItemList,
      countStr = self._cfg.ThreeStarAwardItemCountList .. "|" .. self._cfg.AwardItemCountList,
      starCount = starCount
    }
    self.enemies = self:GetMonstersByMonsterListStr(self._cfg.MonsterList)
    local ids = {
      self._cfg.ThreeStarCondition1,
      self._cfg.ThreeStarCondition2,
      self._cfg.ThreeStarCondition3
    }
    for i, v in ipairs(ids) do
      local cond = ExtraMissionStageCondition:New()
      cond:Init(i, v)
      table.insert(self.three_star_condition, cond)
    end
  end
  for i = 1, table.count(storyList) do
    local story = ExtStory:New()
    story:Init(storyList[i].id, storyList[i].type)
    table.insert(self.story, story)
  end
  self.chapterIdxName = StringTable.Get(idxStr)
  self.chapterIdxNameEn = StringTable.Get(idxStr .. "_en")
  self.chapterName = StringTable.Get(nameStr)
end

function UIExtraMissionStage:UpdateState(state)
  self.state = state
end

function UIExtraMissionStage:UpdateCondition(conditions)
  for i, v in ipairs(conditions) do
    self.three_star_condition[v]:FlushSatisfy(true)
  end
end

function UIExtraMissionStage:GetMonstersByMonsterListStr(monstersStr)
  local items = {}
  local ids = {}
  if string.find(monstersStr, "|") then
    ids = string.split(monstersStr, "|")
  else
    ids[1] = monstersStr
  end
  for i = 1, #ids do
    table.insert(items, tonumber(ids[i]))
  end
  return items
end

function UIExtraMissionStage:GetStageMainBranchStr()
  local chapterInfo = Cfg.cfg_mission_chapter({
    MissionID = self.id
  })[1]
  dump(chapterInfo)
  local cnStr = ""
  local enStr = ""
  if chapterInfo then
    Log.fatal("### GetStageMainBranchStr " .. chapterInfo.ChapterType .. " ; " .. chapterInfo.ChapterType == 1)
    if chapterInfo.ChapterType == 1 then
      cnStr = StringTable.Get("str_discovery_main_chapter")
      enStr = StringTable.Get("str_discovery_main_chapter_en")
    else
      cnStr = StringTable.Get("str_discovery_branch_chapter")
      enStr = StringTable.Get("str_discovery_branch_chapter_en")
    end
  end
  return cnStr, enStr
end

_class("ExtraMissionStageCondition", Object)
ExtraMissionStageCondition = ExtraMissionStageCondition

function ExtraMissionStageCondition:Constructor()
  self.id = 0
  self.content = ""
  self.satisfy = false
  self._extraMissionModule = GameGlobal.GetModule(ExtMissionModule)
end

function ExtraMissionStageCondition:Init(idx, id, desc, isSatisfy)
  self.id = id
  self.content = idx .. "." .. desc
  self:FlushSatisfy(isSatisfy)
end

function ExtraMissionStageCondition:FlushSatisfy(isSatisfy)
  self.satisfy = isSatisfy or false
end

_class("ExtStory", Object)
ExtStory = ExtStory

function ExtStory:Constructor()
  self.id = 0
  self.stageId = 0
  self.activeType = nil
  self._cfg = Cfg.cfg_extra_mission_story
end

function ExtStory:Init(storyID, storyType)
  self.id = storyID
  if storyType == 1 then
    self.activeType = StoryTriggerType.BeforeFight
  elseif storyType == 2 then
    self.activeType = StoryTriggerType.AfterFight
  else
    self.activeType = StoryTriggerType.Node
  end
end
