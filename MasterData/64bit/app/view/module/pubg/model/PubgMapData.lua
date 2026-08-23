local var_0_0 = g.core.config.pubg_refresh_info
local var_0_1 = g.core.common.ServerTime
local KsAStar = require("app.core.utils.KsAStar")
local PubgMapItemUser = require("app.view.module.pubg.model.struct.PubgMapItemUser")
local PubgMapItemBuff = require("app.view.module.pubg.model.struct.PubgMapItemBuff")
local PubgMapItemMonster = require("app.view.module.pubg.model.struct.PubgMapItemMonster")
local PubgMapItemAirDrop = require("app.view.module.pubg.model.struct.PubgMapItemAirDrop")
local var_0_7 = g.core.const.ConstMgr.PubgConst
local var_0_8 = g.core.const.ConstMgr.PubgConst.map
local PubgMapHelp = require("app.view.module.pubg.view.pubgMap.mapWorld.PubgMapHelp")
local var_0_10 = g.core.config.pubg_grid_info
local var_0_11 = g.core.config.pubg_buff_info
local var_0_12 = g.core.config.pubg_text_info
local PubgMapData = class("PubgMapData")
local var_0_14 = {}

function PubgMapData:ctor()
	self._currentMapId = -1
	self._myUser = nil
	self._levelCfg = {}
	self._obstacleDict = {}
	self._grassDict = {}
	self._allItemDict = {}
	self._allUserDict = {}
	self._allBuffDict = {}
	self._allMonsterDict = {}
	self._allAirDropDict = {}
	self._curMapLevel = 0
	self._mapStartTime = 0
	self._mapEndTime = 0
	self._lastRefreshEventTime = 0
	self._refreshTime = 0
	self._maxLevel = 1
	self._deadMonsterDict = {}
	self._pickBuffDict = {}
	self._pickAirDropDict = {}
	self._tickTotalTime = 0
	self._levelTimeDict = {}
	self._attackUserCacheDict = {}
	self._isSendGet = {}
	self._textNoticeList = {}
	self._timeScale = 1
	self._startInvincibleTime = 0
end

function PubgMapData:onMapEnter(arg_2_1)
	self._mapStartTime = arg_2_1.start_time or self._mapStartTime
	self._startInvincibleTime = self._mapStartTime + g.core.model.User.pubgData:getParams(var_0_7.Params.START_INVINCIBLE_TIME)
	self._lastRefreshEventTime = arg_2_1.last_refresh_time or self._lastRefreshEventTime

	self:setMapLevel(arg_2_1.level)

	self._allItemDict = {}
	self._allUserDict = {}
	self._myUser = nil

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.room_users or {}) do
		self:addUser(iter_2_1.id, iter_2_1)
	end

	self._allBuffDict = {}

	for iter_2_2, iter_2_3 in ipairs(arg_2_1.buffs or {}) do
		self:addBuff(iter_2_3.id, iter_2_3)
	end

	self._allMonsterDict = {}

	for iter_2_4, iter_2_5 in ipairs(arg_2_1.monsters or {}) do
		self:addMonster(iter_2_5.id, iter_2_5)
	end

	self._allAirDropDict = {}

	for iter_2_6, iter_2_7 in ipairs(arg_2_1.airdrops or {}) do
		self:addAirDrop(iter_2_7.id, iter_2_7)
	end

	self:setMapId(arg_2_1.map_id)

	local var_2_0 = self:getMyUser()

	if var_2_0 then
		local var_2_1 = arg_2_1.user or {}

		var_2_0:setHp(var_2_1.hp or 0)
		var_2_0:setExp(var_2_1.exp or 0)
		var_2_0:setWinCount(var_2_1.win_times or 0)
		var_2_0:setFailCount(var_2_1.fail_times or 0)
	end

	self._levelTimeDict = {}

	local var_2_2 = self._mapStartTime
	local var_2_3 = 0
	local var_2_4 = var_0_0.fetch(0)

	while var_2_4 do
		var_2_2 = var_2_2 + var_2_4.reduce_time
		self._levelTimeDict[var_2_3] = var_2_2
		var_2_3 = var_2_3 + 1
		var_2_4 = var_0_0.fetch(var_2_3)
	end

	self._maxLevel = var_2_3 - 1
	self._levelChangePreviewTime = g.core.model.User.pubgData:getParams(var_0_7.Params.LEVEL_CHANGE_PREVIEW)
	self._mapEndTime = self._mapStartTime + g.core.model.User.pubgData:getParams(var_0_7.Params.GAME_TIME)
	self._levelTimeDict[self._maxLevel + 1] = self._mapEndTime
