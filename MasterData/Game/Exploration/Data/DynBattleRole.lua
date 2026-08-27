local DynChipHolder = require("Game.Exploration.Data.DynChipHolder")
local DynBattleRole = class("DynBattleRole", DynChipHolder)
local cs_GameData = CS.GameData.instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local HeroAttrUtility = require("Game.Exploration.Data.HeroAttrUtility")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")

function DynBattleRole:ctor()
  self.fightingPower = 0
  self.modelSpecSign = 0
  self.breakId = 0
  self.__monsterLableId = nil
  self.__monsterLableCfg = nil
end

function DynBattleRole:SetCoord(coord, benchRow)
  self.coord = coord
  self.x, self.y = BattleUtil.Pos2XYCoord(coord)
  if benchRow then
    self.onBench = benchRow <= self.x
  else
    self.onBench = false
  end
end

function DynBattleRole:SetCoordXY(x, y, benchRow)
  self.coord = BattleUtil.XYCoord2Pos(x, y)
  self.x = x
  self.y = y
  if benchRow then
    self.onBench = benchRow <= self.x
  else
    self.onBench = false
  end
end

function DynBattleRole:SetBattleBench(onbench)
  self._battleOnBench = onbench
end

function DynBattleRole:ResetBattleBench()
  self._battleOnBench = nil
end

function DynBattleRole:GetName()
end

function DynBattleRole:GetCareer()
end

function DynBattleRole:GetCamp()
end

function DynBattleRole:GetResPicName()
end

function DynBattleRole:GetResModelName(isDefault)
end

function DynBattleRole:GetExtendResName()
end

function DynBattleRole:GetResSrcId()
end

function DynBattleRole:GetSkinId()
  return 0
end

function DynBattleRole:GetOvrideBindPoints()
  if self.resCfg == nil then
    return nil
  end
  return self.resCfg.overide_bind_point
end

function DynBattleRole:GetCarrerIcon()
  local careerId = self:GetCareer()
  local career = ConfigData.career[careerId]
  if career == nil then
    return nil
  end
  return career.icon
end

function DynBattleRole:GetCampIcon()
  local campId = self:GetCamp()
  local camp = ConfigData.camp[campId]
  if camp == nil then
    return nil
  end
  return camp.icon
end

function DynBattleRole:GetOriginSkillList()
  return self.originSkillList
end

function DynBattleRole:OffsetAttrFromChip(property, value)
  HeroAttrUtility.OffsetAttrFromDynHero(self, property, value)
end

function DynBattleRole:UpdateHpPer(hpPer)
  self.hpPer = hpPer
end

