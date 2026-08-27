local PersistentDataBase = require("Game.PersistentManager.PersistentData.PersistentDataBase")
local DeploySaveData = class("DeploySaveData", PersistentDataBase)

function DeploySaveData:GetSaveDataFilePath()
  return PathConsts:GetPersistentDeployDataPath(PlayerDataCenter.strPlayerId, self.__fileName)
end

function DeploySaveData:ctor(fileName)
  self.__fileName = fileName
end

function DeploySaveData:InitBySaveData(table)
  self.hero_pos = table.hero_pos
end

function DeploySaveData:InitByDefaultData()
  self.hero_pos = {}
end

function DeploySaveData:IsPstDataDirty()
  return true
end

return DeploySaveData
