require("ai_node_new")
_class("ActionSkillSelectByRoundCount", AINewNode)
ActionSkillSelectByRoundCount = ActionSkillSelectByRoundCount

function ActionSkillSelectByRoundCount:Constructor()
  self._skillListIndex = 1
  self._skillID = 0
  self.m_nDefaultSkillIndex = 0
  self.m_nSkillListCount = 0
end

function ActionSkillSelectByRoundCount:InitializeNode(cfg, context, parentNode, configData)
  ActionSkillSelectByRoundCount.super.InitializeNode(self, cfg, context, parentNode, configData)
  if type(configData) == "number" then
    self._skillListIndex = configData
    self.m_nDefaultSkillIndex = 1
  elseif type(configData) == "table" then
    self._skillListIndex = configData[1]
    self.m_nDefaultSkillIndex = configData[2]
  end
end

function ActionSkillSelectByRoundCount:Update()
  local vecSkillLists = self:GetConfigSkillList()
  local skillList = vecSkillLists[self._skillListIndex]
  if skillList then
    local nGameRound = self:GetGameRountNow()
    local nSaveRound = self:GetRuntimeData("GameRound")
    if nil == nSaveRound or nSaveRound ~= nGameRound then
      local roundCount = self:GetRuntimeData("NextRoundCount") or self.m_nDefaultSkillIndex or 1
      self._skillID = skillList[roundCount]
      self:PrintLog("按回合选技能<初次进入>，RoundCount = ", roundCount, ", skillID = ", self._skillID)
    else
      local roundCount = self:GetRuntimeData("NextRoundCount") or self.m_nDefaultSkillIndex or 1
      self:PrintLog("按回合选技能<多次进入>，RoundCount = ", roundCount, ", skillID = ", self._skillID)
    end
    if self.m_nSkillListCount <= 0 then
      self.m_nSkillListCount = table.count(skillList)
      if self.m_nSkillListCount > 0 then
        self:SetRuntimeData("SkillCount", self.m_nSkillListCount)
      end
    end
  end
  return AINewNodeStatus.Success
end

function ActionSkillSelectByRoundCount:GetActionSkillID()
  return self._skillID
end
