_class("BuffLogicChangeSkillParam", BuffLogicBase)
BuffLogicChangeSkillParam = BuffLogicChangeSkillParam

function BuffLogicChangeSkillParam:Constructor(buffInstance, logicParam)
  if type(logicParam.skillID) == "number" then
    self._skillID = {
      logicParam.skillID
    }
  else
    self._skillID = logicParam.skillID
  end
  self._effectIndex = logicParam.effectIndex
  self._append = logicParam.append or {}
  self._set = logicParam.set or {}
  self._remove = logicParam.remove or {}
  self._appendArray = logicParam.appendArray or {}
  self._buffInstance._cfg = {}
end

function BuffLogicChangeSkillParam:DoLogic()
  for _, skillID in ipairs(self._skillID) do
    local cfgdecorsvc = self:GetWorld():GetService("ConfigDecoration")
    cfgdecorsvc:DecorateSkillEffect(self:GetBuffSeq(), self:GetEntity(), skillID, self._effectIndex, self._append, self._set, self._remove, self._appendArray)
    local result = {
      buffSeqID = self:GetBuffSeq(),
      entityID = self:GetEntity():GetID(),
      skillID = skillID,
      effectIndex = self._effectIndex,
      append = self._append,
      set = self._set,
      remove = self._remove,
      appendArray = self._appendArray
    }
    table.insert(self._buffInstance._cfg, result)
  end
end

_class("BuffLogicUndoChangeSkillParam", BuffLogicBase)
BuffLogicUndoChangeSkillParam = BuffLogicUndoChangeSkillParam

function BuffLogicUndoChangeSkillParam:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoChangeSkillParam:DoLogic()
  local resultList = self._buffInstance._cfg
  for k, result in ipairs(resultList) do
    local cfgdecorsvc = self:GetWorld():GetService("ConfigDecoration")
    cfgdecorsvc:RevertSkillEffectDecoration(self:GetBuffSeq(), result.entityID, result.skillID, result.effectIndex)
  end
  self._buffInstance._cfg = {}
end

_class("BuffLogicRevertChangeSkillParam", BuffLogicBase)
BuffLogicRevertChangeSkillParam = BuffLogicRevertChangeSkillParam

function BuffLogicRevertChangeSkillParam:Constructor(buffInstance, logicParam)
  self.skillID = tonumber(logicParam.skillID)
  self.effectIndex = tonumber(logicParam.effectIndex)
end

function BuffLogicRevertChangeSkillParam:DoLogic()
  local cfgdecorsvc = self:GetWorld():GetService("ConfigDecoration")
  cfgdecorsvc:RevertAllSkillEffectDecoration(self._entity:GetID(), self.skillID, self.effectIndex)
end
