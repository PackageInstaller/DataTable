local DailyDungeonData = class("DailyDungeonData", require("app.core.model.BaseData"))
local var_0_1 = g.core.config.daily_dungeon_stage_info
local var_0_2 = g.core.config.daily_dungeon_info

function DailyDungeonData:ctor()
	self:initData()
end

function DailyDungeonData:initData()
	DailyDungeonData.super.ctor(self)

	self._info = {}
	self._allState = nil
	self._nowState = nil
	self._hasData = false
	self._clearance = 0
end

function DailyDungeonData:hasData()
	return self._hasData
end

function DailyDungeonData:initInfo(arg_4_1)
	self._hasData = true

	local var_4_0 = arg_4_1.ids or {}
	local var_4_1 = arg_4_1.records or {}
	local var_4_2 = arg_4_1.clears or {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_3 = var_4_1[iter_4_0] or -1
		local var_4_4 = var_4_2[iter_4_0] or false

		self._info[var_4_0[iter_4_0]] = {
			id = var_4_0[iter_4_0],
			record = var_4_3,
			clear = var_4_4
		}
	end

	self:updateNowStageDatas()
	self:resetExpired()
end

function DailyDungeonData:getInfo(arg_5_1)
	return self._info[arg_5_1] or {
		clear = false,
		record = -1,
		id = arg_5_1
	}
end

function DailyDungeonData:getChapterOpenLevel(arg_6_1)
	local var_6_0 = var_0_2.get(arg_6_1)
	local var_6_1 = 1
	local var_6_2 = var_0_1.match(function(arg_7_0)
		return arg_7_0.daily_dungeon_type == var_6_0.daily_dungeon_type
	end)

	if var_6_2 and next(var_6_2) then
		var_6_1 = var_6_2[1].stage_level

		for iter_6_0, iter_6_1 in ipairs(var_6_2) do
			if var_6_1 > iter_6_1.stage_level then
				var_6_1 = iter_6_1.stage_level
			end
		end
	end

	return var_6_1
end

function DailyDungeonData:checkChapterOpenState(arg_8_1)
	local var_8_0 = var_0_2.get(arg_8_1)

	if self:getChapterOpenLevel(arg_8_1) > g.core.model.User:getLevel() then
		return 2
	end

	if var_8_0.time == 1 then
		return 0
	end

	local var_8_1 = g.core.common.ServerTime:getWeekDay()

	if var_8_1 == 0 or (var_8_1 + 1) % 2 == var_8_0.time - 2 then
		return 0
	else
		return 1
	end
end

function DailyDungeonData:checkStageOpenState(arg_9_1)
	local var_9_0 = g.core.model.User:getLevel()
	local var_9_1 = var_0_1.get(arg_9_1)
	local var_9_2 = self:getInfo(arg_9_1)

	if var_9_0 < var_9_1.stage_level then
		if var_9_1.premise_id > 0 and not self:getInfo(var_9_1.premise_id).clear then
			return 0
		end

		return 1
	end

	if var_9_1.premise_id > 0 and self:getInfo(var_9_1.premise_id).record < 0 then
		return 2
	end

	if var_9_2.clear and var_9_0 >= var_9_1.sweep_level then
		return 4
	end

	if var_9_2.record == -1 then
		return 5
	end

	return 3
end

function DailyDungeonData:onRecvChallenge(arg_10_1)
	local var_10_0 = arg_10_1.record
	local var_10_1 = arg_10_1.is_win

	self._clearance = arg_10_1.is_win and arg_10_1.id or 0

	if self._info[arg_10_1.id] then
		self._info[arg_10_1.id].record = math.max(var_10_0, self._info[arg_10_1.id].record or -1)
		self._info[arg_10_1.id].clear = var_10_1 or self._info[arg_10_1.id].clear
	else
		self._info[arg_10_1.id] = {
			id = arg_10_1.id,
			record = var_10_0,
			clear = var_10_1
		}
	end
end

function DailyDungeonData:updateNowStageDatas(arg_11_1)
	if not arg_11_1 and self._nowState == nil or arg_11_1 then
		self._nowState = {}

		for iter_11_0 = 1, var_0_1.getLength() do
			local var_11_0 = var_0_1.indexOf(iter_11_0)
			local var_11_1 = self:checkStageOpenState(var_11_0.id)

			if var_11_1 == 0 or var_11_1 == 1 or var_11_1 == 2 then
				if self._nowState[var_11_0.daily_dungeon_type] == nil then
					self._nowState[var_11_0.daily_dungeon_type] = var_11_0.id
				elseif self._nowState[var_11_0.daily_dungeon_type] > var_11_0.id then
					self._nowState[var_11_0.daily_dungeon_type] = var_11_0.id
				end
			end
		end
	end
end

function DailyDungeonData:updateClearanceDatas()
	self._clearance = 0
end

function DailyDungeonData:isNowUnlockLevel(arg_13_1)
	if self._nowState == nil then
		return false
	end

	if self._nowState[var_0_1.get(arg_13_1).daily_dungeon_type] == arg_13_1 then
		local var_13_0 = self:checkStageOpenState(arg_13_1)

		if var_13_0 == 3 or var_13_0 == 4 or var_13_0 == 5 then
			return true
		end
	end

	return false
end

function DailyDungeonData:isClearance(arg_14_1)
	return self._clearance == arg_14_1
end

function DailyDungeonData:isPrivilegeActiveByStageId(arg_15_1)
	local var_15_0 = ({
		[g.core.const.ConstMgr.DailyDungeonConst.DUNGEON_TYPE.KNIGHT_EXP] = g.core.const.ConstMgr.PrivilegeConst.TYPE.DAILY_DUNGEON_KNIGHT_EXP,
		[g.core.const.ConstMgr.DailyDungeonConst.DUNGEON_TYPE.COIN] = g.core.const.ConstMgr.PrivilegeConst.TYPE.DAILY_DUNGEON_COIN,
		[g.core.const.ConstMgr.DailyDungeonConst.DUNGEON_TYPE.UNITE_TOKEN_SELECT] = g.core.const.ConstMgr.PrivilegeConst.TYPE.DAILY_DUNGEON_UNITE_TOKEN_SELECT,
		[g.core.const.ConstMgr.DailyDungeonConst.DUNGEON_TYPE.TREASURE_EXP] = g.core.const.ConstMgr.PrivilegeConst.TYPE.DAILY_DUNGEON_TREASURE_EXP
	})[g.core.config.daily_dungeon_stage_info.get(arg_15_1).daily_dungeon_type]

	if var_15_0 then
		return g.core.model.User.privilegeData:isActiveByType(var_15_0, false, 2)
	end
end

function DailyDungeonData:getAllDailyDungeon()
	if not self:hasData() or self:isExpired() then
		return
	end

	local var_16_0 = g.core.config.daily_dungeon_info
	local var_16_1 = {}

	for iter_16_0 = 1, g.core.config.daily_dungeon_info.getLength() do
		var_16_1[iter_16_0] = var_16_0.indexOf(iter_16_0)
	end

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		local var_17_0 = self:checkChapterOpenState(arg_17_0.id)
		local var_17_1 = self:checkChapterOpenState(arg_17_1.id)

		if var_17_0 ~= var_17_1 then
			return var_17_0 < var_17_1
		end

		if arg_17_0.id ~= arg_17_1.id then
			return arg_17_0.id < arg_17_1.id
		end

		return false
	end)

	return var_16_1
