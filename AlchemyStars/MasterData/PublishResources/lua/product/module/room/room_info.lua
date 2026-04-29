local RoomType = {RT_ANY = 0, RT_EMPTY = 1}
_enum("RoomType", RoomType)
_class("RoomCreateInfo", Object)
RoomCreateInfo = RoomCreateInfo

function RoomCreateInfo:Constructor()
  self.room_type = RoomType.RT_EMPTY
  self.creator_id = 0
  self.max_player = 0
end

RoomCreateInfo._proto = {
  [1] = {"room_type", "int"},
  [2] = {"creator_id", "int64"},
  [3] = {"max_player", "int"}
}
_class("RoomSyncInfo", Object)
RoomSyncInfo = RoomSyncInfo

function RoomSyncInfo:Constructor()
  self.nick = ""
end

RoomSyncInfo._proto = {
  [1] = {"nick", "string"}
}
_class("RoomInfo", Object)
RoomInfo = RoomInfo

function RoomInfo:Constructor()
  self.room_type = 0
  self.room_token = GroupToken:New()
end

RoomInfo._proto = {
  [1] = {"room_type", "int"},
  [2] = {"room_token", "GroupToken"}
}
