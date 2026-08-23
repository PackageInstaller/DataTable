local GveConst = require("app.view.module.gve.const.GveConst")
local GveFogConfig = require("app.view.module.gve.const.GveFogConfig")
local var_0_2 = g.core.config.gve_fog_info
local var_0_3 = g.core.model.User.gveDataMgr
local KsAStar = require("app.core.utils.KsAStar")
local GveBossStruct = require("app.view.module.gve.model.struct.GveBossStruct")
local var_0_6 = g.core.config.gve_grid_info
local var_0_7 = g.core.config.gve_base_info
local var_0_8 = g.core.config.gve_boss_info
local var_0_9 = {
	Y_ADD = 3,
	X_DEC = 2,
	Y_DEC = 4,
	X_ADD = 1
}
local GveData = class("GveData")

function GveData:ctor()
	self._gridKeyMap = {}
	self._ownerMap = {}
	self._bossCfg = {}
	self._findBossMap = {}
	self._baseIdMap = {}
	self._posPicMap = {}
	self._uidMap = {}
	self._bossDataList = {}
	self._finalBossId = 0
	self._fogCheckSize = var_0_2.getLength()
	self._targetSiteTiledIdDict = {}

	self:initBuildMap()
	self:initBossMap()
	self:initData()
end

function GveData:initData()
	self._mySiteMap = {}
	self._mySiteList = {}
	self._allCtrlKnight = {}
	self._tuanList = {}
	self._lastBossInfoTime = 0
	self._curGridBaseData = {}
	self._randAwardTime = 0
	self._randBossShowAward = nil
	self._isShowMiniMapDetail = nil
	self._myAtkNums = 0
	self._lastKATime = 0
	self._newGetPos = nil
	self._isBossHasBeKilled = false
	self._specialBossPoint = {}
	self._curAStarTuan = nil
	self._gridBuffs = {}
	self._occupiedPoints = {}

	for iter_2_0, iter_2_1 in pairs(self._gridKeyMap) do
		iter_2_1.state = GveConst.GRID_OPE_TYPE.NONE
	end

	self._isLoadBuffShowState = false
	self._giveUpTipTime = (g.core.common.Storage:load("gve_giveup_tip.json", true) or {}).lastTipTime or 0
end

function GveData:initBuildMap()
	for iter_3_0 = 1, var_0_6.getLength() do
		local var_3_0 = var_0_6.indexOf(iter_3_0)

		if var_3_0.base_id ~= 0 then
			local var_3_2 = var_0_7.get(var_3_0.base_id)

			self._baseIdMap[var_3_0.x .. "_" .. var_3_0.y] = var_3_0.base_id
			self._ownerMap[var_3_0.x .. "_" .. var_3_0.y] = var_3_0.x .. "_" .. var_3_0.y

			if var_3_2.base_type == 2 then
				self._ownerMap[var_3_0.x .. "_" .. var_3_0.y + 1] = var_3_0.x .. "_" .. var_3_0.y
				self._baseIdMap[var_3_0.x .. "_" .. var_3_0.y + 1] = var_3_0.base_id
			elseif var_3_2.base_type == 3 then
				self._ownerMap[var_3_0.x + 1 .. "_" .. var_3_0.y] = var_3_0.x .. "_" .. var_3_0.y
				self._baseIdMap[var_3_0.x + 1 .. "_" .. var_3_0.y] = var_3_0.base_id
			elseif var_3_2.base_type == 4 then
				self._ownerMap[var_3_0.x + 1 .. "_" .. var_3_0.y + 1] = var_3_0.x .. "_" .. var_3_0.y
				self._ownerMap[var_3_0.x + 1 .. "_" .. var_3_0.y] = var_3_0.x .. "_" .. var_3_0.y
				self._ownerMap[var_3_0.x .. "_" .. var_3_0.y + 1] = var_3_0.x .. "_" .. var_3_0.y
				self._baseIdMap[var_3_0.x + 1 .. "_" .. var_3_0.y + 1] = var_3_0.base_id
				self._baseIdMap[var_3_0.x + 1 .. "_" .. var_3_0.y] = var_3_0.base_id
				self._baseIdMap[var_3_0.x .. "_" .. var_3_0.y + 1] = var_3_0.base_id
			end
		end

		if var_3_0.pic ~= 0 and self._ownerMap[var_3_0.x .. "_" .. var_3_0.y] then
			self._posPicMap[self._ownerMap[var_3_0.x .. "_" .. var_3_0.y]] = var_3_0.pic
		end

		self._gridKeyMap[var_3_0.x .. "_" .. var_3_0.y] = {
			param = 0,
			cfg = var_3_0,
			state = GveConst.GRID_OPE_TYPE.NONE
		}
	end
end

function GveData:isPointHasBuild(arg_4_1)
	if not arg_4_1 then
		return false
	end

	if arg_4_1.cfg.base_id ~= 0 and var_0_7.get(arg_4_1.cfg.base_id).if_ruins == 1 then
		return true
	end

	return false
end

function GveData:initBossMap()
	for iter_5_0 = 1, var_0_8.getLength() do
		local var_5_0 = var_0_8.indexOf(iter_5_0)

		self._bossCfg[var_5_0.x .. "_" .. var_5_0.y] = self._bossCfg[var_5_0.x .. "_" .. var_5_0.y] or {}

		local var_5_1 = 1

		if var_5_0.range == 4 then
			var_5_1 = 1
		elseif var_5_0.range == 5 then
			var_5_1 = 2
		end

		for iter_5_1 = 0, var_5_1 do
			for iter_5_2 = 0, var_5_1 do
				self._findBossMap[var_5_0.x + iter_5_1 .. "_" .. var_5_0.y + iter_5_2] = var_5_0
			end
		end

		table.insert(self._bossCfg[var_5_0.x .. "_" .. var_5_0.y], var_5_0)

		if var_5_0.if_final == 1 then
			self._finalBossId = var_5_0.id
		end
	end

	for iter_5_3, iter_5_4 in pairs(self._bossCfg) do
		table.sort(iter_5_4, function(arg_6_0, arg_6_1)
			if arg_6_0.order ~= arg_6_1.order then
				return arg_6_0.order < arg_6_1.order
			end

			return false
		end)
	end
end

function GveData:startGveTimer()
	if self._keepAliveSchedule then
		g.core.common.Scheduler:cancelSchedule(self._keepAliveSchedule)

		self._keepAliveSchedule = nil
	end

	self._keepAliveSchedule = g.core.common.Scheduler:newSchedule(handler(self, self.checkNeedSendKAMsg), GveConst.MAP_ALIVE_CHECK_TIME)

	self:sendKeepAliveMsg()

	self._lastKATime = g.core.common.ServerTime:getTime()
	self._notIsRestoreTuan = true
end

function GveData:checkNeedSendKAMsg()
	if g.core.common.ServerTime:getTime() - self._lastKATime + GveConst.MAP_ALIVE_CHECK_TIME >= GveConst.MAP_ALIVE_COUNT then
		self:sendKeepAliveMsg()
	end
end

function GveData:sendKeepAliveMsg()
	if g.core.common.ServerTime:getLeftSeconds((var_0_3:getGveFormalEndTime())) < 0 then
		self:stopGveTimer()

		return
	end

	self._lastKATime = g.core.common.ServerTime:getTime()

	g.core.network.GameNetProxy:send_C2S_GVE_WorldKeepAlive({})
end

function GveData:stopGveTimer()
	if self._keepAliveSchedule then
		g.core.common.Scheduler:cancelSchedule(self._keepAliveSchedule)

		self._keepAliveSchedule = nil
	end
