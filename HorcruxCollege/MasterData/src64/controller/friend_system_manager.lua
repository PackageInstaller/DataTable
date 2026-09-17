local var_0_0 = {}
local activity_manager = require("controller.activity_manager")
local time_check_manager = require("controller.time_check_manager")
local network = require("network.network")
local drop_data = require("data.drop_data")
local item_manager = require("controller.item_manager")
local substitution_manager = require("controller.substitution_manager")
local fight_capacity_manager = require("controller.fight_capacity_manager")
local major_factor_data = require("data.major_factor_data")
local model_data = require("data.model_data")
local model_manager = require("controller.model_manager")
local horcrux_manager = require("controller.horcrux_manager")
local core_manager = require("controller.core_manager")
local component_manager = require("controller.component_manager")
local weapon_manager = require("controller.weapon_manager")
local array_manager = require("controller.array_manager")
local playermodel = require("model.playermodel")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local var_0_19 = require("data.friend_const_data")[1].friend_gift_itemid

var_0_0.player_friend_list = {}
var_0_0.player_black_list = {}
var_0_0.player_application_list = {}
var_0_0.apply1_left_num = 0
var_0_0.apply2_left_num = 0
var_0_0.apply3_left_num = 0
var_0_0.apply1_num = 1
var_0_0.apply2_num = 1
var_0_0.apply3_num = 1

