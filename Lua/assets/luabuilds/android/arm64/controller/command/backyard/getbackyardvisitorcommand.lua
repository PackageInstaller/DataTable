local var_0_0 = class("GetBackYardVisitorCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	pg.ConnectionMgr.GetInstance():Send(19024, {
		type = 0
	}, 19025, function(arg_2_0)
		local var_2_0 = getProxy(DormProxy):getRawData()

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.furniture_put_list) do
			for iter_2_2, iter_2_3 in ipairs(iter_2_1.furniture_put_list) do
				for iter_2_4, iter_2_5 in ipairs(iter_2_3.child) do
					table.insert({}, {
						id = iter_2_5.id,
						x = iter_2_5.x,
						y = iter_2_5.y
					})
				end

				table.insert({}, {
					id = iter_2_3.id,
					x = iter_2_3.x,
					y = iter_2_3.y,
					dir = iter_2_3.dir,
					child = {},
					parent = iter_2_3.parent,
					shipId = iter_2_3.shipId
				})
			end

			var_2_0:SetTheme(iter_2_1.floor, BackYardSelfThemeTemplate.New({
				id = -1,
				furniture_put_list = {}
			}, iter_2_1.floor))
		end

		if arg_2_0.visitor and arg_2_0.visitor.ship_template ~= 0 then
			getProxy(DormProxy):SetVisitorShip((Ship.New({
				id = 99999999,
				template_id = arg_2_0.visitor.ship_template,
				name = arg_2_0.visitor.name,
				skin_id = arg_2_0.visitor.ship_skin
			})))
		end

		if var_1_0 then
			var_1_0()
		end

		arg_1_0:sendNotification(GAME.BACKYARD_GET_VISITOR_SHIP_DONE)

		return
	end)

	return
end

return var_0_0
