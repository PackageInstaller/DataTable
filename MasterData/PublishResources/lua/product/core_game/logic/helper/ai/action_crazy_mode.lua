require("ai_node_new")
_class("ActionCrazyMode", AINewNode)
ActionCrazyMode = ActionCrazyMode

function ActionCrazyMode:Constructor()
  self._world = nil
  self._crazy = false
end

function ActionCrazyMode:InitializeNode(cfg, context, parentNode, configData)
  ActionCrazyMode.super.InitializeNode(self, cfg, context, parentNode, configData)
end

function ActionCrazyMode:OnUpdate()
  if self._crazy then
    return AINewNodeStatus.Failure
  end
  local crazyMonsterID = self:GetLogicData(-1)
  local sisterMonsterID = self:GetLogicData(-2)
  self._crazy = true
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, e in ipairs(group:GetEntities()) do
    if e:HasDeadMark() == false and e:MonsterID():GetMonsterClassID() == sisterMonsterID then
      self._crazy = false
      break
    end
  end
  if self._crazy then
    local cfgService = self._world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    local raceType = monsterConfigData:GetMonsterRaceType(crazyMonsterID)
    local monsterType = monsterConfigData:GetMonsterType(crazyMonsterID)
    local monsterGroupID = monsterConfigData:GetMonsterGroupID(crazyMonsterID)
    local monsterClassID = monsterConfigData:GetMonsterClassID(crazyMonsterID)
    local monsterCampType = monsterConfigData:GetMonsterCampType(crazyMonsterID)
    self.m_entityOwn:ReplaceMonsterID(crazyMonsterID, raceType, monsterType, monsterGroupID, monsterClassID, monsterCampType)
    local monsterConfig = cfgService:GetMonsterConfigData()
    local crazySkillList = monsterConfig:GetMonsterSkillIDs(crazyMonsterID)
    self:SetSkillList(crazySkillList)
    self:SetRuntimeData("RoundCount", 1)
    self:SetRuntimeData("NextRoundCount", 2)
    self.m_logicOwn:ReSelectWorkSkill()
    self.m_entityOwn:ReplaceCrazyMode()
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end
