_class("SMazeFactory", Object)
SMazeFactory = SMazeFactory

function SMazeFactory:Constructor(mn)
  self._manager = mn
  self._cardType = {}
  self._propType = {
    [SeasonMazeEffectType.SMET_Once_Shoe] = SMazeProp_Boot,
    [SeasonMazeEffectType.SMET_Once_Retrun] = SMazeProp_TP,
    [SeasonMazeEffectType.SMET_Once_Sprint] = SMazeProp_Rush,
    [SeasonMazeEffectType.SMET_Once_Bomb] = SMazeProp_Bomb
  }
  self._roomType = {
    [SeasonMazeRoomType.SMRT_PVE] = SMazeMapRoom_Battle,
    [SeasonMazeRoomType.SMRT_Random] = SMazeMapRoom_RandomEvent,
    [SeasonMazeRoomType.SMRT_Resource] = SMazeMapRoom_Resource,
    [SeasonMazeRoomType.SMRT_Ore] = SMazeMapRoom_Ore,
    [SeasonMazeRoomType.SMRT_Box] = SMazeMapRoom_Box,
    [SeasonMazeRoomType.SMRT_Round] = SMazeMapRoom_RoundBonus,
    [SeasonMazeRoomType.SMRT_Empty] = SMazeMapRoom_Empty,
    [SeasonMazeRoomType.SMRT_Camp] = SMazeMapRoom_Camp,
    [SeasonMazeRoomType.SMRT_Altar] = SMazeMapRoom_Altar,
    [SeasonMazeRoomType.SMRT_Market] = SMazeMapRoom_FleaMarket,
    [SeasonMazeRoomType.SMRT_PetRecruit] = SMazeMapRoom_DirectionalRecruit,
    [SeasonMazeRoomType.SMRT_Transfor] = SMazeMapRoom_Transport,
    [SeasonMazeRoomType.SMRT_Shop] = SMazeMapRoom_Shop,
    [SeasonMazeRoomType.SMRT_BeadShop] = SMazeMapRoom_Bead
  }
end

function SMazeFactory:Dispose()
end

function SMazeFactory:CreateCard(typeID, ...)
  return SMazeCard:New(typeID)
end

function SMazeFactory:CreateProp(id, count)
  local cfg = Cfg.cfg_component_season_maze_once({OnceID = id})
  if cfg or 0 < #cfg then
    cfg = cfg[1]
  end
  local typeID = cfg.Type
  local type = self._propType[typeID]
  local prop = type:New(id, count, typeID)
  return prop
end

function SMazeFactory:CreateRoom(typeID, ...)
  local type = self._roomType[typeID]
  if not type then
    Log.exception("房间类型错误:", typeID)
  end
  local room = type:New(...)
  return room
end
