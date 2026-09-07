local IslandDetectionSystem = class("IslandDetectionSystem")
local var_0_1 = 6

function IslandDetectionSystem:Ctor(arg_1_1)
	self.view = arg_1_1
	self.isAreaDetection = false
	self.areaListUnit = {}

	self:Init()

	return
end

function IslandDetectionSystem:NotifiyCore(arg_2_1, ...)
	self.view:NotifiyCore(arg_2_1, ...)

	return
end

function IslandDetectionSystem:Init()
	self.lastHighlightDic = {}

	self:InitProductionCfg()

	return
end

function IslandDetectionSystem:InitProductionCfg()
	self.objectIdDic = {}
	self.objectArrDic = {}

	for iter_4_0, iter_4_1 in ipairs(pg.island_production_farm.all) do
		if pg.island_production_farm[iter_4_1].objId ~= 0 then
			self.objectIdDic[pg.island_production_farm[iter_4_1].objId] = pg.island_production_farm[iter_4_1]
		end

		local var_4_0 = pg.island_production_farm[iter_4_1].array

		if pg.island_production_farm[iter_4_1].array ~= "" then
			self.objectArrDic[var_4_0[1]] = self.objectArrDic[var_4_0[1]] or {}
			self.objectArrDic[var_4_0[1]][var_4_0[2]] = pg.island_production_farm[iter_4_1]
		end
	end

	return
end

function IslandDetectionSystem:SetAreaDetection()
	self.isAreaDetection = not self.isAreaDetection

	pg.TipsMgr.GetInstance():ShowTips(i18n(self.isAreaDetection and "island_dectect_mode3x3" or "island_dectect_mode1x1"))
	self:CheckHighLight()

	return
end

function IslandDetectionSystem:GetNearArea(arg_6_1)
	local var_6_0

	if arg_6_1 == nil then
		do return {} end

		var_6_0 = self:GetUnitModule(arg_6_1)
	end

	local var_6_1 = self.objectIdDic[arg_6_1].array
	local var_6_2 = {}

	if not self.isAreaDetection then
		table.insert(var_6_2, var_6_0)

		return var_6_2
	end

	local var_6_3 = var_6_0:GetPlantType()

	local function var_6_4(arg_7_0, arg_7_1)
		return arg_7_0 >= 1 and arg_7_0 <= var_0_1 and arg_7_1 >= 1 and arg_7_1 <= var_0_1
	end

	for iter_6_0 = -1, 1 do
		for iter_6_1 = -1, 1 do
			if var_6_4(var_6_1[1] + iter_6_0, var_6_1[2] + iter_6_1) then
				local var_6_5 = self:GetUnitModule(self.objectArrDic[var_6_1[1] + iter_6_0][var_6_1[2] + iter_6_1].objId)

				if var_6_5:GetPlantType() == var_6_3 then
					table.insert(var_6_2, var_6_5)
				end
			end
		end
	end

	return var_6_2
end

function IslandDetectionSystem:CheckHighLight()
	local var_8_0 = self:GetUnitModule(self.currentNearId)
	local var_8_1 = self:GetNearArea(self.currentNearId)

	local function var_8_2(arg_9_0)
		for iter_9_0, iter_9_1 in ipairs(var_8_1) do
			if iter_9_1 == arg_9_0 then
				return true
			end
		end

		return false
	end

	for iter_8_0, iter_8_1 in pairs(self.lastHighlightDic) do
		if not var_8_2(iter_8_0) then
			self.lastHighlightDic[iter_8_0] = nil

			self:GetUnitModule(iter_8_0):SetHighLight(false)
		end
	end

	for iter_8_2, iter_8_3 in ipairs(var_8_1) do
		iter_8_3:SetHighLight(true)

		self.lastHighlightDic[iter_8_3.id] = true
	end

	return
end

function IslandDetectionSystem:HighLightUnitHandle(arg_10_1, arg_10_2)
	if arg_10_2 then
		self.currentNearId = arg_10_1

		self:CheckHighLight()
	else
		for iter_10_0, iter_10_1 in pairs(self.lastHighlightDic) do
			self:GetUnitModule(iter_10_0):SetHighLight(false)
		end

		self.lastHighlightDic = {}
	end

	return
end

function IslandDetectionSystem:GetUnitModule(arg_11_1)
	return self.view:GetUnitModuleWithType(IslandConst.UNIT_LIST_OBJ, arg_11_1)
end

function IslandDetectionSystem:GetView()
	return self.view
end

function IslandDetectionSystem:Dispose()
	return
end

function IslandDetectionSystem:Update()
	return
end

function IslandDetectionSystem:GetAreaList()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self.lastHighlightDic) do
		table.insert(var_15_0, iter_15_0)
	end

	return var_15_0
end

return IslandDetectionSystem
