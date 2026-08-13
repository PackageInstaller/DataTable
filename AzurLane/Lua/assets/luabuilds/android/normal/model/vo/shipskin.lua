class = var_0_10000

local var_0_0 = "ShipSkin"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseVO"))

var_0_1.SKIN_TYPE_DEFAULT = -1
var_0_1.SKIN_TYPE_COMMON_FASHION = 0
var_0_1.SKIN_TYPE_PROPOSE = 1
var_0_1.SKIN_TYPE_REMAKE = 2
var_0_1.SKIN_TYPE_OLD = 3
var_0_1.SKIN_TYPE_NOT_HAVE_HIDE = 4
var_0_1.SKIN_TYPE_SHOW_IN_TIME = 5
var_0_1.SKIN_TYPE_TB = 6
var_0_1.WITH_LIVE2D = 1
var_0_1.WITH_BG = 2
var_0_1.WITH_EFFECT = 3
var_0_1.WITH_DYNAMIC_BG = 4
var_0_1.WITH_BGM = 5
var_0_1.WITH_SPINE = 6
var_0_1.WITH_SPINE_PLUS = 7
var_0_1.WITH_CHANGE = 8
var_0_1.WITH_LIVE2D_PLUS = 9
var_0_1.WITH_DOUBLE_VIOCE = 10
var_0_1.WITH_ASMR = 11
var_0_1.VOICE_LANG_JP = 1
var_0_1.VOICE_LANG_CN = 2

function var_0_1.Tag2Name(arg_1_0)
	if not var_0_1.Tag2NameTab then
		var_0_1.Tag2NameTab = {
			[var_0_1.WITH_BG] = "bg",
			[var_0_1.WITH_BGM] = "bgm",
			[var_0_1.WITH_DYNAMIC_BG] = "dtbg",
			[var_0_1.WITH_EFFECT] = "effect",
			[var_0_1.WITH_LIVE2D] = "live2d",
			[var_0_1.WITH_SPINE] = "spine",
			[var_0_1.WITH_SPINE_PLUS] = "spine_plus",
			[var_0_1.WITH_CHANGE] = "change",
			[var_0_1.WITH_LIVE2D_PLUS] = "live2d_plus",
			[var_0_1.WITH_DOUBLE_VIOCE] = "double_voice",
			[var_0_1.WITH_ASMR] = "asmr_skin"
		}
	end

	return var_0_1.Tag2NameTab[arg_1_0]
end

function var_0_1.GetShopTypeIdBySkinId(arg_2_0, arg_2_1)
	pg = var_1_10002

	local var_2_0 = var_1_10002.ship_skin_template.get_id_list_by_shop_type_id

	if arg_2_1[arg_2_0] then
		return arg_2_1[arg_2_0]
	end

	pairs = var_3

	for iter_2_0, iter_2_1 in var_3(var_2_0) do
		ipairs = var_1_10008

		for iter_2_2, iter_2_3 in var_1_10008(iter_2_1) do
			arg_2_1[iter_2_3] = iter_2_0

			if iter_2_3 == arg_2_0 then
				return iter_2_0
			end
		end
	end

	return
end

pg = var_1

local var_0_2 = var_1.ship_skin_template.get_id_list_by_ship_group

function var_0_1.GetSkinByType(arg_3_0, arg_3_1)
	local var_3_0

	if not var_0_2[arg_3_0] then
		var_3_0 = {}
	end

	ipairs = var_1_10003

	for iter_3_0, iter_3_1 in var_1_10003(var_3_0) do
		pg = var_1_10008

		if var_1_10008.ship_skin_template[iter_3_1].skin_type == arg_3_1 then
			return var_1_10008
		end
	end

	return
end

function var_0_1.GetAllSkinByGroup(arg_4_0)
	local var_4_0 = {}
	local var_4_1

	if not var_0_2[arg_4_0] then
		var_4_1 = {}
	end

	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(var_4_1) do
		pg = var_1_10008

		if var_1_10008.ship_skin_template[iter_4_1].no_showing ~= "1" then
			table = var_9

			var_9.insert(var_4_0, var_1_10008)
		end
	end

	return var_4_0
end

