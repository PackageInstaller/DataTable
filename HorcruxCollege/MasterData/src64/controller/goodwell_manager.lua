local var_0_0 = {}

require("controller.global_func")

local network = require("network.network")
local playermodel = require("model.playermodel")
local favorevent_data = require("data.favorevent_data")
local favor_data = require("data.favor_data")
local servant_data = require("data.servant_data")
local item_manager = require("controller.item_manager")
local alert_manager = require("controller.alert_manager")

var_0_0.unlock_eventlist = {}
var_0_0.alert_ids = {}

local var_0_8 = config._DEBUG and 0 or 1

function var_0_0.getDegreeofFavor(arg_1_0)
	for iter_1_0 = 1, #playermodel.haveSuit do
		network:rpc("get_favor_degree", {
			favorid = 200 + iter_1_0
		}, function(arg_2_0)
			l2Log("get_favor_degree")

			playermodel.favorlevel[200 + iter_1_0] = arg_2_0.level
		end)
	end
end

function var_0_0.giveGift(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not playermodel.haveSuit[arg_3_1] then
		if arg_3_3 then
			arg_3_3(2)
		end

		return
	end

	if playermodel.gift_limit[arg_3_1] <= 0 then
		if arg_3_3 then
			arg_3_3(4)
		end

		return
	end

	network:rpc("give_favor_gift", {
		soulid = arg_3_1,
		list = arg_3_2
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			playermodel.favor[arg_3_1].favorlevel = arg_4_0.favorlevel
			playermodel.favor[arg_3_1].favordegree = arg_4_0.favordegree

			for iter_4_0, iter_4_1 in pairs(arg_3_2) do
				item_manager:deleteItem(iter_4_1.dropid, iter_4_1.dropNum)
			end

			if arg_3_3 then
				arg_3_3(1)
			end
		elseif arg_4_0.result == 2 then
			if arg_3_3 then
				arg_3_3(2)
			end
		elseif arg_4_0.result == 3 then
			if arg_3_3 then
				arg_3_3(3)
			end
		elseif arg_4_0.result == 4 then
			if arg_3_3 then
				arg_3_3(4)
			end
		elseif arg_3_3 then
			arg_3_3(0)
		end
	end)
end

function var_0_0.addFavorDegree(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not playermodel.haveSuit[arg_5_1] then
		if arg_5_3 then
			arg_5_3(2)
		end

		return
	end

	network:rpc("add_favor_degree", {
		soulid = arg_5_1,
		favor = arg_5_2
	}, function(arg_6_0)
		if arg_6_0.result == 1 then
			playermodel.favor[arg_5_1].favorlevel = arg_6_0.favorlevel
			playermodel.favor[arg_5_1].favordegree = arg_6_0.favordegree

			if arg_5_3 then
				arg_5_3(1)
			end
		elseif arg_6_0.result == 2 then
			if arg_5_3 then
				arg_5_3(2)
			end
		elseif arg_6_0.result == 3 then
			if arg_5_3 then
				arg_5_3(3)
			end
		elseif arg_5_3 then
			arg_5_3(0)
		end
	end)
end

function var_0_0.getSoulFavor(arg_7_0, arg_7_1, arg_7_2)
	if not playermodel.haveSuit[arg_7_1] then
		if arg_7_2 then
			arg_7_2(2)
		end

		return
	end

	network:rpc("get_favor_degree", {
		soulid = arg_7_1
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			playermodel.favor[arg_7_1].favorlevel = arg_8_0.favorlevel
			playermodel.favor[arg_7_1].favordegree = arg_8_0.favordegree

			if arg_7_2 then
				arg_7_2(1, arg_7_1)
			end
		elseif arg_8_0.result == 2 then
			if arg_7_2 then
				arg_7_2(2)
			end
		elseif arg_7_2 then
			arg_7_2(0)
		end
	end)
end

function var_0_0:updateFavorEvents(arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in pairs(favorevent_data) do
		if iter_9_1.class and iter_9_1.class == arg_9_1 then
			local var_9_3 = {
				toread = false,
				id = iter_9_1.id,
				level = iter_9_1.level
			}

			if arg_9_2 >= iter_9_1.level then
				var_9_2 = var_9_2 + 1

				if self.unlock_eventlist[iter_9_1.id] then
					var_9_3.toread = true
				end
			end

			var_9_0[#var_9_0 + 1] = var_9_3
		end
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return arg_10_0.level < arg_10_1.level
	end)

	return math.floor(var_9_2 / (#var_9_0 or 1) * 100), var_9_0
end

function var_0_0.readFavorEvent(arg_11_0, arg_11_1, arg_11_2)
	network:rpc("read_favor_event", {
		eventid = arg_11_1
	}, function(arg_12_0)
		if arg_11_2 then
			arg_11_2()
		end
	end)
end

function var_0_0.get_favor_event(arg_13_0, arg_13_1)
	arg_13_0.unlock_eventlist = {}
	arg_13_0.alert_ids = {}

	network:rpc("get_favor_event", nil, function(arg_14_0)
		if arg_14_0.result == 1 then
			if arg_14_0.event then
				for iter_14_0, iter_14_1 in pairs(arg_14_0.event) do
					arg_13_0.alert_ids[math.floor(iter_14_1 / 100) % 100] = true
					arg_13_0.unlock_eventlist[iter_14_1] = true
				end
			end

			if arg_13_1 then
				arg_13_1()
			end
		end
	end)
end

function var_0_0:check_event_alert(arg_15_1)
	return self.unlock_eventlist[arg_15_1]
end

function var_0_0:check_soul_event(arg_16_1)
	return self.alert_ids[arg_16_1]
end

function var_0_0:update_event_alert(arg_17_1, arg_17_2)
	local var_17_0 = 0
	local var_17_1 = 0

	for iter_17_0, iter_17_1 in pairs(self.unlock_eventlist) do
		if arg_17_2 == iter_17_0 then
			self.unlock_eventlist[iter_17_0] = nil
		else
			if math.floor(iter_17_0 / 100) % 100 == arg_17_1 then
				var_17_0 = var_17_0 + 1
			end

			var_17_1 = var_17_1 + 1
		end
	end

	if var_17_0 == 0 then
		self.alert_ids[arg_17_1] = false
	end

	if var_17_1 <= 0 then
		local var_17_2 = cc.EventCustom:new("alert_system")

		var_17_2.system = ALERT_FAVOR
		var_17_2.show = false

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_17_2)
	end
end

function var_0_0:updateEventLabelNode(arg_18_1, arg_18_2, arg_18_3)
	alert_manager:add_redDot(arg_18_2, self.alert_ids[arg_18_1], arg_18_3)
end

function var_0_0:updateSoulEventNode(arg_19_1, arg_19_2, arg_19_3)
	alert_manager:add_redDot(arg_19_2, self.unlock_eventlist[arg_19_1], arg_19_3)
end

function var_0_0.updateFavorprogressbar(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5, arg_20_6, arg_20_7)
	if GoodwellLayer and GoodwellLayer.getInstance() then
		if arg_20_2 then
			arg_20_2:setString("LV" .. playermodel.favor[arg_20_1].favorlevel)
		end

		if arg_20_4 then
			arg_20_4:setString(playermodel.favor[arg_20_1].favordegree .. "/" .. favor_data[playermodel.favor[arg_20_1].favorlevel].experience)
		end

		if arg_20_3 then
			arg_20_3:setPercent(playermodel.favor[arg_20_1].favordegree * 100 / favor_data[playermodel.favor[arg_20_1].favorlevel].experience)
		end

		if arg_20_5 then
			arg_20_5:loadTexture("Goodwell/" .. favor_data[playermodel.favor[arg_20_1].favorlevel].title_name .. ".png", var_0_8)
		end

		if arg_20_6 then
			arg_20_6:setString(favor_data[playermodel.favor[arg_20_1].favorlevel].experience)
		end

		if arg_20_7 then
			arg_20_7:setString(L_PHYSICAL_POWER .. playermodel.activity[arg_20_1])
		end
	end
end

function var_0_0.getFavorSciencePoint(arg_21_0, arg_21_1)
	return favor_data[playermodel.favor[arg_21_1].favorlevel].add_science_point or 0
end

function var_0_0.getFavorServantSciencePoint(arg_22_0, arg_22_1)
	return favor_data[playermodel.favor[servant_data[arg_22_1].soulid].favorlevel].add_science_point or 0
end

function var_0_0.getFavorStrength(arg_23_0, arg_23_1)
	return favor_data[playermodel.favor[arg_23_1].favorlevel].add_hp or 0, favor_data[playermodel.favor[arg_23_1].favorlevel].add_damage or 0
end

function var_0_0.getFavorDamage(arg_24_0, arg_24_1)
	return favor_data[playermodel.favor[arg_24_1].favorlevel].add_damage or 0
end

function var_0_0.getFavorHp(arg_25_0, arg_25_1)
	return favor_data[playermodel.favor[arg_25_1].favorlevel].add_hp or 0
end

function var_0_0.getFavorDamageByLv(arg_26_0, arg_26_1)
	return favor_data[arg_26_1].add_damage or 0
end

function var_0_0.getFavorHpByLv(arg_27_0, arg_27_1)
	return favor_data[arg_27_1].add_hp or 0
end

return var_0_0
