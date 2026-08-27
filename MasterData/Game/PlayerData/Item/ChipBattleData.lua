local ChipBattleData = class("ChipBattleData")
local CS_BattleManager_Ins = CS.BattleManager.Instance
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local HeroAttrUtility = require("Game.Exploration.Data.HeroAttrUtility")
local ChipEnum = require("Game.PlayerData.Item.ChipEnum")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local PlayerSelectorFunc = {
  [ChipEnum.eChipInfluenceType.AllHero] = function(roleList, validRoleDic, influenceArg)
    for k, role in ipairs(roleList) do
      validRoleDic[role] = true
    end
  end,
  [ChipEnum.eChipInfluenceType.Camp] = function(roleList, validRoleDic, influenceArg)
    for k, role in ipairs(roleList) do
      if role:GetCamp() == influenceArg then
        validRoleDic[role] = true
      end
    end
  end,
  [ChipEnum.eChipInfluenceType.Career] = function(roleList, validRoleDic, influenceArg)
    for k, role in ipairs(roleList) do
      if role:GetCareer() == influenceArg then
        validRoleDic[role] = true
      end
    end
  end,
  [ChipEnum.eChipInfluenceType.Row] = function(roleList, validRoleDic, influenceArg)
    for k, role in ipairs(roleList) do
      if role:GetAttackRangeType() == influenceArg then
        validRoleDic[role] = true
      end
    end
  end,
  [ChipEnum.eChipInfluenceType.HeroId] = function(roleList, validRoleDic, influenceArg)
    for k, role in ipairs(roleList) do
      if role.dataId == influenceArg then
        validRoleDic[role] = true
      end
    end
  end
}
local EnemySelectorFunc = {
  [ChipEnum.eChipInfluenceType.EnemyAllHero] = PlayerSelectorFunc[ChipEnum.eChipInfluenceType.AllHero],
  [ChipEnum.eChipInfluenceType.EnemyCamp] = PlayerSelectorFunc[ChipEnum.eChipInfluenceType.Camp],
  [ChipEnum.eChipInfluenceType.EnemyCareer] = PlayerSelectorFunc[ChipEnum.eChipInfluenceType.Career],
  [ChipEnum.eChipInfluenceType.EnemyRow] = PlayerSelectorFunc[ChipEnum.eChipInfluenceType.Row],
  [ChipEnum.eChipInfluenceType.EnemyHeroId] = PlayerSelectorFunc[ChipEnum.eChipInfluenceType.HeroId],
  [ChipEnum.eChipInfluenceType.DynEnemy] = function()
  end
}

function ChipBattleData:ctor(chipCfg, skillLevel, skillType)
  skillLevel = skillLevel or 1
  self.level = skillLevel
  self.chipCfg = chipCfg
  self.influenceType = self.chipCfg.influence
  self.influenceArg = self.chipCfg.arg
  self.attributeIdList = self.chipCfg.attribute_id
  local battleSkillType = skillType or eBattleSkillLogicType.Chip
  if self.influenceType == ChipEnum.eChipInfluenceType.PlayerConsume then
    battleSkillType = eBattleSkillLogicType.ChipConsume
  end
  if #self.chipCfg.skill_list > 0 then
    self.skillDataList = {}
    for k, skillId in ipairs(self.chipCfg.skill_list) do
      local skillData = DynBattleSkill.New(skillId, skillLevel, battleSkillType)
      skillData.itemId = self.chipCfg.id
      table.insert(self.skillDataList, skillData)
    end
  end
  self._validRoleDic = {}
end

function ChipBattleData:UpdateChipBattleLevel(level)
  if self.level == level then
    return
  end
  self.level = level
  if self.skillDataList ~= nil then
    for k, v in ipairs(self.skillDataList) do
      v:Update(level)
    end
  end
end

