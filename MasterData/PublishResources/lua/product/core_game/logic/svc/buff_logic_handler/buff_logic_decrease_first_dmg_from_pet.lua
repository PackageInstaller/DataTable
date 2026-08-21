require("buff_logic_base")
_class("BuffLogicDecreaseFirstDmgFromPet", BuffLogicBase)
BuffLogicDecreaseFirstDmgFromPet = BuffLogicDecreaseFirstDmgFromPet

function BuffLogicDecreaseFirstDmgFromPet:Constructor(buffInstance, logicParam)
  self._dmgRate = logicParam.dmgRate
end

function BuffLogicDecreaseFirstDmgFromPet:DoLogic(notify)
  if not self._entity:HasMonsterID() then
    return
  end
  local damageRecords = {}
  self._buffComponent:SetBuffValue("BuffDecreaseFirstDmgFromPetRecords", damageRecords)
  self._buffComponent:SetBuffValue("BuffDecreaseFirstDmgFromPet", tonumber(self._dmgRate))
end

_class("BuffLogicUndoDecreaseFirstDmgFromPet", BuffLogicBase)
BuffLogicUndoDecreaseFirstDmgFromPet = BuffLogicUndoDecreaseFirstDmgFromPet

function BuffLogicUndoDecreaseFirstDmgFromPet:Constructor(buffInstance, logicParam)
end

function BuffLogicUndoDecreaseFirstDmgFromPet:DoLogic(notify)
  self._buffComponent:SetBuffValue("BuffDecreaseFirstDmgFromPet", nil)
  self._buffComponent:SetBuffValue("BuffDecreaseFirstDmgFromPetRecords", nil)
end
