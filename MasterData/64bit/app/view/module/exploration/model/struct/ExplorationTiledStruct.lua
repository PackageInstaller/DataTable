local ExplorationConst = require("app.view.module.exploration.const.ExplorationConst")
local ExplorationTiledStruct = class("ExplorationTiledStruct")

function ExplorationTiledStruct:ctor(arg_1_1, arg_1_2)
	self._state = ExplorationConst.MAP.TILED_STATE_LOCK
	self._cfg = arg_1_1
	self._belongRoom = arg_1_2.room
	self._roomDiff = arg_1_2.difficulty
	self._coordinate = cc.p(arg_1_1.x, arg_1_1.y)
	self._eventInfo = nil
	self._monsterInfo = nil
	self._originInfo = nil

	self:_initEvent(self._cfg.grid_type, arg_1_2)
end

function ExplorationTiledStruct:_resetEvent()
	self._eventInfo = {
		picId = "",
		type = ExplorationConst.EVENT_TYPE.NONE,
		room_id = self._belongRoom,
		x = self._coordinate.x,
		y = self._coordinate.y
	}
end

function ExplorationTiledStruct:_initEvent(arg_3_1, arg_3_2)
	self:_resetEvent()

	if arg_3_1 == ExplorationConst.GRID_TYPE.SHOP then
		if arg_3_2.shop ~= 0 then
			local var_3_0 = g.core.config.exploration_shop_info.get(arg_3_2.shop)

			self._eventInfo.type = var_3_0.shop_type
			self._eventInfo.shopCfg = var_3_0

			self:_initEventCfg()

			self._state = ExplorationConst.MAP.TILED_STATE_UNLOCK
		end
	elseif arg_3_1 == ExplorationConst.GRID_TYPE.MIRROR then
		if arg_3_2.mirror == 0 then
			self._eventInfo.type = ExplorationConst.EVENT_TYPE.NONE
		else
			self._eventInfo.type = ExplorationConst.EVENT_TYPE.ULTIMATUM
			self._state = ExplorationConst.MAP.TILED_STATE_UNLOCK

			self:_initEventCfg()
			self:setBossMonster(g.core.model.User.explorationData:getBaseInfo().boss_id)
		end
	elseif arg_3_1 ~= ExplorationConst.GRID_TYPE.RANDOM and arg_3_1 ~= ExplorationConst.GRID_TYPE.BIRTH then
		self._eventInfo.type = arg_3_1

		self:_initEventCfg()
	end
end

function ExplorationTiledStruct:_initEventCfg()
	self._eventInfo.cfg = g.core.config.exploration_event_info.get(self._eventInfo.type)
	self._eventInfo.picId = self._eventInfo.cfg.event_display_res == "0" and "" or "ui://exploration/" .. self._eventInfo.cfg.event_display_res
end

function ExplorationTiledStruct:updateEvent(arg_5_1)
	if arg_5_1.tp == ExplorationConst.EVENT_TYPE.NONE then
		self:_resetEvent()

		if self._eventInfo.type ~= ExplorationConst.EVENT_TYPE.ROBBER then
			self._monsterInfo = nil
		end

		return
	end

	self._originInfo = arg_5_1
	self._eventInfo.type = arg_5_1.tp
	self._eventInfo.id = arg_5_1.id
	self._eventInfo.unique_id = arg_5_1.unique_id

	if not self._eventInfo.cfg then
		self:_initEventCfg()
	end

	self._eventInfo.param = {
		products = arg_5_1.products,
		params = arg_5_1.params,
		value = arg_5_1.value
	}

	if self._eventInfo.type == ExplorationConst.EVENT_TYPE.ROBBER then
		self:setTiledMonster(self._eventInfo.id)
	end
end

function ExplorationTiledStruct:getPicId()
	return self._eventInfo.picId
end

function ExplorationTiledStruct:getOriginInfo()
	return self._originInfo
end

function ExplorationTiledStruct:getCoordinate()
	return self._coordinate
end

function ExplorationTiledStruct:getState()
	return self._state
end

