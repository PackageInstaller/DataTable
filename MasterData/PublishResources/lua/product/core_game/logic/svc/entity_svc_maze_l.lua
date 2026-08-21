require("entity_svc_l")
_class("LogicEntityServiceMaze", LogicEntityService)
LogicEntityServiceMaze = LogicEntityServiceMaze

function LogicEntityServiceMaze:_InitPetAttributes(entity, petData, maxCastPower)
  local maxhp = petData:GetPetHealth()
  local hp = petData:GetPetCurHealth()
  local attack = petData:GetPetAttack()
  local defense = petData:GetPetDefence()
  local power = petData:GetPetPower()
  local legendPower = petData:GetPetLegendPower()
  local alchemyPower = petData:GetPetAlchemyPower()
  local afterDamage = petData:GetAfterDamage()
  local ready = 0
  if power == -1 then
    power = maxCastPower
  end
  if power == 0 then
    ready = 1
  end
  local exElementParam = petData:GetPropertyRestraint()
  local attributeComponent = entity:Attributes()
  attributeComponent:Modify("Attack", attack)
  attributeComponent:Modify("Defense", defense)
  attributeComponent:Modify("MaxPower", maxCastPower)
  attributeComponent:Modify("Power", power)
  attributeComponent:Modify("LegendPower", legendPower)
  attributeComponent:Modify("AlchemyPower", alchemyPower)
  attributeComponent:Modify("Ready", ready)
  attributeComponent:Modify("HP", hp)
  attributeComponent:Modify("MaxHP", maxhp)
  attributeComponent:Modify("AfterDamage", afterDamage)
  attributeComponent:Modify("ExElementParam", exElementParam)
  local utilData = self._world:GetService("UtilData")
  local extraActiveSkill = petData:GetPetExtraActiveSkill()
  if extraActiveSkill and 0 < #extraActiveSkill then
    local configService = self._configService
    for index, extraSkillID in ipairs(extraActiveSkill) do
      local activeSkillConfigData = configService:GetSkillConfigData(extraSkillID)
      if activeSkillConfigData then
        local skillTriggerType = activeSkillConfigData:GetSkillTriggerType()
        if skillTriggerType == SkillTriggerType.Energy then
          local skillTriggerParam = activeSkillConfigData:GetSkillTriggerParam()
          utilData:SetPetMaxPowerAttr(entity, skillTriggerParam, extraSkillID)
          utilData:SetPetPowerAttr(entity, skillTriggerParam, extraSkillID)
          local extraReady = 0
          if skillTriggerParam == 0 then
            extraReady = 1
          end
          utilData:SetPetSkillReadyAttr(entity, extraReady, extraSkillID)
        end
      end
    end
  end
  return hp, maxhp, defense
end
