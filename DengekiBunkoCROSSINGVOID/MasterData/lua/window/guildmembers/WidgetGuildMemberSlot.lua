local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local GU = require("Common/GuildUtil")
local U = require("Common/Util")
local m_member, m_callback, m_guildVote
local m_colorPrefix = ""
local m_colorSuffix = ""
local m_elapsedTime = 0
local m_updateInterval = 2

function Start()
  WU.BindButtonEvent(REF.Content, OnSlotClick)
  SetHighlight(false)
end

function OnEnable()
  this:Bind("fci/guild/vote/", OnGuildVoteChange)
end

function OnDisable()
  this:Unbind("fci/guild/vote/", OnGuildVoteChange)
end

function Update(delta)
  if m_member then
    m_elapsedTime = m_elapsedTime + delta
    if m_elapsedTime >= m_updateInterval then
      UpdateStatus()
      m_elapsedTime = m_elapsedTime - m_updateInterval
    end
  end
end

function OnGuildVoteChange(guildVote)
  m_guildVote = guildVote
  UpdateVote()
end

function SetData(member, index)
  m_member = member
  if m_member then
    local maxMemberCount = PB.index("GuildLevel", this:GetData("fci/guild").level).maxMemberCount
    m_elapsedTime = index * m_updateInterval / maxMemberCount
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"](m_member)
    local isMyself = m_member.playerId == this:GetData("playerId")
    REF.SpriteMore.UISprite.graify = isMyself
    REF.Content.BoxCollider2D.enabled = not isMyself
    m_colorPrefix = fif(isMyself, "<font color=#0090ff>", "")
    m_colorSuffix = fif(isMyself, "</font>", "")
    local memberType = ""
    if m_member.type ~= 0 then
      memberType = "<font size=32 color=#0090ff>" .. WU.GetString("Window_GuildMemberType_" .. m_member.type) .. "</font>"
    end
    REF.LabelName.UIHtmlLabel.text = m_colorPrefix .. m_member.name .. "&nbsp;" .. memberType .. m_colorSuffix
    REF.LabelLevel.UIHtmlLabel.text = m_colorPrefix .. WU.GetString("Window_Level", m_member.level) .. m_colorSuffix
    REF.LabelScore.UIHtmlLabel.text = m_colorPrefix .. WU.GetString("Window_GuildGuildScoreRecord") .. tostring(m_member.guildScoreRecord) .. m_colorSuffix
    REF.LabelLastWeekScore.UIHtmlLabel.text = m_colorPrefix .. WU.GetString("Window_GuildLastWeekGuildScoreRecord") .. tostring(m_member.lastWeekGuildScoreRecordTotal) .. m_colorSuffix
    UpdateStatus()
    UpdateVote()
  end
end

function UpdateVote()
  local showVote = m_guildVote and m_member and m_guildVote.endTime > CS.GameTime.serverUtc and GU.IsGuildPresident(m_member)
  WU.ToggleRendering(REF.NodeVote, showVote)
  if showVote then
    local voteYesCount = #m_guildVote.playersKick
    local voteNoCount = #m_guildVote.playersSupport
    REF.LabelYes.UILabel.text = tostring(voteYesCount)
    REF.LabelNo.UILabel.text = tostring(voteNoCount)
    REF.SpriteYes.UISprite.fillAmount = voteYesCount / (voteYesCount + voteNoCount)
  end
end

function UpdateStatus()
  REF.LabelStatus.UIHtmlLabel.text = m_colorPrefix .. fif(m_member.lastLogoutTime > 0, WU.RenderElpasedTime(CS.GameTime.serverUtc - m_member.lastLogoutTime), WU.GetString("Window_Online")) .. m_colorSuffix
end

function SetClickCallback(callback)
  m_callback = callback
end

function SetHighlight(value)
  REF.SpriteHighlight.gameObject:SetActive(value)
end

function OnSlotClick()
  if m_callback then
    m_callback(REF["$gameObject"])
  end
end
