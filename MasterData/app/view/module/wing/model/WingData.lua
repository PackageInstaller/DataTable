local WingData = class("WingData")
local var_0_1 = g.core.config.wing_info
local var_0_2 = g.core.config.wing_refine_info
local var_0_3 = g.core.config.wing_refine_change_info

function WingData:ctor()
	self:initData()
end

function WingData:initData()
	self._wingList = {}
	self._wingMap = {}
	self._wingClassMap = {}
	self._wingRefineClassMap = {}
	self._wingRefineChangeMap = {}
	self._firstRefineClass = 0
	self._initWing = nil
	self._wingRefineMap = {}
	self._preRefineMap = {}
	self._wingId = 0
	self._isShowWing = true

	self:_initCfg()
end

function WingData:_initCfg()
	self._wingList = {}
	self._wingMap = {}
	self._wingClassMap = {}
	self._initWing = nil

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		local var_3_0 = require("app.view.module.wing.model.WingStruct").new(iter_3_1)

		table.insert(self._wingList, var_3_0)

		self._wingMap[iter_3_1.id] = var_3_0
		self._wingClassMap[iter_3_1.class] = var_3_0

		if not self._initWing then
			self._initWing = var_3_0
		elseif iter_3_1.class < self._initWing:getClass() then
			self._initWing = var_3_0
		end
	end

	self._wingRefineClassMap = {}
	self._firstRefineClass = 0

	for iter_3_2, iter_3_3 in var_0_2.ipairs() do
		self._wingRefineClassMap[iter_3_3.class] = self._wingRefineClassMap[iter_3_3.class] or {}
		self._firstRefineClass = math.min(self._firstRefineClass, iter_3_3.class)

		table.insert(self._wingRefineClassMap[iter_3_3.class], iter_3_3)
	end

	self._wingRefineChangeMap = {}

	for iter_3_4, iter_3_5 in var_0_3.ipairs() do
		self._wingRefineChangeMap[iter_3_5.id] = self._wingRefineChangeMap[iter_3_5.id] or {}

		table.insert(self._wingRefineChangeMap[iter_3_5.id], iter_3_5)
	end
end

