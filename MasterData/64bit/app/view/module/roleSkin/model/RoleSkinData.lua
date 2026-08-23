local RoleSkinData = class("RoleSkinData")
local var_0_1 = g.core.config.role_skin_info
local var_0_2 = g.core.config.role_skin_level_info
local var_0_3 = g.core.config.role_skin_related_info
local var_0_4 = g.core.const.ConstMgr.RoleSkinConst
local RoleSkinPartItemStruct = require("app.view.module.roleSkin.model.RoleSkinPartItemStruct")

function RoleSkinData:ctor()
	self:initData()
end

function RoleSkinData:initData()
	self._roleSkinPartIdMap = {}

	self:_initAllPartItems()
	self:_initLevelTalent()
end

function RoleSkinData:_initAllPartItems()
	self._roleSkinPartArrMap = {}
	self._roleSkinPartItemMap = {}

	local var_3_0 = g.core.model.User:getUserUniqueAdvanceId() == 210000 and 1 or 0

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		if iter_3_1.put == 1 and (iter_3_1.gender == 2 or iter_3_1.gender == var_3_0) then
			if not self._roleSkinPartItemMap[iter_3_1.advance_id] then
				local var_3_1 = RoleSkinPartItemStruct.new({
					id = iter_3_1.id,
					levelGroup = iter_3_1.level_group
				})

				self._roleSkinPartItemMap[iter_3_1.advance_id] = var_3_1
				self._roleSkinPartArrMap[iter_3_1.part] = self._roleSkinPartArrMap[iter_3_1.part] or {}

				table.insert(self._roleSkinPartArrMap[iter_3_1.part], var_3_1)
			end

			self._roleSkinPartItemMap[iter_3_1.advance_id]:updateSkinInfoMap(iter_3_1)
		end
	end
end

function RoleSkinData:_initLevelTalent()
	self._levelTalentMap = {}

	for iter_4_0, iter_4_1 in var_0_2.ipairs() do
		self._levelTalentMap[iter_4_1.group] = self._levelTalentMap[iter_4_1.group] or {}

		if iter_4_1.talent > 0 then
			table.insert(self._levelTalentMap[iter_4_1.group], {
				talentId = iter_4_1.talent,
				level = iter_4_1.level
			})
		end
	end

	for iter_4_2, iter_4_3 in ipairs(self._levelTalentMap) do
		table.sort(iter_4_3, function(arg_5_0, arg_5_1)
			return arg_5_0.level < arg_5_1.level
		end)
	end
end

function RoleSkinData:getLevelTalentByGroup(arg_6_1)
	return self._levelTalentMap[arg_6_1] or {}
end

function RoleSkinData:getLevelTalentByGroupAndLevel(arg_7_1, arg_7_2)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(self._levelTalentMap[arg_7_1] or {}) do
		if arg_7_2 >= iter_7_1.level then
			table.insert(var_7_0, iter_7_1.talentId)
		else
			break
		end
	end

	return var_7_0
end

function RoleSkinData:getNextLevelTalentById(arg_8_1)
	local var_8_0 = var_0_2.get(arg_8_1)

	if var_8_0.next_id > 0 then
		return var_0_2.get(var_8_0.next_id).talent
	end

	return 0
end

function RoleSkinData:getPartItemListByPart(arg_9_1, arg_9_2)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._roleSkinPartArrMap[arg_9_1] or {}) do
		if iter_9_1:isPut() then
			table.insert(var_9_0, iter_9_1)
		end
	end

	if arg_9_2 then
		table.sort(var_9_0, function(arg_10_0, arg_10_1)
			if arg_10_0:isWear() ~= arg_10_1:isWear() then
				return arg_10_0:isWear()
			end

			if arg_10_0:isOwn() ~= arg_10_1:isOwn() then
				return arg_10_0:isOwn()
			end

			if arg_10_0:getQuality() ~= arg_10_1:getQuality() then
				return arg_10_0:getQuality() > arg_10_1:getQuality()
			end

			if arg_10_0:getStage() ~= arg_10_1:getStage() then
				return arg_10_0:getStage() > arg_10_1:getStage()
			end

			if arg_10_0:getLevel() ~= arg_10_1:getLevel() then
				return arg_10_0:getLevel() > arg_10_1:getLevel()
			end

			return arg_10_0:getAdvanceId() > arg_10_1:getAdvanceId()
		end)
	end

	return var_9_0
end

function RoleSkinData:getOwnNumByPart(arg_11_1)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs((self:getPartItemListByPart(arg_11_1))) do
		if iter_11_1:isOwn() then
			var_11_0 = var_11_0 + 1
		end
	end

	return var_11_0
