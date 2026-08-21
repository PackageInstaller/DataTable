local function _RevertChangesByBuffSeq(world, buffInstance, buffSeq)
  if not buffInstance._cfg_change_skill_numerical_parameter_by_combo then
    return
  end
  local results = buffInstance._cfg_change_skill_numerical_parameter_by_combo
  local cfgdecorsvc = world:GetService("ConfigDecoration")
  for i = #results, 1, -1 do
    local result = results[i]
    cfgdecorsvc:RevertSkillEffectDecoration(buffSeq, result.entityID, result.skillID, result.effectIndex)
  end
end

_class("BuffLogicChangeSkillNumericalParameterByCombo", BuffLogicBase)
BuffLogicChangeSkillNumericalParameterByCombo = BuffLogicChangeSkillNumericalParameterByCombo

function BuffLogicChangeSkillNumericalParameterByCombo:Constructor(buffInstance, logicParam)
  if type(logicParam.skillID) == "number" then
    self._skillID = {
      logicParam.skillID
    }
  else
    self._skillID = logicParam.skillID
  end
  self._effectIndex = logicParam.effectIndex
  self._append = logicParam.append or {}
  if not self._buffInstance._cfg_change_skill_numerical_parameter_by_combo then
    self._buffInstance._cfg_change_skill_numerical_parameter_by_combo = {}
  end
end

function BuffLogicChangeSkillNumericalParameterByCombo:DoLogic()
  local bsvc = self:GetWorld():GetService("Battle")
  local combo = bsvc:GetLogicComboNum()
  _RevertChangesByBuffSeq(self:GetWorld(), self._buffInstance, self:GetBuffSeq())
  local append = {}
  for key, value in pairs(self._append) do
    append[key] = value * combo
  end
  for _, skillID in ipairs(self._skillID) do
    local cfgdecorsvc = self:GetWorld():GetService("ConfigDecoration")
    cfgdecorsvc:DecorateSkillEffect(self:GetBuffSeq(), self:GetEntity(), skillID, self._effectIndex, append, {}, {}, {})
    local result = {
      buffSeqID = self:GetBuffSeq(),
      entityID = self:GetEntity():GetID(),
      skillID = skillID,
      effectIndex = self._effectIndex,
      append = append,
      set = {},
      remove = {}
    }
    table.insert(self._buffInstance._cfg_change_skill_numerical_parameter_by_combo, result)
  end
end

function BuffLogicChangeSkillNumericalParameterByCombo:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicRevertSkillNumericalParameterByCombo", BuffLogicBase)
BuffLogicRevertSkillNumericalParameterByCombo = BuffLogicRevertSkillNumericalParameterByCombo

function BuffLogicRevertSkillNumericalParameterByCombo:DoLogic()
  _RevertChangesByBuffSeq(self:GetWorld(), self._buffInstance, self:GetBuffSeq())
end
