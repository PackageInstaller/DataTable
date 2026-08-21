local var_0_0 = class("CourtYardRawDataChecker")

function var_0_0.Check(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs(arg_1_0) do
		local var_1_0 = RawFurnitureData.New(iter_1_1)

		if not var_0_0.FillMap({}, var_1_0) then
			local var_1_2 = i18n1("Incorrect position")

			return
		end

		;({})[iter_1_1.id] = var_1_0
	end

	for iter_1_2, iter_1_3 in pairs({}) do
		local var_1_3, var_1_4 = var_0_0._CheckFurnitrue(iter_1_3, {}, arg_1_1)

		if not var_1_3 then
			local var_1_6 = i18n1("[" .. iter_1_3.name .. "] erro:" .. var_1_4 .. "-" .. iter_1_3.id)

			return
		end
	end

	return true
end

function var_0_0.FillMap(arg_2_0, arg_2_1)
	if not arg_2_1:MatOrPaper() and not arg_2_1:ExistParnet() and arg_2_1.config.belong == 1 and arg_2_1.x and arg_2_1.y then
		assert(arg_2_1.x, arg_2_1.id)

		for iter_2_0 = arg_2_1.x, arg_2_1.x + arg_2_1.sizeX - 1 do
			for iter_2_1 = arg_2_1.y, arg_2_1.y + arg_2_1.sizeY - 1 do
				arg_2_0[iter_2_0] = arg_2_0[iter_2_0] or {}

				if arg_2_0[iter_2_0][iter_2_1] then
					return false
				end

				arg_2_0[iter_2_0][iter_2_1] = true
			end
		end
	end

	return true
end

function var_0_0.CheckFurnitrue(arg_3_0, arg_3_1, arg_3_2)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		local var_3_0 = RawFurnitureData.New(iter_3_1)

		if not var_0_0.FillMap({}, var_3_0) then
			local var_3_2 = i18n1("Incorrect position")

			return
		end

		;({})[iter_3_1.id] = var_3_0
	end

	return var_0_0._CheckFurnitrue(({})[arg_3_0.id], {}, arg_3_2)
end

function var_0_0._CheckFurnitrue(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0:IsCompletion() then
		return false, "Incomplete data"
	end

	if arg_4_0:ExistParnet() and not arg_4_0:LegalParent(arg_4_1[arg_4_0.parent]) then
		return false, "Incorrect [parent -> child] relation"
	end

	local var_4_1 = arg_4_0.child or {}

	for iter_4_0, iter_4_1 in var_4_0(var_4_1) do
		if not arg_4_0:LegalChild(arg_4_1[iter_4_0]) then
			return false, "Incorrect [child -> parent] relation"
		end
	end

	if not arg_4_0:InSide(arg_4_2.x, arg_4_2.y, arg_4_2.z, arg_4_2.w) then
		return false, "out side"
	end

	return true
end

return var_0_0
