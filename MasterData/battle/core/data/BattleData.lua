local var_0_0 = math
local var_0_1 = math.floor
local var_0_2 = table
local var_0_3 = table.insert
local var_0_4 = table.remove
local BattleData = class("BattleData")
local var_0_6 = load("const.BattleAttrRe")
local var_0_7 = load("const.BattleAttr")
local var_0_8 = load("core.data.KnightsData")
local var_0_9 = load("core.data.PassiveData")
local var_0_10 = load("core.Parameters")
local var_0_11 = load("core.data.SceneData")
local var_0_12 = load("core.data.PlayerData")
local var_0_13 = load("const.BattleConst")
local var_0_14 = load("core.data.PetsData")
local var_0_15 = load("core.data.SkillSummonData")
local var_0_16 = load("core.rule.BuffRule")
local var_0_17 = loadCfg("core.config.cfg.skill_info")
local var_0_18 = load("core.rule.SkillSpecialRule")
local var_0_19 = loadCfg("core.config.cfg.knight_attributelv_info")
local var_0_20 = {
	BLOCK_RATE = "ELEMENTAL_1505",
	CRIT_DAMAGE_DEC = "ELEMENTAL_1510",
	CRIT_DAMAGE_ADD = "ELEMENTAL_1509",
	CRIT_RATE = "ELEMENTAL_1503",
	PIERCE_RATE = "ELEMENTAL_1506",
	BLOCK_DAMAGE_ADD = "ELEMENTAL_1507",
	ACCURACY_RATE = "ELEMENTAL_1501",
	BLOCK_DAMAGE_DEC = "ELEMENTAL_1508",
	HARDEN_RATE = "ELEMENTAL_1504",
	DODGE_RATE = "ELEMENTAL_1502"
}

function BattleData:create()
	return BattleData.new(self)
end

function BattleData:ctor(arg_2_1)
	self._knights = var_0_8.create()
	self._hasFrontSkill = true
	self._comboData = {}
	self._succubaData = {}
	self._fightValue = {}
	self._isPvp = false
	self._isRobot = false
	self._firstAttackId = 0
	self._roundFinish = true
	self._conditionCheck = nil
	self._multiples = {
		1000,
		1000
	}
	self._passiveSkills = {}
	self._spRules = {
		{},
		{}
	}
	self._passiveData = var_0_9.create()
	self._fastPassiveData = var_0_9.create()
	self._energyEffects = {}
	self._skillSummons = {
		{},
		{}
	}
	self._scenes = {}
	self._pets = {
		{},
		{}
	}
	self._petQualitySuppressData = {}
	self._players = {}
	self._battleField = arg_2_1
	self._rebornAttackCount = 0
	self._reborns = {}
	self._comboInherit = true
	self._highIdentity = 0
	self._multiShield = {
		{},
		{}
	}
	self._selfKnightSkillNum = {
		{},
		{}
	}
	self._firstDeadKnight = {
		0,
		0
	}
	self._firstDeadKnightOrder = {
		{},
		{}
	}
	self._randomTargetData = {
		{},
		{}
	}
	self._victoryMode = 0
	self._shareBuffEff = {
		{},
		{}
	}
	self._moodBuffTick = {
		0,
		0
	}
	self._moodBuffTickIds = {
		{},
		{}
	}
	self._isBattleErrorFlag = 0
	self._curAttackerSerialId = 0
	self._buff267TotalDamage = {}
	self._debugBuff267ChangeDamageData = {}
	self._buff420TotalDamage = {}
	self._debugBuff420ChangeDamageData = {}
	self._buff635TotalDamage = {}
	self._debugBuff635ChangeDamageData = {}
	self._buff641TotalCnt = {
		0,
		0
	}
	self._buff645TotalCnt = {
		0,
		0
	}
	self._buff656TotalCnt = {
		0,
		0
	}
	self._specialBuffCnt = {
		{},
		{}
	}
	self._specialBuffCntFirstAddRound = {
		{},
		{}
	}
	self._buff648TotalDamage = {}
	self._buff672SiphonMap = {
		{},
		{}
	}
	self._resultEffectDic = {}
	self._spBuffRefInfoDic = {}
	self._nearList = {
		{
			2,
			4,
			5,
			3,
			6
		},
		{
			1,
			3,
			5,
			4,
			6
		},
		{
			2,
			6,
			5,
			1,
			4
		},
		{
			1,
			5,
			2,
			6,
			3
		},
		{
			4,
			6,
			2,
			1,
			3
		},
		{
			5,
			3,
			2,
			4,
			1
		}
	}
	self._delayRebornList = {}
	self._delayRebornEffDict = {}
	self._curDeadNumDict = {}
	self._succubaValue = {
		0,
		0
	}
	self._succuba = {
		{},
		{}
	}
	self._buffEffTickDict = {}
	self._qsValueRate = 1000
	self._qualityLevelRate = 1000
	self._allKnightMaxQuality = 0
	self._elderData = {}
	self._isBoss = false
	self._warBanMaster = {}
	self._warBanValueData = {}
	self._teamWarBandCanPlay = true
end

function BattleData:setIsPvp(arg_3_1)
	self._isPvp = arg_3_1
end

function BattleData:getIsPvp()
	return self._isPvp
end

function BattleData:setIsRobot(arg_5_1)
	self._isRobot = arg_5_1
end

function BattleData:getIsRobot()
	return self._isRobot
end

function BattleData:setFirstAttackId(arg_7_1)
	self._firstAttackId = arg_7_1
end

function BattleData:getFirstAttackId()
	return self._firstAttackId
end

function BattleData:setMultiples(arg_9_1)
	self._multiples = arg_9_1
end

function BattleData:getMultiples(arg_10_1)
	return self._multiples[arg_10_1]
end

function BattleData:setSpRules(arg_11_1)
	self._spRules = arg_11_1
end

function BattleData:getSpRules()
	return self._spRules
end

function BattleData:getPet(arg_13_1)
	return self._pets[arg_13_1]
end

function BattleData:getKnights()
	return self._knights
end

function BattleData:setKnightData(arg_15_1, arg_15_2)
	self._knights:setKnightData(arg_15_1, arg_15_2)

	self._delayRebornEffDict[arg_15_1.serialId] = nil
end

function BattleData:refreshAllKnightMaxQuality()
	self._allKnightMaxQuality = self._knights:getAllKnightMaxQuality()
end

function BattleData:getKnightData(arg_17_1)
	return self._knights:getKnightData(arg_17_1)
end

