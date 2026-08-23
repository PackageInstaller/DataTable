local var_0_0 = g.core.const.ConstMgr.KNIGHT_CONST
local var_0_1 = g.core.config.knight_info
local var_0_2 = g.core.config.knight_advance_info
local var_0_8 = g.core.const.ConstMgr.FogNightmareConst
local KnightStruct = require("app.view.module.knight.model.KnightStruct")
local SpecialKnightStruct = class("SpecialKnightStruct", KnightStruct)

function SpecialKnightStruct:ctor(arg_1_1)
	KnightStruct.ctor(self, 0)

	self._defaultCfg = nil
	self._state = var_0_0.SPECIAL_KNIGHT_STATE.FULL_HP1
	self._hpPercent = 100
	self._tempPos = 0
	self._cfgList = {}
	self._sid = 0
	self._attr = {
		base = {},
		ext = {}
	}
	self._developStructs = {}
	self._netInfo = nil
	self._owner = nil

	if arg_1_1 then
		self._baseId = arg_1_1

		self:_init()
	end
end

function SpecialKnightStruct:getKnightState()
	return self._state
end

function SpecialKnightStruct:isDead()
	return self._state == var_0_0.SPECIAL_KNIGHT_STATE.DEFEATED
end

function SpecialKnightStruct:getHpPercent()
	return self._hpPercent
end

function SpecialKnightStruct:setHpPercent(arg_5_1)
	arg_5_1 = arg_5_1 or 100
	self._hpPercent = math.clamp(arg_5_1, 0, 100)
	self._state = self._hpPercent == 100 and var_0_0.SPECIAL_KNIGHT_STATE.FULL_HP or self._hpPercent > 0 and var_0_0.SPECIAL_KNIGHT_STATE.INJURED or var_0_0.SPECIAL_KNIGHT_STATE.DEFEATED
end

function SpecialKnightStruct:setOwnerByFriendId(arg_6_1)
	local var_6_0 = g.core.model.User.friendData:getFriendInfoById(arg_6_1)

	if not var_6_0 then
		return
	end

	self:setOwner((var_6_0:getBasicInfo()))
end

function SpecialKnightStruct:setOwner(arg_7_1)
	self._owner = arg_7_1
end

function SpecialKnightStruct:getOwner()
	return self._owner
end

function SpecialKnightStruct:setDevelopStruct(arg_9_1, arg_9_2)
	self._developStructs[arg_9_2] = arg_9_1
end

function SpecialKnightStruct:getDevelopStruct(arg_10_1)
	return self._developStructs[arg_10_1]
end

function SpecialKnightStruct:getDevelopStructs()
	return self._developStructs
end

