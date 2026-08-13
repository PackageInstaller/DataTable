class = var_0_10000

local var_0_0 = var_0_10000("RawData2ThemeConvertor")

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2 then
		return arg_1_0
	else
		pg = var_1_10003

		if var_1_10003.furniture_data_template[arg_1_0] then
			BackyardThemeFurniture = var_3

			return var_3.GetUniqueId(arg_1_0, 0)
		else
			pg = var_3

			local var_1_0 = var_3.furniture_data_template[arg_1_1].count
			local var_1_1

			if arg_1_0 - arg_1_1 < var_1_0 then
				var_1_1 = arg_1_0 - arg_1_1
			elseif 0 < arg_1_0 then
				var_1_1 = arg_1_0 % 10
			end

			BackyardThemeFurniture = var_6

			return var_6.GetUniqueId(arg_1_1, var_1_1)
		end
	end

	return
end

local function var_0_2(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0.shipId then
		var_2_0 = 0
	end

	local var_2_1 = var_2_0 == 1
	local var_2_2 = {}

	ipairs = var_1_10004

	local var_2_3

	if not arg_2_0.child then
		var_2_3 = {}
	end

	for iter_2_0, iter_2_1 in var_1_10004(var_2_3) do
		tonumber = var_1_10009
		var_1_10009 = var_1_10009(iter_2_1.id)
		Vector2 = var_10
		var_2_2[var_1_10009] = var_10(iter_2_1.x, iter_2_1.y)
	end

	BackyardThemeFurniture = var_4

	local var_2_4 = var_4.New
	local var_2_5 = {}

	tonumber = var_6
	var_2_5.id = var_6(arg_2_0.id)
	Vector2 = var_6
	var_2_5.position = var_6(arg_2_0.x, arg_2_0.y)
	var_2_5.dir = arg_2_0.dir
	var_2_5.child = var_2_2
	tonumber = var_6
	var_2_5.parent = var_6(arg_2_0.parent)
	var_2_5.floor = arg_2_1
	var_2_5.isNewStyle = var_2_1

	return (var_2_4(var_2_5))
end

local function var_0_3(arg_3_0, arg_3_1, arg_3_2)
	assert = var_1_10003
	pg = var_1_10004

	var_1_10003(var_1_10004.furniture_data_template[arg_3_1], arg_3_1)

	pg = var_1_10003

	local var_3_0

	if not var_1_10003.furniture_data_template[arg_3_1] then
		var_3_0 = {}
	end

	local var_3_1

	if not var_3_0.count then
		var_3_1 = 0
	end

	if arg_3_2 then
		for iter_3_0 = 0, var_3_1 - 1 do
			BackyardThemeFurniture = var_1_10009

			if arg_3_0 == var_1_10009.GetUniqueId(arg_3_1, iter_3_0) then
				return true
			end
		end
	elseif var_3_1 > arg_3_0 - arg_3_1 then
		for iter_3_1 = 0, var_3_1 - 1 do
			if arg_3_1 + iter_3_1 == arg_3_0 then
				return true
			end
		end
	elseif arg_3_0 > 0 then
		for iter_3_2 = 0, var_3_1 - 1 do
			if arg_3_1 * 0 + iter_3_2 == arg_3_0 then
				return true
			end
		end
	end

	return false
end

local function var_0_4(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	ipairs = var_1_10005

	for iter_4_0, iter_4_1 in var_1_10005(arg_4_0) do
		if var_0_3(iter_4_1.parent, arg_4_2, iter_4_1.isNewStyle) and iter_4_1:SameChildPosition(arg_4_3, arg_4_4) and var_0_3(arg_4_1, iter_4_1.configId, iter_4_1.isNewStyle) then
			return iter_4_1
		end
	end

	return
end

local function var_0_5(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	ipairs = var_1_10005

	for iter_5_0, iter_5_1 in var_1_10005(arg_5_0) do
		if var_0_3(iter_5_1.parent, arg_5_2, iter_5_1.isNewStyle) and iter_5_1:SameChildPosition(arg_5_3, arg_5_4) and var_0_3(arg_5_1, iter_5_1.configId, true) then
			return iter_5_1
		end
	end

	return
end

function var_0_0.GenFurnitures(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.floor
	local var_6_1 = arg_6_1.mapSize
	local var_6_2 = arg_6_1.skipCheck
	local var_6_3 = {}

	ipairs = var_1_10006

	for iter_6_0, iter_6_1 in var_1_10006(arg_6_1.furniture_put_list) do
		table = var_1_10011

		var_1_10011.insert(var_6_3, var_0_2(iter_6_1, var_6_0))
	end

	ipairs = var_6

	for iter_6_2, iter_6_3 in var_6(var_6_3) do
		local var_6_4 = iter_6_3

		if iter_6_3.AnyChild(var_6_4) then
			local var_6_5 = {}

			pairs = var_6_4

			for iter_6_4, iter_6_5 in var_6_4(iter_6_3:GetChildList()) do
				if var_0_4(var_6_3, iter_6_4, iter_6_3.configId, iter_6_3:GetPosition(), iter_6_5) then
					var_6_5[var_0_1(iter_6_4, var_17.configId, var_17.isNewStyle)] = iter_6_5
				end
			end

			iter_6_3:SetChildList(var_6_5)
		end
	end

	local function var_6_6(arg_7_0)
		local var_7_0 = {}

		pairs = var_2_10002

		for iter_7_0, iter_7_1 in var_2_10002(arg_7_0:GetChildList()) do
			if var_0_5(var_6_3, iter_7_0, arg_7_0.configId, arg_7_0:GetPosition(), iter_7_1) then
				var_7:SetUniqueId(iter_7_0)

				table = var_8

				var_8.insert(var_7_0, var_7)
			end
		end

		return var_7_0
	end

	local var_6_7 = {}

	ipairs = var_8

	for iter_6_6, iter_6_7 in var_8(var_6_3) do
		if not iter_6_7:HasParent() then
			table = var_13

			var_13.insert(var_6_7, iter_6_7)
		end

		if iter_6_7:AnyChild() then
			ipairs = var_13

			for iter_6_8, iter_6_9 in var_13(var_6_6(iter_6_7)) do
				table = var_1_10018

				var_1_10018.insert(var_6_7, iter_6_9)
			end
		end
	end

	local var_6_8 = {}

	ipairs = var_9

	for iter_6_10, iter_6_11 in var_9(var_6_7) do
		if iter_6_11:HasParent() then
			var_6_8[iter_6_11.id] = true
		end
	end

	ipairs = var_9

	for iter_6_12, iter_6_13 in var_9(var_6_7) do
		if not iter_6_13:HasParent() then
			ipairs = var_14

			for iter_6_14, iter_6_15 in var_14(iter_6_13:GetAllUniqueId()) do
				if not var_6_8[iter_6_15] then
					iter_6_13:SetUniqueId(iter_6_15)

					var_6_8[iter_6_15] = true

					break
				end
			end
		end
	end

	local function var_6_9(arg_8_0, arg_8_1, arg_8_2)
		ipairs = var_2_10003

		for iter_8_0, iter_8_1 in var_2_10003(arg_8_0) do
			if iter_8_1.id == arg_8_1 then
				iter_8_1:SetParent(arg_8_2)

				break
			end
		end

		return
	end

	ipairs = var_10

	for iter_6_16, iter_6_17 in var_10(var_6_7) do
		if iter_6_17:AnyChild() then
			pairs = var_15

			for iter_6_18, iter_6_19 in var_15(iter_6_17:GetChildList()) do
				var_6_9(var_6_7, iter_6_18, iter_6_17.id)
			end
		end
	end

	local var_6_10 = {}

	ipairs = var_11

	for iter_6_20, iter_6_21 in var_11(var_6_7) do
		var_6_10[iter_6_21.id] = iter_6_21
	end

	if not var_6_2 then
		arg_6_0:CheckFurnitures(var_6_10, var_6_1)
	end

	return var_6_10
end

function var_0_0.CheckFurnitures(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}

	pairs = var_1_10004

	for iter_9_0, iter_9_1 in var_1_10004(arg_9_1) do
		CourtYardRawDataChecker = var_1_10009

		local var_9_1

		var_1_10009, var_9_1 = var_1_10009.CheckFurnitrue(iter_9_1, arg_9_1, arg_9_2)

		if not var_1_10009 then
			arg_9_0:CollectionClearIdList(var_9_0, iter_9_1, arg_9_1)
		end
	end

	if #var_9_0 > 0 then
		ipairs = var_4

		for iter_9_2, iter_9_3 in var_4(var_9_0) do
			if arg_9_1[iter_9_3] then
				arg_9_1[iter_9_3] = nil
			end
		end

		arg_9_0:CheckFurnitures(arg_9_1, arg_9_2)
	end

	return
end

function var_0_0.CollectionClearIdList(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2:AnyChild() then
		ipairs = var_4

		for iter_10_0, iter_10_1 in var_4(arg_10_2:GetChildIdList()) do
			CollectionClearIdList = var_1_10009

			var_1_10009(arg_10_1, arg_10_3[iter_10_1], arg_10_3)
		end
	end

	table = var_4

	var_4.insert(arg_10_1, arg_10_2.id)

	return
end

return var_0_0
