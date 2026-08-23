local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventGame = class("TeamBattleEventGame", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct")))

function TeamBattleEventGame:ctor(arg_1_1)
	TeamBattleEventGame.super.ctor(self, arg_1_1)
end

function TeamBattleEventGame:getUIInfo()
	local var_2_0 = self.super.getUIInfo(self)

	if self._state == TeamBattleConst.EVENT_STATE.WAIT_TRIGGER then
		var_2_0.url = ""
	end

	return var_2_0
end

function TeamBattleEventGame:canTriggerEvent()
	return true
end

function TeamBattleEventGame:updateUserId(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1 or {}) do
		if iter_4_1 == g.core.model.User:getId() then
			self:triggerEvent()

			break
		end
	end
end

return TeamBattleEventGame
