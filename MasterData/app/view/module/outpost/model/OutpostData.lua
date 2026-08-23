local OutpostKnightData = require("app.view.module.outpost.model.OutpostKnightData")
local OutpostBuildData = require("app.view.module.outpost.model.OutpostBuildData")
local OutpostBagData = require("app.view.module.outpost.model.OutpostBagData")
local OutpostTaskData = require("app.view.module.outpost.model.OutpostTaskData")
local KsMath = require("app.core.utils.KsMath")
local var_0_5 = g.core.const.ConstMgr.outpostConst
local var_0_6 = g.core.common.ServerTime
local var_0_7 = g.core.config.outpost_map_info
local var_0_8 = g.core.config.outpost_monster_info
local var_0_9 = g.core.config.outpost_parameter_info
local OutpostEventManager = require("app.view.module.outpost.model.OutpostEventManager")
local OutpostData = class("OutpostData")
local var_0_12 = {}

function OutpostData:ctor()
	self:initData()
end

function OutpostData:initData()
	self._eventManager = OutpostEventManager.new()
	self._knightsData = OutpostKnightData.new()
	self._buildData = OutpostBuildData.new()
	self._bagData = OutpostBagData.new()
	self._taskData = OutpostTaskData.new()
	self._oid = 0
	self._oldFightValue = 0
	self._areaDoor = {}
	self._arenaTypeMap = {}
	self._svrMapInfo = {}
	self._statusDic = {}
	self._ownVit = 0
	self._lastShowVitValue = 0
	self._lastShowVitTime = 0
	self._slots = {}
	self._curSpeed = 1
	self._isSpeedOn = false

	self:initLockDoorDick()
	self:loadSpeedJsonData()

	self._allMonsterDict = {}
	self._allBossDict = {}
	self._allDropDict = {}
	self._allBossBoxDict = {}
	self._curBossHpDict = {}
	self._jsonBossHpData = {}
	self._showAttackRange = false
	self._asyncUpdate = true
	self._monsterDamageRate = 1
	self._knightDamageRate = 1
	self._todayPoint = 0

	self:loadBossHpData()
end

function OutpostData:loadBossHpData()
	self._jsonBossHpData = g.core.common.Storage:load(var_0_5.BossHpJson) or {}
end

function OutpostData:nextOid()
	self._oid = self._oid + 1

	return self._oid
end

function OutpostData:initLockDoorDick()
	for iter_5_0, iter_5_1 in var_0_7.ipairs() do
		local var_5_0 = {
			isOpen = false,
			checkOpenCfg = iter_5_1
		}

		self._arenaTypeMap[iter_5_1.map_type] = var_5_0

		for iter_5_2 = 0, iter_5_1.x_length - 1 do
			for iter_5_3 = 0, iter_5_1.y_length - 1 do
				self._areaDoor[KsMath.mathUnifiedCoordinate(iter_5_1.x + iter_5_2, iter_5_1.y + iter_5_3)] = var_5_0
			end
		end
	end
end

function OutpostData:getEventManager()
	return self._eventManager
end

function OutpostData:dispatchWorldEvent(arg_7_1, arg_7_2)
	self._eventManager:dispatchEvent(arg_7_1, arg_7_2)
end

function OutpostData:clearWorldEvent()
	self._eventManager:clearEvent()
end

function OutpostData:getLeaveMapSaveKnights()
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._knightsData:getAllLineUpKnights()) do
		table.insert(var_9_0, iter_9_1:toProtoOutpostKnight())
	end

	return var_9_0
end

