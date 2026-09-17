local activity_base_manager = require("controller.activitymodules.activity_base_manager")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local monsterdata = require("data.monsterdata")
local monsterteamdata = require("data.monsterteamdata")
local horcrux_manager = require("controller.horcrux_manager")
local weapon_manager = require("controller.weapon_manager")
local component_manager = require("controller.component_manager")
local network = require("network.network")
local chapter_data = require("data.chapter_data")
local playermodel = require("model.playermodel")

function activity_base_manager.getAutoChessModeType(arg_1_0, arg_1_1)
	return ACTIVITY_ID_TO_MODETYPE_FUNC.auto_chess(arg_1_1)
end

function activity_base_manager:getAutoChessReNeed(arg_2_1)
	return self:getActivityObj(arg_2_1):getAutoChessReNeed()
end

function activity_base_manager:getAutoChessServantList(arg_3_1)
	return self:getActivityObj(arg_3_1):getAutoChessServantList()
end

function activity_base_manager:getMaxStarByContrant(arg_4_1, arg_4_2)
	return self:getActivityObj(arg_4_1):getMaxStarByContrant(arg_4_2)
end

function activity_base_manager:getAutoChessUpstarNeedList(arg_5_1, arg_5_2, arg_5_3)
	return self:getActivityObj(arg_5_1):getAutoChessUpstarNeedList(arg_5_2, arg_5_3)
end

function activity_base_manager:get_auto_chess_info(arg_6_1)
	return self:getActivityObj(arg_6_1):get_auto_chess_info()
end

function activity_base_manager:activity_autochess_select(arg_7_1, arg_7_2)
	return self:getActivityObj(arg_7_1):activity_autochess_select(arg_7_2)
end

function activity_base_manager:activity_autochess_upstar(arg_8_1, arg_8_2, arg_8_3)
	return self:getActivityObj(arg_8_1):activity_autochess_upstar(arg_8_2, arg_8_3)
end

function activity_base_manager:activity_autochess_refresh(arg_9_1)
	return self:getActivityObj(arg_9_1):activity_autochess_refresh()
end

function activity_base_manager:activity_autochess_set_array(arg_10_1, arg_10_2)
	return self:getActivityObj(arg_10_1):activity_autochess_set_array(arg_10_2)
end

