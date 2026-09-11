local PreviewHeroDataTemplate = class("PreviewHeroDataTemplate", TemplateHeroDataTemplate)

function PreviewHeroDataTemplate:Init(arg_1_1)
	PreviewHeroDataTemplate.super.Init(self, arg_1_1)
end

function PreviewHeroDataTemplate:GetType()
	return HeroConst.HERO_DATA_TYPE.PREVIEW
end

return PreviewHeroDataTemplate
