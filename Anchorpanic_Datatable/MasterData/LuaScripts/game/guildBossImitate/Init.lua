guildBossImitate = {}

guildBossImitate.GuildImitateDupVo = require("game/guildBossImitate/manager/vo/GuildImitateDupVo")

guildBossImitate.GuildBossImitateStagePanel = require("game/guildBossImitate/view/GuildBossImitateStagePanel.lua")
guildBossImitate.GuildBossImitateLevelSelectPanel = require("game/guildBossImitate/view/GuildBossImitateLevelSelectPanel.lua")
guildBossImitate.GuildBossImitateRankPanel = require("game/guildBossImitate/view/GuildBossImitateRankPanel.lua")
guildBossImitate.GuildBossImitateResultView = require("game/guildBossImitate/view/GuildBossImitateResultView.lua")

guildBossImitate.GuildBossImitateRankItem = require("game/guildBossImitate/view/item/GuildBossImitateRankItem.lua")

guildBossImitate.GuildBossImitateManager = require("game/guildBossImitate/manager/GuildBossImitateManager").new()
guildBossImitate.GuildBossImitateController = require("game/guildBossImitate/controller/GuildBossImitateController").new(guildBossImitate.GuildBossImitateManager)
local module = {guildBossImitate.GuildBossImitateController}

return module
