require("br_sealed_curse")
_class("BuffLogicSetPet1702361LinkLine", BuffLogicBase)
BuffLogicSetPet1702361LinkLine = BuffLogicSetPet1702361LinkLine

function BuffLogicSetPet1702361LinkLine:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:HasPetPstID() then
    return
  end
  e:BuffComponent():SetFlag(BuffFlags.Pet1702361NotLinkLine)
  return BuffResultSealedCurse:New(self._buffInstance:BuffSeq(), true)
end

_class("BuffLogicResetPet1702361LinkLine", BuffLogicBase)
BuffLogicResetPet1702361LinkLine = BuffLogicResetPet1702361LinkLine

function BuffLogicResetPet1702361LinkLine:DoLogic()
  local e = self._buffInstance:Entity()
  if not e:HasPetPstID() then
    return
  end
  e:BuffComponent():ResetFlag(BuffFlags.Pet1702361NotLinkLine)
  return BuffResultSealedCurse:New(self._buffInstance:BuffSeq(), false)
end
