_class("SkillEffectCalc_EnterMirage", Object)
SkillEffectCalc_EnterMirage = SkillEffectCalc_EnterMirage

function SkillEffectCalc_EnterMirage:Constructor(world)
  self._world = world
end

function SkillEffectCalc_EnterMirage:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntityID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterEntityID)
  local mirageSvc = self._world:GetService("MirageLogic")
  mirageSvc:SetMirageOpen()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local trapRefreshID = param:GetTrapRefreshID()
  mirageSvc:SetTrapRefreshID(trapRefreshID)
  mirageSvc:SetMirageBossEntityID(casterEntityID)
  local monsterCreationSvc = self._world:GetService("MonsterCreationLogic")
  local initAttributes = {}
  local inheritAttributeList = param:GetInheritAttribute()
  local isUseAttribute = param:GetUseAttribute()
  local inheritCount = inheritAttributeList == nil and -1 or table.count(inheritAttributeList)
  local attributeCmpt = casterEntity:Attributes()
  local bHasMonsterId = casterEntity:HasMonsterID()
  if 0 < inheritCount and (bHasMonsterId or attributeCmpt ~= nil) then
    local nAttack, nDefense, nMaxHP
    if bHasMonsterId and isUseAttribute == 0 then
      local nCasterMonsterId = casterEntity:MonsterID():GetMonsterID()
      nAttack, nDefense, nMaxHP = monsterCreationSvc:GetCreateADH(nCasterMonsterId)
    else
      nAttack = attributeCmpt:GetAttribute("Attack")
      nDefense = attributeCmpt:GetAttribute("Defense")
      nMaxHP = attributeCmpt:CalcMaxHp()
    end
    if inheritAttributeList.Attack and nAttack ~= nil then
      initAttributes.Attack = nAttack * inheritAttributeList.Attack
    end
    if inheritAttributeList.Defense and nDefense ~= nil then
      initAttributes.Defense = nDefense * inheritAttributeList.Defense
    end
    if inheritAttributeList.MaxHP and nMaxHP ~= nil then
      initAttributes.MaxHP = nMaxHP * inheritAttributeList.MaxHP
      initAttributes.HP = nMaxHP * inheritAttributeList.MaxHP
    end
  end
  local inheritElement = param:GetInheritElement()
  if inheritElement then
    local oriEntity = casterEntity
    if casterEntity:HasSuperEntity() then
      oriEntity = casterEntity:GetSuperEntity()
    end
    if oriEntity:HasAttributes() then
      local attrCmpt = oriEntity:Attributes()
      initAttributes.Element = attrCmpt:GetAttribute("Element")
    end
  end
  mirageSvc:SetMirageTrapInheritAttributes(initAttributes)
  local result = SkillEffectEnterMirageResult:New()
  return result
end
