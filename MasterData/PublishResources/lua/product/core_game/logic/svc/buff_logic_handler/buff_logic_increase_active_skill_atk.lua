_class("BuffLogicDoIncreaseActiveSkillAtk", BuffLogicBase)
BuffLogicDoIncreaseActiveSkillAtk = BuffLogicDoIncreaseActiveSkillAtk

function BuffLogicDoIncreaseActiveSkillAtk:Constructor(buffInstance, logicParam)
  self._increaseMul = logicParam.increaseMul
  self._increaseLayer = logicParam.increaseLayer or 0
  self._iconPassiveSkillLight = logicParam.light == 1
end

function BuffLogicDoIncreaseActiveSkillAtk:DoLogic(notify)
  local buffComponent = self._entity:BuffComponent()
  local buffSeq = self:GetBuffSeq()
  buffComponent:SetBuffValue("IncreaseActiveDamageSkillSeqID", buffSeq)
  self._buffInstance:AddLayerCount(self._increaseLayer)
  local layer = self._buffInstance:GetLayerCount()
  buffComponent:SetBuffValue("IncreaseActiveSkillDamageMul", self._increaseMul * layer)
  local res = BuffResultDoIncreaseActiveSkillAtk:New(self._iconPassiveSkillLight, layer)
  return res
end

_class("BuffLogicUndoIncreaseActiveSkillAtk", BuffLogicBase)
BuffLogicUndoIncreaseActiveSkillAtk = BuffLogicUndoIncreaseActiveSkillAtk

function BuffLogicUndoIncreaseActiveSkillAtk:Constructor(buffInstance, logicParam)
  self._iconPassiveSkillDark = logicParam.dark == 1
end

function BuffLogicUndoIncreaseActiveSkillAtk:DoLogic()
  local buffComponent = self._entity:BuffComponent()
  buffComponent:SetBuffValue("IncreaseActiveSkillDamageMul", 0)
  local seqID = buffComponent:GetBuffValue("IncreaseActiveDamageSkillSeqID")
  local instance = buffComponent:GetBuffBySeq(seqID)
  if instance then
    instance:SetLayerCount(0)
  end
  local result = BuffResultUndoIncreaseActiveSkillAtk:New(self._iconPassiveSkillDark)
  return result
end
