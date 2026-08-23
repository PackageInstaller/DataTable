local var_0_0 = g.core.config.precious_info
local var_0_1 = g.core.config.precious_upgrade_info
local var_0_2 = g.core.const.ConstMgr.PreciousConst
local var_0_3 = g.core.config.fragment_info
local var_0_4 = g.core.model.User.fragmentsData
local var_0_5 = g.core.config.talent_skill_info
local var_0_6 = g.core.model.User.preciousData
local var_0_7 = g.core.model.User.bagData
local PreciousStruct = class("PreciousStruct")

function PreciousStruct:ctor()
	self._id = 0
	self._advId = 0
	self._upgradeId = 0
	self._addtimes = 0
	self._pos = 0
	self._star = 0
	self._stage = 0
	self._node = 0
	self._suitGroup = 0
	self._preciousInfoCfg = {}
	self._maxStarCfg = {}
	self._serverData = nil
end

function PreciousStruct:setServerData(arg_2_1)
	if arg_2_1 then
		self._serverData = arg_2_1
		self._advId = arg_2_1.advance_id
		self._upgradeId = arg_2_1.upgrade_id
		self._id = arg_2_1.base_id
		self._addtimes = arg_2_1.addition_times

		self:setCfg(var_0_0.get(self._id))
	end
end

function PreciousStruct:setCfg(arg_3_1)
	self._preciousInfoCfg = arg_3_1
	self._advId = arg_3_1.advance_id
	self._id = arg_3_1.id
	self._quality = arg_3_1.quality
	self._star = arg_3_1.star
	self._suitGroup = arg_3_1.suit_group

	if self:isMaxStar() then
		self._maxStarCfg = self._preciousInfoCfg
	else
		for iter_3_0, iter_3_1 in var_0_0.ipairs() do
			if iter_3_1.advance_id == self._advId and iter_3_1.quality == self._quality and iter_3_1.star == var_0_2.STAR_MAX_NUM then
				self._maxStarCfg = iter_3_1

				break
			end
		end
	end

	local var_3_0 = false

	for iter_3_2, iter_3_3 in var_0_1.ipairs() do
		if self._upgradeId == 0 and iter_3_3.upgrade_group == self._preciousInfoCfg.upgrade_group then
			self._upgradeCfg = iter_3_3
			self._upgradeId = iter_3_3.id
			self._stage = self._upgradeCfg.stage
			self._node = self._upgradeCfg.node
		elseif self._upgradeId == iter_3_3.id then
			self._upgradeCfg = iter_3_3
			self._stage = self._upgradeCfg.stage
			self._node = self._upgradeCfg.node
		end

		if not var_3_0 and self._preciousInfoCfg.upgrade_group == iter_3_3.upgrade_group and iter_3_3.next_id == 0 then
			self._maxStage = iter_3_3.stage
			self._maxNode = var_0_2.UPGRADE_NODE_MAX_NUM
			var_3_0 = true
		end

		if var_3_0 then
			break
		end
	end
end

function PreciousStruct:getCfg()
	return self._preciousInfoCfg
end

function PreciousStruct:isMaxStar()
	return self:getCfg().next_star_id == 0
end

function PreciousStruct:getAdvId()
	return self._advId
end

function PreciousStruct:getId()
	return self._preciousInfoCfg.id
end

function PreciousStruct:getSuitGroup()
	return self._preciousInfoCfg.suit_group
end

function PreciousStruct:getStar()
	return self._star
end

function PreciousStruct:getAdditionTime()
	return self._addtimes
end

function PreciousStruct:getQuality()
	return self._preciousInfoCfg.quality
end

function PreciousStruct:getServerData()
	return self._serverData
end

function PreciousStruct:getUpgradeId()
	return self._upgradeId
end

function PreciousStruct:getUpgradeInfo()
	return self._upgradeCfg
end

function PreciousStruct:getUpgradeGroup()
	if not self._upgradeCfg then
		return nil
	end

	return self._upgradeCfg.upgrade_group
end

