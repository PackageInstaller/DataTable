require("s_maze_map_room_base")
_class("SMazeMapRoom_Box", SMazeMapRoomBase)
SMazeMapRoom_Box = SMazeMapRoom_Box

function SMazeMapRoom_Box:Constructor()
end

function SMazeMapRoom_Box:OnTrigger()
  self:BindEvent(GameEventType.OnSeasonMazeRoomOperationFinish, self.OnTriggerComplete)
  self:ShowDialog("UISeasonMazeRoomBox", self:NodeID())
end

function SMazeMapRoom_Box:OnTriggerComplete(awardEfts)
  local relicEft
  if awardEfts and 0 < #awardEfts then
    local assets = {}
    for _, eft in ipairs(awardEfts) do
      if eft.type == SeasonMazeEffectType.SMET_Relic then
        relicEft = eft
      else
        local asset = SeasonMazeTool:GetInstance():Effect2Asset(eft, eft.value_min)
        table.insert(assets, asset)
      end
    end
    self:SetAwardAssets(assets)
  end
  self:UnBindEvent(GameEventType.OnSeasonMazeRoomOperationFinish)
  if relicEft then
    Log.info("[SMazeClient] 宝箱房奖励圣物")
    SMazeAdaptor.OnRelicObtained({relicEft}, SMazeRelicReason.Box)
    return
  end
  self:Finish()
end
