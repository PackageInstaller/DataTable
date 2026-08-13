class = var_0_10000

local var_0_0 = "BackYardRefreshShopTemplateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.page
	local var_1_2 = var_2.force
	local var_1_3 = var_2.timeType

	getProxy = var_1_10007
	DormProxy = var_1_10009

	local var_1_4 = var_1_10007(var_1_10009)
	local var_1_5 = false

	if var_1_1 == var_1_4.MAX_PAGE then
		pg = var_9

		local var_1_6 = var_9.TipsMgr.GetInstance()
		local var_1_7 = var_9.ShowTips

		i18n = var_1_10012

		var_1_7(var_1_6, var_1_10012("backyard_shop_reach_last_page"))

		return
	end

	if var_1_1 > var_1_4.lastPages[var_1_0] then
		local var_1_8 = arg_1_0
		local var_1_9 = arg_1_0.sendNotification

		GAME = var_1_10012

		var_1_9(var_1_8, var_1_10012.BACKYARD_REFRESH_SHOP_TEMPLATE_ERRO)

		return
	end

	local function var_1_10(arg_2_0, arg_2_1)
		local var_2_0 = {}

		ipairs = var_2_10003

		local var_2_1

		if not arg_2_0.theme_id_list then
			var_2_1 = {}
		end

		for iter_2_0, iter_2_1 in var_2_10003(var_2_1) do
			local var_2_2 = var_1_4

			if not var_8.GetShopThemeTemplateById(var_2_2, iter_2_1) then
				var_1_5 = true
				BackYardThemeTemplate = var_2_10009

				local var_2_3 = var_2_10009.New({
					id = iter_2_1
				})

				var_2_10009.SetSortIndex(var_2_3, iter_2_0)

				var_2_0[var_2_10009.id] = var_2_10009
			else
				var_8:SetSortIndex(iter_2_0)

				var_2_0[var_8.id] = var_8
			end
		end

		table = var_3

		local var_2_4 = var_3.getCount(var_2_0)

		if 0 < var_2_4 then
			local var_2_5 = var_1_4

			var_2_4.SetShopThemeTemplates(var_2_5, var_2_0)

			var_2_4 = var_1_4
			var_2_4.TYPE = var_1_0
			var_2_4 = var_1_4
			var_2_4.PAGE = var_1_1
		end

		table = var_2_4

		local var_2_6 = var_2_4.getCount(var_2_0)

		BackYardConst = var_4

		if var_2_6 < var_4.THEME_TEMPLATE_SHOP_REFRSH_CNT then
			var_1_4.lastPages[var_1_0] = var_1_1

			if not var_1_2 then
				-- block empty
			end
		end

		if arg_2_1 then
			arg_2_1()
		end

		return
	end

	local function var_1_11(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.BACKYARD_GET_IMG_MD5
		local var_3_3 = {}

		BackYardConst = var_2_10006
		var_3_3.type = var_2_10006.THEME_TEMPLATE_TYPE_SHOP
		var_3_3.callback = arg_3_0

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end

	local function var_1_12(arg_4_0)
		seriesAsync = var_2_10001

		var_2_10001({
			function(arg_5_0)
				var_1_10(arg_4_0, arg_5_0)

				return
			end,
			function(arg_6_0)
				var_1_11(arg_6_0)

				return
			end
		}, function()
			local var_7_0 = arg_1_0
			local var_7_1 = var_0.sendNotification

			GAME = var_3_10003

			var_7_1(var_7_0, var_3_10003.BACKYARD_REFRESH_SHOP_TEMPLATE_DONE, {
				existNew = var_1_5
			})

			return
		end)

		return
	end

	pg = var_1_10012

	local var_1_13 = var_1_10012.ConnectionMgr.GetInstance()
	local var_1_14 = var_12.Send
	local var_1_15 = 19117
	local var_1_16 = {
		typ = var_1_0,
		page = var_1_1
	}

	BackYardConst = var_1_10017
	var_1_16.num = var_1_10017.THEME_TEMPLATE_SHOP_REFRSH_CNT

	var_1_14(var_1_13, var_1_15, var_1_16, 19118, function(arg_8_0)
		if arg_8_0.result == 0 then
			var_1_12(arg_8_0)
		else
			pg = var_1

			local var_8_0 = var_1.TipsMgr.GetInstance()
			local var_8_1 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_8_1(var_8_0, var_2_10004[arg_8_0.result] .. arg_8_0.result)
		end

		return
	end)

	return
end

return var_0_1