function ChipBattleData:ExecuteChipBattle(chipHolder)
  if chipHolder == nil then
    return false
  end
  if chipHolder:ContainChipEffector(self) then
    if isGameDev then
      error("该芯片效果已经生效:" .. tostring(self.chipCfg.id))
    end
    return false
  end
  for k, property in ipairs(self.attributeIdList) do
    local value = self.chipCfg.attribute_initial[k] + (self.chipCfg.level_increase[k] or 0) * (self.level - 1)
    chipHolder:OffsetAttrFromChip(property, value)
  end
  if self.skillDataList ~= nil then
    for k, v in ipairs(self.skillDataList) do
      chipHolder:AddItemSkill(v)
    end
  end
  chipHolder:AddChipEffector(self)
  return true
end

function ChipBattleData:RollbackChipBattle(chipHolder)
  if chipHolder == nil then
    return false
  end
  if not chipHolder:ContainChipEffector(self) then
    return false
  end
  for k, property in ipairs(self.attributeIdList) do
    local value = self.chipCfg.attribute_initial[k] + (self.chipCfg.level_increase[k] or 0) * (self.level - 1)
    chipHolder:OffsetAttrFromChip(property, -value)
  end
  if self.skillDataList ~= nil then
    for k, v in ipairs(self.skillDataList) do
      chipHolder:RemoveItemSkill(v)
    end
  end
  chipHolder:RemoveChipEffector(self)
  return true
end

function ChipBattleData:GetValidRoleList(dynBattleRoleList, belong, chipEffector)
  local result = {}
  if #dynBattleRoleList == 0 then
    return result
  end
  table.clearmap(self._validRoleDic)
  if belong == eBattleRoleBelong.player then
    if chipEffector ~= nil and chipEffector:HasSpecEffectCount() and chipEffector:ModifyChipValidRole(dynBattleRoleList, self._validRoleDic, self.influenceType, self.influenceArg) then
    else
      self:SelValidRoleListPlayer(dynBattleRoleList)
    end
  else
    local selectorFunc = EnemySelectorFunc[self.influenceType]
    if selectorFunc ~= nil then
      selectorFunc(dynBattleRoleList, self._validRoleDic, self.influenceArg)
    end
  end
  for k, v in ipairs(dynBattleRoleList) do
    if self._validRoleDic[v] ~= nil then
      table.insert(result, v)
    end
  end
  return result
end

function ChipBattleData:SelValidRoleListPlayer(dynBattleRoleList)
  local selectorFunc = PlayerSelectorFunc[self.influenceType]
  if selectorFunc ~= nil then
    selectorFunc(dynBattleRoleList, self._validRoleDic, self.influenceArg)
  end
end

function ChipBattleData:IsValidDynPlayer()
  return self.influenceType == ChipEnum.eChipInfluenceType.DynPlayer or self.influenceType == ChipEnum.eChipInfluenceType.PlayerConsume
end

function ChipBattleData:IsConsumeChipBattle()
  return self.influenceType == ChipEnum.eChipInfluenceType.PlayerConsume
end

function ChipBattleData:IsForEnemyChipBattle()
  return EnemySelectorFunc[self.influenceType] ~= nil
end

function ChipBattleData:IsForDynEnemyChipBattle()
  return self.influenceType == ChipEnum.eChipInfluenceType.DynEnemy
end

function ChipBattleData:SetOnlyForOneHero(heroId)
  self.influenceType = ChipEnum.eChipInfluenceType.HeroId
  self.influenceArg = heroId
end

function ChipBattleData:IsForHeroIDChipBattle()
  return self.influenceType == ChipEnum.eChipInfluenceType.HeroId
end

function ChipBattleData:GetVaildRoleCountWithOutBench()
  local vaildRoleCount = 0
  for heroData, v in pairs(self._validRoleDic) do
    if not heroData.onBench then
      vaildRoleCount = vaildRoleCount + 1
    end
  end
  return vaildRoleCount
end

return ChipBattleData
