class = var_0_10000

local var_0_0 = "BackYardCollectThemeTemplateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().templateId
	local var_1_1 = var_2.uploadTime
	local var_1_2 = var_2.isCancel

	local function var_1_3(arg_2_0)
		getProxy = var_2_10001
		DormProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		if var_1.GetCollectionThemeTemplateById(var_2_0, var_1_0) and var_1_2 then
			var_1:DeleteCollectionThemeTemplate(var_2.id)
		elseif var_2 and not var_1_2 then
			var_2:AddCollection()
			var_1:UpdateCollectionThemeTemplate(var_2)
		end

		if var_1:GetShopThemeTemplateById(var_1_0) and var_1_2 then
			var_3:CancelCollection()
		elseif var_3 and not var_1_2 then
			var_3:AddCollection()
			var_1:AddCollectionThemeTemplate(var_3)
		end

		if var_3 then
			var_1:UpdateShopThemeTemplate(var_3)
		end

		local var_2_1 = arg_1_0
		local var_2_2 = var_4.sendNotification

		GAME = var_2_10007

		var_2_2(var_2_1, var_2_10007.BACKYARD_COLLECT_THEME_TEMPLATE_DONE)

		return
	end

	if var_1_2 then
		pg = var_1_10007
		var_1_10009 = var_1_10007.ConnectionMgr.GetInstance()

		var_1_10007.Send(var_1_10009, 19127, {
			theme_id = var_1_0
		}, 19128, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_3(arg_3_0)
			else
				pg = var_1

				local var_3_0 = var_1.TipsMgr.GetInstance()
				local var_3_1 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_3_1(var_3_0, var_2_10004[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)
	else
		getProxy = var_1_10007
		DormProxy = var_1_10009

		local var_1_4 = var_1_10007(var_1_10009)
		local var_1_5 = var_7.GetThemeTemplateCollectionCnt(var_1_4)

		BackYardConst = var_1_10008

		if var_1_5 >= var_1_10008.MAX_COLLECTION_CNT then
			pg = var_1_5

			local var_1_6 = var_1_5.TipsMgr.GetInstance()

			var_1_5 = var_1_5.ShowTips
			i18n = var_1_10010

			var_1_5(var_1_6, var_1_10010("backyard_theme_template_collection_cnt_max"))

			return
		end

		pg = var_1_5

		local var_1_7 = var_1_5.ConnectionMgr.GetInstance()

		var_7.Send(var_1_7, 19119, {
			theme_id = var_1_0,
			upload_time = var_1_1
		}, 19120, function(arg_4_0)
			if arg_4_0.result == 0 then
				var_1_3(arg_4_0)
			else
				pg = var_1

				local var_4_0 = var_1.TipsMgr.GetInstance()
				local var_4_1 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10004

				var_4_1(var_4_0, var_2_10004[arg_4_0.result] .. arg_4_0.result)
			end

			return
		end)
	end

	return
end

return var_0_1
