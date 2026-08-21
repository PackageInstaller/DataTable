module("framework.language.LanguageMgrBase", package.seeall)

local var_0_0 = class("LanguageMgrBase")

function var_0_0.ctor(arg_1_0)
	arg_1_0._dict = {}
	arg_1_0._curLangType = "zh"
end

function var_0_0.getNames(arg_2_0)
	return nil
end

function var_0_0.init(arg_3_0)
	arg_3_0._curLangType = Astral.GameConstParser.Instance.gameConfigLanguageType

	local var_3_0 = arg_3_0:getNames()

	if var_3_0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			ConfigMgr.instance:requestConfig(iter_3_1, arg_3_0)
		end
	end
end

function var_0_0.handleConfig(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._dict[arg_4_1] = arg_4_2
end

function var_0_0.getLanguageType(arg_5_0)
	return arg_5_0._curLangType
end

function var_0_0.isLanguageType(arg_6_0, arg_6_1)
	return arg_6_0._curLangType == arg_6_1
end

function var_0_0.getLanguageText(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0
	local var_7_1

	arg_7_2 = arg_7_2 or arg_7_0._curLangType

	for iter_7_0, iter_7_1 in pairs(arg_7_0._dict) do
		local var_7_2 = iter_7_1[arg_7_1]

		if var_7_2 then
			var_7_0 = var_7_2[arg_7_2]

			break
		end
	end

	return var_7_0
end

function var_0_0.langOrNil(arg_8_0, arg_8_1)
	return arg_8_0:getLanguageText(arg_8_1)
end

function var_0_0.lang(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:getLanguageText(arg_9_1, arg_9_2) or arg_9_1
end

return var_0_0
