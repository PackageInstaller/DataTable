local BackYardApplyThemeTemplateCommand = class("BackYardApplyThemeTemplateCommand", pm.SimpleCommand)

function BackYardApplyThemeTemplateCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.callback
	local var_1_2 = getProxy(DormProxy)

	local function var_1_3(arg_2_0, arg_2_1)
		if #arg_2_0 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_theme_template_list_is_empty"))

			return
		end

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
			var_2_0[iter_2_1.id] = iter_2_1
		end

		local var_2_1 = {}

		for iter_2_2, iter_2_3 in pairs(var_2_0) do
			var_2_1[iter_2_3.id] = iter_2_3:ToSaveData()
		end

		pg.m02:sendNotification(GAME.PUT_FURNITURE, {
			furnsPos = var_2_1,
			floor = arg_2_1,
			callback = function(arg_3_0, arg_3_1)
				if arg_3_0 then
					self:sendNotification(GAME.BACKYARD_APPLY_THEME_TEMPLATE_DONE)
				else
					pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_apply_theme_template_erro"))
					print(arg_3_1)
				end

				return
			end
		})

		return
	end

	local var_1_4 = 1
	local var_1_5 = BackYardApplyThemeTemplateCommand.GetAllFloorFurnitures()
	local var_1_6 = var_1_0.template:IsOccupyed(var_1_5, 1)
	local var_1_7 = {}

	if var_1_6 then
		var_1_7 = var_1_0.template:GetUsableFurnituresForFloor(var_1_5, var_1_4)
	else
		for iter_1_0, iter_1_1 in pairs((var_1_0.template:GetAllFurniture())) do
			table.insert(var_1_7, iter_1_1)
		end
	end

	BackYardApplyThemeTemplateCommand.WarpList(var_1_7)
	var_1_3(var_1_7, var_1_4)

	if var_1_1 then
		var_1_0.callback(not var_1_6, var_1_7)
	end

	return
end

function BackYardApplyThemeTemplateCommand.GetAllFloorFurnitures()
	local function var_4_0(arg_5_0, arg_5_1)
		local var_5_0 = getProxy(DormProxy):getRawData():GetTheme(arg_5_0)

		for iter_5_0, iter_5_1 in pairs((var_5_0 or nil) and var_5_0:GetAllFurniture()) do
			arg_5_1[iter_5_1.id] = iter_5_1
		end

		return
	end

	local var_4_1 = {}

	var_4_0(1, var_4_1)
	var_4_0(2, var_4_1)

	return var_4_1
end

function BackYardApplyThemeTemplateCommand:WarpList()
	local var_6_0 = getProxy(DormProxy):getRawData()
	local var_6_1 = var_6_0:GetMapSize()
	local var_6_2 = var_6_1.x
	local var_6_3 = var_6_1.y

	local function var_6_6(arg_7_0)
		assert(arg_7_0.position, arg_7_0.id)

		return not arg_7_0:isPaper() and (arg_7_0.position.x < var_6_2 or arg_7_0.position.y < var_6_3)
	end

	local var_6_8 = var_6_0:GetPurchasedFurnitures()

	for iter_6_0 = #self, 1, -1 do
		if not self[iter_6_0].position or not var_6_8[self[iter_6_0].configId] or var_6_6(self[iter_6_0]) then
			table.remove(self, iter_6_0)
		end
	end

	table.sort(self, function(arg_8_0, arg_8_1)
		if #arg_8_0.child == #arg_8_1.child then
			return arg_8_0.parent > arg_8_1.parent
		else
			return #arg_8_0.child > #arg_8_1.child
		end

		return
	end)

	local var_6_9 = {}

	for iter_6_1, iter_6_2 in ipairs(self) do
		var_6_9[iter_6_2.id] = iter_6_2
	end

	local var_6_10 = {}
	local var_6_11 = {}
	local var_6_12 = var_6_0:GetMapSize()

	for iter_6_3, iter_6_4 in ipairs(self) do
		local var_6_13, var_6_14 = CourtYardRawDataChecker.CheckFurnitrue(iter_6_4, var_6_9, var_6_12)

		if not var_6_13 and not table.contains(var_6_10, iter_6_4.id) then
			for iter_6_5, iter_6_6 in pairs(iter_6_4.child or {}) do
				table.insert(var_6_10, iter_6_5)
			end

			if iter_6_4.parent ~= 0 then
				var_6_11[iter_6_4.parent] = var_6_11[iter_6_4.parent] or {}

				table.insert(var_6_11[iter_6_4.parent], iter_6_4.id)
			end

			table.insert(var_6_10, iter_6_4.id)
		end
	end

	for iter_6_7 = #self, 1, -1 do
		if table.contains(var_6_10, self[iter_6_7].id) then
			table.remove(self, iter_6_7)
		else
			local var_6_16 = var_6_11[self[iter_6_7].id]

			if var_6_11[self[iter_6_7].id] then
				for iter_6_8, iter_6_9 in pairs(self[iter_6_7].child or {}) do
					if table.contains(var_6_16, iter_6_8) then
						self[iter_6_7].child[iter_6_8] = nil
					end
				end
			end
		end
	end

	GetCanBePutFurnituresForThemeCommand.SortListForPut(self)

	return
end

return BackYardApplyThemeTemplateCommand
