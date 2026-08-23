local NewSlgSkillTreeTalentStruct = require("app.view.module.slg.model.NewSlgSkillTreeTalentStruct")
local var_0_1 = g.core.config.talent_skill_info
local var_0_2 = g.core.config.new_slg_main_technology_info
local var_0_3 = g.core.const.ConstMgr.NewSlgConst
local NewSlgSkillTreeData = class("NewSlgSkillTreeData")

function NewSlgSkillTreeData:ctor()
	self._talentDict = {}
	self._talentXList = {}
	self._talentMap = {}
	self._talentDetailInfo = {}
	self._unlockAction = {}

	self:initData()
end

function NewSlgSkillTreeData:initData()
	self:_initCfgData()
end

function NewSlgSkillTreeData:updateWithServerData(arg_3_1)
	self._unlockAction = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in ipairs(arg_3_1.tree.ids or {}) do
			self._talentMap[iter_3_1]:setActive(true)
		end

		for iter_3_2, iter_3_3 in ipairs(arg_3_1.actions or {}) do
			self._unlockAction[iter_3_3.type .. "_" .. iter_3_3.key] = iter_3_3.value
		end

		self._talentDetailInfo.point = arg_3_1.point
		self._talentDetailInfo.embryos = arg_3_1.embryos
	end
end

function NewSlgSkillTreeData:onS2CActionStatusFlush(arg_4_1)
	local var_4_0 = arg_4_1 and arg_4_1.status

	if arg_4_1 and arg_4_1.status then
		self._unlockAction[var_4_0.id .. "_" .. var_4_0.key] = var_4_0.status
	end
end

function NewSlgSkillTreeData:checkPointIsUnLock(arg_5_1, arg_5_2, arg_5_3)
	return arg_5_3 <= (self._unlockAction[arg_5_1 .. "_" .. arg_5_2] or 0)
end

function NewSlgSkillTreeData:updateExPoint(arg_6_1)
	self._talentDetailInfo.point = arg_6_1.point
end

function NewSlgSkillTreeData:getPointDetail()
	return self._talentDetailInfo
end

function NewSlgSkillTreeData:updateActive(arg_8_1)
	if self._talentMap[arg_8_1.id] then
		self._talentMap[arg_8_1.id]:setActive(true)
	end
end

function NewSlgSkillTreeData:updateActiveOneKey(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_1 or {}) do
		if self._talentMap[iter_9_1] then
			self._talentMap[iter_9_1]:setActive(true)
		end
	end
end

function NewSlgSkillTreeData:onTechnologyReset()
	for iter_10_0, iter_10_1 in pairs(self._talentMap) do
		local var_10_0 = iter_10_1:getInfo()

		if var_10_0.front_pot_1 ~= 0 or var_10_0.front_pot_2 ~= 0 then
			iter_10_1:setActive(false)
		end
	end
end

function NewSlgSkillTreeData:_initCfgData()
	self._talentDict = {}
	self._talentXList = {}

	for iter_11_0, iter_11_1 in var_0_2.ipairs() do
		if not self._talentDict[iter_11_1.technology_type] then
			self._talentDict[iter_11_1.technology_type] = {}
			self._talentXList[iter_11_1.technology_type] = {}
		end

		local var_11_0 = self:getTalentById(iter_11_1.id, true, iter_11_1.technology_type)

		if iter_11_1.front_pot_1 > 0 then
			local var_11_1 = self:getTalentById(iter_11_1.front_pot_1, true, iter_11_1.technology_type)

			var_11_1:addChild(var_11_0)
			var_11_0:addParent(var_11_1)
		end

		if iter_11_1.front_pot_2 > 0 then
			local var_11_2 = self:getTalentById(iter_11_1.front_pot_2, true, iter_11_1.technology_type)

			var_11_2:addChild(var_11_0)
			var_11_0:addParent(var_11_2)
		end

		self._talentXList[iter_11_1.technology_type][iter_11_1.module_id] = self._talentXList[iter_11_1.technology_type][iter_11_1.module_id] or {}

		table.insert(self._talentXList[iter_11_1.technology_type][iter_11_1.module_id], var_11_0)
	end
end

function NewSlgSkillTreeData:getTalentXList(arg_12_1)
	return self._talentXList[arg_12_1]
end

function NewSlgSkillTreeData:getTalentModuleList(arg_13_1, arg_13_2)
	return self._talentXList[arg_13_2][arg_13_1] or {}
end

