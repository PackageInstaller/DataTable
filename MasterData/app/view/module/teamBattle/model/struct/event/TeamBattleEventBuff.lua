local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventBuff = class("TeamBattleEventBuff", (require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct")))

function TeamBattleEventBuff:ctor(arg_1_1)
	TeamBattleEventBuff.super.ctor(self, arg_1_1)

	self._buffIdList = {}
end

function TeamBattleEventBuff:updateEvent(arg_2_1)
	TeamBattleEventBuff.super.updateEvent(self, arg_2_1)

	self._buffIdList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.buff_ids) do
		self._buffIdList[iter_2_0] = {
			id = iter_2_1,
			isSelect = arg_2_1.pos == iter_2_0
		}
	end

	if arg_2_1.pos and arg_2_1.pos > 0 then
		self:onFinishEvent()
	end
end

function TeamBattleEventBuff:getEventInfo()
	local var_3_0 = TeamBattleEventBuff.super.getEventInfo(self)

	var_3_0.buffIdList = self._buffIdList

	return var_3_0
end

return TeamBattleEventBuff
