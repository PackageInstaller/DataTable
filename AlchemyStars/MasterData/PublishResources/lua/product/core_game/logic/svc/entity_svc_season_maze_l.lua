require("entity_svc_l")
_class("LogicEntityService_SeasonMaze", LogicEntityService)
LogicEntityService_SeasonMaze = LogicEntityService_SeasonMaze

function LogicEntityService_SeasonMaze:_InitPetAttributes(entity, petData, maxCastPower)
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
  hp, maxhp, defense = self:_HandleOutsideAttributes(entity)
  return hp, maxhp, defense
end

function LogicEntityService_SeasonMaze:_HandleOutsideAttributes(petEntity)
  if self._world:HasSeasonMazeLogic() then
    local seasonMazeComponent = self._world:SeasonMazeLogic()
    local modifyID = BattleConst.AttributesModifierIDBySeasonMaze
    local buffLSvc = self._world:GetService("BuffLogic")
    local atkRatio = seasonMazeComponent:GetOutsideAttributeByType(SeasonMazeAttrType.SMET_PetAttackRatio)
    if atkRatio then
      atkRatio = atkRatio * 0.001
      buffLSvc:ChangeBaseAttack(petEntity, modifyID, ModifyBaseAttackType.AttackPercentage, atkRatio)
    end
    local defRatio = seasonMazeComponent:GetOutsideAttributeByType(SeasonMazeAttrType.SMET_PetDefRatio)
    if defRatio then
      defRatio = defRatio * 0.001
      buffLSvc:ChangeBaseDefence(petEntity, modifyID, ModifyBaseDefenceType.DefencePercentage, defRatio)
    end
    local normalParam = seasonMazeComponent:GetOutsideAttributeByType(SeasonMazeAttrType.SMET_PetAttackDamageRatio)
    if normalParam then
      normalParam = normalParam * 0.001
      buffLSvc:ChangeSkillIncrease(petEntity, modifyID, ModifySkillIncreaseParamType.NormalSkill, normalParam)
    end
    local chainParam = seasonMazeComponent:GetOutsideAttributeByType(SeasonMazeAttrType.SMET_PetChainSkillDamageRatio)
    if chainParam then
      chainParam = chainParam * 0.001
      buffLSvc:ChangeSkillIncrease(petEntity, modifyID, ModifySkillIncreaseParamType.ChainSkill, chainParam)
    end
    local activeParam = seasonMazeComponent:GetOutsideAttributeByType(SeasonMazeAttrType.SMET_PetActiveSkillDamageRatio)
    if activeParam then
      activeParam = activeParam * 0.001
      buffLSvc:ChangeSkillIncrease(petEntity, modifyID, ModifySkillIncreaseParamType.ActiveSkill, activeParam)
    end
  end
  local attributesCmpt = petEntity:Attributes()
  local curHP = attributesCmpt:GetAttribute("HP")
  local maxHP = attributesCmpt:CalcMaxHp()
  local defence = attributesCmpt:GetDefence()
  return curHP, maxHP, defence
end
