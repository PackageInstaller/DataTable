local var_0_0 = require("Framework/lang/" .. "zh-cn")

function l10n(arg_1_0)
	return var_0_0[arg_1_0] or arg_1_0
end

function i18n(arg_2_0, ...)
	if pg.gametip[arg_2_0] then
		return stringInset(pg.gametip[arg_2_0].tip, ...)
	else
		return i18n_not_find(arg_2_0)
	end

	return
end

function i18n_not_find(arg_3_0)
	return "UndefinedLanguage:" .. arg_3_0
end

function i18n1(arg_4_0, ...)
	return string.format(l10n(arg_4_0), ...)
end

function i18n2(arg_5_0, ...)
	if pg.gameset_language_client[arg_5_0] then
		local var_5_0 = pg.gameset_language_client[arg_5_0].value

		for iter_5_0, iter_5_1 in ipairs({
			...
		}) do
			var_5_0 = string.gsub(var_5_0, "$" .. iter_5_0, iter_5_1)
		end

		return var_5_0
	else
		return arg_5_0
	end

	return
end

return
