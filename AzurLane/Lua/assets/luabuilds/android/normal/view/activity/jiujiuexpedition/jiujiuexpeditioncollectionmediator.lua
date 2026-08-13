class = var_0_10000

local var_0_0 = "JiuJiuExpeditionCollectionMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_GET = "JiuJiuExpeditionCollectionMediator:ON_GET"

local var_0_2 = 691

function var_0_1.register(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_JP = var_1_10002

	if var_1_10001 == var_1_10002 then
		arg_1_0:bind(var_0_1.ON_GET, function(arg_2_0, arg_2_1)
			pg = var_2_10002

			local var_2_0 = var_2_10002.m02
			local var_2_1 = var_2.sendNotification

			GAME = var_2_10004

			var_2_1(var_2_0, var_2_10004.ACTIVITY_OPERATION, {
				cmd = 4,
				activity_id = var_0_2
			})

			return
		end)
	end

	JiuJiuExpeditionCollectionMediator = var_1_10001

	local var_1_0, var_1_1, var_1_2, var_1_3 = var_1_10001.GetCollectionData()
	local var_1_4 = arg_1_0.viewComponent

	var_5.SetData(var_1_4, var_1_0, var_1_1, var_1_2, var_1_3)

	return
end

function var_0_1.GetCollectionData()
	local var_3_0 = 1

	pg = var_1_10001

	local var_3_1 = var_1_10001.activity_event_adventure[var_3_0].boss_list
	local var_3_2 = {}

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_3_3 = var_1_10004(var_1_10005)
	local var_3_4 = var_4.getActivityById(var_3_3, var_0_2).data1
	local var_3_5 = var_4.data1_list
	local var_3_6 = var_4:getConfig("config_data")

	if var_3_4 == 0 then
		var_3_4 = #var_3_6 + 1
	end

	for iter_3_0 = 1, #var_3_6 do
		pg = var_1_10012
		var_1_10012 = var_1_10012.activity_event_chequer[var_3_6[iter_3_0]].list_boss

		if iter_3_0 < var_3_4 then
			for iter_3_1 = 1, #var_1_10012 do
				table = var_1_10017

				var_1_10017.insert(var_3_2, var_1_10012[iter_3_1])
			end
		elseif iter_3_0 == var_3_4 and var_3_5 and #var_3_5 > 0 then
			for iter_3_2 = 1, #var_3_5 do
				var_1_10017 = var_3_5[iter_3_2]
				bit = var_1_10018
				var_1_10018 = var_1_10018.band
				var_1_10019 = var_1_10017
				ActivityConst = var_1_10020

				if var_1_10018(var_1_10019, var_1_10020.EXPEDITION_TYPE_BOSS) ~= 0 then
					bit = var_1_10018
					var_1_10018 = var_1_10018.band
					var_1_10019 = var_1_10017
					ActivityConst = var_1_10020

					if var_1_10018(var_1_10019, var_1_10020.EXPEDITION_TYPE_GOT) ~= 0 then
						bit = var_1_10018
						var_1_10018 = var_1_10018.rshift(var_1_10017, 4)
						table = var_1_10019

						var_1_10019.insert(var_3_2, var_1_10018)
					end
				end
			end
		end
	end

	local var_3_7 = 0

	for iter_3_3 = 1, #var_1.boss_list do
		local var_3_8 = var_1.boss_list[iter_3_3]
		local var_3_9 = 0

		for iter_3_4 = 1, #var_3_8 do
			table = var_1_10019

			if var_1_10019.contains(var_3_2, var_3_8[iter_3_4]) then
				var_3_9 = var_3_9 + 1
			end
		end

		if var_3_9 == #var_3_8 then
			var_3_7 = var_3_7 + 1
		end
	end

	local var_3_10

	if not var_4.data2_list[1] then
		var_3_10 = var_3_7
	end

	return var_3_1, var_3_2, var_3_7, var_3_10
end

function var_0_1.listNotificationInterests(arg_4_0)
	local var_4_0 = {}

	ActivityProxy = var_1_10002
	var_4_0[1] = var_1_10002.ACTIVITY_UPDATED

	return var_4_0
end

function var_0_1.handleNotification(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1
	local var_5_2 = arg_5_1.getBody(var_5_1)

	ActivityProxy = var_5_1

	if var_5_0 == var_5_1.ACTIVITY_UPDATED and var_5_2.id == var_0_2 then
		JiuJiuExpeditionCollectionMediator = var_4

		local var_5_3, var_5_4, var_5_5, var_5_6 = var_4.GetCollectionData()
		local var_5_7 = arg_5_0.viewComponent

		var_8.SetData(var_5_7, var_5_3, var_5_4, var_5_5, var_5_6)

		local var_5_8 = arg_5_0.viewComponent

		var_8.updateBooks(var_5_8)

		local var_5_9 = arg_5_0.viewComponent

		var_8.UpdateTip(var_5_9)

		local var_5_10 = arg_5_0.viewComponent

		var_8.OpenBook(var_5_10, var_5_6 + 1)
	end

	return
end

return var_0_1
