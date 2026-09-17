local network = require("network.network")
local activity_manager = require("controller.activity_manager")
local activity_timesign_data = require("data.activity_modules.activity_timesign_data")
local activity_timesign_conf = require("data.activity_modules.activity_timesign_conf")
local time_check_manager = require("controller.time_check_manager")
local drop_data = require("data.drop_data")
local playermodel = require("model.playermodel")

function ACTIVITY_OBJ_NEW:get_activity_timesign(arg_1_1)
	network:rpc("get_activity_timesign", {
		activityid = self._id
	}, function(arg_2_0)
		if arg_2_0.result == 1 and arg_2_0.signlist and next(arg_2_0.signlist) then
			for iter_2_0, iter_2_1 in pairs(arg_2_0.signlist) do
				if iter_2_1.times and next(iter_2_1.times) then
					for iter_2_2, iter_2_3 in pairs(iter_2_1.times) do
						local var_2_0 = json.decode(iter_2_3.dropinfo)

						drop_data[var_2_0.id] = var_2_0
						iter_2_3.dropid = var_2_0.id
					end
				end
			end
		end

		if arg_1_1 then
			arg_1_1(arg_2_0)
		end
	end)
end

function ACTIVITY_OBJ_NEW:do_timesign(arg_3_1, arg_3_2, arg_3_3)
	network:rpc("do_timesign", {
		activityid = self._id,
		signid = arg_3_1,
		signindex = arg_3_2
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			global_gain(arg_4_0)

			if activity_timesign_data[self._id .. "-" .. arg_3_1].date == os.date("%Y-%m-%d", (time_check_manager:getCurTime())) then
				activity_manager:updateActivityAlert("timesign", self._id, false)
			end
		elseif arg_4_0.result == 6 then
			global_ShowBlockWords(L_ACTIVITY_DOULE_HOLIDAY.DIM_NOT_ENOUGH)
		end

		if arg_4_0.supplementcost then
			playermodel.diamond = playermodel.diamond - arg_4_0.supplementcost
		end

		if arg_4_0.consumes then
			for iter_4_0, iter_4_1 in ipairs(arg_4_0.consumes) do
				itemManager:deleteItem(iter_4_1.entityid, iter_4_1.num)
			end
		end

		global_update_gold_stone_diamond(playermodel.gold, nil, playermodel.diamond)

		if arg_4_0.signlist and next(arg_4_0.signlist) then
			for iter_4_2, iter_4_3 in pairs(arg_4_0.signlist) do
				if iter_4_3.times and next(iter_4_3.times) then
					for iter_4_4, iter_4_5 in pairs(iter_4_3.times) do
						local var_4_0 = json.decode(iter_4_5.dropinfo)

						drop_data[var_4_0.id] = var_4_0
						iter_4_5.dropid = var_4_0.id
					end
				end
			end
		end

		if arg_3_3 then
			arg_3_3(arg_4_0)
		end
	end)
end
