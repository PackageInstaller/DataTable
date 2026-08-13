class = var_0_10000

local var_0_0 = var_0_10000("IslandDetectionSystem")
local var_0_1 = 6

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.view = arg_1_1
	arg_1_0.isAreaDetection = false
	arg_1_0.areaListUnit = {}

	arg_1_0:Init()

	return
end

function var_0_0.NotifiyCore(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_0.view

	var_2.NotifiyCore(var_2_0, arg_2_1, ...)

	return
end

function var_0_0.Init(arg_3_0)
	arg_3_0.lastHighlightDic = {}

	arg_3_0:InitProductionCfg()

	return
end

function var_0_0.InitProductionCfg(arg_4_0)
	arg_4_0.objectIdDic = {}
	arg_4_0.objectArrDic = {}
	ipairs = var_1
	pg = var_1_10003

	for iter_4_0, iter_4_1 in var_1(var_1_10003.island_production_farm.all) do
		pg = var_1_10006

		if var_1_10006.island_production_farm[iter_4_1].objId ~= 0 then
			arg_4_0.objectIdDic[var_1_10006.objId] = var_1_10006
		end

		if var_1_10006.array ~= "" then
			local var_4_0 = var_7[1]
			local var_4_1 = var_7[2]

			if not arg_4_0.objectArrDic[var_4_0] then
				arg_4_0.objectArrDic[var_4_0] = {}
			end

			arg_4_0.objectArrDic[var_4_0][var_4_1] = var_1_10006
		end
	end

	return
end

function var_0_0.SetAreaDetection(arg_5_0)
	arg_5_0.isAreaDetection = not arg_5_0.isAreaDetection

	local var_5_0 = arg_5_0.isAreaDetection and "island_dectect_mode3x3" or "island_dectect_mode1x1"

	pg = var_1_10002

	local var_5_1 = var_1_10002.TipsMgr.GetInstance()
	local var_5_2 = var_2.ShowTips

	i18n = var_1_10005

	var_5_2(var_5_1, var_1_10005(var_5_0))
	arg_5_0:CheckHighLight()

	return
end

function var_0_0.GetNearArea(arg_6_0, arg_6_1)
	if arg_6_1 == nil then
		return {}
	end

	local var_6_0 = arg_6_0.objectIdDic[arg_6_1]
	local var_6_1 = arg_6_0:GetUnitModule(arg_6_1)
	local var_6_2 = var_6_0.array
	local var_6_3 = {}

	if not arg_6_0.isAreaDetection then
		table = var_6

		var_6.insert(var_6_3, var_6_1)

		return var_6_3
	end

	local var_6_4 = var_6_1:GetPlantType()

	local function var_6_5(arg_7_0, arg_7_1)
		return arg_7_0 >= 1 and arg_7_0 <= var_0_1 and arg_7_1 >= 1 and arg_7_1 <= var_0_1
	end

	for iter_6_0 = -1, 1 do
		for iter_6_1 = -1, 1 do
			local var_6_6 = var_6_2[1] + iter_6_0
			local var_6_7 = var_6_2[2] + iter_6_1

			if var_6_5(var_6_6, var_6_7) then
				local var_6_8 = arg_6_0.objectArrDic[var_6_6][var_6_7].objId
				local var_6_9 = arg_6_0
				local var_6_10 = arg_6_0.GetUnitModule(var_6_9, var_6_8)

				if var_20.GetPlantType(var_6_10) == var_6_4 then
					table = var_6_9

					var_6_9.insert(var_6_3, var_20)
				end
			end
		end
	end

	return var_6_3
end

function var_0_0.CheckHighLight(arg_8_0)
	local var_8_0 = arg_8_0.currentNearId
	local var_8_1 = arg_8_0:GetUnitModule(var_8_0)
	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.GetNearArea(var_8_2, var_8_0)

	local function var_8_4(arg_9_0)
		ipairs = var_2_10001

		for iter_9_0, iter_9_1 in var_2_10001(var_8_3) do
			if iter_9_1 == arg_9_0 then
				return true
			end
		end

		return false
	end

	pairs = var_8_2

	for iter_8_0, iter_8_1 in var_8_2(arg_8_0.lastHighlightDic) do
		if not var_8_4(iter_8_0) then
			arg_8_0.lastHighlightDic[iter_8_0] = nil

			local var_8_5 = arg_8_0:GetUnitModule(iter_8_0)

			var_10.SetHighLight(var_8_5, false)
		end
	end

	ipairs = var_5

	for iter_8_2, iter_8_3 in var_5(var_8_3) do
		iter_8_3:SetHighLight(true)

		arg_8_0.lastHighlightDic[iter_8_3.id] = true
	end

	return
end

function var_0_0.HighLightUnitHandle(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 then
		arg_10_0.currentNearId = arg_10_1

		arg_10_0:CheckHighLight()
	else
		pairs = var_1_10003

		for iter_10_0, iter_10_1 in var_1_10003(arg_10_0.lastHighlightDic) do
			local var_10_0 = arg_10_0:GetUnitModule(iter_10_0)

			var_8.SetHighLight(var_10_0, false)
		end

		arg_10_0.lastHighlightDic = {}
	end

	return
end

function var_0_0.GetUnitModule(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.view
	local var_11_1 = var_2.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_11_1(var_11_0, var_1_10005.UNIT_LIST_OBJ, arg_11_1)
end

function var_0_0.GetView(arg_12_0)
	return arg_12_0.view
end

function var_0_0.Dispose(arg_13_0)
	return
end

function var_0_0.Update(arg_14_0)
	return
end

function var_0_0.GetAreaList(arg_15_0)
	local var_15_0 = {}

	pairs = var_1_10002

	for iter_15_0, iter_15_1 in var_1_10002(arg_15_0.lastHighlightDic) do
		table = var_1_10007

		var_1_10007.insert(var_15_0, iter_15_0)
	end

	return var_15_0
end

return var_0_0