function DynBattleRole:SetExtraAttr(attrId, value)
  self.extraAttr[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

function DynBattleRole:SetBaseAttr(attrId, value)
  self.baseAttr[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

function DynBattleRole:SetRatioAttr(attrId, value)
  self.ratioAttr[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

function DynBattleRole:GetClientOriginAttr(attrId)
  return 0
end

function DynBattleRole:GetOriginAttr(attrId)
  return self.originAttr[attrId] or 0
end

function DynBattleRole:GetBaseAttr(attrId)
  return self.baseAttr[attrId] or 0
end

function DynBattleRole:GetRatioAttr(attrId)
  return self.ratioAttr[attrId] or 0
end

function DynBattleRole:GetExtraAttr(attrId)
  return self.extraAttr[attrId] or 0
end

function DynBattleRole:GetRealAttr(attrId)
  return ((self.originAttr[attrId] or 0) + (self.baseAttr[attrId] or 0)) * (eHeroAttrPercent + (self.ratioAttr[attrId] or 0)) // eHeroAttrPercent + (self.extraAttr[attrId] or 0)
end

function DynBattleRole:CopyAttrFromBattleCharacterEntity(entity)
  for i = 0, entity.originAttrList.Length - 1 do
    self.originAttr[i] = entity.originAttrList[i]
    self.baseAttr[i] = entity.baseAttrList[i]
    self.ratioAttr[i] = entity.ratioAttrList[i]
    self.extraAttr[i] = entity.extraAttrList[i]
  end
  local hp = entity.hp
  local hpPer = hp * 10000 // entity.maxHp
  if hpPer == 0 and 0 < hp then
    hpPer = 1
  end
  self.hpPer = hpPer
end

function DynBattleRole:GetFormulaAttr(attrId)
  if attrId == eHeroAttr.hp then
    local maxHp = self:GetRealAttr(eHeroAttr.maxHp)
    local hp = self.hpPer * maxHp // ExplorationEnum.eHeroHpPercent
    if hp == 0 and self.hpPer > 0 then
      hp = 1
    end
    return hp
  elseif attrId == eHeroAttr.attack_range then
    return self.attackRange
  else
    return self:GetRealAttr(attrId)
  end
end

function DynBattleRole:GetSkillFightingPower(heroPower)
  local skillList = {}
  local skillDic = {}
  if self.originSkillList ~= nil then
    for k, v in pairs(self.originSkillList) do
      table.insert(skillList, v)
      skillDic[v.dataId] = v
    end
  end
  if self.__itemSkillDic ~= nil then
    for k, v in pairs(self.__itemSkillDic) do
      local oldSkill = skillDic[k.dataId]
      if oldSkill == nil or k.level > oldSkill.level then
        if oldSkill then
          table.removebyvalue(skillList, oldSkill)
        end
        table.insert(skillList, k)
        skillDic[k.dataId] = k
      end
    end
  end
  local fightingPower = 0
  for k, battleSkill in pairs(skillList) do
    local battleCfg = ConfigData.battle_skill[battleSkill.dataId]
    if battleCfg ~= nil and battleCfg.skill_comat ~= "" then
      local isChipType = battleSkill.type == eBattleSkillLogicType.Chip or battleSkill.type == eBattleSkillLogicType.TempChip
      local power = PlayerDataCenter:GetBattleSkillFightPower(battleSkill.dataId, battleSkill.level, heroPower, isChipType)
      fightingPower = fightingPower + power
    end
  end
  return fightingPower
end

function DynBattleRole:GetFightingPower(fullHp)
  if self.originAttr == nil then
    warn("GetFightingPower:originAttr is nil")
    return 0
  end
  local attrDic = self:GetDynBattleRoleAttrDic()
  local heroPower = 0
  if fullHp then
    heroPower = ConfigData.GetFormulaValue(eFormulaType.Hero, attrDic)
  elseif self.belong == eBattleRoleBelong.enemy then
    heroPower = ConfigData.GetFormulaValue(eFormulaType.BattleHeroEnemy, attrDic)
  else
    heroPower = ConfigData.GetFormulaValue(eFormulaType.BattleHero, attrDic)
  end
  local fightingPower = heroPower + self:GetSkillFightingPower(heroPower)
  fightingPower = math.floor(fightingPower)
  fightingPower = fightingPower + (self._extraFixedPower or 0)
  self.fightingPower = fightingPower
  return fightingPower
end

function DynBattleRole:GetDynBattleRoleAttrDic()
  local attrDic = table.GetDefaulValueTable(0)
  for i = 1, ConfigData.attribute.maxPropertyId - 1 do
    attrDic[i] = self:GetFormulaAttr(i)
  end
  return attrDic
end

function DynBattleRole:GetAttackRangeType()
  if self.attackRange > 1 then
    return 2
  else
    return 1
  end
end

function DynBattleRole:IsDead()
  return self.hpPer <= 0
end

function DynBattleRole:SetExtraFixedPower(combat)
  self._extraFixedPower = combat
end

function DynBattleRole:GetExtraFixedPower()
  return self._extraFixedPower
end

function DynBattleRole:GetTowerCastCdFormula()
  return 0
end

function DynBattleRole:GetMonsterDieRewardFormula()
  return 0
end

function DynBattleRole:GetTowerCastCostFormula()
  return 0
end

function DynBattleRole:GetTowerLoadOffFormula()
  return 0
end

function DynBattleRole:GetRawAttr(rawAttributionID)
  if self.rawAttr == nil then
    return 0
  end
  return self.rawAttr[rawAttributionID] or 0
end

function DynBattleRole:GetStandardMoveSpd()
  return self.resCfg.base_move_spd
end

function DynBattleRole:SetMonsterLableId(monsterLableId)
  if monsterLableId == nil or monsterLableId <= 0 then
    return
  end
  self.__monsterLableId = monsterLableId
  self.__monsterLableCfg = ConfigData.monster_lable[monsterLableId]
  if self.__monsterLableCfg == nil then
    error("monsterLableCfg not exist lableId:" .. tostring(monsterLableId))
    return
  end
  self:__GenMonsterLableSkills()
end

function DynBattleRole:GetIsHaveMonsterLable()
  return self.__monsterLableId ~= nil
end

function DynBattleRole:GetMonsterLableIsHideAfterStartBattle()
  if self:GetIsHaveMonsterLable() then
    return not self.__monsterLableCfg.label_onBattle
  else
    return false
  end
end

function DynBattleRole:GetMonsterLableEffectIsHideAfterStartBattle()
  return not self.__monsterLableCfg.fx_onBattle
end

function DynBattleRole:GetMonsterLableId()
  return self.__monsterLableId
end

function DynBattleRole:GetMonsterLableCfg()
  return self.__monsterLableCfg
end

function DynBattleRole:__GenMonsterLableSkills()
  self:RemoveItemSkillTypeDic({
    [eBattleSkillLogicType.Lable] = true
  })
  local skillList = self.__monsterLableCfg.skill_group
  for _, athSkillId in pairs(skillList) do
    local skillLevel = 1
    local skillData = DynBattleSkill.New(athSkillId, skillLevel, eBattleSkillLogicType.Lable)
    skillData:SetSkillFromMonsterLabel(self.__monsterLableId)
    self:AddItemSkill(skillData)
  end
end

function DynBattleRole:GetMonsterLableEffectId()
  local label_fx = self.__monsterLableCfg.label_fx
  if label_fx == nil or label_fx == 0 then
    return nil
  end
  return label_fx
end

function DynBattleRole:GetMonsterLableMatCfgId()
  local label_mat = self.__monsterLableCfg.label_mat
  if label_mat == nil or label_mat == 0 then
    return nil
  end
  return label_mat
end

return DynBattleRole
