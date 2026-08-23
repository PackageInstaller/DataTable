local var_0_0 = g.core.config.gve_equipment_info
local var_0_1 = g.core.config.gve_equipment_skill_info
local var_0_2 = g.core.config.gve_equipment_resource_info
local var_0_3 = g.core.const.ConstMgr.GveConst.HALIDOM_STATUS
local var_0_4 = 6
local GveHalidomStruct = require("app.view.module.gve.model.struct.GveHalidomStruct")
local GveBagData = class("GveBagData")

function GveBagData:ctor()
	self:initData()
end

function GveBagData:initData()
	self._equipHalidomList = {}
	self._bagList = {}
	self._fightValue = 0
	self._switchBranchTime = 0
	self._coreHalidomLevel = 1
	self._branch = 0
	self._selectBranchLevel = 3

	self:initSkillCfg()
	self:initBranchResource()
end

function GveBagData:updateRedInfo(arg_3_1)
	self._equipHalidomList = self:_createHalidomList(arg_3_1.halidom_info.equipment or {}, true)
	self._bagList = self:_createHalidomList(arg_3_1.halidom_info.bag or {}, false)

	self:_setCoreHalidomBranch()
	self:_setCoreHalidomLevel()
end

function GveBagData:updateInfo(arg_4_1)
	self._equipHalidomList = self:_createHalidomList(arg_4_1.halidom_info.equipment or {}, true)
	self._bagList = self:_createHalidomList(arg_4_1.halidom_info.bag or {}, false)
	self._fightValue = arg_4_1.halidom_fight_value
	self._switchBranchTime = arg_4_1.job_switch_end_timestamp or 0

	self:_setCoreHalidomBranch()
	self:_setCoreHalidomLevel()
end

function GveBagData:initSkillCfg()
	self._skillCfgMap = {}
	self._skillTypeMap = {}

	for iter_5_0 = 1, var_0_1.getLength() do
		local var_5_0 = var_0_1.indexOf(iter_5_0)

		self._skillCfgMap[var_5_0.job] = self._skillCfgMap[var_5_0.job] or {}
		self._skillTypeMap[var_5_0.main_skill_type] = var_5_0

		table.insert(self._skillCfgMap[var_5_0.job], {
			cfg = var_5_0,
			needLv = var_5_0.main_skill_unlock_level
		})
	end

	for iter_5_1, iter_5_2 in pairs(self._skillCfgMap) do
		table.sort(iter_5_2, function(arg_6_0, arg_6_1)
			if arg_6_0.needLv ~= arg_6_1.needLv then
				return arg_6_0.needLv < arg_6_1.needLv
			end

			return false
		end)
	end
end

function GveBagData:initBranchResource()
	self._branchResourceCfg = {}

	for iter_7_0 = 1, var_0_2.getLength() do
		local var_7_0 = var_0_2.indexOf(iter_7_0)

		self._branchResourceCfg[var_7_0.job] = var_7_0
	end
end

function GveBagData:getCfgBySkillType(arg_8_1)
	return self._skillTypeMap[arg_8_1]
end

function GveBagData:getTargetResourceCfg(arg_9_1)
	return self._branchResourceCfg[arg_9_1]
end

function GveBagData:getAllTargetJobSkillCfg(arg_10_1)
	return self._skillCfgMap[arg_10_1]
end

function GveBagData:onS2CHalidomMergeSuccess(arg_11_1)
	if not arg_11_1.is_equip then
		-- block empty
	else
		local var_11_0 = {}

		var_11_0.id = var_0_0.get(arg_11_1.merge_config_id).location
		var_11_0.num = arg_11_1.merge_config_id

		table.insert(self._equipHalidomList, (GveHalidomStruct.new(var_11_0, true)))
	end

	self._fightValue = arg_11_1.halidom_fight_value or self._fightValue
end

function GveBagData:onS2CFastDecompose(arg_12_1)
	return
end

