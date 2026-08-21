local var_0_0 = class("BackYardDeleteThemeTemplateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(DormProxy)
	local var_1_1 = getProxy(DormProxy):GetCustomThemeTemplateById(arg_1_1:getBody().templateId)

	local function var_1_2(arg_2_0)
		if not var_1_1:IsPushed() then
			if arg_2_0 then
				arg_2_0()
			end

			return
		end

		pg.UIMgr.GetInstance():LoadingOn()
		seriesAsync({
			function(arg_3_0)
				BackYardThemeTempalteUtil.DeleteTexture(var_1_1:GetTextureName(), function(arg_4_0)
					if arg_4_0 then
						arg_3_0()
					end

					return
				end)

				return
			end,
			function(arg_5_0)
				BackYardThemeTempalteUtil.DeleteTexture(var_1_1:GetTextureIconName(), function(arg_6_0)
					if arg_6_0 then
						arg_5_0()
					end

					return
				end)

				return
			end
		}, function()
			pg.UIMgr.GetInstance():LoadingOff()

			if arg_2_0 then
				arg_2_0()
			end

			return
		end)

		return
	end

	local function var_1_3(arg_8_0)
		BackYardThemeTempalteUtil.ClearCaches({
			var_1_1:GetTextureName(),
			var_1_1:GetTextureIconName()
		})
		var_1_0:DeleteCustomThemeTemplate(var_0)

		if var_1_0:IsInitShopThemeTemplates() then
			if var_1_0:GetShopThemeTemplateById(var_0) then
				var_1_0:DeleteShopThemeTemplate(var_0)
			end

			if var_1_0:GetCollectionThemeTemplateById(var_0) then
				var_1_0:DeleteCollectionThemeTemplate(var_0)
			end
		end

		arg_1_0:sendNotification(GAME.BACKYARD_DELETE_THEME_TEMPLATE_DONE)

		return
	end

	;(function()
		pg.ConnectionMgr.GetInstance():Send(19123, {
			pos = var_1_1.pos
		}, 19124, function(arg_10_0)
			if arg_10_0.result == 0 then
				var_1_3(arg_10_0)
				var_1_2()
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_10_0.result] .. arg_10_0.result)
			end

			return
		end)

		return
	end)()

	return
end

return var_0_0
