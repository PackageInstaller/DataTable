local Guide_15 = class("Guide_15", BaseGuide)

function Guide_15:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 1501)

	local var_1_1 = MatrixData:GetMatrixPhaseData()

	if var_1_1 and var_1_1:GetPhase() == 1 then
		table.insert(var_1_0, 1502)
	end

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_2 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_2 then
			table.insert(self._steps, var_1_2)
		end
	end
end

return Guide_15
