local var_0_0 = class("BackYardGetThemeTemplateDataCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback

	pg.ConnectionMgr.GetInstance():Send(19113, {
		theme_id = var_1_0.templateId
	}, 19114, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = BackYardThemeTemplate.New({
				is_fetch = true,
				id = arg_2_0.theme.id,
				name = arg_2_0.theme.name,
				furniture_put_list = arg_2_0.theme.furniture_put_list,
				user_id = arg_2_0.theme.user_id,
				pos = arg_2_0.theme.pos,
				like_count = arg_2_0.theme.like_count,
				fav_count = arg_2_0.theme.fav_count,
				upload_time = arg_2_0.theme.upload_time,
				is_collection = arg_2_0.has_fav and 1 or 0,
				is_like = arg_2_0.has_like and 1 or 0,
				image_md5 = arg_2_0.theme.image_md5,
				icon_image_md5 = arg_2_0.theme.icon_image_md5
			})
			local var_2_1 = getProxy(DormProxy)

			if var_2_1:GetShopThemeTemplateById(var_0) then
				var_2_1:UpdateShopThemeTemplate(var_2_0)
			end

			if var_2_1:GetCollectionThemeTemplateById(var_0) then
				var_2_1:UpdateCollectionThemeTemplate(var_2_0)
			end

			if var_1_1 then
				var_1_1(var_2_0)
			end

			arg_1_0:sendNotification(GAME.BACKYARD_GET_THEME_TEMPLATE_DATA_DONE, {
				template = var_2_0
			})
		elseif arg_2_0.result == 20 then
			local var_2_2 = getProxy(DormProxy)

			if var_2_2:GetShopThemeTemplateById(var_0) then
				var_2_2:DeleteShopThemeTemplate(var_0)
			end

			if var_2_2:GetCollectionThemeTemplateById(var_0) then
				var_2_2:DeleteCollectionThemeTemplate(var_0)
			end

			pg.TipsMgr.GetInstance():ShowTips(i18n("Backyard_theme_template_be_delete_tip"))
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_0
