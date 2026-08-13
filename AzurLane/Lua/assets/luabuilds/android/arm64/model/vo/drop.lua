class = var_0_10000

local var_0_0 = "Drop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.__index(arg_1_0, arg_1_1)
	if arg_1_1 == "desc" then
		HXSet = var_1_10002

		local var_1_0 = var_1_10002.hxLan

		rawget = var_1_10004

		return var_1_0(var_1_10004(arg_1_0, "_desc"))
	end

	return var_0_1[arg_1_1]
end

function var_0_1.__newindex(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "desc" then
		rawset = var_1_10003

		var_1_10003(arg_2_0, "_desc", arg_2_2)
	else
		rawset = var_1_10003

		var_1_10003(arg_2_0, arg_2_1, arg_2_2)
	end

	return
end

function var_0_1.Create(arg_3_0)
	local var_3_0 = {}

	unpack = var_1_10002
	var_3_0.type, var_3_0.id, var_3_0.count = var_1_10002(arg_3_0)

	return var_0_1.New(var_3_0)
end

function var_0_1.Change(arg_4_0)
	getmetatable = var_1_10001

	local var_4_0

	if not var_1_10001(arg_4_0) then
		setmetatable = var_1

		var_1(arg_4_0, var_0_1)

		arg_4_0.class = var_0_1
		var_4_0 = arg_4_0

		arg_4_0.InitConfig(var_4_0)
	else
		assert = var_1
		instanceof = var_4_0

		var_1(var_4_0(arg_4_0, var_0_1))
	end

	return arg_4_0
end

function var_0_1.Ctor(arg_5_0, arg_5_1)
	assert = var_1_10002
	getmetatable = var_1_10004

	var_1_10002(not var_1_10004(arg_5_1), "drop data should not has metatable")

	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_1) do
		arg_5_0[iter_5_0] = iter_5_1
	end

	arg_5_0:InitConfig()

	return
end

function var_0_1.InitConfig(arg_6_0)
	if not var_0_1.inited then
		var_0_1.InitSwitch()
	end

	arg_6_0.configId = arg_6_0.id
	switch = var_1
	arg_6_0.cfg = var_1(arg_6_0.type, var_0_1.ConfigCase, var_0_1.ConfigDefault, arg_6_0)

	return
end

function var_0_1.getConfigTable(arg_7_0)
	return arg_7_0.cfg
end

function var_0_1.getName(arg_8_0)
	local var_8_0

	if not arg_8_0.name then
		var_8_0 = arg_8_0:getConfig("name")
	end

	return var_8_0
end

function var_0_1.getIcon(arg_9_0)
	switch = var_1_10001

	local var_9_0 = arg_9_0.type
	local var_9_1 = {}

	DROP_TYPE_ICON_FRAME = var_1_10005
	var_9_1[var_1_10005] = function()
		return "Props/icon_frame"
	end
	DROP_TYPE_ISLAND_ITEM = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_11_0 = arg_9_0
		local var_11_3

		if var_0.getConfig(var_11_0, "icon_normal") == "" or not var_0 then
			::label_11_0::

			local var_11_1 = "island/"
			local var_11_2 = arg_9_0

			var_11_3 = var_11_1 .. var_2.getConfig(var_11_2, "icon")
		end

		return var_11_3
	end
	DROP_TYPE_ISLAND_ABILITY = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_12_0 = "island/"
		local var_12_1 = arg_9_0

		return var_12_0 .. var_1.getConfig(var_12_1, "cmd_icon")
	end
	DROP_TYPE_ISLAND_INVITATION = var_1_10005
	var_9_1[var_1_10005] = function()
		pg = var_2_10000

		local var_13_0 = var_2_10000.island_item_data_template
		local var_13_1 = arg_9_0
		local var_13_2 = var_13_0[var_1.getConfig(var_13_1, "invite_item")].icon

		return "island/" .. var_13_2
	end
	VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_14_0 = "island/"
		local var_14_1 = arg_9_0

		return var_14_0 .. var_1.getConfig(var_14_1, "icon")
	end
	DROP_TYPE_ISLAND_COLLECTION = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_15_0 = "island/"
		local var_15_1 = arg_9_0

		return var_15_0 .. var_1.getConfig(var_15_1, "icon")
	end
	DROP_TYPE_ISLAND_FURNITURE = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_16_0 = "island/IslandFurnitureIcon/"
		local var_16_1 = arg_9_0

		return var_16_0 .. var_1.getConfig(var_16_1, "icon")
	end
	DROP_TYPE_ISLAND_CARD_DIY = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_17_0 = "island/"
		local var_17_1 = arg_9_0

		return var_17_0 .. var_1.getConfig(var_17_1, "icon")
	end
	DROP_TYPE_ISLAND_SPEEDUP_TICKET = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_18_0 = arg_9_0

		return var_0.getConfig(var_18_0, "icon_normal")
	end
	DROP_TYPE_ISLAND_DRESS = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_19_0 = "island/IslandDressIcon/"
		local var_19_1 = arg_9_0

		return var_19_0 .. var_1.getConfig(var_19_1, "icon")
	end
	DROP_TYPE_ISLAND_ACTION = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_20_0 = "island/IslandActionIcon/"
		local var_20_1 = arg_9_0

		return var_20_0 .. var_1.getConfig(var_20_1, "resource")
	end
	DROP_TYPE_ISLAND_SKIN = var_1_10005
	var_9_1[var_1_10005] = function()
		local var_21_0 = arg_9_0

		return var_0.getConfig(var_21_0, "icon_normal")
	end

	return var_1_10001(var_9_0, var_9_1, function()
		local var_22_0 = arg_9_0

		return var_0.getConfig(var_22_0, "icon")
	end)
end

function var_0_1.getDefaultIcon(arg_23_0)
	switch = var_1_10001

	local var_23_0 = arg_23_0.type
	local var_23_1 = {}

	DROP_TYPE_DORM3D_FURNITURE = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_dorm"
	end
	DROP_TYPE_DORM3D_GIFT = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_dorm"
	end
	DROP_TYPE_DORM3D_SKIN = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_dorm"
	end
	DROP_TYPE_ISLAND_ITEM = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_OVERFLOWITEM = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_ABILITY = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_INVITATION = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_FURNITURE = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_DRESS = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_SKIN = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_COLLECTION_FRAMENT = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_COLLECTION = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_SPEEDUP_TICKET = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_ACTION = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end
	DROP_TYPE_ISLAND_CARD_DIY = var_1_10005
	var_23_1[var_1_10005] = function()
		return "props/missing_icon_island"
	end

	return var_1_10001(var_23_0, var_23_1, function()
		return "props/missing_icon"
	end)
end

function var_0_1.getIslandRarity(arg_40_0)
	switch = var_1_10001

	local var_40_0 = arg_40_0.type
	local var_40_1 = {}

	DROP_TYPE_ISLAND_ITEM = var_1_10005
	var_40_1[var_1_10005] = function()
		local var_41_0 = arg_40_0

		return var_0.getConfig(var_41_0, "rarity")
	end
	DROP_TYPE_ISLAND_FURNITURE = var_1_10005
	var_40_1[var_1_10005] = function()
		local var_42_0 = arg_40_0

		return var_0.getConfig(var_42_0, "rarity")
	end
	DROP_TYPE_ISLAND_SPEEDUP_TICKET = var_1_10005
	var_40_1[var_1_10005] = function()
		local var_43_0 = arg_40_0

		return var_0.getConfig(var_43_0, "rarity")
	end
	DROP_TYPE_ISLAND_DRESS = var_1_10005
	var_40_1[var_1_10005] = function()
		IslandItemRarity = var_2_10000

		return var_2_10000.ORANGE
	end
	DROP_TYPE_ISLAND_ACTION = var_1_10005
	var_40_1[var_1_10005] = function()
		IslandItemRarity = var_2_10000

		return var_2_10000.ORANGE
	end
	DROP_TYPE_ITEM = var_1_10005
	var_40_1[var_1_10005] = function()
		IslandItemRarity = var_2_10000

		return var_2_10000.ORANGE
	end
	DROP_TYPE_VITEM = var_1_10005
	var_40_1[var_1_10005] = function()
		IslandItemRarity = var_2_10000

		return var_2_10000.ORANGE
	end

	return var_1_10001(var_40_0, var_40_1, function()
		IslandItemRarity = var_2_10000

		return var_2_10000.GREY
	end)
end

function var_0_1.getCount(arg_49_0)
	local var_49_0 = arg_49_0.type

	DROP_TYPE_OPERATION = var_1_10002

	if var_49_0 ~= var_1_10002 then
		local var_49_1 = arg_49_0.type

		DROP_TYPE_LOVE_LETTER = var_1_10002

		if var_49_1 ~= var_1_10002 then
			MallActivity = var_49_1

			if var_49_1.IsStaffDrop(arg_49_0) then
				return 1
			else
				return arg_49_0.count
			end

			return
		end
	end
end

function var_0_1.isLoveLetter(arg_50_0)
	local var_50_0 = arg_50_0.type

	DROP_TYPE_LOVE_LETTER = var_1_10002

	if var_50_0 ~= var_1_10002 then
		local var_50_1 = arg_50_0.type

		DROP_TYPE_ITEM = var_1_10002

		if var_50_1 == var_1_10002 then
			local var_50_2 = arg_50_0:getConfig("type")

			Item = var_1_10002

			local var_50_3

			if var_50_2 ~= var_1_10002.LOVE_LETTER_TYPE then
				var_50_3 = false

				goto label_50_0
			end

			var_50_3 = true

			::label_50_0::

			return var_50_3
		end
	end
end

function var_0_1.getOwnedCount(arg_51_0)
	switch = var_1_10001

	return var_1_10001(arg_51_0.type, var_0_1.CountCase, var_0_1.CountDefault, arg_51_0)
end

function var_0_1.getOwnedLimit(arg_52_0)
	switch = var_1_10001

	return var_1_10001(arg_52_0.type, var_0_1.LimitCase, var_0_1.LimitDefault, arg_52_0)
end

function var_0_1.getSubClass(arg_53_0)
	switch = var_1_10001

	return var_1_10001(arg_53_0.type, var_0_1.SubClassCase, var_0_1.SubClassDefault, arg_53_0)
end

function var_0_1.getDropRarity(arg_54_0)
	switch = var_1_10001

	return var_1_10001(arg_54_0.type, var_0_1.RarityCase, var_0_1.RarityDefault, arg_54_0)
end

function var_0_1.getDropRarityDorm(arg_55_0)
	switch = var_1_10001

	return var_1_10001(arg_55_0.type, var_0_1.RarityCase, var_0_1.RarityDefaultDorm, arg_55_0)
end

function var_0_1.DropTrans(arg_56_0, ...)
	switch = var_1_10001

	return var_1_10001(arg_56_0.type, var_0_1.TransCase, var_0_1.TransDefault, arg_56_0, ...)
end

function var_0_1.AddItemOperation(arg_57_0)
	switch = var_1_10001

	return var_1_10001(arg_57_0.type, var_0_1.AddItemCase, var_0_1.AddItemDefault, arg_57_0)
end

function var_0_1.MsgboxIntroSet(arg_58_0, ...)
	switch = var_1_10001

	return var_1_10001(arg_58_0.type, var_0_1.MsgboxIntroCase, var_0_1.MsgboxIntroDefault, arg_58_0, ...)
end

function var_0_1.UpdateDropTpl(arg_59_0, ...)
	switch = var_1_10001

	return var_1_10001(arg_59_0.type, var_0_1.UpdateDropCase, var_0_1.UpdateDropDefault, arg_59_0, ...)
end

function var_0_1.UpdateCustomDropTpl(arg_60_0, ...)
	switch = var_1_10001

	return var_1_10001(arg_60_0.type, var_0_1.UpdateCustomDropCase, var_0_1.UpdateCustomDropDefault, arg_60_0, ...)
end

