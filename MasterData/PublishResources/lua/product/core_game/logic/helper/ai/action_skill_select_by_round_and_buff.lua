require("ai_node_new")
_class("ActionSkillSelectByRoundAndBuff", AINewNode)
ActionSkillSelectByRoundAndBuff = ActionSkillSelectByRoundAndBuff

function ActionSkillSelectByRoundAndBuff:Constructor()
  self._skillListIndex = 1
  self._skillID = 0
  self.m_nDefaultSkillIndex = 0
  self.m_nSkillListCount = 0
end

function ActionSkillSelectByRoundAndBuff:InitializeNode(cfg, context, parentNode, configData)
  ActionSkillSelectByRoundAndBuff.super.InitializeNode(self, cfg, context, parentNode, configData)
  self._skillListIndex = configData[1]
  self.m_nDefaultSkillIndex = configData[2]
  self._checkRound = configData[3]
  self._buffAttribute = configData[4]
  self._buffID = configData[5]
end

function ActionSkillSelectByRoundAndBuff:Update()
  local vecSkillLists = self:GetConfigSkillList()
  local skillList = vecSkillLists[self._skillListIndex]
  if skillList then
    local nGameRound = self:GetGameRountNow()
    local nSaveRound = self:GetRuntimeData("GameRound")
    if nil == nSaveRound or nSaveRound ~= nGameRound then
      local roundCount = self:GetRuntimeData("NextRoundCount") or self.m_nDefaultSkillIndex or 1
      self._skillID = skillList[roundCount]
      if roundCount == self._checkRound and self._checkRound > 0 then
        local addRound = self.m_entityOwn:Attributes():GetAttribute(self._buffAttribute)
        addRound = addRound and addRound - 1
        if addRound and 0 < addRound then
          self._skillID = skillList[roundCount + addRound]
        end
      end
      if 0 < self._buffID then
        local buffCmp = self.m_entityOwn:BuffComponent()
        local buffInstance = buffCmp:GetBuffById(self._buffID)
        if not buffInstance then
          self._skillID = skillList[roundCount + self._checkRound]
        end
      end
      self:PrintLog("按回合选技能<初次进入>，RoundCount = ", roundCount, ", skillID = ", self._skillID)
    else
      local roundCount = self:GetRuntimeData("NextRoundCount") or self.m_nDefaultSkillIndex or 1
      self:PrintLog("按回合选技能<多次进入>，RoundCount = ", roundCount, ", skillID = ", self._skillID)
    end
    if 0 >= self.m_nSkillListCount then
      self.m_nSkillListCount = table.count(skillList)
      if 0 < self.m_nSkillListCount then
        self:SetRuntimeData("SkillCount", self.m_nSkillListCount)
      end
    end
  end
  return AINewNodeStatus.Success
end

function ActionSkillSelectByRoundAndBuff:GetActionSkillID()
  return self._skillID
end
