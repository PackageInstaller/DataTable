local var_0_0 = class("IslandDetectionSystem")
local var_0_1 = 6

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.view = arg_1_1
	arg_1_0.isAreaDetection = false
	arg_1_0.areaListUnit = {}

	arg_1_0:Init()

	return
end

function var_0_0.NotifiyCore(arg_2_0, arg_2_1, ...)
	arg_2_0.view:NotifiyCore(arg_2_1, ...)

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

	for iter_4_0, iter_4_1 in ipairs(pg.island_production_farm.all) do
		if pg.island_production_farm[iter_4_1].objId ~= 0 then
			arg_4_0.objectIdDic[pg.island_production_farm[iter_4_1].objId] = pg.island_production_farm[iter_4_1]
		end

		local var_4_0 = pg.island_production_farm[iter_4_1].array

		if pg.island_production_farm[iter_4_1].array ~= "" then
			arg_4_0.objectArrDic[var_4_0[1]] = arg_4_0.objectArrDic[var_4_0[1]] or {}
			arg_4_0.objectArrDic[var_4_0[1]][var_4_0[2]] = pg.island_production_farm[iter_4_1]
		end
	end

	return
end

function var_0_0.SetAreaDetection(arg_5_0)
	arg_5_0.isAreaDetection = not arg_5_0.isAreaDetection

	pg.TipsMgr.GetInstance():ShowTips(i18n(arg_5_0.isAreaDetection and "island_dectect_mode3x3" or "island_dectect_mode1x1"))
	arg_5_0:CheckHighLight()

	return
end

function var_0_0.GetNearArea(arg_6_0, arg_6_1)
	local var_6_0

	if arg_6_1 == nil then
		do return {} end

		var_6_0 = arg_6_0:GetUnitModule(arg_6_1)
	end

	local var_6_1 = arg_6_0.objectIdDic[arg_6_1].array

	if not arg_6_0.isAreaDetection then
		table.insert({}, var_6_0)

		return {}
	end

	local var_6_2 = var_6_0:GetPlantType()

	for iter_6_0 = -1, 1 do
		for iter_6_1 = -1, 1 do
			if (function(arg_7_0, arg_7_1)
				return arg_7_0 >= 1 and arg_7_0 <= var_0_1 and arg_7_1 >= 1 and arg_7_1 <= var_0_1
			end)(var_6_1[1] + iter_6_0, var_6_1[2] + iter_6_1) then
				local var_6_3 = arg_6_0:GetUnitModule(arg_6_0.objectArrDic[var_6_1[1] + iter_6_0][var_6_1[2] + iter_6_1].objId)

				if var_6_3:GetPlantType() == var_6_2 then
					table.insert({}, var_6_3)
				end
			end
		end
	end

	return {}
end

function var_0_0.CheckHighLight(arg_8_0)
	local var_8_0 = arg_8_0:GetUnitModule(arg_8_0.currentNearId)
	local var_8_1 = arg_8_0:GetNearArea(arg_8_0.currentNearId)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.lastHighlightDic) do
		if not (function(arg_9_0)
			for iter_9_0, iter_9_1 in ipairs(var_8_1) do
				if iter_9_1 == arg_9_0 then
					return true
				end
			end

			return false
		end)(iter_8_0) then
			arg_8_0.lastHighlightDic[iter_8_0] = nil

			arg_8_0:GetUnitModule(iter_8_0):SetHighLight(false)
		end
	end

	for iter_8_2, iter_8_3 in ipairs((arg_8_0:GetNearArea(arg_8_0.currentNearId))) do
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
		for iter_10_0, iter_10_1 in pairs(arg_10_0.lastHighlightDic) do
			arg_10_0:GetUnitModule(iter_10_0):SetHighLight(false)
		end

		arg_10_0.lastHighlightDic = {}
	end

	return
end

function var_0_0.GetUnitModule(arg_11_0, arg_11_1)
	return arg_11_0.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_11_1)
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
	for iter_15_0, iter_15_1 in pairs(arg_15_0.lastHighlightDic) do
		table.insert({}, iter_15_0)
	end

	return {}
end

return var_0_0
