local var_0_0 = g.core.config.tower_stage_info
local var_0_1 = g.core.config.tower_debuff_info
local var_0_2 = g.core.config.parameter_info
local var_0_3 = g.core.config.tower_reward_info
local var_0_4 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_5 = g.core.config.tower_skip_info
local var_0_6 = g.core.const.ConstMgr.ShopConst
local var_0_7 = g.core.model.User.shopData
local var_0_8 = g.core.const.ConstMgr.TowerConst
local var_0_9 = g.core.const.ConstMgr.RankAwardConst
local var_0_10 = g.core.const.ConstMgr.PARAMETER_CONST
local var_0_11 = g.core.common.ServerTime
local var_0_12 = g.core.model.User
local RankAward = require("app.core.common.RankAward")
local var_0_14 = g.core.const.ConstMgr
local TowerData = class("TowerData")

function TowerData:ctor()
	self:initData()
end

function TowerData:initData()
	self._isRunSpeedAddEffect = false
	self._isRunMainOpenEffect = false
	self._isRunMainLockEffect = false
	self._lastCapacityData = {}
	self._hasFirstPassReward = false
	self._isInitGetInfo = false
	self._challengeIsWin = false
	self._buffStageList = nil
	self._rankRewardList = {}
	self._passTowerData = {}
	self._towerStageInfo = nil
	self._towerParamsData = {}
	self._serverFirstPassAwardIdsMap = {}
	self._firstPassAwardGetIds = {}
	self._towerPassCountMap = {}
	self._towerMaxPassRewardIdMap = {}
	self._rankList = {}
	self._selfRanks = {}
	self._capacityData = nil
	self._oneKeyBattleRewardList = {}
	self._curUserKnightIdsInStageList = {}
	self._oldJsonFormationData = {}
	self._isSelectNotPopFormation = false
	self._isNotJsonFormationData = false
	self._hangupStartTime = 0
	self._hangupEndTime = 0
	self._serverHangUpReward = {}
	self._subTowerMaxStageJsonData = {}
	self._displayVersion = 1
	self._monsterVersion = 1
	self._hangupOnceTime = var_0_2.get(var_0_10.TOWER_FIGHT_HANGUP_ONCE_TIME).parameter
	self._hangupMaxTime = var_0_2.get(var_0_10.TOWER_FIGHT_HANGUP_MAX_TIME).parameter
	self._hangupParameterTime = var_0_2.get(var_0_10.TOWER_FIGHT_HANGUP_ACCELERATE).parameter

	self:initStageInfo()
end

function TowerData:onGetInfoInitData()
	self._isInitGetInfo = false
	self._challengeIsWin = false
	self._buffStageList = nil
	self._rankRewardList = {}
	self._passTowerData = {}
	self._towerParamsData = {}
	self._serverFirstPassAwardIdsMap = {}
	self._firstPassAwardGetIds = {}
	self._towerPassCountMap = {}
	self._towerMaxPassRewardIdMap = {}
	self._rankList = {}
	self._selfRanks = {}
	self._capacityData = nil
	self._oneKeyBattleRewardList = {}
	self._curUserKnightIdsInStageList = {}
	self._oldJsonFormationData = {}
	self._isSelectNotPopFormation = false
	self._isNotJsonFormationData = false
	self._hangupStartTime = 0
	self._hangupEndTime = 0
	self._serverHangUpReward = {}
	self._subTowerMaxStageJsonData = {}
end

function TowerData:resetData()
	self._rankList = {}
	self._selfRanks = {}
end

function TowerData:initJsonData()
	self._curUserKnightIdsInStageList = {}

	local var_5_0 = g.core.common.Storage:load(var_0_8.FORMATION_JSON_NAME, true) or {}

	if table.nums(var_5_0) > 0 then
		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			if type(iter_5_1) == "table" then
				self._curUserKnightIdsInStageList[iter_5_0] = iter_5_1
				self._oldJsonFormationData[iter_5_0] = iter_5_1
			end
		end

		self._isSelectNotPopFormation = var_5_0.isSelectNotPopFormation or false
	else
		self._isNotJsonFormationData = true
	end

	for iter_5_2, iter_5_3 in pairs(g.core.common.Storage:load(var_0_8.SUB_TOWER_JSON_NAME, true) or {}) do
		self._subTowerMaxStageJsonData[tonumber(iter_5_2)] = iter_5_3
	end
end

function TowerData:setFormationData(arg_6_1, arg_6_2, arg_6_3)
	self._curUserKnightIdsInStageList[arg_6_1 .. "_" .. arg_6_2] = arg_6_3
end

function TowerData:saveFormationJsonData()
	if self:_checkIsChangeFormationInJson() then
		self._oldJsonFormationData = self._curUserKnightIdsInStageList
		self._curUserKnightIdsInStageList.isSelectNotPopFormation = self._isSelectNotPopFormation

		g.core.common.Storage:save(var_0_8.FORMATION_JSON_NAME, self._curUserKnightIdsInStageList, true)

		self._isNotJsonFormationData = false
	end
