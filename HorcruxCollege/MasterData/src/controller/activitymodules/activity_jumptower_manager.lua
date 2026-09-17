local activity_base_manager = require("controller.activitymodules.activity_base_manager")

function activity_base_manager.initActivityArtObj(arg_1_0, arg_1_1)
	return
end

function activity_base_manager:get_activity_jumptower_info(arg_2_1)
	return self.activities[arg_2_1]:get_activity_jumptower_info()
end

function activity_base_manager:reset_jumptower(arg_3_1)
	return self.activities[arg_3_1]:reset_jumptower()
end

function activity_base_manager:getJumpTowerCurLevel(arg_4_1)
	return self.activities[arg_4_1]:getJumpTowerCurLevel()
end

function activity_base_manager:getJumpTowerMaxLevel(arg_5_1)
	return self.activities[arg_5_1]:getJumpTowerMaxLevel()
end

function activity_base_manager:getJumpTowerArrayByIndex(arg_6_1, arg_6_2)
	return self.activities[arg_6_1]:getJumpTowerArrayByIndex(arg_6_2)
end

function activity_base_manager:getJumptowerLockServants(arg_7_1)
	return self.activities[arg_7_1]:getJumptowerLockServants()
end

function activity_base_manager.startJumpTower(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local playermodel = require("model.playermodel")

	require("network.network"):rpc("switch_to_adventuremode", {
		mode = arg_8_1,
		chapter = arg_8_2,
		servants = arg_8_4
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			playermodel.levelmode[arg_8_1] = arg_9_0.levelmode
			playermodel.curLevel = arg_9_0.curlevel
			playermodel.curMode = arg_9_0.curmode

			AnalyticManager.joinAdventure(arg_8_1)
			AnalyticManager.startLevel(playermodel.curMode, playermodel.curLevel)

			if arg_8_3 then
				arg_8_3(1)
			end
		elseif arg_8_3 then
			arg_8_3(arg_9_0.result)
		end
	end)
end

function activity_base_manager:isjumpTowerMode(arg_10_1)
	local var_10_0 = math.floor(arg_10_1 / 100)

	if var_10_0 < 400 then
		return false
	end

	if not self.activities[var_10_0] then
		return false
	end

	if ACTIVITY_ID_TO_MODETYPE_FUNC.jump_tower(var_10_0) * 10 + 1 ~= arg_10_1 then
		return false
	end

	return true
end

function activity_base_manager:getJumptowerUnlockServant(arg_11_1)
	local var_11_0 = math.floor(arg_11_1 / 100)

	if var_11_0 < 400 then
		return false
	end

	if not self.activities[var_11_0] then
		return false
	end

	return self.activities[var_11_0]:getJumptowerUnlockServant()
end