end

function GveData:getRealPoint(arg_11_1)
	return (arg_11_1 - arg_11_1 % 65536) / 65536, arg_11_1 % 65536
end

function GveData:getTagByUid(arg_12_1)
	return (arg_12_1 == g.core.model.User:getId() or nil) and (GveConst.COLOR_TYPE.MINE or GveConst.COLOR_TYPE.OTHER_NO_PASS)
end

function GveData:getGridColorEnum(arg_13_1, arg_13_2)
	return self._occupiedPoints[self._ownerMap[arg_13_1 .. "_" .. arg_13_2]]
end

function GveData:getGridOwner(arg_14_1)
	return self._ownerMap[arg_14_1.x .. "_" .. arg_14_1.y]
end

function GveData:getAllOccupiedPoint()
	return self._occupiedPoints
end

function GveData:updateWorldPointInfo(arg_16_1)
	self._occupiedPoints = {}
	self._initPos = {
		x = arg_16_1.x,
		y = arg_16_1.y
	}

	local var_16_0 = false
	local var_16_1 = {
		x = 290,
		y = 290
	}

	if arg_16_1.x == 0 and arg_16_1.y == 0 then
		var_16_0 = true
	end

	if arg_16_1.is_first then
		self:getIdleReward()
	end

	self._uidMap = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1.cells) do
		if iter_16_1.cells then
			for iter_16_2, iter_16_3 in ipairs(iter_16_1.cells) do
				local var_16_2, var_16_3 = self:getRealPoint(iter_16_3)

				if iter_16_1.uid == GveConst.SPECIAL_POINT.GVE_SPECIAL_CAN_MOVE_POS then
					self._specialBossPoint[var_16_2 .. "_" .. var_16_3] = iter_16_1.uid
				end

				self:updateCellUid(var_16_2 .. "_" .. var_16_3, iter_16_1.uid)

				if iter_16_1.uid >= 10000 then
					g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_16_1.uid)
				end

				local var_16_4 = self:getTagByUid(iter_16_1.uid)

				self:setAllPointState(var_16_2 .. "_" .. var_16_3, var_16_4)

				if var_16_0 and GveConst.COLOR_TYPE.MINE == var_16_4 and var_16_2 + var_16_3 < var_16_1.x + var_16_1.y then
					var_16_1.x = var_16_2
					var_16_1.y = var_16_3
				end
			end
		end
	end

	if var_16_0 then
		self._initPos = var_16_1
	end

	self._notIsRestoreTuan = true
end

function GveData:setAllPointState(arg_17_1, arg_17_2)
	local var_17_0 = self:getBaseCfgByPos(arg_17_1, true)

	if not var_17_0 then
		return
	end

	for iter_17_0, iter_17_1 in ipairs((self:getAllPoint(self._gridKeyMap[arg_17_1], var_17_0.base_type))) do
		self._occupiedPoints[iter_17_1] = arg_17_2
	end
end

function GveData:getAllPointByKeyStr(arg_18_1)
	local var_18_0 = self:getBaseCfgByPos(arg_18_1, true)

	if not var_18_0 then
		return
	end

	return (self:getAllPoint(self._gridKeyMap[arg_18_1], var_18_0.base_type))
end

function GveData:setCurPosition(arg_19_1)
	self._curPos = arg_19_1
end

function GveData:getCurPosition()
	return self._curPos
end

function GveData:getInitPoint()
	return self._initPos
end

function GveData:getLastAddPoint()
	return self._newGetPos or self._initPos
end

function GveData:onGveWorldMove(arg_23_1)
	self._gridBuffs = {}

	self:onSiteBuffChange(arg_23_1.near_data)
end

function GveData:onSiteBuffChange(arg_24_1)
	if arg_24_1.st_cells then
		for iter_24_0, iter_24_1 in ipairs(arg_24_1.st_cells) do
			local var_24_0, var_24_1 = self:getRealPoint(iter_24_1.cell)

			if iter_24_1.status then
				self._gridBuffs[var_24_0 .. "_" .. var_24_1] = {}

				for iter_24_2, iter_24_3 in ipairs(iter_24_1.status) do
					if iter_24_3.num ~= 0 and GveConst.GVE_GRID_BUFF_MAP[iter_24_3.id] then
						table.insert(self._gridBuffs[var_24_0 .. "_" .. var_24_1], {
							buffType = GveConst.GVE_GRID_BUFF_MAP[iter_24_3.id],
							buffNum = iter_24_3.num
						})
					end
				end

				table.sort(self._gridBuffs[var_24_0 .. "_" .. var_24_1], function(arg_25_0, arg_25_1)
					return arg_25_0.buffType < arg_25_1.buffType
				end)

				if #self._gridBuffs[var_24_0 .. "_" .. var_24_1] == 0 then
					self._gridBuffs[var_24_0 .. "_" .. var_24_1] = nil
				end
			else
				self._gridBuffs[var_24_0 .. "_" .. var_24_1] = nil
			end
		end

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GRID_BUFF_REFRESH)
	end
end

function GveData:getGridBuff(arg_26_1, arg_26_2)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(self._gridBuffs[arg_26_1 .. "_" .. arg_26_2] or {}) do
		if iter_26_1.buffType == 8 or iter_26_1.buffType == 9 then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return next(var_26_0) and var_26_0 or nil
end

function GveData:onWorldDataNotify(arg_27_1)
	local var_27_0 = {
		add = {},
		delete = {}
	}
	local var_27_1
	local var_27_2 = {}

	for iter_27_0, iter_27_1 in ipairs(arg_27_1.cells or {}) do
		if iter_27_1.uid == 0 then
			var_27_1 = iter_27_1
		elseif iter_27_1.cells then
			for iter_27_2, iter_27_3 in ipairs(iter_27_1.cells) do
				local var_27_3, var_27_4 = self:getRealPoint(iter_27_3)
				local var_27_5 = var_27_3 .. "_" .. var_27_4

				if self._ownerMap[var_27_3 .. "_" .. var_27_4] and self._ownerMap[var_27_5] == var_27_5 then
					if iter_27_1.uid == GveConst.SPECIAL_POINT.GVE_SPECIAL_CAN_MOVE_POS then
						self._specialBossPoint[var_27_3 .. "_" .. var_27_4] = iter_27_1.uid
						self._occupiedPoints[var_27_3 .. "_" .. var_27_4] = GveConst.COLOR_TYPE.OTHER_PASS
					else
						local var_27_6 = self:getTagByUid(iter_27_1.uid)

						if var_27_6 == GveConst.COLOR_TYPE.MINE then
							self:setMySiteChange(var_27_3, var_27_4, 0)

							self._newGetPos = {
								x = var_27_3,
								y = var_27_4
							}

							g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_MY_GRID_CHANGE)
						end

						self:setAllPointRealState(var_27_5, var_27_6)
					end

					var_27_2[var_27_5] = true

					self:updateCellUid(var_27_5, iter_27_1.uid)

					if iter_27_1.uid >= 10000 then
						g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, iter_27_1.uid)
					end

					table.insert(var_27_0.add, var_27_5)
				end
			end
		end
	end

	if var_27_1 and var_27_1.cells then
		for iter_27_4, iter_27_5 in ipairs(var_27_1.cells) do
			local var_27_7, var_27_8 = self:getRealPoint(iter_27_5)

			if not var_27_2[var_27_7 .. "_" .. var_27_8] then
				self:updateCellUid(var_27_7 .. "_" .. var_27_8, nil)
			end

			if self._ownerMap[var_27_7 .. "_" .. var_27_8] and self._ownerMap[var_27_7 .. "_" .. var_27_8] == var_27_7 .. "_" .. var_27_8 then
				if self._mySiteMap[var_27_7 .. "_" .. var_27_8] then
					self:deleteMySite(var_27_7, var_27_8)

					if self._newGetPos and self._newGetPos.x == var_27_7 and self._newGetPos.y == var_27_8 then
						self._newGetPos = nil
					end

					g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_MY_GRID_CHANGE, false, {
						delete = {
							x = var_27_7,
							y = var_27_8
						}
					})
					self:calcAllUpKnight()
				end

				self:setAllPointRealState(var_27_7 .. "_" .. var_27_8, nil)
				table.insert(var_27_0.delete, var_27_7 .. "_" .. var_27_8)
			end
		end
	end

	self:onPointChange(var_27_0)

	if arg_27_1.near_data then
		self:onSiteBuffChange(arg_27_1.near_data)
	end
