_class("BuffLogicRecordPetAbsorbSuperGrid", BuffLogicBase)
BuffLogicRecordPetAbsorbSuperGrid = BuffLogicRecordPetAbsorbSuperGrid

function BuffLogicRecordPetAbsorbSuperGrid:Constructor(buffInstance, logicParam)
  self._key = "PetAbsorbSuperGridCount"
end

function BuffLogicRecordPetAbsorbSuperGrid:DoLogic(notify)
  local buffComponent = self._entity:BuffComponent()
  if not buffComponent then
    return
  end
  buffComponent:AddBuffValue(self._key, 1)
end

_class("BuffLogicClearRecordPetAbsorbSuperGrid", BuffLogicBase)
BuffLogicClearRecordPetAbsorbSuperGrid = BuffLogicClearRecordPetAbsorbSuperGrid

function BuffLogicClearRecordPetAbsorbSuperGrid:Constructor(buffInstance, logicParam)
  self._key = "PetAbsorbSuperGridCount"
end

function BuffLogicClearRecordPetAbsorbSuperGrid:DoLogic(notify)
  local buffComponent = self._entity:BuffComponent()
  if not buffComponent then
    return
  end
  buffComponent:SetBuffValue(self._key, 0)
end
