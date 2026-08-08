local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")

function SetData(guild)
  local guildIcon = "0"
  local guildName = ""
  local guildId = ""
  local guildBoard = ""
  local guildLevel = ""
  if guild then
    guildIcon = guild.icon
    guildName = guild.name
    guildId = guild.id
    guildBoard = guild.billboard
    guildLevel = WU.GetString("Window_Level", guild.level)
    WU.SetActive(REF.NodeMax, guild.level >= PB.index("GuildMisc", 1).maxGuildLevel)
  end
  REF.SpriteBadge.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", tonumber(guildIcon) or 1)
  REF.LabelName.UILabel.text = guildName
  REF.LabelId.UILabel.text = tostring(guildId)
  REF.LabelBulletin.UILabel.text = guildBoard
  REF.LabelLevel.UILabel.text = guildLevel
end
