local ShipBluePrint = class("ShipBluePrint", import(".BaseVO"))

ShipBluePrint.STATE_LOCK = 1
ShipBluePrint.STATE_DEV = 2
ShipBluePrint.STATE_DEV_FINISHED = 3
ShipBluePrint.STATE_UNLOCK = 4
ShipBluePrint.TASK_STATE_LOCK = 1
ShipBluePrint.TASK_STATE_OPENING = 2
ShipBluePrint.TASK_STATE_WAIT = 3
ShipBluePrint.TASK_STATE_START = 4
ShipBluePrint.TASK_STATE_ACHIEVED = 5
ShipBluePrint.TASK_STATE_FINISHED = 6
ShipBluePrint.TASK_STATE_PAUSE = 7
ShipBluePrint.STRENGTHEN_TYPE_ATTR = "attr"
ShipBluePrint.STRENGTHEN_TYPE_DIALOGUE = "dialog"
ShipBluePrint.STRENGTHEN_TYPE_SKILL = "skill"
ShipBluePrint.STRENGTHEN_TYPE_CHANGE_SKILL = "change_skill"
ShipBluePrint.STRENGTHEN_TYPE_BASE_LIST = "base"
ShipBluePrint.STRENGTHEN_TYPE_SKIN = "skin"
ShipBluePrint.STRENGTHEN_TYPE_BREAKOUT = "breakout"
ShipBluePrint.STRENGTHEN_TYPE_PRLOAD_COUNT = "preload"
ShipBluePrint.STRENGTHEN_TYPE_EQUIPMENTPROFICIENCY = "equipmentproficiency"

local var_0_2 = pg.ship_strengthen_blueprint
local var_0_3 = false

function ShipBluePrint.print(...)
	if var_0_3 then
		print(...)
	end

	return
end

function ShipBluePrint:Ctor(arg_2_1)
	self.configId = arg_2_1.id
	self.id = self.configId
	self.state = ShipBluePrint.STATE_LOCK
	self.startTime = 0
	self.shipId = 0
	self.duration = 0
	self.level = 0
	self.fateLevel = -1
	self.exp = 0
	self.strengthenConfig = {}

	for iter_2_0, iter_2_1 in ipairs(self:getConfig("strengthen_effect")) do
		local var_2_0 = Clone(var_0_2[iter_2_1])

		if var_2_0.special == 1 then
			self:warpspecialEffect(var_2_0)
		end

		self.strengthenConfig[iter_2_0] = var_2_0
	end

	self.fateStrengthenConfig = {}

	for iter_2_2, iter_2_3 in ipairs(self:getConfig("fate_strengthen")) do
		local var_2_1 = Clone(var_0_2[iter_2_3])

		if var_2_1.special == 1 then
			self:warpspecialEffect(var_2_1)
		end

		self.fateStrengthenConfig[iter_2_2] = var_2_1
	end

	return
end

