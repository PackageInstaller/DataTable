class = var_0_10000

local var_0_0 = "VisitBackYardCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0)

	getProxy = var_1_0
	FriendProxy = var_1_10004

	local var_1_2 = var_1_0(var_1_10004)

	if not var_3.getFriend(var_1_2, var_1_1) then
		pg = var_1_2

		local var_1_3 = var_1_2.TipsMgr.GetInstance()

		var_1_2 = var_1_2.ShowTips
		i18n = var_1_10007

		var_1_2(var_1_3, var_1_10007("friend_not_add"))

		return
	end

	pg = var_1_2

	local var_1_4 = var_1_2.ConnectionMgr.GetInstance()

	var_5.Send(var_1_4, 19101, {
		user_id = var_1_1
	}, 19102, function(arg_2_0)
		if arg_2_0.lv == 0 then
			pg = var_1

			local var_2_0 = var_1.TipsMgr.GetInstance()
			local var_2_1 = var_1.ShowTips

			i18n = var_2_10003

			var_2_1(var_2_0, var_2_10003("backyard_unopen"))

			return
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_1.sendNotification

		GAME = var_2_10003

		var_2_3(var_2_2, var_2_10003.GET_BACKYARD_DATA, {
			data = arg_2_0
		})

		getProxy = var_2_3
		DormProxy = var_2_2

		if not var_2_3(var_2_2).friendData then
			pg = var_2_2

			local var_2_4 = var_2_2.TipsMgr.GetInstance()
			local var_2_5 = var_2.ShowTips

			i18n = var_4

			var_2_5(var_2_4, var_4("data_erro"))
		else
			if not var_1.name or var_1.name == "" then
				var_1.name = var_0.name
			end

			local var_2_6 = arg_1_0
			local var_2_7 = var_2.sendNotification

			GAME = var_4

			var_2_7(var_2_6, var_4.VISIT_BACKYARD_DONE, {
				player = var_0,
				dorm = var_1
			})
		end

		return
	end)

	return
end

return var_0_1
