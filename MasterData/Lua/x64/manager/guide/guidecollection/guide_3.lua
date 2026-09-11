local Guide_3 = class("Guide_3", BaseGuide)

function Guide_3:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 301)
	table.insert(var_1_0, 302)

	if HeroData:GetHeroList()[1084] and self:HaveAddHeroExpMaterial() then
		table.insert(var_1_0, 304)
		table.insert(var_1_0, 305)
		table.insert(var_1_0, 306)
		table.insert(var_1_0, 307)
	end

	table.insert(var_1_0, 308)
	table.insert(var_1_0, 309)

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_1 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_1 then
			table.insert(self._steps, var_1_1)
		end
	end
end

function Guide_3:HaveAddHeroExpMaterial()
	for iter_2_0, iter_2_1 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		if ItemTools.getItemNum(iter_2_1) > 0 then
			return true
		end
	end

	return false
end

return Guide_3
