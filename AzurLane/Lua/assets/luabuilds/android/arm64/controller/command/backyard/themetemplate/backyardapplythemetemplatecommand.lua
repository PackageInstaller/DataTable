class = var_0_10000

local var_0_0 = "BackYardApplyThemeTemplateCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().template
	local var_1_1 = var_2.callback

	getProxy = var_1_10005
	DormProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)

	local function var_1_3(arg_2_0, arg_2_1)
		if #arg_2_0 == 0 then
			pg = var_2

			local var_2_0 = var_2.TipsMgr.GetInstance()
			local var_2_1 = var_2.ShowTips

			i18n = var_2_10005

			var_2_1(var_2_0, var_2_10005("backyard_theme_template_list_is_empty"))

			return
		end

		local var_2_2 = {}

		ipairs = var_2_10003

		for iter_2_0, iter_2_1 in var_2_10003(arg_2_0) do
			var_2_2[iter_2_1.id] = iter_2_1
		end

		local var_2_3 = {}

		pairs = var_4

		for iter_2_2, iter_2_3 in var_4(var_2_2) do
			var_2_3[iter_2_3.id] = iter_2_3:ToSaveData()
		end

		pg = var_4

		local var_2_4 = var_4.m02
		local var_2_5 = var_4.sendNotification

		GAME = iter_2_2

		var_2_5(var_2_4, iter_2_2.PUT_FURNITURE, {
			furnsPos = var_2_3,
			floor = arg_2_1,
			callback = function(arg_3_0, arg_3_1)
				if arg_3_0 then
					local var_3_0 = arg_1_0

					var_3_10002 = var_3_10002.sendNotification
					GAME = var_3_10005

					var_3_10002(var_3_0, var_3_10005.BACKYARD_APPLY_THEME_TEMPLATE_DONE)
				else
					pg = var_3_10002

					local var_3_1 = var_3_10002.TipsMgr.GetInstance()
					local var_3_2 = var_2.ShowTips

					i18n = var_3_10005

					var_3_2(var_3_1, var_3_10005("backyard_apply_theme_template_erro"))

					print = var_3_2

					var_3_2(arg_3_1)
				end

				return
			end
		})

		return
	end

	local var_1_4 = 1
	local var_1_5 = var_0_1.GetAllFloorFurnitures()
	local var_1_6 = var_1_0:IsOccupyed(var_1_5, 1)
	local var_1_7 = {}

	if var_1_6 then
		var_1_7 = var_1_0:GetUsableFurnituresForFloor(var_1_5, var_1_4)
	else
		local var_1_8 = var_1_0:GetAllFurniture()

		pairs = var_12

		for iter_1_0, iter_1_1 in var_12(var_1_8) do
			table = var_1_10017

			var_1_10017.insert(var_1_7, iter_1_1)
		end
	end

	var_0_1.WarpList(var_1_7)
	var_1_3(var_1_7, var_1_4)

	if var_1_1 then
		var_1_1(not var_1_6, var_1_7)
	end

	return
end

function var_0_1.GetAllFloorFurnitures()
	local function var_4_0(arg_5_0, arg_5_1)
		getProxy = var_2_10002
		DormProxy = var_2_10004

		local var_5_0 = var_2_10002(var_2_10004)
		local var_5_1 = var_2.getRawData(var_5_0)
		local var_5_2 = var_2.GetTheme(var_5_1, arg_5_0)
		local var_5_3 = {}

		if var_5_2 then
			var_5_3 = var_5_2:GetAllFurniture()
		end

		pairs = var_5_1

		for iter_5_0, iter_5_1 in var_5_1(var_5_3) do
			arg_5_1[iter_5_1.id] = iter_5_1
		end

		return
	end

	local var_4_1 = {}

	var_4_0(1, var_4_1)
	var_4_0(2, var_4_1)

	return var_4_1
end

function var_0_1.WarpList(arg_6_0)
	getProxy = var_1_10001
	DormProxy = var_1_10003

	local var_6_0 = var_1_10001(var_1_10003)
	local var_6_1 = var_1.getRawData(var_6_0)
	local var_6_2 = var_1.GetMapSize(var_6_1).x
	local var_6_3 = var_2.y
	local var_6_4 = var_2.z
	local var_6_5 = var_2.w

	local function var_6_6(arg_7_0)
		assert = var_2_10001

		var_2_10001(arg_7_0.position, arg_7_0.id)

		return not arg_7_0:isPaper() and (arg_7_0.position.x < var_6_2 or arg_7_0.position.y < var_6_3)
	end

	local var_6_7 = var_1.level
	local var_6_8 = var_1:GetPurchasedFurnitures()

	for iter_6_0 = #arg_6_0, 1, -1 do
		if not arg_6_0[iter_6_0].position or not var_6_8[var_14.configId] or var_6_6(var_14) then
			table = var_15

			var_15.remove(arg_6_0, iter_6_0)
		end
	end

	table = var_10

	var_10.sort(arg_6_0, function(arg_8_0, arg_8_1)
		if #arg_8_0.child == #arg_8_1.child then
			return arg_8_0.parent > arg_8_1.parent
		else
			return #arg_8_0.child > #arg_8_1.child
		end

		return
	end)

	local var_6_9 = {}

	ipairs = var_11

	for iter_6_1, iter_6_2 in var_11(arg_6_0) do
		var_6_9[iter_6_2.id] = iter_6_2
	end

	local var_6_10 = {}
	local var_6_11 = {}
	local var_6_12 = var_1:GetMapSize()

	ipairs = iter_6_1

	for iter_6_3, iter_6_4 in iter_6_1(arg_6_0) do
		CourtYardRawDataChecker = var_1_10019
		var_1_10019, var_1_10020 = var_1_10019.CheckFurnitrue(iter_6_4, var_6_9, var_6_12)

		if not var_1_10019 then
			table = var_21

			if not var_21.contains(var_6_10, iter_6_4.id) then
				pairs = var_21

				local var_6_13

				if not iter_6_4.child then
					var_6_13 = {}
				end

				for iter_6_5, iter_6_6 in var_21(var_6_13) do
					table = var_1_10026

					var_1_10026.insert(var_6_10, iter_6_5)
				end

				if iter_6_4.parent ~= 0 then
					if not var_6_11[iter_6_4.parent] then
						var_6_11[iter_6_4.parent] = {}
					end

					table = var_21

					var_21.insert(var_6_11[iter_6_4.parent], iter_6_4.id)
				end

				table = var_21

				var_21.insert(var_6_10, iter_6_4.id)
			end
		end
	end

	for iter_6_7 = #arg_6_0, 1, -1 do
		local var_6_14 = arg_6_0[iter_6_7]

		table = var_1_10019

		if var_1_10019.contains(var_6_10, var_6_14.id) then
			table = var_1_10019

			var_1_10019.remove(arg_6_0, iter_6_7)
		elseif var_6_11[var_6_14.id] then
			pairs = var_1_10020

			local var_6_15

			if not var_6_14.child then
				var_6_15 = {}
			end

			for iter_6_8, iter_6_9 in var_1_10020(var_6_15) do
				table = iter_6_6

				if iter_6_6.contains(var_1_10019, iter_6_8) then
					iter_6_6 = var_6_14.child
					iter_6_6[iter_6_8] = nil
				end
			end
		end
	end

	GetCanBePutFurnituresForThemeCommand = var_14

	var_14.SortListForPut(arg_6_0)

	return
end

return var_0_1