function NewSlgSkillTreeData:getTalentById(arg_14_1, arg_14_2, arg_14_3)
	if not self._talentDict[arg_14_3][arg_14_1] and arg_14_2 then
		local var_14_0 = NewSlgSkillTreeTalentStruct.new(arg_14_1)

		self._talentDict[arg_14_3][arg_14_1] = var_14_0
		self._talentMap[arg_14_1] = var_14_0
	end

	return self._talentDict[arg_14_3][arg_14_1]
end

function NewSlgSkillTreeData:getBtnState(arg_15_1, arg_15_2)
	if arg_15_1:isActive() then
		return var_0_3.BTN_STATE.ACTIVE
	elseif arg_15_1:isCanActive() then
		local var_15_0 = arg_15_1:getInfo().module_id
		local var_15_1 = self._talentXList[arg_15_2][var_15_0] or {}

		if arg_15_1:parentIsActive() then
			if #var_15_1 > 1 then
				local var_15_2 = false
				local var_15_3 = arg_15_1:getInfo().pot_location

				for iter_15_0 = var_15_0 - 1, 1, -1 do
					local var_15_4 = self._talentXList[arg_15_2][iter_15_0] or {}

					if #var_15_4 > 1 then
						for iter_15_1, iter_15_2 in ipairs(var_15_4) do
							if iter_15_2:getInfo().pot_location == var_15_3 and not iter_15_2:isActive() then
								var_15_2 = true

								break
							end
						end
					end
				end

				if var_15_2 then
					return var_0_3.BTN_STATE.AUTO, arg_15_1:getInfo().pot_location
				end
			end

			return var_0_3.BTN_STATE.CAN_ACTIVE
		elseif #var_15_1 > 1 then
			return var_0_3.BTN_STATE.LOCK_TO, arg_15_1:getInfo().pot_location
		else
			local var_15_5
			local var_15_6 = false

			for iter_15_3 = var_15_0 - 1, 1, -1 do
				local var_15_7 = self._talentXList[arg_15_2][iter_15_3] or {}

				if #var_15_7 >= 2 then
					var_15_6 = true
				end

				for iter_15_4, iter_15_5 in ipairs(var_15_7) do
					if iter_15_5:isActive() then
						var_15_5 = var_15_7

						break
					end
				end

				if var_15_5 then
					break
				end
			end

			if var_15_5 and #var_15_5 >= 2 then
				local var_15_8

				for iter_15_6, iter_15_7 in ipairs(var_15_5) do
					if not iter_15_7:isActive() then
						var_15_8 = iter_15_7:getInfo().pot_location

						break
					end
				end

				return var_0_3.BTN_STATE.DOUBLE, var_15_8
			elseif var_15_6 then
				return var_0_3.BTN_STATE.DOUBLE
			else
				return var_0_3.BTN_STATE.LOCK_TO, arg_15_1:getInfo().pot_location
			end
		end
	else
		return var_0_3.BTN_STATE.LOCK
	end
end

function NewSlgSkillTreeData:getMainLvCitySkillUnlockNum(arg_16_1)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(self._talentMap) do
		if iter_16_1:isUnlockWithMainWithLv(arg_16_1) then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function NewSlgSkillTreeData:getAllAttr()
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in pairs(self._talentMap) do
		if iter_17_1:isActive() then
			local var_17_2 = iter_17_1:getInfo()
			local var_17_3 = var_17_2.add_type
			local var_17_4 = {
				attrType = var_17_2.talent_type,
				attrFullType = var_17_2.talent_type .. "_" .. var_17_2.add_module
			}

			if var_17_2.add_type == var_0_3.ATTR_TYPE.NUM then
				var_17_4.attrValue = var_17_2.talent_value or 0
			end

			if var_17_3 == var_0_3.ATTR_TYPE.PRE then
				var_17_4.attrValuePre = var_17_2.talent_value or 0
			end

			var_17_4.addType = var_17_3
			var_17_4.module = var_17_2.add_module

			if not var_17_1[var_17_4.attrFullType] then
				var_17_1[var_17_4.attrFullType] = #var_17_0 + 1

				table.insert(var_17_0, var_17_4)
			else
				local var_17_5 = var_17_0[var_17_1[var_17_4.attrFullType]]

				var_17_5.attrValue = var_17_0[var_17_1[var_17_4.attrFullType]].attrValue + var_17_4.attrValue
				var_17_5.attrValuePre = var_17_5.attrValuePre + var_17_4.attrValuePre
			end
		end
	end

	return var_17_0
end

