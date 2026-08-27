local DynBattleRole = require("Game.Exploration.Data.DynBattleRole")
local DynBattleSkill = require("Game.Exploration.Data.DynBattleSkill")
local DynDungeonRole = class("DynDungeonRole", DynBattleRole)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_GameData = CS.GameData.instance

local function MonsterSkillSort(skill1, skill2)
  return skill1.dataId < skill2.dataId
end

function DynDungeonRole:ctor(monsterData)
  self.dataId = monsterData.stc.dataId
  self.uid = monsterData.stc.uid or self.dataId
  self.rank = monsterData.stc.rank
  self.roleTag = monsterData.stc.roleTag
  self.cat = monsterData.stc.cat
  self.modelSpecSign = monsterData.dyc.texture
  self.monsterCfg = ConfigData.monster[self.dataId]
  if self.monsterCfg == nil then
    error("neutral Cfg is null,id:" .. tostring(self.dataId))
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
  self.isShowHpText = self.monsterCfg.isShowHpText
  self.belong = eBattleRoleBelong.neutral
  self.onBench = false
  self.attackRange = self.monsterCfg.range
  self.moveSpeed = self.monsterCfg.moveSpd
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
  if BattleUtil.IsInTDBattle() and not BattleUtil.IsSpecialTDMode() then
    self.hpPer = self.hpPer + 1
  end
end

function DynDungeonRole:SetSummonerBelong(belong)
  self.belong = belong
end

function DynDungeonRole:GetMonsterInfo()
  return LanguageUtil.GetLocaleText(self.monsterCfg.info)
end

function DynDungeonRole:GetName()
  return LanguageUtil.GetLocaleText(self.monsterCfg.name)
end

function DynDungeonRole:GetCareer()
  return self.monsterCfg.career
end

function DynDungeonRole:GetCamp()
  return self.monsterCfg.camp
end

function DynDungeonRole:GetResPicName()
  if self.resCfg.res_Name == "professor" and not PlayerDataCenter:GetCmderSex() then
    return "professor_boy"
  end
  return self.resCfg.res_Name
end

function DynDungeonRole:GetResModelName(isDefault)
  return self.resCfg.res_Name
end

function DynDungeonRole:GetExtendResName()
  return self.resCfg.extend_res
end

function DynDungeonRole:GetResSrcId()
  return self.monsterCfg.src_id
end

function DynDungeonRole:GetRoleTag()
  return self.monsterCfg.monster_tag, false
end

return DynDungeonRole
