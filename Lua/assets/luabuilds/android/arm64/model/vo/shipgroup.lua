local var_0_0 = class("ShipGroup", import(".BaseVO"))

var_0_0.REQ_INTERVAL = 60

function var_0_0.GetGroupConfig(arg_1_0)
	local var_1_0 = checkExist(pg.ship_data_group.get_id_list_by_group_type[arg_1_0], {
		1
	})

	if var_1_0 then
		return pg.ship_data_group[var_1_0] or nil
	end
end

function var_0_0.getDefaultShipConfig(arg_2_0)
	return pg.ship_data_statistics[arg_2_0 * 10 + 1]
end

function var_0_0.getDefaultShipNameByGroupID(arg_3_0)
	return var_0_0.getDefaultShipConfig(arg_3_0).name
end

function var_0_0.IsBluePrintGroup(arg_4_0)
	return tobool(pg.ship_data_blueprint[arg_4_0])
end

function var_0_0.IsMetaGroup(arg_5_0)
	return tobool(pg.ship_strengthen_meta[arg_5_0])
end

function var_0_0.IsMotGroup(arg_6_0)
	return var_0_0.getDefaultShipConfig(arg_6_0).nationality == Nation.MOT
end

var_0_0.STATE_LOCK = 0
var_0_0.STATE_NOTGET = 1
var_0_0.STATE_UNLOCK = 2
var_0_0.ENABLE_SKIP_TO_CHAPTER = true

local var_0_1 = pg.ship_data_group

function var_0_0.getState(arg_7_0, arg_7_1, arg_7_2)
	if var_0_0.ENABLE_SKIP_TO_CHAPTER then
		if arg_7_2 and not arg_7_1 then
			return var_0_0.STATE_NOTGET
		end

		if var_0_1[arg_7_0] then
			local var_7_0 = var_0_1[arg_7_0]

			assert(var_0_1[arg_7_0].hide, "hide can not be nil in code " .. arg_7_0)

			if not var_7_0.hide then
				return var_0_0.STATE_LOCK
			end

			if var_7_0.hide == 1 then
				return var_0_0.STATE_LOCK
			elseif var_7_0.hide ~= 0 then
				assert(var_7_0.hide == 0 or var_7_0.hide == 1, "hide sign invalid in code " .. arg_7_0)

				return var_0_0.STATE_LOCK
			end
		end

		if arg_7_1 then
			return var_0_0.STATE_UNLOCK
		else
			local var_7_1 = var_0_1[arg_7_0]

			if not var_0_1[arg_7_0] then
				return var_0_0.STATE_LOCK
			end

			assert(var_7_1, "code can not be nil" .. arg_7_0)

			local var_7_2

			if var_7_1.redirect_id ~= 0 then
				var_7_2 = getProxy(ChapterProxy):getChapterById(var_7_1.redirect_id)
			end

			if var_7_1.redirect_id == 0 or var_7_2 and var_7_2:isClear() then
				return var_0_0.STATE_NOTGET
			else
				return var_0_0.STATE_LOCK
			end
		end

		goto label_7_0
	end

	::label_7_0::

	if arg_7_1 then
		do
			return var_0_0.STATE_UNLOCK or var_0_0.STATE_LOCK
		end

		return
	end
end

function var_0_0.Ctor(arg_8_0, arg_8_1)
	arg_8_0.id = arg_8_1.id
	arg_8_0.star = arg_8_1.star
	arg_8_0.hearts = arg_8_1.heart_count

	local var_8_0 = arg_8_1.heart_flag or 0

	arg_8_0.iheart = var_8_0 > 0
	arg_8_0.married = arg_8_1.marry_flag
	arg_8_0.maxIntimacy = arg_8_1.intimacy_max
	arg_8_0.maxLV = arg_8_1.lv_max
	arg_8_0.evaluation = nil
	arg_8_0.equipCodes = nil
	arg_8_0.lastReqStamp = 0
	arg_8_0.trans = false
	arg_8_0.remoulded = arg_8_1.remoulded

	assert(var_0_0.getDefaultShipConfig(arg_8_0.id), "can not find ship_data_statistics for group " .. arg_8_0.id)

	arg_8_0.shipConfig = setmetatable({}, {
		__index = function(arg_9_0, arg_9_1)
			return var_0[arg_9_1]
		end
	})

	assert(var_0_0.GetGroupConfig(arg_8_0.id), "can not find ship_data_group for group " .. arg_8_0.id)

	arg_8_0.groupConfig = setmetatable({}, {
		__index = function(arg_10_0, arg_10_1)
			return var_0[arg_10_1]
		end
	})

	return
end

