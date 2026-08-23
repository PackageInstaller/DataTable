local var_0_0 = math
local var_0_1 = table
local var_0_2 = table.insert
local var_0_3 = tostring
local var_0_4 = load("core.fight.FightComponent")
local var_0_5 = load("core.update.UpdateComponent")
local var_0_6 = load("core.player.PlayerFactory")
local var_0_7 = load("core.command.CommandComponent")
local var_0_8 = load("core.round.RoundComponent")
local var_0_9 = load("const.BattleConst")
local var_0_10 = load("core.rule.SkillSpecialRule")
local var_0_11 = load("const.BattleAttr")
local var_0_12
local var_0_13
local BattleField = class("BattleField")

BattleField.BATTLE_FIGHTING = 0
BattleField.BATTLE_FINISH = 1
BattleField.BATTLE_FAILURE = 2

function BattleField:ctor()
	self:init()
end

function BattleField:init()
	var_0_12 = nil
	var_0_13 = nil
	self._battleData = load("core.data.BattleData").create(self)
	self._playerCommands = {}
	self._hasSuccuba = false
	self._attackCount = 0
	self._curAttackCount = 0
	self._roundCount = 0
	self._actionCount = {
		0,
		0
	}
	self._listeners = {}
	self._commands = {}
	self._battleId = 0
	self._state = BattleField.BATTLE_FIGHTING
	self._winner = 0
	self._auto = load("core.auto.AutoComponent")

	self._auto:init()

	self._action = load("core.action.ActionComponent")
	self._winCondition = 0
	self._randoms = {}
	self._randomIndex = 1
	self._succubaCompareSkillId = 0
	self._hasSuccubaCompare = true
	self._videoCommands = {}
	self._isVideo = false
	self._record = load("core.BattleRecord")

	self._record:init()

	self._restartInfos = {}
	self._restartedIdentity = {
		false,
		false
	}
	var_0_10.globalTriggerTimes = {}
	var_0_10.globalTriggerRound = {}
	self._openingTransform = {}
	self._initKnightsHp = {
		{},
		{}
	}
	self._identityAttackCount = {
		0,
		0
	}
	self._isExtraAction = false
	self._disableComboRecover = false
	self._disableAngerRecover = false
	self._disableThreshRecover = false
	self._extraActionSkillId = 0
	self._allNewWave = false
	self._waveType = 1
	self._drawable = false
	self._disableBeforeUpdateSkill = false
	self._recoverList = {}
	self._recoverIndex = 0
	self._mutiResult = {}
	self._mutiUnits = {}
	self._summaryAll = false
	self._roundList = {}
	self._storedKnightsHp = {}
	self._aliveKnights = {}
	self._actionKnights = {}
end

function BattleField:addIdentityAttackCount(arg_3_1)
	self._identityAttackCount[arg_3_1] = self._identityAttackCount[arg_3_1] + 1
end

function BattleField:getAttackCountByIdentify(arg_4_1)
	return self._identityAttackCount[arg_4_1]
end

