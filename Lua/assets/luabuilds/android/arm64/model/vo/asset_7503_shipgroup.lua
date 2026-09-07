local ShipGroup = class("ShipGroup", import(".BaseVO"))

ShipGroup.REQ_INTERVAL = 60

function ShipGroup:GetGroupConfig()
	local var_1_0 = checkExist(pg.ship_data_group.get_id_list_by_group_type[self], {
		1
	})

	return (var_1_0 or nil) and (pg.ship_data_group[var_1_0] or nil)
end

function ShipGroup:getDefaultShipConfig()
	return pg.ship_data_statistics[self * 10 + 1]
end

function ShipGroup:getDefaultShipNameByGroupID()
	return ShipGroup.getDefaultShipConfig(self).name
end

function ShipGroup:IsBluePrintGroup()
	return tobool(pg.ship_data_blueprint[self])
end

function ShipGroup:IsMetaGroup()
	return tobool(pg.ship_strengthen_meta[self])
end

function ShipGroup:IsMotGroup()
	return ShipGroup.getDefaultShipConfig(self).nationality == Nation.MOT
end

ShipGroup.STATE_LOCK = 0
ShipGroup.STATE_NOTGET = 1
ShipGroup.STATE_UNLOCK = 2
ShipGroup.ENABLE_SKIP_TO_CHAPTER = true

local var_0_1 = pg.ship_data_group

function ShipGroup:getState(arg_7_1, arg_7_2)
	if ShipGroup.ENABLE_SKIP_TO_CHAPTER then
		if arg_7_2 and not arg_7_1 then
			return ShipGroup.STATE_NOTGET
		end

		if var_0_1[self] then
			local var_7_0 = var_0_1[self]

			assert(var_0_1[self].hide, "hide can not be nil in code " .. self)

			if not var_7_0.hide then
				return ShipGroup.STATE_LOCK
			end

			if var_7_0.hide == 1 then
				return ShipGroup.STATE_LOCK
			elseif var_7_0.hide ~= 0 then
				assert(var_7_0.hide == 0 or var_7_0.hide == 1, "hide sign invalid in code " .. self)

				return ShipGroup.STATE_LOCK
			end
		end

		if arg_7_1 then
			return ShipGroup.STATE_UNLOCK
		else
			local var_7_1 = var_0_1[self]

			if not var_0_1[self] then
				return ShipGroup.STATE_LOCK
			end

			assert(var_7_1, "code can not be nil" .. self)

			local var_7_2

			if var_7_1.redirect_id ~= 0 then
				var_7_2 = getProxy(ChapterProxy):getChapterById(var_7_1.redirect_id)
			end

			if var_7_1.redirect_id == 0 or var_7_2 and var_7_2:isClear() then
				return ShipGroup.STATE_NOTGET
			else
				return ShipGroup.STATE_LOCK
			end
		end
	else
		return (arg_7_1 or nil) and (ShipGroup.STATE_UNLOCK or ShipGroup.STATE_LOCK)
	end

	return
end

function ShipGroup:Ctor(arg_8_1)
	self.id = arg_8_1.id
	self.star = arg_8_1.star
	self.hearts = arg_8_1.heart_count
	self.iheart = (arg_8_1.heart_flag or 0) > 0
	self.married = arg_8_1.marry_flag
	self.maxIntimacy = arg_8_1.intimacy_max
	self.maxLV = arg_8_1.lv_max
	self.evaluation = nil
	self.equipCodes = nil
	self.lastReqStamp = 0
	self.trans = false
	self.remoulded = arg_8_1.remoulded

	local var_8_0 = ShipGroup.getDefaultShipConfig(self.id)

	assert(var_8_0, "can not find ship_data_statistics for group " .. self.id)

	self.shipConfig = setmetatable({}, {
		__index = function(arg_9_0, arg_9_1)
			return var_8_0[arg_9_1]
		end
	})

	local var_8_1 = ShipGroup.GetGroupConfig(self.id)

	assert(var_8_1, "can not find ship_data_group for group " .. self.id)

	self.groupConfig = setmetatable({}, {
		__index = function(arg_10_0, arg_10_1)
			return var_8_1[arg_10_1]
		end
	})

	return
end

function ShipGroup:getName(arg_11_1)
	return (arg_11_1 and self.trans or nil) and pg.ship_skin_template[self.groupConfig.trans_skin].name
end

function ShipGroup:getNation()
	return self.shipConfig.nationality
end

