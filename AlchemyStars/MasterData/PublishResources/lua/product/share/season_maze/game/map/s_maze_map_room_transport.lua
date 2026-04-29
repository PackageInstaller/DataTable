require("s_maze_map_room_base")
_class("SMazeMapRoom_Transport", SMazeMapRoomBase)
SMazeMapRoom_Transport = SMazeMapRoom_Transport

function SMazeMapRoom_Transport:OnTrigger()
  Log.debug("SMazeMapRoom_Transport 到达传递点房间 : ", self:NodeID())
  if not self:Node():TransRoomTargetID() then
    self:Finish()
    return
  end
  local node = self:Node()
  self._seasonMazeMgr = GameGlobal.GetUIModule(SeasonMazeModule):SeasonMazeManager()
  local cpt = self._seasonMazeMgr:GetMazeComponent()
  GameGlobal.TaskManager():StartTask(function(TT)
    local res = AsyncRequestRes:New()
    GameGlobal.UIStateManager():Lock("SMazeMapRoom_Transport:HandleSeasonMazeRoomTransfer")
    cpt:HandleSeasonMazeRoomTransfer(TT, res, self:Node():TransRoomTargetID())
    GameGlobal.UIStateManager():UnLock("SMazeMapRoom_Transport:HandleSeasonMazeRoomTransfer")
    if not res:GetSucc() then
      Log.error("HandleSeasonMazeRoomTransfer 消息失败:", res:GetResult())
      if GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res) then
        return
      end
      return
    end
    self:Finish()
  end)
end

function SMazeMapRoom_Transport:OnTriggerComplete()
end
