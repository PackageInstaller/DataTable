local HelpBattleManager = class("HelpBattleManager", (require("controller.base_manager")))

HelpBattleManager.MULTITON_MSG = "HelpBattleManager instancealready constructed!"

local model_data = require("data.model_data")
local servant_data = require("data.servant_data")

HelpBattleManager.CAREER = {
	ASSASSIN = 5,
	SUPPORT = 6,
	SHOOTER = 2,
	WARRIOR = 1,
	TANK = 4,
	MASTER = 3
}
HelpBattleManager.ADD_NUM = nil
HelpBattleManager.GO_NUM = 0

function HelpBattleManager:ctor()
	HelpBattleManager.super.ctor(self)

	self._param = {}
	self._formationIndex = 1
	self._careerInfo = {}
	self._selectCareer = HelpBattleManager.CAREER.WARRIOR

	for iter_1_0, iter_1_1 in pairs(HelpBattleManager.CAREER) do
		self._careerInfo[iter_1_1] = {
			name = L_HELP_BATTLE[iter_1_1],
			career = iter_1_1
		}
	end

	self._config = require("data/helpteam_fighter_data")

	self:updateGoNum()
end

function HelpBattleManager:updateGoNum()
	HelpBattleManager.GO_NUM = 0
	HelpBattleManager.ADD_NUM = HelpBattleManager.ADD_NUM or #self._config

	for iter_2_0 = 1, #self._config do
		if self:isLock(iter_2_0) then
			HelpBattleManager.GO_NUM = HelpBattleManager.GO_NUM + 1
		end
	end
end

function HelpBattleManager:isLock(arg_3_1)
	if self._config[arg_3_1].isunlock then
		local core_manager = require("controller/core_manager")
		local var_3_1 = self._config[arg_3_1].unlock_grade
		local var_3_2 = self._config[arg_3_1].unlock_time
		local var_3_3 = true
		local var_3_4 = true
		local var_3_5 = true
		local var_3_6 = {
			text = "",
			tips = ""
		}

		if self._config[arg_3_1].unlock_level then
			local var_3_7 = string.split(self._config[arg_3_1].unlock_level, "-")

			var_3_3 = require("controller/level_manager"):isPlayerPassLevel(self._config[arg_3_1].unlock_level)

			if not var_3_3 then
				var_3_6.text = string.format(L_HELP_BATTLE[125], self._config[arg_3_1].unlock_level)
				var_3_6.tips = L_HELP_BATTLE[126]
			end
		end

		if var_3_1 then
			var_3_4 = var_3_1 <= require("model/playermodel").grade

			if not var_3_4 then
				var_3_6.text = var_3_6.text == "" and string.format(L_HELP_BATTLE[127], var_3_1) or var_3_6.text .. "\n" .. string.format(L_HELP_BATTLE[127], var_3_1)

				if var_3_6.tips == "" then
					var_3_6.tips = L_HELP_BATTLE[126]
				end
			end
		end

		if var_3_2 then
			var_3_5 = require("controller/time_check_manager"):getCurTime() >= global_get_time_by_date_2(var_3_2)

			if not var_3_5 then
				var_3_6.text = var_3_6.text == "" and string.format(L_HELP_BATTLE[128], var_3_2) or var_3_6.text .. "\n" .. string.format(L_HELP_BATTLE[128], var_3_2)

				if var_3_6.tips == "" then
					var_3_6.tips = L_HELP_BATTLE[126]
				end
			end
		end

		if var_3_3 and var_3_4 and var_3_5 then
			return true
		else
			return false, var_3_6
		end
	else
		return false, {
			text = L_HELP_BATTLE[124],
			tips = L_HELP_BATTLE[124]
		}
	end
end

function HelpBattleManager:setParam(arg_4_1)
	self._param = arg_4_1
	self._configType = self._param.configType
	self._formationIndex = self._param.formationIndex or 1
	self._mode = self._param.mode
end

function HelpBattleManager:getData()
	local var_5_0 = {}
	local var_5_1

	if self._configType == CONFIG_TYPE_HANGUP or self._configType == CONFIG_TYPE_REFIGHT then
		var_5_1 = require("controller.formation.formation_main_manager"):getInstance()
	elseif self._configType == CONFIG_TYPE_MODE then
		var_5_1 = require("controller.formation.formation_mode_manager"):getInstance()
	elseif self._configType == CONFIG_TYPE_SUBSTITUTION then
		var_5_1 = require("controller.formation.formation_overclock_manager"):getInstance()
	elseif self._configType == CONFIG_TYPE_SCOREARENA then
		var_5_1 = require("controller.formation.formation_points_match_manager"):getInstance()
	elseif self._configType == CONFIG_TYPE_ARENA or self._configType == CONFIG_TYPE_ARENA_DEFENCE then
		var_5_1 = require("controller.formation.formation_grab_match_manager"):getInstance()
	elseif self._configType == CONFIG_TYPE_JUMP_TOWER then
		var_5_1 = require("controller.formation.formation_jumptower_manager"):getInstance()
	end

	if not var_5_1 then
		return var_5_0
	end

	local var_5_2 = var_5_1:getAssistsInfo()

	for iter_5_0 = 1, #var_5_2 do
		var_5_0[iter_5_0] = {}

		if next(var_5_2[iter_5_0]) then
			for iter_5_1 = 1, #var_5_2[iter_5_0] do
				var_5_0[iter_5_0][var_5_2[iter_5_0][iter_5_1].ctg] = var_5_2[iter_5_0][iter_5_1].ids
			end
		end
	end

	return var_5_0
