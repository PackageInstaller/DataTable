class = var_0_10000

local var_0_0 = "BackYardUnloadThemeTemplateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().templateId

	getProxy = var_1_10004
	DormProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)
	local var_1_2 = var_4.GetCustomThemeTemplateById(var_1_1, var_1_0)

	local function var_1_3(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.UIMgr.GetInstance()

		var_1.LoadingOn(var_2_0)

		seriesAsync = var_1

		var_1({
			function(arg_3_0)
				BackYardThemeTempalteUtil = var_3_10001

				local var_3_0 = var_3_10001.DeleteTexture
				local var_3_1 = var_1_2

				var_3_0(var_2.GetTextureName(var_3_1), function(arg_4_0)
					if arg_4_0 then
						arg_3_0()
					end

					return
				end)

				return
			end,
			function(arg_5_0)
				BackYardThemeTempalteUtil = var_3_10001

				local var_5_0 = var_3_10001.DeleteTexture
				local var_5_1 = var_1_2

				var_5_0(var_2.GetTextureIconName(var_5_1), function(arg_6_0)
					if arg_6_0 then
						arg_5_0()
					end

					return
				end)

				return
			end
		}, function()
			pg = var_3_10000

			local var_7_0 = var_3_10000.UIMgr.GetInstance()

			var_0.LoadingOff(var_7_0)

			if arg_2_0 then
				arg_2_0()
			end

			return
		end)

		return
	end

	local function var_1_4(arg_8_0)
		local var_8_0 = var_1_2

		var_1.UnLoad(var_8_0)

		local var_8_1 = var_0

		var_1.UpdateCustomThemeTemplate(var_8_1, var_1_2)

		local var_8_2 = var_1_2.id
		local var_8_3 = var_0

		if var_2.GetShopThemeTemplateById(var_8_3, var_8_2) then
			local var_8_4 = var_0

			var_2.DeleteShopThemeTemplate(var_8_4, var_8_2)
		end

		local var_8_5 = var_0

		if var_2.GetCollectionThemeTemplateById(var_8_5, var_8_2) then
			local var_8_6 = var_0

			var_2.DeleteCollectionThemeTemplate(var_8_6, var_8_2)
		end

		local var_8_7 = arg_1_0
		local var_8_8 = var_2.sendNotification

		GAME = var_4

		var_8_8(var_8_7, var_4.BACKYARD_UNLOAD_THEME_TEMPLATE_DONE)

		return
	end

	;(function()
		pg = var_2_10000

		local var_9_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_9_0, 19125, {
			pos = var_1_2.pos
		}, 19126, function(arg_10_0)
			if arg_10_0.result == 0 then
				var_1_4(arg_10_0)
				var_1_3()
			else
				pg = var_1

				local var_10_0 = var_1.TipsMgr.GetInstance()
				local var_10_1 = var_1.ShowTips

				ERROR_MESSAGE = var_3_10003

				var_10_1(var_10_0, var_3_10003[arg_10_0.result] .. arg_10_0.result)
			end

			return
		end)

		return
	end)()

	return
end

return var_0_1
