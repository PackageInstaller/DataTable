local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local servant_data = require("data.servant_data")
local chapter_data = require("data.chapter_data")
local var_0_7 = FORMATION_SHOW_GIRL_NUM

var_0_0.bosshp = nil
var_0_0.damage = nil
var_0_0.mode = nil
var_0_0.oldScore = 0
var_0_0.level = 0
var_0_0.old_boss_hp = 0
var_0_0.totaltime = 0
var_0_0.fighttime = 0
var_0_0.havesettled = nil

function var_0_0.get_player_substitution_data(arg_1_0, arg_1_1, arg_1_2)
	network:rpc("get_player_substitution_data", {
		mode = arg_1_1
	}, function(arg_2_0)
		print("get_player_substitution_data====", dump(arg_2_0))

		if arg_2_0.result == 1 then
			if arg_2_0.fightcount == 0 then
				arg_1_0.oldScore = 0
				arg_1_0.newScore = nil
			else
				arg_1_0.newScore = arg_2_0.score
				arg_1_0.oldScore = arg_2_0.score
			end

			arg_1_0.old_boss_hp = arg_2_0.bosshp
			arg_1_0.mode = arg_2_0.levelmode.mode
			arg_1_0.uplist = arg_2_0.uplist
		end

		if arg_1_2 then
			arg_1_2(arg_2_0)
		end
	end)
end

function var_0_0.get_substitution_list(arg_3_0, arg_3_1)
	network:rpc("get_substitution_list", nil, function(arg_4_0)
		print("get_substitution_list", dump(arg_4_0))

		if arg_3_1 then
			arg_3_1(arg_4_0.list)
		end
	end)
end

