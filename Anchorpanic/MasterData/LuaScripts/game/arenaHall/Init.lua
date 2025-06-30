arena = {}
-- 竞技场
require("game/arenaHall/arena/manager/ArenaConst")

arena.ArenaRankRewardDataVo = require("game/arenaHall/arena/manager/vo/ArenaRankRewardDataVo")
arena.ArenaEnemyVo = require("game/arenaHall/arena/manager/vo/ArenaEnemyVo")
arena.ArenaLogVo = require("game/arenaHall/arena/manager/vo/ArenaLogVo")
arena.ArenaRewardDataVo = require("game/arenaHall/arena/manager/vo/ArenaRewardDataVo")
arena.ArenaRobotDataVo = require("game/arenaHall/arena/manager/vo/ArenaRobotDataVo")

arena.ArenaPanel = require("game/arenaHall/arena/view/ArenaPanel")
arena.ArenaItem = require("game/arenaHall/arena/view/item/ArenaItem")
arena.ArenaManager = require("game/arenaHall/arena/manager/ArenaManager").new()
arena.ArenaSettlementView = require("game/arenaHall/arena/view/ArenaSettlementView")
arena.ArenaController = require("game/arenaHall/arena/controller/ArenaController").new(arena.ArenaManager)

arena.ArenaChallengePanel = require("game/arenaHall/arena/view/ArenaChallengePanel")
arena.ArenaAwardPanel = require("game/arenaHall/arena/view/ArenaAwardPanel")
arena.ArenaAwardItem = require("game/arenaHall/arena/view/item/ArenaAwardItem")
arena.ArenaLogPanel = require("game/arenaHall/arena/view/ArenaLogPanel")
arena.ArenaLogItem = require("game/arenaHall/arena/view/item/ArenaLogItem")
arena.ArenaRankPanel = require("game/arenaHall/arena/view/ArenaRankPanel")
arena.ArenaRankItem = require("game/arenaHall/arena/view/item/ArenaRankItem")
arena.ArenaEnemyDefensePanel = require("game/arenaHall/arena/view/ArenaEnemyDefensePanel")
arena.ArenaEnemyDefenseItem = require("game/arenaHall/arena/view/item/ArenaEnemyDefenseItem")
arena.ArenaInfoPanel = require("game/arenaHall/arena/view/ArenaInfoPanel")
arena.ArenaResultDataPanel = require("game/arenaHall/arena/view/ArenaResultDataPanel")
----TabSubView
arena.ArenaAwardDaily = "game/arenaHall/arena/view/ArenaAwardDaily"
arena.ArenaAwardRank = "game/arenaHall/arena/view/ArenaAwardRank"
arena.ArenaAwardSegement = "game/arenaHall/arena/view/ArenaAwardSegement"

arena.ArenaLogAttackTabView =  "game/arenaHall/arena/view/ArenaLogAttackTabView"
arena.ArenaLogDefenseTabView = "game/arenaHall/arena/view/ArenaLogDefenseTabView"

local module = { arena.ArenaController }
return module

--[[ 替换语言包自动生成，请勿修改！
]]