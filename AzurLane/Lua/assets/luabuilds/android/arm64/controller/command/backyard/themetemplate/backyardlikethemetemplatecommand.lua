class = var_0_10000

local var_0_0 = "BackYardLikeThemeTemplateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().templateId
	local var_1_1 = var_2.uploadTime

	local function var_1_2(arg_2_0)
		getProxy = var_2_10001
		DormProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		if var_1.GetCollectionThemeTemplateById(var_2_0, var_1_0) then
			var_2:AddLike()
			var_1:UpdateCollectionThemeTemplate(var_2)
		end

		if var_1:GetShopThemeTemplateById(var_1_0) then
			var_3:AddLike()
			var_1:UpdateShopThemeTemplate(var_3)
		end

		local var_2_1 = arg_1_0
		local var_2_2 = var_4.sendNotification

		GAME = var_2_10007

		var_2_2(var_2_1, var_2_10007.BACKYARD_LIKE_THEME_TEMPLATE_DONE)

		return
	end

	pg = var_1_10006

	local var_1_3 = var_1_10006.ConnectionMgr.GetInstance()

	var_6.Send(var_1_3, 19121, {
		theme_id = var_1_0,
		upload_time = var_1_1
	}, 19122, function(arg_3_0)
		if arg_3_0.result == 0 then
			var_1_2(arg_3_0)
		else
			pg = var_1

			local var_3_0 = var_1.TipsMgr.GetInstance()
			local var_3_1 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_3_1(var_3_0, var_2_10004[arg_3_0.result] .. arg_3_0.result)
		end

		return
	end)

	return
end

return var_0_1
