class = var_0_10000

local var_0_0 = "GetDormThemeListCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = 0
	local var_1_2

	if var_1_0 then
		type = var_1_10005

		if var_1_10005(var_1_0) == "table" then
			var_1_2 = var_1_0.callback

			goto label_1_0
		end
	end

	var_1_1 = var_1_0 or 0

	::label_1_0::

	pg = var_1_10005

	local var_1_3 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_3, 19018, {
		id = var_1_1
	}, 19019, function(arg_2_0)
		getProxy = var_2_10001
		DormProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)
		local var_2_2

		if var_1_1 == 0 then
			local var_2_1 = var_2_0

			var_2_2 = var_2_0.initThemes

			if not arg_2_0.theme_list then
				var_2_10004 = {}
			end

			var_2_2(var_2_1, var_2_10004)
		else
			ipairs = var_2_2

			for iter_2_0, iter_2_1 in var_2_2(arg_2_0.theme_list) do
				var_2_0:updateTheme(iter_2_1)
			end
		end

		local var_2_3 = arg_1_0
		local var_2_4 = var_2.sendNotification

		GAME = var_2_10004

		var_2_4(var_2_3, var_2_10004.GET_DORMTHEME_DONE)

		if var_1_2 then
			var_1_2()
		end

		return
	end)

	return
end

return var_0_1
