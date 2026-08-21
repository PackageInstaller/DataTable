local var_0_0 = class("Guide_508", BaseGuide)

function var_0_0.InitSteps(arg_1_0)
	local var_1_0 = {}

	arg_1_0:OnGuideStart()
	table.insert(var_1_0, 50801)
	table.insert(var_1_0, 50802)
	table.insert(var_1_0, 50803)

	if HeroData:GetHeroList()[1084] and arg_1_0:HaveAddHeroExpMaterial() then
		table.insert(var_1_0, 50804)
		table.insert(var_1_0, 50805)
	else
		table.insert(var_1_0, 50806)
	end

	table.insert(var_1_0, 50807)
	table.insert(var_1_0, 50808)
	table.insert(var_1_0, 50809)
	table.insert(var_1_0, 50810)
	table.insert(var_1_0, 50811)
	table.insert(var_1_0, 50812)
	table.insert(var_1_0, 50813)
	table.insert(var_1_0, 50814)
	table.insert(var_1_0, 50815)
	table.insert(var_1_0, 50816)

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
