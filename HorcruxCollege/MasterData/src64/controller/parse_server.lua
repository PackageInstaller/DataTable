local var_0_0 = {}
local network = require("network.network")
local item_data = require("data.item_data")
local grade_manager = require("controller.grade_manager")
local tips_manager = require("controller.tips_manager")
local autopop_manager = require("controller.autopop_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")

require("controller.global_func")

local function var_0_7(arg_1_0)
	return tonumber((arg_1_0:match("^%d+")))
end

function var_0_0.passLevel(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local level_manager = require("controller.level_manager")
	local dropcache_manager = require("controller.dropcache_manager")
	local horcrux_manager = require("controller.horcrux_manager")
	local model_manager = require("controller.model_manager")
	local var_2_6, var_2_7 = (function()
		local var_3_0 = {}
		local var_3_1 = {}

		for iter_3_0 = 1, 5 do
			if FightManager.players[iter_3_0] then
				local var_3_2 = {}
				local var_3_3 = FightManager.players[iter_3_0]

				var_3_2.servantid = FightManager.players[iter_3_0]:getAttribute("servantid")
				var_3_2.science_point = var_3_3:getAttribute("science_point")
				var_3_2.hpFactor = var_3_3.model:getFactorAttribute("hpFactor")
				var_3_2.damageFactor = var_3_3.model:getFactorAttribute("damageFactor")
				var_3_2.attackspeed = var_3_3.model:getAttribute("attackspeed")
				var_3_2.defence = var_3_3.model:getAttribute("defence")
				var_3_2.maxrage = var_3_3.model:getAttribute("maxrage")

				local var_3_4

				if var_3_3._assistconfig then
					var_3_4 = var_3_3._assistconfig.entityid
				end

				local var_3_5 = model_manager.new()

				var_3_5:initPlayerAttribute(var_3_2.servantid)

				var_3_2.fightpower = fight_capacity_manager:computeFightCapacityNew(var_3_5, nil, var_3_2.servantid, var_3_4)

				if var_3_4 then
					local var_3_6 = horcrux_manager:getHorcruxAssistConfig(var_3_4)
				end

				table.insert(var_3_0, var_3_2)
				table.insert(var_3_1, {
					servantid = var_3_3:getAttribute("servantid"),
					status = var_3_3:getStatus() == STATUS_DIED and 0 or 1
				})
			end
		end

		return json.encode(var_3_0), var_3_1
	end)()

	network:rpc("pass_boss_level", {
		mode = arg_2_1,
		level = arg_2_2,
		token = var_2_6,
		fight_array = var_2_7,
		fighttime = math.floor((FightManager.getFightTimeStatistics()))
	}, function(arg_4_0)
		if arg_4_0.result ~= 0 then
			local var_4_0 = {
				new_star = level_manager:passLevelGetNewStar(playermodel.levelmode[arg_4_0.levelmode.mode].stars, arg_4_0.levelmode.stars)
			}

			playermodel.curLevel = arg_4_0.curlevel
			playermodel.curMode = arg_4_0.curmode
			playermodel.levelmode[arg_4_0.levelmode.mode] = arg_4_0.levelmode

			if arg_4_0.stardiamond then
				playermodel.diamond = playermodel.diamond + arg_4_0.stardiamond

				global_update_gold_stone_diamond(nil, nil, arg_4_0.stardiamond)
			end

			if arg_4_0.exp and arg_4_0.grade then
				grade_manager:update_player_exp(arg_4_0.exp, arg_4_0.grade, arg_4_0.totalexp)
			end

			if arg_4_0.sp then
				playermodel.strengthpoint = playermodel.strengthpoint + arg_4_0.sp

				global_update_strengthpoint(true)
				AlertManager:check_servant_strenghth(true)
			end

			if arg_4_0.result == 1 then
				if arg_4_0.gold then
					playermodel.gold = playermodel.gold + arg_4_0.gold
				end

				if arg_4_0.items then
					for iter_4_0, iter_4_1 in pairs(arg_4_0.items) do
						dropcache_manager:insertItemCache(iter_4_1)
					end
				end

				if arg_4_0.gainitems then
					for iter_4_2, iter_4_3 in pairs(arg_4_0.gainitems) do
						local var_4_1 = {}
						local var_4_2 = item_manager:setItemByServerItem(iter_4_3)

						var_4_1.entityid = iter_4_3.entityid
						var_4_1.number = var_4_2

						if var_4_2 > 0 then
							table.insert(var_4_0, var_4_1)
						end

						if item_data[iter_4_3.itemid].bag_item_type == kITEM_HERO or item_data[iter_4_3.itemid].bag_item_type == kITEM_SKIN then
							autopop_manager:pushbackGetNewRole(iter_4_3.itemid)
						end
					end
				end

				if arg_4_0.plotinfos then
					PlotManager:trigger_plot_by_server(arg_4_0.plotinfos)
				end

				if ListButtonLayer.getInstance() then
					ListButtonLayer.getInstance():updateButtonsUnlockStatus()
				end

				global_update_gold_stone_diamond(arg_4_0.gold)
			end

			if arg_2_1 ~= 1 or playermodel.levelmode[arg_4_0.levelmode.mode].pass ~= playermodel.levelmode[arg_4_0.levelmode.mode].pass then
				-- block empty
			elseif playermodel.levelmode[arg_4_0.levelmode.mode].status ~= playermodel.levelmode[arg_4_0.levelmode.mode].status then
				-- block empty
			else
				GuideListener.triggerGuide(TRIGGER_SMALLBOSS)
			end

			local levelmode_data = require("data.levelmode_data")

			if playermodel.levelmode[arg_4_0.levelmode.mode].pass ~= playermodel.levelmode[arg_4_0.levelmode.mode].pass and levelmode_data[arg_2_1] and levelmode_data[arg_2_1].modetype == 1 then
				tips_manager:onCanBossFight()
			end

			if playermodel.levelmode[arg_4_0.levelmode.mode].status ~= playermodel.levelmode[arg_4_0.levelmode.mode].status then
				level_manager:checkIsAlertNew(true, arg_4_0.newunlockmodes)
			end

			if arg_4_0.newunlockmodes and #arg_4_0.newunlockmodes > 0 then
				cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("newUnlockMode")))
			end

			AnalyticManager.passBossLevel(arg_4_0.gold, arg_4_0.levelmode.mode, playermodel.levelmode[arg_4_0.levelmode.mode].level)

			if arg_4_0.gold and arg_4_0.gold > 0 then
				table.insert(var_4_0, {
					entityid = "gold",
					number = arg_4_0.gold
				})
			end

			local var_4_4 = var_0_7(arg_2_2)

			if arg_2_3 then
				arg_2_3(var_4_0)
			end

			tips_manager:triggerWithPassLevel(playermodel.curMode, playermodel.levelmode[arg_4_0.levelmode.mode].status)

			local alert_manager = require("controller.alert_manager")

			if level_manager:checkStarRewardAlert() then
				alert_manager:register_alert(ALERT_STAR_REWARD)
			else
				alert_manager:unregister_alert(ALERT_STAR_REWARD, true)
			end

			cc.Director:getInstance():getEventDispatcher():dispatchEvent((cc.EventCustom:new("passLevel")))
		end
	end)
