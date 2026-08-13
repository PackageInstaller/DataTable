class = var_0_10000

local var_0_0 = "GetBackYardVisitorCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).callback

	pg = var_1_0

	local var_1_2 = var_1_0.ConnectionMgr.GetInstance()

	var_4.Send(var_1_2, 19024, {
		type = 0
	}, 19025, function(arg_2_0)
		getProxy = var_2_10001
		DormProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)
		local var_2_1 = var_1.getRawData(var_2_0)

		ipairs = var_2_10002

		for iter_2_0, iter_2_1 in var_2_10002(arg_2_0.furniture_put_list) do
			local var_2_2 = {}

			ipairs = var_2_10008

			for iter_2_2, iter_2_3 in var_2_10008(iter_2_1.furniture_put_list) do
				local var_2_3 = {}

				ipairs = var_2_10014

				for iter_2_4, iter_2_5 in var_2_10014(iter_2_3.child) do
					table = var_2_10019

					var_2_10019.insert(var_2_3, {
						id = iter_2_5.id,
						x = iter_2_5.x,
						y = iter_2_5.y
					})
				end

				var_2_10014 = {
					id = iter_2_3.id,
					x = iter_2_3.x,
					y = iter_2_3.y,
					dir = iter_2_3.dir,
					child = var_2_3,
					parent = iter_2_3.parent,
					shipId = iter_2_3.shipId
				}
				table = var_15

				var_15.insert(var_2_2, var_2_10014)
			end

			local var_2_4 = var_2_1

			var_2_10008 = var_2_1.SetTheme

			local var_2_5 = iter_2_1.floor

			BackYardSelfThemeTemplate = iter_2_3

			var_2_10008(var_2_4, var_2_5, iter_2_3.New({
				id = -1,
				furniture_put_list = var_2_2
			}, iter_2_1.floor))
		end

		if arg_2_0.visitor and arg_2_0.visitor.ship_template ~= 0 then
			Ship = var_2

			local var_2_6 = var_2.New({
				id = 99999999,
				template_id = arg_2_0.visitor.ship_template,
				name = arg_2_0.visitor.name,
				skin_id = arg_2_0.visitor.ship_skin
			})

			getProxy = var_3
			DormProxy = iter_2_0
			iter_2_0 = var_3(iter_2_0)

			var_3.SetVisitorShip(iter_2_0, var_2_6)
		end

		if var_1_1 then
			var_1_1()
		end

		local var_2_7 = arg_1_0
		local var_2_8 = var_2.sendNotification

		GAME = iter_2_0

		var_2_8(var_2_7, iter_2_0.BACKYARD_GET_VISITOR_SHIP_DONE)

		return
	end)

	return
end

return var_0_1
