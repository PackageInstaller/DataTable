local Guide_14 = class("Guide_14", BaseGuide)

function Guide_14:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 1401)
	table.insert(var_1_0, 1402)
	table.insert(var_1_0, 1403)

	local var_1_1 = MatrixData:GetUnlockBeaconList()

	if var_1_1 and #var_1_1 == 0 then
		table.insert(var_1_0, 1404)
		table.insert(var_1_0, 1405)
		table.insert(var_1_0, 1406)
		table.insert(var_1_0, 1407)
	end

	table.insert(var_1_0, 1408)
	table.insert(var_1_0, 1409)
	table.insert(var_1_0, 1410)
	table.insert(var_1_0, 1411)
	table.insert(var_1_0, 1412)
	table.insert(var_1_0, 1413)
	table.insert(var_1_0, 1414)
	table.insert(var_1_0, 1415)

	local var_1_2 = 1

	for iter_1_0, iter_1_1 in ipairs(self._cfg.leaps) do
		if GuideTool.SatisfyCondition({
			{
				"uiName",
				iter_1_1[1]
			}
		}) then
			var_1_2 = iter_1_1[2]
		end
	end

	self._steps = {}

	for iter_1_2 = var_1_2, #var_1_0 do
		local var_1_3 = self:ProduceStep(var_1_0[iter_1_2])

		if var_1_3 then
			table.insert(self._steps, var_1_3)
		end
	end
end

return Guide_14
