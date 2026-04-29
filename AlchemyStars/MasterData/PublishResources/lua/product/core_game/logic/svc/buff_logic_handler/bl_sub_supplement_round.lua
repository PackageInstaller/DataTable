_class("BuffLogicSubSupplementRound", BuffLogicBase)
BuffLogicSubSupplementRound = BuffLogicSubSupplementRound

function BuffLogicSubSupplementRound:Constructor(buffInstance, logicParam)
  self._levelRound = logicParam.levelRound
end

function BuffLogicSubSupplementRound:DoLogic(notify)
  local battleStatCmpt = self._world:BattleStat()
  battleStatCmpt:SubCurWaveRoundByEffect(self._levelRound)
  return true
end