end

function GveData:setAllPointRealState(arg_28_1, arg_28_2)
	local var_28_0 = self:getBaseCfgByPos(arg_28_1, true)

	if not var_28_0 then
		return
	end

	for iter_28_0, iter_28_1 in ipairs((self:getAllPoint(self._gridKeyMap[arg_28_1], var_28_0.base_type))) do
		self._occupiedPoints[iter_28_1] = arg_28_2

		local var_28_1 = string.split(iter_28_1, "_")
		local var_28_2 = tonumber(var_28_1[1])
		local var_28_3 = tonumber(var_28_1[2])

		if arg_28_2 then
			self:addPoint(var_28_2, var_28_3)
		else
			self:delPoint(var_28_2, var_28_3)
		end
	end
end

function GveData:getAllPoint(arg_29_1, arg_29_2)
	if arg_29_2 == 1 then
		return {
			arg_29_1.cfg.x .. "_" .. arg_29_1.cfg.y
		}
	elseif arg_29_2 == 2 then
		return {
			arg_29_1.cfg.x .. "_" .. arg_29_1.cfg.y,
			arg_29_1.cfg.x .. "_" .. arg_29_1.cfg.y + 1
		}
	elseif arg_29_2 == 3 then
		return {
			arg_29_1.cfg.x .. "_" .. arg_29_1.cfg.y,
			arg_29_1.cfg.x + 1 .. "_" .. arg_29_1.cfg.y
		}
	elseif arg_29_2 == 4 then
		return {
			arg_29_1.cfg.x .. "_" .. arg_29_1.cfg.y,
			arg_29_1.cfg.x .. "_" .. arg_29_1.cfg.y + 1,
			arg_29_1.cfg.x + 1 .. "_" .. arg_29_1.cfg.y,
			arg_29_1.cfg.x + 1 .. "_" .. arg_29_1.cfg.y + 1
		}
	end

	return {}
end

function GveData:onPointChange(arg_30_1)
	local var_30_0 = {}

	if arg_30_1.add then
		var_30_0.add = {}

		for iter_30_0, iter_30_1 in ipairs(arg_30_1.add) do
			local var_30_1 = self:getBaseCfgByPos(iter_30_1, true)

			if var_30_1 then
				for iter_30_2, iter_30_3 in ipairs((self:getAllPoint(self._gridKeyMap[iter_30_1], var_30_1.base_type))) do
					table.insert(var_30_0.add, iter_30_3)
				end
			end
		end
	end

	if arg_30_1.delete then
		var_30_0.delete = {}

		for iter_30_4, iter_30_5 in ipairs(arg_30_1.delete) do
			local var_30_2 = self:getBaseCfgByPos(iter_30_5, true)

			if var_30_2 then
				for iter_30_6, iter_30_7 in ipairs((self:getAllPoint(self._gridKeyMap[iter_30_5], var_30_2.base_type))) do
					table.insert(var_30_0.delete, iter_30_7)
				end
			end
		end
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GRID_STATE_CHANGE, false, var_30_0)
end

function GveData:onWorldCellDetail(arg_31_1)
	self._curGridBaseData = {}

	if not arg_31_1.x or not arg_31_1.y then
		return
	end

	self._curGridBaseData[arg_31_1.x .. "_" .. arg_31_1.y] = clone(arg_31_1)
end

function GveData:onGiveUpGrid(arg_32_1)
	self:setMySiteGiveUp(arg_32_1.x, arg_32_1.y, arg_32_1.giveup_ts)
end

function GveData:onCancelGiveUpGrid(arg_33_1)
	self:setMySiteGiveUp(arg_33_1.x, arg_33_1.y, nil)
end

function GveData:getTargetPath(arg_34_1)
	if self._skipPath then
		return {}
	end

	local var_34_0 = self:getPosCurOperateData(arg_34_1.x, arg_34_1.y)
	local var_34_1 = {
		x = 0,
		y = 0
	}
	local var_34_2

	if var_34_0.isBoss then
		var_34_1.x = var_34_0.bossCfg.x
		var_34_1.y = var_34_0.bossCfg.y
		var_34_2 = var_34_0.bossCfg.range
	else
		var_34_1.x = var_34_0.gridData.cfg.x
		var_34_1.y = var_34_0.gridData.cfg.y
		var_34_2 = self:getBaseCfgByPos(var_34_1).base_type
	end

	return self:getCanAtkPath(var_34_1, var_34_2)
end

function GveData:setCheckSkipPath(arg_35_1)
	self._skipPath = arg_35_1
end

function GveData:isCheckSkipPath()
	return self._skipPath
end

function GveData:updateMyAtkNums(arg_37_1)
	self._myAtkNums = arg_37_1
end

function GveData:getMyAtkNums(arg_38_1)
	return self._myAtkNums
end

function GveData:getAllRangePoints(arg_39_1, arg_39_2, arg_39_3)
	if arg_39_3 == 1 then
		return {
			{
				x = arg_39_1,
				y = arg_39_2 + 1,
				changeTag = var_0_9.Y_ADD
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2,
				changeTag = var_0_9.X_ADD
			},
			{
				x = arg_39_1 - 1,
				y = arg_39_2,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			}
		}
	elseif arg_39_3 == 2 then
		return {
			{
				x = arg_39_1,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			},
			{
				x = arg_39_1 - 1,
				y = arg_39_2,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2,
				changeTag = var_0_9.X_ADD
			},
			{
				x = arg_39_1 - 1,
				y = arg_39_2 + 1,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2 + 1,
				changeTag = var_0_9.X_ADD
			},
			{
				x = arg_39_1,
				y = arg_39_2 + 2,
				changeTag = var_0_9.Y_ADD
			}
		}
	elseif arg_39_3 == 3 then
		return {
			{
				x = arg_39_1 - 1,
				y = arg_39_2,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			},
			{
				x = arg_39_1,
				y = arg_39_2 + 1,
				changeTag = var_0_9.Y_ADD
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2 + 1,
				changeTag = var_0_9.Y_ADD
			},
			{
				x = arg_39_1 + 2,
				y = arg_39_2,
				changeTag = var_0_9.X_ADD
			}
		}
	elseif arg_39_3 == 4 then
		return {
			{
				x = arg_39_1,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			},
			{
				x = arg_39_1 - 1,
				y = arg_39_2,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1 - 1,
				y = arg_39_2 + 1,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			},
			{
				x = arg_39_1,
				y = arg_39_2 + 2,
				changeTag = var_0_9.Y_ADD
			},
			{
				x = arg_39_1 + 2,
				y = arg_39_2,
				changeTag = var_0_9.X_ADD
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2 + 2,
				changeTag = var_0_9.Y_ADD
			},
			{
				x = arg_39_1 + 2,
				y = arg_39_2 + 1,
				changeTag = var_0_9.X_ADD
			}
		}
	elseif arg_39_3 == 5 then
		return {
			{
				x = arg_39_1 - 1,
				y = arg_39_2,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1 - 1,
				y = arg_39_2 + 1,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1 - 1,
				y = arg_39_2 + 2,
				changeTag = var_0_9.X_DEC
			},
			{
				x = arg_39_1,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			},
			{
				x = arg_39_1 + 2,
				y = arg_39_2 - 1,
				changeTag = var_0_9.Y_DEC
			},
			{
				x = arg_39_1 + 3,
				y = arg_39_2,
				changeTag = var_0_9.X_ADD
			},
			{
				x = arg_39_1 + 3,
				y = arg_39_2 + 1,
				changeTag = var_0_9.X_ADD
			},
			{
				x = arg_39_1 + 3,
				y = arg_39_2 + 2,
				changeTag = var_0_9.X_ADD
			},
			{
				x = arg_39_1,
				y = arg_39_2 + 3,
				changeTag = var_0_9.Y_ADD
			},
			{
				x = arg_39_1 + 1,
				y = arg_39_2 + 3,
				changeTag = var_0_9.Y_ADD
			},
			{
				x = arg_39_1 + 2,
				y = arg_39_2 + 3,
				changeTag = var_0_9.Y_ADD
			}
		}
	end

	return {}
