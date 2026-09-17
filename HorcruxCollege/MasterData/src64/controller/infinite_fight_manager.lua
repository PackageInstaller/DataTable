local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local level_manager = require("controller.level_manager")
local monster_manager = require("controller.monster_manager")
local servant_data = require("data.servant_data")

var_0_0.battlearray = nil
var_0_0.fighttime = 0
var_0_0.totaltime = 30
var_0_0.damage = 0
var_0_0.havesettled = nil

local function var_0_6(arg_1_0)
	local var_1_0 = {
		science_point = arg_1_0.science_point,
		star = arg_1_0.star
	}

	var_1_0.servantid = arg_1_0.servantid
	var_1_0.soulid = servant_data[arg_1_0.servantid].major
	var_1_0.contract = arg_1_0.contract

	local var_1_1 = arg_1_0.skillslevel or {}

	var_1_0.passiveLevel = var_1_1[1] or 0
	var_1_0.skill1Level = var_1_1[2] or 0
	var_1_0.servantrank = arg_1_0.servantrank
	var_1_0.servantskin = arg_1_0.servantskin
	var_1_0.overclock = arg_1_0.overclock
	var_1_0.reinforce_component = arg_1_0.reinforce_component
	var_1_0.favorlevel = arg_1_0.favorlevel

	local var_1_2 = {
		majorlist = var_1_0,
		component = arg_1_0.component,
		horcrux = arg_1_0.horcrux
	}

	if arg_1_0.weapon then
		var_1_2.weapon = {
			itemid = arg_1_0.weapon.itemid,
			weapon_attr = {
				exp = arg_1_0.weapon.exp,
				level = arg_1_0.weapon.level,
				nowStars = arg_1_0.weapon.nowStars
			}
		}
	end

	return var_1_2
end

function var_0_0:getInfinitePlayer()
	if not self.battlearray then
		return nil
	end

	local var_2_0 = {}

	for iter_2_0 = 1, #self.battlearray do
		var_2_0[iter_2_0] = var_0_6(self.battlearray[iter_2_0])
	end

	return var_2_0
end

function var_0_0.generateEnemy(arg_3_0)
	return monster_manager.initBossList((level_manager.getBossTeam()))
end

function var_0_0.switch_to_infinitemode(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	network:rpc("switch_to_infinitemode", {
		mode = arg_4_1
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			playermodel.levelmode[arg_4_1] = arg_5_0.levelmode
			playermodel.curLevel = arg_5_0.curlevel
			playermodel.curMode = arg_5_0.curmode
			arg_4_0.totaltime = 30
			arg_4_0.fighttime = 0
			arg_4_0.battlearray = arg_5_0.fightdata
			arg_4_0.havesettled = nil

			if arg_4_3 then
				arg_4_3(1)
			end
		elseif arg_4_3 then
			arg_4_3(arg_5_0.result)
		end
	end)
end

function var_0_0:pass_infinite(arg_6_1, arg_6_2)
	network:rpc("pass_infinite", {
		mode = arg_6_1,
		damage = tostring(self.damage)
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			self.havesettled = nil

			if arg_6_2 then
				arg_6_2(1, arg_7_0.score)
			end
		elseif arg_7_0.result == 2 then
			playermodel.levelmode[arg_6_1] = arg_7_0.levelmode
			playermodel.curLevel = arg_7_0.curlevel
			playermodel.curMode = arg_7_0.curmode
			self.totaltime = arg_7_0.totaltime
			self.damage = 0

			if arg_6_2 then
				arg_6_2(2)
			end
		elseif arg_6_2 then
			arg_6_2(0)
		end
	end)
end

function var_0_0:sync_infinite_time(arg_8_1)
	network:rpc("sync_infinite_time", {
		dt = tostring(arg_8_1),
		damage = tostring(self.damage)
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			self:updateFightTime(tonumber(arg_9_0.time))
		elseif arg_9_0.result == 2 then
			self.havesettled = arg_9_0.score

			FightManager.fightFailExtern()
		end
	end)
end

function var_0_0:get_remain_time()
	return self.totaltime - self.fighttime
end

function var_0_0:get_fight_time()
	return self.fighttime
end

function var_0_0:sync_boss_damage(arg_12_1)
	self.damage = self.damage + arg_12_1
end

function var_0_0:fightFail(arg_13_1, arg_13_2)
	if self.havesettled then
		if arg_13_2 then
			arg_13_2(1, self.havesettled)
		end
	else
		self:pass_infinite(arg_13_1, arg_13_2)
	end
end

function var_0_0:fightSuccess(arg_14_1, arg_14_2)
	print("FightSuccess!!!!!!!!!!!!!!!!!!!!!!!")
	self:pass_infinite(arg_14_1, arg_14_2)
end

function var_0_0:updateFightTime(arg_15_1)
	self.fighttime = arg_15_1

	FightManager.updateFightTimeByServer(self.fighttime, 1, 0)
	self:updateFighLayerLefttTime()
end

function var_0_0:updateFighLayerLefttTime()
	FightLayer.getInstance():updateInfinteTimePanel(self:get_remain_time() or 0)
end

function var_0_0.requestCleanSweep(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	network:rpc("adventure_sweep", {
		mode = tonumber(arg_17_1),
		chapter = tonumber(arg_17_2),
		times = tonumber(arg_17_3)
	}, function(arg_18_0)
		if arg_18_0.result == 1 then
			local item_manager = require("controller.item_manager")

			global_gain(arg_18_0)

			if arg_18_0.cost_items and next(arg_18_0.cost_items) then
				for iter_18_0, iter_18_1 in ipairs(arg_18_0.cost_items) do
					item_manager:deleteItem(iter_18_1.entityid, iter_18_1.num)
				end
			end

			if arg_18_0.gold and arg_18_0.gold > 0 then
				playermodel.gold = playermodel.gold + arg_18_0.gold
			end

			if arg_17_4 then
				arg_17_4(arg_18_0)
			end
		elseif arg_18_0.result == 2 then
			global_ShowBlockWords("当前关卡不能扫荡")
		elseif arg_18_0.result == 3 then
			global_ShowBlockWords("挑战次数不足")
		elseif arg_18_0.result == 4 then
			global_ShowBlockWords("扫荡卷不足")
		elseif arg_18_0.result == 5 then
			global_ShowBlockWords("章节未通关")
		elseif arg_18_0.result == 6 then
			global_ShowBlockWords("需要订阅特权")
		end
	end)
end

return var_0_0
