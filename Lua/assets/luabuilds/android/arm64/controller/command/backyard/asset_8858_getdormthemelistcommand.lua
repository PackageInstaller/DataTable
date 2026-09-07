local GetDormThemeListCommand = class("GetDormThemeListCommand", pm.SimpleCommand)

function GetDormThemeListCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = 0
	local var_1_2

	if var_1_0 and type(var_1_0) == "table" then
		var_1_2 = var_1_0.callback
	else
		var_1_1 = var_1_0 or 0
	end

	pg.ConnectionMgr.GetInstance():Send(19018, {
		id = var_1_1
	}, 19019, function(arg_2_0)
		local var_2_0 = getProxy(DormProxy)

		if var_1_1 == 0 then
			var_2_0:initThemes(arg_2_0.theme_list or {})
		else
			for iter_2_0, iter_2_1 in ipairs(arg_2_0.theme_list) do
				var_2_0:updateTheme(iter_2_1)
			end
		end

		self:sendNotification(GAME.GET_DORMTHEME_DONE)

		if var_1_2 then
			var_1_2()
		end

		return
	end)

	return
end

return GetDormThemeListCommand
