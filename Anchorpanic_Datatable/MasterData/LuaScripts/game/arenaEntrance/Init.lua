arenaEntrance = {}
require("game/arenaEntrance/manager/ArenaEntranceConst")



arenaEntrance.ArenaHellRobotDataRo = require("game/arenaEntrance/manager/vo/ArenaHellRobotDataRo")

arenaEntrance.ArenaHellRankRewardDataVo = require("game/arenaEntrance/manager/vo/ArenaHellRankRewardDataVo")

arenaEntrance.ArenaEntrancePanel = require("game/arenaEntrance/view/ArenaEntrancePanel")
arenaEntrance.ArenaHellVsView = require("game/arenaEntrance/view/ArenaHellVsView")

arenaEntrance.ArenaOtherItem = require("game/arenaEntrance/view/item/ArenaOtherItem")
arenaEntrance.ArenaHellPanel = require("game/arenaEntrance/view/ArenaHellPanel")

arenaEntrance.ArenaOtheInfoPanel = require("game/arenaEntrance/view/ArenaOtheInfoPanel")

arenaEntrance.ArenaHellLogVo =  require("game/arenaEntrance/manager/vo/ArenaHellLogVo")

arenaEntrance.ArenaHellLogAttackTabView = require("game/arenaEntrance/view/tab/ArenaHellLogAttackTabView")
arenaEntrance.ArenaHellLogDefenseTabView = require("game/arenaEntrance/view/tab/ArenaHellLogDefenseTabView")

arenaEntrance.ArenaHellLogPanel = require("game/arenaEntrance/view/ArenaHellLogPanel")

arenaEntrance.ArenaEntranceRankItem = require("game/arenaEntrance/view/item/ArenaEntranceRankItem")
arenaEntrance.ArenaHellAwardItem =  require("game/arenaEntrance/view/item/ArenaHellAwardItem")

arenaEntrance.ArenaHellSeasonRankTabView = require("game/arenaEntrance/view/tab/ArenaHellSeasonRankTabView")
arenaEntrance.ArenaHellSeasonAwardTabView = require("game/arenaEntrance/view/tab/ArenaHellSeasonAwardTabView")
arenaEntrance.ArenaHellWeekAwardTabView = require("game/arenaEntrance/view/tab/ArenaHellWeekAwardTabView")
arenaEntrance.ArenaHellAwardPanel = require("game/arenaEntrance/view/ArenaHellAwardPanel")

--结算
arenaEntrance.ArenaHellResultPanel = require("game/arenaEntrance/view/ArenaHellResultPanel")
arenaEntrance.ArenaHellResultDataPanel =  require("game/arenaEntrance/view/ArenaHellResultDataPanel")


arenaEntrance.ArenaEntranceManager = require("game/arenaEntrance/manager/ArenaEntranceManager").new()
arenaEntrance.ArenaEntranceController = require("game/arenaEntrance/controller/ArenaEntranceController").new(arenaEntrance.ArenaEntranceManager)
local module = {arenaEntrance.AreanController }
return module