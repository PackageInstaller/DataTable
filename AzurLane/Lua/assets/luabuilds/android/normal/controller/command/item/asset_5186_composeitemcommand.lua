class = var_0_10000

local var_0_0 = "ComposeItemCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count

	getProxy = var_1_10005
	BagProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getItemById(var_1_2, var_1_0)

	if var_1_1 == 0 then
		return
	end

	local var_1_4 = var_1_3:getConfig("target_id")
	local var_1_5 = var_1_3:getConfig("compose_number")
	local var_1_7

	if var_1_1 > var_1_3.count / var_1_5 then
		pg = var_1_7

		local var_1_6 = var_1_7.TipsMgr.GetInstance()

		var_1_7 = var_1_7.ShowTips
		i18n = var_1_10012

		var_1_7(var_1_6, var_1_10012("common_no_item_1"))

		return
	end

	pg = var_1_7

	local var_1_8 = var_1_7.ConnectionMgr.GetInstance()

	var_10.Send(var_1_8, 15006, {
		id = var_1_0,
		num = var_1_1
	}, 15007, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1.removeItemById(var_2_0, var_1_0, var_1_1 * var_1_5)

			Drop = var_2_1
			var_2_1 = var_2_1.New

			local var_2_2 = {}

			DROP_TYPE_ITEM = var_2_10003
			var_2_2.type = var_2_10003
			var_2_2.id = var_1_4
			var_2_2.count = var_1_1
			var_2_1 = var_2_1(var_2_2)
			var_2_10003 = arg_1_0

			local var_2_3 = var_2.sendNotification

			GAME = var_4

			var_2_3(var_2_10003, var_4.ADD_ITEM, var_2_1)

			var_2_10003 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_4

			var_2_4(var_2_10003, var_4.USE_ITEM_DONE, {
				drops = {
					var_2_1
				}
			})
		else
			pg = var_2_1

			local var_2_5 = var_2_1.TipsMgr.GetInstance()
			local var_2_6 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_6(var_2_5, var_2_10003("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
