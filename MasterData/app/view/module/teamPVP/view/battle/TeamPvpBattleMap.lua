local var_0_0 = g.core.const.ConstMgr.TeamPvpConst
local var_0_1 = g.core.model.User.teamPvpData
local var_0_2 = g.core.const.ConstMgr.SpineConst
local var_0_3 = g.core.common.Path
local TeamPvpBattleMap = class("TeamPvpBattleMap")

function TeamPvpBattleMap:ctor()
	self._playerList = {}
	self._enemyList = {}
	self._playerPos = {}
	self._enemyPos = {}
	self._towerLeftList = {}
	self._towerRightList = {}
	self._towerLeftPos = {}
	self._towerRightPos = {}
	self._leftPos = {}
	self._rightPos = {}
	self._reportData = nil
	self._curTurn = 1
	self._lastTurn = 0
	self._isEnterBattleResult = false
	self._isExtraTurn = false
	self._npcDelayTime = 0

	local var_1_0 = var_0_1:getMapId()

	self._mapId = var_1_0 > 0 and var_1_0 or var_0_0.MAP_TYPE.SNOW
	self._playerMax = var_0_0.MAP_PARMAS[self._mapId].MaxPlayerLen
	self._battleLine = var_0_0.MAP_PARMAS[self._mapId].Line
	self._beAttackTowers = {}
	self._endTimeStemp = 0
	self._scheduleHandler = nil
	self._isRunning = false
	self._stepList = {}
end

function TeamPvpBattleMap:onLoad()
	self:initListData()
	cc.Director:getInstance():getScheduler():setTimeScale(1.5)
	self:newSchedule(handler(self, self._aniUpdate), 0.5)
end

function TeamPvpBattleMap:initListData()
	for iter_3_0 = 1, self._playerMax do
		local var_3_0 = self:getChild("player" .. iter_3_0)

		if var_3_0 then
			table.insert(self._playerList, var_3_0)
			table.insert(self._playerPos, var_3_0:getPosition())
		end

		local var_3_1 = self:getChild("enemy" .. iter_3_0)

		if var_3_1 then
			table.insert(self._enemyList, var_3_1)
			table.insert(self._enemyPos, var_3_1:getPosition())
		end

		local var_3_2 = self:getChild("leftTower" .. iter_3_0)

		if var_3_2 then
			local var_3_3 = var_3_2:getSize()
			local var_3_4 = var_3_2:getPosition()

			table.insert(self._towerLeftList, {
				tower = var_3_2,
				pos = {
					x = var_3_4.x + var_3_3.width,
					y = var_3_4.y + var_3_3.height / 2
				}
			})
		end

		local var_3_5 = self:getChild("rightTower" .. iter_3_0)

		if var_3_5 then
			local var_3_6 = var_3_5:getPosition()

			table.insert(self._towerRightList, {
				tower = var_3_5,
				pos = {
					x = var_3_6.x,
					y = var_3_6.y + var_3_5:getSize().height / 2
				}
			})
		end

		local var_3_7 = (iter_3_0 - 1) % self._battleLine + 1
		local var_3_8 = self:getChild("hitPos" .. iter_3_0)

		if var_3_8 then
			table.insert(self._towerLeftPos, var_3_8:getPosition())

			self._leftPos[var_3_7] = self._leftPos[var_3_7] or {}

			table.insert(self._leftPos[var_3_7], var_3_8:getPosition())
		end

		local var_3_9 = self:getChild("hitEnemyPos" .. iter_3_0)

		if var_3_9 then
			table.insert(self._towerRightPos, var_3_9:getPosition())

			self._rightPos[var_3_7] = self._rightPos[var_3_7] or {}

			table.insert(self._rightPos[var_3_7], var_3_9:getPosition())
		end
	end
end

