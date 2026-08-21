module("bootstrap.config.BootstrapLanguage", package.seeall)

function getTipsTextByKey(arg_1_0, arg_1_1)
	local var_1_0 = LangLauncherTips[arg_1_0]

	if not var_1_0 then
		printError("找不到key", arg_1_0)
	end

	return var_1_0[arg_1_1 or Astral.GameConstParser.Instance.gameConfigLanguageType]
end
