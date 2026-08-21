local var_0_0 = class("JiuJiuExpeditionCollectionMediator", import("...base.ContextMediator"))

var_0_0.ON_GET = "JiuJiuExpeditionCollectionMediator:ON_GET"

local var_0_1 = 691

function var_0_0.register(arg_1_0)
	if PLATFORM_CODE == PLATFORM_JP then
		arg_1_0:bind(var_0_0.ON_GET, function(arg_2_0, arg_2_1)
			pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
				cmd = 4,
				activity_id = var_0_1
			})

			return
		end)
	end

	local var_1_0, var_1_1, var_1_2, var_1_3 = JiuJiuExpeditionCollectionMediator.GetCollectionData()

	arg_1_0.viewComponent:SetData(var_1_0, var_1_1, var_1_2, var_1_3)

	return
end

function var_0_0.GetCollectionData()
	local var_3_0 = getProxy(ActivityProxy):getActivityById(var_0_1)
	local var_3_1 = var_3_0.data1
	local var_3_2 = var_3_0:getConfig("config_data")

	if var_3_0.data1 == 0 then
		var_3_1 = #var_3_2 + 1
	end

	for iter_3_0 = 1, #var_3_2 do
		if iter_3_0 < var_3_1 then
			for iter_3_1 = 1, #pg.activity_event_chequer[var_3_2[iter_3_0]].list_boss do
				table.insert({}, pg.activity_event_chequer[var_3_2[iter_3_0]].list_boss[iter_3_1])
			end
		elseif iter_3_0 == var_3_1 and var_3_0.data1_list and #var_3_0.data1_list > 0 then
			for iter_3_2 = 1, #var_3_0.data1_list do
				if bit.band(var_3_0.data1_list[iter_3_2], ActivityConst.EXPEDITION_TYPE_BOSS) ~= 0 and bit.band(var_3_0.data1_list[iter_3_2], ActivityConst.EXPEDITION_TYPE_GOT) ~= 0 then
					table.insert({}, (bit.rshift(var_3_0.data1_list[iter_3_2], 4)))
				end
			end
		end
	end

	local var_3_3 = 0

	for iter_3_3 = 1, #pg.activity_event_adventure[1].boss_list do
		local var_3_4 = 0

		for iter_3_4 = 1, #pg.activity_event_adventure[1].boss_list[iter_3_3] do
			if table.contains({}, pg.activity_event_adventure[1].boss_list[iter_3_3][iter_3_4]) then
				var_3_4 = var_3_4 + 1
			end
		end

		if var_3_4 == #pg.activity_event_adventure[1].boss_list[iter_3_3] then
			var_3_3 = var_3_3 + 1
		end
	end

	local var_3_5 = var_3_0.data2_list[1] or var_3_3

	return pg.activity_event_adventure[1].boss_list, {}, var_3_3, var_3_5
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	if arg_5_1:getName() == ActivityProxy.ACTIVITY_UPDATED and arg_5_1:getBody().id == var_0_1 then
		local var_5_0, var_5_1, var_5_2, var_5_3 = JiuJiuExpeditionCollectionMediator.GetCollectionData()

		arg_5_0.viewComponent:SetData(var_5_0, var_5_1, var_5_2, var_5_3)
		arg_5_0.viewComponent:updateBooks()
		arg_5_0.viewComponent:UpdateTip()
		arg_5_0.viewComponent:OpenBook(var_5_3 + 1)
	end

	return
end

return var_0_0
