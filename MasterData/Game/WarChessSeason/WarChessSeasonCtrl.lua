local WarChessSeasonCtrl = class("WarChessSeasonCtrl")
local cs_ResLoader = CS.ResLoader
local eDynConfigData = require("Game.ConfigData.eDynConfigData")

function WarChessSeasonCtrl:ctor(seasonId, towerId, wcsEnvId)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_level)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_floor)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_item)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_general_env_pool)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_monster_change)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_tower_shop_drop)
  ConfigData:LoadDynCfg(eDynConfigData.warchess_season_stage_info)
  self.resloader = cs_ResLoader.Create()
  self.__wcSeasonId = seasonId
  self.__wcSeasonCfg = ConfigData.warchess_season[self.__wcSeasonId]
  self.__wcTowerId = towerId
  self.__wcsEnvId = wcsEnvId
  self.__wcsEnvCfg = ConfigData.warchess_general_env_pool[wcsEnvId]
  self.isInLobby = true
  self.isInFirstLobby = true
  self.__couldSelectWCLevelList = nil
  self.__formMsg = nil
  self.warChessSeasonFloor = 0
  self.wcsTotalScore = 0
  self.__curWCSRoomData = nil
end

function WarChessSeasonCtrl:EnterWCSeasonLobbyByMsg(lobbyMessage, isReconnect)
  self.__couldSelectWCLevelList = lobbyMessage.RoomData
  self.__formMsg = lobbyMessage.backLobbyReMainData.forms
  self.warChessSeasonFloor = lobbyMessage.backLobbyReMainData.warChessSeasonFloor
  self._initialProtocolDic = {}
  for _, buffId in ipairs(lobbyMessage.backLobbyReMainData.initialProtocol) do
    self._initialProtocolDic[buffId] = true
  end
  WarChessSeasonManager:SetOutSideInfo2WCManager()
  WarChessManager:EnterWarChessByOutMsg(lobbyMessage.backLobbyReMainData, isReconnect)
end

function WarChessSeasonCtrl:GetWCSInitUnlockDic()
  return self._initialProtocolDic or table.emptytable
end

function WarChessSeasonCtrl:CleanWCSInitUnlockDic()
  self._initialProtocolDic = nil
end

function WarChessSeasonCtrl:GetWCSTowerId()
  return self.__wcTowerId
end

function WarChessSeasonCtrl:GetWCSSeasonId()
  return self.__wcSeasonId
end

function WarChessSeasonCtrl:GetWCSSeasonCfg()
  return self.__wcSeasonCfg
end

function WarChessSeasonCtrl:GetWCSOfficialSupportCfgId()
  local towerID = WarChessSeasonManager:GetWCSSeasonTowerID()
  local floorIndex = self:WCSGetFloor()
  local floorCfg = ConfigData.warchess_season_floor[towerID][floorIndex]
  if floorCfg == nil then
    return 0
  end
  return floorCfg.assist_id
end

function WarChessSeasonCtrl:GetWCEnvId()
  return self.__wcsEnvId
end

function WarChessSeasonCtrl:GetWCEnvCfg()
  return self.__wcsEnvCfg
end

function WarChessSeasonCtrl:WCSGetLobbyNextRoomDataMsg()
  return self.__couldSelectWCLevelList
end

function WarChessSeasonCtrl:WCSGetFloor()
  return self.warChessSeasonFloor
end

function WarChessSeasonCtrl:WCSGetIsAtLastFloor()
  local curFloor = self:WCSGetFloor()
  local towerID = WarChessSeasonManager:GetWCSSeasonTowerID()
  local floorCfgs = ConfigData.warchess_season_floor[towerID]
  local maxFloor = #floorCfgs
  return curFloor >= maxFloor
end

function WarChessSeasonCtrl:WCSGetTotalScore()
  return self.wcsTotalScore
end

function WarChessSeasonCtrl:WCSSetTotalScore(wcsTotalScore)
  self.wcsTotalScore = wcsTotalScore
end

function WarChessSeasonCtrl:WCSSetSurWCSRoomData(curWCSRoomData)
  self.__curWCSRoomData = curWCSRoomData
end

function WarChessSeasonCtrl:WCSGetSurWCSRoomData()
  return self.__curWCSRoomData
end

function WarChessSeasonCtrl:GetWCSSeasonTipId()
  return self.__wcSeasonCfg.guide_id
end

function WarChessSeasonCtrl:Delete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.WCS3DUINode = nil
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_level)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_floor)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_item)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_general_env_pool)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_monster_change)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_tower_shop_drop)
  ConfigData:ReleaseDynCfg(eDynConfigData.warchess_season_stage_info)
end

return WarChessSeasonCtrl
