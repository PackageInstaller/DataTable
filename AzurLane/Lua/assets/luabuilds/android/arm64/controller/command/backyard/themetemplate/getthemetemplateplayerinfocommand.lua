local var_0_0 = class("GetThemeTemplatePlayerInfoCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.templateId
	local var_1_2 = var_1_0.callback
	local var_1_3 = getProxy(DormProxy)

	if var_1_0.type == BackYardConst.THEME_TEMPLATE_TYPE_SHOP or var_1_0.type == BackYardConst.THEME_TEMPLATE_TYPE_COLLECTION then
		local function var_1_4(arg_2_0)
			local var_2_0 = CourtYardThemeOwner.New(arg_2_0.player)
			local var_2_1 = var_1_3:GetShopThemeTemplateById(var_1_1)

			if var_2_1 then
				var_2_1:SetPlayerInfo(var_2_0)
				var_1_3:UpdateShopThemeTemplate(var_2_1)
			end

			local var_2_2 = var_1_3:GetCollectionThemeTemplateById(var_1_1)

			if var_2_2 then
				var_2_2:SetPlayerInfo(var_2_0)
				var_1_3:UpdateCollectionThemeTemplate(var_2_2)
			end

			if var_1_2 then
				var_1_2(var_2_0)
			end

			return
		end

		pg.ConnectionMgr.GetInstance():Send(50113, {
			user_id = var_1_0.userId
		}, 50114, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_4(arg_3_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)
	elseif var_1_0.type == BackYardConst.THEME_TEMPLATE_TYPE_CUSTOM then
		local var_1_5 = getProxy(PlayerProxy):getData()
		local var_1_6 = var_1_3:GetCustomThemeTemplateById(var_1_0.templateId)

		if var_1_6 then
			var_1_6:SetPlayerInfo(var_1_5)
			var_1_3:UpdateCustomThemeTemplate(var_1_6)
		end

		if var_1_0.callback then
			var_1_0.callback(var_1_5)
		end
	end

	return
end

return var_0_0
