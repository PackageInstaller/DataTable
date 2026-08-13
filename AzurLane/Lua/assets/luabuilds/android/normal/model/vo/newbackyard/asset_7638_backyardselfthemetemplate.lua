class = var_0_10000

local var_0_0 = "BackYardSelfThemeTemplate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BackYardBaseThemeTemplate"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.floor = arg_1_2 or 1

	return
end

function var_0_1.GetAllFurniture(arg_2_0)
	if not arg_2_0.furnitruesByIds then
		local var_2_0 = arg_2_0:GetRawPutList()

		arg_2_0.furnitruesByIds = arg_2_0:InitFurnitures({
			mapSize = arg_2_0:GetMapSize(),
			floor = arg_2_0.floor,
			furniture_put_list = var_2_0
		})
	end

	return arg_2_0.furnitruesByIds
end

function var_0_1.AddFurniture(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetAllFurniture()
	local var_3_1 = {}

	pairs = var_1_10005

	for iter_3_0, iter_3_1 in var_1_10005(arg_3_1.child) do
		var_3_1[iter_3_0] = iter_3_1
	end

	BackyardThemeFurniture = var_5

	local var_3_2 = var_5.New
	local var_3_3 = {
		isNewStyle = true,
		id = arg_3_1.id,
		configId = arg_3_1.configId
	}

	Vector2 = var_7
	var_3_3.position = var_7(arg_3_1.x, arg_3_1.y)
	var_3_3.dir = arg_3_1.dir
	var_3_3.child = var_3_1
	var_3_3.parent = arg_3_1.parent
	var_3_3.floor = arg_3_2

	local var_3_4 = var_3_2(var_3_3)

	var_3_0[arg_3_1.id] = var_3_4

	return var_3_4
end

function var_0_1.DeleteFurniture(arg_4_0, arg_4_1)
	if arg_4_0:GetAllFurniture()[arg_4_1] then
		var_2[arg_4_1] = nil
	end

	return
end

function var_0_1.GetFurniture(arg_5_0, arg_5_1)
	return arg_5_0:GetAllFurniture()[arg_5_1]
end

function var_0_1.GetType(arg_6_0)
	BackYardConst = var_1_10001

	return var_1_10001.THEME_TEMPLATE_USAGE_TYPE_SELF
end

function var_0_1.IsSystem(arg_7_0)
	return false
end

function var_0_1.IsCollected(arg_8_0)
	return true
end

function var_0_1.IsLiked(arg_9_0)
	return true
end

function var_0_1.UnLoad(arg_10_0)
	arg_10_0.time = 0

	return
end

function var_0_1.Upload(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.TimeMgr.GetInstance()

	arg_11_0.time = var_1.GetServerTime(var_11_0)

	return
end

function var_0_1.CanDispaly(arg_12_0)
	return arg_12_0:IsPushed() or not var_1 and arg_12_0:ExistLocalImage()
end

function var_0_1.IsUsing(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.GetWarpFurnitures(var_13_0)

	table = var_13_0

	local var_13_2 = var_13_0.getCount(arg_13_1)

	table = var_4

	if var_13_2 ~= var_4.getCount(var_13_1) then
		local var_13_3 = false

		Vector2 = var_1_10006
		var_1_10006 = var_1_10006(var_13_2, var_4)

		return
	end

	local var_13_4 = {}

	pairs = var_1_10006

	for iter_13_0, iter_13_1 in var_1_10006(arg_13_1) do
		if arg_13_0:IsSystem() and iter_13_1:getConfig("themeId") ~= arg_13_0.id then
			return false, 0
		end

		if not var_13_4[iter_13_1:getConfig("id")] then
			var_13_4[var_11] = {}
		end

		table = var_12

		var_12.insert(var_13_4[var_11], iter_13_1)
	end

	pairs = var_6

	for iter_13_2, iter_13_3 in var_6(var_13_1) do
		if not arg_13_1[iter_13_3.id] then
			return false, 1
		end

		if not var_11:isPaper() then
			if not var_11.position then
				return false, 2
			end

			local var_13_5

			if not var_13_4[iter_13_3.id] then
				var_13_5 = {}
			end

			local var_13_6 = false

			ipairs = var_1_10014

			for iter_13_4, iter_13_5 in var_1_10014(var_13_5) do
				if iter_13_5:isSame(iter_13_3) then
					var_13_6 = true

					break
				end
			end

			if not var_13_6 then
				return false, 3
			end
		end
	end

	return true
end

function var_0_1.GetMissFurnitures(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetWarpFurnitures()

	if #arg_14_1 == #var_14_0 then
		return
	end

	local var_14_1 = {}

	local function var_14_2(arg_15_0, arg_15_1)
		ipairs = var_2_10002

		for iter_15_0, iter_15_1 in var_2_10002(arg_15_0) do
			if not arg_15_1[iter_15_1.id] then
				arg_15_1[iter_15_1.id] = 0
			else
				arg_15_1[iter_15_1.id] = arg_15_1[iter_15_1.id] + 1
			end
		end

		return
	end

	local var_14_3 = {}
	local var_14_4 = {}

	var_14_2(var_14_0, var_14_3)
	var_14_2(arg_14_1, var_14_4)

	local function var_14_5(arg_16_0)
		pg = var_2_10001

		local var_16_0 = var_2_10001.furniture_data_template[arg_16_0]

		return {
			count = 1,
			name = var_16_0.name
		}
	end

	pairs = var_8

	for iter_14_0, iter_14_1 in var_8(var_14_3) do
		if not var_14_4[iter_14_0] then
			var_14_1[iter_14_0] = var_14_5(iter_14_0)
		elseif var_14_4[iter_14_0] and iter_14_1 > var_14_4[iter_14_0] then
			if not var_14_1[iter_14_0] then
				var_14_1[iter_14_0] = var_14_5(iter_14_0)
			end

			var_14_1[iter_14_0].count = iter_14_1 - var_14_4[iter_14_0]
		end
	end

	return var_14_1
end

function var_0_1.getName(arg_17_0)
	return arg_17_0:GetName()
end

function var_0_1.getIcon(arg_18_0)
	return "themeicon"
end

return var_0_1
