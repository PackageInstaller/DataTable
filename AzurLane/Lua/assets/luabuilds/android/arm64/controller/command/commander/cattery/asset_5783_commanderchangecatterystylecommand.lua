class = var_0_10000

local var_0_0 = "CommanderChangeCatteryStyleCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.styleId

	getProxy = var_1_10005
	CommanderProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	if not var_5.GetCommanderHome(var_1_2) then
		return
	end

	if not var_6:GetCatteryById(var_1_0) then
		return
	end

	if var_7:GetStyle() == var_1_1 then
		return
	end

	pg = var_8

	local var_1_3 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_3, 25032, {
		slotidx = var_1_0,
		styleidx = var_1_1
	}, 25033, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.UpdateStyle(var_2_0, var_1_1)

			pg = var_2_2

			local var_2_1 = var_2_2.TipsMgr.GetInstance()

			var_2_2 = var_2_2.ShowTips
			i18n = var_2_10004

			var_2_2(var_2_1, var_2_10004("cattery_style_change_success"))

			local var_2_3 = arg_1_0

			var_2_2 = var_2_2.sendNotification
			GAME = var_2_10004

			var_2_2(var_2_3, var_2_10004.COMMANDER_CHANGE_CATTERY_STYLE_DONE, {
				id = var_0.id
			})
		else
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_5(var_2_4, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