end

function GveData:getCanAtkPath(arg_40_1, arg_40_2)
	local var_40_1 = {}

	for iter_40_0, iter_40_1 in ipairs(self:getAllRangePoints(arg_40_1.x, arg_40_1.y, arg_40_2) or {}) do
		if self._occupiedPoints[iter_40_1.x .. "_" .. iter_40_1.y] then
			table.insert(var_40_1, iter_40_1)
		end
	end

	if next(var_40_1) then
		for iter_40_2, iter_40_3 in ipairs(var_40_1) do
			for iter_40_4, iter_40_5 in ipairs(self._tuanList) do
				if iter_40_5[iter_40_3.x .. "_" .. iter_40_3.y] and (self._occupiedPoints[iter_40_3.x .. "_" .. iter_40_3.y] == GveConst.COLOR_TYPE.MINE or self._occupiedPoints[iter_40_3.x .. "_" .. iter_40_3.y] == GveConst.COLOR_TYPE.OTHER_PASS) then
					for iter_40_6, iter_40_7 in pairs(iter_40_5) do
						if self._occupiedPoints[iter_40_6] == GveConst.COLOR_TYPE.MINE or self._specialBossPoint[iter_40_6] and self._specialBossPoint[iter_40_6] == GveConst.SPECIAL_POINT.GVE_SPECIAL_CAN_MOVE_POS then
							local var_40_2 = string.split(iter_40_6, "_")
							local var_40_3 = tonumber(var_40_2[1])
							local var_40_4 = tonumber(var_40_2[2])

							self._curAStarTuan = iter_40_5

							local var_40_5 = KsAStar.searchPath({
								x = var_40_3,
								y = var_40_4
							}, iter_40_3, self)

							if var_40_5 then
								local var_40_6 = {
									x = iter_40_3.x,
									y = iter_40_3.y
								}

								if var_0_9.X_ADD == iter_40_3.changeTag then
									var_40_6.x = var_40_6.x - 1
								elseif var_0_9.Y_ADD == iter_40_3.changeTag then
									var_40_6.y = var_40_6.y - 1
								elseif var_0_9.X_DEC == iter_40_3.changeTag then
									var_40_6.x = var_40_6.x + 1
								elseif var_0_9.Y_DEC == iter_40_3.changeTag then
									var_40_6.y = var_40_6.y + 1
								end

								table.insert(var_40_5, var_40_6)
							end

							for iter_40_8, iter_40_9 in ipairs(var_40_5) do
								iter_40_9.changeTag = nil
							end

							return var_40_5
						end
					end
				end
			end
		end
	end

	return nil
end

function GveData:doCanMoveAStar(arg_41_1, arg_41_2)
	if not self._curAStarTuan then
		return false
	end

	if math.abs(arg_41_1.x - arg_41_2.x) + math.abs(arg_41_1.y - arg_41_2.y) > 1 then
		return false
	end

	if self._curAStarTuan[arg_41_1.x .. "_" .. arg_41_1.y] and self._curAStarTuan[arg_41_2.x .. "_" .. arg_41_2.y] then
		return true
	end

	return false
end

function GveData:getSiteAroundSites(arg_42_1, arg_42_2)
	local var_42_0 = self:getBuildDataByPos({
		x = arg_42_1,
		y = arg_42_2
	}).cfg
	local var_42_1 = self:getAllRangePoints(var_42_0.x, var_42_0.y, self:getBaseCfgByPos({
		x = arg_42_1,
		y = arg_42_2
	}).base_type)

	for iter_42_0 = #var_42_1, 1, -1 do
		if not self:getBuildDataByPos(var_42_1[iter_42_0]) then
			table.remove(var_42_1, iter_42_0)
		end
	end

	return var_42_1
end

function GveData:getBuildDataByPos(arg_43_1, arg_43_2)
	if not arg_43_1 then
		return
	end

	if self._ownerMap[arg_43_1.x .. "_" .. arg_43_1.y] and not arg_43_2 then
		return self._gridKeyMap[self._ownerMap[arg_43_1.x .. "_" .. arg_43_1.y]]
	end

	return self._gridKeyMap[arg_43_1.x .. "_" .. arg_43_1.y]
end

function GveData:getBaseCfgByPos(arg_44_1, arg_44_2)
	if arg_44_2 then
		return var_0_7.fetch(self._baseIdMap[arg_44_1])
	end

	return var_0_7.fetch(self._baseIdMap[arg_44_1.x .. "_" .. arg_44_1.y])
end

function GveData:getPosBossCfg(arg_45_1, arg_45_2)
	return self._findBossMap[arg_45_1 .. "_" .. arg_45_2]
end

function GveData:getPosPic(arg_46_1, arg_46_2)
	local var_46_0 = self._posPicMap[self._ownerMap[arg_46_1 .. "_" .. arg_46_2]] or 0

	if var_46_0 and var_46_0 ~= 0 then
		return "pic/gve/relic_details/" .. var_46_0 .. ".png"
	end

	return ""
end

function GveData:getPosPic2(arg_47_1)
	return "pic/gve/relic_details/pic_judian_ui_" .. arg_47_1 .. ".png"
end

function GveData:onUpdatePosCellCtrlData(arg_48_1)
	self._mySiteMap = {}
	self._mySiteList = {}

	for iter_48_0, iter_48_1 in ipairs(arg_48_1 or {}) do
		local var_48_0, var_48_1 = self:getRealPoint(iter_48_1.cell)

		self:setMySiteChange(var_48_0, var_48_1, iter_48_1.knight_id, iter_48_1.giveup_ts)
	end

	self:calcAllUpKnight()

	if self._notIsRestoreTuan then
		self:restoreTuanList()

		self._notIsRestoreTuan = false

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_REFRESH_GRID_COLOR)
	end
end

function GveData:getMyPointKnightId(arg_49_1, arg_49_2)
	if self._mySiteMap[arg_49_1 .. "_" .. arg_49_2] then
		return self._mySiteMap[arg_49_1 .. "_" .. arg_49_2].knight
	end

	return 0
end

