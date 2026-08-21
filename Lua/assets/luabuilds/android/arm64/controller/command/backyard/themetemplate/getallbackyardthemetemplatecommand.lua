local var_0_0 = class("GetAllBackYardThemeTemplateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = {}

	seriesAsync({
		function(arg_2_0)
			arg_1_0:GetCustomThemeTemplate(function(arg_3_0)
				var_1_2 = arg_3_0

				arg_2_0()

				return
			end)

			return
		end,
		function(arg_4_0)
			arg_1_0:GetShopThemeTemplate(function(arg_5_0)
				var_1_1 = arg_5_0

				arg_4_0()

				return
			end)

			return
		end,
		function(arg_6_0)
			arg_1_0:GetCollectionThemeTemplate(function(arg_7_0)
				var_1_3 = arg_7_0

				arg_6_0()

				return
			end)

			return
		end
	}, function()
		if var_1_0 then
			var_1_0(var_1_1, var_1_2, var_1_3)
		end

		return
	end)

	return
end

local function var_0_1(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_1 or {}) do
		table.insert({}, iter_9_1)
	end

	return {}
end

function var_0_0.GetCustomThemeTemplate(arg_10_0, arg_10_1)
	local var_10_0 = getProxy(DormProxy)
	local var_10_1 = getProxy(DormProxy):GetCustomThemeTemplates()

	if not var_10_1 then
		arg_10_0:sendNotification(GAME.BACKYARD_GET_THEME_TEMPLATE, {
			type = BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM,
			callback = function()
				var_10_1 = var_10_0:GetCustomThemeTemplates()

				arg_10_1(var_0_1(arg_10_0, var_10_1))

				return
			end
		})
	else
		arg_10_1(var_0_1(arg_10_0, var_10_1))
	end

	return
end

function var_0_0.GetShopThemeTemplate(arg_12_0, arg_12_1)
	getProxy(DormProxy):SetShopThemeTemplates({})
	arg_12_1({})

	return
end

function var_0_0.GetCollectionThemeTemplate(arg_13_0, arg_13_1)
	local var_13_0 = getProxy(DormProxy)
	local var_13_1 = getProxy(DormProxy):GetCollectionThemeTemplates()

	if not var_13_1 then
		arg_13_0:sendNotification(GAME.BACKYARD_GET_THEME_TEMPLATE, {
			type = BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION,
			callback = function()
				var_13_1 = var_13_0:GetCollectionThemeTemplates()

				arg_13_1(var_0_1(arg_13_0, var_13_1))

				return
			end
		})
	else
		arg_13_1(var_0_1(arg_13_0, var_13_1))
	end

	return
end

return var_0_0
