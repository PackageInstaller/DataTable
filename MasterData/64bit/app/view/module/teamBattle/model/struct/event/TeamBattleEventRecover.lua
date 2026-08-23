local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventRecover = class("TeamBattleEventRecover", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct")))

function TeamBattleEventRecover:ctor(arg_1_1)
	TeamBattleEventRecover.super.ctor(self, arg_1_1)
end

return TeamBattleEventRecover
