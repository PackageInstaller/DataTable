local ExplorationExRoomCtrl = class("ExplorationExRoomCtrl", ExplorationCtrlBase)
local base = ExplorationCtrlBase
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function ExplorationExRoomCtrl:ctor(epCtrl)
  self.epNetWork = NetworkManager:GetNetwork(NetworkTypeID.Exploration)
  self.__OnExRoomLogicEnd = BindCallback(self, self.OnExRoomLogicEnd)
end

function ExplorationExRoomCtrl:OnEpExRoomOpen(roomData, isFirst)
  if roomData.epExRoomData == nil then
    error("Can't find epExRoomData")
    self:OnExRoomLogicEnd()
    return
  end
  self.__epExRoomData = roomData.epExRoomData
  local exRoomCfg = ConfigData.exploration_exroom[self.__epExRoomData.id]
  if exRoomCfg == nil then
    error("exploration_exroom cfg is null,id:" .. tostring(self.__epExRoomData.id))
    self:OnExRoomLogicEnd()
    return
  end
  if exRoomCfg.exroom_type == ExplorationEnum.exRoomType.AvgRoom then
    local avgCtrl = ControllerManager:GetController(ControllerTypeId.Avg, true)
    avgCtrl:StartAvg(nil, exRoomCfg.para1, self.__OnExRoomLogicEnd)
    self.epCtrl.autoCtrl:OnEnterEpExRoom(exRoomCfg.exroom_type, true)
  else
    self:OnExRoomLogicEnd()
  end
end

function ExplorationExRoomCtrl:GetExRoomData()
  return self.__epExRoomData
end

function ExplorationExRoomCtrl:OnExRoomLogicEnd()
  self.epCtrl.autoCtrl:OnExitEpExRoom()
  self.epNetWork:CS_EXPLORATION_EX_OVER(function()
    self.__epExRoomData = nil
    MsgCenter:Broadcast(eMsgEventId.OnExitRoomComplete, ExplorationEnum.eExitRoomCompleteType.ExRoom)
  end)
end

function ExplorationExRoomCtrl:OnDelete()
  base.OnDelete(self)
end

return ExplorationExRoomCtrl