end

function TowerData:_checkIsChangeFormationInJson()
	if self._isSelectNotPopFormation ~= self._curUserKnightIdsInStageList.isSelectNotPopFormation then
		return true
	end

	for iter_8_0, iter_8_1 in pairs(self._oldJsonFormationData) do
		if type(iter_8_1) == "table" then
			for iter_8_2 = 1, var_0_4.LINEUP_MAX do
				if not self._curUserKnightIdsInStageList[iter_8_0] or self._curUserKnightIdsInStageList[iter_8_0][iter_8_2] ~= iter_8_1[iter_8_2] then
					return true
				end
			end
		end
	end

	return false
end

function TowerData:getCurUserKnightIds(arg_9_1, arg_9_2)
	return clone(self._curUserKnightIdsInStageList[arg_9_1 .. "_" .. arg_9_2] or {})
end

function TowerData:getIsSelectPopFormation()
	return self._isSelectNotPopFormation
end

function TowerData:setIsSelectPopFormation(arg_11_1)
	self._isSelectNotPopFormation = arg_11_1 == true
end

function TowerData:checkIsNeedPopFormation(arg_12_1)
	if not self._isSelectNotPopFormation then
		return true
	end

	if self._isNotJsonFormationData then
		return true
	end

	local var_12_0, var_12_1 = self:getCurTowerIdByType(arg_12_1)
	local var_12_2 = var_0_0.get(var_12_1)
	local var_12_3 = self:getCurUserKnightIds(arg_12_1, 6)

	if table.nums(var_12_3) == 0 then
		return true
	end

	local var_12_4 = var_0_12.knightsData:getFormation() or {}
	local var_12_5 = {}
	local var_12_6 = 0

	for iter_12_0 = 1, var_0_4.LINEUP_MAX do
		if var_12_4[iter_12_0] > 0 then
			var_12_5[var_12_4[iter_12_0]] = true
		end
	end

	for iter_12_1 = 1, var_0_4.LINEUP_MAX do
		if var_12_3[iter_12_1] > 0 then
			if var_12_5[var_12_3[iter_12_1]] ~= true then
				return true
			else
				var_12_6 = var_12_6 + 1
			end
		end
	end

	if var_12_6 == 0 or 6 < var_12_6 then
		return true
	end

	return false
end

function TowerData:getFormationPos(arg_13_1)
	local var_13_0, var_13_1 = self:getCurTowerIdByType(arg_13_1)
	local var_13_2 = var_0_0.get(var_13_1)
	local var_13_3 = self:getCurUserKnightIds(arg_13_1, 6)
	local var_13_4 = {}
	local var_13_5 = {}

	for iter_13_0, iter_13_1 in pairs({}) do
		for iter_13_2 = 1, var_0_4.LINEUP_MAX do
			if var_13_4[iter_13_2] == 0 and var_13_5[iter_13_2] == true then
				var_13_4[iter_13_2] = iter_13_1

				break
			end
		end
	end

	return var_13_1, var_13_4
end

function TowerData:saveSubTowerJsonData(arg_14_1)
	for iter_14_0 = var_0_8.STAGE_TYPE.JIAO_GUO, var_0_8.STAGE_TYPE.LI_JIN do
		self._subTowerMaxStageJsonData[iter_14_0] = self:getCurTowerIdByType(iter_14_0)
	end

	g.core.common.Storage:save(var_0_8.SUB_TOWER_JSON_NAME, self._subTowerMaxStageJsonData, true)
end

function TowerData:getLineNeedLightBySubTower()
	local var_15_0 = {}

	for iter_15_0 = var_0_8.STAGE_TYPE.JIAO_GUO, var_0_8.STAGE_TYPE.LI_JIN do
		var_15_0[iter_15_0] = ((not self._subTowerMaxStageJsonData[iter_15_0] or nil) and 0) < self:getCurTowerIdByType(iter_15_0)
	end

	return var_15_0
end

function TowerData:onsS2CTowerGetInfo(arg_16_1)
	self._isInitGetInfo = true
	self._hasFirstPassReward = false

	self:onGetInfoInitData()
	self:initJsonData()

	local var_16_0 = rawget(arg_16_1, "stages")

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			if iter_16_1.user_stage then
				self._passTowerData[iter_16_1.user_stage.type] = iter_16_1.user_stage
			end

			if iter_16_1.type then
				self._towerMaxPassRewardIdMap[iter_16_1.type] = iter_16_1.max_stage_first_reward_id or 0
				self._towerPassCountMap[iter_16_1.type] = iter_16_1.challenge_stage_pass_count or 0
			end
		end
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_1.can_award_ids or {}) do
		local var_16_1 = var_0_3.fetch(iter_16_3)

		if var_16_1 then
			if self._serverFirstPassAwardIdsMap[var_16_1.tab_type] == nil then
				self._serverFirstPassAwardIdsMap[var_16_1.tab_type] = {}
			end

			table.insert(self._serverFirstPassAwardIdsMap[var_16_1.tab_type], iter_16_3)

			self._firstPassAwardGetIds[iter_16_3] = false
		end
	end

	self:_initCapacityData()

	self._hangupStartTime = arg_16_1.hangup_start_time or 0
	self._hangupEndTime = arg_16_1.hangup_end_time or 0
	self._serverHangUpReward = arg_16_1.hangup_stub_awards or {}