function var_0_1.InitSwitch()
	var_0_1.inited = true

	local var_61_0 = var_0_1
	local var_61_1 = {}

	DROP_TYPE_RESOURCE = var_1_10002
	var_61_1[var_1_10002] = function(arg_62_0)
		Item = var_2_10001

		local var_62_0 = var_2_10001.getConfigData

		id2ItemId = var_2_10003
		arg_62_0.desc = var_62_0(var_2_10003(arg_62_0.id)).display

		return var_1
	end
	DROP_TYPE_ITEM = var_1_10002
	var_61_1[var_1_10002] = function(arg_63_0)
		Item = var_2_10001
		arg_63_0.desc = var_2_10001.getConfigData(arg_63_0.id).display

		local var_63_0 = var_1.type

		Item = var_3

		if var_63_0 == var_3.LOVE_LETTER_TYPE then
			string = var_63_0

			local var_63_1 = var_63_0.gsub
			local var_63_2 = arg_63_0.desc
			local var_63_3 = "$1"

			ShipGroup = var_2_10006
			arg_63_0.desc = var_63_1(var_63_2, var_63_3, var_2_10006.getDefaultShipNameByGroupID(arg_63_0.extra))
		end

		return var_1
	end
	DROP_TYPE_VITEM = var_1_10002
	var_61_1[var_1_10002] = function(arg_64_0)
		Item = var_2_10001

		local var_64_0 = var_2_10001.getConfigData(arg_64_0.id)

		assert = var_2_10002

		var_2_10002(var_64_0, arg_64_0.id)

		arg_64_0.desc = var_64_0.display

		return var_64_0
	end
	DROP_TYPE_LOVE_LETTER = var_1_10002
	var_61_1[var_1_10002] = function(arg_65_0)
		Item = var_2_10001

		local var_65_0 = var_2_10001.getConfigData(arg_65_0.id)

		string = var_2_10002

		local var_65_1 = var_2_10002.gsub
		local var_65_2 = var_65_0.display
		local var_65_3 = "$1"

		ShipGroup = var_2_10006
		arg_65_0.desc = var_65_1(var_65_2, var_65_3, var_2_10006.getDefaultShipNameByGroupID(arg_65_0.count))

		return var_65_0
	end
	DROP_TYPE_EQUIP = var_1_10002
	var_61_1[var_1_10002] = function(arg_66_0)
		Equipment = var_2_10001
		arg_66_0.desc = var_2_10001.getConfigData(arg_66_0.id).descrip

		return var_1
	end
	DROP_TYPE_SHIP = var_1_10002
	var_61_1[var_1_10002] = function(arg_67_0)
		pg = var_2_10001

		local var_67_0 = var_2_10001.ship_data_statistics[arg_67_0.id]

		ShipWordHelper = var_2

		local var_67_1 = var_2.GetWordAndCV
		local var_67_2 = var_67_0.skin_id

		ShipWordHelper = var_2_10005

		local var_67_3, var_67_4, var_67_5 = var_67_1(var_67_2, var_2_10005.WORD_TYPE_DROP)
		local var_67_6

		if not var_67_5 then
			::label_67_0::

			i18n = var_67_6
			var_67_6 = var_67_6("ship_drop_desc_default")
		end

		arg_67_0.desc = var_67_6
		Ship = var_67_6
		arg_67_0.ship = var_67_6.New({
			configId = arg_67_0.id,
			skin_id = arg_67_0.skinId,
			propose = arg_67_0.propose
		})
		arg_67_0.ship.remoulded = arg_67_0.remoulded
		arg_67_0.ship.virgin = arg_67_0.virgin

		return var_67_0
	end
	DROP_TYPE_FURNITURE = var_1_10002
	var_61_1[var_1_10002] = function(arg_68_0)
		pg = var_2_10001
		arg_68_0.desc = var_2_10001.furniture_data_template[arg_68_0.id].describe

		return var_1
	end
	DROP_TYPE_SKIN = var_1_10002
	var_61_1[var_1_10002] = function(arg_69_0)
		pg = var_2_10001

		local var_69_0 = var_2_10001.ship_skin_template[arg_69_0.id].skin_type

		ShipSkin = var_2_10003

		if var_69_0 == var_2_10003.SKIN_TYPE_TB then
			EducateCharWordHelper = var_69_0
			var_69_0 = var_69_0.GetWordAndCV
			NewEducateHelper = var_2_10004

			local var_69_1 = var_2_10004.GetSecIdBySkinId(arg_69_0.id)

			EducateCharWordHelper = var_2_10005

			local var_69_2, var_69_3

			var_69_0, var_69_2, var_69_3 = var_69_0(var_69_1, var_2_10005.WORD_KEY_LOGIN)
			arg_69_0.desc = var_69_3
		else
			ShipWordHelper = var_69_0

			local var_69_4 = var_69_0.GetWordAndCV
			local var_69_5 = arg_69_0.id

			ShipWordHelper = var_2_10005

			local var_69_6, var_69_7, var_69_8 = var_69_4(var_69_5, var_2_10005.WORD_TYPE_DROP)

			arg_69_0.desc = var_69_8
		end

		return var_1
	end
	DROP_TYPE_SKIN_TIMELIMIT = var_1_10002
	var_61_1[var_1_10002] = function(arg_70_0)
		pg = var_2_10001

		local var_70_0 = var_2_10001.ship_skin_template[arg_70_0.id].skin_type

		ShipSKin = var_2_10003

		if var_70_0 == var_2_10003.SKIN_TYPE_TB then
			EducateCharWordHelper = var_70_0
			var_70_0 = var_70_0.GetWordAndCV
			NewEducateHelper = var_2_10004

			local var_70_1 = var_2_10004.GetSecIdBySkinId(arg_70_0.id)

			EducateCharWordHelper = var_2_10005

			local var_70_2, var_70_3

			var_70_0, var_70_2, var_70_3 = var_70_0(var_70_1, var_2_10005.WORD_KEY_LOGIN)
			arg_70_0.desc = var_70_3
		else
			ShipWordHelper = var_70_0

			local var_70_4 = var_70_0.GetWordAndCV
			local var_70_5 = arg_70_0.id

			ShipWordHelper = var_2_10005

			local var_70_6, var_70_7, var_70_8 = var_70_4(var_70_5, var_2_10005.WORD_TYPE_DROP)

			arg_70_0.desc = var_70_8
		end

		return var_1
	end
	DROP_TYPE_EQUIPMENT_SKIN = var_1_10002
	var_61_1[var_1_10002] = function(arg_71_0)
		pg = var_2_10001
		arg_71_0.desc = var_2_10001.equip_skin_template[arg_71_0.id].desc

		return var_1
	end
	DROP_TYPE_WORLD_ITEM = var_1_10002
	var_61_1[var_1_10002] = function(arg_72_0)
		pg = var_2_10001
		arg_72_0.desc = var_2_10001.world_item_data_template[arg_72_0.id].display

		return var_1
	end
	DROP_TYPE_ICON_FRAME = var_1_10002
	var_61_1[var_1_10002] = function(arg_73_0)
		pg = var_2_10001
		arg_73_0.desc = var_2_10001.item_data_frame[arg_73_0.id].desc

		return var_1
	end
	DROP_TYPE_CHAT_FRAME = var_1_10002
	var_61_1[var_1_10002] = function(arg_74_0)
		pg = var_2_10001

		return var_2_10001.item_data_chat[arg_74_0.id]
	end
	DROP_TYPE_SPWEAPON = var_1_10002
	var_61_1[var_1_10002] = function(arg_75_0)
		pg = var_2_10001
		arg_75_0.desc = var_2_10001.spweapon_data_statistics[arg_75_0.id].descrip

		return var_1
	end
	DROP_TYPE_RYZA_DROP = var_1_10002
	var_61_1[var_1_10002] = function(arg_76_0)
		pg = var_2_10001

		local var_76_0 = var_2_10001.activity_ryza_item[arg_76_0.id]

		AtelierMaterial = var_2
		arg_76_0.item = var_2.New({
			configId = arg_76_0.id
		})

		local var_76_1 = arg_76_0.item

		arg_76_0.desc = var_2.GetDesc(var_76_1)

		return var_76_0
	end
	DROP_TYPE_OPERATION = var_1_10002
	var_61_1[var_1_10002] = function(arg_77_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_77_0 = var_2_10001(var_2_10003)

		arg_77_0.ship = var_1.getShipById(var_77_0, arg_77_0.count)
		pg = var_1

		local var_77_1 = var_1.ship_data_statistics[arg_77_0.ship.configId]

		ShipWordHelper = var_2

		local var_77_2 = var_2.GetWordAndCV
		local var_77_3 = var_77_1.skin_id

		ShipWordHelper = var_2_10005

		local var_77_4, var_77_5, var_77_6 = var_77_2(var_77_3, var_2_10005.WORD_TYPE_DROP)
		local var_77_7

		if not var_77_6 then
			::label_77_0::

			i18n = var_77_7
			var_77_7 = var_77_7("ship_drop_desc_default")
		end

		arg_77_0.desc = var_77_7

		return var_77_1
	end
	DROP_TYPE_STRATEGY = var_1_10002
	var_61_1[var_1_10002] = function(arg_78_0)
		if arg_78_0.isWorldBuff then
			pg = var_78_0

			local var_78_0

			if not var_78_0.world_SLGbuff_data[arg_78_0.id] then
				pg = var_78_0
				var_78_0 = var_78_0.strategy_data_template[arg_78_0.id]
			end

			return var_78_0
		end
	end
	DROP_TYPE_EMOJI = var_1_10002
	var_61_1[var_1_10002] = function(arg_79_0)
		pg = var_2_10001
		arg_79_0.name = var_2_10001.emoji_template[arg_79_0.id].item_name
		arg_79_0.desc = var_1.item_desc

		return var_1
	end
	DROP_TYPE_WORLD_COLLECTION = var_1_10002
	var_61_1[var_1_10002] = function(arg_80_0)
		WorldCollectionProxy = var_2_10001
		arg_80_0.desc = var_2_10001.GetCollectionTemplate(arg_80_0.id).name

		return var_1
	end
	DROP_TYPE_META_PT = var_1_10002
	var_61_1[var_1_10002] = function(arg_81_0)
		pg = var_2_10001

		local var_81_0 = var_2_10001.ship_strengthen_meta[arg_81_0.id]

		Item = var_2
		arg_81_0.desc = var_2.getConfigData(var_81_0.itemid).display

		return var_2
	end
	DROP_TYPE_WORKBENCH_DROP = var_1_10002
	var_61_1[var_1_10002] = function(arg_82_0)
		pg = var_2_10001

		local var_82_0 = var_2_10001.activity_workbench_item[arg_82_0.id]

		WorkBenchItem = var_2
		arg_82_0.item = var_2.New({
			configId = arg_82_0.id
		})

		local var_82_1 = arg_82_0.item

		arg_82_0.desc = var_2.GetDesc(var_82_1)

		return var_82_0
	end
	DROP_TYPE_BUFF = var_1_10002
	var_61_1[var_1_10002] = function(arg_83_0)
		pg = var_2_10001
		arg_83_0.desc = var_2_10001.benefit_buff_template[arg_83_0.id].desc

		return var_1
	end
	DROP_TYPE_COMMANDER_CAT = var_1_10002
	var_61_1[var_1_10002] = function(arg_84_0)
		pg = var_2_10001
		arg_84_0.desc = var_2_10001.commander_data_template[arg_84_0.id].desc

		return var_1
	end
	DROP_TYPE_ISLAND_ITEM = var_1_10002
	var_61_1[var_1_10002] = function(arg_85_0)
		pg = var_2_10001
		arg_85_0.desc = var_2_10001.island_item_data_template[arg_85_0.id].desc

		return var_1
	end
	DROP_TYPE_ISLAND_ABILITY = var_1_10002
	var_61_1[var_1_10002] = function(arg_86_0)
		pg = var_2_10001

		local var_86_0 = var_2_10001.island_ability_template[arg_86_0.id]

		arg_86_0.desc = ""

		return var_86_0
	end
	DROP_TYPE_ISLAND_INVITATION = var_1_10002
	var_61_1[var_1_10002] = function(arg_87_0)
		pg = var_2_10001

		local var_87_0 = var_2_10001.island_chara_template[arg_87_0.id].invite_item

		pg = var_2_10003
		arg_87_0.desc = var_2_10003.island_item_data_template[var_87_0].desc

		return var_1
	end
	DROP_TYPE_ISLAND_FURNITURE = var_1_10002
	var_61_1[var_1_10002] = function(arg_88_0)
		pg = var_2_10001
		arg_88_0.desc = var_2_10001.island_furniture_template[arg_88_0.id].describe

		return var_1
	end
	DROP_TYPE_ISLAND_DRESS = var_1_10002
	var_61_1[var_1_10002] = function(arg_89_0)
		pg = var_2_10001
		arg_89_0.desc = var_2_10001.island_dress_template[arg_89_0.id].desc

		return var_1
	end
	DROP_TYPE_ISLAND_SKIN = var_1_10002
	var_61_1[var_1_10002] = function(arg_90_0)
		pg = var_2_10001
		arg_90_0.desc = var_2_10001.island_skin_template[arg_90_0.id].desc

		return var_1
	end
	DROP_TYPE_ISLAND_ACTION = var_1_10002
	var_61_1[var_1_10002] = function(arg_91_0)
		pg = var_2_10001
		arg_91_0.desc = var_2_10001.island_action[arg_91_0.id].desc

		return var_1
	end
	DROP_TYPE_ISLAND_SPEEDUP_TICKET = var_1_10002
	var_61_1[var_1_10002] = function(arg_92_0)
		pg = var_2_10001
		arg_92_0.desc = var_2_10001.island_speedup_ticket[arg_92_0.id].desc

		return var_1
	end
	DROP_TYPE_ISLAND_CARD_DIY = var_1_10002
	var_61_1[var_1_10002] = function(arg_93_0)
		pg = var_2_10001
		arg_93_0.desc = var_2_10001.island_card_diy[arg_93_0.id].desc

		return var_1
	end
	DROP_TYPE_TRANS_ITEM = var_1_10002
	var_61_1[var_1_10002] = function(arg_94_0)
		pg = var_2_10001

		return var_2_10001.drop_data_restore[arg_94_0.id]
	end
	DROP_TYPE_DORM3D_FURNITURE = var_1_10002
	var_61_1[var_1_10002] = function(arg_95_0)
		pg = var_2_10001
		arg_95_0.desc = var_2_10001.dorm3d_furniture_template[arg_95_0.id].desc

		return var_1
	end
	DROP_TYPE_DORM3D_GIFT = var_1_10002
	var_61_1[var_1_10002] = function(arg_96_0)
		pg = var_2_10001
		arg_96_0.desc = var_2_10001.dorm3d_gift[arg_96_0.id].display

		return var_1
	end
	DROP_TYPE_DORM3D_SKIN = var_1_10002
	var_61_1[var_1_10002] = function(arg_97_0)
		pg = var_2_10001

		local var_97_0 = var_2_10001.dorm3d_resource[arg_97_0.id]

		arg_97_0.desc = ""

		return var_97_0
	end
	DROP_TYPE_LIVINGAREA_COVER = var_1_10002
	var_61_1[var_1_10002] = function(arg_98_0)
		pg = var_2_10001
		arg_98_0.desc = var_2_10001.livingarea_cover[arg_98_0.id].desc

		return var_1
	end
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10002
	var_61_1[var_1_10002] = function(arg_99_0)
		pg = var_2_10001

		return var_2_10001.item_data_battleui[arg_99_0.id]
	end
	DROP_TYPE_ACTIVITY_MEDAL = var_1_10002
	var_61_1[var_1_10002] = function(arg_100_0)
		pg = var_2_10001

		local var_100_0 = var_2_10001.activity_medal_template[arg_100_0.id].item

		pg = var_2

		return var_2.item_virtual_data_statistics[var_100_0]
	end
	DROP_TYPE_HOLIDAY_VILLA = var_1_10002
	var_61_1[var_1_10002] = function(arg_101_0)
		Item = var_2_10001

		local var_101_0 = var_2_10001.getConfigData(arg_101_0.id)

		assert = var_2_10002

		var_2_10002(var_101_0, arg_101_0.id)

		arg_101_0.desc = var_101_0.display

		return var_101_0
	end
	DROP_TYPE_ISLAND_COLLECTION = var_1_10002
	var_61_1[var_1_10002] = function(arg_102_0)
		pg = var_2_10001

		return var_2_10001.island_collection[arg_102_0.id]
	end
	VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_1_10002
	var_61_1[var_1_10002] = function(arg_103_0)
		pg = var_2_10001

		local var_103_0 = var_2_10001.island_set.season_pt_show.key_value_int

		pg = var_2_10002
		arg_103_0.desc = var_2_10002.island_item_data_template[var_103_0].desc

		return var_2
	end
	var_61_0.ConfigCase = var_61_1

	function var_0_1.ConfigDefault(arg_104_0)
		local var_104_0 = arg_104_0.type

		tonumber = var_2_10002

		if var_2_10002(var_104_0) then
			DROP_TYPE_USE_ACTIVITY_DROP = var_2

			if var_2 < var_104_0 then
				pg = var_2

				if var_2.activity_drop_type[var_104_0].relevance then
					::label_104_0::

					pg = var_2_10003
					var_2_10003 = var_2_10003[var_2][arg_104_0.id]
				end

				return var_2_10003
			end
		end

		return
	end

	local var_61_2 = var_0_1
	local var_61_3 = {}

	DROP_TYPE_RESOURCE = var_1_10002
	var_61_3[var_1_10002] = function(arg_105_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_105_0 = var_2_10001(var_2_10003)
		local var_105_1 = var_1.getRawData(var_105_0)

		return var_1.getResById(var_105_1, arg_105_0.id), true
	end
	DROP_TYPE_ITEM = var_1_10002
	var_61_3[var_1_10002] = function(arg_106_0)
		getProxy = var_2_10001
		BagProxy = var_2_10003

		local var_106_0 = var_2_10001(var_2_10003)
		local var_106_1 = var_1.getItemCountById(var_106_0, arg_106_0.id)
		local var_106_2 = arg_106_0:getConfig("type")

		Item = var_106_0

		if var_106_2 == var_106_0.LOVE_LETTER_TYPE then
			math = var_106_2

			return var_106_2.min(var_106_1, 1), true
		else
			return var_106_1, true
		end

		return
	end
	DROP_TYPE_EQUIP = var_1_10002
	var_61_3[var_1_10002] = function(arg_107_0)
		local var_107_0 = arg_107_0
		local var_107_1 = arg_107_0.getConfig(var_107_0, "group")

		assert = var_2_10002
		pg = var_4

		var_2_10002(var_4.equip_data_template.get_id_list_by_group[var_107_1], "equip groupId not exist")

		pg = var_2_10002

		local var_107_2 = var_2_10002.equip_data_template.get_id_list_by_group[var_107_1]

		underscore = var_107_0

		return var_107_0.reduce(var_107_2, 0, function(arg_108_0, arg_108_1)
			getProxy = var_3_10002
			EquipmentProxy = var_3_10004

			local var_108_0 = var_3_10002(var_3_10004)
			local var_108_1

			if not var_2.getEquipmentById(var_108_0, arg_108_1) or not var_2.count then
				var_108_1 = 0
			end

			local var_108_2 = arg_108_0 + var_108_1

			getProxy = var_108_0
			BayProxy = var_3_10006

			local var_108_3 = var_108_0(var_3_10006)

			return var_108_2 + var_4.GetEquipCountInShips(var_108_3, arg_108_1)
		end)
	end
	DROP_TYPE_SHIP = var_1_10002
	var_61_3[var_1_10002] = function(arg_109_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_109_0 = var_2_10001(var_2_10003)

		return var_1.getConfigShipCount(var_109_0, arg_109_0.id)
	end
	DROP_TYPE_FURNITURE = var_1_10002
	var_61_3[var_1_10002] = function(arg_110_0)
		getProxy = var_2_10001
		DormProxy = var_2_10003

		local var_110_0 = var_2_10001(var_2_10003)
		local var_110_1 = var_1.getRawData(var_110_0)

		return var_1.GetOwnFurnitureCount(var_110_1, arg_110_0.id)
	end
	DROP_TYPE_STRATEGY = var_1_10002
	var_61_3[var_1_10002] = function(arg_111_0)
		local var_111_0 = arg_111_0.count

		tobool = var_2_10002

		local var_111_1 = var_2_10002(arg_111_0.count)
	end
	DROP_TYPE_SKIN = var_1_10002
	var_61_3[var_1_10002] = function(arg_112_0)
		getProxy = var_2_10001
		ShipSkinProxy = var_2_10003

		local var_112_0 = var_2_10001(var_2_10003)

		return var_1.getSkinCountById(var_112_0, arg_112_0.id)
	end
	DROP_TYPE_SKIN_TIMELIMIT = var_1_10002
	var_61_3[var_1_10002] = function(arg_113_0)
		getProxy = var_2_10001
		ShipSkinProxy = var_2_10003

		local var_113_0 = var_2_10001(var_2_10003)

		return var_1.getSkinCountById(var_113_0, arg_113_0.id)
	end
	DROP_TYPE_VITEM = var_1_10002
	var_61_3[var_1_10002] = function(arg_114_0)
		local var_114_0 = arg_114_0:getConfig("virtual_type")

		switch = var_2_10002

		return var_2_10002(var_114_0, {
			[22] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_115_0 = var_3_10000(var_3_10002)
				local var_115_1 = var_0.getActivityById
				local var_115_2 = arg_114_0
				local var_115_3

				if not var_115_1(var_115_0, var_3.getConfig(var_115_2, "link_id")) or not var_0.data1 then
					var_115_3 = 0
				end

				return var_115_3, true
			end,
			[101] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_116_0 = var_3_10000(var_3_10002)
				local var_116_1 = var_0.getActivityById
				local var_116_2 = arg_114_0
				local var_116_3

				if not var_116_1(var_116_0, var_3.getConfig(var_116_2, "link_id")) or not var_0.data1 then
					var_116_3 = 0
				end

				return var_116_3
			end
		}, function()
			return nil
		end)
	end
	DROP_TYPE_EQUIPMENT_SKIN = var_1_10002
	var_61_3[var_1_10002] = function(arg_118_0)
		getProxy = var_2_10001
		EquipmentProxy = var_2_10003

		local var_118_0 = var_2_10001(var_2_10003)
		local var_118_1

		if not var_1.getEquipmnentSkinById(var_118_0, arg_118_0.id) or not var_1.count then
			var_118_1 = 0
		end

		getProxy = var_118_0
		BayProxy = var_2_10005

		local var_118_2 = var_118_0(var_2_10005)

		return var_118_1 + var_3.GetEquipSkinCountInShips(var_118_2, arg_118_0.id)
	end
	DROP_TYPE_RYZA_DROP = var_1_10002
	var_61_3[var_1_10002] = function(arg_119_0)
		getProxy = var_2_10001
		ActivityProxy = var_2_10003

		local var_119_0 = var_2_10001(var_2_10003)
		local var_119_1 = var_1.getActivityById

		pg = var_2_10004

		if not var_119_1(var_119_0, var_2_10004.activity_drop_type[arg_119_0.type].activity_id) then
			return 0
		end

		local var_119_2

		if not var_1:GetItemById(arg_119_0.id) or not var_2.count then
			var_119_2 = 0
		end

		return var_119_2
	end
	DROP_TYPE_ICON_FRAME = var_1_10002
	var_61_3[var_1_10002] = function(arg_120_0)
		getProxy = var_2_10001
		AttireProxy = var_2_10003

		local var_120_0 = var_2_10001(var_2_10003)
		local var_120_1 = var_1.getAttireFrame

		AttireConst = var_2_10004

		return var_120_1(var_120_0, var_2_10004.TYPE_ICON_FRAME, arg_120_0.id) and var_1:isOwned() and 1 or 0
	end
	DROP_TYPE_CHAT_FRAME = var_1_10002
	var_61_3[var_1_10002] = function(arg_121_0)
		getProxy = var_2_10001
		AttireProxy = var_2_10003

		local var_121_0 = var_2_10001(var_2_10003)
		local var_121_1 = var_1.getAttireFrame

		AttireConst = var_2_10004

		return var_121_1(var_121_0, var_2_10004.TYPE_CHAT_FRAME, arg_121_0.id) and var_1:isOwned() and 1 or 0
	end
	DROP_TYPE_WORLD_ITEM = var_1_10002
	var_61_3[var_1_10002] = function(arg_122_0)
		nowWorld = var_2_10001

		local var_122_0 = var_2_10001().type

		World = var_2_10003

		if var_122_0 ~= var_2_10003.TypeFull then
			assert = var_122_0

			var_122_0(false)

			return 0, false
		else
			local var_122_1 = var_1:GetInventoryProxy()

			return var_2.GetItemCount(var_122_1, arg_122_0.id), false
		end

		return
	end
	DROP_TYPE_COMMANDER_CAT = var_1_10002
	var_61_3[var_1_10002] = function(arg_123_0)
		getProxy = var_2_10001
		CommanderProxy = var_2_10003

		local var_123_0 = var_2_10001(var_2_10003)

		return var_1.GetSameConfigIdCommanderCount(var_123_0, arg_123_0.id)
	end
	DROP_TYPE_LIVINGAREA_COVER = var_1_10002
	var_61_3[var_1_10002] = function(arg_124_0)
		getProxy = var_2_10001
		LivingAreaCoverProxy = var_2_10003

		local var_124_0 = var_2_10001(var_2_10003)

		return var_1.GetCover(var_124_0, arg_124_0.id) and var_1:IsUnlock() and 1 or 0
	end
	DROP_TYPE_DORM3D_GIFT = var_1_10002
	var_61_3[var_1_10002] = function(arg_125_0)
		getProxy = var_2_10001
		ApartmentProxy = var_2_10003

		local var_125_0 = var_2_10001(var_2_10003)

		return var_1.getGiftCount(var_125_0, arg_125_0.id), true
	end
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10002
	var_61_3[var_1_10002] = function(arg_126_0)
		getProxy = var_2_10001
		AttireProxy = var_2_10003

		local var_126_0 = var_2_10001(var_2_10003)
		local var_126_1 = var_1.getAttireFrame

		AttireConst = var_2_10004

		local var_126_2 = var_126_1(var_126_0, var_2_10004.TYPE_COMBAT_UI_STYLE, arg_126_0.id)

		return 1
	end
	DROP_TYPE_ISLAND_ITEM = var_1_10002
	var_61_3[var_1_10002] = function(arg_127_0)
		local var_127_0 = 0

		getProxy = var_2_10002
		IslandProxy = var_2_10004

		local var_127_1 = var_2_10002(var_2_10004)

		if var_2.GetIsland(var_127_1) then
			local var_127_2 = var_2:GetInventoryAgency()

			var_127_0 = var_3.GetOwnCount(var_127_2, arg_127_0.id)
		end

		return var_127_0
	end
	DROP_TYPE_ISLAND_ABILITY = var_1_10002
	var_61_3[var_1_10002] = function(arg_128_0)
		return 0
	end
	DROP_TYPE_ISLAND_INVITATION = var_1_10002
	var_61_3[var_1_10002] = function(arg_129_0)
		return 0
	end
	DROP_TYPE_ISLAND_FURNITURE = var_1_10002
	var_61_3[var_1_10002] = function(arg_130_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		local var_130_0 = var_2_10001(var_2_10003)

		if var_1.GetIsland(var_130_0) then
			local var_130_1 = var_1:GetAgoraAgency()
			local var_130_2 = var_2.GetFurnitures(var_130_1)

			ipairs = var_130_0

			for iter_130_0, iter_130_1 in var_130_0(var_130_2) do
				if iter_130_1.id == arg_130_0.id then
					return iter_130_1.count
				end
			end
		end

		return 0
	end
	DROP_TYPE_ISLAND_DRESS = var_1_10002
	var_61_3[var_1_10002] = function(arg_131_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		local var_131_0 = var_2_10001(var_2_10003)

		if var_1.GetIsland(var_131_0) then
			if arg_131_0:getConfig("belongto") == 1 then
				local var_131_1 = var_1:GetDressUpAgency()

				return var_3.CheckOwnDress(var_131_1, arg_131_0.id) and 1 or 0
			elseif var_2 == 2 then
				local var_131_2 = var_1:GetCharacterAgency()

				return var_3.GetDressIdRealCount(var_131_2, arg_131_0.id)
			end
		end

		return 0
	end
	DROP_TYPE_ISLAND_SKIN = var_1_10002
	var_61_3[var_1_10002] = function(arg_132_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		if not var_2_10001(var_2_10003) then
			return 0
		end

		if var_1:GetIsland() then
			local var_132_0 = var_2:GetCharacterAgency()

			return var_3.CheckSkinIsOwned(var_132_0, arg_132_0.id) and 1 or 0
		end

		return 0
	end
	DROP_TYPE_ISLAND_ACTION = var_1_10002
	var_61_3[var_1_10002] = function(arg_133_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		if not var_2_10001(var_2_10003) then
			return 0
		end

		if var_1:GetIsland() then
			local var_133_0 = var_2:GetActionAgency()

			return var_3.ExistAction(var_133_0, arg_133_0.id) and 1 or 0
		end

		return 0
	end
	VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_1_10002
	var_61_3[var_1_10002] = function(arg_134_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		if not var_2_10001(var_2_10003) then
			return 0
		end

		if var_1:GetIsland() then
			local var_134_0 = var_2:GetSeasonAgency()
			local var_134_1 = var_3.GetSeason(var_134_0)

			return var_3.GetPt(var_134_1)
		end

		return 0
	end
	DROP_TYPE_ISLAND_CARD_DIY = var_1_10002
	var_61_3[var_1_10002] = function(arg_135_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		if not var_2_10001(var_2_10003) then
			return 0
		end

		if var_1:GetIsland() then
			local var_135_0 = var_2:GetCardDiyAgency()

			return var_3.GetIdCount(var_135_0, arg_135_0.id)
		end

		return 0
	end
	var_61_2.CountCase = var_61_3

	function var_0_1.CountDefault(arg_136_0)
		local var_136_0 = arg_136_0.type

		DROP_TYPE_USE_ACTIVITY_DROP = var_2_10002

		if var_2_10002 < var_136_0 then
			getProxy = var_2_10002
			ActivityProxy = var_2_10004

			local var_136_1 = var_2_10002(var_2_10004)
			local var_136_2 = var_2.getActivityById

			pg = var_2_10005

			local var_136_3 = var_136_2(var_136_1, var_2_10005.activity_drop_type[var_136_0].activity_id)

			return var_2.getVitemNumber(var_136_3, arg_136_0.id)
		else
			return 0, false
		end

		return
	end

	local var_61_4 = var_0_1
	local var_61_5 = {}

	DROP_TYPE_FURNITURE = var_1_10002
	var_61_5[var_1_10002] = function(arg_137_0)
		return arg_137_0:getConfig("count")
	end
	DROP_TYPE_ICON_FRAME = var_1_10002
	var_61_5[var_1_10002] = function(arg_138_0)
		return 1
	end
	DROP_TYPE_CHAT_FRAME = var_1_10002
	var_61_5[var_1_10002] = function(arg_139_0)
		return 1
	end
	DROP_TYPE_SKIN = var_1_10002
	var_61_5[var_1_10002] = function(arg_140_0)
		return 1
	end
	var_61_4.LimitCase = var_61_5

	function var_0_1.LimitDefault(arg_141_0)
		return 0
	end

	local var_61_6 = var_0_1
	local var_61_7 = {}

	DROP_TYPE_RESOURCE = var_1_10002
	var_61_7[var_1_10002] = function(arg_142_0)
		return
	end
	DROP_TYPE_ITEM = var_1_10002
	var_61_7[var_1_10002] = function(arg_143_0)
		Item = var_2_10001

		return var_2_10001.New(arg_143_0)
	end
	DROP_TYPE_VITEM = var_1_10002
	var_61_7[var_1_10002] = function(arg_144_0)
		Item = var_2_10001

		return var_2_10001.New(arg_144_0)
	end
	DROP_TYPE_EQUIP = var_1_10002
	var_61_7[var_1_10002] = function(arg_145_0)
		Equipment = var_2_10001

		return var_2_10001.New(arg_145_0)
	end
	DROP_TYPE_LOVE_LETTER = var_1_10002
	var_61_7[var_1_10002] = function(arg_146_0)
		Item = var_2_10001

		return var_2_10001.New({
			count = 1,
			id = arg_146_0.id,
			extra = arg_146_0.count
		})
	end
	DROP_TYPE_WORLD_ITEM = var_1_10002
	var_61_7[var_1_10002] = function(arg_147_0)
		WorldItem = var_2_10001

		return var_2_10001.New(arg_147_0)
	end
	var_61_6.SubClassCase = var_61_7

	function var_0_1.SubClassDefault(arg_148_0)
		assert = var_2_10001

		local var_148_0 = false

		string = var_2_10004

		var_2_10001(var_148_0, var_2_10004.format("drop type %d without subClass", arg_148_0.type))

		return
	end

	local var_61_8 = var_0_1
	local var_61_9 = {}

	DROP_TYPE_RESOURCE = var_1_10002
	var_61_9[var_1_10002] = function(arg_149_0)
		return arg_149_0:getConfig("rarity")
	end
	DROP_TYPE_ITEM = var_1_10002
	var_61_9[var_1_10002] = function(arg_150_0)
		return arg_150_0:getConfig("rarity")
	end
	DROP_TYPE_EQUIP = var_1_10002
	var_61_9[var_1_10002] = function(arg_151_0)
		return arg_151_0:getConfig("rarity") - 1
	end
	DROP_TYPE_SHIP = var_1_10002
	var_61_9[var_1_10002] = function(arg_152_0)
		return arg_152_0:getConfig("rarity") - 1
	end
	DROP_TYPE_FURNITURE = var_1_10002
	var_61_9[var_1_10002] = function(arg_153_0)
		return arg_153_0:getConfig("rarity")
	end
	DROP_TYPE_SKIN = var_1_10002
	var_61_9[var_1_10002] = function(arg_154_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	DROP_TYPE_SKIN_TIMELIMIT = var_1_10002
	var_61_9[var_1_10002] = function(arg_155_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	DROP_TYPE_VITEM = var_1_10002
	var_61_9[var_1_10002] = function(arg_156_0)
		return arg_156_0:getConfig("rarity")
	end
	DROP_TYPE_WORLD_ITEM = var_1_10002
	var_61_9[var_1_10002] = function(arg_157_0)
		return arg_157_0:getConfig("rarity")
	end
	DROP_TYPE_BUFF = var_1_10002
	var_61_9[var_1_10002] = function(arg_158_0)
		ItemRarity = var_2_10001

		return var_2_10001.Purple
	end
	DROP_TYPE_COMMANDER_CAT = var_1_10002
	var_61_9[var_1_10002] = function(arg_159_0)
		return arg_159_0:getConfig("rarity") - 1
	end
	DROP_TYPE_DORM3D_FURNITURE = var_1_10002
	var_61_9[var_1_10002] = function(arg_160_0)
		return arg_160_0:getConfig("rarity")
	end
	DROP_TYPE_DORM3D_SKIN = var_1_10002
	var_61_9[var_1_10002] = function(arg_161_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	DROP_TYPE_WORLD_COLLECTION = var_1_10002
	var_61_9[var_1_10002] = function(arg_162_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10002
	var_61_9[var_1_10002] = function(arg_163_0)
		return arg_163_0:getConfig("rare")
	end
	DROP_TYPE_ACTIVITY_MEDAL = var_1_10002
	var_61_9[var_1_10002] = function(arg_164_0)
		return arg_164_0:getConfig("rarity")
	end
	DROP_TYPE_ISLAND_ITEM = var_1_10002
	var_61_9[var_1_10002] = function(arg_165_0)
		return arg_165_0:getConfig("rarity")
	end
	DROP_TYPE_ISLAND_ABILITY = var_1_10002
	var_61_9[var_1_10002] = function(arg_166_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	DROP_TYPE_ISLAND_INVITATION = var_1_10002
	var_61_9[var_1_10002] = function(arg_167_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	DROP_TYPE_ISLAND_FURNITURE = var_1_10002
	var_61_9[var_1_10002] = function(arg_168_0)
		return arg_168_0:getConfig("rarity")
	end
	DROP_TYPE_ISLAND_DRESS = var_1_10002
	var_61_9[var_1_10002] = function(arg_169_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	DROP_TYPE_ISLAND_SKIN = var_1_10002
	var_61_9[var_1_10002] = function(arg_170_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_1_10002
	var_61_9[var_1_10002] = function(arg_171_0)
		ItemRarity = var_2_10001

		return var_2_10001.Gold
	end
	var_61_8.RarityCase = var_61_9

	function var_0_1.RarityDefault(arg_172_0)
		local var_172_0

		if not arg_172_0:getConfig("rarity") then
			ItemRarity = var_172_0
			var_172_0 = var_172_0.Gray
		end

		return var_172_0
	end

	function var_0_1.RarityDefaultDorm(arg_173_0)
		local var_173_0

		if not arg_173_0:getConfig("rarity") then
			ItemRarity = var_173_0
			var_173_0 = var_173_0.Purple
		end

		return var_173_0
	end

	local var_61_10 = var_0_1
	local var_61_11 = {}

	DROP_TYPE_TRANS_ITEM = var_1_10002
	var_61_11[var_1_10002] = function(arg_174_0)
		Drop = var_2_10001

		local var_174_0 = var_2_10001.New({
			type = arg_174_0:getConfig("type"),
			id = arg_174_0:getConfig("resource_type"),
			count = arg_174_0:getConfig("resource_num") * arg_174_0.count
		})

		Drop = var_2_10002

		local var_174_1 = var_2_10002.New({
			type = arg_174_0:getConfig("target_type"),
			id = arg_174_0:getConfig("target_id"),
			count = arg_174_0.count
		})

		PlayerConst = var_3

		var_3.UpdateLinkActivity({
			var_174_1
		})

		string = var_3
		var_174_0.name = var_3.format("%s(%s)", var_174_0:getName(), var_174_1:getName())

		return var_174_0
	end
	DROP_TYPE_RESOURCE = var_1_10002
	var_61_11[var_1_10002] = function(arg_175_0)
		ipairs = var_2_10001
		getProxy = var_2_10003
		ActivityProxy = var_2_10005

		local var_175_0 = var_2_10003(var_2_10005)
		local var_175_1 = var_3.getActivitiesByType

		ActivityConst = var_2_10006

		for iter_175_0, iter_175_1 in var_2_10001(var_175_1(var_175_0, var_2_10006.ACTIVITY_TYPE_PT_CRUSING)) do
			pg = var_6

			if var_6.battlepass_event_pt[iter_175_1.id].pt == arg_175_0.id then
				return nil, arg_175_0
			end
		end

		ipairs = var_1
		getProxy = var_3
		ActivityProxy = iter_175_1

		local var_175_2 = var_3(iter_175_1)
		local var_175_3 = var_3.getActivitiesByType

		ActivityConst = var_6

		for iter_175_2, iter_175_3 in var_1(var_175_3(var_175_2, var_6.ACTIVITY_TYPE_PT_HEI5)) do
			pg = var_6

			if var_6.black_friday_battlepass_event_pt[iter_175_3.id].pt == arg_175_0.id then
				return nil, arg_175_0
			end
		end

		return arg_175_0
	end
	DROP_TYPE_OPERATION = var_1_10002
	var_61_11[var_1_10002] = function(arg_176_0)
		if arg_176_0.id ~= 3 then
			return nil
		end

		return arg_176_0
	end
	DROP_TYPE_EMOJI = var_1_10002
	var_61_11[var_1_10002] = function(arg_177_0)
		return nil, arg_177_0
	end
	DROP_TYPE_VITEM = var_1_10002
	var_61_11[var_1_10002] = function(arg_178_0, arg_178_1, arg_178_2)
		assert = var_2_10003

		var_2_10003(arg_178_0:getConfig("type") == 0, "item type error:must be virtual type from " .. arg_178_0.id)

		switch = var_2_10003

		return var_2_10003(arg_178_0:getConfig("virtual_type"), {
			function()
				local var_179_0 = arg_178_0
				local var_179_1 = var_0.getConfig(var_179_0, "link_id")

				ActivityConst = var_3_10001

				if var_179_1 == var_3_10001.LINLK_DUNHUANG_ACT then
					return nil, arg_178_0
				end

				return arg_178_0
			end,
			[6] = function()
				local var_180_0 = arg_178_2.taskId

				getProxy = var_3_10001
				ActivityProxy = var_3_10003

				local var_180_1 = var_3_10001(var_3_10003)
				local var_180_2 = var_1.getActivityByType

				ActivityConst = var_3_10005

				if var_180_2(var_180_1, var_3_10005.ACTIVITY_TYPE_REFLUX) then
					local var_180_3 = var_2.data1KeyValueList[1]

					defaultValue = var_180_1
					var_180_3[var_180_0] = var_180_1(var_180_3[var_180_0], 0) + arg_178_0.count

					var_1:updateActivity(var_2)
				end

				return nil, arg_178_0
			end,
			[13] = function()
				local var_181_0 = arg_178_0
				local var_181_1 = var_0.getName(var_181_0)

				getProxy = var_3_10001
				ActivityProxy = var_3_10003

				local var_181_2 = var_3_10001(var_3_10003)
				local var_181_3 = var_1.getActivityById
				local var_181_4 = arg_178_0

				if not var_181_3(var_181_2, var_4.getConfig(var_181_4, "link_id")) or var_1:isEnd() then
					pg = var_181_0

					local var_181_5 = var_181_0.TipsMgr.GetInstance()
					local var_181_6 = var_2.ShowTips

					i18n = var_3_10005

					var_181_6(var_181_5, var_3_10005("coupon_timeout_tip", var_181_1))

					return nil
				elseif var_1:IsMaxCnt() then
					pg = var_2

					local var_181_7 = var_2.TipsMgr.GetInstance()
					local var_181_8 = var_2.ShowTips

					i18n = var_3_10005

					var_181_8(var_181_7, var_3_10005("coupon_repeat_tip", var_181_1))

					return nil
				else
					return arg_178_0, nil
				end

				return
			end,
			[17] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_182_0 = var_3_10000(var_3_10002)
				local var_182_1 = var_0.getActivityById
				local var_182_2 = arg_178_0
				local var_182_3

				if var_182_1(var_182_0, var_3.getConfig(var_182_2, "link_id")).data1 < 1 then
					Drop = var_182_3
					var_182_3 = var_182_3.New

					local var_182_4 = {
						count = 1
					}

					DROP_TYPE_SHIP = var_3_10004
					var_182_4.type = var_3_10004
					var_182_4.id = var_0:getConfig("config_id")

					return var_182_3(var_182_4), arg_178_0
				else
					Drop = var_182_3

					local var_182_5 = var_182_3.New
					local var_182_6 = {
						id = 3
					}

					DROP_TYPE_OPERATION = var_3_10004
					var_182_6.type = var_3_10004
					var_182_6.count = var_0.data2

					return var_182_5(var_182_6), arg_178_0
				end

				return
			end,
			[21] = function()
				return nil, arg_178_0
			end,
			[28] = function()
				Drop = var_3_10000

				local var_184_0 = var_3_10000.New
				local var_184_1 = {
					type = arg_178_0.type,
					id = arg_178_0.id
				}

				math = var_3
				var_184_1.count = var_3.floor(arg_178_0.count / 1000)

				local var_184_2 = var_184_0(var_184_1)

				Drop = var_3_10001

				local var_184_3 = var_3_10001.New
				local var_184_4 = {
					type = arg_178_0.type,
					id = arg_178_0.id
				}
				local var_184_5 = arg_178_0.count

				math = var_5
				var_184_4.count = var_184_5 - var_5.floor(arg_178_0.count / 1000)

				local var_184_6 = var_184_3(var_184_4)

				return var_184_2, var_184_6
			end
		}, function()
			return arg_178_0
		end)
	end
	DROP_TYPE_SHIP = var_1_10002
	var_61_11[var_1_10002] = function(arg_186_0, arg_186_1)
		Ship = var_2_10002

		if var_2_10002.isMetaShipByConfigID(arg_186_0.id) then
			Player = var_2

			if var_2.isMetaShipNeedToTrans(arg_186_0.id) then
				table = var_2

				if var_2.indexof(arg_186_1, arg_186_0.id, 1) then
					table = var_2_10003

					var_2_10003.remove(arg_186_1, var_2)
				else
					Player = var_2_10003

					local var_186_0 = var_2_10003.metaShip2Res(arg_186_0.id)

					Drop = var_4

					local var_186_1 = var_4.New(var_186_0[1])

					getProxy = var_5
					BayProxy = var_2_10007

					local var_186_2 = var_5(var_2_10007)

					var_5.addMetaTransItemMap(var_186_2, arg_186_0.id, var_186_1)

					return arg_186_0, var_186_1
				end
			end
		end

		return arg_186_0
	end
	DROP_TYPE_SKIN = var_1_10002
	var_61_11[var_1_10002] = function(arg_187_0)
		getProxy = var_2_10001
		ShipSkinProxy = var_2_10003

		local var_187_0 = var_2_10001(var_2_10003)

		arg_187_0.isNew = not var_1.hasNonLimitSkin(var_187_0, arg_187_0.id)

		return arg_187_0
	end
	DROP_TYPE_ACTIVITY_MEDAL = var_1_10002
	var_61_11[var_1_10002] = function(arg_188_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10003

		local var_188_0 = var_2_10001(var_2_10003)
		local var_188_1 = var_1.getRawData(var_188_0)

		pg = var_2_10002

		local var_188_2 = var_2_10002.TimeMgr.GetInstance()
		local var_188_3 = var_2.GetServerTime(var_188_2)

		var_188_1:updateMedalList({
			{
				key = arg_188_0.id,
				value = var_188_3
			}
		})

		return arg_188_0
	end
	DROP_TYPE_BUFF = var_1_10002
	var_61_11[var_1_10002] = function(arg_189_0)
		return nil, arg_189_0
	end
	var_61_10.TransCase = var_61_11

	function var_0_1.TransDefault(arg_190_0)
		return arg_190_0
	end

	local var_61_12 = var_0_1
	local var_61_13 = {}

	DROP_TYPE_RESOURCE = var_1_10002
	var_61_13[var_1_10002] = function(arg_191_0)
		id2res = var_2_10001

		local var_191_0 = var_2_10001(arg_191_0.id)

		assert = var_2_10002

		var_2_10002(var_191_0, "res should be defined: " .. arg_191_0.id)

		getProxy = var_2_10002
		PlayerProxy = var_4

		local var_191_1 = var_2_10002(var_4)
		local var_191_2 = var_2.getData(var_191_1)

		var_3.addResources(var_191_2, {
			[var_191_0] = arg_191_0.count
		})
		var_2:updatePlayer(var_3)

		return
	end
	DROP_TYPE_ITEM = var_1_10002
	var_61_13[var_1_10002] = function(arg_192_0)
		local var_192_0 = arg_192_0
		local var_192_1 = arg_192_0.getConfig(var_192_0, "type")

		Item = var_2_10002

		if var_192_1 == var_2_10002.EXP_BOOK_TYPE then
			getProxy = var_192_1
			BagProxy = var_192_0
			var_192_0 = var_192_1(var_192_0)
			var_192_1 = var_192_1.getItemCountById(var_192_0, arg_192_0.id)
			math = var_2

			local var_192_2 = var_2.min(arg_192_0:getConfig("max_num") - var_192_1, arg_192_0.count)

			if 0 < var_192_2 then
				getProxy = var_192_0
				BagProxy = var_5

				local var_192_3 = var_192_0(var_5)

				var_192_0.addItemById(var_192_3, arg_192_0.id, var_192_2)
			end
		else
			getProxy = var_192_1
			BagProxy = var_192_0

			local var_192_4 = var_192_1(var_192_0)

			var_1.addItemById(var_192_4, arg_192_0.id, arg_192_0.count, arg_192_0.extra)
		end

		return
	end
	DROP_TYPE_LOVE_LETTER = var_1_10002
	var_61_13[var_1_10002] = function(arg_193_0)
		local var_193_0 = arg_193_0:getSubClass()

		getProxy = var_2_10002
		BagProxy = var_2_10004

		local var_193_1 = var_2_10002(var_2_10004)

		var_2.addItemById(var_193_1, var_193_0.id, var_193_0.count, var_193_0.extra)

		return
	end
	DROP_TYPE_EQUIP = var_1_10002
	var_61_13[var_1_10002] = function(arg_194_0)
		getProxy = var_2_10001
		EquipmentProxy = var_2_10003

		local var_194_0 = var_2_10001(var_2_10003)

		var_1.addEquipmentById(var_194_0, arg_194_0.id, arg_194_0.count)

		return
	end
	DROP_TYPE_SHIP = var_1_10002
	var_61_13[var_1_10002] = function(arg_195_0)
		return
	end
	DROP_TYPE_FURNITURE = var_1_10002
	var_61_13[var_1_10002] = function(arg_196_0)
		getProxy = var_2_10001
		DormProxy = var_2_10003

		local var_196_0 = var_2_10001(var_2_10003)

		Furniture = var_2_10002

		local var_196_1 = var_2_10002.New({
			id = arg_196_0.id,
			count = arg_196_0.count
		})

		if var_2.isRecordTime(var_196_1) then
			pg = var_3

			local var_196_2 = var_3.TimeMgr.GetInstance()

			var_2.date = var_3.GetServerTime(var_196_2)
		end

		local var_196_3 = var_196_0:getRawData()

		var_3.AddFurniture(var_196_3, var_2)

		local var_196_4 = var_196_0
		local var_196_5 = var_196_0.updateDrom
		local var_196_6 = var_3

		BackYardConst = var_2_10008

		var_196_5(var_196_4, var_196_6, var_2_10008.DORM_UPDATE_TYPE_FURNITURE)

		return
	end
	DROP_TYPE_SKIN = var_1_10002
	var_61_13[var_1_10002] = function(arg_197_0)
		getProxy = var_2_10001
		ShipSkinProxy = var_2_10003

		local var_197_0 = var_2_10001(var_2_10003)

		ShipSkin = var_2_10002

		local var_197_1 = var_2_10002.New({
			id = arg_197_0.id
		})

		var_197_0:addSkin(var_197_1)

		return
	end
	DROP_TYPE_VITEM = var_1_10002
	var_61_13[var_1_10002] = function(arg_198_0)
		arg_198_0 = arg_198_0:getSubClass()
		assert = var_1

		var_1(arg_198_0:isVirtualItem(), "item type error(virtual item)>>" .. arg_198_0.id)

		switch = var_1

		var_1(arg_198_0:getConfig("virtual_type"), {
			[0] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_199_0 = var_3_10000(var_3_10002)

				var_0.addVitemById(var_199_0, arg_198_0.id, arg_198_0.count)

				return
			end,
			function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_200_0 = var_3_10000(var_3_10002)
				local var_200_1 = arg_198_0
				local var_200_2 = var_1.getConfig(var_200_1, "link_id")
				local var_200_3

				if var_200_2 > 0 then
					var_200_3 = var_200_0:getActivityById(var_200_2)
				else
					local var_200_4 = var_200_0
					local var_200_5 = var_200_0.getActivityByType

					ActivityConst = var_3_10006
					var_200_3 = var_200_5(var_200_4, var_3_10006.ACTIVITY_TYPE_PUZZLA)
				end

				if var_200_3 and not var_200_3:isEnd() then
					table = var_3

					if not var_3.contains(var_200_3.data1_list, arg_198_0.id) then
						table = var_3

						var_3.insert(var_200_3.data1_list, arg_198_0.id)
					end

					var_200_0:updateActivity(var_200_3)
				end

				return
			end,
			function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_201_0 = var_3_10000(var_3_10002)
				local var_201_1 = var_0.getActivitiesByType

				ActivityConst = var_3_10004

				local var_201_2 = var_201_1(var_201_0, var_3_10004.ACTIVITY_TYPE_VOTE)

				ipairs = var_3_10002

				for iter_201_0, iter_201_1 in var_3_10002(var_201_2) do
					iter_201_1.data1 = iter_201_1.data1 + arg_198_0.count

					local var_201_3 = iter_201_1:getConfig("config_id")

					pg = var_8

					if var_8.activity_vote[var_201_3] and var_8.ticket_id_period == arg_198_0.id then
						iter_201_1.data3 = iter_201_1.data3 + arg_198_0.count
					end

					var_0:updateActivity(iter_201_1)

					pg = var_9

					local var_201_4 = var_9.ToastMgr.GetInstance()
					local var_201_5 = var_9.ShowToast

					pg = var_12

					var_201_5(var_201_4, var_12.ToastMgr.TYPE_VOTE, {
						ptId = arg_198_0.id,
						ptCount = arg_198_0.count
					})
				end

				return
			end,
			[4] = function()
				getProxy = var_3_10000
				ColoringProxy = var_3_10002

				local var_202_0 = var_3_10000(var_3_10002)
				local var_202_1 = var_0.getColorItems(var_202_0)
				local var_202_2 = arg_198_0.id
				local var_202_3

				if not var_202_1[arg_198_0.id] then
					var_202_3 = 0
				end

				var_202_1[var_202_2] = var_202_3 + arg_198_0.count

				return
			end,
			[6] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_203_0 = var_3_10000(var_3_10002)
				local var_203_1 = var_0.getActivityByType

				ActivityConst = var_3_10004

				if var_203_1(var_203_0, var_3_10004.ACTIVITY_TYPE_REFLUX) then
					var_1.data3 = var_1.data3 + arg_198_0.count

					var_0:updateActivity(var_1)
				end

				return
			end,
			[7] = function()
				getProxy = var_3_10000
				ChapterProxy = var_3_10002

				local var_204_0 = var_3_10000(var_3_10002)
				local var_204_1 = var_0.updateRemasterTicketsNum

				math = var_3_10004

				local var_204_2 = var_3_10004.min
				local var_204_3 = var_0.remasterTickets + arg_198_0.count

				pg = var_7

				var_204_1(var_204_0, var_204_2(var_204_3, var_7.gameset.reactivity_ticket_max.key_value))

				return
			end,
			[9] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_205_0 = var_3_10000(var_3_10002)

				getProxy = var_3_10001
				ActivityProxy = var_3_10003

				local var_205_1 = var_3_10001(var_3_10003)
				local var_205_2 = var_1.getActivityByType

				ActivityConst = var_3_10004

				if var_205_2(var_205_1, var_3_10004.ACTIVITY_TYPE_MONOPOLY) then
					var_1.data1_list[1] = var_1.data1_list[1] + arg_198_0.count

					var_205_0:updateActivity(var_1)
				end

				return
			end,
			[11] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_206_0 = var_3_10000(var_3_10002)
				local var_206_1 = var_0.getActivityByType

				ActivityConst = var_3_10004

				if var_206_1(var_206_0, var_3_10004.ACTIVITY_TYPE_RED_PACKETS) and not var_1:isEnd() then
					var_1.data1 = var_1.data1 + arg_198_0.count
				end

				return
			end,
			[12] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_207_0 = var_3_10000(var_3_10002)
				local var_207_1 = var_0.getActivityByType

				ActivityConst = var_3_10004

				if var_207_1(var_207_0, var_3_10004.ACTIVITY_TYPE_BUILDING_BUFF) and not var_1:isEnd() then
					local var_207_2 = var_1.data1KeyValueList[1]
					local var_207_3 = arg_198_0.id
					local var_207_4

					if not var_1.data1KeyValueList[1][arg_198_0.id] then
						var_207_4 = 0
					end

					var_207_2[var_207_3] = var_207_4 + arg_198_0.count
				end

				return
			end,
			[13] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_208_0 = var_3_10000(var_3_10002)
				local var_208_1 = var_0.getActivityById
				local var_208_2 = arg_198_0
				local var_208_3 = var_208_1(var_208_0, var_3.getConfig(var_208_2, "link_id"))

				if var_0.IsMaxCnt(var_208_3) then
					pg = var_1
					var_208_3 = var_1.TipsMgr.GetInstance()

					local var_208_4 = var_1.ShowTips

					i18n = var_3_10004

					var_208_4(var_208_3, var_3_10004("common_already owned"))

					return
				end

				var_0.data1 = var_0.data1 + arg_198_0.count
				getProxy = var_1
				ActivityProxy = var_208_3

				local var_208_5 = var_1(var_208_3)

				var_1.updateActivity(var_208_5, var_0)

				return
			end,
			[14] = function()
				nowWorld = var_3_10000

				local var_209_0 = var_3_10000()
				local var_209_1 = var_0.GetBossProxy(var_209_0)

				WorldBossConst = var_3_10001

				if var_3_10001.WORLD_BOSS_ITEM_ID == arg_198_0.id then
					var_209_1:AddSummonPt(arg_198_0.count)
				else
					WorldBossConst = var_1

					if var_1.WORLD_PAST_BOSS_ITEM_ID == arg_198_0.id then
						var_209_1:AddSummonPtOld(arg_198_0.count)
					end
				end

				return
			end,
			[15] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_210_0 = var_3_10000(var_3_10002)
				local var_210_1 = var_0.getActivityById
				local var_210_2 = arg_198_0

				if not var_210_1(var_210_0, var_4.getConfig(var_210_2, "link_id")) or var_1:isEnd() then
					return
				end

				local var_210_3 = var_1:getConfig("type")

				ActivityConst = var_210_0

				if var_210_3 == var_210_0.ACTIVITY_TYPE_WORLDINPICTURE then
					pg = var_210_3

					local var_210_4 = var_210_3.activity_event_grid[var_1.data1]

					if arg_198_0.id == var_210_4.ticket_item then
						var_1.data2 = var_1.data2 + arg_198_0.count
					elseif arg_198_0.id == var_210_4.explore_item then
						var_1.data3 = var_1.data3 + arg_198_0.count
					end
				else
					local var_210_5 = var_1:getConfig("type")

					ActivityConst = var_3

					if var_210_5 == var_3.ACTIVITY_TYPE_EXPEDITION then
						var_1.data3 = var_1.data3 + arg_198_0.count
					end
				end

				var_0:updateActivity(var_1)

				return
			end,
			[16] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_211_0 = var_3_10000(var_3_10002)
				local var_211_1 = var_0.getActivitiesByType

				ActivityConst = var_3_10004

				local var_211_2 = var_211_1(var_211_0, var_3_10004.ACTIVITY_TYPE_SHAKE_BEADS)

				pairs = var_3_10002

				for iter_211_0, iter_211_1 in var_3_10002(var_211_2) do
					if iter_211_1 and not iter_211_1:isEnd() and arg_198_0.id == iter_211_1:getConfig("config_id") then
						iter_211_1.data1 = iter_211_1.data1 + arg_198_0.count

						var_0:updateActivity(iter_211_1)
					end
				end

				return
			end,
			[17] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_212_0 = var_3_10000(var_3_10002)
				local var_212_1 = var_0.getActivityById
				local var_212_2 = arg_198_0

				if not var_212_1(var_212_0, var_4.getConfig(var_212_2, "link_id")) or var_1:isEnd() then
					return
				end

				var_1.data1 = 2

				var_0:updateActivity(var_1)

				return
			end,
			[20] = function()
				getProxy = var_3_10000
				BagProxy = var_3_10002

				local var_213_0 = var_3_10000(var_3_10002)

				pg = var_3_10001

				local var_213_1 = var_3_10001.gameset.urpt_chapter_max.description[1]
				local var_213_2 = var_1[2]
				local var_213_3 = var_213_0:GetLimitCntById(var_213_1)

				math = var_3_10005

				if var_3_10005.min(var_213_2 - var_213_3, arg_198_0.count) > 0 then
					var_213_0:addItemById(var_213_1, var_5)
					var_213_0:AddLimitCnt(var_213_1, var_5)
				end

				return
			end,
			[21] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_214_0 = var_3_10000(var_3_10002)
				local var_214_1 = var_0.getActivityById
				local var_214_2 = arg_198_0

				if var_214_1(var_214_0, var_4.getConfig(var_214_2, "link_id")) and not var_1:isEnd() then
					var_1.data2 = 1

					var_0:updateActivity(var_1)
				end

				return
			end,
			[22] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_215_0 = var_3_10000(var_3_10002)
				local var_215_1 = var_0.getActivityById
				local var_215_2 = arg_198_0

				if var_215_1(var_215_0, var_4.getConfig(var_215_2, "link_id")) and not var_1:isEnd() then
					var_1.data1 = var_1.data1 + arg_198_0.count

					var_0:updateActivity(var_1)
				end

				return
			end,
			[23] = function()
				local var_216_0 = (function()
					ipairs = var_4_10000
					pg = var_4_10002

					for iter_217_0, iter_217_1 in var_4_10000(var_4_10002.gameset.package_lv.description) do
						if arg_198_0.id == iter_217_1[1] then
							return iter_217_1[2]
						end
					end

					return
				end)()

				assert = var_3_10001

				var_3_10001(var_216_0)

				getProxy = var_3_10001
				PlayerProxy = var_3

				local var_216_1 = var_3_10001(var_3)
				local var_216_2 = var_1.getData(var_216_1)

				var_2.addExpToLevel(var_216_2, var_216_0)
				var_1:updatePlayer(var_2)

				return
			end,
			[24] = function()
				local var_218_0 = arg_198_0
				local var_218_1 = var_0.getConfig(var_218_0, "link_id")

				getProxy = var_3_10001
				ActivityProxy = var_3

				local var_218_2 = var_3_10001(var_3)

				if var_1.getActivityById(var_218_2, var_218_1) and not var_1:isEnd() then
					local var_218_3 = var_1
					local var_218_4 = var_1.getConfig(var_218_3, "type")

					ActivityConst = var_218_2

					if var_218_4 == var_218_2.ACTIVITY_TYPE_HOTSPRING then
						var_1.data2 = var_1.data2 + arg_198_0.count
						getProxy = var_2
						ActivityProxy = var_218_3

						local var_218_5 = var_2(var_218_3)

						var_2.updateActivity(var_218_5, var_1)
					end
				end

				return
			end,
			[25] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_219_0 = var_3_10000(var_3_10002)
				local var_219_1 = var_0.getActivityByType

				ActivityConst = var_3_10004

				if var_219_1(var_219_0, var_3_10004.ACTIVITY_TYPE_FIREWORK) and not var_1:isEnd() then
					var_1.data1 = var_1.data1 - 1
					table = var_2

					if not var_2.contains(var_1.data1_list, arg_198_0.id) then
						table = var_2

						var_2.insert(var_1.data1_list, arg_198_0.id)
					end

					var_0:updateActivity(var_1)

					local var_219_2 = arg_198_0

					if var_2.getConfig(var_219_2, "link_id") > 0 and var_0:getActivityById(var_2) and not var_3:isEnd() then
						var_3.data1 = var_3.data1 + 1

						var_0:updateActivity(var_3)
					end
				end

				return
			end,
			[26] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_220_0 = var_3_10000(var_3_10002)

				Clone = var_3_10001

				local var_220_1 = var_220_0
				local var_220_2 = var_220_0.getActivityByType

				ActivityConst = var_3_10006

				if var_3_10001(var_220_2(var_220_1, var_3_10006.ACTIVITY_TYPE_PT_CRUSING)) and not var_1:isEnd() then
					var_1.data1 = var_1.data1 + arg_198_0.count

					var_220_0:updateActivity(var_1)
				end

				return
			end,
			[27] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_221_0 = var_3_10000(var_3_10002)

				Clone = var_3_10001

				local var_221_1 = var_221_0
				local var_221_2 = var_221_0.getActivityByType

				ActivityConst = var_3_10006

				if var_3_10001(var_221_2(var_221_1, var_3_10006.ACTIVITY_TYPE_TOWN)) and not var_1:isEnd() then
					var_1:AddExp(arg_198_0.count)
					var_221_0:updateActivity(var_1)
				end

				return
			end,
			[28] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_222_0 = var_3_10000(var_3_10002)

				Clone = var_3_10001

				local var_222_1 = var_222_0
				local var_222_2 = var_222_0.getActivityByType

				ActivityConst = var_3_10006

				if var_3_10001(var_222_2(var_222_1, var_3_10006.ACTIVITY_TYPE_TOWN)) and not var_1:isEnd() then
					var_1:AddGold(arg_198_0.count)
					var_222_0:updateActivity(var_1)
				end

				return
			end,
			[29] = function()
				getProxy = var_3_10000
				ActivityProxy = var_3_10002

				local var_223_0 = var_3_10000(var_3_10002)

				Clone = var_3_10001

				local var_223_1 = var_223_0
				local var_223_2 = var_223_0.getActivityByType

				ActivityConst = var_3_10006

				if var_3_10001(var_223_2(var_223_1, var_3_10006.ACTIVITY_TYPE_PT_HEI5)) and not var_1:isEnd() then
					var_1.data1 = var_1.data1 + arg_198_0.count

					var_223_0:updateActivity(var_1)
				end

				return
			end,
			[30] = function()
				local var_224_0 = arg_198_0
				local var_224_1 = var_0.getConfig(var_224_0, "link_id")

				getProxy = var_3_10001
				ActivityProxy = var_3

				local var_224_2 = var_3_10001(var_3)

				if not var_1.getActivityById(var_224_2, var_224_1) or var_1:isEnd() then
					return
				end

				local var_224_3 = arg_198_0.count
				local var_224_4 = var_1

				if var_1.IsLimitExpItem(var_224_4, arg_198_0.id) then
					var_224_4 = var_1
					var_224_3 = var_1.FilterExp(var_224_4, var_224_3)
					getProxy = var_3
					LoveLetterProxy = var_224_4
					var_224_4 = var_3(var_224_4)
					var_224_3 = var_3.AddLoveLetterExp(var_224_4, var_1:GetTargetGroupId(), var_224_3)
					var_224_4 = var_1

					var_1.AddDailyProgress(var_224_4, var_224_3)
				else
					getProxy = var_3
					LoveLetterProxy = var_224_4
					var_224_4 = var_3(var_224_4)

					local var_224_5 = var_3.AddLoveLetterExp(var_224_4, var_1:GetTargetGroupId(), var_224_3)
				end

				getProxy = var_3
				ActivityProxy = var_224_4

				local var_224_6 = var_3(var_224_4)

				var_3.updateActivity(var_224_6, var_1)

				return
			end,
			[31] = function()
				getProxy = var_3_10000
				AuctionGameBaseProxy = var_3_10002

				local var_225_0 = var_3_10000(var_3_10002)

				var_0.AddGold(var_225_0, arg_198_0.count)

				return
			end,
			[99] = function()
				return
			end,
			[100] = function()
				return
			end,
			[101] = function()
				local var_228_0 = arg_198_0
				local var_228_1 = var_0.getConfig(var_228_0, "link_id")

				getProxy = var_3_10001
				ActivityProxy = var_3

				local var_228_2 = var_3_10001(var_3)

				if var_1.getActivityById(var_228_2, var_228_1) then
					local var_228_3 = var_1

					if not var_1.isEnd(var_228_3) then
						var_1.data1 = var_1.data1 + arg_198_0.count
						getProxy = var_2
						ActivityProxy = var_228_3

						local var_228_4 = var_2(var_228_3)

						var_2.updateActivity(var_228_4, var_1)
					end
				end

				return
			end,
			[102] = function()
				local var_229_0 = arg_198_0
				local var_229_1 = var_0.getConfig(var_229_0, "link_id")

				pg = var_3_10001

				local var_229_2

				var_229_2, switch = var_3_10001.activity_template[var_229_1].type, var_229_0

				local var_229_3 = {}

				ActivityConst = var_3_10006
				var_229_3[var_3_10006.ACTIVITY_TYPE_CITY_REBUILD] = function()
					getProxy = var_4_10000
					CityRebuildProxy = var_4_10002

					local var_230_0 = var_4_10000(var_4_10002)

					var_0.AddPt(var_230_0, var_229_1, arg_198_0.count)

					return
				end

				var_229_0(var_229_2, var_229_3)

				return
			end,
			[103] = function()
				local var_231_0 = arg_198_0
				local var_231_1 = var_0.getConfig(var_231_0, "link_id")

				getProxy = var_3_10001
				ActivityProxy = var_3

				local var_231_2 = var_3_10001(var_3)

				if not var_1.getActivityById(var_231_2, var_231_1) or var_1:isEnd() then
					return
				end

				local var_231_3 = var_1:getConfig("type")

				switch = var_231_2

				local var_231_4 = var_231_3
				local var_231_5 = {}

				ActivityConst = var_3_10007
				var_231_5[var_3_10007.ACTIVITY_TYPE_TOWN2] = function()
					getProxy = var_4_10000
					ActivityProxy = var_4_10002

					local var_232_0 = var_4_10000(var_4_10002)

					Clone = var_4_10001

					local var_232_1 = var_232_0
					local var_232_2 = var_232_0.getActivityByType

					ActivityConst = var_4_10006

					local var_232_3 = var_4_10001(var_232_2(var_232_1, var_4_10006.ACTIVITY_TYPE_TOWN2))
					local var_232_4 = arg_198_0
					local var_232_5 = var_2.getConfig(var_232_4, "id")

					pg = var_3

					if var_232_5 == var_3.activity_town_2[var_232_3.id].bubble_drop[1][2] then
						var_232_3:AddGold(arg_198_0.count)
						var_232_3:AddAllGold(arg_198_0.count)
					else
						var_232_3:AddGold2(arg_198_0.count)
					end

					var_232_0:updateActivity(var_232_3)

					return
				end
				ActivityConst = var_7
				var_231_5[var_7.ACTIVITY_TYPE_MALL] = function()
					local var_233_0 = var_0
					local var_233_1 = var_0.getConfig(var_233_0, "config_data")[1]

					if arg_198_0.id ~= var_233_1 then
						var_4_10004 = var_0

						var_233_0.AddStaff(var_4_10004, arg_198_0.id, arg_198_0.count)
					else
						var_4_10004 = var_0

						var_233_0.AddGold(var_4_10004, arg_198_0.count)
					end

					getProxy = var_233_0
					ActivityProxy = var_4_10004

					local var_233_2 = var_233_0(var_4_10004)

					var_2.updateActivity(var_233_2, var_0)

					if var_1 then
						pg = var_2

						local var_233_3 = var_2.m02
						local var_233_4 = var_2.sendNotification

						GAME = var_5

						local var_233_5 = var_5.ACTIVITY_MALL_OP
						local var_233_6 = {
							activity_id = var_0.id
						}

						ActivityMallOPCommand = var_7
						var_233_6.cmd = var_7.CMD.GET_STAFF_DATA
						var_233_6.arg1 = arg_198_0.count

						var_233_4(var_233_3, var_233_5, var_233_6)
					end

					return
				end

				var_231_2(var_231_4, var_231_5, function()
					assert = var_4_10000

					var_4_10000(var_0 .. "对应" .. var_231_3 .. "错误")

					return
				end)

				return
			end
		})

		return
	end
	DROP_TYPE_EQUIPMENT_SKIN = var_1_10002
	var_61_13[var_1_10002] = function(arg_235_0)
		getProxy = var_2_10001
		EquipmentProxy = var_2_10003

		local var_235_0 = var_2_10001(var_2_10003)

		var_1.addEquipmentSkin(var_235_0, arg_235_0.id, arg_235_0.count)

		return
	end
	DROP_TYPE_OPERATION = var_1_10002
	var_61_13[var_1_10002] = function(arg_236_0)
		getProxy = var_2_10001
		BayProxy = var_2_10003

		local var_236_0 = var_2_10001(var_2_10003)

		if var_1.getShipById(var_236_0, arg_236_0.count) then
			var_2:unlockActivityNpc(0)

			local var_236_1 = var_1

			var_1.updateShip(var_236_1, var_2)

			getProxy = var_3
			CollectionProxy = var_236_1

			local var_236_2 = var_3(var_236_1)

			var_3.flushCollection(var_236_2, var_2)
		end

		return
	end
	DROP_TYPE_WORLD_ITEM = var_1_10002
	var_61_13[var_1_10002] = function(arg_237_0)
		nowWorld = var_2_10001

		local var_237_0 = var_2_10001()
		local var_237_1 = var_1.GetInventoryProxy(var_237_0)

		var_1.AddItem(var_237_1, arg_237_0.id, arg_237_0.count)

		return
	end
	DROP_TYPE_ICON_FRAME = var_1_10002
	var_61_13[var_1_10002] = function(arg_238_0)
		getProxy = var_2_10001
		AttireProxy = var_2_10003

		local var_238_0 = var_2_10001(var_2_10003)

		pg = var_2_10002

		local var_238_1 = var_2_10002.TimeMgr.GetInstance()
		local var_238_2 = var_2.GetServerTime(var_238_1)

		IconFrame = var_2_10003

		local var_238_3 = var_2_10003.New({
			id = arg_238_0.id
		})
		local var_238_4 = var_238_2 + var_3.getConfig(var_238_3, "time_second")

		var_3:updateData({
			isNew = true,
			end_time = var_238_4
		})
		var_238_0:addAttireFrame(var_3)

		pg = var_5

		local var_238_5 = var_5.ToastMgr.GetInstance()
		local var_238_6 = var_5.ShowToast

		pg = var_8

		var_238_6(var_238_5, var_8.ToastMgr.TYPE_ATTIRE, var_3)

		return
	end
	DROP_TYPE_CHAT_FRAME = var_1_10002
	var_61_13[var_1_10002] = function(arg_239_0)
		getProxy = var_2_10001
		AttireProxy = var_2_10003

		local var_239_0 = var_2_10001(var_2_10003)

		pg = var_2_10002

		local var_239_1 = var_2_10002.TimeMgr.GetInstance()
		local var_239_2 = var_2.GetServerTime(var_239_1)

		ChatFrame = var_2_10003

		local var_239_3 = var_2_10003.New({
			id = arg_239_0.id
		})
		local var_239_4 = var_239_2 + var_3.getConfig(var_239_3, "time_second")

		var_3:updateData({
			isNew = true,
			end_time = var_239_4
		})
		var_239_0:addAttireFrame(var_3)

		pg = var_5

		local var_239_5 = var_5.ToastMgr.GetInstance()
		local var_239_6 = var_5.ShowToast

		pg = var_8

		var_239_6(var_239_5, var_8.ToastMgr.TYPE_ATTIRE, var_3)

		return
	end
	DROP_TYPE_EMOJI = var_1_10002
	var_61_13[var_1_10002] = function(arg_240_0)
		getProxy = var_2_10001
		EmojiProxy = var_2_10003

		local var_240_0 = var_2_10001(var_2_10003)

		var_1.addNewEmojiID(var_240_0, arg_240_0.id)

		pg = var_2

		local var_240_1 = var_2.ToastMgr.GetInstance()
		local var_240_2 = var_2.ShowToast

		pg = var_5

		var_240_2(var_240_1, var_5.ToastMgr.TYPE_EMOJI, arg_240_0:getConfigTable())

		return
	end
	DROP_TYPE_WORLD_COLLECTION = var_1_10002
	var_61_13[var_1_10002] = function(arg_241_0)
		nowWorld = var_2_10001

		local var_241_0 = var_2_10001()
		local var_241_1 = var_1.GetCollectionProxy(var_241_0)

		var_1.Unlock(var_241_1, arg_241_0.id)

		return
	end
	DROP_TYPE_META_PT = var_1_10002
	var_61_13[var_1_10002] = function(arg_242_0)
		getProxy = var_2_10001
		MetaCharacterProxy = var_2_10003

		local var_242_0 = var_2_10001(var_2_10003)
		local var_242_1 = var_1.getMetaProgressVOByID(var_242_0, arg_242_0.id)

		var_1.addPT(var_242_1, arg_242_0.count)

		return
	end
	DROP_TYPE_SKIN_TIMELIMIT = var_1_10002
	var_61_13[var_1_10002] = function(arg_243_0)
		local var_243_0 = arg_243_0.id
		local var_243_1 = arg_243_0.count

		getProxy = var_2_10003
		ShipSkinProxy = var_2_10005

		local var_243_2 = var_2_10003(var_2_10005)

		if var_3.getSkinById(var_243_2, var_243_0) and var_4:isExpireType() then
			var_2_10005 = var_243_1 + var_4.endTime
			ShipSkin = var_243_2
			var_243_2 = var_243_2.New({
				id = var_243_0,
				end_time = var_2_10005
			})

			var_3:addSkin(var_243_2)
		elseif not var_4 then
			pg = var_2_10005

			local var_243_3 = var_2_10005.TimeMgr.GetInstance()
			local var_243_4 = var_243_1 + var_5.GetServerTime(var_243_3)

			ShipSkin = var_243_2

			local var_243_5 = var_243_2.New({
				id = var_243_0,
				end_time = var_243_4
			})

			var_3:addSkin(var_243_5)
		end

		return
	end
	DROP_TYPE_BUFF = var_1_10002
	var_61_13[var_1_10002] = function(arg_244_0)
		local var_244_0 = arg_244_0.id

		pg = var_2_10002

		local var_244_1 = var_2_10002.benefit_buff_template[var_244_0]

		assert = var_2_10003

		var_2_10003(var_244_1 and var_244_1.act_id > 0, "should exist act id")

		getProxy = var_2_10003
		ActivityProxy = var_5

		local var_244_2 = var_2_10003(var_5)

		if var_3.getActivityById(var_244_2, var_244_1.act_id) and not var_3:isEnd() then
			local var_244_3 = var_244_1.max_time

			pg = var_244_2

			local var_244_4 = var_244_2.TimeMgr.GetInstance()
			local var_244_5 = var_5.GetServerTime(var_244_4) + var_244_3
			local var_244_6 = var_3
			local var_244_7 = var_3.AddBuff

			ActivityBuff = var_2_10009

			var_244_7(var_244_6, var_2_10009.New(var_3.id, var_244_0, var_244_5))

			getProxy = var_244_7
			ActivityProxy = var_244_6

			local var_244_8 = var_244_7(var_244_6)

			var_6.updateActivity(var_244_8, var_3)
		end

		return
	end
	DROP_TYPE_COMMANDER_CAT = var_1_10002
	var_61_13[var_1_10002] = function(arg_245_0)
		return
	end
	DROP_TYPE_DORM3D_FURNITURE = var_1_10002
	var_61_13[var_1_10002] = function(arg_246_0)
		getProxy = var_2_10001
		ApartmentProxy = var_2_10003

		local var_246_0 = var_2_10001(var_2_10003)

		var_1.ModifyRoom(var_246_0, arg_246_0:getConfig("room_id"), function(arg_247_0)
			arg_247_0:AddFurnitureByID(arg_246_0.id)

			return
		end)

		return
	end
	DROP_TYPE_DORM3D_GIFT = var_1_10002
	var_61_13[var_1_10002] = function(arg_248_0)
		getProxy = var_2_10001
		ApartmentProxy = var_2_10003

		local var_248_0 = var_2_10001(var_2_10003)

		var_1.changeGiftCount(var_248_0, arg_248_0.id, arg_248_0.count)

		return
	end
	DROP_TYPE_DORM3D_SKIN = var_1_10002
	var_61_13[var_1_10002] = function(arg_249_0)
		getProxy = var_2_10001
		ApartmentProxy = var_2_10003

		local var_249_0 = var_2_10001(var_2_10003)

		var_1.ModifyApartment(var_249_0, arg_249_0:getConfig("ship_group"), function(arg_250_0)
			arg_250_0:addSkin(arg_249_0.id)

			return
		end)

		return
	end
	DROP_TYPE_LIVINGAREA_COVER = var_1_10002
	var_61_13[var_1_10002] = function(arg_251_0)
		getProxy = var_2_10001
		LivingAreaCoverProxy = var_2_10003

		local var_251_0 = var_2_10001(var_2_10003)

		LivingAreaCover = var_2_10002

		local var_251_1 = var_2_10002.New({
			isNew = true,
			unlock = true,
			id = arg_251_0.id
		})

		var_251_0:UpdateCover(var_251_1)

		pg = var_3

		local var_251_2 = var_3.ToastMgr.GetInstance()
		local var_251_3 = var_3.ShowToast

		pg = var_6

		var_251_3(var_251_2, var_6.ToastMgr.TYPE_COVER, var_251_1)

		pg = var_251_3

		local var_251_4 = var_251_3.m02
		local var_251_5 = var_3.sendNotification

		GAME = var_6

		local var_251_6 = var_6.APARTMENT_TRACK

		Dorm3dTrackCommand = var_7

		var_251_5(var_251_4, var_251_6, var_7.BuildDataCover(arg_251_0.id, 1))

		return
	end
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10002
	var_61_13[var_1_10002] = function(arg_252_0)
		getProxy = var_2_10001
		AttireProxy = var_2_10003

		local var_252_0 = var_2_10001(var_2_10003)

		pg = var_2_10002

		local var_252_1 = var_2_10002.TimeMgr.GetInstance()
		local var_252_2 = var_2.GetServerTime(var_252_1)

		CombatUIStyle = var_2_10003

		local var_252_3 = var_2_10003.New({
			id = arg_252_0.id
		})

		var_3.setUnlock(var_252_3)
		var_3:setNew()
		var_252_0:addAttireFrame(var_3)

		pg = var_4

		local var_252_4 = var_4.ToastMgr.GetInstance()
		local var_252_5 = var_4.ShowToast

		pg = var_7

		var_252_5(var_252_4, var_7.ToastMgr.TYPE_COMBAT_UI, var_3)

		return
	end
	DROP_TYPE_ISLAND_ITEM = var_1_10002
	var_61_13[var_1_10002] = function(arg_253_0)
		getProxy = var_2_10001
		IslandProxy = var_2_10003

		local var_253_0 = var_2_10001(var_2_10003)

		if not var_1.GetIsland(var_253_0) then
			return
		end

		local var_253_1 = var_1:GetInventoryAgency()
		local var_253_2 = var_2.AddItem

		IslandItem = var_2_10006

		var_253_2(var_253_1, var_2_10006.New({
			id = arg_253_0.id,
			num = arg_253_0.count
		}))

		return
	end
	var_61_12.AddItemCase = var_61_13

	function var_0_1.AddItemDefault(arg_254_0)
		local var_254_0 = arg_254_0.type

		DROP_TYPE_USE_ACTIVITY_DROP = var_2_10002

		if var_2_10002 < var_254_0 then
			getProxy = var_254_0
			ActivityProxy = var_2_10003
			var_2_10003 = var_254_0(var_2_10003)

			local var_254_1 = var_1.getActivityById

			pg = var_2_10004

			local var_254_2 = var_254_1(var_2_10003, var_2_10004.activity_drop_type[arg_254_0.type].activity_id)

			var_2_10002 = arg_254_0.type
			DROP_TYPE_RYZA_DROP = var_2_10003

			if var_2_10002 == var_2_10003 then
				if var_254_2 and not var_254_2:isEnd() then
					local var_254_3 = var_254_2

					var_2_10002 = var_254_2.AddItem
					AtelierMaterial = var_5

					var_2_10002(var_254_3, var_5.New({
						configId = arg_254_0.id,
						count = arg_254_0.count
					}))

					getProxy = var_2_10002
					ActivityProxy = var_254_3

					local var_254_4 = var_2_10002(var_254_3)

					var_2_10002.updateActivity(var_254_4, var_254_2)
				end
			elseif var_254_2 and not var_254_2:isEnd() then
				local var_254_5 = var_254_2

				var_254_2.addVitemNumber(var_254_5, arg_254_0.id, arg_254_0.count)

				getProxy = var_2_10002
				ActivityProxy = var_254_5

				local var_254_6 = var_2_10002(var_254_5)

				var_2_10002.updateActivity(var_254_6, var_254_2)
			end
		else
			local var_254_7 = arg_254_0.type

			DROP_TYPE_ISLAND_ITEM = var_2_10002

			if var_2_10002 <= var_254_7 then
				var_254_7 = arg_254_0.type
				DROP_TYPE_ISLAND_CARD_DIY = var_2_10002

				if var_254_7 <= var_2_10002 then
					getProxy = var_254_7
					IslandProxy = var_2_10003

					local var_254_8 = var_254_7(var_2_10003)

					if not var_254_7.GetIsland(var_254_8) then
						return
					end

					local var_254_9 = {}

					table = var_254_8

					var_254_8.insert(var_254_9, {
						type = arg_254_0.type,
						id = arg_254_0.id,
						number = arg_254_0.count
					})

					IslandDropHelper = var_3

					var_3.AddItems({
						drop_list = var_254_9
					})

					goto label_254_0
				end
			end

			print = var_254_7

			var_254_7("can not handle this type>>" .. arg_254_0.type)
		end

		::label_254_0::

		return
	end

	local var_61_14 = var_0_1
	local var_61_15 = {}

	DROP_TYPE_RESOURCE = var_1_10002
	var_61_15[var_1_10002] = function(arg_255_0, arg_255_1, arg_255_2)
		setText = var_2_10003

		var_2_10003(arg_255_2, arg_255_0:getConfig("display"))

		return
	end
	DROP_TYPE_ITEM = var_1_10002
	var_61_15[var_1_10002] = function(arg_256_0, arg_256_1, arg_256_2)
		local var_256_0 = arg_256_0
		local var_256_1 = arg_256_0.getConfig(var_256_0, "display")
		local var_256_2 = arg_256_0:getConfig("type")

		Item = var_256_0

		local var_256_4

		if var_256_2 == var_256_0.LOVE_LETTER_TYPE then
			string = var_256_2
			var_256_2 = var_256_2.gsub

			local var_256_3 = var_256_1

			var_256_4 = "$1"
			ShipGroup = var_2_10008
			var_256_1 = var_256_2(var_256_3, var_256_4, var_2_10008.getDefaultShipNameByGroupID(arg_256_0.extra))
		elseif arg_256_0:getConfig("combination_display") ~= nil and arg_256_0:getConfig("combination_display") and #var_256_2 > 0 then
			Item = var_5
			var_256_1 = var_5.StaticCombinationDisplay(var_256_2)
		end

		setText = var_256_2

		local var_256_5 = arg_256_2

		SwitchSpecialChar = var_256_4

		var_256_2(var_256_5, var_256_4(var_256_1, true))

		return
	end
	DROP_TYPE_FURNITURE = var_1_10002
	var_61_15[var_1_10002] = function(arg_257_0, arg_257_1, arg_257_2)
		setText = var_2_10003

		var_2_10003(arg_257_2, arg_257_0:getConfig("describe"))

		return
	end
	DROP_TYPE_SHIP = var_1_10002
	var_61_15[var_1_10002] = function(arg_258_0, arg_258_1, arg_258_2)
		local var_258_0 = arg_258_0:getConfig("skin_id")

		ShipWordHelper = var_2_10004

		local var_258_1 = var_2_10004.GetWordAndCV
		local var_258_2 = var_258_0

		ShipWordHelper = var_2_10007

		local var_258_3 = var_2_10007.WORD_TYPE_DROP
		local var_258_4

		PLATFORM_CODE = var_2_10009
		PLATFORM_US = var_2_10010

		local var_258_5, var_258_6, var_258_7 = var_258_1(var_258_2, var_258_3, var_258_4, var_2_10009 ~= var_2_10010)

		setText = var_258_3

		local var_258_8 = arg_258_2

		if not var_258_7 then
			::label_258_0::

			i18n = var_2_10010
			var_2_10010 = var_2_10010("ship_drop_desc_default")
		end

		var_258_3(var_258_8, var_2_10010)

		return
	end
	DROP_TYPE_OPERATION = var_1_10002
	var_61_15[var_1_10002] = function(arg_259_0, arg_259_1, arg_259_2)
		local var_259_0 = arg_259_0:getConfig("skin_id")

		ShipWordHelper = var_2_10004

		local var_259_1 = var_2_10004.GetWordAndCV
		local var_259_2 = var_259_0

		ShipWordHelper = var_2_10007

		local var_259_3 = var_2_10007.WORD_TYPE_DROP
		local var_259_4

		PLATFORM_CODE = var_2_10009
		PLATFORM_US = var_2_10010

		local var_259_5, var_259_6, var_259_7 = var_259_1(var_259_2, var_259_3, var_259_4, var_2_10009 ~= var_2_10010)

		setText = var_259_3

		local var_259_8 = arg_259_2

		if not var_259_7 then
			::label_259_0::

			i18n = var_2_10010
			var_2_10010 = var_2_10010("ship_drop_desc_default")
		end

		var_259_3(var_259_8, var_2_10010)

		return
	end
	DROP_TYPE_EQUIP = var_1_10002
	var_61_15[var_1_10002] = function(arg_260_0, arg_260_1, arg_260_2)
		setText = var_2_10003

		local var_260_0 = arg_260_2
		local var_260_1

		if not arg_260_1.name and not arg_260_0:getConfig("name") then
			var_260_1 = ""
		end

		var_2_10003(var_260_0, var_260_1)

		return
	end
	DROP_TYPE_STRATEGY = var_1_10002
	var_61_15[var_1_10002] = function(arg_261_0, arg_261_1, arg_261_2)
		local var_261_0 = arg_261_0:getConfig("desc")

		ipairs = var_2_10004

		for iter_261_0, iter_261_1 in var_2_10004({
			arg_261_0.count
		}) do
			string = var_2_10009
			var_261_0 = var_2_10009.gsub(var_261_0, "$" .. iter_261_0, iter_261_1)
		end

		setText = var_4

		var_4(arg_261_2, var_261_0)

		return
	end
	DROP_TYPE_SKIN = var_1_10002
	var_61_15[var_1_10002] = function(arg_262_0, arg_262_1, arg_262_2)
		setText = var_2_10003

		var_2_10003(arg_262_2, arg_262_0:getConfig("desc"))

		return
	end
	DROP_TYPE_SKIN_TIMELIMIT = var_1_10002
	var_61_15[var_1_10002] = function(arg_263_0, arg_263_1, arg_263_2)
		setText = var_2_10003

		var_2_10003(arg_263_2, arg_263_0:getConfig("desc"))

		return
	end
	DROP_TYPE_EQUIPMENT_SKIN = var_1_10002
	var_61_15[var_1_10002] = function(arg_264_0, arg_264_1, arg_264_2)
		local var_264_0 = arg_264_0
		local var_264_1 = arg_264_0.getConfig(var_264_0, "desc")

		_ = var_2_10004

		local var_264_2 = var_2_10004.map(arg_264_0:getConfig("equip_type"), function(arg_265_0)
			EquipType = var_3_10001

			return var_3_10001.Type2Name2(arg_265_0)
		end)

		setText = var_264_0

		local var_264_3 = arg_264_2
		local var_264_4 = var_264_1
		local var_264_5 = "\n\n"

		i18n = var_2_10010

		local var_264_6 = var_2_10010("word_fit")
		local var_264_7 = ": "

		table = var_12

		var_264_0(var_264_3, var_264_4 .. var_264_5 .. var_264_6 .. var_264_7 .. var_12.concat(var_264_2, ","))

		return
	end
	DROP_TYPE_VITEM = var_1_10002
	var_61_15[var_1_10002] = function(arg_266_0, arg_266_1, arg_266_2)
		setText = var_2_10003

		var_2_10003(arg_266_2, arg_266_0:getConfig("display"))

		return
	end
	DROP_TYPE_WORLD_ITEM = var_1_10002
	var_61_15[var_1_10002] = function(arg_267_0, arg_267_1, arg_267_2)
		setText = var_2_10003

		var_2_10003(arg_267_2, arg_267_0:getConfig("display"))

		return
	end
	DROP_TYPE_WORLD_COLLECTION = var_1_10002
	var_61_15[var_1_10002] = function(arg_268_0, arg_268_1, arg_268_2, arg_268_3)
		WorldCollectionProxy = var_2_10004

		local var_268_0 = var_2_10004.GetCollectionType(arg_268_0.id)

		WorldCollectionProxy = var_2_10005

		local var_268_1 = var_268_0 == var_2_10005.WorldCollectionType.FILE and "file" or "record"

		setText = var_6

		local var_268_2 = arg_268_2

		i18n = var_2_10009

		var_6(var_268_2, var_2_10009("world_" .. var_268_1 .. "_desc", arg_268_0:getConfig("name")))

		setText = var_6

		local var_268_3 = arg_268_3

		i18n = var_9

		var_6(var_268_3, var_9("world_" .. var_268_1 .. "_name", arg_268_0:getConfig("name")))

		return
	end
	DROP_TYPE_ICON_FRAME = var_1_10002
	var_61_15[var_1_10002] = function(arg_269_0, arg_269_1, arg_269_2)
		setText = var_2_10003

		local var_269_0 = arg_269_2
		local var_269_1

		if not arg_269_0.desc or not arg_269_0.desc then
			var_269_1 = arg_269_0:getConfig("desc")
		end

		var_2_10003(var_269_0, var_269_1)

		return
	end
	DROP_TYPE_CHAT_FRAME = var_1_10002
	var_61_15[var_1_10002] = function(arg_270_0, arg_270_1, arg_270_2)
		setText = var_2_10003

		var_2_10003(arg_270_2, arg_270_0:getConfig("desc"))

		return
	end
	DROP_TYPE_EMOJI = var_1_10002
	var_61_15[var_1_10002] = function(arg_271_0, arg_271_1, arg_271_2)
		setText = var_2_10003

		var_2_10003(arg_271_2, arg_271_0:getConfig("item_desc"))

		return
	end
	DROP_TYPE_LOVE_LETTER = var_1_10002
	var_61_15[var_1_10002] = function(arg_272_0, arg_272_1, arg_272_2)
		string = var_2_10003

		local var_272_0 = var_2_10003.gsub
		local var_272_1 = arg_272_0
		local var_272_2 = arg_272_0.getConfig(var_272_1, "display")
		local var_272_3 = "$1"

		ShipGroup = var_272_1

		local var_272_4 = var_272_0(var_272_2, var_272_3, var_272_1.getDefaultShipNameByGroupID(arg_272_0.count))

		setText = var_2_10004

		local var_272_5 = arg_272_2

		SwitchSpecialChar = var_7

		var_2_10004(var_272_5, var_7(var_272_4, true))

		return
	end
	DROP_TYPE_META_PT = var_1_10002
	var_61_15[var_1_10002] = function(arg_273_0, arg_273_1, arg_273_2)
		setText = var_2_10003

		var_2_10003(arg_273_2, arg_273_0:getConfig("display"))

		return
	end
	DROP_TYPE_BUFF = var_1_10002
	var_61_15[var_1_10002] = function(arg_274_0, arg_274_1, arg_274_2)
		setText = var_2_10003

		var_2_10003(arg_274_2, arg_274_0:getConfig("desc"))

		return
	end
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10002
	var_61_15[var_1_10002] = function(arg_275_0, arg_275_1, arg_275_2)
		setText = var_2_10003

		var_2_10003(arg_275_2, arg_275_0:getConfig("desc"))

		return
	end
	DROP_TYPE_ACTIVITY_MEDAL = var_1_10002
	var_61_15[var_1_10002] = function(arg_276_0, arg_276_1, arg_276_2)
		setText = var_2_10003

		var_2_10003(arg_276_2, arg_276_0:getConfig("display"))

		return
	end
	DROP_TYPE_LIVINGAREA_COVER = var_1_10002
	var_61_15[var_1_10002] = function(arg_277_0, arg_277_1, arg_277_2)
		setText = var_2_10003

		var_2_10003(arg_277_2, arg_277_0:getConfig("desc"))

		return
	end
	DROP_TYPE_ISLAND_ITEM = var_1_10002
	var_61_15[var_1_10002] = function(arg_278_0, arg_278_1, arg_278_2)
		setText = var_2_10003

		var_2_10003(arg_278_2, arg_278_0:getConfig("desc"))

		return
	end
	DROP_TYPE_ISLAND_ABILITY = var_1_10002
	var_61_15[var_1_10002] = function(arg_279_0, arg_279_1, arg_279_2)
		setText = var_2_10003

		var_2_10003(arg_279_2, "")

		return
	end
	DROP_TYPE_ISLAND_INVITATION = var_1_10002
	var_61_15[var_1_10002] = function(arg_280_0, arg_280_1, arg_280_2)
		setText = var_2_10003

		var_2_10003(arg_280_2, arg_280_0.desc)

		return
	end
	DROP_TYPE_ISLAND_FURNITURE = var_1_10002
	var_61_15[var_1_10002] = function(arg_281_0, arg_281_1, arg_281_2)
		setText = var_2_10003

		var_2_10003(arg_281_2, arg_281_0.desc)

		return
	end
	DROP_TYPE_ISLAND_DRESS = var_1_10002
	var_61_15[var_1_10002] = function(arg_282_0, arg_282_1, arg_282_2)
		setText = var_2_10003

		var_2_10003(arg_282_2, arg_282_0.desc)

		return
	end
	DROP_TYPE_ISLAND_SKIN = var_1_10002
	var_61_15[var_1_10002] = function(arg_283_0, arg_283_1, arg_283_2)
		setText = var_2_10003

		var_2_10003(arg_283_2, arg_283_0.desc)

		return
	end
	var_61_14.MsgboxIntroCase = var_61_15

	function var_0_1.MsgboxIntroDefault(arg_284_0, arg_284_1, arg_284_2)
		local var_284_0 = arg_284_0.type

		DROP_TYPE_USE_ACTIVITY_DROP = var_2_10004

		if var_2_10004 < var_284_0 then
			setText = var_284_0

			var_284_0(arg_284_2, arg_284_0:getConfig("display"))
		else
			setText = var_284_0

			local var_284_1 = arg_284_2
			local var_284_2

			if not arg_284_0.desc then
				var_284_2 = ""
			end

			var_284_0(var_284_1, var_284_2)
		end

		return
	end

	local var_61_16 = var_0_1
	local var_61_17 = {}

	DROP_TYPE_RESOURCE = var_1_10002
	var_61_17[var_1_10002] = function(arg_285_0, arg_285_1, arg_285_2)
		local var_285_0 = arg_285_0.id

		PlayerConst = var_2_10004

		if var_285_0 ~= var_2_10004.ResStoreGold then
			var_285_0 = arg_285_0.id
			PlayerConst = var_4

			if var_285_0 == var_4.ResStoreOil then
				arg_285_2 = arg_285_2 or {}
				arg_285_2.frame = "frame_store"
			end

			updateItem = var_285_0

			local var_285_1 = arg_285_1

			Item = var_2_10006

			local var_285_2 = var_2_10006.New
			local var_285_3 = {}

			id2ItemId = var_2_10009
			var_285_3.id = var_2_10009(arg_285_0.id)

			var_285_0(var_285_1, var_285_2(var_285_3), arg_285_2)

			return
		end
	end
	DROP_TYPE_ITEM = var_1_10002
	var_61_17[var_1_10002] = function(arg_286_0, arg_286_1, arg_286_2)
		updateItem = var_2_10003

		var_2_10003(arg_286_1, arg_286_0:getSubClass(), arg_286_2)

		return
	end
	DROP_TYPE_EQUIP = var_1_10002
	var_61_17[var_1_10002] = function(arg_287_0, arg_287_1, arg_287_2)
		updateEquipment = var_2_10003

		var_2_10003(arg_287_1, arg_287_0:getSubClass(), arg_287_2)

		return
	end
	DROP_TYPE_SHIP = var_1_10002
	var_61_17[var_1_10002] = function(arg_288_0, arg_288_1, arg_288_2)
		updateShip = var_2_10003

		var_2_10003(arg_288_1, arg_288_0.ship, arg_288_2)

		return
	end
	DROP_TYPE_OPERATION = var_1_10002
	var_61_17[var_1_10002] = function(arg_289_0, arg_289_1, arg_289_2)
		updateShip = var_2_10003

		var_2_10003(arg_289_1, arg_289_0.ship, arg_289_2)

		return
	end
	DROP_TYPE_FURNITURE = var_1_10002
	var_61_17[var_1_10002] = function(arg_290_0, arg_290_1, arg_290_2)
		updateFurniture = var_2_10003

		var_2_10003(arg_290_1, arg_290_0, arg_290_2)

		return
	end
	DROP_TYPE_STRATEGY = var_1_10002
	var_61_17[var_1_10002] = function(arg_291_0, arg_291_1, arg_291_2)
		arg_291_2.isWorldBuff = arg_291_0.isWorldBuff
		updateStrategy = var_3

		var_3(arg_291_1, arg_291_0, arg_291_2)

		return
	end
	DROP_TYPE_SKIN = var_1_10002
	var_61_17[var_1_10002] = function(arg_292_0, arg_292_1, arg_292_2)
		arg_292_2.isSkin = true
		arg_292_2.isNew = arg_292_0.isNew
		updateShip = var_3

		local var_292_0 = arg_292_1

		Ship = var_2_10006

		local var_292_1 = var_2_10006.New
		local var_292_2 = {}

		tonumber = var_2_10009
		var_292_2.configId = var_2_10009(arg_292_0:getConfig("ship_group") .. "1")
		var_292_2.skin_id = arg_292_0.id

		var_3(var_292_0, var_292_1(var_292_2), arg_292_2)

		return
	end
	DROP_TYPE_EQUIPMENT_SKIN = var_1_10002
	var_61_17[var_1_10002] = function(arg_293_0, arg_293_1, arg_293_2)
		setmetatable = var_2_10003

		local var_293_0 = var_2_10003({
			count = arg_293_0.count
		}, {
			__index = arg_293_0:getConfigTable()
		})

		updateEquipmentSkin = var_2_10004

		var_2_10004(arg_293_1, var_293_0, arg_293_2)

		return
	end
	DROP_TYPE_VITEM = var_1_10002
	var_61_17[var_1_10002] = function(arg_294_0, arg_294_1, arg_294_2)
		updateItem = var_2_10003

		local var_294_0 = arg_294_1

		Item = var_2_10006

		var_2_10003(var_294_0, var_2_10006.New({
			id = arg_294_0.id
		}), arg_294_2)

		return
	end
	DROP_TYPE_WORLD_ITEM = var_1_10002
	var_61_17[var_1_10002] = function(arg_295_0, arg_295_1, arg_295_2)
		updateWorldItem = var_2_10003

		local var_295_0 = arg_295_1

		WorldItem = var_2_10006

		var_2_10003(var_295_0, var_2_10006.New({
			id = arg_295_0.id
		}), arg_295_2)

		return
	end
	DROP_TYPE_WORLD_COLLECTION = var_1_10002
	var_61_17[var_1_10002] = function(arg_296_0, arg_296_1, arg_296_2)
		updateWorldCollection = var_2_10003

		var_2_10003(arg_296_1, arg_296_0, arg_296_2)

		return
	end
	DROP_TYPE_CHAT_FRAME = var_1_10002
	var_61_17[var_1_10002] = function(arg_297_0, arg_297_1, arg_297_2)
		updateAttire = var_2_10003

		local var_297_0 = arg_297_1

		AttireConst = var_2_10006

		var_2_10003(var_297_0, var_2_10006.TYPE_CHAT_FRAME, arg_297_0:getConfigTable(), arg_297_2)

		return
	end
	DROP_TYPE_ICON_FRAME = var_1_10002
	var_61_17[var_1_10002] = function(arg_298_0, arg_298_1, arg_298_2)
		updateAttire = var_2_10003

		local var_298_0 = arg_298_1

		AttireConst = var_2_10006

		var_2_10003(var_298_0, var_2_10006.TYPE_ICON_FRAME, arg_298_0:getConfigTable(), arg_298_2)

		return
	end
	DROP_TYPE_EMOJI = var_1_10002
	var_61_17[var_1_10002] = function(arg_299_0, arg_299_1, arg_299_2)
		updateEmoji = var_2_10003

		var_2_10003(arg_299_1, arg_299_0:getConfigTable(), arg_299_2)

		return
	end
	DROP_TYPE_LOVE_LETTER = var_1_10002
	var_61_17[var_1_10002] = function(arg_300_0, arg_300_1, arg_300_2)
		arg_300_2.count = 1
		updateItem = var_3

		var_3(arg_300_1, arg_300_0:getSubClass(), arg_300_2)

		return
	end
	DROP_TYPE_SPWEAPON = var_1_10002
	var_61_17[var_1_10002] = function(arg_301_0, arg_301_1, arg_301_2)
		updateSpWeapon = var_2_10003

		local var_301_0 = arg_301_1

		SpWeapon = var_2_10006

		var_2_10003(var_301_0, var_2_10006.New({
			id = arg_301_0.id
		}), arg_301_2)

		return
	end
	DROP_TYPE_META_PT = var_1_10002
	var_61_17[var_1_10002] = function(arg_302_0, arg_302_1, arg_302_2)
		updateItem = var_2_10003

		local var_302_0 = arg_302_1

		Item = var_2_10006

		var_2_10003(var_302_0, var_2_10006.New({
			id = arg_302_0:getConfig("id")
		}), arg_302_2)

		return
	end
	DROP_TYPE_SKIN_TIMELIMIT = var_1_10002
	var_61_17[var_1_10002] = function(arg_303_0, arg_303_1, arg_303_2)
		arg_303_2.isSkin = true
		arg_303_2.isTimeLimit = true
		arg_303_2.count = 1
		updateShip = var_3

		local var_303_0 = arg_303_1

		Ship = var_2_10006

		local var_303_1 = var_2_10006.New
		local var_303_2 = {}

		tonumber = var_2_10009
		var_303_2.configId = var_2_10009(arg_303_0:getConfig("ship_group") .. "1")
		var_303_2.skin_id = arg_303_0.id

		var_3(var_303_0, var_303_1(var_303_2), arg_303_2)

		return
	end
	DROP_TYPE_RYZA_DROP = var_1_10002
	var_61_17[var_1_10002] = function(arg_304_0, arg_304_1, arg_304_2)
		AtelierMaterial = var_2_10003

		var_2_10003.UpdateRyzaItem(arg_304_1, arg_304_0.item, arg_304_2)

		return
	end
	DROP_TYPE_WORKBENCH_DROP = var_1_10002
	var_61_17[var_1_10002] = function(arg_305_0, arg_305_1, arg_305_2)
		WorkBenchItem = var_2_10003

		var_2_10003.UpdateDrop(arg_305_1, arg_305_0.item, arg_305_2)

		return
	end
	DROP_TYPE_FEAST_DROP = var_1_10002
	var_61_17[var_1_10002] = function(arg_306_0, arg_306_1, arg_306_2)
		WorkBenchItem = var_2_10003

		local var_306_0 = var_2_10003.UpdateDrop
		local var_306_1 = arg_306_1

		WorkBenchItem = var_2_10006

		var_306_0(var_306_1, var_2_10006.New({
			configId = arg_306_0.id,
			count = arg_306_0.count
		}), arg_306_2)

		return
	end
	DROP_TYPE_BUFF = var_1_10002
	var_61_17[var_1_10002] = function(arg_307_0, arg_307_1, arg_307_2)
		updateBuff = var_2_10003

		var_2_10003(arg_307_1, arg_307_0.id, arg_307_2)

		return
	end
	DROP_TYPE_COMMANDER_CAT = var_1_10002
	var_61_17[var_1_10002] = function(arg_308_0, arg_308_1, arg_308_2)
		updateCommander = var_2_10003

		var_2_10003(arg_308_1, arg_308_0, arg_308_2)

		return
	end
	DROP_TYPE_LIVINGAREA_COVER = var_1_10002
	var_61_17[var_1_10002] = function(arg_309_0, arg_309_1, arg_309_2)
		updateCover = var_2_10003

		var_2_10003(arg_309_1, arg_309_0, arg_309_2)

		return
	end
	DROP_TYPE_COMBAT_UI_STYLE = var_1_10002
	var_61_17[var_1_10002] = function(arg_310_0, arg_310_1, arg_310_2)
		updateAttireCombatUI = var_2_10003

		local var_310_0 = arg_310_1

		AttireConst = var_2_10006

		var_2_10003(var_310_0, var_2_10006.TYPE_ICON_FRAME, arg_310_0:getConfigTable(), arg_310_2)

		return
	end
	DROP_TYPE_ACTIVITY_MEDAL = var_1_10002
	var_61_17[var_1_10002] = function(arg_311_0, arg_311_1, arg_311_2)
		updateActivityMedal = var_2_10003

		var_2_10003(arg_311_1, arg_311_0:getConfigTable(), arg_311_2)

		return
	end
	var_61_16.UpdateDropCase = var_61_17

	function var_0_1.UpdateDropDefault(arg_312_0, arg_312_1, arg_312_2)
		updateDefaultIconTpl = var_2_10003

		var_2_10003(arg_312_1, arg_312_0, arg_312_2)

		return
	end

	local var_61_18 = var_0_1
	local var_61_19 = "UpdateCustomDropCase"
	local var_61_20 = {}

	DROP_TYPE_DORM3D_FURNITURE = var_3
	var_61_20[var_3] = function(arg_313_0, arg_313_1, arg_313_2)
		updateDorm3dIcon = var_2_10003

		var_2_10003(arg_313_1, arg_313_0, arg_313_2)

		return
	end
	DROP_TYPE_DORM3D_GIFT = var_3
	var_61_20[var_3] = function(arg_314_0, arg_314_1, arg_314_2)
		updateDorm3dIcon = var_2_10003

		var_2_10003(arg_314_1, arg_314_0, arg_314_2)

		return
	end
	DROP_TYPE_DORM3D_SKIN = var_3
	var_61_20[var_3] = function(arg_315_0, arg_315_1, arg_315_2)
		updateDorm3dIcon = var_2_10003

		var_2_10003(arg_315_1, arg_315_0, arg_315_2)

		return
	end
	DROP_TYPE_ISLAND_ITEM = var_3
	var_61_20[var_3] = function(arg_316_0, arg_316_1, arg_316_2)
		updateIslandItem = var_2_10003

		var_2_10003(arg_316_1, arg_316_0, arg_316_2)

		return
	end
	DROP_TYPE_ISLAND_ABILITY = var_3
	var_61_20[var_3] = function(arg_317_0, arg_317_1, arg_317_2)
		updateIslandUnlock = var_2_10003

		var_2_10003(arg_317_1, arg_317_0, arg_317_2)

		return
	end
	DROP_TYPE_ISLAND_INVITATION = var_3
	var_61_20[var_3] = function(arg_318_0, arg_318_1, arg_318_2)
		updateIslandInvitation = var_2_10003

		var_2_10003(arg_318_1, arg_318_0, arg_318_2)

		return
	end
	VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT = var_3
	var_61_20[var_3] = function(arg_319_0, arg_319_1, arg_319_2)
		updateIslandSeasonPt = var_2_10003

		var_2_10003(arg_319_1, arg_319_0, arg_319_2)

		return
	end
	DROP_TYPE_ISLAND_COLLECTION = var_3
	var_61_20[var_3] = function(arg_320_0, arg_320_1, arg_320_2)
		updateIslandWatherCollect = var_2_10003

		var_2_10003(arg_320_1, arg_320_0, arg_320_2)

		return
	end
	DROP_TYPE_ISLAND_FURNITURE = var_3
	var_61_20[var_3] = function(arg_321_0, arg_321_1, arg_321_2)
		updateIslandFurniture = var_2_10003

		var_2_10003(arg_321_1, arg_321_0, arg_321_2)

		return
	end
	DROP_TYPE_ISLAND_CARD_DIY = var_3
	var_61_20[var_3] = function(arg_322_0, arg_322_1, arg_322_2)
		updateIslandCardDiy = var_2_10003

		var_2_10003(arg_322_1, arg_322_0, arg_322_2)

		return
	end
	DROP_TYPE_ISLAND_SPEEDUP_TICKET = var_3
	var_61_20[var_3] = function(arg_323_0, arg_323_1, arg_323_2)
		updateIslandSpeedupTicket = var_2_10003

		var_2_10003(arg_323_1, arg_323_0, arg_323_2)

		return
	end
	DROP_TYPE_HOLIDAY_VILLA = var_3
	var_61_20[var_3] = function(arg_324_0, arg_324_1, arg_324_2)
		updateItem = var_2_10003

		local var_324_0 = arg_324_1

		Item = var_2_10006

		var_2_10003(var_324_0, var_2_10006.New({
			id = arg_324_0.id
		}), arg_324_2)

		return
	end
	DROP_TYPE_ISLAND_SKIN = var_3
	var_61_20[var_3] = function(arg_325_0, arg_325_1, arg_325_2)
		updateIslandSkin = var_2_10003

		var_2_10003(arg_325_1, arg_325_0, arg_325_2)

		return
	end
	DROP_TYPE_ISLAND_DRESS = var_3
	var_61_20[var_3] = function(arg_326_0, arg_326_1, arg_326_2)
		updateIslandDress = var_2_10003

		var_2_10003(arg_326_1, arg_326_0, arg_326_2)

		return
	end
	var_61_18[var_61_19] = var_61_20

	function var_0_1.UpdateCustomDropDefault(arg_327_0, arg_327_1, arg_327_2)
		if arg_327_2.style == "dorm" then
			updateDorm3dIcon = var_3

			var_3(arg_327_1, arg_327_0, arg_327_2)
		elseif arg_327_2.style == "island" then
			updateIslandDefaultIconTpl = var_3

			var_3(arg_327_1, arg_327_0, arg_327_2)
		else
			warning = var_3
			string = var_2_10005

			var_3(var_2_10005.format("without dropType %d in updateCustomDrop", arg_327_0.type))
		end

		return
	end

	return
end

return var_0_1