function WingData:getWingList(arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(self._wingList) do
		if iter_4_1:isPut() then
			if arg_4_2 then
				if iter_4_1:getGrade() <= 1 then
					table.insert(var_4_0, iter_4_1)
				end
			else
				table.insert(var_4_0, iter_4_1)
			end
		end
	end

	if arg_4_1 then
		table.sort(var_4_0, function(arg_5_0, arg_5_1)
			return arg_5_0:getClass() < arg_5_1:getClass()
		end)
	end

	return var_4_0
end

function WingData:getWingById(arg_6_1)
	return self._wingMap[arg_6_1]
end

function WingData:getCurWing()
	if self._wingId > 0 then
		return self:getWingById(self._wingId)
	else
		return self._initWing
	end
end

function WingData:getMaxGradeWingByClass(arg_8_1, arg_8_2)
	local var_8_0 = self._wingClassMap[arg_8_1]

	if self._wingClassMap[arg_8_1] and not arg_8_2 and not var_8_0:isPut() then
		var_8_0 = nil
	end

	return var_8_0
end

function WingData:getWingListByClass(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._wingList) do
		if iter_9_1:getClass() == arg_9_1 then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function WingData:getCurWingClass()
	local var_10_0 = self:getCurWing()
	local var_10_1 = self._initWing:getClass() - 1

	return (var_10_0:isComposed() or nil) and var_10_0:getClass()
end

function WingData:getCurWingGrade()
	local var_11_0 = self:getCurWing()
	local var_11_1 = self._initWing:getGrade()

	return (var_11_0:isComposed() or nil) and var_11_0:getGrade()
end

function WingData:getRefineAttr(arg_12_1)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self._wingRefineMap) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			var_12_0[iter_12_3.id] = var_12_0[iter_12_3.id] or {
				value = 0,
				refineMin = 0,
				refineMax = 0,
				type = iter_12_3.id
			}
			var_12_0[iter_12_3.id].value = var_12_0[iter_12_3.id].value + iter_12_3.num
		end
	end

	if arg_12_1 and arg_12_1 > 0 then
		local var_12_1 = self._wingRefineMap[arg_12_1] or {}
		local var_12_2 = self._wingRefineChangeMap[var_0_2.get(arg_12_1).change_id]

		var_12_2 = var_12_2 or {}

		for iter_12_4, iter_12_5 in ipairs(var_12_2) do
			local var_12_3 = 0

			for iter_12_6, iter_12_7 in ipairs(var_12_1) do
				if iter_12_7.id == iter_12_5.attribute_type then
					var_12_3 = iter_12_7.num

					break
				end
			end

			var_12_0[iter_12_5.attribute_type] = var_12_0[iter_12_5.attribute_type] or {
				value = 0,
				refineMin = 0,
				refineMax = 0,
				type = iter_12_5.attribute_type
			}

			local var_12_4 = math.max(1, iter_12_5.attribute_size_max - var_12_3)
			local var_12_5 = var_12_0[iter_12_5.attribute_type]

			var_12_0[iter_12_5.attribute_type].refineMin = var_12_4 * (iter_12_5.attribute_refine_weight - iter_12_5.attribute_change_weight) / 1000
			var_12_0[iter_12_5.attribute_type].refineMax = var_12_4 * math.min(1000, iter_12_5.attribute_refine_weight + iter_12_5.attribute_change_weight) / 1000

			if var_12_0[iter_12_5.attribute_type].refineMin > var_12_0[iter_12_5.attribute_type].refineMax then
				var_12_5.refineMin, var_12_5.refineMax = var_12_0[iter_12_5.attribute_type].refineMax, var_12_0[iter_12_5.attribute_type].refineMin
			end

			var_12_0[iter_12_5.attribute_type].refineMin = math.max(1, math.floor(var_12_0[iter_12_5.attribute_type].refineMin + 0.5))
			var_12_0[iter_12_5.attribute_type].refineMax = math.max(1, math.floor(var_12_0[iter_12_5.attribute_type].refineMax + 0.5))
		end
	end

	local var_12_6 = table.values(var_12_0)

	table.sort(var_12_6, function(arg_13_0, arg_13_1)
		if arg_13_0.refineMin > 0 ~= (arg_13_1.refineMin > 0) then
			return arg_13_0.refineMin > 0
		end

		return arg_13_0.type < arg_13_1.type
	end)

	return var_12_6
end

function WingData:getRefineShowQuality(arg_14_1, arg_14_2)
	arg_14_1 = arg_14_1 or 1
	arg_14_2 = arg_14_2 or 0

	local var_14_0 = 1
	local var_14_1 = g.core.config.wing_refine_show.fetch(arg_14_1)

	if var_14_1 then
		var_14_0 = var_14_1.initial_quality

		while g.core.config.wing_refine_show.hasKey("quality_" .. 1) do
			local var_14_2

			if arg_14_2 >= var_14_1["quality_" .. 1 .. "_num"] then
				var_14_0 = var_14_1["quality_" .. 1]
				var_14_2 = 1 + 1
			else
				break
			end
		end
	end

	return var_14_0
end

function WingData:getRefineChangeList(arg_15_1)
	return self._wingRefineChangeMap[arg_15_1] or {}
end

function WingData:getCurRefineCfgs()
	local var_16_0 = {}

	for iter_16_0 = 0, self:getCurWingClass() do
		for iter_16_1, iter_16_2 in ipairs(self._wingRefineClassMap[iter_16_0] or {}) do
			table.insert(var_16_0, iter_16_2)
		end
	end

	return var_16_0
end

function WingData:getAllRefineCfgs()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self._wingRefineClassMap) do
		for iter_17_2, iter_17_3 in ipairs(iter_17_1) do
			if iter_17_3.class < g.core.const.ConstMgr.WingConst.MAX_CLASS_NUM then
				table.insert(var_17_0, iter_17_3)
			end
		end
	end

	return var_17_0