end

function var_0_0.passLevelAgain(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local level_manager = require("controller.level_manager")
	local dropcache_manager = require("controller.dropcache_manager")
	local horcrux_manager = require("controller.horcrux_manager")
	local model_manager = require("controller.model_manager")
	local var_5_6, var_5_7 = (function()
		local var_6_0 = {}
		local var_6_1 = {}

		for iter_6_0 = 1, 5 do
			if FightManager.players[iter_6_0] then
				local var_6_2 = {}
				local var_6_3 = FightManager.players[iter_6_0]

				var_6_2.servantid = FightManager.players[iter_6_0]:getAttribute("servantid")
				var_6_2.science_point = var_6_3:getAttribute("science_point")
				var_6_2.hpFactor = var_6_3.model:getFactorAttribute("hpFactor")
				var_6_2.damageFactor = var_6_3.model:getFactorAttribute("damageFactor")
				var_6_2.attackspeed = var_6_3.model:getAttribute("attackspeed")
				var_6_2.defence = var_6_3.model:getAttribute("defence")
				var_6_2.maxrage = var_6_3.model:getAttribute("maxrage")

				local var_6_4

				if var_6_3._assistconfig then
					var_6_4 = var_6_3._assistconfig.entityid
				end

				local var_6_5 = model_manager.new()

				var_6_5:initPlayerAttribute(var_6_2.servantid)

				var_6_2.fightpower = fight_capacity_manager:computeFightCapacityNew(var_6_5, nil, var_6_2.servantid, var_6_4)

				if var_6_4 then
					local var_6_6 = horcrux_manager:getHorcruxAssistConfig(var_6_4)
				end

				table.insert(var_6_0, var_6_2)
				table.insert(var_6_1, {
					servantid = var_6_3:getAttribute("servantid"),
					status = var_6_3:getStatus() == STATUS_DIED and 0 or 1
				})
			end
		end

		return json.encode(var_6_0), var_6_1
	end)()

	network:rpc("repeat_pass_big_boss", {
		mode = arg_5_1,
		level = arg_5_2,
		token = var_5_6,
		fight_array = var_5_7,
		fighttime = math.floor((FightManager.getFightTimeStatistics()))
	}, function(arg_7_0)
		if arg_7_0.result ~= 0 then
			playermodel.curLevel = arg_7_0.curlevel
			playermodel.curMode = arg_7_0.curmode
			playermodel.levelmode[arg_7_0.levelmode.mode] = arg_7_0.levelmode

			if arg_7_0.stardiamond then
				playermodel.diamond = playermodel.diamond + arg_7_0.stardiamond

				global_update_gold_stone_diamond(nil, nil, arg_7_0.stardiamond)
			end

			if arg_5_3 then
				arg_5_3({
					new_star = level_manager:passLevelGetNewStar(playermodel.levelmode[arg_7_0.levelmode.mode].stars, arg_7_0.levelmode.stars)
				})
			end

			local alert_manager = require("controller.alert_manager")

			if level_manager:checkStarRewardAlert() then
				alert_manager:register_alert(ALERT_STAR_REWARD)
			else
				alert_manager:unregister_alert(ALERT_STAR_REWARD, true)
			end
		end
	end)
end

function var_0_0.unlockNextChapter(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local playermodel = require("model.playermodel")

	network:rpc("unlock_next_chapter", {
		mode = arg_8_1,
		level = arg_8_2
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			playermodel.levelmode[arg_8_1] = arg_9_0.levelmode
			playermodel.curLevel = arg_9_0.curlevel
			playermodel.curMode = arg_9_0.curmode

			if arg_8_1 == 1 and playermodel.levelmode[arg_8_1].pass ~= playermodel.levelmode[arg_8_1].pass then
				GuideListener.triggerGuide(TRIGGER_PASSBEFOREBOSS)
			end

			if arg_8_3 then
				arg_8_3(1)
			end
		elseif arg_9_0.result == 2 then
			playermodel.levelmode[arg_8_1] = arg_9_0.levelmode
			playermodel.curLevel = arg_9_0.curlevel
			playermodel.curMode = arg_9_0.curmode

			if arg_8_3 then
				arg_8_3(2)
			end
		elseif arg_9_0.result == 3 then
			playermodel.levelmode[arg_8_1] = arg_9_0.levelmode
			playermodel.curLevel = arg_9_0.curlevel
			playermodel.curMode = arg_9_0.curmode

			if arg_8_3 then
				arg_8_3(3)
			end
		elseif arg_9_0.result == 4 then
			playermodel.levelmode[arg_8_1] = arg_9_0.levelmode
			playermodel.curLevel = arg_9_0.curlevel
			playermodel.curMode = arg_9_0.curmode

			if arg_8_3 then
				arg_8_3(4)
			end
		elseif arg_9_0.result == 5 then
			playermodel.levelmode[arg_8_1] = arg_9_0.levelmode
			playermodel.curLevel = arg_9_0.curlevel
			playermodel.curMode = arg_9_0.curmode

			if arg_8_3 then
				arg_8_3(5)
			end
		elseif arg_9_0.result == 6 then
			playermodel.levelmode[arg_8_1] = arg_9_0.levelmode
			playermodel.curLevel = arg_9_0.curlevel
			playermodel.curMode = arg_9_0.curmode

			if arg_8_3 then
				arg_8_3(6)
			end
		elseif arg_9_0.result == 7 then
			playermodel.levelmode[arg_8_1] = arg_9_0.levelmode
			playermodel.curLevel = arg_9_0.curlevel
			playermodel.curMode = arg_9_0.curmode

			if arg_8_3 then
				arg_8_3(7)
			end
		elseif arg_8_3 then
			arg_8_3(0)
		end
	end)
end

function var_0_0.selectCurMode(arg_10_0, arg_10_1, arg_10_2)
	local playermodel = require("model.playermodel")

	if playermodel.levelmode[arg_10_1].status <= 0 then
		if arg_10_2 then
			arg_10_2(2)
		end

		return
	end

	network:rpc("select_curmode", {
		mode = arg_10_1
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			playermodel.curLevel = arg_11_0.curlevel
			playermodel.curMode = arg_11_0.curmode

			require("controller.level_manager"):registerBasicModeInfo(arg_11_0.curmode, arg_11_0.modeinfo)

			if arg_10_2 then
				arg_10_2(1)
			end
		elseif arg_11_0.result == 2 then
			if arg_10_2 then
				arg_10_2(2)
			end
		elseif arg_11_0.result == 3 then
			if arg_10_2 then
				arg_10_2(3)
			end
		elseif arg_11_0.reuslt == 4 then
			if arg_10_2 then
				arg_10_2(4)
			end
		elseif arg_10_2 then
			arg_10_2(0)
		end
	end)
end

function var_0_0.passQuickFight(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")

	arg_12_3 = arg_12_3 or 1

	local var_12_2

	if arg_12_3 == 1 then
		var_12_2 = 9999999
	elseif arg_12_3 == 3 then
		var_12_2 = 9999998
	end

	network:rpc("quick_pass_level", {
		quicktype = arg_12_3,
		mode = arg_12_1,
		chapter = arg_12_2
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			item_manager:deleteItem(var_12_2, arg_13_0.cost)

			local var_13_0 = 0
			local var_13_1 = 0
			local var_13_2 = {}

			if arg_13_0.gold then
				playermodel.gold = playermodel.gold + arg_13_0.gold
				var_13_0 = arg_13_0.gold

				global_update_gold_stone_diamond(1)
			end

			if arg_13_0.sp then
				playermodel.strengthpoint = playermodel.strengthpoint + arg_13_0.sp
				var_13_1 = arg_13_0.sp

				global_update_strengthpoint(true)
				AlertManager:check_servant_strenghth(true)
			end

			if arg_13_0.exp and arg_13_0.grade then
				require("controller.grade_manager"):update_player_exp(arg_13_0.exp, arg_13_0.grade, arg_13_0.totalexp)
			end

			if arg_13_0.items then
				for iter_13_0, iter_13_1 in pairs(arg_13_0.items) do
					local var_13_3 = item_manager:setItemByServerItem(iter_13_1)

					if var_13_3 > 0 then
						table.insert(var_13_2, {
							dropid = iter_13_1.itemid,
							dropNum = var_13_3,
							entityid = iter_13_1.entityid
						})
					end
				end
			end

			playermodel.havequickfight = true

			if arg_12_4 then
				arg_12_4(1, {
					gold = var_13_0,
					sp = var_13_1,
					items = var_13_2
				})
			end
		elseif arg_12_4 then
			arg_12_4(arg_13_0.result)
		end
	end)
end

function var_0_0.passTrainQuickFight(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")

	network:rpc("quick_pass_level", {
		quicktype = 2,
		mode = arg_14_1,
		chapter = arg_14_2,
		servants = arg_14_3
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			local var_15_0 = 0
			local var_15_1 = 0
			local var_15_2 = {}

			if arg_15_0.gold then
				playermodel.gold = playermodel.gold + arg_15_0.gold
				var_15_0 = arg_15_0.gold

				global_update_gold_stone_diamond(1)
			end

			if arg_15_0.sp then
				playermodel.strengthpoint = playermodel.strengthpoint + arg_15_0.sp
				var_15_1 = arg_15_0.sp

				global_update_strengthpoint(true)
				AlertManager:check_servant_strenghth(true)
			end

			if arg_15_0.items then
				for iter_15_0, iter_15_1 in pairs(arg_15_0.items) do
					local var_15_3 = item_manager:setItemByServerItem(iter_15_1)

					if var_15_3 > 0 then
						table.insert(var_15_2, {
							dropid = iter_15_1.itemid,
							dropNum = var_15_3,
							entityid = iter_15_1.entityid
						})
					end
				end
			end

			for iter_15_2, iter_15_3 in ipairs(arg_14_3) do
				playermodel.quickfight[iter_15_3] = playermodel.quickfight[iter_15_3] + 1
			end

			if arg_14_4 then
				arg_14_4(1, {
					gold = var_15_0,
					sp = var_15_1,
					items = var_15_2
				})
			end
		elseif arg_14_4 then
			arg_14_4(arg_15_0.result)
		end
	end)
end

function var_0_0.passOfflineFight(arg_16_0, arg_16_1)
	network:rpc("pass_offline", nil, function(arg_17_0)
		if arg_16_1 then
			arg_16_1(arg_17_0)
		end
	end)
end

function var_0_0.passAdventure(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local playermodel = require("model.playermodel")
	local item_manager = require("controller.item_manager")
	local dropcache_manager = require("controller.dropcache_manager")
	local model_manager = require("controller.model_manager")
	local horcrux_manager = require("controller.horcrux_manager")
	local var_18_5, var_18_6 = (function()
		local var_19_0 = {}
		local var_19_1 = {}

		for iter_19_0 = 1, 5 do
			if FightManager.players[iter_19_0] then
				local var_19_2 = {}
				local var_19_3 = FightManager.players[iter_19_0]

				var_19_2.servantid = FightManager.players[iter_19_0]:getAttribute("servantid")
				var_19_2.science_point = var_19_3:getAttribute("science_point")
				var_19_2.hpFactor = var_19_3.model:getFactorAttribute("hpFactor")
				var_19_2.damageFactor = var_19_3.model:getFactorAttribute("damageFactor")
				var_19_2.attackspeed = var_19_3.model:getAttribute("attackspeed")
				var_19_2.defence = var_19_3.model:getAttribute("defence")
				var_19_2.maxrage = var_19_3.model:getAttribute("maxrage")

				local var_19_4

				if var_19_3._assistconfig then
					var_19_4 = var_19_3._assistconfig.entityid
				end

				local var_19_5 = model_manager.new()

				var_19_5:initPlayerAttribute(var_19_2.servantid)

				var_19_2.fightpower = fight_capacity_manager:computeFightCapacityNew(var_19_5, nil, var_19_2.servantid, var_19_4)

				if var_19_4 then
					local var_19_6 = horcrux_manager:getHorcruxAssistConfig(var_19_4)
				end

				table.insert(var_19_0, var_19_2)
				table.insert(var_19_1, {
					servantid = var_19_3:getAttribute("servantid"),
					status = var_19_3:getStatus() == STATUS_DIED and 0 or 1
				})
			end
		end

		return json.encode(var_19_0), var_19_1
	end)()

	network:rpc("pass_adventure", {
		mode = arg_18_1,
		token = var_18_5,
		fight_array = var_18_6,
		time = arg_18_3
	}, function(arg_20_0)
		if arg_20_0.result == 1 then
			if arg_20_0.gold and arg_20_0.gold > 0 then
				playermodel.gold = playermodel.gold + arg_20_0.gold
			end

			local var_20_0 = {}

			if arg_20_0.items then
				for iter_20_0, iter_20_1 in pairs(arg_20_0.items) do
					dropcache_manager:insertItemCache(iter_20_1)
				end
			end

			if arg_20_0.gainitems then
				for iter_20_2, iter_20_3 in pairs(arg_20_0.gainitems) do
					local var_20_1 = {}
					local var_20_2 = item_manager:setItemByServerItem(iter_20_3)

					var_20_1.entityid = iter_20_3.entityid
					var_20_1.number = var_20_2

					if var_20_2 > 0 then
						table.insert(var_20_0, var_20_1)
					end

					if item_data[iter_20_3.itemid].bag_item_type == kITEM_HERO or item_data[iter_20_3.itemid].bag_item_type == kITEM_SKIN then
						require("view.Layer.GetRoleAnimationLayer")

						local var_20_3 = GetRoleAnimationLayer:create(iter_20_3.itemid)

						if not var_20_3:getParent() then
							global_basic_scene:addChild(var_20_3, 999)
						end
					end
				end
			end

			if arg_20_0.gold and arg_20_0.gold > 0 then
				table.insert(var_20_0, {
					entityid = "gold",
					number = arg_20_0.gold
				})
			end

			local var_20_4 = {
				gold = arg_20_0.gold,
				score = arg_20_0.score,
				items = var_20_0
			}

			global_update_gold_stone_diamond(arg_20_0.gold)

			playermodel.curLevel = arg_20_0.curlevel
			playermodel.curMode = arg_20_0.curmode
			playermodel.levelmode[arg_20_0.levelmode.mode] = arg_20_0.levelmode

			if arg_20_0.externlevelmode then
				for iter_20_4, iter_20_5 in ipairs(arg_20_0.externlevelmode) do
					playermodel.levelmode[iter_20_5.mode] = iter_20_5
				end
			end

			if arg_20_0.gold and arg_20_0.gold > 0 then
				AnalyticManager.getGold("traingold", arg_20_0.gold)
			end

			if arg_20_0.costticket then
				item_manager:deleteItem(arg_20_0.costticket.entityid, arg_20_0.costticket.num)
			end

			tips_manager:triggerWithPassLevel(playermodel.curMode, playermodel.levelmode[arg_20_0.levelmode.mode].status)

			if require("controller.activity_manager"):isLockActivityBossFight(arg_18_1) then
				require("controller.formation.formation_bossfight_manager"):getInstance():clearFormation()
			end

			if arg_18_2 then
				arg_18_2(1, var_20_4, arg_20_0.remainfighttime, arg_20_0.canbuytime)
			end
		elseif arg_18_2 then
			arg_18_2(0)
		end
	end)
end

function var_0_0.onFightBigBoss(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	network:rpc("on_fight_big_boss", {
		mode = arg_21_1,
		chapter = arg_21_2,
		array = arg_21_3 or require("model.playermodel").curArray
	}, function(arg_22_0)
		return
	end)
end

function var_0_0.passLevelFail(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	network:rpc("pass_level_fail", {
		mode = arg_23_1,
		level = arg_23_2,
		fighttime = arg_23_3,
		failtype = arg_23_4
	}, function(arg_24_0)
		if arg_24_0.result == 1 then
			if arg_24_0.new_recharge and next(arg_24_0.new_recharge) then
				local LocalEvent = require("common.LocalEvent")

				LocalEvent:triggerEvent(LocalEvent.EVENT_IDS.SHOW_LIMITTIME_PACKAGES, {
					packages = arg_24_0.new_recharge
				})
			end
		else
			print("no recharge packages: ", arg_24_0.result)
		end
	end)
end

function var_0_0.passAdventureFail(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	network:rpc("pass_adventure_fail", {
		mode = arg_25_1,
		fighttime = arg_25_2,
		failtype = arg_25_3
	})
end

return var_0_0