function var_0_0.switch_to_substitution(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.level = arg_5_2

	network:rpc("switch_to_substitution", {
		mode = arg_5_1,
		chapter = arg_5_2,
		array = arg_5_3
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			playermodel.levelmode[arg_5_1] = arg_6_0.levelmode
			playermodel.curLevel = arg_6_0.curlevel
			playermodel.curMode = arg_6_0.curmode
			arg_5_0.array = arg_5_3

			arg_5_0:update_substitution_bosshp(tonumber(arg_6_0.bosshp))

			arg_5_0.havesettled = nil
			arg_5_0.totaltime = chapter_data[arg_5_1 .. "-" .. arg_5_2].limittime or 30
			arg_5_0.fighttime = 0

			FightManager.refreshFightToType(FIGHTTYPE_SUBSTITUTION)

			if arg_5_4 then
				arg_5_4(1)
			end
		elseif arg_5_4 then
			arg_5_4(arg_6_0.result)
		end
	end)
end

function var_0_0:getUpLevel()
	local var_7_0 = {}
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in pairs(self.uplist) do
		if iter_7_1.up == "0.25" then
			var_7_0[#var_7_0 + 1] = iter_7_1.servantid
		else
			var_7_1[#var_7_1 + 1] = iter_7_1.servantid
		end
	end

	return var_7_0, var_7_1
end

function var_0_0:getUpStr()
	local var_8_0, var_8_1 = self:getUpLevel()
	local var_8_2 = 0

	for iter_8_0 = 1, #var_8_0 do
		local var_8_3 = self:getArrayByServantID(var_8_0[iter_8_0])

		if var_8_3 and self.array == var_8_3 then
			var_8_2 = var_8_2 + 25
		end
	end

	return tostring(var_8_2)
end

function var_0_0:getLevel()
	return self.level
end

function var_0_0:resetRefightPlayer(arg_10_1)
	if not self.usingarrays or not self.usingarrays["array_" .. arg_10_1] then
		return nil
	end

	local var_10_0 = self.usingarrays

	playermodel.curSoul = {}

	for iter_10_0 = 1, var_0_7 do
		if var_10_0["array_" .. arg_10_1] and var_10_0["array_" .. arg_10_1]["pos_" .. iter_10_0].fight_girl then
			playermodel.curSoul[iter_10_0] = {
				classtype = 1,
				pos = iter_10_0,
				fight_girl = var_10_0["array_" .. arg_10_1]["pos_" .. iter_10_0].fight_girl,
				assist_girl = var_10_0["array_" .. arg_10_1]["pos_" .. iter_10_0].assist_girl
			}
		end
	end
end

function var_0_0:getSubstitutionPlayer()
	self:resetRefightPlayer(self.array)

	return playermodel.curSoul
end

function var_0_0.getSubstitutionEnemy(arg_12_0)
	return (monster_manager.initBossList((level_manager.getBossTeam())))
end

function var_0_0.update_substitution_bosshp(arg_13_0, arg_13_1)
	arg_13_0.bosshp = tostring(arg_13_1)
	arg_13_0.damage = "0"
end

function var_0_0:update_substitution_damage(arg_14_1)
	self.damage = tostring(tonumber(self.damage) + arg_14_1)

	FightLayer.getInstance():updateSubRate(self.damage)
end

function var_0_0:get_damage()
	return self.damage
end

function var_0_0:get_substitution_bosshp()
	return tonumber(self.bosshp)
end

function var_0_0:getOldScore()
	return self.oldScore
end

function var_0_0:getNewScore()
	return self.newScore
end

function var_0_0:pass_substitution(arg_19_1, arg_19_2)
	network:rpc("pass_substitution", {
		mode = arg_19_1,
		damage = self.damage,
		token = (function()
			local fight_capacity_manager = require("controller.fight_capacity_manager")
			local model_manager = require("controller.model_manager")
			local var_20_2 = {}

			for iter_20_0 = 1, 5 do
				if FightManager.players[iter_20_0] then
					local var_20_3 = {}

					var_20_3.servantid = FightManager.players[iter_20_0]:getAttribute("servantid")
					var_20_3.science_point = FightManager.players[iter_20_0]:getAttribute("science_point")
					var_20_3.hpFactor = FightManager.players[iter_20_0].model:getFactorAttribute("hpFactor")
					var_20_3.damageFactor = FightManager.players[iter_20_0].model:getFactorAttribute("damageFactor")
					var_20_3.attackspeed = FightManager.players[iter_20_0].model:getAttribute("attackspeed")
					var_20_3.defence = FightManager.players[iter_20_0].model:getAttribute("defence")
					var_20_3.maxrage = FightManager.players[iter_20_0].model:getAttribute("maxrage")

					local var_20_4

					if FightManager.players[iter_20_0]._assistconfig then
						var_20_4 = FightManager.players[iter_20_0]._assistconfig.entityid
					end

					local var_20_5 = model_manager.new()

					var_20_5:initPlayerAttribute(var_20_3.servantid)

					var_20_3.fightpower = fight_capacity_manager:computeFightCapacityNew(var_20_5, nil, var_20_3.servantid, var_20_4)

					if var_20_4 then
						-- block empty
					end

					table.insert(var_20_2, var_20_3)
				end
			end

			return json.encode(var_20_2)
		end)()
	}, function(arg_21_0)
		if arg_21_0.result == 1 then
			if arg_21_0.bosshp then
				self:setBossHp(self.old_boss_hp)
			end

			if self.newScore then
				self.oldScore = self.newScore
			end

			self.newScore = arg_21_0.score

			if arg_19_2 then
				arg_19_2(arg_21_0)
			end
		elseif arg_19_2 then
			arg_19_2(arg_21_0)
		end
	end)
end

function var_0_0:sync_substitution_time(arg_22_1)
	network:rpc("sync_substitution_time", {
		dt = tostring(arg_22_1),
		damage = tostring(self.damage)
	}, function(arg_23_0)
		if arg_23_0.result == 1 then
			self:updateFightTime(tonumber(arg_23_0.time))
		elseif arg_23_0.result == 2 then
			self.havesettled = arg_23_0

			FightManager.fightFailExtern()
		end
	end)
end

function var_0_0.setBossHp(arg_24_0, arg_24_1)
	arg_24_0.first_blood = arg_24_1
end

function var_0_0:get_first_blood()
	return self.first_blood
end

function var_0_0:updateFightTime(arg_26_1)
	self.fighttime = arg_26_1

	FightManager.updateFightTimeByServer(self.fighttime, 1, 0)
	self:updateFighLayerLefttTime()
end

function var_0_0:updateFighLayerLefttTime()
	FightLayer.getInstance():updateInfinteTimePanel(self:get_remain_time() or 0)
end

function var_0_0:get_remain_time()
	return self.totaltime - self.fighttime
end

function var_0_0:fightSuccess(arg_29_1, arg_29_2)
	self:pass_substitution(arg_29_1, arg_29_2)
end

function var_0_0:fightFail(arg_30_1, arg_30_2)
	if self.havesettled then
		if arg_30_2 then
			arg_30_2(self.havesettled)
		end
	else
		self:pass_substitution(arg_30_1, arg_30_2)
	end
end

function var_0_0.get_substitution_battlearrays(arg_31_0, arg_31_1, arg_31_2)
	network:rpc("get_substitution_battlearrays", {
		mode = arg_31_1
	}, function(arg_32_0)
		if arg_32_0.result == 1 then
			arg_31_0.usingarrays = arg_32_0.usingarrays
			arg_31_0.arraydata = arg_32_0.arraydata
			arg_31_0.locklist = arg_32_0.locklist

			if arg_31_2 then
				arg_31_2(arg_32_0.fightcount, arg_32_0.arraydata, arg_32_0.usingarrays, arg_32_0.locklist)
			end
		end
	end)
end

function var_0_0:getLockList()
	return self.locklist
end

function var_0_0:getUsingArraysData(arg_34_1)
	if not self.usingarrays or not self.usingarrays["array_" .. arg_34_1] then
		return nil
	end

	local var_34_0 = {}

	for iter_34_0 = 1, var_0_7 do
		var_34_0[iter_34_0] = self.usingarrays["array_" .. arg_34_1]["pos_" .. iter_34_0]
	end

	return var_34_0
end

function var_0_0:getSubArraysData(arg_35_1)
	if not self.arraydata["array_" .. arg_35_1] then
		return nil
	end

	local var_35_0 = {}

	for iter_35_0 = 1, var_0_7 do
		var_35_0[iter_35_0] = self.arraydata["array_" .. arg_35_1].array[iter_35_0]
	end

	return var_35_0
end

function var_0_0:getArrayByServantID(arg_36_1)
	if not self.usingarrays then
		return nil
	end

	for iter_36_0, iter_36_1 in pairs(self.usingarrays) do
		for iter_36_2 = 1, var_0_7 do
			if iter_36_1["pos_" .. iter_36_2].fight_girl == arg_36_1 then
				return iter_36_1.id
			end
		end
	end

	return nil
end

function var_0_0.getServantPos(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in pairs(var_0_0.usingarrays) do
		while iter_37_1["pos_" .. 1] do
			if iter_37_1["pos_" .. 1].fight_girl == arg_37_1 then
				return 1
			end
		end
	end
end

function var_0_0:getSubArrayData(arg_38_1)
	local var_38_0 = {}

	for iter_38_0 = 1, var_0_7 do
		var_38_0[#var_38_0 + 1] = {
			fight_girl = self.usingarrays["array_" .. arg_38_1]["pos_" .. iter_38_0].fight_girl
		}
	end

	if not next(self.arraydata) then
		return var_38_0
	end

	for iter_38_1, iter_38_2 in pairs(self.arraydata) do
		for iter_38_3 = 1, var_0_7 do
			var_38_0[#var_38_0 + 1] = {}

			if iter_38_2.array and iter_38_2.array[iter_38_3] then
				var_38_0[#var_38_0 + 1] = {
					fight_girl = iter_38_2.array[iter_38_3].servantid
				}
			end
		end
	end

	return var_38_0
end

function var_0_0:isServantInDefArrayNow(arg_39_1)
	return self:getArrayByServantID(arg_39_1) ~= nil
end

function var_0_0:getMode()
	return self.mode
end

function var_0_0.setEndTime(arg_41_0, arg_41_1)
	arg_41_0.endTime = arg_41_1
end

function var_0_0:getEndTime()
	return self.endTime
end

function var_0_0.set_substitution_servant(arg_43_0, arg_43_1, arg_43_2, arg_43_3, arg_43_4, arg_43_5)
	network:rpc("set_substitution_servant", {
		mode = arg_43_1,
		servantid = arg_43_2,
		pos = arg_43_3,
		array = arg_43_4
	}, function(arg_44_0)
		if arg_44_0.result == 1 then
			arg_43_0.usingarrays["array_" .. arg_43_4] = arg_44_0.array

			if arg_44_0.robbed_array then
				arg_43_0.usingarrays["array_" .. arg_44_0.robbed_array.id] = arg_44_0.robbed_array
			end
		end

		if arg_43_5 then
			arg_43_5(arg_44_0)
		end
	end)
end

function var_0_0.set_substitution_horcrux(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	network:rpc("set_substitution_horcrux", {
		mode = arg_45_1,
		horcrux = arg_45_2,
		pos = arg_45_3,
		array = arg_45_4
	}, function(arg_46_0)
		if arg_46_0.result == 1 then
			arg_45_0:deleteHorcruxInArrayNowAfterChange(arg_45_2)

			arg_45_0.usingarrays["array_" .. arg_45_4] = arg_46_0.array

			if arg_46_0.robbed_array then
				arg_45_0.usingarrays["array_" .. arg_46_0.robbed_array.id] = arg_46_0.robbed_array
			end
		end

		if arg_45_5 then
			arg_45_5(arg_46_0)
		end
	end)
end

function var_0_0:getSubByHorcruxID(arg_47_1)
	for iter_47_0, iter_47_1 in pairs(self.usingarrays) do
		for iter_47_2 = 1, var_0_7 do
			if iter_47_1["pos_" .. iter_47_2].assist_girl == arg_47_1 then
				return split(iter_47_0, "_")[2]
			end
		end
	end

	return nil
end

function var_0_0:getArrayScore(arg_48_1)
	return self.arraydata["array_" .. arg_48_1].score
end

function var_0_0:getSubByHorcruxEntityid()
	local var_49_0 = {}

	if self.locklist.horcrux then
		for iter_49_0, iter_49_1 in pairs(self.locklist.horcrux) do
			var_49_0[#var_49_0 + 1] = iter_49_1
		end
	end

	return var_49_0
end

function var_0_0:isHorcruxInArrayNow(arg_50_1)
	return self:getSubByHorcruxID(arg_50_1) ~= nil
end

function var_0_0:deleteHorcruxInArrayNowAfterChange(arg_51_1)
	for iter_51_0, iter_51_1 in pairs(self.usingarrays) do
		for iter_51_2 = 1, var_0_7 do
			if iter_51_1["pos_" .. iter_51_2].assist_girl == arg_51_1 then
				iter_51_1["pos_" .. iter_51_2].assist_girl = nil

				break
			end
		end
	end
end

function var_0_0.get_substitution_award(arg_52_0, arg_52_1, arg_52_2)
	network:rpc("get_substitution_award", {
		id = arg_52_1
	}, function(arg_53_0)
		if arg_53_0.result == 1 then
			global_gain({
				gold = arg_53_0.gold,
				diamond = arg_53_0.diamond,
				items = arg_53_0.items
			})

			if arg_52_2 then
				arg_52_2(1)
			end
		elseif arg_52_2 then
			arg_52_2(arg_53_0.result)
		end
	end)
end

function var_0_0.get_substitution_ranklist(arg_54_0, arg_54_1, arg_54_2)
	network:rpc("get_substitution_ranklist", {
		start = 0,
		stop = 99,
		mode = arg_54_1
	}, function(arg_55_0)
		if arg_54_2 then
			arg_54_2(arg_55_0.data)
		end
	end)
end

function var_0_0.get_substitution_battlearray_data(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	network:rpc("get_substitution_battlearray_data", {
		mode = arg_56_1,
		playerid = arg_56_2
	}, function(arg_57_0)
		if arg_57_0.result == 1 then
			arg_56_0.arraydata = arg_57_0.arraydata

			if arg_56_3 then
				arg_56_3(arg_57_0.arraydata)
			end
		elseif arg_56_3 then
			arg_56_3(arg_57_0.result)
		end
	end)
end

function var_0_0.get_player_substitution_rank(arg_58_0, arg_58_1, arg_58_2)
	network:rpc("get_player_substitution_rank", {
		mode = arg_58_1
	}, function(arg_59_0)
		if arg_59_0.result == 1 then
			if arg_59_0.rank then
				arg_59_0.rank = arg_59_0.rank + 1
			end

			if arg_58_2 then
				arg_58_2(arg_59_0)
			end
		elseif arg_58_2 then
			arg_58_2(arg_59_0.result)
		end
	end)
end

function var_0_0.setTeamSkill(arg_60_0, arg_60_1)
	arg_60_0.teamskill = arg_60_1
end

function var_0_0:getTeamSkill()
	return self.teamskill or {}
end

function var_0_0.reset_substitution(arg_62_0, arg_62_1, arg_62_2)
	network:rpc("reset_substitution", {
		mode = arg_62_1
	}, function(arg_63_0)
		if arg_63_0.result == 1 then
			if arg_63_0.fightcount == 0 then
				arg_62_0.oldScore = 0
				arg_62_0.newScore = nil
			else
				arg_62_0.oldScore = arg_63_0.score
			end

			arg_62_0.old_boss_hp = arg_63_0.bosshp
			arg_62_0.mode = arg_63_0.levelmode.mode
			arg_62_0.uplist = arg_63_0.uplist

			if arg_62_2 then
				arg_62_2(arg_63_0)
			end
		else
			print("@@@@@@@@@@@@@@@@@@@@@@@@志鹏")
		end
	end)
end

function var_0_0.reset_last_substitution(arg_64_0, arg_64_1, arg_64_2)
	network:rpc("reset_last_substitution", {
		mode = arg_64_1
	}, function(arg_65_0)
		if arg_65_0.result == 1 then
			if arg_65_0.fightcount == 0 then
				arg_64_0.oldScore = 0
				arg_64_0.newScore = nil
			else
				arg_64_0.oldScore = arg_65_0.score
				arg_64_0.newScore = arg_65_0.score
			end

			arg_64_0.old_boss_hp = arg_65_0.bosshp
			arg_64_0.mode = arg_65_0.levelmode.mode
			arg_64_0.uplist = arg_65_0.uplist

			if arg_64_2 then
				arg_64_2(arg_65_0)
			end
		end
	end)
end

function var_0_0.isSubstitutionModeType(arg_66_0, arg_66_1)
	return arg_66_1 == 601
end

function var_0_0.getCurSubstitutionActivityId(arg_67_0, arg_67_1)
	return 463
end

return var_0_0
