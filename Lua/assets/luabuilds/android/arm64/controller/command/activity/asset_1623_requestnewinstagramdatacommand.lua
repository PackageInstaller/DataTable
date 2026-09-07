local RequestNewInstagramDataCommand = class("RequestNewInstagramDataCommand", pm.SimpleCommand)
local var_0_1 = 10

function RequestNewInstagramDataCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(InstagramProxy)

	if var_1_1:IsReqNewInstagramData() then
		if var_1_0.callback then
			var_1_0.callback()
		end

		return
	end

	local var_1_2 = var_1_1:GetNewInstagramIds()

	if #var_1_2 >= 30 and IsUnityEditor then
		warning("！！！！注意！！！！！一次请求太多ins数据，策划需检查配置是不是有问题！！！")
	end

	local var_1_3 = {}

	for iter_1_0 = 1, math.ceil(#var_1_2 / var_0_1) do
		local var_1_4 = {}

		for iter_1_1 = 1 + (iter_1_0 - 1) * var_0_1, iter_1_0 * var_0_1 do
			table.insert(var_1_4, var_1_2[iter_1_1])
		end

		table.insert(var_1_3, function(arg_2_0)
			self:Send(var_1_4, arg_2_0)

			return
		end)
	end

	seriesAsync(var_1_3, function()
		var_1_1:MarkNewInstagramData()

		if var_1_0.callback then
			var_1_0.callback()
		end

		self:sendNotification(GAME.REQ_NEW_INSTAGRAM_DATA_DONE)

		return
	end)

	return
end

function RequestNewInstagramDataCommand:Send(arg_4_1, arg_4_2)
	local var_4_0 = getProxy(InstagramProxy)

	pg.ConnectionMgr.GetInstance():Send(11705, {
		id_list = arg_4_1
	}, 11706, function(arg_5_0)
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.ins_message_list) do
			var_4_0:AddInstagram((Instagram.New(iter_5_1)))
		end

		arg_4_2()

		return
	end)

	return
end

return RequestNewInstagramDataCommand
