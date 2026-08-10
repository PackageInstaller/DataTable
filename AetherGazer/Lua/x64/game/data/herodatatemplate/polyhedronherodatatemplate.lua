local var_0_0 = class("PolyhedronHeroDataTemplate", TemplateHeroDataTemplate)

function var_0_0.Init(arg_1_0, arg_1_1)
	var_0_0.super.Init(arg_1_0, arg_1_1)

	local var_1_0 = HeroCfg[arg_1_0.id]
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0.astrolabe or {}) do
		local var_1_2 = HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[iter_1_1] or {}

		for iter_1_2, iter_1_3 in pairs(var_1_2) do
			table.insert(var_1_1, iter_1_3)
		end
	end

	arg_1_0.unlocked_astrolabe = var_1_1
end

function var_0_0.GetType(arg_2_0)
	return HeroConst.HERO_DATA_TYPE.POLYHEDRON
end

return var_0_0
