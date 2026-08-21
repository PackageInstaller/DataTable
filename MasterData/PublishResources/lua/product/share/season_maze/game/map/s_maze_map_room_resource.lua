require("s_maze_map_room_base")
_class("SMazeMapRoom_Resource", SMazeMapRoomBase)
SMazeMapRoom_Resource = SMazeMapRoom_Resource

function SMazeMapRoom_Resource:Constructor()
end

function SMazeMapRoom_Resource:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomResources", self:NodeID())
end

function SMazeMapRoom_Resource:OnTriggerComplete(asset)
  if asset then
    if asset:Type() == SeasonMazeEffectType.SMET_Pro then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.OnUISeasonMazeAttChanged, asset:SubParam())
    elseif asset:Type() == SeasonMazeEffectType.SMET_Bead then
    end
    self:SetAwardAssets({asset})
  end
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  self:Finish()
end
