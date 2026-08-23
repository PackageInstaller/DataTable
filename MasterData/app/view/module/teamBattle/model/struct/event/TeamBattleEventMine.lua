local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventMine = class("TeamBattleEventMine", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct")))

function TeamBattleEventMine:ctor(arg_1_1)
	TeamBattleEventMine.super.ctor(self, arg_1_1)

	self._mineTimes = 0
end

function TeamBattleEventMine:updateEvent(arg_2_1)
	TeamBattleEventMine.super.updateEvent(self, arg_2_1)

	self._mineTimes = arg_2_1.mine_times or 0
	self._value = arg_2_1.mine_id
	self._mineCfg = g.core.config.team_battle_mining_info.get(self._value)

	self:_checkHasLeftMines()
end

function TeamBattleEventMine:costOneMineTimes()
	self._mineTimes = self._mineTimes + 1

	self:_checkHasLeftMines()
end

function TeamBattleEventMine:getEventInfo()
	local var_4_0 = TeamBattleEventMine.super.getEventInfo(self)

	var_4_0.mineTimes = self._mineTimes

	return var_4_0
end

function TeamBattleEventMine:_checkHasLeftMines()
	if self._mineCfg.buy_num <= self._mineTimes then
		self:onFinishEvent()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEAM_BATTLE_EVENT_FINISH)
	end
end

return TeamBattleEventMine