function TeamPvpBattleMap:updateMapComp(arg_4_1)
	if arg_4_1 then
		self._isExtraTurn = arg_4_1.isExtra or false
	end

	local var_4_0 = var_0_1:getBattleReport()

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0.playerInfos and var_4_0.playerInfos.positions

	local function var_4_2(arg_5_0)
		local var_5_0 = 100

		if self._isExtraTurn then
			for iter_5_0, iter_5_1 in ipairs(var_4_0.normal_turn) do
				if (iter_5_1.atk_guid == arg_5_0 or iter_5_1.def_guid == arg_5_0) and var_5_0 > iter_5_1.hp_percent then
					var_5_0 = iter_5_1.hp_percent
				end
			end
		end

		return var_5_0
	end

	if self._isExtraTurn then
		self._battleLine = 1
		var_4_1 = var_0_1:getExtraPosition()
	end

	local function var_4_3(arg_6_0, arg_6_1)
		local var_6_0
		local var_6_1 = 0

		for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
			if arg_6_1[iter_6_0] and arg_6_1[iter_6_0].npc_type == var_0_0.NPC_TYPE.MASTER then
				var_6_0 = iter_6_1
				var_6_1 = iter_6_0
			end
		end

		return (var_6_0 or nil) and (var_6_1 - 1) % self._battleLine + 1
	end

	self._isAtk = var_4_0.isAtk

	if var_4_1 then
		local var_4_4 = var_4_3(self._playerList, var_4_1)

		for iter_4_0, iter_4_1 in ipairs(self._playerList) do
			local var_4_5 = var_4_1[iter_4_0] and var_4_1[iter_4_0].guid

			if var_4_5 then
				local var_4_6 = {
					isEnemy = false,
					playerguid = var_4_5,
					playerinfo = var_4_0.playerInfos.userInfos[var_4_1[iter_4_0].user_id]
				}

				if self._playerPos then
					var_4_6.curpos = self._playerPos[iter_4_0] or nil
				end

				var_4_6.npcType = var_4_1[iter_4_0].npc_type
				var_4_6.index = iter_4_0
				var_4_6.hp = var_4_2(var_4_5)
				var_4_6.masterLine = var_4_4

				iter_4_1:updatePlayer(var_4_6)
			else
				local var_4_7 = {
					isEnemy = false
				}

				if self._playerPos then
					var_4_7.curpos = self._playerPos[iter_4_0] or nil
				end

				var_4_7.index = iter_4_0
				var_4_7.masterLine = var_4_4

				iter_4_1:updatePlayer(var_4_7)
			end
		end
	end

	local var_4_8 = var_4_0.enemyInfos and var_4_0.enemyInfos.positions

	if self._isExtraTurn then
		var_4_8 = var_0_1:getEnemyExtraPosition()
	end

	if var_4_8 then
		local var_4_9 = var_4_3(self._enemyList, var_4_8)

		for iter_4_2, iter_4_3 in ipairs(self._enemyList) do
			local var_4_10 = var_4_8[iter_4_2] and var_4_8[iter_4_2].guid

			if var_4_10 then
				local var_4_11 = {
					isEnemy = true,
					playerguid = var_4_10,
					playerinfo = var_4_0.enemyInfos.userInfos[var_4_8[iter_4_2].user_id]
				}

				if self._enemyPos then
					var_4_11.curpos = self._enemyPos[iter_4_2] or nil
				end

				var_4_11.npcType = var_4_8[iter_4_2].npc_type
				var_4_11.index = iter_4_2
				var_4_11.hp = var_4_2(var_4_10)
				var_4_11.masterLine = var_4_9

				iter_4_3:updatePlayer(var_4_11)
			else
				local var_4_12 = {
					isEnemy = true
				}

				if self._enemyPos then
					var_4_12.curpos = self._enemyPos[iter_4_2] or nil
				end

				var_4_12.index = iter_4_2
				var_4_12.masterLine = var_4_9

				iter_4_3:updatePlayer(var_4_12)
			end
		end
	end

	local var_4_13 = var_0_1:getMapId()

	if self._isExtraTurn then
		var_4_13 = var_0_0.EXTRAID
	end

	for iter_4_4, iter_4_5 in ipairs(self._towerLeftList) do
		iter_4_5.tower:updateTower((var_4_13 == var_0_0.MAP_TYPE.FIRE and not self._isExtraTurn or nil) and {
			camp = 0,
			type = var_4_13,
			max = var_0_0.MAX_HP,
			curhp = var_0_0.MAX_HP,
			index = iter_4_4
		})
	end

	for iter_4_6, iter_4_7 in ipairs(self._towerRightList) do
		iter_4_7.tower:updateTower((var_4_13 == var_0_0.MAP_TYPE.FIRE and not self._isExtraTurn or nil) and {
			camp = 1,
			type = var_4_13,
			max = var_0_0.MAX_HP,
			curhp = var_0_0.MAX_HP,
			index = iter_4_6
		})
	end

	if self._isExtraTurn then
		local var_4_16 = self:getChild("extraLineLoader")

		if var_4_16 then
			var_4_16:setURL((var_0_3:getTeamPVPExtraBattleLineBg(var_0_1:getMapId())))
		end
	end
