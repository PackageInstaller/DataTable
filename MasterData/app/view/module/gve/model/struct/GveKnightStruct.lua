local GveKnightStruct = class("GveKnightStruct")
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_2 = g.core.config.knight_info
local var_0_3 = g.core.config.knight_advance_info
local var_0_4 = g.core.config.knight_awake_info
local var_0_5 = g.core.config.awake_task_info
local var_0_6 = g.core.config.attribute_info
local var_0_7 = g.core.config.awake_pendant_info
local var_0_8 = g.core.config.pendant_level_info

function GveKnightStruct:ctor(arg_1_1)
	local var_1_0 = var_0_2.get(arg_1_1)

	self._advanceId = var_1_0.advance_id
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
	self._isNew = nil
	self._hasNewSkin = false

	self:addCfgInfo(var_1_0)
end

function GveKnightStruct:setIsOtherUser(arg_2_1, arg_2_2)
	self._isOtherUser = arg_2_1 == true
	self._otherUserName = arg_2_2
end

function GveKnightStruct:isPut()
	return self._defaultCfg and self._defaultCfg.put == 1
end

function GveKnightStruct:getIsOtherUser()
	return self._isOtherUser
end

function GveKnightStruct:getOtherUserName()
	return self._otherUserName
end

function GveKnightStruct:addCfgInfo(arg_6_1)
	self._cfgInfo[arg_6_1.star] = arg_6_1
	self._cfgIdInfo[arg_6_1.id] = arg_6_1
	self._defaultCfg = self._defaultCfg or arg_6_1

	self:calMaxTrainLevel()
end

function GveKnightStruct:setInfo(arg_7_1)
	self._info = arg_7_1

	self:addCfgInfo(var_0_2.get(arg_7_1.base_id))
	self:calMaxTrainLevel()

	if self._info.star_level > self._maxStarLv then
		self._info.star_level = self._maxStarLv
	end

	self:initAttrs()
	self:updateAdvStage()
end

function GveKnightStruct:getTrainLevel()
	local var_8_0 = self._info.star_level

	if self:getAwakeStage() < g.core.model.User.trainData:getTrainInfoByLevel(self._info.star_level).awake_stage then
		var_8_0 = var_8_0 - 1
	end

	return var_8_0
end

function GveKnightStruct:getServerId()
	return (self._info or nil) and (self._info.id or 0)
end

function GveKnightStruct:updateTrainLevel()
	if self._info.star_level > self._maxStarLv then
		self._info.star_level = self._maxStarLv
	end
end

function GveKnightStruct:updateAdvStage()
	local var_11_0 = self:getBaseInfo()

	if var_11_0 then
		local var_11_1 = g.core.config.knight_advance_info.get(var_11_0.promote_code, self._info.advance_level)

		self._advStage = var_11_1.stage
		self._advNode = var_11_1.node
	end
end

function GveKnightStruct:getAdvStageAndLevel()
	return self._advStage, self._advNode
end

function GveKnightStruct:updatePos(arg_13_1)
	self._info.position = arg_13_1
end

function GveKnightStruct:getFormationPos()
	return self._info.position
end

function GveKnightStruct:isDisplay()
	return self._defaultCfg and self._defaultCfg.is_display == 1
end

function GveKnightStruct:isLineup()
	return self._info and self._info.position > 0 and self._info.position <= var_0_1.LINEUP_MAX
end

function GveKnightStruct:isHelper()
	return self._info and self._info.position > var_0_1.LINEUP_MAX and self._info.position <= var_0_1.KNIGHT_PARTNER_MAX
end

function GveKnightStruct:isBackup()
	return self._info and self._info.position > var_0_1.KNIGHT_PARTNER_MAX
end

function GveKnightStruct:getBaseInfo()
	if self._info then
		return self._cfgIdInfo[self._info.base_id]
	else
		return self._defaultCfg
	end
end

function GveKnightStruct:getGroup()
	return self:getBaseInfo().group
end

function GveKnightStruct:getBaseId()
	return self:getBaseInfo().id
end

function GveKnightStruct:getQuality()
	return self:getBaseInfo().quality
end

function GveKnightStruct:getInfo()
	return self._info
end

function GveKnightStruct:getName()
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

function GveKnightStruct:getResInfo()
	local var_25_0 = self:getBaseInfo().res_id

	if self:isMain() and g.core.model.User:getDressId() ~= 0 then
		local var_25_1 = g.core.model.User:getDressId()

		var_25_0 = self:getBaseInfo().sex == 0 and g.core.config.dress_info.get(var_25_1).woman_res_id or g.core.config.dress_info.get(var_25_1).man_res_id
	end

	if self:isWearSkin() then
		local var_25_2 = g.core.config.skin_info.fetch(self._info.skin)

		if var_25_2 then
			var_25_0 = var_25_2.res
		end
	end

	return g.core.config.knight_base_info.get(var_25_0)
end

function GveKnightStruct:getVoiceResInfo(arg_26_1, arg_26_2)
	local var_26_0 = self:getBaseInfo().res_id

	if self:isMain() and g.core.model.User:getDressId() ~= 0 and not arg_26_1 then
		local var_26_1 = g.core.model.User:getDressId()

		var_26_0 = self:getBaseInfo().sex == 0 and g.core.config.dress_info.get(var_26_1).woman_res_id or g.core.config.dress_info.get(var_26_1).man_res_id
	end

	if self:isWearSkin() and not arg_26_1 then
		local var_26_2 = g.core.config.skin_info.fetch(self._info.skin)

		if var_26_2 then
			var_26_0 = var_26_2.res
		end
	end

	local var_26_3 = g.core.config.knight_show_info.fetch(var_26_0)

	if not arg_26_2 and var_26_3 and var_26_3.toObject then
		var_26_3 = var_26_3.toObject()

		local var_26_4 = g.core.model.User:isBoy()

		for iter_26_0, iter_26_1 in pairs(var_26_3) do
			if var_26_3[iter_26_0 .. "_woman"] and var_26_3[iter_26_0 .. "_woman"] ~= "" and var_26_3[iter_26_0 .. "_woman"] ~= iter_26_1 and not var_26_4 then
				var_26_3[iter_26_0] = var_26_3[iter_26_0 .. "_woman"]
			end
		end
	end

	return var_26_3
