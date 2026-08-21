require("ai_node_new")
_class("ActionSkillSelectByRoundCountAndCrazy", AINewNode)
ActionSkillSelectByRoundCountAndCrazy = ActionSkillSelectByRoundCountAndCrazy

function ActionSkillSelectByRoundCountAndCrazy:Constructor()
  self._skillListIndex = 1
  self._skillID = 0
  self.m_nDefaultSkillIndex = 0
  self.m_nSkillListCount = 0
  self._crazySkillListIndex = 1
end

function ActionSkillSelectByRoundCountAndCrazy:InitializeNode(cfg, context, parentNode, configData)
  ActionSkillSelectByRoundCountAndCrazy.super.InitializeNode(self, cfg, context, parentNode, configData)
  if type(configData) == "number" then
    self._skillListIndex = configData
    self.m_nDefaultSkillIndex = 1
  elseif type(configData) == "table" then
    self._skillListIndex = configData[1]
    self.m_nDefaultSkillIndex = configData[2]
    self._crazySkillListIndex = configData[3]
  end
end

function ActionSkillSelectByRoundCountAndCrazy:Update()
  local vecSkillLists = self:GetConfigSkillList()
  local skillList = vecSkillLists[self._skillListIndex]
  if self.m_entityOwn:HasCrazyMode() then
    skillList = vecSkillLists[self._crazySkillListIndex]
  end
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

function ActionSkillSelectByRoundCountAndCrazy:GetActionSkillID()
  return self._skillID
end
