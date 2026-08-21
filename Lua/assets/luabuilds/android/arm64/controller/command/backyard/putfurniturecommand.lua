local var_0_0 = class("PutFurnitureCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(DormProxy)

	if not var_1_1 then
		return
	end

	local var_1_2 = var_1_0.floor or var_1_1.floor

	assert(var_1_2, "floor should exist")

	local var_1_3 = var_1_1:getRawData()
	local var_1_5, var_1_6 = CourtYardRawDataChecker.Check(var_1_0.furnsPos, var_1_3:GetMapSize())

	if not var_1_5 then
		if var_1_0.callback then
			var_1_0.callback(false, var_1_6)

			return
		end

		pg.TipsMgr.GetInstance():ShowTips(var_1_6)

		return
	end

	local var_1_7 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.furnsPos) do
		for iter_1_2, iter_1_3 in pairs(iter_1_1.child) do
			table.insert({}, {
				id = tostring(iter_1_2),
				x = iter_1_3.x,
				y = iter_1_3.y
			})
		end

		table.insert(var_1_7, {
			shipId = 1,
			id = tostring(iter_1_1.configId),
			x = iter_1_1.x,
			y = iter_1_1.y,
			dir = iter_1_1.dir,
			child = {},
			parent = iter_1_1.parent
		})
	end

	var_1_1:getRawData():SetTheme(var_1_2, BackYardSelfThemeTemplate.New({
		id = -1,
		furniture_put_list = var_1_7
	}, var_1_2))
	pg.ConnectionMgr.GetInstance():Send(19008, {
		floor = var_1_2,
		furniture_put_list = var_1_7
	})

	if var_1_0.tip then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_putFurniture_ok"))
	end

	arg_1_0:sendNotification(GAME.PUT_FURNITURE_DONE)

	if var_1_0.callback then
		var_1_0.callback(true)
	end

	return
end

return var_0_0
