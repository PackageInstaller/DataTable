local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynMonster = class("DynMonster", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

local function MonsterSkillSort(skill1, skill2)
  return skill1.dataId < skill2.dataId
end

function DynMonster:ctor(monsterData)
  self.dataId = monsterData.stc.dataId
  self.uid = monsterData.stc.uid or self.dataId
  self.cat = monsterData.stc.cat
  self.roleTag = monsterData.stc.roleTag
  self.roleWave = monsterData.stc.roleWave
  self.rank = monsterData.stc.rank
  self.stage = monsterData.stc.stage
  self.parentUid = monsterData.stc.parentUid
  self.isTowerAbandonMove = false
  self.monsterCfg = ConfigData.monster[self.dataId]
  self.modelSpecSign = monsterData.dyc.texture
  if self.monsterCfg == nil then
    error("monster Cfg is null,id:" .. tostring(self.dataId))
    return
  end
  self.resCfg = ConfigData.resource_model[self.monsterCfg.src_id]
  if self.resCfg == nil then
    error("resource model cfg is null,id:" .. tostring(self.monsterCfg.src_id))
    return
  end
  self.isShowStateBar = self.monsterCfg.isShowStateBar
  self.isShowInfoBar = self.monsterCfg.isShowInfoBar
  self.isContainAction = self.monsterCfg.contain_action
  self.belong = eBattleRoleBelong.enemy
  self.onBench = false
  self.attackRange = self.monsterCfg.range
  self.moveSpeed = self.monsterCfg.move_spd
  self.intensity = self.monsterCfg.intensity
  self.breakId = monsterData.stc.breakId
  self.baseAttr = {}
  self.ratioAttr = {}
  self.extraAttr = {}
  self.originAttr = {}
  if monsterData.stc ~= nil and monsterData.stc.attr ~= nil then
    for i = 2, eHeroAttr.max_property_count + 1 do
      self.originAttr[i - 1] = monsterData.stc.attr[i]
    end
  end
  self.originSkillList = {}
  for skillId, skillLevel in pairs(monsterData.stc.skillGroup) do
    local battleSkill = DynBattleSkill.New(skillId, skillLevel, eBattleSkillLogicType.Original)
    table.insert(self.originSkillList, battleSkill)
  end
  table.sort(self.originSkillList, MonsterSkillSort)
  self.coordination = monsterData.dyc.coordination
  self:SetCoord(monsterData.dyc.coordination)
  self.hpPer = monsterData.dyc.hpPer
  self.death_frames = self.resCfg.death_frames
  self.isContainAction = true
  self.priority = 1
  self.fixedSkillSequence = self.monsterCfg.skill_array
  self.targetDeployPosX = 0
  self.targetDeployPosY = 0
  self:InitTowerMonsterData()
  self:SetMonsterLableId(monsterData.stc.monsterLable)
end

function DynMonster:SetDynMonTargetDeployPos(x, y)
  self.targetDeployPosX = x
  self.targetDeployPosY = y
end

function DynMonster:InitTowerMonsterData()
  if (BattleUtil.IsInTDBattle() or BattleUtil.IsSpecialTDMode()) and self.cat == BattleUtil.battleRoleCat.waitToCasterMonster then
    local towerCfg = ConfigData.tower_monster_data[self.dataId]
    if towerCfg == nil then
      error("找不到指定id的塔防怪物:" .. self.dataId)
      return
    end
    self.towerDieRewardFormula = towerCfg.coin_gain_formula
  end
end

function DynMonster:GetMonsterInfo()
  return LanguageUtil.GetLocaleText(self.monsterCfg.info)
end

function DynMonster:GetName()
  if self.__monsterLableCfg ~= nil then
    return LanguageUtil.GetLocaleText(self.__monsterLableCfg.monster_prefix) .. LanguageUtil.GetLocaleText(self.monsterCfg.name)
  end
  return LanguageUtil.GetLocaleText(self.monsterCfg.name)
end

function DynMonster:GetCareer()
  return self.monsterCfg.career
end

function DynMonster:GetCamp()
  return self.monsterCfg.camp
end

function DynMonster:GetResPicName()
  return self.resCfg.res_Name
end

function DynMonster:GetResModelName(isDefault)
  return self.resCfg.res_Name
end

function DynMonster:GetExtendResName()
  return self.resCfg.extend_res
end

function DynMonster:GetResSrcId()
  return self.monsterCfg.src_id
end

function DynMonster:GetRoleTag()
  return self.monsterCfg.monster_tag, false
end

function DynMonster:GetBossBloodNum()
  return self.monsterCfg.blood_bar_num
end

function DynMonster:GetMonsterDieRewardFormula()
  return self.towerDieRewardFormula
end

function DynMonster:GetDynMonsterStageGroup()
  return self.monsterCfg.group
end

function DynMonster:IsStageMonster()
  return self.stage > 0
end

function DynMonster:SetMonsterHasMoreStage(maxStage)
  self._maxStage = maxStage
end

function DynMonster:MonsterHasMoreStage()
  return self.parentUid > 0
end

function DynMonster:GetMonsterMaxStage()
  return self._maxStage
end

function DynMonster:IsGiantBoss()
  return self.monsterCfg.is_giant_boss == 1
end

return DynMonster
