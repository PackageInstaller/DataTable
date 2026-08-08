local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local m_guild, m_guildMembers, m_selectedSlot

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonApply, function()
    local guildId = m_guild.guildId
    if guildId and guildId ~= 0 then
      DB:GameRequest("fci/guild/" .. guildId .. "/pending-members/"):Put({
        playerId = DB:GetData("playerId")
      }, function()
        WU.ShowHintText(WU.GetString("Window_GuildApplicationSent"))
      end)
    end
  end)
end

function InitWindow()
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateRow
  })
end

function UninitWindow()
  m_guild = nil
  m_guildMembers = nil
end

function SetData(guild, members)
  m_guild = guild
  if m_guild then
    LU.Set(REF.WrapContent, 0)
    this:GameRequest("fci/guild-billboard/" .. m_guild.guildId .. "/"):Get(function(str)
      OnGuildMemebersChange(members)
      WU.SetLabel(REF.LabelGuildBoard, WU.GetString("Window_GuildAnnouncement") .. ": " .. str.billboard)
    end)
  end
  local guildPlayer = this:GetData("fci/guild-player/")
  local maxMemberCount = PB.index("GuildLevel", m_guild.guildLevel).maxMemberCount
  WU.SetLabel(REF.LabelGuildName, m_guild.guildName)
  WU.SetLabel(REF.LabelGuildLevel, "Lv." .. m_guild.guildLevel)
  WU.SetLabel(REF.LabelGuildId, "ID: " .. m_guild.guildId)
  WU.SetLabel(REF.LabelGuildMember, WU.GetString("Window_GuildMember") .. ": " .. m_guild.guildMemberCount .. "/" .. maxMemberCount)
  WU.SetLabel(REF.LabelGuildHeat, WU.GetString("Window_GuildScoreTitle") .. ": " .. m_guild.guildScore)
  WU.SetActive(REF.ButtonApply, guildPlayer == nil or guildPlayer.guildId == 0)
  REF.SpriteIcon.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", tonumber(m_guild.guildIcon) or 1) .. "s"
end

function OnGuildMemebersChange(guildMembers)
  m_guildMembers = _ENV["!"](guildMembers):values()
  table.sort(m_guildMembers, function(a, b)
    local onlineStatusA = fif(a.lastLogoutTime == 0, 1, 0)
    local onlineStatusB = fif(b.lastLogoutTime == 0, 1, 0)
    if onlineStatusA ~= onlineStatusB then
      return onlineStatusA > onlineStatusB
    elseif a.type ~= b.type then
      return a.type > b.type
    else
      return a.guildScoreRecord > b.guildScoreRecord
    end
  end)
  local memberCount = 0
  if m_guildMembers then
    memberCount = #m_guildMembers
  end
  LU.Set(REF.WrapContent, memberCount)
end

function UpdateRow(refRow, wrapIndex, realIndex)
  if m_guildMembers == nil or realIndex >= #m_guildMembers then
    return
  end
  local ref = _ENV["$"](refRow.root)
  local member = m_guildMembers[realIndex + 1]
  if member then
    local isMyself = member.playerId == this:GetData("playerId")
    local colorPrefix = fif(isMyself, "<font color=#0090ff>", "")
    local colorSuffix = fif(isMyself, "</font>", "")
    ref.LabelName.UIHtmlLabel.text = colorPrefix .. member.name .. colorSuffix
    ref.LabelPosition.UIHtmlLabel.text = colorPrefix .. WU.GetString("Window_GuildMemberType_" .. member.type) .. colorSuffix
    ref.LabelStatus.UIHtmlLabel.text = colorPrefix .. fif(member.lastLogoutTime > 0, WU.RenderElpasedTime(CS.GameTime.serverUtc - member.lastLogoutTime), WU.GetString("Window_Online")) .. colorSuffix
  end
end