function ShipBluePrint:warpspecialEffect(arg_3_1)
	local var_3_0 = {}
	local var_3_1 = string.split(arg_3_1.effect_desc, "|")
	local var_3_2 = 0

	if type(arg_3_1.effect_attr) == "table" then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.effect_attr) do
			var_3_2 = var_3_2 + 1

			local var_3_4 = {
				ShipBluePrint.STRENGTHEN_TYPE_ATTR,
				iter_3_1
			}

			var_3_4[3] = var_3_1[var_3_2] or ""

			table.insert(var_3_0, var_3_4)
		end

		arg_3_1.effect_attr = nil
	end

	if arg_3_1.effect_breakout ~= 0 then
		var_3_2 = var_3_2 + 1

		local var_3_5 = {
			ShipBluePrint.STRENGTHEN_TYPE_BREAKOUT,
			arg_3_1.effect_breakout
		}

		var_3_5[3] = var_3_1[var_3_2] or ""

		table.insert(var_3_0, var_3_5)

		arg_3_1.effect_breakout = nil
	end

	if type(arg_3_1.effect_skill) == "table" then
		var_3_2 = var_3_2 + 1

		local var_3_6 = {
			ShipBluePrint.STRENGTHEN_TYPE_SKILL,
			arg_3_1.effect_skill
		}

		var_3_6[3] = var_3_1[var_3_2] or ""

		table.insert(var_3_0, var_3_6)

		arg_3_1.effect_skill = nil
	end

	if type(arg_3_1.change_skill) == "table" then
		var_3_2 = var_3_2 + 1

		local var_3_7 = {
			ShipBluePrint.STRENGTHEN_TYPE_CHANGE_SKILL,
			arg_3_1.change_skill
		}

		var_3_7[3] = var_3_1[var_3_2] or ""

		table.insert(var_3_0, var_3_7)

		arg_3_1.change_skill = nil
	end

	if type(arg_3_1.effect_base) == "table" then
		var_3_2 = var_3_2 + 1

		local var_3_8 = {
			ShipBluePrint.STRENGTHEN_TYPE_BASE_LIST,
			arg_3_1.effect_base
		}

		var_3_8[3] = var_3_1[var_3_2] or ""

		table.insert(var_3_0, var_3_8)

		arg_3_1.effect_base = nil
	end

	if type(arg_3_1.effect_preload) == "table" then
		var_3_2 = var_3_2 + 1

		local var_3_9 = {
			ShipBluePrint.STRENGTHEN_TYPE_PRLOAD_COUNT,
			arg_3_1.effect_preload
		}

		var_3_9[3] = var_3_1[var_3_2] or ""

		table.insert(var_3_0, var_3_9)

		arg_3_1.effect_preload = nil
	end

	if type(arg_3_1.effect_dialog) == "table" then
		var_3_2 = var_3_2 + 1

		local var_3_10 = {
			ShipBluePrint.STRENGTHEN_TYPE_DIALOGUE,
			arg_3_1.effect_dialog
		}

		var_3_10[3] = var_3_1[var_3_2] or ""

		table.insert(var_3_0, var_3_10)

		arg_3_1.effect_dialog = nil
	end

	if arg_3_1.effect_skin ~= 0 then
		var_3_2 = var_3_2 + 1

		local var_3_11 = {
			ShipBluePrint.STRENGTHEN_TYPE_SKIN,
			arg_3_1.effect_skin
		}

		var_3_11[3] = var_3_1[var_3_2] or ""

		table.insert(var_3_0, var_3_11)

		arg_3_1.effect_skin = nil
	end

	if type(arg_3_1.effect_equipment_proficiency) == "table" then
		local var_3_12 = {
			ShipBluePrint.STRENGTHEN_TYPE_EQUIPMENTPROFICIENCY,
			arg_3_1.effect_equipment_proficiency
		}

		var_3_12[3] = var_3_1[var_3_2 + 1] or ""

		table.insert(var_3_0, var_3_12)
	end

	arg_3_1.special_effect = var_3_0

	return
end

function ShipBluePrint:updateInfo(arg_4_1)
	self.startTime = arg_4_1.start_time or 0
	self.shipId = arg_4_1.ship_id or 0
	self.level = arg_4_1.blue_print_level and math.min(arg_4_1.blue_print_level, self:getMaxLevel()) or 0
	self.fateLevel = self.level == self:getMaxLevel() and arg_4_1.blue_print_level - self:getMaxLevel() or -1
	self.exp = arg_4_1.exp or 0
	self.duration = arg_4_1.start_duration or 0

	self:updateState()

	return
end

function ShipBluePrint:updateStartUpTime(arg_5_1)
	self.duration = arg_5_1

	return
end

function ShipBluePrint:updateState()
	self.state = self:isFetched() and ShipBluePrint.STATE_UNLOCK or self.startTime == 0 and ShipBluePrint.STATE_LOCK or self:isFinishedAllTasks() and ShipBluePrint.STATE_DEV_FINISHED or ShipBluePrint.STATE_DEV

	return
end

function ShipBluePrint:addExp(arg_7_1)
	assert(arg_7_1, "exp can not be nil")

	self.exp = self.exp + arg_7_1

	local var_7_0 = self:getMaxLevel()

	if var_7_0 > self.level then
		while self:canLevelUp() do
			self.exp = self.exp - self:getNextLevelExp()
			self.level = math.min(self.level + 1, var_7_0)
		end

		if self.level == var_7_0 then
			self.fateLevel = 0
		end
	end

	if self:canFateSimulation() then
		local var_7_1 = self:getMaxFateLevel()

		while self:canFateLevelUp() do
			self.exp = self.exp - self:getNextFateLevelExp()
			self.fateLevel = math.min(self.fateLevel + 1, var_7_1)
		end
	end

	return
