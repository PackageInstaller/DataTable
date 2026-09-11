local PolyhedronHeroDataTemplate = class("PolyhedronHeroDataTemplate", TemplateHeroDataTemplate)

function PolyhedronHeroDataTemplate:Init(arg_1_1)
	PolyhedronHeroDataTemplate.super.Init(self, arg_1_1)

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(HeroCfg[self.id].astrolabe or {}) do
		for iter_1_2, iter_1_3 in pairs(HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_1_1] or {}) do
			table.insert(var_1_0, iter_1_3)
		end
	end

	self.unlocked_astrolabe = var_1_0
end

function PolyhedronHeroDataTemplate:GetType()
	return HeroConst.HERO_DATA_TYPE.POLYHEDRON
end

return PolyhedronHeroDataTemplate
