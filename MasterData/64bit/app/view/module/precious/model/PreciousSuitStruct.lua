local var_0_0 = g.core.config.precious_suit_info
local var_0_1 = g.core.const.ConstMgr.PreciousConst
local var_0_2 = g.core.model.User.preciousData
local PreciousSuitStruct = class("PreciousSuitStruct")

function PreciousSuitStruct:ctor()
	self._suitId = 0
	self._quality = 0
	self._star = 0
	self._suitInfCfg = {}
	self._serverData = nil
end

function PreciousSuitStruct:setCfg(arg_2_1)
	self._suitInfCfg = arg_2_1
	self._suitId = arg_2_1.id
	self._quality = arg_2_1.quality
end

function PreciousSuitStruct:setServerData(arg_3_1)
	self._serverData = arg_3_1

	if arg_3_1.base_id then
		local var_3_0 = var_0_0.get(arg_3_1.base_id)

		self._suitId = var_3_0.id
		self._star = var_3_0.star

		self:setCfg(var_3_0)
	end
end

function PreciousSuitStruct:getOwnPreciousNum()
	local var_4_0 = 0

	for iter_4_0, iter_4_1, iter_4_2 in self._suitInfCfg.gmatch({
		"precious_id_%d+"
	}) do
		if iter_4_2[1] and iter_4_2[1] ~= 0 then
			local var_4_1 = var_0_2:getPreciousByAdvId(iter_4_2[1])

			if var_4_1 and var_4_1:isOwn() then
				var_4_0 = var_4_0 + 1
			end
		end
	end

	return var_4_0
end

function PreciousSuitStruct:isPreciousCanCompose()
	for iter_5_0, iter_5_1, iter_5_2 in self._suitInfCfg.gmatch({
		"precious_id_%d+"
	}) do
		if iter_5_2[1] and iter_5_2[1] ~= 0 then
			local var_5_0 = var_0_2:getPreciousByAdvId(iter_5_2[1])

			if var_5_0 and var_5_0:isCanCompose() then
				return true
			end
		end
	end

	return false
end

function PreciousSuitStruct:isPreciousCanStarUp()
	for iter_6_0, iter_6_1, iter_6_2 in self._suitInfCfg.gmatch({
		"precious_id_%d+"
	}) do
		if iter_6_2[1] and iter_6_2[1] ~= 0 then
			local var_6_0 = var_0_2:getPreciousByAdvId(iter_6_2[1])

			if var_6_0 and var_6_0:isCanStarUp() then
				return true
			end
		end
	end

	return false
end

function PreciousSuitStruct:getCfg()
	return self._suitInfCfg
end

function PreciousSuitStruct:getStar()
	return self._star
end

function PreciousSuitStruct:getId()
	return self._suitId
end

function PreciousSuitStruct:getGroup()
	return self._suitInfCfg.group
end

function PreciousSuitStruct:getGroupName()
	return self._suitInfCfg.group_name
end

function PreciousSuitStruct:getSuitGroup()
	return self._suitInfCfg.suit_group
end

function PreciousSuitStruct:getQuality()
	return self._quality
end

function PreciousSuitStruct:getSameSuitCfgList()
	local var_14_0 = {}
	local var_14_1 = var_0_0.match(function(arg_15_0)
		if self:getSuitGroup() == arg_15_0.suit_group and arg_15_0.star == 0 then
			return arg_15_0
		end
	end)

	local function var_14_3(arg_16_0)
		if arg_16_0.next_star_id ~= 0 then
			local var_16_0 = var_0_0.get(arg_16_0.next_star_id)

			table.insert(var_14_0, var_16_0)
			var_14_3(var_16_0)
		end
	end

	if #var_14_1 > 0 then
		table.insert(var_14_0, var_14_1[1])
		var_14_3(var_14_1[1])
	end

	return var_14_0
end

function PreciousSuitStruct:getMaxStarTalentSkillList()
	local var_17_0 = {}
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs((self:getSameSuitCfgList())) do
		for iter_17_2 = 0, 7 do
			if iter_17_1["talent_skill_id_" .. iter_17_2] ~= 0 and not var_17_1[iter_17_1["talent_skill_id_" .. iter_17_2]] then
				table.insert(var_17_0, {
					star = iter_17_1.star,
					skillId = iter_17_1["talent_skill_id_" .. iter_17_2]
				})

				var_17_1[iter_17_1["talent_skill_id_" .. iter_17_2]] = true
			end
		end
	end

	return var_17_0
end