function var_0_0.get_friend_list(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_1 = arg_1_1 or 1
	arg_1_2 = arg_1_2 or 200

	network:rpc("get_friend_list", {
		start = arg_1_1,
		count = arg_1_2
	}, function(arg_2_0)
		if arg_2_0.result == 1 then
			arg_1_0.player_have_friend = arg_2_0.total
			arg_1_0.apply1_left_num = arg_1_0.player_have_friend - 200 * arg_1_0.apply1_num

			if arg_2_0.list and next(arg_2_0.list) then
				for iter_2_0, iter_2_1 in pairs(arg_2_0.list) do
					table.insert(arg_1_0.player_friend_list, iter_2_1)
				end
			end

			if arg_1_0.apply1_left_num <= 0 then
				if arg_1_3 then
					arg_1_3(arg_2_0.result, arg_1_0.player_friend_list)
				end
			else
				arg_1_0.apply1_num = arg_1_0.apply1_num + 1

				arg_1_0:get_friend_list(arg_1_0.apply1_num * 200 + 1, arg_1_0.apply1_num * 200 + 1 + 200, arg_1_3)
			end
		elseif arg_1_3 then
			arg_1_3(arg_2_0.result)
		end
	end)
end

function var_0_0.get_black_list(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_1 = arg_3_1 or 1
	arg_3_2 = arg_3_2 or 200

	network:rpc("get_black_list", {
		start = arg_3_1,
		count = arg_3_2
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			arg_3_0.player_black_max = arg_4_0.total
			arg_3_0.apply2_left_num = arg_3_0.player_black_max - 200 * arg_3_0.apply2_num

			if arg_4_0.list and next(arg_4_0.list) then
				for iter_4_0, iter_4_1 in pairs(arg_4_0.list) do
					table.insert(arg_3_0.player_black_list, iter_4_1)
				end
			end

			if arg_3_0.apply2_left_num <= 0 then
				if arg_3_3 then
					arg_3_3(arg_4_0.result, arg_3_0.player_black_list, 3)
				end
			else
				arg_3_0.apply2_num = arg_3_0.apply2_num + 1

				arg_3_0:get_black_list(arg_3_0.apply2_num * 200 + 1, arg_3_0.apply2_num * 200 + 1 + 200, arg_3_3)
			end
		elseif arg_3_3 then
			arg_3_3(arg_4_0.result, nil, 3)
		end
	end)
end

function var_0_0.get_friend_application_list(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_1 = arg_5_1 or 1
	arg_5_2 = arg_5_2 or 200

	network:rpc("get_friend_application_list", {
		start = arg_5_1,
		count = arg_5_2
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			arg_5_0.player_application_max = arg_6_0.total
			arg_5_0.apply3_left_num = arg_5_0.player_application_max - 200 * arg_5_0.apply3_num

			if arg_6_0.list and next(arg_6_0.list) then
				for iter_6_0, iter_6_1 in pairs(arg_6_0.list) do
					table.insert(arg_5_0.player_application_list, iter_6_1)
				end
			end

			if arg_5_0.apply3_left_num <= 0 then
				if arg_5_3 then
					arg_5_3(arg_6_0.result, arg_5_0.player_application_list, 2)
				end
			else
				arg_5_0.apply3_num = arg_5_0.apply3_num + 1

				arg_5_0:get_friend_application_list(arg_5_0.apply3_num * 200 + 1, arg_5_0.apply3_num * 200 + 1 + 200, arg_5_3)
			end
		elseif arg_5_3 then
			arg_5_3(arg_6_0.result, nil, 2)
		end
	end)
end

function var_0_0.get_friend_recommend_list(arg_7_0, arg_7_1, arg_7_2)
	network:rpc("get_friend_recommend_list", {
		refresh = arg_7_1
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			arg_7_0.player_recommend_list = arg_8_0.list

			if arg_7_2 then
				arg_7_2(arg_8_0.result, arg_8_0.list, 1)
			end
		elseif arg_7_2 then
			arg_7_2(arg_8_0.result, nil, 1)
		end
	end)
end

function var_0_0.apply_add_friend(arg_9_0, arg_9_1, arg_9_2)
	network:rpc("apply_add_friend", {
		playerid = arg_9_1
	}, function(arg_10_0)
		if arg_10_0.result == 1 then
			if arg_9_2 then
				arg_9_2(arg_10_0)
			end
		elseif arg_9_2 then
			arg_9_2(arg_10_0)
		end
	end)
end

function var_0_0.handle_friend_application(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	network:rpc("handle_friend_application", {
		applicantid = arg_11_1,
		type = arg_11_2
	}, function(arg_12_0)
		if arg_12_0.result == 1 then
			if arg_11_2 == 1 then
				arg_11_0:updateHaveFriendNum(2)
			end

			if arg_11_3 then
				arg_11_3(arg_12_0)
			end
		elseif arg_11_3 then
			arg_11_3(arg_12_0)
		end
	end)
end

function var_0_0.friend_search_player(arg_13_0, arg_13_1, arg_13_2)
	network:rpc("friend_search_player", {
		playerid = arg_13_1
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			arg_13_0.search_player = arg_14_0.data
			arg_13_0.search_player_status = arg_14_0.applied

			if arg_13_2 then
				arg_13_2(arg_14_0)
			end
		elseif arg_13_2 then
			arg_13_2(arg_14_0)
		end
	end)
end

function var_0_0.get_friend_information(arg_15_0, arg_15_1, arg_15_2)
	network:rpc("get_player_display_data", {
		playerid = arg_15_1
	}, function(arg_16_0)
		if arg_16_0.result == 1 then
			if arg_15_2 then
				arg_15_2(arg_16_0)
			end
		elseif arg_15_2 then
			arg_15_2(arg_16_0)
		end
	end)
end

function var_0_0.delete_add_friend(arg_17_0, arg_17_1, arg_17_2)
	network:rpc("delete_frined", {
		playerid = arg_17_1
	}, function(arg_18_0)
		if arg_18_0.result == 1 then
			arg_17_0:updateHaveFriendNum(1)

			if arg_17_2 then
				arg_17_2(arg_18_0)
			end
		elseif arg_17_2 then
			arg_17_2(arg_18_0)
		end
	end)
end

function var_0_0.get_friend_max_num(arg_19_0, arg_19_1)
	network:rpc("get_friend_data", nil, function(arg_20_0)
		if arg_20_0 then
			arg_19_0.friend_max = arg_20_0.maxfriend
			arg_19_0.apply_max = arg_20_0.maxpending
			arg_19_0.haveRedGift = arg_20_0.canreceive
			arg_19_0.newpendding = arg_20_0.newpendding

			if arg_19_0.haveRedGift then
				RoleDefault:getInstance():setBoolForKey("NewFriendGiftHave", true)
			else
				RoleDefault:getInstance():setBoolForKey("NewFriendGiftHave", false)
			end

			if arg_19_0.newpendding then
				RoleDefault:getInstance():setBoolForKey("NewFriendApplyHave", true)
			else
				RoleDefault:getInstance():setBoolForKey("NewFriendApplyHave", false)
			end

			activity_manager:fireEvent(activity_manager.activityEventId.FRIEND_NEW_Gift_NOTICE)
			activity_manager:fireEvent(activity_manager.activityEventId.FRIEND_NEW_APPLY_NOTICE)

			if arg_19_1 then
				arg_19_1(arg_20_0)
			end
		end
	end)
end

function var_0_0.set_signment(arg_21_0, arg_21_1, arg_21_2)
	network:rpc("set_signment", {
		msg = arg_21_1
	}, function(arg_22_0)
		if arg_21_1.result == 1 then
			if arg_21_2 then
				arg_21_2(arg_22_0)
			end
		elseif arg_21_2 then
			arg_21_2(arg_22_0)
		end
	end)
end

function var_0_0.friend_gift_opt(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	network:rpc("friend_gift_opt", {
		opt = arg_23_1,
		playerid = arg_23_2
	}, function(arg_24_0)
		if arg_24_0.result == 1 then
			if arg_24_0.items and next(arg_24_0.items) then
				arg_23_0.lastitem = arg_23_0:getPlayerFriendCurrency()

				global_get({
					items = arg_24_0.items
				})
			end

			if arg_23_3 then
				arg_23_3(arg_24_0)
			end
		elseif arg_23_3 then
			arg_23_3(arg_24_0)
		end
	end)
end

function var_0_0.get_someone_array(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	network:rpc("get_someone_array", {
		type = arg_25_1,
		playerid = arg_25_2
	}, function(arg_26_0)
		if arg_26_0.result == 1 then
			arg_25_0.array = arg_26_0.arrays[1].array

			if arg_25_3 then
				arg_25_3(arg_25_0:dealWithTheData(arg_26_0.arrays[1].array, arg_26_0.arrays[1].fightpower))
			end
		elseif arg_25_3 then
			arg_25_3(2)
		end
	end)
end

function var_0_0.get_enemy_defence_array(arg_27_0, arg_27_1, arg_27_2)
	network:rpc("get_enemy_defence_array", {
		playerid = arg_27_1
	}, function(arg_28_0)
		if arg_28_0.result == 1 then
			arg_27_0.tftenemyArray = arg_28_0.fightinfo

			if arg_27_2 then
				arg_27_2(arg_28_0.fightinfo)
			end
		elseif arg_27_2 then
			arg_27_2(arg_28_0)
		end
	end)
end

function var_0_0.get_someone_array_fightdata(arg_29_0, arg_29_1, arg_29_2)
	network:rpc("get_someone_array_fightdata", {
		playerid = arg_29_1
	}, function(arg_30_0)
		if arg_30_0.result == 1 then
			arg_29_0.curEnemyData = arg_30_0.playerdata

			if arg_29_2 then
				arg_29_2(arg_29_0.curEnemyData, arg_30_0.fightpower)
			end
		elseif arg_29_2 then
			arg_29_2(arg_30_0.result)
		end
	end)
end

function var_0_0:getPlayerFriendList()
	return self.player_friend_list
end

function var_0_0:isHaveFriends()
	return self.player_friend_list and #self.player_friend_list > 0
end

function var_0_0:getPlayerBlackList()
	return self.player_black_list
end

function var_0_0:getPlayerApplicationList()
	return self.player_application_list
end

function var_0_0:getPlayerRecommendList()
	return self.player_recommend_list
end

function var_0_0:getHaveFriendNum()
	return (self.player_have_friend or nil) and (self.player_have_friend or 0)
end

function var_0_0:getLastFriendNum()
	return (self.lastitem or nil) and (self.lastitem or 0)
end

function var_0_0:geMaxFriendNum()
	return (self.friend_max or nil) and (self.friend_max or 0)
end

function var_0_0.getPlayerFriendCurrency(arg_39_0)
	return item_manager:getItemNumber(var_0_19)
end

function var_0_0:geMaxFriendApplyNum()
	return (self.apply_max or nil) and (self.apply_max or 0)
end

function var_0_0:getSearchPlayerInfo()
	return self.search_player
end

function var_0_0:getSearchPlayerStatus()
	return self.search_player_status
end

function var_0_0.resetFriendListParam(arg_43_0)
	arg_43_0.player_friend_list = {}
	arg_43_0.apply1_left_num = 0
	arg_43_0.apply1_num = 1
end

function var_0_0.resetBlackListParam(arg_44_0)
	arg_44_0.player_black_list = {}
	arg_44_0.apply2_left_num = 0
	arg_44_0.apply2_num = 1
end

function var_0_0.resetApplicationListListParam(arg_45_0)
	arg_45_0.player_application_list = {}
	arg_45_0.apply3_left_num = 0
	arg_45_0.apply3_num = 1
end

function var_0_0:updateHaveFriendNum(arg_46_1)
	if not arg_46_1 then
		return
	end

	if self.player_have_friend and self.player_have_friend >= 0 then
		if arg_46_1 == 1 then
			self.player_have_friend = self.player_have_friend - 1

			if self.player_have_friend < 0 then
				self.player_have_friend = 0
			end
		elseif arg_46_1 == 2 then
			self.player_have_friend = self.player_have_friend + 1
		end

		if self.friend_max and self.friend_max >= 0 and self.player_have_friend > self.friend_max then
			self.player_have_friend = self.friend_max
		end
	end
end

function var_0_0.dealTheOnlineTime(arg_47_0, arg_47_1)
	if not arg_47_1 then
		return
	end

	if arg_47_1 == "-1" then
		return L_FRIEND_SYSTEM.online
	else
		local var_47_0 = time_check_manager:getCurTime() - global_get_time_by_date(arg_47_1)

		if var_47_0 < 60 then
			return L_FRIEND_SYSTEM.sec_online
		elseif var_47_0 >= 60 and var_47_0 < 3600 then
			return math.ceil(var_47_0 / 60) .. L_FRIEND_SYSTEM.min_online
		elseif var_47_0 >= 3600 and var_47_0 < 86400 then
			return math.ceil(var_47_0 / 3600) .. L_FRIEND_SYSTEM.hour_online
		elseif var_47_0 >= 86400 and var_47_0 < 604800 then
			return math.ceil(var_47_0 / 86400) .. L_FRIEND_SYSTEM.day_online
		else
			return " 7" .. L_FRIEND_SYSTEM.max_onlie
		end
	end
end

function var_0_0:getFrindArraysData(arg_48_1, arg_48_2)
	if not arg_48_1 then
		return
	end

	if arg_48_1 == 1 then
		-- block empty
	elseif arg_48_1 == 2 then
		return self:dealWithTheData(self:getCurArrayData())
	elseif arg_48_1 == 3 then
		return self:get3V3ArrayData(arg_48_2).battlearray
	elseif arg_48_1 == 4 then
		if arg_48_2 then
			return substitution_manager:getSubArraysData(arg_48_2)
		else
			return
		end
	end
end

function var_0_0:getFrindArrayCapacityData(arg_49_1, arg_49_2)
	if not arg_49_1 then
		return
	end

	if arg_49_1 == 1 then
		-- block empty
	elseif arg_49_1 == 2 then
		local var_49_0 = 0

		for iter_49_0, iter_49_1 in pairs((self:getCurArrayData())) do
			if iter_49_1.fightpower then
				var_49_0 = iter_49_1.fightpower + var_49_0
			end
		end

		return var_49_0
	elseif arg_49_1 == 3 then
		return self.tftenemyArray[arg_49_2].fightpower
	elseif arg_49_1 == 4 then
		return fight_capacity_manager:getSubUsingArrayFightCapacity((self:getFrindArraysData(arg_49_1, arg_49_2)))
	end
end

function var_0_0.getLockList(arg_50_0, arg_50_1)
	if not arg_50_1 or arg_50_1 ~= 4 then
		return
	end

	return substitution_manager:getLockList()
end

function var_0_0:getCurArrayData()
	return self.array
end

function var_0_0:dealWithTheData(arg_52_1, arg_52_2)
	local var_52_0 = {
		fightpower = arg_52_2 or 0
	}

	for iter_52_0, iter_52_1 in ipairs(arg_52_1) do
		var_52_0[iter_52_0] = {}
		var_52_0[iter_52_0].servantlevel = iter_52_1.level
		var_52_0[iter_52_0].servantrank = iter_52_1.rank
		var_52_0[iter_52_0].fightpower = iter_52_1.fightpower
		var_52_0[iter_52_0].modelid = iter_52_1.modelid
		var_52_0[iter_52_0].hp = iter_52_1.hp
		var_52_0[iter_52_0].damage = iter_52_1.damage
		var_52_0[iter_52_0].contract = iter_52_1.contract
		var_52_0[iter_52_0].overclock = iter_52_1.overclock

		if iter_52_1.assistid then
			var_52_0[iter_52_0].horcrux = {
				itemid = iter_52_1.assistid,
				hlv = iter_52_1.assistlv,
				hclass = iter_52_1.assisthclass,
				star = iter_52_1.assiststar
			}
		end

		if iter_52_1.modelid and iter_52_1.modelid ~= -1 then
			var_52_0[iter_52_0].servantid = self:getServentidBymodeid(iter_52_1.modelid)
		end
	end

	return var_52_0
end

function var_0_0.getServentidBymodeid(arg_53_0, arg_53_1)
	if not arg_53_1 then
		return
	end

	local var_53_0 = model_data[tostring(arg_53_1)] and model_data[tostring(arg_53_1)].major or nil

	return (major_factor_data[var_53_0] or nil) and (major_factor_data[var_53_0].servant or nil)
end

function var_0_0:get3V3ArrayData(arg_54_1)
	return self.tftenemyArray[arg_54_1]
end

var_0_0.curPlayerData = nil
var_0_0.curEnemyData = nil
var_0_0.pvpNeedData = nil

local function var_0_20(arg_55_0)
	local var_55_0 = {
		science_point = arg_55_0.science_point,
		star = arg_55_0.star
	}

	var_55_0.servantid = arg_55_0.servantid
	var_55_0.soulid = servant_data[arg_55_0.servantid].major
	var_55_0.contract = arg_55_0.contract

	local var_55_1 = arg_55_0.skillslevel or {}

	var_55_0.passiveLevel = var_55_1[1] or 0
	var_55_0.skill1Level = var_55_1[2] or 0
	var_55_0.servantrank = arg_55_0.servantrank
	var_55_0.servantskin = arg_55_0.servantskin
	var_55_0.overclock = arg_55_0.overclock
	var_55_0.favorlevel = arg_55_0.favorlevel
	var_55_0.satr = arg_55_0.satr

	local var_55_2 = {
		majorlist = var_55_0,
		component = arg_55_0.component,
		horcrux = arg_55_0.horcrux
	}

	if arg_55_0.weapon then
		var_55_2.weapon = {
			itemid = arg_55_0.weapon.itemid,
			weapon_attr = {
				exp = arg_55_0.weapon.exp,
				level = arg_55_0.weapon.level,
				nowStars = arg_55_0.weapon.nowStars
			}
		}
	end

	return var_55_2
end

function var_0_0:getArenaPlayer()
	if not self.curPlayerData then
		return nil
	end

	local var_56_0 = {}

	for iter_56_0, iter_56_1 in pairs(self.curPlayerData) do
		var_56_0[#var_56_0 + 1] = iter_56_1
	end

	return var_56_0
end

function var_0_0:getArenaEnemy()
	if not self.curEnemyData then
		return nil
	end

	local var_57_0 = {}

	for iter_57_0, iter_57_1 in pairs(self.curEnemyData) do
		var_57_0[#var_57_0 + 1] = var_0_20(iter_57_1)
	end

	return var_57_0
end

function var_0_0:passArena(arg_58_1, arg_58_2)
	if arg_58_2 then
		arg_58_2(self.pvpNeedData)
	end

	AnalyticManager.friend_fight_result({
		result = arg_58_1,
		playerName = self.pvpNeedData.playerName,
		enemyName = self.pvpNeedData.enemyName,
		playerArray = self.pvpNeedData.playerArray,
		enemyArray = self.pvpNeedData.enemyArray
	})
end

function var_0_0:fightSuccess(arg_59_1)
	self:passArena(1, arg_59_1)
end

function var_0_0:fightFail(arg_60_1)
	self:passArena(0, arg_60_1)
end

function var_0_0.initMyArrayData(arg_61_0)
	arg_61_0.curPlayerData = array_manager:getArenaAttackArray()
end

function var_0_0:start_fight(arg_62_1)
	HORCRUX_DEVOUR_FIGHT_TYPE = 3

	local var_62_0 = true

	for iter_62_0, iter_62_1 in pairs(self.curPlayerData) do
		if iter_62_1.fight_girl then
			var_62_0 = false
		end
	end

	if var_62_0 then
		if arg_62_1 then
			arg_62_1(2)
		end

		return
	end

	if FightManager.refreshFightToType(FIGHTTYPE_FRIENDFIGHT) then
		if arg_62_1 then
			arg_62_1(1)
		end
	elseif arg_62_1 then
		arg_62_1(0)
	end
end

function var_0_0:getArenaEnemyHorcruxDevour(arg_63_1)
	local var_63_0 = {}
	local var_63_1

	if self.curEnemyData then
		for iter_63_0 = 1, #self.curEnemyData do
			if self.curEnemyData[iter_63_0].servantid == arg_63_1 then
				var_63_1 = self.curEnemyData[iter_63_0].servant_horcrux

				break
			end
		end
	end

	if var_63_1 then
		for iter_63_1 = 1, HORCRUX_DEVOUR_MAX do
			var_63_0[iter_63_1] = var_63_1[iter_63_1] and var_63_1[iter_63_1] or {}
		end
	else
		for iter_63_2 = 1, HORCRUX_DEVOUR_MAX do
			var_63_0[iter_63_2] = {}
		end
	end

	return var_63_0
end

function var_0_0:setPvpNeedData(arg_64_1)
	self:initMyArrayData()

	self.pvpNeedData = {
		playerName = playermodel.nickname,
		enemyName = arg_64_1,
		playerArray = self.curPlayerData,
		enemyArray = self.curEnemyData
	}
end

function var_0_0.getFriendDormData(arg_65_0, arg_65_1, arg_65_2)
	network:rpc("get_someone_dorm_data", {
		playerid = arg_65_1
	}, function(arg_66_0)
		if arg_66_0.result == 1 then
			-- block empty
		else
			global_ShowBlockWords("参数错误")
		end

		if arg_65_2 then
			arg_65_2(arg_66_0)
		end
	end)
end

function var_0_0.getDormVisitAward(arg_67_0, arg_67_1, arg_67_2)
	network:rpc("get_dormvisit_award", {
		playerid = arg_67_1
	}, function(arg_68_0)
		print("get_dormvisit_award>>>>>>>", dump(arg_68_0))

		if arg_68_0.result == 1 then
			global_gain(arg_68_0)
		end

		if arg_67_2 then
			arg_67_2(arg_68_0)
		end
	end)
end

function var_0_0.randomVisitDorm(arg_69_0, arg_69_1)
	network:rpc("get_rand_dorm", nil, function(arg_70_0)
		if arg_70_0.result == 1 then
			-- block empty
		else
			global_ShowBlockWords("暂无宿舍可以访问")
		end

		if arg_69_1 then
			arg_69_1(arg_70_0)
		end
	end)
end

return var_0_0
