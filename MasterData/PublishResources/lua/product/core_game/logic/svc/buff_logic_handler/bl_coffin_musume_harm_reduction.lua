_class("BuffLogicCoffinMusumeHarmReduction", BuffLogicBase)
BuffLogicCoffinMusumeHarmReduction = BuffLogicCoffinMusumeHarmReduction

function BuffLogicCoffinMusumeHarmReduction:Constructor(buffInstance, logicParam)
  self._trapID = tonumber(logicParam.trapID)
  self._harmReduction = logicParam.harmReduction
  self._stage = logicParam.stage
  self._uiText = logicParam.uiText
end

function BuffLogicCoffinMusumeHarmReduction:DoLogic()
  local candleCount = 0
  local tLightCandleID = {}
  local globalTrapEntities = self._world:GetGroupEntities(self._world.BW_WEMatchers.Trap)
  for _, eTrap in ipairs(globalTrapEntities) do
    if not eTrap:Trap():GetTrapID() ~= self._trapID and eTrap:HasBuff() and eTrap:BuffComponent():GetBuffValue(BattleConst.CandleLightKey) == 1 then
      candleCount = candleCount + 1
      table.insert(tLightCandleID, eTrap:GetID())
    end
  end
  self._buffLogicService:RemoveFinalBeHitDamageParam(self._entity, self:GetBuffSeq())
  local val = self._harmReduction[candleCount + 1]
  if not val then
    Log.exception("CoffinMusumeHarmReduction: 亮灯数量与减伤参数不匹配，亮灯数=", candleCount, "参数连续最大个数=", #self._harmReduction)
    return
  end
  self._buffLogicService:ChangeFinalBeHitDamageParam(self._entity, self:GetBuffSeq(), val * -0.01)
  local lineList = {}
  local curStage = 1
  if 0 < candleCount and candleCount <= #self._stage then
    for i = 1, candleCount do
      if curStage < self._stage[i] then
        curStage = self._stage[i]
        local lineIndex = i + #lineList
        table.insert(lineList, lineIndex)
      end
    end
  end
  return BuffResultCoffinMusumeHarmReduction:New(tLightCandleID, self._uiText, val, lineList)
end

function BuffLogicCoffinMusumeHarmReduction:DoOverlap()
  return self:DoLogic()
end

_class("BuffLogicResetCoffinMusumeHarmReduction", BuffLogicBase)
BuffLogicResetCoffinMusumeHarmReduction = BuffLogicResetCoffinMusumeHarmReduction

function BuffLogicResetCoffinMusumeHarmReduction:DoLogic()
  self._buffLogicService:RemoveFinalBeHitDamageParam(self._entity, self:GetBuffSeq())
end
