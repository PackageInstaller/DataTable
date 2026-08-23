local PetHandBookData = class("PetHandBookData")
local var_0_1 = g.core.config.pet_compose_info
local var_0_2 = g.core.config.pet_compose_advanced_info
local var_0_3 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_4 = g.core.const.ConstMgr.PetHandBookConst
local var_0_5 = g.core.common.Path
local var_0_6 = g.core.model.User.petsData
local PetHandbookGroupStruct = require("app.view.module.petHandbook.model.PetHandbookGroupStruct")

function PetHandBookData:ctor()
	self:initData()
end

function PetHandBookData:initData()
	self._petIsPutArr = {}
	self._allPetInfoDict = {}
	self._qualityGroup = {}
	self._activatedNum = 0
	self._petNum = 0
	self._petHandbookGroupDict = {}

	self:_initAllPetData()
	self:_initGroupData()
end

function PetHandBookData:_initGroupData()
	for iter_3_0, iter_3_1 in var_0_2.ipairs() do
		self._petHandbookGroupDict[iter_3_1.group] = self._petHandbookGroupDict[iter_3_1.group] or PetHandbookGroupStruct.new({
			cfg = iter_3_1
		})
	end
end

function PetHandBookData:_initAllPetData()
	self._petIsPutArr = var_0_6:getPetArrByFilter()
	self._petNum = #self._petIsPutArr

	for iter_4_0, iter_4_1 in pairs(self._petIsPutArr) do
		local var_4_0 = {}

		var_4_0.isActivated = false
		var_4_0.level = 0
		var_4_0.petStruct = iter_4_1

		local var_4_1 = iter_4_1:getAdvanceId()

		var_4_0.advId = var_4_1
		self._allPetInfoDict[var_4_1] = var_4_0
	end

	self:_initQualityGroup()
end

function PetHandBookData:_initQualityGroup()
	for iter_5_0 = var_0_3.NONE, var_0_3.MAX_QUALITY do
		self._qualityGroup[iter_5_0 + 1] = {}
	end

	for iter_5_1, iter_5_2 in pairs(self._allPetInfoDict) do
		table.insert(self._qualityGroup[iter_5_2.petStruct:getQuality() + 1], iter_5_2)
		table.insert(self._qualityGroup[var_0_3.NONE + 1], iter_5_2)
	end

	self:_sortAllQualityGroup()
end

function PetHandBookData:updatePetHandBook(arg_6_1)
	if arg_6_1 then
		self._activatedNum = 0

		if arg_6_1.id then
			self._activatedNum = #arg_6_1.id

			if arg_6_1.id then
				for iter_6_0, iter_6_1 in pairs(arg_6_1.id) do
					local var_6_0 = self:getComposeCfgById(iter_6_1)

					if self._allPetInfoDict[var_6_0.pet_1] then
						self._allPetInfoDict[var_6_0.pet_1].isActivated = true
						self._allPetInfoDict[var_6_0.pet_1].level = var_6_0.level
						self._allPetInfoDict[var_6_0.pet_1].handBookId = iter_6_1
					end
				end
			end
		end
	end

	self:_sortAllQualityGroup()
end

function PetHandBookData:_sortAllQualityGroup(arg_7_1)
	if arg_7_1 then
		table.sort(self._qualityGroup[arg_7_1 + 1], handler(self, self._sortPetList))
		table.sort(self._qualityGroup[var_0_3.NONE + 1], handler(self, self._sortPetList))

		return
	end

	for iter_7_0 = var_0_3.NONE, var_0_3.SSR do
		if #self._qualityGroup[iter_7_0 + 1] > 1 then
			table.sort(self._qualityGroup[iter_7_0 + 1], handler(self, self._sortPetList))
		end
	end
end

function PetHandBookData:getQualityGroup(arg_8_1)
	local var_8_0 = {}

	for iter_8_0 = 1, #self._qualityGroup[arg_8_1 + 1] do
		if self._qualityGroup[arg_8_1 + 1][iter_8_0].petStruct:isPut() then
			table.insert(var_8_0, self._qualityGroup[arg_8_1 + 1][iter_8_0])
		end
	end

	return var_8_0
