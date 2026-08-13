class = var_0_10000

local var_0_0 = "BackYardGetThemeTemplateDataCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().templateId
	local var_1_1 = var_2.callback

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 19113, {
		theme_id = var_1_0
	}, 19114, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = arg_2_0.theme
			local var_2_1 = arg_2_0.has_fav and 1 or 0

			var_2_10003 = arg_2_0.has_like and 1 or 0
			BackYardThemeTemplate = var_2_10004
			var_2_10004 = var_2_10004.New({
				is_fetch = true,
				id = var_2_0.id,
				name = var_2_0.name,
				furniture_put_list = var_2_0.furniture_put_list,
				user_id = var_2_0.user_id,
				pos = var_2_0.pos,
				like_count = var_2_0.like_count,
				fav_count = var_2_0.fav_count,
				upload_time = var_2_0.upload_time,
				is_collection = var_2_1,
				is_like = var_2_10003,
				image_md5 = var_2_0.image_md5,
				icon_image_md5 = var_2_0.icon_image_md5
			})
			getProxy = var_2_10005
			DormProxy = var_7

			local var_2_2 = var_2_10005(var_7)

			if var_5.GetShopThemeTemplateById(var_2_2, var_1_0) then
				var_5:UpdateShopThemeTemplate(var_2_10004)
			end

			if var_5:GetCollectionThemeTemplateById(var_1_0) then
				var_5:UpdateCollectionThemeTemplate(var_2_10004)
			end

			if var_1_1 then
				var_1_1(var_2_10004)
			end

			local var_2_3 = arg_1_0
			local var_2_4 = var_6.sendNotification

			GAME = var_9

			var_2_4(var_2_3, var_9.BACKYARD_GET_THEME_TEMPLATE_DATA_DONE, {
				template = var_2_10004
			})
		elseif arg_2_0.result == 20 then
			getProxy = var_1
			DormProxy = var_2_10003
			var_2_10004 = var_1(var_2_10003)

			if var_1.GetShopThemeTemplateById(var_2_10004, var_1_0) then
				var_2_10004 = var_1

				var_1.DeleteShopThemeTemplate(var_2_10004, var_1_0)
			end

			var_2_10004 = var_1

			if var_1.GetCollectionThemeTemplateById(var_2_10004, var_1_0) then
				var_2_10004 = var_1

				var_1.DeleteCollectionThemeTemplate(var_2_10004, var_1_0)
			end

			pg = var_2
			var_2_10004 = var_2.TipsMgr.GetInstance()

			local var_2_5 = var_2.ShowTips

			i18n = var_5

			var_2_5(var_2_10004, var_5("Backyard_theme_template_be_delete_tip"))
		else
			pg = var_1

			local var_2_6 = var_1.TipsMgr.GetInstance()
			local var_2_7 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_7(var_2_6, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
