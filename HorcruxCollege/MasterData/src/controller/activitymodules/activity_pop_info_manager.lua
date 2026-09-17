local activity_base_manager = require("controller.activitymodules.activity_base_manager")
local activity_pop_data = require("data.activity_pop_data")
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5

function activity_base_manager.get_activity_pop_showinfo(arg_1_0, arg_1_1)
	if not activity_pop_data[arg_1_1] then
		return nil
	end

	if activity_pop_data[arg_1_1].showinfo == var_0_2 then
		return {
			showtype = activity_pop_data[arg_1_1].showinfo,
			showservant = activity_pop_data[arg_1_1].showinfoservant
		}
	elseif activity_pop_data[arg_1_1].showinfo == var_0_3 then
		return {
			showtype = activity_pop_data[arg_1_1].showinfo,
			showkey = activity_pop_data[arg_1_1].showdetailkey
		}
	elseif activity_pop_data[arg_1_1].showinfo == var_0_4 then
		return {
			showtype = activity_pop_data[arg_1_1].showinfo,
			showkey = activity_pop_data[arg_1_1].dropid
		}
	elseif activity_pop_data[arg_1_1].showinfo == var_0_6 then
		return {
			showtype = activity_pop_data[arg_1_1].showinfo,
			showkey = activity_pop_data[arg_1_1].dropid
		}
	else
		local var_1_0

		while activity_pop_data[arg_1_1]["channelid" .. 1] do
			if activity_pop_data[arg_1_1]["channelid" .. 1] == DeviceManager:getChannelID() then
				var_1_0 = activity_pop_data[arg_1_1]["channelurl" .. 1]
			end
		end

		return {
			showtype = var_0_5,
			showkey = activity_pop_data[arg_1_1].jumpto,
			showurl = var_1_0 or activity_pop_data[arg_1_1].url
		}
	end
end

function activity_base_manager.get_activity_pop_showinfo2(arg_2_0, arg_2_1)
	if not activity_pop_data[arg_2_1] then
		return nil
	end

	if activity_pop_data[arg_2_1].showinfo2 == var_0_2 then
		return {
			showtype = activity_pop_data[arg_2_1].showinfo2,
			showservant = activity_pop_data[arg_2_1].showinfoservant2
		}
	elseif activity_pop_data[arg_2_1].showinfo2 == var_0_3 then
		return {
			showtype = activity_pop_data[arg_2_1].showinfo2,
			showkey = activity_pop_data[arg_2_1].showdetailkey2
		}
	elseif activity_pop_data[arg_2_1].showinfo2 == var_0_4 then
		return {
			showtype = activity_pop_data[arg_2_1].showinfo,
			showkey = activity_pop_data[arg_2_1].dropid
		}
	elseif activity_pop_data[arg_2_1].showinfo2 == var_0_6 then
		return {
			showtype = activity_pop_data[arg_2_1].showinfo2,
			showkey = activity_pop_data[arg_2_1].rechargeid
		}
	else
		return {
			showtype = var_0_5,
			showkey = activity_pop_data[arg_2_1].jumpto2
		}
	end
end

function activity_base_manager.get_activity_pop_jump(arg_3_0, arg_3_1)
	if not activity_pop_data[arg_3_1] then
		return nil
	end

	local var_3_0 = activity_pop_data[arg_3_1].url

	if activity_pop_data[arg_3_1].url then
		local var_3_1

		while activity_pop_data[arg_3_1]["channelid" .. 1] do
			if activity_pop_data[arg_3_1]["channelid" .. 1] == DeviceManager:getChannelID() then
				var_3_1 = activity_pop_data[arg_3_1]["channelurl" .. 1]
			end
		end

		var_3_0 = var_3_1 or var_3_0
	end

	return activity_pop_data[arg_3_1].jumpto or var_3_0
end

function activity_base_manager.get_activity_pop_drop(arg_4_0, arg_4_1)
	if not activity_pop_data[arg_4_1] then
		return false
	end

	if activity_pop_data[arg_4_1].showinfo ~= var_0_4 then
		return false
	end

	if not activity_pop_data[arg_4_1].dropid then
		return false
	end

	require("network.network"):rpc("get_activity_pop_drop", {
		id = arg_4_1
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			global_gain(arg_5_0)
			RoleDefault:getInstance():setBoolForKey("act_pop_drop_" .. arg_4_1, true)
		else
			global_ShowBlockWords(">_<...")
		end

		local var_5_0 = cc.EventCustom:new("ON_GET_POP_DROP")

		var_5_0.id = arg_4_1
		var_5_0.result = arg_5_0.result == 1

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_5_0)
	end)

	return true
end

function activity_base_manager.can_show_activity_pop(arg_6_0, arg_6_1)
	return activity_pop_data[arg_6_1] ~= nil
end

function activity_base_manager.get_activity_pop_recharge(arg_7_0, arg_7_1)
	local var_7_0 = activity_pop_data[arg_7_1]

	if not activity_pop_data[arg_7_1] then
		return false
	end

	if activity_pop_data[arg_7_1].showinfo ~= var_0_6 then
		return false
	end

	if not activity_pop_data[arg_7_1].rechargeid then
		return false
	end

	require("controller.recharge_manager"):confirmPayment(activity_pop_data[arg_7_1].rechargeid, function(arg_8_0)
		if arg_8_0 == 0 then
			local var_8_0 = cc.EventCustom:new("purchase_fail")

			var_8_0.id = var_7_0.rechargeid

			cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_8_0)
		end
	end)

	return true
end

function activity_base_manager.get_activity_pop_rechargeid(arg_9_0, arg_9_1)
	if not activity_pop_data[arg_9_1] then
		return nil
	end

	return activity_pop_data[arg_9_1].rechargeid
end