function var_0_0.getName(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.shipConfig.name

	if arg_11_1 and arg_11_0.trans then
		var_11_0 = pg.ship_skin_template[arg_11_0.groupConfig.trans_skin].name
	end

	return var_11_0
end

function var_0_0.getNation(arg_12_0)
	return arg_12_0.shipConfig.nationality
end

function var_0_0.getRarity(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.shipConfig.rarity

	if arg_13_1 and arg_13_0.trans then
		var_13_0 = var_13_0 + 1
	end

	return var_13_0
end

function var_0_0.getTeamType(arg_14_0)
	return ShipType.GetTeamFromShipType(arg_14_0:getShipType())
end

function var_0_0.getPainting(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.shipConfig.skin_id

	if arg_15_1 and arg_15_0.trans then
		var_15_0 = arg_15_0.groupConfig.trans_skin
	end

	local var_15_1 = pg.ship_skin_template[var_15_0]

	assert(pg.ship_skin_template[var_15_0], "ship_skin_template not exist: " .. var_15_0)

	return var_15_1.painting
end

function var_0_0.getPaintingId(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.shipConfig.skin_id

	if arg_16_1 and arg_16_0.trans then
		var_16_0 = arg_16_0.groupConfig.trans_skin
	end

	return var_16_0
end

function var_0_0.getShipType(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.shipConfig.type

	if arg_17_1 and arg_17_0.trans then
		local var_17_1 = Ship.getTransformShipId(arg_17_0.shipConfig.id)

		if var_17_1 then
			var_17_0 = pg.ship_data_statistics[var_17_1].type
		end
	end

	return var_17_0
end

function var_0_0.getShipConfigId(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.shipConfig.id

	if arg_18_1 and arg_18_0.trans then
		local var_18_1 = Ship.getTransformShipId(arg_18_0.shipConfig.id)

		if var_18_1 then
			var_18_0 = pg.ship_data_statistics[var_18_1].id
		end
	end

	return var_18_0
end

function var_0_0.getSkinList(arg_19_0)
	return ShipSkin.GetAllSkinByGroup(arg_19_0)
end

function var_0_0.GetDisplayableSkinList(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(pg.ship_skin_template.all) do
		if pg.ship_skin_template[iter_20_1].ship_group == arg_20_0 and pg.ship_skin_template[iter_20_1].no_showing ~= "1" and not (function(arg_21_0)
			local var_21_0 = arg_21_0.skin_type ~= ShipSkin.SKIN_TYPE_OLD and (arg_21_0.skin_type == ShipSkin.SKIN_TYPE_NOT_HAVE_HIDE and not getProxy(ShipSkinProxy):hasSkin(arg_21_0.id) or false) or true

			return var_21_0
		end)(pg.ship_skin_template[iter_20_1]) and (function(arg_22_0)
			return getProxy(ShipSkinProxy):InShowTime(arg_22_0)
		end)(pg.ship_skin_template[iter_20_1].id) then
			table.insert({}, pg.ship_skin_template[iter_20_1])
		end
	end

	for iter_20_2 = #{}, 1, -1 do
		if ShipSkin.GetChangeSkinGroupId(({})[iter_20_2].id) and ShipSkin.GetChangeSkinIndex(({})[iter_20_2].id) ~= 1 then
			table.remove({}, iter_20_2)
		end
	end

	return {}
end

function var_0_0.getDefaultSkin(arg_23_0)
	return ShipSkin.GetSkinByType(arg_23_0, ShipSkin.SKIN_TYPE_DEFAULT)
end

function var_0_0.getProposeSkin(arg_24_0)
	return ShipSkin.GetSkinByType(arg_24_0, ShipSkin.SKIN_TYPE_PROPOSE)
end

function var_0_0.getModSkin(arg_25_0)
	if pg.ship_data_trans[arg_25_0] then
		return pg.ship_skin_template[pg.ship_data_trans[arg_25_0].skin_id]
	end

	return nil
end

function var_0_0.GetSkin(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return var_0_0.getDefaultSkin(arg_26_0.id)
	else
		return var_0_0.getModSkin(arg_26_0.id)
	end

	return
end

function var_0_0.updateMaxIntimacy(arg_27_0, arg_27_1)
	arg_27_0.maxIntimacy = math.max(arg_27_1, arg_27_0.maxIntimacy)

	return
end

function var_0_0.updateMarriedFlag(arg_28_0)
	arg_28_0.married = 1

	return
end

function var_0_0.IsMarried(arg_29_0)
	return arg_29_0.married == 1
end

function var_0_0.isBluePrintGroup(arg_30_0)
	return var_0_0.IsBluePrintGroup(arg_30_0.id)
end

function var_0_0.getBluePrintChangeSkillList(arg_31_0)
	assert(arg_31_0:isBluePrintGroup(), "ShipGroup " .. arg_31_0.id .. "isn't BluePrint")

	return pg.ship_data_blueprint[arg_31_0.id].change_skill
end

function var_0_0.GetNationTxt(arg_32_0)
	return Nation.Nation2facionName(arg_32_0.shipConfig.nationality) .. "-" .. Nation.Nation2Name(arg_32_0.shipConfig.nationality)
end

var_0_0.CONDITION_FORBIDDEN = -1
var_0_0.CONDITION_CLEAR = 0
var_0_0.CONDITION_INTIMACY = 1
var_0_0.CONDITION_MARRIED = 2

function var_0_0.VoiceReplayCodition(arg_33_0, arg_33_1)
	local var_33_0 = true
	local var_33_1 = ""

	if arg_33_0:isBluePrintGroup() then
		local var_33_2 = getProxy(TechnologyProxy):getBluePrintById(arg_33_0.id)

		assert(var_33_2, "blueprint can not be nil >>" .. arg_33_0.id)

		if not table.contains(var_33_2:getUnlockVoices(), arg_33_1.key) then
			local var_33_3 = var_33_2:getUnlockLevel(arg_33_1.key)

			if var_33_3 > 0 then
				var_33_0 = false

				local var_33_5 = i18n("ship_profile_voice_locked_design", var_33_3)

				return
			end
		end
	end

	if arg_33_0:isMetaGroup() then
		local var_33_6 = getProxy(BayProxy):getMetaShipByGroupId(arg_33_0.id):getMetaCharacter()

		if not table.contains(var_33_6:getUnlockedVoiceList(), arg_33_1.key) then
			local var_33_7 = var_33_6:getUnlockVoiceRepairPercent(arg_33_1.key)

			if var_33_7 > 0 then
				var_33_0 = false

				local var_33_9 = i18n("ship_profile_voice_locked_meta", var_33_7)

				return
			end
		end
	end

	if arg_33_1.unlock_condition[1] == var_0_0.CONDITION_INTIMACY then
		if arg_33_0.maxIntimacy < arg_33_1.unlock_condition[2] then
			var_33_0 = false
			var_33_1 = i18n("ship_profile_voice_locked_intimacy", math.floor(arg_33_1.unlock_condition[2] / 100))
		end
	elseif arg_33_1.unlock_condition[1] == var_0_0.CONDITION_MARRIED and arg_33_0.married == 0 then
		var_33_0 = false
		var_33_1 = arg_33_0:IsXIdol() and i18n("ship_profile_voice_locked_propose_imas") or i18n("ship_profile_voice_locked_propose")
	end

	return var_33_0, var_33_1
end

function var_0_0.GetMaxIntimacy(arg_34_0)
	local var_34_0 = arg_34_0.maxIntimacy / 100

	if arg_34_0.married then
		local var_34_1 = arg_34_0.married * 1000 or 0

		return var_34_0 + var_34_1
	end
end

function var_0_0.isSpecialFilter(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0.shipConfig.tag_list) do
		if iter_35_1 == "special" then
			return true
		end
	end

	return false
end

function var_0_0.getGroupId(arg_36_0)
	return arg_36_0.id
end

function var_0_0.isRemoulded(arg_37_0)
	return arg_37_0.remoulded
end

function var_0_0.isMetaGroup(arg_38_0)
	return var_0_0.IsMetaGroup(arg_38_0.id)
end

local var_0_2 = {
	feeling2 = true,
	feeling3 = true,
	feeling5 = true,
	propose = true,
	feeling4 = true,
	feeling1 = true
}

function var_0_0.getIntimacyName(arg_39_0, arg_39_1)
	if not var_0_2[arg_39_1] then
		return
	end

	if arg_39_0:isMetaGroup() then
		return i18n("meta_voice_name_" .. arg_39_1)
	elseif arg_39_0:IsXIdol() then
		return i18n("idolmaster_voice_name_" .. arg_39_1)
	end

	return
end

function var_0_0.getProposeType(arg_40_0)
	if arg_40_0:isMetaGroup() then
		return "meta"
	elseif arg_40_0:IsXIdol() then
		return "imas"
	else
		return "default"
	end

	return
end

function var_0_0.IsXIdol(arg_41_0)
	return arg_41_0:getNation() == Nation.IDOL_LINK
end

function var_0_0.CanUseShareSkin(arg_42_0)
	return arg_42_0.groupConfig.share_group_id and #arg_42_0.groupConfig.share_group_id > 0
end

function var_0_0.rarity2bgPrint(arg_43_0, arg_43_1)
	return shipRarity2bgPrint(arg_43_0:getRarity(arg_43_1), arg_43_0:isBluePrintGroup(), arg_43_0:isMetaGroup())
end

function var_0_0.rarity2bgPrintForGet(arg_44_0, arg_44_1, arg_44_2)
	return skinId2bgPrint(arg_44_2 or arg_44_0:GetSkin(arg_44_1).id) or arg_44_0:rarity2bgPrint(arg_44_1)
end

function var_0_0.setEquipCodes(arg_45_0, arg_45_1)
	arg_45_0.equipCodes = arg_45_1

	return
end

function var_0_0.getEquipCodes(arg_46_0)
	return arg_46_0.equipCodes
end

return var_0_0