function GveBagData:onS2CLevelUp(arg_13_1)
	self:setOriAttrList((self:getAttrList()))

	for iter_13_0 = #self._equipHalidomList, 1, -1 do
		if self._equipHalidomList[iter_13_0]:getPosition() == 0 then
			self._equipHalidomList[iter_13_0]:updateData({
				id = 0,
				num = arg_13_1.new_config_id
			}, true)
		else
			table.remove(self._equipHalidomList, iter_13_0)
		end
	end

	if arg_13_1.halidom_fight_value then
		self._fightValue = arg_13_1.halidom_fight_value
	end

	self:_setCoreHalidomBranch()
	self:_setCoreHalidomLevel()
end

function GveBagData:onS2CSwitchJob(arg_14_1)
	for iter_14_0 = 1, #arg_14_1.equip do
		for iter_14_1 = 1, #self._equipHalidomList do
			if self._equipHalidomList[iter_14_1]:getPosition() == arg_14_1.equip[iter_14_0].id then
				self._equipHalidomList[iter_14_1]:updateData(arg_14_1.equip[iter_14_0], true)
			end
		end
	end

	if arg_14_1.halidom_fight_value then
		self._fightValue = arg_14_1.halidom_fight_value
	end

	self._switchBranchTime = arg_14_1.job_switch_end_timestamp or 0

	self:_setCoreHalidomBranch()
	self:_setCoreHalidomLevel()
end

function GveBagData:onS2CEquip(arg_15_1)
	self:setOriAttrList((self:getAttrList()))
	table.insert(self._equipHalidomList, (GveHalidomStruct.new({
		id = var_0_0.get(arg_15_1.config_id).location,
		num = arg_15_1.config_id
	}, true)))

	if arg_15_1.halidom_fight_value then
		self._fightValue = arg_15_1.halidom_fight_value
	end
end

function GveBagData:onS2CDecompose(arg_16_1)
	return
end

function GveBagData:_createHalidomList(arg_17_1, arg_17_2)
	local var_17_0 = {}

	for iter_17_0 = 1, #arg_17_1 do
		table.insert(var_17_0, (GveHalidomStruct.new(arg_17_1[iter_17_0], arg_17_2)))
	end

	return var_17_0
end

function GveBagData:_setCoreHalidomLevel()
	self._coreHalidomLevel = self:getEquipHalidomByPosition(0):getLevel()
end

function GveBagData:_setCoreHalidomBranch()
	self._branch = self:getEquipHalidomByPosition(0):getBranch()
end

function GveBagData:getEquipHalidomByPosition(arg_20_1)
	for iter_20_0 = 1, #self._equipHalidomList do
		if self._equipHalidomList[iter_20_0]:getPosition() == arg_20_1 then
			return self._equipHalidomList[iter_20_0]
		end
	end

	return {}
end

function GveBagData:getPositionStatus(arg_21_1)
	local var_21_0 = var_0_3.CAN_NOT_EUIP

	if next((self:getEquipHalidomByPosition(arg_21_1))) then
		var_21_0 = var_0_3.HAVE_EQUIP
	else
		local var_21_1 = self:getCoreHalidomBranch()
		local var_21_2 = self:getCoreHalidomLevel()
		local var_21_3 = self:getCommonHalidomByPBL(arg_21_1, var_21_1, var_21_2)

		if var_21_3 and next(var_21_3) then
			var_21_0 = var_0_3.CAN_EUIP
		else
			local var_21_4, var_21_5 = self:getComposeItems((self:getHalidomIdByPBL(arg_21_1, var_21_1, var_21_2)))

			var_21_0 = var_21_4 and var_0_3.CAN_COMPOSE or var_0_3.CAN_NOT_EUIP
		end
	end

	return var_21_0
end