end

function PubgMapData:setTimeScale(arg_3_1)
	self._timeScale = arg_3_1
end

function PubgMapData:onPickBuffNotice(arg_4_1)
	self:delBuff(arg_4_1.id)

	if self._allUserDict[arg_4_1.userId] and arg_4_1.buff then
		self._allUserDict[arg_4_1.userId]:addBuff(arg_4_1.buff)
	end
end

function PubgMapData:onS2CRefreshAirdrop(arg_5_1)
	local var_5_0 = arg_5_1.airdrop or {}

	if var_5_0.id then
		self:addAirDrop(var_5_0.id, var_5_0)
	end
end

function PubgMapData:onS2CPickAirdropNotice(arg_6_1)
	if self._allAirDropDict[arg_6_1.airdrop_id] then
		self._allAirDropDict[arg_6_1.airdrop_id]:addGettingUser(arg_6_1.user_id, arg_6_1.pick_time)
	end
end

function PubgMapData:onS2CGainAirdrop(arg_7_1)
	self:delAirDrop(arg_7_1.airdrop_id, true)

	local var_7_0 = self:getUserById(arg_7_1.user_id)

	if var_7_0 then
		var_7_0:addAirBuff(arg_7_1.effect)
	end

	self:onAddTextNotice({
		base_id = 11,
		user_id = arg_7_1.user_id
	})
end

function PubgMapData:onRemoveBuffNotice(arg_8_1)
	if self._allUserDict[arg_8_1.user_id] then
		self._allUserDict[arg_8_1.user_id]:removeBuff(arg_8_1.tp)
	end
end

function PubgMapData:onUpdateUser(arg_9_1)
	if self._allUserDict[arg_9_1.user_id] then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1.list or {}) do
			if iter_9_1.key == var_0_8.USER_UPDATE_TYPE.HP then
				self._allUserDict[arg_9_1.user_id]:setHp(iter_9_1.value)
			elseif iter_9_1.key == var_0_8.USER_UPDATE_TYPE.LEVEL then
				self._allUserDict[arg_9_1.user_id]:setLevel(iter_9_1.value)
			elseif iter_9_1.key == var_0_8.USER_UPDATE_TYPE.EXP then
				self._allUserDict[arg_9_1.user_id]:setExp(iter_9_1.value)
			elseif iter_9_1.key == var_0_8.USER_UPDATE_TYPE.SCORE then
				self._allUserDict[arg_9_1.user_id]:setScore(iter_9_1.value)
			elseif iter_9_1.key == var_0_8.USER_UPDATE_TYPE.FIGHT_VALUE then
				self._allUserDict[arg_9_1.user_id]:setFightValue(iter_9_1.value)
			elseif iter_9_1.key == var_0_8.USER_UPDATE_TYPE.RECOVER_TIME then
				self._allUserDict[arg_9_1.user_id]:setRecoverTime(iter_9_1.value)
			elseif iter_9_1.key == var_0_8.USER_UPDATE_TYPE.INVINCIBLE_TIME then
				self._allUserDict[arg_9_1.user_id]:setInvincibleTime(iter_9_1.value)
			end
		end
	end
end

function PubgMapData:onShrinkCircle(arg_10_1)
	self:setMapLevel(arg_10_1.level)

	for iter_10_0, iter_10_1 in pairs(self._allMonsterDict) do
		if self:isBan(PubgMapHelp.getKey(iter_10_1:getPos())) then
			self:delMonster(iter_10_0)
		end
	end

	for iter_10_2, iter_10_3 in pairs(self._allBuffDict) do
		if self:isBan(PubgMapHelp.getKey(iter_10_3:getPos())) then
			self:delBuff(iter_10_2)
		end
	end

	for iter_10_4, iter_10_5 in pairs(self._allAirDropDict) do
		if self:isBan(PubgMapHelp.getKey(iter_10_5:getPos())) then
			self:delAirDrop(iter_10_4)
		end
	end