function NewSlgSkillTreeData:getAllAttrSize()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self._talentMap) do
		if iter_18_1:isActive() then
			local var_18_1 = iter_18_1:getInfo()
			local var_18_2 = var_18_1.talent_value

			if var_18_1.add_type == var_0_3.ATTR_TYPE.PRE then
				var_18_2 = var_18_2 / 1000
			end

			var_18_0[var_18_1.talent_type] = var_18_0[var_18_1.talent_type] or {}
			var_18_0[var_18_1.talent_type][var_18_1.add_type] = var_18_0[var_18_1.talent_type][var_18_1.add_type] or {}
			var_18_0[var_18_1.talent_type][var_18_1.add_type][var_18_1.add_module] = var_18_0[var_18_1.talent_type][var_18_1.add_type][var_18_1.add_module] or 0
			var_18_0[var_18_1.talent_type][var_18_1.add_type][var_18_1.add_module] = var_18_0[var_18_1.talent_type][var_18_1.add_type][var_18_1.add_module] + var_18_2
		end
	end

	return var_18_0
end

function NewSlgSkillTreeData:getTotalFightValue()
	local var_19_0 = 0
	local var_19_1 = self:getAllAttrSize()

	if var_19_1[var_0_3.ATTR.ATTR_FIGHT_VALUE] then
		local var_19_2, var_19_3

		if var_19_1[var_0_3.ATTR.ATTR_FIGHT_VALUE][var_0_3.ATTR_TYPE.PRE] then
			var_19_2 = var_19_1[var_0_3.ATTR.ATTR_FIGHT_VALUE][var_0_3.ATTR_TYPE.PRE][0] or 0

			if var_19_1[var_0_3.ATTR.ATTR_FIGHT_VALUE][var_0_3.ATTR_TYPE.NUM] then
				var_19_3 = var_19_1[var_0_3.ATTR.ATTR_FIGHT_VALUE][var_0_3.ATTR_TYPE.NUM][0] or 0
			end
		end

		var_19_0 = math.floor(var_19_3 * (var_19_2 + 1))
	end

	return var_19_0
end

function NewSlgSkillTreeData:getUpActiveIds(arg_20_1, arg_20_2)
	local var_20_0 = {
		arg_20_1:getId()
	}
	local var_20_1 = false

	for iter_20_0 = arg_20_1:getInfo().module_id - 1, 1, -1 do
		for iter_20_1, iter_20_2 in ipairs(self._talentXList[arg_20_2][iter_20_0] or {}) do
			if iter_20_2:getInfo().pot_location <= 1 then
				if iter_20_2:isActive() then
					var_20_1 = true

					break
				else
					table.insert(var_20_0, iter_20_2:getId())
				end
			end
		end

		if var_20_1 then
			break
		end
	end

	return var_20_0
end