end

function TeamPvpBattleMap:moveforward(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = 1

	if arg_7_1 then
		local var_7_1
		local var_7_2

		if arg_7_1.atk_is_win == 1 then
			var_7_1, var_7_0 = self:_getPlayerInfo(arg_7_1.atk_guid)
			var_7_2 = self:_getPlayerInfo(arg_7_1.def_guid)
		elseif arg_7_1.atk_is_win == 2 then
			var_7_1, var_7_0 = self:_getPlayerInfo(arg_7_1.def_guid)
			var_7_2 = self:_getPlayerInfo(arg_7_1.atk_guid)
		elseif arg_7_1.atk_is_win == 3 then
			if arg_7_3 then
				var_7_1, var_7_0 = self:_getPlayerInfo(arg_7_1.atk_guid)
				var_7_2 = self:_getPlayerInfo(arg_7_1.def_guid)
			else
				var_7_1, var_7_0 = self:_getPlayerInfo(arg_7_1.def_guid)
				var_7_2 = self:_getPlayerInfo(arg_7_1.atk_guid)
			end
		end

		;(function(arg_8_0, arg_8_1)
			local var_8_0
			local var_8_1 = false

			for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
				if (iter_8_0 - 1) % self._battleLine + 1 == var_7_0 then
					local var_8_2 = arg_8_1 and arg_8_1:getCurPos() or nil

					if var_8_0 then
						var_8_2 = var_8_0
					end

					var_8_0 = iter_8_1:getCurPos()

					iter_8_1:run()

					local var_8_3 = {}
					local var_8_4 = {}

					if var_8_2 then
						var_8_4.x = var_8_2.x or var_8_0.x
					end

					if var_8_2 then
						var_8_4.y = var_8_2.y or var_8_0.y
					end

					var_8_3[1] = fgui.FMoveTo:create(1, var_8_4)
					var_8_3[2] = fgui.FCallFunc:create(handler(self, function()
						iter_8_1:idle()
						iter_8_1:setCurPos(var_8_2)
						self:_updatePlayerPos()

						if arg_7_2 and not var_8_1 then
							var_8_1 = true

							arg_7_2()
						end
					end))

					iter_8_1:runFGAction(fgui.FSequence:create(var_8_3))
				end
			end
		end)((var_7_1 and var_7_1:getIsEnemy() or false) and self._enemyList or self._playerList, var_7_2)

		if arg_7_1.atk_is_win == 3 and arg_7_3 == nil then
			self:moveforward(arg_7_1, arg_7_2, true)
		end
	end
end

function TeamPvpBattleMap:enterBattle()
	for iter_10_0, iter_10_1 in ipairs(self._playerList) do
		iter_10_1:enterInBattle()
	end

	for iter_10_2, iter_10_3 in ipairs(self._enemyList) do
		iter_10_3:enterInBattle()
	end
end

function TeamPvpBattleMap:allBattle()
	for iter_11_0, iter_11_1 in ipairs(self._playerList) do
		iter_11_1:startBattle()
	end

	for iter_11_2, iter_11_3 in ipairs(self._enemyList) do
		iter_11_3:startBattle()
	end
end

function TeamPvpBattleMap:allStop()
	for iter_12_0, iter_12_1 in ipairs(self._playerList) do
		iter_12_1:stop()
	end

	for iter_12_2, iter_12_3 in ipairs(self._enemyList) do
		iter_12_3:stop()
	end
end

function TeamPvpBattleMap:startBattle(arg_13_1, arg_13_2)
	self._reportData = arg_13_1

	self:sortTurn()

	self._isExtraTurn = arg_13_2

	if self._isExtraTurn then
		self._battleLine = 1
	end

	self:_battleShow()
end

function TeamPvpBattleMap:sortTurn()
	table.sort(self._reportData.normal_turn, function(arg_15_0, arg_15_1)
		local var_15_0, var_15_1 = self:_getPlayerInfo(arg_15_0.atk_guid)
		local var_15_2, var_15_3 = self:_getPlayerInfo(arg_15_1.atk_guid)

		if arg_15_0.id < arg_15_1.id then
			return true
		elseif arg_15_0.id == arg_15_1.id then
			return var_15_1 < var_15_3
		else
			return false
		end
	end)
end

function TeamPvpBattleMap:_moveToFighting(arg_16_1)
	local var_16_0 = 40
	local var_16_1 = 100

	if arg_16_1 then
		local var_16_2 = self:_getPlayerInfo(arg_16_1.atk_guid)
		local var_16_3 = self:_getPlayerInfo(arg_16_1.def_guid)

		if not var_16_2 or not var_16_3 then
			return
		end

		local var_16_4 = var_16_2:getNpcType()
		local var_16_5 = var_16_3:getNpcType()
		local var_16_6
		local var_16_7
		local var_16_8
		local var_16_9

		if var_16_2 then
			var_16_7 = var_16_2:getCurPos()
			var_16_9 = var_16_2:getIsEnemy()
		end

		if var_16_3 then
			var_16_8 = var_16_3:getCurPos()
		end

		if var_16_7 and var_16_8 then
			var_16_6 = {
				x = (var_16_7.x + var_16_8.x) / 2,
				y = var_16_7.y
			}
		end

		if var_16_6 then
			local function var_16_10(arg_17_0)
				local var_17_0 = arg_17_0:getCurPos()

				arg_17_0:setPosition(arg_17_0:getIsEnemy() and {
					x = var_16_6.x + var_16_1,
					y = var_16_6.y
				} or {
					x = var_16_6.x - var_16_1,
					y = var_16_6.y
				})
				arg_17_0:moveBack(arg_16_1)
			end

			var_16_2:startBattle()
			var_16_2:run()

			local var_16_11 = 0.4 + 0.2 * ((var_16_2:getCurPos().x - var_16_6.x) / 100)
			local var_16_12 = fgui.FCallFunc:create(function()
				return
			end)

			if self._isAtk then
				if var_16_4 == var_0_0.NPC_TYPE.ASSASSIN then
					var_16_12 = fgui.FCallFunc:create(function()
						self:dispatchCompEvent("BATTLE_PLAYER_SHOW_NPC_EFFECT", {
							npcType = (var_16_4 == var_0_0.NPC_TYPE.ASSASSIN or nil) and (var_16_4 or var_16_5)
						})
					end)
				end
			else
				var_16_12 = fgui.FCallFunc:create(function()
					self:dispatchCompEvent("BATTLE_PLAYER_SHOW_NPC_EFFECT", {
						npcType = (var_16_5 == var_0_0.NPC_TYPE.ASSASSIN or nil) and (var_16_5 or var_16_4)
					})
				end)
			end

			local var_16_13 = {}
			local var_16_14 = {}

			if var_16_9 then
				var_16_14.x = var_16_6.x + var_16_0 or var_16_6.x - var_16_0
			end

			var_16_14.y = var_16_6.y
			var_16_13[1] = fgui.FMoveTo:create(var_16_11, var_16_14)
			var_16_13[2] = var_16_12
			var_16_13[3] = fgui.FCallFunc:create(handler(self, function()
				var_16_2:doattack(handler(self, function()
					var_16_10(var_16_2)
				end))
			end))

			var_16_2:runFGAction(fgui.FSequence:create(var_16_13))
			var_16_3:startBattle()
			var_16_3:run()

			local var_16_15 = {}
			local var_16_16 = {}

			if var_16_9 then
				var_16_16.x = var_16_6.x - var_16_0 or var_16_6.x + var_16_0
			end

			var_16_16.y = var_16_6.y
			var_16_15[1] = fgui.FMoveTo:create(var_16_11, var_16_16)
			var_16_15[2] = fgui.FCallFunc:create(handler(self, function()
				var_16_3:beattack(handler(self, function()
					var_16_10(var_16_3)
				end))
			end))

			var_16_3:runFGAction(fgui.FSequence:create(var_16_15))
		else
			if var_16_2 then
				var_16_2:startBattle()
				var_16_2:moveBack(arg_16_1)
			end

			if var_16_3 then
				var_16_3:startBattle()
				var_16_3:moveBack(arg_16_1)
			end
		end
	end
end

function TeamPvpBattleMap:_battleShow()
	local var_25_0 = 3

	if self._reportData then
		if self._lastTurn == self._curTurn then
			return
		end

		self._lastTurn = self._curTurn

		local var_25_1 = self._isExtraTurn and self._reportData.extra_turn or self._reportData.normal_turn

		if self._curTurn <= #var_25_1 then
			local var_25_2 = var_25_1[self._curTurn]
			local var_25_3

			if self:_hasNpc(var_25_1[self._curTurn]) then
				var_25_0 = var_25_0 + self._npcDelayTime
				var_25_3 = {
					(fgui.FDelayTime:create(1))
				}
			end

			var_25_3[2] = fgui.FCallFunc:create(handler(self, function()
				self:_moveToFighting(var_25_2)
			end))
			var_25_3[3] = fgui.FDelayTime:create(var_25_0)
			var_25_3[4] = fgui.FCallFunc:create(handler(self, function()
				self._curTurn = self._curTurn + 1

				self:moveforward(var_25_2, handler(self, function()
					self:_battleShow()
				end))
			end))

			self:runFGAction(fgui.FSequence:create(var_25_3))
		else
			local var_25_4 = {
				(fgui.FDelayTime:create(0.3))
			}

			var_25_4[2] = fgui.FCallFunc:create(handler(self, function()
				self:_attackTower()
			end))

			self:runFGAction(fgui.FSequence:create(var_25_4))
		end
	end
end

function TeamPvpBattleMap:_getPlayerInfo(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(self._playerList) do
		if iter_30_1:getPlayerguid() == arg_30_1 then
			return iter_30_1, (iter_30_0 % self._battleLine == 0 or nil) and (self._battleLine or iter_30_0 % self._battleLine)
		end
	end

	for iter_30_2, iter_30_3 in pairs(self._enemyList) do
		if iter_30_3:getPlayerguid() == arg_30_1 then
			return iter_30_3, (iter_30_2 % self._battleLine == 0 or nil) and (self._battleLine or iter_30_2 % self._battleLine)
		end
	end

	return nil, 0
end

function TeamPvpBattleMap:_updatePlayerPos()
	for iter_31_0, iter_31_1 in pairs(self._playerPos) do
		self._playerPos[iter_31_0] = self._playerList[iter_31_0]:getCurPos()
	end

	for iter_31_2, iter_31_3 in pairs(self._enemyPos) do
		self._enemyPos[iter_31_2] = self._enemyList[iter_31_2]:getCurPos()
	end
end

function TeamPvpBattleMap:_moveToTower(arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	local var_32_0 = var_0_1:getMapId()
	local var_32_1 = 0
	local var_32_2

	for iter_32_0, iter_32_1 in pairs(arg_32_1) do
		if iter_32_1:getIsLive() then
			local var_32_3 = (iter_32_0 - 1) % self._battleLine + 1

			if self._mapId == var_0_0.MAP_TYPE.DESERT then
				var_32_2 = arg_32_2[2]

				if arg_32_2[2] and var_32_2.tower then
					table.insert(self._beAttackTowers, var_32_2.tower)
				end
			else
				if arg_32_2[var_32_3] then
					var_32_2 = arg_32_2[var_32_3]
				end

				if var_32_2 and var_32_2.tower and arg_32_4 then
					table.insert(self._beAttackTowers, var_32_2.tower)
				end
			end

			var_32_1 = var_32_1 + 1

			local var_32_4 = arg_32_3[var_32_1]

			if (var_32_0 == var_0_0.MAP_TYPE.SNOW or var_32_0 == var_0_0.MAP_TYPE.DESERT or var_32_0 == var_0_0.MAP_TYPE.SEA) and not self._isExtraTurn then
				var_32_4 = arg_32_5[var_32_3][1]

				table.remove(arg_32_5[var_32_3], 1)
			end

			local function var_32_5()
				local var_33_0

				if arg_32_2[(iter_32_0 - 1) % self._battleLine + 1] then
					var_33_0 = arg_32_2[(iter_32_0 - 1) % self._battleLine + 1]
				elseif var_32_0 == var_0_0.MAP_TYPE.FIRE then
					var_33_0 = arg_32_2[1]
				elseif var_32_0 == var_0_0.MAP_TYPE.DESERT then
					var_33_0 = arg_32_2[2]
				end

				self._isRunning = false

				if var_33_0 and var_33_0.tower then
					var_33_0.tower:beAttack()

					return var_33_0.tower:isDestroy()
				end

				return false
			end

			local function var_32_6()
				iter_32_1:attackTower(handler(self, var_32_5))
			end

			iter_32_1:run()
			iter_32_1:runFGAction(fgui.FSequence:create({
				fgui.FMoveTo:create(1 + var_32_1 * 0.2, {
					x = var_32_4.x,
					y = var_32_4.y
				}),
				fgui.FCallFunc:create(handler(self, function()
					iter_32_1:idle()
					iter_32_1:hideInfo()
					iter_32_1:setSortingOrder(var_32_1)
				end)),
				fgui.FDelayTime:create(1),
				fgui.FCallFunc:create(handler(self, var_32_6))
			}))
		end
	end
end

function TeamPvpBattleMap:setRunning(arg_36_1)
	self._isRunning = arg_36_1
end

function TeamPvpBattleMap:_attackTower()
	local var_37_0 = self._reportData and self._reportData.extra_turn

	self._isRunning = false
	self._stepList = {}
	self._stepList = self._mapId == var_0_0.MAP_TYPE.DESERT and (not var_37_0 and {
		handler(self, self._updateMorale),
		handler(self, self._playFirstLine),
		handler(self, self._playWin),
		handler(self, self._playFoodSuccessTitle),
		handler(self, self._playFlag),
		handler(self, self._playOtherLine)
	} or not self._isExtraTurn and {
		handler(self, self._updateMorale),
		handler(self, self._playFirstLine),
		handler(self, self._playWin),
		handler(self, self._playFoodSuccessTitle),
		handler(self, self._playFlag),
		function()
			self:finishBattle()
		end
	} or {
		function()
			self:moveToTower(self._enemyList, self._playerList)
		end
	}) or not var_37_0 and {
		function()
			self:moveToTower(self._enemyList, self._playerList)
		end
	} or not self._isExtraTurn and {
		function()
			self:finishBattle()
		end
	} or {
		function()
			self:moveToTower(self._enemyList, self._playerList)
		end
	}
end

function TeamPvpBattleMap:_playFlagLightAndCalMorale(arg_43_1)
	self:dispatchCompEvent("TEAMPVP_SHOW_FLAGACTION", {
		v = arg_43_1,
		isWin = self:isFoodWin()
	})
end

function TeamPvpBattleMap:_playFlag()
	local var_44_0 = {}
	local var_44_1 = {}

	var_44_0[2] = self._enemyList[2]
	var_44_0[5] = self._enemyList[5]
	var_44_0[8] = self._enemyList[8]
	var_44_0[3] = self._enemyList[3]
	var_44_0[6] = self._enemyList[6]
	var_44_0[9] = self._enemyList[9]
	var_44_0[12] = self._enemyList[12]
	var_44_1[2] = self._playerList[2]
	var_44_1[5] = self._playerList[5]
	var_44_1[8] = self._playerList[8]
	var_44_1[3] = self._playerList[3]
	var_44_1[6] = self._playerList[6]
	var_44_1[9] = self._playerList[9]
	var_44_1[12] = self._playerList[12]

	local function var_44_2(arg_45_0)
		local var_45_0 = true

		for iter_45_0, iter_45_1 in pairs(arg_45_0) do
			if iter_45_1 and iter_45_1:getIsLive() then
				var_45_0 = false

				iter_45_1:playFlag(handler(self, function(arg_46_0)
					arg_46_0:_playFlagLightAndCalMorale(iter_45_1)
				end))
			end
		end

		if var_45_0 then
			self._isRunning = false
		end
	end

	if self:isFoodWin() then
		var_44_2(var_44_1)
	else
		var_44_2(var_44_0)
	end
end

function TeamPvpBattleMap:_playFoodSuccessTitle()
	self:dispatchCompEvent("TEAMPVP_PLAYFOODSUCCESSTITLE")
end

function TeamPvpBattleMap:_playWin()
	local var_48_0 = {}
	local var_48_1 = {}

	var_48_0[1] = self._enemyList[1]
	var_48_0[4] = self._enemyList[4]
	var_48_0[7] = self._enemyList[7]
	var_48_0[10] = self._enemyList[10]
	var_48_1[1] = self._playerList[1]
	var_48_1[4] = self._playerList[4]
	var_48_1[7] = self._playerList[7]
	var_48_1[10] = self._playerList[10]

	local function var_48_2(arg_49_0)
		for iter_49_0, iter_49_1 in pairs(arg_49_0) do
			if iter_49_1 and iter_49_1:getIsLive() then
				iter_49_1:playAction(var_0_2.ACTION.SHOW)
			end
		end
	end

	var_48_2(var_48_0)
	var_48_2(var_48_1)

	self._isRunning = false
end

function TeamPvpBattleMap:_updateMorale()
	local var_50_0, var_50_1 = self:getMorale()

	self:dispatchCompEvent("TEAMPVP_UPDATE_MORALE", {
		lefthp = var_50_0,
		righthp = var_50_1
	})
end

function TeamPvpBattleMap:_playFirstLine()
	local var_51_0 = {}
	local var_51_1 = {}

	var_51_0[1] = self._enemyList[1]
	var_51_0[4] = self._enemyList[4]
	var_51_0[7] = self._enemyList[7]
	var_51_0[10] = self._enemyList[10]
	var_51_1[1] = self._playerList[1]
	var_51_1[4] = self._playerList[4]
	var_51_1[7] = self._playerList[7]
	var_51_1[10] = self._playerList[10]

	self:moveToTower(var_51_0, var_51_1)
end

function TeamPvpBattleMap:_playOtherLine()
	local var_52_0 = {}
	local var_52_1 = {}

	var_52_0[2] = self._enemyList[2]
	var_52_0[5] = self._enemyList[5]
	var_52_0[8] = self._enemyList[8]
	var_52_0[11] = self._enemyList[11]
	var_52_0[3] = self._enemyList[3]
	var_52_0[6] = self._enemyList[6]
	var_52_0[9] = self._enemyList[9]
	var_52_0[12] = self._enemyList[12]
	var_52_1[2] = self._playerList[2]
	var_52_1[5] = self._playerList[5]
	var_52_1[8] = self._playerList[8]
	var_52_1[11] = self._playerList[11]
	var_52_1[3] = self._playerList[3]
	var_52_1[6] = self._playerList[6]
	var_52_1[9] = self._playerList[9]
	var_52_1[12] = self._playerList[12]

	self:moveToTower(var_52_0, var_52_1)
end

function TeamPvpBattleMap:isFoodWin()
	local var_53_0 = false

	for iter_53_0, iter_53_1 in pairs({
		self._playerList[1],
		[4] = self._playerList[4],
		[7] = self._playerList[7],
		[10] = self._playerList[10]
	}) do
		if iter_53_1:getIsLive() then
			var_53_0 = true

			break
		end
	end

	return var_53_0
end

function TeamPvpBattleMap:_aniUpdate()
	self._stepList = self._stepList or {}

	if not self._isRunning and next(self._stepList) then
		self._isRunning = true

		self._stepList[1]()
		table.remove(self._stepList, 1)
	end
end

function TeamPvpBattleMap:moveToTower(arg_55_1, arg_55_2)
	local var_55_0 = var_0_1:isBattleWin()

	self._beAttackTowers = {}

	if var_55_0 then
		self:_moveToTower(arg_55_1, self._towerLeftList, self._towerLeftPos, not var_55_0, self._leftPos)
		self:_moveToTower(arg_55_2, self._towerRightList, self._towerRightPos, var_55_0, self._rightPos)
	else
		self:_moveToTower(arg_55_2, self._towerRightList, self._towerRightPos, var_55_0, self._rightPos)
		self:_moveToTower(arg_55_1, self._towerLeftList, self._towerLeftPos, not var_55_0, self._leftPos)
	end
end

function TeamPvpBattleMap:checkTowerDestroy()
	if #self._stepList == 0 and self._isRunning == false then
		local var_56_0 = true

		for iter_56_0, iter_56_1 in ipairs(self._beAttackTowers) do
			if not iter_56_1:isDestroy() then
				var_56_0 = false

				break
			end
		end

		if var_56_0 then
			self:finishBattle()
		end
	end
end

function TeamPvpBattleMap:finishBattle()
	self._isRunning = false

	if self._isEnterBattleResult then
		return
	end

	self._isEnterBattleResult = true

	self:allStop()

	self._endTimeStemp = g.core.common.ServerTime:getTime()
	self._scheduleHandler = self._scheduleHandler or self:newSchedule(handler(self, self._onUpdate), 1)
end

function TeamPvpBattleMap:_onUpdate()
	if g.core.common.ServerTime:getTime() - self._endTimeStemp > 1 then
		self:stopSchedule()
		cc.Director:getInstance():getScheduler():setTimeScale(1)

		if self._reportData and self._reportData.extra_turn and not self._isExtraTurn then
			self:dispatchCompEvent("ENTER_EXTRA_BATTLE")
		else
			self:dispatchCompEvent("END_BATTLE_EVENT")
		end
	end
end

function TeamPvpBattleMap:getMorale()
	local var_59_0 = {}
	local var_59_1 = {}

	var_59_0[2] = self._enemyList[2]
	var_59_0[5] = self._enemyList[5]
	var_59_0[8] = self._enemyList[8]
	var_59_0[11] = self._enemyList[11]
	var_59_0[3] = self._enemyList[3]
	var_59_0[6] = self._enemyList[6]
	var_59_0[9] = self._enemyList[9]
	var_59_0[12] = self._enemyList[12]
	var_59_1[2] = self._playerList[2]
	var_59_1[5] = self._playerList[5]
	var_59_1[8] = self._playerList[8]
	var_59_1[11] = self._playerList[11]
	var_59_1[3] = self._playerList[3]
	var_59_1[6] = self._playerList[6]
	var_59_1[9] = self._playerList[9]
	var_59_1[12] = self._playerList[12]

	local var_59_2 = 0
	local var_59_3 = 0

	for iter_59_0, iter_59_1 in pairs(var_59_1) do
		if iter_59_1:getIsLive() then
			var_59_2 = var_59_2 + 1
		end
	end

	for iter_59_2, iter_59_3 in pairs(var_59_0) do
		if iter_59_3:getIsLive() then
			var_59_3 = var_59_3 + 1
		end
	end

	return var_59_2, var_59_3
end

function TeamPvpBattleMap:stopSchedule()
	if self._scheduleHandler then
		self:cancelSchedule(self._scheduleHandler)

		self._scheduleHandler = nil
	end
end

function TeamPvpBattleMap:onUnload()
	self:stopSchedule()
	cc.Director:getInstance():getScheduler():setTimeScale(1)
end

function TeamPvpBattleMap:_hasNpc(arg_62_1)
	if self._mapId == var_0_0.MAP_TYPE.SEA then
		local var_62_0 = self:_getPlayerInfo(arg_62_1.atk_guid):getNpcType()
		local var_62_1 = self:_getPlayerInfo(arg_62_1.def_guid):getNpcType()

		if self._isAtk then
			return var_62_0 == var_0_0.NPC_TYPE.ASSASSIN or var_62_1 == var_0_0.NPC_TYPE.BAGGAGE
		else
			return var_62_1 == var_0_0.NPC_TYPE.ASSASSIN or var_62_0 == var_0_0.NPC_TYPE.BAGGAGE
		end
	end

	return false
end

function TeamPvpBattleMap:HideTeamPlayerBuffEffect(arg_63_1)
	local var_63_0

	if arg_63_1 then
		var_63_0 = self._enemyList or self._playerList
	end

	local var_63_1

	for iter_63_0, iter_63_1 in ipairs(var_63_0) do
		if iter_63_1:getNpcType() == var_0_0.NPC_TYPE.MASTER then
			var_63_1 = iter_63_1
		end
	end

	if var_63_1 then
		local var_63_2 = (var_63_1:getIndex() - 1) % self._battleLine + 1

		for iter_63_2, iter_63_3 in ipairs(var_63_0) do
			if (iter_63_3:getIndex() - 1) % self._battleLine + 1 == var_63_2 then
				iter_63_3:hidePlayerBuff()
			end
		end
	end
end

return TeamPvpBattleMap
