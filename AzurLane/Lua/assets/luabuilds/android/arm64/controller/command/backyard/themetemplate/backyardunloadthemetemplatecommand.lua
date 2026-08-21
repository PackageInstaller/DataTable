local var_0_0 = class("BackYardUnloadThemeTemplateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(DormProxy)
	local var_1_1 = getProxy(DormProxy):GetCustomThemeTemplateById(arg_1_1:getBody().templateId)

	local function var_1_2(arg_2_0)
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
		var_1_1:UnLoad()
		var_1_0:UpdateCustomThemeTemplate(var_1_1)

		if var_1_0:GetShopThemeTemplateById(var_1_1.id) then
			var_1_0:DeleteShopThemeTemplate(var_1_1.id)
		end

		if var_1_0:GetCollectionThemeTemplateById(var_1_1.id) then
			var_1_0:DeleteCollectionThemeTemplate(var_1_1.id)
		end

		arg_1_0:sendNotification(GAME.BACKYARD_UNLOAD_THEME_TEMPLATE_DONE)

		return
	end

	;(function()
		pg.ConnectionMgr.GetInstance():Send(19125, {
			pos = var_1_1.pos
		}, 19126, function(arg_10_0)
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