end

function PetHandBookData:_isLvUpEnable(arg_9_1)
	if not arg_9_1.isActivated or arg_9_1.petStruct:getStarNum() <= arg_9_1.level then
		return false
	else
		return true
	end
end

function PetHandBookData:isActivateEnable(arg_10_1)
	return not arg_10_1.isActivated and arg_10_1.petStruct:isOwn()
end

function PetHandBookData:getPetBookAttrById(arg_11_1)
	local var_11_0 = var_0_1.get(arg_11_1)
	local var_11_1 = {}

	for iter_11_0 = 1, 5 do
		if var_11_0["attribute_type_" .. iter_11_0] ~= 0 then
			table.insert(var_11_1, {
				isAll = true,
				attr = {
					g.core.lang:getAttr(var_11_0["attribute_type_" .. iter_11_0], var_11_0["attribute_value_" .. iter_11_0], true)
				},
				res = var_0_5:getAttrIcon(var_11_0["attribute_type_" .. iter_11_0])
			})
		end
	end

	return var_11_1
end

function PetHandBookData:getComposeCfgById(arg_12_1)
	return (var_0_1.get(arg_12_1))
end

function PetHandBookData:getMaxPetNum()
	return self._petNum
end

function PetHandBookData:getActivatedNum()
	return self._activatedNum
end

function PetHandBookData:getPetBookLevel(arg_15_1)
	return (self._allPetInfoDict[arg_15_1] or nil) and self._allPetInfoDict[arg_15_1].level
end

function PetHandBookData:getPetStateByAdvId(arg_16_1)
	if not self._allPetInfoDict[arg_16_1].isActivated then
		if self._allPetInfoDict[arg_16_1].petStruct:isOwn() then
			return var_0_4.CELL_STATE.CAN_ACTIVATE
		else
			return var_0_4.CELL_STATE.CAN_NOT_ACTIVATE
		end
	elseif self:_isLvUpEnable(self._allPetInfoDict[arg_16_1]) then
		return var_0_4.CELL_STATE.CAN_STAR_UP
	else
		return var_0_4.CELL_STATE.ACTIVATED_NORMAL
	end
end

function PetHandBookData:getCollectAttr()
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in pairs(self._allPetInfoDict) do
		if iter_17_1.isActivated then
			local var_17_1 = self:_getAttrByBaseId(iter_17_1.petStruct:getCfg().id)

			for iter_17_2 = 1, var_0_4.ATTR_NUM do
				if not var_17_0[iter_17_2] then
					table.insert(var_17_0, {
						value = 0,
						type = var_17_1["attribute_type_" .. iter_17_2].type
					})
				end

				var_17_0[iter_17_2].value = var_17_0[iter_17_2].value + var_17_1["attribute_type_" .. iter_17_2].value
			end
		end
	end

	return var_17_0
end

function PetHandBookData:_getAttrByBaseId(arg_18_1)
	local var_18_0 = {}
	local var_18_1 = var_0_1.get(arg_18_1)

	for iter_18_0 = 1, var_0_4.ATTR_NUM do
		var_18_0["attribute_type_" .. iter_18_0] = {
			type = var_18_1["attribute_type_" .. iter_18_0],
			value = var_18_1["attribute_value_" .. iter_18_0]
		}
	end

	return var_18_0
end

function PetHandBookData:getAdvanceIdById(arg_19_1)
	return var_0_1.get(arg_19_1).pet_1
end

function PetHandBookData:getAllPetInfoDict()
	return self._allPetInfoDict
end

function PetHandBookData:getGroupStructList()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self._petHandbookGroupDict) do
		if iter_21_1:isPut() then
			table.insert(var_21_0, iter_21_1)
		end
	end

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0:isGroupCanActivate()

		if var_22_0 ~= arg_22_1:isGroupCanActivate() then
			return var_22_0
		end

		local var_22_1 = arg_22_0:isGroupCanUpgrade()

		if var_22_1 ~= arg_22_1:isGroupCanUpgrade() then
			return var_22_1
		end

		return arg_22_0:getBaseId() > arg_22_1:getBaseId()
	end)

	return var_21_0
