local Guide_1101 = class("Guide_1101", BaseGuide)

function Guide_1101:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()

	if MythicData:IsShowDifficultySelectView_Guide() then
		table.insert(var_1_0, 1104)
	end

	table.insert(var_1_0, 1105)

	local var_1_1 = 1

	for iter_1_0, iter_1_1 in ipairs(self._cfg.leaps) do
		if GuideTool.SatisfyCondition({
			{
				"uiName",
				iter_1_1[1]
			}
		}) then
			var_1_1 = iter_1_1[2]
		end
	end

	self._steps = {}

	for iter_1_2 = var_1_1, #var_1_0 do
		local var_1_2 = self:ProduceStep(var_1_0[iter_1_2])

		if var_1_2 then
			table.insert(self._steps, var_1_2)
		end
	end
end

return Guide_1101
