class = var_0_10000

local var_0_0 = "CheckLoveLetterItemMailCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().item_id
	local var_1_1 = var_2.group_id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 30016, {
		item_id = var_1_0,
		groupid = var_1_1
	}, 30017, function(arg_2_0)
		underscore = var_2_10001

		local var_2_0 = var_2_10001.rest(arg_2_0.years, 1)

		getProxy = var_2_10002
		BagProxy = var_4

		local var_2_1 = var_2_10002(var_4)

		var_2.SetLoveLetterRepairInfo(var_2_1, var_1_0 .. "_" .. var_1_1, var_2_0)

		local var_2_3

		if #var_2_0 == 0 then
			pg = var_2_3

			local var_2_2 = var_2_3.TipsMgr.GetInstance()

			var_2_3 = var_2_3.ShowTips
			i18n = var_5

			var_2_3(var_2_2, var_5("loveletter_recover_tip7"))
		else
			pg = var_2_3

			local var_2_4 = var_2_3.TipsMgr.GetInstance()
			local var_2_5 = var_2.ShowTips

			i18n = var_5

			local var_2_6 = "loveletter_recover_tip6"

			table = var_2_10008

			var_2_5(var_2_4, var_5(var_2_6, var_2_10008.concat(var_2_0, "、")))
		end

		local var_2_7 = arg_1_0
		local var_2_8 = var_2.sendNotification

		GAME = var_5

		var_2_8(var_2_7, var_5.LOVE_ITEM_MAIL_CHECK_DONE, {
			itemId = var_1_0,
			groupId = var_1_1,
			list = var_2_0
		})

		return
	end)

	return
end

return var_0_1
