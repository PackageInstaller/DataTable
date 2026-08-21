local var_0_0 = class("ShipSkin", import(".BaseVO"))

var_0_0.SKIN_TYPE_DEFAULT = -1
var_0_0.SKIN_TYPE_COMMON_FASHION = 0
var_0_0.SKIN_TYPE_PROPOSE = 1
var_0_0.SKIN_TYPE_REMAKE = 2
var_0_0.SKIN_TYPE_OLD = 3
var_0_0.SKIN_TYPE_NOT_HAVE_HIDE = 4
var_0_0.SKIN_TYPE_SHOW_IN_TIME = 5
var_0_0.SKIN_TYPE_TB = 6
var_0_0.WITH_LIVE2D = 1
var_0_0.WITH_BG = 2
var_0_0.WITH_EFFECT = 3
var_0_0.WITH_DYNAMIC_BG = 4
var_0_0.WITH_BGM = 5
var_0_0.WITH_SPINE = 6
var_0_0.WITH_SPINE_PLUS = 7
var_0_0.WITH_CHANGE = 8
var_0_0.WITH_LIVE2D_PLUS = 9
var_0_0.WITH_DOUBLE_VIOCE = 10
var_0_0.WITH_ASMR = 11
var_0_0.VOICE_LANG_JP = 1
var_0_0.VOICE_LANG_CN = 2

function var_0_0.Tag2Name(arg_1_0)
	var_0_0.Tag2NameTab = var_0_0.Tag2NameTab or {
		[var_0_0.WITH_BG] = "bg",
		[var_0_0.WITH_BGM] = "bgm",
		[var_0_0.WITH_DYNAMIC_BG] = "dtbg",
		[var_0_0.WITH_EFFECT] = "effect",
		[var_0_0.WITH_LIVE2D] = "live2d",
		[var_0_0.WITH_SPINE] = "spine",
		[var_0_0.WITH_SPINE_PLUS] = "spine_plus",
		[var_0_0.WITH_CHANGE] = "change",
		[var_0_0.WITH_LIVE2D_PLUS] = "live2d_plus",
		[var_0_0.WITH_DOUBLE_VIOCE] = "double_voice",
		[var_0_0.WITH_ASMR] = "asmr_skin"
	}

	return var_0_0.Tag2NameTab[arg_1_0]
end

function var_0_0.GetShopTypeIdBySkinId(arg_2_0, arg_2_1)
	if arg_2_1[arg_2_0] then
		return arg_2_1[arg_2_0]
	end

	for iter_2_0, iter_2_1 in pairs(pg.ship_skin_template.get_id_list_by_shop_type_id) do
		for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
			arg_2_1[iter_2_3] = iter_2_0

			if iter_2_3 == arg_2_0 then
				return iter_2_0
			end
		end
	end

	return
end

local var_0_1 = pg.ship_skin_template.get_id_list_by_ship_group

function var_0_0.GetSkinByType(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1[arg_3_0] or {}

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if pg.ship_skin_template[iter_3_1].skin_type == arg_3_1 then
			return pg.ship_skin_template[iter_3_1]
		end
	end

	return
end

function var_0_0.GetAllSkinByGroup(arg_4_0)
	local var_4_0 = var_0_1[arg_4_0] or {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if pg.ship_skin_template[iter_4_1].no_showing ~= "1" then
			table.insert({}, pg.ship_skin_template[iter_4_1])
		end
	end

	return {}
end

function var_0_0.GetShareSkinsByGroupId(arg_5_0)
	if not pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[arg_5_0][1]].share_group_id or #pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[arg_5_0][1]].share_group_id <= 0 then
		return {}
	end

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[arg_5_0][1]].share_group_id) do
		for iter_5_2, iter_5_3 in ipairs(pg.ship_skin_template.get_id_list_by_ship_group[iter_5_1]) do
			local var_5_1 = ShipSkin.New({
				id = iter_5_3
			})

			if (function(arg_6_0)
				local var_6_0 = arg_6_0:getConfig("skin_type")

				return not (var_6_0 == var_0_0.SKIN_TYPE_DEFAULT or var_6_0 == var_0_0.SKIN_TYPE_REMAKE or var_6_0 == var_0_0.SKIN_TYPE_OLD)
			end)(var_5_1) then
				table.insert(var_5_0, var_5_1)
			end
		end
	end

	return var_5_0
