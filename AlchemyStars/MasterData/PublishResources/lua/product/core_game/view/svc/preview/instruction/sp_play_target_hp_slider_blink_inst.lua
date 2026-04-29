require("sp_base_inst")
_class("SkillPreviewPlayTargetHpSliderBlinkInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayTargetHpSliderBlinkInstruction = SkillPreviewPlayTargetHpSliderBlinkInstruction

function SkillPreviewPlayTargetHpSliderBlinkInstruction:Constructor(params)
  self._compareType = tonumber(params.compareType)
  self._compareParam = tonumber(params.compareParam)
end

function SkillPreviewPlayTargetHpSliderBlinkInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local targetIDList = previewContext:GetTargetEntityIDList()
  targetIDList = table.unique(targetIDList)
  for _, id in pairs(targetIDList) do
    local entity = world:GetEntityByID(id)
    if entity and entity:HasView() and entity:HasHP() then
      local percent = entity:HP():GetRedHP() / entity:HP():GetMaxHP()
      local satisfied = false
      if self._compareType == ComparisonOperator.EQ then
        satisfied = percent == self._compareParam
      elseif self._compareType == ComparisonOperator.NE then
        satisfied = percent ~= self._compareParam
      elseif self._compareType == ComparisonOperator.GT then
        satisfied = percent > self._compareParam
      elseif self._compareType == ComparisonOperator.GE then
        satisfied = percent >= self._compareParam
      elseif self._compareType == ComparisonOperator.LT then
        satisfied = percent < self._compareParam
      elseif self._compareType == ComparisonOperator.LE then
        satisfied = percent <= self._compareParam
      end
      if satisfied then
        world:EventDispatcher():Dispatch(GameEventType.HPSliderBlink, entity:GetID(), true)
      end
    end
  end
end

_class("SkillPreviewStopTargetHpSliderBlinkInstruction", SkillPreviewBaseInstruction)
SkillPreviewStopTargetHpSliderBlinkInstruction = SkillPreviewStopTargetHpSliderBlinkInstruction

function SkillPreviewStopTargetHpSliderBlinkInstruction:Constructor(params)
end

function SkillPreviewStopTargetHpSliderBlinkInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local monsterGroup = world:GetGroup(world.BW_WEMatchers.MonsterID)
  for _, entity in ipairs(monsterGroup:GetEntities()) do
    if entity and entity:HasView() and entity:HasHP() then
      world:EventDispatcher():Dispatch(GameEventType.HPSliderBlink, entity:GetID(), false)
    end
  end
end