function OutpostData:onS2COutpostGetInfo(arg_10_1)
	self._slots = arg_10_1.data.slots or {}
	self._ownVit = arg_10_1.data.cur_vit

	self._bagData:onFlushItems(arg_10_1.data.bags)

	arg_10_1.data.knights = self:updateKnightsMapType(arg_10_1.data.knights)

	self._knightsData:updateOwnKnightSvrAll(arg_10_1.data.knights, self._slots)
	self._taskData:updateTask(arg_10_1.data.tasks)
	self:setTodayPoint(arg_10_1.data.daily_coins or 0)

	self._statusDic = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.data.statuses or {}) do
		self:updateStatus(iter_10_1)
	end

	self._buildData:updateBuilds(arg_10_1.data.builds)

	for iter_10_2, iter_10_3 in ipairs(arg_10_1.data.map_infos or {}) do
		self._arenaTypeMap[iter_10_3.map_type].isOpen = true
		self._svrMapInfo[iter_10_3.map_type] = iter_10_3
	end

	self._allMonsterDict = {}
	self._allBossDict = {}

	for iter_10_4, iter_10_5 in ipairs(arg_10_1.data.map_infos or {} or {}) do
		for iter_10_6, iter_10_7 in ipairs(iter_10_5.drops or {}) do
			self._allDropDict[table.concat({
				iter_10_5.map_type,
				iter_10_7.pos_x,
				iter_10_7.pos_y,
				iter_10_7.seq
			}, "_")] = {
				mapType = iter_10_5.map_type,
				drop = iter_10_7
			}
		end

		for iter_10_8, iter_10_9 in ipairs(iter_10_5.monsters or {}) do
			if var_0_8.get(iter_10_9.monster_id).type == var_0_5.MonsterType.BigBoss then
				self._allBossDict[iter_10_9.unique_id] = iter_10_9
				self._curBossHpDict[iter_10_9.unique_id] = self._jsonBossHpData[tostring(iter_10_9.unique_id)]
			else
				self._allMonsterDict[iter_10_9.unique_id] = iter_10_9
			end
		end

		for iter_10_10, iter_10_11 in ipairs(iter_10_5.boss_boxes or {}) do
			self._allBossBoxDict[iter_10_11.id] = iter_10_11
		end
	end

	self._oldFightValue = self:getKnightsData():getFightValue()
end

function OutpostData:onS2COutpostUseVit(arg_11_1)
	self._ownVit = arg_11_1.left_vit
end

function OutpostData:onS2COutpostDonateKnight(arg_12_1)
	arg_12_1.knight = self:updateKnightsMapType({
		arg_12_1.knight
	})[1]

	self._knightsData:onS2COutpostDonateKnight(arg_12_1)
end

