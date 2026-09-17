PlayerCharacter = class("PlayerCharacter", function(arg_1_0, arg_1_1)
	return FightCharacter:create(arg_1_0, arg_1_1)
end)

local var_0_0 = math
local var_0_2 = table
local playermodel = require("model.playermodel")
local horcrux_manager = require("controller.horcrux_manager")
local weapon_manager = require("controller.weapon_manager")
local FightHorcrux = require("fight.horcrux.FightHorcrux")
local FightUIElementsManager = require("fight.FightUIElementsManager")
local xp_effect_manager = require("fight.xp.xp_effect_manager")
local total_skill_data = require("data.total_skill_data")
local skill_data = require("data.skill_data")
local battlefield_status_data = require("data.battlefield_status_data")

function PlayerCharacter.create(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = PlayerCharacter.new(arg_2_1, arg_2_2)

	var_2_0:initPlayer()

	return var_2_0
end

function PlayerCharacter:initPlayer()
	self.classname = "class_player"

	self:registerEnterHandler(function()
		if config._DEVELOP_MODE == "FIGHTDEV" or FightManager.isFakeFight() then
			return
		end

		self:initCourseBuffs((require("controller.course_cultivate_manager").getInstance():getEffectiveBuffs(require("data.servant_data")[self:getServantId()].modelid)))
		self:addCourseBuff()
	end)
	self:registerExitHandler(function()
		self:unregisterPlayerItem()
		self:unregisterPlayerBuffPanel()
	end)
	self:initPlayerBasicHandlers()
end

function PlayerCharacter:initPlayerItem()
	self.playerItem = FightManager.getPlayerItem(tonumber((self.index:match("players@(.+)"))))

	if self.playerItem then
		self.playerItem:registerFightBinding(self:getAttribute("modelid"), self.index, self:getAttribute("maxrage"))
		self.playerItem:updateRage(1, self:getAttribute("rage"))
	end
end

function PlayerCharacter:unregisterPlayerItem()
	if self.playerItem then
		self.playerItem:unregisterFightBinding()

		self.playerItem = nil
	end
end

function PlayerCharacter:initPlayerBuffPanel()
	self.buffpanel = FightManager.getBuffPanel(tonumber((self.index:match("players@(.+)"))))

	if self.buffpanel then
		self.buffpanel:registerFightBinding(self:getAttribute("modelid"), self.index)
	end
end

function PlayerCharacter:unregisterPlayerBuffPanel()
	if self.buffpanel then
		self.buffpanel:unregisterFightBinding()

		self.buffpanel = nil
	end
end

function PlayerCharacter:joinFight(arg_10_1)
	self.index = arg_10_1

	if self.charactertype == "player" then
		self:switchStatus(STATE_SEARCHING)
	elseif self.charactertype == "enemy" then
		self:switchStatus(STATE_PREFIGHTING)
	end

	if self.weapon_XP then
		-- block empty
	end

	if self.weapon_skill1 then
		self:updateSkillList({
			self.weapon_skill1
		})
	end

	self:registerStatusPool()
	self:resetAllCD()

	if config.who_is_your_dady then
		self:addAttribute("damage", 1000 * self:getAttribute("damage"))
		self:addAttribute("hp", 1000 * self:getAttribute("hp"))
		self:setAttribute("singlehp", var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount")))
		self:setAttribute("curhp", self:getAttribute("singlehp"))

		if self.hpbar then
			self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
			self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
		end
	end

	if self.charactertype == "player" then
		self:initPlayerItem()
		self:initPlayerBuffPanel()
	end

	if self._slaves then
		for iter_10_0, iter_10_1 in ipairs(self._slaves) do
			iter_10_1:joinFight(arg_10_1, iter_10_0)
			FightManager.getUIElements().attachCharacter(iter_10_1)
		end
	end
end

function PlayerCharacter:initCourseBuffs(arg_11_1)
	self.courseBuffs = {}

	local buff_data = require("data.buff_data")

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if buff_data[iter_11_1] then
			self.courseBuffs[#self.courseBuffs + 1] = iter_11_1
		end
	end
end

function PlayerCharacter:addCourseBuff()
	if not self.courseBuffs then
		return
	end

	local buff_data = require("data.buff_data")

	for iter_12_0, iter_12_1 in ipairs(self.courseBuffs) do
		self:addBuff(tonumber(iter_12_1), self.index, self:getExertBuffTimeAdd(tonumber(iter_12_1)), self:getExertBuffTimeFac(buff_data[tonumber(iter_12_1)].buff_or_debuff), (self:getExertBuffStackAdd(tonumber(iter_12_1))))
	end
end

function PlayerCharacter:registerStatusPool()
	self:registerPassiveSkill()
	self:registerSPSkill()
	self:registerEXSkill()
	self:registerOCSkill()
	self:registerWeaponSkill()
	self:registerBondSkill()
	self:registerExpeditionSkill()
	self:registerAssistSkill()
	self:registerComponentEffect()
	self:registerBattleFieldStatus()
	self:registerExploreSkill()
	self:registerTeamSkill()
	self:registerReinforceComponentEffect()
	self:registerUpgradeSkill()
	self:registerTowerSkill()
	self:registerMonoPolySkill()
	self:registerFlyChessSkill()
	self:registerHorcruxDevourSkill()
	self:registerArenaEnemyHorcruxDevourSkill()

	if config._DEVELOP_MODE and config._DEVELOP_MODE == "FIGHTDEV" then
		self:registerTestSkills()
	end
end

function PlayerCharacter:unregisterStatusPool()
	self:unregisterPassiveSkill()
	self:unregisterSPSkill()
	self:unregisterEXSkill()
	self:unregisterOCSkill()
	self:unregisterWeaponSkill()
	self:unregisterBondSkill()
	self:unregisterExpeditionSkill()
	self:unregisterAssistSkill()
	self:unregisterComponentEffect()
	self:unregisterBattleFieldStatus()
	self:unregisterExploreSkill()
	self:unregisterTeamSkill()
	self:unregisterReinforceComponentEffect()
	self:unregisterUpgradeSkill()
	self:unregisterTowerSkill()
	self:unregisterMonoPolySkill()
	self:unregisterFlyChessSkill()
	self:unregisterHorcruxDevourSkill()
	self:unregisterArenaEnemyHorcruxDevourSkill()
end

function PlayerCharacter:registerPassiveSkill()
	local var_15_0 = total_skill_data[self:getAttribute("passiveskill")]
	local var_15_1 = 1

	while var_15_0["skill" .. var_15_1] do
		self.statuspool:registerPassiveskill(var_15_0["skill" .. var_15_1])

		var_15_1 = var_15_1 + 1
	end

	local var_15_2 = 1

	while self._skilllist["skill" .. var_15_2] do
		while total_skill_data[self._skilllist["skill" .. var_15_2].id]["skill" .. 1] do
			if skill_data[total_skill_data[self._skilllist["skill" .. var_15_2].id]["skill" .. 1]].skill_type == 0 then
				self.statuspool:registerPassiveskill(total_skill_data[self._skilllist["skill" .. var_15_2].id]["skill" .. 1])
			end
		end

		var_15_2 = var_15_2 + 1
	end
end

function PlayerCharacter:unregisterPassiveSkill()
	local var_16_0 = total_skill_data[self:getAttribute("passiveskill")]
	local var_16_1 = 1

	while var_16_0["skill" .. var_16_1] do
		self.statuspool:unregisterPassiveskill(var_16_0["skill" .. var_16_1])

		var_16_1 = var_16_1 + 1
	end

	local var_16_2 = 1

	while self._skilllist["skill" .. var_16_2] do
		while total_skill_data[self._skilllist["skill" .. var_16_2].id]["skill" .. 1] do
			if skill_data[total_skill_data[self._skilllist["skill" .. var_16_2].id]["skill" .. 1]].skill_type == 0 then
				self.statuspool:unregisterPassiveskill(total_skill_data[self._skilllist["skill" .. var_16_2].id]["skill" .. 1])
			end
		end

		var_16_2 = var_16_2 + 1
	end
end

function PlayerCharacter:registerSPSkill()
	local var_17_0 = self:getAttribute("spskill")

	if not var_17_0 then
		return
	end

	local var_17_1 = total_skill_data[var_17_0]

	while var_17_1["skill" .. 1] do
		self.statuspool:registerPassiveskill(var_17_1["skill" .. 1])
	end
end

function PlayerCharacter:unregisterSPSkill()
	local var_18_0 = self:getAttribute("spskill")

	if not var_18_0 then
		return
	end

	local var_18_1 = total_skill_data[var_18_0]

	while var_18_1["skill" .. 1] do
		self.statuspool:unregisterPassiveskill(var_18_1["skill" .. 1])
	end
end

function PlayerCharacter:registerOCSkill()
	local var_19_0 = self:getAttribute("ocskill")

	print("registerOCSkill: ", self.index, var_19_0)

	if not var_19_0 then
		return
	end

	local var_19_1 = total_skill_data[var_19_0]

	while var_19_1["skill" .. 1] do
		self.statuspool:registerPassiveskill(var_19_1["skill" .. 1])
	end
end

function PlayerCharacter:unregisterOCSkill()
	local var_20_0 = self:getAttribute("ocskill")

	if not var_20_0 then
		return
	end

	local var_20_1 = total_skill_data[var_20_0]

	while var_20_1["skill" .. 1] do
		self.statuspool:unregisterPassiveskill(var_20_1["skill" .. 1])
	end
end

function PlayerCharacter:registerEXSkill()
	local var_21_0 = self:getAttribute("exskill")

	if not var_21_0 then
		return
	end

	local var_21_1 = total_skill_data[var_21_0]

	while var_21_1["skill" .. 1] do
		self.statuspool:registerPassiveskill(var_21_1["skill" .. 1])
	end
end

function PlayerCharacter:unregisterEXSkill()
	local var_22_0 = self:getAttribute("exskill")

	if not var_22_0 then
		return
	end

	local var_22_1 = total_skill_data[var_22_0]

	while var_22_1["skill" .. 1] do
		self.statuspool:unregisterPassiveskill(var_22_1["skill" .. 1])
	end
end

function PlayerCharacter:registerWeaponSkill()
	if self.weapon_skill then
		assert(total_skill_data[self.weapon_skill], self.weapon_skill)

		while total_skill_data[self.weapon_skill]["skill" .. 1] do
			self.statuspool:registerPassiveskill(total_skill_data[self.weapon_skill]["skill" .. 1])
		end
	end
end

function PlayerCharacter:unregisterWeaponSkill()
	if self.weapon_skill then
		while total_skill_data[self.weapon_skill]["skill" .. 1] do
			self.statuspool:unregisterPassiveskill(total_skill_data[self.weapon_skill]["skill" .. 1])
		end
	end
end

function PlayerCharacter:registerBondSkill()
	if self.bond_skillList then
		for iter_25_0 = 1, #self.bond_skillList do
			assert(total_skill_data[self.bond_skillList[iter_25_0]], self.bond_skillList[iter_25_0])

			while total_skill_data[self.bond_skillList[iter_25_0]]["skill" .. 1] do
				self.statuspool:registerPassiveskill(total_skill_data[self.bond_skillList[iter_25_0]]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:unregisterBondSkill()
	if self.bond_skillList then
		for iter_26_0 = 1, #self.bond_skillList do
			assert(total_skill_data[self.bond_skillList[iter_26_0]], self.bond_skillList[iter_26_0])

			while total_skill_data[self.bond_skillList[iter_26_0]]["skill" .. 1] do
				self.statuspool:unregisterPassiveskill(total_skill_data[self.bond_skillList[iter_26_0]]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:registerExpeditionSkill()
	if self.expedition_skillList then
		for iter_27_0 = 1, #self.expedition_skillList do
			assert(total_skill_data[self.expedition_skillList[iter_27_0]], self.expedition_skillList[iter_27_0])

			while total_skill_data[self.expedition_skillList[iter_27_0]]["skill" .. 1] do
				self.statuspool:registerPassiveskill(total_skill_data[self.expedition_skillList[iter_27_0]]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:unregisterExpeditionSkill()
	if self.expedition_skillList then
		for iter_28_0 = 1, #self.expedition_skillList do
			assert(total_skill_data[self.expedition_skillList[iter_28_0]], self.expedition_skillList[iter_28_0])

			while total_skill_data[self.expedition_skillList[iter_28_0]]["skill" .. 1] do
				self.statuspool:unregisterPassiveskill(total_skill_data[self.expedition_skillList[iter_28_0]]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:registerAssistSkill()
	if self._assistconfig then
		for iter_29_0, iter_29_1 in pairs(self._assistconfig.skills) do
			while total_skill_data[iter_29_1]["skill" .. 1] do
				self.statuspool:registerAssistMain(total_skill_data[iter_29_1]["skill" .. 1])
			end
		end

		if self._assistconfig.typeskill then
			while total_skill_data[self._assistconfig.typeskill]["skill" .. 1] do
				self.statuspool:registerAssistMain(total_skill_data[self._assistconfig.typeskill]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:unregisterAssistSkill()
	if self._assistconfig then
		for iter_30_0, iter_30_1 in pairs(self._assistconfig.skills) do
			while total_skill_data[iter_30_1]["skill" .. 1] do
				self.statuspool:unregisterAssistMain(total_skill_data[iter_30_1]["skill" .. 1])
			end
		end

		if self._assistconfig.typeskill then
			while total_skill_data[self._assistconfig.typeskill]["skill" .. 1] do
				self.statuspool:unregisterAssistMain(total_skill_data[self._assistconfig.typeskill]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:registerComponentEffect()
	if self._componenteffect then
		self.statuspool:registerComponentEffect(self._componenteffect)
	end
end

function PlayerCharacter:unregisterComponentEffect()
	if self._componenteffect then
		self.statuspool:unregisterComponentEffect(self._componenteffect)
	end
end

function PlayerCharacter:registerReinforceComponentEffect()
	if self._reinforce_component then
		self.statuspool:registerReinforceComponentEffect(self._reinforce_component)
	end
end

function PlayerCharacter:unregisterReinforceComponentEffect()
	if self._reinforce_component then
		self.statuspool:unregisterReinforceComponentEffect(self._reinforce_component)
	end
end

function PlayerCharacter:registerUpgradeSkill()
	local var_35_0 = self:getAttribute("upgradeskills")

	if not var_35_0 then
		return
	end

	if not next(var_35_0) then
		return
	end

	for iter_35_0, iter_35_1 in pairs(var_35_0) do
		while total_skill_data[iter_35_1]["skill" .. 1] do
			self.statuspool:registerPassiveskill(total_skill_data[iter_35_1]["skill" .. 1])
		end
	end
end

function PlayerCharacter:unregisterUpgradeSkill()
	local var_36_0 = self:getAttribute("upgradeskills")

	if not var_36_0 then
		return
	end

	if not next(var_36_0) then
		return
	end

	for iter_36_0, iter_36_1 in pairs(var_36_0) do
		while total_skill_data[iter_36_1]["skill" .. 1] do
			self.statuspool:unregisterPassiveskill(total_skill_data[iter_36_1]["skill" .. 1])
		end
	end
end

function PlayerCharacter:registerExploreSkill()
	if self.explore_buffs then
		for iter_37_0, iter_37_1 in pairs(self.explore_buffs) do
			while total_skill_data[iter_37_1]["skill" .. 1] do
				self.statuspool:registerPassiveskill(total_skill_data[iter_37_1]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:unregisterExploreSkill()
	if self.explore_buffs then
		for iter_38_0, iter_38_1 in pairs(self.explore_buffs) do
			while total_skill_data[iter_38_1]["skill" .. 1] do
				self.statuspool:unregisterPassiveskill(total_skill_data[iter_38_1]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:registerBattleFieldStatus()
	if self._battlefieldstatus then
		for iter_39_0, iter_39_1 in ipairs(self._battlefieldstatus) do
			self.statuspool:registerBattleFieldStatus(iter_39_1)
		end
	end
end

function PlayerCharacter:unregisterBattleFieldStatus()
	if self._battlefieldstatus then
		for iter_40_0, iter_40_1 in ipairs(self._battlefieldstatus) do
			self.statuspool:unregisterBattleFieldStatus(iter_40_1)
		end
	end
end

function PlayerCharacter:registerTestSkills()
	local var_41_0 = self:getAttribute("testSkills")

	if not var_41_0 or not next(var_41_0) then
		return
	end

	for iter_41_0, iter_41_1 in pairs(var_41_0) do
		while total_skill_data[iter_41_1]["skill" .. 1] do
			self.statuspool:registerPassiveskill(total_skill_data[iter_41_1]["skill" .. 1])
		end
	end
end

function PlayerCharacter:registerTeamSkill()
	for iter_42_0, iter_42_1 in pairs((self:getAttribute("teamskill"))) do
		while total_skill_data[iter_42_1]["skill" .. 1] do
			self.statuspool:registerPassiveskill(total_skill_data[iter_42_1]["skill" .. 1])
		end
	end
end

function PlayerCharacter:unregisterTeamSkill()
	for iter_43_0, iter_43_1 in pairs((self:getAttribute("teamskill"))) do
		while total_skill_data[iter_43_1]["skill" .. 1] do
			self.statuspool:unregisterPassiveskill(total_skill_data[iter_43_1]["skill" .. 1])
		end
	end
end

function PlayerCharacter:leaveFight()
	if self:getStatus() ~= STATE_DIED then
		self:setStatus(STATE_DIED)
		FightManager.call("die", self.index)
		FightManager.playerdie(self)
	end

	FightManager.playerleave(self)
end

function PlayerCharacter:resetOnSoulChange()
	if self:getStatus() ~= STATE_DIED then
		self:setStatus(STATE_DIED)
		FightManager.call("die", self.index)
		FightManager.playerdie(self)
		self:playIdle()
	end
end

function PlayerCharacter:resetOnWeaponChange(arg_46_1)
	self.model:changePlayerWeapon(arg_46_1)
	self.logic:resetCfg()
	self:resetSkeleton()

	self._movingForward = nil

	self:removeRushingForward()

	self._running = false
	self._lockmove = false
	self._playing = nil

	if self:getStatus() == STATUS_DIED then
		self._replaydie = true
	elseif self:getStatus() == STATUS_REVIVAL then
		self._replaydie = true
	elseif self:getStatus() == STATUS_FIGHTWIN then
		self._wining = false
		self._lock = false
	end
end

function PlayerCharacter:resetOnClothesChange(arg_47_1)
	self.model:changePlayerClothes(arg_47_1)
	self:resetSkeleton()

	self._movingForward = nil
	self._rushingForward = nil
	self._running = false
	self._lockmove = false
	self._playing = nil
end

function PlayerCharacter:resetOnDressChange(arg_48_1)
	self.model:changePlayerDress(arg_48_1)
	self:resetSkeleton()

	self._movingForward = nil
	self._rushingForward = nil
	self._running = false
	self._lockmove = false
	self._playing = nil
end

function PlayerCharacter.updateSkillCD(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	print("updateSkillCD in PlayerCharacter is deprecated!!!")
end

function PlayerCharacter:updateXPRageToPlayerItem(arg_50_1)
	if self.playerItem then
		self.playerItem:updateRage(arg_50_1, self:getAttribute("rage"))
	end
end

function PlayerCharacter:relive()
	if self.playerItem then
		self.playerItem:relive()
	end
end

function PlayerCharacter.initNormalAniListener(arg_52_0)
	return
end

function PlayerCharacter.initExploreBuff(arg_53_0, arg_53_1)
	arg_53_0.explore_buffs = arg_53_1
end

function PlayerCharacter.initBondSkill(arg_54_0, arg_54_1)
	arg_54_0.bond_skillList = arg_54_1.skillList
end

function PlayerCharacter.initExpeditionSkill(arg_55_0, arg_55_1)
	arg_55_0.expedition_skillList = arg_55_1.skillList
end

function PlayerCharacter:initWeaponSkill(arg_56_1)
	self.weapon_skill = arg_56_1.passiveSkill
	self.weapon_skill1 = arg_56_1.skill1

	self.model:updateWeaponAttr(arg_56_1)
	self.logic:resetCfg()
	self.skilllogic:resetCfg()

	local var_56_0 = var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))

	self.model:setAttribute("singlehp", var_56_0)
	self.model:addAttribute("equipsinglehp", var_56_0 - self.model:getAttribute("singlehp"))
	self.model:setAttribute("curhp", (var_0_0.round(self:getAttribute("singlehp") * (self.model:getAttribute("curhp") / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end
end

function PlayerCharacter:initArenaEnemyHorcruxDevour()
	local var_57_0 = {
		damage = 0,
		hp = 0
	}
	local var_57_1 = getArenaEnemyHorcruxDevour((self.model:getAttribute("servantid")))

	for iter_57_0 = 1, HORCRUX_DEVOUR_MAX do
		if next(var_57_1[iter_57_0]) and not var_57_1[iter_57_0].disable then
			var_57_0.damage = var_57_0.damage + var_57_1[iter_57_0].damage
			var_57_0.hp = var_57_0.hp + var_57_1[iter_57_0].hp
		end
	end

	self.model:updateAssistAttr(var_57_0)

	local var_57_2 = var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))

	self.model:setAttribute("singlehp", var_57_2)
	self.model:addAttribute("equipsinglehp", var_57_2 - self:getAttribute("singlehp"))
	self.model:setAttribute("curhp", (var_0_0.round(self:getAttribute("singlehp") * (self.model:getAttribute("curhp") / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end

	self:initArenaEnemyHorcruxDevourSkill()
end

function PlayerCharacter:initHorcruxDevour()
	local var_58_0 = self.model:getAttribute("servantid")
	local var_58_1 = require("controller/horcrux_devour/horcrux_devour_manager"):getInstance()
	local var_58_2 = {
		damage = 0,
		hp = 0
	}
	local var_58_3 = var_58_1:getHorcruxDevourData(var_58_0)

	for iter_58_0 = 1, HORCRUX_DEVOUR_MAX do
		if next(var_58_3[iter_58_0]) and not var_58_3[iter_58_0].disable and var_58_1:isUnlock(var_58_0, iter_58_0) then
			var_58_2.damage = var_58_2.damage + var_58_3[iter_58_0].damage
			var_58_2.hp = var_58_2.hp + var_58_3[iter_58_0].hp
		end
	end

	self.model:updateAssistAttr(var_58_2)

	local var_58_4 = var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))

	self.model:setAttribute("singlehp", var_58_4)
	self.model:addAttribute("equipsinglehp", var_58_4 - self:getAttribute("singlehp"))
	self.model:setAttribute("curhp", (var_0_0.round(self:getAttribute("singlehp") * (self.model:getAttribute("curhp") / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end

	self:initHorcruxDevourSkill()
end

function PlayerCharacter:getBattleAssist()
	return self._assistconfig
end

function PlayerCharacter:initBattleAssist(arg_60_1, arg_60_2, arg_60_3)
	self._assistconfig = arg_60_1

	if self._assistconfig then
		self._assistconfig.entityid = arg_60_3
	end

	self._assist = FightHorcrux.new(arg_60_2, arg_60_3, arg_60_1 and arg_60_1.skills)

	self:updateAssistAttr(self._assistconfig)
end

function PlayerCharacter:initBattleFieldStatus(arg_61_1)
	self._battlefieldstatus = nil

	if not arg_61_1 then
		return
	end

	for iter_61_0, iter_61_1 in ipairs(arg_61_1) do
		if self:canTriggerBattleFieldStatus(battlefield_status_data[iter_61_1]) then
			while battlefield_status_data[iter_61_1]["skill" .. 1] do
				self._battlefieldstatus = self._battlefieldstatus or {}

				var_0_2.insert(self._battlefieldstatus, battlefield_status_data[iter_61_1]["skill" .. 1])
			end
		end
	end
end

function PlayerCharacter:canTriggerBattleFieldStatus(arg_62_1)
	if arg_62_1.targetside == 2 then
		return false
	end

	if arg_62_1.targetattacktype == 1 then
		if self:getAttribute("range") >= 200 then
			return false
		end
	elseif arg_62_1.targetattacktype == 2 and self:getAttribute("range") < 200 then
		return false
	end

	if arg_62_1.targetcareer and arg_62_1.targetcareer ~= self:getAttribute("career") then
		return false
	end

	if arg_62_1.targetsoulid and arg_62_1.targetsoulid ~= self:getAttribute("soulid") then
		return false
	end

	if arg_62_1.targetattr and not self:checkAttrValid(arg_62_1.targetattr) then
		return false
	end

	if arg_62_1.targetmodelid and arg_62_1.targetmodelid ~= self:getAttribute("modelid") then
		return false
	end

	if arg_62_1.targetmodeltype and arg_62_1.targetmodeltype ~= self:getAttribute("modeltype") then
		return false
	end

	return true
end

function PlayerCharacter:initArenaEnemyHorcruxDevourSkill()
	self._arenaEnemyHorcruxDevourSkill = {}

	local var_63_0 = self.model:getAttribute("servantid")
	local var_63_1 = getArenaEnemyHorcruxDevour(var_63_0)
	local horcrux_manager = require("controller/horcrux_manager")
	local var_63_3 = require("controller/horcrux_devour/horcrux_devour_manager"):getInstance()

	for iter_63_0 = 1, HORCRUX_DEVOUR_MAX do
		if next(var_63_1[iter_63_0]) and not var_63_1[iter_63_0].disable then
			local var_63_4 = {}

			if var_63_1[iter_63_0].skillid and var_63_1[iter_63_0].skillid > 0 then
				var_0_2.insert(var_63_4, var_63_1[iter_63_0].skillid)
			end

			if var_63_1[iter_63_0].skillid2 and var_63_1[iter_63_0].skillid2 > 0 then
				var_0_2.insert(var_63_4, var_63_1[iter_63_0].skillid2)
			end

			if var_63_1[iter_63_0].itemid and var_63_3:hasHorcruxRaceTypeSkillByItemId(var_63_0, var_63_1[iter_63_0].itemid) then
				var_0_2.insert(var_63_4, horcrux_manager:getTypeSkillByItemid(var_63_1[iter_63_0].itemid))
			end

			for iter_63_1, iter_63_2 in pairs(var_63_4) do
				while total_skill_data[iter_63_2]["skill" .. 1] do
					var_0_2.insert(self._arenaEnemyHorcruxDevourSkill, total_skill_data[iter_63_2]["skill" .. 1])
				end
			end
		end
	end
end

function PlayerCharacter:registerArenaEnemyHorcruxDevourSkill()
	if self._arenaEnemyHorcruxDevourSkill then
		for iter_64_0, iter_64_1 in ipairs(self._arenaEnemyHorcruxDevourSkill) do
			self.statuspool:registerPassiveskill(iter_64_1)
		end
	end
end

function PlayerCharacter:unregisterArenaEnemyHorcruxDevourSkill()
	if self._arenaEnemyHorcruxDevourSkill then
		for iter_65_0, iter_65_1 in ipairs(self._arenaEnemyHorcruxDevourSkill) do
			self.statuspool:registerBattleFieldStatus(iter_65_1)
		end
	end
end

function PlayerCharacter:initHorcruxDevourSkill()
	self._horcruxDevourSkill = {}

	local horcrux_manager = require("controller/horcrux_manager")
	local horcrux_devour_manager = require("controller/horcrux_devour/horcrux_devour_manager")
	local var_66_2 = horcrux_devour_manager:getInstance()
	local var_66_3 = self.model:getAttribute("servantid")
	local var_66_4 = var_66_2:getHorcruxDevourData(horcrux_devour_manager)

	for iter_66_0 = 1, HORCRUX_DEVOUR_MAX do
		if next(var_66_4[iter_66_0]) and not var_66_4[iter_66_0].disable and var_66_2:isUnlock(var_66_3, iter_66_0) then
			local var_66_5 = {}

			if var_66_4[iter_66_0].skillid and var_66_4[iter_66_0].skillid > 0 then
				var_0_2.insert(var_66_5, var_66_4[iter_66_0].skillid)
			end

			if var_66_4[iter_66_0].skillid2 and var_66_4[iter_66_0].skillid2 > 0 then
				var_0_2.insert(var_66_5, var_66_4[iter_66_0].skillid2)
			end

			if var_66_4[iter_66_0].horcrux and var_66_2:hasHorcruxRaceTypeSkill(var_66_3, var_66_4[iter_66_0].horcrux) then
				var_0_2.insert(var_66_5, (horcrux_manager:getTypeSkillByEntityid(var_66_4[iter_66_0].horcrux)))
			end

			for iter_66_1, iter_66_2 in pairs(var_66_5) do
				while total_skill_data[iter_66_2] and total_skill_data[iter_66_2]["skill" .. 1] do
					var_0_2.insert(self._horcruxDevourSkill, total_skill_data[iter_66_2]["skill" .. 1])
				end
			end
		end
	end
end

function PlayerCharacter:registerHorcruxDevourSkill()
	if self._horcruxDevourSkill then
		for iter_67_0, iter_67_1 in ipairs(self._horcruxDevourSkill) do
			self.statuspool:registerPassiveskill(iter_67_1)
		end
	end
end

function PlayerCharacter:unregisterHorcruxDevourSkill()
	if self._horcruxDevourSkill then
		for iter_68_0, iter_68_1 in ipairs(self._horcruxDevourSkill) do
			self.statuspool:registerBattleFieldStatus(iter_68_1)
		end
	end
end

function PlayerCharacter:initTowerSkills(arg_69_1)
	if not arg_69_1 then
		return
	end

	self._towerField = {}

	for iter_69_0, iter_69_1 in ipairs(arg_69_1) do
		self._towerField[#self._towerField + 1] = iter_69_1.skillId
	end
end

function PlayerCharacter:registerTowerSkill()
	if self._towerField then
		for iter_70_0, iter_70_1 in ipairs(self._towerField) do
			self.statuspool:registerPassiveskill(iter_70_1)
		end
	end
end

function PlayerCharacter:unregisterTowerSkill()
	if self._towerField then
		for iter_71_0, iter_71_1 in ipairs(self._towerField) do
			self.statuspool:registerBattleFieldStatus(iter_71_1)
		end
	end
end

function PlayerCharacter:initSupermarketPrivilegeSkills(arg_72_1)
	if not arg_72_1 then
		return
	end

	self._supermarketPrivilegeField = {}

	for iter_72_0, iter_72_1 in ipairs(arg_72_1) do
		self._supermarketPrivilegeField[#self._supermarketPrivilegeField + 1] = iter_72_1.skillId
	end
end

function PlayerCharacter:registerSupermarketPrivilegeSkill()
	if self._supermarketPrivilegeField then
		for iter_73_0, iter_73_1 in ipairs(self._supermarketPrivilegeField) do
			self.statuspool:registerPassiveskill(iter_73_1)
		end
	end
end

function PlayerCharacter:unregisterSupermarketPrivilegeSkill()
	if self._supermarketPrivilegeField then
		for iter_74_0, iter_74_1 in ipairs(self._supermarketPrivilegeField) do
			self.statuspool:unregisterPassiveskill(iter_74_1)
		end
	end
end

function PlayerCharacter:initMonoPolySkills(arg_75_1)
	if not arg_75_1 then
		return
	end

	if not next(arg_75_1) then
		return
	end

	self._monopolyskills = {}

	for iter_75_0, iter_75_1 in ipairs(arg_75_1) do
		var_0_2.insert(self._monopolyskills, iter_75_1)
	end
end

function PlayerCharacter:registerMonoPolySkill()
	if not self._monopolyskills then
		return
	end

	for iter_76_0, iter_76_1 in ipairs(self._monopolyskills) do
		self.statuspool:registerPassiveskill(tonumber(iter_76_1))
	end
end

function PlayerCharacter:unregisterMonoPolySkill()
	if not self._monopolyskills then
		return
	end

	for iter_77_0, iter_77_1 in ipairs(self._monopolyskills) do
		self.statuspool:unregisterPassiveskill(tonumber(iter_77_1))
	end
end

function PlayerCharacter:initFlyChessSkills(arg_78_1)
	if not arg_78_1 then
		return
	end

	if not next(arg_78_1) then
		return
	end

	self._flychessskills = {}

	for iter_78_0, iter_78_1 in ipairs(arg_78_1) do
		var_0_2.insert(self._flychessskills, iter_78_1)
	end
end

function PlayerCharacter:registerFlyChessSkill()
	if not self._flychessskills then
		return
	end

	for iter_79_0, iter_79_1 in ipairs(self._flychessskills) do
		self.statuspool:registerPassiveskill(tonumber(iter_79_1))
	end
end

function PlayerCharacter:unregisterFlyChessSkill()
	if not self._flychessskills then
		return
	end

	for iter_80_0, iter_80_1 in ipairs(self._flychessskills) do
		self.statuspool:unregisterPassiveskill(tonumber(iter_80_1))
	end
end

function PlayerCharacter:useXP()
	self:cleanAllFightHandlers()
	self:play("idle_fight", false)

	self._running = false

	self:setSpeed(0)

	self._movingForward = nil

	self:removeRushingForward()

	self._crossing = nil
	self._crashing = nil

	self.logic:resetToXP()
	FightManager.addClickXPCount()
end

function PlayerCharacter:useSkillManual(arg_82_1)
	self:cleanAllFightHandlers()

	self._running = false

	self:setSpeed(0)

	self._movingForward = nil

	self:removeRushingForward()

	self._crossing = nil
	self._crashing = nil

	self.logic:resetToSkill(arg_82_1)

	if arg_82_1 == "xp" then
		FightManager.addClickXPCount()
	end
end

function PlayerCharacter.changeFightType(arg_83_0, arg_83_1)
	playermodel.autoXP = arg_83_1
end

function PlayerCharacter:checkXPStatus()
	if self.charactertype ~= "player" then
		return false
	end

	if self._globallock then
		return false
	end

	if self._pause then
		return false
	end

	if playermodel.autoXP then
		global_ShowBlockWords("学员自动战斗中")

		return false
	end

	if self:getStatus() ~= STATUS_FIGHTING then
		return false
	end

	if xp_effect_manager.isXPNow() then
		return false
	end

	if not self:check_basic_xp_distance() then
		return false
	end

	if not self:canCharacterFight() then
		return false
	end

	if self.statuspool:checkStatus("addict") then
		return false
	end

	if self.statuspool:checkStatus("silence") then
		global_ShowBlockWords("沉默中……")

		return false
	elseif self.statuspool:checkStatus("ragefree") then
		return true
	elseif self:getAttribute("rage") >= self:getAttribute("maxrage") then
		return true
	else
		global_ShowBlockWords("怒气不足")

		return false
	end
end

function PlayerCharacter:checkXPStatusOnTower()
	if self.charactertype ~= "player" then
		return false
	end

	if self._globallock then
		return false
	end

	if self._pause then
		return false
	end

	if playermodel.autoXP then
		global_ShowBlockWords("学员自动战斗中")

		return false
	end

	if self:getStatus() ~= STATUS_FIGHTING then
		return false
	end

	if xp_effect_manager.isXPNow() then
		return false
	end

	if not self:check_basic_xp_distance() then
		return false
	end

	if not self:canCharacterFight() then
		return false
	end

	if self.statuspool:checkStatus("addict") then
		return false
	end

	if self.statuspool:checkStatus("silence") then
		global_ShowBlockWords("沉默中……")

		return false
	elseif self.statuspool:checkStatus("ragefree") then
		return false
	elseif self:getAttribute("rage") >= self:getAttribute("maxrage") then
		return true
	else
		return true
	end
end

function PlayerCharacter:checkSkillStatus(arg_86_1)
	if self.charactertype ~= "player" then
		return false
	end

	if arg_86_1 == "xp" then
		return self:checkXPStatus()
	end

	if playermodel.autoXP then
		global_ShowBlockWords("学员自动战斗中")

		return false
	end

	if self:getStatus() ~= STATUS_FIGHTING then
		return false
	end

	if not self:check_basic_skill_distance(arg_86_1) then
		return false
	end

	if not self:canCharacterFight() then
		return false
	end

	if self.statuspool:checkStatus("silence") then
		global_riseWord("沉默中……")

		return false
	elseif self:canSkillCDEnable(arg_86_1) then
		return true
	else
		global_ShowBlockWords("技能还未冷却")

		return false
	end
end

function PlayerCharacter.onPlayerFightBoss(arg_87_0)
	return
end

function PlayerCharacter:playerResetHP(arg_88_1)
	arg_88_1 = arg_88_1 or 1

	self:setAttribute("curhp", self:getAttribute("singlehp"))
	self:setAttribute("curhpcount", self:getAttribute("hpcount"))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):resetBar()
	end
end

function PlayerCharacter:onPlayerUpdateListener()
	self.model:updatePlayerModel()
	self.model:setAttribute("singlehp", (var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))))
	self.model:setAttribute("curhp", (var_0_0.floor(self:getAttribute("singlehp") * (self.model:getAttribute("curhp") / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end
end

function PlayerCharacter:onPlayerAssistChangeListener(arg_90_1)
	if self._assist and self._assist:isSame(arg_90_1) then
		self._assistconfig = horcrux_manager:getHorcruxAssistConfig(arg_90_1)

		self:updateAssistAttr(self._assistconfig)
	else
		if self:getStatus() ~= STATUS_DIED then
			self:unregisterAssistSkill()
		end

		self._assistconfig = horcrux_manager:getHorcruxAssistConfig(arg_90_1)
		self._assist = FightHorcrux.new(horcrux_manager:getHorcruxItemid(arg_90_1), arg_90_1, self._assistconfig and self._assistconfig.skills)

		self:updateAssistAttr(self._assistconfig)

		if self:getStatus() ~= STATUS_DIED then
			self:registerAssistSkill()
		end
	end
end

function PlayerCharacter:updateComponentAttr(arg_91_1)
	self.model:updateComponentAttr(arg_91_1)

	if arg_91_1.effect ~= self._componenteffect then
		if self.index and self:getStatus() ~= STATUS_DIED then
			self:unregisterComponentEffect()

			self._componenteffect = arg_91_1.effect

			self:registerComponentEffect()
		else
			self._componenteffect = arg_91_1.effect
		end
	end

	local var_91_0 = arg_91_1.reinforce_component

	if arg_91_1.reinforce_component ~= self._reinforce_component then
		if self.index and self:getStatus() ~= STATUS_DIED then
			self:unregisterReinforceComponentEffect()

			self._reinforce_component = var_91_0

			self:registerReinforceComponentEffect()
		else
			self._reinforce_component = var_91_0
		end
	end

	local var_91_1 = self:getAttribute("singlehp")
	local var_91_2 = var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))

	self.model:setAttribute("singlehp", var_91_2)
	self.model:addAttribute("equipsinglehp", var_91_2 - var_91_1)
	self.model:setAttribute("curhp", (var_0_0.round(self:getAttribute("singlehp") * (self.model:getAttribute("curhp") / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end
end

function PlayerCharacter:updateHelpBattle(arg_92_1)
	self.model:updateHelpBattle(arg_92_1)

	local var_92_0 = var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))

	self.model:setAttribute("singlehp", var_92_0)
	self.model:addAttribute("equipsinglehp", var_92_0 - self:getAttribute("singlehp"))
	self.model:setAttribute("curhp", (var_0_0.round(self:getAttribute("singlehp") * (self.model:getAttribute("curhp") / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end
end

function PlayerCharacter:updateArenaEnemyHelpBattle()
	self.model:updateArenaEnemyHelpBattle()

	local var_93_0 = var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))

	self.model:setAttribute("singlehp", var_93_0)
	self.model:addAttribute("equipsinglehp", var_93_0 - self:getAttribute("singlehp"))
	self.model:setAttribute("curhp", (var_0_0.round(self:getAttribute("singlehp") * (self.model:getAttribute("curhp") / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end
end

function PlayerCharacter:updateAssistAttr(arg_94_1)
	local var_94_0 = {
		damage = 0,
		hp = 0
	}

	if arg_94_1 then
		local var_94_1 = horcrux_manager:getServantAttrAddPercent(ATTR_ID[arg_94_1.attr], self:getAttribute("allAttrs"))

		var_94_0.damage = arg_94_1.damage * var_94_1.damage
		var_94_0.hp = arg_94_1.hp * var_94_1.hp
	end

	local var_94_2 = self.model:getAttribute("curhp")

	self.model:updateAssistAttr(var_94_0)

	local var_94_3 = var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))

	self.model:setAttribute("singlehp", var_94_3)
	self.model:addAttribute("equipsinglehp", var_94_3 - self:getAttribute("singlehp"))
	self.model:setAttribute("curhp", (var_0_0.round(self:getAttribute("singlehp") * (var_94_2 / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end
end

function PlayerCharacter:onPlayerWeaponskillChangeListener(arg_95_1)
	if self:getStatus() ~= STATUS_DIED then
		self:unregisterWeaponSkill()
	end

	self.weapon_skill = arg_95_1.passiveSkill
	self.weapon_skill1 = arg_95_1.skill1
	self.weapon_XP = arg_95_1.XP

	if self.weapon_XP then
		self:updateXPSkill(arg_95_1.XP)
	else
		self:updateXPSkill(self.model:getAttribute("xpskill"))
	end

	if self.weapon_skill1 then
		self:updateSkillList({
			self.weapon_skill1
		})
	else
		self:updateSkillList(self.model:getAttribute("skills"))
	end

	local var_95_0 = self.model:getAttribute("curhp")

	self.model:updateWeaponAttr(arg_95_1)
	self.logic:resetCfg()
	self.skilllogic:resetCfg()

	local var_95_1 = var_0_0.floor(self:getAttribute("hp") / self:getAttribute("hpcount"))

	self.model:setAttribute("singlehp", var_95_1)
	self.model:addAttribute("equipsinglehp", var_95_1 - self:getAttribute("singlehp"))
	self.model:setAttribute("curhp", (var_0_0.round(self:getAttribute("singlehp") * (var_95_0 / self.model:getAttribute("singlehp")))))

	if self.hpbar then
		self.hpbar:getChildByName("hpbar"):setTotalHp(self.model:getAttribute("singlehp"))
		self.hpbar:getChildByName("hpbar"):setCurHp(self.model:getAttribute("curhp"))
	end

	if self:getStatus() ~= STATUS_DIED then
		self:registerWeaponSkill()
	end
end

function PlayerCharacter:updateSkillLevel(arg_96_1, arg_96_2)
	if self.model:getAttribute("passiveLevel") ~= arg_96_1 then
		if self:getStatus() ~= STATUS_DIED then
			self:unregisterPassiveSkill()
		end

		self.model:updateSkills(SKILL_PASSIVE)

		if self:getStatus() ~= STATUS_DIED then
			self:registerPassiveSkill()
		end
	elseif self.model:getAttribute("skill1Level") ~= arg_96_2 then
		self.model:updateSkills(SKILL_SKILL1)

		if self.weapon_skill1 then
			self.weapon_skill1 = require("controller.weapon_mananger"):getWeaponConfig(playermodel.items[playermodel.weaponId[self.model:getAttribute("servantid")]], playermodel.skill1Level[self.model:getAttribute("servantid")]).skill1

			self:updateSkillList({
				self.weapon_skill1
			})
		else
			self:updateSkillList(self.model:getAttribute("skills"))
		end
	end
end

local function var_0_12(arg_97_0, arg_97_1)
	arg_97_0:keepMoving()
end

local function var_0_13(arg_98_0, arg_98_1)
	arg_98_0:setStatus(STATUS_FIGHTING)
	arg_98_0:runFight()
	arg_98_0.hpbar:setVisible(not FightManager.isNormalFight() or FightManager.isFightingBoss())
end

local function var_0_14(arg_99_0, arg_99_1)
	if arg_99_0._lockturnbacklimit then
		return
	end

	if not arg_99_0._turnbackLimit and arg_99_0.target and type(arg_99_0.target) == "string" then
		local var_99_0 = arg_99_0:getTarget()

		if var_99_0 then
			local var_99_1 = var_99_0:getStandardPosition()

			arg_99_0:switchDirection(arg_99_0.charactertype == "player" and (var_99_1 >= arg_99_0:getStandardPosition() and 1 or -1) or var_99_1 > arg_99_0:getStandardPosition() and 1 or -1)
		end
	end
end

local function var_0_15(arg_100_0, arg_100_1)
	if arg_100_0._pause then
		return
	end

	if arg_100_0._usingXP then
		return
	end

	if arg_100_0._fightforce then
		return
	end

	if arg_100_0._carriedconf then
		return
	end

	if arg_100_0._godie then
		arg_100_0._replaydie = false

		FightManager.triggerEnemyDied(arg_100_0)

		if arg_100_0._assist then
			arg_100_0._assist:onPlayerDied()
		end

		arg_100_0:unregisterStatusPool()
		arg_100_0:cleanAllBuffs()
		FightManager.call("die", arg_100_0.index)
		arg_100_0:finishFight()

		if arg_100_0.charactertype == "player" then
			if arg_100_0.playerItem then
				arg_100_0.playerItem:updateSkillCD(3)
			end

			FightManager.playerdie(arg_100_0)
		else
			FightManager.enemydie(arg_100_0)
		end

		arg_100_0.skeleton:setTimeScale(1)
		arg_100_0:playDieAni()

		if arg_100_0.hpbar then
			arg_100_0.hpbar:setVisible(false)
		end

		arg_100_0:hideBuffEffect()

		arg_100_0._godie = false
	else
		arg_100_0:stopMoving()
	end

	if arg_100_0._replaydie then
		arg_100_0._replaydie = false

		arg_100_0.skeleton:setTimeScale(1)
		arg_100_0:play("die", false)
	end
end

local function var_0_16(arg_101_0, arg_101_1)
	if arg_101_0._pause then
		return
	end

	if arg_101_0._usingXP then
		return
	end

	if arg_101_0._fightforce ~= nil then
		return
	end

	if arg_101_0._carriedconf then
		return
	end

	if arg_101_0._godie then
		arg_101_0._replaydie = false

		arg_101_0:shutDown()
		arg_101_0:shutDownSlaves()
		arg_101_0:playDieAni()

		if arg_101_0.hpbar then
			arg_101_0.hpbar:setVisible(false)
		end

		arg_101_0:hideBuffEffect()

		arg_101_0._godie = false
	else
		arg_101_0:stopMoving()
	end

	if arg_101_0._replaydie then
		arg_101_0._replaydie = false

		arg_101_0.skeleton:setTimeScale(1)
		arg_101_0:play("die", false)
	end
end

local function var_0_17(arg_102_0, arg_102_1)
	if arg_102_0._playing then
		return
	end

	if arg_102_0._suppress then
		return
	end

	arg_102_0:finishFight()
	arg_102_0:switchDirection(arg_102_0.charactertype == "player" and 1 or -1)
	arg_102_0:setStatus(STATUS_SEARCHING)
end

local function var_0_18(arg_103_0, arg_103_1)
	if arg_103_0._playing then
		return
	end

	if arg_103_0._suppress then
		return
	end

	if arg_103_0._wining then
		return
	end

	arg_103_0._wining = true

	arg_103_0.skeleton:setTimeScale(1)
	arg_103_0:finishFight()
	arg_103_0:switchDirection(arg_103_0.charactertype == "player" and 1 or -1)
	arg_103_0:playWinAni()

	arg_103_0._lock = true
end

function PlayerCharacter:updateFightState(arg_104_1)
	if self:getStatus() == STATUS_WAITING then
		return
	elseif self:getStatus() == STATUS_SEARCHING then
		var_0_12(self, arg_104_1)
	elseif self:getStatus() == STATUS_PREFIGHTING then
		var_0_13(self, arg_104_1)
	elseif self:getStatus() == STATUS_FIGHTING then
		var_0_14(self, arg_104_1)
	elseif self:getStatus() == STATUS_DIED then
		var_0_15(self, arg_104_1)
	elseif self:getStatus() == STATUS_REVIVAL then
		var_0_16(self, arg_104_1)
	elseif self:getStatus() == STATUS_ENDFIGHT then
		var_0_17(self, arg_104_1)
	elseif self:getStatus() == STATUS_FIGHTWIN then
		var_0_18(self, arg_104_1)
	end
end

function PlayerCharacter.updateSkillButton(arg_105_0)
	print("updateSkillButton is deprecated")
end

function PlayerCharacter:playerSurrender()
	if self:getStatus() == STATE_DIED then
		return false
	end

	self:setStatus(STATE_DIED)

	self._godie = true
end

function PlayerCharacter:beHitted(arg_107_1, arg_107_2)
	if FightManager.isNormalFight() and not FightManager.isFightingBoss() then
		return false
	end

	local var_107_0 = FightManager.getCharacter(arg_107_1.sourceindex)

	if var_107_0 and var_107_0.statuspool:getStatus("damage_change_mechanical") then
		arg_107_1.damagetype = MECHANICAL_DAMAGE
	end

	if self.statuspool:getStatus("suffer_damage_change_mechanical") then
		arg_107_1.damagetype = MECHANICAL_DAMAGE
	end

	if arg_107_1.damage <= 0 then
		if arg_107_1.info and arg_107_1.info.isBlind then
			self:beHittedBlind()
		end

		return false
	end

	if not self:canBeHit() then
		return false
	end

	if not arg_107_1.behitted then
		self._behitted = 0.2
	end

	self:onHittedShutDown(arg_107_1.behitted)

	if arg_107_1.sourceindex and arg_107_1.info.isRes == nil then
		local var_107_1, var_107_2 = calculate_majorattr_addition(FightManager.getCharacter(arg_107_1.sourceindex), self)

		arg_107_1.info.isRes = var_107_1
		arg_107_1.damage = var_0_0.floor(arg_107_1.damage * var_107_2)
	end

	arg_107_1.damage = arg_107_1.damage * (1 + FightManager.getGlobalDamageAddition())

	local var_107_3 = self:getAttribute("max_taken_damage")

	if var_107_3 then
		self:setAttribute("max_taken_damage", var_107_3 * (1 + FightManager.getGlobalDamageAddition()))
	end

	if self:isDamageCauseDie(arg_107_1.damagetype, arg_107_1.damage) then
		self:triggerStatus("onDyingBeforeSheild", FightManager.getCharacter(arg_107_1.sourceindex), arg_107_1)
	end

	local var_107_4 = {
		damage = 0,
		finalhit = true
	}
	local var_107_5 = 0

	if arg_107_1.damagetype == HOLY_DAMAGE then
		var_107_4.damage = arg_107_1.damage
		var_107_5 = arg_107_1.damage
	else
		var_107_4.damage = self:hitShield(arg_107_1.damage)
		var_107_4.damage = self:calculateDefence(arg_107_1.damagetype, var_107_4.damage, FightManager.getCharacter(arg_107_1.sourceindex))
		arg_107_1.damage = var_107_4.damage + (arg_107_1.damage - var_107_4.damage)
		var_107_5 = arg_107_1.damage
	end

	if var_107_0 and not var_107_0.statuspool:getStatus("ignoremaxdamage") and self:getAttribute("max_taken_damage") > 0 and arg_107_1.damage > self:getAttribute("max_taken_damage") then
		arg_107_1.damage = self:getAttribute("max_taken_damage")
		var_107_5 = arg_107_1.damage
		var_107_4.damage = arg_107_1.damage
	end

	FightManager.addStatistics("damage", var_107_5, arg_107_1.sourceindex, self.index, arg_107_1)

	if not arg_107_2 then
		arg_107_1.triggeronhurt = true

		if arg_107_1.damagetype == MECHANICAL_DAMAGE then
			if FightManager.getCharacter(arg_107_1.sourceindex) then
				FightManager.getCharacter(arg_107_1.sourceindex):triggerStatus("onMechanicalDamage", self, arg_107_1)
			end

			self:triggerStatus("onMechanicalHurt", FightManager.getCharacter(arg_107_1.sourceindex), arg_107_1)
		elseif arg_107_1.damagetype == ENERGY_DAMAGE then
			if FightManager.getCharacter(arg_107_1.sourceindex) then
				FightManager.getCharacter(arg_107_1.sourceindex):triggerStatus("onEnergyDamage", self, arg_107_1)
			end

			self:triggerStatus("onEnergyHurt", FightManager.getCharacter(arg_107_1.sourceindex), arg_107_1)
		end

		self:triggerStatus("onHurt", FightManager.getCharacter(arg_107_1.sourceindex), arg_107_1)
	end

	if self._bear and self._bear:transferDamage({
		damage = var_107_4.damage,
		damagetype = arg_107_1.damagetype,
		sourceindex = arg_107_1.sourceindex,
		info = {
			isRes = false
		}
	}) then
		local var_107_6 = self._bear:getEffect()

		self:playStatusEffect(false, var_107_6.filename, var_107_6.ani, var_107_6.offsetX, var_107_6.offsetY, var_107_6.offsetZ, self:getDirection())

		var_107_4.damage = var_107_4.damage * (1 - self._bear:getPercent())
	end

	local var_107_7 = false

	if self._contracted then
		local var_107_8 = FightManager.getCharacter(self._contracted:getIndex())

		if var_107_8 and var_107_8._bear then
			var_107_7 = true
		end
	end

	if not var_107_7 and self:getAttribute("curhp") + self:getAttribute("singlehp") * (self:getAttribute("curhpcount") - 1) - var_107_4.damage <= 0 then
		if self._contracted and self._contracted:trigger({
			damage = var_107_4.damage,
			damagetype = arg_107_1.damagetype,
			sourceindex = arg_107_1.sourceindex
		}) then
			local var_107_9 = self._contracted:getEffect()

			self:playStatusEffect(false, var_107_9.filename, var_107_9.ani, var_107_9.offsetX, var_107_9.offsetY, var_107_9.offsetZ, self:getDirection())

			return false
		end

		self:triggerStatus("onDying", FightManager.getCharacter(arg_107_1.sourceindex), var_107_4)

		if not self.statuspool:getStatus("superimmortal") and (arg_107_1.immortallimit or not self.statuspool:getStatus("immortal")) then
			self:triggerStatus("onDyingNoImmortal", FightManager.getCharacter(arg_107_1.sourceindex), var_107_4)
		end
	end

	local var_107_10 = self:addCurHp(-1 * var_0_0.round(var_107_4.damage), arg_107_1.immortallimit)

	if self.skeleton then
		local var_107_11 = arg_107_1.info.beattype

		if arg_107_1.damagetype == ENERGY_DAMAGE then
			var_107_11 = 10

			if arg_107_1.skilltype == "attack" then
				var_107_11 = 9
			elseif arg_107_1.skilltype == "xp" then
				var_107_11 = 11
			end
		end

		self:pushBackHitnumber({
			posx = self:getPositionX(),
			posy = self:getPositionY() + (self:getAttribute("model_height") + self:getRootOffsetY()) * STANDARD_SCALE * self:getAttribute("model_scale") + HITWORD_HEIGHT,
			number = var_0_0.round(-1 * var_107_4.damage),
			cri = arg_107_1.info.isCri,
			miss = arg_107_1.info.isMiss,
			strike = arg_107_1.info.isStrike,
			restrain = arg_107_1.info.isRes,
			side = self.charactertype,
			attacktype = var_107_11
		})
	end

	if var_107_10 < 0 then
		self:addRageOnHitted(-var_107_10)
	end

	if self:getAttribute("curhp") < 1 and self:getAttribute("curhpcount") <= 1 then
		return self:dieAction(arg_107_1.sourceindex)
	end

	return false
end

function PlayerCharacter:onPlayerSubstitute()
	self.statuspool:setStatus("invincible", true)
	self.statuspool:addStatus("invincible_count", 1)
	self.statuspool:setStatus("impotence", true)
	self.statuspool:addStatus("impotence_count", 1)
	self:pushInDelayCallFuncs(1, function()
		self.statuspool:addStatus("invincible_count", -1)

		if self.statuspool:getStatus("invincible_count") <= 0 then
			self.statuspool:setStatus("invincible", false)
		end

		self.statuspool:addStatus("impotence_count", -1)

		if self.statuspool:getStatus("impotence_count") <= 0 then
			self.statuspool:setStatus("impotence", false)
		end

		self:resetAllCD()

		if self:getState() == STATE_FIGHTING then
			self.logic:updateFight()
		end
	end)
	self:playEffect("fuhuo", "fuhuo", 0, 0, 1)
end
