local BackYardLikeThemeTemplateCommand = class("BackYardLikeThemeTemplateCommand", pm.SimpleCommand)

function BackYardLikeThemeTemplateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.templateId

	local function var_1_2(arg_2_0)
		local var_2_0 = getProxy(DormProxy)
		local var_2_1 = var_2_0:GetCollectionThemeTemplateById(var_1_1)

		if var_2_1 then
			var_2_1:AddLike()
			var_2_0:UpdateCollectionThemeTemplate(var_2_1)
		end

		local var_2_2 = var_2_0:GetShopThemeTemplateById(var_1_1)

		if var_2_2 then
			var_2_2:AddLike()
			var_2_0:UpdateShopThemeTemplate(var_2_2)
		end

		self:sendNotification(GAME.BACKYARD_LIKE_THEME_TEMPLATE_DONE)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(19121, {
		theme_id = var_1_0.templateId,
		upload_time = var_1_0.uploadTime
	}, 19122, function(arg_3_0)
		if arg_3_0.result == 0 then
			var_1_2(arg_3_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return BackYardLikeThemeTemplateCommand
