local config = {}
config.CHANNLE_LIST = {
  [1] = {
    Util.format_str("系统"),
    "S Y S T E M"
  },
  [2] = {
    Util.format_str("世界"),
    "W O R L D"
  },
  [3] = {
    Util.format_str("公会"),
    "G U I L D"
  }
}
config.CHANNEL_TYPE = {
  SYSTEM = 1,
  WORLD = 2,
  GUILD = 3,
  TEAM = 4
}
config.Channnel_red_point = {
  [config.CHANNEL_TYPE.SYSTEM] = 2,
  [config.CHANNEL_TYPE.WORLD] = 3,
  [config.CHANNEL_TYPE.GUILD] = 4,
  [config.CHANNEL_TYPE.TEAM] = 5
}
config.chat_face = {}
for k, v in pairs(ShareRes.create("chat.chat_face")) do
  config.chat_face[v.face_character] = v
end
config.CHAT_TYPE = {
  FRIEND = 1,
  SYSTEM = 2,
  WORLD = 3,
  GUILD = 4,
  TEAM = 5
}
return config
