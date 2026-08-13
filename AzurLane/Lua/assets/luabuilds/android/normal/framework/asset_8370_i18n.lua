local var_0_0 = "zh-cn"

require = var_0_10001

local var_0_1 = var_0_10001("Framework/lang/" .. var_0_0)

local function var_0_2(arg_1_0)
	return var_0_1[arg_1_0] or arg_1_0
end

local var_0_3 = l10n

local function var_0_4(arg_2_0, ...)
	pg = var_1_10001

	if var_1_10001.gametip[arg_2_0] then
		stringInset = var_1_10002

		return var_1_10002(var_1.tip, ...)
	else
		i18n_not_find = var_1_10002

		return var_1_10002(arg_2_0)
	end

	return
end

local var_0_5 = i18n

local function var_0_6(arg_3_0)
	return "UndefinedLanguage:" .. arg_3_0
end

local var_0_7 = i18n_not_find

local function var_0_8(arg_4_0, ...)
	string = var_1_10001

	local var_4_0 = var_1_10001.format

	l10n = var_1_10002

	return var_4_0(var_1_10002(arg_4_0), ...)
end

local var_0_9 = i18n1

local function var_0_10(arg_5_0, ...)
	pg = var_1_10001

	if var_1_10001.gameset_language_client[arg_5_0] then
		local var_5_0 = var_1.value

		ipairs = var_1_10003

		for iter_5_0, iter_5_1 in var_1_10003({
			...
		}) do
			string = var_1_10008
			var_5_0 = var_1_10008.gsub(var_5_0, "$" .. iter_5_0, iter_5_1)
		end

		return var_5_0
	else
		return arg_5_0
	end

	return
end

local var_0_11 = i18n2

return
