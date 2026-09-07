local AddBackYardThemeTemplateCommand = class("AddBackYardThemeTemplateCommand", pm.SimpleCommand)

function AddBackYardThemeTemplateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_3, var_1_4 = CourtYardRawDataChecker.Check(var_1_0.furnitureputList, getProxy(DormProxy):getRawData():GetMapSize())

	if not var_1_3 then
		pg.TipsMgr.GetInstance():ShowTips(var_1_4)

		return
	end

	local var_1_5 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.furnitureputList) do
		local var_1_6 = {}

		for iter_1_2, iter_1_3 in pairs(iter_1_1.child) do
			table.insert(var_1_6, {
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
			child = var_1_6,
			parent = iter_1_1.parent
		})
	end

	local var_1_7 = {
		pos = var_1_0.id,
		name = var_1_0.name,
		furniture_put_list = var_1_5,
		icon_image_md5 = var_1_0.iconMd5,
		image_md5 = var_1_0.imageMd5
	}

	pg.ConnectionMgr.GetInstance():Send(19109, var_1_7, 19110, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_7.id = BackYardBaseThemeTemplate.BuildId(var_1_0.id)

			getProxy(DormProxy):AddCustomThemeTemplate((BackYardSelfThemeTemplate.New(var_1_7)))
			self:sendNotification(GAME.BACKYARD_SAVE_THEME_TEMPLATE_DONE)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return AddBackYardThemeTemplateCommand
