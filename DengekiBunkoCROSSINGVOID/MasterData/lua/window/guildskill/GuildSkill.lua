inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local m_guildSkills
local m_windowsOnTop = {}

function SetupWindow()
  WU.SetRuleCallback("GuildSkill", function()
    WU.AcquireWindowAsync("RuleCommon", function(ui)
      _ENV["$"](ui)["$$SetLabel"](WU.GetString("Help_GuildSkill"))
    end)
    m_windowsOnTop.RuleCommon = true
  end)
end

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  this:Bind("fci/guild/skill/", OnGuildSkillChange)
  this:Bind("fci/guild/", OnGuildChange)
  this:GameRequest("fci/profit/"):Get(function(profit)
    this:SetData("fci/profit/", profit)
  end)
end

function UninitWindow()
  ClearTopWindows()
end

function ClearTopWindows()
  for key, _ in pairs(m_windowsOnTop) do
    WU.RecycleWindow(key)
  end
  m_windowsOnTop = {}
end

function OnGuildSkillChange(guildSkills)
  m_guildSkills = guildSkills
  if m_guildSkills then
    REF.SkillList.gameObject:SetActive(m_guildSkills)
    if m_guildSkills then
      for i = 0, #REF.SkillList - 1 do
        REF.SkillList[i]["$$SetData"](m_guildSkills[i + 1], i)
      end
    end
  end
end

function OnGuildChange(guild)
  local guildScore = 0
  if guild then
    guildScore = guild.score
  end
  REF.LabelGuildScore.UIHtmlLabel.text = "<img src='ResIcon_s.ResGuildScore_0'/>" .. tostring(guildScore)
end

function Focus(on)
  WU.RecordWindowFocus(100162, on)
end
