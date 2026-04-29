require("ai_node_new")
_class("ActionResetRoundAndSkill", AINewNode)
ActionResetRoundAndSkill = ActionResetRoundAndSkill

function ActionResetRoundAndSkill:Constructor()
end

function ActionResetRoundAndSkill:OnBegin()
  local nLoopLimit = self:GetLogicData(-1)
  if nil == nLoopLimit or nLoopLimit <= 0 then
    nLoopLimit = self:GetRuntimeData("SkillCount") or 1
  end
  self:SetRuntimeData("RoundCount", nLoopLimit)
  self:SetRuntimeData("NextRoundCount", 1)
  local id = self.m_entityOwn:MonsterID():GetMonsterID()
  local cfgService = self._world:GetService("Config")
  local monsterConfig = cfgService:GetMonsterConfigData()
  local crazySkillList = monsterConfig:GetMonsterSkillIDs(id)
  self:SetSkillList(crazySkillList)
  self.m_logicOwn:ReSelectWorkSkill()
  self:PrintLog("重置回合数和技能列表")
end

function ActionResetRoundAndSkill:OnUpdate(dt)
  return AINewNodeStatus.Success
end