function GveData:getGiveUpTime(arg_50_1, arg_50_2)
	if self._mySiteMap[arg_50_1 .. "_" .. arg_50_2] then
		local var_50_0 = self._mySiteMap[arg_50_1 .. "_" .. arg_50_2].giveUpTs or 0

		if var_50_0 > g.core.common.ServerTime:getTime() then
			return var_50_0
		end
	end

	return nil
end

function GveData:getAllGiveUpTiled()
	local var_51_0 = {}

	for iter_51_0, iter_51_1 in pairs(self._mySiteMap) do
		if self:getGiveUpTime(iter_51_1.x, iter_51_1.y) then
			table.insert(var_51_0, iter_51_1)
		end
	end

	return var_51_0
end

function GveData:onSetCellKnight(arg_52_1)
	self:setMySiteChange(arg_52_1.x, arg_52_1.y, arg_52_1.knight_id)
end

function GveData:setMySiteChange(arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	if not self._mySiteMap[arg_53_1 .. "_" .. arg_53_2] then
		local var_53_0 = {
			x = arg_53_1,
			y = arg_53_2,
			knight = arg_53_3,
			giveUpTs = arg_53_4
		}

		self._mySiteMap[arg_53_1 .. "_" .. arg_53_2] = var_53_0

		table.insert(self._mySiteList, var_53_0)
	else
		self._mySiteMap[arg_53_1 .. "_" .. arg_53_2].knight = arg_53_3
	end

	self:calcAllUpKnight()
end

function GveData:deleteMySite(arg_54_1, arg_54_2)
	if self._mySiteMap[arg_54_1 .. "_" .. arg_54_2] then
		self._mySiteMap[arg_54_1 .. "_" .. arg_54_2] = nil
	end

	for iter_54_0, iter_54_1 in ipairs(self._mySiteList) do
		if iter_54_1.x == arg_54_1 and iter_54_1.y == arg_54_2 then
			table.remove(self._mySiteList, iter_54_0)

			break
		end
	end

	self:calcAllUpKnight()
end

function GveData:calcAllUpKnight()
	self._allCtrlKnight = {}

	for iter_55_0, iter_55_1 in ipairs(self._mySiteList) do
		if iter_55_1.knight ~= 0 then
			self._allCtrlKnight[iter_55_1.knight] = true
		end
	end
end

function GveData:getLastMySite()
	return self._mySiteList[#self._mySiteList]
end

function GveData:getAllMySiteInfoList()
	return self._mySiteList
end

function GveData:getMySiteCtrlData()
	local var_58_0 = {
		small = {},
		middle = {},
		big = {}
	}

	for iter_58_0, iter_58_1 in ipairs(self._mySiteList) do
		local var_58_1 = {
			x = iter_58_1.x,
			y = iter_58_1.y
		}
		local var_58_2 = self:getBuildDataByPos(var_58_1)
		local var_58_3 = self:getBaseCfgByPos(var_58_1)

		if var_58_3 then
			if var_58_3.base_type == 1 then
				table.insert(var_58_0.small, {
					baseCfg = var_58_3,
					knight = iter_58_1.knight,
					cfg = var_58_2.cfg
				})
			elseif var_58_3.base_type == 2 or var_58_3.base_type == 3 then
				table.insert(var_58_0.middle, {
					baseCfg = var_58_3,
					knight = iter_58_1.knight,
					cfg = var_58_2.cfg
				})
			elseif var_58_3.base_type == 4 then
				table.insert(var_58_0.big, {
					baseCfg = var_58_3,
					knight = iter_58_1.knight,
					cfg = var_58_2.cfg
				})
			end
		end
	end

	local function var_58_4(arg_59_0, arg_59_1)
		if arg_59_0.baseCfg.base_level ~= arg_59_1.baseCfg.base_level then
			return arg_59_0.baseCfg.base_level < arg_59_1.baseCfg.base_level
		end

		if arg_59_0.cfg.x ~= arg_59_1.cfg.x then
			return arg_59_0.cfg.x < arg_59_1.cfg.x
		end

		if arg_59_0.cfg.y ~= arg_59_1.cfg.y then
			return arg_59_0.cfg.y < arg_59_1.cfg.y
		end

		return false
	end

	table.sort(var_58_0.small, var_58_4)
	table.sort(var_58_0.middle, var_58_4)
	table.sort(var_58_0.big, var_58_4)

	return var_58_0
end

function GveData:getAllCanLineUpKnight(arg_60_1, arg_60_2)
	local var_60_0 = {
		x = arg_60_1,
		y = arg_60_2
	}
	local var_60_1 = self:getBuildDataByPos(var_60_0)
	local var_60_2 = self:getBaseCfgByPos(var_60_0)
	local var_60_3

	if not self._mySiteMap[arg_60_1 .. "_" .. arg_60_2] then
		do return {} end

		var_60_3 = {}
	end

	for iter_60_0, iter_60_1 in ipairs((g.core.model.User.knightsData:getOwnerAllList())) do
		if iter_60_1:getGroup() == var_60_1.cfg.group then
			local var_60_4 = iter_60_1:getServerId()
			local var_60_5 = iter_60_1:getBaseInfo()

			if self._allCtrlKnight[var_60_4] then
				if var_60_4 == self._mySiteMap[arg_60_1 .. "_" .. arg_60_2].knight then
					table.insert(var_60_3, {
						isCurSite = true,
						knight = iter_60_1
					})
				end
			elseif var_60_2.knight_quality < var_60_5.quality then
				table.insert(var_60_3, {
					knight = iter_60_1
				})
			elseif var_60_2.knight_quality == var_60_5.quality and iter_60_1:getStarLv() >= var_60_2.knight_star then
				table.insert(var_60_3, {
					knight = iter_60_1
				})
			end
		end
	end

	table.sort(var_60_3, function(arg_61_0, arg_61_1)
		local var_61_0 = arg_61_1.knight

		if arg_61_0.knight:getQuality() ~= arg_61_1.knight:getQuality() then
			return arg_61_0.knight:getQuality() > var_61_0:getQuality()
		end

		if arg_61_0.knight:getStarLv() ~= var_61_0:getStarLv() then
			return arg_61_0.knight:getStarLv() > var_61_0:getStarLv()
		end

		return arg_61_0.knight:getAdvanceId() > var_61_0:getAdvanceId()
	end)

	return var_60_3
end

function GveData:getMinePointData(arg_62_1, arg_62_2)
	if not self._ownerMap[arg_62_1 .. "_" .. arg_62_2] then
		return nil
	end

	return self._mySiteMap[self._ownerMap[arg_62_1 .. "_" .. arg_62_2]]
end

function GveData:getMyGridNum()
	return #self._mySiteList
end

function GveData:setJumpPos(arg_64_1)
	self._jumpPos = arg_64_1
end

function GveData:getJumpPos()
	self._jumpPos = nil

	return self._jumpPos
end

function GveData:getMaxGridNum()
	return g.core.model.User.gveDataMgr:getGveTaskData():getPrivilegeGridNum()
end

function GveData:canIGetNewGrid()
	return self:getMyGridNum() < self:getMaxGridNum()
end

function GveData:getCurResourceRate()
	local var_68_0 = 0
	local var_68_1 = var_0_3:getCurArmyAddProduct() + 1

	for iter_68_0, iter_68_1 in ipairs(self._mySiteList) do
		local var_68_2 = self:getBaseCfgByPos(iter_68_1)

		if var_68_2 then
			var_68_0 = iter_68_1.knight and iter_68_1.knight ~= 0 and var_68_0 + math.floor(var_68_1 * math.floor(var_68_2.equip_mat_rate * (1 + var_68_2.addition_mat * 0.001) / var_68_2.equip_mat_time * 3600 * 100) / 100 * 100) / 100 or var_68_0 + math.floor(var_68_1 * math.floor(var_68_2.equip_mat_rate / var_68_2.equip_mat_time * 3600 * 100) / 100 * 100) / 100
		end
	end

	return var_68_0
end

function GveData:setMySiteGiveUp(arg_69_1, arg_69_2, arg_69_3)
	if self._mySiteMap[arg_69_1 .. "_" .. arg_69_2] then
		self._mySiteMap[arg_69_1 .. "_" .. arg_69_2].giveUpTs = arg_69_3
	end
end

function GveData:isGridCanGiveUp()
	local var_70_0 = 0

	for iter_70_0, iter_70_1 in ipairs(self._mySiteList) do
		if not iter_70_1.giveUpTs or iter_70_1.giveUpTs == 0 then
			var_70_0 = var_70_0 + 1
		end
	end

	return var_70_0 > 1
end

function GveData:haveNearXYNum(arg_71_1, arg_71_2, arg_71_3)
	return (arg_71_1[arg_71_2 - 1 .. "_" .. arg_71_3] and 1 or 0) + (arg_71_1[arg_71_2 + 1 .. "_" .. arg_71_3] and 1 or 0) + (arg_71_1[arg_71_2 .. "_" .. arg_71_3 - 1] and 1 or 0) + (arg_71_1[arg_71_2 .. "_" .. arg_71_3 + 1] and 1 or 0)
end

function GveData:setPointColorType(arg_72_1, arg_72_2, arg_72_3)
	local var_72_0 = false
	local var_72_1 = arg_72_2 .. "_" .. arg_72_3

	if self._mySiteMap[arg_72_2 .. "_" .. arg_72_3] then
		self._occupiedPoints[var_72_1] = GveConst.COLOR_TYPE.MINE
		var_72_0 = true
	elseif self._specialBossPoint[var_72_1] and self._specialBossPoint[var_72_1] == GveConst.SPECIAL_POINT.GVE_SPECIAL_CAN_MOVE_POS then
		var_72_0 = true
		self._occupiedPoints[var_72_1] = GveConst.COLOR_TYPE.OTHER_PASS
	end

	for iter_72_0, iter_72_1 in pairs(arg_72_1) do
		if self._occupiedPoints[iter_72_0] == GveConst.COLOR_TYPE.MINE or self._occupiedPoints[iter_72_0] == GveConst.COLOR_TYPE.OTHER_PASS then
			if self._mySiteMap[var_72_1] then
				self._occupiedPoints[var_72_1] = GveConst.COLOR_TYPE.MINE or GveConst.COLOR_TYPE.OTHER_PASS
			end

			break
		elseif var_72_0 then
			if self._mySiteMap[iter_72_0] then
				self._occupiedPoints[iter_72_0] = GveConst.COLOR_TYPE.MINE or GveConst.COLOR_TYPE.OTHER_PASS
			end
		else
			break
		end
	end
end

function GveData:restoreTuanList()
	self._tuanList = {}

	for iter_73_0, iter_73_1 in pairs(self._occupiedPoints) do
		local var_73_0 = string.split(iter_73_0, "_")

		self:addPoint(tonumber(var_73_0[1]), (tonumber(var_73_0[2])))
	end
end

function GveData:addPoint(arg_74_1, arg_74_2, arg_74_3)
	arg_74_3 = arg_74_3 or self._tuanList

	local var_74_0 = self:haveNearXYNum(self._occupiedPoints, arg_74_1, arg_74_2)
	local var_74_1 = {}

	for iter_74_0 = 1, #arg_74_3 do
		local var_74_2 = self:haveNearXYNum(arg_74_3[iter_74_0], arg_74_1, arg_74_2)

		if var_74_2 > 0 then
			if #var_74_1 == 0 then
				self:setPointColorType(arg_74_3[iter_74_0], arg_74_1, arg_74_2)

				arg_74_3[iter_74_0][arg_74_1 .. "_" .. arg_74_2] = true
			end

			table.insert(var_74_1, iter_74_0)

			var_74_0 = var_74_0 - var_74_2

			if var_74_0 <= 0 then
				break
			end
		end
	end

	if #var_74_1 == 0 then
		local var_74_3 = {
			[arg_74_1 .. "_" .. arg_74_2] = true
		}

		self:setPointColorType(var_74_3, arg_74_1, arg_74_2)
		table.insert(arg_74_3, var_74_3)
	elseif #var_74_1 > 1 then
		for iter_74_1 = #var_74_1, 2, -1 do
			for iter_74_2, iter_74_3 in pairs(arg_74_3[var_74_1[iter_74_1]]) do
				local var_74_4 = string.split(iter_74_2, "_")

				self:setPointColorType(arg_74_3[var_74_1[1]], tonumber(var_74_4[1]), (tonumber(var_74_4[2])))

				arg_74_3[var_74_1[1]][iter_74_2] = iter_74_3
			end

			table.remove(arg_74_3, var_74_1[iter_74_1])
		end

		self:reCalcTuanColor(arg_74_3[var_74_1[1]])
	end
end

function GveData:reCalcTuanColor(arg_75_1)
	local var_75_0 = false

	for iter_75_0, iter_75_1 in pairs(arg_75_1) do
		if self._mySiteMap[iter_75_0] or self._specialBossPoint[iter_75_0] and self._specialBossPoint[iter_75_0] == GveConst.SPECIAL_POINT.GVE_SPECIAL_CAN_MOVE_POS then
			var_75_0 = true

			break
		end
	end

	for iter_75_2, iter_75_3 in pairs(arg_75_1) do
		if var_75_0 then
			if self._mySiteMap[iter_75_2] then
				self._occupiedPoints[iter_75_2] = GveConst.COLOR_TYPE.MINE or GveConst.COLOR_TYPE.OTHER_PASS
			end
		else
			self._occupiedPoints[iter_75_2] = GveConst.COLOR_TYPE.OTHER_NO_PASS
		end
	end
end

function GveData:delPoint(arg_76_1, arg_76_2)
	local var_76_0 = 0

	for iter_76_0 = 1, #self._tuanList do
		if self._tuanList[iter_76_0][arg_76_1 .. "_" .. arg_76_2] then
			self._tuanList[iter_76_0][arg_76_1 .. "_" .. arg_76_2] = nil
			var_76_0 = iter_76_0

			break
		end
	end

	if var_76_0 == 0 then
		return
	end

	local var_76_1 = {}

	for iter_76_1, iter_76_2 in pairs(self._tuanList[var_76_0]) do
		local var_76_2 = string.split(iter_76_1, "_")

		if self._occupiedPoints[iter_76_1] then
			self._occupiedPoints[iter_76_1] = GveConst.COLOR_TYPE.OTHER_NO_PASS
		end

		self:addPoint(tonumber(var_76_2[1]), tonumber(var_76_2[2]), var_76_1)
	end

	table.remove(self._tuanList, var_76_0)

	for iter_76_3 = 1, #var_76_1 do
		table.insert(self._tuanList, var_76_1[iter_76_3])
	end
end

function GveData:isBossAlive(arg_77_1)
	local var_77_0 = self:getBossData(arg_77_1, nil, nil)

	if var_77_0 then
		return not var_77_0:isDeadByIndex(0)
	end

	return false
end

function GveData:isFinalBossAlive()
	return self:isBossAlive(self._finalBossId)
end

function GveData:setLastBossInfoTime(arg_79_1)
	self._lastBossInfoTime = arg_79_1
end

function GveData:getLastBossInfoTime()
	return self._lastBossInfoTime
end

function GveData:getFinalBossName()
	return var_0_8.get(self._finalBossId).name
end

function GveData:onS2CChallengeBossEnd(arg_82_1)
	self._randBossShowAward = arg_82_1.awards

	if self._randBossShowAward then
		self._randAwardTime = self._randAwardTime + 1
	end

	self:getBossData(arg_82_1.boss_id, nil, nil):updateBossData(arg_82_1.boss_info)

	self._finalAward = arg_82_1.boss9_awards
end

function GveData:onS2CBossNotify(arg_83_1)
	self:getBossData(arg_83_1.boss_id, nil, nil):setBossIsDead(true, arg_83_1.guard_id or 0)
	self:setBossKilled()
end

function GveData:onS2CAllBossIsDead(arg_84_1)
	local var_84_1 = false

	for iter_84_0, iter_84_1 in pairs(arg_84_1.boss or {}) do
		local var_84_2 = self:getBossData(iter_84_1.boss_id, nil, nil)

		if var_84_2 then
			var_84_2:setBossIsDead(iter_84_1.is_dead, 0)
			var_84_2:updateBossExpireTime(iter_84_1.expire_time)

			if iter_84_1.boss_id >= 1 and iter_84_1.boss_id <= 5 and iter_84_1.is_dead then
				var_84_1 = true
			end
		end
	end

	self._isBossHasBeKilled = var_84_1
end

function GveData:onRedPointInfo(arg_85_1)
	for iter_85_0, iter_85_1 in pairs(arg_85_1.Boss or {}) do
		local var_85_1 = self:getBossData(iter_85_1.boss_id, nil, nil)

		if var_85_1 then
			var_85_1:setBossIsDead(iter_85_1.is_dead, 0)
		end
	end

	self._isBossHasBeKilled = arg_85_1.KillBoss
end

function GveData:onS2CGetBossInfo(arg_86_1)
	local var_86_0 = arg_86_1.boss_info or {}
	local var_86_1 = self:getBossData(arg_86_1.boss_id, arg_86_1.x, arg_86_1.y)

	var_86_1:refreshMaxHp()
	var_86_1:updateBossData(var_86_0)

	if arg_86_1.boss_id == GveConst.FINAL_BOSS_ID then
		var_86_1:updateChallengeState(arg_86_1.boss9_challenge_count, var_0_8.get(GveConst.FINAL_PRE_BOSS_ID).end_time + g.core.model.User.gveDataMgr:getGveSignUpEndTime(), arg_86_1.boss9_damage_max)
	end
end

function GveData:onRandBossInfoSync(arg_87_1)
	for iter_87_0, iter_87_1 in ipairs(arg_87_1.boss_info) do
		self:getBossData(iter_87_1.boss_id, arg_87_1.x, arg_87_1.y):updateBossData(iter_87_1 or {})
	end
end

function GveData:getRandBossShowAward()
	if self._randBossShowAward then
		self._randBossShowAward = nil

		return self._randBossShowAward
	end

	return nil
end

function GveData:getBossKey(arg_89_1, arg_89_2, arg_89_3)
	return arg_89_1
end

function GveData:setTodayRandBossRandTime(arg_90_1)
	self._randAwardTime = arg_90_1 or 0
end

function GveData:getTodayRandBossRandTime()
	return self._randAwardTime
end

function GveData:getBossData(arg_92_1, arg_92_2, arg_92_3)
	local var_92_0 = self:getBossKey(arg_92_1, arg_92_2, arg_92_3)

	self._bossDataList[var_92_0] = self._bossDataList[var_92_0] or GveBossStruct.new(arg_92_1, arg_92_2, arg_92_3)

	return self._bossDataList[var_92_0]
end

function GveData:getFinalChallengeBoss()
	return self:getBossData(GveConst.FINAL_BOSS_ID)
end

function GveData:getFinalPreBoss()
	return self:getBossData(GveConst.FINAL_PRE_BOSS_ID)
end

function GveData:getPosNowBossCfg(arg_95_1, arg_95_2)
	local var_95_0

	if self._findBossMap[arg_95_1 .. "_" .. arg_95_2] then
		for iter_95_0, iter_95_1 in ipairs(self._bossCfg[self._findBossMap[arg_95_1 .. "_" .. arg_95_2].x .. "_" .. self._findBossMap[arg_95_1 .. "_" .. arg_95_2].y]) do
			if self:isBossAlive(iter_95_1.id) then
				return iter_95_1
			else
				var_95_0 = iter_95_1
			end
		end
	end

	return nil, var_95_0
end

function GveData:isPosHasBoss(arg_96_1, arg_96_2)
	return self._findBossMap[arg_96_1 .. "_" .. arg_96_2]
end

function GveData:isCurSiteCanClick(arg_97_1, arg_97_2)
	local var_97_0 = self:getPosNowBossCfg(arg_97_1, arg_97_2)

	if not var_97_0 then
		return true
	end

	if not self:getBossData(var_97_0.id, nil, nil):isGetServerBossDead() then
		return false
	end

	return true
end

function GveData:getAllBossMap()
	return self._bossCfg
end

function GveData:getCurGridBaseData(arg_99_1, arg_99_2)
	return self._curGridBaseData[arg_99_1 .. "_" .. arg_99_2] or {}
end

function GveData:checkInitIdleTime()
	if var_0_3:getGveTimeState() ~= GveConst.GVE_TIME_STATE.FORMAL then
		self._lastRewardIdleTime = g.core.common.ServerTime:getTime()

		return
	end

	if not self._lastRewardIdleTime then
		local var_100_0 = g.core.common.Storage:load("gve_lastIdle_reward_time_new.json")

		if not var_100_0 then
			self._lastRewardIdleTime = g.core.common.ServerTime:getTime()

			g.core.common.Storage:save("gve_lastIdle_reward_time_new.json", {
				time = self._lastRewardIdleTime,
				season = var_0_3:getSeasonId()
			})
		elseif var_100_0.season == var_0_3:getSeasonId() then
			self._lastRewardIdleTime = var_100_0.time
		else
			self._lastRewardIdleTime = g.core.common.ServerTime:getTime()

			g.core.common.Storage:save("gve_lastIdle_reward_time_new.json", {
				time = self._lastRewardIdleTime,
				season = var_0_3:getSeasonId()
			})
		end
	end
end

function GveData:getCanRecIdleReward()
	self:checkInitIdleTime()

	return g.core.common.ServerTime:getTime() - self._lastRewardIdleTime >= 1200
end

function GveData:getAllIdleTime()
	self:checkInitIdleTime()

	return g.core.common.ServerTime:getTime() - self._lastRewardIdleTime
end

function GveData:getIdleReward()
	self._lastRewardIdleTime = g.core.common.ServerTime:getTime()

	g.core.common.Storage:save("gve_lastIdle_reward_time_new.json", {
		time = self._lastRewardIdleTime,
		season = var_0_3:getSeasonId()
	})
end

function GveData:getPosCurOperateData(arg_104_1, arg_104_2)
	local var_104_0 = self:getPosNowBossCfg(arg_104_1, arg_104_2)

	if var_104_0 then
		return {
			isBoss = true,
			bossCfg = var_104_0
		}
	else
		return {
			isBoss = false,
			gridData = self:getBuildDataByPos({
				x = arg_104_1,
				y = arg_104_2
			})
		}
	end
end

function GveData:getGridNumByLevel(arg_105_1)
	if arg_105_1 < 5 then
		return 3
	elseif arg_105_1 < 9 then
		return 1
	else
		return 2
	end
end

function GveData:isSiteCanUpKnight(arg_106_1)
	if not self._mySiteMap[arg_106_1.x .. "_" .. arg_106_1.y] then
		return false
	end

	if self._mySiteMap[arg_106_1.x .. "_" .. arg_106_1.y].knight and self._mySiteMap[arg_106_1.x .. "_" .. arg_106_1.y].knight ~= 0 then
		return false
	end

	local var_106_0 = self:getBuildDataByPos(arg_106_1)

	if not var_106_0 then
		return false
	end

	if var_106_0.cfg.group == 0 then
		return false
	end

	return #self:getAllCanLineUpKnight(arg_106_1.x, arg_106_1.y) > 0
end

function GveData:hasSiteCanUpKnight()
	if #self._mySiteList == 0 then
		return false
	end

	for iter_107_0, iter_107_1 in ipairs(self._mySiteList) do
		if self:isSiteCanUpKnight(iter_107_1) then
			return true
		end
	end

	return false
end

function GveData:setShowGridBuff(arg_108_1)
	self._showBuffState = arg_108_1

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GRID_BUFF_REFRESH)
	g.core.common.Storage:save("gveShowGridBuffState.json", {
		state = self._showBuffState and 1 or 0
	})
end

function GveData:isGridBuffShow()
	self:checkAndLoadBuffState()

	return self._showBuffState
end

function GveData:checkAndLoadBuffState()
	if not self._isLoadBuffShowState then
		self._isLoadBuffShowState = true

		local var_110_0 = g.core.common.Storage:load("gveShowGridBuffState.json")

		if not var_110_0 then
			self._showBuffState = false
		else
			self._showBuffState = var_110_0.state == 1
		end
	end
end

function GveData:isTargetTileSaved(arg_111_1)
	return self._targetSiteTiledIdDict[arg_111_1.x .. "_" .. arg_111_1.y] and self._targetSiteTiledIdDict[arg_111_1.x .. "_" .. arg_111_1.y] ~= 0
end

function GveData:saveTargetTile(arg_112_1, arg_112_2)
	self._targetSiteTiledIdDict[arg_112_1.x .. "_" .. arg_112_1.y] = arg_112_2
end

function GveData:getTargetTile(arg_113_1)
	return self._targetSiteTiledIdDict[arg_113_1.x .. "_" .. arg_113_1.y] or 0
end

function GveData:isCurPosInFogCloud(arg_114_1)
	for iter_114_0 = 1, self._fogCheckSize do
		local var_114_0 = var_0_2.indexOf(iter_114_0)

		if GveFogConfig.isHasFog(arg_114_1.x, arg_114_1.y, var_114_0.pic) and not self:checkFogCondition(var_114_0) then
			return true
		end
	end

	return false
end

function GveData:getIsHasFogCloud()
	for iter_115_0 = 1, self._fogCheckSize do
		local var_115_0 = var_0_2.indexOf(iter_115_0)

		if not self:checkFogCondition(var_115_0) then
			return true, var_115_0.id
		end
	end

	return false
end

function GveData:checkFogCondition(arg_116_1)
	if arg_116_1.way == 1 then
		for iter_116_0 = 1, 5 do
			if arg_116_1["value_" .. iter_116_0] ~= 0 then
				local var_116_0 = self:getBossData(arg_116_1["value_" .. iter_116_0])

				if not var_116_0 then
					return true
				end

				if var_116_0:isGetServerBossDead() and var_116_0:isDeadByIndex() then
					return true
				end
			end
		end

		return false
	else
		return true
	end
end

function GveData:setCurCenterPos(arg_117_1)
	self._curCenterPos = arg_117_1
end

function GveData:getCurCenterPos()
	return self._curCenterPos or self._initPos
end

function GveData:setBossKilled()
	self._isBossHasBeKilled = true
end

function GveData:hasKillBoss()
	return self._isBossHasBeKilled
end

function GveData:isKillResearchOpenAndNotIn()
	if g.core.model.User.guideData:getServerDataById(g.core.const.ConstMgr.GuideConst.SAVE_SERVER_DATA_IDS.GVE_FIRST_ENTER_KILL_RESEARCH) then
		return false
	end

	return self._isBossHasBeKilled
end

function GveData:getNearestStageBoss(arg_122_1)
	local var_122_0 = {
		x = self._initPos.x,
		y = self._initPos.y
	}

	for iter_122_0 = 1, var_0_8.getLength() do
		local var_122_1 = var_0_8.indexOf(iter_122_0)
		local var_122_3

		if var_122_1.boss_group == arg_122_1 then
			local var_122_2 = math.abs(var_122_1.x - var_122_0.x) + math.abs(var_122_1.y - var_122_0.y)

			if var_122_2 < 9999999 then
				var_122_3 = var_122_2
				var_122_0.x = var_122_1.x
				var_122_0.y = var_122_1.y
			end
		end
	end

	return var_122_0
end

function GveData:isAllBossKilled(arg_123_1)
	for iter_123_0 = 1, var_0_8.getLength() do
		local var_123_0 = var_0_8.indexOf(iter_123_0)

		if var_123_0.boss_group == arg_123_1 then
			local var_123_1 = self:getBossData(self:getBossKey(var_123_0.id))

			if not var_123_1:isGetServerBossDead() then
				return false
			end

			if not var_123_1:isDeadByIndex() then
				return false
			end
		end
	end

	return true
end

function GveData:isAllNormalBossKilled()
	for iter_124_0 = 1, 8 do
		local var_124_0 = self:getBossData(self:getBossKey(var_0_8.indexOf(iter_124_0).id))

		if not var_124_0:isGetServerBossDead() then
			return false
		end

		if not var_124_0:isDeadByIndex() then
			return false
		end
	end

	return true
end

function GveData:saveShowMiniMapDetail(arg_125_1)
	self._isShowMiniMapDetail = {
		show = arg_125_1
	}

	g.core.common.Storage:save("gve_show_minimap_detail.json", self._isShowMiniMapDetail)
end

function GveData:loadShowMiniMapDetail()
	self._isShowMiniMapDetail = g.core.common.Storage:load("gve_show_minimap_detail.json") or {
		show = false
	}
end

function GveData:isShowMiniMapDetail()
	if not self._isShowMiniMapDetail then
		self:loadShowMiniMapDetail()
	end

	return self._isShowMiniMapDetail.show
end

function GveData:getFinalChallengeAward()
	if self._finalAward then
		self._finalAward = nil
	end

	return self._finalAward
end

function GveData:updateCellUid(arg_129_1, arg_129_2)
	self._uidMap[arg_129_1] = arg_129_2

	local var_129_0 = self:getAllPointByKeyStr(arg_129_1)

	if not var_129_0 then
		return
	end

	for iter_129_0, iter_129_1 in ipairs(var_129_0) do
		self._uidMap[iter_129_1] = arg_129_2
	end
end

function GveData:getCellUid(arg_130_1)
	return self._uidMap[table.concat({
		arg_130_1.x,
		arg_130_1.y
	}, "_")]
end

function GveData:checkIsGiveUpTipPop()
	if self._giveUpTipTime > 0 then
		return not g.core.common.ServerTime:isToday(self._giveUpTipTime)
	else
		return true
	end
end

function GveData:setGiveUpTipTime(arg_132_1)
	if arg_132_1 > 0 and g.core.common.ServerTime:isToday(self._giveUpTipTime) then
		return
	end

	self._giveUpTipTime = arg_132_1

	g.core.common.Storage:save("gve_giveup_tip.json", {
		lastTipTime = arg_132_1
	}, true)
end

return GveData
