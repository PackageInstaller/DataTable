local MatrixAstrolabeInfoView = class("MatrixAstrolabeInfoView", (import("game.views.astrolabe.AstrolabeInfoView")))

function MatrixAstrolabeInfoView:RefreshUI(arg_1_1, arg_1_2)
	if arg_1_1 then
		self.desText_.text = GetI18NText(string.format("<size=32><color=#FFFFFF>%s·%s\n\n</color></size>", GetI18NText(HeroAstrolabeCfg[arg_1_1.id].suit_name), GetI18NText(HeroAstrolabeCfg[arg_1_1.id].name)) .. GetI18NText(SkillTools.GetAstrolabeDescByServant(arg_1_1.id, arg_1_2)))
	end
end

return MatrixAstrolabeInfoView
