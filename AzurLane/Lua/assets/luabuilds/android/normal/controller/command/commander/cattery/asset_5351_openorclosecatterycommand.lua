class = var_0_10000

local var_0_0 = "OpenOrCloseCatteryCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().open and 0 or 1

	pg = var_1_10005

	local var_1_1 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_1, 25036, {
		is_open = var_1_0
	})

	getProxy = var_5
	CommanderProxy = var_1_1

	local var_1_2 = var_5(var_1_1)

	var_5.UpdateOpenCommanderScene(var_1_2, var_3)

	if var_3 and var_5:GetCommanderHome() then
		local var_1_3 = var_6
		local var_1_4 = var_6.GetCatteries(var_1_3)

		pairs = var_1_3

		for iter_1_0, iter_1_1 in var_1_3(var_1_4) do
			iter_1_1:ClearCacheExp()
		end
	end

	return
end

return var_0_1
