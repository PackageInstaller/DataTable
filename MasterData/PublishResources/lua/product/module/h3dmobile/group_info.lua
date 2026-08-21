_class("GroupToken", Object)
GroupToken = GroupToken

function GroupToken:Constructor()
  self.group_type = 0
  self.server_id = 0
  self.group_id = 0
end

GroupToken._proto = {
  [1] = {"group_type", "short"},
  [2] = {"server_id", "short"},
  [3] = {"group_id", "int64"}
}
_class("GroupAuthInfo", Object)
GroupAuthInfo = GroupAuthInfo

function GroupAuthInfo:Constructor()
  self.player_id = 0
  self.token = GroupToken:New()
  self.vkey = 0
end

GroupAuthInfo._proto = {
  [1] = {"player_id", "int64"},
  [2] = {"token", "GroupToken"},
  [3] = {"vkey", "int"}
}