end

function PubgMapData:onRefresh(arg_11_1)
	self._lastRefreshEventTime = arg_11_1.last_refresh_time
	self._allMonsterDict = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.monsters or {}) do
		self:addMonster(iter_11_1.id, iter_11_1)
	end

	self._allBuffDict = {}

	for iter_11_2, iter_11_3 in ipairs(arg_11_1.buffs or {}) do
		self:addBuff(iter_11_3.id, iter_11_3)
	end
end

function PubgMapData:onAddTextNotice(arg_12_1)
	table.insert(self._textNoticeList, self:getTextTip(arg_12_1))
end

function PubgMapData:onExpNotice(arg_13_1)
	local var_13_0 = self:getMyUser()

	if var_13_0 then
		var_13_0:setExp(arg_13_1.exp)
	end
end

function PubgMapData:getTextNoticeList()
	return self._textNoticeList
end

function PubgMapData:getTextTip(arg_15_1)
	local var_15_0 = ""

	var_15_0 = arg_15_1.base_id and arg_15_1.base_id > 0 and var_0_12.get(arg_15_1.base_id).text or g.core.lang:get(430935)

	local var_15_1 = self:getUserById(arg_15_1.user_id)
	local var_15_2 = self:getUserById(arg_15_1.target_id)
	local var_15_3 = var_15_0
	local var_15_4 = {}

	var_15_4.name1 = var_15_1 and var_15_1:getName() or ""
	var_15_4.name2 = var_15_2 and var_15_2:getName() or ""

	return g.core.lang:getByString(var_15_3, var_15_4)
end

function PubgMapData:onDeadNotice(arg_16_1)
	local var_16_0 = arg_16_1.dead or {}

	if var_16_0.tp == 1 then
		self:delMonster(var_16_0.id)
	else
		local var_16_1 = var_16_0.id
		local var_16_2 = self:getUserById(var_16_0.id)

		if var_16_2 then
			var_16_2:setDead(true)
			var_16_2:addFailCount()

			if arg_16_1.drop_buff then
				if arg_16_1.drop_buff.buff then
					self:addBuff(arg_16_1.drop_buff.buff.id, arg_16_1.drop_buff.buff)
				end

				var_16_2:loseBuff(arg_16_1.drop_buff.tp)
			end

			for iter_16_0, iter_16_1 in pairs(self._allAirDropDict) do
				iter_16_1:removeGettingUser(var_16_1)
			end

			if var_16_2:isMe() then
				self:clearSendGet()
			end
		end
	end

	if arg_16_1.defend and arg_16_1.defend.tp == 2 then
		local var_16_3 = self:getUserById(arg_16_1.attack.id)
		local var_16_4 = self:getUserById(arg_16_1.defend.id)

		if not var_16_3 or not var_16_4 then
			return
		end

		local var_16_5
		local var_16_6

		if var_16_3:isDead() then
			var_16_5 = var_16_4:getUid()

			var_16_4:addWinCount()

			var_16_6 = var_16_3:getUid()
		else
			var_16_5 = var_16_3:getUid()

			var_16_3:addWinCount()

			var_16_6 = var_16_4:getUid()
		end

		self:onAddTextNotice({
			base_id = 0,
			user_id = var_16_5,
			target_id = var_16_6
		})
	end

	if arg_16_1.attack then
		local var_16_7 = self:getUserById(arg_16_1.attack.id)

		if var_16_7 then
			var_16_7:setInvincibleTime(var_0_1:getTime() - 1)
			var_16_7:removeBuff(var_0_8.BUFF_TYPE.HIDE)
			var_16_7:subMustWin()

			if var_16_7:isMe() then
				self:clearSendGet()
			end
		end

		for iter_16_2, iter_16_3 in pairs(self._allAirDropDict) do
			iter_16_3:removeGettingUser(arg_16_1.attack.id)
		end
	end
