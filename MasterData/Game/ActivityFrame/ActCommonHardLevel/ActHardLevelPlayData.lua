local ActHardLevelPlayData = class("ActHardLevelPlayData")
local ActHardLevelData = require("Game.ActivityFrame.ActCommonHardLevel.ActHardLevelData")

function ActHardLevelPlayData:ctor(activityBase)
  self._actFrameId = activityBase:GetActFrameId()
  self._activityBase = activityBase
  self._mainCfg = ConfigData.activity_hard_dungeon[self._actFrameId]
  self._dunDataList = {}
  self._dunDataDic = {}
  self:__GenAllDunData()
end

function ActHardLevelPlayData:__GenAllDunData()
  for index, dunStageId in ipairs(self._mainCfg.dungeon_id) do
    local data = ActHardLevelData.New(dunStageId, self._activityBase, self)
    self._dunDataList[index] = data
    self._dunDataDic[dunStageId] = data
  end
end

function ActHardLevelPlayData:AHLPD_RefreshByServerData(msg_elem)
  for dungeonId, data in pairs(msg_elem.hardDungeonDatas) do
    local dungeonLevelData = self._dunDataDic[dungeonId]
    if dungeonLevelData ~= nil then
      dungeonLevelData:ACHLD_SetRankInfo(data)
    end
  end
end

function ActHardLevelPlayData:AHLPD_GetActFreameId()
  return self._actFrameId
end

function ActHardLevelPlayData:AHLPD_GetDunDataList()
  return self._dunDataList
end

function ActHardLevelPlayData:AHLPD_GetRankId()
  return self._mainCfg.rank_id
end

function ActHardLevelPlayData:AHLPD_GetIsHaveNotSeen()
  for key, data in pairs(self._dunDataList) do
    if data:GetIsLevelUnlock() and not data:ACHLD_GetIsSeen() then
      return true
    end
  end
  return false
end

function ActHardLevelPlayData:AHLPD_SetAllSeen()
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for key, data in pairs(self._dunDataList) do
    if data:GetIsLevelUnlock() then
      local dunStageId = data:GetDungeonLevelStageId()
      userDataCache:SetCommonHardDunLevelIsSeen(self._actFrameId, dunStageId, true)
    end
  end
end

return ActHardLevelPlayData