end

function PetHandBookData:getGroupActiveNum()
	local var_23_0 = 0

	for iter_23_0, iter_23_1 in pairs(self._petHandbookGroupDict) do
		if iter_23_1:isGroupActive() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function PetHandBookData:getAllGroupAttrList()
	local var_24_0 = {}
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in pairs(self._petHandbookGroupDict) do
		if iter_24_1:isGroupActive() then
			for iter_24_2, iter_24_3 in pairs((iter_24_1:getSumAttrMap((iter_24_1:getBaseId())))) do
				var_24_0[iter_24_2] = var_24_0[iter_24_2] or 0
				var_24_0[iter_24_2] = var_24_0[iter_24_2] + iter_24_3
			end
		end
	end

	for iter_24_4, iter_24_5 in pairs(var_24_0) do
		table.insert(var_24_1, {
			type = iter_24_4,
			value = iter_24_5
		})
	end

	return var_24_1
end

function PetHandBookData:hasGroupPut()
	for iter_25_0, iter_25_1 in pairs(self._petHandbookGroupDict) do
		if iter_25_1:isPut() then
			return true
		end
	end

	return false
end

function PetHandBookData:getGroupStructByGroup(arg_26_1)
	return self._petHandbookGroupDict[arg_26_1]
end

function PetHandBookData:_sortPetList(arg_27_1, arg_27_2)
	local var_27_0 = self:_isLvUpEnable(arg_27_1) or self:isActivateEnable(arg_27_1)

	if var_27_0 ~= (self:_isLvUpEnable(arg_27_2) or self:isActivateEnable(arg_27_2)) then
		return var_27_0
	elseif arg_27_1.isActivated ~= arg_27_2.isActivated then
		return arg_27_1.isActivated
	else
		local var_27_1 = arg_27_1.petStruct:getQuality()
		local var_27_2 = arg_27_2.petStruct:getQuality()

		if var_27_1 ~= var_27_2 then
			return var_27_2 < var_27_1
		else
			return arg_27_1.advId < arg_27_2.advId
		end
	end
end

function PetHandBookData:onS2CPetHandbookInfo(arg_28_1)
	self:updatePetHandBook(arg_28_1)
end

function PetHandBookData:onS2CPetHandbookActivate(arg_29_1)
	local var_29_0 = self._allPetInfoDict[self:getAdvanceIdById(arg_29_1.id)]

	var_29_0.isActivated = true
	var_29_0.level = 0
	var_29_0.handBookId = arg_29_1.id
	self._activatedNum = self._activatedNum + 1

	self:_sortAllQualityGroup((var_29_0.petStruct:getQuality()))
end

function PetHandBookData:onS2CPetHandbookUpgrade(arg_30_1)
	local var_30_0 = self:getAdvanceIdById(arg_30_1.id)

	self._allPetInfoDict[var_30_0].isActivated = true
	self._allPetInfoDict[var_30_0].level = self:getPetBookLevel(var_30_0) + 1
	self._allPetInfoDict[var_30_0].handBookId = self:getComposeCfgById(arg_30_1.id).next_id

	self:_sortAllQualityGroup((self._allPetInfoDict[var_30_0].petStruct:getQuality()))
end

function PetHandBookData:onS2CPetHandBookOneKeyUpgrade(arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_1.hb or {}) do
		local var_31_1 = self._allPetInfoDict[self:getAdvanceIdById(iter_31_1.id)]

		if not var_31_1.isActivated then
			self._activatedNum = self._activatedNum + 1
		end

		var_31_1.isActivated = true
		var_31_1.level = iter_31_1.level
		var_31_1.handBookId = iter_31_1.id
	end

	self:_sortAllQualityGroup()
end

