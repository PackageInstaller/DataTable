local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local GU = require("Common/GuildUtil")
local DBH = require("Manager/DataBindingHandler")
local m_badge = 1

function Start()
  WU.BindButtonEvent(REF.EditBadge, OnEditBadgeClick)
  WU.BindButtonEvent(REF.ButtonCreate, OnCreateClick)
  local createCost = PB.index("GuildMisc", 1).createCost
  REF.LabelCost.ResourcePrinter:SetResource(createCost.type, createCost.id, createCost.count)
  local guildMisc = PB.index("GuildMisc", 1)
  REF.InputGuildName.UIInput.characterLimit = guildMisc.maxNameLen
  REF.InputGuildName.UIInput.defaultText = WU.GetString("Window_GuildNameTitle") .. WU.GetString("Window_Comma") .. WU.GetString("Window_CharacterLimit", guildMisc.maxNameLen)
  REF.InputGuildBillboard.UIInput.characterLimit = guildMisc.maxBillboardLen
  REF.InputGuildBillboard.UIInput.defaultText = WU.GetString("Window_GuildAnnouncement") .. WU.GetString("Window_Comma") .. WU.GetString("Window_CharacterLimit", guildMisc.maxBillboardLen)
end

function OnEnable()
  m_badge = math.random(PB.index("GuildMisc", 1).badgeCount) - 1
  REF.SpriteBadge.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", m_badge)
end

function OnEditBadgeClick(go)
  WU.AcquireWindowAsync("GuildCustom", function(ui)
    _ENV["$"](ui)["$$SetData"](PB.index("GuildMisc", 1).badgeCount, m_badge, function(badge)
      m_badge = badge
      REF.SpriteBadge.UISprite.spriteName = "guild_emblem_" .. string.format("%02d", m_badge)
    end, true)
  end)
end

function OnCreateClick()
  local guildMisc = PB.index("GuildMisc", 1)
  local baseInfo = this:GetData("fci/baseinfo")
  if baseInfo.level >= guildMisc.createMinLevel then
    local createCost = PB.index("GuildMisc", 1).createCost
    WU.TryToPay(createCost.type, createCost.id, createCost.count, function()
      local guildName = U.trim(REF.InputGuildName.UIInput.value)
      local guildBillboard = U.trim(REF.InputGuildBillboard.UIInput.value)
      if guildName ~= "" then
        this:GameRequest("fci/guild/"):Post({
          name = guildName,
          billboard = guildBillboard,
          icon = tostring(m_badge)
        }, OnCreateGuildResult)
      else
        WU.ShowMessageOK(WU.GetString("Window_GuildNameRequired"))
      end
    end)
  else
    WU.ShowHintText(WU.GetString("Window_GuildCreationLevelLimit", guildMisc.createMinLevel))
  end
end

function OnCreateGuildResult(result)
  if result then
    this:SetData("fci/guild/", result.baseInfo)
    this:SetData("fci/guild/members/", result.members)
    this:SetData("fci/guild/pending-members/", result.pendingMembers)
    this:SetData("fci/guild/invited-members/", result.invitedMembers)
    this:SetData("fci/guild/skill/", result.skills)
    this:SetData("fci/guild/vote/", result.voteInfo)
    this:SetData("fci/guild/donate/", result.donateInfo)
    DBH.ResChange(result.resChange)
  end
end
