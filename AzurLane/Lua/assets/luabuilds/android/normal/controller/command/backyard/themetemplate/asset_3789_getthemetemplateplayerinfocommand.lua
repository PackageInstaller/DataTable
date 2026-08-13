class = var_0_10000

local var_0_0 = "GetThemeTemplatePlayerInfoCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.templateId
	local var_1_2 = var_2.userId
	local var_1_3 = var_2.callback

	getProxy = var_1_10007
	DormProxy = var_1_10008

	local var_1_4 = var_1_10007(var_1_10008)

	BackYardConst = var_1_10008

	if var_1_0 ~= var_1_10008.THEME_TEMPLATE_TYPE_SHOP then
		BackYardConst = var_1_5

		local var_1_5

		if var_1_0 == var_1_5.THEME_TEMPLATE_TYPE_COLLECTION then
			function var_1_5(arg_2_0)
				CourtYardThemeOwner = var_2_10001

				local var_2_0 = var_2_10001.New(arg_2_0.player)
				local var_2_1 = var_1_4

				if var_2.GetShopThemeTemplateById(var_2_1, var_1_1) then
					var_2:SetPlayerInfo(var_2_0)

					local var_2_2 = var_1_4

					var_3.UpdateShopThemeTemplate(var_2_2, var_2)
				end

				local var_2_3 = var_1_4

				if var_3.GetCollectionThemeTemplateById(var_2_3, var_1_1) then
					var_3:SetPlayerInfo(var_2_0)

					local var_2_4 = var_1_4

					var_4.UpdateCollectionThemeTemplate(var_2_4, var_3)
				end

				if var_1_3 then
					var_1_3(var_2_0)
				end

				return
			end

			pg = var_1_10009

			local var_1_6 = var_1_10009.ConnectionMgr.GetInstance()

			var_1_10009.Send(var_1_6, 50113, {
				user_id = var_1_2
			}, 50114, function(arg_3_0)
				if arg_3_0.result == 0 then
					var_1_5(arg_3_0)
				else
					pg = var_1

					local var_3_0 = var_1.TipsMgr.GetInstance()
					local var_3_1 = var_1.ShowTips

					ERROR_MESSAGE = var_2_10003

					var_3_1(var_3_0, var_2_10003[arg_3_0.result] .. arg_3_0.result)
				end

				return
			end)
		else
			BackYardConst = var_1_5

			if var_1_0 == var_1_5.THEME_TEMPLATE_TYPE_CUSTOM then
				getProxy = var_8
				PlayerProxy = var_1_10009

				local var_1_7 = var_8(var_1_10009)
				local var_1_8 = var_8.getData(var_1_7)

				if var_1_4:GetCustomThemeTemplateById(var_1_1) then
					var_9:SetPlayerInfo(var_1_8)
					var_1_4:UpdateCustomThemeTemplate(var_9)
				end

				if var_1_3 then
					var_1_3(var_1_8)
				end
			end
		end

		return
	end
end

return var_0_1