function ShipGroup:getRarity(arg_13_1)
	local var_13_0 = self.shipConfig.rarity

	if arg_13_1 and self.trans then
		var_13_0 = var_13_0 + 1
	end

	return var_13_0
end

function ShipGroup:getTeamType()
	return ShipType.GetTeamFromShipType(self:getShipType())
end

function ShipGroup:getPainting(arg_15_1)
	local var_15_0 = self.shipConfig.skin_id

	if arg_15_1 and self.trans then
		var_15_0 = self.groupConfig.trans_skin
	end

	local var_15_1 = pg.ship_skin_template[var_15_0]

	assert(pg.ship_skin_template[var_15_0], "ship_skin_template not exist: " .. var_15_0)

	return var_15_1.painting
end

function ShipGroup:getPaintingId(arg_16_1)
	return (arg_16_1 and self.trans or nil) and self.groupConfig.trans_skin
end

function ShipGroup:getShipType(arg_17_1)
	local var_17_0 = self.shipConfig.type

	if arg_17_1 and self.trans then
		local var_17_1 = Ship.getTransformShipId(self.shipConfig.id)

		if var_17_1 then
			var_17_0 = pg.ship_data_statistics[var_17_1].type
		end
	end

	return var_17_0
end

function ShipGroup:getShipConfigId(arg_18_1)
	local var_18_0 = self.shipConfig.id

	if arg_18_1 and self.trans then
		local var_18_1 = Ship.getTransformShipId(self.shipConfig.id)

		if var_18_1 then
			var_18_0 = pg.ship_data_statistics[var_18_1].id
		end
	end

	return var_18_0
end

function ShipGroup:getSkinList()
	return ShipSkin.GetAllSkinByGroup(self)
end

function ShipGroup:GetDisplayableSkinList()
	local var_20_0 = {}

	local function var_20_1(arg_21_0)
		return arg_21_0.skin_type ~= ShipSkin.SKIN_TYPE_OLD and (arg_21_0.skin_type == ShipSkin.SKIN_TYPE_NOT_HAVE_HIDE and not getProxy(ShipSkinProxy):hasSkin(arg_21_0.id) or false) or true
	end

	local function var_20_2(arg_22_0)
		return getProxy(ShipSkinProxy):InShowTime(arg_22_0)
	end

	for iter_20_0, iter_20_1 in ipairs(pg.ship_skin_template.all) do
		if pg.ship_skin_template[iter_20_1].ship_group == self and pg.ship_skin_template[iter_20_1].no_showing ~= "1" and not var_20_1(pg.ship_skin_template[iter_20_1]) and var_20_2(pg.ship_skin_template[iter_20_1].id) then
			table.insert(var_20_0, pg.ship_skin_template[iter_20_1])
		end
	end

	for iter_20_2 = #var_20_0, 1, -1 do
		if ShipSkin.GetChangeSkinGroupId(var_20_0[iter_20_2].id) and ShipSkin.GetChangeSkinIndex(var_20_0[iter_20_2].id) ~= 1 then
			table.remove(var_20_0, iter_20_2)
		end
	end

	return var_20_0
end

function ShipGroup:getDefaultSkin()
	return ShipSkin.GetSkinByType(self, ShipSkin.SKIN_TYPE_DEFAULT)
end

function ShipGroup:getProposeSkin()
	return ShipSkin.GetSkinByType(self, ShipSkin.SKIN_TYPE_PROPOSE)
end

function ShipGroup:getModSkin()
	if pg.ship_data_trans[self] then
		return pg.ship_skin_template[pg.ship_data_trans[self].skin_id]
	end

	return nil
end

function ShipGroup:GetSkin(arg_26_1)
	if not arg_26_1 then
		return ShipGroup.getDefaultSkin(self.id)
	else
		return ShipGroup.getModSkin(self.id)
	end

	return
end

function ShipGroup:updateMaxIntimacy(arg_27_1)
	self.maxIntimacy = math.max(arg_27_1, self.maxIntimacy)

	return
end

function ShipGroup:updateMarriedFlag()
	self.married = 1

	return
end

function ShipGroup:IsMarried()
	return self.married == 1
end

function ShipGroup:isBluePrintGroup()
	return ShipGroup.IsBluePrintGroup(self.id)
end

function ShipGroup:getBluePrintChangeSkillList()
	assert(self:isBluePrintGroup(), "ShipGroup " .. self.id .. "isn't BluePrint")

	return pg.ship_data_blueprint[self.id].change_skill
end

