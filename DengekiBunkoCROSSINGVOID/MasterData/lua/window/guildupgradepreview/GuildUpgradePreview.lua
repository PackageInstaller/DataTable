inherit("Window/Guild/GuildSensitiveBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnConfirmClick)
end

function InitWindow()
  this:Bind("guildId", ValidateRestrictions)
  this:Bind("fci/guild/", OnGuildChange)
end

function OnGuildChange(guild)
  if guild then
    local reachMaxLevel = guild.level >= PB.index("GuildMisc", 1).maxGuildLevel
    local guildLevel = PB.get("GuildLevel", math.max(1, guild.level))
    REF.LabelLevel.UILabel.text = WU.GetString("Window_Level", guild.level)
    REF.LabelMemberLimit.UILabel.text = guildLevel.maxMemberCount
    REF.LabelShopSlotLimit.UILabel.text = guildLevel.maxShopSlotCount
    REF.LabelVicePresidentLimit.UILabel.text = guildLevel.maxVicePresidentCount
    WU.SetActive(REF.NodeLevelNext, not reachMaxLevel)
    WU.SetActive(REF.NodeMemberLimitNext, not reachMaxLevel)
    WU.SetActive(REF.NodeShopSlotLimitNext, not reachMaxLevel)
    WU.SetActive(REF.NodeVicePresidentLimitNext, not reachMaxLevel)
    WU.SetActive(REF.NodeMax, reachMaxLevel)
    if not reachMaxLevel then
      local guildLevelNext = PB.get("GuildLevel", guild.level + 1)
      REF.ProgressBarExp.UIProgressBar.value = guild.exp / guildLevel.exp
      REF.LabelLevelNext.UILabel.text = WU.GetString("Window_Level", guild.level + 1)
      REF.LabelExp.UILabel.text = guild.exp .. "/" .. guildLevel.exp
      REF.LabelMemberLimitNext.UILabel.text = guildLevelNext.maxMemberCount
      REF.LabelShopSlotLimitNext.UILabel.text = guildLevelNext.maxShopSlotCount
      REF.LabelVicePresidentLimitNext.UILabel.text = guildLevelNext.maxVicePresidentCount
    else
      REF.ProgressBarExp.UIProgressBar.value = 1
    end
    REF.LabelExpTips.UIHtmlLabel.text = WU.GetString("Window_GuildExpOutputSource")
  end
end

function OnConfirmClick()
  WU.RecycleWindow(this)
end
