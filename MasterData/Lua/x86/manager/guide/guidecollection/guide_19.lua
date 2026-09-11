local Guide_19 = class("Guide_19", BaseGuide)

function Guide_19:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()
	table.insert(var_1_0, 1901)
	table.insert(var_1_0, 1902)
	table.insert(var_1_0, 1903)
	table.insert(var_1_0, 1924)
	table.insert(var_1_0, 1925)
	table.insert(var_1_0, 1930)
	table.insert(var_1_0, 1905)

	if not table.keyof(ChipData:GetUnlockChipManagerIDList(), 6) then
		table.insert(var_1_0, 1906)
		table.insert(var_1_0, 1926)
		table.insert(var_1_0, 1927)
	end

	table.insert(var_1_0, 1907)
	table.insert(var_1_0, 1908)
	table.insert(var_1_0, 1909)

	if not table.keyof(ChipData:GetUnlockChipIDList(), 105) then
		table.insert(var_1_0, 1910)
	end

	table.insert(var_1_0, 1911)
	table.insert(var_1_0, 1912)
	table.insert(var_1_0, 1913)
	table.insert(var_1_0, 1914)
	table.insert(var_1_0, 1915)
	table.insert(var_1_0, 1916)

	local var_1_1 = ChipData:GetChipManagerList()

	if not var_1_1 or not var_1_1[6] or not table.indexof(var_1_1[6], 105) then
		table.insert(var_1_0, 1917)
		table.insert(var_1_0, 1918)
		table.insert(var_1_0, 1919)
		table.insert(var_1_0, 1928)
		table.insert(var_1_0, 1920)
		table.insert(var_1_0, 1921)
		table.insert(var_1_0, 1922)
		table.insert(var_1_0, 1929)
	end

	table.insert(var_1_0, 1923)

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_2 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_2 then
			table.insert(self._steps, var_1_2)
		end
	end
end

return Guide_19
