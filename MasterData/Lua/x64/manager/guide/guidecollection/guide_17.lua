local Guide_17 = class("Guide_17", BaseGuide)

function Guide_17:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 1702)
	table.insert(var_1_0, 1704)

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_1 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_1 then
			table.insert(self._steps, var_1_1)
		end
	end
end

function Guide_17:CheckGuide()
	return GuideTool.SatisfyCondition(self.open_condition) and ActivityData:GetActivityIsOpen(240034) and not DrawData:GetNewbieChooseDrawFlag()
end

return Guide_17
