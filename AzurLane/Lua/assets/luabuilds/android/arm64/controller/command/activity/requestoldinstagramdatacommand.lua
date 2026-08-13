class = var_0_10000

local var_0_0 = "RequestOldInstagramDataCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)
local var_0_2 = 30

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	InstagramProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if var_3.IsReqOldInstagramData(var_1_1) then
		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	local var_1_2 = var_3
	local var_1_3 = var_3.GetOldInstagramIds(var_1_2)
	local var_1_4 = {}

	math = var_1_2

	local var_1_5 = var_1_2.ceil(#var_1_3 / var_0_2)

	for iter_1_0 = 1, var_1_5 do
		local var_1_6 = {}

		for iter_1_1 = 1 + (iter_1_0 - 1) * var_0_2, iter_1_0 * var_0_2 do
			table = var_1_10016

			var_1_10016.insert(var_1_6, var_1_3[iter_1_1])
		end

		table = var_12

		var_12.insert(var_1_4, function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.Send(var_2_0, var_1_6, arg_2_0)

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_1_4, function()
		if var_1_0.callback then
			var_1_0.callback()
		end

		local var_3_0 = var_0

		var_0.MarkOldInstagramData(var_3_0)

		local var_3_1 = arg_1_0
		local var_3_2 = var_0.sendNotification

		GAME = var_2_10003

		var_3_2(var_3_1, var_2_10003.REQ_OLD_INSTAGRAM_DATA_DONE)

		return
	end)

	return
end

function var_0_1.Send(arg_4_0, arg_4_1, arg_4_2)
	getProxy = var_1_10003
	InstagramProxy = var_1_10005

	local var_4_0 = var_1_10003(var_1_10005)

	pg = var_1_10004

	local var_4_1 = var_1_10004.ConnectionMgr.GetInstance()

	var_4.Send(var_4_1, 11705, {
		id_list = arg_4_1
	}, 11706, function(arg_5_0)
		ipairs = var_2_10001

		for iter_5_0, iter_5_1 in var_2_10001(arg_5_0.ins_message_list) do
			Instagram = var_2_10006
			var_2_10006 = var_2_10006.New(iter_5_1)

			local var_5_0 = var_4_0

			var_7.AddInstagram(var_5_0, var_2_10006)
		end

		arg_4_2()

		return
	end)

	return
end

return var_0_1
