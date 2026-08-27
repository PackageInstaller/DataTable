local HexaTowerData = class("HexaTowerData")
local DungeonLevelTower = require("Game.DungeonCenter.Data.DungeonLevelTower")

function HexaTowerData:ctor(towerId)
  self.__typeId = towerId
  self.__towerTypeCfg = ConfigData.env_dungeon_tower[towerId]
  self.__listGened = false
  self:GenTowerLevelListData()
end

function HexaTowerData:GenTowerLevelListData()
  if self.__towerLevelList ~= nil then
    return
  end
  self.__towerLevelList = {}
  local levelList = ConfigData.env_dungeon_tower_dungeon_detail.tower2DunDic[self.__typeId]
  for num, levelId in pairs(levelList) do
    local towerLevelData = DungeonLevelTower.New(levelId, true)
    towerLevelData:BindLevelTowerTypeData(self)
    self.__towerLevelList[num] = towerLevelData
  end
end

function HexaTowerData:GetDungeonTowerTypeId()
  return self.__typeId
end

function HexaTowerData:GetTowerLevelList()
  return self.__towerLevelList
end

function HexaTowerData:GetTowerLevelByNum(num)
  return self.__towerLevelList[num]
end

function HexaTowerData:GetTowerTotalLevel()
  return #ConfigData.env_dungeon_tower_dungeon_detail.tower2DunDic[self.__typeId]
end

function HexaTowerData:GetTowerRankId()
  return self.__towerTypeCfg.rank_id
end

function HexaTowerData:IsTypeTwinTower()
  return false
end

function HexaTowerData:IsTypeHeax()
  return true
end

function HexaTowerData:GetDungeonTowerName()
  return LanguageUtil.GetLocaleText(self.__towerTypeCfg.tower_name)
end

function HexaTowerData:GetDungeonTowerDesc()
  return LanguageUtil.GetLocaleText(self.__towerTypeCfg.tower_des)
end

function HexaTowerData:GetDungeonTowerLvName()
  return LanguageUtil.GetLocaleText(self.__towerTypeCfg.tower_name)
end

function HexaTowerData:GetTowerFormationRuleId()
  return self.__towerTypeCfg.formation_rule
end

function HexaTowerData:GetTowerRewardInfo()
  return self.__towerTypeCfg.show_rewards_list
end

function HexaTowerData:GetDungeonTowerSystemName()
  local systemName = LanguageUtil.GetLocaleText(ConfigData.system_open[proto_csmsg_SystemFunctionID.SystemFunctionID_SixHeroTower].name)
  return systemName
end

function HexaTowerData:GetTowerAvgNounType()
  return ConfigData.noun_des_type.spec_noun[1]
end

function HexaTowerData:GetTowerAvgNounNumInfo()
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

function HexaTowerData:GetTowerRacingCfg()
  local racingCfg = ConfigData.env_dungeon_tower_speed_reward[self.__typeId]
  return racingCfg
end

function HexaTowerData:GetIsPeriodic()
  return 0 < (self.__towerTypeCfg.start_time or 0)
end

return HexaTowerData
