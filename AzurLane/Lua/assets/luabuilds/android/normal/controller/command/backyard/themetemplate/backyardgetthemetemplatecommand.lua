class = var_0_10000

local var_0_0 = "BackYardGetThemeTemplateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	DormProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)

	local function var_1_3(arg_2_0, arg_2_1)
		local var_2_0 = var_1_0

		BackYardConst = var_2_10003

		if var_2_0 == var_2_10003.THEME_TEMPLATE_TYPE_SHOP then
			local var_2_1 = {}

			ipairs = var_3

			local var_2_2

			if not arg_2_0.theme_id_list then
				var_2_2 = {}
			end

			for iter_2_0, iter_2_1 in var_3(var_2_2) do
				local var_2_3

				BackYardThemeTemplate = var_2_10009

				local var_2_4 = var_2_10009.New({
					id = iter_2_1
				})

				var_8.SetSortIndex(var_2_4, iter_2_0)

				var_2_1[var_8.id] = var_8
			end

			local var_2_5 = var_1_2

			var_3.SetShopThemeTemplates(var_2_5, var_2_1)
		else
			local var_2_6 = var_1_0

			BackYardConst = var_3

			if var_2_6 == var_3.THEME_TEMPLATE_TYPE_CUSTOM then
				local var_2_7 = {}

				ipairs = var_3

				local var_2_8

				if not arg_2_0.theme_list then
					var_2_8 = {}
				end

				for iter_2_2, iter_2_3 in var_3(var_2_8) do
					local var_2_9

					BackYardSelfThemeTemplate = var_2_10009
					var_2_7[var_2_10009.New(iter_2_3).id] = var_8
				end

				local var_2_10 = var_1_2

				var_3.SetCustomThemeTemplates(var_2_10, var_2_7)
			else
				local var_2_11 = var_1_0

				BackYardConst = var_3

				if var_2_11 == var_3.THEME_TEMPLATE_TYPE_COLLECTION then
					local var_2_12 = {}

					ipairs = var_3

					local var_2_13

					if not arg_2_0.theme_profile_list then
						var_2_13 = {}
					end

					for iter_2_4, iter_2_5 in var_3(var_2_13) do
						local var_2_14

						BackYardThemeTemplate = var_2_10009
						var_2_12[var_2_10009.New({
							id = iter_2_5.id,
							upload_time = iter_2_5.upload_time
						}).id] = var_8
					end

					local var_2_15 = var_1_2

					var_3.SetCollectionThemeTemplates(var_2_15, var_2_12)
				end
			end
		end

		if arg_2_1 then
			arg_2_1()
		end

		return
	end

	local function var_1_4(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10003

		var_3_1(var_3_0, var_2_10003.BACKYARD_GET_IMG_MD5, {
			type = var_1_0,
			callback = arg_3_0
		})

		return
	end

	local function var_1_5(arg_4_0)
		seriesAsync = var_2_10001

		var_2_10001({
			function(arg_5_0)
				var_1_3(arg_4_0, arg_5_0)

				return
			end,
			function(arg_6_0)
				var_1_4(arg_6_0)

				return
			end
		}, function()
			local var_7_0 = arg_1_0
			local var_7_1 = var_0.sendNotification

			GAME = var_3_10002

			var_7_1(var_7_0, var_3_10002.BACKYARD_GET_THEME_TEMPLATE_DONE)

			if var_1_1 then
				var_1_1()
			end

			return
		end)

		return
	end

	BackYardConst = var_1_10009

	if var_1_0 == var_1_10009.THEME_TEMPLATE_TYPE_CUSTOM then
		pg = var_9

		local var_1_6 = var_9.ConnectionMgr.GetInstance()

		var_9.Send(var_1_6, 19105, {
			typ = var_1_0
		}, 19106, function(arg_8_0)
			local var_8_1

			if arg_8_0.result == 0 then
				var_1_3(arg_8_0)

				local var_8_0 = arg_1_0

				var_8_1 = var_8_1.sendNotification
				GAME = var_2_10003

				var_8_1(var_8_0, var_2_10003.BACKYARD_GET_THEME_TEMPLATE_DONE)

				if var_1_1 then
					var_1_1()
				end
			else
				pg = var_8_1

				local var_8_2 = var_8_1.TipsMgr.GetInstance()
				local var_8_3 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_8_3(var_8_2, var_2_10003[arg_8_0.result] .. arg_8_0.result)
			end

			return
		end)
	else
		BackYardConst = var_9

		local var_1_8

		if var_1_0 == var_9.THEME_TEMPLATE_TYPE_SHOP then
			pg = var_1_8

			local var_1_7 = var_1_8.ConnectionMgr.GetInstance()

			var_1_8 = var_1_8.Send

			local var_1_9 = 19117
			local var_1_10 = {
				typ = var_1_2.TYPE,
				page = var_1_2.PAGE
			}

			BackYardConst = var_13
			var_1_10.num = var_13.THEME_TEMPLATE_SHOP_REFRSH_CNT

			var_1_8(var_1_7, var_1_9, var_1_10, 19118, function(arg_9_0)
				if arg_9_0.result == 0 then
					var_1_5(arg_9_0)
				else
					pg = var_1

					local var_9_0 = var_1.TipsMgr.GetInstance()
					local var_9_1 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10003

					var_9_1(var_9_0, var_2_10003[arg_9_0.result] .. arg_9_0.result)
				end

				return
			end)
		else
			BackYardConst = var_1_8

			if var_1_0 == var_1_8.THEME_TEMPLATE_TYPE_COLLECTION then
				pg = var_9

				local var_1_11 = var_9.ConnectionMgr.GetInstance()

				var_9.Send(var_1_11, 19115, {
					typ = 3
				}, 19116, function(arg_10_0)
					if arg_10_0.result == 0 then
						var_1_5(arg_10_0)
					else
						pg = var_1

						local var_10_0 = var_1.TipsMgr.GetInstance()
						local var_10_1 = var_1.ShowTips

						ERROR_MESSAGE = var_2_10003

						var_10_1(var_10_0, var_2_10003[arg_10_0.result] .. arg_10_0.result)
					end

					return
				end)
			end
		end
	end

	return
end

return var_0_1
