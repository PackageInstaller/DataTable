class = var_0_10000

local var_0_0 = "ShipGroup"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

var_0_1.REQ_INTERVAL = 60

function var_0_1.GetGroupConfig(arg_1_0)
	checkExist = var_1_10001
	pg = var_1_10002

	if var_1_10001(var_1_10002.ship_data_group.get_id_list_by_group_type[arg_1_0], {
		1
	}) then
		pg = var_2

		local var_1_0

		if not var_2.ship_data_group[var_1] then
			var_1_0 = nil
		end

		return var_1_0
	end
end

function var_0_1.getDefaultShipConfig(arg_2_0)
	pg = var_1_10001

	return var_1_10001.ship_data_statistics[arg_2_0 * 10 + 1]
end

function var_0_1.getDefaultShipNameByGroupID(arg_3_0)
	return var_0_1.getDefaultShipConfig(arg_3_0).name
end

function var_0_1.IsBluePrintGroup(arg_4_0)
	tobool = var_1_10001
	pg = var_1_10002

	return var_1_10001(var_1_10002.ship_data_blueprint[arg_4_0])
end

function var_0_1.IsMetaGroup(arg_5_0)
	tobool = var_1_10001
	pg = var_1_10002

	return var_1_10001(var_1_10002.ship_strengthen_meta[arg_5_0])
end

function var_0_1.IsMotGroup(arg_6_0)
	local var_6_0 = var_0_1.getDefaultShipConfig(arg_6_0).nationality

	Nation = var_1_10003

	return var_6_0 == var_1_10003.MOT
end

var_0_1.STATE_LOCK = 0
var_0_1.STATE_NOTGET = 1
var_0_1.STATE_UNLOCK = 2
var_0_1.ENABLE_SKIP_TO_CHAPTER = true
pg = var_1

local var_0_2 = var_1.ship_data_group

function var_0_1.getState(arg_7_0, arg_7_1, arg_7_2)
	if var_0_1.ENABLE_SKIP_TO_CHAPTER then
		if arg_7_2 and not arg_7_1 then
			return var_0_1.STATE_NOTGET
		end

		if var_0_2[arg_7_0] then
			local var_7_0 = var_0_2[arg_7_0]

			assert = var_1_10004

			var_1_10004(var_7_0.hide, "hide can not be nil in code " .. arg_7_0)

			if not var_7_0.hide then
				return var_0_1.STATE_LOCK
			end

			if var_7_0.hide == 1 then
				return var_0_1.STATE_LOCK
			elseif var_7_0.hide ~= 0 then
				assert = var_1_10004

				var_1_10004(var_7_0.hide == 0 or var_7_0.hide == 1, "hide sign invalid in code " .. arg_7_0)

				return var_0_1.STATE_LOCK
			end
		end

		if arg_7_1 then
			return var_0_1.STATE_UNLOCK
		else
			if not var_0_2[arg_7_0] then
				return var_0_1.STATE_LOCK
			end

			assert = var_1_10004

			var_1_10004(var_3, "code can not be nil" .. arg_7_0)

			local var_7_1 = var_3.redirect_id

			getProxy = var_5
			ChapterProxy = var_6

			local var_7_2 = var_5(var_6)
			local var_7_3

			if var_7_1 ~= 0 then
				var_7_3 = var_7_2:getChapterById(var_7_1)
			end

			if var_7_1 == 0 or var_7_3 and var_7_3:isClear() then
				return var_0_1.STATE_NOTGET
			else
				return var_0_1.STATE_LOCK
			end
		end
	else
		local var_7_4

		if not arg_7_1 or not var_0_1.STATE_UNLOCK then
			var_7_4 = var_0_1.STATE_LOCK
		end

		return var_7_4
	end

	return
end

function var_0_1.Ctor(arg_8_0, arg_8_1)
	arg_8_0.id = arg_8_1.id
	arg_8_0.star = arg_8_1.star
	arg_8_0.hearts = arg_8_1.heart_count

	local var_8_0

	if not arg_8_1.heart_flag then
		var_8_0 = 0
	end

	arg_8_0.iheart = var_8_0 > 0
	arg_8_0.married = arg_8_1.marry_flag
	arg_8_0.maxIntimacy = arg_8_1.intimacy_max
	arg_8_0.maxLV = arg_8_1.lv_max
	arg_8_0.evaluation = nil
	arg_8_0.equipCodes = nil
	arg_8_0.lastReqStamp = 0
	arg_8_0.trans = false
	arg_8_0.remoulded = arg_8_1.remoulded

	local var_8_1 = var_0_1.getDefaultShipConfig(arg_8_0.id)

	assert = var_3

	var_3(var_8_1, "can not find ship_data_statistics for group " .. arg_8_0.id)

	setmetatable = var_3
	arg_8_0.shipConfig = var_3({}, {
		__index = function(arg_9_0, arg_9_1)
			return var_8_1[arg_9_1]
		end
	})

	local var_8_2 = var_0_1.GetGroupConfig(arg_8_0.id)

	assert = var_4

	var_4(var_8_2, "can not find ship_data_group for group " .. arg_8_0.id)

	setmetatable = var_4
	arg_8_0.groupConfig = var_4({}, {
		__index = function(arg_10_0, arg_10_1)
			return var_8_2[arg_10_1]
		end
	})

	return
