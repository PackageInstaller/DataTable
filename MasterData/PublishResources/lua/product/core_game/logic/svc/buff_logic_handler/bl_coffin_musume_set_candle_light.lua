_class("BuffLogicCoffinMusumeSetCandleLight", BuffLogicBase)
BuffLogicCoffinMusumeSetCandleLight = BuffLogicCoffinMusumeSetCandleLight

function BuffLogicCoffinMusumeSetCandleLight:Constructor(buffInstance, logicParam)
  self._light = tonumber(logicParam.light)
end

function BuffLogicCoffinMusumeSetCandleLight:DoLogic()
  local cBuff = self:GetEntity():BuffComponent()
  local isLightBefore = cBuff:GetBuffValue(BattleConst.CandleLightKey) == 1 or false
  self:GetEntity():BuffComponent():SetBuffValue(BattleConst.CandleLightKey, self._light)
  self._world:GetService("Trigger"):Notify(NTCoffinMusumeLightChanged:New())
  return BuffResultCoffinMusumeSetCandleLight:New(isLightBefore, self._light)
end
