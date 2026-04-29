_class("UISeasonBuildContextS3", Object)
UISeasonBuildContextS3 = UISeasonBuildContextS3

function UISeasonBuildContextS3:Constructor()
  self._questModuel = GameGlobal.GetModule(QuestModule)
  self._seasonModuel = GameGlobal.GetModule(SeasonModule)
end

function UISeasonBuildContextS3:Init()
  self._seasonId = self._seasonModuel:GetCurSeasonID()
  self._levelCfgs = Cfg.cfg_season_castle({
    SeasonID = self._seasonId
  })
  if not self._levelCfgs then
    Log.error("err cfg_season_castle no config for seasonId ", self._seasonId)
    return
  end
  table.sort(self._levelCfgs, function(a, b)
    return a.Lv < b.Lv
  end)
  self._maxLevel = #self._levelCfgs
end

function UISeasonBuildContextS3:GetSeasonId()
  return self._seasonId
end

function UISeasonBuildContextS3:GetMaxLevel()
  return self._maxLevel
end

function UISeasonBuildContextS3:GetCurLevel()
  return self._seasonModuel:GetCastleLv(self._seasonId)
end

function UISeasonBuildContextS3:BuildLevelIsFull()
  return self:GetCurLevel() == self:GetMaxLevel()
end

function UISeasonBuildContextS3:GetLevelCfgs()
  return self._levelCfgs
end

function UISeasonBuildContextS3:GetBuildCfgByLevel(level)
  local cfg = self._levelCfgs[level]
  if not cfg then
    Log.error("err can't find cfg with level ", level)
    return
  end
  return cfg
end

function UISeasonBuildContextS3:GetQuestByBuildLevel(level)
  local cfg = self:GetBuildCfgByLevel(level)
  if not cfg then
    return
  end
  local ids = cfg.QuestList
  local id = ids[1]
  local d = {}
  d.ID = id
  local open, finish = self:GetQuestStatus(id)
  d.Finish = finish
  d.Open = true
  return d
end

function UISeasonBuildContextS3:GetQuestStatus(questId)
  local open = false
  local finish = false
  local quest = self._questModuel:GetQuest(questId)
  if quest then
    local questInfo = quest:QuestInfo()
    local status = questInfo.status
    open = status ~= QuestStatus.QUEST_NotStart
    finish = status == QuestStatus.QUEST_Completed or status == QuestStatus.QUEST_Taken
  else
    open = false
  end
  return open, finish
end

function UISeasonBuildContextS3:CanBuild()
  local level = self:GetCurLevel()
  if level == self:GetMaxLevel() then
    return false
  end
  local quest = self:GetQuestByBuildLevel(level)
  if quest and quest.Finish then
    return true
  end
  return false
end