function ExplorationTiledStruct:getEventType()
	return self._eventInfo.type
end

function ExplorationTiledStruct:getEventName()
	return self._eventInfo.cfg.event_name
end

function ExplorationTiledStruct:getEventInfo()
	return self._eventInfo
end

function ExplorationTiledStruct:getEventUniqueID()
	return self._eventInfo.unique_id
end

function ExplorationTiledStruct:setState(arg_14_1)
	self._state = arg_14_1
end

function ExplorationTiledStruct:setBelongRoom(arg_15_1)
	self._belongRoom = arg_15_1
end

function ExplorationTiledStruct:getBelongRoom()
	return self._belongRoom
end

function ExplorationTiledStruct:setMirrorMonster(arg_17_1)
	local var_17_0 = g.core.config.knight_info.get(arg_17_1.user.base_id)

	self._monsterInfo.resId = var_17_0.res_id

	if arg_17_1.user.skin and arg_17_1.user.skin ~= 0 then
		local var_17_1 = g.core.config.skin_info.fetch(arg_17_1.user.skin)

		if var_17_1 then
			local var_17_2 = g.core.config.knight_base_info.fetch(var_17_1.res)

			if var_17_2 then
				self._monsterInfo.resId = var_17_2.fight_id
			end
		end
	end

	self._monsterInfo.spineId = var_17_0.res_id
	self._monsterInfo.battleTeam = {
		units = {}
	}

	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		if iter_17_0 ~= "units" then
			self._monsterInfo.battleTeam[iter_17_0] = iter_17_1
		else
			for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
				table.insert(self._monsterInfo.battleTeam.units, iter_17_3)
			end
		end
	end

	table.sort(self._monsterInfo.battleTeam.units, function(arg_18_0, arg_18_1)
		return arg_18_0.pos < arg_18_1.pos
	end)

	self._monsterInfo.name = g.core.lang:get(420693, {
		user = arg_17_1.user.name
	})
end

