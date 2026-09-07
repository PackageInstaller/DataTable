local BackYardCollectThemeTemplateCommand = class("BackYardCollectThemeTemplateCommand", pm.SimpleCommand)

function BackYardCollectThemeTemplateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.templateId
	local var_1_2 = var_1_0.isCancel

	local function var_1_3(arg_2_0)
		local var_2_0 = getProxy(DormProxy)
		local var_2_1 = var_2_0:GetCollectionThemeTemplateById(var_1_1)

		if var_2_1 and var_1_2 then
			var_2_0:DeleteCollectionThemeTemplate(var_2_1.id)
		elseif var_2_1 and not var_1_2 then
			var_2_1:AddCollection()
			var_2_0:UpdateCollectionThemeTemplate(var_2_1)
		end

		local var_2_2 = var_2_0:GetShopThemeTemplateById(var_1_1)

		if var_2_2 and var_1_2 then
			var_2_2:CancelCollection()
		elseif var_2_2 and not var_1_2 then
			var_2_2:AddCollection()
			var_2_0:AddCollectionThemeTemplate(var_2_2)
		end

		if var_2_2 then
			var_2_0:UpdateShopThemeTemplate(var_2_2)
		end

		self:sendNotification(GAME.BACKYARD_COLLECT_THEME_TEMPLATE_DONE)

		return
	end

	if var_1_0.isCancel then
		pg.ConnectionMgr.GetInstance():Send(19127, {
			theme_id = var_1_0.templateId
		}, 19128, function(arg_3_0)
			if arg_3_0.result == 0 then
				var_1_3(arg_3_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)
	else
		if getProxy(DormProxy):GetThemeTemplateCollectionCnt() >= BackYardConst.MAX_COLLECTION_CNT then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_template_collection_cnt_max"))

			return
		end

		pg.ConnectionMgr.GetInstance():Send(19119, {
			theme_id = var_1_0.templateId,
			upload_time = var_1_0.uploadTime
		}, 19120, function(arg_4_0)
			if arg_4_0.result == 0 then
				var_1_3(arg_4_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
			end

			return
		end)
	end

	return
end

return BackYardCollectThemeTemplateCommand