function NewSlgSkillTreeData:getPreSameLocationUnActiveIds(arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = {
		arg_21_1:getId()
	}

	for iter_21_0 = arg_21_1:getInfo().module_id - 1, 1, -1 do
		for iter_21_1, iter_21_2 in ipairs(self._talentXList[arg_21_3][iter_21_0] or {}) do
			if (iter_21_2:getInfo().pot_location == arg_21_2 or iter_21_2:getInfo().pot_location == 1) and not iter_21_2:isActive() then
				table.insert(var_21_0, iter_21_2:getId())
			end
		end
	end

	return var_21_0
end

function NewSlgSkillTreeData:getDownActiveIds(arg_22_1, arg_22_2)
	local var_22_0 = {
		arg_22_1:getId()
	}
	local var_22_1 = false

	for iter_22_0 = arg_22_1:getInfo().module_id - 1, 1, -1 do
		for iter_22_1, iter_22_2 in ipairs(self._talentXList[arg_22_2][iter_22_0] or {}) do
			if iter_22_2:getInfo().pot_location >= 1 then
				if iter_22_2:isActive() then
					var_22_1 = true

					break
				else
					table.insert(var_22_0, iter_22_2:getId())
				end
			end
		end

		if var_22_1 then
			break
		end
	end

	return var_22_0
end

function NewSlgSkillTreeData:getToActiveIds(arg_23_1, arg_23_2)
	local var_23_0 = {
		arg_23_1:getId()
	}
	local var_23_1 = arg_23_1:getInfo().module_id
	local var_23_2 = arg_23_1:getInfo().pot_location
	local var_23_3

	for iter_23_0 = var_23_1 - 1, 1, -1 do
		local var_23_5 = self._talentXList[arg_23_2][iter_23_0] or {}

		for iter_23_1, iter_23_2 in ipairs(var_23_5) do
			if iter_23_2:isActive() and (math.abs(iter_23_2:getInfo().pot_location - var_23_2) <= 1 or (#var_23_5 == 1 or nil) and true) then
				var_23_3 = iter_23_2

				break
			end
		end

		if var_23_3 then
			break
		end
	end

	if var_23_3 then
		local var_23_6 = var_23_3:getChildList()
		local var_23_7 = var_23_3:getInfo().pot_location

		while #var_23_6 > 0 do
			local var_23_8 = {}

			for iter_23_3, iter_23_4 in ipairs(var_23_6) do
				if iter_23_4:getId() == arg_23_1:getId() then
					var_23_8 = {}

					break
				end

				if math.abs(iter_23_4:getInfo().pot_location - var_23_7) == 0 then
					if not iter_23_4:isActive() then
						table.insert(var_23_0, iter_23_4:getId())
					end

					var_23_8 = iter_23_4:getChildList()

					break
				else
					var_23_7 = var_23_2

					if math.abs(iter_23_4:getInfo().pot_location - var_23_2) <= 1 then
						table.insert(var_23_0, iter_23_4:getId())

						var_23_8 = iter_23_4:getChildList()

						break
					end
				end
			end

			var_23_6 = var_23_8
		end
	else
		for iter_23_5 = var_23_1 - 1, 1, -1 do
			for iter_23_6, iter_23_7 in ipairs(self._talentXList[arg_23_2][iter_23_5] or {}) do
				if math.abs(iter_23_7:getInfo().pot_location - var_23_2) <= 1 then
					table.insert(var_23_0, iter_23_7:getId())
				end
			end
		end
	end

	return var_23_0
end

function NewSlgSkillTreeData:getAllActiveTalent(arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self._talentDict[arg_24_1]) do
		if iter_24_1:isActive() then
			var_24_0[iter_24_1:getId()] = iter_24_1
		end
	end

	return var_24_0
end

function NewSlgSkillTreeData:getActiveAttrData(arg_25_1)
	local var_25_0 = {}
	local var_25_1 = {}

	for iter_25_0, iter_25_1 in pairs(self._talentDict[arg_25_1] or {}) do
		if iter_25_1:isActive() then
			if iter_25_1:getInfo().pot_type == 3 then
				table.insert(var_25_0, iter_25_1:getInfo())
			else
				local var_25_2 = var_0_1.get(iter_25_1:getInfo().talent_skill)

				for iter_25_2 = 1, 3 do
					if var_25_2["affect_type_" .. iter_25_2] > 0 then
						var_25_1[var_25_2["affect_type_" .. iter_25_2]] = var_25_1[var_25_2["affect_type_" .. iter_25_2]] or 0
						var_25_1[var_25_2["affect_type_" .. iter_25_2]] = var_25_1[var_25_2["affect_type_" .. iter_25_2]] + var_25_2["affect_value_" .. iter_25_2]
					end
				end
			end
		end
	end

	local var_25_3 = {}

	for iter_25_3, iter_25_4 in pairs(var_25_1) do
		local var_25_4, var_25_5 = g.core.lang:getAttr(iter_25_3, iter_25_4)

		table.insert(var_25_3, {
			attrName = var_25_4,
			attrValue = var_25_5
		})
	end

	return var_25_3, var_25_0
end

function NewSlgSkillTreeData:hasTalentRed(arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(self._talentDict) do
		for iter_26_2, iter_26_3 in pairs(iter_26_1) do
			if not iter_26_3:isActive() and iter_26_3:isCanActive() then
				local var_26_0 = false
				local var_26_1 = false
				local var_26_2 = iter_26_3:getInfo()

				if g.core.model.User.bagData:getOwnNum(var_26_2.activate_type_1, var_26_2.activate_value_1) >= var_26_2.activate_size_1 then
					var_26_0 = true
				end

				if var_26_2.activate_size_2 > 0 then
					if g.core.model.User.bagData:getOwnNum(var_26_2.activate_type_2, var_26_2.activate_value_2) >= var_26_2.activate_size_1 then
						var_26_1 = true
					end
				else
					var_26_1 = true
				end

				if var_26_0 and var_26_1 then
					return true
				end
			end
		end
	end

	return false
end

function NewSlgSkillTreeData:isTalentNeedPlayUnlock(arg_27_1)
	arg_27_1 = tostring(arg_27_1)
	self._playedAnimMap = self._playedAnimMap or g.core.common.Storage:load("new_slg_skill_tree_unlock_anim.json", true) or {}

	if self._playedAnimMap[arg_27_1] then
		return false
	end

	self._playedAnimMap[arg_27_1] = true

	g.core.common.Storage:save("new_slg_skill_tree_unlock_anim.json", self._playedAnimMap)

	return true
end

return NewSlgSkillTreeData