end

function var_0_0.Ctor(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1.id
	arg_7_0.configId = arg_7_1.id
	arg_7_0.endTime = arg_7_1.end_time or arg_7_1.time or 0

	local var_7_0 = ShipGroup.getDefaultShipConfig((arg_7_0:getConfig("ship_group")))

	if arg_7_0:getConfig("skin_type") == var_0_0.SKIN_TYPE_TB then
		arg_7_0.shipName = NewEducateHelper.GetShipNameBySecId(NewEducateHelper.GetSecIdBySkinId(arg_7_0.id))

		goto label_7_0
	end

	::label_7_0::

	if var_7_0 then
		arg_7_0.shipName = var_7_0.name or ""
		arg_7_0.skinName = arg_7_0:getConfig("name")

		return
	end
end

function var_0_0.bindConfigTable(arg_8_0)
	return pg.ship_skin_template
end

function var_0_0.isExpireType(arg_9_0)
	return arg_9_0.endTime > 0
end

function var_0_0.getExpireTime(arg_10_0)
	return arg_10_0.endTime
end

function var_0_0.isExpired(arg_11_0)
	local var_11_0 = pg.TimeMgr.GetInstance()

	return var_11_0:GetServerTime() >= arg_11_0.endTime
end

function var_0_0.getRemainTime(arg_12_0)
	return arg_12_0:getExpireTime() - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.getIcon(arg_13_0)
	return arg_13_0:getConfig("painting")
end

function var_0_0.InShowTime(arg_14_0)
	return getProxy(ShipSkinProxy):InShowTime(arg_14_0.id)
end

function var_0_0.IsDefault(arg_15_0)
	return arg_15_0:getConfig("skin_type") == var_0_0.SKIN_TYPE_DEFAULT
end

function var_0_0.IsType(arg_16_0, arg_16_1)
	return arg_16_0:getConfig("shop_type_id") == arg_16_1
end

function var_0_0.IsMatchKey(arg_17_0, arg_17_1)
	if not arg_17_1 or arg_17_1 == "" then
		return true
	end

	arg_17_1 = string.lower(string.gsub(arg_17_1, "%.", "%%."))
	arg_17_1 = string.lower(string.gsub(arg_17_1, "%-", "%%-"))

	return string.find(string.lower(arg_17_0.shipName), arg_17_1) or string.find(string.lower(arg_17_0.skinName), arg_17_1)
end

function var_0_0.ToShip(arg_18_0)
	local var_18_0 = ShipGroup.getDefaultShipConfig((arg_18_0:getConfig("ship_group")))

	if var_18_0 then
		return Ship.New({
			id = 1,
			intimacy = 10000,
			template_id = var_18_0.id,
			skin_id = arg_18_0.id
		})
	else
		return nil
	end

	return
end

function var_0_0.GetDefaultShipConfig(arg_19_0)
	return (ShipGroup.getDefaultShipConfig((arg_19_0:getConfig("ship_group"))))
end

function var_0_0.IsLive2d(arg_20_0)
	arg_20_0.isLive2dTag = arg_20_0.isLive2dTag or table.contains(arg_20_0:getConfig("tag"), var_0_0.WITH_LIVE2D)

	return arg_20_0.isLive2dTag
end

function var_0_0.IsDbg(arg_21_0)
	arg_21_0.isDGBTag = arg_21_0.isDGBTag or table.contains(arg_21_0:getConfig("tag"), var_0_0.WITH_DYNAMIC_BG)

	return arg_21_0.isDGBTag
end

function var_0_0.IsBG(arg_22_0)
	arg_22_0.isBGTag = arg_22_0.isBGTag or table.contains(arg_22_0:getConfig("tag"), var_0_0.WITH_BG)

	return arg_22_0.isBGTag
end

function var_0_0.IsEffect(arg_23_0)
	arg_23_0.isEffectTag = arg_23_0.isEffectTag or table.contains(arg_23_0:getConfig("tag"), var_0_0.WITH_EFFECT)

	return arg_23_0.isEffectTag
end

function var_0_0.isBgm(arg_24_0)
	arg_24_0.isBgmTag = arg_24_0.isBgmTag or table.contains(arg_24_0:getConfig("tag"), var_0_0.WITH_BGM)

	return arg_24_0.isBgmTag
end

function var_0_0.IsSpine(arg_25_0)
	arg_25_0.isSpine = arg_25_0.isSpine or table.contains(arg_25_0:getConfig("tag"), var_0_0.WITH_SPINE)

	return arg_25_0.isSpine
end

function var_0_0.IsSpinePlus(arg_26_0)
	arg_26_0.isSpinePlus = arg_26_0.isSpinePlus or table.contains(arg_26_0:getConfig("tag"), var_0_0.WITH_SPINE_PLUS)

	return arg_26_0.isSpinePlus
end

function var_0_0.IsLive2dPlus(arg_27_0)
	arg_27_0.isLive2dPlusTag = arg_27_0.isLive2dPlusTag or table.contains(arg_27_0:getConfig("tag"), var_0_0.WITH_LIVE2D_PLUS)

	return arg_27_0.isLive2dPlusTag
end

function var_0_0.CantUse(arg_28_0)
	local var_28_0 = arg_28_0:getConfig("ship_group")
	local var_28_1 = getProxy(BayProxy)
	local var_28_2 = getProxy(CollectionProxy).shipGroups[var_28_0] == nil

	return not var_28_1:_ExistGroupShip(var_28_0, arg_28_0:IsTransSkin(), (arg_28_0:IsProposeSkin())) or var_28_2
end

function var_0_0.OwnShip(arg_29_0)
	return (getProxy(BayProxy):_ExistGroupShip(arg_29_0:getConfig("ship_group"), arg_29_0:IsTransSkin(), (arg_29_0:IsProposeSkin())))
end

function var_0_0.WithoutUse(arg_30_0)
	local var_30_0 = getProxy(BayProxy):CanUseShareSkinPhantoms(arg_30_0.id)

	return #var_30_0 > 0 and underscore.all(var_30_0, function(arg_31_0)
		return arg_31_0:getSkinId() ~= arg_30_0.id and not var_0_0.IsSameChangeSkinGroup(arg_31_0:getSkinId(), arg_30_0.id)
	end)
