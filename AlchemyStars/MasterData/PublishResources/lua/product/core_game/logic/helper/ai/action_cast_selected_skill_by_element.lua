require("ai_node_new")
_class("ActionCastSelectedSkillByElement", ActionCastSkillBase)
ActionCastSelectedSkillByElement = ActionCastSelectedSkillByElement

function ActionCastSelectedSkillByElement:Constructor()
end

function ActionCastSelectedSkillByElement:GetWorkSkillID()
  local skillId = self:GetLogicData(-1)
  local remove = self:GetLogicData(-2)
  local random = self:GetLogicData(-3)
  local attributeCmpt = self.m_entityOwn:Attributes()
  local curElement = attributeCmpt:GetAttribute("Element")
  local elementList = {
    1,
    2,
    3,
    4
  }
  if curElement ~= 0 and remove then
    table.remove(elementList, curElement)
  end
  skillId = skillId + curElement * 10
  if random then
    local utilScopeSvc = self._world:GetService("UtilScopeCalc")
    local randomIndex = utilScopeSvc:_GetRandomNumber(1, table.count(elementList))
    local skillIndexY = elementList[randomIndex]
    skillId = skillId + skillIndexY
  end
  return skillId
end
