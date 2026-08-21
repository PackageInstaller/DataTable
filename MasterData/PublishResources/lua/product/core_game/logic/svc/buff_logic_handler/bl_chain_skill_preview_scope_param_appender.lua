require("buff_logic_base")
_class("BuffLogicChainSkillPreviewScopeParamAppender", BuffLogicBase)
BuffLogicChainSkillPreviewScopeParamAppender = BuffLogicChainSkillPreviewScopeParamAppender

function BuffLogicChainSkillPreviewScopeParamAppender:Constructor(buffInstance, logicParam)
  self._initArray = logicParam.appendArray
  self._skillID = logicParam.skillID
end

function BuffLogicChainSkillPreviewScopeParamAppender:GetBuffValueKey()
  return "ChainSkillPreviewScopeParamAppender" .. self._skillID
end

function BuffLogicChainSkillPreviewScopeParamAppender:DoLogic(notify)
  local cBuff = self._entity:BuffComponent()
  local bvk = self:GetBuffValueKey()
  local savedArray = {}
  if not cBuff:GetBuffValue(bvk) then
    cBuff:SetBuffValue(bvk, savedArray)
  else
    savedArray = table.cloneconf(cBuff:GetBuffValue(bvk))
  end
  for index, value in ipairs(self._initArray) do
    local currentVal = savedArray[index] or 0
    savedArray[index] = currentVal + value
  end
  cBuff:SetBuffValue(bvk, savedArray)
  return {array = savedArray}
end

_class("BuffLogicResetChainSkillPreviewScopeParamAppender", BuffLogicBase)
BuffLogicResetChainSkillPreviewScopeParamAppender = BuffLogicResetChainSkillPreviewScopeParamAppender

function BuffLogicResetChainSkillPreviewScopeParamAppender:Constructor(buffInstance, logicParam)
  self._skillID = logicParam.skillID
end

function BuffLogicResetChainSkillPreviewScopeParamAppender:GetBuffValueKey()
  return "ChainSkillPreviewScopeParamAppender" .. self._skillID
end

function BuffLogicResetChainSkillPreviewScopeParamAppender:DoLogic(notify)
  local cBuff = self._entity:BuffComponent()
  local bvk = self:GetBuffValueKey()
  cBuff:SetBuffValue(bvk, nil)
end