end

function RoleSkinData:getPartItemByAdvanceId(arg_12_1)
	return self._roleSkinPartItemMap[arg_12_1]
end

function RoleSkinData:getAttrMapByGroupAndLevel(arg_13_1, arg_13_2)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in var_0_2.ipairs() do
		if iter_13_1.group == arg_13_1 and iter_13_1.level == arg_13_2 then
			while var_0_2.hasKey("affect_type_" .. 1) and iter_13_1.affectType ~= 0 do
				var_13_0[iter_13_1.affectType] = {
					type = iter_13_1.affectType,
					value = iter_13_1["affect_value_" .. 1]
				}
			end
		end
	end

	return var_13_0
end

function RoleSkinData:getTalentIdByGroupAndLevel(arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in var_0_2.ipairs() do
		if iter_14_1.group == arg_14_1 and iter_14_1.level == arg_14_2 then
			return iter_14_1.talent_id
		end
	end

	return 0
end

function RoleSkinData:getPartNameByPart(arg_15_1, arg_15_2)
	if arg_15_2 then
		if arg_15_1 == var_0_4.PART.CLOTH then
			return g.core.lang:get(430512)
		elseif arg_15_1 == var_0_4.PART.WEAPON then
			return g.core.lang:get(430513)
		elseif arg_15_1 == var_0_4.PART.BACK then
			return g.core.lang:get(430514)
		end
	elseif arg_15_1 == var_0_4.PART.CLOTH then
		return g.core.lang:get(430511)
	elseif arg_15_1 == var_0_4.PART.WEAPON then
		return g.core.lang:get(430507)
	elseif arg_15_1 == var_0_4.PART.BACK then
		return g.core.lang:get(430508)
	end
end

function RoleSkinData:getSkinNameByWeaponId(arg_16_1)
	return
end

function RoleSkinData:getWearAdvanceIdByPart(arg_17_1)
	local var_17_0 = self._roleSkinPartIdMap[arg_17_1] or 0

	if arg_17_1 == var_0_4.PART.CLOTH and var_17_0 == 0 then
		var_17_0 = g.core.model.User.knightsData:getMainRoleKnight()[1]:getResInfo().fight_id
	elseif arg_17_1 == var_0_4.PART.WEAPON and var_17_0 == 0 then
		local var_17_1 = var_0_3.fetch(g.core.model.User.knightsData:getMainRoleKnight()[1]:getResInfo().fight_id)

		var_17_0 = var_17_1 and var_17_1.weapon or 201000
	end

	return var_17_0
end

function RoleSkinData:getRoleSkinSpineId(arg_18_1)
	local var_18_0 = self:getPartItemByAdvanceId(arg_18_1)

	if var_18_0 then
		return tonumber(var_18_0:getSpineId())
	end

	return 0
end

function RoleSkinData:getRoleSkinBackParams(arg_19_1)
	local var_19_0 = {
		backSkin = "",
		backName = ""
	}
	local var_19_1 = self:getPartItemByAdvanceId(arg_19_1)

	if var_19_1 then
		var_19_0.backName = var_19_1:getSpineId()
		var_19_0.backSkin = var_19_1:getSkinName()
	end

	return var_19_0
end

function RoleSkinData:getWeaponSkinName(arg_20_1)
	local var_20_0 = self:getPartItemByAdvanceId(arg_20_1)

	if var_20_0 then
		return var_20_0:getSkinName()
	end

	return ""
end

function RoleSkinData:getWearSpineParams()
	local var_21_0 = self:getRoleSkinBackParams(self:getWearAdvanceIdByPart(var_0_4.PART.BACK))

	return {
		isMainRole = true,
		isShowBack = true,
		resId = self:getRoleSkinSpineId(self:getWearAdvanceIdByPart(var_0_4.PART.CLOTH)),
		skinName = self:getWeaponSkinName(self:getWearAdvanceIdByPart(var_0_4.PART.WEAPON)),
		backName = var_21_0.backName,
		backSkin = var_21_0.backSkin
	}
end

function RoleSkinData:onS2CGetInfo(arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_1.skin_parts or {}) do
		local var_22_1 = self:getPartItemByAdvanceId(iter_22_1.advance_id)

		if var_22_1 then
			var_22_1:updateStruct({
				level = iter_22_1.level,
				stage = iter_22_1.stage
			})
		else
			print("不存在advance_id = " .. iter_22_1.advance_id)
		end
	end
end

function RoleSkinData:onS2CLevelUp(arg_23_1)
	self:getPartItemByAdvanceId(arg_23_1.advance_id):updateStruct({
		level = arg_23_1.target_level
	})
end

function RoleSkinData:onS2CStageUp(arg_24_1)
	local var_24_0 = self:getPartItemByAdvanceId(arg_24_1.advance_id)

	var_24_0:updateStruct({
		stage = arg_24_1.target_stage
	})
	g.core.model.User:updateRoleSkinPart(var_24_0:getPart(), (var_24_0:getSkinInfoId()))
end

function RoleSkinData:onS2CWear(arg_25_1)
	self._roleSkinPartIdMap[self:getPartItemByAdvanceId(arg_25_1.advance_id):getPart()] = arg_25_1.advance_id
end

function RoleSkinData:onS2CRoleSkinOpObject(arg_26_1)
	if arg_26_1.insert then
		for iter_26_0, iter_26_1 in ipairs(arg_26_1.insert) do
			local var_26_0 = self:getPartItemByAdvanceId(iter_26_1.advance_id)

			if var_26_0 then
				var_26_0:updateStruct({
					level = iter_26_1.level,
					stage = iter_26_1.stage
				})
			end
		end
	end

	if arg_26_1.update then
		for iter_26_2, iter_26_3 in ipairs(arg_26_1.update) do
			local var_26_1 = self:getPartItemByAdvanceId(iter_26_3.advance_id)

			if var_26_1 then
				var_26_1:updateStruct({
					level = iter_26_3.level,
					stage = iter_26_3.stage
				})
			end
		end
	end

	if arg_26_1.del then
		for iter_26_4, iter_26_5 in ipairs(arg_26_1.del) do
			local var_26_2 = self:getPartItemByAdvanceId(iter_26_5.advance_id)

			var_26_2:updateStruct({
				isOwn = false,
				level = 0,
				stage = 0
			})

			self._roleSkinPartIdMap[var_26_2:getPart()] = nil
		end
	end
end

function RoleSkinData:initList(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_1.skin_parts or {}) do
		local var_27_1 = self:getPartItemByAdvanceId(iter_27_1.advance_id)

		if var_27_1 then
			var_27_1:updateStruct({
				level = iter_27_1.level,
				stage = iter_27_1.stage
			})
		else
			print("不存在advance_id = " .. iter_27_1.advance_id .. "    大概率是性别问题！")
		end
	end
end

function RoleSkinData:updateWearData(arg_28_1)
	self._roleSkinPartIdMap = {}

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		if iter_28_1 > 0 then
			local var_28_0 = var_0_1.get(iter_28_1)

			self._roleSkinPartIdMap[var_28_0.part] = var_28_0.advance_id
		end
	end
end

function RoleSkinData:hasSkinPartCanLevelUp(arg_29_1)
	if arg_29_1 and arg_29_1.struct then
		return arg_29_1.struct:canLevelUp()
	elseif arg_29_1 and arg_29_1.part then
		for iter_29_0, iter_29_1 in ipairs((self:getPartItemListByPart(arg_29_1.part))) do
			if iter_29_1:canLevelUp() then
				return true
			end
		end
	else
		for iter_29_2, iter_29_3 in pairs(self._roleSkinPartItemMap) do
			if iter_29_3:canLevelUp() then
				return true
			end
		end
	end

	return false
end

function RoleSkinData:hasSkinPartCanStageUp(arg_30_1)
	if arg_30_1 and arg_30_1.struct then
		return arg_30_1.struct:canStageUp()
	elseif arg_30_1 and arg_30_1.part then
		for iter_30_0, iter_30_1 in ipairs((self:getPartItemListByPart(arg_30_1.part))) do
			if iter_30_1:canStageUp() then
				return true
			end
		end
	else
		for iter_30_2, iter_30_3 in pairs(self._roleSkinPartItemMap) do
			if iter_30_3:canStageUp() then
				return true
			end
		end
	end

	return false
end

function RoleSkinData:hasSkinPartCanDevelop(arg_31_1)
	if arg_31_1 and arg_31_1.struct then
		return arg_31_1.struct:canStageUp() or arg_31_1.struct:canLevelUp()
	elseif arg_31_1 and arg_31_1.part then
		for iter_31_0, iter_31_1 in ipairs((self:getPartItemListByPart(arg_31_1.part))) do
			if iter_31_1:canStageUp() or iter_31_1:canLevelUp() then
				return true
			end
		end
	end

	return false
end

return RoleSkinData
