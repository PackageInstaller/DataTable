local OpenOrCloseCatteryCommand = class("OpenOrCloseCatteryCommand", pm.SimpleCommand)

function OpenOrCloseCatteryCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().open

	pg.ConnectionMgr.GetInstance():Send(25036, {
		is_open = var_1_0 and 0 or 1
	})

	local var_1_1 = getProxy(CommanderProxy)

	var_1_1:UpdateOpenCommanderScene(var_1_0)

	if var_1_0 then
		local var_1_2 = var_1_1:GetCommanderHome()

		if var_1_2 then
			for iter_1_0, iter_1_1 in pairs((var_1_2:GetCatteries())) do
				iter_1_1:ClearCacheExp()
			end
		end
	end

	return
end

return OpenOrCloseCatteryCommand
