local BackYardRefreshShopTemplateCommand = class("BackYardRefreshShopTemplateCommand", pm.SimpleCommand)

function BackYardRefreshShopTemplateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type
	local var_1_2 = var_1_0.page
	local var_1_3 = var_1_0.force
	local var_1_5 = getProxy(DormProxy)
	local var_1_6 = false

	if var_1_0.page == var_1_5.MAX_PAGE then
		pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_shop_reach_last_page"))

		return
	end

	if var_1_0.page > var_1_5.lastPages[var_1_0.type] then
		self:sendNotification(GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_ERRO)

		return
	end

	local function var_1_7(arg_2_0, arg_2_1)
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.theme_id_list or {}) do
			local var_2_1 = var_1_5:GetShopThemeTemplateById(iter_2_1)

			if not var_2_1 then
				var_1_6 = true

				local var_2_2 = BackYardThemeTemplate.New({
					id = iter_2_1
				})

				var_2_2:SetSortIndex(iter_2_0)

				var_2_0[var_2_2.id] = var_2_2
			else
				var_2_1:SetSortIndex(iter_2_0)

				var_2_0[var_2_1.id] = var_2_1
			end
		end

		if table.getCount(var_2_0) > 0 then
			var_1_5:SetShopThemeTemplates(var_2_0)

			var_1_5.TYPE = var_1_1
			var_1_5.PAGE = var_1_2
		end

		if table.getCount(var_2_0) < BackYardConst.THEME_TEMPLATE_SHOP_REFRSH_CNT then
			var_1_5.lastPages[var_1_1] = var_1_2

			if not var_1_3 then
				-- block empty
			end
		end

		if arg_2_1 then
			arg_2_1()
		end

		return
	end

	local function var_1_8(arg_3_0)
		self:sendNotification(GAME.BACKYARD_GET_IMG_MD5, {
			type = BackYardConst.THEME_TEMPLATE_TYPE_SHOP,
			callback = arg_3_0
		})

		return
	end

	local function var_1_9(arg_4_0)
		seriesAsync({
			function(arg_5_0)
				var_1_7(arg_4_0, arg_5_0)

				return
			end,
			function(arg_6_0)
				var_1_8(arg_6_0)

				return
			end
		}, function()
			self:sendNotification(GAME.BACKYARD_REFRESH_SHOP_TEMPLATE_DONE, {
				existNew = var_1_6
			})

			return
		end)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(19117, {
		typ = var_1_0.type,
		page = var_1_0.page,
		num = BackYardConst.THEME_TEMPLATE_SHOP_REFRSH_CNT
	}, 19118, function(arg_8_0)
		if arg_8_0.result == 0 then
			var_1_9(arg_8_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_8_0.result] .. arg_8_0.result)
		end

		return
	end)

	return
end

return BackYardRefreshShopTemplateCommand
