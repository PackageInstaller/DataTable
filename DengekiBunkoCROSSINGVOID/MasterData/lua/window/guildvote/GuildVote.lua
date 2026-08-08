inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local m_guildVote
local m_voteFinished = false

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonYes, OnYesClick)
  WU.BindButtonEvent(REF.ButtonNo, OnNoClick)
end

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  this:Bind("fci/guild/vote/", OnGuildVoteChange)
end

function UpdateWindow()
  UpdateVoteTiming()
end

function OnYesClick()
  this:GameRequest("fci/guild/{guildId}/vote/"):Post({voteSupport = false}, function(result)
    this:SetData("fci/guild/vote/", result)
    WU.RecycleWindow(this)
  end)
end

function OnNoClick()
  this:GameRequest("fci/guild/{guildId}/vote/"):Post({voteSupport = true}, function(result)
    this:SetData("fci/guild/vote/", result)
    WU.RecycleWindow(this)
  end)
end

function OnGuildVoteChange(guildVote)
  m_guildVote = guildVote
  if m_guildVote then
    UpdateVoteInfo()
    UpdateVoteTiming()
  end
end

function UpdateVoteInfo()
  local guildMisc = PB.index("GuildMisc", 1)
  REF.LabelTips.UIHtmlLabel.text = WU.GetString("Window_GuildVoteTips", WU.RenderCountDownTime(guildMisc.voteStartPresidentLeave, REF.LabelTips.UIHtmlLabel.fontSize, false, true))
  local voteYesCount = #m_guildVote.playersKick
  local voteNoCount = #m_guildVote.playersSupport
  REF.LabelYesCount.UILabel.text = tostring(voteYesCount)
  REF.LabelNoCount.UILabel.text = tostring(voteNoCount)
  REF.SpriteYes.UISprite.fillAmount = voteYesCount / (voteYesCount + voteNoCount)
end

function UpdateVoteTiming()
  if m_guildVote and not m_voteFinished then
    if m_guildVote.endTime > CS.GameTime.serverUtc then
      local timeLeft = m_guildVote.endTime - CS.GameTime.serverUtc
      REF.LabelTimeLeft.UIHtmlLabel.text = WU.GetString("Window_GuildVoteCountDown") .. WU.RenderCountDownTime(timeLeft, REF.LabelTimeLeft.UIHtmlLabel.fontSize)
    else
      WU.ShowMessageOK(WU.GetString("Window_GuildVoteJustFinished"), function(result)
        local top = WU.TopWindow()
        if top and top.name == this.name then
          WU.RecycleWindow(this)
        end
      end)
      m_voteFinished = true
    end
  end
end
