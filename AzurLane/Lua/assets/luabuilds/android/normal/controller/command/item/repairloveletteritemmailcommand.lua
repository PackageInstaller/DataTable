class = var_0_10000

local var_0_0 = "RepairLoveLetterItemMailCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().item_id
	local var_1_1 = var_2.group_id

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()
	local var_1_3 = var_5.Send
	local var_1_4 = 30018
	local var_1_5 = {
		item_id = var_1_0
	}
	local var_1_6

	if not var_2.year then
		var_1_6 = 0
	end

	var_1_5.year = var_1_6
	var_1_5.groupid = var_1_1 or 0

	var_1_3(var_1_2, var_1_4, var_1_5, 30019, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy = var_1
			BagProxy = var_2_10002

			local var_2_0 = var_1(var_2_10002)

			var_1.SetLoveLetterRepairInfo(var_2_0, var_1_0 .. "_" .. var_1_1, nil)

			getProxy = var_1
			BagProxy = var_2_0

			local var_2_1 = var_1(var_2_0)

			var_1.removeItemById(var_2_1, var_1_0, 1, var_1_1)

			getProxy = var_1
			MailProxy = var_2_1

			local var_2_2 = var_1(var_2_1)

			var_2_2.collectionIds = nil
			PlayerConst = var_2_2

			local var_2_3 = var_2_2.addTranDrop(arg_2_0.drop_list)

			var_2_10003 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_4

			local var_2_5 = var_4.LOVE_ITEM_MAIL_REPAIR_DONE
			local var_2_6 = {}

			underscore = var_2_10006
			var_2_6.awards = var_2_10006.filter(var_2_3, function(arg_3_0)
				return not arg_3_0:isLoveLetter()
			end)

			var_2_4(var_2_10003, var_2_5, var_2_6)
		elseif arg_2_0.ret == 6 then
			pg = var_1

			local var_2_7 = var_1.TipsMgr.GetInstance()
			local var_2_8 = var_1.ShowTips

			i18n = var_2_10003

			var_2_8(var_2_7, var_2_10003("loveletter_recover_tip5"))
		elseif arg_2_0.ret == 7 then
			pg = var_1

			local var_2_9 = var_1.TipsMgr.GetInstance()
			local var_2_10 = var_1.ShowTips

			i18n = var_2_10003

			var_2_10(var_2_9, var_2_10003("loveletter_recover_tip3"))
		else
			local var_2_12

			if arg_2_0.ret == 40 then
				pg = var_2_12

				local var_2_11 = var_2_12.TipsMgr.GetInstance()

				var_2_12 = var_2_12.ShowTips
				i18n = var_2_10003

				var_2_12(var_2_11, var_2_10003("player_harvestResource_error_fullBag"))
			else
				pg = var_2_12

				local var_2_13 = var_2_12.TipsMgr.GetInstance()
				local var_2_14 = var_1.ShowTips

				errorTip = var_2_10003

				var_2_14(var_2_13, var_2_10003("", arg_2_0.ret))
			end
		end

		return
	end)

	return
end

return var_0_1
