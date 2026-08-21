require("ai_node_new")
_class("ActionSkillSelectByBuffLayerCount", ActionCastSkillBase)
ActionSkillSelectByBuffLayerCount = ActionSkillSelectByBuffLayerCount

function ActionSkillSelectByBuffLayerCount:Constructor()
end

function ActionSkillSelectByBuffLayerCount:GetWorkSkillID()
  local skillID = self:GetLogicData(1)
  self._skillListIndex = self:GetLogicData(-1)
  self._buffID = self:GetLogicData(-2)
  local vecSkillLists = self:GetConfigSkillList()
  local skillList = vecSkillLists[self._skillListIndex]
  local skillListCount = table.count(skillList)
  local buffCmp = self.m_entityOwn:BuffComponent()
  for i = 1, skillListCount do
    local targetBuffID = self._buffID + i
    local buffInstance = buffCmp:GetBuffById(targetBuffID)
    if buffInstance and not buffInstance:IsUnload() then
      skillID = skillList[i]
      break
    end
  end
  return skillID
end