end

function HelpBattleManager:getFormation()
	local var_6_0 = {}

	if self._configType == CONFIG_TYPE_HANGUP or self._configType == CONFIG_TYPE_REFIGHT then
		var_6_0 = require("controller.formation.formation_main_manager"):getInstance():getFormationInfo()
	elseif self._configType == CONFIG_TYPE_MODE then
		var_6_0 = require("controller.formation.formation_mode_manager"):getInstance():getFormationInfo()
	elseif self._configType == CONFIG_TYPE_SUBSTITUTION then
		manager = require("controller.formation.formation_overclock_manager"):getInstance()
		var_6_0 = manager:getFormationInfo()
	elseif self._configType == CONFIG_TYPE_SCOREARENA then
		manager = require("controller.formation.formation_points_match_manager"):getInstance()
		var_6_0 = manager:getFormationInfo()
	elseif self._configType == CONFIG_TYPE_ARENA or self._configType == CONFIG_TYPE_ARENA_DEFENCE then
		manager = require("controller.formation.formation_grab_match_manager"):getInstance()
		var_6_0 = manager:getFormationInfo()
	elseif self._configType == CONFIG_TYPE_JUMP_TOWER then
		manager = require("controller.formation.formation_jumptower_manager"):getInstance()
		var_6_0 = manager:getFormationInfo()
	end

	return var_6_0
end

function HelpBattleManager:setFormationIndex(arg_7_1)
	self._formationIndex = arg_7_1
end

function HelpBattleManager:requestInfo(arg_8_1)
	return
end

