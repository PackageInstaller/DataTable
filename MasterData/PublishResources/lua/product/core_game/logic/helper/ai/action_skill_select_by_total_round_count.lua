require("ai_node_new")
_class("ActionSkillSelectByTotalRoundCount", AINewNode)
ActionSkillSelectByTotalRoundCount = ActionSkillSelectByTotalRoundCount

function ActionSkillSelectByTotalRoundCount:Constructor()
  self._skillListIndex = 1
  self._skillID = 0
  self.m_nDefaultSkillIndex = 0
  self.m_nSkillListCount = 0
end

function ActionSkillSelectByTotalRoundCount:InitializeNode(cfg, context, parentNode, configData)
  ActionSkillSelectByTotalRoundCount.super.InitializeNode(self, cfg, context, parentNode, configData)
  if type(configData) == "number" then
    self._skillListIndex = configData
    self.m_nDefaultSkillIndex = 1
  elseif type(configData) == "table" then
    self._skillListIndex = configData[1] or 1
    self.m_nDefaultSkillIndex = configData[2]
    self._skillCount = configData[3]
  end
end

function ActionSkillSelectByTotalRoundCount:Update()
  local vecSkillLists = self:GetConfigSkillList()
  local skillList = vecSkillLists[self._skillListIndex]
  if skillList then
    local battleStatCmpt = self._world:BattleStat()
    local levelTotalRoundCount = battleStatCmpt:GetLevelTotalRoundCount()
    local skillCount = self._skillCount or table.count(skillList)
    local roundCount = levelTotalRoundCount % skillCount
    if roundCount == 0 then
      roundCount = skillCount
    end
    self._skillID = skillList[roundCount]
    self:PrintLog("按回合选技能<初次进入>，RoundCount = ", roundCount, ", skillID = ", self._skillID)
    self:SetRuntimeData("SkillCount", skillCount)
  end
  return AINewNodeStatus.Success
end

function ActionSkillSelectByTotalRoundCount:GetActionSkillID()
  return self._skillID
end
