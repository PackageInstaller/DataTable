local Guide_19 = class("Guide_19", BaseGuide)

function Guide_19:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()

	if SkuldTravelData:GetSkuldStatu() == 2 then
		table.insert(var_1_0, 2801)
		table.insert(var_1_0, 2802)
		table.insert(var_1_0, 2803)
	end

	table.insert(var_1_0, 2804)
	table.insert(var_1_0, 2805)
	table.insert(var_1_0, 2806)
	table.insert(var_1_0, 2807)
	table.insert(var_1_0, 2808)
	table.insert(var_1_0, 2809)
	table.insert(var_1_0, 2810)

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_1 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_1 then
			table.insert(self._steps, var_1_1)
		end
	end
end

function Guide_19:CheckGuide()
	if not GuideTool.SatisfyCondition(self.open_condition) then
		return false
	end

	if SkuldTravelData:GetSkuldStatu() == 2 then
		return gameContext:GetOpenPageHandler("skuldTravelResultView") ~= nil
	else
		return gameContext:GetOpenPageHandler("skuldTravelView") ~= nil
	end
end

return Guide_19
