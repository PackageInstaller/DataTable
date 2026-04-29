_class("BuffLogicCoffinMusumeChangeDefenceByCandle", BuffLogicBase)
BuffLogicCoffinMusumeChangeDefenceByCandle = BuffLogicCoffinMusumeChangeDefenceByCandle

function BuffLogicCoffinMusumeChangeDefenceByCandle:Constructor(buffInstance, logicParam)
  self._trapID = tonumber(logicParam.trapID)
  self._mulVal = tonumber(logicParam.mulVal)
  self._uiText = logicParam.uiText
end

function BuffLogicCoffinMusumeChangeDefenceByCandle:DoLogic()
  local candleCount = 0
  local tLightCandleID = {}
  local globalTrapEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, eTrap in ipairs(globalTrapEntities) do
    if not eTrap:Trap():GetTrapID() ~= self._trapID and eTrap:HasBuff() and eTrap:BuffComponent():GetBuffValue(BattleConst.CandleLightKey) == 1 then
      candleCount = candleCount + 1
      table.insert(tLightCandleID, eTrap:GetID())
    end
  end
  self._buffLogicService:RemoveBaseDefence(self._entity, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage)
  local val = self._mulVal * candleCount
  self._buffLogicService:ChangeBaseDefence(self._entity, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage, val)
  return BuffResultCoffinMusumeChangeDefenceByCandle:New(tLightCandleID, self._uiText, val)
end

function BuffLogicCoffinMusumeChangeDefenceByCandle:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicResetCoffinMusumeChangeDefence", BuffLogicBase)
BuffLogicResetCoffinMusumeChangeDefence = BuffLogicResetCoffinMusumeChangeDefence

function BuffLogicResetCoffinMusumeChangeDefence:DoLogic()
  self._buffLogicService:RemoveBaseDefence(self._entity, self:GetBuffSeq(), ModifyBaseDefenceType.DefencePercentage)
end
