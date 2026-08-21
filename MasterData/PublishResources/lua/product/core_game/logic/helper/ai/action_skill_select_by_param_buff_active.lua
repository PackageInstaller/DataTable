require("ai_node_new")
_class("ActionSkillSelectByParamBuffActive", AINewNode)
ActionSkillSelectByParamBuffActive = ActionSkillSelectByParamBuffActive

function ActionSkillSelectByParamBuffActive:Constructor()
  self._skillID = 0
end

function ActionSkillSelectByParamBuffActive:InitializeNode(cfg, context, parentNode, configData)
  ActionSkillSelectByParamBuffActive.super.InitializeNode(self, cfg, context, parentNode, configData)
  local checkBuffCount = table.count(configData)
  self._buffIDList = {}
  for i = 1, checkBuffCount do
    table.insert(self._buffIDList, configData[i])
  end
end

function ActionSkillSelectByParamBuffActive:Update()
  self:_CalcSkillID()
  return AINewNodeStatus.Success
end

function ActionSkillSelectByParamBuffActive:GetActionSkillID()
  self:_CalcSkillID()
  return self._skillID
end

function ActionSkillSelectByParamBuffActive:_CalcSkillID()
  local vecSkillLists = self:GetConfigSkillList()
  local buffCmp = self.m_entityOwn:BuffComponent()
  for index, buffID in ipairs(self._buffIDList) do
    local buffInstance = buffCmp:GetBuffById(buffID)
    if buffInstance and not buffInstance:IsUnload() then
      self._skillID = vecSkillLists[1][index]
      return
    end
  end
  self._skillID = vecSkillLists[1][1]
end
