local BuildingQueueCtrl = class("BuildingQueueCtrl", ControllerBase)
local BuildingBelong = require("Game.Oasis.Data.BuildingBelong")

function BuildingQueueCtrl:OnInit()
  self.__OnForceUpdateProcess = BindCallback(self, self.__ForceUpdateProcess)
  MsgCenter:AddListener(eMsgEventId.BuildingSendUpgradeComplete, self.__OnForceUpdateProcess)
end

function BuildingQueueCtrl:InitBuildQueueCtrl(buildingBelong)
  self._buildBelong = buildingBelong
  self:UpdateBuildingQueue(PlayerDataCenter.timestamp)
end

function BuildingQueueCtrl:UpdateBuildQueueSecond(timestamp, isSecond)
  self.__timeStamp = timestamp
  if isSecond then
    self:UpdateBuildingQueue(timestamp)
  end
end

function BuildingQueueCtrl:__ForceUpdateProcess()
  self:UpdateBuildingQueue(self.__timeStamp)
end

function BuildingQueueCtrl:UpdateBuildingQueue(timestamp)
  local builtDatas, queueCeiling
  if self._buildBelong == BuildingBelong.Sector then
    builtDatas = PlayerDataCenter.AllBuildingData.sectorBuilt
    queueCeiling = PlayerDataCenter.playerBonus:GetBuildQueueCount(eBuildQueueType.Sector)
  else
    builtDatas = PlayerDataCenter.AllBuildingData.oasisBuilt
    queueCeiling = PlayerDataCenter.playerBonus:GetBuildQueueCount(eBuildQueueType.Oasis)
  end
  local inQueCount = 0
  for k, v in pairs(builtDatas) do
    if v.state == proto_object_BuildingState.BuildingStateCreate or v.state == proto_object_BuildingState.BuildingStateUpgrade then
      self:__GenProgress(v, timestamp)
      inQueCount = inQueCount + 1
      if queueCeiling <= inQueCount then
        break
      end
    end
  end
end

function BuildingQueueCtrl:__GenProgress(builtData, timestamp)
  local progress, second, waitConfirmOver = builtData:GetProcess(timestamp)
  local remainTimeText = TimeUtil:TimestampToTime(second)
  MsgCenter:Broadcast(eMsgEventId.UpdateBuildingProcess, builtData.id, progress, remainTimeText, waitConfirmOver, second)
end

function BuildingQueueCtrl:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.BuildingSendUpgradeComplete, self.__OnForceUpdateProcess)
end

return BuildingQueueCtrl
