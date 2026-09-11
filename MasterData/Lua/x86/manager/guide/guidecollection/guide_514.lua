local Guide_514 = class("Guide_514", BaseGuide)

function Guide_514:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 51401)
	table.insert(var_1_0, 51402)
	table.insert(var_1_0, 51403)
	table.insert(var_1_0, 51404)
	table.insert(var_1_0, 51405)
	table.insert(var_1_0, 51406)
	table.insert(var_1_0, 51407)

	if not table.keyof(ChipData:GetUnlockChipManagerIDList(), 6) then
		table.insert(var_1_0, 51408)
		table.insert(var_1_0, 51409)
		table.insert(var_1_0, 51410)
	end

	table.insert(var_1_0, 51411)
	table.insert(var_1_0, 51412)
	table.insert(var_1_0, 51413)

	if not table.keyof(ChipData:GetUnlockChipIDList(), 105) then
		table.insert(var_1_0, 51414)
	end

	table.insert(var_1_0, 51415)
	table.insert(var_1_0, 51416)
	table.insert(var_1_0, 51417)
	table.insert(var_1_0, 51418)
	table.insert(var_1_0, 51419)

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_1 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_1 then
			table.insert(self._steps, var_1_1)
		end
	end
end

return Guide_514