function GveBagData:getHalidomIdByPBL(arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = var_0_0.match(function(arg_23_0)
		return arg_23_0.location == arg_22_1 and arg_23_0.level == arg_22_3 and arg_23_0.job == arg_22_2
	end)

	if var_22_0[1] and var_22_0[1].id then
		return var_22_0[1].id
	else
		return 0
	end
end

function GveBagData:getComposeItems(arg_24_1)
	local var_24_0 = var_0_0.get(arg_24_1)
	local var_24_2 = {}
	local var_24_3 = self:getCoreHalidomBranch()
	local var_24_4 = var_24_0.location
	local var_24_5 = {}

	var_24_5 = var_24_3 == 0 and self:getSPCommonHalidom(function(arg_25_0)
		return arg_25_0:getBranch() == 0 and arg_25_0:getLevel() < var_24_0.level and arg_25_0:getPosition() == var_24_4
	end) or self:getSPCommonHalidom(function(arg_26_0)
		return (arg_26_0:getBranch() == 0 and arg_26_0:getLevel() < var_24_0.level or arg_26_0:getBranch() == var_24_3 and arg_26_0:getLevel() < var_24_0.level) and arg_26_0:getPosition() == var_24_4
	end)

	local var_24_6 = var_24_0.price
	local var_24_7 = 0

	table.sort(var_24_5, function(arg_27_0, arg_27_1)
		return arg_27_0:getLevel() > arg_27_1:getLevel()
	end)

	for iter_24_0 = 1, #var_24_5 do
		local var_24_9 = var_24_5[iter_24_0]:getPrice()
		local var_24_10 = 0

		for iter_24_1 = 1, var_24_5[iter_24_0]:getNum() do
			var_24_7 = var_24_7 + var_24_9

			if var_24_7 - var_24_6 > 0 then
				var_24_7 = var_24_7 - var_24_9
			else
				var_24_10 = var_24_10 + 1
			end
		end

		if var_24_10 > 0 then
			table.insert(var_24_2, {
				halidom = var_24_5[iter_24_0],
				needNum = var_24_10
			})
		end
	end

	return g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_GVE_COMMON_RESOURCE) >= var_24_6 - var_24_7, var_24_2, var_24_6 - var_24_7
end

function GveBagData:getCommonHalidomByPBL(arg_28_1, arg_28_2, arg_28_3)
	return self:getSPCommonHalidom(function(arg_29_0)
		return arg_29_0:getPosition() == arg_28_1 and arg_29_0:getBranch() == arg_28_2 and arg_29_0:getLevel() == arg_28_3
	end)[1]
end