end

function GveKnightStruct:getPreResInfo()
	local var_27_0 = self:getBaseInfo()

	for iter_27_0, iter_27_1 in g.core.config.knight_info.ipairs() do
		if iter_27_1.next_star_id == var_27_0.id then
			return g.core.config.knight_base_info.get(iter_27_1.res_id)
		end
	end
end

function GveKnightStruct:isWearSkin()
	if self._info and self._info.skin and self._info.skin > 0 and self._info.skin_ts and (self._info.skin_ts == 0 or self._info.skin_ts > g.core.common.ServerTime:getTime()) then
		return true
	end

	return false
end

function GveKnightStruct:getSkin()
	if self._info and self._info.skin and self._info.skin > 0 and self._info.skin_ts and (self._info.skin_ts == 0 or self._info.skin_ts > g.core.common.ServerTime:getTime()) then
		return self._info.skin, self._info.skin_ts
	end

	return 0
end

function GveKnightStruct:isChangeImage()
	local var_30_0 = self:getBaseInfo()
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in g.core.config.knight_info.ipairs() do
		if iter_30_1.advance_id == var_30_0.advance_id then
			var_30_1[iter_30_1.star + 1] = iter_30_1

			if #var_30_1 == var_0_1.STAR_MAX + 1 then
				break
			end
		end
	end

	local var_30_2 = var_30_1[1].res_id

	for iter_30_2 = 1, #var_30_1 do
		if var_30_2 ~= var_30_1[iter_30_2].res_id then
			return true, var_30_1[iter_30_2], var_30_1[1]
		end
	end

	return false
end

function GveKnightStruct:getWingId()
	if self:isMain() then
		return g.core.model.User.wingData:getShowWingId()
	end

	return 0
end

function GveKnightStruct:initAttrs()
	if self:isLineup() then
		self._attr.hp = self._info.init_hp
		self._attr.attack = self._info.attack
		self._attr.phyDef = self._info.phy_defence
		self._attr.magDef = self._info.mag_defence
		self._attr.otherAttr = {}

		local var_32_0 = self._info.other_attrs or {}

		for iter_32_0 = 1, #var_32_0 do
			self._attr.otherAttr[var_32_0[iter_32_0].id] = var_32_0[iter_32_0].num
		end
	else
		local var_32_1 = self:getCurAttr()

		self._attr.hp = var_32_1[1]
		self._attr.attack = var_32_1[2]
		self._attr.phyDef = var_32_1[3]
		self._attr.magDef = var_32_1[4]
	end
end

function GveKnightStruct:updateAttrs()
	if self:isLineup() then
		self._diffAttr.hp = math.uint64_sub(self._info.init_hp, self._attr.hp)
		self._diffAttr.attack = self._info.attack - self._attr.attack
		self._diffAttr.phyDef = self._info.phy_defence - self._attr.phyDef
		self._diffAttr.magDef = self._info.mag_defence - self._attr.magDef

		self:_updateOtherDiffAttr()
	else
		local var_33_0 = self:getCurAttr()

		self._diffAttr.hp = math.uint64_sub(var_33_0[1], self._attr.hp)
		self._diffAttr.attack = var_33_0[2] - self._attr.attack
		self._diffAttr.phyDef = var_33_0[3] - self._attr.phyDef
		self._diffAttr.magDef = var_33_0[4] - self._attr.magDef
	end

	self:initAttrs()
end

function GveKnightStruct:_updateOtherDiffAttr()
	local var_34_0 = {}
	local var_34_1 = {}
	local var_34_2 = self._info.other_attrs or {}

	for iter_34_0 = 1, #var_34_2 do
		var_34_0[var_34_2[iter_34_0].id] = var_34_2[iter_34_0].num
	end

	local var_34_3 = self._attr.otherAttr or {}

	for iter_34_1, iter_34_2 in pairs(var_34_0) do
		var_34_1[iter_34_1] = var_34_3[iter_34_1] and iter_34_2 - var_34_3[iter_34_1] or iter_34_2
	end

	for iter_34_3, iter_34_4 in pairs(var_34_3) do
		if not var_34_0[iter_34_3] then
			var_34_1[iter_34_3] = iter_34_4 * -1
		end
	end

	self._diffAttr.otherAttr = var_34_1
end

function GveKnightStruct:getCurAttr()
	local var_35_0 = {}
	local var_35_1 = self:getLevelAttrs()
	local var_35_2 = self:getCurTrainAttrInfos()
	local var_35_3 = self:getAdvaceAttrs()
	local var_35_4 = self:getAwakeAttrs()

	for iter_35_0 = 1, 4 do
		var_35_0[iter_35_0] = var_35_1[iter_35_0] + var_35_2[iter_35_0] + var_35_3[iter_35_0] + (var_35_4[iter_35_0] or 0)
	end

	return var_35_0
end

function GveKnightStruct:getAttrs()
	return self._attr
end

function GveKnightStruct:getBaseAttrs()
	local var_37_0 = {}
	local var_37_1 = {
		type = 1
	}

	var_37_1.value = self._attr.hp or self._defaultCfg.base_hp

	table.insert(var_37_0, var_37_1)

	local var_37_2 = {
		type = 2
	}

	var_37_2.value = self._attr.attack or self._defaultCfg.base_attack

	table.insert(var_37_0, var_37_2)

	local var_37_3 = {
		type = 3
	}

	var_37_3.value = self._attr.phyDef or self._defaultCfg.base_physical_defence

	table.insert(var_37_0, var_37_3)

	local var_37_4 = {
		type = 4
	}

	var_37_4.value = self._attr.magDef or self._defaultCfg.base_magical_defence

	table.insert(var_37_0, var_37_4)

	return var_37_0
end

function GveKnightStruct:getDiffAttrs()
	return self._diffAttr
end

function GveKnightStruct:isMain()
	return self:getBaseInfo().type == 1
end

function GveKnightStruct:isOwn()
	return self._info ~= nil
end

function GveKnightStruct:isElementLeader()
	local var_41_0 = self:getBaseInfo()

	return var_41_0 ~= nil and var_41_0.is_element_leader > 0
end