function PreciousStruct:getPreciousStageAndLevel()
	return self._stage, self._node
end

function PreciousStruct:getFormationPos()
	return self._pos
end

function PreciousStruct:setFormationPos(arg_18_1)
	self._pos = arg_18_1
end

function PreciousStruct:getMaxStage()
	return self._maxStage
end

function PreciousStruct:getMaxNode()
	return self._maxNode
end

function PreciousStruct:getUpgradeMaterial()
	local var_21_0 = {}

	for iter_21_0, iter_21_1, iter_21_2 in self:getUpgradeInfo().gmatch({
		"cost_type_%d+",
		"cost_value_%d+",
		"cost_size_%d+"
	}) do
		if iter_21_2[1] and iter_21_2[1] ~= 0 then
			table.insert(var_21_0, {
				type = iter_21_2[1],
				value = iter_21_2[2],
				size = iter_21_2[3]
			})
		end
	end

	return var_21_0
end

function PreciousStruct:getLvAddAttr()
	local var_22_0 = {
		0,
		0,
		0,
		0
	}
	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs((var_0_6:getUpgradeInfoListByGroup((self:getUpgradeGroup())))) do
		if self._upgradeId >= iter_22_1.id and iter_22_1.affect_type_1 > 0 then
			var_22_1[iter_22_1.affect_type_1] = not var_22_1[iter_22_1.affect_type_1] and iter_22_1.affect_value_1 or var_22_1[iter_22_1.affect_type_1] + iter_22_1.affect_value_1
		end
	end

	for iter_22_2, iter_22_3 in pairs(var_22_1) do
		var_22_0[iter_22_2] = iter_22_3
	end

	return var_22_0
end

function PreciousStruct:getCurStarAttr()
	local var_23_0 = {}
	local var_23_1 = {}
	local var_23_2 = self:getCfg()

	var_23_0[1] = var_23_2.base_hp
	var_23_0[2] = var_23_2.base_attack
	var_23_0[3] = var_23_2.base_physical_defence
	var_23_0[4] = var_23_2.base_magical_defence

	if var_23_2.next_star_id ~= 0 then
		local var_23_3 = var_0_0.get(var_23_2.next_star_id)

		var_23_1[1] = var_23_3.base_hp
		var_23_1[2] = var_23_3.base_attack
		var_23_1[3] = var_23_3.base_physical_defence
		var_23_1[4] = var_23_3.base_magical_defence
	end

	return var_23_0, var_23_1
end

function PreciousStruct:getFullScreenStarUpAttr()
	local var_24_0 = {
		"base_hp",
		"base_attack",
		"base_physical_defence",
		"base_magical_defence"
	}
	local var_24_1 = {}
	local var_24_2 = {}
	local var_24_3 = self:getCfg()
	local var_24_4 = var_0_0.get(self:getId() - 1)

	for iter_24_0 = 1, 4 do
		var_24_1[iter_24_0] = {
			value = var_24_3[var_24_0[iter_24_0]]
		}
		var_24_2[iter_24_0] = {
			value = var_24_4[var_24_0[iter_24_0]]
		}
	end

	return var_24_1, var_24_2
end

function PreciousStruct:getFullScreenQualityUpAttr()
	local var_25_0 = {
		"base_hp",
		"base_attack",
		"base_physical_defence",
		"base_magical_defence"
	}
	local var_25_1 = {}
	local var_25_2 = {}
	local var_25_3 = self:getCfg()
	local var_25_4

	for iter_25_0, iter_25_1 in var_0_0.ipairs() do
		if iter_25_1.advance_id == var_25_3.advance_id and iter_25_1.star == var_25_3.star and iter_25_1.quality == var_25_3.quality - 1 then
			var_25_4 = iter_25_1

			break
		end
	end

	for iter_25_2 = 1, 4 do
		var_25_1[iter_25_2] = {
			value = var_25_3[var_25_0[iter_25_2]]
		}

		local var_25_5 = {}

		if var_25_4 then
			var_25_5.value = var_25_4[var_25_0[iter_25_2]] or 0
		end

		var_25_2[iter_25_2] = var_25_5
	end

	return var_25_1, var_25_2
