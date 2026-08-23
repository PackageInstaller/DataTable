local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleEventStruct = class("TeamBattleEventStruct")

function TeamBattleEventStruct:ctor(arg_1_1)
	self._eventId = -1
	self._type = arg_1_1.type
	self._grid = arg_1_1.grid
	self._cfg = g.core.config.team_battle_event_info.get(self._type)
	self._res = self._cfg.res
	self._value = arg_1_1.tileValue
	self._belongRoom = arg_1_1.roomId or -1
	self._createTime = -1
	self._state = TeamBattleConst.EVENT_STATE.NONE
	self._param = nil
end

function TeamBattleEventStruct:getEventType()
	return self._type
end

function TeamBattleEventStruct:getCfg()
	return self._cfg
end

function TeamBattleEventStruct:resetEvent()
	self._eventId = -1
	self._value = nil
	self._createTime = -1
	self._state = TeamBattleConst.EVENT_STATE.NONE
	self._param = nil
	self._netInfo = nil
end

function TeamBattleEventStruct:lockEvent()
	self._state = TeamBattleConst.EVENT_STATE.LOCK
end

function TeamBattleEventStruct:canTriggerEvent()
	return self._state ~= TeamBattleConst.EVENT_STATE.LOCK
end

function TeamBattleEventStruct:triggerEvent()
	self._state = TeamBattleConst.EVENT_STATE.WAIT_TRIGGER
end

function TeamBattleEventStruct:updateEvent(arg_8_1)
	self._eventId = arg_8_1.unique_id
	self._createTime = arg_8_1.create_time or 0

	if arg_8_1.value then
		self._value = arg_8_1.value
	end

	self._param = arg_8_1.params

	self:triggerEvent()

	self._netInfo = arg_8_1
end

function TeamBattleEventStruct:getUniqueID()
	return self._eventId
end

function TeamBattleEventStruct:doEvent(arg_10_1)
	self._state = TeamBattleConst.EVENT_STATE.DOING
end

function TeamBattleEventStruct:requestFinishEvent(arg_11_1)
	return
end

function TeamBattleEventStruct:onFinishEvent(arg_12_1)
	self._state = TeamBattleConst.EVENT_STATE.FINISH
end

function TeamBattleEventStruct:getState()
	return self._state
end

function TeamBattleEventStruct:getUIInfo()
	local var_14_0 = {
		url = "",
		name = self._cfg.event_name
	}

	if self._state ~= TeamBattleConst.EVENT_STATE.FINISH then
		local var_14_1 = tonumber(self._res)

		if var_14_1 > 0 and var_14_1 <= 10000 then
			var_14_0.url = g.core.common.Path:getTeamBattlePicRes(self._res)
		elseif var_14_1 > 10000 then
			var_14_0.knightInfo = {
				resId = self._res,
				name = self._cfg.event_name,
				eventType = self._type
			}
		end
	end

	return var_14_0
end

function TeamBattleEventStruct:getEventInfo()
	return {
		grid = self._grid,
		cfg = self._cfg,
		room = self._belongRoom,
		createTime = self._createTime,
		param = self._param,
		eventId = self._eventId,
		value = self._value
	}
end

function TeamBattleEventStruct:getNetInfo()
	return self._netInfo
end

function TeamBattleEventStruct:getGrid()
	return self._grid
end

function TeamBattleEventStruct:getBelongRoom()
	return self._belongRoom
end

return TeamBattleEventStruct
