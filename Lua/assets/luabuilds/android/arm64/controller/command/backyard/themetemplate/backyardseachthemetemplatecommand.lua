local var_0_0 = class("BackYardSeachThemeTemplateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().str

	if not var_1_0 or var_1_0 == "" then
		arg_1_0:sendNotification(GAME.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO)

		return
	end

	local function var_1_1(arg_2_0)
		arg_1_0:sendNotification(GAME.BACKYARD_SEARCH_THEME_TEMPLATE_DONE, {
			template = BackYardThemeTemplate.New({
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
		})

		return
	end

	local function var_1_2(arg_3_0)
		arg_1_0:sendNotification(GAME.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO)

		return
	end

	pg.ConnectionMgr.GetInstance():Send(19113, {
		theme_id = var_1_0
	}, 19114, function(arg_4_0)
		if arg_4_0.result == 0 then
			var_1_1(arg_4_0)
		else
			var_1_2(arg_4_0)

			if arg_4_0.result == 20 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_not_found_theme_template"))
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
			end
		end

		return
	end)

	return
end

return var_0_0
