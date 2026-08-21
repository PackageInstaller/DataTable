require("base_service")
_class("BattleDamageStatisticsServiceLogic", BaseService)
BattleDamageStatisticsServiceLogic = BattleDamageStatisticsServiceLogic

function BattleDamageStatisticsServiceLogic:Constructor(world)
end

function BattleDamageStatisticsServiceLogic:_OnGetBattleDamageStatisticsComponent()
  local battleDamageStatisticsComponent = self._world:BattleDamageStatistics()
  return battleDamageStatisticsComponent
end

function BattleDamageStatisticsServiceLogic:AddDamageStatisticsInfo(damageInfo)
  local matchType = self._world:MatchType()
  if matchType == MatchType.MT_BlackFist or matchType == MatchType.MT_Chess or matchType == MatchType.MT_EightPets or matchType == MatchType.MT_PopStar then
    return
  end
  local damageType = damageInfo:GetDamageType()
  if damageType == DamageType.Recover or damageType == DamageType.RecoverTransmit or damageType == DamageType.Miss or damageType == DamageType.Guard or damageType == DamageType.Invalid then
    return
  end
  local damageValue = damageInfo:GetHpAndShieldChangeValue()
  local casterID = damageInfo:GetDamageStatisticsAttackerEntityID()
  if casterID == nil then
    casterID = damageInfo:GetAttackerEntityID()
  end
  local defenderID = damageInfo:GetTargetEntityID()
  if not defenderID then
    return
  end
  if casterID == defenderID then
    Log.info("[AddDamageStatisticsInfo] casterID=" .. casterID .. " defenderID=" .. defenderID .. " damageValue=" .. damageValue)
    return
  end
  local defenderEntity = self._world:GetEntityByID(defenderID)
  if not defenderEntity then
    return
  end
  if not defenderEntity:HasMonsterID() and not defenderEntity:HasTrapID() then
    return
  end
  if defenderEntity:HasTrapID() then
    local trapCmpt = defenderEntity:Trap()
    if trapCmpt and trapCmpt:GetTrapType() == TrapType.Protected then
      return
    end
  end
  local damageStatisticsType = damageInfo:GetDamageStatisticsType()
  local skillID = damageInfo:GetSkillID()
  if damageStatisticsType == nil and skillID then
    local configSvc = self._world:GetService("Config")
    local skillConfigData = configSvc:GetSkillConfigData(skillID)
    local skillType = skillConfigData:GetSkillType()
    damageStatisticsType = skillType
    if skillType >= SkillType.Passive then
      damageStatisticsType = DamageStatisticsType.PetBuff
    end
  end
  local casterEntity = self._world:GetEntityByID(casterID)
  if casterEntity and casterEntity:HasSuperEntity() and casterEntity:EntityType():IsSkillHolder() then
    local superEntityComponent = casterEntity:SuperEntityComponent()
    local buffCasterEntityID = superEntityComponent:GetBuffSkillHolderCasterEntityID()
    if buffCasterEntityID then
      local buffCasterEntity = self._world:GetEntityByID(buffCasterEntityID)
      if buffCasterEntity then
        casterEntity = buffCasterEntity
      else
      end
    else
      local superEntity = superEntityComponent:GetSuperEntity()
      if superEntity then
        casterEntity = superEntity
      end
    end
    casterID = casterEntity:GetID()
  end
  local battleDamageStatistics = self:_OnGetBattleDamageStatisticsComponent()
  battleDamageStatistics:AddDamageStatisticsInfo(casterID, defenderID, math.floor(damageValue * -1), damageStatisticsType)
end

function BattleDamageStatisticsServiceLogic:GetDamageStatisticsInfo()
  self:_OnSortDamageStatisticsInfo()
  local battleDamageStatistics = self:_OnGetBattleDamageStatisticsComponent()
  local damageStatisticsDataList = battleDamageStatistics:GetDamageStatisticsDataList()
  return damageStatisticsDataList
end

function BattleDamageStatisticsServiceLogic:_OnSortDamageStatisticsInfo()
  local battleDamageStatistics = self:_OnGetBattleDamageStatisticsComponent()
  local damageStatisticsDataList = battleDamageStatistics:GetDamageStatisticsDataList()
  local allPetDamageValue = battleDamageStatistics:GetAllPetDamageValue()
  local sortDamageStatisticsDataList = {}
  local floorCount = 0
  for _, v in pairs(damageStatisticsDataList) do
    local damageStatisticsData = v
    local petDamage = damageStatisticsData:GetAllDamageValue()
    local percentage = 0
    local percentageFloor = 0
    if 0 < allPetDamageValue then
      percentage = petDamage / allPetDamageValue * 100
      percentageFloor = math.floor(petDamage / allPetDamageValue * 100)
    end
    damageStatisticsData:SetPercentage(percentage)
    damageStatisticsData:SetPercentageInt(percentageFloor)
    floorCount = floorCount + percentageFloor
    table.insert(sortDamageStatisticsDataList, damageStatisticsData)
  end
  table.sort(sortDamageStatisticsDataList, function(a, b)
    local decimalsA = a:GetPercentage() - a:GetPercentageInt()
    local decimalsB = b:GetPercentage() - b:GetPercentageInt()
    return decimalsA > decimalsB
  end)
  if 0 < floorCount then
    local needSupplementCount = 100 - floorCount
    for i = 1, needSupplementCount do
      local damageStatisticsData = sortDamageStatisticsDataList[i]
      if damageStatisticsData then
        local percentage = damageStatisticsData:GetPercentageInt()
        local percentageNew = percentage + 1
        local casterID = damageStatisticsData:GetCasterID()
        local targetDamageStatisticsData = battleDamageStatistics:GetDamageStatisticsInfoByCasterID(casterID)
        damageStatisticsData:SetPercentageInt(percentageNew)
      end
    end
  end
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  local petEntities = teamEntity:Team():GetTeamPetEntities()
  for i, e in ipairs(petEntities) do
    local entityID = e:GetID()
    local targetDamageStatisticsData = battleDamageStatistics:GetDamageStatisticsInfoByCasterID(entityID)
    if not targetDamageStatisticsData then
      battleDamageStatistics:AddDamageStatisticsInfo(entityID, -1, 0, DamageStatisticsType.PetBuff)
    end
  end
  local otherDamageStatisticsData = battleDamageStatistics:GetDamageStatisticsInfoByCasterID(-1)
  if not otherDamageStatisticsData then
    battleDamageStatistics:AddDamageStatisticsInfo(-1, -1, 0, DamageStatisticsType.PetBuff)
  end
end

function BattleDamageStatisticsServiceLogic:GetMonsterHPMaxStatistics()
  local battleDamageStatistics = self:_OnGetBattleDamageStatisticsComponent()
  local monsterHPMaxStatistics = battleDamageStatistics:GetMonsterHPMaxStatistics()
  return monsterHPMaxStatistics
end

function BattleDamageStatisticsServiceLogic:AddMonsterHPMaxStatistics(hpMax)
  local battleDamageStatistics = self:_OnGetBattleDamageStatisticsComponent()
  battleDamageStatistics:AddMonsterHPMaxStatistics(hpMax)
end
