local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local TeamBattleTiledStruct = class("TeamBattleTiledStruct")

function TeamBattleTiledStruct:ctor(arg_1_1, arg_1_2)
	self._state = TeamBattleConst.MAP.TILED_STATE_LOCK
	self._lastState = nil
	self._cfg = arg_1_1
	self._belongRoom = arg_1_2.room
	self._coordinate = cc.p(arg_1_1.x, arg_1_1.y)
	self._playerMap = {}
	self._size = 1
	self._event = nil

	if self._cfg.grid_type then
		self:_initEvent(self._cfg.grid_type)

		self._size = math.max(1, g.core.config.team_battle_event_info.get(self._cfg.grid_type).size / 2)
	end
end

function TeamBattleTiledStruct:_resetEvent()
	if self._event then
		self._event:resetEvent()
	end
end

function TeamBattleTiledStruct:_initEvent(arg_3_1, arg_3_2)
	if arg_3_1 == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS1 or arg_3_1 == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS2 then
		return
	end

	local var_3_0 = {
		type = arg_3_1,
		grid = self._cfg.id,
		roomId = self._belongRoom,
		tileValue = arg_3_2
	}

	if TeamBattleConst.EVENT_TYPE.KNIGHT_SHOP == arg_3_1 or TeamBattleConst.EVENT_TYPE.BUFF_SHOP == arg_3_1 then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventShop").new(var_3_0)
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.MINING then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventMine").new(var_3_0)
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.GUARD or arg_3_1 == TeamBattleConst.EVENT_TYPE.ROBBER then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventMonster").new(var_3_0)
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.REVIVAL then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventRevival").new(var_3_0)
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.RECOVER then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventRecover").new(var_3_0)
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.LIMIT_PROPS then
		-- block empty
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.TRAPPED then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventTrap").new(var_3_0)
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.BUFF then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventBuff").new(var_3_0)
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.BIRTH then
		-- block empty
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.TEL_PORT then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventStruct").new(var_3_0)
	elseif arg_3_1 == TeamBattleConst.EVENT_TYPE.GAME_METEOR_SHOWER or arg_3_1 == TeamBattleConst.EVENT_TYPE.GAME_TURN_CARD or arg_3_1 == TeamBattleConst.EVENT_TYPE.GAME_DART then
		self._event = require("app.view.module.teamBattle.model.struct.event.TeamBattleEventGame").new(var_3_0)
	end

	if self._event then
		self._size = self._event:getCfg().size
	end
end

function TeamBattleTiledStruct:updateEvent(arg_4_1)
	if self._event then
		self._event:updateEvent(arg_4_1)
	end
end

function TeamBattleTiledStruct:updateBossEvent(arg_5_1)
	self._event = self._event or require("app.view.module.teamBattle.model.struct.event.TeamBattleEventBoss").new({
		type = self._cfg.grid_type,
		grid = self._cfg.id,
		roomId = self._belongRoom
	})

	self._event:updateEvent(arg_5_1)
end

function TeamBattleTiledStruct:getUIInfo()
	return (self._event or nil) and self._event:getUIInfo()
end

function TeamBattleTiledStruct:getCoordinate()
	return self._coordinate
end

function TeamBattleTiledStruct:getEventType(arg_8_1)
	local var_8_0 = TeamBattleConst.EVENT_TYPE.NONE

	if self._event then
		local var_8_1 = self._event:getEventType()

		if not arg_8_1 or self._event:getState() ~= TeamBattleConst.EVENT_STATE.FINISH or var_8_1 == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS1 or var_8_1 == TeamBattleConst.EVENT_TYPE.LIMIT_BOSS2 then
			var_8_0 = self._event:getEventType()
		end
	end

	return var_8_0
end

function TeamBattleTiledStruct:getEventName()
	return (self._event or nil) and self._event:getCfg().event_name
end

function TeamBattleTiledStruct:getEventInfo()
	return self._event
end

function TeamBattleTiledStruct:getEventUniqueID()
	return (self._event or nil) and self._event:getUniqueID()
end

function TeamBattleTiledStruct:setState(arg_12_1)
	if self._state == TeamBattleConst.MAP.TILED_STATE_IN_SIGHT and arg_12_1 == TeamBattleConst.MAP.TILED_STATE_UNLOCK then
		return
	end

	self._lastState = self._state
	self._state = arg_12_1
end

function TeamBattleTiledStruct:unLockTiled()
	self._state = TeamBattleConst.MAP.TILED_STATE_UNLOCK
end

function TeamBattleTiledStruct:getState()
	return self._state
end

function TeamBattleTiledStruct:getLastState()
	return self._lastState
end

function TeamBattleTiledStruct:syncLastState()
	self._lastState = self._state
end

function TeamBattleTiledStruct:setBelongRoom(arg_17_1)
	self._belongRoom = arg_17_1
end

function TeamBattleTiledStruct:getBelongRoom()
	return self._belongRoom
end

function TeamBattleTiledStruct:finishEvent(arg_19_1)
	if self._event then
		self._event:onFinishEvent(arg_19_1)
	end
end

function TeamBattleTiledStruct:getTiledEvent()
	return self._event
end

function TeamBattleTiledStruct:getCfg()
	return self._cfg
end

function TeamBattleTiledStruct:getEventCfg()
	if self._event then
		return self._event:getCfg()
	end

	return {}
end

function TeamBattleTiledStruct:getShopProductList()
	local var_23_0 = self._eventInfo.param.products or {}

	table.sort(var_23_0, function(arg_24_0, arg_24_1)
		if arg_24_0.num ~= arg_24_1.num then
			return arg_24_0.num > arg_24_1.num
		end

		local var_24_0 = {}
		local var_24_1 = {}

		if self._eventInfo.type == TeamBattleConst.EVENT_TYPE.KNIGHT_SHOP then
			var_24_0 = g.core.config.knight_info.get(arg_24_0.id)
			var_24_1 = g.core.config.knight_info.get(arg_24_1.id)
		end

		if var_24_0.quality ~= var_24_1.quality then
			return var_24_0.quality > var_24_1.quality
		end

		if var_24_0.star ~= var_24_1.star then
			return var_24_0.star > var_24_1.star
		end

		return arg_24_0.id > arg_24_1.id
	end)

	return var_23_0
end

function TeamBattleTiledStruct:getTiledSize()
	return self._size
end

return TeamBattleTiledStruct
