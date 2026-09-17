local var_0_0 = {}
local network = require("network.network")

function var_0_0.get_mail_list(arg_1_0, arg_1_1)
	network:rpc("get_player_mail", nil, function(arg_2_0)
		if arg_1_1 then
			arg_1_1((arg_1_0:filterMailDataByChannel(arg_2_0.maillist)))
		end
	end)
end

function var_0_0.read_mail(arg_3_0, arg_3_1)
	network:rpc("read_mail", {
		mailid = arg_3_1
	})
end

local var_0_2 = false

function var_0_0.get_mail_drops(arg_4_0, arg_4_1, arg_4_2)
	if var_0_2 then
		return
	end

	var_0_2 = true

	network:rpc("get_mail_drops", {
		mailid = arg_4_1
	}, function(arg_5_0)
		if arg_5_0.result == 1 then
			global_gain({
				gold = arg_5_0.gold,
				diamond = arg_5_0.diamond,
				honor = arg_5_0.honor,
				items = arg_5_0.items
			})

			if arg_4_2 then
				arg_4_2(arg_5_0.result, (arg_4_0:filterMailDataByChannel(arg_5_0.maillist)))
			end
		elseif arg_4_2 then
			arg_4_2(arg_5_0.result)
		end

		var_0_2 = false
	end)
end

function var_0_0.get_mail_drops_one_key(arg_6_0, arg_6_1, arg_6_2)
	if var_0_2 then
		return
	end

	var_0_2 = true

	network:rpc("get_mail_drops_one_key", {
		channel = arg_6_1
	}, function(arg_7_0)
		if arg_7_0.result == 1 then
			global_gain({
				gold = arg_7_0.gold,
				diamond = arg_7_0.diamond,
				honor = arg_7_0.honor,
				items = arg_7_0.items
			})

			if arg_6_2 then
				arg_6_2(arg_7_0.result, (arg_6_0:filterMailDataByChannel(arg_7_0.maillist)))
			end
		end

		var_0_2 = false
	end)
end

function var_0_0.delete_mail(arg_8_0, arg_8_1, arg_8_2)
	network:rpc("delete_mail", {
		mailid = arg_8_1
	}, function(arg_9_0)
		if arg_8_2 then
			arg_8_2((arg_8_0:filterMailDataByChannel(arg_9_0.maillist)))
		end
	end)
end

function var_0_0.delete_mail_one_key(arg_10_0, arg_10_1)
	network:rpc("delete_mail_one_key", {
		param = "read"
	}, function(arg_11_0)
		if arg_10_1 then
			arg_10_1((arg_10_0:filterMailDataByChannel(arg_11_0.maillist)))
		end
	end)
end

local function var_0_3(arg_12_0, arg_12_1)
	for iter_12_0 = 2, #arg_12_0 do
		if arg_12_0[iter_12_0] == arg_12_1 then
			return true
		end
	end

	return false
end

function var_0_0.filterMailDataByChannel(arg_13_0, arg_13_1)
	if not arg_13_1 or not next(arg_13_1) then
		return
	end

	local var_13_0 = 1

	while var_13_0 <= #arg_13_1 do
		if arg_13_1[var_13_0].title ~= nil and string.find(arg_13_1[var_13_0].title, "&") then
			local var_13_1 = {}
			local var_13_2 = DeviceManager:getChannelID()

			for iter_13_0 in string.gmatch(arg_13_1[var_13_0].title, "([^&]+)") do
				var_13_1[#var_13_1 + 1] = iter_13_0
			end

			if not var_0_3(var_13_1, var_13_2) then
				table.remove(arg_13_1, var_13_0)

				var_13_0 = var_13_0 - 1
			else
				arg_13_1[var_13_0].title = string.sub(arg_13_1[var_13_0].title, 1, string.find(arg_13_1[var_13_0].title, "&") - 1)
			end
		end

		var_13_0 = var_13_0 + 1
	end

	return arg_13_1
end

function var_0_0.click_hyperlink(arg_14_0, arg_14_1)
	network:rpc("activity_click_mail_hyperlink", {
		activityid = 241,
		mailid = arg_14_1
	})
end

return var_0_0
