local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.knight_advance_info
local var_0_2 = g.core.config.knight_awake_info
local var_0_3 = g.core.config.awake_task_info
local var_0_4 = g.core.config.attribute_info
local var_0_5 = g.core.config.awake_pendant_info
local var_0_6 = g.core.config.pendant_level_info
local var_0_7 = g.core.config.parameter_info
local var_0_8 = g.core.config.knight_spirit_info
local var_0_9 = g.core.config.knight_spirit_support_info
local var_0_10 = g.core.config.knight_spirit_support_skill_info
local var_0_11 = g.core.const.ConstMgr
local var_0_12 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_13 = g.core.const.ConstMgr.QUALITY_TYPE
local KnightStruct = class("KnightStruct")

KnightStruct.SpiritSupportList = nil
KnightStruct.SpiritSupportSkillList = nil

function KnightStruct.initKnightSupportList()
	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in var_0_9.ipairs() do
		var_1_0[iter_1_1.advance] = var_1_0[iter_1_1.advance] or {}
		var_1_0[iter_1_1.advance][iter_1_1.knight_support] = var_1_0[iter_1_1.advance][iter_1_1.knight_support] or {}

		table.insert(var_1_0[iter_1_1.advance][iter_1_1.knight_support], {
			cfg = iter_1_1,
			knightAdvId = iter_1_1.knight_support
		})
	end

	for iter_1_2, iter_1_3 in var_0_10.ipairs() do
		var_1_1[iter_1_3.advance_id] = var_1_1[iter_1_3.advance_id] or {}
		var_1_1[iter_1_3.advance_id][iter_1_3.level] = iter_1_3
	end

	KnightStruct.SpiritSupportList = var_1_0
	KnightStruct.SpiritSupportSkillList = var_1_1
end

function KnightStruct:getSpiritSupportKnights()
	if not KnightStruct.SpiritSupportList then
		KnightStruct.initKnightSupportList()
	end

	return KnightStruct.SpiritSupportList[self] or {}
end

function KnightStruct:getSpiritSupportSkills()
	if not KnightStruct.SpiritSupportList then
		KnightStruct.initKnightSupportList()
	end

	return KnightStruct.SpiritSupportSkillList[self] or {}
end

function KnightStruct:ctor(arg_4_1)
	self._advanceId = arg_4_1
	self._cfgInfo = {}
	self._cfgIdInfo = {}
	self._defaultCfg = nil
	self._info = nil
	self._attr = {}
	self._diffAttr = {}
	self._advStage = 0
	self._advNode = 0
	self._maxStarLv = 0
	self._isOtherUser = false
	self._otherUserName = ""
	self._spSoulLevel = 0
	self._spSupportLevel = 0
	self._activeSupportKnightMap = {}
	self._isNew = nil
	self._hasNewSkin = false
end

function KnightStruct:setIsOtherUser(arg_5_1, arg_5_2)
	self._isOtherUser = arg_5_1 == true
	self._otherUserName = arg_5_2
end

function KnightStruct:getIsOtherUser()
	return self._isOtherUser
end

function KnightStruct:getOtherUserName()
	return self._otherUserName
end

function KnightStruct:addCfgInfo(arg_8_1)
	self._cfgInfo[arg_8_1.star] = arg_8_1
	self._cfgIdInfo[arg_8_1.id] = arg_8_1
	self._defaultCfg = self._defaultCfg or arg_8_1

	self:calMaxTrainLevel()
end

function KnightStruct:onlyAddCfgInfo(arg_9_1)
	self._cfgInfo[arg_9_1.star] = arg_9_1
	self._cfgIdInfo[arg_9_1.id] = arg_9_1
	self._defaultCfg = self._defaultCfg or arg_9_1
end

function KnightStruct:setInfo(arg_10_1)
	self._info = arg_10_1

	self:calMaxTrainLevel()

	if self._info.star_level > self._maxStarLv then
		self._info.star_level = self._maxStarLv
	end

	self._spSoulLevel = self._info.support_level or 0
	self._spSupportLevel = self._info.support_skill_level or 0
	self._activeSupportKnightMap = {}

	for iter_10_0, iter_10_1 in ipairs(self._info.support_knights or {}) do
		self._activeSupportKnightMap[iter_10_1] = true
	end

	self:initAttrs()
	self:updateAdvStage()
end

function KnightStruct:updateMrStruct(arg_11_1)
	self._spSoulLevel = arg_11_1.support_level or 0
	self._spSupportLevel = arg_11_1.support_skill_level or 0
	self._activeSupportKnightMap = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.support_knights or {}) do
		self._activeSupportKnightMap[iter_11_1] = true
	end
end

function KnightStruct:onlySetInfo(arg_12_1)
	self._info = arg_12_1
end

function KnightStruct:getTrainLevel()
	local var_13_0 = self._info.star_level

	if self:getAwakeStage() < g.core.model.User.trainData:getTrainInfoByLevel(self._info.star_level).awake_stage then
		var_13_0 = var_13_0 - 1
	end

	return var_13_0
end

function KnightStruct:getServerId()
	return (self._info or nil) and (self._info.id or 0)
end

function KnightStruct:updateTrainLevel()
	if self._info.star_level > self._maxStarLv then
		self._info.star_level = self._maxStarLv
	end
end

function KnightStruct:updateAdvStage()
	local var_16_0 = self:getBaseInfo()

	if var_16_0 then
		local var_16_1 = g.core.config.knight_advance_info.get(var_16_0.promote_code, self._info.advance_level)

		self._advStage = var_16_1.stage
		self._advNode = var_16_1.node
	end
end

function KnightStruct:getAdvStageAndLevel()
	return self._advStage, self._advNode
end

function KnightStruct:getPromoteLevel()
	return (self._info or nil) and (self._info.advance_level or 0)
end

function KnightStruct:updatePos(arg_19_1)
	self._info.position = arg_19_1
end

function KnightStruct:getFormationPos()
	return self._info.position
end

function KnightStruct:isDisplay()
	return self._defaultCfg and self._defaultCfg.is_display == 1
end

function KnightStruct:isPut()
	return self._defaultCfg and self._defaultCfg.put == 1
end

function KnightStruct:isElementLeader()
	local var_23_0 = self:getBaseInfo()

	return var_23_0 ~= nil and var_23_0.is_element_leader > 0
end

function KnightStruct:isLineup()
	return self._info and self._info.position > 0 and self._info.position <= var_0_12.LINEUP_MAX
end

function KnightStruct:isHelper()
	return self._info and self._info.position > var_0_12.LINEUP_MAX and self._info.position <= var_0_12.KNIGHT_PARTNER_MAX
end

function KnightStruct:isBackup()
	return self._info and self._info.position > var_0_12.KNIGHT_PARTNER_MAX
end

function KnightStruct:getBaseInfo()
	if self._info then
		return self._cfgIdInfo[self._info.base_id]
	else
		return self._defaultCfg
	end
end

function KnightStruct:getGroup()
	return self:getBaseInfo().group
end

function KnightStruct:getProfession()
	return self:getBaseInfo().profession
end

function KnightStruct:getDamage()
	return self:getBaseInfo().attack_type
end

function KnightStruct:getElement()
	return self:getBaseInfo().classical
end

function KnightStruct:getProfessionTxt()
	return var_0_12.KNIGHT_PROFESSION[self:getProfession()] or ""
end

function KnightStruct:getBaseId()
	return self:getBaseInfo().id
end

function KnightStruct:getQuality()
	return self:getBaseInfo().quality
end

function KnightStruct:getInfo()
	return self._info
end

function KnightStruct:getName()
	if self:isMain() then
		if self._isOtherUser then
			return self._otherUserName
		else
			return g.core.model.User:getName()
		end
	else
		return self:getBaseInfo().name
	end
end

