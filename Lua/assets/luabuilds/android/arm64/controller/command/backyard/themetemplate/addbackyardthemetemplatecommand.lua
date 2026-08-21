local var_0_0 = class("AddBackYardThemeTemplateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(DormProxy):getRawData()
	local var_1_3, var_1_4 = CourtYardRawDataChecker.Check(var_1_0.furnitureputList, var_1_1:GetMapSize())

	if not var_1_3 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_4)

		return
	end

	local var_1_5 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.furnitureputList) do
		for iter_1_2, iter_1_3 in pairs(iter_1_1.child) do
			table.insert({}, {
				id = tostring(iter_1_2),
				x = iter_1_3.x,
				y = iter_1_3.y
			})
		end

		table.insert(var_1_5, {
			shipId = 1,
			id = tostring(iter_1_1.configId),
			x = iter_1_1.x,
			y = iter_1_1.y,
			dir = iter_1_1.dir,
			child = {},
			parent = iter_1_1.parent
		})
	end

	pg.ConnectionMgr.GetInstance():Send(19109, {
		pos = var_1_0.id,
		name = var_1_0.name,
		furniture_put_list = var_1_5,
		icon_image_md5 = var_1_0.iconMd5,
		image_md5 = var_1_0.imageMd5
	}, 19110, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_0.id = BackYardBaseThemeTemplate.BuildId(var_1_0.id)

			getProxy(DormProxy):AddCustomThemeTemplate((BackYardSelfThemeTemplate.New(var_0)))
			arg_1_0:sendNotification(GAME.BACKYARD_SAVE_THEME_TEMPLATE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_0
