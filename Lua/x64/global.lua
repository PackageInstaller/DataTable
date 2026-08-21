function defaultValue(arg_1_0, arg_1_1)
	return arg_1_0 == nil and arg_1_1 or arg_1_0
end

function isNil(arg_2_0)
	return arg_2_0 == nil or arg_2_0:Equals(nil)
end

function extend(arg_3_0, arg_3_1)
	if arg_3_0 then
		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			if arg_3_0[iter_3_0] == nil then
				arg_3_0[iter_3_0] = iter_3_1
			end
		end
	end

	return arg_3_0
end

function string.isNullOrEmpty(arg_4_0)
	return arg_4_0 == nil or string.len(arg_4_0) == 0
end

function delS(arg_5_0)
	if string.match(arg_5_0, "%s*(.-)%s*$") == "" then
		return false
	else
		return true
	end
end

function seq(arg_6_0)
	local var_6_0 = {}

	for iter_6_0 = 1, arg_6_0 do
		var_6_0[iter_6_0] = iter_6_0
	end

	return var_6_0
end

function swap(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0[arg_7_2], arg_7_0[arg_7_1] = arg_7_0[arg_7_1], arg_7_0[arg_7_2]
end

function randomMN(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1

	if type(arg_8_0) == "table" then
		var_8_1 = arg_8_0
	elseif type(arg_8_0) == "number" then
		var_8_1 = seq(arg_8_0)
	end

	local var_8_2 = #var_8_1

	for iter_8_0 = 1, arg_8_1 do
		local var_8_3 = math.random(var_8_2)

		var_8_0[iter_8_0] = var_8_1[var_8_3]

		swap(var_8_1, var_8_3, var_8_2)

		var_8_2 = var_8_2 - 1
	end

	return var_8_0
end

function parsedData(arg_9_0)
	local var_9_0 = string.split(arg_9_0, ";")
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		table.insert(var_9_1, string.split(iter_9_1, ","))
	end

	return var_9_1
end

function keyPairsSort(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(arg_10_0) do
		if type(iter_10_0) == "number" then
			table.insert(var_10_0, iter_10_0)
		end
	end

	table.sort(var_10_0)

	return var_10_0
end

function buildVector3(arg_11_0)
	return Vector3(arg_11_0[1], arg_11_0[2], arg_11_0[3])
end

CustomLoadingConst = {
	ASHGAME_Loading = 4,
	SkuldT0_Loading = 5,
	Oath_Loading = 6,
	BilliardGame_Day = 2,
	BilliardGame_Night = 1,
	BilliardGame_Loading = 3
}

function ShowCustomLoading(arg_12_0)
	P08Main.Loading.CustomLoadingManager.inst:ShowLoadUI(arg_12_0)
end

function CloseCustomLoading(arg_13_0)
	P08Main.Loading.CustomLoadingManager.inst:CloseLoadUI(arg_13_0)
end