function KnightStruct:getResInfo()
	local var_37_0 = self:getBaseInfo().res_id

	if self:isMain() and g.core.model.User:getDressId() ~= 0 then
		local var_37_1 = g.core.model.User:getDressId()

		var_37_0 = self:getBaseInfo().sex == 0 and g.core.config.dress_info.get(var_37_1).woman_res_id or g.core.config.dress_info.get(var_37_1).man_res_id
	end

	if self:isWearSkin() then
		local var_37_2 = g.core.config.skin_info.fetch(self._info.skin)

		if var_37_2 then
			var_37_0 = var_37_2.res
		end
	end

	return g.core.config.knight_base_info.get(var_37_0)
end

function KnightStruct:getVoiceResInfo(arg_38_1, arg_38_2)
	local var_38_0 = self:getBaseInfo().res_id

	if self:isMain() and g.core.model.User:getDressId() ~= 0 and not arg_38_1 then
		local var_38_1 = g.core.model.User:getDressId()

		var_38_0 = self:getBaseInfo().sex == 0 and g.core.config.dress_info.get(var_38_1).woman_res_id or g.core.config.dress_info.get(var_38_1).man_res_id
	end

	if self:isWearSkin() and not arg_38_1 then
		local var_38_2 = g.core.config.skin_info.fetch(self._info.skin)

		if var_38_2 then
			var_38_0 = var_38_2.res
		end
	end

	local var_38_3 = g.core.config.knight_show_info.fetch(var_38_0)

	if not arg_38_2 and var_38_3 and var_38_3.toObject then
		var_38_3 = var_38_3.toObject()

		local var_38_4 = g.core.model.User:isBoy()

		for iter_38_0, iter_38_1 in pairs(var_38_3) do
			if var_38_3[iter_38_0 .. "_woman"] and var_38_3[iter_38_0 .. "_woman"] ~= "" and var_38_3[iter_38_0 .. "_woman"] ~= iter_38_1 and not var_38_4 then
				var_38_3[iter_38_0] = var_38_3[iter_38_0 .. "_woman"]
			end
		end
	end

	return var_38_3
end

function KnightStruct:getPreResInfo()
	local var_39_0 = self:getBaseInfo()

	for iter_39_0, iter_39_1 in g.core.config.knight_info.ipairs() do
		if iter_39_1.next_star_id == var_39_0.id then
			return g.core.config.knight_base_info.get(iter_39_1.res_id)
		end
	end
end

function KnightStruct:isWearSkin()
	if self._info and self._info.skin and self._info.skin > 0 and self._info.skin_ts and (self._info.skin_ts == 0 or self._info.skin_ts > g.core.common.ServerTime:getTime()) then
		return true
	end

	return false
end

function KnightStruct:getSkin()
	if self._info and self._info.skin and self._info.skin > 0 and self._info.skin_ts and (self._info.skin_ts == 0 or self._info.skin_ts > g.core.common.ServerTime:getTime()) then
		return self._info.skin, self._info.skin_ts
	end

	return 0
end

function KnightStruct:isChangeImage()
	local var_42_0 = self:getBaseInfo()
	local var_42_1 = {}

	for iter_42_0, iter_42_1 in g.core.config.knight_info.ipairs() do
		if iter_42_1.advance_id == var_42_0.advance_id then
			var_42_1[iter_42_1.star + 1] = iter_42_1

			if #var_42_1 == var_0_12.STAR_MAX + 1 then
				break
			end
		end
	end

	local var_42_2 = var_42_1[1].res_id

	for iter_42_2 = 1, #var_42_1 do
		if var_42_2 ~= var_42_1[iter_42_2].res_id then
			return true, var_42_1[iter_42_2], var_42_1[1]
		end
	end

	return false
end

function KnightStruct:getWingId()
	if self:isMain() then
		return g.core.model.User.wingData:getShowWingId()
	end

	return 0
end

function KnightStruct:initAttrs()
	if self:isLineup() then
		self._attr.hp = self._info.init_hp
		self._attr.attack = self._info.attack
		self._attr.phyDef = self._info.phy_defence
		self._attr.magDef = self._info.mag_defence
		self._attr.otherAttr = {}

		local var_44_0 = self._info.other_attrs or {}

		for iter_44_0 = 1, #var_44_0 do
			self._attr.otherAttr[var_44_0[iter_44_0].id] = var_44_0[iter_44_0].num
		end
	else
		local var_44_1 = self:getCurAttr()

		self._attr.hp = var_44_1[1]
		self._attr.attack = var_44_1[2]
		self._attr.phyDef = var_44_1[3]
		self._attr.magDef = var_44_1[4]
	end
end

function KnightStruct:updateAttrs()
	if self:isLineup() then
		self._diffAttr.hp = math.uint64_sub(self._info.init_hp, self._attr.hp)
		self._diffAttr.attack = self._info.attack - self._attr.attack
		self._diffAttr.phyDef = self._info.phy_defence - self._attr.phyDef
		self._diffAttr.magDef = self._info.mag_defence - self._attr.magDef

		self:_updateOtherDiffAttr()
	else
		local var_45_0 = self:getCurAttr()

		self._diffAttr.hp = math.uint64_sub(var_45_0[1], self._attr.hp)
		self._diffAttr.attack = var_45_0[2] - self._attr.attack
		self._diffAttr.phyDef = var_45_0[3] - self._attr.phyDef
		self._diffAttr.magDef = var_45_0[4] - self._attr.magDef
	end

	self:initAttrs()
end

function KnightStruct:_updateOtherDiffAttr()
	local var_46_0 = {}
	local var_46_1 = {}
	local var_46_2 = self._info.other_attrs or {}

	for iter_46_0 = 1, #var_46_2 do
		var_46_0[var_46_2[iter_46_0].id] = var_46_2[iter_46_0].num
	end

	local var_46_3 = self._attr.otherAttr or {}

	for iter_46_1, iter_46_2 in pairs(var_46_0) do
		var_46_1[iter_46_1] = var_46_3[iter_46_1] and iter_46_2 - var_46_3[iter_46_1] or iter_46_2
	end

	for iter_46_3, iter_46_4 in pairs(var_46_3) do
		if not var_46_0[iter_46_3] then
			var_46_1[iter_46_3] = iter_46_4 * -1
		end
	end

	self._diffAttr.otherAttr = var_46_1
end

function KnightStruct:getCurAttr()
	local var_47_0 = {}
	local var_47_1 = self:getLevelAttrs()
	local var_47_2 = self:getCurTrainAttrInfos()
	local var_47_3 = self:getAdvaceAttrs()
	local var_47_4 = self:getAwakeAttrs()

	for iter_47_0 = 1, 4 do
		var_47_0[iter_47_0] = var_47_1[iter_47_0] + var_47_2[iter_47_0] + var_47_3[iter_47_0] + (var_47_4[iter_47_0] or 0)
	end

	return var_47_0
end

function KnightStruct:getAttrs()
	return self._attr
end

function KnightStruct:getBaseAttrs()
	local var_49_0 = {}
	local var_49_1 = {
		type = 1
	}

	var_49_1.value = self._attr.hp or self._defaultCfg.base_hp

	table.insert(var_49_0, var_49_1)

	local var_49_2 = {
		type = 2
	}

	var_49_2.value = self._attr.attack or self._defaultCfg.base_attack

	table.insert(var_49_0, var_49_2)

	local var_49_3 = {
		type = 3
	}

	var_49_3.value = self._attr.phyDef or self._defaultCfg.base_physical_defence

	table.insert(var_49_0, var_49_3)

	local var_49_4 = {
		type = 4
	}

	var_49_4.value = self._attr.magDef or self._defaultCfg.base_magical_defence

	table.insert(var_49_0, var_49_4)

	return var_49_0
end

function KnightStruct:getDiffAttrs()
	return self._diffAttr
end

