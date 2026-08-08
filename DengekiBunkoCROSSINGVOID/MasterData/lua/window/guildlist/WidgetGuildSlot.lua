local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_callback
local m_highlight = false

function Start()
  SetHighlight(m_highlight)
  WU.BindButtonEvent(REF["$"], OnSlotClick)
end

function SetData(guild)
  if guild then
    local isMyGuild = guild.id == this:GetData("guildId")
    local colorPrefix = fif(isMyGuild, "<font color=#0072ff>", "")
    local colorSuffix = fif(isMyGuild, "</font>", "")
    REF.SpriteBadge.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", tonumber(guild.icon) or 1) .. "s"
    REF.LabelName.UIHtmlLabel.text = colorPrefix .. guild.name .. colorSuffix
    REF.LabelLevel.UIHtmlLabel.text = colorPrefix .. WU.GetString("Window_Level", guild.level) .. colorSuffix
    REF.LabelPresident.UIHtmlLabel.text = colorPrefix .. guild.presidentName .. colorSuffix
    REF.LabelGuildScore.UIHtmlLabel.text = colorPrefix .. guild.score .. colorSuffix
    local maxMemberCount = PB.index("GuildLevel", guild.level).maxMemberCount
    REF.LabelMemberCount.UIHtmlLabel.text = colorPrefix .. guild.membersCount .. "/" .. maxMemberCount .. colorSuffix
  end
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetHighlight(value)
  m_highlight = value
  REF.SpriteHighlight.gameObject:SetActive(value)
end

function OnSlotClick()
  if m_callback then
    m_callback(REF["$gameObject"])
  end
end