function PreciousSuitStruct:getMaxPassiveSkillList()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs((self:getSameSuitCfgList())) do
		local var_18_1

		if iter_18_1.passive_skill_id ~= 0 and iter_18_1.passive_skill_id ~= 0 then
			var_18_1 = iter_18_1.passive_skill_id

			local var_18_2 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(iter_18_1.passive_skill_id).passive_skill_value)

			table.insert(var_18_0, {
				star = iter_18_1.star,
				skillId = iter_18_1.passive_skill_id,
				lv = var_18_2.level,
				desc = g.core.utils.String.formatSkillDesc(var_18_2.id)
			})
		end
	end

	return var_18_0
end

function PreciousSuitStruct:getCurBaseAttrList()
	local var_19_0 = self._suitInfCfg

	if self._suitInfCfg.next_star_id > 0 then
		var_19_0 = var_0_0.get(self._suitInfCfg.next_star_id)
	end

	return {
		{
			type = 1,
			value = self._suitInfCfg.base_hp,
			value2 = var_19_0.base_hp
		},
		{
			type = 2,
			value = self._suitInfCfg.base_attack,
			value2 = var_19_0.base_attack
		},
		{
			type = 3,
			value = self._suitInfCfg.base_physical_defence,
			value2 = var_19_0.base_physical_defence
		},
		{
			type = 4,
			value = self._suitInfCfg.base_magical_defence,
			value2 = var_19_0.base_magical_defence
		}
	}
end

function PreciousSuitStruct:getServerData()
	return self._serverData
end

function PreciousSuitStruct:isActivate()
	return self._serverData ~= nil
end

function PreciousSuitStruct:isPreciousOwnByIndex(arg_22_1)
	local var_22_0 = self:getCfg()

	if var_22_0["precious_id_" .. arg_22_1] and var_22_0["precious_id_" .. arg_22_1] > 0 then
		local var_22_1 = var_0_2:getPreciousByAdvId(var_22_0["precious_id_" .. arg_22_1])

		if not var_22_1 then
			return false
		end

		return var_22_1:isOwn()
	end

	return false
end

function PreciousSuitStruct:getPreciousCfgByIndex(arg_23_1)
	local var_23_0 = self:getCfg()

	if var_23_0["precious_id_" .. arg_23_1] and var_23_0["precious_id_" .. arg_23_1] > 0 then
		local var_23_1 = var_0_2:getPreciousByAdvId(var_23_0["precious_id_" .. arg_23_1])

		if not var_23_1 then
			return nil
		end

		return var_23_1:getCfg()
	end

	return nil
end

function PreciousSuitStruct:isCanActivate()
	return self:getStatus() == var_0_1.PRECIOUS_SUIT_STATUS.CAN_ACTIVATED
end

function PreciousSuitStruct:isCanStarUp()
	return self:getStatus() == var_0_1.PRECIOUS_SUIT_STATUS.CAN_STARUP
end

function PreciousSuitStruct:isMaxStar()
	return self._star >= var_0_1.SUIT_MAX_STAR_NUM
end

function PreciousSuitStruct:getStatus()
	local var_27_0
	local var_27_1

	for iter_27_0, iter_27_1, iter_27_2 in self._suitInfCfg.gmatch({
		"precious_id_%d+"
	}) do
		if iter_27_2[1] and iter_27_2[1] ~= 0 then
			local var_27_2 = var_0_2:getPreciousByAdvId(iter_27_2[1])

			if not var_27_2 or not var_27_2:isOwn() then
				return var_0_1.PRECIOUS_SUIT_STATUS.CANNOT_ACTIVATE
			end

			local var_27_3 = var_27_2:getStar()
			local var_27_4 = var_27_2:getQuality()

			if not var_27_0 then
				var_27_0 = var_27_3
				var_27_1 = var_27_4
			else
				var_27_0 = math.min(var_27_0, var_27_3)
				var_27_1 = math.min(var_27_1, var_27_4)
			end
		end
	end

	if not self._serverData then
		return var_0_1.PRECIOUS_SUIT_STATUS.CAN_ACTIVATED
	elseif self._star >= var_0_1.STAR_MAX_NUM then
		return var_0_1.PRECIOUS_SUIT_STATUS.MAX_STAR
	elseif var_27_0 == self._star then
		return var_0_1.PRECIOUS_SUIT_STATUS.CANNOT_STARUP
	else
		return var_0_1.PRECIOUS_SUIT_STATUS.CAN_STARUP
	end
end

return PreciousSuitStruct
