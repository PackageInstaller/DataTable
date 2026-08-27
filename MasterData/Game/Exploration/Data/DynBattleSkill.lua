local DynBattleSkill = class("DynBattleSkill")
local CS_GameData_Ins = CS.GameData.instance
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local cs_FormulaUtility = CS.FormulaUtility
local cs_FilePathHelper = CS.FilePathHelper.Instance
local cs_ResManager = CS.ResManager.Instance

function DynBattleSkill:ctor(dataId, level, skillType, unlockAdvance)
  self.dataId = dataId
  self.level = level
  self.type = skillType
  self.itemId = 0
  self.unlockAdvance = unlockAdvance or false
  local skillcfg = ConfigData.battle_skill[self.dataId]
  if skillcfg == nil then
    error("battle skill cfg is null,id:" .. tostring(self.dataId))
    return
  end
  if not string.IsNullOrEmpty(skillcfg.lua_script) then
    require(PathConsts.LuaSkillScriptsPath .. skillcfg.lua_script)
  end
  self.__isFullLevel = false
  self.__adapterType = 0
  self.labelDic = ConfigData.battle_skill.skill_label_Dic[self.dataId]
end

function DynBattleSkill:Update(level)
  self.level = level
end

function DynBattleSkill:SetIsFullLevel(full)
  self.__isFullLevel = full
end

function DynBattleSkill:GetIsFullLevel()
  return self.__isFullLevel
end

function DynBattleSkill:SetSkillAdapterType(type)
  self.__adapterType = type
end

function DynBattleSkill:GetSkillAdapterType()
  return self.__adapterType
end

function DynBattleSkill:IsSpecialBanSkill()
  return self.__adapterType == ExplorationEnum.eSkillAdapterType.Ban
end

function DynBattleSkill:GetIsUnlock()
  return self.level > 0
end

function DynBattleSkill:IsPassiveSkill()
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return false
  end
  return skillCfg:IsPassiveSkill()
end

function DynBattleSkill:IsUniqueSkill()
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return false
  end
  return skillCfg:IsUltSkill()
end

function DynBattleSkill:CreateByChip(dataId, level, itemId)
  local skill = DynBattleSkill.New(dataId, level, eBattleSkillLogicType.Chip)
  skill.itemId = itemId
  return skill
end

function DynBattleSkill:GetLevelDescribe(level, unlockAdvance, isShowDetail)
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return nil
  end
  local lv = level or self.level
  local unAdv = unlockAdvance or self.unlockAdvance
  return skillCfg:GetLevelDescribe(lv, unAdv, isShowDetail)
end

function DynBattleSkill:GetIcon()
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return nil
  end
  return skillCfg.Icon
end

function DynBattleSkill:GetName()
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return nil
  end
  return skillCfg.Name
end

function DynBattleSkill:IsHideViewSkill()
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return true
  end
  return skillCfg.SkillIsShow
end

function DynBattleSkill:IsCommonAttack()
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return false
  end
  return skillCfg:IsCommonAttack()
end

function DynBattleSkill:GetSkillTag()
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return nil
  end
  return skillCfg.SkillTag
end

function DynBattleSkill:GetBattleSkillTypeColor()
  local skillCfg = CS_GameData_Ins.listBattleSkillDatas:GetDataById(self.dataId)
  if skillCfg == nil then
    error("找不到技能配置:" .. tostring(self.dataId))
    return nil
  end
  return skillCfg.TypeColor
end

function DynBattleSkill:GetSkillLabeIdList(level)
  if self.labelDic == nil then
    return
  end
  local compareLv = 1
  compareLv = level == nil and self.level or level
  local tab = {}
  local labelList = ConfigData.battle_skill.skill_label_List[self.dataId]
  for index, id in ipairs(labelList) do
    if self.labelDic[id] ~= nil and compareLv >= self.labelDic[id] then
      table.insert(tab, id)
    end
  end
  return tab
end

function DynBattleSkill:PreloadSkill(effectPoolCtrl, dynHero)
  local skillcfg = ConfigData.battle_skill[self.dataId]
  if skillcfg == nil then
    return
  end
  local resloader = effectPoolCtrl.resloader
  for _, effctId in pairs(skillcfg.effect_id) do
    local effectCfg = ConfigData.battle_creation[effctId]
    if effectCfg.src_name ~= nil then
      local loadType = effectCfg.load_type
      if loadType == 1 then
        local path = cs_FilePathHelper:GetSkinCharacterSkillEffectPath(dynHero:GetResModelName(), dynHero:GetResModelName(true), effectCfg.src_name)
        if not cs_ResManager:ContainsAsset(path) then
          path = effectCfg.base_src_path .. PathConsts.PrefabExtension
        end
        resloader:LoadABAsset(path)
      elseif loadType == 0 then
        resloader:LoadABAsset(effectCfg.src_name .. PathConsts.PrefabExtension)
      end
    end
  end
end

function DynBattleSkill:GetCurrentSkillCDTime()
  return cs_FormulaUtility.CalculateSkillCd(self.dataId, self.level)
end

function DynBattleSkill:GetSkillAdaptationSource()
  local skillCfg = ConfigData.hero_skill[self.dataId]
  if skillCfg ~= nil then
    return skillCfg.skill_adaption
  end
  return 0
end

function DynBattleSkill:SetSkillFromMonsterLabel(monsterLableId)
  self.__monsterLableId = monsterLableId
end

function DynBattleSkill:GetSkillMonsterLabel()
  return self.__monsterLableId
end

return DynBattleSkill
