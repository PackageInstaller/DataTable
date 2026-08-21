local var_0_0 = class("Guide_3", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()
	table.insert(var_1_0, 301)
	table.insert(var_1_0, 302)

	if HeroData:GetHeroList()[1084] and arg_1_0:HaveAddHeroExpMaterial() then
		table.insert(var_1_0, 304)
		table.insert(var_1_0, 305)
		table.insert(var_1_0, 306)
		table.insert(var_1_0, 307)
	end

	table.insert(var_1_0, 308)
	table.insert(var_1_0, 309)

	arg_1_0._steps = {}

	local var_1_1 = #var_1_0

	for iter_1_0 = 1, var_1_1 do
		local var_1_2 = var_1_0[iter_1_0]
		local var_1_3 = arg_1_0:ProduceStep(var_1_2)

		if var_1_3 then
			table.insert(arg_1_0._steps, var_1_3)
		end
	end
end

function var_0_0.HaveAddHeroExpMaterial(arg_2_0)
	for iter_2_0, iter_2_1 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		if ItemTools.getItemNum(iter_2_1) > 0 then
			return true
		end
	end

	return false
end

return var_0_0
