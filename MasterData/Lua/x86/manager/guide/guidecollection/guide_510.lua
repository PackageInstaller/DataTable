local Guide_510 = class("Guide_510", BaseGuide)

function Guide_510:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 51001)
	table.insert(var_1_0, 51002)
	table.insert(var_1_0, 51003)

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_1 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_1 then
			table.insert(self._steps, var_1_1)
		end
	end
end

function Guide_510:CheckGuide()
	return GuideTool.SatisfyCondition(self.open_condition) and ActivityData:GetActivityIsOpen(240034) and not DrawData:GetNewbieChooseDrawFlag()
end

return Guide_510
