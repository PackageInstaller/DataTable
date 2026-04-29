require("_buff_result_base")
_class("BuffResultStealPetAttributes", BuffResultBase)
BuffResultStealPetAttributes = BuffResultStealPetAttributes

function BuffResultStealPetAttributes:Constructor(newHp, newHpMax, newHpCaster, newHpMaxCaster)
  self._newHp = newHp
  self._newHpMax = newHpMax
  self._newHpCaster = newHpCaster
  self._newHpMaxCaster = newHpMaxCaster
end

function BuffResultStealPetAttributes:GetHp()
  return self._newHp
end

function BuffResultStealPetAttributes:GetHpMax()
  return self._newHpMax
end

function BuffResultStealPetAttributes:GetHpCaster()
  return self._newHpCaster
end

function BuffResultStealPetAttributes:GetHpMaxCaster()
  return self._newHpMaxCaster
end

_class("BuffResultResetStealPetAttributes", BuffResultBase)
BuffResultResetStealPetAttributes = BuffResultResetStealPetAttributes

function BuffResultResetStealPetAttributes:Constructor(newHp, newHpMax, newHpCaster, newHpMaxCaster)
  self._newHp = newHp
  self._newHpMax = newHpMax
  self._newHpCaster = newHpCaster
  self._newHpMaxCaster = newHpMaxCaster
end

function BuffResultResetStealPetAttributes:GetHp()
  return self._newHp
end

function BuffResultResetStealPetAttributes:GetHpMax()
  return self._newHpMax
end

function BuffResultResetStealPetAttributes:GetHpCaster()
  return self._newHpCaster
end

function BuffResultResetStealPetAttributes:GetHpMaxCaster()
  return self._newHpMaxCaster
end