function SpecialKnightStruct:getKnightString()
	local var_12_0 = self:getDevelopStruct(var_0_8.KNIGHT_DEVELOP_KEY.ARTIFACT)
	local var_12_1 = {
		tostring(self:getServerId())
	}

	if var_12_0 then
		var_12_1[#var_12_1 + 1] = var_0_8.KNIGHT_DEVELOP_KEY.ARTIFACT
		var_12_1[#var_12_1 + 1] = var_12_0:getServerOnlyId()
	end

	local var_12_2 = self:getDevelopStruct(var_0_8.KNIGHT_DEVELOP_KEY.KEEPSAKE)

	if var_12_2 then
		var_12_1[#var_12_1 + 1] = var_0_8.KNIGHT_DEVELOP_KEY.KEEPSAKE
		var_12_1[#var_12_1 + 1] = var_12_2:getCfg().id
	end

	return (table.concat(var_12_1, "|"))
end

function SpecialKnightStruct:_init()
	self:setBaseId(self._baseId)
end

function SpecialKnightStruct:setBaseId(arg_14_1)
	self:_addCfg(arg_14_1)

	self._baseId = arg_14_1
	self._advanceId = self._cfgList[arg_14_1].advance_id
	self._profession = self._cfgList[arg_14_1].profession
	self._damage = self._cfgList[arg_14_1].attack_type

	local var_14_0 = self:getAdvStage()

	self._advStage = var_14_0.advStage
	self._advNode = var_14_0.advNode

	if self._netInfo then
		self:updateAttrs()
	end
end

function SpecialKnightStruct:getBaseInfo(arg_15_1)
	arg_15_1 = arg_15_1 or self._baseId

	if not arg_15_1 then
		return
	end

	return self._cfgList[arg_15_1]
end

function SpecialKnightStruct:_addCfg(arg_16_1)
	local var_16_0 = var_0_1.get(arg_16_1)

	self._cfgList[arg_16_1] = var_16_0
	self._defaultCfg = self._defaultCfg or var_16_0
end

function SpecialKnightStruct:setInfoByFriendAssistantData(arg_17_1)
	self:setOwnerByFriendId(arg_17_1.uid)
	self:setInfo(arg_17_1)
end

function SpecialKnightStruct:setInfo(arg_18_1)
	self._netInfo = arg_18_1
	self._sid = arg_18_1.id

	self:setBaseId(self._netInfo.base_id)
end

function SpecialKnightStruct:getServerId()
	return self._sid or 0
end

function SpecialKnightStruct:getAdvStage(arg_20_1)
	local var_20_0 = self:getBaseInfo(arg_20_1)
	local var_20_1 = {
		advNode = 0,
		advStage = 0
	}

	if var_20_0 and self._netInfo and self._netInfo.advance_level then
		local var_20_2 = var_0_2.get(var_20_0.promote_code, self._netInfo.advance_level)

		var_20_1.advStage = var_20_2.stage
		var_20_1.advNode = var_20_2.node
	end

	return var_20_1
end

function SpecialKnightStruct:getKnightFight()
	return (self._netInfo and self._netInfo.fight_value or nil) and self._netInfo.fight_value
end

function SpecialKnightStruct:updateAttrsByMonsterInfo(arg_22_1)
	self._attr = {
		base = {},
		ext = {}
	}
	self._attr.base.hp = arg_22_1.initial_hp
	self._attr.base.maxHp = self._attr.base.hp
	self._attr.base.attack = 0
	self._attr.base.phyDef = 0
	self._attr.base.magDef = 0
	self._hpPercent = 100
end

function SpecialKnightStruct:resetFullHp()
	self:updateMonsterHp(self._attr.base.maxHp)
end

function SpecialKnightStruct:updateMonsterHp(arg_24_1)
	self._attr.base.hp = arg_24_1
	self._hpPercent = self._attr.base.hp / self._attr.base.maxHp * 100
end

function SpecialKnightStruct:updateAttrs()
	self._attr = {
		base = {},
		ext = {}
	}

	if self._netInfo then
		self._attr.base.hp = self._netInfo.init_hp
		self._attr.base.attack = self._netInfo.attack or 0
		self._attr.base.phyDef = self._netInfo.phy_defence or 0
		self._attr.base.magDef = self._netInfo.mag_defence or 0

		local var_25_0 = self._netInfo.other_attrs or {}

		for iter_25_0 = 1, #var_25_0 do
			self._attr.ext[var_25_0[iter_25_0].id] = var_25_0[iter_25_0].num
		end
	else
		local var_25_1 = self:getCurAttr()

		self._attr.base.hp = var_25_1[1]
		self._attr.base.attack = var_25_1[2] or 0
		self._attr.base.phyDef = var_25_1[3] or 0
		self._attr.base.magDef = var_25_1[4] or 0
	end
end

function SpecialKnightStruct:getLevelAttrs(arg_26_1, arg_26_2)
	arg_26_1 = self._netInfo and (arg_26_1 or self._netInfo.level) or arg_26_1 or 1

	local var_26_0 = self:getBaseInfo()

	if arg_26_2 then
		var_26_0 = self._cfgList[arg_26_2]
	end

	return {
		var_26_0.base_hp + (arg_26_1 - 1) * var_26_0.develop_hp,
		var_26_0.base_attack + (arg_26_1 - 1) * var_26_0.develop_attack,
		var_26_0.base_physical_defence + (arg_26_1 - 1) * var_26_0.develop_physical_defence,
		var_26_0.base_magical_defence + (arg_26_1 - 1) * var_26_0.develop_magical_defence
	}
end

function SpecialKnightStruct:getAdvaceAttrs()
	local var_27_0

	if self._netInfo then
		var_27_0 = self._netInfo.advance_level or 0
	end

	local var_27_1 = {
		0,
		0,
		0,
		0
	}

	local function var_27_2(arg_28_0, arg_28_1)
		if arg_28_0 == 0 then
			return
		end

		if var_27_1[arg_28_0] then
			var_27_1[arg_28_0] = var_27_1[arg_28_0] + arg_28_1
		end
	end

	local var_27_3 = self:getBaseInfo()

	for iter_27_0 = 1, var_27_0 - 1 do
		local var_27_4 = var_0_2.get(var_27_3.promote_code, iter_27_0)

		for iter_27_1 = 1, 4 do
			for iter_27_2 = 1, 4 do
				var_27_2(var_27_4["place_" .. iter_27_1 .. "_affect_type_" .. iter_27_2], var_27_4["place_" .. iter_27_1 .. "_affect_value_" .. iter_27_2])
			end

			var_27_2(var_27_4["affect_type_" .. iter_27_1], var_27_4["affect_value_" .. iter_27_1])
		end
	end

	return var_27_1
end

function SpecialKnightStruct:updatePos(arg_29_1)
	self._netInfo.position = arg_29_1
end

function SpecialKnightStruct:getFormationPos()
	return self._netInfo.position
end

function SpecialKnightStruct:updateTempFormationPos(arg_31_1)
	self._tempPos = arg_31_1
end

function SpecialKnightStruct:getTempFormationPos()
	return self._tempPos
end

function SpecialKnightStruct:isDisplay()
	local var_33_0 = self:getBaseInfo()

	return var_33_0 and var_33_0.is_display == 1
end

function SpecialKnightStruct:isLineup()
	return self._netInfo and self._netInfo.position > 0 and self._netInfo.position <= var_0_0.LINEUP_MAX
end

function SpecialKnightStruct:isHelper()
	return self._netInfo and self._netInfo.position > var_0_0.LINEUP_MAX and self._netInfo.position <= var_0_0.KNIGHT_PARTNER_MAX
end

function SpecialKnightStruct:isBackup()
	return self._netInfo and self._netInfo.position > var_0_0.KNIGHT_PARTNER_MAX
end

function SpecialKnightStruct:getBaseId()
	return self._baseId
end

function SpecialKnightStruct:getInfo()
	return self._netInfo
end

function SpecialKnightStruct:getName()
	if self:isMain() then
		if self._isOtherUser then
			return self._otherUserName
		else
			if self._owner then
				if self._owner.id ~= g.core.model.User:getId() then
					return g.core.lang:get(500227)
				else
					return self._owner.name
				end
			end

			return g.core.model.User:getName()
		end

		return ""
	else
		return self:getBaseInfo().name
	end
end

function SpecialKnightStruct:getResInfo()
	local var_40_0 = self:getBaseInfo().res_id

	if self:isMain() and self._owner and self._owner.dress_id ~= 0 then
		var_40_0 = self:getBaseInfo().sex == 0 and g.core.config.dress_info.get(self._owner.dress_id).woman_res_id or g.core.config.dress_info.get(self._owner.dress_id).man_res_id
	end

	if self:isWearSkin() then
		local var_40_1 = g.core.config.skin_info.fetch(self._netInfo.skin)

		if var_40_1 then
			var_40_0 = var_40_1.res
		end
	end

	return g.core.config.knight_base_info.get(var_40_0)
end

function SpecialKnightStruct:getVoiceResInfo(arg_41_1, arg_41_2)
	local var_41_0 = self:getBaseInfo().res_id

	if self:isMain() and self._owner and self._owner.dress_id ~= 0 and not arg_41_1 then
		var_41_0 = self:getBaseInfo().sex == 0 and g.core.config.dress_info.get(self._owner.dress_id).woman_res_id or g.core.config.dress_info.get(self._owner.dress_id).man_res_id
	end

	if self:isWearSkin() and not arg_41_1 then
		local var_41_1 = g.core.config.skin_info.fetch(self._netInfo.skin)

		if var_41_1 then
			var_41_0 = var_41_1.res
		end
	end

	local var_41_2 = g.core.config.knight_show_info.fetch(var_41_0)

	if not arg_41_2 and var_41_2 and var_41_2.toObject then
		var_41_2 = var_41_2.toObject()

		local var_41_3 = g.core.model.User:isBoy()

		for iter_41_0, iter_41_1 in pairs(var_41_2) do
			if var_41_2[iter_41_0 .. "_woman"] and var_41_2[iter_41_0 .. "_woman"] ~= "" and var_41_2[iter_41_0 .. "_woman"] ~= iter_41_1 and not var_41_3 then
				var_41_2[iter_41_0] = var_41_2[iter_41_0 .. "_woman"]
			end
		end
	end

	return var_41_2
end

function SpecialKnightStruct:getSkin()
	if self._netInfo and self._netInfo.skin and self._netInfo.skin > 0 then
		if self._netInfo.skin_ts and (self._netInfo.skin_ts == 0 or self._netInfo.skin_ts > g.core.common.ServerTime:getTime()) then
			return self._netInfo.skin, self._netInfo.skin_ts
		end

		return self._netInfo.skin or 0, self._netInfo.skin_ts or 0
	end

	return 0, 0
end

function SpecialKnightStruct:isWearSkin()
	local var_43_0, var_43_1 = self:getSkin()

	return var_43_0 + var_43_1 > 0
end

function SpecialKnightStruct:isOwn()
	return self._netInfo ~= nil
end

function SpecialKnightStruct:calcSortList(arg_45_1)
	local var_45_0 = {}
	local var_45_1 = self:getBaseInfo()
	local var_45_2, var_45_3, var_45_4 = self:canCompose()

	var_45_0[#var_45_0 + 1] = var_45_2 and 1 or 0

	if self._netInfo then
		if self:isLineup() then
			var_45_0[#var_45_0 + 1] = var_0_0.KNIGHT_BACKUP_MAX + 1 - self._netInfo.position or 0
		end
	end

	var_45_0[#var_45_0 + 1] = self:canStarUp() and 1 or 0
	var_45_0[#var_45_0 + 1] = var_45_1.quality
	var_45_0[#var_45_0 + 1] = var_45_1.star

	if self._netInfo then
		var_45_0[#var_45_0 + 1] = self._netInfo.level or 0
	end

	if self._netInfo then
		var_45_0[#var_45_0 + 1] = self._netInfo.advance_level or 0
	end

	var_45_0[#var_45_0 + 1] = var_45_1.id
	self._sortList = var_45_0
end

function SpecialKnightStruct:calcLineupSortList(arg_46_1, arg_46_2)
	local var_46_0 = {}
	local var_46_1 = self:getBaseInfo()

	var_46_0[#var_46_0 + 1] = var_46_1.advance_id == arg_46_1 and 1 or 0

	if self._netInfo then
		if self:isLineup() then
			var_46_0[#var_46_0 + 1] = var_0_0.KNIGHT_BACKUP_MAX + 1 - self._netInfo.position or 0
		end

		if self:isBackup() then
			var_46_0[#var_46_0 + 1] = var_0_0.KNIGHT_BACKUP_MAX + 1 - self._netInfo.position or 0
		end

		if self:isHelper() then
			var_46_0[#var_46_0 + 1] = var_0_0.KNIGHT_BACKUP_MAX + 1 - self._netInfo.position or 0
		end
	end

	var_46_0[#var_46_0 + 1] = var_46_1.quality
	var_46_0[#var_46_0 + 1] = g.core.model.User.formationData:getAvailAssctCountByAdvId(var_46_1.advance_id, arg_46_2)
	var_46_0[#var_46_0 + 1] = var_46_1.star
	var_46_0[#var_46_0 + 1] = var_46_1.id
	self._sortList = var_46_0
end

function SpecialKnightStruct:getNextStarAttr(arg_47_1, arg_47_2)
	local var_47_0 = 1

	if self._netInfo then
		arg_47_1 = arg_47_1 or self:getBaseInfo().star or 0
		var_47_0 = self._netInfo.level
	else
		arg_47_1 = arg_47_1 or 0
	end

	local var_47_1 = arg_47_1 == 7

	arg_47_1 = math.min(arg_47_1 + 1, 7)

	local var_47_2 = self:getBaseInfo()

	if arg_47_2 then
		var_47_2 = self._cfgIdInfo[arg_47_2]
	end

	local var_47_3 = {}

	if var_47_2.id - var_47_2.star + arg_47_1 > 0 then
		local var_47_4 = var_47_0 - 1

		if var_47_0 - 1 < 0 then
			var_47_4 = 0
		end

		var_47_3.hp = self._cfgIdInfo[var_47_2.id - var_47_2.star + arg_47_1].base_hp + self._cfgIdInfo[var_47_2.id - var_47_2.star + arg_47_1].develop_hp * var_47_4
		var_47_3.attack = self._cfgIdInfo[var_47_2.id - var_47_2.star + arg_47_1].base_attack + self._cfgIdInfo[var_47_2.id - var_47_2.star + arg_47_1].develop_attack * var_47_4
		var_47_3.phyDef = self._cfgIdInfo[var_47_2.id - var_47_2.star + arg_47_1].base_physical_defence + self._cfgIdInfo[var_47_2.id - var_47_2.star + arg_47_1].develop_physical_defence * var_47_4
		var_47_3.magDef = self._cfgIdInfo[var_47_2.id - var_47_2.star + arg_47_1].base_magical_defence + self._cfgIdInfo[var_47_2.id - var_47_2.star + arg_47_1].develop_magical_defence * var_47_4
	end

	local var_47_5 = {
		hp = var_47_2.base_hp + var_47_2.develop_hp * (var_47_0 - 1),
		attack = var_47_2.base_attack + var_47_2.develop_attack * (var_47_0 - 1),
		phyDef = var_47_2.base_physical_defence + var_47_2.develop_physical_defence * (var_47_0 - 1),
		magDef = var_47_2.base_magical_defence + var_47_2.develop_magical_defence * (var_47_0 - 1)
	}
	local var_47_6 = {}

	table.insert(var_47_6, {
		type = 1,
		value = var_47_5.hp,
		value2 = var_47_3.hp
	})
	table.insert(var_47_6, {
		type = 2,
		value = var_47_5.attack,
		value2 = var_47_3.attack
	})
	table.insert(var_47_6, {
		type = 3,
		value = var_47_5.phyDef,
		value2 = var_47_3.phyDef
	})
	table.insert(var_47_6, {
		type = 4,
		value = var_47_5.magDef,
		value2 = var_47_3.magDef
	})

	return var_47_6, var_47_1
end

function SpecialKnightStruct:getCurStarAttr(arg_48_1, arg_48_2)
	local var_48_0 = 1

	if self._netInfo then
		arg_48_1 = arg_48_1 or self._netInfo.star
		var_48_0 = self._netInfo.level
	else
		arg_48_1 = arg_48_1 or 1
	end

	local var_48_1 = self:getBaseInfo()

	if arg_48_2 then
		var_48_1 = self._cfgIdInfo[arg_48_2]
	end

	local var_48_2 = {}

	if var_48_1.advance_id + arg_48_1 - 1 > 0 then
		local var_48_3 = var_48_0 - 1

		if var_48_0 - 1 < 0 then
			var_48_3 = 0
		end

		var_48_2.hp = self._cfgIdInfo[var_48_1.advance_id + arg_48_1 - 1].base_hp + self._cfgIdInfo[var_48_1.advance_id + arg_48_1 - 1].develop_hp * var_48_3
		var_48_2.attack = self._cfgIdInfo[var_48_1.advance_id + arg_48_1 - 1].base_attack + self._cfgIdInfo[var_48_1.advance_id + arg_48_1 - 1].develop_attack * var_48_3
		var_48_2.phyDef = self._cfgIdInfo[var_48_1.advance_id + arg_48_1 - 1].base_physical_defence + self._cfgIdInfo[var_48_1.advance_id + arg_48_1 - 1].develop_physical_defence * var_48_3
		var_48_2.magDef = self._cfgIdInfo[var_48_1.advance_id + arg_48_1 - 1].base_magical_defence + self._cfgIdInfo[var_48_1.advance_id + arg_48_1 - 1].develop_magical_defence * var_48_3
	end

	local var_48_4 = {
		hp = var_48_1.base_hp + var_48_1.develop_hp * (var_48_0 - 1),
		attack = var_48_1.base_attack + var_48_1.develop_attack * (var_48_0 - 1),
		phyDef = var_48_1.base_physical_defence + var_48_1.develop_physical_defence * (var_48_0 - 1),
		magDef = var_48_1.base_magical_defence + var_48_1.develop_magical_defence * (var_48_0 - 1)
	}
	local var_48_5 = {}

	table.insert(var_48_5, {
		type = 1,
		value = var_48_2.hp,
		value2 = var_48_4.hp
	})
	table.insert(var_48_5, {
		type = 2,
		value = var_48_2.attack,
		value2 = var_48_4.attack
	})
	table.insert(var_48_5, {
		type = 3,
		value = var_48_2.phyDef,
		value2 = var_48_4.phyDef
	})
	table.insert(var_48_5, {
		type = 4,
		value = var_48_2.magDef,
		value2 = var_48_4.magDef
	})

	return var_48_5
end

function SpecialKnightStruct:getCurTrainAttrInfos()
	local var_49_0 = {}

	for iter_49_0 = 1, 4 do
		var_49_0[iter_49_0] = self:getCurTrainAttrInfo(iter_49_0).cur
	end

	local var_49_1

	if self._netInfo then
		var_49_1 = self._netInfo.star_level or 1
	end

	local var_49_2 = {
		"initial_hp"
	}

	for iter_49_1 = 1, var_49_1 - 1 do
		local var_49_3 = self:getTrainInfo(iter_49_1)

		for iter_49_2 = 1, 4 do
			var_49_0[iter_49_2] = var_49_0[iter_49_2] + var_49_3[var_49_2[iter_49_2]]
		end
	end

	return var_49_0
end

function SpecialKnightStruct:getCurTrainAttrInfo(arg_50_1)
	if not self._netInfo then
		return {}
	end

	local var_50_0 = self:getTrainInfo()
	local var_50_1 = {
		cur = self._netInfo.star_train[arg_50_1],
		next = self._netInfo.star_train[arg_50_1 + 4],
		total = var_50_0[({
			"initial_hp"
		})[arg_50_1]]
	}

	if var_50_0.level < self._netInfo.star_level then
		var_50_1.next = 0
		var_50_1.cur = var_50_1.total
	end

	return var_50_1
end

function SpecialKnightStruct:getTrainState()
	if self:getTrainInfo().level < self._netInfo.star_level then
		return 4
	end

	local var_51_0 = true

	for iter_51_0 = 1, 4 do
		local var_51_1 = self:getCurTrainAttrInfo(iter_51_0)

		if var_51_1.next ~= 0 then
			return 1
		end

		if var_51_1.cur < var_51_1.total then
			var_51_0 = false
		end
	end

	if not var_51_0 then
		return 0
	end

	if not self._netInfo.is_star_activited then
		return 2
	end

	return 3
end

SpecialKnightStruct.TRAIN_ITEM = 2

function SpecialKnightStruct:getTrainInfo(arg_52_1)
	local var_52_0 = self:getBaseInfo().knight_star_id

	if arg_52_1 then
		return g.core.config.knight_star_info.fetch(var_52_0, arg_52_1)
	else
		local var_52_1 = g.core.config.knight_star_info.get(var_52_0, self._netInfo.star_level)

		if self:getAwakeStage() < var_52_1.awake_stage then
			var_52_1 = g.core.config.knight_star_info.get(var_52_0, self._netInfo.star_level - 1)
		end

		return var_52_1
	end
end

function SpecialKnightStruct:getCurAdvanceAttr()
	local var_53_0 = {
		0,
		0,
		0,
		0
	}
	local var_53_1 = self:getBaseInfo()
	local var_53_2 = false

	for iter_53_0 = 1, self._netInfo.advance_level - 1 do
		local var_53_3 = var_0_2.get(var_53_1.promote_code, iter_53_0)

		for iter_53_1 = 1, 4 do
			if var_53_3["affect_type_" .. iter_53_1] ~= 0 and var_53_0[var_53_3["affect_type_" .. iter_53_1]] then
				var_53_0[var_53_3["affect_type_" .. iter_53_1]] = var_53_0[var_53_3["affect_type_" .. iter_53_1]] + var_53_3["affect_value_" .. iter_53_1]
			end
		end
	end

	local var_53_4 = var_0_2.get(var_53_1.promote_code, self._netInfo.advance_level)
	local var_53_5 = {
		0,
		0,
		0,
		0
	}

	for iter_53_2 = 1, 4 do
		if var_53_4["affect_type_" .. iter_53_2] ~= 0 and var_53_0[var_53_4["affect_type_" .. iter_53_2]] then
			var_53_5[var_53_4["affect_type_" .. iter_53_2]] = var_53_0[var_53_4["affect_type_" .. iter_53_2]] + var_53_4["affect_value_" .. iter_53_2]
		end
	end

	local var_53_6 = {}

	for iter_53_3 = 1, 4 do
		if var_53_4["affect_type_" .. iter_53_3] ~= 0 and var_53_0[var_53_4["affect_type_" .. iter_53_3]] then
			table.insert(var_53_6, {
				type = var_53_4["affect_type_" .. iter_53_3],
				value = var_53_0[iter_53_3],
				value2 = var_53_5[iter_53_3]
			})
		else
			var_53_2 = true

			break
		end
	end

	if var_53_2 then
		for iter_53_4, iter_53_5 in pairs(var_53_0) do
			table.insert(var_53_6, {
				type = iter_53_4,
				value = iter_53_5
			})
		end
	end

	return var_53_6, var_53_2
end

function SpecialKnightStruct:getLevel()
	return (self._netInfo or nil) and (self._netInfo.level or 0)
end

function SpecialKnightStruct:getAwakeStage()
	return (self._netInfo or nil) and (self._netInfo.awake_stage or 0)
end

function SpecialKnightStruct:getAwakeTask()
	return (self._netInfo or nil) and (self._netInfo.awake_task or 0)
end

function SpecialKnightStruct:getAwakeTaskValue()
	return (self._netInfo or nil) and (self._netInfo.awake_task_value or 0)
end

function SpecialKnightStruct:getPendantLevel()
	return (self._netInfo or nil) and (self._netInfo.pendant_level or 0)
end

function SpecialKnightStruct:isAwaking()
	return ((self._netInfo or nil) and (self._netInfo.awake_task or 0)) > 0 and self:hasAwakeAbility()
end

function SpecialKnightStruct:getFavoLevel()
	return (self._netInfo or nil) and (self._netInfo.favorability_level or 0)
end

function SpecialKnightStruct:getFavoExp()
	return self._netInfo.favorability_exp
end

function SpecialKnightStruct:getFavoStage()
	return (self._netInfo or nil) and (self._netInfo.favorability_stage or 0)
end

function SpecialKnightStruct:getMobilityVal()
	return self._netInfo.mobility_val or 0
end

function SpecialKnightStruct:getProfession()
	return self._profession
end

function SpecialKnightStruct:getAdvanceLevel()
	return self.advance_level
end

function SpecialKnightStruct:canLevelUpFive()
	if not self:isLineup() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ONEKEY_LEVELUP) then
		return false
	end

	local var_66_0

	if self:getCurMaxLevel() - self:getLevel() < 5 then
		do return false end

		var_66_0 = 0
	end

	for iter_66_0, iter_66_1 in pairs((g.core.model.User.itemsData:getExpItemData())) do
		local var_66_1 = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_ITEM,
			value = iter_66_1.id,
			size = iter_66_1.num
		})

		if var_66_1.info.item_type then
			var_66_0 = var_66_0 + var_66_1.info.item_value * var_66_1.size
		end
	end

	if var_66_0 == 0 then
		return false
	end

	local var_66_2 = g.core.config.knight_level_info
	local var_66_3 = self:getBaseInfo().level_exp_id
	local var_66_4 = var_66_0 + self._netInfo.exp

	for iter_66_2 = 0, 4 do
		var_66_4 = var_66_4 - var_66_2.get(var_66_3, self._netInfo.level + iter_66_2).next_exp

		if var_66_4 < 0 then
			return false
		end
	end

	return true
end

function SpecialKnightStruct:canAdvance()
	if not self:isLineup() then
		return false
	end

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_ADVANCE) then
		return false
	end

	local var_67_0 = var_0_2.get(self:getBaseInfo().promote_code, (math.max(self:getInfo().advance_level)))

	if self:getLevel() < var_67_0.require_level then
		return false
	end

	if g.core.model.User.bagData:getCountById(var_67_0.cost_type, var_67_0.cost_value) < var_67_0.cost_size or var_67_0.cost_money > g.core.model.User.resourceData:getCoin() then
		return false
	end

	local var_67_1 = g.core.common.Goods

	for iter_67_0 = 1, 4 do
		if var_67_0["place_" .. iter_67_0] == 0 then
			return false
		end

		local var_67_2 = var_67_1:convert({
			type = var_67_1.TYPE_KNIGHT_ADVANCE,
			value = var_67_0["place_" .. iter_67_0]
		})

		var_67_2.numCost = var_67_0["num_" .. iter_67_0]

		if var_67_2.size < var_67_2.numCost then
			return false
		end
	end

	return true
end

function SpecialKnightStruct:getDamage()
	return self._damage
end

return SpecialKnightStruct