function HelpBattleManager:requestUpdate(arg_9_1, arg_9_2, arg_9_3)
	arg_9_2 = arg_9_2 or {}

	local playermodel = require("model.playermodel")
	local network = require("network.network")

	if self:isInFormation(arg_9_2[#arg_9_2]) then
		global_ShowBlockWords(L_HELP_BATTLE[129])

		return
	end

	if #arg_9_2 > HelpBattleManager.GO_NUM then
		global_ShowBlockWords(L_HELP_BATTLE[130])

		return
	end

	if self._configType == CONFIG_TYPE_HANGUP or self._configType == CONFIG_TYPE_REFIGHT then
		self:requestMainHelpBattle(arg_9_1, arg_9_2, arg_9_3)
	elseif self._configType == CONFIG_TYPE_MODE then
		self:requestModeHelpBattle(self._mode, arg_9_1, arg_9_2, arg_9_3)
	elseif self._configType == CONFIG_TYPE_SUBSTITUTION then
		-- block empty
	elseif self._configType == CONFIG_TYPE_SCOREARENA then
		self:requestPointMatchHelpBattle(arg_9_1, arg_9_2, arg_9_3)
	elseif self._configType == CONFIG_TYPE_ARENA or self._configType == CONFIG_TYPE_ARENA_DEFENCE then
		self:requestGrabMatchHelpBattle(arg_9_1, arg_9_2, arg_9_3)
	elseif self._configType == CONFIG_TYPE_JUMP_TOWER then
		self:requestJumptowerHelpBattle(arg_9_1, arg_9_2, arg_9_3)
	end
end

function HelpBattleManager:requestMainHelpBattle(arg_10_1, arg_10_2, arg_10_3)
	local playermodel = require("model.playermodel")
	local var_10_1 = self._formationIndex

	require("network.network"):rpc("update_array_assist", {
		id = self._formationIndex,
		assist = {
			ctg = arg_10_1,
			ids = arg_10_2
		}
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			playermodel.arrays[var_10_1].assist = playermodel.arrays[var_10_1].assist or {}

			local var_11_0 = false

			for iter_11_0 = 1, #playermodel.arrays[var_10_1].assist do
				if playermodel.arrays[var_10_1].assist[iter_11_0].ctg == arg_10_1 then
					var_11_0 = true
					playermodel.arrays[var_10_1].assist[iter_11_0].ids = arg_10_2

					break
				end
			end

			if not var_11_0 then
				playermodel.arrays[var_10_1].assist[#playermodel.arrays[var_10_1].assist + 1] = {
					ctg = arg_10_1,
					ids = arg_10_2
				}
			end

			if arg_10_3 then
				arg_10_3(arg_11_0)
			end

			self:updateGirlSuccess()
		elseif arg_11_0.result == 2 then
			global_ShowBlockWords(L_HELP_BATTLE[121])
		elseif arg_11_0.result == 3 then
			global_ShowBlockWords(L_HELP_BATTLE[122])
		elseif arg_11_0.result == 4 then
			global_ShowBlockWords(L_HELP_BATTLE[123])
		elseif arg_11_0.result == 5 then
			global_ShowBlockWords(L_HELP_BATTLE[132])
		elseif arg_11_0.result == 6 then
			global_ShowBlockWords(L_HELP_BATTLE[133])
		end
	end)
end

function HelpBattleManager:requestPointMatchHelpBattle(arg_12_1, arg_12_2, arg_12_3)
	local playermodel = require("model.playermodel")
	local var_12_1 = {}

	var_12_1.id = -3
	var_12_1.assist = {
		ctg = arg_12_1,
		ids = arg_12_2
	}

	require("network.network"):rpc("update_array_assist", var_12_1, function(arg_13_0)
		if arg_13_0.result == 1 then
			local var_13_0 = self:getFormation()[self._formationIndex]

			var_13_0.assist = var_13_0.assist or {}

			local var_13_1 = false

			for iter_13_0 = 1, #var_13_0.assist do
				if var_13_0.assist[iter_13_0].ctg == arg_12_1 then
					var_13_1 = true
					var_13_0.assist[iter_13_0].ids = arg_12_2

					break
				end
			end

			if not var_13_1 then
				var_13_0.assist[#var_13_0.assist + 1] = {
					ctg = arg_12_1,
					ids = arg_12_2
				}
			end

			if arg_12_3 then
				arg_12_3(arg_13_0)
			end

			self:updateGirlSuccess()
		elseif arg_13_0.result == 2 then
			global_ShowBlockWords(L_HELP_BATTLE[121])
		elseif arg_13_0.result == 3 then
			global_ShowBlockWords(L_HELP_BATTLE[122])
		elseif arg_13_0.result == 4 then
			global_ShowBlockWords(L_HELP_BATTLE[123])
		end
	end)
end

function HelpBattleManager:requestGrabMatchHelpBattle(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = require("controller/formation/formation_grab_match_manager"):getInstance()
	local playermodel = require("model.playermodel")
	local var_14_2 = var_14_0:getLayerType()

	require("network.network"):rpc("update_array_assist", {
		id = var_14_2,
		assist = {
			ctg = arg_14_1,
			ids = arg_14_2
		}
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			local var_15_0 = arg_14_1
			local var_15_1 = arg_14_2

			playermodel.arenaAttackArray.assist = playermodel.arenaAttackArray.assist or {}
			playermodel.arenaArray.assist = playermodel.arenaArray.assist or {}

			local var_15_2

			if var_14_2 == var_14_0.Type.Attack then
				var_15_2 = playermodel.arenaAttackArray
			elseif var_14_2 == var_14_0.Type.Defend then
				var_15_2 = playermodel.arenaArray
			end

			var_15_2.assist = var_15_2.assist or {}

			local var_15_3 = false

			for iter_15_0 = 1, #var_15_2.assist do
				if var_15_2.assist[iter_15_0].ctg == var_15_0 then
					var_15_3 = true
					var_15_2.assist[iter_15_0].ids = var_15_1

					break
				end
			end

			if not var_15_3 then
				var_15_2.assist[#var_15_2.assist + 1] = {
					ctg = var_15_0,
					ids = var_15_1
				}
			end

			if arg_14_3 then
				arg_14_3(arg_15_0)
			end

			self:updateGirlSuccess()
		elseif arg_15_0.result == 2 then
			global_ShowBlockWords(L_HELP_BATTLE[121])
		elseif arg_15_0.result == 3 then
			global_ShowBlockWords(L_HELP_BATTLE[122])
		elseif arg_15_0.result == 4 then
			global_ShowBlockWords(L_HELP_BATTLE[123])
		end
	end)
end

function HelpBattleManager:requestModeHelpBattle(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local playermodel = require("model.playermodel")

	require("network.network"):rpc("update_adventure_array_assist", {
		mode = arg_16_1,
		assist = {
			ctg = arg_16_2,
			ids = arg_16_3
		}
	}, function(arg_17_0)
		if arg_17_0.result == 1 then
			local var_17_0 = self:getFormation()[self._formationIndex]

			var_17_0.assist = var_17_0.assist or {}

			local var_17_1 = false

			for iter_17_0 = 1, #var_17_0.assist do
				if var_17_0.assist[iter_17_0].ctg == arg_16_2 then
					var_17_1 = true
					var_17_0.assist[iter_17_0].ids = arg_16_3

					break
				end
			end

			if not var_17_1 then
				var_17_0.assist[#var_17_0.assist + 1] = {
					ctg = arg_16_2,
					ids = arg_16_3
				}
			end

			if arg_16_4 then
				arg_16_4(arg_17_0)
			end

			self:updateGirlSuccess()
		elseif arg_17_0.result == 2 then
			global_ShowBlockWords(L_HELP_BATTLE[121])
		elseif arg_17_0.result == 3 then
			global_ShowBlockWords(L_HELP_BATTLE[122])
		elseif arg_17_0.result == 4 then
			global_ShowBlockWords(L_HELP_BATTLE[123])
		end
	end)
end

function HelpBattleManager:requestJumptowerHelpBattle(arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = self:getFormation()[self._formationIndex]

	var_18_0.assist = var_18_0.assist or {}

	local var_18_1 = false

	for iter_18_0 = 1, #var_18_0.assist do
		if var_18_0.assist[iter_18_0].ctg == arg_18_1 then
			var_18_1 = true
			var_18_0.assist[iter_18_0].ids = arg_18_2

			break
		end
	end

	if not var_18_1 then
		var_18_0.assist[#var_18_0.assist + 1] = {
			ctg = arg_18_1,
			ids = arg_18_2
		}
	end

	if arg_18_3 then
		arg_18_3(msg)
	end

	self:updateGirlSuccess()
end

function HelpBattleManager:handlerInfo(arg_19_1)
	return
end

function HelpBattleManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function HelpBattleManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function HelpBattleManager:updateGirlSuccess()
	if self.layer then
		self.layer:updateGirlList()
	end
end

function HelpBattleManager:getSelectCareer()
	return self._selectCareer
end

function HelpBattleManager:setSelectCareer(arg_24_1)
	self._selectCareer = arg_24_1
end

function HelpBattleManager:getCareerInfo()
	return self._careerInfo
end

function HelpBattleManager:getServants(arg_26_1, arg_26_2)
	local var_26_0 = self:getData()

	arg_26_2 = arg_26_2 or self._formationIndex

	if var_26_0[arg_26_2] and var_26_0[arg_26_2][arg_26_1] then
		return var_26_0[arg_26_2][arg_26_1]
	end

	return {}
end

function HelpBattleManager:getAllServants(arg_27_1)
	local var_27_0 = self:getData()

	arg_27_1 = arg_27_1 or self._formationIndex

	if var_27_0[arg_27_1] then
		return var_27_0[arg_27_1]
	end

	return {}
end

function HelpBattleManager:getNormalBouns()
	return
end

function HelpBattleManager:getBonusByList(arg_29_1, arg_29_2)
	if type(arg_29_2) == "string" then
		arg_29_2 = require("controller/help_battle/help_battle_formation_manager"):getInstance().CAREER_STR_MAP[arg_29_2]
	end

	local var_29_0 = arg_29_1.assist or {}
	local var_29_1 = arg_29_1.array or {}
	local var_29_2 = {}

	for iter_29_0 = 1, #var_29_0 do
		if var_29_0[iter_29_0].ctg == arg_29_2 then
			var_29_2 = var_29_0[iter_29_0].ids

			break
		end
	end

	return (self:getBonusByInfo(var_29_2, arg_29_2, var_29_1))
end

function HelpBattleManager:getBonus(arg_30_1, arg_30_2)
	local var_30_0 = self:getData()

	arg_30_2 = arg_30_2 or self._formationIndex

	if type(arg_30_1) == "string" then
		arg_30_1 = require("controller/help_battle/help_battle_formation_manager"):getInstance().CAREER_STR_MAP[arg_30_1]
	end

	if not var_30_0[arg_30_2] then
		return self:getNullBonus()
	end

	return (self:getBonusByInfo(var_30_0[arg_30_2][arg_30_1] or {}, arg_30_1, self:getFormation()[arg_30_2]))
end

function HelpBattleManager:getBounsFactor(arg_31_1, arg_31_2)
	local var_31_0 = require("controller/help_battle/help_battle_formation_manager"):getInstance()
	local var_31_1 = 0

	for iter_31_0, iter_31_1 in pairs(arg_31_2) do
		if iter_31_1.fight_girl and var_31_0.CAREER_STR_MAP[model_data[servant_data[iter_31_1.fight_girl].modelid].career] == arg_31_1 then
			var_31_1 = var_31_1 + 1
		end
	end

	return setmetatable({
		1,
		0.5,
		0.33,
		0.25,
		0.2
	}, {
		__index = function(arg_32_0, arg_32_1)
			return 1
		end
	})[var_31_1]
end

function HelpBattleManager:getNullBonus()
	return {
		factor = 1,
		value = {
			defence = 0,
			hp = 0,
			damage = 0,
			critical = 0,
			extra_attack = 0,
			energydefence = 0,
			extra_defence = 0,
			dodge = 0
		},
		percent = {
			defence = 0,
			hp = 0,
			damage = 0,
			extra_heal_extern = 0,
			critical = 0,
			energydefence = 0,
			extra_attack = 0,
			extra_defence = 0
		},
		girlInfo = {}
	}
end

function HelpBattleManager:getBonusByInfo(arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = self:getBounsFactor(arg_34_2, arg_34_3)
	local var_34_1 = self:getNullBonus()

	var_34_1.factor = var_34_0

	for iter_34_0 = 1, #arg_34_1 do
		var_34_1.girlInfo[arg_34_1[iter_34_0]] = {
			value = {
				defence = 0,
				hp = 0,
				damage = 0,
				critical = 0,
				extra_attack = 0,
				energydefence = 0,
				extra_defence = 0,
				dodge = 0
			}
		}

		local var_34_2 = self:getGirlData(arg_34_1[iter_34_0])
		local var_34_3 = var_34_2.model:getAttribute("damage") * 0.045 * var_34_0

		var_34_1.value.damage = math.round(var_34_1.value.damage + var_34_3)
		var_34_1.girlInfo[arg_34_1[iter_34_0]].value.damage = math.round(var_34_3)

		local var_34_4 = var_34_2.model:getAttribute("hp") * 0.045 * var_34_0

		var_34_1.value.hp = math.round(var_34_1.value.hp + var_34_4)
		var_34_1.girlInfo[arg_34_1[iter_34_0]].value.hp = math.round(var_34_4)
	end

	return var_34_1
end

function HelpBattleManager:getArenaEnemyBonus(arg_35_1, arg_35_2)
	arg_35_2 = arg_35_2 or self._formationIndex

	local arena_manager = require("controller.arena_manager")

	if type(arg_35_1) == "string" then
		arg_35_1 = require("controller/help_battle/help_battle_formation_manager"):getInstance().CAREER_STR_MAP[arg_35_1]
	end

	local var_35_1 = self:getNullBonus()

	if arena_manager.helpBattleData.enemy then
		for iter_35_0 = 1, #arena_manager.helpBattleData.enemy do
			if arena_manager.helpBattleData.enemy[iter_35_0].career == arg_35_1 then
				var_35_1.value.damage = var_35_1.value.damage + arena_manager.helpBattleData.enemy[iter_35_0].damage
				var_35_1.value.hp = var_35_1.value.damage + arena_manager.helpBattleData.enemy[iter_35_0].hp
			end
		end
	end

	return var_35_1
end

function HelpBattleManager:getBonusByServantId(arg_36_1)
	local var_36_0 = {
		value = {
			defence = 0,
			hp = 0,
			damage = 0,
			energydefence = 0,
			fightCapacity = require("controller/fight_capacity_manager"):getSoulFightCapacity(arg_36_1, "number")
		}
	}

	if not require("model.playermodel").haveServant[arg_36_1] then
		return var_36_0
	end

	local var_36_1 = self:getGirlData(arg_36_1)

	var_36_0.value.damage = var_36_1.model:getAttribute("damage")
	var_36_0.value.hp = var_36_1.model:getAttribute("hp")

	return var_36_0
end

function HelpBattleManager:getGirlData(arg_37_1)
	local playermodel = require("model.playermodel")
	local var_37_1 = require("controller.model_manager").new()

	var_37_1:initPlayerAttribute(arg_37_1)

	local var_37_2, var_37_3 = require("controller.component_manager"):getSoulComponentlist(arg_37_1)

	var_37_1:updateComponentAttr(var_37_2)

	return {
		model = var_37_1,
		effects = var_37_3
	}
end

function HelpBattleManager:isInFormation(arg_38_1)
	if not arg_38_1 then
		return false
	end

	local var_38_0 = self:getFormation()[self._formationIndex]

	if var_38_0 then
		for iter_38_0 = 1, #var_38_0 do
			if var_38_0[iter_38_0].fight_girl == arg_38_1 then
				return true
			end
		end
	end

	return false
end

function HelpBattleManager:autoHelpFormation()
	if self._configType == CONFIG_TYPE_HANGUP or self._configType == CONFIG_TYPE_REFIGHT then
		self:autoHelpFormationMain()
	elseif self._configType == CONFIG_TYPE_MODE then
		self:autoHelpFormationMode()
	elseif self._configType == CONFIG_TYPE_SUBSTITUTION then
		-- block empty
	elseif self._configType == CONFIG_TYPE_SCOREARENA then
		self:autoHelpFormationPointMatch()
	elseif self._configType == CONFIG_TYPE_ARENA or self._configType == CONFIG_TYPE_ARENA_DEFENCE then
		self:autoHelpFormationGrabMatch()
	elseif self._configType == CONFIG_TYPE_JUMP_TOWER then
		self:autoHelpFormationJumpTower()
	end
end

function HelpBattleManager:autoHelpFormationMain()
	local playermodel = require("model.playermodel")
	local var_40_1 = self:getFormation()
	local var_40_2 = {}

	if var_40_1[self._formationIndex] then
		for iter_40_0 = 1, #var_40_1[self._formationIndex] do
			if var_40_1[self._formationIndex][iter_40_0].fight_girl then
				var_40_2[var_40_1[self._formationIndex][iter_40_0].fight_girl] = 1
			end
		end
	end

	local var_40_3 = require("controller.help_battle.help_battle_formation_manager"):getInstance()

	var_40_3:initShowInfo()

	local var_40_4 = var_40_3:getAllShowInfo()
	local var_40_5 = {
		id = self._formationIndex
	}

	var_40_5.battlearray = clone(playermodel.arrays[self._formationIndex] or {})
	var_40_5.battlearray.assist = var_40_5.battlearray.assist or {}

	for iter_40_1, iter_40_2 in pairs(HelpBattleManager.CAREER) do
		if var_40_4[iter_40_2] then
			local var_40_6 = var_40_5.battlearray.assist or {}
			local var_40_7 = {}
			local var_40_8

			for iter_40_3, iter_40_4 in pairs(var_40_6) do
				if iter_40_4.ctg == iter_40_2 then
					var_40_8 = iter_40_4.ids

					for iter_40_5, iter_40_6 in pairs(iter_40_4.ids) do
						var_40_7[iter_40_6] = 1
					end

					break
				end
			end

			local var_40_9 = var_40_8 == nil

			if var_40_8 == nil then
				var_40_8 = {}
			end

			local var_40_10 = var_40_4[iter_40_2]

			for iter_40_7 = 1, #var_40_4[iter_40_2] do
				if not var_40_2[var_40_10[iter_40_7].soulid] and not var_40_7[var_40_10[iter_40_7].soulid] and playermodel.haveServant[var_40_10[iter_40_7].soulid] then
					if #var_40_8 < HelpBattleManager.GO_NUM then
						var_40_8[#var_40_8 + 1] = var_40_10[iter_40_7].soulid
					else
						break
					end
				end
			end

			if var_40_9 then
				var_40_6[#var_40_6 + 1] = {
					ctg = iter_40_2,
					ids = var_40_8
				}
			end
		end
	end

	require("controller.array_manager"):updateArrayOneKey(var_40_5.id, var_40_5.battlearray, function(arg_41_0)
		self:updateHelpBattleOneKeySuccess()
	end)
end

function HelpBattleManager:autoHelpFormationPointMatch()
	local playermodel = require("model.playermodel")
	local var_42_1 = self:getFormation()
	local var_42_2 = {}

	if var_42_1[self._formationIndex] then
		for iter_42_0 = 1, #var_42_1[self._formationIndex] do
			if var_42_1[self._formationIndex][iter_42_0].fight_girl then
				var_42_2[var_42_1[self._formationIndex][iter_42_0].fight_girl] = 1
			end
		end
	end

	local var_42_3 = require("controller.help_battle.help_battle_formation_manager"):getInstance()

	var_42_3:initShowInfo()

	local var_42_4 = var_42_3:getAllShowInfo()
	local var_42_5 = {
		id = self._formationIndex
	}
	local var_42_6 = self:getFormation()[self._formationIndex] or {}

	var_42_5.battlearray = {}

	for iter_42_1 = 1, #var_42_6 do
		var_42_5.battlearray["pos_" .. var_42_6[iter_42_1].pos] = var_42_6[iter_42_1]
	end

	var_42_5.battlearray.assist = var_42_5.battlearray.assist or {}

	for iter_42_2, iter_42_3 in pairs(HelpBattleManager.CAREER) do
		if var_42_4[iter_42_3] then
			local var_42_7 = var_42_5.battlearray.assist or {}
			local var_42_8 = {}
			local var_42_9

			for iter_42_4, iter_42_5 in pairs(var_42_7) do
				if iter_42_5.ctg == iter_42_3 then
					var_42_9 = iter_42_5.ids

					for iter_42_6, iter_42_7 in pairs(iter_42_5.ids) do
						var_42_8[iter_42_7] = 1
					end

					break
				end
			end

			local var_42_10 = var_42_9 == nil

			if var_42_9 == nil then
				var_42_9 = {}
			end

			local var_42_11 = var_42_4[iter_42_3]

			for iter_42_8 = 1, #var_42_4[iter_42_3] do
				if not var_42_2[var_42_11[iter_42_8].soulid] and not var_42_8[var_42_11[iter_42_8].soulid] and playermodel.haveServant[var_42_11[iter_42_8].soulid] then
					if #var_42_9 < HelpBattleManager.GO_NUM then
						var_42_9[#var_42_9 + 1] = var_42_11[iter_42_8].soulid
					else
						break
					end
				end
			end

			if var_42_10 then
				var_42_7[#var_42_7 + 1] = {
					ctg = iter_42_3,
					ids = var_42_9
				}
			end
		end
	end

	require("controller.formation.formation_points_match_manager"):getInstance():requestOneTimeUpdateArray(var_42_5.id, var_42_5.battlearray, function(arg_43_0)
		self:updateHelpBattleOneKeySuccess()
	end)
end

function HelpBattleManager:autoHelpFormationGrabMatch()
	local playermodel = require("model.playermodel")
	local var_44_1 = self:getFormation()
	local var_44_2 = {}

	if var_44_1[self._formationIndex] then
		for iter_44_0 = 1, #var_44_1[self._formationIndex] do
			if var_44_1[self._formationIndex][iter_44_0].fight_girl then
				var_44_2[var_44_1[self._formationIndex][iter_44_0].fight_girl] = 1
			end
		end
	end

	local formation_grab_match_manager = require("controller.formation.formation_grab_match_manager")
	local var_44_4 = formation_grab_match_manager:getInstance()
	local var_44_5 = require("controller.help_battle.help_battle_formation_manager").getInstance(formation_grab_match_manager)

	var_44_5:initShowInfo()

	local var_44_6 = var_44_5:getAllShowInfo()
	local var_44_7 = {
		id = var_44_4:getLayerType(),
		battlearray = {}
	}

	for iter_44_1 = 1, FORMATION_SHOW_GIRL_NUM do
		var_44_7.battlearray["pos_" .. iter_44_1] = {
			pos = iter_44_1
		}
	end

	local var_44_8 = clone(self:getFormation()[self._formationIndex] or {})

	for iter_44_2 = 1, #var_44_8 do
		if var_44_8[iter_44_2].pos then
			var_44_7.battlearray["pos_" .. var_44_8[iter_44_2].pos] = var_44_8[iter_44_2]
		end
	end

	var_44_7.battlearray.assist = var_44_7.battlearray.assist or {}

	for iter_44_3, iter_44_4 in pairs(HelpBattleManager.CAREER) do
		if var_44_6[iter_44_4] then
			local var_44_9 = var_44_7.battlearray.assist or {}
			local var_44_10 = {}
			local var_44_11

			for iter_44_5, iter_44_6 in pairs(var_44_9) do
				if iter_44_6.ctg == iter_44_4 then
					var_44_11 = iter_44_6.ids

					for iter_44_7, iter_44_8 in pairs(iter_44_6.ids) do
						var_44_10[iter_44_8] = 1
					end

					break
				end
			end

			local var_44_12 = var_44_11 == nil

			if var_44_11 == nil then
				var_44_11 = {}
			end

			local var_44_13 = var_44_6[iter_44_4]

			for iter_44_9 = 1, #var_44_6[iter_44_4] do
				if not var_44_2[var_44_13[iter_44_9].soulid] and not var_44_10[var_44_13[iter_44_9].soulid] and playermodel.haveServant[var_44_13[iter_44_9].soulid] then
					if #var_44_11 < HelpBattleManager.GO_NUM then
						var_44_11[#var_44_11 + 1] = var_44_13[iter_44_9].soulid
					else
						break
					end
				end
			end

			if var_44_12 then
				var_44_9[#var_44_9 + 1] = {
					ctg = iter_44_4,
					ids = var_44_11
				}
			end
		end
	end

	local array_manager = require("controller.array_manager")

	if var_44_7.id == var_44_4.Type.Attack then
		array_manager:updateArenaAttackArrayOneKey(var_44_7.battlearray, function(arg_45_0)
			self:updateHelpBattleOneKeySuccess()
		end)
	elseif var_44_7.id == var_44_4.Type.Defend then
		array_manager:updateArenaDefenceArrayOneKey(var_44_7.battlearray, function(arg_46_0)
			self:updateHelpBattleOneKeySuccess()
		end)
	end
end

function HelpBattleManager:autoHelpFormationMode()
	local playermodel = require("model.playermodel")
	local var_47_1 = self:getFormation()
	local var_47_2 = {}

	if var_47_1[self._formationIndex] then
		for iter_47_0 = 1, #var_47_1[self._formationIndex] do
			if var_47_1[self._formationIndex][iter_47_0].fight_girl then
				var_47_2[var_47_1[self._formationIndex][iter_47_0].fight_girl] = 1
			end
		end
	end

	local var_47_3 = require("controller.help_battle.help_battle_formation_manager"):getInstance()

	var_47_3:initShowInfo()

	local var_47_4 = var_47_3:getAllShowInfo()
	local var_47_5 = {
		id = self._formationIndex
	}
	local var_47_6 = self:getFormation()[self._formationIndex] or {}

	var_47_5.battlearray = {}

	for iter_47_1 = 1, #var_47_6 do
		var_47_5.battlearray["pos_" .. var_47_6[iter_47_1].pos] = var_47_6[iter_47_1]
	end

	var_47_5.battlearray.assist = var_47_5.battlearray.assist or {}

	for iter_47_2, iter_47_3 in pairs(HelpBattleManager.CAREER) do
		if var_47_4[iter_47_3] then
			local var_47_7 = var_47_5.battlearray.assist or {}
			local var_47_8 = {}
			local var_47_9

			for iter_47_4, iter_47_5 in pairs(var_47_7) do
				if iter_47_5.ctg == iter_47_3 then
					var_47_9 = iter_47_5.ids

					for iter_47_6, iter_47_7 in pairs(iter_47_5.ids) do
						var_47_8[iter_47_7] = 1
					end

					break
				end
			end

			local var_47_10 = var_47_9 == nil

			if var_47_9 == nil then
				var_47_9 = {}
			end

			local var_47_11 = var_47_4[iter_47_3]

			for iter_47_8 = 1, #var_47_4[iter_47_3] do
				if not var_47_2[var_47_11[iter_47_8].soulid] and not var_47_8[var_47_11[iter_47_8].soulid] and playermodel.haveServant[var_47_11[iter_47_8].soulid] then
					if #var_47_9 < HelpBattleManager.GO_NUM then
						var_47_9[#var_47_9 + 1] = var_47_11[iter_47_8].soulid
					else
						break
					end
				end
			end

			if var_47_10 then
				var_47_7[#var_47_7 + 1] = {
					ctg = iter_47_3,
					ids = var_47_9
				}
			end
		end
	end

	require("controller/formation/formation_mode_manager"):getInstance():requestOneTimeUpdateArray(var_47_5.id, var_47_5.battlearray, function(arg_48_0)
		if arg_48_0.result == 1 then
			self:updateHelpBattleOneKeySuccess()
		end
	end)
end

function HelpBattleManager:autoHelpFormationJumpTower()
	local playermodel = require("model.playermodel")
	local var_49_1 = self:getFormation()
	local var_49_2 = {}

	if var_49_1[self._formationIndex] then
		for iter_49_0 = 1, #var_49_1[self._formationIndex] do
			if var_49_1[self._formationIndex][iter_49_0].fight_girl then
				var_49_2[var_49_1[self._formationIndex][iter_49_0].fight_girl] = 1
			end
		end
	end

	local var_49_3 = require("controller.help_battle.help_battle_formation_manager"):getInstance()

	var_49_3:initShowInfo()

	local var_49_4 = var_49_3:getAllShowInfo()
	local var_49_5 = {
		id = self._formationIndex
	}
	local var_49_6 = self:getFormation()[self._formationIndex] or {}

	var_49_5.battlearray = {}

	for iter_49_1 = 1, #var_49_6 do
		var_49_5.battlearray["pos_" .. var_49_6[iter_49_1].pos] = var_49_6[iter_49_1]
	end

	var_49_5.battlearray.assist = var_49_5.battlearray.assist or {}

	for iter_49_2, iter_49_3 in pairs(HelpBattleManager.CAREER) do
		if var_49_4[iter_49_3] then
			local var_49_7 = var_49_5.battlearray.assist or {}
			local var_49_8 = {}
			local var_49_9

			for iter_49_4, iter_49_5 in pairs(var_49_7) do
				if iter_49_5.ctg == iter_49_3 then
					var_49_9 = iter_49_5.ids

					for iter_49_6, iter_49_7 in pairs(iter_49_5.ids) do
						var_49_8[iter_49_7] = 1
					end

					break
				end
			end

			local var_49_10 = var_49_9 == nil

			if var_49_9 == nil then
				var_49_9 = {}
			end

			local var_49_11 = var_49_4[iter_49_3]

			for iter_49_8 = 1, #var_49_4[iter_49_3] do
				if not var_49_2[var_49_11[iter_49_8].soulid] and not var_49_8[var_49_11[iter_49_8].soulid] and playermodel.haveServant[var_49_11[iter_49_8].soulid] then
					if #var_49_9 < HelpBattleManager.GO_NUM then
						var_49_9[#var_49_9 + 1] = var_49_11[iter_49_8].soulid
					else
						break
					end
				end
			end

			if var_49_10 then
				var_49_7[#var_49_7 + 1] = {
					ctg = iter_49_3,
					ids = var_49_9
				}
			end
		end
	end

	require("controller/formation/formation_jumptower_manager"):getInstance():requestOneTimeUpdateArray(var_49_5.id, var_49_5.battlearray, function(arg_50_0)
		if arg_50_0.result == 1 then
			self:updateHelpBattleOneKeySuccess()
		end
	end)
end

function HelpBattleManager:checkHelpFormationAlert(arg_51_1)
	if self._configType == CONFIG_TYPE_HANGUP or self._configType == CONFIG_TYPE_REFIGHT then
		return self:checkHelpFormationMainAlert(arg_51_1)
	elseif self._configType == CONFIG_TYPE_MODE then
		return false
	elseif self._configType == CONFIG_TYPE_SUBSTITUTION then
		return false
	elseif self._configType == CONFIG_TYPE_SCOREARENA then
		return false
	elseif self._configType == CONFIG_TYPE_ARENA or self._configType == CONFIG_TYPE_ARENA_DEFENCE then
		return false
	elseif self._configType == CONFIG_TYPE_JUMP_TOWER then
		return false
	end
end

function HelpBattleManager:checkHelpFormationMainAlert(arg_52_1)
	local playermodel = require("model.playermodel")
	local help_battle_formation_manager = require("controller/help_battle/help_battle_formation_manager")
	local var_52_2 = help_battle_formation_manager:getInstance()
	local var_52_3 = {}

	if help_battle_formation_manager[arg_52_1] then
		for iter_52_0 = 1, #self:getFormation()[arg_52_1] do
			if self:getFormation()[arg_52_1][iter_52_0].fight_girl then
				var_52_3[self:getFormation()[arg_52_1][iter_52_0].fight_girl] = true
			end
		end
	end

	for iter_52_1, iter_52_2 in pairs(HelpBattleManager.CAREER) do
		for iter_52_3, iter_52_4 in pairs((not (playermodel.arrays[arg_52_1] or {}).assist or nil) and {}) do
			local var_52_5 = {}

			if iter_52_4.ctg == iter_52_2 and #iter_52_4.ids < HelpBattleManager.GO_NUM then
				for iter_52_5, iter_52_6 in pairs(iter_52_4.ids) do
					var_52_5[iter_52_6] = true
				end

				for iter_52_7, iter_52_8 in pairs(playermodel.haveServant) do
					if iter_52_2 == var_52_2.CAREER_STR_MAP[model_data[servant_data[iter_52_7].modelid].career] and not var_52_3[iter_52_7] and not var_52_5[iter_52_7] then
						return true
					end
				end
			end
		end
	end

	return false
end

function HelpBattleManager:updateHelpBattleOneKeySuccess()
	global_ShowBlockWords(L_HELP_BATTLE[131])
	self:updateLayer()
	sendNotification("HelpBattleRoleFastChanged")
end

return HelpBattleManager
