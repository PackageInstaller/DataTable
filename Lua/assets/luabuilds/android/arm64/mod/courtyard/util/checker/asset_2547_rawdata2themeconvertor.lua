local RawData2ThemeConvertor = class("RawData2ThemeConvertor")

local function var_0_1(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2 then
		return arg_1_0
	elseif pg.furniture_data_template[arg_1_0] then
		return BackyardThemeFurniture.GetUniqueId(arg_1_0, 0)
	else
		local var_1_0

		if pg.furniture_data_template[arg_1_1].count > arg_1_0 - arg_1_1 then
			var_1_0 = arg_1_0 - arg_1_1
		elseif arg_1_0 > 0 then
			var_1_0 = arg_1_0 % 10
		end

		return BackyardThemeFurniture.GetUniqueId(arg_1_1, var_1_0)
	end

	return
end

local function var_0_2(arg_2_0, arg_2_1)
	local var_2_1 = (arg_2_0.shipId or 0) == 1
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.child or {}) do
		var_2_2[tonumber(iter_2_1.id)] = Vector2(iter_2_1.x, iter_2_1.y)
	end

	return (BackyardThemeFurniture.New({
		id = tonumber(arg_2_0.id),
		position = Vector2(arg_2_0.x, arg_2_0.y),
		dir = arg_2_0.dir,
		child = var_2_2,
		parent = tonumber(arg_2_0.parent),
		floor = arg_2_1,
		isNewStyle = var_2_1
	}))
end

local function var_0_3(arg_3_0, arg_3_1, arg_3_2)
	assert(pg.furniture_data_template[arg_3_1], arg_3_1)

	local var_3_0 = (pg.furniture_data_template[arg_3_1] or {}).count

	if not (pg.furniture_data_template[arg_3_1] or {}).count then
		var_3_0 = 0
	end

	if arg_3_2 then
		for iter_3_0 = 0, var_3_0 - 1 do
			if arg_3_0 == BackyardThemeFurniture.GetUniqueId(arg_3_1, iter_3_0) then
				return true
			end
		end
	elseif var_3_0 > arg_3_0 - arg_3_1 then
		for iter_3_1 = 0, var_3_0 - 1 do
			if arg_3_1 + iter_3_1 == arg_3_0 then
				return true
			end
		end
	elseif arg_3_0 > 0 then
		for iter_3_2 = 0, var_3_0 - 1 do
			if arg_3_1 * 0 + iter_3_2 == arg_3_0 then
				return true
			end
		end
	end

	return false
end

local function var_0_4(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		if var_0_3(iter_4_1.parent, arg_4_2, iter_4_1.isNewStyle) and iter_4_1:SameChildPosition(arg_4_3, arg_4_4) and var_0_3(arg_4_1, iter_4_1.configId, iter_4_1.isNewStyle) then
			return iter_4_1
		end
	end

	return
end

local function var_0_5(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		if var_0_3(iter_5_1.parent, arg_5_2, iter_5_1.isNewStyle) and iter_5_1:SameChildPosition(arg_5_3, arg_5_4) and var_0_3(arg_5_1, iter_5_1.configId, true) then
			return iter_5_1
		end
	end

	return
end

function RawData2ThemeConvertor:GenFurnitures(arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.furniture_put_list) do
		table.insert(var_6_0, var_0_2(iter_6_1, arg_6_1.floor))
	end

	for iter_6_2, iter_6_3 in ipairs(var_6_0) do
		if iter_6_3:AnyChild() then
			local var_6_1 = {}

			for iter_6_4, iter_6_5 in pairs(iter_6_3:GetChildList()) do
				local var_6_2 = var_0_4(var_6_0, iter_6_4, iter_6_3.configId, iter_6_3:GetPosition(), iter_6_5)

				if var_6_2 then
					var_6_1[var_0_1(iter_6_4, var_6_2.configId, var_6_2.isNewStyle)] = iter_6_5
				end
			end

			iter_6_3:SetChildList(var_6_1)
		end
	end

	local function var_6_3(arg_7_0)
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(arg_7_0:GetChildList()) do
			local var_7_1 = var_0_5(var_6_0, iter_7_0, arg_7_0.configId, arg_7_0:GetPosition(), iter_7_1)

			if var_7_1 then
				var_7_1:SetUniqueId(iter_7_0)
				table.insert(var_7_0, var_7_1)
			end
		end

		return var_7_0
	end

	local var_6_4 = {}

	for iter_6_6, iter_6_7 in ipairs(var_6_0) do
		if not iter_6_7:HasParent() then
			table.insert(var_6_4, iter_6_7)
		end

		if iter_6_7:AnyChild() then
			for iter_6_8, iter_6_9 in ipairs(var_6_3(iter_6_7)) do
				table.insert(var_6_4, iter_6_9)
			end
		end
	end

	local var_6_5 = {}

	for iter_6_10, iter_6_11 in ipairs(var_6_4) do
		if iter_6_11:HasParent() then
			var_6_5[iter_6_11.id] = true
		end
	end

	for iter_6_12, iter_6_13 in ipairs(var_6_4) do
		if not iter_6_13:HasParent() then
			for iter_6_14, iter_6_15 in ipairs(iter_6_13:GetAllUniqueId()) do
				if not var_6_5[iter_6_15] then
					iter_6_13:SetUniqueId(iter_6_15)

					var_6_5[iter_6_15] = true

					break
				end
			end
		end
	end

	local function var_6_6(arg_8_0, arg_8_1, arg_8_2)
		for iter_8_0, iter_8_1 in ipairs(arg_8_0) do
			if iter_8_1.id == arg_8_1 then
				iter_8_1:SetParent(arg_8_2)

				break
			end
		end

		return
	end

	for iter_6_16, iter_6_17 in ipairs(var_6_4) do
		if iter_6_17:AnyChild() then
			for iter_6_18, iter_6_19 in pairs(iter_6_17:GetChildList()) do
				var_6_6(var_6_4, iter_6_18, iter_6_17.id)
			end
		end
	end

	local var_6_7 = {}

	for iter_6_20, iter_6_21 in ipairs(var_6_4) do
		var_6_7[iter_6_21.id] = iter_6_21
	end

	if not arg_6_1.skipCheck then
		self:CheckFurnitures(var_6_7, arg_6_1.mapSize)
	end

	return var_6_7
end

function RawData2ThemeConvertor:CheckFurnitures(arg_9_1, arg_9_2)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		local var_9_1, var_9_2 = CourtYardRawDataChecker.CheckFurnitrue(iter_9_1, arg_9_1, arg_9_2)

		if not var_9_1 then
			self:CollectionClearIdList(var_9_0, iter_9_1, arg_9_1)
		end
	end

	if #var_9_0 > 0 then
		for iter_9_2, iter_9_3 in ipairs(var_9_0) do
			if arg_9_1[iter_9_3] then
				arg_9_1[iter_9_3] = nil
			end
		end

		self:CheckFurnitures(arg_9_1, arg_9_2)
	end

	return
end

function RawData2ThemeConvertor:CollectionClearIdList(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2:AnyChild() then
		for iter_10_0, iter_10_1 in ipairs(arg_10_2:GetChildIdList()) do
			CollectionClearIdList(arg_10_1, arg_10_3[iter_10_1], arg_10_3)
		end
	end

	table.insert(arg_10_1, arg_10_2.id)

	return
end

return RawData2ThemeConvertor
