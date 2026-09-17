local var_0_0 = _G
local var_0_3 = math
local var_0_5 = string.match
local var_0_9 = pairs
local var_0_11 = cc
local bit = require("bit")
local var_0_21 = FIGHTSTATE_WAIT
local var_0_29 = STATE_DIED
local var_0_32 = STATE_REVIVAL
local xp_effect_manager = require("fight.xp.xp_effect_manager")
local skill_data = require("data.skill_data")
local audio_manager = require("controller.audio_manager")
local RoleDefault = require("controller.RoleDefault")

return function(arg_1_0)
	return setfenv(function()
		_pause = false
		collect_gold_timer = 15

		local var_2_0 = 11207429
		local var_2_1 = bit.bxor(0, 11207429)

		function getGlobalDamageAddition()
			return bit.bxor(var_2_1, var_2_0) / 10
		end

		function setGlobalDamageAddition(arg_4_0)
			var_2_1 = bit.bxor(arg_4_0, var_2_0)
		end

		function addGlobalDamageAddition(arg_5_0)
			var_2_1 = bit.bxor(bit.bxor(var_2_1, var_2_0) + arg_5_0, var_2_0)
		end

		local var_2_2 = 13435301
		local var_2_3 = bit.bxor(RoleDefault:getInstance():getIntegerForKey("fightSpeed", 10), 13435301)

		function getBossSpeedUpForce()
			return bit.bxor(var_2_3, var_2_2) / 10
		end

		function getBossSpeedUp()
			return (not isNormalFight() or isBigBossFight()) and bit.bxor(var_2_3, var_2_2) / 10 or 1
		end

		function setBossSpeedUp(arg_8_0)
			local var_8_0 = getBossSpeedUp()

			var_2_3 = bit.bxor(arg_8_0 * 10, var_2_2)

			RoleDefault:getInstance():setIntegerForKey("fightSpeed", arg_8_0 * 10)

			if not isNormalFight() or isBigBossFight() then
				updateFightUITimeScale(var_8_0)
				xp_effect_manager.updateBgTimeScale(var_8_0)
			end
		end

		function update(arg_9_0)
			collectgarbage(arg_9_0)

			if _pause then
				return
			end

			xp_effect_manager.update(arg_9_0)
			updatePosition(arg_9_0)
			updateFightStatus(arg_9_0)
			updateHalo(arg_9_0)
			updateFightElements(arg_9_0)
		end

		local function var_2_4(arg_10_0)
			local var_10_0 = getCamera().getCameraSpeed()

			for iter_10_0, iter_10_1 in var_0_9(players) do
				local var_10_1 = iter_10_1:getSpeed() * arg_10_0

				iter_10_1:move(var_10_1 - var_10_0, 0)
				iter_10_1:addDistance(var_0_3.abs(var_10_1))
			end
		end

		local function var_2_5(arg_11_0)
			local var_11_0 = getCamera().getCameraSpeed()

			for iter_11_0, iter_11_1 in var_0_9(enemies) do
				local var_11_1 = iter_11_1:getSpeed() * arg_11_0

				iter_11_1:move(var_11_1 - var_11_0, 0)
				iter_11_1:addDistance(var_0_3.abs(var_11_1))
			end
		end

		local function var_2_6(arg_12_0)
			local var_12_0 = getCamera().getCameraSpeed()

			for iter_12_0, iter_12_1 in var_0_9(character_garbage) do
				iter_12_1:move(-var_12_0, 0)
			end
		end

		local function var_2_7(arg_13_0)
			local var_13_0 = getCamera().getCameraSpeed()

			for iter_13_0, iter_13_1 in var_0_9(bullets) do
				local var_13_1 = iter_13_1:getSpeed()

				iter_13_1:move(var_13_1.x - var_13_0, var_13_1.y)
				iter_13_1:addDistance(var_0_3.abs(var_13_1.x))
			end
		end

		local function var_2_8(arg_14_0)
			local var_14_0 = getCamera().getCameraSpeed()

			for iter_14_0, iter_14_1 in var_0_9(golds) do
				iter_14_1:move(-var_14_0, 0)
			end
		end

		function updatePosition(arg_15_0)
			getCamera().update(arg_15_0)
			var_2_4(arg_15_0)
			var_2_5(arg_15_0)
			var_2_6(arg_15_0)
			var_2_7(arg_15_0)
			var_2_8(arg_15_0)
			fightconsoleRef:updateSmallMapChildrenPos()
		end

		function updateFightElements(arg_16_0)
			for iter_16_0, iter_16_1 in var_0_9(players) do
				iter_16_1:update(arg_16_0)
			end

			for iter_16_2, iter_16_3 in var_0_9(enemies) do
				iter_16_3:update(arg_16_0)
			end

			for iter_16_4, iter_16_5 in var_0_9(character_garbage) do
				iter_16_5:update(arg_16_0)
			end

			for iter_16_6, iter_16_7 in var_0_9(bullets) do
				iter_16_7:update(arg_16_0)
			end
		end

		function collectgarbage(arg_17_0)
			for iter_17_0, iter_17_1 in var_0_9(character_garbage) do
				if not iter_17_1._instance then
					character_garbage[iter_17_0] = nil
				elseif not iter_17_1._aniWait then
					iter_17_1:runAction(var_0_11.RemoveSelf:create())

					character_garbage[iter_17_0] = nil
				end
			end

			collect_gold_timer = collect_gold_timer - arg_17_0

			if collect_gold_timer <= 0 then
				for iter_17_2, iter_17_3 in var_0_9(golds) do
					iter_17_3:hide()
				end

				collect_gold_timer = 12
			end
		end

		function mainloop()
			mainloopID = mainloopID or var_0_11.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_19_0)
				update(arg_19_0 * var_0_0.global_battlefield_timescale * getBossSpeedUp())
			end, 0, false)
		end

		function unloop()
			if mainloopID then
				var_0_11.Director:getInstance():getScheduler():unscheduleScriptEntry(mainloopID)

				mainloopID = nil
			end
		end

		function releaseAllCharacter()
			setFightState(var_0_21)

			for iter_21_0, iter_21_1 in var_0_9(enemies) do
				iter_21_1:removeFromParent()

				enemies[iter_21_0] = nil
			end

			enemies = {}
			charactersCount.enemiesCount = 17
			bossDie = false

			for iter_21_2, iter_21_3 in var_0_9(players) do
				iter_21_3:removeFromParent()

				players[iter_21_2] = nil
			end

			players = {}
			charactersCount.playersCount = 17
			charactersCount = {
				enemiesCount = 17,
				playersCount = 17
			}

			for iter_21_4, iter_21_5 in var_0_9(character_garbage) do
				if iter_21_5._instance then
					iter_21_5:removeFromParent()
				end
			end

			character_garbage = {}

			for iter_21_6, iter_21_7 in var_0_9(bullets) do
				iter_21_7:destroy()
			end

			bullets = {}

			for iter_21_8, iter_21_9 in var_0_9(golds) do
				iter_21_9:removeFromParent()
			end

			golds = {}
			halos = {}
			source_halo = {}
			target_halo = {}

			xp_effect_manager.removeXP()
			stopStatistics()
			detachAllBuffPanels()

			fighttype = nil
			pvpfighting = false
			pvefighting = false
			fightingBigBoss = false
			refightingBigBoss = false
			fightingNormalBoss = false

			unloop()
		end

		function collectAllGolds()
			for iter_22_0, iter_22_1 in var_0_9(golds) do
				if iter_22_0 == #golds then
					iter_22_1:collect(function()
						var_0_0.global_gold_animation()
					end)
				else
					iter_22_1:collect()
				end
			end

			collect_gold_timer = 12
		end

		function pauseBattleField()
			for iter_24_0, iter_24_1 in var_0_9(players) do
				iter_24_1:lockBattleField()
			end

			for iter_24_2, iter_24_3 in var_0_9(enemies) do
				iter_24_3:lockBattleField()
			end

			for iter_24_4, iter_24_5 in var_0_9(bullets) do
				iter_24_5:lockBattleField()
			end

			xp_effect_manager.lockBattleField()
			audio_manager:pauseAllFightSound()

			_pause = true
		end

		function resumeBattleField(arg_25_0)
			for iter_25_0, iter_25_1 in var_0_9(players) do
				iter_25_1:unlockBattleField()
			end

			for iter_25_2, iter_25_3 in var_0_9(enemies) do
				iter_25_3:unlockBattleField()
			end

			for iter_25_4, iter_25_5 in var_0_9(bullets) do
				iter_25_5:unlockBattleField()
			end

			xp_effect_manager.unlockBattleField()
			audio_manager:resumeAllFightSound()

			_pause = false
		end

		function die(arg_26_0)
			clearHalo(arg_26_0)
		end

		function targetInRange(arg_27_0, arg_27_1, arg_27_2)
			if skill_data[arg_27_0].exe_target == 1 or skill_data[arg_27_0].exe_target == 5 then
				if not skill_data[arg_27_0].exe_range then
					return true
				elseif not arg_27_1 or not arg_27_2 then
					return false
				else
					return getCharacterDistance(arg_27_1, arg_27_2) <= skill_data[arg_27_0].exe_range
				end
			else
				return true
			end
		end

		function triggerEnemyDied(arg_28_0)
			local var_28_0, var_28_1 = var_0_5(arg_28_0.index, "([^@]+)@(.+)")
			local var_28_2

			if var_28_0 == "players" then
				var_28_2 = enemies
			elseif var_28_0 == "enemies" then
				var_28_2 = players
			end

			if not var_28_2 then
				return
			end

			for iter_28_0, iter_28_1 in var_0_9(var_28_2) do
				if iter_28_1._instance and iter_28_1:getState() ~= var_0_29 and iter_28_1:getState() ~= var_0_32 then
					iter_28_1:triggerStatus("onEnemyDied", arg_28_0)
				end
			end
		end
	end, arg_1_0)
end
