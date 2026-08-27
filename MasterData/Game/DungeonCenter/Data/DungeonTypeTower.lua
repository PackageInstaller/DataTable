local DungeonTypeTower = class("DungeonTypeTower")
local DungeonLevelTower = require("Game.DungeonCenter.Data.DungeonLevelTower")

function DungeonTypeTower:ctor(typeId, noGenList)
  self.__typeId = typeId
  self.__towerTypeCfg = ConfigData.dungeon_tower_type[typeId]
  self.__listGened = false
  noGenList = noGenList or false
  if not noGenList then
    self:GenTowerLevelListData()
  end
end

function DungeonTypeTower:GenTowerLevelListData()
  if self.__listGened then
    return
  end
  self.__listGened = true
  self.__towerLevelList = {}
  for num, levelId in pairs(self.__towerTypeCfg.tower_list) do
    local towerLevelData = DungeonLevelTower.New(levelId)
    towerLevelData:BindLevelTowerTypeData(self)
    self.__towerLevelList[num] = towerLevelData
  end
end

function DungeonTypeTower:GetDungeonTowerTypeId()
  return self.__typeId
end

function DungeonTypeTower:GetTowerLevelList()
  return self.__towerLevelList
end

function DungeonTypeTower:GetTowerLevelByNum(num)
  return self.__towerLevelList[num]
end

function DungeonTypeTower:GetTowerTotalLevel()
  return self.__towerTypeCfg.total_level
end

function DungeonTypeTower:GetTowerRankId()
  return self.__towerTypeCfg.rank_id
end

function DungeonTypeTower:IsTypeTwinTower()
  return self.__towerTypeCfg.tower_cat == 1
end

function DungeonTypeTower:IsTypeHeax()
  return false
end

function DungeonTypeTower:GetTowerCategory()
  return self.__towerTypeCfg.tower_cat
end

function DungeonTypeTower:GetDungeonTowerName()
  return LanguageUtil.GetLocaleText(self.__towerTypeCfg.tower_name)
end

function DungeonTypeTower:GetDungeonTowerDesc()
  return LanguageUtil.GetLocaleText(self.__towerTypeCfg.tower_des)
end

function DungeonTypeTower:GetDungeonTowerLvName()
  return LanguageUtil.GetLocaleText(self.__towerTypeCfg.level_name)
end

function DungeonTypeTower:GetTowerFormationRuleId()
  return self.__towerTypeCfg.formation_rule
end

function DungeonTypeTower:GetTowerRewardInfo()
  return self.__towerTypeCfg.tower_reward_ids, self.__towerTypeCfg.tower_reward_nums
end

function DungeonTypeTower:GetDungeonTowerSystemName()
  local systemName = LanguageUtil.GetLocaleText(ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_DungeonTower].name)
  return systemName
end

function DungeonTypeTower:GetTowerAvgNounType()
  return ConfigData.noun_des_type.spec_noun[1]
end

function DungeonTypeTower:GetTowerAvgNounNumInfo()
  local nounList = ConfigData.noun_des.typeListDic[self:GetTowerAvgNounType()]
  local totalNum = #nounList
  local unlockCount = 0
  local unReadCount = 0
  local userSaveData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for _, desId in pairs(nounList) do
    local nounDesCfg = ConfigData.noun_des[desId]
    if CheckCondition.CheckLua(nounDesCfg.pre_condition, nounDesCfg.pre_para1, nounDesCfg.pre_para2) then
      unlockCount = unlockCount + 1
      if not userSaveData:GetAvgNounIsRead(desId) then
        unReadCount = unReadCount + 1
      end
    end
  end
  return totalNum, unlockCount, unReadCount
end

function DungeonTypeTower:GetTowerRacingCfg()
  local racingCfg = ConfigData.dungeon_tower_racing[self.__typeId]
  return racingCfg
end

return DungeonTypeTower