end

function PreciousStruct:getMaxStarCfg()
	return self._maxStarCfg
end

function PreciousStruct:getAllPreciousPrivilege()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in var_0_0.ipairs() do
		if iter_27_1.advance_id == self._advId and iter_27_1.quality == self._quality then
			var_27_0[iter_27_1.privilege_id] = var_27_0[iter_27_1.privilege_id] or iter_27_1
		end
	end

	local var_27_1 = table.values(var_27_0)

	table.sort(var_27_1, function(arg_28_0, arg_28_1)
		return arg_28_0.star < arg_28_1.star
	end)

	return var_27_1
end

function PreciousStruct:getPrivilegeId()
	return self._preciousInfoCfg.privilege_id
end

function PreciousStruct:getStarUpTalents()
	local var_30_0 = {}

	for iter_30_0, iter_30_1, iter_30_2 in self._maxStarCfg.gmatch({
		"star_talent_%d+"
	}) do
		if iter_30_2[1] and iter_30_2[1] ~= 0 then
			local var_30_1 = var_0_5.get(iter_30_2[1])

			if var_30_1 then
				table.insert(var_30_0, {
					name = var_30_1.name,
					star = iter_30_1,
					description = var_30_1.description,
					isActive = iter_30_1 <= self._star
				})
			end
		end
	end

	return var_30_0
end

function PreciousStruct:getUpgradeTalents()
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs((var_0_6:getUpgradeInfoListByGroup(self._preciousInfoCfg.upgrade_group))) do
		if iter_31_1.talent_skill_id ~= 0 then
			local var_31_1 = var_0_5.get(iter_31_1.talent_skill_id)

			table.insert(var_31_0, {
				stage = iter_31_1.stage,
				name = var_31_1.name,
				description = var_31_1.description,
				isActive = iter_31_1.stage <= self._stage
			})
		end
	end

	return var_31_0
end

function PreciousStruct:isOwn()
	return self._serverData ~= nil
end

function PreciousStruct:isMaxStage()
	return self._upgradeCfg and self._upgradeCfg.next_id == 0
end

function PreciousStruct:isCanStarUp()
	if not self:isOwn() then
		return false
	end

	if self:isMaxStar() then
		return false
	end

	local var_34_0 = self:getCfg()

	if var_34_0.next_star_num <= var_0_4:getFragmentNumById(var_34_0.fragment_id) then
		return true
	end

	return false
end

function PreciousStruct:isCanUpgradeUp()
	if not self:isOwn() then
		return false
	end

	local var_35_0

	if self:isMaxStage() then
		do return false end

		var_35_0 = self:getUpgradeMaterial() or {}
	end

	for iter_35_0, iter_35_1 in ipairs(var_35_0) do
		if var_0_7:getOwnNum(iter_35_1.type, iter_35_1.value) < iter_35_1.size then
			return false
		end
	end

	return true
end

function PreciousStruct:isCanCompose()
	if self:isOwn() then
		return false
	end

	local var_36_0 = self:getCfg()
	local var_36_1 = var_0_4:getFragmentNumById(var_36_0.fragment_id)

	if var_36_0.fragment_id == 0 then
		return false, 0, 0
	end

	local var_36_2 = var_0_3.get(var_36_0.fragment_id)

	return var_36_1 >= var_36_2.combine_num, var_36_2.combine_num, var_36_1
end

function PreciousStruct:getPreciousStatus()
	local var_37_0 = var_0_2.PRECIOUS_STATUS.NOGET

	if self:isOwn() then
		var_37_0 = self:isCanStarUp() and var_0_2.PRECIOUS_STATUS.STARUP or var_0_2.PRECIOUS_STATUS.GET
	elseif self:isCanCompose() then
		var_37_0 = var_0_2.PRECIOUS_STATUS.CANCOMPOSE
	end

	return var_37_0
end

return PreciousStruct