function var_0_1.GetShareSkinsByGroupId(arg_5_0)
	local function var_5_0(arg_6_0)
		return not (arg_6_0:getConfig("skin_type") == var_0_1.SKIN_TYPE_DEFAULT or var_1 == var_0_1.SKIN_TYPE_REMAKE or var_1 == var_0_1.SKIN_TYPE_OLD)
	end

	pg = var_1_10002

	local var_5_1 = var_1_10002.ship_data_group.get_id_list_by_group_type[arg_5_0][1]

	pg = var_1_10003

	if not var_1_10003.ship_data_group[var_5_1].share_group_id or #var_3.share_group_id <= 0 then
		return {}
	end

	local var_5_2 = {}

	ipairs = var_1_10005

	for iter_5_0, iter_5_1 in var_1_10005(var_3.share_group_id) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.ship_skin_template.get_id_list_by_ship_group[iter_5_1]
		ipairs = var_1_10011

		for iter_5_2, iter_5_3 in var_1_10011(var_1_10010) do
			ShipSkin = var_1_10016
			var_1_10016 = var_1_10016.New({
				id = iter_5_3
			})

			if var_5_0(var_1_10016) then
				table = var_17

				var_17.insert(var_5_2, var_1_10016)
			end
		end
	end

	return var_5_2
end

function var_0_1.Ctor(arg_7_0, arg_7_1)
	arg_7_0.id = arg_7_1.id
	arg_7_0.configId = arg_7_1.id

	local var_7_0

	if not arg_7_1.end_time and not arg_7_1.time then
		var_7_0 = 0
	end

	arg_7_0.endTime = var_7_0

	if arg_7_0:getConfig("skin_type") == var_0_1.SKIN_TYPE_TB then
		NewEducateHelper = var_2

		local var_7_1 = var_2.GetShipNameBySecId

		NewEducateHelper = var_3
		arg_7_0.shipName = var_7_1(var_3.GetSecIdBySkinId(arg_7_0.id))
	else
		local var_7_2 = arg_7_0
		local var_7_3 = arg_7_0.getConfig(var_7_2, "ship_group")

		ShipGroup = var_7_2

		local var_7_4

		if not var_7_2.getDefaultShipConfig(var_7_3) or not var_3.name then
			var_7_4 = ""
		end

		arg_7_0.shipName = var_7_4
	end

	arg_7_0.skinName = arg_7_0:getConfig("name")

	return
end

function var_0_1.bindConfigTable(arg_8_0)
	pg = var_1_10001

	return var_1_10001.ship_skin_template
end

function var_0_1.isExpireType(arg_9_0)
	return arg_9_0.endTime > 0
end

function var_0_1.getExpireTime(arg_10_0)
	return arg_10_0.endTime
end

function var_0_1.isExpired(arg_11_0)
	pg = var_1_10001

	local var_11_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_11_0) >= arg_11_0.endTime
end