end

function PubgMapData:onRecoverNotice(arg_17_1)
	if self._allUserDict[arg_17_1.user_id] then
		self._allUserDict[arg_17_1.user_id]:setRecoverTime(var_0_1:getTime())
		self._allUserDict[arg_17_1.user_id]:setDead(false)
		self._allUserDict[arg_17_1.user_id]:setPosXY(arg_17_1.x, arg_17_1.y)
	end
end

function PubgMapData:onChallenge(arg_18_1)
	return
end

function PubgMapData:addUser(arg_19_1, arg_19_2)
	local var_19_0 = self._allUserDict[arg_19_1]

	if not self._allUserDict[arg_19_1] then
		var_19_0 = PubgMapItemUser.new({
			uid = arg_19_1
		})
		self._allUserDict[arg_19_1] = var_19_0
		self._allItemDict[var_19_0:getOnlyKey()] = var_19_0
	end

	var_19_0:setData(arg_19_2)
	var_19_0:setStartInvincibleTime(self._startInvincibleTime)
end

function PubgMapData:addBuff(arg_20_1, arg_20_2)
	local var_20_0 = PubgMapItemBuff.new({
		uid = arg_20_1
	})

	self._allBuffDict[arg_20_1] = var_20_0
	self._allItemDict[var_20_0:getOnlyKey()] = var_20_0

	var_20_0:setData(arg_20_2)
end

function PubgMapData:delBuff(arg_21_1)
	if self._allBuffDict[arg_21_1] then
		self._pickBuffDict[arg_21_1] = self._allBuffDict[arg_21_1]

		local var_21_0 = self._allBuffDict[arg_21_1]:getOnlyKey()
		local var_21_1 = self:getMyUser()

		if var_21_1 and var_21_1:getTargetOnlyId() == var_21_0 then
			var_21_1:stopMove()
		end

		self._allItemDict[var_21_0] = nil
	end

	self._allBuffDict[arg_21_1] = nil
end

function PubgMapData:addMonster(arg_22_1, arg_22_2)
	local var_22_0 = PubgMapItemMonster.new({
		uid = arg_22_1
	})

	self._allMonsterDict[arg_22_1] = var_22_0
	self._allItemDict[var_22_0:getOnlyKey()] = var_22_0

	var_22_0:setData(arg_22_2)
end

function PubgMapData:addAirDrop(arg_23_1, arg_23_2)
	local var_23_0 = PubgMapItemAirDrop.new({
		uid = arg_23_1
	})

	self._allAirDropDict[arg_23_1] = var_23_0
	self._allItemDict[var_23_0:getOnlyKey()] = var_23_0

	var_23_0:setData(arg_23_2)
end

function PubgMapData:delAirDrop(arg_24_1, arg_24_2)
	if self._allAirDropDict[arg_24_1] then
		if arg_24_2 then
			self._pickAirDropDict[arg_24_1] = self._allAirDropDict[arg_24_1]
		end

		self._allItemDict[self._allAirDropDict[arg_24_1]:getOnlyKey()] = nil
	end

	self._allAirDropDict[arg_24_1] = nil
end

function PubgMapData:delMonster(arg_25_1)
	if self._allMonsterDict[arg_25_1] then
		self._deadMonsterDict[arg_25_1] = self._allMonsterDict[arg_25_1]

		local var_25_0 = self._allMonsterDict[arg_25_1]:getOnlyKey()
		local var_25_1 = self:getMyUser()

		if var_25_1 and var_25_1:getTargetOnlyId() == var_25_0 then
			var_25_1:stopMove()
		end

		self._allItemDict[var_25_0] = nil
	end

	self._allMonsterDict[arg_25_1] = nil
end

function PubgMapData:setMapId(arg_26_1)
	self._levelCfg = require((string.format("app.view.module.pubg.view.pubgMap.mapWorld.mapConfig.PubgLevelConfig_%d", arg_26_1)))

	self:initMapData(arg_26_1)

	self._currentMapId = arg_26_1
end

