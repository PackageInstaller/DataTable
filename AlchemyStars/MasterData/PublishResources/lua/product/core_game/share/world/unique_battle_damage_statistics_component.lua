_class("BattleDamageStatisticsComponent", Object)
BattleDamageStatisticsComponent = BattleDamageStatisticsComponent

function BattleDamageStatisticsComponent:Constructor(world)
  self._world = world
  self._damageStatisticsInfo = {}
  self._allPetDamageValue = 0
  self._allMonsterHPMax = 0
end

function BattleDamageStatisticsComponent:GetDamageStatisticsDataList()
  return self._damageStatisticsInfo
end

function BattleDamageStatisticsComponent:GetDamageStatisticsInfoByCasterID(casterID)
  return self._damageStatisticsInfo[casterID]
end

function BattleDamageStatisticsComponent:GetAllPetDamageValue()
  return self._allPetDamageValue
end

function BattleDamageStatisticsComponent:AddMonsterHPMaxStatistics(hpMax)
  self._allMonsterHPMax = self._allMonsterHPMax + hpMax
end

function BattleDamageStatisticsComponent:GetMonsterHPMaxStatistics()
  return self._allMonsterHPMax
end

function BattleDamageStatisticsComponent:AddDamageStatisticsInfo(casterID, defenderID, damage, damageStatisticsType)
  local casterEntity = self._world:GetEntityByID(casterID)
  local petTemplateID = -1
  if casterEntity then
    if casterEntity:HasSummoner() and casterEntity:GetSummonerEntity() then
      casterEntity = casterEntity:GetSummonerEntity()
    end
    if casterEntity:HasSuperEntity() and casterEntity:GetSuperEntity() then
      casterEntity = casterEntity:GetSuperEntity()
    end
    local cPetPstID = casterEntity:PetPstID()
    if cPetPstID then
      petTemplateID = casterEntity:PetPstID():GetTemplateID()
      casterID = casterEntity:GetID()
    else
      Log.info("[AddDamageStatisticsInfo] caster is not pet")
      casterID = -1
    end
  elseif casterID ~= -1 then
    Log.info("[AddDamageStatisticsInfo] casterID is nil. casterID=" .. casterID .. " defenderID=" .. defenderID .. " damage=" .. damage)
    casterID = -1
  end
  if not self._damageStatisticsInfo[casterID] then
    self._damageStatisticsInfo[casterID] = BattleDamageStatisticsData:New(casterID, petTemplateID)
  end
  local curBattleDamageStatisticsData = self._damageStatisticsInfo[casterID]
  curBattleDamageStatisticsData:AddDamageStatistics(defenderID, damage, damageStatisticsType)
  self._allPetDamageValue = self._allPetDamageValue + damage
end

local DamageStatisticsType = {
  PetNormalSkill = 1,
  PetChainSkill = 2,
  PetActiveSkill = 3,
  PetBuff = 4,
  MAX = 9
}
_enum("DamageStatisticsType", DamageStatisticsType)
_class("BattleDamageStatisticsData", Object)
BattleDamageStatisticsData = BattleDamageStatisticsData

function BattleDamageStatisticsData:Constructor(casterID, petTemplateID)
  self._casterID = casterID
  self._petTemplateID = petTemplateID
  self._petNormalDamageList = {}
  self._petChainDamageList = {}
  self._petActiveDamageList = {}
  self._petBuffDamageList = {}
  self._allDamageValue = 0
  self._percentage = 0
  self._percentageInt = 0
  self._petNormalDamageValue = 0
  self._petChainDamageValue = 0
  self._petActiveDamageValue = 0
  self._petBuffDamageValue = 0
end

function BattleDamageStatisticsData:AddDamageStatistics(defenderID, damage, damageStatisticsType)
  local curStatisticsInfo = {defenderID = defenderID, damage = damage}
  if damageStatisticsType == DamageStatisticsType.PetNormalSkill then
    table.insert(self._petNormalDamageList, curStatisticsInfo)
    self._petNormalDamageValue = self._petNormalDamageValue + damage
  elseif damageStatisticsType == DamageStatisticsType.PetChainSkill then
    table.insert(self._petChainDamageList, curStatisticsInfo)
    self._petChainDamageValue = self._petChainDamageValue + damage
  elseif damageStatisticsType == DamageStatisticsType.PetActiveSkill then
    table.insert(self._petActiveDamageList, curStatisticsInfo)
    self._petActiveDamageValue = self._petActiveDamageValue + damage
  elseif damageStatisticsType == DamageStatisticsType.PetBuff then
    table.insert(self._petBuffDamageList, curStatisticsInfo)
    self._petBuffDamageValue = self._petBuffDamageValue + damage
  else
    table.insert(self._petBuffDamageList, curStatisticsInfo)
    self._petBuffDamageValue = self._petBuffDamageValue + damage
  end
  self._allDamageValue = self._allDamageValue + damage
end

function BattleDamageStatisticsData:GetCasterID()
  return self._casterID
end

function BattleDamageStatisticsData:GetPetTemplateID()
  return self._petTemplateID
end

function BattleDamageStatisticsData:GetAllDamageValue()
  return self._allDamageValue
end

function BattleDamageStatisticsData:GetPercentage()
  return self._percentage
end

function BattleDamageStatisticsData:SetPercentage(percentage)
  self._percentage = percentage
end

function BattleDamageStatisticsData:GetPercentageInt()
  return self._percentageInt
end

function BattleDamageStatisticsData:SetPercentageInt(percentageInt)
  self._percentageInt = percentageInt
end

function BattleDamageStatisticsData:GetPetNormalDamageValue()
  return self._petNormalDamageValue
end

function BattleDamageStatisticsData:GetPetChainDamageValue()
  return self._petChainDamageValue
end

function BattleDamageStatisticsData:GetPetActiveDamageValue()
  return self._petActiveDamageValue
end

function BattleDamageStatisticsData:GetPetBuffDamageValue()
  return self._petBuffDamageValue
end

function MainWorld:BattleDamageStatistics()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.BattleDamageStatistics)
end

function MainWorld:HasBattleDamageStatistics()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.BattleDamageStatistics) ~= nil
end

function MainWorld:AddBattleDamageStatistics()
  local index = self.BW_UniqueComponentsEnum.BattleDamageStatistics
  local component = BattleDamageStatisticsComponent:New(self)
  self:SetUniqueComponent(index, component)
end

function MainWorld:RemoveBattleDamageStatistics()
  if self:HasBattleDamageStatistics() then
    self:SetUniqueComponent(self.BW_UniqueComponentsEnum.BattleDamageStatistics, nil)
  end
end
