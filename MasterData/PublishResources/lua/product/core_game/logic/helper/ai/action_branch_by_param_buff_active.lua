require("action_cast_skill_base")
_class("ActionBranchByParamBuffActive", AINewNode)
ActionBranchByParamBuffActive = ActionBranchByParamBuffActive

function ActionBranchByParamBuffActive:Constructor()
end

function ActionBranchByParamBuffActive:OnUpdate()
  local checkBuffCount = self:GetLogicData(-1)
  self._buffIDList = {}
  for i = 2, checkBuffCount + 1 do
    table.insert(self._buffIDList, self:GetLogicData(-1 * i))
  end
  local buffCmp = self.m_entityOwn:BuffComponent()
  for index, buffID in ipairs(self._buffIDList) do
    local buffInstance = buffCmp:GetBuffById(buffID)
    if buffInstance and not buffInstance:IsUnload() then
      return AINewNodeStatus.Other + index
    end
  end
  return AINewNodeStatus.Other + 1
end