function PubgMapData:initMapData(arg_27_1)
	if arg_27_1 == self._currentMapId then
		return
	end

	self._obstacleDict = {}
	self._grassDict = {}

	for iter_27_0, iter_27_1 in var_0_10.ipairs() do
		if iter_27_1.map_id == arg_27_1 then
			if iter_27_1.grid_type == var_0_8.GRID_TYPE.OBSTACLE then
				self._obstacleDict[PubgMapHelp.getKey(iter_27_1.x, iter_27_1.y)] = true
			elseif iter_27_1.grid_type == var_0_8.GRID_TYPE.GRASS then
				self._grassDict[PubgMapHelp.getKey(iter_27_1.x, iter_27_1.y)] = {
					grassId = 0,
					x = iter_27_1.x,
					y = iter_27_1.y
				}
			end
		end
	end

	for iter_27_2, iter_27_3 in pairs(self._grassDict) do
		local var_27_0

		if iter_27_3.grassId == 0 then
			self:_findGrass(iter_27_3.x, iter_27_3.y, 1)

			var_27_0 = 1 + 1
		end
	end
end

function PubgMapData:_findGrass(arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = PubgMapHelp.getKey(arg_28_1, arg_28_2)

	if self._grassDict[var_28_0] and self._grassDict[var_28_0].grassId == 0 then
		self._grassDict[var_28_0].grassId = arg_28_3

		self:_findGrass(arg_28_1 + 1, arg_28_2, arg_28_3)
		self:_findGrass(arg_28_1 - 1, arg_28_2, arg_28_3)
		self:_findGrass(arg_28_1, arg_28_2 + 1, arg_28_3)
		self:_findGrass(arg_28_1, arg_28_2 - 1, arg_28_3)
	end
end

function PubgMapData:checkInMapTime()
	local var_29_0 = var_0_1:getTime()

	return var_29_0 >= self._mapStartTime and var_29_0 < self._mapEndTime
end

function PubgMapData:tickUpdate(arg_30_1)
	arg_30_1 = arg_30_1 / self._timeScale

	if not self:checkInMapTime() then
		return
	end

	local var_30_0 = self:getMyUser()

	if not var_30_0 then
		return
	end

	self._tickTotalTime = self._tickTotalTime + arg_30_1

	local var_30_1 = {}

	for iter_30_0, iter_30_1 in pairs(self._allMonsterDict) do
		local var_30_2 = iter_30_1:getOnlyKey()

		if var_30_0:isInAttackRange(iter_30_1:getPos()) and self:isSightGrassWithMe(PubgMapHelp.getKey(iter_30_1:getPos())) then
			if not self._attackUserCacheDict[var_30_2] then
				iter_30_1:setLastSee(self._tickTotalTime)

				self._attackUserCacheDict[var_30_2] = true
			end

			table.insert(var_30_1, iter_30_1)
		else
			self._attackUserCacheDict[var_30_2] = nil
		end
	end

	local var_30_3 = {}
	local var_30_4 = false
	local var_30_5 = false
	local var_30_6 = false

	for iter_30_2, iter_30_3 in pairs(self._allUserDict) do
		local var_30_7 = iter_30_3:tickBuffUpdate(arg_30_1)
		local var_30_8, var_30_9 = iter_30_3:getPos()
		local var_30_10 = var_30_0:isInVisualField(var_30_8, var_30_9)
		local var_30_11 = iter_30_3:isInvincible()

		if not iter_30_3:isMe() and not iter_30_3:isDead() and not iter_30_3:isHide() then
			local var_30_12 = iter_30_3:getOnlyKey()

			if var_30_10 and not var_30_11 and var_30_0:isInAttackRange(var_30_8, var_30_9) and self:isSightGrassWithMe(PubgMapHelp.getKey(var_30_8, var_30_9)) then
				if var_30_7[var_0_8.BUFF_TYPE.HIDE] then
					var_30_4 = true
				end

				if var_30_7[var_0_8.BUFF_TYPE.MUST_WIN] then
					var_30_6 = true
				end

				var_30_5 = (var_30_7[var_0_8.BUFF_TYPE.FIGHT_VALUE_VALUE] or var_30_7[var_0_8.BUFF_TYPE.FIGHT_VALUE_RATE]) and true

				if not self._attackUserCacheDict[var_30_12] then
					iter_30_3:setLastSee(self._tickTotalTime)

					self._attackUserCacheDict[var_30_12] = true
				end

				table.insert(var_30_1, iter_30_3)
			else
				self._attackUserCacheDict[var_30_12] = nil
			end
		end

		if var_30_10 and iter_30_3:getLastInvincible() ~= var_30_11 then
			table.insert(var_30_3, iter_30_3)
			iter_30_3:setLastInvincible(var_30_11)
		end
	end

	local var_30_13 = var_30_0:tickMoveUpdate(arg_30_1)

	return {
		isMove = var_30_13,
		isMoveEnd = var_30_13 and not var_30_0:hasRoute(),
		removeHide = var_30_4,
		removeFightValue = var_30_5,
		removeMustWin = var_30_6,
		attackUserList = var_30_1,
		invincibleChangeList = var_30_3
	}
end

function PubgMapData:getMyUser()
	self._myUser = self._myUser or self._allUserDict[g.core.model.User:getId()]

	return self._myUser
end

function PubgMapData:getMapId()
	return self._currentMapId
end

function PubgMapData:getMyPos()
	local var_33_0 = self:getMyUser()

	if var_33_0 then
		return var_33_0:getPos()
	else
		return 0, 0
	end
end

function PubgMapData:hasFog(arg_34_1, arg_34_2)
	local var_34_0 = self:getMyUser()

	if var_34_0 then
		return not var_34_0:isInVisualField(arg_34_1, arg_34_2)
	else
		return true
	end
end

function PubgMapData:isGrass(arg_35_1)
	return self._grassDict[arg_35_1] ~= nil
end

function PubgMapData:isSightGrassWithMe(arg_36_1)
	local var_36_0 = self:getMyUser()

	if not var_36_0 then
		return false
	end

	return self:isSightA2BGrass(PubgMapHelp.getKey(var_36_0:getPos()), arg_36_1)
end

function PubgMapData:isSightA2BGrass(arg_37_1, arg_37_2)
	if not self._grassDict[arg_37_1] then
		return not self._grassDict[arg_37_2]
	end

	if not self._grassDict[arg_37_2] then
		return true
	end

	return self._grassDict[arg_37_1].grassId == self._grassDict[arg_37_2].grassId
end

function PubgMapData:canMove(arg_38_1, arg_38_2, arg_38_3)
	arg_38_1 = arg_38_1 or PubgMapHelp.getKey(arg_38_2, arg_38_3)

	if self._obstacleDict[arg_38_1] then
		return false
	end

	if self:isBan(arg_38_1) then
		return false
	end

	return true
end

function PubgMapData:isBan(arg_39_1, arg_39_2, arg_39_3)
	arg_39_1 = arg_39_1 or PubgMapHelp.getKey(arg_39_2, arg_39_3)

	return self:isBanByLevel(arg_39_1, self._curMapLevel)
end

function PubgMapData:isBaning(arg_40_1)
	if self:isMaxLevel() then
		return false
	end

	if self:getLevelTime() - self:getLevelChangePreviewTime() > var_0_1:getTime() then
		return false
	end

	return self:isBanByLevel(arg_40_1, self._curMapLevel + 1)
end

function PubgMapData:isBanByLevel(arg_41_1, arg_41_2)
	return not PubgMapHelp.keyInLevel(arg_41_1, arg_41_2, self._levelCfg)
end

function PubgMapData:getCurLevel()
	return self._curMapLevel
end

function PubgMapData:getBuffById(arg_43_1)
	return self._allBuffDict[arg_43_1]
end

function PubgMapData:getAirDropById(arg_44_1)
	return self._allAirDropDict[arg_44_1]
end

function PubgMapData:getAirDropDict()
	return self._allAirDropDict
end

function PubgMapData:isSendGet(arg_46_1)
	return self._isSendGet[arg_46_1] or false
end

function PubgMapData:clearSendGet()
	self._isSendGet = {}
end

function PubgMapData:addSendGet(arg_48_1)
	self._isSendGet[arg_48_1] = true
end

function PubgMapData:getPickBuffById(arg_49_1)
	return self._pickBuffDict[arg_49_1]
end

function PubgMapData:delPickBuff(arg_50_1)
	self._pickBuffDict[arg_50_1] = nil
end

function PubgMapData:getPickAirDropById(arg_51_1)
	return self._pickAirDropDict[arg_51_1]
end

function PubgMapData:delPickAirDrop(arg_52_1)
	self._pickAirDropDict[arg_52_1] = nil
end

function PubgMapData:getAllUser()
	return self._allUserDict
end

function PubgMapData:getUserById(arg_54_1)
	return self._allUserDict[arg_54_1]
end

function PubgMapData:getUserByPos(arg_55_1, arg_55_2)
	local var_55_0 = {}

	for iter_55_0, iter_55_1 in pairs(self._allUserDict) do
		if not iter_55_1:isDead() then
			local var_55_1, var_55_2 = iter_55_1:getPos()

			if var_55_1 == arg_55_1 and var_55_2 == arg_55_2 then
				table.insert(var_55_0, iter_55_1)
			end
		end
	end

	return var_55_0
end

function PubgMapData:getMonsterById(arg_56_1)
	return self._allMonsterDict[arg_56_1]
end

function PubgMapData:getDeadMonsterById(arg_57_1)
	return self._deadMonsterDict[arg_57_1]
end

function PubgMapData:delDeadMonster(arg_58_1)
	self._deadMonsterDict[arg_58_1] = nil
end

function PubgMapData:getMonsterByPos(arg_59_1, arg_59_2)
	for iter_59_0, iter_59_1 in pairs(self._allMonsterDict) do
		local var_59_0, var_59_1 = iter_59_1:getPos()

		if var_59_0 == arg_59_1 and var_59_1 == arg_59_2 then
			return iter_59_1
		end
	end
end

function PubgMapData:getBuffByPos(arg_60_1, arg_60_2)
	for iter_60_0, iter_60_1 in pairs(self._allBuffDict) do
		local var_60_0, var_60_1 = iter_60_1:getPos()

		if var_60_0 == arg_60_1 and var_60_1 == arg_60_2 then
			return iter_60_1
		end
	end
end

function PubgMapData:getAirDropByPos(arg_61_1, arg_61_2)
	for iter_61_0, iter_61_1 in pairs(self._allAirDropDict) do
		local var_61_0, var_61_1 = iter_61_1:getPos()

		if var_61_0 == arg_61_1 and var_61_1 == arg_61_2 then
			return iter_61_1
		end
	end
end

function PubgMapData:getRouteArray(arg_62_1, arg_62_2)
	return (KsAStar.searchPath(arg_62_1, arg_62_2, self))
end

function PubgMapData:doCanMoveAStar(arg_63_1, arg_63_2)
	return self:canMove(nil, arg_63_2.x, arg_63_2.y)
end

function PubgMapData:setUserMoveNotice(arg_64_1)
	for iter_64_0, iter_64_1 in ipairs(arg_64_1.list or {}) do
		local var_64_1 = self._allUserDict[iter_64_1.user_id]

		if self._allUserDict[iter_64_1.user_id] then
			if not var_64_1:isMe() then
				var_64_1:setOldPos(cc.p(var_64_1:getPos()))
			else
				self:clearSendGet()
			end

			var_64_1:setPosXY(iter_64_1.x, iter_64_1.y)
			var_64_1:setMovingPos(cc.p(iter_64_1.x, iter_64_1.y))
		end

		for iter_64_2, iter_64_3 in pairs(self._allAirDropDict) do
			iter_64_3:removeGettingUser(iter_64_1.user_id)
		end
	end
end

function PubgMapData:moveError(arg_65_1)
	local var_65_0 = self:getMyUser()

	if var_65_0 then
		if arg_65_1.x and arg_65_1.y then
			var_65_0:setPosXY(arg_65_1.x, arg_65_1.y)
		else
			local var_65_1 = var_65_0:getOldPos()

			if var_65_1 then
				var_65_0:setPosXY(var_65_1.x, var_65_1.y)
			end
		end

		var_65_0:stopMove()
		var_65_0:setMovingPos(nil)
	end
end

function PubgMapData:updateMonster(arg_66_1)
	if self._allMonsterDict[arg_66_1] then
		-- block empty
	end
end

function PubgMapData:getMapStartTime()
	return self._mapStartTime
end

function PubgMapData:setMapLevel(arg_68_1)
	self._curMapLevel = arg_68_1

	local var_68_0 = var_0_0.fetch(arg_68_1)

	if var_68_0 then
		self._refreshTime = var_68_0.refresh_time
	end
end

function PubgMapData:getLevelTime(arg_69_1)
	arg_69_1 = arg_69_1 or self._curMapLevel

	return self._levelTimeDict[arg_69_1 + 1] or 0
end

function PubgMapData:isMaxLevel()
	return self._curMapLevel >= self._maxLevel
end

function PubgMapData:getItemByOid(arg_71_1)
	return self._allItemDict[arg_71_1]
end

function PubgMapData:getLevelChangePreviewTime()
	return self._levelChangePreviewTime
end

function PubgMapData:getBuffInfo(arg_73_1, arg_73_2)
	for iter_73_0, iter_73_1 in var_0_11.ipairs() do
		if iter_73_1.level == arg_73_2 and iter_73_1.effect_type == arg_73_1 then
			return iter_73_1
		end
	end

	return nil
end

function PubgMapData:getBuffMaxLevel(arg_74_1)
	local var_74_0 = 0

	for iter_74_0, iter_74_1 in var_0_11.ipairs() do
		if iter_74_1.effect_type == arg_74_1 then
			var_74_0 = math.max(var_74_0, iter_74_1.level)
		end
	end

	return var_74_0
end

function PubgMapData:clearMapCacheData()
	for iter_75_0, iter_75_1 in pairs(self._allUserDict) do
		iter_75_1:stopMove()
	end

	self._attackUserCacheDict = {}
	self._deadMonsterDict = {}
	self._textNoticeList = {}
	self._isSendGet = {}
end

function PubgMapData:clearMapCfg()
	self._levelCfg = {}
	package.loaded[string.format("app.view.module.pubg.view.pubgMap.mapWorld.mapConfig.PubgLevelConfig_%d", self._currentMapId)] = nil
end

function PubgMapData:getRefreshEventTime()
	return self._refreshTime - (var_0_1:getTime() - self._lastRefreshEventTime)
end

function PubgMapData:getLastStartInvincibleTime()
	return self._startInvincibleTime - var_0_1:getTime()
end

function PubgMapData:hasShowAirDropTip()
	local var_79_0 = var_0_1:getTime()
	local var_79_1 = g.core.model.User.pubgData:getParams(var_0_7.Params.AIRDROP_TIP_TIME)

	for iter_79_0, iter_79_1 in pairs(self._allAirDropDict) do
		if var_79_0 <= iter_79_1:getStartTime() + var_79_1 then
			return true
		end
	end

	return false
end

function PubgMapData:getKnightSpine(arg_80_1)
	var_0_14[arg_80_1.resId] = var_0_14[arg_80_1.resId] or {}

	local var_80_0 = table.remove(var_0_14[arg_80_1.resId])

	if not var_80_0 then
		var_80_0 = require("app.view.battle.BattleKnight").new(arg_80_1)

		var_80_0:retain()
	end

	return var_80_0
end

function PubgMapData:recycleKnightSpine(arg_81_1)
	arg_81_1:retain()
	arg_81_1:removeFromParent()

	local var_81_0 = arg_81_1:getResId()

	var_0_14[var_81_0] = var_0_14[var_81_0] or {}

	if #var_0_14[var_81_0] <= 2 then
		table.insert(var_0_14[var_81_0], arg_81_1)
	else
		arg_81_1:release()
	end
end

function PubgMapData:clearCacheKnightSpine()
	for iter_82_0, iter_82_1 in pairs(var_0_14) do
		for iter_82_2, iter_82_3 in ipairs(iter_82_1) do
			iter_82_3:release()
		end

		var_0_14[iter_82_0] = {}
	end
end

return PubgMapData
