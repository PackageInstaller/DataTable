local UniteTokenStructData = class("UniteTokenStructData")
local var_0_1 = g.core.config.unite_token_info
local var_0_2 = g.core.config.fragment_info
local var_0_3 = g.core.config.unite_token_upgrade_info

function UniteTokenStructData:ctor(arg_1_1)
	self._baseId = arg_1_1
	self._id = 0
	self._sid = 0
	self._advanceLevel = 0
	self._level = 1
	self._isOwn = false
	self._isAwaken = false
	self._pos = 0
	self._preStarId = 0

	local var_1_0 = var_0_1.get(self._baseId)

	self._advanceId = var_1_0.advance_id
	self._skillId = var_1_0.skill_id
	self._quality = var_1_0.quality
	self._upgradeId = var_1_0.upgrade_code
	self._nextStarId = var_1_0.next_star_id
	self._starLevel = var_1_0.star
	self._uniteType = var_1_0.unite_type
	self._put = var_1_0.put
	self._name = var_1_0.name
	self._cfg = var_1_0
	self._strengthScore = 0
	self._runes = 0
	self._sourceType = nil
	self._expireTime = 0
end

function UniteTokenStructData:updateByNetData(arg_2_1)
	self:setServerId(arg_2_1.id)

	self._level = arg_2_1.level or 1
	self._pos = arg_2_1.position or 0
	self._runes = arg_2_1.runes or 0
	self._isAwaken = arg_2_1.awaken
	self._sourceType = arg_2_1.source_type
	self._expireTime = arg_2_1.expire_time or 0
end

function UniteTokenStructData:update(arg_3_1)
	self._starLevel = arg_3_1.star_level
	self._advanceLevel = arg_3_1.advance_level
end

function UniteTokenStructData:setRunes(arg_4_1)
	self._runes = arg_4_1
end

function UniteTokenStructData:setOwn(arg_5_1)
	self._isOwn = arg_5_1
end

function UniteTokenStructData:setPreStarId(arg_6_1)
	self._preStarId = arg_6_1
end

function UniteTokenStructData:setNextStarId(arg_7_1)
	self._nextStarId = arg_7_1
end

function UniteTokenStructData:setBaseId(arg_8_1)
	self._baseId = arg_8_1
	self._cfg = var_0_1.get(self._baseId)
end

function UniteTokenStructData:setServerId(arg_9_1)
	self._id = arg_9_1 % 4294967296
	self._sid = arg_9_1
end

function UniteTokenStructData:setRealServerId(arg_10_1)
	self._sid = arg_10_1
end

function UniteTokenStructData:justSetServerId(arg_11_1)
	self._id = arg_11_1
end

function UniteTokenStructData:setAwaken(arg_12_1)
	self._isAwaken = arg_12_1
end

function UniteTokenStructData:setStarLevel(arg_13_1)
	self._starLevel = arg_13_1
end

function UniteTokenStructData:setAdvanceLevel(arg_14_1)
	self._advanceLevel = arg_14_1
end

function UniteTokenStructData:setLevel(arg_15_1)
	self._level = arg_15_1
end

function UniteTokenStructData:setSkillId(arg_16_1)
	self._skillId = arg_16_1
end

function UniteTokenStructData:setFormationPos(arg_17_1)
	self._pos = arg_17_1
end

function UniteTokenStructData:isMaxStarLevel()
	return self._nextStarId == 0
end

function UniteTokenStructData:getFragmentNum()
	local var_19_0 = var_0_1.get(self._baseId).fragment_id
	local var_19_1 = var_0_2.get(var_19_0)

	if not var_19_1 then
		return 0, 0
	end

	return g.core.model.User.fragmentsData:getFragmentNumById(var_19_0), var_19_1.combine_num
end

function UniteTokenStructData:getUpgradeNeedNum()
	local var_20_0 = var_0_3.get(self._upgradeId, self._level)

	return g.core.model.User.resourceData:getCoin(), var_20_0.cost_money, g.core.model.User.bagData:getCountById(var_20_0.cost_type, var_20_0.cost_value), var_20_0.cost_num, g.core.model.User.bagData:getCountById(var_20_0.cost_type_2, var_20_0.cost_value_2), var_20_0.cost_num_2
end

function UniteTokenStructData:getTokenMaxLevel()
	local var_21_0 = 0

	for iter_21_0 = 1, var_0_3.getLength() do
		if var_0_3.indexOf(iter_21_0).id == self._upgradeId then
			var_21_0 = var_21_0 + 1
		end
	end

	return var_21_0
end

function UniteTokenStructData:getStarUpFragmentNum()
	local var_22_0 = var_0_1.get(self._baseId)
	local var_22_1 = var_0_2.get(var_22_0.fragment_id)

	return g.core.model.User.fragmentsData:getFragmentNumById(var_22_0.fragment_id), var_22_0.next_star_num
end

function UniteTokenStructData:canCompose()
	local var_23_0, var_23_1 = self:getFragmentNum()

	return not self._isOwn and var_23_1 <= var_23_0
end

function UniteTokenStructData:canAwaken()
	if self._isAwaken or not self._isOwn then
		return false
	end

	return true
end

function UniteTokenStructData:getMaxStarLevel(arg_25_1)
	return g.core.model.User.uniteTokenData:getMaxStarLevel(arg_25_1)
end

