local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventRevival = class("TeamBattleEventRevival", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct")))

function TeamBattleEventRevival:ctor(arg_1_1)
	TeamBattleEventRevival.super.ctor(self, arg_1_1)
end

return TeamBattleEventRevival
