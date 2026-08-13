class = var_0_10000

local var_0_0 = var_0_10000("CourtYardRawDataChecker")

function var_0_0.Check(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = {}

	pairs = var_1_10004

	for iter_1_0, iter_1_1 in var_1_10004(arg_1_0) do
		RawFurnitureData = var_1_10009
		var_1_10009 = var_1_10009.New(iter_1_1)

		if not var_0_0.FillMap(var_1_1, var_1_10009) then
			local var_1_2 = false

			i18n1 = var_12

			local var_1_3 = var_12("Incorrect position")

			return
		end

		var_1_0[iter_1_1.id] = var_1_10009
	end

	pairs = var_4

	for iter_1_2, iter_1_3 in var_4(var_1_0) do
		local var_1_4, var_1_5 = var_0_0._CheckFurnitrue(iter_1_3, var_1_0, arg_1_1)

		if not var_1_4 then
			local var_1_6 = var_1_4

			i18n1 = var_12

			local var_1_7 = var_12("[" .. iter_1_3.name .. "] erro:" .. var_1_5 .. "-" .. iter_1_3.id)

			return
		end
	end

	return true
end

function var_0_0.FillMap(arg_2_0, arg_2_1)
	if not arg_2_1:MatOrPaper() and not arg_2_1:ExistParnet() and arg_2_1.config.belong == 1 and arg_2_1.x and arg_2_1.y then
		assert = var_2

		var_2(arg_2_1.x, arg_2_1.id)

		for iter_2_0 = arg_2_1.x, arg_2_1.x + arg_2_1.sizeX - 1 do
			for iter_2_1 = arg_2_1.y, arg_2_1.y + arg_2_1.sizeY - 1 do
				if not arg_2_0[iter_2_0] then
					arg_2_0[iter_2_0] = {}
				end

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
	local var_3_0 = {}
	local var_3_1 = {}

	pairs = var_1_10005

	for iter_3_0, iter_3_1 in var_1_10005(arg_3_1) do
		RawFurnitureData = var_1_10010
		var_1_10010 = var_1_10010.New(iter_3_1)

		if not var_0_0.FillMap(var_3_1, var_1_10010) then
			local var_3_2 = false

			i18n1 = var_13

			local var_3_3 = var_13("Incorrect position")

			return
		end

		var_3_0[iter_3_1.id] = var_1_10010
	end

	local var_3_4 = var_3_0[arg_3_0.id]

	return var_0_0._CheckFurnitrue(var_3_4, var_3_0, arg_3_2)
end

function var_0_0._CheckFurnitrue(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2.x
	local var_4_1 = arg_4_2.y
	local var_4_2 = arg_4_2.z
	local var_4_3 = arg_4_2.w

	if not arg_4_0:IsCompletion() then
		return false, "Incomplete data"
	end

	if arg_4_0:ExistParnet() and not arg_4_0:LegalParent(arg_4_1[arg_4_0.parent]) then
		return false, "Incorrect [parent -> child] relation"
	end

	pairs = var_8

	local var_4_4

	if not arg_4_0.child then
		var_4_4 = {}
	end

	for iter_4_0, iter_4_1 in var_8(var_4_4) do
		if not arg_4_0:LegalChild(arg_4_1[iter_4_0]) then
			return false, "Incorrect [child -> parent] relation"
		end
	end

	if not arg_4_0:InSide(var_4_0, var_4_1, var_4_2, var_4_3) then
		return false, "out side"
	end

	return true
end

return var_0_0