function ShipGroup:GetNationTxt()
	return Nation.Nation2facionName(self.shipConfig.nationality) .. "-" .. Nation.Nation2Name(self.shipConfig.nationality)
end

ShipGroup.CONDITION_FORBIDDEN = -1
ShipGroup.CONDITION_CLEAR = 0
ShipGroup.CONDITION_INTIMACY = 1
ShipGroup.CONDITION_MARRIED = 2

function ShipGroup:VoiceReplayCodition(arg_33_1)
	local var_33_0 = true
	local var_33_1 = ""

	if self:isBluePrintGroup() then
		local var_33_2 = getProxy(TechnologyProxy):getBluePrintById(self.id)

		assert(var_33_2, "blueprint can not be nil >>" .. self.id)

		if not table.contains(var_33_2:getUnlockVoices(), arg_33_1.key) then
			local var_33_3 = var_33_2:getUnlockLevel(arg_33_1.key)

			if var_33_3 > 0 then
				var_33_0 = false

				local var_33_5 = i18n("ship_profile_voice_locked_design", var_33_3)

				return
			end
		end
	end

	if self:isMetaGroup() then
		local var_33_6 = getProxy(BayProxy):getMetaShipByGroupId(self.id):getMetaCharacter()

		if not table.contains(var_33_6:getUnlockedVoiceList(), arg_33_1.key) then
			local var_33_7 = var_33_6:getUnlockVoiceRepairPercent(arg_33_1.key)

			if var_33_7 > 0 then
				var_33_0 = false

				local var_33_9 = i18n("ship_profile_voice_locked_meta", var_33_7)

				return
			end
		end
	end

	if arg_33_1.unlock_condition[1] == ShipGroup.CONDITION_INTIMACY then
		if self.maxIntimacy < arg_33_1.unlock_condition[2] then
			var_33_0 = false
			var_33_1 = i18n("ship_profile_voice_locked_intimacy", math.floor(arg_33_1.unlock_condition[2] / 100))
		end
	elseif arg_33_1.unlock_condition[1] == ShipGroup.CONDITION_MARRIED and self.married == 0 then
		var_33_0 = false
		var_33_1 = self:IsXIdol() and i18n("ship_profile_voice_locked_propose_imas") or i18n("ship_profile_voice_locked_propose")
	end

	return var_33_0, var_33_1
end

function ShipGroup:GetMaxIntimacy()
	return self.maxIntimacy / 100 + ((self.married or nil) and (self.married * 1000 or 0))
end

function ShipGroup:isSpecialFilter()
	for iter_35_0, iter_35_1 in ipairs(self.shipConfig.tag_list) do
		if iter_35_1 == "special" then
			return true
		end
	end

	return false
end

function ShipGroup:getGroupId()
	return self.id
end

function ShipGroup:isRemoulded()
	return self.remoulded
end

function ShipGroup:isMetaGroup()
	return ShipGroup.IsMetaGroup(self.id)
end

local var_0_2 = {
	feeling2 = true,
	feeling3 = true,
	feeling5 = true,
	propose = true,
	feeling4 = true,
	feeling1 = true
}

function ShipGroup:getIntimacyName(arg_39_1)
	if not var_0_2[arg_39_1] then
		return
	end

	if self:isMetaGroup() then
		return i18n("meta_voice_name_" .. arg_39_1)
	elseif self:IsXIdol() then
		return i18n("idolmaster_voice_name_" .. arg_39_1)
	end

	return
end

function ShipGroup:getProposeType()
	if self:isMetaGroup() then
		return "meta"
	elseif self:IsXIdol() then
		return "imas"
	else
		return "default"
	end

	return
end

function ShipGroup:IsXIdol()
	return self:getNation() == Nation.IDOL_LINK
end

function ShipGroup:CanUseShareSkin()
	return self.groupConfig.share_group_id and #self.groupConfig.share_group_id > 0
end

function ShipGroup:rarity2bgPrint(arg_43_1)
	return shipRarity2bgPrint(self:getRarity(arg_43_1), self:isBluePrintGroup(), self:isMetaGroup())
end

function ShipGroup:rarity2bgPrintForGet(arg_44_1, arg_44_2)
	return skinId2bgPrint(arg_44_2 or self:GetSkin(arg_44_1).id) or self:rarity2bgPrint(arg_44_1)
end

function ShipGroup:setEquipCodes(arg_45_1)
	self.equipCodes = arg_45_1

	return
end

function ShipGroup:getEquipCodes()
	return self.equipCodes
end

return ShipGroup
