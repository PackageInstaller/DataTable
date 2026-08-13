class = var_0_10000

local var_0_0 = "GetAllBackYardThemeTemplateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = {}
	local var_1_2 = {}
	local var_1_3 = {}

	seriesAsync = var_1_10007

	var_1_10007({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.GetCustomThemeTemplate(var_2_0, function(arg_3_0)
				var_1_2 = arg_3_0

				arg_2_0()

				return
			end)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_1_0

			var_1.GetShopThemeTemplate(var_4_0, function(arg_5_0)
				var_1_1 = arg_5_0

				arg_4_0()

				return
			end)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_1_0

			var_1.GetCollectionThemeTemplate(var_6_0, function(arg_7_0)
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

local function var_0_2(arg_9_0, arg_9_1)
	local var_9_0 = {}

	pairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_1 or {}) do
		table = var_1_10008

		var_1_10008.insert(var_9_0, iter_9_1)
	end

	return var_9_0
end

function var_0_1.GetCustomThemeTemplate(arg_10_0, arg_10_1)
	getProxy = var_1_10002
	DormProxy = var_1_10004

	local var_10_0 = var_1_10002(var_1_10004)

	if not var_2.GetCustomThemeTemplates(var_10_0) then
		local var_10_1 = arg_10_0
		local var_10_2 = arg_10_0.sendNotification

		GAME = var_1_10007

		local var_10_3 = var_1_10007.BACKYARD_GET_THEME_TEMPLATE
		local var_10_4 = {}

		BackYardConst = var_1_10009
		var_10_4.type = var_1_10009.THEME_TEMPLATE_TYPE_CUSTOM

		function var_10_4.callback()
			local var_11_0 = var_0

			var_0 = var_0.GetCustomThemeTemplates(var_11_0)

			arg_10_1(var_0_2(arg_10_0, var_0))

			return
		end

		var_10_2(var_10_1, var_10_3, var_10_4)
	else
		arg_10_1(var_0_2(arg_10_0, var_3))
	end

	return
end

function var_0_1.GetShopThemeTemplate(arg_12_0, arg_12_1)
	local var_12_0 = {}

	getProxy = var_1_10003
	DormProxy = var_1_10005

	local var_12_1 = var_1_10003(var_1_10005)

	var_3.SetShopThemeTemplates(var_12_1, var_12_0)
	arg_12_1(var_12_0)

	return
end

function var_0_1.GetCollectionThemeTemplate(arg_13_0, arg_13_1)
	getProxy = var_1_10002
	DormProxy = var_1_10004

	local var_13_0 = var_1_10002(var_1_10004)

	if not var_2.GetCollectionThemeTemplates(var_13_0) then
		local var_13_1 = arg_13_0
		local var_13_2 = arg_13_0.sendNotification

		GAME = var_1_10007

		local var_13_3 = var_1_10007.BACKYARD_GET_THEME_TEMPLATE
		local var_13_4 = {}

		BackYardConst = var_1_10009
		var_13_4.type = var_1_10009.THEME_TEMPLATE_TYPE_COLLECTION

		function var_13_4.callback()
			local var_14_0 = var_0

			var_0 = var_0.GetCollectionThemeTemplates(var_14_0)

			arg_13_1(var_0_2(arg_13_0, var_0))

			return
		end

		var_13_2(var_13_1, var_13_3, var_13_4)
	else
		arg_13_1(var_0_2(arg_13_0, var_3))
	end

	return
end

return var_0_1