function activity_base_manager.getChapterConfByMode(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	return chapter_data[arg_11_1 .. "-" .. arg_11_2][arg_11_3]
end

function activity_base_manager.switchToAutoChessDefence(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_3) do
		var_12_0[iter_12_0] = iter_12_1.servantid
	end

	network:rpc("switch_to_adventuremode", {
		mode = arg_12_1,
		chapter = arg_12_2,
		servants = var_12_0
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			local playermodel = require("model.playermodel")

			playermodel.levelmode[arg_12_1] = arg_13_0.levelmode
			playermodel.curLevel = arg_13_0.curlevel
			playermodel.curMode = arg_13_0.curmode
			arg_12_0.isFighting = true
			arg_12_0.autoChessroleList = arg_12_3

			FightManager.setWorldMapWidth(FIGHTTYPE_AUTO_CHESS, arg_12_0:getChapterConfByMode(arg_12_1, arg_12_2, "level_lenth") or 3000)

			if arg_12_4 then
				arg_12_4(arg_13_0)
			end
		elseif arg_12_4 then
			arg_12_4(arg_13_0)
		end
	end)
end

function activity_base_manager.autoChessFightSuccess(arg_14_0, arg_14_1)
	local item_manager = require("controller.item_manager")
	local dropcache_manager = require("controller.dropcache_manager")
	local model_manager = require("controller.model_manager")
	local tips_manager = require("controller.tips_manager")
	local var_14_4, var_14_5 = playermodel.curLevel:match("(%d+)-(%d+)")

	network:rpc("pass_adventure", {
		mode = playermodel.curMode,
		time = FightManager.getFightTimeStatistics()
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			if arg_15_0.gold and arg_15_0.gold > 0 then
				playermodel.gold = playermodel.gold + arg_15_0.gold
			end

			if arg_15_0.diamond and arg_15_0.diamond > 0 then
				playermodel.diamond = playermodel.diamond + arg_15_0.diamond
			end

			local var_15_0 = {}

			if arg_15_0.items then
				for iter_15_0, iter_15_1 in pairs(arg_15_0.items) do
					dropcache_manager:insertItemCache(iter_15_1)
				end
			end

			if arg_15_0.gainitems then
				for iter_15_2, iter_15_3 in pairs(arg_15_0.gainitems) do
					local var_15_1 = {}
					local var_15_2 = item_manager:setItemByServerItem(iter_15_3)

					var_15_1.entityid = iter_15_3.entityid
					var_15_1.number = var_15_2

					if var_15_2 > 0 then
						table.insert(var_15_0, var_15_1)
					end

					if item_data[iter_15_3.itemid].bag_item_type == kITEM_HERO or item_data[iter_15_3.itemid].bag_item_type == kITEM_SKIN then
						require("view.Layer.GetRoleAnimationLayer")

						local var_15_3 = GetRoleAnimationLayer:create(iter_15_3.itemid)

						if not var_15_3:getParent() then
							global_basic_scene:addChild(var_15_3, 999)
						end
					end
				end
			end

			if arg_15_0.gold and arg_15_0.gold > 0 then
				table.insert(var_15_0, {
					entityid = "gold",
					number = arg_15_0.gold
				})
			end

			if arg_15_0.diamond and arg_15_0.diamond > 0 then
				table.insert(var_15_0, {
					entityid = "diamond",
					number = arg_15_0.diamond
				})
			end

			local var_15_4 = {
				gold = arg_15_0.gold,
				diamond = arg_15_0.diamond,
				score = arg_15_0.score,
				items = var_15_0
			}

			global_update_gold_stone_diamond(arg_15_0.gold, nil, playermodel.diamond)

			playermodel.curLevel = arg_15_0.curlevel
			playermodel.curMode = arg_15_0.curmode
			playermodel.levelmode[arg_15_0.levelmode.mode] = arg_15_0.levelmode

			if arg_15_0.gold and arg_15_0.gold > 0 then
				AnalyticManager.getGold("traingold", arg_15_0.gold)
			end

			if arg_15_0.costticket then
				item_manager:deleteItem(arg_15_0.costticket.entityid, arg_15_0.costticket.num)
			end

			tips_manager:triggerWithPassLevel(playermodel.curMode, playermodel.levelmode[arg_15_0.levelmode.mode].status)

			if arg_14_1 then
				arg_14_1(1, var_15_4)
			end
		elseif arg_14_1 then
			arg_14_1(0)
		end
	end)
end

function activity_base_manager:getAutoChessArray(arg_16_1)
	return self:getActivityObj(arg_16_1):getAutoChessArray()
end

function activity_base_manager.autoChessFightFail(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0, var_17_1 = playermodel.curLevel:match("(%d+)-(%d+)")
	local var_17_2

	if arg_17_2 then
		arg_17_2()

		var_17_2 = {
			mode = playermodel.curMode,
			fighttime = FightManager.getFightTimeStatistics()
		}
	end

	var_17_2.failtype = arg_17_1 and 2 or 1

	network:rpc("pass_adventure_fail", var_17_2, function(arg_18_0)
		return
	end)
end

function activity_base_manager:getCurAutoChessroleList()
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in ipairs(self.autoChessroleList) do
		table.insert(var_19_0, self:createAutoChessServant(iter_19_1))
	end

	return var_19_0
end

function activity_base_manager:getAutoChessFightingModelid()
	return servant_data[self.autoChessroleList[math.random(#self.autoChessroleList)].servantid].modelid
end

function activity_base_manager:getAutoChessServantCost(arg_21_1, arg_21_2)
	return self:getActivityObj(arg_21_1):getAutoChessServantCost(arg_21_2)
end

function activity_base_manager.getAutoChessLvByStar(arg_22_0, arg_22_1)
	return ({
		200,
		250,
		300,
		310,
		320,
		330
	})[arg_22_1] or 330
end

function activity_base_manager:createAutoChessServant(arg_23_1)
	return {
		science_point = 1800,
		rank = 5,
		fight_girl = arg_23_1.servantid,
		modelid = servant_data[arg_23_1.servantid].modelid,
		soulid = servant_data[arg_23_1.servantid].modelid,
		servantid = arg_23_1.servantid,
		servantskin = model_data[servant_data[arg_23_1.servantid].modelid].itemid,
		weapon = weapon_manager:createMaxWeaponData(arg_23_1.servantid),
		component = component_manager:createMaxComponentData(arg_23_1.servantid),
		level = (function(arg_24_0)
			return arg_24_0
		end)(arg_23_1.star),
		contract = self:getAutoChessLvByStar(arg_23_1.star)
	}
end

function activity_base_manager:getAutoChessJumpID(arg_25_1)
	return self:getActivityObj(arg_25_1):getAutoChessJumpID()
end

function activity_base_manager:getAutoChessRefreshNeedItem(arg_26_1)
	return self:getActivityObj(arg_26_1):getAutoChessRefreshNeedItem()
end

function activity_base_manager:getAutoChessSelectNeedItem(arg_27_1)
	return self:getActivityObj(arg_27_1):getAutoChessSelectNeedItem()
end

function activity_base_manager:getAutoChessRedomList(arg_28_1)
	return self:getActivityObj(arg_28_1):getAutoChessRedomList()
end

function activity_base_manager:canAutoChessServantUpStar(arg_29_1, arg_29_2)
	return self:getActivityObj(arg_29_1):canAutoChessServantUpStar(arg_29_2)
end
