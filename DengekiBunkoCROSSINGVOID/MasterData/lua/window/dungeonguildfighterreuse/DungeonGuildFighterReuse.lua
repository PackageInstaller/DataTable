inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_actor, m_type, m_guildId

function SetupWindow()
  WU.BindButtonEvent(REF.BtnConfirm, OnBtnConfirmClick)
  WU.BindButtonEvent(REF.BtnCancel, OnBtnCancelClick)
end

function InitWindow()
  this:Bind("guildId", function(guildId)
    m_guildId = guildId
    ValidateRestrictions(guildId)
  end)
end

function SetActor(actor)
  m_actor = actor
  REF.WidgetIconActor["$SetActor"](m_actor)
end

function OnBtnConfirmClick()
  local path = "fci/guild/" .. tostring(m_guildId) .. "/rent-actor/"
  this:GameRequest(path):Post({
    actorUid = m_actor.uid
  }, function(res)
    this:BroadcastGameEvent("DungeonGuildFighterSet")
    WU.RecycleWindow(this)
  end)
end

function OnBtnCancelClick()
  WU.RecycleWindow(this)
  WU.AcquireWindowAsync("DungeonGuildHelperSet")
end
