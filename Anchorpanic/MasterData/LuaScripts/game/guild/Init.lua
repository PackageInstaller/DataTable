guild = {}
require("game/guild/manager/GuildConst")


guild.GuildIconVo = require("game/guild/manager/vo/GuildIconVo")
guild.GuildExpDataVo = require("game/guild/manager/vo/GuildExpDataVo")
guild.GuildPrepareDataVo = require("game/guild/manager/vo/GuildPrepareDataVo")
guild.GuildBossStageDupConfigVo = require("game/guild/manager/vo/GuildBossStageDupConfigVo")
guild.GuildBossSeasonRewardConfigVo = require("game/guild/manager/vo/GuildBossSeasonRewardConfigVo")

guild.GuildAwardDataVo = require("game/guild/manager/vo/GuildAwardDataVo")

guild.GuildSkillVo = require("game/guild/manager/vo/GuildSkillVo")
guild.GuildSkillEffVo = require("game/guild/manager/vo/GuildSkillEffVo")

guild.GuildSweepVo = require("game/guild/manager/vo/GuildSweepVo")
guild.GuildSweepDifficultyVo = require("game/guild/manager/vo/GuildSweepDifficultyVo")
guild.GuildSweepDifficultyStepVo = require("game/guild/manager/vo/GuildSweepDifficultyStepVo")

guild.GuildSweepDupVo= require("game/guild/manager/vo/GuildSweepDupVo")

guild.GuildSearchItem = require("game/guild/view/item/GuildSearchItem")

guild.GuildManagerItem = require("game/guild/view/item/GuildManagerItem")
guild.GuildRequestItem = require("game/guild/view/item/GuildRequestItem")
guild.GuildMemberItem = require("game/guild/view/item/GuildMemberItem")

guild.GuildJoinTabView = require("game/guild/view/tab/GuildJoinTabView")
guild.GuildCreateTabView = require("game/guild/view/tab/GuildCreateTabView")
guild.GuildJoinPanel = require("game/guild/view/GuildJoinPanel")

guild.GuildMainPanel = require("game/guild/view/GuildMainPanel")
guild.GuildReNamePanel = require("game/guild/view/GuildReNamePanel")
guild.GuildChangeNoticePanel = require("game/guild/view/GuildChangeNoticePanel")

guild.GuildSupplyPanel = require("game/guild/view/GuildSupplyPanel")
guild.GuildPreparationPanel = require("game/guild/view/GuildPreparationPanel")

guild.GuildManagerTabView = require("game/guild/view/tab/GuildManagerTabView")
guild.GuildRequestTabView = require("game/guild/view/tab/GuildRequestTabView")
guild.GuildManagerPanel = require("game/guild/view/GuildManagerPanel")

guild.GuildRequestSettingPanel = require("game/guild/view/GuildRequestSettingPanel")

guild.GuildMemberTabView = require("game/guild/view/tab/GuildMemberTabView")
guild.GuildMemberPanel = require("game/guild/view/GuildMemberPanel")

guild.GuildChairmanManagerItem = require("game/guild/view/item/GuildChairmanManagerItem")
guild.GuildChairmanManagerTabView = require("game/guild/view/tab/GuildChairmanManagerTabView")
guild.GuildChairmanRequestTabView = require("game/guild/view/tab/GuildChairmanRequestTabView")
guild.GuildChairmanPanel = require("game/guild/view/GuildChairmanPanel")

guild.GuildTipsPanel = require("game/guild/view/GuildTipsPanel")

guild.GuildSkillPanel = require("game/guild/view/GuildSkillPanel")

guild.GuildChangeIconPanel = require("game/guild/view/GuildChangeIconPanel")

-------------------GuildBosss
guild.GuildBossMainUI = require("game/guild/view/GuildBossMainUI")
guild.GuildBossRankPanel = require("game/guild/view/GuildBossRankPanel")
guild.GuildBossFightLogPanel = require("game/guild/view/GuildBossFightLogPanel")
guild.GuildBossDamageLogPanel = require("game/guild/view/GuildBossDamageLogPanel")
guild.GuildBossMemberFightInfoPanel = require("game/guild/view/GuildBossMemberFightInfoPanel")

guild.GuildBossInfoPanel = require("game/guild/view/GuildBossInfoPanel")
guild.GuildBossResultView = require("game/guild/view/GuildBossResultView")

guild.GuildBossRankTabView = require("game/guild/view/tab/GuildBossRankTabView")
guild.GuildBossSeasonAwardTabView = require("game/guild/view/tab/GuildBossSeasonAwardTabView")

guild.GuildBossRankItem = require("game/guild/view/item/GuildBossRankItem")
guild.GuildBossSeasonAwardItem = require("game/guild/view/item/GuildBossSeasonAwardItem")


-------------------GuildSweep----------------------------------
guild.GuildSweepMainPanel = require("game/guild/view/GuildSweepMainPanel")

guild.GuildSweepLevelSelectPanel = require("game/guild/view/GuildSweepLevelSelectPanel")

guild.GuildSweepBossPanel = require("game/guild/view/GuildSweepBossPanel")
guild.GuildSweepLogPanel = require("game/guild/view/GuildSweepLogPanel")

guild.GuildSweepResultView = require("game/guild/view/GuildSweepResultView")


-------------------GuildWar----------------------------------




guild.GuildManager = require("game/guild/manager/GuildManager").new()
guild.GuildController = require("game/guild/controller/GuildController").new(guild.GuildManager)
local module = {guild.GuildController}

return module
