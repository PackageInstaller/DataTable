local var_0_0 = class("VisitBackYardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	if not getProxy(FriendProxy):getFriend(var_1_0) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("friend_not_add"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(19101, {
		user_id = var_1_0
	}, 19102, function(arg_2_0)
		if arg_2_0.lv == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_unopen"))

			return
		end

		arg_1_0:sendNotification(GAME.GET_BACKYARD_DATA, {
			data = arg_2_0
		})

		local var_2_0 = getProxy(DormProxy).friendData

		if not var_2_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("data_erro"))
		else
			if not var_2_0.name or var_2_0.name == "" then
				var_2_0.name = var_0.name
			end

			arg_1_0:sendNotification(GAME.VISIT_BACKYARD_DONE, {
				player = var_0,
				dorm = var_2_0
			})
		end

		return
	end)

	return
end

return var_0_0
