class = var_0_10000

local var_0_0 = "UpdateShipPreferenceTagCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipId
	local var_1_1 = var_2.tag

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 12040, {
		ship_id = var_1_0,
		flag = var_1_1
	}, 12041, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			BayProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)

			local var_2_1

			var_2_10003 = var_1_1
			Ship = var_2_10004

			if var_2_10003 == var_2_10004.PREFERENCE_TAG_COMMON then
				var_2_1 = "ship_preference_common"
			else
				var_2_10003 = var_1_1
				Ship = var_4

				if var_2_10003 == var_4.PREFERENCE_TAG_NONE then
					var_2_1 = "ship_preference_non"
				end
			end

			local var_2_2 = var_2_0:getShipById(var_1_0)

			var_2_10003.SetPreferenceTag(var_2_2, var_1_1)
			var_2_0:updateShip(var_2_10003)

			local var_2_3 = arg_1_0
			local var_2_4 = var_4.sendNotification

			GAME = var_6

			var_2_4(var_2_3, var_6.UPDATE_PREFERENCE_DONE, var_2_10003)

			pg = var_2_4

			local var_2_5 = var_2_4.TipsMgr.GetInstance()
			local var_2_6 = var_4.ShowTips

			i18n = var_6

			var_2_6(var_2_5, var_6(var_2_1, var_2_10003:getName()))
		else
			pg = var_2_0

			local var_2_7 = var_2_0.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_8(var_2_7, var_2_10003("ship_updateShipLock", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
