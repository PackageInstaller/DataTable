local var_0_0 = class("PreviewHeroDataTemplate", TemplateHeroDataTemplate)

function var_0_0.Init(arg_1_0, arg_1_1)
	var_0_0.super.Init(arg_1_0, arg_1_1)
end

function var_0_0.GetType(arg_2_0)
	return HeroConst.HERO_DATA_TYPE.PREVIEW
end

return var_0_0
