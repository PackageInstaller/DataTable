class = var_0_10000

local var_0_0 = "BackYardRenameCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg = var_1_10003

	local var_1_1 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_1_1, 19016, {
		name = var_1_0
	}, 19017, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy = var_1
			DormProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			local var_2_0 = var_1.getData(var_2_10004)

			var_2.setName(var_2_0, var_1_0)

			local var_2_1 = var_1
			local var_2_2 = var_1.updateDrom
			local var_2_3 = var_2

			BackYardConst = var_2_10007

			var_2_2(var_2_1, var_2_3, var_2_10007.DORM_UPDATE_TYPE_NAME)

			local var_2_4 = arg_1_0
			local var_2_5 = var_3.sendNotification

			GAME = var_2_3

			var_2_5(var_2_4, var_2_3.BACKYARD_RENAME_DONE)

			pg = var_2_5

			local var_2_6 = var_2_5.TipsMgr.GetInstance()
			local var_2_7 = var_3.ShowTips

			i18n = var_6

			var_2_7(var_2_6, var_6("backyard_rename_success"))
		else
			pg = var_1

			local var_2_8 = var_1.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_9(var_2_8, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
