class = var_0_10000

local var_0_0 = "StartTechnologyCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.pool_id

	getProxy = var_1_10005
	TechnologyProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	if not var_5.getTechnologyById(var_1_2, var_1_0) then
		return
	end

	tobool = var_1_2

	local var_1_3 = var_5

	if var_1_2(var_5.getActivateTechnology(var_1_3)) then
		return
	end

	local var_1_4, var_1_5 = var_6:hasResToStart()

	if not var_1_4 then
		pg = var_1_3

		local var_1_6 = var_1_3.TipsMgr.GetInstance()

		var_1_3.ShowTips(var_1_6, var_1_5)

		return
	end

	pg = var_1_3

	local var_1_7 = var_1_3.ConnectionMgr.GetInstance()

	var_9.Send(var_1_7, 25, {
		tech_id = var_1_0,
		refresh_id = var_1_1
	}, 26, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1 = var_2_1.getConfig(var_2_0, "consume")
			ipairs = var_2_0

			for iter_2_0, iter_2_1 in var_2_0(var_2_1) do
				local var_2_2 = arg_1_0
				local var_2_3 = var_7.sendNotification

				GAME = var_2_10009
				var_2_10009 = var_2_10009.CONSUME_ITEM
				Drop = var_2_10010

				var_2_3(var_2_2, var_2_10009, var_2_10010.Create(iter_2_1))
			end

			var_2_10003 = var_0

			var_2.start(var_2_10003, arg_2_0.time)

			var_2_10003 = var_0

			var_2.updateTechnology(var_2_10003, var_0)

			var_2_10003 = arg_1_0

			local var_2_4 = var_2.sendNotification

			GAME = var_4

			var_2_4(var_2_10003, var_4.START_TECHNOLOGY_DONE, {
				technologyId = var_0.id
			})

			pg = var_2_4
			var_2_10003 = var_2_4.TipsMgr.GetInstance()

			local var_2_5 = var_2.ShowTips

			i18n = var_4

			var_2_5(var_2_10003, var_4("technology_start_up"))
		else
			pg = var_2_1

			local var_2_6 = var_2_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			i18n = var_2_10003

			var_2_7(var_2_6, var_2_10003("technology_start_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
