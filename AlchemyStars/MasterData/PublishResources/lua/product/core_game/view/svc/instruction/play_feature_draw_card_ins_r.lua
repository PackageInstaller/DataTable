require("base_ins_r")
_class("PlayFeatureDrawCardInstruction", BaseInstruction)
PlayFeatureDrawCardInstruction = PlayFeatureDrawCardInstruction

function PlayFeatureDrawCardInstruction:Constructor(paramList)
end

function PlayFeatureDrawCardInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local rsvcFeature = world:GetService("FeatureRender")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DrawCard)
  if not resultArray then
    return
  end
  for _, result in ipairs(resultArray) do
    local cardType = result:GetCardType()
    GameGlobal.EventDispatcher():Dispatch(GameEventType.FeatureUIPlayDrawCard, cardType)
  end
end