function UniteTokenStructData:canUpgrade()
	local var_26_0, var_26_1, var_26_2, var_26_3, var_26_4, var_26_5 = self:getUpgradeNeedNum()

	return var_26_1 <= var_26_0 and var_26_3 <= var_26_2 and (var_26_5 > 0 or nil) and var_26_5 <= var_26_4, var_26_0, var_26_1, var_26_2, var_26_3, var_26_4, var_26_5
end

function UniteTokenStructData:canTenUpgrade()
	return self:canUpgrade()
end

function UniteTokenStructData:canStarup()
	local var_28_0, var_28_1 = self:getStarUpFragmentNum()

	return (var_28_1 ~= 0 or nil) and self._isOwn and var_28_1 <= var_28_0, var_28_0, var_28_1
end

function UniteTokenStructData:canRuneInset()
	local var_29_0 = g.core.config.unite_token_rune_info.get(self._advanceId)
	local var_29_1 = g.core.model.User.bagData:getOwnNum(var_29_0.item_type, var_29_0.item_value)

	for iter_29_0, iter_29_1 in ipairs((g.core.model.User.uniteTokenData:getHoleInsetList(self:getRunes(), var_29_0.num))) do
		if iter_29_1 == 0 and var_29_1 >= var_29_0["hole_" .. iter_29_0 .. "_cost"] then
			return true
		end
	end

	return false
end

function UniteTokenStructData:isTopShow()
	return self:canCompose() or self._isOwn
end

function UniteTokenStructData:isLineup()
	return self._pos > 0
end

function UniteTokenStructData:isAvailable(arg_32_1)
	if not arg_32_1 then
		return true
	end

	if (arg_32_1.quality == 0 or arg_32_1.quality == self._quality * 10 + self._cfg.rare) and (arg_32_1.uniteType == 0 or arg_32_1.uniteType == self._uniteType) then
		return true
	end

	return false
end

function UniteTokenStructData:getSkillDescription()
	local var_33_0 = g.core.config.skill_info.get(self._cfg.skill_id)

	return (string.gsub(var_33_0.description, "#num1#", var_33_0.formula_1_value_1 / 10))
end

function UniteTokenStructData:getFragProgress()
	local var_34_0 = var_0_1.get(self._baseId)
	local var_34_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_34_0.fragment_id)

	if self._isOwn then
		if self:isMaxStarLevel() then
			return 0, var_34_1
		else
			return var_34_0.next_star_num, var_34_1
		end
	else
		return var_0_2.get(var_34_0.fragment_id).combine_num, var_34_1
	end
end

function UniteTokenStructData:getFragId()
	return var_0_1.get(self._baseId).fragment_id
end

function UniteTokenStructData:getStrengthScore()
	local var_36_0 = 0
	local var_36_1 = g.core.config.unite_token_upgrade_info.get(self._upgradeId, self._level)

	for iter_36_0 = 1, 4 do
		if var_36_1["upgrade_type_" .. iter_36_0] > 0 then
			var_36_0 = var_36_0 + var_36_1["upgrade_value_" .. iter_36_0] * g.core.common.Attribute:getFightValueWeight(var_36_1["upgrade_type_" .. iter_36_0]) / 1000
		end
	end

	for iter_36_1 = 0, self._level do
		local var_36_2 = g.core.config.unite_token_upgrade_info.get(self._upgradeId, iter_36_1)

		if var_36_2.talent > 0 then
			local var_36_3 = g.core.config.talent_skill_info.get(var_36_2.talent)

			for iter_36_2 = 1, 3 do
				if var_36_3["affect_type_" .. iter_36_2] > 0 then
					var_36_0 = var_36_0 + var_36_3["affect_value_" .. iter_36_2] * g.core.common.Attribute:getFightValueWeight(var_36_3["affect_type_" .. iter_36_2]) / 1000
				end
			end
		end
	end

	return math.floor(var_36_0 + 0.5)
end

function UniteTokenStructData:isOwn()
	return self._isOwn
end

function UniteTokenStructData:getBaseId()
	return self._baseId
end

function UniteTokenStructData:getAdvanceId()
	return self._advanceId
end

function UniteTokenStructData:getLevel()
	return self._level
end

function UniteTokenStructData:getStarLevel()
	return self._starLevel
end

function UniteTokenStructData:getStar()
	return self:getStarLevel()
end

function UniteTokenStructData:getSkillId()
	return self._skillId
end

function UniteTokenStructData:getPos()
	return self._pos
end

function UniteTokenStructData:getQuality()
	return self._quality
end

function UniteTokenStructData:isAwaken()
	return self._isAwaken
end

function UniteTokenStructData:getUpgradeId()
	return self._upgradeId
end

function UniteTokenStructData:getNextStarId()
	return self._nextStarId
end

function UniteTokenStructData:getPreStarId()
	return self._preStarId
end

function UniteTokenStructData:getServerId()
	return self._id
end

function UniteTokenStructData:getRealServerId()
	return self._sid
end

function UniteTokenStructData:getSourceType()
	return self._sourceType
end

function UniteTokenStructData:getPut()
	return var_0_1.get(self._baseId).put
end

function UniteTokenStructData:getName()
	return self._name
end

function UniteTokenStructData:getCfg()
	return self._cfg
end

function UniteTokenStructData:getRunes()
	return self._runes
end

function UniteTokenStructData:getExpireTime()
	return self._expireTime
end

return UniteTokenStructData