end

function var_0_1.getName(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.shipConfig.name

	if arg_11_1 and arg_11_0.trans then
		local var_11_1 = arg_11_0.groupConfig.trans_skin

		pg = var_1_10004
		var_11_0 = var_1_10004.ship_skin_template[var_11_1].name
	end

	return var_11_0
end

function var_0_1.getNation(arg_12_0)
	return arg_12_0.shipConfig.nationality
end

function var_0_1.getRarity(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.shipConfig.rarity

	if arg_13_1 and arg_13_0.trans then
		var_13_0 = var_13_0 + 1
	end

	return var_13_0
end

function var_0_1.getTeamType(arg_14_0)
	ShipType = var_1_10001

	return var_1_10001.GetTeamFromShipType(arg_14_0:getShipType())
end

function var_0_1.getPainting(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0.shipConfig.skin_id

	if arg_15_1 and arg_15_0.trans then
		var_15_0 = arg_15_0.groupConfig.trans_skin
	end

	pg = var_1_10003

	local var_15_1 = var_1_10003.ship_skin_template[var_15_0]

	assert = var_1_10004

	var_1_10004(var_15_1, "ship_skin_template not exist: " .. var_15_0)

	return var_15_1.painting
end

function var_0_1.getPaintingId(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.shipConfig.skin_id

	if arg_16_1 and arg_16_0.trans then
		var_16_0 = arg_16_0.groupConfig.trans_skin
	end

	return var_16_0
end

function var_0_1.getShipType(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.shipConfig.type

	if arg_17_1 and arg_17_0.trans then
		Ship = var_3

		if var_3.getTransformShipId(arg_17_0.shipConfig.id) then
			pg = var_4
			var_17_0 = var_4.ship_data_statistics[var_3].type
		end
	end

	return var_17_0
end

function var_0_1.getShipConfigId(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.shipConfig.id

	if arg_18_1 and arg_18_0.trans then
		Ship = var_3

		if var_3.getTransformShipId(arg_18_0.shipConfig.id) then
			pg = var_4
			var_18_0 = var_4.ship_data_statistics[var_3].id
		end
	end

	return var_18_0
end

function var_0_1.getSkinList(arg_19_0)
	ShipSkin = var_1_10001

	return var_1_10001.GetAllSkinByGroup(arg_19_0)
end

function var_0_1.GetDisplayableSkinList(arg_20_0)
	local var_20_0 = {}

	local function var_20_1(arg_21_0)
		local var_21_0 = arg_21_0.skin_type

		ShipSkin = var_2_10002

		local var_21_3

		if var_21_0 ~= var_2_10002.SKIN_TYPE_OLD then
			local var_21_1 = arg_21_0.skin_type

			ShipSkin = var_2

			if var_21_1 == var_2.SKIN_TYPE_NOT_HAVE_HIDE then
				getProxy = var_21_1
				ShipSkinProxy = var_2

				local var_21_2 = var_21_1(var_2)

				var_21_3 = not var_1.hasSkin(var_21_2, arg_21_0.id)
			else
				var_21_3 = false
			end
		else
			var_21_3 = true
		end

		return var_21_3
	end

	local function var_20_2(arg_22_0)
		getProxy = var_2_10001
		ShipSkinProxy = var_2_10002

		local var_22_0 = var_2_10001(var_2_10002)

		return var_1.InShowTime(var_22_0, arg_22_0)
	end

	ipairs = var_1_10004
	pg = var_1_10005

	for iter_20_0, iter_20_1 in var_1_10004(var_1_10005.ship_skin_template.all) do
		pg = var_1_10009

		if var_1_10009.ship_skin_template[iter_20_1].ship_group == arg_20_0 and var_1_10009.no_showing ~= "1" and not var_20_1(var_1_10009) and var_20_2(var_1_10009.id) then
			table = var_10

			var_10.insert(var_20_0, var_1_10009)
		end
	end

	for iter_20_2 = #var_20_0, 1, -1 do
		local var_20_3 = var_20_0[iter_20_2]

		ShipSkin = var_1_10009

		if var_1_10009.GetChangeSkinGroupId(var_20_3.id) then
			ShipSkin = var_10

			if var_10.GetChangeSkinIndex(var_20_3.id) ~= 1 then
				table = var_11

				var_11.remove(var_20_0, iter_20_2)
			end
		end
	end

	return var_20_0
end

function var_0_1.getDefaultSkin(arg_23_0)
	ShipSkin = var_1_10001

	local var_23_0 = var_1_10001.GetSkinByType
	local var_23_1 = arg_23_0

	ShipSkin = var_1_10003

	return var_23_0(var_23_1, var_1_10003.SKIN_TYPE_DEFAULT)
end

function var_0_1.getProposeSkin(arg_24_0)
	ShipSkin = var_1_10001

	local var_24_0 = var_1_10001.GetSkinByType
	local var_24_1 = arg_24_0

	ShipSkin = var_1_10003

	return var_24_0(var_24_1, var_1_10003.SKIN_TYPE_PROPOSE)
end

function var_0_1.getModSkin(arg_25_0)
	pg = var_1_10001

	if var_1_10001.ship_data_trans[arg_25_0] then
		pg = var_1_10002

		return var_1_10002.ship_skin_template[var_1.skin_id]
	end

	return nil
end

function var_0_1.GetSkin(arg_26_0, arg_26_1)
	if not arg_26_1 then
		return var_0_1.getDefaultSkin(arg_26_0.id)
	else
		return var_0_1.getModSkin(arg_26_0.id)
	end

	return
end

function var_0_1.updateMaxIntimacy(arg_27_0, arg_27_1)
	math = var_1_10002
	arg_27_0.maxIntimacy = var_1_10002.max(arg_27_1, arg_27_0.maxIntimacy)

	return
end

function var_0_1.updateMarriedFlag(arg_28_0)
	arg_28_0.married = 1

	return
end

function var_0_1.IsMarried(arg_29_0)
	return arg_29_0.married == 1
end

function var_0_1.isBluePrintGroup(arg_30_0)
	return var_0_1.IsBluePrintGroup(arg_30_0.id)
end

function var_0_1.getBluePrintChangeSkillList(arg_31_0)
	assert = var_1_10001

	var_1_10001(arg_31_0:isBluePrintGroup(), "ShipGroup " .. arg_31_0.id .. "isn't BluePrint")

	pg = var_1_10001

	return var_1_10001.ship_data_blueprint[arg_31_0.id].change_skill
end

function var_0_1.GetNationTxt(arg_32_0)
	local var_32_0 = arg_32_0.shipConfig.nationality

	Nation = var_1_10002

	local var_32_1 = var_1_10002.Nation2facionName(var_32_0)
	local var_32_2 = "-"

	Nation = var_1_10004

	return var_32_1 .. var_32_2 .. var_1_10004.Nation2Name(var_32_0)
end

var_0_1.CONDITION_FORBIDDEN = -1
var_0_1.CONDITION_CLEAR = 0
var_0_1.CONDITION_INTIMACY = 1
var_0_1.CONDITION_MARRIED = 2

function var_0_1.VoiceReplayCodition(arg_33_0, arg_33_1)
	local var_33_0 = true
	local var_33_1 = ""
	local var_33_2 = arg_33_0

	if arg_33_0.isBluePrintGroup(var_33_2) then
		getProxy = var_4
		TechnologyProxy = var_33_2

		local var_33_3 = var_4(var_33_2)
		local var_33_4 = var_4.getBluePrintById(var_33_3, arg_33_0.id)

		assert = var_33_3

		var_33_3(var_33_4, "blueprint can not be nil >>" .. arg_33_0.id)

		var_1_10006 = var_33_4

		local var_33_5 = var_33_4.getUnlockVoices(var_1_10006)

		table = var_1_10006

		if not var_1_10006.contains(var_33_5, arg_33_1.key) and var_33_4:getUnlockLevel(arg_33_1.key) > 0 then
			local var_33_6 = false

			i18n = var_8

			local var_33_7 = var_8("ship_profile_voice_locked_design", var_1_10006)

			return
		end
	end

	local var_33_8 = arg_33_0

	if arg_33_0.isMetaGroup(var_33_8) then
		getProxy = var_4
		BayProxy = var_33_8

		local var_33_9 = var_4(var_33_8)

		var_1_10006 = var_4.getMetaShipByGroupId(var_33_9, arg_33_0.id)

		local var_33_10 = var_4.getMetaCharacter(var_1_10006)

		var_1_10006 = var_5.getUnlockedVoiceList(var_33_10)
		table = var_33_10

		if not var_33_10.contains(var_1_10006, arg_33_1.key) and var_5:getUnlockVoiceRepairPercent(arg_33_1.key) > 0 then
			local var_33_11 = false

			i18n = var_9

			local var_33_12 = var_9("ship_profile_voice_locked_meta", var_7)

			return
		end
	end

	if arg_33_1.unlock_condition[1] == var_0_1.CONDITION_INTIMACY then
		if arg_33_0.maxIntimacy < arg_33_1.unlock_condition[2] then
			var_33_0 = false
			i18n = var_4

			local var_33_13 = "ship_profile_voice_locked_intimacy"

			math = var_1_10006
			var_33_1 = var_4(var_33_13, var_1_10006.floor(arg_33_1.unlock_condition[2] / 100))
		end
	elseif arg_33_1.unlock_condition[1] == var_0_1.CONDITION_MARRIED and arg_33_0.married == 0 then
		var_33_0 = false

		if arg_33_0:IsXIdol() then
			i18n = var_4
			var_33_1 = var_4("ship_profile_voice_locked_propose_imas")
		else
			i18n = var_4
			var_33_1 = var_4("ship_profile_voice_locked_propose")
		end
	end

	return var_33_0, var_33_1
end

function var_0_1.GetMaxIntimacy(arg_34_0)
	local var_34_0 = arg_34_0.maxIntimacy / 100
	local var_34_1

	if not arg_34_0.married or not (arg_34_0.married * 1000) then
		var_34_1 = 0
	end

	return var_34_0 + var_34_1
end

function var_0_1.isSpecialFilter(arg_35_0)
	ipairs = var_1_10001

	for iter_35_0, iter_35_1 in var_1_10001(arg_35_0.shipConfig.tag_list) do
		if iter_35_1 == "special" then
			return true
		end
	end

	return false
end

function var_0_1.getGroupId(arg_36_0)
	return arg_36_0.id
end

function var_0_1.isRemoulded(arg_37_0)
	return arg_37_0.remoulded
end

function var_0_1.isMetaGroup(arg_38_0)
	return var_0_1.IsMetaGroup(arg_38_0.id)
end

local var_0_3 = {
	feeling2 = true,
	feeling3 = true,
	feeling5 = true,
	propose = true,
	feeling4 = true,
	feeling1 = true
}

function var_0_1.getIntimacyName(arg_39_0, arg_39_1)
	if not var_0_3[arg_39_1] then
		return
	end

	if arg_39_0:isMetaGroup() then
		i18n = var_2

		return var_2("meta_voice_name_" .. arg_39_1)
	elseif arg_39_0:IsXIdol() then
		i18n = var_2

		return var_2("idolmaster_voice_name_" .. arg_39_1)
	end

	return
end

function var_0_1.getProposeType(arg_40_0)
	if arg_40_0:isMetaGroup() then
		return "meta"
	elseif arg_40_0:IsXIdol() then
		return "imas"
	else
		return "default"
	end

	return
end

function var_0_1.IsXIdol(arg_41_0)
	local var_41_0 = arg_41_0
	local var_41_1 = arg_41_0.getNation(var_41_0)

	Nation = var_41_0

	return var_41_1 == var_41_0.IDOL_LINK
end

function var_0_1.CanUseShareSkin(arg_42_0)
	local var_42_0

	if arg_42_0.groupConfig.share_group_id then
		var_42_0 = #arg_42_0.groupConfig.share_group_id > 0
	end

	return var_42_0
end

function var_0_1.rarity2bgPrint(arg_43_0, arg_43_1)
	shipRarity2bgPrint = var_1_10002

	return var_1_10002(arg_43_0:getRarity(arg_43_1), arg_43_0:isBluePrintGroup(), arg_43_0:isMetaGroup())
end

function var_0_1.rarity2bgPrintForGet(arg_44_0, arg_44_1, arg_44_2)
	skinId2bgPrint = var_1_10003

	local var_44_0

	if not var_1_10003(arg_44_2 or arg_44_0:GetSkin(arg_44_1).id) then
		var_44_0 = arg_44_0:rarity2bgPrint(arg_44_1)
	end

	return var_44_0
end

function var_0_1.setEquipCodes(arg_45_0, arg_45_1)
	arg_45_0.equipCodes = arg_45_1

	return
end

function var_0_1.getEquipCodes(arg_46_0)
	return arg_46_0.equipCodes
end

return var_0_1
