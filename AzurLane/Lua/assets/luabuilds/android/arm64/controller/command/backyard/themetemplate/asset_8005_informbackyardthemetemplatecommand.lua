class = var_0_10000

local var_0_0 = "InformBackYardThemeTemplateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).playerName

	getProxy = var_1_0
	PlayerProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)

	if var_4.getRawData(var_1_2).level < 20 then
		pg = var_5

		local var_1_3 = var_5.TipsMgr.GetInstance()
		local var_1_4 = var_5.ShowTips

		i18n = var_1_10008

		var_1_4(var_1_3, var_1_10008("inform_level_limit"))

		return
	end

	local var_1_5 = var_2.uid
	local var_1_6 = var_2.tid
	local var_1_7 = 0

	ipairs = var_1_10008

	for iter_1_0, iter_1_1 in var_1_10008(var_2.content) do
		var_1_7 = iter_1_1 + var_1_7
	end

	getProxy = var_8
	DormProxy = var_10

	local var_1_8 = var_8(var_10)
	local var_1_9

	if not var_8.GetShopThemeTemplateById(var_1_8, var_1_6) then
		var_1_9 = var_8:GetCollectionThemeTemplateById(var_1_6)
	end

	if not var_1_9 or not var_1_9.name then
		return
	end

	pg = var_10

	local var_1_10 = var_10.ConnectionMgr.GetInstance()

	var_10.Send(var_1_10, 19129, {
		target_id = var_1_5,
		target_name = var_1_1,
		theme_id = var_1_6,
		theme_name = var_1_9.name,
		reason = var_1_7
	}, 19130, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			ChatProxy = var_2_10003
			var_2_0 = var_2_0(var_2_10003)
			table = var_2_10002

			var_2_10002.insert(var_2_0.informs, var_1_5 .. var_1_6)

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_5

			var_2_1(var_2_10004, var_5.INFORM_THEME_TEMPLATE_DONE)

			pg = var_2_1
			var_2_10004 = var_2_1.TipsMgr.GetInstance()

			local var_2_2 = var_2.ShowTips

			i18n = var_5

			var_2_2(var_2_10004, var_5("inform_sueecss"))
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_4(var_2_3, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
