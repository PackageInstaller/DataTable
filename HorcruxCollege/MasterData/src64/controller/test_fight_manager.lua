local var_0_0 = {}
local network = require("network.network")
local model_data = require("data.model_data")
local major_factor_data = require("data.major_factor_data")
local item_data = require("data.item_data")
local servant_data = require("data.servant_data")
local monsterdata = require("data.monsterdata")
local monsterteamdata = require("data.monsterteamdata")
local horcrux_manager = require("controller.horcrux_manager")
local weapon_manager = require("controller.weapon_manager")
local component_manager = require("controller.component_manager")
local activity_manager = require("controller.activity_manager")

function var_0_0.createMaxData(arg_1_0, arg_1_1)
	return {
		science_point = 1800,
		contract = 5,
		rank = 5,
		level = 300,
		fight_girl = arg_1_1.servantid,
		modelid = arg_1_1.modelid,
		soulid = arg_1_1.modelid,
		servantid = arg_1_1.servantid,
		servantskin = model_data[arg_1_1.modelid].itemid,
		horcrux = horcrux_manager:createMaxHorcruxData(arg_1_1.horcruxid),
		weapon = weapon_manager:createMaxWeaponData(arg_1_1.servantid),
		component = component_manager:createMaxComponentData(arg_1_1.servantid)
	}
end

function var_0_0.getPvpArrayFromSever(arg_2_0)
	network:rpc("get_test_fight_pvp_array", {}, function(arg_3_0)
		arg_2_0:updatePvpArray(arg_3_0)
		activity_manager:fireEvent(activity_manager.activityEventId.CHANGE_TEST_E_FIGHT_ARRAY_SUCCESS, arg_3_0)
	end)
end