function ExplorationTiledStruct:_getRandomName(arg_19_1, arg_19_2)
	local var_19_0 = g.core.config.exploration_monster_name_info.match(function(arg_20_0)
		return arg_20_0.name_group == arg_19_1
	end)

	return var_19_0[math.max(1, arg_19_2 * g.core.model.User.explorationData:getBaseInfo().id % (#var_19_0 + 1))].monster_name
end

function ExplorationTiledStruct:setTiledMonster(arg_21_1, arg_21_2, arg_21_3)
	if arg_21_1 == nil then
		self._monsterInfo = nil

		if self._eventInfo.type == ExplorationConst.EVENT_TYPE.GUARD or self._eventInfo.type == ExplorationConst.EVENT_TYPE.ROBBER then
			self._monsterInfo = nil

			self:exchangeEventType(ExplorationConst.EVENT_TYPE.NONE)
		end

		return
	end

	self._monsterInfo = {
		monsterId = arg_21_1,
		diff = self._roomDiff
	}

	local var_21_0 = g.core.config.exploration_monster_info.get(arg_21_1)

	if arg_21_3 then
		self._monsterInfo.name = self:_getRandomName(var_21_0.guard_name, arg_21_1)

		if self._roomDiff == 1 then
			self._monsterInfo.resId = 302120
		elseif self._roomDiff == 2 then
			self._monsterInfo.resId = 301020
		elseif self._roomDiff == 3 then
			self._monsterInfo.resId = 302420
		end

		self._monsterInfo.roomId = self._belongRoom
	else
		self._monsterInfo.name = self:_getRandomName(var_21_0.robber_name, arg_21_1)
		self._monsterInfo.resId = 301010
	end

	local var_21_1 = g.core.model.User.explorationData:getMapData()
	local var_21_2 = self:getBelongRoom()

	if var_21_0.attr_type > 0 then
		self._monsterInfo.deBuffInfo = {
			attrName = g.core.config.attribute_info.get(var_21_0.attr_type).name,
			initValue = var_21_0.initial_attr,
			limit = var_21_0.attr_dec_min,
			time = var_21_0.attr_dec_time,
			ratio = var_21_0.attr_dec_ratio
		}

		if var_21_0.attr_type == 310 then
			self._monsterInfo.deBuffInfo.attrName = g.core.lang:get(420702)
		end

		if g.core.config.exploration_map_info.get(var_21_2, (var_21_1:getCurMapId())).difficulty > 1 then
			self._monsterInfo.diffTip = true
		end
	end

	local var_21_3 = 1
	local var_21_4

	while g.core.config.exploration_monster_info.hasKey("monster_" .. 1) do
		local var_21_6

		if var_21_0["monster_" .. 1] ~= 0 then
			local var_21_5 = g.core.config.massive_monster_team_info.get(var_21_0["monster_" .. 1])

			if 0 < var_21_5.fight then
				var_21_4 = var_21_5
				var_21_6 = var_21_5.fight
			end
		end

		var_21_3 = var_21_3 + 1
	end

	self._monsterInfo.spineId = g.core.config.knight_info.get(var_21_4.knight_id_1).res_id
	self._monsterInfo.fight = var_21_4.fight
	self._monsterInfo.direction = arg_21_3
	self._monsterInfo.roomId = var_21_2
	self._state = ExplorationConst.MAP.TILED_STATE_UNLOCK
end

function ExplorationTiledStruct:setBossMonster(arg_22_1)
	self._monsterInfo = {
		scale = 1.2,
		monsterId = arg_22_1,
		diff = self._roomDiff
	}

	local var_22_0 = g.core.config.exploration_boss_info.get(arg_22_1).boss_team

	for iter_22_0 = 1, 1 do
		local var_22_1 = g.core.config.monster_team_info.fetch(var_22_0, iter_22_0)

		if not var_22_1 then
			break
		end

		if var_22_1["monster_" .. 1] ~= 0 then
			local var_22_2 = g.core.config.monster_info.get(var_22_1["monster_" .. 1])
			local var_22_3 = g.core.config.knight_info.get(var_22_2.advance_id)

			self._monsterInfo.resId = g.core.config.knight_base_info.get(var_22_2.advance_id).fight_id
			self._monsterInfo.spineId = var_22_3.res_id
			self._monsterInfo.name = var_22_2.name
			self._monsterInfo.fight = var_22_1.fight
		end
	end
end

function ExplorationTiledStruct:exchangeEventType(arg_23_1)
	if arg_23_1 == self._eventInfo.type then
		return
	end

	self:_resetEvent()

	if self._eventInfo.type ~= ExplorationConst.EVENT_TYPE.NONE then
		self:_initEventCfg()
	end
end

function ExplorationTiledStruct:getTiledMonster()
	return self._monsterInfo
end

function ExplorationTiledStruct:getTiledMonsterAndReset()
	self._monsterInfo = nil

	return self._monsterInfo
end

function ExplorationTiledStruct:getMonsterResId()
	return
end

function ExplorationTiledStruct:getCfg()
	return self._cfg
end

function ExplorationTiledStruct:getEventCfg()
	return self._eventInfo.cfg
end

function ExplorationTiledStruct:getEventBuffList()
	return self._eventInfo.param.params or {}
end

function ExplorationTiledStruct:getShopProductList()
	local var_30_0 = self._eventInfo.param.products or {}

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		if arg_31_0.num ~= arg_31_1.num then
			return arg_31_0.num > arg_31_1.num
		end

		local var_31_0 = {}
		local var_31_1 = {}

		if self._eventInfo.type == ExplorationConst.EVENT_TYPE.KNIGHT_SHOP then
			var_31_0 = g.core.config.knight_info.get(arg_31_0.id)
			var_31_1 = g.core.config.knight_info.get(arg_31_1.id)
		end

		if var_31_0.quality ~= var_31_1.quality then
			return var_31_0.quality > var_31_1.quality
		end

		if var_31_0.star ~= var_31_1.star then
			return var_31_0.star > var_31_1.star
		end

		return arg_31_0.id > arg_31_1.id
	end)

	return var_30_0
end

return ExplorationTiledStruct