function PetHandBookData:onS2CURHandbookActive(arg_32_1)
	local var_32_0 = var_0_2.fetch(arg_32_1.id)

	if var_32_0 then
		local var_32_1 = self:getGroupStructByGroup(var_32_0.group)

		if var_32_1 then
			var_32_1:setActive()
		end
	end
end

function PetHandBookData:onS2CURHandbookUpgrade(arg_33_1)
	local var_33_0 = var_0_2.fetch(arg_33_1.id)

	if var_33_0 then
		local var_33_1 = self:getGroupStructByGroup(var_33_0.group)

		if var_33_1 and var_33_0.next_id > 0 then
			var_33_1:setNewCfg((var_0_2.get(var_33_0.next_id)))
		end
	end
end

function PetHandBookData:onS2CHandbookInfo(arg_34_1)
	if arg_34_1.id and arg_34_1.id == g.core.network.proto.UR_PET_HB or arg_34_1.tp and arg_34_1.tp == g.core.network.proto.UR_PET_HB then
		for iter_34_0, iter_34_1 in ipairs(arg_34_1.hb or {}) do
			local var_34_1 = var_0_2.fetch(iter_34_1.id)

			if var_34_1 then
				local var_34_2 = self:getGroupStructByGroup(var_34_1.group)

				if var_34_2 then
					var_34_2:setNewCfg(var_34_1)
					var_34_2:setActive()
				end
			end
		end
	end
end

function PetHandBookData:hasPetCanActivateOrStarUpWithCustomData(arg_35_1)
	if not arg_35_1.advId then
		for iter_35_0, iter_35_1 in pairs(self._allPetInfoDict) do
			local var_35_0 = self:getPetStateByAdvId(iter_35_0)

			if var_35_0 == var_0_4.CELL_STATE.CAN_ACTIVATE or var_35_0 == var_0_4.CELL_STATE.CAN_STAR_UP then
				return true
			end
		end

		return false
	else
		local var_35_1 = self:getPetStateByAdvId(arg_35_1.advId)

		return var_35_1 == var_0_4.CELL_STATE.CAN_ACTIVATE or var_35_1 == var_0_4.CELL_STATE.CAN_STAR_UP
	end
end

function PetHandBookData:getAllCanActiveOrUpgradeHandBookList(arg_36_1)
	local var_36_0 = {}
	local var_36_1 = {}
	local var_36_2 = {}

	if arg_36_1 then
		for iter_36_0, iter_36_1 in pairs(self._petHandbookGroupDict) do
			local var_36_3 = iter_36_1:getBaseId()

			if iter_36_1:isGroupCanActivate() then
				table.insert(var_36_0, var_36_3)
				table.insert(var_36_2, var_36_3)
			elseif iter_36_1:isGroupCanUpgrade() then
				table.insert(var_36_1, var_36_3)
				table.insert(var_36_2, var_36_3)
			end
		end
	else
		for iter_36_2, iter_36_3 in pairs(self._allPetInfoDict) do
			local var_36_4 = self:getPetStateByAdvId(iter_36_2)

			if var_36_4 == var_0_4.CELL_STATE.CAN_ACTIVATE then
				table.insert(var_36_0, iter_36_2)
				table.insert(var_36_2, iter_36_2)
			elseif var_36_4 == var_0_4.CELL_STATE.CAN_STAR_UP then
				table.insert(var_36_1, iter_36_3.handBookId)
				table.insert(var_36_2, iter_36_3.handBookId)
			end
		end
	end

	return var_36_0, var_36_1, var_36_2
end

function PetHandBookData:hasGroupCanPromoteWithCustomData(arg_37_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PET_UR_GROUP) then
		return false
	end

	if arg_37_1 and arg_37_1.groupStruct then
		return arg_37_1.groupStruct:isGroupCanActivate() or arg_37_1.groupStruct:isGroupCanUpgrade()
	else
		for iter_37_0, iter_37_1 in pairs(self._petHandbookGroupDict) do
			if iter_37_1:isGroupCanActivate() or iter_37_1:isGroupCanUpgrade() then
				return true
			end
		end
	end

	return false
end

return PetHandBookData
