local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local GU = require("Common/GuildUtil")
local RU = require("Common/RedMarkUtil")
local LU = require("Common/ListUtil")
local m_recruitGuilds
local m_requestB4 = false

function SetupWindow()
  WU.BindButtonEvent(REF.TabInvitations, function()
    WU.RecordButtonClick(160006)
    REF.TabInvitations["$SetNew"](false)
    RU.SetRedMark("Relation/Guild/Invite", false)
  end)
  WU.TraverseChildren(REF.PageSwitch, function(go)
    local gasket = _ENV["$"](go).root
    CS.EventDelegate.Add(gasket.UIToggle.onChange, function()
      if REF.TabGuildRecruit.UIToggle.value then
        OnTabGuildRecruit()
      end
    end)
  end)
  LU.Bind(REF.WrapContentRecruit, {
    updateRow = UpdateRowRecruit
  })
end

function InitWindow()
  m_requestB4 = false
  REF.TabRecommendations.UIToggle.value = true
  this:SetData("GuildJoinNotified", false)
  this:Bind("guildId", ValidateRestrictions)
  this:Bind("fci/guild-player/invited/", OnGuildInvitationChange)
  RU.BindRedMark(this, "Relation/Guild/Invite", function(flag)
    REF.TabInvitations["$SetNew"](flag)
  end)
end

function Focus(on)
  WU.RecordWindowFocus(100160, on)
  if on then
    ValidateRestrictions(this:GetData("guildId"))
  end
end

function OnGuildInvitationChange(guildInvitation)
  RU.SetRedMark("Relation/Guild/Invite", guildInvitation and 0 < #guildInvitation)
end

function ValidateRestrictions(guildId)
  local top = WU.TopWindow()
  if top and top.name == this.name and 0 < guildId then
    local guildPlayer = this:GetData("fci/guild-player")
    if guildPlayer.type ~= PB.enum.GuildMemberType.President and not this:GetData("GuildJoinNotified") then
      this:SetData("GuildJoinNotified", true)
      WU.ShowMessageOK(WU.GetString("Window_JustJoinGuild"), function(result)
        local top = WU.TopWindow()
        if top and top.name == this.name then
          SwitchToGuild()
        end
      end)
    else
      SwitchToGuild()
    end
  end
end

function SwitchToGuild()
  if this:GetData("guildId") > 0 then
    WU.AcquireWindowAsync("Guild", nil, true)
  else
    WU.ShowHintText("Window_JustQuitGuild")
  end
end

function UpdateRowRecruit(refRow, wrapIndex, realIndex)
  if m_recruitGuilds == nil or realIndex >= #m_recruitGuilds then
    return
  end
  local ref = _ENV["$"](refRow.root)
  local content = m_recruitGuilds[realIndex + 1]
  local guildPlayer = this:GetData("fci/guild-player/")
  local maxMemberCount = PB.index("GuildLevel", content.guildLevel).maxMemberCount
  WU.SetLabel(ref.LabelName, content.guildName)
  WU.SetLabel(ref.LabelMember, content.guildMemberCount .. "/" .. maxMemberCount)
  WU.SetLabel(ref.LabelInfo, content.bulletinContent)
  WU.SetLabel(ref.LabelHeat, content.guildScore)
  WU.SetActive(ref.ButtonApply, guildPlayer == nil or guildPlayer.guildId == 0)
  ref.SpriteIcon.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", tonumber(content.guildIcon) or 1) .. "s"
  WU.ClearButtonEvent(ref.ButtonApply)
  WU.BindButtonEvent(ref.ButtonApply, function()
    local guildId = content.guildId
    if guildId and guildId ~= 0 then
      DB:GameRequest("fci/guild/" .. guildId .. "/pending-members/"):Put({
        playerId = DB:GetData("playerId")
      }, function()
        WU.ShowHintText(WU.GetString("Window_GuildApplicationSent"))
      end)
    end
  end)
  WU.ClearButtonEvent(ref.ButtonDetail)
  WU.BindButtonEvent(ref.ButtonDetail, function()
    this:GameRequest("fci/guild/" .. content.guildId .. "/members/"):Get(function(members)
      WU.AcquireWindowAsync("OtherGuildDetail", function(ui)
        _ENV["$"](ui)["$$SetData"](content, members)
      end)
    end)
  end)
end

function OnTabGuildRecruit()
  if m_requestB4 then
    return
  end
  REF.GuildListRecruit.gameObject:SetActive(false)
  this:GameRequest("fci/guild-recruit-recommend/"):Get(function(result)
    if result ~= nil then
      m_recruitGuilds = WU.CheckGuildExist(result.recruitContent)
      REF.NodeEmptyRecruit.gameObject:SetActive(#m_recruitGuilds <= 0)
      REF.GuildListRecruit.gameObject:SetActive(0 < #m_recruitGuilds)
      LU.Set(REF.WrapContentRecruit, #m_recruitGuilds)
      m_requestB4 = true
    end
  end)
end