end

function ShipBluePrint:getNextLevelExp()
	if self.level == self:getMaxLevel() then
		return -1
	else
		return self.strengthenConfig[self.level + 1].need_exp
	end

	return
end

function ShipBluePrint:getNextFateLevelExp()
	if self.fateLevel == self:getMaxFateLevel() then
		return -1
	else
		return self.fateStrengthenConfig[self.fateLevel + 1].need_exp
	end

	return
end

function ShipBluePrint:canLevelUp()
	if self.level == self:getMaxLevel() then
		return false
	end

	if self:getNextLevelExp() <= self.exp then
		return true
	end

	return false
end

function ShipBluePrint:canFateSimulation()
	return #self.fateStrengthenConfig > 0 and self.fateLevel >= 0
end

function ShipBluePrint:canFateLevelUp()
	if self.fateLevel == self:getMaxFateLevel() then
		return false
	end

	if self:getNextFateLevelExp() <= self.exp then
		return true
	end

	return false
end

function ShipBluePrint:getMaxLevel()
	return self.strengthenConfig[#self.strengthenConfig].lv
end

function ShipBluePrint:getMaxFateLevel()
	return self.fateStrengthenConfig[#self.fateStrengthenConfig].lv - 30
end

function ShipBluePrint:isMaxLevel()
	return self.level == self:getMaxLevel()
end

function ShipBluePrint:isMaxFateLevel()
	return self.fateLevel == self:getMaxFateLevel()
end

function ShipBluePrint:isMaxIntensifyLevel()
	if #self:getConfig("fate_strengthen") > 0 then
		return self:isMaxFateLevel()
	else
		return self:isMaxLevel()
	end

	return
end

function ShipBluePrint:getBluePrintAddition(arg_18_1)
	local var_18_0 = table.indexof(ShipModAttr.BLUEPRINT_ATTRS, arg_18_1)
	local var_18_1 = self:getConfig("attr_exp")[var_18_0]

	if var_18_1 then
		local var_18_2 = 0

		for iter_18_0 = 1, self.level do
			var_18_2 = var_18_2 + self.strengthenConfig[iter_18_0].effect[var_18_0]
		end

		local var_18_3 = 0

		if not self:isMaxLevel() then
			var_18_3 = self.exp / self:getNextLevelExp() * self.strengthenConfig[self.level + 1].effect[var_18_0]
		end

		return (var_18_2 + var_18_3) / var_18_1, (var_18_2 + var_18_3) % var_18_1
	else
		return 0, 0
	end

	return
end

function ShipBluePrint:getShipVO()
	return Ship.New({
		configId = tonumber(self.id .. "1")
	})
end

function ShipBluePrint:isFetched()
	return self.shipId ~= 0
end

function ShipBluePrint:getState()
	return self.state
end

function ShipBluePrint:start(arg_22_1)
	self.state = ShipBluePrint.STATE_DEV
	self.startTime = arg_22_1
	self.duration = 0

	return
end

function ShipBluePrint:reset()
	self.state = ShipBluePrint.STATE_LOCK
	self.startTime = 0

	return
end

function ShipBluePrint:isLock()
	return self.state == ShipBluePrint.STATE_LOCK
end

function ShipBluePrint:isDeving()
	return self.state == ShipBluePrint.STATE_DEV
end

function ShipBluePrint:isFinished()
	return self.state == ShipBluePrint.STATE_DEV_FINISHED
end

function ShipBluePrint:finish()
	self.state = ShipBluePrint.STATE_DEV_FINISHED

	return
end

function ShipBluePrint:unlock(arg_28_1)
	self.shipId = arg_28_1
	self.state = ShipBluePrint.STATE_UNLOCK
	self.duration = 0

	return
end

function ShipBluePrint:isUnlock()
	return self.state == ShipBluePrint.STATE_UNLOCK
end

function ShipBluePrint:getItemId()
	return self:getConfig("strengthen_item")
end

function ShipBluePrint:bindConfigTable()
	return pg.ship_data_blueprint
end

function ShipBluePrint:getTaskIds()
	return _.map(self:getConfig("unlock_task"), function(arg_33_0)
		return arg_33_0[1]
	end)
end

function ShipBluePrint:getTaskOpenTimeStamp(arg_34_1)
	return self:getConfig("unlock_task")[table.indexof(self:getTaskIds(), arg_34_1)][2] + self.startTime + 1
end

function ShipBluePrint:isFinishedAllTasks()
	local var_35_0 = getProxy(TaskProxy)

	return _.all(self:getTaskIds(), function(arg_36_0)
		return self:getTaskStateById(arg_36_0) == ShipBluePrint.TASK_STATE_FINISHED
	end)
end

function ShipBluePrint:getTaskStateById(arg_37_1)
	if self:isLock() then
		if self.duration > 0 then
			return ShipBluePrint.TASK_STATE_PAUSE
		else
			return ShipBluePrint.TASK_STATE_LOCK
		end
	elseif self:getTaskOpenTimeStamp(arg_37_1) > pg.TimeMgr.GetInstance():GetServerTime() then
		return ShipBluePrint.TASK_STATE_WAIT
	else
		local var_37_0 = getProxy(TaskProxy):getTaskVO(arg_37_1)

		if var_37_0 and var_37_0:isReceive() then
			return ShipBluePrint.TASK_STATE_FINISHED
		elseif var_37_0 and var_37_0:isFinish() then
			return ShipBluePrint.TASK_STATE_ACHIEVED
		elseif var_37_0 then
			return ShipBluePrint.TASK_STATE_START
		else
			return ShipBluePrint.TASK_STATE_OPENING
		end
	end

	return
end

function ShipBluePrint:getExpRetio(arg_38_1)
	local var_38_0 = self:getConfig("attr_exp")

	assert(arg_38_1 > 0 and arg_38_1 <= #var_38_0, "invalid index" .. arg_38_1)

	return var_38_0[arg_38_1]
end

function ShipBluePrint:specialStrengthens()
	local var_39_0 = {}
	local var_39_1 = noEmptyStr(self:getConfig("normal_display"))

	if var_39_1 then
		table.insert(var_39_0, {
			level = 0,
			des = {},
			extraDes = var_39_1
		})
	end

	for iter_39_0, iter_39_1 in ipairs(self.strengthenConfig) do
		if iter_39_1.special == 1 then
			table.insert(var_39_0, {
				des = iter_39_1.special_effect,
				extraDes = iter_39_1.extra_desc,
				level = iter_39_1.lv
			})
		end
	end

	return var_39_0
end

function ShipBluePrint:getSpecials()
	return self.strengthenConfig[self.level].special_effect
end

function ShipBluePrint:getTopLimitAttrValue(arg_41_1)
	if self.level == 0 then
		return 0
	else
		assert(self.strengthenConfig[self.level].effect[arg_41_1], "strengthen config effect" .. arg_41_1)

		return math.floor(self.strengthenConfig[self.level].effect[arg_41_1] / self:getConfig("attr_exp")[arg_41_1])
	end

	return
end

function ShipBluePrint:getItemExp()
	return Item.getConfigData((self:getConfig("strengthen_item"))).usage_arg[1]
end

function ShipBluePrint:getShipProperties(arg_43_1, arg_43_2)
	assert(arg_43_1, "shipVO can not be nil" .. self.shipId)

	local var_43_0 = arg_43_1:getBaseProperties()

	arg_43_2 = defaultValue(arg_43_2, true)

	local var_43_1 = self:getTotalAdditions()

	for iter_43_0, iter_43_1 in pairs(var_43_0) do
		var_43_0[iter_43_0] = var_43_0[iter_43_0] + (var_43_1[iter_43_0] or 0)
	end

	if arg_43_1:getIntimacyLevel() > 0 and arg_43_2 then
		local var_43_3 = pg.intimacy_template[arg_43_1:getIntimacyLevel()].attr_bonus * 0.0001

		for iter_43_2, iter_43_3 in pairs(var_43_0) do
			if iter_43_2 == AttributeType.Durability or iter_43_2 == AttributeType.Cannon or iter_43_2 == AttributeType.Torpedo or iter_43_2 == AttributeType.AntiAircraft or iter_43_2 == AttributeType.Air or iter_43_2 == AttributeType.Reload or iter_43_2 == AttributeType.Hit or iter_43_2 == AttributeType.AntiSub or iter_43_2 == AttributeType.Dodge then
				var_43_0[iter_43_2] = var_43_0[iter_43_2] * (var_43_3 + 1)
			end
		end
	end

	return var_43_0
end

function ShipBluePrint:getTotalAdditions()
	local var_44_0 = {}
	local var_44_1 = self:attrSpecialAddition()

	for iter_44_0, iter_44_1 in ipairs(Ship.PROPERTIES) do
		local var_44_2, var_44_3 = self:getBluePrintAddition(iter_44_1)

		var_44_0[iter_44_1] = var_44_2 + (var_44_1[iter_44_1] or 0)
	end

	return var_44_0
end

function ShipBluePrint:attrSpecialAddition()
	local var_45_0 = {}

	for iter_45_0 = 1, self.level do
		if self.strengthenConfig[iter_45_0].special == 1 and type(self.strengthenConfig[iter_45_0].special_effect) == "table" then
			for iter_45_1, iter_45_2 in ipairs(self.strengthenConfig[iter_45_0].special_effect) do
				if iter_45_2[1] == ShipBluePrint.STRENGTHEN_TYPE_ATTR then
					var_45_0[iter_45_2[2][1]] = (var_45_0[iter_45_2[2][1]] or 0) + iter_45_2[2][2]
				end
			end
		end
	end

	for iter_45_3 = 1, self.fateLevel do
		if self.fateStrengthenConfig[iter_45_3].special == 1 and type(self.fateStrengthenConfig[iter_45_3].special_effect) == "table" then
			for iter_45_4, iter_45_5 in ipairs(self.fateStrengthenConfig[iter_45_3].special_effect) do
				if iter_45_5[1] == ShipBluePrint.STRENGTHEN_TYPE_ATTR then
					var_45_0[iter_45_5[2][1]] = (var_45_0[iter_45_5[2][1]] or 0) + iter_45_5[2][2]
				end
			end
		end
	end

	return var_45_0
end

function ShipBluePrint:getUseageMaxItem()
	local var_46_0 = 0

	for iter_46_0 = self.level + 1, self:getMaxLevel() do
		assert(self.strengthenConfig[iter_46_0], "strengthen config >> " .. iter_46_0)

		var_46_0 = var_46_0 + self.strengthenConfig[iter_46_0].need_exp
	end

	return math.max(math.ceil((var_46_0 - self.exp) / self:getItemExp()), 0)
end

function ShipBluePrint:getFateUseageMaxItem()
	local var_47_0 = 0

	for iter_47_0 = self.fateLevel + 1, self:getMaxFateLevel() do
		assert(self.fateStrengthenConfig[iter_47_0], "strengthen config >> " .. iter_47_0)

		var_47_0 = var_47_0 + self.fateStrengthenConfig[iter_47_0].need_exp
	end

	return math.max(math.ceil((var_47_0 - self.exp) / self:getItemExp()), 0)
end

function ShipBluePrint:getOpenTaskList()
	return self:getConfig("unlock_task_open_condition")
end

function ShipBluePrint:getStrengthenConfig(arg_49_1)
	return self.strengthenConfig[arg_49_1]
end

function ShipBluePrint:getFateStrengthenConfig(arg_50_1)
	return self.fateStrengthenConfig[arg_50_1]
end

function ShipBluePrint:getUnlockVoices()
	local var_51_0 = {}

	for iter_51_0 = 1, self.level do
		local var_51_1 = self:getStrengthenConfig(iter_51_0)

		if var_51_1.special == 1 then
			if type(var_51_1.special_effect) == "table" then
				for iter_51_1, iter_51_2 in ipairs(var_51_1.special_effect) do
					if iter_51_2[1] == ShipBluePrint.STRENGTHEN_TYPE_DIALOGUE then
						for iter_51_3, iter_51_4 in ipairs(iter_51_2[2]) do
							table.insert(var_51_0, iter_51_4)
						end
					end
				end
			end
		end
	end

	return var_51_0
end

function ShipBluePrint:getUnlockLevel(arg_52_1)
	for iter_52_0 = 1, self:getMaxLevel() do
		local var_52_0 = self:getStrengthenConfig(iter_52_0).special_effect

		if type(var_52_0) == "table" then
			for iter_52_1, iter_52_2 in ipairs(var_52_0) do
				if iter_52_2[1] == ShipBluePrint.STRENGTHEN_TYPE_DIALOGUE then
					for iter_52_3, iter_52_4 in ipairs(iter_52_2[2]) do
						if arg_52_1 == iter_52_4 then
							return iter_52_0
						end
					end
				end
			end
		end
	end

	return 0
end

function ShipBluePrint:getBaseList(arg_53_1)
	assert(arg_53_1, "shipVO can not be nil" .. self.shipId)

	for iter_53_0 = self.level, 1, -1 do
		local var_53_0 = self:getStrengthenConfig(iter_53_0)

		if var_53_0.special == 1 then
			for iter_53_1, iter_53_2 in ipairs(var_53_0.special_effect) do
				if iter_53_2[1] == ShipBluePrint.STRENGTHEN_TYPE_BASE_LIST then
					return iter_53_2[2]
				end
			end
		end
	end

	return arg_53_1:getConfig("base_list")
end

function ShipBluePrint:getPreLoadCount(arg_54_1)
	assert(arg_54_1, "shipVO can not be nil" .. self.shipId)

	for iter_54_0 = self.level, 1, -1 do
		local var_54_0 = self:getStrengthenConfig(iter_54_0)

		if var_54_0.special == 1 then
			for iter_54_1, iter_54_2 in ipairs(var_54_0.special_effect) do
				if iter_54_2[1] == ShipBluePrint.STRENGTHEN_TYPE_PRLOAD_COUNT then
					return iter_54_2[2]
				end
			end
		end
	end

	return arg_54_1:getConfig("preload_count")
end

function ShipBluePrint:getEquipProficiencyList(arg_55_1)
	assert(arg_55_1, "shipVO can not be nil" .. self.shipId)

	local var_55_0 = {}

	for iter_55_0 = 1, self.level do
		local var_55_1 = self:getStrengthenConfig(iter_55_0)

		if var_55_1.special == 1 then
			for iter_55_1, iter_55_2 in ipairs(var_55_1.special_effect) do
				if iter_55_2[1] == ShipBluePrint.STRENGTHEN_TYPE_EQUIPMENTPROFICIENCY then
					var_55_0[iter_55_2[2][1]] = (var_55_0[iter_55_2[2][1]] or 0) + iter_55_2[2][2]
				end
			end
		end
	end

	local var_55_3 = Clone(arg_55_1:getConfig("equipment_proficiency"))

	for iter_55_3, iter_55_4 in pairs(var_55_0) do
		var_55_3[iter_55_3] = var_55_3[iter_55_3] + iter_55_4
	end

	return var_55_3
end

function ShipBluePrint:isFinishPrevTask()
	local var_56_0 = true

	for iter_56_0, iter_56_1 in ipairs(self:getOpenTaskList()) do
		local var_56_1 = getProxy(TaskProxy):getTaskVO(iter_56_1)

		if not var_56_1 or not var_56_1:isFinish() then
			return false, false
		else
			var_56_0 = (var_56_1:isReceive() or false) and var_56_0
		end
	end

	return true, var_56_0
end

function ShipBluePrint:isShipModMaxLevel(arg_57_1)
	assert(arg_57_1, "shipVO can not be nil" .. self.shipId)

	local var_57_0 = self:getStrengthenConfig(math.min(self.level + 1, self:getMaxLevel()))

	if not self:isMaxLevel() and arg_57_1.level < var_57_0.need_lv then
		return true, var_57_0.need_lv
	else
		return false
	end

	return
end

function ShipBluePrint:isShipModMaxFateLevel(arg_58_1)
	assert(arg_58_1, "shipVO can not be nil" .. self.shipId)

	local var_58_0 = self:getFateStrengthenConfig(math.min(self.fateLevel + 1, self:getMaxFateLevel()))

	if not self:isMaxFateLevel() and arg_58_1.level < var_58_0.need_lv then
		return true, var_58_0.need_lv
	else
		return false
	end

	return
end

function ShipBluePrint:isShipModMaxIntensifyLevel(arg_59_1)
	if self:canFateSimulation() then
		return self:isShipModMaxFateLevel(arg_59_1)
	else
		return self:isShipModMaxLevel(arg_59_1)
	end

	return
end

function ShipBluePrint:getChangeSkillList()
	return self:getConfig("change_skill")
end

function ShipBluePrint:isRarityUR()
	return self:getShipVO():getRarity() >= ShipRarity.SSR
end

function ShipBluePrint:getFateMaxLeftOver()
	local var_62_0

	if self:isRarityUR() then
		var_62_0 = pg.gameset.fate_sim_ur.key_value or pg.gameset.fate_sim_ssr.key_value
	end

	local var_62_1 = var_62_0 - self:getFateUseNum()

	return var_62_1 < 0 and var_62_0 or var_62_1
end

function ShipBluePrint:getFateUseNum()
	local var_63_0 = 0

	if self:isMaxLevel() then
		local var_63_1 = 0

		for iter_63_0, iter_63_1 in ipairs(self.fateStrengthenConfig) do
			if iter_63_1.lv <= 30 + self.fateLevel then
				var_63_1 = var_63_1 + iter_63_1.need_exp
			end
		end

		var_63_0 = math.floor((var_63_1 + self.exp) / self:getItemExp())
	end

	return var_63_0
end

function ShipBluePrint:isPursuing()
	return self:getConfig("is_pursuing") == 1
end

function ShipBluePrint:getPursuingPrice(arg_65_1)
	arg_65_1 = arg_65_1 or 100

	return self:getConfig("price") * arg_65_1 / 100
end

function ShipBluePrint:getUnlockItem()
	local var_66_0 = getProxy(BagProxy)

	for iter_66_0, iter_66_1 in ipairs(self:getConfig("gain_item_id")) do
		if var_66_0:getItemCountById(iter_66_1) > 0 then
			return iter_66_1
		end
	end

	return
end

function ShipBluePrint:isPursuingCostTip()
	local var_67_0 = self:isPursuing()

	if var_67_0 then
		var_67_0 = self:isUnlock()

		if var_67_0 then
			if not self:isMaxIntensifyLevel() then
				if not self:isShipModMaxIntensifyLevel(getProxy(BayProxy):getShipById(self.shipId)) then
					if getProxy(TechnologyProxy):calcPursuingCost(self, 1) ~= 0 then
						var_67_0 = false

						goto label_67_0
					end
				end
			end

			var_67_0 = true
		end
	end

	::label_67_0::

	return var_67_0
end

function ShipBluePrint:setPhantomQuestProgress(arg_68_1, arg_68_2)
	self.phantomQuestProgress = self.phantomQuestProgress or {}
	self.phantomQuestProgress[arg_68_1] = arg_68_2

	return
end

function ShipBluePrint:getPhantomQuestCostDrop()
	if self.config.type == 5 then
		return Drop.New({
			type = DROP_TYPE_RESOURCE,
			id = PlayerConst.ResDiamond,
			count = self.config.target_num
		})
	else
		return nil
	end

	return
end

function ShipBluePrint:getPhantomQuestProgress(arg_70_1)
	assert(self.shipId)

	return switch(arg_70_1, {
		function()
			return getProxy(BayProxy):getShipById(self.shipId).level
		end,
		function()
			return self.level + (self.level < self:getMaxLevel() and 0 or self.fateLevel)
		end,
		function()
			return self.phantomQuestProgress[3] or 0
		end,
		function()
			return getProxy(BayProxy):getShipById(self.shipId).propose and 1 or 0
		end,
		function()
			return Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResDiamond
			}):getOwnedCount()
		end
	})
end

function ShipBluePrint:getPhantomQuestInfo(arg_76_1)
	local var_76_0 = {
		config = pg.technology_shadow_unlock[arg_76_1],
		progress = self:getPhantomQuestProgress(pg.technology_shadow_unlock[arg_76_1].type)
	}

	var_76_0.unlocked = tobool(getProxy(BayProxy):getShipById(self.shipId).phantomDic[arg_76_1])

	return var_76_0
end

function ShipBluePrint:getAllPhantomQuestInfo()
	return underscore.map(pg.technology_shadow_unlock.all, function(arg_78_0)
		return self:getPhantomQuestInfo(arg_78_0)
	end)
end

function ShipBluePrint:isUnlockShipPhantom()
	local var_79_0 = self:isFetched()

	if var_79_0 then
		var_79_0 = getGameset("technology_shadow_unlock_lv")[1] <= getProxy(BayProxy):getShipById(self.shipId).level
	end

	return var_79_0
end

function ShipBluePrint:IsFate()
	return #self:getConfig("fate_strengthen") > 0
end

return ShipBluePrint