function OutpostData:onS2COutpostBattleFinish(arg_13_1)
	local var_13_0 = arg_13_1.knights or {}
	local var_13_1 = arg_13_1.drops or {}
	local var_13_2 = arg_13_1.boss_boxes or {}
	local var_13_3 = arg_13_1.new_monster

	self._ownVit = arg_13_1.left_vit or self._ownVit

	if var_13_3 then
		self._allMonsterDict[var_13_3.unique_id] = var_13_3
	end

	local var_13_4 = arg_13_1.unique_id

	if self._allMonsterDict[arg_13_1.unique_id] then
		self._allMonsterDict[var_13_4] = nil
	else
		local var_13_5 = self._allBossDict[var_13_4]

		if self._allBossDict[var_13_4] then
			local var_13_6 = self:getStatusByIdAndKey(var_0_5.BuildUnlockType.KILL_BOSS, var_13_5.monster_id) or {
				status = 0,
				id = var_0_5.BuildUnlockType.KILL_BOSS,
				key = var_13_5.monster_id
			}

			var_13_6.status = var_13_6.status + 1

			self:updateStatus(var_13_6)

			self._allBossDict[var_13_4] = nil

			self._buildData:onS2COutpostBattleFinish(var_13_5.monster_id)
		end
	end

	self._knightsData:updateKnightSvr((self:updateKnightsMapType(var_13_0)))

	for iter_13_0, iter_13_1 in ipairs(var_13_1 or {}) do
		self._allDropDict[table.concat({
			arg_13_1.map_tp,
			iter_13_1.pos_x,
			iter_13_1.pos_y,
			iter_13_1.seq
		}, "_")] = {
			mapType = arg_13_1.map_tp,
			drop = iter_13_1
		}
	end

	for iter_13_2, iter_13_3 in ipairs(var_13_2) do
		self._allBossBoxDict[iter_13_3.id] = iter_13_3
	end

	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostBuildLevelUp(arg_14_1)
	self._buildData:onS2COutpostBuildLevelUp(arg_14_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostBuildUnlock(arg_15_1)
	self._buildData:unlockBuild(arg_15_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostBuildUse(arg_16_1)
	local var_16_0 = self._knightsData:getKnightBySid(arg_16_1.knight.knight_id)

	if var_16_0 then
		local var_16_1 = self:updateKnightsMapType({
			arg_16_1.knight
		})[1]

		var_16_0:setServerData(var_16_1, nil, false)

		for iter_16_0, iter_16_1 in ipairs(var_16_1.states) do
			if iter_16_1.tp == var_0_5.BuildToState[arg_16_1.build_tp] then
				var_16_0:getStateMaps()[var_0_5.BuildToState[arg_16_1.build_tp]] = iter_16_1

				break
			end
		end
	end

	self._buildData:onS2COutpostBuildUse(arg_16_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostBuildUseLeave(arg_17_1)
	local var_17_0 = self._knightsData:getKnightBySid(arg_17_1.knight.knight_id)

	if var_17_0 then
		local var_17_1 = self:updateKnightsMapType({
			arg_17_1.knight
		})[1]

		var_17_0:setServerData(var_17_1, nil, false)

		for iter_17_0, iter_17_1 in ipairs(var_17_1.states) do
			if iter_17_1.tp == var_0_5.BuildToState[arg_17_1.build_tp] then
				var_17_0:getStateMaps()[var_0_5.BuildToState[arg_17_1.build_tp]] = iter_17_1

				break
			end
		end
	end

	self._buildData:onS2COutpostBuildUseLeave(arg_17_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostBuildOrderProcess(arg_18_1)
	self._buildData:onS2COutpostBuildOrderProcess(arg_18_1)

	if arg_18_1.knight then
		arg_18_1.knight = self:updateKnightsMapType({
			arg_18_1.knight
		})[1]

		self._knightsData:updateKnightSvr({
			arg_18_1.knight
		})
	end

	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostBuildChangeOrder(arg_19_1)
	self._buildData:onS2COutpostBuildChangeOrder(arg_19_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostCallBoss(arg_20_1)
	if arg_20_1.boss then
		self._allBossDict[arg_20_1.boss.unique_id] = arg_20_1.boss
	end

	self._buildData:onS2COutpostCallBoss(arg_20_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostDelBoss(arg_21_1)
	self._allBossDict[arg_21_1.boss_id] = nil
end

function OutpostData:onS2COutpostBossSweep(arg_22_1)
	self:checkUpdateOutpostFightValue()

	if arg_22_1.box then
		self._allBossBoxDict[arg_22_1.box.id] = arg_22_1.box
	end
end

function OutpostData:onS2COutpostClickDrop(arg_23_1)
	self._allDropDict[table.concat({
		arg_23_1.map_tp,
		arg_23_1.target_x,
		arg_23_1.target_y,
		arg_23_1.seq
	}, "_")] = nil
end

function OutpostData:onS2COutpostClickBossBox(arg_24_1)
	if self._allBossBoxDict[arg_24_1.box_id] then
		self._allBossBoxDict[arg_24_1.box_id] = nil
	end
end

function OutpostData:onS2COutpostGetTaskAward(arg_25_1)
	self._taskData:onS2COutpostGetTaskAward(arg_25_1)
	self._buildData:onS2COutpostGetTaskAward(arg_25_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutpostSyncTask(arg_26_1)
	self._taskData:onS2COutpostSyncTask(arg_26_1)
	self._buildData:onS2COutpostSyncTask(arg_26_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutPostKnightEntrance(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1.slots) do
		local var_27_0 = false

		for iter_27_2, iter_27_3 in ipairs(self._slots) do
			if iter_27_1.pos == iter_27_3.pos then
				var_27_0 = true
				iter_27_3.knight_id = iter_27_1.knight_id

				break
			end
		end

		if not var_27_0 then
			table.insert(self._slots, iter_27_1)
		end
	end

	arg_27_1.knights = self:updateKnightsMapType(arg_27_1.knights)

	self._knightsData:updateKnightEntrance(arg_27_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutPostKnightExit(arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1.knights) do
		for iter_28_2, iter_28_3 in ipairs(self._slots) do
			if iter_28_3.knight_id == iter_28_1.knight_id then
				iter_28_3.knight_id = 0

				break
			end
		end
	end

	self._knightsData:updateKnightExit(arg_28_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COutPostKnightChangeMap(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1.slots) do
		for iter_29_2, iter_29_3 in ipairs(self._slots) do
			if iter_29_1.pos == iter_29_3.pos then
				iter_29_3.map_type = iter_29_1.map_type

				break
			end
		end
	end

	self._knightsData:onS2COutPostKnightChangeMap(arg_29_1)
	self:checkUpdateOutpostFightValue()
end

function OutpostData:onS2COneKeyClickDrop(arg_30_1)
	self._allDropDict = {}
end

function OutpostData:onS2COutpostMapUnlock(arg_31_1)
	self._arenaTypeMap[arg_31_1.map_tp].isOpen = true
	self._svrMapInfo[arg_31_1.map_tp] = arg_31_1.map

	for iter_31_0, iter_31_1 in ipairs(arg_31_1.map.drops or {}) do
		self._allDropDict[table.concat({
			arg_31_1.map.map_type,
			iter_31_1.pos_x,
			iter_31_1.pos_y,
			iter_31_1.seq
		}, "_")] = {
			mapType = arg_31_1.map.map_type,
			drop = iter_31_1
		}
	end

	for iter_31_2, iter_31_3 in ipairs(arg_31_1.map.monsters or {}) do
		self._allMonsterDict[iter_31_3.unique_id] = iter_31_3
	end
end

function OutpostData:onS2COpObject(arg_32_1)
	self._bagData:onS2COpObject(arg_32_1)
	self._buildData:onS2COpObject(arg_32_1)
end

function OutpostData:onS2CRedPoint(arg_33_1)
	self._taskData:updateTask(arg_33_1.tasks)

	self._ownVit = arg_33_1.cur_vit or 0
end

function OutpostData:onBossTimeFinish(arg_34_1)
	self._allBossDict[arg_34_1] = nil
end

function OutpostData:isHasVit()
	return self._ownVit > 0
end

function OutpostData:isHasLimitTaskAward()
	return self._taskData:canGetLimitTaskAward()
end

function OutpostData:isCanLineUp()
	return #self._knightsData:getAllCanUpKnights() > 0 and self._knightsData:isCanLineUp()
end

function OutpostData:isHasBossChallengeTimes()
	return g.core.model.User.shopData:getLeftCount(g.core.const.ConstMgr.outpostConst.BOSS_SUMMON_PLAY_NUM_ID) > 0
end

function OutpostData:isHasAchievementReward()
	return
end

function OutpostData:getAllArenaInfo()
	local var_40_0 = {
		{
			isOpen = true,
			arena = 1,
			name = g.core.lang:get(432602),
			subName = g.core.lang:get(432602)
		}
	}

	for iter_40_0, iter_40_1 in var_0_7.ipairs() do
		var_40_0[iter_40_1.map_type] = {
			name = iter_40_1.name,
			subName = iter_40_1.sub_name,
			arena = iter_40_1.map_type,
			cfg = iter_40_1,
			isOpen = self._arenaTypeMap[iter_40_1.map_type].isOpen
		}
	end

	return var_40_0
end

function OutpostData:getBuildData()
	return self._buildData
end

function OutpostData:getBagData()
	return self._bagData
end

function OutpostData:getKnightsData()
	return self._knightsData
end

function OutpostData:getTaskData()
	return self._taskData
end

function OutpostData:getAllDropDict()
	return self._allDropDict
end

function OutpostData:getAllMonsters()
	return self._allMonsterDict
end

function OutpostData:getAllBoss()
	return self._allBossDict
end

function OutpostData:getBossById(arg_48_1)
	for iter_48_0, iter_48_1 in pairs(self._allBossDict) do
		if iter_48_1.monster_id == arg_48_1 then
			return iter_48_1
		end
	end

	return nil
end

function OutpostData:hasBoss()
	local var_49_0 = var_0_9.get(var_0_5.WorldParam.BossAttackTime).parameter
	local var_49_1 = var_0_6:getTime()

	for iter_49_0, iter_49_1 in pairs(self._allBossDict) do
		if var_49_1 < iter_49_1.alive_time + var_49_0 then
			return true
		end
	end

	return false
end

function OutpostData:isSpeedBtnActive()
	return var_0_9.get(var_0_5.WorldParam.SpeedOnMainCityLevel).parameter <= self:getBuildData():getMainCity():getLevel()
end

function OutpostData:getFightValue()
	return self._knightsData:getFightValue()
end

function OutpostData:isLockDoor(arg_52_1)
	if self._areaDoor[arg_52_1] then
		if self._areaDoor[arg_52_1].isOpen then
			return false
		end

		self._areaDoor[arg_52_1].isOpen = self._areaDoor[arg_52_1].isOpen
	end

	return false
end

function OutpostData:isArenaOpen(arg_53_1)
	if self._arenaTypeMap[arg_53_1] and self._arenaTypeMap[arg_53_1].isOpen then
		return true
	end

	return false
end

function OutpostData:checkIsCondAccept(arg_54_1)
	local var_54_0 = true

	while var_0_7.hasKey("unlock_type_" .. 1) do
		if arg_54_1["unlock_type_" .. 1] ~= 0 then
			if arg_54_1["unlock_type_" .. 1] == 500 and arg_54_1["unlock_key_" .. 1] == 1 then
				if self:getBuildData():getMainCity():getLevel() < arg_54_1["unlock_value_" .. 1] then
					var_54_0 = false
				end
			elseif (self:getStatusByIdAndKey(arg_54_1["unlock_type_" .. 1], arg_54_1["unlock_key_" .. 1]) or 0) < arg_54_1["unlock_value_" .. 1] then
				var_54_0 = false
			end
		end
	end

	return var_54_0
end

function OutpostData:checkUpdateOutpostFightValue()
	local var_55_0 = self:getFightValue() - self._oldFightValue

	if var_55_0 > 0 then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_ADD_FEEDBACK_SHOW, false, {
			outpostFightValueChange = var_55_0
		})
	end

	self._oldFightValue = self:getKnightsData():getFightValue()
end

function OutpostData:getArenaUnlockTipStr(arg_56_1)
	return arg_56_1.unlock_des
end

function OutpostData:getKnightSpine(arg_57_1)
	var_0_12[arg_57_1.resId] = var_0_12[arg_57_1.resId] or {}

	local var_57_0 = table.remove(var_0_12[arg_57_1.resId])

	if not var_57_0 then
		var_57_0 = require("app.view.common.CommonKnight").new(arg_57_1)

		var_57_0:retain()
	end

	return var_57_0
end

function OutpostData:recycleKnightSpine(arg_58_1)
	arg_58_1:retain()
	arg_58_1:removeFromParent()

	local var_58_0 = arg_58_1:getKnightSpine():getResId()

	var_0_12[var_58_0] = var_0_12[var_58_0] or {}

	if #var_0_12[var_58_0] <= 2 then
		table.insert(var_0_12[var_58_0], arg_58_1)
	else
		arg_58_1:release()
	end
end

function OutpostData:clearCacheKnightSpine()
	for iter_59_0, iter_59_1 in pairs(var_0_12) do
		for iter_59_2, iter_59_3 in ipairs(iter_59_1) do
			iter_59_3:release()
		end

		var_0_12[iter_59_0] = {}
	end
end

function OutpostData:updateStatus(arg_60_1)
	self._statusDic[table.concat({
		arg_60_1.id,
		arg_60_1.key
	}, "_")] = arg_60_1
end

function OutpostData:getStatusByIdAndKey(arg_61_1, arg_61_2)
	return self._statusDic[table.concat({
		arg_61_1,
		arg_61_2
	}, "_")]
end

function OutpostData:getAllStatus()
	return self._statusDic
end

function OutpostData:setShowAttackRange(arg_63_1)
	self._showAttackRange = arg_63_1
end

function OutpostData:isShowAttackRange()
	return self._showAttackRange
end

function OutpostData:setAsyncUpdate(arg_65_1)
	self._asyncUpdate = arg_65_1
end

function OutpostData:getOwnVit()
	return self._ownVit
end

function OutpostData:getLastShowVit()
	if var_0_6:getTime() - self._lastShowVitTime >= var_0_5.ShowVitDeltaTime then
		self._lastShowVitValue = self._ownVit
		self._lastShowVitTime = var_0_6:getTime()
	end

	return self._lastShowVitValue
end

function OutpostData:isAsyncUpdate()
	return self._asyncUpdate
end

function OutpostData:isCanOutOutpost()
	return g.core.model.User.dungeonData:getLastPassedStageId() > 0
end

function OutpostData:setMonsterDamageRate(arg_70_1)
	self._monsterDamageRate = arg_70_1
end

function OutpostData:setKnightDamageRate(arg_71_1)
	self._knightDamageRate = arg_71_1
end

function OutpostData:getMonsterDamageRate()
	return self._monsterDamageRate
end

function OutpostData:getKnightDamageRate()
	return self._knightDamageRate
end

function OutpostData:getBossHp(arg_74_1)
	return self._curBossHpDict[arg_74_1]
end

function OutpostData:setBossHp(arg_75_1, arg_75_2)
	self._curBossHpDict[arg_75_1] = arg_75_2
end

function OutpostData:saveBossHp()
	self._jsonBossHpData = {}

	for iter_76_0, iter_76_1 in pairs(self._allBossDict) do
		self._jsonBossHpData[tostring(iter_76_0)] = self._curBossHpDict[iter_76_0]
	end

	g.core.common.Storage:save(var_0_5.BossHpJson, self._jsonBossHpData)
end

function OutpostData:getBossBoxDict()
	return self._allBossBoxDict
end

function OutpostData:resetRejectBuildCache()
	self._rejectSids = {}
end

function OutpostData:checkCoinEnough(arg_79_1, arg_79_2)
	if arg_79_2 ~= var_0_5.REJECT_IN_BUILD_REASON.NOT_COIN then
		if self._rejectSids[arg_79_1] then
			self._rejectSids[arg_79_1] = nil

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_KNIGHT_NOT_COIN_REFRESH)
		end
	elseif arg_79_2 == var_0_5.REJECT_IN_BUILD_REASON.NOT_COIN then
		self._rejectSids[arg_79_1] = var_0_5.REJECT_IN_BUILD_REASON.NOT_COIN

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_OUTPOST_KNIGHT_NOT_COIN_REFRESH)
	end
end

function OutpostData:isLackConBuildCoin(arg_80_1)
	if not self._rejectSids then
		return false
	end

	if arg_80_1 and arg_80_1.sid then
		if self._rejectSids[arg_80_1.sid] then
			return true
		end
	elseif next(self._rejectSids) then
		return true
	end

	return false
end

function OutpostData:setTodayPoint(arg_81_1)
	self._todayPoint = arg_81_1
end

function OutpostData:getTodayPoint()
	return self._todayPoint
end

function OutpostData:getKnightsPositions(arg_83_1)
	local var_83_0 = {}

	for iter_83_0 = 1, #arg_83_1 do
		for iter_83_1, iter_83_2 in ipairs(self._slots) do
			if iter_83_2.knight_id == arg_83_1[iter_83_0] then
				table.insert(var_83_0, iter_83_2.pos)
			end
		end
	end

	return var_83_0
end

function OutpostData:getLineupAdvanceIdPosMap(arg_84_1)
	local var_84_0 = {}
	local var_84_1 = self:getBuildData():getBuild({
		type = var_0_5.BuildType.Main
	})
	local var_84_2 = var_84_1 and var_84_1:getMaxRoleNum() or 0

	local function var_84_3(arg_85_0)
		for iter_85_0 = arg_85_0, var_84_2 do
			local var_85_0 = false

			for iter_85_1, iter_85_2 in ipairs(self._slots) do
				if iter_85_2.pos == iter_85_0 then
					var_85_0 = true

					if iter_85_2.knight_id == 0 then
						return iter_85_0
					end
				end
			end

			if not var_85_0 then
				return iter_85_0
			end
		end
	end

	for iter_84_0 = 1, #arg_84_1 do
		table.insert(var_84_0, {
			id = arg_84_1[iter_84_0],
			num = var_84_3(1)
		})

		local var_84_4 = var_84_3(1) + 1
	end

	return var_84_0
end

function OutpostData:updateKnightsMapType(arg_86_1)
	for iter_86_0, iter_86_1 in ipairs(arg_86_1 or {}) do
		for iter_86_2, iter_86_3 in ipairs(self._slots) do
			if iter_86_1.knight_id == iter_86_3.knight_id then
				iter_86_1.map_type = iter_86_3.map_type

				break
			end
		end
	end

	return arg_86_1
end

function OutpostData:loadSpeedJsonData()
	local var_87_0 = g.core.common.Storage:load("out_post_speed.json", true) or {}

	self._curSpeed = var_87_0.curSpeed or 1
	self._isSpeedOn = var_87_0.speedOn
end

function OutpostData:setSpeed(arg_88_1, arg_88_2)
	if arg_88_1 then
		self._curSpeed = arg_88_1
	end

	if arg_88_2 ~= nil then
		self._isSpeedOn = arg_88_2
	end
end

function OutpostData:isSpeedOn()
	return self._isSpeedOn
end

function OutpostData:getMaxSpeed()
	return 10
end

function OutpostData:getSpeed()
	if not self._isSpeedOn then
		return 1
	end

	return self._curSpeed or 1
end

function OutpostData:saveSpeedJsonData()
	g.core.common.Storage:save("out_post_speed.json", {
		curSpeed = self._curSpeed,
		speedOn = self._isSpeedOn
	})
end

return OutpostData
