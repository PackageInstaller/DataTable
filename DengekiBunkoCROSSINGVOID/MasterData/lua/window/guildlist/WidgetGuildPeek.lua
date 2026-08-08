local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_guild

function Start()
  WU.BindButtonEvent(REF.ButtonDetail, OnDetailClick)
end

function SetData(guild)
  m_guild = guild
  REF.WidgetGuildProfile["$SetData"](m_guild)
  local guildMemberCount = 0
  local maxMemberCount = 0
  local guildScore = 0
  if m_guild then
    guildMemberCount = m_guild.membersCount
    maxMemberCount = PB.index("GuildLevel", m_guild.level).maxMemberCount
    guildScore = m_guild.score
  end
  REF.LabelMemberCount.UILabel.text = guildMemberCount .. "/" .. maxMemberCount
  REF.LabelGuildScore.UILabel.text = tostring(guildScore)
end

function OnDetailClick(go)
  WU.RecordButtonClick(160005)
  if m_guild then
    WU.AcquireWindowAsync("GuildDetail", function(ui)
      _ENV["$"](ui)["$$SetData"](m_guild)
    end)
  end
end
