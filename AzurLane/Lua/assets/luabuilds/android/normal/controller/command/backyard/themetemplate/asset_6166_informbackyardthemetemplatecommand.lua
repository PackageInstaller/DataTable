class = var_0_10000

local var_0_0 = "InformBackYardThemeTemplateCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().playerName

	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if var_4.getRawData(var_1_1).level < 20 then
		pg = var_5

		local var_1_2 = var_5.TipsMgr.GetInstance()
		local var_1_3 = var_5.ShowTips

		i18n = var_1_10007

		var_1_3(var_1_2, var_1_10007("inform_level_limit"))

		return
	end

	local var_1_4 = var_2.uid
	local var_1_5 = var_2.tid
	local var_1_6 = 0

	ipairs = var_1_10008

	for iter_1_0, iter_1_1 in var_1_10008(var_2.content) do
		var_1_6 = iter_1_1 + var_1_6
	end

	getProxy = var_8
	DormProxy = var_9

	local var_1_7 = var_8(var_9)
	local var_1_8

	if not var_8.GetShopThemeTemplateById(var_1_7, var_1_5) then
		var_1_8 = var_8:GetCollectionThemeTemplateById(var_1_5)
	end

	if not var_1_8 or not var_1_8.name then
		return
	end

	pg = var_1_7

	local var_1_9 = var_1_7.ConnectionMgr.GetInstance()

	var_10.Send(var_1_9, 19129, {
		target_id = var_1_4,
		target_name = var_1_0,
		theme_id = var_1_5,
		theme_name = var_1_8.name,
		reason = var_1_6
	}, 19130, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			ChatProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			table = var_2_10002

			var_2_10002.insert(var_2_0.informs, var_1_4 .. var_1_5)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.INFORM_THEME_TEMPLATE_DONE)

			pg = var_2_1
			var_2_10003 = var_2_1.TipsMgr.GetInstance()

			local var_2_2 = var_2.ShowTips

			i18n = var_4

			var_2_2(var_2_10003, var_4("inform_sueecss"))
		else
			pg = var_2_0

			local var_2_3 = var_2_0.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_4(var_2_3, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
