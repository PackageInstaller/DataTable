local ArtifactStruct = import(".ArtifactStruct")
local var_0_1 = g.core.config.artifact_info
local var_0_2 = g.core.config.artifact_spirit_info
local var_0_3 = g.core.config.artifact_upgrade_info
local var_0_4 = g.core.config.talent_skill_info
local var_0_5 = g.core.config.passive_skill_info
local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local var_0_7 = g.core.config.parameter_info
local ArtifactData = class("ArtifactData")

function ArtifactData:ctor()
	self:initData()
end

function ArtifactData:initData()
	self._ownList = {}
	self._artifactSidMap = {}
	self._artifactMap = {}
	self._artifactList = {}
	self._formationList = {}
	self._allEnhanceTalentList = {}
	self._enhanceTalentMap = {}
	self._ownMapWithQuality = {}

	self:_initCfg()
end

function ArtifactData:_initCfg()
	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		if not self._artifactMap[iter_3_1.advance_code] then
			local var_3_1 = ArtifactStruct.new(iter_3_1.advance_code)

			var_3_1:setCfg(iter_3_1)

			self._artifactList[#self._artifactList + 1] = var_3_1
			self._artifactMap[iter_3_1.advance_code] = var_3_1
		end

		if self._artifactMap[iter_3_1.advance_code]:isHasWeaponSpirit() then
			self._artifactMap[iter_3_1.advance_code]:setStarCfg(iter_3_1)
		end
	end

	for iter_3_2, iter_3_3 in var_0_2.ipairs() do
		if self._artifactMap[iter_3_3.advance_id] then
			self._artifactMap[iter_3_3.advance_id]:setSpiritStageCfg(iter_3_3, iter_3_3.spirit_stage)
		end
	end

	for iter_3_4 = 1, var_0_3.getLength() do
		local var_3_3 = var_0_3.indexOf(iter_3_4).toObject()

		self._enhanceTalentMap[var_3_3.id] = self._enhanceTalentMap[var_3_3.id] or {}

		if var_3_3.talent and var_3_3.talent > 0 then
			table.insert(self._allEnhanceTalentList, var_3_3)
			table.insert(self._enhanceTalentMap[var_3_3.id], {
				isUnLock = false,
				info = var_3_3,
				talentInfo = self:getTalentDescById(var_3_3.talent)
			})
		end
	end
end

function ArtifactData:updateArtifactData()
	local var_4_0 = g.core.model.User.bagData:getList(g.core.const.ConstMgr.BAG_TYPE.ARTIFACT)

	self._ownList = {}
	self._ownMapWithQuality = {}

	for iter_4_0 = 1, #var_4_0 do
		local var_4_1 = var_0_1.get(var_4_0[iter_4_0].base_id)

		if self._artifactMap[var_4_1.advance_code] then
			self._artifactMap[var_4_1.advance_code]:setCfg(var_4_1)
			self._artifactMap[var_4_1.advance_code]:setServerData(var_4_0[iter_4_0])

			self._artifactSidMap[var_4_0[iter_4_0].id] = self._artifactMap[var_4_1.advance_code]
			self._ownList[#self._ownList + 1] = self._artifactMap[var_4_1.advance_code]
			self._ownMapWithQuality[var_4_1.quality] = self._ownMapWithQuality[var_4_1.quality] or {}

			table.insert(self._ownMapWithQuality[var_4_1.quality], self._artifactMap[var_4_1.advance_code])
		end
	end

	for iter_4_1, iter_4_2 in ipairs(self._formationList) do
		if iter_4_2 > 0 then
			if self._artifactSidMap[iter_4_2] then
				self._artifactSidMap[iter_4_2]:updatePosition(iter_4_1)
			end
		end
	end

	self:sortArtifactList(self._ownList)
	self:_sortOwnMapWithQuality()
end

function ArtifactData:removeArtifact(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		for iter_5_2, iter_5_3 in ipairs(self._ownList) do
			if iter_5_1 == iter_5_3:getServerData().id then
				iter_5_3:deleteSelf()
				table.remove(self._ownList, iter_5_2)

				break
			end
		end
	end
end

function ArtifactData:updateArtifactPos(arg_6_1)
	arg_6_1 = arg_6_1 or {}
	self._formationList = arg_6_1

	for iter_6_0 = 1, #self._artifactList do
		self._artifactList[iter_6_0]:updatePosition(0)
	end

	for iter_6_1, iter_6_2 in ipairs(arg_6_1) do
		if iter_6_2 > 0 then
			if self._artifactSidMap[iter_6_2] then
				self._artifactSidMap[iter_6_2]:updatePosition(iter_6_1)
			end
		end
	end

	self:updateArtifactData()
end

function ArtifactData:getSpList(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(self._artifactList) do
		if arg_7_1(iter_7_1) and iter_7_1:isPut() then
			var_7_0[#var_7_0 + 1] = iter_7_1
		end
	end

	if not arg_7_3 then
		if arg_7_2 then
			self:sortFragList(var_7_0)
		else
			self:sortArtifactList(var_7_0)
		end
	end

	return var_7_0
end

function ArtifactData:getBagList()
	return self:getSpList(function(arg_9_0)
		return arg_9_0:isOwn() or arg_9_0:canCompose()
	end)
end

function ArtifactData:getNotLineupBagList()
	return self:getSpList(function(arg_11_0)
		return (arg_11_0:isOwn() or arg_11_0:canCompose()) and not arg_11_0:isLineup()
	end)
end

function ArtifactData:getLineUpList(arg_12_1)
	return self:getSpList(function(arg_13_0)
		return arg_13_0:isOwn() and arg_13_0:isLineup()
	end, nil, arg_12_1)
end

function ArtifactData:getNotLineUpList()
	return self:getSpList(function(arg_15_0)
		return arg_15_0:isOwn() and not arg_15_0:isLineup()
	end)
end

function ArtifactData:getCanResolveArtifactList()
	return self:getSpList(function(arg_17_0)
		return arg_17_0:isOwn() and not arg_17_0:isLineup() and arg_17_0:getCfg().quality < g.core.const.ConstMgr.QUALITY_TYPE.RED
	end)
end

function ArtifactData:getCanComposeArtifactList()
	return self:getSpList(function(arg_19_0)
		return arg_19_0:canCompose()
	end)
end

function ArtifactData:getOwnArtifactList(arg_20_1)
	return self:getSpList(function(arg_21_0)
		return arg_21_0:isOwn()
	end, nil, arg_20_1)
end

function ArtifactData:getAllCanSellFrag()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs((self:getOwnArtifactList())) do
		if iter_22_1:isMaxStar() and (not iter_22_1:isHasWeaponSpirit() or iter_22_1:isHasWeaponSpirit() and iter_22_1:isSpiritMaxStage()) then
			local var_22_1 = iter_22_1:getCfg()
			local var_22_2 = g.core.model.User.fragmentsData:getFragmentNumById(var_22_1.fragment_id)

			if var_22_2 > 0 then
				local var_22_3 = g.core.config.fragment_info.get(var_22_1.fragment_id)

				table.insert(var_22_0, {
					type = g.core.common.Goods.TYPE_FRAGMENT,
					value = var_22_1.fragment_id,
					size = var_22_2,
					priceType = var_22_3.price_type,
					priceValue = var_22_3.price_value,
					priceSize = var_22_3.price_size,
					quality = var_22_3.quality
				})
			end
		end
	end

	return var_22_0
end

function ArtifactData:getHasNotEnoughFragList()
	return self:getSpList(function(arg_24_0)
		return arg_24_0:hasNotEnoughFrag()
	end, true)
end

function ArtifactData:getHasOwnFragList()
	return self:getSpList(function(arg_26_0)
		return arg_26_0:isHasOwnFrag()
	end, true)
end

function ArtifactData:getGoldArtifactList()
	return self:getSpList(function(arg_28_0)
		return arg_28_0:isOwn() and arg_28_0:getCfg().quality == g.core.const.ConstMgr.QUALITY_TYPE.GOLD
	end)
end

function ArtifactData:hasArtifactByAdvanceId(arg_29_1)
	return self._artifactMap[arg_29_1]:isOwn(), self._artifactMap[arg_29_1]
end

function ArtifactData:getArtifactInfoByAdvanceId(arg_30_1)
	return self._artifactMap[arg_30_1]:getCfg()
end

function ArtifactData:getArtifactByBaseId(arg_31_1)
	return self._artifactMap[var_0_1.get(arg_31_1).advance_code]
end

function ArtifactData:getArtifactByAdvacnceId(arg_32_1)
	return self._artifactMap[arg_32_1]
end

function ArtifactData:sortArtifactList(arg_33_1)
	table.sort(arg_33_1, function(arg_34_0, arg_34_1)
		local var_34_0 = arg_34_0:getFormationPos()
		local var_34_1 = arg_34_1:getFormationPos()

		var_34_0 = var_34_0 == 0 and 9999 or var_34_0
		var_34_1 = var_34_1 == 0 and 9999 or var_34_1

		if var_34_0 ~= var_34_1 then
			return var_34_0 < var_34_1
		end

		local var_34_2 = arg_34_0:canCompose()

		if var_34_2 ~= arg_34_1:canCompose() then
			return var_34_2
		end

		local var_34_3 = arg_34_0:canStarUp()

		if var_34_3 ~= arg_34_1:canStarUp() then
			return var_34_3
		end

		local var_34_4 = arg_34_0:canSpiritStageUp()

		if var_34_4 ~= arg_34_1:canSpiritStageUp() then
			return var_34_4
		end

		local var_34_5 = arg_34_0:getCfg()
		local var_34_6 = arg_34_1:getCfg()

		if var_34_5.quality ~= var_34_6.quality then
			return var_34_5.quality > var_34_6.quality
		end

		return arg_34_0:getAdvanceId() > arg_34_1:getAdvanceId()
	end)
end

function ArtifactData:sortFragList(arg_35_1)
	table.sort(arg_35_1, function(arg_36_0, arg_36_1)
		local var_36_0 = arg_36_0:getCfg()
		local var_36_1 = arg_36_1:getCfg()
		local var_36_2 = g.core.model.User.fragmentsData:getFragmentNumById(var_36_0.fragment_id)
		local var_36_3 = g.core.model.User.fragmentsData:getFragmentNumById(var_36_1.fragment_id)
		local var_36_4 = arg_36_0:canCompose()

		if var_36_4 ~= arg_36_1:canCompose() then
			return var_36_4
		end

		if var_36_0.quality ~= var_36_1.quality then
			return var_36_0.quality > var_36_1.quality
		end

		if var_36_2 ~= var_36_3 then
			return var_36_3 < var_36_2
		end

		if var_36_0.advance_code ~= var_36_1.advance_code then
			return var_36_0.advance_code > var_36_1.advance_code
		end
	end)
end

function ArtifactData:getFragNumStarUpByAdvId(arg_37_1, arg_37_2)
	local var_37_0 = 0

	for iter_37_0, iter_37_1 in g.core.config.artifact_star_info.ipairs() do
		if iter_37_1.id == arg_37_1 and iter_37_1.star == arg_37_2 then
			var_37_0 = var_37_0 + iter_37_1.fragment_num
		end
	end

	return var_37_0
end

function ArtifactData:getArtifactByFormationIndex(arg_38_1)
	if self._formationList[arg_38_1] and self._formationList[arg_38_1] > 0 then
		return self._artifactSidMap[self._formationList[arg_38_1]]
	end
end

function ArtifactData:getLineupArtifactCount()
	local var_39_0 = 0

	for iter_39_0, iter_39_1 in ipairs(self._formationList) do
		if iter_39_1 > 0 then
			var_39_0 = var_39_0 + 1
		end
	end

	return var_39_0
end

function ArtifactData:isWornArtifact(arg_40_1)
	return self._formationList[arg_40_1] and self._formationList[arg_40_1] ~= 0
end

function ArtifactData:isCanWearArtifact()
	for iter_41_0 = 1, #self._ownList do
		if self._ownList[iter_41_0]:getServerData().pos == 0 then
			return true
		end
	end
end

function ArtifactData:getArtifactByPos(arg_42_1)
	local var_42_0 = self._formationList[arg_42_1] or 0

	if var_42_0 > 0 then
		return self._artifactSidMap[var_42_0]
	end
end

function ArtifactData:getQualityList()
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in var_0_1.ipairs() do
		var_43_0[iter_43_1.quality] = var_43_0[iter_43_1.quality] or true
	end

	local var_43_1 = table.keys(var_43_0)

	table.sort(var_43_1, function(arg_44_0, arg_44_1)
		if arg_44_0 ~= arg_44_1 then
			return arg_44_0 < arg_44_1
		end
	end)

	return var_43_1
end

function ArtifactData:getPreStarArtifactInfo(arg_45_1, arg_45_2)
	if arg_45_2 < 1 then
		return
	end

	for iter_45_0, iter_45_1 in var_0_1.ipairs() do
		if iter_45_1.advance_code == arg_45_1 and iter_45_1.star == arg_45_2 - 1 then
			return iter_45_1
		end
	end
end

function ArtifactData:getSkillInfo(arg_46_1, arg_46_2)
	arg_46_2 = arg_46_2 or 1

	local var_46_0 = g.core.config.artifact_info.get(arg_46_1)["passive_skill_" .. arg_46_2]

	if var_46_0 == 0 then
		return
	end

	return g.core.config.skill_info.get(var_0_5.get(var_46_0).passive_skill_value)
end

function ArtifactData:getSkillDesc(arg_47_1, arg_47_2)
	arg_47_2 = arg_47_2 or 1

	local var_47_0 = self:getSkillInfo(arg_47_1, arg_47_2)

	if var_47_0 then
		return g.core.utils.String.formatSkillDesc(var_47_0.id)
	else
		return ""
	end
end

function ArtifactData:getInfoListByAdvanceId(arg_48_1)
	return var_0_1.match(function(arg_49_0)
		return arg_49_0.advance_code == arg_48_1
	end)
end

function ArtifactData:getArtifactShowAllSkillsByBaseId(arg_50_1)
	local var_50_0 = {}
	local var_50_1 = 0
	local var_50_2

	if arg_50_1 then
		local var_50_3 = var_0_1.get(arg_50_1)
		local var_50_4 = var_50_3.star

		for iter_50_0, iter_50_1 in var_0_1.ipairs() do
			if var_50_3.advance_code == iter_50_1.advance_code and iter_50_1.skill_des1 >= 0 then
				local var_50_5 = self:getSkillEnhanceInfoByBaseId(iter_50_1.id)
				local var_50_6 = {
					level = iter_50_1.star,
					desc = var_50_5.description,
					buffDesc = var_50_5.buffDesc,
					name = var_0_5.get(var_50_3.passive_skill_1).name,
					isUnLock = var_50_4 >= iter_50_1.star,
					skillIconId = var_50_3.skill_icon_1,
					quality = var_50_3.quality
				}

				if var_50_4 >= iter_50_1.star then
					var_50_1 = var_50_1 + 1
				end

				if var_50_4 == iter_50_1.star then
					var_50_2 = var_50_6
				end

				table.insert(var_50_0, var_50_6)
			end
		end
	end

	return var_50_0, var_50_2, var_50_1
end

function ArtifactData:getMaxFullEnhanceLevel()
	local var_51_0 = var_0_3.indexOf(1).id
	local var_51_1 = 1

	for iter_51_0 = 1, var_0_3.getLength() do
		local var_51_2 = var_0_3.indexOf(iter_51_0)

		if var_51_2.id == var_51_0 then
			var_51_1 = math.max(var_51_1, var_51_2.level)
		end
	end

	return var_51_1
end

function ArtifactData:getEnhanceTalentByCodeAndLevel(arg_52_1, arg_52_2)
	local var_52_0 = self._enhanceTalentMap[arg_52_1] or {}

	if var_52_0 then
		if arg_52_2 >= self:getMaxFullEnhanceLevel() then
			return var_52_0[#var_52_0].info.talent
		end

		for iter_52_0, iter_52_1 in ipairs(var_52_0) do
			if arg_52_2 < iter_52_1.info.level then
				return iter_52_1.info.talent
			end
		end
	end
end

function ArtifactData:getCurArtifactAllEnhanceTalentInfo(arg_53_1, arg_53_2)
	local var_53_0 = clone(self._enhanceTalentMap[arg_53_1]) or {}

	if var_53_0 then
		local var_53_1 = 0

		for iter_53_0, iter_53_1 in ipairs(var_53_0) do
			iter_53_1.isUnLock = false

			if arg_53_2 >= iter_53_1.info.level then
				iter_53_1.isUnLock = true
				var_53_1 = var_53_1 + 1
			end
		end

		return var_53_0, var_53_1
	end
end

function ArtifactData:getNewCurArtifactAllEnhanceTalentInfo(arg_54_1, arg_54_2)
	local var_54_0 = {}

	if self._enhanceTalentMap[arg_54_1] then
		local var_54_1 = 0
		local var_54_2 = 0

		for iter_54_0, iter_54_1 in ipairs(self._enhanceTalentMap[arg_54_1]) do
			iter_54_1.isUnLock = false

			if arg_54_2 >= iter_54_1.info.level then
				iter_54_1.isUnLock = true
				var_54_2 = var_54_2 + 1
			else
				var_54_1 = var_54_1 + 1

				if var_54_1 > var_0_7.get(19004).parameter then
					break
				end
			end

			table.insert(var_54_0, iter_54_1)
		end

		return var_54_0, var_54_2
	end
end

function ArtifactData:getTalentDescById(arg_55_1)
	local var_55_0 = var_0_4.get(arg_55_1)

	return {
		name = var_55_0.name,
		desc = var_55_0.description
	}
end

function ArtifactData:getSkillEnhanceInfoByBaseId(arg_56_1)
	local var_56_0 = var_0_5.get(var_0_1.get(arg_56_1).skill_des1)
	local var_56_1, var_56_2 = g.core.utils.String.formatSkillEnchantInfoDesc(var_56_0.passive_skill_value, var_56_0.passive_skill_type)

	return {
		description = var_56_1,
		buffDesc = var_56_2
	}
end

function ArtifactData:_sortOwnMapWithQuality(arg_57_1)
	return function(arg_58_0, arg_58_1)
		local var_58_0 = arg_58_0:isLineup() and 1 or 0
		local var_58_1 = arg_58_1:isLineup() and 1 or 0
		local var_58_2 = arg_58_0:getQuality()
		local var_58_3 = arg_58_1:getQuality()
		local var_58_4 = arg_58_0:getStar()
		local var_58_5 = arg_58_1:getStar()
		local var_58_6 = self:isRelatedByAdvanceId(arg_58_0, arg_57_1) and 1 or 0
		local var_58_7 = self:isRelatedByAdvanceId(arg_58_1, arg_57_1) and 1 or 0
		local var_58_8 = arg_58_0:getArtifactBaseId()
		local var_58_9 = arg_58_1:getArtifactBaseId()

		if var_58_0 ~= var_58_1 then
			return var_58_1 < var_58_0
		end

		if var_58_6 ~= var_58_7 then
			return var_58_7 < var_58_6
		end

		if var_58_2 ~= var_58_3 then
			return var_58_3 < var_58_2
		end

		if var_58_4 ~= var_58_5 then
			return var_58_5 < var_58_4
		end

		return var_58_9 < var_58_8
	end
end

function ArtifactData:getAllOwnArtifactWithQuality(arg_59_1, arg_59_2, arg_59_3)
	local var_59_0 = arg_59_1 or ArtifactConst.QUALITY_TAB.ALL
	local var_59_1 = {}

	if var_59_0 == ArtifactConst.QUALITY_TAB.ALL then
		for iter_59_0, iter_59_1 in pairs(self._ownMapWithQuality) do
			for iter_59_2, iter_59_3 in pairs(iter_59_1) do
				if arg_59_2 then
					if self:_needInsertShowData(arg_59_3, iter_59_3) then
						table.insert(var_59_1, iter_59_3)
					end
				else
					table.insert(var_59_1, iter_59_3)
				end
			end
		end
	else
		local var_59_2 = self._ownMapWithQuality[self:getQualityByQualityTab(var_59_0)] or {}

		if #var_59_2 > 0 then
			if arg_59_2 then
				for iter_59_4, iter_59_5 in ipairs(var_59_2) do
					if self:_needInsertShowData(arg_59_3, iter_59_5) then
						table.insert(var_59_1, iter_59_5)
					end
				end
			else
				var_59_1 = var_59_2
			end
		end
	end

	if #var_59_1 > 1 then
		table.sort(var_59_1, self:_sortOwnMapWithQuality(arg_59_3))
	end

	return var_59_1
end

function ArtifactData:_needInsertShowData(arg_60_1, arg_60_2)
	if not arg_60_2:isLineup() then
		return true
	end

	return g.core.model.User.knightsData:getKnightByPos(arg_60_1):getAdvanceId() == arg_60_2:getBelongToKnightAvdIdIncludingMainRole() and arg_60_2:getFormationPos() ~= arg_60_1 and not arg_60_2:isDemo()
end

function ArtifactData:_artifactNotEquipBelongKnight(arg_61_1, arg_61_2)
	return g.core.model.User.knightsData:getKnightByPos(arg_61_1):getAdvanceId() == arg_61_2:getBelongToKnightAvdIdIncludingMainRole() and arg_61_2:getFormationPos() ~= arg_61_1 and not arg_61_2:isDemo()
end

function ArtifactData:getQualityByQualityTab(arg_62_1)
	if arg_62_1 == ArtifactConst.QUALITY_TAB.MR then
		return g.core.const.ConstMgr.QUALITY_TYPE.MR
	elseif arg_62_1 == ArtifactConst.QUALITY_TAB.UR then
		return g.core.const.ConstMgr.QUALITY_TYPE.UR
	elseif arg_62_1 == ArtifactConst.QUALITY_TAB.SSR then
		return g.core.const.ConstMgr.QUALITY_TYPE.SSR
	elseif arg_62_1 == ArtifactConst.QUALITY_TAB.SR then
		return g.core.const.ConstMgr.QUALITY_TYPE.SR
	elseif arg_62_1 == ArtifactConst.QUALITY_TAB.R then
		return g.core.const.ConstMgr.QUALITY_TYPE.R
	end

	return 0
end

function ArtifactData:getRelatedArtifactArrByKnight(arg_63_1)
	local var_63_0 = {}

	if not arg_63_1 then
		return var_63_0
	end

	for iter_63_0, iter_63_1 in pairs(self._ownMapWithQuality) do
		for iter_63_2, iter_63_3 in ipairs(iter_63_1) do
			if self:isKnightRelatedArtifact(iter_63_3, arg_63_1) then
				table.insert(var_63_0, iter_63_3)
			end
		end
	end

	if #var_63_0 > 1 then
		table.sort(var_63_0, function(arg_64_0, arg_64_1)
			return arg_64_0:getQuality() > arg_64_1:getQuality()
		end)
	end

	return var_63_0
end

function ArtifactData:isRelatedByAdvanceId(arg_65_1, arg_65_2)
	if arg_65_2 and arg_65_2 ~= 0 then
		local var_65_0 = g.core.model.User.knightsData:getKnightByFormationIndex(arg_65_2)

		if var_65_0 and arg_65_1 then
			if var_65_0:isMain() then
				if arg_65_1:isMainRoleRelatedArtifact() and var_65_0:getQuality() == 3 then
					return true
				end
			elseif var_65_0:getAdvanceId() == arg_65_1:getBelongToKnightAvdIdIncludingMainRole() then
				return true
			end
		end
	end

	return false
end

function ArtifactData:isKnightRelatedArtifact(arg_66_1, arg_66_2)
	if arg_66_2 and arg_66_1 then
		if arg_66_2:isMain() then
			return arg_66_1:isMainRoleRelatedArtifact()
		else
			return arg_66_2:getAdvanceId() == arg_66_1:getBelongToKnightAvdIdIncludingMainRole()
		end
	end

	return false
end

function ArtifactData:isRelatedByIdAndKnightAdvId(arg_67_1, arg_67_2)
	if arg_67_2 and arg_67_1 then
		local var_67_0 = g.core.model.User.knightsData:getKnightByAdvanceId(arg_67_2)
		local var_67_1 = self:getArtifactByAdvId(arg_67_1)

		if var_67_1 and var_67_0 then
			if var_67_0:isMain() then
				return var_67_1:isMainRoleRelatedArtifact() and var_67_0:getQuality() == 3
			else
				return arg_67_2 == var_67_1:getBelongToKnightAvdIdIncludingMainRole()
			end
		end
	end

	return false
end

function ArtifactData:notOwnNum()
	return #self._artifactList - #self._ownList
end

function ArtifactData:getItemIndexAtOwnList(arg_69_1)
	local var_69_0 = self:getOwnArtifactList()

	if #var_69_0 > 0 then
		for iter_69_0, iter_69_1 in ipairs(var_69_0) do
			local var_69_1 = iter_69_1:getServerOnlyId()

			if var_69_1 ~= 0 and var_69_1 == arg_69_1 then
				return iter_69_0
			end
		end
	end

	return 1
end

function ArtifactData:getManRoleRelatedAdvId(arg_70_1)
	local var_70_0

	if arg_70_1 == 210000 or arg_70_1 == 200000 then
		var_70_0 = 200000

		if g.core.model.User:isBoy() then
			var_70_0 = 210000
		end
	end

	return var_70_0
end

function ArtifactData:isHasArtifactCanStrength(arg_71_1)
	if arg_71_1 then
		local var_71_0 = arg_71_1.pos or nil

		if var_71_0 then
			local var_71_1 = self:getArtifactByPos(var_71_0)

			if var_71_1 and var_71_1:canEnhance() then
				return true
			end

			return false
		elseif arg_71_1 and arg_71_1.advId then
			local var_71_2 = self:getArtifactByAdvId(arg_71_1.advId)

			return var_71_2:isLineup() and var_71_2:canEnhance()
		end
	end

	do
		local var_71_3 = self:getLineUpList()

		if #var_71_3 > 0 then
			for iter_71_0, iter_71_1 in ipairs(var_71_3) do
				local var_71_4 = self:getArtifactByAdvId((iter_71_1:getAdvanceId()))

				if var_71_4 and var_71_4:canEnhance() then
					return true
				end
			end
		end

		return false
	end
end

function ArtifactData:isHasArtifactCanStarUp(arg_72_1)
	if arg_72_1 then
		local var_72_0 = arg_72_1.pos or nil

		if var_72_0 then
			local var_72_1 = self:getArtifactByPos(var_72_0)

			if var_72_1 and var_72_1:canStarUp() then
				return true
			end

			return false
		elseif arg_72_1 and arg_72_1.advId then
			return self:getArtifactByAdvId(arg_72_1.advId):canStarUp()
		end
	end

	do
		local var_72_2 = self:getOwnArtifactList()

		if #var_72_2 > 0 then
			for iter_72_0, iter_72_1 in ipairs(var_72_2) do
				local var_72_3 = self:getArtifactByAdvId((iter_72_1:getAdvanceId()))

				if var_72_3 and var_72_3:canStarUp() then
					return true
				end
			end
		end

		return false
	end
end

function ArtifactData:isHasArtifactCanCompose(arg_73_1)
	if arg_73_1 and arg_73_1.advId then
		return self:getArtifactByAdvId(arg_73_1.advId):canCompose()
	else
		if #self:getCanComposeArtifactList() > 0 then
			return true
		end

		return false
	end
end

function ArtifactData:isHasArtifactCanWear(arg_74_1)
	local function var_74_0(arg_75_0, arg_75_1)
		local var_75_0 = self:getArtifactByAdvId(arg_75_0)

		if var_75_0:isOwn() and (var_75_0:getFormationPos() or 0) == 0 then
			if arg_75_1 then
				if var_75_0:checkWearKnight(arg_75_1:getAdvanceId()) then
					return true
				else
					return false
				end
			else
				return true
			end
		end

		return false
	end

	if arg_74_1 then
		local var_74_1 = arg_74_1.pos or nil

		if var_74_1 then
			local var_74_2 = g.core.model.User.knightsData:getKnightByFormationIndex(var_74_1)

			if not self:getArtifactByPos(var_74_1) then
				if #self._ownList > 0 then
					for iter_74_0, iter_74_1 in ipairs(self._ownList) do
						if var_74_0(iter_74_1:getAdvanceId(), var_74_2) then
							return true
						end
					end
				end
			else
				for iter_74_2, iter_74_3 in ipairs(self._ownList) do
					if self:_artifactNotEquipBelongKnight(var_74_1, iter_74_3) then
						return true
					end
				end

				return false
			end
		elseif arg_74_1 and arg_74_1.advId then
			return var_74_0(arg_74_1.advId)
		end
	end

	do
		local var_74_3 = g.core.model.User.knightsData:getFormationKnights()

		for iter_74_4 = 1, 6 do
			if var_74_3[iter_74_4] and var_74_3[iter_74_4] ~= 0 then
				local var_74_4 = self:getArtifactByPos(iter_74_4)

				if not var_74_4 then
					if #self._ownList > 0 then
						local var_74_5 = g.core.model.User.knightsData:getKnightByFormationIndex(iter_74_4)

						for iter_74_5, iter_74_6 in ipairs(self._ownList) do
							if var_74_0(iter_74_6:getAdvanceId(), var_74_5) then
								return true
							end
						end
					end
				else
					for iter_74_7, iter_74_8 in ipairs(self._ownList) do
						if self:_artifactNotEquipBelongKnight(iter_74_4, var_74_4) then
							return true
						end
					end

					return false
				end
			end
		end

		return false
	end
end

function ArtifactData:isHasBagNewOwnArtifactCanStarUp()
	local var_76_0 = self:getOwnArtifactList()

	if #var_76_0 > 0 then
		for iter_76_0, iter_76_1 in ipairs(var_76_0) do
			local var_76_1 = self:getArtifactByAdvId((iter_76_1:getAdvanceId()))

			if var_76_1 and var_76_1:canStarUp() then
				return true
			end
		end
	end

	return false
end

function ArtifactData:isHasBagNewOwnArtifactCanSpiritStageUp(arg_77_1)
	if arg_77_1 and arg_77_1.advId then
		local var_77_0 = self:getArtifactByAdvId(arg_77_1.advId)

		if var_77_0 then
			return var_77_0:canSpiritStageUp()
		end

		return false
	end

	local var_77_1 = self:getOwnArtifactList()

	if #var_77_1 > 0 then
		for iter_77_0, iter_77_1 in ipairs(var_77_1) do
			local var_77_2 = self:getArtifactByAdvId((iter_77_1:getAdvanceId()))

			if var_77_2 and var_77_2:canSpiritStageUp() then
				return true
			end
		end
	end

	return false
end

function ArtifactData:isHasNewArtifact(arg_78_1)
	if arg_78_1 and arg_78_1.advId then
		if arg_78_1.serverId then
			if g.core.model.User.bagData:getNewData(g.core.const.ConstMgr.BAG_TYPE.ARTIFACT, arg_78_1.advId) then
				return true
			end
		else
			return false
		end
	else
		local var_78_0 = g.core.model.User.bagData:getNewData(g.core.const.ConstMgr.BAG_TYPE.ARTIFACT)

		if var_78_0 and next(var_78_0) then
			return true
		end
	end

	return false
end

function ArtifactData:getAllFullStarArtifacts(arg_79_1)
	local var_79_0 = {}

	for iter_79_0, iter_79_1 in ipairs((self:getOwnArtifactList())) do
		if iter_79_1:isMaxStar() and (arg_79_1 or nil) and arg_79_1 <= iter_79_1:getQuality() then
			table.insert(var_79_0, iter_79_1)
		end
	end

	return var_79_0
end

function ArtifactData:hasRelatedArtifactCanLineUp(arg_80_1)
	return false
end

function ArtifactData:getAllArtifactList()
	return self._artifactList
end

function ArtifactData:getArtifactBySid(arg_82_1)
	return self._artifactSidMap[arg_82_1]
end

function ArtifactData:getAllArtifactEnhanceTalentList()
	return self._allEnhanceTalentList
end

function ArtifactData:getArtifactEnhanceTalentByUpgradeCode(arg_84_1)
	return self._enhanceTalentMap[arg_84_1]
end

function ArtifactData:getArtifactByAdvId(arg_85_1)
	return self._artifactMap[arg_85_1]
end

function ArtifactData:setNotifyState(arg_86_1)
	self._curNotifyState = arg_86_1
end

function ArtifactData:isNotifyState()
	return self._curNotifyState
end

function ArtifactData:getFormationList()
	return self._formationList
end

function ArtifactData:getArtifactSpiritShowAllSkills(arg_89_1, arg_89_2)
	local var_89_0 = {}
	local var_89_1 = 0
	local var_89_2
	local var_89_3 = self._artifactMap[arg_89_1]:getSpiritStage()

	if arg_89_2 then
		var_89_3 = var_89_3 + 1
	end

	local var_89_4 = 0

	if self._artifactMap[arg_89_1] then
		for iter_89_0, iter_89_1 in ipairs((self._artifactMap[arg_89_1]:getAllAdjointSkill())) do
			if iter_89_1.skillId ~= var_89_4 then
				var_89_4 = iter_89_1.skillId

				local var_89_5 = var_0_5.get(iter_89_1.skillId)
				local var_89_6, var_89_7 = g.core.utils.String.formatSkillEnchantInfoDesc(var_89_5.passive_skill_value, var_89_5.passive_skill_type)
				local var_89_8 = {
					level = self._artifactMap[arg_89_1]:getSpiritStageCfg(iter_89_1.stage).skill_stars,
					desc = var_89_6,
					buffDesc = var_89_7,
					name = var_89_5.name,
					isUnLock = var_89_3 >= iter_89_1.stage,
					skillIconId = self._artifactMap[arg_89_1]:getSpiritAdjointSkillIcon(iter_89_1.stage),
					quality = self._artifactMap[arg_89_1]:getQuality(),
					stage = iter_89_1.stage
				}

				table.insert(var_89_0, var_89_8)

				if var_89_3 >= iter_89_1.stage then
					var_89_1 = #var_89_0
					var_89_2 = var_89_8
				end
			end
		end
	end

	return var_89_0, var_89_2, var_89_1
end

function ArtifactData:isSpiritCanUpgrade(arg_90_1)
	if arg_90_1 then
		local var_90_0 = arg_90_1.pos or nil

		if var_90_0 then
			local var_90_1 = self:getArtifactByPos(var_90_0)

			if var_90_1 and var_90_1:canSpiritUpgrade() then
				return true
			end

			return false
		elseif arg_90_1 and arg_90_1.advId then
			return self:getArtifactByAdvId(arg_90_1.advId):canSpiritUpgrade()
		end
	end

	do
		local var_90_2 = self:getLineUpList()

		if #var_90_2 > 0 then
			for iter_90_0, iter_90_1 in ipairs(var_90_2) do
				local var_90_3 = self:getArtifactByAdvId((iter_90_1:getAdvanceId()))

				if var_90_3 and var_90_3:canSpiritUpgrade() then
					return true
				end
			end
		end

		return false
	end
end

return ArtifactData
