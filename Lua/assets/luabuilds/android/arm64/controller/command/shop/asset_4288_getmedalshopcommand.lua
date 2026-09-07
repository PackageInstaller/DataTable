local GetMedalShopCommand = class("GetMedalShopCommand", pm.SimpleCommand)

function GetMedalShopCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(16106, {
		type = 0
	}, 16107, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			self:sendNotification(GAME.GET_MEDALSHOP_DONE)

			var_2_0 = MedalShop.New(arg_2_0)

			local var_2_1 = getProxy(ShopsProxy)

			if var_2_1.medalShop then
				var_2_1:UpdateMedalShop(var_2_0)
			else
				var_2_1:SetMedalShop(var_2_0)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		if var_1_1 then
			var_1_1(var_2_0)
		end

		return
	end)

	return
end

return GetMedalShopCommand
