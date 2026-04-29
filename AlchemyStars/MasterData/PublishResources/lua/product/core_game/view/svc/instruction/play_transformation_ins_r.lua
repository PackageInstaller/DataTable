_class("PlayTransformationInstruction", BaseInstruction)
PlayTransformationInstruction = PlayTransformationInstruction

function PlayTransformationInstruction:Constructor(paramList)
end

function PlayTransformationInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Transformation)
  for i = 1, #resultArray do
    local result = resultArray[i]
    local caster = world:GetEntityByID(result:GetCaster())
    local elementType = result:GetElementType()
    if not caster then
      Log.fatal("没有施法者，变身失败")
      return
    end
    local cfgService = world:GetService("Config")
    local monsterConfigData = cfgService:GetMonsterConfigData()
    local monsterResPath = monsterConfigData:GetMonsterResPath(result:GetMonsterID())
    local newPos = result:GetNewPos()
    if newPos then
      caster:SetPosition(newPos)
    end
    caster:ReplaceAsset(NativeUnityPrefabAsset:New(monsterResPath, true))
    local sMonsterShowRender = world:GetService("MonsterShowRender")
    sMonsterShowRender:CreateMonsterEffect(casterEntity, result:GetMonsterID())
    local transformationHp = result:GetTransformationHp()
    if transformationHp ~= 0 then
      local transformationHpMax = result:GetTransformationHpMax()
      caster:ReplaceRedAndMaxHP(transformationHp, transformationHpMax)
    end
    local sliderEntityID = caster:HP():GetHPSliderEntityID()
    local sliderEntity = world:GetEntityByID(sliderEntityID)
    TaskManager:GetInstance():CoreGameStartTask(InnerGameHelperRender:GetInstance().SetHpSliderElementIcon, InnerGameHelperRender:GetInstance(), sliderEntity, elementType)
    local utilDataSvc = world:GetService("UtilData")
    local hpBarType = utilDataSvc:GetHPBarTypeByEntity(caster)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossNameAndElement, result:GetMonsterID(), hpBarType, caster:GetID())
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UpdateBossElement, elementType, caster:GetID())
  end
end