end

function DailyDungeonData:loadJsonCache()
	self._localConfig = self:_load(true)

	if not next(self._localConfig) then
		self._localConfig = {
			showIds = {
				initedSign = true
			}
		}
	end
end

function DailyDungeonData:isChapterHasLeftCount(arg_19_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_DUNGEON) then
		return false
	end

	local var_19_0 = arg_19_1 and arg_19_1.stageId

	if arg_19_1 and arg_19_1.stageId then
		if self:checkChapterOpenState(var_19_0) == 0 then
			return g.core.model.User.shopData:getLeftCount(var_0_2.get(var_19_0).dungeon_num) > 0
		end

		return false
	else
		for iter_19_0, iter_19_1 in ipairs(self:getAllDailyDungeon() or {}) do
			if self:checkChapterOpenState(iter_19_1.id) == 0 and g.core.model.User.shopData:getLeftCount(iter_19_1.dungeon_num) > 0 then
				return true
			end
		end

		return false
	end
end

function DailyDungeonData:hasNewDungeon(arg_20_1)
	if arg_20_1 then
		if not arg_20_1.type and not arg_20_1.id then
			for iter_20_0 = 1, g.core.config.daily_dungeon_info.getLength() do
				local var_20_0 = g.core.config.daily_dungeon_info.indexOf(iter_20_0)

				if self:hasNewDungeon({
					type = var_20_0.daily_dungeon_type,
					stageId = var_20_0.id
				}) then
					return true
				end
			end

			return false
		elseif not arg_20_1.id then
			if ((arg_20_1.stageId or nil) and g.core.model.User.dailyDungeonData:checkChapterOpenState(arg_20_1.stageId)) ~= 0 then
				return false
			end

			local var_20_2 = g.core.config.daily_dungeon_stage_info.match(function(arg_21_0)
				if arg_21_0.daily_dungeon_type == arg_20_1.type then
					return self:checkStageOpenState(arg_21_0.id) > 1
				end

				return false
			end)

			for iter_20_1, iter_20_2 in ipairs(var_20_2) do
				if self:_checkNewDungeon(arg_20_1.type, iter_20_2.id, var_20_2) and self:_checkIsLook(arg_20_1.type, iter_20_2.id) then
					return true
				end
			end

			return false
		end
	end

	return self:_checkNewDungeon(arg_20_1.type, arg_20_1.id) and self:_checkIsLook(arg_20_1.type, arg_20_1.id, true)
end

function DailyDungeonData:_checkIsLook(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = false

	if not self._localConfig.showIds[arg_22_1 .. "_" .. arg_22_2] then
		if arg_22_3 then
			self._localConfig.showIds[arg_22_1 .. "_" .. arg_22_2] = true

			self:_save(true)
		end

		var_22_0 = true
	end

	return var_22_0
end

function DailyDungeonData:_checkNewDungeon(arg_23_1, arg_23_2, arg_23_3)
	arg_23_3 = arg_23_3 or g.core.config.daily_dungeon_stage_info.match(function(arg_24_0)
		return arg_24_0.daily_dungeon_type == arg_23_1
	end)

	local var_23_0

	for iter_23_0, iter_23_1 in ipairs(arg_23_3) do
		if iter_23_1.id == arg_23_2 then
			var_23_0 = iter_23_0

			break
		end
	end

	if arg_23_3[var_23_0 + 1] ~= nil and self:checkStageOpenState(arg_23_2) == 5 then
		return true
	end

	return false
end

function DailyDungeonData:_save()
	if not self._localConfig then
		return
	end

	g.core.common.Storage:save("dailyDungeon.json", self._localConfig, ...)
end

function DailyDungeonData:_load()
	return g.core.common.Storage:load("dailyDungeon.json", ...) or {}
end

return DailyDungeonData