function GveKnightStruct:calcSortList(arg_42_1)
	local var_42_0 = {}
	local var_42_1 = self:getBaseInfo()
	local var_42_2, var_42_3, var_42_4 = self:canCompose()

	var_42_0[#var_42_0 + 1] = var_42_2 and 1 or 0

	if self._info then
		if self:isLineup() then
			var_42_0[#var_42_0 + 1] = var_0_1.KNIGHT_BACKUP_MAX + 1 - self._info.position or 0
		end
	end

	var_42_0[#var_42_0 + 1] = self:canStarUp() and 1 or 0
	var_42_0[#var_42_0 + 1] = var_42_1.quality
	var_42_0[#var_42_0 + 1] = var_42_1.star

	if self._info then
		var_42_0[#var_42_0 + 1] = self._info.level or 0
	end

	if self._info then
		var_42_0[#var_42_0 + 1] = self._info.advance_level or 0
	end

	var_42_0[#var_42_0 + 1] = var_42_1.id
	self._sortList = var_42_0
end

function GveKnightStruct:calcLineupSortList(arg_43_1, arg_43_2)
	local var_43_0 = {}
	local var_43_1 = self:getBaseInfo()

	var_43_0[#var_43_0 + 1] = var_43_1.advance_id == arg_43_1 and 1 or 0

	if self._info then
		if self:isLineup() then
			var_43_0[#var_43_0 + 1] = var_0_1.KNIGHT_BACKUP_MAX + 1 - self._info.position or 0
		end

		if self:isBackup() then
			var_43_0[#var_43_0 + 1] = var_0_1.KNIGHT_BACKUP_MAX + 1 - self._info.position or 0
		end

		if self:isHelper() then
			var_43_0[#var_43_0 + 1] = var_0_1.KNIGHT_BACKUP_MAX + 1 - self._info.position or 0
		end
	end

	var_43_0[#var_43_0 + 1] = var_43_1.quality
	var_43_0[#var_43_0 + 1] = g.core.model.User.formationData:getAvailAssctCountByAdvId(var_43_1.advance_id, arg_43_2)
	var_43_0[#var_43_0 + 1] = var_43_1.star
	var_43_0[#var_43_0 + 1] = var_43_1.id
	self._sortList = var_43_0
end

function GveKnightStruct:getSortList()
	return self._sortList
end

function GveKnightStruct:hasNotEnoughFrag()
	if self:isOwn() or self:canCompose() then
		return false
	end

	local var_45_0 = self:getBaseInfo()

	if var_45_0.type == 1 then
		return false, 0, 0
	end

	return g.core.model.User.fragmentsData:getFragmentNumById(var_45_0.fragment_id) > 0
end

function GveKnightStruct:hasNoneFrag()
	return g.core.model.User.fragmentsData:getFragmentNumById(self:getBaseInfo().fragment_id) == 0
end

function GveKnightStruct:canCompose()
	if self:isOwn() then
		return false
	end

	local var_47_0 = self:getBaseInfo()

	if var_47_0.type == 1 then
		return false, 0, 0
	end

	local var_47_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_47_0.fragment_id)

	if var_47_0.fragment_id == 0 then
		return false, 0, 0
	end

	local var_47_2 = g.core.config.fragment_info.get(var_47_0.fragment_id)

	return var_47_1 >= var_47_2.combine_num, var_47_1, var_47_2.combine_num
end

function GveKnightStruct:canStarUp()
	local var_48_0 = self:getBaseInfo()
	local var_48_1 = true

	if var_48_0.type == 1 then
		return false, 0, 0
	end

	if var_48_0.next_star_id == 0 then
		return false, 0, 0
	end

	local var_48_2 = g.core.model.User.fragmentsData:getFragmentNumById(var_48_0.fragment_id)

	if not self:isOwn() then
		var_48_1 = false
	elseif var_48_2 < var_48_0.next_star_num then
		var_48_1 = false
	end

	return var_48_1, var_48_2, var_48_0.next_star_num
end

function GveKnightStruct:canDevelop()
	return false
end

function GveKnightStruct:getNextStarAttr(arg_50_1, arg_50_2)
	local var_50_0 = 1

	if self._info then
		arg_50_1 = arg_50_1 or self:getBaseInfo().star or 0
		var_50_0 = self._info.level
	else
		arg_50_1 = arg_50_1 or 0
	end

	local var_50_1 = arg_50_1 == 7

	arg_50_1 = math.min(arg_50_1 + 1, 7)

	local var_50_2 = self:getBaseInfo()

	if arg_50_2 then
		var_50_2 = self._cfgIdInfo[arg_50_2]
	end

	local var_50_3 = {}

	if var_50_2.id - var_50_2.star + arg_50_1 > 0 then
		local var_50_4 = var_50_0 - 1

		if var_50_0 - 1 < 0 then
			var_50_4 = 0
		end

		var_50_3.hp = self._cfgIdInfo[var_50_2.id - var_50_2.star + arg_50_1].base_hp + self._cfgIdInfo[var_50_2.id - var_50_2.star + arg_50_1].develop_hp * var_50_4
		var_50_3.attack = self._cfgIdInfo[var_50_2.id - var_50_2.star + arg_50_1].base_attack + self._cfgIdInfo[var_50_2.id - var_50_2.star + arg_50_1].develop_attack * var_50_4
		var_50_3.phyDef = self._cfgIdInfo[var_50_2.id - var_50_2.star + arg_50_1].base_physical_defence + self._cfgIdInfo[var_50_2.id - var_50_2.star + arg_50_1].develop_physical_defence * var_50_4
		var_50_3.magDef = self._cfgIdInfo[var_50_2.id - var_50_2.star + arg_50_1].base_magical_defence + self._cfgIdInfo[var_50_2.id - var_50_2.star + arg_50_1].develop_magical_defence * var_50_4
	end

	local var_50_5 = {
		hp = var_50_2.base_hp + var_50_2.develop_hp * (var_50_0 - 1),
		attack = var_50_2.base_attack + var_50_2.develop_attack * (var_50_0 - 1),
		phyDef = var_50_2.base_physical_defence + var_50_2.develop_physical_defence * (var_50_0 - 1),
		magDef = var_50_2.base_magical_defence + var_50_2.develop_magical_defence * (var_50_0 - 1)
	}
	local var_50_6 = {}

	table.insert(var_50_6, {
		type = 1,
		value = var_50_5.hp,
		value2 = var_50_3.hp
	})
	table.insert(var_50_6, {
		type = 2,
		value = var_50_5.attack,
		value2 = var_50_3.attack
	})
	table.insert(var_50_6, {
		type = 3,
		value = var_50_5.phyDef,
		value2 = var_50_3.phyDef
	})
	table.insert(var_50_6, {
		type = 4,
		value = var_50_5.magDef,
		value2 = var_50_3.magDef
	})

	return var_50_6, var_50_1
end

function GveKnightStruct:getCurStarAttr(arg_51_1, arg_51_2)
	local var_51_0 = 1

	if self._info then
		arg_51_1 = arg_51_1 or self._info.star
		var_51_0 = self._info.level
	else
		arg_51_1 = arg_51_1 or 1
	end

	local var_51_1 = self:getBaseInfo()

	if arg_51_2 then
		var_51_1 = self._cfgIdInfo[arg_51_2]
	end

	local var_51_2 = {}

	if var_51_1.advance_id + arg_51_1 - 1 > 0 then
		local var_51_3 = var_51_0 - 1

		if var_51_0 - 1 < 0 then
			var_51_3 = 0
		end

		var_51_2.hp = self._cfgIdInfo[var_51_1.advance_id + arg_51_1 - 1].base_hp + self._cfgIdInfo[var_51_1.advance_id + arg_51_1 - 1].develop_hp * var_51_3
		var_51_2.attack = self._cfgIdInfo[var_51_1.advance_id + arg_51_1 - 1].base_attack + self._cfgIdInfo[var_51_1.advance_id + arg_51_1 - 1].develop_attack * var_51_3
		var_51_2.phyDef = self._cfgIdInfo[var_51_1.advance_id + arg_51_1 - 1].base_physical_defence + self._cfgIdInfo[var_51_1.advance_id + arg_51_1 - 1].develop_physical_defence * var_51_3
		var_51_2.magDef = self._cfgIdInfo[var_51_1.advance_id + arg_51_1 - 1].base_magical_defence + self._cfgIdInfo[var_51_1.advance_id + arg_51_1 - 1].develop_magical_defence * var_51_3
	end

	local var_51_4 = {
		hp = var_51_1.base_hp + var_51_1.develop_hp * (var_51_0 - 1),
		attack = var_51_1.base_attack + var_51_1.develop_attack * (var_51_0 - 1),
		phyDef = var_51_1.base_physical_defence + var_51_1.develop_physical_defence * (var_51_0 - 1),
		magDef = var_51_1.base_magical_defence + var_51_1.develop_magical_defence * (var_51_0 - 1)
	}
	local var_51_5 = {}

	table.insert(var_51_5, {
		type = 1,
		value = var_51_2.hp,
		value2 = var_51_4.hp
	})
	table.insert(var_51_5, {
		type = 2,
		value = var_51_2.attack,
		value2 = var_51_4.attack
	})
	table.insert(var_51_5, {
		type = 3,
		value = var_51_2.phyDef,
		value2 = var_51_4.phyDef
	})
	table.insert(var_51_5, {
		type = 4,
		value = var_51_2.magDef,
		value2 = var_51_4.magDef
	})

	return var_51_5
end

function GveKnightStruct:getStarTalentData()
	local var_52_0 = self:getBaseInfo()
	local var_52_1 = {}

	for iter_52_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.STAR_TALENT do
		if var_52_0["star_talent_" .. iter_52_0] > 0 then
			table.insert(var_52_1, {
				talentId = var_52_0["star_talent_" .. iter_52_0],
				value = var_52_0.star
			})
		end
	end

	return #var_52_1, var_52_1
end

function GveKnightStruct:getLevelAttrs(arg_53_1, arg_53_2)
	arg_53_1 = self._info and (arg_53_1 or self._info.level) or arg_53_1 or 1

	local var_53_0 = self:getBaseInfo()

	if arg_53_2 then
		var_53_0 = self._cfgIdInfo[arg_53_2]
	end

	return {
		var_53_0.base_hp + (arg_53_1 - 1) * var_53_0.develop_hp,
		var_53_0.base_attack + (arg_53_1 - 1) * var_53_0.develop_attack,
		var_53_0.base_physical_defence + (arg_53_1 - 1) * var_53_0.develop_physical_defence,
		var_53_0.base_magical_defence + (arg_53_1 - 1) * var_53_0.develop_magical_defence
	}
end

function GveKnightStruct:getCurTrainAttrInfos()
	local var_54_0 = {}

	for iter_54_0 = 1, 4 do
		var_54_0[iter_54_0] = self:getCurTrainAttrInfo(iter_54_0).cur
	end

	local var_54_1 = {
		"initial_hp",
		"attack",
		"phy_defence",
		"mag_defence"
	}

	for iter_54_1 = 1, self._info.star_level - 1 do
		local var_54_2 = self:getTrainInfo(iter_54_1)

		for iter_54_2 = 1, 4 do
			var_54_0[iter_54_2] = var_54_0[iter_54_2] + var_54_2[var_54_1[iter_54_2]]
		end
	end

	return var_54_0
end

function GveKnightStruct:getCurTrainAttrInfo(arg_55_1)
	if not self._info then
		return {}
	end

	local var_55_0 = self:getTrainInfo()
	local var_55_1 = {
		cur = self._info.star_train[arg_55_1],
		next = self._info.star_train[arg_55_1 + 4],
		total = var_55_0[({
			"initial_hp",
			"attack",
			"phy_defence",
			"mag_defence"
		})[arg_55_1]]
	}

	if var_55_0.level < self._info.star_level then
		var_55_1.next = 0
		var_55_1.cur = var_55_1.total
	end

	return var_55_1
end

function GveKnightStruct:getTrainState()
	if self:getTrainInfo().level < self._info.star_level then
		return 4
	end

	local var_56_0 = true

	for iter_56_0 = 1, 4 do
		local var_56_1 = self:getCurTrainAttrInfo(iter_56_0)

		if var_56_1.next ~= 0 then
			return 1
		end

		if var_56_1.cur < var_56_1.total then
			var_56_0 = false
		end
	end

	if not var_56_0 then
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

function GveKnightStruct:getNextTrainState()
	local var_57_0 = 0

	for iter_57_0 = 1, 4 do
		local var_57_1 = self:getCurTrainAttrInfo(iter_57_0)

		if var_57_1.cur + var_57_1.next >= var_57_1.total then
			var_57_0 = var_57_0 + 1
		else
			return 1
		end
	end

	if var_57_0 == 4 then
		return 2
	else
		return 1
	end
end

GveKnightStruct.TRAIN_ITEM = 2

function GveKnightStruct:getTrainCost(arg_58_1)
	return ({
		5,
		50,
		500
	})[arg_58_1 + 1], (g.core.model.User.itemsData:getItemNumById(GveKnightStruct.TRAIN_ITEM))
end

function GveKnightStruct:getTrainInfo(arg_59_1)
	local var_59_0 = self:getBaseInfo().knight_star_id

	if arg_59_1 then
		return g.core.config.knight_star_info.fetch(var_59_0, arg_59_1)
	else
		local var_59_1 = g.core.config.knight_star_info.get(var_59_0, self._info.star_level)

		if self:getAwakeStage() < var_59_1.awake_stage then
			var_59_1 = g.core.config.knight_star_info.get(var_59_0, self._info.star_level - 1)
		end

		return var_59_1
	end
end

function GveKnightStruct:calMaxTrainLevel()
	local var_60_0 = self:getBaseInfo().knight_star_id
	local var_60_1 = 0

	for iter_60_0, iter_60_1 in g.core.config.knight_star_info.ipairs() do
		if 0 ~= 0 and 0 ~= var_60_0 then
			break
		end

		local var_60_2

		if iter_60_1.id == var_60_0 then
			var_60_1 = var_60_1 + 1
			var_60_2 = var_60_0
		end
	end

	self._maxStarLv = var_60_1
end

function GveKnightStruct:getMaxTrainLevel()
	return self._maxStarLv
end

function GveKnightStruct:isMaxTrainLevel()
	return self._info and self._info.star_level == self._maxStarLv or false
end

function GveKnightStruct:getTrainPer()
	local var_63_0 = 0

	for iter_63_0 = 1, 4 do
		local var_63_1 = self:getCurTrainAttrInfo(iter_63_0)

		var_63_0 = var_63_0 + var_63_1.cur / var_63_1.total
	end

	return var_63_0 / 4
end

function GveKnightStruct:getTrainInfos()
	local var_64_0 = {}
	local var_64_1 = 1
	local var_64_2 = self:getTrainInfo(1)

	while var_64_2 do
		var_64_0[#var_64_0 + 1] = var_64_2
		var_64_1 = var_64_1 + 1
		var_64_2 = self:getTrainInfo(var_64_1)
	end

	return var_64_0
end

function GveKnightStruct:getAdvaceAttrs()
	local var_65_0 = {
		0,
		0,
		0,
		0
	}

	local function var_65_1(arg_66_0, arg_66_1)
		if arg_66_0 == 0 then
			return
		end

		if var_65_0[arg_66_0] then
			var_65_0[arg_66_0] = var_65_0[arg_66_0] + arg_66_1
		end
	end

	local var_65_2 = self:getBaseInfo()

	for iter_65_0 = 1, self._info.advance_level - 1 do
		local var_65_3 = var_0_3.get(var_65_2.promote_code, iter_65_0)

		for iter_65_1 = 1, 4 do
			for iter_65_2 = 1, 4 do
				var_65_1(var_65_3["place_" .. iter_65_1 .. "_affect_type_" .. iter_65_2], var_65_3["place_" .. iter_65_1 .. "_affect_value_" .. iter_65_2])
			end

			var_65_1(var_65_3["affect_type_" .. iter_65_1], var_65_3["affect_value_" .. iter_65_1])
		end
	end

	return var_65_0
end

function GveKnightStruct:getCurAdvanceAttr()
	local var_67_0 = {
		0,
		0,
		0,
		0
	}
	local var_67_1 = self:getBaseInfo()
	local var_67_2 = false

	for iter_67_0 = 1, self._info.advance_level - 1 do
		local var_67_3 = var_0_3.get(var_67_1.promote_code, iter_67_0)

		for iter_67_1 = 1, 4 do
			if var_67_3["affect_type_" .. iter_67_1] ~= 0 and var_67_0[var_67_3["affect_type_" .. iter_67_1]] then
				var_67_0[var_67_3["affect_type_" .. iter_67_1]] = var_67_0[var_67_3["affect_type_" .. iter_67_1]] + var_67_3["affect_value_" .. iter_67_1]
			end
		end
	end

	local var_67_4 = var_0_3.get(var_67_1.promote_code, self._info.advance_level)
	local var_67_5 = {
		0,
		0,
		0,
		0
	}

	for iter_67_2 = 1, 4 do
		if var_67_4["affect_type_" .. iter_67_2] ~= 0 and var_67_0[var_67_4["affect_type_" .. iter_67_2]] then
			var_67_5[var_67_4["affect_type_" .. iter_67_2]] = var_67_0[var_67_4["affect_type_" .. iter_67_2]] + var_67_4["affect_value_" .. iter_67_2]
		end
	end

	local var_67_6 = {}

	for iter_67_3 = 1, 4 do
		if var_67_4["affect_type_" .. iter_67_3] ~= 0 and var_67_0[var_67_4["affect_type_" .. iter_67_3]] then
			table.insert(var_67_6, {
				type = var_67_4["affect_type_" .. iter_67_3],
				value = var_67_0[iter_67_3],
				value2 = var_67_5[iter_67_3]
			})
		else
			var_67_2 = true

			break
		end
	end

	if var_67_2 then
		for iter_67_4, iter_67_5 in pairs(var_67_0) do
			table.insert(var_67_6, {
				type = iter_67_4,
				value = iter_67_5
			})
		end
	end

	return var_67_6, var_67_2
end

function GveKnightStruct:getAdvaceTalentData()
	local var_68_0 = {}
	local var_68_1 = self:getBaseInfo()

	for iter_68_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.TRAIN_MAX do
		if var_68_1["promote_talent_" .. iter_68_0] > 0 or var_68_1["promote_passive_" .. iter_68_0 .. "_1"] > 0 then
			local var_68_2 = {
				talentId = var_68_1["promote_talent_" .. iter_68_0] > 0 and var_68_1["promote_talent_" .. iter_68_0] or nil,
				skillId = var_68_1["promote_passive_" .. iter_68_0 .. "_1"] > 0 and var_68_1["promote_passive_" .. iter_68_0 .. "_1"] or nil
			}

			var_68_2.value = self._advStage or 0
			var_68_2.openValue = iter_68_0

			table.insert(var_68_0, var_68_2)
		end
	end

	return #var_68_0, var_68_0
end

function GveKnightStruct:getPassiveList()
	local var_69_0 = {}
	local var_69_1 = 0
	local var_69_2 = false
	local var_69_3 = self:getBaseInfo()

	for iter_69_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.TRAIN_MAX do
		if var_69_3["promote_passive_" .. iter_69_0 .. "_1"] > 0 then
			local var_69_4 = {
				talentLevel = iter_69_0,
				skillId = var_69_3["promote_passive_" .. iter_69_0 .. "_1"]
			}

			var_69_4.value = self._advStage or 0

			if var_69_1 == 0 or iter_69_0 <= self._advStage then
				var_69_1 = var_69_3["promote_passive_" .. iter_69_0 .. "_1"]
				var_69_2 = iter_69_0 <= self._advStage
			end

			table.insert(var_69_0, var_69_4)
		end
	end

	return {
		id = var_69_1,
		isActive = var_69_2
	}, var_69_0
end

function GveKnightStruct:getAwakeAttrs()
	local var_70_0 = self:getAwakeStage()
	local var_70_1 = self:getAwakeId()
	local var_70_2 = {}
	local var_70_3 = {}

	if var_0_4.hasData(var_70_1, var_70_0) then
		var_70_2, var_70_3 = self:getAttrsByAwakeCfg((var_0_4.get(var_70_1, var_70_0)))
	end

	return var_70_2, var_70_3
end

function GveKnightStruct:getAwakeAttrsByStage(arg_71_1)
	local var_71_0 = self:getAwakeId()
	local var_71_2 = {}
	local var_71_3 = {}

	if var_0_4.hasData(var_71_0, arg_71_1) then
		var_71_2, var_71_3 = self:getAttrsByAwakeCfg((var_0_4.get(var_71_0, arg_71_1)))
	end

	return var_71_2, var_71_3
end

function GveKnightStruct:getAttrsByAwakeCfg(arg_72_1)
	local var_72_0 = {}

	for iter_72_0 = 1, 6 do
		if arg_72_1["attribute_type" .. iter_72_0] > 0 then
			var_72_0[arg_72_1["attribute_type" .. iter_72_0]] = var_72_0[arg_72_1["attribute_type" .. iter_72_0]] or 0
			var_72_0[arg_72_1["attribute_type" .. iter_72_0]] = var_72_0[arg_72_1["attribute_type" .. iter_72_0]] + arg_72_1["attribute_value" .. iter_72_0]
		end
	end

	local var_72_1 = {}

	for iter_72_1, iter_72_2 in pairs(var_72_0) do
		table.insert(var_72_1, {
			id = iter_72_1,
			value = iter_72_2
		})
	end

	table.sort(var_72_1, function(arg_73_0, arg_73_1)
		return var_0_6.get(arg_73_0.id).num < var_0_6.get(arg_73_1.id).num
	end)

	return var_72_0, var_72_1
end

function GveKnightStruct:getNextQualityInfo()
	local var_74_0 = self:getBaseInfo()

	for iter_74_0 = 1, var_0_2.getLength() do
		local var_74_1 = var_0_2.indexOf(iter_74_0)

		if var_74_1.star == var_74_0.star and var_74_1.advance_id == var_74_0.advance_id and var_74_1.quality == var_74_0.quality + 1 then
			return var_74_1
		end
	end

	return {}
end

function GveKnightStruct:getNextQuality()
	local var_75_0 = self:getBaseInfo().quality

	for iter_75_0 = 1, g.core.config.role_quality_info.getLength() do
		local var_75_1 = g.core.config.role_quality_info.indexOf(iter_75_0)

		if var_75_1.quality == var_75_0 then
			if var_75_1.is_up == 0 then
				return 0
			else
				return g.core.config.role_quality_info.get(iter_75_0 + 1).quality
			end
		end
	end

	return 0
end

function GveKnightStruct:getSkillLevel()
	return self:getBaseInfo().star + 1
end

function GveKnightStruct:getLevel()
	return (self._info or nil) and (self._info.level or 0)
end

function GveKnightStruct:getStarLv()
	return self:getBaseInfo().star
end

function GveKnightStruct:getAdvTalentList(arg_79_1)
	arg_79_1 = arg_79_1 or self:getBaseInfo()

	local var_79_0 = arg_79_1.promote_code
	local var_79_1 = {}

	for iter_79_0 = 1, var_0_3.getLength() do
		local var_79_2 = var_0_3.indexOf(iter_79_0)

		if var_79_2.promote_code == var_79_0 and not var_79_1[var_79_2.stage] and var_79_2.stage > 0 and arg_79_1["promote_talent_" .. var_79_2.stage] > 0 then
			var_79_1[var_79_2.stage] = {
				stage = var_79_2.stage,
				talentId = arg_79_1["promote_talent_" .. var_79_2.stage]
			}
		end
	end

	return var_79_1
end

function GveKnightStruct:isMaxStar()
	if not self:isOwn() then
		return false
	end

	if self:getBaseInfo().next_star_id == 0 then
		return true
	end

	return false
end

function GveKnightStruct:getAwakeStage()
	return (self._info or nil) and (self._info.awake_stage or 0)
end

function GveKnightStruct:getAwakeId()
	local var_82_0 = self:getBaseInfo()

	if not var_0_2.hasKey("awake_id") then
		return 1
	end

	if not var_82_0 then
		return 1
	end

	return var_82_0.awake_id
end

function GveKnightStruct:hasAwakeAbility()
	return self:getAwakeId() ~= 0
end

function GveKnightStruct:isCanAwake()
	if not self:isOwn() then
		return false
	end

	if not self._defaultCfg then
		return false
	end

	if not var_0_2.hasKey("awake_id") then
		return false
	end

	if self._defaultCfg.awake_id == 0 then
		return false
	end

	local var_84_0 = self:getAwakeStage()
	local var_84_1 = self:getAwakeId()

	if var_0_4.hasData(var_84_1, var_84_0 + 1) then
		return self:getLevel() >= var_0_4.get(var_84_1, var_84_0 + 1).open_level
	end

	return false
end

function GveKnightStruct:getMaxLevel()
	return (g.core.model.User.knightsData:getKnightMaxLvByLevelExpId(self:getBaseInfo().level_exp_id))
end

function GveKnightStruct:isMaxLevel()
	if not self:isOwn() then
		return false
	end

	return self:getLevel() >= self:getMaxLevel()
end

function GveKnightStruct:getAwakeTask()
	return (self._info or nil) and (self._info.awake_task or 0)
end

function GveKnightStruct:getAwakeTaskValue()
	return (self._info or nil) and (self._info.awake_task_value or 0)
end

function GveKnightStruct:getPendantLevel()
	return (self._info or nil) and (self._info.pendant_level or 0)
end

function GveKnightStruct:getPendantStageLv()
	return math.floor(self:getPendantLevel() / var_0_1.PENDANT_MAX_LV_ONESTAGE)
end

function GveKnightStruct:isStartedAwake()
	return self:getAwakeStage() ~= 0
end

function GveKnightStruct:isAwaking()
	return ((self._info or nil) and (self._info.awake_task or 0)) > 0 and self:hasAwakeAbility()
end

function GveKnightStruct:isPendantActive()
	return self:getAwakeStage() > 0
end

function GveKnightStruct:getKnightAwakeState()
	local var_94_0 = self:getLevel()
	local var_94_1 = self:getAwakeId()
	local var_94_2 = self:getAwakeStage()
	local var_94_3 = self:getAwakeTaskValue()
	local var_94_4 = self:getAwakeTask()

	if not var_0_4.hasData(var_94_1, var_94_2 + 1) then
		return 3
	end

	if not self:isAwaking() then
		return 0
	end

	local var_94_5 = var_0_4.get(var_94_1, var_94_2 + 1)

	if var_94_4 == 0 then
		return 0
	end

	if not var_0_5.hasData(var_94_5.awake_task, var_94_4) then
		if var_94_3 >= var_0_5.indexOf(1).task_value then
			return 2
		else
			return 1
		end
	end

	if var_94_3 >= var_0_5.get(var_94_5.awake_task, var_94_4).task_value then
		if not var_0_5.hasData(var_94_5.awake_task, var_94_4 + 1) then
			return 2
		end

		return 1
	else
		return 1
	end

	return 0
end

function GveKnightStruct:getCurAwakeTask()
	local var_95_0 = {}
	local var_95_1 = self:getAwakeTask()
	local var_95_2 = self:getAwakeId()

	if not self:isStartedAwake() then
		local var_95_3 = var_0_4.get(var_95_2, 1)

		if self:getLevel() < var_95_3.open_level then
			return var_95_0
		end

		if not var_0_5.hasData(var_95_3.awake_task, var_95_1) then
			var_95_0 = var_0_5.indexOf(1)

			return var_95_0
		end

		return var_0_5.get(var_95_3.awake_task, var_95_1)
	end

	local var_95_4 = self:getAwakeStage()

	if not var_0_4.hasData(var_95_2, var_95_4 + 1) then
		return var_95_0
	end

	local var_95_5 = var_0_4.get(var_95_2, var_95_4 + 1)

	if not var_0_5.hasData(var_95_5.awake_task, var_95_1) then
		return (var_0_5.indexOf(1))
	end

	return var_0_5.get(var_95_5.awake_task, var_95_1)
end

function GveKnightStruct:getCurAwakeCfg()
	if not self:hasAwakeAbility() then
		return
	end

	local var_96_0 = self:getAwakeId()
	local var_96_1 = self:getAwakeStage()

	if var_96_1 == 0 then
		return var_0_4.get(var_96_0, 1)
	end

	if not var_0_4.hasData(var_96_0, var_96_1) then
		return var_0_4.get(var_96_0, 1)
	end

	return var_0_4.get(var_96_0, var_96_1)
end

function GveKnightStruct:getAllAwakeCfgs()
	local var_97_0 = self:getAwakeId()
	local var_97_1 = {}

	for iter_97_0 = 0, 6 do
		if var_0_4.hasData(var_97_0, iter_97_0) then
			local var_97_2 = var_0_4.get(var_97_0, iter_97_0)

			if var_97_2.talent_skill > 0 then
				table.insert(var_97_1, var_97_2)
			end
		end
	end

	return var_97_1
end

function GveKnightStruct:getCurrPendantTalentId()
	local var_98_0 = var_0_7.get(self:getCurAwakeCfg().awake_pendant).pendant_level_id
	local var_98_1 = self:getPendantLevel()
	local var_98_2 = 0
	local var_98_3

	for iter_98_0 = 0, 7 do
		local var_98_4 = var_0_8.get(var_98_0, var_98_1 + iter_98_0)

		if var_98_4.talent > 0 then
			var_98_2 = var_98_4.talent
			var_98_3 = var_98_4

			break
		end
	end

	return var_98_2, var_98_3
end

function GveKnightStruct:isCanExtendLevel()
	if not self:hasAwakeAbility() then
		return false
	end

	local var_99_0 = self:getAwakeId()
	local var_99_1 = self:getAwakeStage()
	local var_99_2 = self:getLevel()
	local var_99_3 = g.core.model.User:getMaxLevel()

	if var_99_1 == 0 then
		local var_99_4 = var_0_4.get(var_99_0, 1)

		return var_99_2 >= var_99_4.open_level, var_99_4.max_level, var_99_4
	end

	if self:getKnightAwakeState() == 3 then
		return false
	end

	if var_99_2 < var_0_4.get(var_99_0, var_99_1).max_level then
		return false
	end

	if not var_0_4.hasData(var_99_0, var_99_1 + 1) then
		return false
	end

	local var_99_5 = var_0_4.get(var_99_0, var_99_1 + 1)

	return var_99_2 >= var_99_5.open_level, var_99_5.max_level, var_99_5
end

function GveKnightStruct:getLevelCanReach()
	local var_100_0 = self:getAwakeStage()

	if not self:hasAwakeAbility() or var_100_0 == 0 then
		if not self:hasAwakeAbility() then
			return g.core.model.User.knightsData:getKnightMaxLvByLevelExpId(self:getBaseInfo().level_exp_id)
		end

		return g.core.model.User:getMaxLevel()
	end

	local var_100_1 = var_0_4.get(self:getAwakeId(), var_100_0)

	return self:isMain() and var_100_1.max_level or math.min(var_100_1.max_level, g.core.model.User:getLevel())
end

function GveKnightStruct:getCurMaxLevel()
	local var_101_0 = self:getAwakeStage()
	local var_101_1 = self:isMain()
	local var_101_2 = g.core.model.User:getLevel()
	local var_101_3 = g.core.model.User.knightsData:getKnightMaxLvByLevelExpId(self:getBaseInfo().level_exp_id)

	return var_101_3 <= var_101_2 and var_101_3 or var_101_2
end

function GveKnightStruct:getPendantTalentSkillCfgs()
	if not self:hasAwakeAbility() then
		return {}
	end

	local var_102_0 = self:getAwakeId()
	local var_102_1 = {}

	for iter_102_0 = 1, var_0_1.KNIGHT_AWAKE_MAX do
		if var_0_4.hasData(var_102_0, iter_102_0) then
			local var_102_2 = var_0_7.get(var_0_4.get(var_102_0, iter_102_0).awake_pendant).pendant_level_id

			for iter_102_1 = 0, var_0_1.PENDANT_MAX_LV do
				if var_0_8.hasData(var_102_2, iter_102_1) then
					local var_102_3 = var_0_8.get(var_102_2, iter_102_1)

					if var_102_3.talent > 0 then
						table.insert(var_102_1, var_102_3)
					end
				else
					break
				end
			end
		end
	end

	return var_102_1
end

function GveKnightStruct:canPendantUpgrade()
	if not self:isPendantActive() then
		return false
	end

	local var_103_0 = var_0_7.get(self:getCurAwakeCfg().awake_pendant)
	local var_103_1 = self:getPendantLevel()
	local var_103_2 = self:getPendantTalentSkillCfgs()

	if var_103_1 >= var_103_2[#var_103_2].level then
		return false
	end

	local var_103_3 = var_0_8.get(var_103_0.pendant_level_id, var_103_1 + 1)

	return g.core.model.User.bagData:getOwnNum(var_103_3.cost_type, var_103_3.cost_value) >= var_103_3.cost_num
end

function GveKnightStruct:getFavoLevel()
	return (self._info or nil) and (self._info.favorability_level or 0)
end

function GveKnightStruct:getFavoExp()
	return self._info.favorability_exp
end

function GveKnightStruct:getFavoStage()
	return (self._info or nil) and (self._info.favorability_stage or 0)
end

function GveKnightStruct:getMobilityVal()
	return self._info.mobility_val or 0
end

function GveKnightStruct:getMaxMobility()
	return self:getBaseInfo().mobility
end

function GveKnightStruct:isExistMobilityProperty()
	return self:getMaxMobility() > 0
end

function GveKnightStruct:isCanCheckIn()
	return self:isOwn() and self:isExistMobilityProperty()
end

function GveKnightStruct:isCanBeDispatched()
	return self:isOwn() and self:isExistMobilityProperty()
end

function GveKnightStruct:getHomeLandTalent()
	return self:getBaseInfo().homeland_talent
end

function GveKnightStruct:getAdvanceId()
	return self._advanceId
end

function GveKnightStruct:getAdvanceLevel()
	return self.advance_level
end

function GveKnightStruct:getIsNewKnight()
	if self._isNew == nil then
		self._isNew = not (g.core.common.Storage:load("knight_is_card_click.json", g.core.model.User:getId()) or {})[tostring(self._advanceId)]
	end

	return self._isNew and self:isOwn()
end

function GveKnightStruct:setIsNewKnight()
	if self._isNew then
		local var_116_0 = g.core.common.Storage:load("knight_is_card_click.json", g.core.model.User:getId()) or {}

		var_116_0[tostring(self._advanceId)] = true

		g.core.common.Storage:save("knight_is_card_click.json", var_116_0, g.core.model.User:getId())
	end

	self._isNew = false
end

function GveKnightStruct:canLevelUpFive()
	if not self:isLineup() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ONEKEY_LEVELUP) then
		return false
	end

	local var_117_0

	if self:getCurMaxLevel() - self:getLevel() < 5 then
		do return false end

		var_117_0 = 0
	end

	for iter_117_0, iter_117_1 in pairs((g.core.model.User.itemsData:getExpItemData())) do
		local var_117_1 = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_ITEM,
			value = iter_117_1.id,
			size = iter_117_1.num
		})

		if var_117_1.info.item_type then
			var_117_0 = var_117_0 + var_117_1.info.item_value * var_117_1.size
		end
	end

	if var_117_0 == 0 then
		return false
	end

	local var_117_2 = g.core.config.knight_level_info
	local var_117_3 = self:getBaseInfo().level_exp_id
	local var_117_4 = var_117_0 + self._info.exp

	for iter_117_2 = 0, 4 do
		var_117_4 = var_117_4 - var_117_2.get(var_117_3, self._info.level + iter_117_2).next_exp

		if var_117_4 < 0 then
			return false
		end
	end

	return true
end

function GveKnightStruct:canAdvance()
	if not self:isLineup() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ADVANCE) then
		return false
	end

	local var_118_0 = var_0_3.get(self:getBaseInfo().promote_code, (math.max(self:getInfo().advance_level)))

	if self:getLevel() < var_118_0.require_level then
		return false
	end

	if g.core.model.User.bagData:getCountById(var_118_0.cost_type, var_118_0.cost_value) < var_118_0.cost_size or var_118_0.cost_money > g.core.model.User.resourceData:getCoin() then
		return false
	end

	local var_118_1 = g.core.common.Goods

	for iter_118_0 = 1, 4 do
		if var_118_0["place_" .. iter_118_0] == 0 then
			return false
		end

		local var_118_2 = var_118_1:convert({
			type = var_118_1.TYPE_KNIGHT_ADVANCE,
			value = var_118_0["place_" .. iter_118_0]
		})

		var_118_2.numCost = var_118_0["num_" .. iter_118_0]

		if var_118_2.size < var_118_2.numCost then
			return false
		end
	end

	return true
end

return GveKnightStruct
