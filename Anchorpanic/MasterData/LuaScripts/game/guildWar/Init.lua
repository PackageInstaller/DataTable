
guildWar = {}

-- 引入游戏公会战常量模块
require("game/guildWar/manager/GuildWarConst")
-- 引入公会战构建视图对象模块
guildWar.GuildWarBuildVo= require("game/guildWar/manager/vo/GuildWarBuildVo")
-- 引入公会战奖励视图对象模块
guildWar.GuildWarAwardVo= require("game/guildWar/manager/vo/GuildWarAwardVo")
-- 引入公会战建筑机器人模块
guildWar.GuildWarRobotVo = require("game/guildWar/manager/vo/GuildWarRobotVo")
-- 引入公会战主面板模块
guildWar.GuildWarMainPanel = require("game/guildWar/view/GuildWarMainPanel")
-- 引入公会战子面板模块
guildWar.GuildWarChildPanel = require("game/guildWar/view/GuildWarChildPanel")
-- 引入公会战信息面板模块
guildWar.GuildWarInfoPanel = require("game/guildWar/view/GuildWarInfoPanel")
-- 引入公会战结果面板模块
guildWar.GuildWarResultPanel = require("game/guildWar/view/GuildWarResultPanel")
-- 引入公会战成员面板模块
guildWar.GuildWarMemberPanel = require("game/guildWar/view/GuildWarMemberPanel")
-- 引入公会战日志面板模块
guildWar.GuildWarLogPanel = require("game/guildWar/view/GuildWarLogPanel")
-- 引入公会战公会日志面板模块
guildWar.GuildWarGuildLogPanel = require("game/guildWar/view/GuildWarGuildLogPanel")
-- 引入公会战公会日志结算面板模块
guildWar.GuildWarGuildResultPanel = require("game/guildWar/view/GuildWarGuildResultPanel")
-- 引入公会战排名项模块
guildWar.GuildWarRankItem = require("game/guildWar/view/item/GuildWarRankItem")
-- 引入公会战奖励项模块
guildWar.GuildWarAwardItem = require("game/guildWar/view/item/GuildWarAwardItem")
-- 引入公会战排名标签视图模块
guildWar.GuildWarRankTabView = require("game/guildWar/view/tab/GuildWarRankTabView")
-- 引入公会战奖励标签视图模块
guildWar.GuildWarAwardTabView = require("game/guildWar/view/tab/GuildWarAwardTabView")
-- 引入公会战标签面板模块
guildWar.GuildWarTabPanel = require("game/guildWar/view/GuildWarTabPanel")
-- 引入公会战战斗结果信息模块
guildWar.GuildWarFightResultInfoPanel = require("game/guildWar/view/GuildWarFightResultInfoPanel")
-- 引入公会战战斗准备模块
guildWar.GuildWarFightInfoPanel = require("game/guildWar/view/GuildWarFightInfoPanel")

-- 引入并创建公会战管理器实例
guildWar.GuildWarManager = require("game/guildWar/manager/GuildWarManager").new()
-- 引入并创建公会战控制器实例
guildWar.GuildWarController = require("game/guildWar/controller/GuildWarController").new(guildWar.GuildWarManager)



-- 模块导出，包含公会战控制器
local module = {guildWar.GuildWarController}
return module