local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventTrap = class("TeamBattleEventTrap", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct")))

function TeamBattleEventTrap:ctor(arg_1_1)
	TeamBattleEventTrap.super.ctor(self, arg_1_1)
end

return TeamBattleEventTrap