function BattleData:getKnightList(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in self._knights:ipairs(arg_18_1) do
		if arg_18_2 or iter_18_1:isValid(arg_18_3) then
			var_0_3(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function BattleData:getKnightMap(arg_19_1, arg_19_2)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in self._knights:ipairs(arg_19_1) do
		if iter_19_1:isValid() or arg_19_2 then
			var_19_0[iter_19_1.serialId] = iter_19_1
		end
	end

	return var_19_0
end

function BattleData:getAllKnightList()
	local var_20_0 = {}
	local var_20_1 = self:getHighIdentity()

	for iter_20_0, iter_20_1 in self._knights:ipairs(var_20_1) do
		var_0_3(var_20_0, iter_20_1)
	end

	for iter_20_2, iter_20_3 in self._knights:ipairs(3 - var_20_1) do
		var_0_3(var_20_0, iter_20_3)
	end

	return var_20_0
end

function BattleData:getAllKnightListTarget(arg_21_1, arg_21_2)
	local var_21_0 = {}
	local var_21_1 = self:getHighIdentity()

	for iter_21_0, iter_21_1 in self._knights:ipairs(var_21_1) do
		if iter_21_1:isValid(arg_21_2) or arg_21_1 then
			var_0_3(var_21_0, iter_21_1)
		end
	end

	for iter_21_2, iter_21_3 in self._knights:ipairs(3 - var_21_1) do
		if iter_21_3:isValid(arg_21_2) or arg_21_1 then
			var_0_3(var_21_0, iter_21_3)
		end
	end

	return var_21_0
end

function BattleData:getKnightByIdAndPos(arg_22_1, arg_22_2)
	return self._knights:getKnightByIdAndPos(arg_22_1, arg_22_2)
end

function BattleData:getNearKnight(arg_23_1, arg_23_2, arg_23_3)
	for iter_23_0, iter_23_1 in ipairs(self._nearList[arg_23_2]) do
		local var_23_0 = self:getKnightByIdAndPos(arg_23_1, iter_23_1)

		if var_23_0 and var_23_0:isValid(arg_23_3) then
			return var_23_0
		end
	end
end

function BattleData:getNearKnightList(arg_24_1)
	local var_24_0 = {}
	local var_24_1 = {}

	if arg_24_1.originInfo.pos ~= 4 then
		var_24_1[#var_24_1 + 1] = arg_24_1.originInfo.pos - 1
	end

	var_24_1[#var_24_1 + 1] = arg_24_1.originInfo.pos + 3

	if arg_24_1.originInfo.pos ~= 3 then
		var_24_1[#var_24_1 + 1] = arg_24_1.originInfo.pos + 1
	end

	var_24_1[#var_24_1 + 1] = arg_24_1.originInfo.pos - 3

	for iter_24_0 = 1, #var_24_1 do
		local var_24_2 = self._knights:getKnightByIdAndPos(arg_24_1.identity, var_24_1[iter_24_0])

		if var_24_2 and var_24_2:isValid() then
			var_0_3(var_24_0, var_24_2)
		end
	end

	return var_24_0
end

function BattleData:initComboData(arg_25_1, arg_25_2)
	self._comboData[arg_25_2] = self._comboInherit and load("core.data.ComboData").create(arg_25_1, self._comboData[arg_25_2]) or load("core.data.ComboData").create(arg_25_1)

	if arg_25_2 == 2 then
		self._comboData[2]:setIsBoss(self._isBoss)
	end
end

function BattleData:initSuccubaData(arg_26_1, arg_26_2)
	self._succubaData[arg_26_2] = load("core.data.SuccubaData").create(arg_26_1)
end

function BattleData:setComboInherit(arg_27_1)
	self._comboInherit = arg_27_1
end

function BattleData:isComboInherit()
	return self._comboInherit
end

function BattleData:getComboInfo(arg_29_1)
	return self._comboData[arg_29_1]
end

function BattleData:getSuccubaInfo(arg_30_1)
	return self._succubaData[arg_30_1]
end

function BattleData:updateComboValue(arg_31_1, arg_31_2, arg_31_3)
	return self._comboData[arg_31_2]:updateComboValue(arg_31_1, arg_31_3)
end

function BattleData:updateSuccubaValue(arg_32_1, arg_32_2, arg_32_3)
	return self._succubaData[arg_32_2]:updateSuccubaValue(arg_32_1, arg_32_3)
end

function BattleData:hasComboSkill(arg_33_1, arg_33_2)
	return self._comboData[arg_33_2]:hasSkill(arg_33_1)
end

function BattleData:hasSuccubaSkill(arg_34_1, arg_34_2)
	return self._succubaData[arg_34_2]:hasSkill(arg_34_1)
end

function BattleData:updateComboSkills(arg_35_1)
	return {
		self._comboData[1]:updateSkills(arg_35_1),
		(self._comboData[2]:updateSkills(arg_35_1))
	}
end

function BattleData:updateSuccubaSkills(arg_36_1)
	return {
		self._succubaData[1]:updateSkills(arg_36_1),
		(self._succubaData[2]:updateSkills(arg_36_1))
	}
end

function BattleData:useComboSkill(arg_37_1, arg_37_2)
	return self._comboData[arg_37_2]:useSkill(arg_37_1)
end

function BattleData:useSuccubaSkill(arg_38_1, arg_38_2)
	return self._succubaData[arg_38_2]:useSkill(arg_38_1)
end

function BattleData:isComboSkillReady(arg_39_1, arg_39_2)
	local var_39_1 = self._comboData[arg_39_2] and self._comboData[arg_39_2]:getSkills()[arg_39_1]

	return self._comboData[arg_39_2]:isSkillReady(arg_39_1, (var_39_1 or nil) and self:getSkillEffectComboCostMod(arg_39_2, (var_39_1:getAdvId())))
end

function BattleData:getSkillEffectComboCostMod(arg_40_1, arg_40_2)
	if not arg_40_2 or arg_40_2 <= 0 then
		return 0
	end

	local var_40_0 = "comboCostMod_" .. arg_40_2
	local var_40_1 = 0

	for iter_40_0, iter_40_1 in self._knights:ipairs(arg_40_1) do
		var_40_1 = var_40_1 + (iter_40_1:getKnightTempValue(var_40_0) or 0)
	end

	return var_40_1
end

function BattleData:isSuccubaSkillReady(arg_41_1, arg_41_2)
	return self._succubaData[arg_41_2]:isSkillReady(arg_41_1)
end

function BattleData:getComboLevel(arg_42_1, arg_42_2)
	return self._comboData[arg_42_2]:getSkillLevel(arg_42_1)
end

function BattleData:getSuccubaLevel(arg_43_1, arg_43_2)
	return self._succubaData[arg_43_2]:getSkillLevel(arg_43_1)
end

function BattleData:initComboAddData(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = 0
	local var_44_1 = 0

	for iter_44_0, iter_44_1 in self._knights:ipairs(arg_44_3) do
		var_44_0 = var_44_0 + 1
		var_44_1 = var_44_1 + iter_44_1.originInfo[arg_44_2]
	end

	self._comboData[arg_44_3].baseInfo[arg_44_1] = var_0_0.floor(var_44_1 * 1000 / load("core.Parameters").getComboParameter(var_44_0))
end

function BattleData:initComboAddData2(arg_45_1)
	self._comboData[arg_45_1].baseInfo.totalAtk = self._comboData[arg_45_1].baseInfo.COMBO_ATTACK
end

function BattleData:getTotalAttack(arg_46_1)
	local var_46_0 = 0

	for iter_46_0, iter_46_1 in self._knights:ipairs(arg_46_1) do
		var_46_0 = var_46_0 + iter_46_1.originInfo.ATTACK
	end

	return var_46_0
end

function BattleData:setFightValue(arg_47_1, arg_47_2)
	self._fightValue[arg_47_2] = arg_47_1
end

function BattleData:getFightValue(arg_48_1)
	return self._fightValue[arg_48_1]
end

function BattleData:setCondition(arg_49_1)
	if not arg_49_1 then
		return
	end

	local var_49_0 = loadCfg("core.config.cfg.battle_rating_info").get(arg_49_1)
	local var_49_1 = var_49_0.rating_value
	local var_49_2 = var_49_0.rating_type2
	local var_49_3 = var_49_0.rating_value2

	if var_49_0.rating_type == 4 then
		function self._conditionCheck(arg_50_0)
			return arg_50_0 <= var_49_1
		end
	elseif var_49_0.rating_type == 5 then
		function self._conditionCheck(arg_51_0)
			local var_51_0 = 0

			for iter_51_0, iter_51_1 in self._knights:ipairs(1) do
				if iter_51_1.isDead then
					var_51_0 = var_51_0 + 1
				end
			end

			return var_51_0 <= var_49_1
		end
	elseif var_49_0.rating_type == 6 then
		function self._conditionCheck(arg_52_0)
			return self:getHpPer(1) >= var_49_1 * 10
		end
	elseif var_49_0.rating_type == 7 then
		function self._conditionCheck(arg_53_0)
			return arg_53_0 <= var_49_1, true
		end
	elseif var_49_0.rating_type == 8 then
		function self._conditionCheck(arg_54_0)
			return arg_54_0 <= 5
		end
	elseif var_49_0.rating_type == 9 then
		function self._conditionCheck(arg_55_0)
			if var_49_2 == 10 and var_49_3 ~= 0 then
				return arg_55_0 <= var_49_3
			else
				return true
			end
		end
	elseif var_49_0.rating_type == 10 then
		function self._conditionCheck(arg_56_0)
			return arg_56_0 <= var_49_1
		end
	end
end

function BattleData:getHpPer(arg_57_1)
	local var_57_0 = 0
	local var_57_1 = 0

	for iter_57_0, iter_57_1 in self._knights:ipairs(arg_57_1) do
		var_57_0 = var_57_0 + iter_57_1.baseInfo.INITIAL_HP
		var_57_1 = var_57_1 + iter_57_1.originInfo.INITIAL_HP
	end

	return var_0_0.floor(var_57_0 * 1000 / var_57_1)
end

function BattleData:setMultiple(arg_58_1, arg_58_2)
	if not arg_58_2 then
		return
	end

	self._multiples[arg_58_1] = arg_58_2 + 1000
end

function BattleData:setElderBossBuff(arg_59_1, arg_59_2)
	self._elderData[arg_59_1] = {}

	if arg_59_2.key then
		self._elderData[arg_59_1][arg_59_2.key] = arg_59_2.value
	end
end

function BattleData:isTeamAllDead(arg_60_1)
	local var_60_0 = true

	for iter_60_0, iter_60_1 in self._knights:ipairs(arg_60_1) do
		var_60_0 = var_60_0 and not iter_60_1:isReal()
	end

	return var_60_0
end

function BattleData:isGameOver(arg_61_1)
	if arg_61_1 > var_0_10.ROUND_MAX then
		return true, 2
	end

	if self._conditionCheck then
		local var_61_0, var_61_1 = self._conditionCheck(arg_61_1)

		if not var_61_0 then
			return true, var_61_1 and 1 or 2
		end
	end

	if self:hasNextPassive() or self:hasNextFastPassive() then
		return false
	end

	local var_61_2 = self:isTeamAllDead(1)
	local var_61_3 = self:isTeamAllDead(2)
	local var_61_4 = var_61_2 or var_61_3

	if var_61_2 or var_61_3 then
		if self._victoryMode ~= 1 then
			return var_61_4, var_61_2 and 2 or 1
		else
			return var_61_4, var_61_3 and 1 or 2
		end
	end

	return var_61_4, var_61_2 and 2 or 1
end

function BattleData:getHighIdentity()
	if self._highIdentity > 0 then
		return self._highIdentity
	end

	if self._isPvp then
		return self:getFightValue(1) >= self:getFightValue(2) and 1 or 2
	else
		return 1
	end
end

function BattleData:getHighIdentityDynamic()
	if self._isPvp then
		return self:getFightValue(1) >= self:getFightValue(2) and 1 or 2
	else
		return 1
	end
end

function BattleData:setHighIdentity(arg_64_1)
	self._highIdentity = arg_64_1
end

function BattleData:setRoundFinish(arg_65_1)
	self._roundFinish = arg_65_1
end

function BattleData:getRoundFinish()
	return self._roundFinish
end

function BattleData:packKnightData(arg_67_1)
	local var_67_0 = {}
	local var_67_1 = {}

	for iter_67_0, iter_67_1 in self._knights:ipairs(arg_67_1) do
		local var_67_2

		if iter_67_1:doBuff(var_0_16.TYPE.BUFF_530, {
			isEff = false
		}, nil).isEff then
			var_67_0[iter_67_0] = 0
		else
			var_67_0[iter_67_0] = iter_67_1.baseInfo.INITIAL_HP
			var_67_2 = var_67_1
		end

		var_0_3(var_67_1, {
			identity = iter_67_1.identity,
			pos = iter_67_1.serialId % 10,
			hp = var_67_0[iter_67_0],
			reborn_count = iter_67_1.rebornCount
		})
	end

	return var_67_0, var_67_1
end

function BattleData:setKnightHp(arg_68_1, arg_68_2)
	for iter_68_0, iter_68_1 in ipairs(arg_68_2) do
		local var_68_0 = self._knights:getKnightByIdAndPos(arg_68_1, iter_68_1.pos)

		var_68_0.baseInfo.INITIAL_HP = iter_68_1.hp

		if iter_68_1.hp == 0 then
			var_68_0.isDead = true
		end
	end
end

function BattleData:clear(arg_69_1)
	self._knights:clear(arg_69_1)
	self._passiveData:clear()
	self._fastPassiveData:clear()

	self._skillSummons = {
		{},
		{}
	}
	self._scenes = {}
	self._allKnightMaxQuality = 0
end

function BattleData:setPets(arg_70_1, arg_70_2)
	self._pets[arg_70_1] = {}
	self._pets[arg_70_1] = var_0_14.new(arg_70_1)

	self._pets[arg_70_1]:setPets(arg_70_2)

	if arg_70_1 == 2 then
		self._pets[2]:setIsBoss(self._isBoss)
	end
end

function BattleData:checkPetExtraSkill(arg_71_1, arg_71_2)
	self._pets[arg_71_1]:checkPetExtraSkill(self, arg_71_2)
end

function BattleData:setPassiveSkills(arg_72_1, arg_72_2)
	self._passiveSkills[arg_72_1] = arg_72_2
	self._spRules[arg_72_1] = load("core.rule.SkillSpecialRule").initRule(arg_72_2, arg_72_1, self._battleField)
end

function BattleData:addSpRule(arg_73_1, arg_73_2, arg_73_3, arg_73_4)
	var_0_18.addRule(self._spRules[arg_73_1], self:getBattleField(), arg_73_1, arg_73_2, arg_73_3)

	if arg_73_4 then
		var_0_18.sortRules(self._spRules[arg_73_1])
	end
end

function BattleData:executeSpRule(arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5)
	local var_74_0 = {}
	local var_74_1 = self:getHighIdentity()

	for iter_74_0 = var_74_1, 3 - var_74_1, var_74_1 == 1 and 1 or -1 do
		if self._spRules[iter_74_0] and self._spRules[iter_74_0][arg_74_1] then
			for iter_74_1, iter_74_2 in ipairs(self._spRules[iter_74_0][arg_74_1]) do
				if arg_74_3 then
					if iter_74_2.info.passive_skill_type == 4 and iter_74_2.spEffectInfo.special_skill_type == arg_74_3 and iter_74_2:check(arg_74_2) and iter_74_2:execute() then
						arg_74_4 = iter_74_2.spEffectRule(arg_74_4, arg_74_5)

						var_0_3(var_74_0, iter_74_2.spEffectInfo.id)
					end
				elseif iter_74_2:check(arg_74_2) and iter_74_2:execute() then
					if iter_74_2.info.passive_skill_type == 3 then
						self._battleField:getBattleData():addFastPassive({
							identity = iter_74_0,
							info = iter_74_2.info,
							check = iter_74_2
						})
					elseif iter_74_2.info.passive_skill_type == 1 and iter_74_2.info.if_merge == 1 then
						self._battleField:getBattleData():addFastPassive({
							identity = iter_74_0,
							info = iter_74_2.info
						})
					else
						self._battleField:getBattleData():addPassive({
							identity = iter_74_0,
							info = iter_74_2.info
						})
					end
				end
			end
		end

		for iter_74_3, iter_74_4 in ipairs(self._skillSummons[iter_74_0]) do
			iter_74_4:executeSpRule(arg_74_1, arg_74_2)
		end

		for iter_74_5, iter_74_6 in ipairs(self._scenes) do
			iter_74_6:executeSpRule(arg_74_1, arg_74_2)
		end
	end

	return arg_74_4, var_74_0
end

function BattleData:executeKnightSpRule(arg_75_1, arg_75_2)
	local var_75_0 = self:getHighIdentity()

	for iter_75_0 = var_75_0, 3 - var_75_0, var_75_0 == 1 and 1 or -1 do
		for iter_75_1, iter_75_2 in self._knights:ipairs(iter_75_0) do
			local var_75_1 = false

			if arg_75_1 == var_0_18.TYPE.BUFF_DOING_EFFECT then
				if var_0_16.TYPE.BUFF_355 ~= arg_75_2.passiveEffectBuffType and var_0_16.TYPE.BUFF_594 ~= arg_75_2.passiveEffectBuffType then
					var_75_1 = iter_75_2:doBuff(var_0_16.TYPE.BUFF_355, false, {
						passiveEffectBuffType = var_0_16.TYPE.BUFF_355
					})
				end
			else
				var_75_1 = iter_75_2:doBuff(var_0_16.TYPE.BUFF_355, false, {})
			end

			if var_75_1 or iter_75_2:isValid() then
				iter_75_2:executeSpRule(arg_75_1, arg_75_2)
			end
		end
	end
end

function BattleData:getPassiveSkills(arg_76_1)
	return self._passiveSkills[arg_76_1]
end

function BattleData:addPassive(arg_77_1)
	self._passiveData:push(arg_77_1)
end

function BattleData:getNextPassive()
	local var_78_0 = self._passiveData:pop()

	while var_78_0 do
		if self:checkActionPassiveSkill(var_78_0) then
			break
		else
			var_78_0 = self._passiveData:pop()
		end
	end

	if not var_78_0 then
		return nil
	end

	if self:isTeamAllDead(1) or self:isTeamAllDead(2) then
		while var_78_0 do
			if not var_78_0.isSkill then
				if var_78_0.info.ace_trigger_type == 1 then
					return var_78_0
				end
			else
				return var_78_0
			end

			var_78_0 = self._passiveData:pop()
		end

		return nil
	else
		return var_78_0
	end
end

function BattleData:hasNextPassive()
	if self:isTeamAllDead(1) or self:isTeamAllDead(2) then
		for iter_79_0, iter_79_1 in ipairs(self._passiveData.list) do
			if self:checkActionPassiveSkill(iter_79_1) and not iter_79_1.isSkill and iter_79_1.info.ace_trigger_type == 1 then
				return true
			end
		end
	else
		for iter_79_2, iter_79_3 in ipairs(self._passiveData.list) do
			if self:checkActionPassiveSkill(iter_79_3) then
				return true
			end
		end
	end

	return false
end

function BattleData:checkActionPassiveSkill(arg_80_1)
	if arg_80_1.isSkill then
		return true
	end

	if arg_80_1.assist then
		return true
	end

	if arg_80_1.canReleased == false then
		return false
	elseif arg_80_1.canReleased == true then
		return true
	end

	local var_80_0 = arg_80_1.info
	local var_80_1

	if arg_80_1.identity then
		var_80_1 = arg_80_1.identity
	elseif arg_80_1.knight then
		var_80_1 = arg_80_1.knight.identity
	end

	if var_80_1 then
		local var_80_2 = self:getQSValue(var_80_1, var_80_0.belong_to_type, var_0_13.Q_SUPPRESS_TYPE.PASSIVE, var_80_0.passive_quality)

		if var_80_2 > 0 and self._battleField:bingo(var_80_2) then
			arg_80_1.canReleased = false

			BLog.LogText(string.format("品质压制成功，被动释放失败：%d %s,压制千分比：%d", var_80_0.id, var_80_0.name, var_80_2))

			return false
		end
	end

	local var_80_3 = arg_80_1.knight

	if arg_80_1.knight then
		if self:isKnightFight((var_0_17.get(var_80_0.passive_skill_value))) then
			if not var_80_3:isReal() then
				arg_80_1.canReleased = false

				return false
			end

			if var_80_3:doBuff(var_0_16.TYPE.EXTRA_ACTION_FAIL) then
				arg_80_1.canReleased = false

				return false
			end
		end

		if var_80_3:doBuff(var_0_16.TYPE.BUFF_564, nil, {
			checkPassive = true
		}) then
			arg_80_1.canReleased = false

			return false
		end
	end

	arg_80_1.canReleased = true

	return true
end

function BattleData:addFastPassive(arg_81_1)
	self._fastPassiveData:push(arg_81_1)
end

function BattleData:getNextFastPassive()
	local var_82_0 = self._fastPassiveData:pop()

	while var_82_0 do
		if self:checkActionPassiveSkill(var_82_0) then
			break
		else
			var_82_0 = self._fastPassiveData:pop()
		end
	end

	if not var_82_0 then
		return nil
	end

	if self:isTeamAllDead(1) or self:isTeamAllDead(2) then
		while var_82_0 do
			if not var_82_0.isSkill then
				if var_82_0.info.ace_trigger_type == 1 then
					return var_82_0
				end
			else
				return var_82_0
			end

			var_82_0 = self._fastPassiveData:pop()
		end

		return nil
	else
		return var_82_0
	end
end

function BattleData:hasNextFastPassive()
	if self:isTeamAllDead(1) or self:isTeamAllDead(2) then
		for iter_83_0, iter_83_1 in ipairs(self._fastPassiveData.list) do
			if self:checkActionPassiveSkill(iter_83_1) and not iter_83_1.isSkill and iter_83_1.info.ace_trigger_type == 1 then
				return true
			end
		end
	else
		for iter_83_2, iter_83_3 in ipairs(self._fastPassiveData.list) do
			if self:checkActionPassiveSkill(iter_83_3) then
				return true
			end
		end
	end

	return false
end

function BattleData:executeEnergyRule(arg_84_1, arg_84_2)
	for iter_84_0, iter_84_1 in ipairs((self:getAllKnightList())) do
		if not iter_84_1.isDead then
			iter_84_1:executeEnergyRule(arg_84_1, arg_84_2)
		end
	end
end

function BattleData:addEnergyEffect(arg_85_1, arg_85_2)
	var_0_3(self._energyEffects, {
		victim = arg_85_1,
		effect_type = arg_85_2 < 0 and 12 or 13,
		effect_value = arg_85_2
	})
end

function BattleData:getEnergyEffect()
	self._energyEffects = {}

	return self._energyEffects
end

local var_0_21 = 1

function BattleData:addSkillSummon(arg_87_1, arg_87_2)
	local var_87_0 = 0
	local var_87_1 = loadCfg("core.config.cfg.skill_summon_info").get(arg_87_1)

	for iter_87_0, iter_87_1 in ipairs(self._skillSummons[arg_87_2.identity]) do
		if iter_87_1.summonCfg.advance_id == var_87_1.advance_id then
			var_87_0 = var_87_0 + 1
		end
	end

	if var_87_0 >= var_87_1.summon_max_num then
		return
	end

	local var_87_2 = var_0_15.createSkillSummon(var_0_21, var_87_1, arg_87_2, self._battleField)

	var_0_21 = var_0_21 + 1

	var_0_3(self._skillSummons[arg_87_2.identity], var_87_2)

	return var_87_2
end

function BattleData:checkSkillSummonFinish(arg_88_1)
	local var_88_0 = {}

	for iter_88_0 = 1, 2 do
		for iter_88_1 = #self._skillSummons[iter_88_0], 1, -1 do
			if self._skillSummons[iter_88_0][iter_88_1].isDone then
				var_0_3(var_88_0, self._skillSummons[iter_88_0][iter_88_1])
				var_0_4(self._skillSummons[iter_88_0], iter_88_1)
			end
		end
	end

	return var_88_0
end

function BattleData:getSkillSummons(arg_89_1)
	return self._skillSummons[arg_89_1]
end

local var_0_22 = 1

function BattleData:addScene(arg_90_1, arg_90_2, arg_90_3)
	local var_90_0 = var_0_11.createScene(var_0_22, arg_90_1, arg_90_2, arg_90_3, self._battleField)

	var_0_22 = var_0_22 + 1

	var_0_3(self._scenes, var_90_0)

	return var_90_0.serialId
end

function BattleData:getSecenes()
	return self._scenes
end

function BattleData:setAssist(arg_92_1)
	if not arg_92_1 then
		return
	end

	local var_92_0 = loadCfg("core.config.cfg.battle_assistance_info").get(arg_92_1)

	if not var_92_0 then
		return
	end

	local var_92_1 = {}

	for iter_92_0 = 1, 3 do
		local var_92_2 = self:getKnightByIdAndPos(var_92_0.npc_type, var_92_0["npc_position_" .. iter_92_0])

		if var_92_2 then
			var_92_2.willAssist = true
		end

		var_92_1[#var_92_1 + 1] = var_92_2
	end

	function self:assistCheck(arg_93_1, arg_93_2, arg_93_3)
		if var_92_0.wave == self._battleField:getWave() + 1 and var_92_0.npc_type == arg_93_1 and load("core.rule.SkillSpecialRule").getCheckFunc(var_92_0, self._battleField, arg_93_1)({
			info = var_92_0
		}, arg_93_3) then
			local var_93_0 = false

			for iter_93_0 = 1, #var_92_1 do
				if var_92_1[iter_93_0].willAssist then
					var_92_1[iter_93_0].willAssist = false

					if var_92_0.if_attack_immediately == 1 then
						var_92_1[iter_93_0].assisting = true
					end

					var_93_0 = true
				end
			end

			if var_93_0 then
				return var_92_1, var_92_0
			end
		end
	end
end

function BattleData:addRebornKnight(arg_94_1)
	local var_94_0 = self._battleField:getAttackCount()

	if self._rebornAttackCount ~= var_94_0 then
		self._reborns = {}
		self._rebornAttackCount = var_94_0
	end

	var_0_3(self._reborns, arg_94_1)
end

function BattleData:getRebornKnights()
	local var_95_0 = self._battleField:getAttackCount()

	if self._rebornAttackCount ~= var_95_0 then
		self._reborns = {}
		self._rebornAttackCount = var_95_0
	end

	return self._reborns
end

function BattleData:recoverKnightsHp(arg_96_1, arg_96_2)
	local var_96_0 = {}

	for iter_96_0, iter_96_1 in self._knights:ipairs(arg_96_1) do
		if iter_96_1:isValid() then
			local var_96_1 = var_0_0.min(var_0_1(iter_96_1.originInfo.INITIAL_HP * arg_96_2 / 1000), iter_96_1.originInfo.INITIAL_HP - iter_96_1.baseInfo.INITIAL_HP)

			if var_96_1 > 0 then
				iter_96_1.baseInfo.INITIAL_HP = iter_96_1.baseInfo.INITIAL_HP + var_96_1

				var_0_3(var_96_0, {
					id = iter_96_1.serialId,
					hp = var_96_1
				})
			end
		end
	end

	return var_96_0
end

function BattleData:getBattleField()
	return self._battleField
end

function BattleData:doSceneRound()
	local var_98_0 = {}

	for iter_98_0 = #self._scenes, 1, -1 do
		self._scenes[iter_98_0]:doRound()

		if self._scenes[iter_98_0].sceneTime <= 0 then
			var_0_3(var_98_0, self._scenes[iter_98_0])
			var_0_4(self._scenes, iter_98_0)
		end
	end

	return var_98_0
end

function BattleData:initPlayers()
	self._players = {}
	self._players[1] = var_0_12.createPlayer(1, self)
	self._players[2] = var_0_12.createPlayer(2, self)
end

function BattleData:getPlayer(arg_100_1)
	return self._players[arg_100_1]
end

function BattleData:setMultiShield(arg_101_1, arg_101_2, arg_101_3)
	self._multiShield[arg_101_1][arg_101_2] = arg_101_3
end

function BattleData:getMultiShield(arg_102_1, arg_102_2)
	return self._multiShield[arg_102_1][arg_102_2]
end

function BattleData:getSelfKnightSkillNum(arg_103_1, arg_103_2)
	return self._selfKnightSkillNum[arg_103_1][arg_103_2] or 0
end

function BattleData:setSelfKnightSkillNum(arg_104_1, arg_104_2, arg_104_3)
	self._selfKnightSkillNum[arg_104_1][arg_104_3] = arg_104_2
end

function BattleData:addSelfKnightSkillNum(arg_105_1, arg_105_2)
	self._selfKnightSkillNum[arg_105_1][arg_105_2] = self._selfKnightSkillNum[arg_105_1][arg_105_2] and self._selfKnightSkillNum[arg_105_1][arg_105_2] + 1 or 1
end

function BattleData:setFirstDeadKnight(arg_106_1, arg_106_2)
	if self._firstDeadKnight[arg_106_1] == 0 then
		self._firstDeadKnight[arg_106_1] = arg_106_2
	end
end

function BattleData:getFirstDeadKnight(arg_107_1)
	return self._firstDeadKnight[arg_107_1]
end

function BattleData:setFirstDeadKnightOrder(arg_108_1, arg_108_2)
	local var_108_0 = false

	for iter_108_0, iter_108_1 in ipairs(self._firstDeadKnightOrder[arg_108_1]) do
		if iter_108_1 == arg_108_2 then
			var_108_0 = true

			break
		end
	end

	if not var_108_0 then
		var_0_2.insert(self._firstDeadKnightOrder[arg_108_1], arg_108_2)
	end
end

function BattleData:getFirstDeadKnightOrder(arg_109_1)
	return self._firstDeadKnightOrder[arg_109_1]
end

function BattleData:packCheckKnightData()
	local var_110_0 = {}

	for iter_110_0, iter_110_1 in self._knights:ipairs() do
		var_0_3(var_110_0, {
			pos = iter_110_1.serialId,
			hp = iter_110_1.baseInfo.INITIAL_HP,
			shield = iter_110_1.baseInfo.SHIELD,
			takeOffHp = iter_110_1.baseInfo.TAKEOFF_HP,
			takeOffShield = iter_110_1.baseInfo.TAKEOFF_SHIELD,
			name = iter_110_1.knightCfg.name
		})
	end

	return var_110_0
end

function BattleData:setRandomTargetData(arg_111_1, arg_111_2, arg_111_3, arg_111_4)
	if self._randomTargetData[arg_111_2][arg_111_1] then
		self._randomTargetData[arg_111_2][arg_111_1][arg_111_4] = arg_111_3
	else
		self._randomTargetData[arg_111_2][arg_111_1] = {}
		self._randomTargetData[arg_111_2][arg_111_1][arg_111_4] = arg_111_3
	end
end

function BattleData:getRandomTargetData(arg_112_1, arg_112_2, arg_112_3)
	if self._randomTargetData[arg_112_2][arg_112_1] then
		return self._randomTargetData[arg_112_2][arg_112_1][arg_112_3] or {}
	else
		return {}
	end
end

function BattleData:setVictoryMode(arg_113_1)
	self._victoryMode = arg_113_1 or 0
end

function BattleData:getBattleAttr(arg_114_1)
	self._battleAttr = self._battleAttr or {}

	if self._battleAttr[arg_114_1] then
		return self._battleAttr[arg_114_1]
	end

	local var_114_0 = {
		0,
		0
	}

	for iter_114_0 = 1, 2 do
		for iter_114_1, iter_114_2 in self._knights:ipairs(iter_114_0) do
			if iter_114_2.originInfo[arg_114_1] and iter_114_2.originInfo[arg_114_1] > 0 then
				var_114_0[iter_114_0] = iter_114_2.originInfo[arg_114_1]

				break
			end
		end
	end

	self._battleAttr[arg_114_1] = var_114_0

	return var_114_0
end

function BattleData:effectBuff(arg_115_1, arg_115_2)
	self._shareBuffEff[arg_115_1][arg_115_2] = self._shareBuffEff[arg_115_1][arg_115_2] or 0
	self._shareBuffEff[arg_115_1][arg_115_2] = self._shareBuffEff[arg_115_1][arg_115_2] - 1

	if self._shareBuffEff[arg_115_1][arg_115_2] <= 0 then
		self._shareBuffEff[arg_115_1][arg_115_2] = 0

		return true
	end

	return false
end

function BattleData:getMultiAllShield(arg_116_1)
	return self._multiShield[arg_116_1]
end

function BattleData:addBuffEffectTime(arg_117_1, arg_117_2, arg_117_3)
	self._shareBuffEff[arg_117_1][arg_117_2] = self._shareBuffEff[arg_117_1][arg_117_2] or 0
	self._shareBuffEff[arg_117_1][arg_117_2] = self._shareBuffEff[arg_117_1][arg_117_2] + arg_117_3
end

function BattleData:onMoodBuffTick(arg_118_1, arg_118_2)
	self._moodBuffTickIds[arg_118_1][arg_118_2] = self._moodBuffTickIds[arg_118_1][arg_118_2] or 0
	self._moodBuffTickIds[arg_118_1][arg_118_2] = self._moodBuffTickIds[arg_118_1][arg_118_2] + 1
	self._moodBuffTick[arg_118_1] = self._moodBuffTick[arg_118_1] + 1
end

function BattleData:getMoodBuffTick(arg_119_1, arg_119_2)
	if not arg_119_2 then
		return self._moodBuffTick[arg_119_1] or 0
	else
		return self._moodBuffTickIds[arg_119_1][arg_119_2] or 0
	end
end

function BattleData:clearMoodBuffTick(arg_120_1)
	self._moodBuffTickIds[arg_120_1] = {}
	self._moodBuffTick[arg_120_1] = 0
end

function BattleData:setBattleError()
	self._isBattleErrorFlag = var_0_13.ERROR_ID.DEAD_LOOP
end

function BattleData:isBattleError()
	return self._isBattleErrorFlag
end

function BattleData:setCurAttackerId(arg_123_1)
	self._curAttackerSerialId = arg_123_1
end

function BattleData:addBuff267TotalDamage(arg_124_1, arg_124_2)
	if self._curAttackerSerialId == arg_124_1.serialId then
		self._buff267TotalDamage[arg_124_1.identity] = self._buff267TotalDamage[arg_124_1.identity] or 0
		self._buff267TotalDamage[arg_124_1.identity] = self._buff267TotalDamage[arg_124_1.identity] + arg_124_2
	end
end

function BattleData:subBuff267TotalDamage(arg_125_1, arg_125_2)
	self._buff267TotalDamage[arg_125_1] = self._buff267TotalDamage[arg_125_1] - arg_125_2

	if self._buff267TotalDamage[arg_125_1] < 0 then
		self._buff267TotalDamage[arg_125_1] = 0
	end
end

function BattleData:getBuff267TotalDamage(arg_126_1)
	return self._buff267TotalDamage[arg_126_1] or 0
end

function BattleData:debugChangeBuff267DamageValue(arg_127_1, arg_127_2, arg_127_3, arg_127_4)
	if self._curAttackerSerialId > 0 and self._curAttackerSerialId ~= arg_127_2.serialId then
		return
	end

	self._debugBuff267ChangeDamageData[arg_127_1] = self._debugBuff267ChangeDamageData[arg_127_1] or {}

	var_0_2.insert(self._debugBuff267ChangeDamageData[arg_127_1], {
		attacker = arg_127_2,
		victim = arg_127_3,
		value = arg_127_4
	})
end

function BattleData:debugGetChangeBuff267ValueData(arg_128_1)
	return self._debugBuff267ChangeDamageData[arg_128_1] or {}, self._buff267TotalDamage
end

function BattleData:addBuff420TotalDamage(arg_129_1, arg_129_2)
	if self._curAttackerSerialId == arg_129_1.serialId then
		self._buff420TotalDamage[arg_129_1.identity] = self._buff420TotalDamage[arg_129_1.identity] or 0
		self._buff420TotalDamage[arg_129_1.identity] = self._buff420TotalDamage[arg_129_1.identity] + arg_129_2
	end
end

function BattleData:subBuff420TotalDamage(arg_130_1, arg_130_2)
	self._buff420TotalDamage[arg_130_1] = self._buff420TotalDamage[arg_130_1] - arg_130_2

	if self._buff420TotalDamage[arg_130_1] < 0 then
		self._buff420TotalDamage[arg_130_1] = 0
	end
end

function BattleData:getBuff420TotalDamage(arg_131_1)
	return self._buff420TotalDamage[arg_131_1] or 0
end

function BattleData:getBuff641TotalCnt(arg_132_1)
	return self._buff641TotalCnt[arg_132_1] or 0
end

function BattleData:setBuff641TotalCnt(arg_133_1, arg_133_2)
	self._buff641TotalCnt[arg_133_1] = arg_133_2
end

function BattleData:getBuff645TotalCnt(arg_134_1)
	return self._buff645TotalCnt[arg_134_1] or 0
end

function BattleData:setBuff645TotalCnt(arg_135_1, arg_135_2)
	self._buff645TotalCnt[arg_135_1] = arg_135_2
end

function BattleData:getBuff656TotalCnt(arg_136_1)
	return self._buff656TotalCnt[arg_136_1] or 0
end

function BattleData:setBuff656TotalCnt(arg_137_1, arg_137_2)
	self._buff656TotalCnt[arg_137_1] = arg_137_2
end

function BattleData:addSpecialBuffCnt(arg_138_1, arg_138_2)
	if not self._specialBuffCnt[arg_138_1][arg_138_2] then
		self._specialBuffCntFirstAddRound[arg_138_1][arg_138_2] = self._battleField:getRoundCount()
	end

	self._specialBuffCnt[arg_138_1][arg_138_2] = (self._specialBuffCnt[arg_138_1][arg_138_2] or 0) + 1
end

function BattleData:getSpecialBuffCnt(arg_139_1, arg_139_2)
	return (self._specialBuffCnt[arg_139_1][arg_139_2] or 0) + (self._battleField:getRoundCount() - (self._specialBuffCntFirstAddRound[arg_139_1][arg_139_2] or self._battleField:getRoundCount()))
end

function BattleData:getBuff648TotalDamage(arg_140_1)
	return self._buff648TotalDamage[arg_140_1] or 0
end

function BattleData:setBuff648TotalDamage(arg_141_1, arg_141_2)
	self._buff648TotalDamage[arg_141_1] = arg_141_2
end

function BattleData:addBuff672SiphonRatio(arg_142_1, arg_142_2, arg_142_3)
	self._buff672SiphonMap[arg_142_1] = self._buff672SiphonMap[arg_142_1] or {}
	self._buff672SiphonMap[arg_142_1][arg_142_2] = (self._buff672SiphonMap[arg_142_1][arg_142_2] or 0) + arg_142_3
end

function BattleData:subtractBuff672SiphonRatio(arg_143_1, arg_143_2, arg_143_3)
	if self._buff672SiphonMap[arg_143_1] and self._buff672SiphonMap[arg_143_1][arg_143_2] then
		self._buff672SiphonMap[arg_143_1][arg_143_2] = var_0_0.max(0, self._buff672SiphonMap[arg_143_1][arg_143_2] - arg_143_3)
	end
end

function BattleData:getBuff672SiphonMap(arg_144_1)
	return self._buff672SiphonMap[arg_144_1] or {}
end

function BattleData:debugChangeBuff420DamageValue(arg_145_1, arg_145_2, arg_145_3, arg_145_4)
	if self._curAttackerSerialId > 0 and self._curAttackerSerialId ~= arg_145_2.serialId then
		return
	end

	self._debugBuff420ChangeDamageData[arg_145_1] = self._debugBuff420ChangeDamageData[arg_145_1] or {}

	var_0_2.insert(self._debugBuff420ChangeDamageData[arg_145_1], {
		attacker = arg_145_2,
		victim = arg_145_3,
		value = arg_145_4
	})
end

function BattleData:debugGetChangeBuff420ValueData(arg_146_1)
	return self._debugBuff420ChangeDamageData[arg_146_1] or {}, self._buff420TotalDamage
end

function BattleData:addBuff635TotalDamage(arg_147_1, arg_147_2)
	if self._curAttackerSerialId == arg_147_1.serialId then
		self._buff635TotalDamage[arg_147_1.identity] = self._buff635TotalDamage[arg_147_1.identity] or 0
		self._buff635TotalDamage[arg_147_1.identity] = self._buff635TotalDamage[arg_147_1.identity] + arg_147_2
	end
end

function BattleData:subBuff635TotalDamage(arg_148_1, arg_148_2)
	self._buff635TotalDamage[arg_148_1] = self._buff635TotalDamage[arg_148_1] - arg_148_2

	if self._buff635TotalDamage[arg_148_1] < 0 then
		self._buff635TotalDamage[arg_148_1] = 0
	end
end

function BattleData:getBuff635TotalDamage(arg_149_1)
	return self._buff635TotalDamage[arg_149_1] or 0
end

function BattleData:debugChangeBuff635DamageValue(arg_150_1, arg_150_2, arg_150_3, arg_150_4)
	if self._curAttackerSerialId > 0 and self._curAttackerSerialId ~= arg_150_2.serialId then
		return
	end

	self._debugBuff635ChangeDamageData[arg_150_1] = self._debugBuff635ChangeDamageData[arg_150_1] or {}

	var_0_2.insert(self._debugBuff635ChangeDamageData[arg_150_1], {
		attacker = arg_150_2,
		victim = arg_150_3,
		value = arg_150_4
	})
end

function BattleData:debugGetChangeBuff635ValueData(arg_151_1)
	return self._debugBuff635ChangeDamageData[arg_151_1] or {}, self._buff635TotalDamage
end

function BattleData:getQSValue(arg_152_1, arg_152_2, arg_152_3, arg_152_4)
	local var_152_0 = 0

	if arg_152_2 == var_0_13.Q_SUPPRESS_MODULE.KNIGHT then
		var_152_0 = self._knights:getKnightQualitySuppress(3 - arg_152_1, arg_152_3, arg_152_4)
	elseif arg_152_2 == var_0_13.Q_SUPPRESS_MODULE.ARTIFACT then
		var_152_0 = self._knights:getArtifactQualitySuppress(3 - arg_152_1, arg_152_3, arg_152_4)
	elseif arg_152_2 == var_0_13.Q_SUPPRESS_MODULE.TOKEN then
		var_152_0 = self._comboData[3 - arg_152_1]:getQualitySuppress(arg_152_3, arg_152_4)
	elseif arg_152_2 == var_0_13.Q_SUPPRESS_MODULE.PET then
		var_152_0 = self._pets[3 - arg_152_1]:getQualitySuppress(arg_152_3, arg_152_4)
	elseif arg_152_2 == var_0_13.Q_SUPPRESS_MODULE.SUCCUBA then
		var_152_0 = self._succubaData[3 - arg_152_1]:getQualitySuppress(arg_152_3, arg_152_4)
	end

	return var_0_1(var_152_0 * self._qsValueRate * 0.001)
end

function BattleData:isKnightFight(arg_153_1)
	return arg_153_1.skill_type == 1 or arg_153_1.skill_type == 2 or arg_153_1.skill_type == 12 or arg_153_1.skill_type == 32
end

function BattleData:hasPetAdv(arg_154_1, arg_154_2)
	for iter_154_0, iter_154_1 in pairs(self._pets[arg_154_1]:getPets()) do
		if iter_154_1:getAdvanceId() == arg_154_2 then
			return true
		end
	end
end

function BattleData:addResultEffectTypeInAttackCnt(arg_155_1)
	local var_155_0 = self._battleField:getAttackCount()

	self._resultEffectDic[arg_155_1] = self._resultEffectDic[arg_155_1] or {
		atkCnt = 0,
		cnt = 0
	}

	if var_155_0 ~= self._resultEffectDic[arg_155_1].atkCnt then
		self._resultEffectDic[arg_155_1].atkCnt = var_155_0
		self._resultEffectDic[arg_155_1].cnt = 0
	end

	self._resultEffectDic[arg_155_1].cnt = self._resultEffectDic[arg_155_1].cnt + 1
end

function BattleData:getResultEffectTypeInAttackCnt(arg_156_1)
	if not self._resultEffectDic[arg_156_1] or self._resultEffectDic[arg_156_1].atkCnt ~= self._battleField:getAttackCount() then
		return 0
	end

	return self._resultEffectDic[arg_156_1].cnt
end

function BattleData:addSpBuffRef(arg_157_1)
	local var_157_0 = self._spBuffRefInfoDic[arg_157_1.attacker.serialId]

	if not self._spBuffRefInfoDic[arg_157_1.attacker.serialId] then
		var_157_0 = {}
		self._spBuffRefInfoDic[arg_157_1.attacker.serialId] = var_157_0
	end

	local var_157_1 = var_157_0[arg_157_1.buffCfg.buff_type]

	if not var_157_0[arg_157_1.buffCfg.buff_type] then
		var_157_1 = {}
		var_157_0[arg_157_1.buffCfg.buff_type] = var_157_1
	end

	var_157_1[#var_157_1 + 1] = {
		buff = arg_157_1,
		attacker = arg_157_1.attacker,
		victim = arg_157_1.victim
	}
end

function BattleData:knightIsBuffAttackerAndGetVictims(arg_158_1, arg_158_2)
	local var_158_0 = {}

	if not self._spBuffRefInfoDic[arg_158_1.serialId] then
		return var_158_0
	end

	local var_158_1 = self._spBuffRefInfoDic[arg_158_1.serialId][arg_158_2]

	if not self._spBuffRefInfoDic[arg_158_1.serialId][arg_158_2] then
		return var_158_0
	end

	local var_158_2 = 1

	while var_158_2 <= #var_158_1 do
		if var_158_1[var_158_2].buff.isDone then
			var_0_2.remove(var_158_1, var_158_2)
		else
			var_158_0[#var_158_0 + 1] = var_158_1[var_158_2].buff.victim
			var_158_2 = var_158_2 + 1
		end
	end

	return var_158_0
end

function BattleData:addDelayRebornList(arg_159_1)
	self._delayRebornList[arg_159_1.victim.serialId .. "_" .. arg_159_1.serialId] = arg_159_1
end

function BattleData:updateDelayRebornList()
	for iter_160_0, iter_160_1 in pairs(self._delayRebornList) do
		if iter_160_1.isDone then
			self._delayRebornList[iter_160_0] = nil
		else
			local var_160_0 = iter_160_1.victim
			local var_160_1 = iter_160_1.victim:doBuff(var_0_16.TYPE.DELAY_REBORN, {
				skillId = 0,
				roundTick = true
			})

			if var_160_1.skillId > 0 then
				self:addPassive({
					isSkill = true,
					knight = var_160_0,
					info = var_0_17.get(var_160_1.skillId),
					identity = var_160_0.identity
				})

				self._delayRebornList[iter_160_0] = nil
			end
		end
	end
end

function BattleData:setDelayRebornEff(arg_161_1)
	self._delayRebornEffDict[arg_161_1.serialId] = true
end

function BattleData:isDelayRebornEff(arg_162_1)
	return self._delayRebornEffDict[arg_162_1.serialId] == true
end

function BattleData:resetBattleData()
	self._delayRebornList = {}
	self._delayRebornEffDict = {}
end

function BattleData:resetAttackCountData()
	self._curDeadNumDict = {}
end

function BattleData:addDeadNum(arg_165_1)
	self._curDeadNumDict[arg_165_1] = self._curDeadNumDict[arg_165_1] or 0
	self._curDeadNumDict[arg_165_1] = self._curDeadNumDict[arg_165_1] + 1
end

function BattleData:getDeadNum(arg_166_1)
	return self._curDeadNumDict[arg_166_1] or 0
end

function BattleData:setSuccubaValue(arg_167_1, arg_167_2)
	self._succubaValue[arg_167_2] = arg_167_1
end

function BattleData:getSuccubaValue(arg_168_1)
	return self._succubaValue[arg_168_1]
end

function BattleData:setSuccuba(arg_169_1, arg_169_2)
	self._succuba[arg_169_2] = arg_169_1
end

function BattleData:getSuccuba(arg_170_1)
	return self._succuba[arg_170_1]
end

function BattleData:addBuffTickCount(arg_171_1, arg_171_2)
	local var_171_0 = self._buffEffTickDict[arg_171_1] or {}

	var_171_0[arg_171_2] = (var_171_0[arg_171_2] or 0) + 1
	self._buffEffTickDict[arg_171_1] = var_171_0
end

function BattleData:getBuffTickCount(arg_172_1, arg_172_2)
	return (self._buffEffTickDict[arg_172_1] or {})[arg_172_2] or 0
end

function BattleData:setQsRate(arg_173_1)
	self._qsValueRate = arg_173_1
end

function BattleData:setQualityLevelRate(arg_174_1)
	self._qualityLevelRate = arg_174_1
end

function BattleData:getQualityLevelRate()
	return self._qualityLevelRate
end

function BattleData:getAttrValue(arg_176_1, arg_176_2, arg_176_3)
	local var_176_0

	if not arg_176_1.isPlayer and self._allKnightMaxQuality >= var_0_13.ELEMENT_CHECK_QUALITY then
		if arg_176_1.knightCfg.quality >= var_0_13.ELEMENT_CHECK_QUALITY then
			local var_176_1 = var_0_19.get(self._allKnightMaxQuality, var_0_7[arg_176_2])

			var_176_0 = var_176_1 and var_0_0.floor((arg_176_1.advanceInfo[arg_176_2] * var_176_1.proportion_1 + arg_176_1.advanceInfo[var_0_6[var_176_1.attribute_2]] * var_176_1.proportion_2) * 0.001) or arg_176_1.advanceInfo[arg_176_2]
		else
			local var_176_2 = var_0_19.get(self._allKnightMaxQuality, var_0_7[arg_176_2])

			var_176_0 = var_176_2 and var_0_0.floor(arg_176_1.advanceInfo[arg_176_2] * var_176_2.proportion_1 * 0.001) or arg_176_1.advanceInfo[arg_176_2]
		end
	else
		var_176_0 = arg_176_1.advanceInfo[arg_176_2]
	end

	if arg_176_3 then
		if var_0_20[arg_176_2] then
			var_176_0 = var_176_0 + (arg_176_3[var_0_20[arg_176_2]] or 0)
		end
	end

	return var_176_0
end

function BattleData:getElderBossAdd(arg_177_1, arg_177_2)
	if self._elderData[arg_177_1.identity] then
		local var_177_0 = self._elderData[arg_177_1.identity][arg_177_1.classical] or 0

		if var_177_0 > 0 then
			return var_0_1(arg_177_2 * (1000 + var_177_0) * 0.001)
		end
	end

	return arg_177_2
end

function BattleData:setIsBoss(arg_178_1)
	self._isBoss = arg_178_1
end

function BattleData:setWarBandMaster(arg_179_1)
	self._warBanMaster[arg_179_1.identity] = {
		firstDead = true,
		beDead = false,
		knight = arg_179_1
	}
end

function BattleData:resetWarBandMaster(arg_180_1)
	self._warBanMaster[arg_180_1] = nil
end

function BattleData:getWarBandMaster(arg_181_1)
	return self._warBanMaster[arg_181_1]
end

function BattleData:getWarBandClassical(arg_182_1)
	if self._warBanMaster[arg_182_1] and self._warBanMaster[arg_182_1].knight then
		return self._warBanMaster[arg_182_1].knight.classical
	end

	return 0
end

function BattleData:initWarBandValue()
	local var_183_0 = self:getHighIdentity()

	self._warBanValueData[var_183_0] = var_0_10.WARBAND_VALUE_INIT1
	self._warBanValueData[3 - var_183_0] = var_0_10.WARBAND_VALUE_INIT2
end

function BattleData:updateWarBandValue(arg_184_1, arg_184_2)
	if self._warBanMaster[arg_184_1] == nil then
		return 0
	end

	local var_184_0 = self._warBanValueData[arg_184_1] + arg_184_2

	if self._warBanValueData[arg_184_1] + arg_184_2 < 0 then
		var_184_0 = 0
	end

	if var_184_0 > var_0_10.WARBAND_VALUE_MAX then
		var_184_0 = var_0_10.WARBAND_VALUE_MAX
	end

	self._warBanValueData[arg_184_1] = var_184_0

	return var_184_0 - self._warBanValueData[arg_184_1]
end

function BattleData:getWarBandValue(arg_185_1)
	return self._warBanValueData[arg_185_1]
end

function BattleData:canPlayWarBand()
	return self._teamWarBandCanPlay
end

function BattleData:setCanPlayWarBand(arg_187_1)
	self._teamWarBandCanPlay = arg_187_1
end

return BattleData
