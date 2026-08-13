class = var_0_10000

local var_0_0 = "BackYardSeachThemeTemplateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	if not arg_1_1:getBody().str or var_3 == "" then
		var_1_10006 = arg_1_0

		local var_1_0 = arg_1_0.sendNotification

		GAME = var_1_10007

		var_1_0(var_1_10006, var_1_10007.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO)

		return
	end

	local function var_1_1(arg_2_0)
		local var_2_0 = arg_2_0.theme
		local var_2_1 = arg_2_0.has_fav and 1 or 0
		local var_2_2 = arg_2_0.has_like and 1 or 0

		BackYardThemeTemplate = var_2_10004

		local var_2_3 = var_2_10004.New({
			id = var_2_0.id,
			name = var_2_0.name,
			furniture_put_list = var_2_0.furniture_put_list,
			user_id = var_2_0.user_id,
			pos = var_2_0.pos,
			like_count = var_2_0.like_count,
			fav_count = var_2_0.fav_count,
			upload_time = var_2_0.upload_time,
			is_collection = var_2_1,
			is_like = var_2_2,
			image_md5 = var_2_0.image_md5,
			icon_image_md5 = var_2_0.icon_image_md5
		})
		local var_2_4 = arg_1_0
		local var_2_5 = var_5.sendNotification

		GAME = var_2_10008

		var_2_5(var_2_4, var_2_10008.BACKYARD_SEARCH_THEME_TEMPLATE_DONE, {
			template = var_2_3
		})

		return
	end

	local function var_1_2(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.BACKYARD_SEARCH_THEME_TEMPLATE_ERRO)

		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 19113, {
		theme_id = var_3
	}, 19114, function(arg_4_0)
		if arg_4_0.result == 0 then
			var_1_1(arg_4_0)
		else
			var_1_2(arg_4_0)

			local var_4_1

			if arg_4_0.result == 20 then
				pg = var_4_1

				local var_4_0 = var_4_1.TipsMgr.GetInstance()

				var_4_1 = var_4_1.ShowTips
				i18n = var_2_10004

				var_4_1(var_4_0, var_2_10004("backyard_not_found_theme_template"))
			else
				pg = var_4_1

				local var_4_2 = var_4_1.TipsMgr.GetInstance()
				local var_4_3 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_4_3(var_4_2, var_2_10004[arg_4_0.result] .. arg_4_0.result)
			end
		end

		return
	end)

	return
end

return var_0_1