function var_0_0.changePvpArrayByIndes(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	network:rpc("change_test_fight_pvp_array_by_index", {
		index = arg_4_1,
		servantid = arg_4_2,
		modelid = arg_4_3
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			arg_4_0:updatePvpArray(arg_5_0)
		end

		activity_manager:fireEvent(activity_manager.activityEventId.CHANGE_TEST_E_FIGHT_ARRAY_SUCCESS, arg_5_0)
	end)
end

function var_0_0:updatePvpArray(arg_6_1)
	self.pvpArray = {}

	for iter_6_0 = 1, FORMATION_SHOW_GIRL_NUM do
		if arg_6_1.array_list[iter_6_0].servantid then
			self.pvpArray[iter_6_0] = self:createMaxData(arg_6_1.array_list[iter_6_0])
		end
	end
end

function var_0_0:getPvpArray()
	if self.pvpArray then
		return self.pvpArray
	end
end

function var_0_0:getFightRresultPvpData()
	local var_8_0 = {
		playerArray = {},
		enemyArray = {}
	}

	for iter_8_0, iter_8_1 in pairs(self.pvpArray) do
		var_8_0.enemyArray[iter_8_0] = {
			servantid = iter_8_1.servantid
		}
	end

	for iter_8_2, iter_8_3 in pairs(self.playerArray) do
		var_8_0.playerArray[iter_8_2] = {
			fight_girl = iter_8_3.modelid
		}
	end

	return var_8_0
end

function var_0_0.getPveArray(arg_9_0)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs({
		1000000001,
		1000000002,
		1000000003
	}) do
		table.insert(var_9_0, {
			modelid = monsterdata[iter_9_1].modelid,
			mosterid = iter_9_1
		})
	end

	return var_9_0
end

function var_0_0:getFightRresultPveData()
	local var_10_0 = {
		playerArray = {},
		enemyArray = {}
	}

	for iter_10_0, iter_10_1 in pairs(self:getPveArray()) do
		var_10_0.enemyArray[iter_10_0] = {
			servantid = iter_10_1.mosterid
		}
	end

	for iter_10_2, iter_10_3 in pairs(self.playerArray) do
		var_10_0.playerArray[iter_10_2] = {
			fight_girl = iter_10_3.servantid
		}
	end

	return var_10_0
end

function var_0_0.initBossList(arg_11_0)
	local var_11_0 = monsterteamdata["100000000"]

	assert(monsterteamdata["100000000"] ~= nil, "there is no data of team " .. "100000000" .. " in monster team data!!!")

	local var_11_1 = {}

	while var_11_0["monster" .. 1] do
		var_11_1[#var_11_1 + 1] = {}
		var_11_1[#var_11_1 + 1].id = var_11_0["monster" .. 1]
		var_11_1[#var_11_1 + 1].majorlist = monsterdata[var_11_0["monster" .. 1]]
		var_11_1[#var_11_1 + 1].pos = var_11_0["pos" .. 1]
		var_11_1[#var_11_1 + 1].posy = var_11_0["posy" .. 1]
		var_11_1[#var_11_1 + 1].delaytime = var_11_0["delay" .. 1]
		var_11_1[#var_11_1 + 1].offset = var_11_0["offset" .. 1]
	end

	if var_11_0.boss then
		var_11_1.boss = {}
		var_11_1.boss.id = var_11_0.boss
		var_11_1.boss.majorlist = monsterdata[var_11_0.boss]
		var_11_1.boss.pos = var_11_0.posboss
		var_11_1.boss.posy = var_11_0.posyboss
		var_11_1.boss.delaytime = var_11_0.delayboss
		var_11_1.boss.offset = var_11_0.offsetboss
	end

	return var_11_1
end

local function var_0_12(arg_12_0, arg_12_1)
	local var_12_0

	while major_factor_data[model_data[arg_12_0].major]["item" .. 1] do
		if item_data[major_factor_data[model_data[arg_12_0].major]["item" .. 1]].model == arg_12_0 then
			var_12_0 = servant_data[arg_12_1]["modelid" .. 1]

			break
		end
	end

	return var_12_0
end

local function var_0_13(arg_13_0)
	return model_data[arg_13_0].spinecfg ~= nil and model_data[arg_13_0].behavior ~= nil
end

function var_0_0.getPLayerArrayFromSever(arg_14_0, arg_14_1)
	network:rpc("get_test_fight_player_array", {
		servantids = arg_14_1
	}, function(arg_15_0)
		arg_14_0:updatePlayerArray(arg_15_0)
		activity_manager:fireEvent(activity_manager.activityEventId.CHANGE_TEST_P_FIGHT_ARRAY_SUCCESS, arg_15_0)
	end)
end

function var_0_0:updatePlayerArray(arg_16_1)
	self.playerArray = {}

	for iter_16_0 = 1, FORMATION_SHOW_GIRL_NUM do
		local var_16_0 = arg_16_1.array_list[iter_16_0]

		if arg_16_1.array_list[iter_16_0] and var_16_0.servantid then
			if not var_16_0.modelid or var_16_0.modelid == "nil" then
				var_16_0.modelid = servant_data[var_16_0.servantid].modelid
			end

			if not var_0_13(var_16_0.modelid) then
				var_16_0.modelid = var_0_12(var_16_0.modelid, var_16_0.servantid)
			end

			self.playerArray[iter_16_0] = self:createMaxData(var_16_0)
		end
	end
end

function var_0_0.changePlayerArrayByIndes(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_2 and not var_0_13(arg_17_3) then
		arg_17_3 = var_0_12(arg_17_3, arg_17_2)
	end

	network:rpc("change_test_fight_player_array_by_index", {
		index = arg_17_1,
		servantid = arg_17_2,
		modelid = arg_17_3
	}, function(arg_18_0)
		if arg_18_0.result == 1 then
			arg_17_0:updatePlayerArray(arg_18_0)
		end

		activity_manager:fireEvent(activity_manager.activityEventId.CHANGE_TEST_P_FIGHT_ARRAY_SUCCESS, arg_18_0)
	end)
end

function var_0_0:getPlayerArray()
	if self.playerArray then
		return self.playerArray
	end
end

function var_0_0.changeTestFightArray(arg_20_0, arg_20_1, arg_20_2)
	network:rpc("change_test_fight_array", {
		pvpArray = arg_20_1,
		playerArray = arg_20_2
	}, function(arg_21_0)
		arg_20_0:updatePlayerArray({
			array_list = arg_21_0.pvpArray
		})
		arg_20_0:updatePvpArray({
			array_list = arg_21_0.playerArray
		})
		activity_manager:fireEvent(activity_manager.activityEventId.CHANGE_TEST_A_FIGHT_ARRAY_SUCCESS, arg_21_0)
	end)
end

return var_0_0
