class = var_0_10000

local var_0_0 = "RequestNewInstagramDataCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)
local var_0_2 = 10

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	getProxy = var_1_10003
	InstagramProxy = var_1_10005

	local var_1_1 = var_1_10003(var_1_10005)

	if var_3.IsReqNewInstagramData(var_1_1) then
		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	local var_1_2 = #var_3:GetNewInstagramIds()

	if 30 <= var_1_2 then
		IsUnityEditor = var_1_2

		if var_1_2 then
			warning = var_1_2

			var_1_2("！！！！注意！！！！！一次请求太多ins数据，策划需检查配置是不是有问题！！！")
		end
	end

	local var_1_3 = {}

	math = var_6

	local var_1_4 = var_6.ceil(#var_4 / var_0_2)

	for iter_1_0 = 1, var_1_4 do
		local var_1_5 = {}

		for iter_1_1 = 1 + (iter_1_0 - 1) * var_0_2, iter_1_0 * var_0_2 do
			table = var_1_10016

			var_1_10016.insert(var_1_5, var_4[iter_1_1])
		end

		table = var_12

		var_12.insert(var_1_3, function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.Send(var_2_0, var_1_5, arg_2_0)

			return
		end)
	end

	seriesAsync = var_7

	var_7(var_1_3, function()
		local var_3_0 = var_0

		var_0.MarkNewInstagramData(var_3_0)

		if var_1_0.callback then
			var_1_0.callback()
		end

		local var_3_1 = arg_1_0
		local var_3_2 = var_0.sendNotification

		GAME = var_2_10003

		var_3_2(var_3_1, var_2_10003.REQ_NEW_INSTAGRAM_DATA_DONE)

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