end

function var_0_0.NoUse(arg_32_0)
	local var_32_0 = getProxy(BayProxy):CanUseShareSkinPhantoms(arg_32_0.id)

	return #var_32_0 == 0 or #var_32_0 > 0 and underscore.all(var_32_0, function(arg_33_0)
		return arg_33_0:getSkinId() ~= arg_32_0.id and not var_0_0.IsSameChangeSkinGroup(arg_33_0:getSkinId(), arg_32_0.id)
	end)
end

function var_0_0.ExistShip(arg_34_0)
	return pg.ship_data_statistics[tonumber(arg_34_0:getConfig("ship_group") .. 1)] ~= nil
end

function var_0_0.IsTransSkin(arg_35_0)
	return arg_35_0:getConfig("skin_type") == var_0_0.SKIN_TYPE_REMAKE
end

function var_0_0.IsProposeSkin(arg_36_0)
	return arg_36_0:getConfig("skin_type") == var_0_0.SKIN_TYPE_PROPOSE
end

function var_0_0.IsHxDynamicPreview(arg_37_0)
	if HXSet.isHx() then
		return arg_37_0:getConfig("shop_dynamic_hx") == 1
	end

	return false
end

function var_0_0.IsChangeSkinMainIndex(arg_38_0)
	if var_0_0.IsChangeSkin(arg_38_0.id) then
		return arg_38_0:getConfig("change_skin").index == 1
	end

	return false
end

function var_0_0.MatchChangeSkinMain(arg_39_0)
	if var_0_0.IsChangeSkin(arg_39_0.id) and not arg_39_0:IsChangeSkinMainIndex() then
		return false
	end

	return true
end

