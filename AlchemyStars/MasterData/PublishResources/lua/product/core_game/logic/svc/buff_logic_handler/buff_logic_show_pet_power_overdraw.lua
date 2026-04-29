_class("BuffLogicShowPetPowerOverdraw", BuffLogicBase)
BuffLogicShowPetPowerOverdraw = BuffLogicShowPetPowerOverdraw

function BuffLogicShowPetPowerOverdraw:Constructor(buffInstance, logicParam)
  self._ready = logicParam.ready
  self._overdraw = logicParam.overdraw
end

function BuffLogicShowPetPowerOverdraw:DoLogic()
  local buffResult = BuffResultShowPetPowerOverdraw:New(self._ready, self._overdraw)
  return buffResult
end
