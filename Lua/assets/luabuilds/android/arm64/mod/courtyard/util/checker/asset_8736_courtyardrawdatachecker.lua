local CourtYardRawDataChecker = class("CourtYardRawDataChecker")

function CourtYardRawDataChecker:Check(arg_1_1)
	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in pairs(self) do
		local var_1_2 = RawFurnitureData.New(iter_1_1)

		if not CourtYardRawDataChecker.FillMap(var_1_1, var_1_2) then
			local var_1_4 = i18n1("Incorrect position")

			return
		end

		var_1_0[iter_1_1.id] = var_1_2
	end

	for iter_1_2, iter_1_3 in pairs(var_1_0) do
		local var_1_5, var_1_6 = CourtYardRawDataChecker._CheckFurnitrue(iter_1_3, var_1_0, arg_1_1)

		if not var_1_5 then
			local var_1_8 = i18n1("[" .. iter_1_3.name .. "] erro:" .. var_1_6 .. "-" .. iter_1_3.id)

			return
		end
	end

	return true
end

function CourtYardRawDataChecker:FillMap(arg_2_1)
	if not arg_2_1:MatOrPaper() and not arg_2_1:ExistParnet() and arg_2_1.config.belong == 1 and arg_2_1.x and arg_2_1.y then
		assert(arg_2_1.x, arg_2_1.id)

		for iter_2_0 = arg_2_1.x, arg_2_1.x + arg_2_1.sizeX - 1 do
			for iter_2_1 = arg_2_1.y, arg_2_1.y + arg_2_1.sizeY - 1 do
				self[iter_2_0] = self[iter_2_0] or {}

				if self[iter_2_0][iter_2_1] then
					return false
				end

				self[iter_2_0][iter_2_1] = true
			end
		end
	end

	return true
end

function CourtYardRawDataChecker:CheckFurnitrue(arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		local var_3_2 = RawFurnitureData.New(iter_3_1)

		if not CourtYardRawDataChecker.FillMap(var_3_1, var_3_2) then
			local var_3_4 = i18n1("Incorrect position")

			return
		end

		var_3_0[iter_3_1.id] = var_3_2
	end

	return CourtYardRawDataChecker._CheckFurnitrue(var_3_0[self.id], var_3_0, arg_3_2)
end

function CourtYardRawDataChecker:_CheckFurnitrue(arg_4_1, arg_4_2)
	if not self:IsCompletion() then
		return false, "Incomplete data"
	end

	if self:ExistParnet() and not self:LegalParent(arg_4_1[self.parent]) then
		return false, "Incorrect [parent -> child] relation"
	end

	for iter_4_0, iter_4_1 in pairs(self.child or {}) do
		if not self:LegalChild(arg_4_1[iter_4_0]) then
			return false, "Incorrect [child -> parent] relation"
		end
	end

	if not self:InSide(arg_4_2.x, arg_4_2.y, arg_4_2.z, arg_4_2.w) then
		return false, "out side"
	end

	return true
end

return CourtYardRawDataChecker