function KnightStruct:isMain()
	return self:getBaseInfo().type == 1
end

function KnightStruct:isOwn()
	return self._info ~= nil
end

function KnightStruct:calcSortList(arg_53_1)
	local var_53_0 = {}
	local var_53_1 = self:getBaseInfo()
	local var_53_2, var_53_3, var_53_4 = self:canCompose()

	var_53_0[#var_53_0 + 1] = var_53_2 and 1 or 0

	if self._info then
		if self:isLineup() then
			var_53_0[#var_53_0 + 1] = var_0_12.KNIGHT_BACKUP_MAX + 1 - self._info.position or 0
		end
	end

	var_53_0[#var_53_0 + 1] = self:canStarUp() and 1 or 0

	local var_53_6 = false

	if self:isOwn() then
		local var_53_7 = {
			advId = self:getAdvanceId()
		}

		var_53_6 = g.core.model.User.weddingData:hasWeddingRedPoint(var_53_7, false) or g.core.model.User.weddingData:hasWeddingSpecialRing(var_53_7) or g.core.model.User.knightsData:isHasMrKnightSoulUp(var_53_7) or g.core.model.User.knightsData:isHasMrKnightSupportActive(var_53_7) or g.core.model.User.knightsData:isHasMrKnightSupportSkillUp(var_53_7)
	end

	var_53_0[#var_53_0 + 1] = var_53_6 and 1 or 0
	var_53_0[#var_53_0 + 1] = var_53_1.quality
	var_53_0[#var_53_0 + 1] = var_53_1.star

	if self._info then
		var_53_0[#var_53_0 + 1] = self._info.level or 0
	end

	if self._info then
		var_53_0[#var_53_0 + 1] = self._info.advance_level or 0
	end

	var_53_0[#var_53_0 + 1] = var_53_1.id
	self._sortList = var_53_0
end

function KnightStruct:calcLineupSortList(arg_54_1, arg_54_2)
	local var_54_0 = {}
	local var_54_1 = self:getBaseInfo()

	var_54_0[#var_54_0 + 1] = var_54_1.advance_id == arg_54_1 and 1 or 0

	if self._info then
		if self:isLineup() then
			var_54_0[#var_54_0 + 1] = var_0_12.KNIGHT_BACKUP_MAX + 1 - self._info.position or 0
		end

		if self:isBackup() then
			var_54_0[#var_54_0 + 1] = var_0_12.KNIGHT_BACKUP_MAX + 1 - self._info.position or 0
		end

		if self:isHelper() then
			var_54_0[#var_54_0 + 1] = var_0_12.KNIGHT_BACKUP_MAX + 1 - self._info.position or 0
		end
	end

	var_54_0[#var_54_0 + 1] = var_54_1.quality
	var_54_0[#var_54_0 + 1] = g.core.model.User.formationData:getAvailAssctCountByAdvId(var_54_1.advance_id, arg_54_2)
	var_54_0[#var_54_0 + 1] = var_54_1.star
	var_54_0[#var_54_0 + 1] = var_54_1.id
	self._sortList = var_54_0
end

function KnightStruct:getSortList()
	return self._sortList
end

function KnightStruct:hasNotEnoughFrag()
	if self:isOwn() or self:canCompose() then
		return false
	end

	local var_56_0 = self:getBaseInfo()

	if var_56_0.type == 1 then
		return false, 0, 0
	end

	return g.core.model.User.fragmentsData:getFragmentNumById(var_56_0.fragment_id) > 0
end

function KnightStruct:hasNoneFrag()
	return g.core.model.User.fragmentsData:getFragmentNumById(self:getBaseInfo().fragment_id) == 0
end

function KnightStruct:canCompose()
	if self:isOwn() then
		return false
	end

	local var_58_0 = self:getBaseInfo()

	if var_58_0.type == 1 then
		return false, 0, 0
	end

	local var_58_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_58_0.fragment_id)

	if var_58_0.fragment_id == 0 then
		return false, 0, 0
	end

	local var_58_2 = g.core.config.fragment_info.get(var_58_0.fragment_id)

	return var_58_1 >= var_58_2.combine_num, var_58_1, var_58_2.combine_num
end

function KnightStruct:canStarUp()
	local var_59_0 = self:getBaseInfo()
	local var_59_1 = true

	if var_59_0.type == 1 then
		return false, 0, 0
	end

	if var_59_0.next_star_id == 0 then
		return false, 0, 0
	end

	local var_59_2 = g.core.model.User.fragmentsData:getFragmentNumById(var_59_0.fragment_id)

	if not self:isOwn() then
		var_59_1 = false
	elseif var_59_2 < var_59_0.next_star_num then
		var_59_1 = false
	end

	return var_59_1, var_59_2, var_59_0.next_star_num
end

function KnightStruct:canDevelop()
	return false
end

function KnightStruct:getNextStarAttr(arg_61_1, arg_61_2)
	local var_61_0 = 1

	if self._info then
		arg_61_1 = arg_61_1 or self:getBaseInfo().star or 0
		var_61_0 = self._info.level
	else
		arg_61_1 = arg_61_1 or 0
	end

	local var_61_1 = arg_61_1 == 7

	arg_61_1 = math.min(arg_61_1 + 1, 7)

	local var_61_2 = self:getBaseInfo()

	if arg_61_2 then
		var_61_2 = self._cfgIdInfo[arg_61_2]
	end

	local var_61_3 = {}

	if var_61_2.id - var_61_2.star + arg_61_1 > 0 then
		local var_61_4 = var_61_0 - 1

		if var_61_0 - 1 < 0 then
			var_61_4 = 0
		end

		var_61_3.hp = self._cfgIdInfo[var_61_2.id - var_61_2.star + arg_61_1].base_hp + self._cfgIdInfo[var_61_2.id - var_61_2.star + arg_61_1].develop_hp * var_61_4
		var_61_3.attack = self._cfgIdInfo[var_61_2.id - var_61_2.star + arg_61_1].base_attack + self._cfgIdInfo[var_61_2.id - var_61_2.star + arg_61_1].develop_attack * var_61_4
		var_61_3.phyDef = self._cfgIdInfo[var_61_2.id - var_61_2.star + arg_61_1].base_physical_defence + self._cfgIdInfo[var_61_2.id - var_61_2.star + arg_61_1].develop_physical_defence * var_61_4
		var_61_3.magDef = self._cfgIdInfo[var_61_2.id - var_61_2.star + arg_61_1].base_magical_defence + self._cfgIdInfo[var_61_2.id - var_61_2.star + arg_61_1].develop_magical_defence * var_61_4
	end

	local var_61_5 = {
		hp = var_61_2.base_hp + var_61_2.develop_hp * (var_61_0 - 1),
		attack = var_61_2.base_attack + var_61_2.develop_attack * (var_61_0 - 1),
		phyDef = var_61_2.base_physical_defence + var_61_2.develop_physical_defence * (var_61_0 - 1),
		magDef = var_61_2.base_magical_defence + var_61_2.develop_magical_defence * (var_61_0 - 1)
	}
	local var_61_6 = {}

	table.insert(var_61_6, {
		type = 1,
		value = var_61_5.hp,
		value2 = var_61_3.hp
	})
	table.insert(var_61_6, {
		type = 2,
		value = var_61_5.attack,
		value2 = var_61_3.attack
	})
	table.insert(var_61_6, {
		type = 3,
		value = var_61_5.phyDef,
		value2 = var_61_3.phyDef
	})
	table.insert(var_61_6, {
		type = 4,
		value = var_61_5.magDef,
		value2 = var_61_3.magDef
	})

	return var_61_6, var_61_1
end

function KnightStruct:getCurStarAttr(arg_62_1, arg_62_2)
	local var_62_0 = 1

	if self._info then
		arg_62_1 = arg_62_1 or self._info.star
		var_62_0 = self._info.level
	else
		arg_62_1 = arg_62_1 or 1
	end

	local var_62_1 = self:getBaseInfo()

	if arg_62_2 then
		var_62_1 = self._cfgIdInfo[arg_62_2]
	end

	local var_62_2 = {}

	if var_62_1.advance_id + arg_62_1 - 1 > 0 then
		local var_62_3 = var_62_0 - 1

		if var_62_0 - 1 < 0 then
			var_62_3 = 0
		end

		var_62_2.hp = self._cfgIdInfo[var_62_1.advance_id + arg_62_1 - 1].base_hp + self._cfgIdInfo[var_62_1.advance_id + arg_62_1 - 1].develop_hp * var_62_3
		var_62_2.attack = self._cfgIdInfo[var_62_1.advance_id + arg_62_1 - 1].base_attack + self._cfgIdInfo[var_62_1.advance_id + arg_62_1 - 1].develop_attack * var_62_3
		var_62_2.phyDef = self._cfgIdInfo[var_62_1.advance_id + arg_62_1 - 1].base_physical_defence + self._cfgIdInfo[var_62_1.advance_id + arg_62_1 - 1].develop_physical_defence * var_62_3
		var_62_2.magDef = self._cfgIdInfo[var_62_1.advance_id + arg_62_1 - 1].base_magical_defence + self._cfgIdInfo[var_62_1.advance_id + arg_62_1 - 1].develop_magical_defence * var_62_3
	end

	local var_62_4 = {
		hp = var_62_1.base_hp + var_62_1.develop_hp * (var_62_0 - 1),
		attack = var_62_1.base_attack + var_62_1.develop_attack * (var_62_0 - 1),
		phyDef = var_62_1.base_physical_defence + var_62_1.develop_physical_defence * (var_62_0 - 1),
		magDef = var_62_1.base_magical_defence + var_62_1.develop_magical_defence * (var_62_0 - 1)
	}
	local var_62_5 = {}

	table.insert(var_62_5, {
		type = 1,
		value = var_62_2.hp,
		value2 = var_62_4.hp
	})
	table.insert(var_62_5, {
		type = 2,
		value = var_62_2.attack,
		value2 = var_62_4.attack
	})
	table.insert(var_62_5, {
		type = 3,
		value = var_62_2.phyDef,
		value2 = var_62_4.phyDef
	})
	table.insert(var_62_5, {
		type = 4,
		value = var_62_2.magDef,
		value2 = var_62_4.magDef
	})

	return var_62_5
end

function KnightStruct:getStarTalentData()
	local var_63_0 = self:getBaseInfo()
	local var_63_1 = {}

	for iter_63_0 = 1, var_0_12.STAR_TALENT do
		if var_63_0["star_talent_" .. iter_63_0] > 0 then
			table.insert(var_63_1, {
				talentId = var_63_0["star_talent_" .. iter_63_0],
				value = var_63_0.star
			})
		end
	end

	return #var_63_1, var_63_1
end

function KnightStruct:getWeddingAllTalentData()
	return g.core.model.User.weddingData:getWeddingAllTalentData(self._advanceId)
end

function KnightStruct:getLevelAttrs(arg_65_1, arg_65_2)
	arg_65_1 = self._info and (arg_65_1 or self._info.level) or arg_65_1 or 1

	local var_65_0 = self:getBaseInfo()

	if arg_65_2 then
		var_65_0 = self._cfgIdInfo[arg_65_2]
	end

	return {
		var_65_0.base_hp + (arg_65_1 - 1) * var_65_0.develop_hp,
		var_65_0.base_attack + (arg_65_1 - 1) * var_65_0.develop_attack,
		var_65_0.base_physical_defence + (arg_65_1 - 1) * var_65_0.develop_physical_defence,
		var_65_0.base_magical_defence + (arg_65_1 - 1) * var_65_0.develop_magical_defence
	}
end

function KnightStruct:getCurTrainAttrInfos()
	local var_66_0 = {}

	for iter_66_0 = 1, 4 do
		var_66_0[iter_66_0] = self:getCurTrainAttrInfo(iter_66_0).cur
	end

	local var_66_1 = {
		"initial_hp",
		"attack",
		"phy_defence",
		"mag_defence"
	}

	for iter_66_1 = 1, self._info.star_level - 1 do
		local var_66_2 = self:getTrainInfo(iter_66_1)

		for iter_66_2 = 1, 4 do
			var_66_0[iter_66_2] = var_66_0[iter_66_2] + var_66_2[var_66_1[iter_66_2]]
		end
	end

	return var_66_0
end

function KnightStruct:getCurTrainAttrInfo(arg_67_1)
	if not self._info then
		return {}
	end

	local var_67_0 = self:getTrainInfo()
	local var_67_1 = {
		cur = self._info.star_train[arg_67_1],
		next = self._info.star_train[arg_67_1 + 4],
		total = var_67_0[({
			"initial_hp",
			"attack",
			"phy_defence",
			"mag_defence"
		})[arg_67_1]]
	}

	if var_67_0.level < self._info.star_level then
		var_67_1.next = 0
		var_67_1.cur = var_67_1.total
	end

	return var_67_1
end

function KnightStruct:getTrainState()
	if self:getTrainInfo().level < self._info.star_level then
		return 4
	end

	local var_68_0 = true

	for iter_68_0 = 1, 4 do
		local var_68_1 = self:getCurTrainAttrInfo(iter_68_0)

		if var_68_1.next ~= 0 then
			return 1
		end

		if var_68_1.cur < var_68_1.total then
			var_68_0 = false
		end
	end

	if not var_68_0 then
		return 0
	end

	if not self._info.is_star_activited then
		return 2
	end

	if not self:isMaxTrainLevel() then
		-- block empty
	end

	return 3
end

function KnightStruct:getNextTrainState()
	local var_69_0 = 0

	for iter_69_0 = 1, 4 do
		local var_69_1 = self:getCurTrainAttrInfo(iter_69_0)

		if var_69_1.cur + var_69_1.next >= var_69_1.total then
			var_69_0 = var_69_0 + 1
		else
			return 1
		end
	end

	if var_69_0 == 4 then
		return 2
	else
		return 1
	end
end

KnightStruct.TRAIN_ITEM = 2

function KnightStruct:getTrainCost(arg_70_1)
	return ({
		5,
		50,
		500
	})[arg_70_1 + 1], (g.core.model.User.itemsData:getItemNumById(KnightStruct.TRAIN_ITEM))
end

function KnightStruct:getTrainInfo(arg_71_1)
	local var_71_0 = self:getBaseInfo().knight_star_id

	if arg_71_1 then
		return g.core.config.knight_star_info.fetch(var_71_0, arg_71_1)
	else
		local var_71_1 = g.core.config.knight_star_info.get(var_71_0, self._info.star_level)

		if self:getAwakeStage() < var_71_1.awake_stage then
			var_71_1 = g.core.config.knight_star_info.get(var_71_0, self._info.star_level - 1)
		end

		return var_71_1
	end
end

function KnightStruct:calMaxTrainLevel()
	local var_72_0 = self:getBaseInfo().knight_star_id
	local var_72_1 = 0

	for iter_72_0, iter_72_1 in g.core.config.knight_star_info.ipairs() do
		if 0 ~= 0 and 0 ~= var_72_0 then
			break
		end

		local var_72_2

		if iter_72_1.id == var_72_0 then
			var_72_1 = var_72_1 + 1
			var_72_2 = var_72_0
		end
	end

	self._maxStarLv = var_72_1
end

function KnightStruct:getMaxTrainLevel()
	return self._maxStarLv
end

function KnightStruct:isMaxTrainLevel()
	return self._info and self._info.star_level == self._maxStarLv or false
end

function KnightStruct:getTrainPer()
	local var_75_0 = 0

	for iter_75_0 = 1, 4 do
		local var_75_1 = self:getCurTrainAttrInfo(iter_75_0)

		var_75_0 = var_75_0 + var_75_1.cur / var_75_1.total
	end

	return var_75_0 / 4
end

function KnightStruct:getTrainInfos()
	local var_76_0 = {}
	local var_76_1 = 1
	local var_76_2 = self:getTrainInfo(1)

	while var_76_2 do
		var_76_0[#var_76_0 + 1] = var_76_2
		var_76_1 = var_76_1 + 1
		var_76_2 = self:getTrainInfo(var_76_1)
	end

	return var_76_0
end

function KnightStruct:getAdvaceAttrs()
	local var_77_0 = {
		0,
		0,
		0,
		0
	}

	local function var_77_1(arg_78_0, arg_78_1)
		if arg_78_0 == 0 then
			return
		end

		if var_77_0[arg_78_0] then
			var_77_0[arg_78_0] = var_77_0[arg_78_0] + arg_78_1
		end
	end

	local var_77_2 = self:getBaseInfo()

	for iter_77_0 = 1, self._info.advance_level - 1 do
		local var_77_3 = var_0_1.get(var_77_2.promote_code, iter_77_0)

		for iter_77_1 = 1, 4 do
			for iter_77_2 = 1, 4 do
				var_77_1(var_77_3["place_" .. iter_77_1 .. "_affect_type_" .. iter_77_2], var_77_3["place_" .. iter_77_1 .. "_affect_value_" .. iter_77_2])
			end

			var_77_1(var_77_3["affect_type_" .. iter_77_1], var_77_3["affect_value_" .. iter_77_1])
		end
	end

	return var_77_0
end

function KnightStruct:getCurAdvanceAttr()
	local var_79_0 = {
		0,
		0,
		0,
		0
	}
	local var_79_1 = self:getBaseInfo()
	local var_79_2 = false

	for iter_79_0 = 1, self._info.advance_level - 1 do
		local var_79_3 = var_0_1.get(var_79_1.promote_code, iter_79_0)

		for iter_79_1 = 1, 4 do
			if var_79_3["affect_type_" .. iter_79_1] ~= 0 and var_79_0[var_79_3["affect_type_" .. iter_79_1]] then
				var_79_0[var_79_3["affect_type_" .. iter_79_1]] = var_79_0[var_79_3["affect_type_" .. iter_79_1]] + var_79_3["affect_value_" .. iter_79_1]
			end
		end
	end

	local var_79_4 = var_0_1.get(var_79_1.promote_code, self._info.advance_level)
	local var_79_5 = {
		0,
		0,
		0,
		0
	}

	for iter_79_2 = 1, 4 do
		if var_79_4["affect_type_" .. iter_79_2] ~= 0 and var_79_0[var_79_4["affect_type_" .. iter_79_2]] then
			var_79_5[var_79_4["affect_type_" .. iter_79_2]] = var_79_0[var_79_4["affect_type_" .. iter_79_2]] + var_79_4["affect_value_" .. iter_79_2]
		end
	end

	local var_79_6 = {}

	for iter_79_3 = 1, 4 do
		if var_79_4["affect_type_" .. iter_79_3] ~= 0 and var_79_0[var_79_4["affect_type_" .. iter_79_3]] then
			table.insert(var_79_6, {
				type = var_79_4["affect_type_" .. iter_79_3],
				value = var_79_0[iter_79_3],
				value2 = var_79_5[iter_79_3]
			})
		else
			var_79_2 = true

			break
		end
	end

	if var_79_2 then
		for iter_79_4, iter_79_5 in pairs(var_79_0) do
			table.insert(var_79_6, {
				type = iter_79_4,
				value = iter_79_5
			})
		end
	end

	return var_79_6, var_79_2
end

function KnightStruct:getAdvaceTalentData()
	local var_80_0 = {}
	local var_80_1 = self:getBaseInfo()
	local var_80_2 = var_80_1.quality

	for iter_80_0 = 1, math.min(self._advStage + var_0_7.get(19003).parameter, var_0_12.TRAIN_MAX) do
		if var_80_1["promote_talent_" .. iter_80_0] > 0 or var_80_1["promote_passive_" .. iter_80_0 .. "_1"] > 0 then
			local var_80_3 = {
				talentId = var_80_1["promote_talent_" .. iter_80_0] > 0 and var_80_1["promote_talent_" .. iter_80_0] or nil,
				skillId = var_80_1["promote_passive_" .. iter_80_0 .. "_1"] > 0 and var_80_1["promote_passive_" .. iter_80_0 .. "_1"] or nil
			}

			if var_80_3.skillId then
				if var_80_2 >= var_0_13.UR then
					var_80_3.passiveSkillType = var_0_12.ADVANCE_PASSIVE_SKILL_TYPE.BLOOD or var_0_12.ADVANCE_PASSIVE_SKILL_TYPE.PASSIVE
				end
			else
				var_80_3.passiveSkillType = var_0_12.ADVANCE_PASSIVE_SKILL_TYPE.NONE
			end

			var_80_3.value = self._advStage or 0
			var_80_3.openValue = iter_80_0

			table.insert(var_80_0, var_80_3)
		end
	end

	return #var_80_0, var_80_0
end

function KnightStruct:getPassiveListNew()
	if self:getQuality() >= var_0_13.UR then
		return self:getAdvancedPassiveList()
	end

	return self:getPassiveList()
end

function KnightStruct:getPassiveList()
	local var_82_0 = {}
	local var_82_1 = 0
	local var_82_2 = false
	local var_82_3 = self:getBaseInfo()

	for iter_82_0 = 1, var_0_12.TRAIN_MAX do
		if var_82_3["promote_passive_" .. iter_82_0 .. "_1"] > 0 then
			local var_82_4 = {
				talentLevel = iter_82_0,
				skillId = var_82_3["promote_passive_" .. iter_82_0 .. "_1"]
			}

			var_82_4.value = self._advStage or 0

			if var_82_1 == 0 or iter_82_0 <= self._advStage then
				var_82_1 = var_82_3["promote_passive_" .. iter_82_0 .. "_1"]
				var_82_2 = iter_82_0 <= self._advStage
			end

			table.insert(var_82_0, var_82_4)
		end
	end

	return {
		id = var_82_1,
		isActive = var_82_2
	}, var_82_0
end

function KnightStruct:getAdvancedPassiveList()
	local var_83_0 = {}
	local var_83_1 = 0
	local var_83_2 = false
	local var_83_3 = self:getStarLv()

	if self:getQuality() < var_0_13.UR then
		return {
			id = var_83_1,
			isActive = var_83_2
		}, var_83_0
	end

	for iter_83_0 = 0, var_0_12.STAR_MAX do
		if self._cfgInfo[iter_83_0] then
			if self._cfgInfo[iter_83_0]["advanced_passive_skill_id_" .. 1] > 0 then
				local var_83_4 = {
					skillLv = self._cfgInfo[iter_83_0].star,
					skillId = self._cfgInfo[iter_83_0]["advanced_passive_skill_id_" .. 1]
				}

				if var_83_1 == 0 or var_83_3 >= self._cfgInfo[iter_83_0].star then
					var_83_1 = self._cfgInfo[iter_83_0]["advanced_passive_skill_id_" .. 1]
					var_83_2 = var_83_3 >= self._cfgInfo[iter_83_0].star
				end

				if #var_83_0 == 0 or var_83_0[#var_83_0].skillId ~= var_83_4.skillId then
					var_83_4.talentLevel = iter_83_0

					table.insert(var_83_0, var_83_4)
				end
			end
		end
	end

	return {
		id = var_83_1,
		isActive = var_83_2
	}, var_83_0
end

function KnightStruct:getAwakeAttrs()
	local var_84_0 = self:getAwakeStage()
	local var_84_1 = self:getAwakeId()
	local var_84_2 = {}
	local var_84_3 = {}

	if var_0_2.hasData(var_84_1, var_84_0) then
		var_84_2, var_84_3 = self:getAttrsByAwakeCfg((var_0_2.get(var_84_1, var_84_0)))
	end

	return var_84_2, var_84_3
end

function KnightStruct:getAwakeAttrsByStage(arg_85_1)
	local var_85_0 = self:getAwakeId()
	local var_85_2 = {}
	local var_85_3 = {}

	if var_0_2.hasData(var_85_0, arg_85_1) then
		var_85_2, var_85_3 = self:getAttrsByAwakeCfg((var_0_2.get(var_85_0, arg_85_1)))
	end

	return var_85_2, var_85_3
end

function KnightStruct:getAttrsByAwakeCfg(arg_86_1)
	local var_86_0 = {}

	for iter_86_0 = 1, 6 do
		if arg_86_1["attribute_type" .. iter_86_0] > 0 then
			var_86_0[arg_86_1["attribute_type" .. iter_86_0]] = var_86_0[arg_86_1["attribute_type" .. iter_86_0]] or 0
			var_86_0[arg_86_1["attribute_type" .. iter_86_0]] = var_86_0[arg_86_1["attribute_type" .. iter_86_0]] + arg_86_1["attribute_value" .. iter_86_0]
		end
	end

	local var_86_1 = {}

	for iter_86_1, iter_86_2 in pairs(var_86_0) do
		table.insert(var_86_1, {
			id = iter_86_1,
			value = iter_86_2
		})
	end

	table.sort(var_86_1, function(arg_87_0, arg_87_1)
		return var_0_4.get(arg_87_0.id).num < var_0_4.get(arg_87_1.id).num
	end)

	return var_86_0, var_86_1
end

function KnightStruct:getNextQualityInfo()
	local var_88_0 = self:getBaseInfo()

	for iter_88_0 = 1, var_0_0.getLength() do
		local var_88_1 = var_0_0.indexOf(iter_88_0)

		if var_88_1.star == var_88_0.star and var_88_1.advance_id == var_88_0.advance_id and var_88_1.quality == var_88_0.quality + 1 then
			return var_88_1
		end
	end

	return {}
end

function KnightStruct:getNextQuality()
	local var_89_0 = self:getBaseInfo().quality

	for iter_89_0 = 1, g.core.config.role_quality_info.getLength() do
		local var_89_1 = g.core.config.role_quality_info.indexOf(iter_89_0)

		if var_89_1.quality == var_89_0 then
			if var_89_1.is_up == 0 then
				return 0
			else
				return g.core.config.role_quality_info.get(iter_89_0 + 1).quality
			end
		end
	end

	return 0
end

function KnightStruct:getSkillLevel()
	return self:getBaseInfo().star + 1
end

function KnightStruct:getLevel()
	return (self._info or nil) and (self._info.level or 1)
end

function KnightStruct:getStarLv()
	return self:getBaseInfo().star
end

function KnightStruct:getStar()
	return self:getStarLv()
end

function KnightStruct:getMaxStarLevel()
	return 7
end

function KnightStruct:getAdvTalentList(arg_95_1)
	arg_95_1 = arg_95_1 or self:getBaseInfo()

	local var_95_0 = arg_95_1.promote_code
	local var_95_1 = {}

	for iter_95_0 = 1, var_0_1.getLength() do
		local var_95_2 = var_0_1.indexOf(iter_95_0)

		if var_95_2.promote_code == var_95_0 and not var_95_1[var_95_2.stage] and var_95_2.stage > 0 and arg_95_1["promote_talent_" .. var_95_2.stage] > 0 then
			var_95_1[var_95_2.stage] = {
				stage = var_95_2.stage,
				talentId = arg_95_1["promote_talent_" .. var_95_2.stage]
			}
		end
	end

	return var_95_1
end

function KnightStruct:isMaxStar()
	if not self:isOwn() then
		return false
	end

	if self:getBaseInfo().next_star_id == 0 then
		return true
	end

	return false
end

function KnightStruct:getAwakeStage()
	return (self._info or nil) and (self._info.awake_stage or 0)
end

function KnightStruct:getAwakeId()
	local var_98_0 = self:getBaseInfo()

	if not var_0_0.hasKey("awake_id") then
		return 1
	end

	if not var_98_0 then
		return 1
	end

	return var_98_0.awake_id
end

function KnightStruct:hasAwakeAbility()
	return self:getAwakeId() ~= 0
end

function KnightStruct:isCanAwake()
	if not self:isOwn() then
		return false
	end

	if not self._defaultCfg then
		return false
	end

	if not var_0_0.hasKey("awake_id") then
		return false
	end

	if self._defaultCfg.awake_id == 0 then
		return false
	end

	local var_100_0 = self:getAwakeStage()
	local var_100_1 = self:getAwakeId()

	if var_0_2.hasData(var_100_1, var_100_0 + 1) then
		return self:getLevel() >= var_0_2.get(var_100_1, var_100_0 + 1).open_level
	end

	return false
end

function KnightStruct:getMaxLevel()
	return (g.core.model.User.knightsData:getKnightMaxLvByLevelExpId(self:getBaseInfo().level_exp_id))
end

function KnightStruct:isMaxLevel()
	if not self:isOwn() then
		return false
	end

	return self:getLevel() >= self:getMaxLevel()
end

function KnightStruct:getAwakeTask()
	return (self._info or nil) and (self._info.awake_task or 0)
end

function KnightStruct:getAwakeTaskValue()
	return (self._info or nil) and (self._info.awake_task_value or 0)
end

function KnightStruct:getPendantLevel()
	return (self._info or nil) and (self._info.pendant_level or 0)
end

function KnightStruct:getPendantStageLv()
	return math.floor(self:getPendantLevel() / var_0_12.PENDANT_MAX_LV_ONESTAGE)
end

function KnightStruct:isStartedAwake()
	return self:getAwakeStage() ~= 0
end

function KnightStruct:isAwaking()
	return ((self._info or nil) and (self._info.awake_task or 0)) > 0 and self:hasAwakeAbility()
end

function KnightStruct:isPendantActive()
	return self:getAwakeStage() > 0
end

function KnightStruct:getKnightAwakeState()
	local var_110_0 = self:getLevel()
	local var_110_1 = self:getAwakeId()
	local var_110_2 = self:getAwakeStage()
	local var_110_3 = self:getAwakeTaskValue()
	local var_110_4 = self:getAwakeTask()

	if not var_0_2.hasData(var_110_1, var_110_2 + 1) then
		return 3
	end

	if not self:isAwaking() then
		return 0
	end

	local var_110_5 = var_0_2.get(var_110_1, var_110_2 + 1)

	if var_110_4 == 0 then
		return 0
	end

	if not var_0_3.hasData(var_110_5.awake_task, var_110_4) then
		if var_110_3 >= var_0_3.indexOf(1).task_value then
			return 2
		else
			return 1
		end
	end

	if var_110_3 >= var_0_3.get(var_110_5.awake_task, var_110_4).task_value then
		if not var_0_3.hasData(var_110_5.awake_task, var_110_4 + 1) then
			return 2
		end

		return 1
	else
		return 1
	end

	return 0
end

function KnightStruct:getCurAwakeTask()
	local var_111_0 = {}
	local var_111_1 = self:getAwakeTask()
	local var_111_2 = self:getAwakeId()

	if not self:isStartedAwake() then
		local var_111_3 = var_0_2.get(var_111_2, 1)

		if self:getLevel() < var_111_3.open_level then
			return var_111_0
		end

		if not var_0_3.hasData(var_111_3.awake_task, var_111_1) then
			var_111_0 = var_0_3.indexOf(1)

			return var_111_0
		end

		return var_0_3.get(var_111_3.awake_task, var_111_1)
	end

	local var_111_4 = self:getAwakeStage()

	if not var_0_2.hasData(var_111_2, var_111_4 + 1) then
		return var_111_0
	end

	local var_111_5 = var_0_2.get(var_111_2, var_111_4 + 1)

	if not var_0_3.hasData(var_111_5.awake_task, var_111_1) then
		return (var_0_3.indexOf(1))
	end

	return var_0_3.get(var_111_5.awake_task, var_111_1)
end

function KnightStruct:getCurAwakeCfg()
	if not self:hasAwakeAbility() then
		return
	end

	local var_112_0 = self:getAwakeId()
	local var_112_1 = self:getAwakeStage()

	if var_112_1 == 0 then
		return var_0_2.get(var_112_0, 1)
	end

	if not var_0_2.hasData(var_112_0, var_112_1) then
		return var_0_2.get(var_112_0, 1)
	end

	return var_0_2.get(var_112_0, var_112_1)
end

function KnightStruct:getAllAwakeCfgs()
	local var_113_0 = self:getAwakeId()
	local var_113_1 = {}

	for iter_113_0 = 0, 6 do
		if var_0_2.hasData(var_113_0, iter_113_0) then
			local var_113_2 = var_0_2.get(var_113_0, iter_113_0)

			if var_113_2.talent_skill > 0 then
				table.insert(var_113_1, var_113_2)
			end
		end
	end

	return var_113_1
end

function KnightStruct:getCurrPendantTalentId()
	local var_114_0 = var_0_5.get(self:getCurAwakeCfg().awake_pendant).pendant_level_id
	local var_114_1 = self:getPendantLevel()
	local var_114_2 = 0
	local var_114_3

	for iter_114_0 = 0, 7 do
		local var_114_4 = var_0_6.get(var_114_0, var_114_1 + iter_114_0)

		if var_114_4.talent > 0 then
			var_114_2 = var_114_4.talent
			var_114_3 = var_114_4

			break
		end
	end

	return var_114_2, var_114_3
end

function KnightStruct:isCanExtendLevel()
	if not self:hasAwakeAbility() then
		return false
	end

	local var_115_0 = self:getAwakeId()
	local var_115_1 = self:getAwakeStage()
	local var_115_2 = self:getLevel()
	local var_115_3 = g.core.model.User:getMaxLevel()

	if var_115_1 == 0 then
		local var_115_4 = var_0_2.get(var_115_0, 1)

		return var_115_2 >= var_115_4.open_level, var_115_4.max_level, var_115_4
	end

	if self:getKnightAwakeState() == 3 then
		return false
	end

	if var_115_2 < var_0_2.get(var_115_0, var_115_1).max_level then
		return false
	end

	if not var_0_2.hasData(var_115_0, var_115_1 + 1) then
		return false
	end

	local var_115_5 = var_0_2.get(var_115_0, var_115_1 + 1)

	return var_115_2 >= var_115_5.open_level, var_115_5.max_level, var_115_5
end

function KnightStruct:getLevelCanReach()
	local var_116_0 = self:getAwakeStage()

	if not self:hasAwakeAbility() or var_116_0 == 0 then
		if not self:hasAwakeAbility() then
			return g.core.model.User.knightsData:getKnightMaxLvByLevelExpId(self:getBaseInfo().level_exp_id)
		end

		return g.core.model.User:getMaxLevel()
	end

	local var_116_1 = var_0_2.get(self:getAwakeId(), var_116_0)

	return self:isMain() and var_116_1.max_level or math.min(var_116_1.max_level, g.core.model.User:getLevel())
end

function KnightStruct:getCurMaxLevel()
	local var_117_0 = self:getAwakeStage()
	local var_117_1 = self:isMain()
	local var_117_2 = g.core.model.User:getLevel()
	local var_117_3 = g.core.model.User.knightsData:getKnightMaxLvByLevelExpId(self:getBaseInfo().level_exp_id)

	return var_117_3 <= var_117_2 and var_117_3 or var_117_2
end

function KnightStruct:getPendantTalentSkillCfgs()
	if not self:hasAwakeAbility() then
		return {}
	end

	local var_118_0 = self:getAwakeId()
	local var_118_1 = {}

	for iter_118_0 = 1, var_0_12.KNIGHT_AWAKE_MAX do
		if var_0_2.hasData(var_118_0, iter_118_0) then
			local var_118_2 = var_0_5.get(var_0_2.get(var_118_0, iter_118_0).awake_pendant).pendant_level_id

			for iter_118_1 = 0, var_0_12.PENDANT_MAX_LV do
				if var_0_6.hasData(var_118_2, iter_118_1) then
					local var_118_3 = var_0_6.get(var_118_2, iter_118_1)

					if var_118_3.talent > 0 then
						table.insert(var_118_1, var_118_3)
					end
				else
					break
				end
			end
		end
	end

	return var_118_1
end

function KnightStruct:canPendantUpgrade()
	if not self:isPendantActive() then
		return false
	end

	local var_119_0 = var_0_5.get(self:getCurAwakeCfg().awake_pendant)
	local var_119_1 = self:getPendantLevel()
	local var_119_2 = self:getPendantTalentSkillCfgs()

	if var_119_1 >= var_119_2[#var_119_2].level then
		return false
	end

	local var_119_3 = var_0_6.get(var_119_0.pendant_level_id, var_119_1 + 1)

	return g.core.model.User.bagData:getOwnNum(var_119_3.cost_type, var_119_3.cost_value) >= var_119_3.cost_num
end

function KnightStruct:getFavoLevel()
	return (self._info or nil) and (self._info.favorability_level or 1)
end

function KnightStruct:getFavoExp()
	return self._info.favorability_exp
end

function KnightStruct:getFavoStage()
	return (self._info or nil) and (self._info.favorability_stage or 0)
end

function KnightStruct:getMobilityVal()
	return self._info.mobility_val or 0
end

function KnightStruct:getMaxMobility()
	return self:getBaseInfo().mobility
end

function KnightStruct:isExistMobilityProperty()
	return self:getMaxMobility() > 0
end

function KnightStruct:isCanCheckIn()
	return self:isOwn() and self:isExistMobilityProperty()
end

function KnightStruct:isCanBeDispatched()
	return self:isOwn() and self:isExistMobilityProperty()
end

function KnightStruct:getHomeLandTalent()
	return self:getBaseInfo().homeland_talent
end

function KnightStruct:getAdvanceId()
	return self._advanceId
end

function KnightStruct:getAdvanceLevel()
	return self._advStage
end

function KnightStruct:getIsNewKnight()
	if self._isNew == nil then
		self._isNew = not (g.core.common.Storage:load("knight_is_card_click.json", g.core.model.User:getId()) or {})[tostring(self._advanceId)]
	end

	return self._isNew and self:isOwn()
end

function KnightStruct:getIsNewKnightSpecial()
	if self._isNew == nil then
		self._isNew = not (g.core.common.Storage:load("knight_is_card_click.json", g.core.model.User:getId()) or {})[tostring(self._advanceId)]
	end

	return self._isNew
end

function KnightStruct:setIsNewKnight()
	if self._isNew then
		local var_133_0 = g.core.common.Storage:load("knight_is_card_click.json", g.core.model.User:getId()) or {}

		var_133_0[tostring(self._advanceId)] = true

		g.core.common.Storage:save("knight_is_card_click.json", var_133_0, g.core.model.User:getId())
	end

	self._isNew = false
end

function KnightStruct:canLevelUpFive()
	if not self:isLineup() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_11.FUNCTION_TYPE.KNIGHT_ONEKEY_LEVELUP) then
		return false
	end

	local var_134_0

	if self:getCurMaxLevel() - self:getLevel() < 5 then
		do return false end

		var_134_0 = 0
	end

	for iter_134_0, iter_134_1 in pairs((g.core.model.User.itemsData:getExpItemData())) do
		local var_134_1 = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_ITEM,
			value = iter_134_1.id,
			size = iter_134_1.num
		})

		if var_134_1.info.item_type then
			var_134_0 = var_134_0 + var_134_1.info.item_value * var_134_1.size
		end
	end

	if var_134_0 == 0 then
		return false
	end

	local var_134_2 = g.core.config.knight_level_info
	local var_134_3 = self:getBaseInfo().level_exp_id
	local var_134_4 = var_134_0 + self._info.exp

	for iter_134_2 = 0, 4 do
		var_134_4 = var_134_4 - var_134_2.get(var_134_3, self._info.level + iter_134_2).next_exp

		if var_134_4 < 0 then
			return false
		end
	end

	return true
end

function KnightStruct:canAdvance()
	if not self:isLineup() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(var_0_11.FUNCTION_TYPE.KNIGHT_ADVANCE) then
		return false
	end

	local var_135_0 = var_0_1.get(self:getBaseInfo().promote_code, (math.max(self:getInfo().advance_level)))

	if self:getLevel() < var_135_0.require_level then
		return false
	end

	if g.core.model.User.bagData:getCountById(var_135_0.cost_type, var_135_0.cost_value) < var_135_0.cost_size or var_135_0.cost_money > g.core.model.User.resourceData:getCoin() then
		return false
	end

	local var_135_1 = g.core.common.Goods

	for iter_135_0 = 1, 4 do
		if var_135_0["place_" .. iter_135_0] == 0 then
			return false
		end

		local var_135_2 = var_135_1:convert({
			type = var_135_1.TYPE_KNIGHT_ADVANCE,
			value = var_135_0["place_" .. iter_135_0]
		})

		var_135_2.numCost = var_135_0["num_" .. iter_135_0]

		if var_135_2.size < var_135_2.numCost then
			return false
		end
	end

	return true
end

function KnightStruct:getVideoShowType()
	local var_136_0 = self:getResInfo()

	if var_136_0.knight_show == 0 then
		return var_0_12.VIDEO_SHOW_TYPE.NONE
	end

	return var_136_0.show_scene
end

function KnightStruct:getId()
	return self:getBaseId()
end

function KnightStruct:getCfg()
	return self:getBaseInfo()
end

function KnightStruct:getArtifactId()
	local var_139_0 = g.core.config.artifact_info.match(function(arg_140_0)
		if arg_140_0.knight_advance_code == self:getCfg().advance_id then
			return true
		end
	end)

	return (var_139_0[1] or nil) and (var_139_0[1].advance_code or 0)
end

function KnightStruct:isMRQuality()
	return self:getBaseInfo().quality == var_0_13.MR
end

function KnightStruct:getSpSoulLevel()
	return self._spSoulLevel
end

function KnightStruct:getSpSupportLevel()
	return self._spSupportLevel
end

function KnightStruct:getSpSoulCfg(arg_144_1)
	arg_144_1 = arg_144_1 or self._spSoulLevel

	return var_0_8.get(self:getAdvanceId(), arg_144_1)
end

function KnightStruct:isMaxSoulLevel()
	if self:getBaseInfo().quality < var_0_13.MR then
		return true
	end

	return self:getSpSoulCfg().next_level == 0
end

function KnightStruct:getSoulUpCost()
	local var_146_0 = self:getSpSoulCfg()

	return {
		type = var_146_0.up_stage_type,
		value = var_146_0.up_stage_value,
		size = var_146_0.up_stage_size
	}
end

function KnightStruct:canSoulUpLevel()
	if self:isMaxSoulLevel() then
		return false
	end

	local var_147_1 = self:getSoulUpCost()

	if not self:isOwn() then
		return false
	end

	local var_147_2 = 0

	var_147_2 = var_147_1.type == g.core.common.Goods.TYPE_FRAGMENT and g.core.model.User.fragmentsData:getFragmentNumById(var_147_1.value) or g.core.model.User.bagData:getOwnNum(var_147_1.type, var_147_1.value)

	return var_147_2 >= var_147_1.size, var_147_1, var_147_2
end

function KnightStruct:getSpSoulAttr(arg_148_1)
	arg_148_1 = arg_148_1 or self._spSoulLevel

	local var_148_0 = self:getSpSoulCfg(arg_148_1)
	local var_148_1 = var_148_0.next_level > 0 and self:getSpSoulCfg(var_148_0.next_level) or nil
	local var_148_2 = {}
	local var_148_3 = 1

	while var_0_8.hasKey("affect_type_" .. var_148_3) do
		local var_148_4 = {}

		if var_148_1 then
			var_148_4.type = var_148_1["affect_type_" .. var_148_3] or var_148_0["affect_type_" .. var_148_3]
		end

		var_148_4.value = var_148_0["affect_value_" .. var_148_3]
		var_148_4.value2 = var_148_1 and var_148_1["affect_value_" .. var_148_3]

		table.insert(var_148_2, var_148_4)

		var_148_3 = var_148_3 + 1
	end

	return var_148_2
end

function KnightStruct:getSpSupportKnights()
	local var_149_0 = {}

	for iter_149_0, iter_149_1 in pairs((KnightStruct.getSpiritSupportKnights(self:getAdvanceId()))) do
		table.insert(var_149_0, iter_149_1)
	end

	table.sort(var_149_0, function(arg_150_0, arg_150_1)
		if arg_150_0.knightAdvId ~= arg_150_1.knightAdvId then
			return arg_150_0.knightAdvId < arg_150_1.knightAdvId
		end

		return false
	end)

	return var_149_0
end

function KnightStruct:getSpSupportSkills()
	return KnightStruct.getSpiritSupportSkills(self:getAdvanceId())
end

function KnightStruct:isSpSupportMaxLevel()
	return not self:getSpSupportSkills()[self._spSupportLevel + 1]
end

function KnightStruct:isCanUpgradeSpSupport()
	local var_153_0 = self:getSpSupportSkills()[self._spSupportLevel + 1] or nil
	local var_153_1 = var_0_12.MR_PROTECT_UNLOCK_COND
	local var_153_2 = {
		[var_0_12.MR_PROTECT_UNLOCK_COND.SOUL_LEVEL] = {
			desc = 201113,
			value = self:getSpSoulLevel()
		},
		[var_0_12.MR_PROTECT_UNLOCK_COND.ASSISTANT_KNIGHT_STAR] = {
			desc = 201114,
			value = -1
		}
	}
	local var_153_3 = -1

	for iter_153_0, iter_153_1 in pairs(self.getSpiritSupportKnights(self:getAdvanceId()) or {}) do
		local var_153_4 = g.core.model.User.knightsData:getKnight({
			advance_id = iter_153_1[1].knightAdvId
		})

		if var_153_4 and var_153_4:isOwn() and var_153_3 < var_153_4:getStar() then
			var_153_3 = var_153_4:getStar()
		end
	end

	var_153_2[var_153_1.ASSISTANT_KNIGHT_STAR].value = var_153_3

	if var_153_0 then
		local var_153_5 = true
		local var_153_6 = {}

		while var_0_10.hasKey(table.concat({
			"unlock_type_",
			1
		})) do
			var_153_5 = var_153_5 and var_153_2[var_153_0["unlock_type_" .. 1]].value >= var_153_0["unlock_value_" .. 1]
			var_153_6["desc" .. 1] = g.core.lang:get(var_153_2[var_153_0["unlock_type_" .. 1]].desc, {
				value = var_153_0["unlock_value_" .. 1]
			})
		end

		return var_153_5, g.core.lang:get(201115, var_153_6)
	end

	return false, ""
end

function KnightStruct:isSpSupportActive(arg_154_1)
	return self._activeSupportKnightMap[arg_154_1]
end

return KnightStruct
