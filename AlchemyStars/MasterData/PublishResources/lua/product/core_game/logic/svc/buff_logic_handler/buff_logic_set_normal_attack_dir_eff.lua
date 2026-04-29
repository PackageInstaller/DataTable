require("buff_logic_base")
_class("BuffLogicSetNormalAttackDirEff", BuffLogicBase)
BuffLogicSetNormalAttackDirEff = BuffLogicSetNormalAttackDirEff

function BuffLogicSetNormalAttackDirEff:Constructor(buffInstance, logicParam)
  self._effectDirList = logicParam.effectDirList or {}
  self._animName = logicParam.animName
  self._waitTime = logicParam.waitTime
  self._remove = logicParam.remove
  self._effectID = logicParam.effectID
end

function BuffLogicSetNormalAttackDirEff:DoLogic(notify)
  local curRound = self._world:BattleStat():GetGameRoundCount()
  local cPetPstID = self._entity:PetPstID()
  local curRoundHadSave = table.clone(cPetPstID:GetRoundNormalAttackDirTable(curRound))
  local result = BuffResultSetNormalAttackDirEff:New(self._effectDirList, self._animName, self._waitTime, self._remove, self._effectID, curRoundHadSave)
  return result
end
