_class("SkillEffectCalc_EachGridAddBuff", Object)
SkillEffectCalc_EachGridAddBuff = SkillEffectCalc_EachGridAddBuff

function SkillEffectCalc_EachGridAddBuff:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_EachGridAddBuff:DoSkillEffectCalculator(skillEffectCalcParam)
  local layerCount = 0
  local targetPieces = skillEffectCalcParam.skillEffectParam:GetPieceTypes()
  for _, pos in ipairs(skillEffectCalcParam.skillRange) do
    if targetPieces then
      local isMatch = self._skillEffectService:_IsGridElementMatch(pos, targetPieces)
      if isMatch then
        layerCount = layerCount + 1
      end
    else
      layerCount = layerCount + 1
    end
  end
  local result = self:_CalculateAddBuffSinglePosResult(layerCount, skillEffectCalcParam)
  return result
end

function SkillEffectCalc_EachGridAddBuff:_CalculateAddBuffSinglePosResult(layerCount, skillEffectCalcParam)
  local skillEffectCalc = SkillEffectCalc_AddBuff:New(self._world)
  local effectParam = skillEffectCalcParam.skillEffectParam
  effectParam:SetBuffInitLayer(layerCount)
  local tResults = skillEffectCalc:DoSkillEffectCalculator(skillEffectCalcParam)
  for _, r in ipairs(tResults) do
    local eid = r:GetEntityID()
    local e = self._world:GetEntityByID(eid)
    local newBuffArray = r:GetAddBuffResult()
    local cBuff = e:BuffComponent()
    for _, seq in ipairs(newBuffArray) do
      local inst = cBuff:GetBuffBySeq(seq)
      local layer = inst:GetLayerCount()
      r:SetBuffInitLayer(layer)
    end
  end
  return tResults
end
