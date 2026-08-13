class = var_0_10000

local var_0_0 = "UseFudaiItemCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.count
	local var_1_2 = var_2.callback

	if var_1_1 == 0 then
		return
	end

	getProxy = var_1_10006
	BagProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)
	local var_1_5

	if var_6.getItemById(var_1_3, var_1_0).count < var_1_1 then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10010

		var_1_5(var_1_4, var_1_10010("common_no_item_1"))

		return
	end

	pg = var_1_5

	local var_1_6 = var_1_5.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 15002, {
		id = var_1_0,
		count = var_1_1
	}, 15003, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			var_2_0 = {}
			var_2_10003 = var_0

			var_2.removeItemById(var_2_10003, var_1_0, var_1_1)

			assert = var_2

			local var_2_1 = var_0

			var_2_10003 = var_2_10003.getConfig(var_2_1, "usage")
			ItemUsage = var_2_1

			if var_2_10003 ~= var_2_1.DROP then
				local var_2_2 = var_0

				var_2_10003 = var_2_10003.getConfig(var_2_2, "usage")
				ItemUsage = var_2_2

				if var_2_10003 ~= var_2_2.DROP_TEMPLATE then
					local var_2_3 = var_0

					var_2_10003 = var_2_10003.getConfig(var_2_3, "usage")
					ItemUsage = var_2_3

					if var_2_10003 ~= var_2_3.RANDOM_SKIN then
						var_2_10003 = false

						goto label_2_0
					end
				end
			end

			var_2_10003 = true

			::label_2_0::

			var_2(var_2_10003, "未处理类型")

			existCall = var_2
			var_2_10003 = var_1_2
			PlayerConst = var_4

			var_2(var_2_10003, var_4.addTranDrop(arg_2_0.drop_list))
		else
			pg = var_2_0

			local var_2_4 = var_2_0.TipsMgr.GetInstance()
			local var_2_5 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_5(var_2_4, var_2_10003("", arg_2_0.result))

			existCall = var_2_5

			var_2_5(var_1_2)
		end

		return
	end)

	return
end

return var_0_1
