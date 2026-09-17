local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager:get_worldboss_data(arg_1_1, arg_1_2)
	return self.activities[arg_1_1]:get_worldboss_data(arg_1_2)
end

function activity_base_manager:start_worldboss_fight(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	return self.activities[arg_2_1]:start_worldboss_fight(arg_2_2, arg_2_3, arg_2_4)
end

function activity_base_manager:getWorldBossCurData(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	return self.activities[arg_3_1]:getWorldBossCurData(arg_3_2, arg_3_3, arg_3_4)
end

function activity_base_manager:get_worldboss_rank_list(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	return self.activities[arg_4_1]:get_worldboss_rank_list(arg_4_2, arg_4_3, arg_4_4, arg_4_5)
end

function activity_base_manager:switch_to_worldboss_fight(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	return self.activities[arg_5_1]:switch_to_worldboss_fight(arg_5_2, arg_5_3, arg_5_4)
end

function activity_base_manager:getWorldBossEnemy()
	if not self._worldbossfightingId then
		return
	end

	return self.activities[self._worldbossfightingId]:getWorldBossEnemy()
end

function activity_base_manager:getWorldBossFightAttrAdd()
	if not self._worldbossfightingId then
		return
	end

	return self.activities[self._worldbossfightingId]:getWorldBossFightAttrAdd()
end

function activity_base_manager:getWorldBossBattleFieldStatus(arg_8_1)
	if not self._worldbossfightingId then
		return
	end

	return self.activities[self._worldbossfightingId]:getWorldBossBattleFieldStatus(arg_8_1)
end

function activity_base_manager:worldbossFightFail()
	if not self._worldbossfightingId then
		return
	end

	return self.activities[self._worldbossfightingId]:worldbossFightFail()
end

function activity_base_manager:worldbossFightSuccess()
	if not self._worldbossfightingId then
		return
	end

	return self.activities[self._worldbossfightingId]:worldbossFightSuccess()
end

function activity_base_manager:updateWorldBossDamage(arg_11_1)
	if not self._worldbossfightingId then
		return
	end

	return self.activities[self._worldbossfightingId]:updateWorldBossDamage(arg_11_1)
end
