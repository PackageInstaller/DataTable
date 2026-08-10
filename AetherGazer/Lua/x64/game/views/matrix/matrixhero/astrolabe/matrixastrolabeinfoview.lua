local var_0_0 = import("game.views.astrolabe.AstrolabeInfoView")
local var_0_1 = class("MatrixAstrolabeInfoView", var_0_0)

function var_0_1.RefreshUI(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 then
		local var_1_0 = HeroAstrolabeCfg[arg_1_1.id]
		local var_1_1 = string.format("<size=32><color=#FFFFFF>%s·%s\n\n</color></size>", GetI18NText(var_1_0.suit_name), GetI18NText(var_1_0.name)) .. GetI18NText(SkillTools.GetAstrolabeDescByServant(arg_1_1.id, arg_1_2))

		arg_1_0.desText_.text = GetI18NText(var_1_1)
	end
end

return var_0_1
