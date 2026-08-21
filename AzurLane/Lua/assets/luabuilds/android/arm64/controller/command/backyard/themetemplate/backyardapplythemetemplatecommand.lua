local var_0_0 = class("BackYardApplyThemeTemplateCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(DormProxy)
	local var_1_4 = 1
	local var_1_5 = var_0_0.GetAllFloorFurnitures()
	local var_1_6 = var_1_0.template:IsOccupyed(var_1_5, 1)
	local var_1_7 = {}

	if var_1_6 then
		var_1_7 = var_1_0.template:GetUsableFurnituresForFloor(var_1_5, var_1_4)
	else
		for iter_1_0, iter_1_1 in pairs((var_1_0.template:GetAllFurniture())) do
			table.insert(var_1_7, iter_1_1)
		end
	end

	var_0_0.WarpList(var_1_7)
	var_1_3(var_1_7, var_1_4)

	if var_1_1 then
		var_1_1(not var_1_6, var_1_7)
	end

	return
end

function var_0_0.GetAllFloorFurnitures()
	(function(arg_5_0, arg_5_1)
		local var_5_0 = getProxy(DormProxy):getRawData():GetTheme(arg_5_0)
		local var_5_1 = {}

		if var_5_0 then
			var_5_1 = var_5_0:GetAllFurniture()
		end

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			arg_5_1[iter_5_1.id] = iter_5_1
		end

		return
	end)(1, {})
	;(function(arg_5_0, arg_5_1)
		local var_5_0 = getProxy(DormProxy):getRawData():GetTheme(arg_5_0)
		local var_5_1 = {}

		if var_5_0 then
			var_5_1 = var_5_0:GetAllFurniture()
		end

		for iter_5_0, iter_5_1 in pairs(var_5_1) do
			arg_5_1[iter_5_1.id] = iter_5_1
		end

		return
	end)(2, {})

	return {}
end

function var_0_0.WarpList(arg_6_0)
	local var_6_0 = getProxy(DormProxy):getRawData()
	local var_6_1 = var_6_0:GetMapSize()
	local var_6_2 = var_6_1.x
	local var_6_3 = var_6_1.y
	local var_6_7 = var_6_0:GetPurchasedFurnitures()

	for iter_6_0 = #arg_6_0, 1, -1 do
		if not arg_6_0[iter_6_0].position or not var_6_7[arg_6_0[iter_6_0].configId] or (function(arg_7_0)
			assert(arg_7_0.position, arg_7_0.id)

			return not arg_7_0:isPaper() and (arg_7_0.position.x < var_6_2 or arg_7_0.position.y < var_6_3)
		end)(arg_6_0[iter_6_0]) then
			table.remove(arg_6_0, iter_6_0)
		end
	end

	table.sort(arg_6_0, function(arg_8_0, arg_8_1)
		if #arg_8_0.child == #arg_8_1.child then
			return arg_8_0.parent > arg_8_1.parent
		else
			return #arg_8_0.child > #arg_8_1.child
		end

		return
	end)

	for iter_6_1, iter_6_2 in ipairs(arg_6_0) do
		({})[iter_6_2.id] = iter_6_2
	end

	local var_6_8 = var_6_0:GetMapSize()

	for iter_6_3, iter_6_4 in ipairs(arg_6_0) do
		local var_6_9, var_6_10 = CourtYardRawDataChecker.CheckFurnitrue(iter_6_4, {}, var_6_8)

		if not var_6_9 and not table.contains({}, iter_6_4.id) then
			local var_6_11 = iter_6_4.child or {}

			for iter_6_5, iter_6_6 in pairs(var_6_11) do
				table.insert({}, iter_6_5)
			end

			if iter_6_4.parent ~= 0 then
				if not ({})[iter_6_4.parent] then
					({})[iter_6_4.parent] = {}
				end

				table.insert(({})[iter_6_4.parent], iter_6_4.id)
			end

			table.insert({}, iter_6_4.id)
		end
	end

	for iter_6_7 = #arg_6_0, 1, -1 do
		if table.contains({}, arg_6_0[iter_6_7].id) then
			table.remove(arg_6_0, iter_6_7)
		else
			local var_6_12 = ({})[arg_6_0[iter_6_7].id]

			if ({})[arg_6_0[iter_6_7].id] then
				local var_6_13 = arg_6_0[iter_6_7].child or {}

				for iter_6_8, iter_6_9 in pairs(var_6_13) do
					if table.contains(var_6_12, iter_6_8) then
						arg_6_0[iter_6_7].child[iter_6_8] = nil
					end
				end
			end
		end
	end

	GetCanBePutFurnituresForThemeCommand.SortListForPut(arg_6_0)

	return
end

return var_0_0