end

function TowerData:getIsInitGetInfo()
	return self._isInitGetInfo
end

function TowerData:getIsFirstPassByStageAndId(arg_18_1, arg_18_2)
	return arg_18_2 <= (self._towerMaxPassRewardIdMap[arg_18_1] or 0)
end

function TowerData:getFirstPassMaxId(arg_19_1)
	return self._towerMaxPassRewardIdMap[arg_19_1] or 0
end

function TowerData:_initCapacityData()
	self._capacityData = {}

	for iter_20_0, iter_20_1 in pairs(var_0_8.STAGE_TYPE) do
		self._capacityData[iter_20_1] = self:getStageRewardList(self:getCurTowerIdByType(iter_20_1), false)
	end
end

function TowerData:getCapacityData()
	if self._capacityData == nil then
		self:_initCapacityData()
	end

	return self._capacityData
end

function TowerData:getCapacityAddListData(arg_22_1)
	if self._capacityData == nil then
		self:_initCapacityData()
	end

	local var_22_0, var_22_1 = self:getHangUpTimeHours()
	local var_22_2 = {}
	local var_22_3 = self._lastCapacityData[arg_22_1] or {}

	for iter_22_0, iter_22_1 in pairs(self._capacityData[arg_22_1] or {}) do
		local var_22_4 = iter_22_1.size

		for iter_22_2 = 1, #var_22_3 do
			if var_22_3[iter_22_2].type == iter_22_1.type and var_22_3[iter_22_2].value == iter_22_1.value then
				var_22_4 = iter_22_1.size - var_22_3[iter_22_2].size

				break
			end
		end

		if var_22_4 > 0 then
			table.insert(var_22_2, {
				size = 0,
				type = iter_22_1.type,
				value = iter_22_1.value,
				curSize = iter_22_1.size,
				addSize = var_22_4,
				onceTime = var_22_0
			})
		end
	end

	return var_22_2
end

function TowerData:getCapacityAddListDataById(arg_23_1, arg_23_2)
	local var_23_0 = self:getStageRewardList(arg_23_1, false)
	local var_23_1 = {}
	local var_23_2, var_23_3 = self:getHangUpTimeHours()

	for iter_23_0, iter_23_1 in pairs((self:getStageRewardList(arg_23_2, false))) do
		local var_23_4 = iter_23_1.size

		for iter_23_2 = 1, #var_23_0 do
			if var_23_0[iter_23_2].type == iter_23_1.type and var_23_0[iter_23_2].value == iter_23_1.value then
				var_23_4 = iter_23_1.size - var_23_0[iter_23_2].size

				break
			end
		end

		if var_23_4 > 0 then
			table.insert(var_23_1, {
				size = 0,
				type = iter_23_1.type,
				value = iter_23_1.value,
				curSize = iter_23_1.size,
				addSize = var_23_4,
				onceTime = var_23_2
			})
		end
	end

	return var_23_1
end