function var_0_1.getRemainTime(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.getExpireTime(var_12_0)

	pg = var_12_0

	local var_12_2 = var_12_0.TimeMgr.GetInstance()

	return var_12_1 - var_2.GetServerTime(var_12_2)
end

function var_0_1.getIcon(arg_13_0)
	return arg_13_0:getConfig("painting")
end

function var_0_1.InShowTime(arg_14_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)

	return var_1.InShowTime(var_14_0, arg_14_0.id)
end

function var_0_1.IsDefault(arg_15_0)
	return arg_15_0:getConfig("skin_type") == var_0_1.SKIN_TYPE_DEFAULT
end

function var_0_1.IsType(arg_16_0, arg_16_1)
	return arg_16_0:getConfig("shop_type_id") == arg_16_1
end

function var_0_1.IsMatchKey(arg_17_0, arg_17_1)
	if not arg_17_1 or arg_17_1 == "" then
		return true
	end

	string = var_1_10002

	local var_17_0 = var_1_10002.lower

	string = var_1_10003
	arg_17_1 = var_17_0(var_1_10003.gsub(arg_17_1, "%.", "%%."))
	string = var_2

	local var_17_1 = var_2.lower

	string = var_3
	arg_17_1 = var_17_1(var_3.gsub(arg_17_1, "%-", "%%-"))
	string = var_2

	local var_17_2 = var_2.find

	string = var_3

	local var_17_3

	if not var_17_2(var_3.lower(arg_17_0.shipName), arg_17_1) then
		string = var_17_3
		var_17_3 = var_17_3.find
		string = var_3
		var_17_3 = var_17_3(var_3.lower(arg_17_0.skinName), arg_17_1)
	end

	return var_17_3
end

function var_0_1.ToShip(arg_18_0)
	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.getConfig(var_18_0, "ship_group")

	ShipGroup = var_18_0

	if var_18_0.getDefaultShipConfig(var_18_1) then
		Ship = var_3

		return var_3.New({
			id = 1,
			intimacy = 10000,
			template_id = var_2.id,
			skin_id = arg_18_0.id
		})
	else
		return nil
	end

	return
end

function var_0_1.GetDefaultShipConfig(arg_19_0)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.getConfig(var_19_0, "ship_group")

	ShipGroup = var_19_0

	return (var_19_0.getDefaultShipConfig(var_19_1))
end

function var_0_1.IsLive2d(arg_20_0)
	if not arg_20_0.isLive2dTag then
		table = var_1
		arg_20_0.isLive2dTag = var_1.contains(arg_20_0:getConfig("tag"), var_0_1.WITH_LIVE2D)
	end

	return arg_20_0.isLive2dTag
end

function var_0_1.IsDbg(arg_21_0)
	if not arg_21_0.isDGBTag then
		table = var_1
		arg_21_0.isDGBTag = var_1.contains(arg_21_0:getConfig("tag"), var_0_1.WITH_DYNAMIC_BG)
	end

	return arg_21_0.isDGBTag
end

function var_0_1.IsBG(arg_22_0)
	if not arg_22_0.isBGTag then
		table = var_1
		arg_22_0.isBGTag = var_1.contains(arg_22_0:getConfig("tag"), var_0_1.WITH_BG)
	end

	return arg_22_0.isBGTag
end

function var_0_1.IsEffect(arg_23_0)
	if not arg_23_0.isEffectTag then
		table = var_1
		arg_23_0.isEffectTag = var_1.contains(arg_23_0:getConfig("tag"), var_0_1.WITH_EFFECT)
	end

	return arg_23_0.isEffectTag
end

function var_0_1.isBgm(arg_24_0)
	if not arg_24_0.isBgmTag then
		table = var_1
		arg_24_0.isBgmTag = var_1.contains(arg_24_0:getConfig("tag"), var_0_1.WITH_BGM)
	end

	return arg_24_0.isBgmTag
end

function var_0_1.IsSpine(arg_25_0)
	if not arg_25_0.isSpine then
		table = var_1
		arg_25_0.isSpine = var_1.contains(arg_25_0:getConfig("tag"), var_0_1.WITH_SPINE)
	end

	return arg_25_0.isSpine
end

function var_0_1.IsSpinePlus(arg_26_0)
	if not arg_26_0.isSpinePlus then
		table = var_1
		arg_26_0.isSpinePlus = var_1.contains(arg_26_0:getConfig("tag"), var_0_1.WITH_SPINE_PLUS)
	end

	return arg_26_0.isSpinePlus
end

function var_0_1.IsLive2dPlus(arg_27_0)
	if not arg_27_0.isLive2dPlusTag then
		table = var_1
		arg_27_0.isLive2dPlusTag = var_1.contains(arg_27_0:getConfig("tag"), var_0_1.WITH_LIVE2D_PLUS)
	end

	return arg_27_0.isLive2dPlusTag
end

function var_0_1.CantUse(arg_28_0)
	local var_28_0 = arg_28_0:IsTransSkin()
	local var_28_1 = arg_28_0:IsProposeSkin()
	local var_28_2 = arg_28_0
	local var_28_3 = arg_28_0.getConfig(var_28_2, "ship_group")

	getProxy = var_28_2
	BayProxy = var_5

	local var_28_4 = var_28_2(var_5)
	local var_28_5 = var_4._ExistGroupShip(var_28_4, var_28_3, var_28_0, var_28_1)

	getProxy = var_28_4
	CollectionProxy = var_6

	local var_28_6 = var_28_4(var_6).shipGroups[var_28_3] == nil

	return not var_28_5 or var_28_6
end

function var_0_1.OwnShip(arg_29_0)
	local var_29_0 = arg_29_0:IsTransSkin()
	local var_29_1 = arg_29_0:IsProposeSkin()
	local var_29_2 = arg_29_0
	local var_29_3 = arg_29_0.getConfig(var_29_2, "ship_group")

	getProxy = var_29_2
	BayProxy = var_5

	local var_29_4 = var_29_2(var_5)

	return (var_4._ExistGroupShip(var_29_4, var_29_3, var_29_0, var_29_1))
end

function var_0_1.WithoutUse(arg_30_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_30_0 = var_1_10001(var_1_10002)
	local var_30_1

	if #var_1.CanUseShareSkinPhantoms(var_30_0, arg_30_0.id) > 0 then
		underscore = var_2
		var_30_1 = var_2.all(var_1, function(arg_31_0)
			return arg_31_0:getSkinId() ~= arg_30_0.id and not var_0_1.IsSameChangeSkinGroup(arg_31_0:getSkinId(), arg_30_0.id)
		end)
	else
		var_30_1 = false
	end

	if false then
		var_30_1 = true
	end

	return var_30_1
end

function var_0_1.NoUse(arg_32_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_32_0 = var_1_10001(var_1_10002)
	local var_32_1

	if #var_1.CanUseShareSkinPhantoms(var_32_0, arg_32_0.id) ~= 0 then
		if #var_1 > 0 then
			underscore = var_2
			var_32_1 = var_2.all(var_1, function(arg_33_0)
				return arg_33_0:getSkinId() ~= arg_32_0.id and not var_0_1.IsSameChangeSkinGroup(arg_33_0:getSkinId(), arg_32_0.id)
			end)
		else
			var_32_1 = false
		end
	else
		var_32_1 = true
	end

	return var_32_1
end

function var_0_1.ExistShip(arg_34_0)
	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.getConfig(var_34_0, "ship_group")

	pg = var_34_0

	local var_34_2 = var_34_0.ship_data_statistics

	tonumber = var_3

	return var_34_2[var_3(var_34_1 .. 1)] ~= nil
end

function var_0_1.IsTransSkin(arg_35_0)
	return arg_35_0:getConfig("skin_type") == var_0_1.SKIN_TYPE_REMAKE
end

function var_0_1.IsProposeSkin(arg_36_0)
	return arg_36_0:getConfig("skin_type") == var_0_1.SKIN_TYPE_PROPOSE
end

function var_0_1.IsHxDynamicPreview(arg_37_0)
	HXSet = var_1_10001

	if var_1_10001.isHx() then
		return arg_37_0:getConfig("shop_dynamic_hx") == 1
	end

	return false
end

function var_0_1.IsChangeSkinMainIndex(arg_38_0)
	if var_0_1.IsChangeSkin(arg_38_0.id) then
		return arg_38_0:getConfig("change_skin").index == 1
	end

	return false
end

function var_0_1.MatchChangeSkinMain(arg_39_0)
	if var_0_1.IsChangeSkin(arg_39_0.id) and not arg_39_0:IsChangeSkinMainIndex() then
		return false
	end

	return true
end

function var_0_1.CanShare(arg_40_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10002

	local var_40_0 = var_1_10001(var_1_10002)
	local var_40_1 = var_1.hasSkin(var_40_0, arg_40_0.configId)

	local function var_40_2()
		if var_40_1 then
			return true
		end

		local var_41_0 = arg_40_0

		return var_0.InShowTime(var_41_0)
	end

	local function var_40_3()
		local var_42_0 = arg_40_0
		local var_42_1 = var_0.getConfig(var_42_0, "ship_group")

		getProxy = var_42_0
		BayProxy = var_2

		local var_42_2 = var_42_0(var_2)
		local var_42_3 = var_1.getRawData(var_42_2)

		pairs = var_42_2

		for iter_42_0, iter_42_1 in var_42_2(var_42_3) do
			if iter_42_1.groupId == var_42_1 and iter_42_1.propose then
				return true
			end
		end

		return false
	end

	return not (arg_40_0:getConfig("skin_type") == var_0_1.SKIN_TYPE_DEFAULT or var_4 == var_0_1.SKIN_TYPE_REMAKE or var_4 == var_0_1.SKIN_TYPE_OLD or var_4 == var_0_1.SKIN_TYPE_NOT_HAVE_HIDE and not var_40_1 or var_4 == var_0_1.SKIN_TYPE_SHOW_IN_TIME and not var_40_2())
end

function var_0_1.CanShareInJuus(arg_43_0)
	getProxy = var_1_10001
	ShipSkinProxy = var_1_10002

	local var_43_0 = var_1_10001(var_1_10002)
	local var_43_1 = var_1.hasSkin(var_43_0, arg_43_0.configId)

	return not (arg_43_0:getConfig("skin_type") == var_0_1.SKIN_TYPE_REMAKE or var_2 == var_0_1.SKIN_TYPE_OLD or var_2 == var_0_1.SKIN_TYPE_NOT_HAVE_HIDE and not var_43_1 or var_2 == var_0_1.SKIN_TYPE_SHOW_IN_TIME and not var_43_1)
end

function var_0_1.IsShareSkin(arg_44_0, arg_44_1)
	pg = var_1_10002

	local var_44_0 = var_1_10002.ship_skin_template[arg_44_1]

	pg = var_1_10003

	local var_44_1 = var_3[var_1_10003.ship_data_group.get_id_list_by_group_type[arg_44_0.groupId][1]].share_group_id

	table = var_1_10006

	return var_1_10006.contains(var_44_1, var_44_0.ship_group)
end

function var_0_1.CanUseShareSkinForShip(arg_45_0, arg_45_1)
	local var_45_0 = var_0_1.IsShareSkin(arg_45_0, arg_45_1)

	ShipSkin = var_3

	local var_45_1 = var_3.New({
		id = arg_45_1
	})
	local var_45_2 = false
	local var_45_3 = var_45_1:CanShare()
	local var_45_4 = var_45_1
	local var_45_5 = var_45_1.IsProposeSkin(var_45_4)

	if var_45_3 and var_45_5 and arg_45_0.propose then
		var_45_2 = true
	elseif var_45_3 and not var_45_5 then
		math = var_45_4
		var_45_2 = var_45_4.floor(arg_45_0:getIntimacy() / 100) >= arg_45_0:GetNoProposeIntimacyMax()
	end

	return var_45_0 and var_45_2
end

function var_0_1.ExistReward(arg_46_0)
	pg = var_1_10001

	return var_1_10001.ship_skin_reward[arg_46_0.configId] ~= nil and #var_1.reward > 0
end

function var_0_1.GetRewardList(arg_47_0)
	if not arg_47_0:ExistReward() then
		return {}
	end

	pg = var_1

	local var_47_0 = var_1.ship_skin_reward[arg_47_0.configId]
	local var_47_1 = {}

	pairs = var_1_10003

	for iter_47_0, iter_47_1 in var_1_10003(var_47_0.reward) do
		table = var_1_10008

		var_1_10008.insert(var_47_1, {
			type = iter_47_1[1],
			id = iter_47_1[2],
			count = iter_47_1[3]
		})
	end

	return var_47_1
end

function var_0_1.GetRewardListDesc(arg_48_0)
	if #arg_48_0:GetRewardList() <= 0 then
		return ""
	end

	_ = var_2

	local var_48_0 = var_2.map(var_1, function(arg_49_0)
		return {
			arg_49_0.type,
			arg_49_0.id,
			arg_49_0.count
		}
	end)

	getDropInfo = var_3

	return var_3(var_48_0)
end

function var_0_1.GetShareGroupIds(arg_50_0)
	local var_50_0 = arg_50_0
	local var_50_1 = arg_50_0.getConfig(var_50_0, "ship_group")

	pg = var_50_0

	local var_50_2

	if not var_50_0.ship_data_group.get_id_list_by_group_type[var_50_1] or not var_2[1] then
		var_50_2 = nil
	end

	local var_50_3 = var_50_1

	underscore = var_1_10005

	local var_50_4 = var_1_10005.to_array

	if var_50_2 then
		pg = var_1_10006

		local var_50_5

		if not var_1_10006.ship_data_group[var_50_2].share_group_id then
			var_50_5 = {}
		end

		local var_50_6 = var_50_4(var_50_5)
	end
end

function var_0_1.GetAllChangeSkinIds(arg_51_0)
	if not var_0_1.GetChangeSkinMainId(arg_51_0) then
		return {
			arg_51_0
		}
	end

	local var_51_0 = var_0_1.GetChangeSkinMainId(arg_51_0)
	local var_51_1 = {
		var_51_0
	}
	local var_51_2 = arg_51_0

	for iter_51_0 = 1, 10 do
		local var_51_3 = var_0_1.GetChangeSkinNextId(var_51_2)

		table = var_9

		if not var_9.contains(var_51_1, var_51_3) then
			table = var_9

			var_9.insert(var_51_1, var_51_3)
		end

		var_51_2 = var_51_3

		if var_0_1.GetChangeSkinIndex(var_51_2) == 1 then
			return var_51_1
		end
	end

	return var_51_1
end

function var_0_1.IsChangeSkin(arg_52_0)
	pg = var_1_10001

	if not var_1_10001.ship_skin_template[arg_52_0] then
		warning = var_1_10002

		var_1_10002("skin not exist " .. arg_52_0)
	end

	table = var_1_10002

	local var_52_0

	if not var_1_10002.contains(var_1.tag, var_0_1.WITH_CHANGE) then
		table = var_52_0

		if not var_52_0.contains(var_1.tag, var_0_1.WITH_DOUBLE_VIOCE) then
			table = var_52_0
			var_52_0 = var_52_0.contains(var_1.tag, var_0_1.WITH_ASMR)
		end
	end

	return var_52_0
end

function var_0_1.GetChangeSkinMainId(arg_53_0)
	if not var_0_1.IsChangeSkin(arg_53_0) then
		return arg_53_0
	end

	while var_0_1.GetChangeSkinIndex(arg_53_0) ~= 1 do
		arg_53_0 = var_0_1.GetChangeSkinNextId(arg_53_0)
	end

	return arg_53_0
end

function var_0_1.GetChangeSkinData(arg_54_0)
	if not var_0_1.IsChangeSkin(arg_54_0) then
		return nil
	end

	pg = var_1

	if var_1.ship_skin_template[arg_54_0] and var_1.change_skin and var_1.change_skin ~= "" then
		return var_1.change_skin
	end

	return nil
end

function var_0_1.IsSameChangeSkinGroup(arg_55_0, arg_55_1)
	if not var_0_1.IsChangeSkin(arg_55_0) or not var_0_1.IsChangeSkin(arg_55_1) then
		return false
	end

	return var_0_1.GetChangeSkinGroupId(arg_55_0) == var_0_1.GetChangeSkinGroupId(arg_55_1)
end

function var_0_1.GetChangeSkinGroupId(arg_56_0)
	local var_56_0

	if not var_0_1.GetChangeSkinData(arg_56_0) or not var_1.group then
		var_56_0 = nil
	end

	return var_56_0
end

function var_0_1.GetChangeSkinNextId(arg_57_0)
	local var_57_0

	if not var_0_1.GetChangeSkinData(arg_57_0) or not var_1.next then
		var_57_0 = nil
	end

	return var_57_0
end

function var_0_1.GetChangeSkinIndex(arg_58_0)
	local var_58_0

	if not var_0_1.GetChangeSkinData(arg_58_0) or not var_1.index then
		var_58_0 = nil
	end

	return var_58_0
end

function var_0_1.GetChangeSkinState(arg_59_0)
	local var_59_0

	if not var_0_1.GetChangeSkinData(arg_59_0) or not var_1.state then
		var_59_0 = nil
	end

	return var_59_0
end

function var_0_1.GetChangeSkinAction(arg_60_0)
	local var_60_0

	if not var_0_1.GetChangeSkinData(arg_60_0) or not var_1.action then
		var_60_0 = nil
	end

	return var_60_0
end

function var_0_1.GetChangeSkinCustomDataId(arg_61_0, arg_61_1)
	local var_61_0

	if not var_0_1.GetChangeSkinData(arg_61_0) or not var_2[arg_61_1] then
		var_61_0 = nil
	end

	return var_61_0
end

function var_0_1.GetStoreChangeSkinId(arg_62_0, arg_62_1)
	ShipPhantom = var_1_10002

	local var_62_0, var_62_1 = var_1_10002.UnpackMark(arg_62_1)
	local var_62_2 = var_0_1.GetStoreChangeSkinPrefsName(arg_62_0, arg_62_1)

	PlayerPrefs = var_5

	if var_5.GetInt(var_62_2, 0) == 0 then
		return nil
	else
		return var_5
	end

	return
end

function var_0_1.SetStoreChangeSkinId(arg_63_0, arg_63_1)
	ShipSkin = var_1_10002

	local var_63_0

	var_63_0 = var_1_10002.GetChangeSkinCustomDataId(arg_63_0, "asmr") == 1 and true or false
	ShipPhantom = var_3

	local var_63_1, var_63_2 = var_3.UnpackMark(arg_63_1)
	local var_63_3 = var_0_1.GetChangeSkinGroupId(arg_63_0)
	local var_63_4 = var_0_1.GetStoreChangeSkinPrefsName(var_63_3, arg_63_1)

	PlayerPrefs = var_7

	var_7.SetInt(var_63_4, arg_63_0)

	return
end

function var_0_1.GetStoreChangeSkinPrefsName(...)
	string = var_1_10000

	local var_64_0 = var_1_10000.format
	local var_64_1 = "change_skin_group_%s"

	table = var_1_10002

	return var_64_0(var_64_1, var_1_10002.concat({
		...
	}, "_"))
end

return var_0_1