function BattleField:addRecord(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._record:addRecord(arg_5_1, arg_5_2, arg_5_3, arg_5_4, (arg_5_1.identity == 1 or nil) and (self._attackIndex[1] or self._attackIndex[2]))
end

function BattleField:getRecord()
	return self._record:getRecord()
end

function BattleField:getWinInfo()
	return self._record:getWinInfo()
end

function BattleField:recordArtifact()
	self._record:recordArtifact()
end

function BattleField:recordMagic()
	self._record:recordMagic()
end

function BattleField:reset()
	self:init()
end

function BattleField:restart()
	if self._atkType ~= 4 then
		self._attackIndex = {
			1,
			0
		}
	else
		self._attackIndex[2] = self._attackIndex[2] - 1
	end

	local var_11_0 = self._battleData:isComboInherit()

	self._battleData:setComboInherit(false)
	self:updateNewPlayer(1, true)
	self._battleData:setComboInherit(var_11_0)
	self._action:reset()
end

function BattleField:registerEventListener(arg_12_1, arg_12_2)
	self._listeners[arg_12_2] = arg_12_1
end

function BattleField:unregisterEventListener(arg_13_1)
	self._listeners[arg_13_1] = nil
end

function BattleField:bingos(arg_14_1, arg_14_2)
	local var_14_0 = arg_14_2 or 0

	if type(arg_14_1) == "number" then
		if arg_14_2 <= arg_14_1 then
			return 1
		elseif arg_14_1 <= 0 then
			return 0
		end
	end

	if var_14_0 == 0 then
		if type(arg_14_1) == "number" then
			var_14_0 = arg_14_1
		elseif type(arg_14_1) == "table" then
			for iter_14_0 = 1, #arg_14_1 do
				var_14_0 = var_14_0 + arg_14_1[iter_14_0]
			end
		end
	end

	local var_14_1 = self:boundedRandom(1, var_14_0)

	if type(arg_14_1) == "number" then
		return var_14_1 <= arg_14_1 and 1 or 0
	else
		local var_14_2 = 0
		local var_14_3 = 0

		repeat
			var_14_3 = var_14_3 + 1
			var_14_2 = var_14_2 + arg_14_1[var_14_3]
		until var_14_1 <= var_14_2 or var_14_3 >= #arg_14_1

		return var_14_1 <= var_14_2 and var_14_3 or 0
	end
end

function BattleField:bingo(arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or 1000

	return arg_15_1 >= self:boundedRandom(1, arg_15_2)
end

function BattleField:boundedRandom(arg_16_1, arg_16_2)
	local var_16_0 = self._randoms[self._randomIndex]

	if not self._randoms[self._randomIndex] then
		self._randomIndex = 1
		var_16_0 = self._randoms[1]
	end

	self._randomIndex = self._randomIndex + 1

	return var_0_0.floor(var_16_0 * (arg_16_2 - arg_16_1 + 1) / 1000) + arg_16_1
end

function BattleField:setInitData(arg_17_1)
	if BATTLE_PLATFORM == CLIENT and device.isWindowsDebug() then
		local var_17_0 = io.open("battle_report.txt", "w")

		var_17_0:write(json.encode(arg_17_1))
		var_17_0:close()
	end

	self._playId = arg_17_1.play_id

	self._battleData:setVictoryMode(arg_17_1.victory_mode)
	self._battleData:resetBattleData()

	local var_17_1 = loadCfg("core.config.cfg.battle_play_num_info").get(self._playId)

	if var_17_1 then
		self._battleData:setQsRate(var_17_1.battle_quality_magnification)
		self._battleData:setQualityLevelRate(var_17_1.battle_parameter_magnification)

		self._hasSuccubaCompare = var_17_1.succuba_battle_close ~= 1
	else
		self._battleData:setQsRate(arg_17_1.battle_quality_magnification or 1000)
		self._battleData:setQualityLevelRate(arg_17_1.battle_parameter_magnification or 1000)

		self._hasSuccubaCompare = arg_17_1.succuba_battle_close ~= 1
	end

	local var_17_3 = {}

	if arg_17_1.atk_type == 4 then
		local var_17_4 = loadCfg("core.config.cfg.debate_parameter_info")

		self._allNewWave = true

		self._battleData:setComboInherit(false)

		self._recoverList[1] = var_17_4.get(3).parameter
		self._recoverList[2] = var_17_4.get(4).parameter
		self._recoverIndex = 1
		self._needSpecialFirst = true
		self._summaryAll = true

		for iter_17_0 = 1, 2 do
			for iter_17_1, iter_17_2 in ipairs((iter_17_0 == 1 or nil) and (arg_17_1.own_teams or arg_17_1.enemy_teams)) do
				local var_17_5 = iter_17_2.monster_team_id and iter_17_2.monster_team_id > 0 or false

				for iter_17_3, iter_17_4 in ipairs(iter_17_2.units) do
					local var_17_6 = loadCfg("core.config.cfg." .. (var_17_5 and "monster_info" or "knight_info")).get(iter_17_4.id)

					if var_17_6.group == 0 then
						iter_17_4.multiple = var_17_4.get(12).parameter
					elseif var_17_6.group == 1 then
						iter_17_4.multiple = var_17_4.get(6).parameter
					elseif var_17_6.group == 2 then
						iter_17_4.multiple = var_17_4.get(7).parameter
					elseif var_17_6.group == 3 then
						iter_17_4.multiple = var_17_4.get(8).parameter
					elseif var_17_6.group == 4 then
						iter_17_4.multiple = var_17_4.get(9).parameter
					elseif var_17_6.group == 5 then
						iter_17_4.multiple = var_17_4.get(13).parameter
					end

					if iter_17_2.multiple then
						iter_17_4.multiple = (iter_17_4.multiple or 0) + iter_17_2.multiple
					end

					local var_17_8 = var_17_4.get(5).parameter

					if iter_17_4.hp then
						iter_17_4.hp = var_0_0.floor(iter_17_4.hp * (1000 + var_17_8) / 1000)
					end

					for iter_17_5, iter_17_6 in ipairs(iter_17_4.attrs) do
						if iter_17_6.type == var_0_11.INITIAL_HP then
							iter_17_6.value = var_0_0.floor(iter_17_6.value * (1000 + var_17_8) / 1000)
						elseif iter_17_6.type == var_0_11.BATTLE_HP then
							iter_17_6.value = var_0_0.floor(iter_17_6.value * (1000 + var_17_8) / 1000)
						end
					end
				end
			end
		end
	end

	self._waveType = arg_17_1.multi_fight_mode

	if self._waveType == 2 or self._waveType == 3 or self._waveType == 4 then
		self._allNewWave = true
		self._summaryAll = true

		self._battleData:setComboInherit(false)
	end

	self._randoms = arg_17_1.random_seeds
	self._atkType = arg_17_1.atk_type

	self._battleData:setIsPvp(arg_17_1.atk_type == 2 or arg_17_1.atk_type == 3 or arg_17_1.atk_type == 4)
	self._battleData:setIsRobot(arg_17_1.atk_type == 3)
	self._battleData:setCondition(arg_17_1.win_condition)

	self._winCondition = arg_17_1.win_condition

	self._auto:setAuto(2, true)

	self._battleId = arg_17_1.battle_id
	self._isAuto = arg_17_1.is_auto

	if self._isAuto then
		self._auto:setAuto(1, true)
	end

	self._attackIndex = {
		1,
		1
	}

	local var_17_9 = false

	for iter_17_7 = 1, 2 do
		local var_17_10

		if iter_17_7 == 1 then
			var_17_10 = arg_17_1.own_teams or arg_17_1.enemy_teams
		end

		local var_17_11 = var_17_10[1]
		local var_17_12 = self:isMonster(var_17_10[1])
		local var_17_13 = self:getProfessionDict(var_17_10[1])
		local var_17_14 = var_17_10[1].demon_boss_multiple

		for iter_17_8, iter_17_9 in ipairs(var_17_10[1].units) do
			local var_17_15 = loadCfg("core.config.cfg." .. (var_17_12 and "monster_info" or "knight_info")).get(iter_17_9.id)

			iter_17_9.professionPassives = iter_17_9.professionPassives or var_17_12 and (var_17_13[loadCfg("core.config.cfg.knight_info").get(var_17_15.advance_id).profession] or {}) or var_17_13[var_17_15.profession] or {}

			if var_17_14 and (var_17_14.team == var_17_15.group or var_17_15.group == 0 or var_17_15.group == 5) then
				iter_17_9.multiple = var_17_14.multiple
			end

			if var_17_11.multiple then
				iter_17_9.multiple = (iter_17_9.multiple or 0) + var_17_11.multiple
			end
		end

		self._battleData:setMultiple(iter_17_7, var_17_11.multiple)
		self._battleData:setElderBossBuff(iter_17_7, var_17_11.elder_boss_buff or {})
		self:setFightKnights(var_17_11.units, iter_17_7, var_17_12, var_17_11.user, var_17_11.monster_team_id)
		self:setEnabledCommands(var_17_11.combo, iter_17_7)
		self:setSuccubaData(var_17_11.succubas, iter_17_7)

		local var_17_18 = var_17_11.total_charm or 0

		var_17_3[iter_17_7] = var_17_18

		self._battleData:setSuccubaValue(var_17_18, iter_17_7)

		if var_17_11.succubas then
			self._battleData:setSuccuba(var_17_11.succubas, iter_17_7)
		end

		self._battleData:setFightValue(var_17_11.fight_value, iter_17_7)
		self._battleData:setAssist(arg_17_1.assistance_id)
		self._battleData:setPassiveSkills(iter_17_7, var_17_11.passive_skills)
		self._battleData:setPets(iter_17_7, var_17_11.pets)
		self._battleData:initPlayers()

		if not var_17_9 then
			for iter_17_10, iter_17_11 in ipairs(var_17_10) do
				if iter_17_11.succubas and #iter_17_11.succubas > 0 then
					var_17_9 = true
				end
			end
		end
	end

	self._battleData:initWarBandValue()

	self._hasSuccuba = var_17_9

	if not self._hasSuccuba then
		self._hasSuccubaCompare = false
	end

	local var_17_19 = var_17_3[1] or 0
	local var_17_20 = var_17_3[2] or 0
	local var_17_21 = loadCfg("core.config.cfg.succuba_battle_info")
	local var_17_22 = 0

	if var_17_20 < var_17_19 then
		var_17_22 = var_17_20 == 0 and 99999 or var_0_0.floor((var_17_19 - var_17_20) / var_17_20 * 1000)
	elseif var_17_19 ~= var_17_20 then
		var_17_22 = var_17_19 == 0 and 99999 or var_0_0.floor((var_17_20 - var_17_19) / var_17_19 * 1000)
	end

	if self._hasSuccubaCompare then
		for iter_17_12 = 1, var_17_21.getLength() do
			local var_17_23 = var_17_21.indexOf(iter_17_12)

			if var_17_22 >= var_17_23.score_low and var_17_22 < var_17_23.score_high then
				if var_17_20 < var_17_19 then
					self._battleData:addSpRule(1, nil, var_17_23.passive_skill_id, true)

					for iter_17_13, iter_17_14 in ipairs((self._battleData:getSuccubaInfo(1):getSuccubaInfo())) do
						if iter_17_14.quality >= 5 then
							self._battleData:addSpRule(1, nil, var_17_23.passive_skill_id2, true)

							break
						end
					end

					break
				end

				self._battleData:addSpRule(2, nil, var_17_23.passive_skill_id, true)

				for iter_17_15, iter_17_16 in ipairs((self._battleData:getSuccubaInfo(2):getSuccubaInfo())) do
					if iter_17_16.quality >= 5 then
						self._battleData:addSpRule(2, nil, var_17_23.passive_skill_id2, true)

						break
					end
				end

				break
			end
		end
	end

	self._initData = arg_17_1

	if self._summaryAll then
		self._record:initRecordAll(self._initData.own_teams, self._initData.enemy_teams)
	else
		self._record:initRecord(self._initData.own_teams[self._attackIndex[1]], self._initData.enemy_teams[self._attackIndex[2]])
	end

	self._action:init(self._battleData)

	if arg_17_1.atk_type == 4 then
		self._action:changeTurns(self._battleData)
	end
end

function BattleField:updateNewPlayer(arg_18_1, arg_18_2, arg_18_3)
	arg_18_3 = arg_18_3 or {}

	local var_18_0 = 3 - arg_18_1
	local var_18_1

	if self._waveType == 2 then
		if arg_18_1 == 2 then
			return false
		end

		local var_18_2 = self._attackIndex[var_18_0] + 1

		self._attackIndex[var_18_0] = self._attackIndex[var_18_0] + 1

		local var_18_3

		if var_18_0 == 1 then
			var_18_3 = self._initData.own_teams or self._initData.enemy_teams
		end

		var_18_1 = var_18_3[var_18_2]

		if not var_18_3[var_18_2] then
			return false
		end

		local var_18_4 = self._attackIndex[arg_18_1] + 1

		self._attackIndex[arg_18_1] = self._attackIndex[arg_18_1] + 1

		local var_18_5

		if arg_18_1 == 1 then
			var_18_5 = self._initData.own_teams or self._initData.enemy_teams
		end

		var_18_1 = var_18_5[var_18_4]

		if not var_18_5[var_18_4] then
			return false
		end

		self._battleData:initWarBandValue()
		self._battleData:clear(arg_18_1)
	elseif self._waveType == 3 then
		local var_18_6 = self._attackIndex[var_18_0] + 1
		local var_18_7

		if var_18_0 == 1 then
			var_18_7 = self._initData.own_teams or self._initData.enemy_teams
		end

		local var_18_8 = var_18_7[var_18_6]
		local var_18_9 = self._attackIndex[arg_18_1] + 1
		local var_18_10

		if arg_18_1 == 1 then
			var_18_10 = self._initData.own_teams or self._initData.enemy_teams
		end

		local var_18_11 = var_18_10[var_18_9]

		if not var_18_8 or not var_18_11 then
			local var_18_12
			local var_18_13
			local var_18_14

			if not var_18_8 and var_18_11 then
				var_18_12 = var_18_0
				var_18_13 = var_18_10
				var_18_14 = var_18_9
			elseif var_18_8 and not var_18_11 then
				var_18_12 = arg_18_1
				var_18_13 = var_18_7
				var_18_14 = var_18_6
			end

			if var_18_12 then
				for iter_18_0 = var_18_14, #var_18_13 do
					self._mutiResult[#self._mutiResult + 1] = 3 - var_18_12
				end
			end

			return false
		end

		self._attackIndex[var_18_0] = var_18_6
		self._attackIndex[arg_18_1] = var_18_9
		var_18_1 = var_18_11

		self._battleData:initWarBandValue()
		self._battleData:clear(arg_18_1)
	elseif self._waveType == 4 then
		local var_18_15 = self._attackIndex[var_18_0] + 1

		self._attackIndex[var_18_0] = self._attackIndex[var_18_0] + 1

		local var_18_16

		if var_18_0 == 1 then
			var_18_16 = self._initData.own_teams or self._initData.enemy_teams
		end

		var_18_1 = var_18_16[var_18_15]

		if not var_18_16[var_18_15] then
			return false
		end

		local var_18_17 = self._attackIndex[arg_18_1] + 1

		self._attackIndex[arg_18_1] = self._attackIndex[arg_18_1] + 1

		local var_18_18

		if arg_18_1 == 1 then
			var_18_18 = self._initData.own_teams or self._initData.enemy_teams
		end

		var_18_1 = var_18_18[var_18_17]

		if not var_18_18[var_18_17] then
			return false
		end

		self._battleData:initWarBandValue()
		self._battleData:clear(arg_18_1)
	else
		local var_18_19 = self._attackIndex[var_18_0] + 1

		self._attackIndex[var_18_0] = self._attackIndex[var_18_0] + 1

		local var_18_20

		if var_18_0 == 1 then
			var_18_20 = self._initData.own_teams or self._initData.enemy_teams
		end

		var_18_1 = var_18_20[var_18_19]

		if not var_18_20[var_18_19] then
			return false
		end
	end

	if not self._summaryAll then
		self._record:initRecord(self._initData.own_teams[self._attackIndex[1]], self._initData.enemy_teams[self._attackIndex[2]], self._attackIndex[1], self._attackIndex[2])
	elseif self._attackIndex[arg_18_1] == 1 and self._attackIndex[var_18_0] == 2 then
		self._record:storeRecord()
	end

	self._action:clearExtraAction()
	self._battleData:setRoundFinish(true)

	self._roundCount = 0
	self._curAttackCount = 0

	self._battleData:clear(var_18_0)

	self._aliveKnights = {}
	self._disableBeforeUpdateSkill = false

	if self._allNewWave or arg_18_2 then
		local var_18_21, var_18_22 = self._battleData:packKnightData(arg_18_1)
		local var_18_23 = self:getProfessionDict(var_18_1)
		local var_18_24 = {}

		for iter_18_1 = 1, 2 do
			local var_18_25

			if iter_18_1 == 1 then
				var_18_25 = self._initData.own_teams[self._attackIndex[1]] or self._initData.enemy_teams[self._attackIndex[2]]
			end

			local var_18_26 = self:isMonster(var_18_25)

			for iter_18_2, iter_18_3 in ipairs(var_18_1.units) do
				local var_18_27 = loadCfg("core.config.cfg." .. (var_18_26 and "monster_info" or "knight_info")).get(iter_18_3.id)

				iter_18_3.professionPassives = iter_18_3.professionPassives or var_18_26 and (var_18_23[loadCfg("core.config.cfg.knight_info").get(var_18_27.advance_id).profession] or {}) or var_18_23[var_18_27.profession] or {}

				if var_18_1.multiple then
					iter_18_3.multiple = (iter_18_3.multiple or 0) + var_18_1.multiple
				end
			end

			self:setFightKnights(var_18_25.units, iter_18_1, var_18_26, var_18_25.user, var_18_25.monster_team_id)
			self:setEnabledCommands(var_18_25.combo, iter_18_1)
			self:setSuccubaData(var_18_25.succubas, iter_18_1)

			local var_18_29 = var_18_25.total_charm or 0

			var_18_24[iter_18_1] = var_18_29

			self._battleData:setSuccubaValue(var_18_29, iter_18_1)

			if var_18_25.succubas then
				self._battleData:setSuccuba(var_18_25.succubas, iter_18_1)
			else
				self._battleData:setSuccuba({}, iter_18_1)
			end

			self._battleData:setFightValue(var_18_25.fight_value, iter_18_1)
			self._battleData:setAssist(self._initData.assistance_id)
			self._battleData:setPassiveSkills(iter_18_1, var_18_25.passive_skills)
			self._battleData:setPets(iter_18_1, var_18_25.pets)
			self._battleData:initPlayers()
			self:openingTransform(self._attackIndex[1], 1)
			self:openingTransform(self._attackIndex[2], 2)

			if arg_18_2 then
				self._battleData:setKnightHp(iter_18_1, self._initKnightsHp[iter_18_1])
			elseif iter_18_1 == arg_18_1 then
				self._battleData:setKnightHp(iter_18_1, var_18_22)
			end
		end

		local var_18_30 = loadCfg("core.config.cfg.succuba_battle_info")
		local var_18_31 = var_18_24[1] or 0
		local var_18_32 = var_18_24[2] or 0
		local var_18_33 = 0

		if var_18_32 < var_18_31 then
			var_18_33 = var_18_32 == 0 and 99999 or var_0_0.floor((var_18_31 - var_18_32) / var_18_32 * 1000)
		elseif var_18_31 ~= var_18_32 then
			var_18_33 = var_18_31 == 0 and 99999 or var_0_0.floor((var_18_32 - var_18_31) / var_18_31 * 1000)
		end

		if self._hasSuccubaCompare then
			for iter_18_4 = 1, var_18_30.getLength() do
				local var_18_34 = var_18_30.indexOf(iter_18_4)

				if var_18_33 >= var_18_34.score_low and var_18_33 < var_18_34.score_high then
					if var_18_32 < var_18_31 then
						self._battleData:addSpRule(1, nil, var_18_34.passive_skill_id, true)

						for iter_18_5, iter_18_6 in ipairs((self._battleData:getSuccubaInfo(1):getSuccubaInfo())) do
							if iter_18_6.quality >= 5 then
								self._battleData:addSpRule(1, nil, var_18_34.passive_skill_id2, true)

								break
							end
						end

						break
					end

					self._battleData:addSpRule(2, nil, var_18_34.passive_skill_id, true)

					for iter_18_7, iter_18_8 in ipairs((self._battleData:getSuccubaInfo(2):getSuccubaInfo())) do
						if iter_18_8.quality >= 5 then
							self._battleData:addSpRule(2, nil, var_18_34.passive_skill_id2, true)

							break
						end
					end

					break
				end
			end
		end

		if not arg_18_2 then
			for iter_18_9 = 1, 2 do
				local var_18_35, var_18_36 = self._battleData:packKnightData(iter_18_9)

				self._initKnightsHp[iter_18_9] = var_18_36
			end
		end

		if self._needSpecialFirst then
			self._battleData:setHighIdentity(arg_18_1)
			self._action:changeTurns(self._battleData, arg_18_1)
		elseif self._waveType == 3 or self._waveType == 4 then
			local var_18_37 = self._battleData:getHighIdentityDynamic()

			self._battleData:setHighIdentity(var_18_37)
			self._action:changeTurns(self._battleData, var_18_37)
		end

		return true
	end

	local var_18_38 = self:isMonster(var_18_1)
	local var_18_39 = var_18_1.demon_boss_multiple
	local var_18_40 = self:getProfessionDict(var_18_1)

	for iter_18_10, iter_18_11 in ipairs(var_18_1.units) do
		local var_18_41 = loadCfg("core.config.cfg." .. (var_18_38 and "monster_info" or "knight_info")).get(iter_18_11.id)

		iter_18_11.professionPassives = iter_18_11.professionPassives or var_18_38 and (var_18_40[loadCfg("core.config.cfg.knight_info").get(var_18_41.advance_id).profession] or {}) or var_18_40[var_18_41.profession] or {}

		if var_18_39 and (var_18_39.team == var_18_41.group or var_18_41.type == 1) then
			iter_18_11.multiple = var_18_39.multiple
		end

		if var_18_1.multiple then
			iter_18_11.multiple = (iter_18_11.multiple or 0) + var_18_1.multiple
		end
	end

	self._battleData:setMultiple(var_18_0, var_18_1.multiple)
	self._battleData:setElderBossBuff(var_18_0, var_18_1.elder_boss_buff or {})
	self:setFightKnights(var_18_1.units, var_18_0, var_18_38, var_18_1.user, var_18_1.monster_team_id)
	self:setEnabledCommands(var_18_1.combo, var_18_0)
	self:setSuccubaData(var_18_1.succubas, var_18_0)
	self._battleData:setFightValue(var_18_1.fight_value, var_18_0)
	self._battleData:setPassiveSkills(var_18_0, var_18_1.passive_skills)
	self._battleData:setPets(var_18_0, var_18_1.pets)
	self._battleData:initPlayers()
	self:openingTransform(self._attackIndex[var_18_0], var_18_0)

	arg_18_3.removeBuffList = {}
	arg_18_3.removeMarkList = {}

	for iter_18_12, iter_18_13 in ipairs((self._battleData:getKnightList(arg_18_1))) do
		arg_18_3.removeBuffList[iter_18_13.serialId] = iter_18_13:clearBuff()

		iter_18_13:clearPassiveSkill()
		iter_18_13:resetSpRule()

		arg_18_3.removeMarkList[iter_18_13.serialId] = iter_18_13:clearMark()

		iter_18_13:clearKnightTempValue()
	end

	return true
end

function BattleField:isAuto()
	return self._isAuto
end

function BattleField:setFightKnights(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0 = load("core.knight.KnightFactory")
	local var_20_1 = {}

	if arg_20_5 and arg_20_5 > 0 then
		local var_20_2 = loadCfg("core.config.cfg.monster_team_info").get(arg_20_5, self:getWaveInfo()[arg_20_2])
		local var_20_3 = false

		if var_20_2 then
			for iter_20_0 = 1, 6 do
				var_0_1.insert(var_20_1, var_20_2["monster_" .. iter_20_0])
			end

			var_20_3 = var_20_2.is_boss == 1
		end

		self._battleData:setIsBoss(var_20_3)
		self._battleData:getKnights():setIsBoss(var_20_3)
	end

	self._battleData:resetWarBandMaster(arg_20_2)

	for iter_20_1 = 1, #arg_20_1 do
		local var_20_4 = arg_20_1[iter_20_1].pos or 0
		local var_20_6 = var_20_0.createKnight(arg_20_1[iter_20_1], arg_20_2, arg_20_3, arg_20_4, self, (var_20_1[var_20_4] and var_20_1[var_20_4] > 0 or nil) and loadCfg("core.config.cfg.monster_info").get(var_20_1[var_20_4]))

		self._battleData:setKnightData(var_20_6, arg_20_2)

		if var_20_6.knightCfg.is_element_leader ~= 0 then
			self._battleData:setWarBandMaster(var_20_6)
		end
	end

	self._battleData:refreshAllKnightMaxQuality()
end

function BattleField:setEnabledCommands(arg_21_1, arg_21_2)
	self._battleData:initComboData(arg_21_1, arg_21_2)
	self._battleData:initComboAddData("COMBO_ATTACK", "ATTACK", arg_21_2)
	self._battleData:initComboAddData("COMBO_HP", "INITIAL_HP", arg_21_2)
	self._battleData:initComboAddData("COMBO_FINAL_DAMAGE_ADD", "FIN_DAMAGE_ADD", arg_21_2)
	self._battleData:initComboAddData("COMBO_BASE_CRIT_RATE", "CRIT_RATE", arg_21_2)
	self._battleData:initComboAddData("COMBO_BASE_CRIT_DAMAGE_ADD", "CRIT_DAMAGE_ADD", arg_21_2)
	self._battleData:initComboAddData("COMBO_BASE_DAMAGE_ADD", "DAMAGE_ADD", arg_21_2)
	self._battleData:initComboAddData("COMBO_BASE_PVP_DAMAGE_ADD", "PVP_DAMAGE_ADD", arg_21_2)
	self._battleData:initComboAddData2(arg_21_2)
end

function BattleField:checkCombo(arg_22_1)
	if self._state == BattleField.BATTLE_FINISH or self._curAttackCount == 0 then
		return false
	end

	if arg_22_1.id > 0 then
		return self._battleData:isComboSkillReady(arg_22_1.id, arg_22_1.identity)
	end

	return false
end

function BattleField:setSuccubaData(arg_23_1, arg_23_2)
	self._battleData:initSuccubaData(arg_23_1, arg_23_2)
end

function BattleField:execute(arg_24_1, arg_24_2)
	if self._state == BattleField.BATTLE_FINISH then
		BLog.LogEnd(self:getBattleResult())

		return self._state
	end

	if self._isAuto then
		arg_24_2 = nil
	end

	local var_24_0 = self._battleData

	BLog.ExecuteStart()

	local var_24_4 = var_0_7.create()

	self:addAttackCount()

	local var_24_5, var_24_6 = self._action:hasExtraAction()

	if var_24_5 then
		self._isExtraAction = true
		self._disableComboRecover = var_24_6.disableComboRecover == true
		self._disableAngerRecover = var_24_6.disableAngerRecover == true
		self._disableThreshRecover = var_24_6.disableThreshRecover == true
		self._extraActionSkillId = var_24_6.skillId or 0

		if not var_24_6.isWarBand then
			var_24_0:setCanPlayWarBand(true)
		end
	else
		self._isExtraAction = false
		self._disableComboRecover = false
		self._disableAngerRecover = false
		self._disableThreshRecover = false
		self._extraActionSkillId = 0

		var_24_0:setCanPlayWarBand(true)
	end

	self._battleData:setCurAttackerId(0)

	local var_24_7 = var_24_0:isTeamAllDead(1) or var_24_0:isTeamAllDead(2)

	if not var_24_7 then
		self._aliveKnights = var_24_0:getKnightList()
	end

	if not self._isExtraAction and (not var_24_7 or var_24_0:hasNextPassive() or var_24_0:hasNextFastPassive()) and var_24_0:getRoundFinish() then
		local var_24_8 = var_24_0:getAllKnightList()

		if self._roundCount > 0 then
			for iter_24_0, iter_24_1 in ipairs(var_24_8) do
				if not iter_24_1.isDead then
					iter_24_1:executeSpRule(var_0_10.TYPE.ROUND_END)
				end
			end

			var_24_0:executeSpRule(var_0_10.TYPE.ROUND_END)
		end

		self._roundCount = self._roundCount + 1
		self._isRoundChange = true

		if self._roundCount > 1 then
			var_24_4:addRoundCommand((var_0_8.roundStart(var_24_0)))
		end

		for iter_24_2, iter_24_3 in ipairs(var_24_8) do
			if not iter_24_3.isDead then
				iter_24_3:executeSpRule(var_0_10.TYPE.BEFORE_ROUND_START)
			end
		end

		var_24_0:executeSpRule(var_0_10.TYPE.BEFORE_ROUND_START)

		for iter_24_4, iter_24_5 in ipairs(var_24_8) do
			if not iter_24_5.isDead then
				iter_24_5:executeSpRule(var_0_10.TYPE.ROUND_START)
			end
		end

		var_24_0:executeSpRule(var_0_10.TYPE.ROUND_START)
		var_24_0:updateDelayRebornList()

		self._actionKnights = {}
	end

	local var_24_9
	local var_24_10 = true

	if not self._isExtraAction and not var_24_7 and not arg_24_2 and self._attackCount > 0 then
		arg_24_2 = self._auto:checkMySuccubaAuto(var_24_0)
		arg_24_2 = arg_24_2 or self._isVideo and self._videoCommands[self._attackCount] or self._auto:checkAuto(var_24_0)
	end

	if self._succubaCompareSkillId ~= 0 then
		local var_24_12 = 1

		if self._succubaCompareSkillId < 0 then
			self._succubaCompareSkillId = -self._succubaCompareSkillId
			var_24_12 = 2
		end

		self._curAttackCount = self._curAttackCount + 1
		var_24_9 = var_0_6.createPlayerCommand({
			serialExId = 1,
			isSuccubaCompare = true,
			id = self._succubaCompareSkillId,
			identity = var_24_12,
			attack_count = self._attackCount,
			battleData = var_24_0
		})
		self._succubaCompareSkillId = 0
	elseif arg_24_2 and arg_24_2.id > 0 then
		if arg_24_2.type == var_0_9.AUTO_TYPE.SUCCUBA then
			if not var_24_0:isSuccubaSkillReady(arg_24_2.id, arg_24_2.identity) then
				return BattleField.BATTLE_FAILURE
			end

			self._curAttackCount = self._curAttackCount + 1
			var_24_9 = var_0_6.createPlayerCommand({
				isSuccuba = true,
				serialExId = 1,
				id = arg_24_2.id,
				identity = arg_24_2.identity,
				attack_count = self._attackCount,
				battleData = var_24_0
			})

			BLog.LogSuccubaSkill(arg_24_2)
		else
			if not var_24_0:isComboSkillReady(arg_24_2.id, arg_24_2.identity) then
				return BattleField.BATTLE_FAILURE
			end

			self._curAttackCount = self._curAttackCount + 1

			local var_24_13 = var_0_6.createPlayerCommand({
				id = arg_24_2.id,
				identity = arg_24_2.identity,
				attack_count = self._attackCount,
				battleData = var_24_0
			})

			var_24_9 = var_24_13

			var_0_2(self._playerCommands, var_24_13)
			BLog.LogComboSkill(arg_24_2)
		end
	else
		self._curAttackCount = self._curAttackCount + 1

		local var_24_14 = var_24_0:getNextFastPassive() or var_24_0:getNextPassive()

		if var_24_14 then
			var_24_10 = false

			if var_24_14.assist then
				var_24_4:addAssist()
			else
				local var_24_15 = var_0_4.fightPassive(var_24_14, var_24_0, self)

				if var_24_15 then
					var_24_15:update()
					var_24_4:addFightCommand(var_24_15)
				end
			end
		else
			local var_24_16

			if not self._disableBeforeUpdateSkill then
				self._action:getNextKnight():executeSpRule(var_0_10.TYPE.BEFORE_UPDATE)

				if self._isRoundChange then
					var_24_0:executeKnightSpRule(var_0_10.TYPE.AFTER_ROUND_START)

					self._isRoundChange = false
				end

				var_24_16 = var_24_0:getNextFastPassive()
				var_24_16 = var_24_16 or var_24_0:getNextPassive()
			end

			if var_24_16 then
				var_24_10 = false

				local var_24_17 = var_0_4.fightPassive(var_24_16, var_24_0, self)

				if var_24_17 then
					var_24_17:update()
					var_24_4:addFightCommand(var_24_17)
				end

				self._disableBeforeUpdateSkill = true
			else
				self._disableBeforeUpdateSkill = false

				local var_24_19

				var_24_9, var_24_19 = self._action:next()

				if not self._isExtraAction then
					self._actionCount[var_24_9.identity] = self._actionCount[var_24_9.identity] + 1
				end

				local var_24_20

				var_24_10, var_24_20 = var_0_5.update(var_24_9, var_24_0, self, var_24_19.isWarBand)

				if var_24_20 then
					var_24_4:addUpdateCommand(var_24_20)
				end
			end
		end
	end

	if var_24_10 then
		BLog.LogAttackKnight(var_24_9)

		local var_24_21 = {}

		if not var_24_9.isPlayer then
			self._battleData:setCurAttackerId(var_24_9.serialId)
			var_24_9:executeSpRule(var_0_10.TYPE.BEFORE_SKILL)

			local var_24_22 = var_24_0:getNextFastPassive()

			if var_24_22 then
				local var_24_23 = var_0_4.fightPassive(var_24_22, var_24_0, self)

				if var_24_23 then
					var_24_21[#var_24_21 + 1] = var_24_23
				end
			end
		end

		local var_24_24 = var_0_4.fight(var_24_9, var_24_0, self)

		self:addIdentityAttackCount(var_24_9.identity)

		local var_24_25 = var_24_0:getNextFastPassive()
		local var_24_26 = {}

		var_0_10.disable = true

		while var_24_25 do
			local var_24_27 = var_0_4.fightPassive(var_24_25, var_24_0, self)

			if var_24_27 then
				var_24_26[#var_24_26 + 1] = var_24_27
			end

			var_24_25 = var_24_0:getNextFastPassive()
		end

		var_0_10.disable = false

		for iter_24_6, iter_24_7 in ipairs(var_24_21) do
			iter_24_7:update()
			var_24_4:addFightCommand(iter_24_7, true)
		end

		var_24_24:update()
		var_24_4:addFightCommand(var_24_24)

		for iter_24_8, iter_24_9 in ipairs(var_24_26) do
			iter_24_9:update()
			var_24_4:addFightCommand(iter_24_9, true)
		end
	elseif var_24_9 then
		var_24_4:addNotReadyCommand((var_0_5.updateNotReady(var_24_9, self)))
	end

	if var_24_9 and var_24_9.isSuccuba then
		var_24_0:executeSpRule(var_0_10.TYPE.AFTER_SUCCUBA_SKILL, {
			identity = var_24_9.identity,
			attacker = var_24_9
		})
	end

	if var_24_9 and not var_24_9.isPlayer then
		var_24_0:executeSpRule(var_0_10.TYPE.ACTION, {
			identity = var_24_9.identity,
			attacker = var_24_9,
			isExAction = self._isExtraAction
		})
		var_24_0:executeKnightSpRule(var_0_10.TYPE.ACTION, {
			identity = var_24_9.identity,
			attacker = var_24_9,
			isExAction = self._isExtraAction,
			isActionSucc = var_24_10
		})

		if not self._isExtraAction then
			var_0_1.insert(self._actionKnights, var_24_9.serialId)
		end
	end

	local var_24_28 = var_24_0:getNextFastPassive()

	while var_24_28 do
		local var_24_29 = {}

		var_0_10.disable = true

		while var_24_28 do
			local var_24_30 = var_0_4.fightPassive(var_24_28, var_24_0, self)

			if var_24_30 then
				var_24_29[#var_24_29 + 1] = var_24_30
			end

			var_24_28 = var_24_0:getNextFastPassive()
		end

		var_0_10.disable = false

		for iter_24_10, iter_24_11 in ipairs(var_24_29) do
			iter_24_11:update()
			var_24_4:addFightCommand(iter_24_11, true)
		end

		var_24_28 = var_24_0:getNextFastPassive()
	end

	if not var_24_0:hasNextPassive() then
		local var_24_31 = {
			var_24_0:isTeamAllDead(1),
			var_24_0:isTeamAllDead(2)
		}

		if var_24_31[1] or var_24_31[2] then
			for iter_24_12, iter_24_13 in ipairs(self._aliveKnights) do
				if var_24_31[iter_24_13.identity] then
					iter_24_13:executeSpRule(var_0_10.TYPE.ALL_DEAD)
				end
			end
		end
	end

	var_24_0:executeSpRule(var_0_10.TYPE.ATTACK_COUNT, {
		attacker = var_24_9
	})
	var_24_4:addUpdateAfterAttackCommand((var_0_5.updateAfterAttack(var_24_9, var_24_0, self)))

	local var_24_32 = self._action:checkFinish()
	local var_24_33, var_24_34, var_24_35 = var_24_0:isGameOver(self._roundCount)

	if var_24_32 and not var_24_33 then
		var_24_33, var_24_34, var_24_35 = var_24_0:isGameOver(self._roundCount + 1)
	end

	var_24_0:setRoundFinish(var_24_32)
	self:_addCommand(var_24_4)

	local var_24_36 = false
	local var_24_37 = {}

	for iter_24_14, iter_24_15 in ipairs(self._restartInfos) do
		if not self._restartedIdentity[iter_24_15.identity] then
			var_24_36 = true

			var_0_1.insert(var_24_37, iter_24_15)

			if iter_24_15.skillImageId > 0 then
				self:setOpeningTransform(self:getAttackIndex(iter_24_15.identity), iter_24_15.knightSerialId, iter_24_15.skillImageId)
			end

			self._restartedIdentity[iter_24_15.identity] = true
		end
	end

	local var_24_38 = false

	if var_24_36 then
		var_24_4:addRestart(var_24_37)
		self:restart()

		self._state = BattleField.BATTLE_FIGHTING
	elseif var_24_33 then
		self._roundList[#self._roundList + 1] = self._roundCount
		self._mutiResult[#self._mutiResult + 1] = var_24_35 and 3 or var_24_34 == 1 and 1 or 2

		local var_24_39, var_24_40 = self._battleData:packKnightData(1)
		local var_24_41, var_24_42 = self._battleData:packKnightData(2)

		var_0_1.insert(self._mutiUnits, {
			own_units = var_24_40,
			enemy_units = var_24_42
		})

		local var_24_43 = self._roundCount
		local var_24_44 = {}

		if not self:updateNewPlayer(var_24_34, nil, var_24_44) then
			if self._waveType == 3 or self._waveType == 4 then
				local var_24_45 = {
					0,
					0,
					0
				}

				for iter_24_16, iter_24_17 in ipairs(self._mutiResult) do
					var_24_45[iter_24_17] = var_24_45[iter_24_17] + 1
				end

				var_24_34 = var_24_45[1] > var_24_45[2] and 1 or 2
			end

			var_24_4:setGameOver(var_24_34)

			self._state = BattleField.BATTLE_FINISH
			self._winner = var_24_34

			local var_24_46 = self._initData.own_teams[self._attackIndex[1]] or self._initData.own_teams[self._attackIndex[1] - 1]
			local var_24_47 = self._initData.enemy_teams[self._attackIndex[2]] or self._initData.enemy_teams[self._attackIndex[2] - 1]

			self._record:setWinInfo(var_24_34, var_24_46.user and var_24_46.user.name, var_24_47.user and var_24_47.user.name)
		else
			var_24_38 = true

			var_24_4:setWaveOver(var_24_34)
			var_24_4:addNextWave(var_24_44)
			self._action:reset()

			self._state = BattleField.BATTLE_FIGHTING
		end

		if self._state == BattleField.BATTLE_FIGHTING then
			local var_24_48, var_24_49 = self._battleData:packKnightData()

			self._storedKnightsHp = var_24_49
			self._storedKnightsHp.round = var_24_43

			if self._recoverIndex > 0 then
				if self._recoverList[self._recoverIndex] and self._recoverList[self._recoverIndex] > 0 then
					var_24_4:setWaveRecover((self._battleData:recoverKnightsHp(var_24_34, self._recoverList[self._recoverIndex])))
				end

				self._recoverIndex = self._recoverIndex + 1
			end
		end
	else
		self._state = BattleField.BATTLE_FIGHTING
	end

	if var_24_9 and var_24_9.knightCfg and var_24_9.knightCfg.advance_id and var_24_9.identity and var_24_9.identity == 1 then
		var_0_12 = var_24_9.knightCfg.advance_id
		var_0_13 = var_24_9.baseData.skin
	end

	self._isExtraAction = false
	self._disableComboRecover = false
	self._disableAngerRecover = false
	self._disableThreshRecover = false
	self._extraActionSkillId = 0
	self._restartInfos = {}

	BLog.ExecuteEnd()

	return self._state, not arg_24_1 and var_24_4:pack() or nil, var_24_38
end

function BattleField:getState()
	return self._state
end

function BattleField:executeExtraAction()
	local var_26_0 = BattleField.BATTLE_FIGHTING
	local var_26_1 = self:hasExtraAction()

	repeat
		if var_26_1 then
			var_26_0 = self:execute(true)
		end

		var_26_1 = self:hasExtraAction()
	until not var_26_1 or var_26_0 ~= BattleField.BATTLE_FIGHTING
end

function BattleField:getPlayerCommands()
	local var_27_0 = {}

	for iter_27_0 = 1, #self._playerCommands do
		var_0_2(var_27_0, (self._playerCommands[iter_27_0]:pack()))
	end

	return var_27_0
end

function BattleField:executeAll(arg_28_1, arg_28_2)
	self:setVideoInfo(arg_28_1)

	repeat
		-- block empty
	until self:execute(true) ~= BattleField.BATTLE_FIGHTING

	local var_28_2 = {
		ret = (self._record:getAttackerDamage() ~= arg_28_2 or nil) and 226,
		isWin = self._winner == 1
	}

	var_28_2.hps1, var_28_2.knights1 = self._battleData:packKnightData(1)
	var_28_2.hps2, var_28_2.knights2 = self._battleData:packKnightData(2)

	return var_28_2
end

function BattleField:autoExecuteAll()
	repeat
		-- block empty
	until self:execute(true) ~= BattleField.BATTLE_FIGHTING
end

function BattleField:getStoredKnightsHp()
	return self._storedKnightsHp
end

function BattleField:autoExecuteWave()
	local var_31_2

	repeat
		local var_31_3, var_31_4

		var_31_3, var_31_2, var_31_4 = self:execute(false)
	until var_31_3 ~= BattleField.BATTLE_FIGHTING or var_31_4

	return var_31_2
end

function BattleField:getBattleResult()
	local var_32_0 = self._battleData:isBattleError()
	local var_32_1 = {
		is_win = self._winner == 1,
		battle_id = self._battleId,
		command = self:getPlayerCommands()
	}
	local var_32_2, var_32_3 = self._battleData:packKnightData(1)
	local var_32_4, var_32_5 = self._battleData:packKnightData(2)

	var_32_1.is_report = var_32_0
	var_32_1.units1 = var_32_3
	var_32_1.units2 = var_32_5
	var_32_1.round = self._roundCount
	var_32_1.result = self:getExtraResult()

	if self._winner == 1 then
		var_32_1.cur_own_wave = self._attackIndex[1] or self._attackIndex[1] - 1
	end

	if self._winner == 1 then
		var_32_1.cur_enemy_wave = self._attackIndex[2] - 1 or self._attackIndex[2]
	end

	var_32_1.data_version = var_0_3(loadCfg("core.config.cfg.version"))

	local var_32_6 = self._record:getRecordNormal()
	local var_32_7 = self._record:getWinInfo()

	var_32_1.own_name = var_32_7.own_name
	var_32_1.enemy_name = var_32_7.enemy_name
	var_32_1.own_teams = var_32_6[1]
	var_32_1.enemy_teams = var_32_6[2]
	var_32_1.attack_total_damage = self._record:getAttackerDamage()
	var_32_1.multi_result = self._mutiResult
	var_32_1.wave_units = self._mutiUnits

	if self:getBattlePlayId() == var_0_9.ServerPlayId.DEMON_BOSS and loadCfg("core.config.cfg.parameter_info").get(5100001).parameter / 1000 < var_32_1.attack_total_damage / self._battleData:getFightValue(1) then
		var_32_1.is_report = var_0_9.ERROR_ID.DAMAGE_ERROR
	end

	return var_32_1
end

function BattleField:getBattleId()
	return self._battleId
end

function BattleField:getExtraResult()
	if not self._winCondition or self._winCondition == 0 then
		return
	end

	local var_34_0 = loadCfg("core.config.cfg.battle_rating_info").get(self._winCondition)

	if not var_34_0 then
		return 0
	end

	local var_34_1 = var_34_0.rating_type

	if var_34_0.rating_type == 0 then
		return 0
	end

	if var_34_1 == 4 then
		return self._roundCount
	elseif var_34_1 == 5 then
		local var_34_2 = 0

		for iter_34_0, iter_34_1 in self._battleData:getKnights():ipairs(1) do
			if iter_34_1.isDead then
				var_34_2 = var_34_2 + 1
			end
		end

		return var_34_2
	elseif var_34_1 == 6 then
		local var_34_3 = 0
		local var_34_4 = 0

		for iter_34_2, iter_34_3 in self._battleData:getKnights():ipairs(1) do
			var_34_3 = var_34_3 + iter_34_3.advanceInfo.INITIAL_HP
			var_34_4 = var_34_4 + iter_34_3.originInfo.INITIAL_HP
		end

		return var_0_0.floor(var_34_3 * 100 / var_34_4)
	elseif var_34_1 == 7 then
		if self._winner == 1 then
			local var_34_5 = false

			for iter_34_4, iter_34_5 in self._battleData:getKnights():ipairs(1) do
				if iter_34_5.advanceInfo.INITIAL_HP > 0 then
					var_34_5 = true

					break
				end
			end

			if var_34_5 then
				return var_34_0.rating_value
			else
				return self._roundCount
			end
		else
			return self._roundCount - 1
		end
	elseif var_34_1 == 8 then
		local var_34_6 = 0
		local var_34_7 = 0

		for iter_34_6, iter_34_7 in self._battleData:getKnights():ipairs(2) do
			var_34_6 = var_34_6 + iter_34_7.advanceInfo.INITIAL_HP
			var_34_7 = var_34_7 + iter_34_7.originInfo.INITIAL_HP
		end

		return var_0_0.floor((var_34_7 - var_34_6) * 100 / var_34_7)
	elseif var_34_1 == 9 then
		return self._attackIndex[2] - 1
	elseif var_34_1 == 10 then
		local var_34_8 = 0
		local var_34_9 = 0

		for iter_34_8, iter_34_9 in self._battleData:getKnights():ipairs(2) do
			var_34_8 = var_34_8 + iter_34_9.advanceInfo.INITIAL_HP
			var_34_9 = var_34_9 + iter_34_9.originInfo.INITIAL_HP
		end

		return var_0_0.max(0, var_0_0.floor((var_34_9 - var_34_8) * 100 / var_34_9))
	end

	return 0
end

function BattleField:getAttackCount()
	return self._attackCount
end

function BattleField:getRoundCount()
	return self._roundCount
end

function BattleField:getCommands()
	return self._commands
end

function BattleField:getWinner()
	return self._winner
end

function BattleField:getBattleData()
	return self._battleData
end

function BattleField:getRoundList()
	return self._roundList
end

function BattleField:getMultiResult()
	return self._mutiResult
end

function BattleField:setAuto(arg_42_1)
	if self._isAuto then
		return
	end

	self._auto:setAuto(1, arg_42_1)
end

function BattleField:_dispatchEvent()
	for iter_43_0, iter_43_1 in pairs(self._listeners) do
		iter_43_1(..., self)
	end
end

function BattleField:_addCommand(arg_44_1)
	var_0_1.insert(self._commands, arg_44_1)
end

function BattleField:setInitDataBytes(arg_45_1)
	self:setInitData((load("core.proto.ProtoBuilder"):decodeByMsgName("BattleReport", arg_45_1)))
end

function BattleField:checkResultBytes(arg_46_1)
	return load("core.proto.ProtoBuilder"):encodeByMsgName("CheckResult", (self:checkResult((load("core.proto.ProtoBuilder"):decodeByMsgName("BattleResult", arg_46_1)))))
end

function BattleField:checkResult(arg_47_1)
	local var_47_1 = self:executeAll(arg_47_1.command or {}, arg_47_1.attack_total_damage)
	local var_47_2 = true and var_47_1.isWin == arg_47_1.is_win

	if rawget(arg_47_1, "units1") then
		for iter_47_0 = 1, #arg_47_1.units1 do
			var_47_2 = var_47_2 and arg_47_1.units1[iter_47_0].hp - var_47_1.hps1[(arg_47_1.units1[iter_47_0].identity - 1) * 10 + arg_47_1.units1[iter_47_0].pos] == 0
		end
	end

	if rawget(arg_47_1, "units2") then
		for iter_47_1 = 1, #arg_47_1.units2 do
			var_47_2 = var_47_2 and arg_47_1.units2[iter_47_1].hp - var_47_1.hps2[(arg_47_1.units2[iter_47_1].identity - 1) * 10 + arg_47_1.units2[iter_47_1].pos] == 0
		end
	end

	var_47_2 = var_47_2 and self:getExtraResult() == arg_47_1.result

	local var_47_3 = var_47_1.ret or 1
	local var_47_4 = "0"

	if not var_47_2 then
		var_47_4 = var_0_3(loadCfg("core.config.cfg.version"))
		var_47_3 = var_47_4 ~= arg_47_1.data_version and 1001 or 1000
	end

	return {
		battle_id = arg_47_1.battle_id,
		check = var_47_2,
		is_win = var_47_1.isWin,
		units1 = var_47_1.knights1,
		units2 = var_47_1.knights2,
		ret = var_47_3,
		data_version = var_47_4
	}
end

function BattleField:getBattleResultByte()
	return load("core.proto.ProtoBuilder"):encodeByMsgName("BattleResult", (self:getBattleResult()))
end

function BattleField:getAutoResultByte()
	self:setAuto(true)
	self:executeAll({})

	return self:getBattleResultByte()
end

function BattleField:getWave()
	return self._attackIndex[2] - 1
end

function BattleField:getWaveInfo()
	return self._attackIndex
end

function BattleField:setVideoInfo(arg_52_1)
	local var_52_0 = {}

	for iter_52_0, iter_52_1 in ipairs(arg_52_1) do
		var_52_0[iter_52_1.attack_count] = iter_52_1
	end

	self._videoCommands = var_52_0
	self._isVideo = true
end

function BattleField:getNextKnight()
	local var_53_0 = self._action:getNextKnight()

	if var_53_0 then
		return var_53_0.serialId
	end
end

function BattleField:getActionCount(arg_54_1)
	return self._actionCount[arg_54_1]
end

function BattleField:getAttackIndex(arg_55_1)
	return self._attackIndex[arg_55_1]
end

function BattleField:addExtraAction(arg_56_1)
	self._action:addExtraAction(arg_56_1)
end

function BattleField:hasExtraAction()
	return self._action:hasExtraAction()
end

function BattleField:isExtraAction()
	return self._isExtraAction
end

function BattleField:isDisableComboRecover()
	return self._disableComboRecover
end

function BattleField:isDisableAngerRecover()
	return self._disableAngerRecover
end

function BattleField:isDisableThreshRecover()
	return self._disableThreshRecover
end

function BattleField:getExtraActionSkillId()
	return self._extraActionSkillId
end

function BattleField:addRestartInfo(arg_63_1, arg_63_2, arg_63_3)
	var_0_2(self._restartInfos, {
		identity = arg_63_1,
		knightSerialId = arg_63_2,
		skillImageId = arg_63_3
	})
end

function BattleField:setOpeningTransform(arg_64_1, arg_64_2, arg_64_3)
	self._openingTransform[arg_64_1 .. "_" .. arg_64_2] = arg_64_3
end

function BattleField:getOpeningTransform(arg_65_1, arg_65_2)
	return self._openingTransform[arg_65_1 .. "_" .. arg_65_2]
end

function BattleField:openingTransform(arg_66_1, arg_66_2)
	for iter_66_0, iter_66_1 in ipairs((self._battleData:getKnightList(arg_66_2))) do
		local var_66_0 = self:getOpeningTransform(arg_66_1, iter_66_1.serialId)

		if var_66_0 then
			iter_66_1:transform((loadCfg("core.config.cfg.skill_image_info").get(var_66_0)))
		end
	end
end

function BattleField:getStoredRecord()
	return self._record:getStoredRecord()
end

function BattleField:getAllNewWave()
	return self._allNewWave
end

function BattleField:getActionKnights()
	return self._actionKnights
end

function BattleField:getLastBeatKnightAdvanceId()
	return var_0_12, var_0_13
end

function BattleField:resetCheckRecord()
	self._record:resetCheckRecord()
end

function BattleField:addCheckRecord(arg_72_1)
	self._record:addCheckRecord({
		attackCount = self._attackCount,
		knightData = self._battleData:packCheckKnightData(),
		commands = arg_72_1
	})
end

function BattleField:getCheckRecord()
	return self._record:getCheckRecord()
end

function BattleField:checkExecuteAll()
	self:resetCheckRecord()

	repeat
		local var_74_2, var_74_3 = self:execute()

		self:addCheckRecord(var_74_3)
	until var_74_2 ~= BattleField.BATTLE_FIGHTING
end

function BattleField:getCurAttackIndex()
	return self._action:getCurAttackIndex()
end

function BattleField:getBattlePlayId()
	return self._playId
end

function BattleField:setIsTestFight()
	self._isTestFight = true
end

function BattleField:isTestFight()
	return self._isTestFight
end

function BattleField:getProfessionDict(arg_79_1)
	local var_79_0 = {}
	local var_79_1 = loadCfg("core.config.cfg.profession_passive_info")

	for iter_79_0, iter_79_1 in ipairs(arg_79_1.profession_passive_skills or {}) do
		local var_79_2 = var_79_1.get(iter_79_1)

		var_79_0[var_79_2.profession] = var_79_0[var_79_2.profession] or {}

		var_0_1.insert(var_79_0[var_79_2.profession], var_79_2.passive_skill_id)
	end

	return var_79_0
end

function BattleField:isMonster(arg_80_1)
	return arg_80_1.monster_team_id and (not arg_80_1.monster_team_type or arg_80_1.monster_team_type == 0) and arg_80_1.monster_team_id > 0 and self:getBattlePlayId() ~= var_0_9.ServerPlayId.EXPLORATION_BOSS
end

function BattleField:addAttackCount()
	self._attackCount = self._attackCount + 1

	self._battleData:resetAttackCountData()
	BLog.LogAttackRound(self._attackCount, self._roundCount)
end

function BattleField:isHasSuccuba()
	return self._hasSuccuba and self._hasSuccubaCompare
end

function BattleField:getTotalDamage()
	return self._record:getAttackerDamage()
end

return BattleField
