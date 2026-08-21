_class("PlayChangeElementInstruction", BaseInstruction)
PlayChangeElementInstruction = PlayChangeElementInstruction

function PlayChangeElementInstruction:Constructor(paramList)
end

function PlayChangeElementInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.ChangeElement)
  if #resultArray == 0 then
    return
  end
  local result = resultArray[1]
  local target = world:GetEntityByID(result:GetTarget())
  local elementType = result:GetElementType()
  if not target then
    Log.fatal("没有施法者，变身失败")
    return
  end
  local sliderEntityID = target:HP():GetHPSliderEntityID()
  local sliderEntity = world:GetEntityByID(sliderEntityID)
  TaskManager:GetInstance():CoreGameStartTask(InnerGameHelperRender:GetInstance().SetHpSliderElementIcon, InnerGameHelperRender:GetInstance(), sliderEntity, elementType)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossElement, elementType, target:GetID())
end