function var_0_0.CanShare(arg_40_0)
	local var_40_0 = getProxy(ShipSkinProxy):hasSkin(arg_40_0.configId)
	local var_40_3 = arg_40_0:getConfig("skin_type")

	return not (var_40_3 == var_0_0.SKIN_TYPE_DEFAULT or var_40_3 == var_0_0.SKIN_TYPE_REMAKE or var_40_3 == var_0_0.SKIN_TYPE_OLD or var_40_3 == var_0_0.SKIN_TYPE_NOT_HAVE_HIDE and not var_40_0 or var_40_3 == var_0_0.SKIN_TYPE_SHOW_IN_TIME and not var_40_1())
end

function var_0_0.CanShareInJuus(arg_43_0)
	local var_43_0 = getProxy(ShipSkinProxy):hasSkin(arg_43_0.configId)
	local var_43_1 = arg_43_0:getConfig("skin_type")

	return not (var_43_1 == var_0_0.SKIN_TYPE_REMAKE or var_43_1 == var_0_0.SKIN_TYPE_OLD or var_43_1 == var_0_0.SKIN_TYPE_NOT_HAVE_HIDE and not var_43_0 or var_43_1 == var_0_0.SKIN_TYPE_SHOW_IN_TIME and not var_43_0)
end

function var_0_0.IsShareSkin(arg_44_0, arg_44_1)
	return table.contains(pg.ship_data_group[pg.ship_data_group.get_id_list_by_group_type[arg_44_0.groupId][1]].share_group_id, pg.ship_skin_template[arg_44_1].ship_group)
end

function var_0_0.CanUseShareSkinForShip(arg_45_0, arg_45_1)
	local var_45_0 = var_0_0.IsShareSkin(arg_45_0, arg_45_1)
	local var_45_1 = ShipSkin.New({
		id = arg_45_1
	})
	local var_45_2 = false
	local var_45_3 = var_45_1:CanShare()
	local var_45_4 = var_45_1:IsProposeSkin()

	if var_45_3 and var_45_4 and arg_45_0.propose then
		var_45_2 = true
	elseif var_45_3 and not var_45_4 then
		var_45_2 = math.floor(arg_45_0:getIntimacy() / 100) >= arg_45_0:GetNoProposeIntimacyMax()
	end

	return var_45_0 and var_45_2
end

function var_0_0.ExistReward(arg_46_0)
	local var_46_0 = pg.ship_skin_reward[arg_46_0.configId]

	return pg.ship_skin_reward[arg_46_0.configId] ~= nil and #var_46_0.reward > 0
end

function var_0_0.GetRewardList(arg_47_0)
	if not arg_47_0:ExistReward() then
		return {}
	end

	for iter_47_0, iter_47_1 in pairs(pg.ship_skin_reward[arg_47_0.configId].reward) do
		table.insert({}, {
			type = iter_47_1[1],
			id = iter_47_1[2],
			count = iter_47_1[3]
		})
	end

	return {}
end

function var_0_0.GetRewardListDesc(arg_48_0)
	local var_48_0 = arg_48_0:GetRewardList()

	if #var_48_0 <= 0 then
		return ""
	end

	return getDropInfo((_.map(var_48_0, function(arg_49_0)
		return {
			arg_49_0.type,
			arg_49_0.id,
			arg_49_0.count
		}
	end)))
end

function var_0_0.GetShareGroupIds(arg_50_0)
	local var_50_0 = arg_50_0:getConfig("ship_group")

	if pg.ship_data_group.get_id_list_by_group_type[var_50_0] then
		local var_50_1 = pg.ship_data_group.get_id_list_by_group_type[var_50_0][1] or nil

		if var_50_1 then
			local var_50_4 = pg.ship_data_group[var_50_1].share_group_id or {}
			local var_50_5 = var_50_3(var_50_4)
		end
	end
end

function var_0_0.GetAllChangeSkinIds(arg_51_0)
	if not var_0_0.GetChangeSkinMainId(arg_51_0) then
		return {
			arg_51_0
		}
	end

	;({})[1] = var_0_0.GetChangeSkinMainId(arg_51_0)

	local var_51_0 = arg_51_0

	for iter_51_0 = 1, 10 do
		local var_51_1 = var_0_0.GetChangeSkinNextId(arg_51_0)

		if not table.contains({}, var_51_1) then
			table.insert({}, var_51_1)
		end

		var_51_0 = var_51_1

		if var_0_0.GetChangeSkinIndex(var_51_1) == 1 then
			return {}
		end
	end

	return {}
