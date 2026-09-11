local Guide_4601 = class("Guide_4601", BaseGuide)

function Guide_4601:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()

	local var_1_1 = PolyhedronData:GetUnlockBeaconList()

	if var_1_1 and #var_1_1 == 0 then
		table.insert(var_1_0, 4605)
		table.insert(var_1_0, 4606)
		table.insert(var_1_0, 4607)
		table.insert(var_1_0, 4608)
	end

	table.insert(var_1_0, 4609)
	table.insert(var_1_0, 4610)
	table.insert(var_1_0, 4611)
	table.insert(var_1_0, 4612)

	local var_1_2 = PolyhedronData:GetUnlockHeroList()

	if var_1_2 and #var_1_2 <= 1 then
		table.insert(var_1_0, 4613)
		table.insert(var_1_0, 4614)
		table.insert(var_1_0, 4615)
		table.insert(var_1_0, 4616)
		table.insert(var_1_0, 4617)
	end

	table.insert(var_1_0, 4618)
	table.insert(var_1_0, 4619)
	table.insert(var_1_0, 4620)
	table.insert(var_1_0, 4621)

	local var_1_3 = 1

	for iter_1_0, iter_1_1 in ipairs(self._cfg.leaps) do
		if GuideTool.SatisfyCondition({
			{
				"uiName",
				iter_1_1[1]
			}
		}) then
			var_1_3 = iter_1_1[2]
		end
	end

	self._steps = {}

	for iter_1_2 = var_1_3, #var_1_0 do
		local var_1_4 = self:ProduceStep(var_1_0[iter_1_2])

		if var_1_4 then
			table.insert(self._steps, var_1_4)
		end
	end
end

return Guide_4601