function GveBagData:getSPCommonHalidom(arg_30_1)
	local var_30_0 = {}

	for iter_30_0, iter_30_1 in ipairs(self._bagList) do
		if arg_30_1(iter_30_1) then
			var_30_0[#var_30_0 + 1] = iter_30_1
		end
	end

	table.sort(var_30_0, function(arg_31_0, arg_31_1)
		return arg_31_0:getLevel() > arg_31_1:getLevel()
	end)

	return var_30_0
end

function GveBagData:getSelectBranchLevel()
	return self._selectBranchLevel
end

function GveBagData:isSelectBranchDirectly()
	return self._selectBranchLevel
end

function GveBagData:getCoreHalidomLevel()
	return self._coreHalidomLevel
end

function GveBagData:getCoreHalidomBranch()
	return self._branch
end

function GveBagData:getNotEquipCommonHalidomList()
	return self._bagList
end

function GveBagData:getEquipCommonHalidomList()
	local var_37_0 = {}

	for iter_37_0 = 1, #self._equipHalidomList do
		if self._equipHalidomList[iter_37_0]:getPosition() ~= 0 then
			table.insert(var_37_0, self._equipHalidomList[iter_37_0])
		end
	end

	return var_37_0
end

function GveBagData:getRecycleMoney(arg_38_1)
	local var_38_0 = 0

	if arg_38_1 then
		var_38_0 = arg_38_1:getRecyclePrice() * arg_38_1:getNum()
	else
		local var_38_1 = self:getCoreHalidomBranch()
		local var_38_2 = self:getSPCommonHalidom(function(arg_39_0)
			return arg_39_0:getBranch() ~= 0 and var_38_1 ~= arg_39_0:getBranch()
		end)

		for iter_38_0 = 1, #var_38_2 do
			var_38_0 = var_38_0 + var_38_2[iter_38_0]:getRecyclePrice() * var_38_2[iter_38_0]:getNum()
		end
	end

	return var_38_0
end

function GveBagData:getFightValue()
	return self._fightValue or 0
end

function GveBagData:getCanUpLevel()
	return true
end

function GveBagData:getAttrList(arg_42_1)
	local var_42_0 = {}
	local var_42_1 = {}
	local var_42_2 = {}

	if arg_42_1 then
		table.insert(var_42_2, arg_42_1)
	else
		var_42_2 = self._equipHalidomList
	end

	for iter_42_0 = 1, #var_42_2 do
		local var_42_3 = var_42_2[iter_42_0]:getCfg()

		while var_0_0.hasKey("attribute_type_" .. 1) do
			if var_42_3["attribute_type_" .. 1] ~= 0 and var_42_3["attribute_value_" .. 1] ~= 0 then
				var_42_0[var_42_3["attribute_type_" .. 1]] = var_42_0[var_42_3["attribute_type_" .. 1]] or 0
				var_42_0[var_42_3["attribute_type_" .. 1]] = var_42_0[var_42_3["attribute_type_" .. 1]] + var_42_3["attribute_value_" .. 1]
			end
		end
	end

	for iter_42_1, iter_42_2 in pairs(var_42_0) do
		table.insert(var_42_1, {
			type = iter_42_1,
			value = iter_42_2
		})
	end

	table.sort(var_42_1, function(arg_43_0, arg_43_1)
		return arg_43_0.type < arg_43_1.type
	end)

	return var_42_1, var_42_0
end

function GveBagData:getHalidomIdByPBL(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = var_0_0.match(function(arg_45_0)
		return arg_45_0.level == arg_44_3 and arg_45_0.job == arg_44_2 and arg_45_0.location == arg_44_1
	end)

	if var_44_0[1] and var_44_0[1].id then
		return var_44_0[1].id
	else
		return 0
	end
end

function GveBagData:addBagHalidomList(arg_46_1)
	for iter_46_0 = 1, #arg_46_1 do
		local var_46_0 = false

		for iter_46_1 = 1, #self._bagList do
			if self._bagList[iter_46_1]:getId() == arg_46_1[iter_46_0].id then
				var_46_0 = true

				self._bagList[iter_46_1]:setNum(self._bagList[iter_46_1]:getNum() + arg_46_1[iter_46_0].num)
			end
		end

		if not var_46_0 then
			table.insert(self._bagList, (GveHalidomStruct.new({
				id = arg_46_1[iter_46_0].id,
				num = arg_46_1[iter_46_0].num
			}, false)))
		end
	end
end

function GveBagData:updateBagHalidomList(arg_47_1)
	for iter_47_0 = 1, #arg_47_1 do
		for iter_47_1 = 1, #self._bagList do
			if self._bagList[iter_47_1]:getId() == arg_47_1[iter_47_0].id then
				self._bagList[iter_47_1]:setNum(arg_47_1[iter_47_0].num)
			end
		end
	end
end

function GveBagData:removeBagHalidomList(arg_48_1)
	for iter_48_0 = 1, #arg_48_1 do
		for iter_48_1 = #self._bagList, 1, -1 do
			if self._bagList[iter_48_1]:getId() == arg_48_1[iter_48_0].id then
				local var_48_0 = self._bagList[iter_48_1]:getNum() - arg_48_1[iter_48_0].num

				if var_48_0 > 0 then
					self._bagList[iter_48_1]:setNum(var_48_0)
				else
					self._bagList[iter_48_1]:setNum(0)
					table.remove(self._bagList, iter_48_1)
				end
			end
		end
	end
end

function GveBagData:deleteBagHalidomList(arg_49_1)
	for iter_49_0 = 1, #arg_49_1 do
		for iter_49_1 = #self._bagList, 1, -1 do
			if self._bagList[iter_49_1]:getId() == arg_49_1[iter_49_0] then
				self._bagList[iter_49_1]:setNum(0)
				table.remove(self._bagList, iter_49_1)
			end
		end
	end
end

function GveBagData:getBranchAllHalidomListByPB(arg_50_1, arg_50_2)
	local var_50_0 = arg_50_2 or self:getCoreHalidomBranch()
	local var_50_1 = {}
	local var_50_2 = {}
	local var_50_3 = self:getSelectBranchLimitLevel()

	var_50_1 = var_50_0 == 0 and var_0_0.match(function(arg_51_0)
		return arg_51_0.location == arg_50_1 and arg_51_0.job == 0 and arg_51_0.level <= var_50_3
	end) or var_0_0.match(function(arg_52_0)
		return arg_52_0.location == arg_50_1 and arg_52_0.job == var_50_0 or arg_52_0.location == arg_50_1 and arg_52_0.job == 0 and arg_52_0.level <= var_50_3
	end)

	for iter_50_0 = 1, #var_50_1 do
		table.insert(var_50_2, (GveHalidomStruct.new({
			num = 0,
			id = var_50_1[iter_50_0].id
		})))
	end

	table.sort(var_50_2, function(arg_53_0, arg_53_1)
		return arg_53_0:getId() > arg_53_1:getId()
	end)

	return var_50_2
end

function GveBagData:canCoreHalidomLevelUp()
	local var_54_0 = true

	for iter_54_0 = 1, var_0_4 do
		local var_54_1 = self:getEquipHalidomByPosition(iter_54_0)

		if not var_54_1 or not next(var_54_1) then
			var_54_0 = false

			break
		end
	end

	return var_54_0
end

function GveBagData:canCoreHalidomLevelUp1()
	local var_55_0 = self:canCoreHalidomLevelUp()

	if var_55_0 then
		if not self:isFullLevel() and g.core.model.User.gveDataMgr:getGveTaskData():getPrivilegeLevel() < self:getEquipHalidomByPosition(0):getNeedTaskLevel() then
			var_55_0 = false
		end
	end

	return var_55_0
end

function GveBagData:isFullLevel()
	local var_56_0 = self:getCoreHalidomLevel()

	if self:getHalidomIdByPBL(0, self:getCoreHalidomBranch(), var_56_0 + 1) == 0 and self:getSelectBranchLimitLevel() < var_56_0 then
		return true
	end

	return false
end

function GveBagData:getSelectBranchLimitLevel()
	return g.core.config.parameter_info.get(20102).parameter
end

function GveBagData:getAfterSelectBranchLevel()
	return g.core.config.parameter_info.get(20103).parameter
end

function GveBagData:setOriAttrList(arg_59_1)
	self._oriAttrList = arg_59_1
end

function GveBagData:getOriAttrList()
	return self._oriAttrList or {}
end

function GveBagData:getNewSkill()
	local var_61_0 = self:getCoreHalidomLevel()
	local var_61_1 = self:getEquipHalidomByPosition(0):getCfg()

	while var_0_0.hasKey("main_skill_type_" .. 1) do
		if var_61_1["main_skill_type_" .. 1] ~= 0 and var_0_1.get(var_61_1["main_skill_type_" .. 1]).main_skill_unlock_level == var_61_0 then
			return true, var_61_1["main_skill_type_" .. 1]
		end
	end

	return false
end

function GveBagData:getCdTime()
	return self._switchBranchTime or 0
end

function GveBagData:getBranchCfgByBranchId(arg_63_1)
	return g.core.config.gve_equipment_resource_info.match(function(arg_64_0)
		return arg_64_0.job == arg_63_1
	end)[1] or {}
end

function GveBagData:getOwnNumberById(arg_65_1)
	for iter_65_0 = 1, #self._bagList do
		if self._bagList[iter_65_0]:getId() == arg_65_1 then
			return self._bagList[iter_65_0]:getNum()
		end
	end

	return 0
end

function GveBagData:checkOneHalidomAllEquip()
	return not (self:getCoreHalidomLevel() <= 1 and #self._equipHalidomList < 7)
end

function GveBagData:checkCoreHalidomLv4()
	return self:getCoreHalidomLevel() >= 4
end

function GveBagData:updateHalidomItems(arg_68_1)
	if arg_68_1.insert then
		self:addBagHalidomList(arg_68_1.insert)
	elseif arg_68_1.update then
		self:updateBagHalidomList(arg_68_1.update)
	elseif arg_68_1.del then
		self:deleteBagHalidomList(arg_68_1.del)
	end
end

return GveBagData