end

function var_0_0.IsChangeSkin(arg_52_0)
	if not pg.ship_skin_template[arg_52_0] then
		warning("skin not exist " .. arg_52_0)
	end

	return table.contains(pg.ship_skin_template[arg_52_0].tag, var_0_0.WITH_CHANGE) or table.contains(pg.ship_skin_template[arg_52_0].tag, var_0_0.WITH_DOUBLE_VIOCE) or table.contains(pg.ship_skin_template[arg_52_0].tag, var_0_0.WITH_ASMR)
end

function var_0_0.GetChangeSkinMainId(arg_53_0)
	if not var_0_0.IsChangeSkin(arg_53_0) then
		return arg_53_0
	end

	while var_0_0.GetChangeSkinIndex(arg_53_0) ~= 1 do
		arg_53_0 = var_0_0.GetChangeSkinNextId(arg_53_0)
	end

	return arg_53_0
end

function var_0_0.GetChangeSkinData(arg_54_0)
	if not var_0_0.IsChangeSkin(arg_54_0) then
		return nil
	end

	local var_54_0 = pg.ship_skin_template[arg_54_0]

	if pg.ship_skin_template[arg_54_0] and var_54_0.change_skin and var_54_0.change_skin ~= "" then
		return var_54_0.change_skin
	end

	return nil
end

function var_0_0.IsSameChangeSkinGroup(arg_55_0, arg_55_1)
	if not var_0_0.IsChangeSkin(arg_55_0) or not var_0_0.IsChangeSkin(arg_55_1) then
		return false
	end

	return var_0_0.GetChangeSkinGroupId(arg_55_0) == var_0_0.GetChangeSkinGroupId(arg_55_1)
end

function var_0_0.GetChangeSkinGroupId(arg_56_0)
	local var_56_0 = var_0_0.GetChangeSkinData(arg_56_0)

	if var_56_0 then
		return var_56_0.group or nil
	end
end

function var_0_0.GetChangeSkinNextId(arg_57_0)
	local var_57_0 = var_0_0.GetChangeSkinData(arg_57_0)

	if var_57_0 then
		return var_57_0.next or nil
	end
end

function var_0_0.GetChangeSkinIndex(arg_58_0)
	local var_58_0 = var_0_0.GetChangeSkinData(arg_58_0)

	if var_58_0 then
		return var_58_0.index or nil
	end
end

function var_0_0.GetChangeSkinState(arg_59_0)
	local var_59_0 = var_0_0.GetChangeSkinData(arg_59_0)

	if var_59_0 then
		return var_59_0.state or nil
	end
end

function var_0_0.GetChangeSkinAction(arg_60_0)
	local var_60_0 = var_0_0.GetChangeSkinData(arg_60_0)

	if var_60_0 then
		return var_60_0.action or nil
	end
end

function var_0_0.GetChangeSkinCustomDataId(arg_61_0, arg_61_1)
	local var_61_0 = var_0_0.GetChangeSkinData(arg_61_0)

	if var_61_0 then
		return var_61_0[arg_61_1] or nil
	end
end

function var_0_0.GetStoreChangeSkinId(arg_62_0, arg_62_1)
	local var_62_0, var_62_1 = ShipPhantom.UnpackMark(arg_62_1)
	local var_62_2 = PlayerPrefs.GetInt(var_0_0.GetStoreChangeSkinPrefsName(arg_62_0, arg_62_1), 0)

	if var_62_2 == 0 then
		return nil
	else
		return var_62_2
	end

	return
end

function var_0_0.SetStoreChangeSkinId(arg_63_0, arg_63_1)
	local var_63_0 = ShipSkin.GetChangeSkinCustomDataId(arg_63_0, "asmr") == 1
	local var_63_1, var_63_2 = ShipPhantom.UnpackMark(arg_63_1)

	PlayerPrefs.SetInt(var_0_0.GetStoreChangeSkinPrefsName(var_0_0.GetChangeSkinGroupId(arg_63_0), arg_63_1), arg_63_0)

	return
end

function var_0_0.GetStoreChangeSkinPrefsName(...)
	return string.format("change_skin_group_%s", table.concat({
		...
	}, "_"))
end

return var_0_0