end

function WingData:flushWing(arg_18_1)
	if arg_18_1.wing and arg_18_1.wing[1] then
		self:updateWing(arg_18_1.wing[1])
	end

	self._wingRefineMap = {}

	self:udpateRefineList(arg_18_1.wing_refines)
end

function WingData:updateWing(arg_19_1)
	if not arg_19_1 then
		return
	end

	self._wingId = arg_19_1.id
	self._isShowWing = arg_19_1.is_show == 1

	local var_19_0 = -1
	local var_19_1 = 0

	if self._wingId > 0 then
		local var_19_2 = g.core.config.wing_info.get(self._wingId)

		var_19_0 = var_19_2.class
		var_19_1 = var_19_2.grade
	end

	for iter_19_0, iter_19_1 in ipairs(self._wingList) do
		iter_19_1:updateByCurClass(var_19_0, var_19_1)
	end
end

function WingData:udpateRefineList(arg_20_1)
	if not arg_20_1 then
		return
	end

	self._preRefineMap = clone(self._wingRefineMap)

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		self._wingRefineMap[iter_20_1.id] = iter_20_1.attrs or {}
	end
end

function WingData:isShowWing()
	return self._isShowWing
end

function WingData:getNextWing()
	if self:isOwnWing() then
		return self:getNextWingBuyId(self:getCurWing():getCfgId())
	else
		return self:getInitWing()
	end
end

function WingData:getNextWingBuyId(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(self._wingList) do
		if iter_23_1:getCfg().pre_id == arg_23_1 then
			return iter_23_1
		end
	end
end

function WingData:isOwnWing()
	return self._wingId > 0
end

function WingData:getInitWing()
	return self._initWing
end

function WingData:getShowWingId()
	if self._isShowWing then
		return self._wingId
	end

	return 0
end

function WingData:getRefineAttrChange()
	local function var_27_0(arg_28_0)
		local var_28_0 = {}

		for iter_28_0, iter_28_1 in pairs(arg_28_0) do
			for iter_28_2, iter_28_3 in ipairs(iter_28_1) do
				var_28_0[iter_28_3.id] = var_28_0[iter_28_3.id] or 0
				var_28_0[iter_28_3.id] = var_28_0[iter_28_3.id] + iter_28_3.num
			end
		end

		return var_28_0
	end

	local var_27_1 = var_27_0(self._preRefineMap)
	local var_27_2 = {}

	for iter_27_0, iter_27_1 in pairs((var_27_0(self._wingRefineMap))) do
		local var_27_3 = var_27_1[iter_27_0] or 0

		if var_27_3 ~= iter_27_1 then
			table.insert(var_27_2, {
				type = iter_27_0,
				value = iter_27_1,
				preValue = var_27_3
			})
		end
	end

	return var_27_2
end

function WingData:getAllAttr()
	local var_29_0 = self:getCurWing()
	local var_29_1 = {}

	if var_29_0:isComposed() then
		var_29_1 = var_29_0:getBaseAttrs()
	end

	local var_29_2 = self:getRefineAttr()
	local var_29_3 = {}

	local function var_29_4(arg_30_0)
		for iter_30_0, iter_30_1 in ipairs(arg_30_0) do
			var_29_3[iter_30_1.type] = var_29_3[iter_30_1.type] or {
				value = 0,
				type = iter_30_1.type
			}
			var_29_3[iter_30_1.type].value = var_29_3[iter_30_1.type].value + iter_30_1.value
		end
	end

	var_29_4(var_29_1)
	var_29_4(var_29_2)

	local var_29_5 = table.values(var_29_3)

	table.sort(var_29_5, function(arg_31_0, arg_31_1)
		return arg_31_0.type < arg_31_1.type
	end)

	return var_29_5
end

function WingData:getWingId()
	return self._wingId
end

return WingData