function TowerData:onsS2CChallengeStageFinish(arg_24_1)
	local var_24_0 = rawget(arg_24_1, "stage")

	if not var_24_0 then
		return
	end

	local var_24_1 = var_24_0.type

	if var_24_0.type then
		self._towerMaxPassRewardIdMap[var_24_1] = var_24_0.max_stage_first_reward_id or 0
		self._towerPassCountMap[var_24_1] = var_24_0.challenge_stage_pass_count or 0
	end

	local var_24_2 = var_24_0.user_stage or {}

	if not self._passTowerData[var_24_1] then
		self._passTowerData[var_24_1] = var_24_2
	else
		for iter_24_0, iter_24_1 in pairs(var_24_2) do
			self._passTowerData[var_24_1][iter_24_0] = iter_24_1
		end
	end

	if arg_24_1.is_win then
		if var_24_1 == var_0_8.STAGE_TYPE.MAIN and not self:getMainTowerIsOpen() then
			self:saveSubTowerJsonData()
		end

		self._challengeIsWin = true

		local var_24_3 = clone(self._capacityData[var_24_1] or {})
		local var_24_4 = self:getStageRewardList(self:getCurTowerIdByType(var_24_1), false)

		self._capacityData[var_24_1] = var_24_4
		self._lastCapacityData[var_24_1] = var_24_3

		self:setRunSpeedAddEffect(#var_24_3 ~= #var_24_4 and true or self:_checkIsAddItem(var_24_3, var_24_4))
	end
end

function TowerData:onsS2CFirstPassAward(arg_25_1)
	if arg_25_1 then
		self._firstPassAwardGetIds[arg_25_1.id] = true
	end
end

function TowerData:onsS2COneKeyFirstPassAward(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(arg_26_1.ids or {}) do
		self._firstPassAwardGetIds[iter_26_1] = true
	end
end

function TowerData:onsS2CHangupAward(arg_27_1)
	self._hangupStartTime = var_0_11:getTime()
	self._serverHangUpReward = {}
end

function TowerData:onsS2CFastRolling(arg_28_1)
	local var_28_0 = rawget(arg_28_1, "stage_type") or 0
	local var_28_1 = arg_28_1.stage

	if arg_28_1.stage then
		var_28_0 = var_28_1.type

		if var_28_1.type then
			self._towerMaxPassRewardIdMap[var_28_0] = var_28_1.max_stage_first_reward_id or 0
			self._towerPassCountMap[var_28_0] = var_28_1.challenge_stage_pass_count or 0
		end

		local var_28_2 = var_28_1.user_stage or {}

		if not self._passTowerData[var_28_0] then
			self._passTowerData[var_28_0] = var_28_2
		else
			for iter_28_0, iter_28_1 in pairs(var_28_2) do
				self._passTowerData[var_28_0][iter_28_0] = iter_28_1
			end
		end
	end

	local var_28_3 = clone(self._capacityData[var_28_0] or {})
	local var_28_4 = self:getStageRewardList(self:getCurTowerIdByType(var_28_0), false)

	self._capacityData[var_28_0] = var_28_4
	self._lastCapacityData[var_28_0] = var_28_3

	self:setRunSpeedAddEffect(#var_28_3 ~= #var_28_4 and true or self:_checkIsAddItem(var_28_3, var_28_4))

	local var_28_6 = {}

	for iter_28_2, iter_28_3 in pairs(rawget(arg_28_1, "awards") or {}) do
		for iter_28_4 = 1, #iter_28_3.award do
			var_28_6[iter_28_3.award[iter_28_4].type .. "_" .. iter_28_3.award[iter_28_4].value] = not var_28_6[iter_28_3.award[iter_28_4].type .. "_" .. iter_28_3.award[iter_28_4].value] and iter_28_3.award[iter_28_4].size or var_28_6[iter_28_3.award[iter_28_4].type .. "_" .. iter_28_3.award[iter_28_4].value] + iter_28_3.award[iter_28_4].size
		end
	end

	local var_28_7 = {}

	for iter_28_5, iter_28_6 in pairs(var_28_6) do
		local var_28_8 = string.split(iter_28_5, "_")

		table.insert(var_28_7, {
			type = tonumber(var_28_8[1]),
			value = tonumber(var_28_8[2]),
			size = iter_28_6
		})
	end

	self._oneKeyBattleRewardList = var_28_7
end

function TowerData:onsS2COneKeyChallenge(arg_29_1)
	if arg_29_1.stage then
		if arg_29_1.stage.type then
			self._towerMaxPassRewardIdMap[arg_29_1.stage.type] = arg_29_1.stage.max_stage_first_reward_id or 0
			self._towerPassCountMap[arg_29_1.stage.type] = arg_29_1.stage.challenge_stage_pass_count or 0
		end

		local var_29_1 = arg_29_1.stage.user_stage or {}

		if not self._passTowerData[arg_29_1.stage.type] then
			self._passTowerData[arg_29_1.stage.type] = var_29_1
		else
			for iter_29_0, iter_29_1 in pairs(var_29_1) do
				self._passTowerData[arg_29_1.stage.type][iter_29_0] = iter_29_1
			end
		end
	end
end

function TowerData:convertCapacityAward(arg_30_1, arg_30_2)
	local var_30_0 = {}
	local var_30_1 = {}
	local var_30_2 = {}
	local var_30_3 = math.min(var_0_11:getTime(), self._hangupEndTime)

	for iter_30_0, iter_30_1 in pairs(arg_30_1) do
		local var_30_4 = 0

		if arg_30_2 ~= nil then
			var_30_4 = arg_30_2
		else
			local var_30_5 = self._passTowerData[iter_30_0]

			var_30_4 = self._passTowerData[iter_30_0] and var_30_5.open_time > 0 and var_30_3 - math.max(var_30_5.open_time, self._hangupStartTime) or 0
		end

		for iter_30_2, iter_30_3 in pairs(iter_30_1) do
			if iter_30_3.size * var_30_4 / self._hangupOnceTime > 0 then
				if var_30_2[iter_30_3.type .. "_" .. iter_30_3.value] then
					var_30_1[var_30_2[iter_30_3.type .. "_" .. iter_30_3.value]].size = var_30_1[var_30_2[iter_30_3.type .. "_" .. iter_30_3.value]].size + iter_30_3.size * var_30_4 / self._hangupOnceTime
				else
					table.insert(var_30_1, {
						type = iter_30_3.type,
						value = iter_30_3.value,
						size = iter_30_3.size * var_30_4 / self._hangupOnceTime
					})

					var_30_2[iter_30_3.type .. "_" .. iter_30_3.value] = #var_30_1
				end
			end
		end
	end

	local var_30_6 = {}

	for iter_30_4, iter_30_5 in ipairs(var_30_1) do
		local var_30_7 = math.floor(iter_30_5.size)

		if var_30_7 > 0 then
			iter_30_5.size = var_30_7

			table.insert(var_30_0, iter_30_5)

			var_30_6[iter_30_5.type .. "_" .. iter_30_5.value] = #var_30_0
		end
	end

	return var_30_0, var_30_6
end

function TowerData:_checkIsAddItem(arg_31_1, arg_31_2)
	for iter_31_0, iter_31_1 in pairs(arg_31_2) do
		for iter_31_2 = 1, #arg_31_1 do
			if arg_31_1[iter_31_2].type == iter_31_1.type and arg_31_1[iter_31_2].value == iter_31_1.value then
				if arg_31_1[iter_31_2].size ~= iter_31_1.size then
					return true
				else
					break
				end
			end
		end
	end

	return false
end

function TowerData:getCurTowerIdByType(arg_32_1)
	local var_32_1 = (self._passTowerData[arg_32_1] or {}).id or 0
	local var_32_2 = false
	local var_32_3 = 0

	if var_32_1 <= 0 then
		var_32_3 = self._towerStageInfo[arg_32_1].startId
	else
		local var_32_4 = var_0_0.get(var_32_1)

		var_32_3 = var_32_4.next_stage == 0 and var_32_1 or var_32_4.next_stage
		var_32_2 = var_32_4.next_stage == 0
	end

	return var_32_1, var_32_3, var_32_2
end

function TowerData:initStageInfo()
	local var_33_0 = {}
	local var_33_1 = {}

	for iter_33_0 = 1, var_0_0.getLength() do
		local var_33_2 = var_0_0.indexOf(iter_33_0)

		var_33_0[var_33_2.stage_type] = var_33_0[var_33_2.stage_type] or {}
		var_33_1[var_33_2.stage_type] = var_33_1[var_33_2.stage_type] or 0
		var_33_1[var_33_2.stage_type] = var_33_1[var_33_2.stage_type] + 1

		if var_33_2.stage_order == 1 then
			var_33_0[var_33_2.stage_type].startId = var_33_2.id
		elseif var_33_2.next_stage == 0 then
			var_33_0[var_33_2.stage_type].endId = var_33_2.id
		end
	end

	for iter_33_1, iter_33_2 in pairs(var_33_0) do
		iter_33_2.stageCount = var_33_1[iter_33_1]
	end

	self._towerStageInfo = var_33_0
end

function TowerData:_initBuffInfo()
	local var_34_0 = {}

	for iter_34_0 = 1, var_0_1.getLength() do
		local var_34_1 = var_0_1.indexOf(iter_34_0)

		var_34_0[var_34_1.stage_type] = var_34_0[var_34_1.stage_type] or {}

		table.insert(var_34_0[var_34_1.stage_type], var_34_1)
	end

	for iter_34_1, iter_34_2 in pairs(var_34_0) do
		table.sort(iter_34_2, function(arg_35_0, arg_35_1)
			return arg_35_0.clear_num < arg_35_1.clear_num
		end)
	end

	self._buffStageList = var_34_0
end

function TowerData:getTowerBuffInfo(arg_36_1)
	if self._buffStageList == nil then
		self:_initBuffInfo()
	end

	local var_36_0 = self._towerPassCountMap[arg_36_1] or 0
	local var_36_1 = 0
	local var_36_2 = self._buffStageList[arg_36_1] or {}

	for iter_36_0, iter_36_1 in pairs(var_36_2) do
		if var_36_0 >= iter_36_1.clear_num then
			var_36_1 = iter_36_0
		else
			break
		end
	end

	return var_36_2[var_36_1], var_36_2
end

function TowerData:getMainTowerIsOpen()
	local var_37_0 = self:getCurTowerIdByType(var_0_8.STAGE_TYPE.MAIN)
	local var_37_1
	local var_37_2 = 0
	local var_37_3 = 0

	if var_37_0 <= 0 then
		var_37_1 = var_0_0.get(self._towerStageInfo[var_0_8.STAGE_TYPE.MAIN].startId)
		var_37_3 = 0
		var_37_2 = var_37_1.require_value
	else
		local var_37_4 = var_0_0.get(var_37_0)

		if var_37_4.next_stage <= 0 then
			return false, var_37_2, var_37_3
		end

		var_37_1 = var_0_0.get(var_37_4.next_stage)
		var_37_3 = var_37_4.require_value
		var_37_2 = var_37_1.require_value
	end

	if not var_37_1 then
		return false, var_37_2, var_37_3
	end

	local var_37_5 = false

	if var_37_1.require_type == var_0_8.STAGE_REQUIRE_TYPE.NONE then
		var_37_5 = true
	elseif var_37_1.require_type == var_0_8.STAGE_REQUIRE_TYPE.ALL then
		var_37_5 = self:getTotalSubTower() >= var_37_1.require_value
	else
		local var_37_6 = self:getCurTowerIdByType(var_37_1.require_type)

		var_37_5 = ((var_37_6 > 0 or nil) and ((var_0_0.fetch(var_37_6) or {}).stage_order or 0)) >= var_37_1.require_value
	end

	return var_37_5, var_37_2, var_37_3
end

function TowerData:getTotalSubTower()
	local var_38_0 = 0

	for iter_38_0 = var_0_8.STAGE_TYPE.JIAO_GUO, var_0_8.STAGE_TYPE.LI_JIN do
		var_38_0 = var_38_0 + ((var_0_0.fetch((self:getCurTowerIdByType(iter_38_0))) or {}).stage_order or 0)
	end

	return var_38_0
end

function TowerData:getParamDataByType(arg_39_1)
	if not next(self._towerParamsData) then
		self:_initTowerParams()
	end

	return self._towerParamsData[arg_39_1] or {}
end

function TowerData:getSubTowerIsOpen(arg_40_1)
	if not next(self._towerParamsData) then
		self:_initTowerParams()
	end

	local var_40_0 = self._towerParamsData[arg_40_1] or {}
	local var_40_1 = var_0_11:getWeekDay()

	if var_40_1 == 0 then
		var_40_1 = 7
	end

	local var_40_2 = false

	for iter_40_0 = 1, 4 do
		if var_40_1 == var_40_0["open_time_" .. iter_40_0] then
			var_40_2 = true

			break
		end
	end

	local var_40_3 = var_0_11:getTime()
	local var_40_4 = 0
	local var_40_5 = false

	if self:isGMOpenByType(arg_40_1) and var_40_3 >= self._subTowerGMOpenTime and var_40_3 < self._subTowerGMEndTime then
		var_40_4 = self._subTowerGMEndTime
		var_40_5 = true
	end

	return var_40_2 or var_40_5, var_40_4
end

function TowerData:debugGetSubTowerIsOpen(arg_41_1)
	if arg_41_1 == 1 then
		return self:getMainTowerIsOpen()
	end

	if not next(self._towerParamsData) then
		self:_initTowerParams()
	end

	local var_41_0 = self._towerParamsData[arg_41_1] or {}
	local var_41_1 = var_0_11:getWeekDay()

	if var_41_1 == 0 then
		var_41_1 = 7
	end

	local var_41_2 = false

	for iter_41_0 = 1, 4 do
		if var_41_1 == var_41_0["open_time_" .. iter_41_0] then
			var_41_2 = true

			break
		end
	end

	local var_41_3 = var_0_11:getTime()
	local var_41_4 = 0
	local var_41_5 = false

	if self:isGMOpenByType(arg_41_1) and var_41_3 >= self._subTowerGMOpenTime and var_41_3 < self._subTowerGMEndTime then
		var_41_4 = self._subTowerGMEndTime
		var_41_5 = true
	end

	return var_41_2 or var_41_5, var_41_4
end

function TowerData:isGMOpenByType(arg_42_1)
	return false
end

function TowerData:_initTowerParams()
	for iter_43_0, iter_43_1 in g.core.config.tower_parameter_info.ipairs() do
		self._towerParamsData[iter_43_1.stage_type] = iter_43_1
	end
end

function TowerData:isPassBattleById(arg_44_1)
	if not self._towerSkipMap then
		self:_initTowerSkipMap()
	end

	local var_44_0 = var_0_12:getFightValue()
	local var_44_1 = var_0_0.fetch(arg_44_1)

	if var_44_1 == nil then
		return false
	end

	if var_44_1.if_speedup == 0 then
		return false
	end

	if var_44_1.if_node == 1 then
		var_44_1 = var_0_0.fetch(var_44_1.next_stage)

		if var_44_1 == nil then
			return false
		end
	end

	local var_44_2 = self._towerSkipMap[1]

	if not self._towerSkipMap[1] then
		return false
	end

	local var_44_3 = 1000

	for iter_44_0, iter_44_1 in ipairs(var_44_2) do
		if var_44_1.stage_order >= iter_44_1.tower_min and var_44_1.stage_order <= iter_44_1.tower_max then
			var_44_3 = iter_44_1.value
		end
	end

	return var_44_0 > ((self._displayVersion == 1 or nil) and (var_44_1.fight or var_44_1["fight_" .. self._displayVersion])) * (var_44_3 / 1000)
end

function TowerData:_initTowerSkipMap()
	self._towerSkipMap = {}

	for iter_45_0 = 1, var_0_5.getLength() do
		local var_45_0 = var_0_5.indexOf(iter_45_0)

		self._towerSkipMap[var_45_0.play_type] = self._towerSkipMap[var_45_0.play_type] or {}

		table.insert(self._towerSkipMap[var_45_0.play_type], var_45_0)
	end
end

function TowerData:getSubTowerMaxCount(arg_46_1)
	local var_46_0, var_46_1, var_46_2 = self:getCurTowerIdByType(arg_46_1)
	local var_46_3 = var_0_0.get(var_46_1)

	return (var_46_3 or nil) and (var_46_3.stage_order or 1), var_0_0.get(self._towerStageInfo[arg_46_1].endId).stage_order, var_46_2
end

function TowerData:getStageRewardList(arg_47_1, arg_47_2)
	local var_47_0 = arg_47_1

	if type(arg_47_1) == "number" then
		var_47_0 = var_0_0.fetch(arg_47_1)
	end

	local var_47_1 = {}

	if var_47_0 == nil then
		return var_47_1
	end

	local var_47_2 = 1
	local var_47_3 = (arg_47_2 and "reward_type" or "output_type_") .. 1

	while var_0_0.hasKey(var_47_3) do
		if var_47_0[var_47_3] > 0 then
			var_47_1[#var_47_1 + 1] = {
				type = var_47_0[var_47_3],
				value = var_47_0[(arg_47_2 and "reward_value" or "output_value_") .. var_47_2],
				size = var_47_0[(arg_47_2 and "reward_size" or "output_size_") .. var_47_2]
			}
		end

		var_47_2 = var_47_2 + 1
		var_47_3 = (arg_47_2 and "reward_type" or "output_type_") .. var_47_2
	end

	return var_47_1
end

function TowerData:resRankList(arg_48_1)
	if not arg_48_1 then
		return
	end

	self._selfRanks[arg_48_1.id] = rawget(arg_48_1, "self_rank") or 0
	self._rankList[arg_48_1.id] = {}

	for iter_48_0, iter_48_1 in pairs(rawget(arg_48_1, "rank_units") or {}) do
		local var_48_1 = {
			rank = iter_48_1.rank,
			score = iter_48_1.score,
			id = iter_48_1.id
		}

		var_48_1.user = rawget(iter_48_1, "user") or {}
		var_48_1.guild = rawget(iter_48_1, "guild") or {}

		table.insert(self._rankList[arg_48_1.id], var_48_1)
	end
end

function TowerData:getRankListByStageType(arg_49_1)
	return self._rankList[arg_49_1]
end

function TowerData:getMySelfRank(arg_50_1)
	return self._selfRanks[arg_50_1] or 0
end

function TowerData:getRankRewardListByStageType(arg_51_1)
	if self._rankRewardList[arg_51_1] ~= nil then
		return self._rankRewardList[arg_51_1]
	end

	local var_51_0 = RankAward:getRankAwardArray(var_0_9["TOWER_" .. arg_51_1])

	self._rankRewardList[arg_51_1] = var_51_0

	return var_51_0
end

function TowerData:getFirstPassAwardIsGetById(arg_52_1)
	return self._firstPassAwardGetIds[arg_52_1] or false
end

function TowerData:getTowerCanAwardIdsByType(arg_53_1)
	return self._serverFirstPassAwardIdsMap[arg_53_1] or {}
end

function TowerData:setFirstPassGetAward(arg_54_1, arg_54_2)
	self._firstPassAwardGetIds[arg_54_1] = arg_54_2 == true
end

function TowerData:setRunSpeedAddEffect(arg_55_1)
	self._isRunSpeedAddEffect = arg_55_1 == true
end

function TowerData:getRunSpeedAddEffect()
	self._isRunSpeedAddEffect = false

	return self._isRunSpeedAddEffect
end

function TowerData:getOneKeyBattleReward()
	self._oneKeyBattleRewardList = {}

	return self._oneKeyBattleRewardList
end

function TowerData:getStageStr(arg_58_1)
	return arg_58_1 < 10 and "000" .. arg_58_1 or arg_58_1 < 100 and "00" .. arg_58_1 or arg_58_1 < 1000 and "0" .. arg_58_1 or tostring(arg_58_1)
end

function TowerData:getHangUpTimeHours()
	return math.floor(self._hangupOnceTime / 3600), (math.floor(self._hangupMaxTime / 3600))
end

function TowerData:getHangUpRewardData(arg_60_1)
	local var_60_0 = arg_60_1 ~= false
	local var_60_1, var_60_2 = self:convertCapacityAward((self:getCapacityData()))

	for iter_60_0, iter_60_1 in pairs(self._serverHangUpReward) do
		if var_60_2[iter_60_1.type .. "_" .. iter_60_1.value] then
			var_60_1[var_60_2[iter_60_1.type .. "_" .. iter_60_1.value]].size = var_60_1[var_60_2[iter_60_1.type .. "_" .. iter_60_1.value]].size + iter_60_1.size
		else
			table.insert(var_60_1, {
				type = iter_60_1.type,
				value = iter_60_1.value,
				size = iter_60_1.size
			})

			var_60_2[iter_60_1.type .. "_" .. iter_60_1.value] = #var_60_1
		end
	end

	if var_60_0 then
		table.sort(var_60_1, function(arg_61_0, arg_61_1)
			if arg_61_0.type ~= arg_61_1.type then
				return arg_61_0.type > arg_61_1.type
			else
				return arg_61_0.value > arg_61_1.value
			end
		end)
	end

	return var_60_1
end

function TowerData:canGetHangupReward()
	if next(self._serverHangUpReward) then
		return true
	end

	return next((self:convertCapacityAward((self:getCapacityData()))))
end

function TowerData:getCurRealHangupTimeAndProgress()
	if self._hangupStartTime == 0 then
		return 0, 0
	end

	local var_63_0 = math.min(var_0_11:getTime() - self._hangupStartTime, self._hangupMaxTime)

	return var_63_0, var_63_0 / self._hangupMaxTime
end

function TowerData:getHangupTimeData()
	return self._hangupStartTime, self._hangupEndTime
end

function TowerData:getQuickHangupReward()
	local var_65_0 = self:convertCapacityAward(self:getCapacityData(), self._hangupParameterTime)

	table.sort(var_65_0, function(arg_66_0, arg_66_1)
		if arg_66_0.type ~= arg_66_1.type then
			return arg_66_0.type > arg_66_1.type
		else
			return arg_66_0.value < arg_66_1.value
		end
	end)

	return var_65_0
end

function TowerData:getChallengeIsWin()
	self._challengeIsWin = false

	return self._challengeIsWin
end

function TowerData:isShowAutoBtn(arg_68_1)
	local var_68_0, var_68_1, var_68_2 = self:getCurTowerIdByType(arg_68_1)

	if var_68_2 then
		return false
	end

	if var_0_7:getLeftCount(var_0_6.PLAY_TYPE["TOWER_CHALLENGE_COUNT_" .. arg_68_1]) <= 0 then
		return false
	end

	local var_68_3 = var_0_0.get(var_68_1)

	if var_68_3.next_stage == 0 and var_68_3.if_node then
		return false
	end

	return (self:isPassBattleById(var_68_1))
end

function TowerData:isSpiritHelpShow(arg_69_1)
	if not self:getSubTowerIsOpen(arg_69_1) then
		return false
	end

	local var_69_0, var_69_1, var_69_2 = self:getCurTowerIdByType(arg_69_1)

	if var_69_2 then
		return false
	end

	if var_0_7:getLeftCount(var_0_6.PLAY_TYPE["TOWER_CHALLENGE_COUNT_" .. arg_69_1]) <= 0 then
		return false
	end

	if not self._towerSkipMap then
		self:_initTowerSkipMap()
	end

	local var_69_3 = var_0_12:getFightValue()
	local var_69_4 = var_0_0.get(var_69_1)

	if var_69_4 == nil then
		return false
	end

	local var_69_5 = 1000

	for iter_69_0, iter_69_1 in ipairs(self._towerSkipMap[1] or {}) do
		if var_69_4.stage_order >= iter_69_1.tower_min and var_69_4.stage_order <= iter_69_1.tower_max then
			var_69_5 = iter_69_1.value

			break
		end
	end

	return var_69_3 > ((self._displayVersion == 1 or nil) and (var_69_4.fight or var_69_4["fight_" .. self._displayVersion])) * (var_69_5 / 1000)
end

function TowerData:setDisplayVersion(arg_70_1)
	self._displayVersion = arg_70_1
end

function TowerData:getDisplayVersion()
	return self._displayVersion
end

function TowerData:setMonsterVersion(arg_72_1)
	self._monsterVersion = arg_72_1
end

function TowerData:getSwitchMonsterTeamId(arg_73_1)
	local var_73_0 = g.core.config.monster_team_switch_info.get(arg_73_1)

	return (self._monsterVersion == 1 or nil) and (var_73_0.id or var_73_0["id_" .. self._monsterVersion])
end

function TowerData:hasHangupRewardRed()
	local var_74_0, var_74_1 = self:getCurRealHangupTimeAndProgress()

	return var_74_1 >= 0.5
end

function TowerData:hasFirstPassRewardRed(arg_75_1)
	if arg_75_1.stageType == nil then
		for iter_75_0, iter_75_1 in pairs(self._firstPassAwardGetIds) do
			if iter_75_1 == false then
				return true
			end
		end

		if self._hasFirstPassReward then
			return true
		end
	else
		for iter_75_2, iter_75_3 in pairs(self._serverFirstPassAwardIdsMap[arg_75_1.stageType] or {}) do
			if not self:getFirstPassAwardIsGetById(iter_75_3) then
				return true
			end
		end
	end
end

function TowerData:hasRedPointByFreeCount()
	if self._hangupStartTime ~= 0 then
		local var_76_0 = false

		for iter_76_0, iter_76_1 in pairs((self:getCapacityData())) do
			if next(iter_76_1) then
				var_76_0 = true

				break
			end
		end

		if not var_76_0 then
			return false
		end
	else
		return false
	end

	if var_0_7:getLeftCount(var_0_14.ShopConst.PLAY_TYPE.TOWER_ACCELERATE_COUNT) > 0 then
		return true
	end

	return false
end

function TowerData:updateRedData(arg_77_1)
	self._hangupStartTime = arg_77_1.hangup_start_time or 0
	self._hangupEndTime = arg_77_1.hangup_end_time or 0
	self._hasFirstPassReward = arg_77_1.has_first_reward or false

	for iter_77_0, iter_77_1 in ipairs(arg_77_1.user_stages or {}) do
		if iter_77_1.type then
			self._passTowerData[iter_77_1.type] = iter_77_1
		end
	end
end

return TowerData
