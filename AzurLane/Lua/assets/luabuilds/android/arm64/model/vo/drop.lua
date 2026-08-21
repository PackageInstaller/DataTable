local var_0_0 = class("Drop", import(".BaseVO"))

function var_0_0.__index(arg_1_0, arg_1_1)
	if arg_1_1 == "desc" then
		return HXSet.hxLan(rawget(arg_1_0, "_desc"))
	end

	return var_0_0[arg_1_1]
end

function var_0_0.__newindex(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "desc" then
		rawset(arg_2_0, "_desc", arg_2_2)
	else
		rawset(arg_2_0, arg_2_1, arg_2_2)
	end

	return
end

function var_0_0.Create(arg_3_0)
	local var_3_0 = {}

	var_3_0.type, var_3_0.id, var_3_0.count = unpack(arg_3_0)

	return var_0_0.New({})
end

function var_0_0.Change(arg_4_0)
	if not getmetatable(arg_4_0) then
		setmetatable(arg_4_0, var_0_0)

		arg_4_0.class = var_0_0

		arg_4_0:InitConfig()
	else
		assert(instanceof(arg_4_0, var_0_0))
	end

	return arg_4_0
end

function var_0_0.Ctor(arg_5_0, arg_5_1)
	assert(not getmetatable(arg_5_1), "drop data should not has metatable")

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		arg_5_0[iter_5_0] = iter_5_1
	end

	arg_5_0:InitConfig()

	return
end

function var_0_0.InitConfig(arg_6_0)
	if not var_0_0.inited then
		var_0_0.InitSwitch()
	end

	arg_6_0.configId = arg_6_0.id
	arg_6_0.cfg = switch(arg_6_0.type, var_0_0.ConfigCase, var_0_0.ConfigDefault, arg_6_0)

	return
end

function var_0_0.getConfigTable(arg_7_0)
	return arg_7_0.cfg
end

function var_0_0.getName(arg_8_0)
	return arg_8_0.name or arg_8_0:getConfig("name")
end

function var_0_0.getIcon(arg_9_0)
	return switch(arg_9_0.type, {
		[DROP_TYPE_ICON_FRAME] = function()
			return "Props/icon_frame"
		end,
		[DROP_TYPE_ISLAND_ITEM] = function()
			local var_11_0 = arg_9_0:getConfig("icon_normal")

			return var_11_0 ~= "" and var_11_0 or "island/" .. arg_9_0:getConfig("icon")
		end,
		[DROP_TYPE_ISLAND_ABILITY] = function()
			return "island/" .. arg_9_0:getConfig("cmd_icon")
		end,
		[DROP_TYPE_ISLAND_INVITATION] = function()
			return "island/" .. pg.island_item_data_template[arg_9_0:getConfig("invite_item")].icon
		end,
		[VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT] = function()
			return "island/" .. arg_9_0:getConfig("icon")
		end,
		[DROP_TYPE_ISLAND_COLLECTION] = function()
			return "island/" .. arg_9_0:getConfig("icon")
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function()
			return "island/IslandFurnitureIcon/" .. arg_9_0:getConfig("icon")
		end,
		[DROP_TYPE_ISLAND_CARD_DIY] = function()
			return "island/" .. arg_9_0:getConfig("icon")
		end,
		[DROP_TYPE_ISLAND_SPEEDUP_TICKET] = function()
			return arg_9_0:getConfig("icon_normal")
		end,
		[DROP_TYPE_ISLAND_DRESS] = function()
			return "island/IslandDressIcon/" .. arg_9_0:getConfig("icon")
		end,
		[DROP_TYPE_ISLAND_ACTION] = function()
			return "island/IslandActionIcon/" .. arg_9_0:getConfig("resource")
		end,
		[DROP_TYPE_ISLAND_SKIN] = function()
			return arg_9_0:getConfig("icon_normal")
		end
	}, function()
		return arg_9_0:getConfig("icon")
	end)
end

function var_0_0.getDefaultIcon(arg_23_0)
	return switch(arg_23_0.type, {
		[DROP_TYPE_DORM3D_FURNITURE] = function()
			return "props/missing_icon_dorm"
		end,
		[DROP_TYPE_DORM3D_GIFT] = function()
			return "props/missing_icon_dorm"
		end,
		[DROP_TYPE_DORM3D_SKIN] = function()
			return "props/missing_icon_dorm"
		end,
		[DROP_TYPE_ISLAND_ITEM] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_OVERFLOWITEM] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_ABILITY] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_INVITATION] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_DRESS] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_SKIN] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_COLLECTION_FRAMENT] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_COLLECTION] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_SPEEDUP_TICKET] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_ACTION] = function()
			return "props/missing_icon_island"
		end,
		[DROP_TYPE_ISLAND_CARD_DIY] = function()
			return "props/missing_icon_island"
		end
	}, function()
		return "props/missing_icon"
	end)
end

function var_0_0.getIslandRarity(arg_40_0)
	return switch(arg_40_0.type, {
		[DROP_TYPE_ISLAND_ITEM] = function()
			return arg_40_0:getConfig("rarity")
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function()
			return arg_40_0:getConfig("rarity")
		end,
		[DROP_TYPE_ISLAND_SPEEDUP_TICKET] = function()
			return arg_40_0:getConfig("rarity")
		end,
		[DROP_TYPE_ISLAND_DRESS] = function()
			return IslandItemRarity.ORANGE
		end,
		[DROP_TYPE_ISLAND_ACTION] = function()
			return IslandItemRarity.ORANGE
		end,
		[DROP_TYPE_ITEM] = function()
			return IslandItemRarity.ORANGE
		end,
		[DROP_TYPE_VITEM] = function()
			return IslandItemRarity.ORANGE
		end
	}, function()
		return IslandItemRarity.GREY
	end)
end

function var_0_0.getCount(arg_49_0)
	if arg_49_0.type == DROP_TYPE_OPERATION or arg_49_0.type == DROP_TYPE_LOVE_LETTER or MallActivity.IsStaffDrop(arg_49_0) then
		return 1
	else
		return arg_49_0.count
	end

	return
end

function var_0_0.isLoveLetter(arg_50_0)
	return arg_50_0.type == DROP_TYPE_LOVE_LETTER or arg_50_0.type == DROP_TYPE_ITEM and arg_50_0:getConfig("type") == Item.LOVE_LETTER_TYPE
end

function var_0_0.getOwnedCount(arg_51_0)
	return switch(arg_51_0.type, var_0_0.CountCase, var_0_0.CountDefault, arg_51_0)
end

function var_0_0.getOwnedLimit(arg_52_0)
	return switch(arg_52_0.type, var_0_0.LimitCase, var_0_0.LimitDefault, arg_52_0)
end

function var_0_0.getSubClass(arg_53_0)
	return switch(arg_53_0.type, var_0_0.SubClassCase, var_0_0.SubClassDefault, arg_53_0)
end

function var_0_0.getDropRarity(arg_54_0)
	return switch(arg_54_0.type, var_0_0.RarityCase, var_0_0.RarityDefault, arg_54_0)
end

function var_0_0.getDropRarityDorm(arg_55_0)
	return switch(arg_55_0.type, var_0_0.RarityCase, var_0_0.RarityDefaultDorm, arg_55_0)
end

function var_0_0.DropTrans(arg_56_0, ...)
	return switch(arg_56_0.type, var_0_0.TransCase, var_0_0.TransDefault, arg_56_0, ...)
end

function var_0_0.AddItemOperation(arg_57_0)
	return switch(arg_57_0.type, var_0_0.AddItemCase, var_0_0.AddItemDefault, arg_57_0)
end

function var_0_0.MsgboxIntroSet(arg_58_0, ...)
	return switch(arg_58_0.type, var_0_0.MsgboxIntroCase, var_0_0.MsgboxIntroDefault, arg_58_0, ...)
end

function var_0_0.UpdateDropTpl(arg_59_0, ...)
	return switch(arg_59_0.type, var_0_0.UpdateDropCase, var_0_0.UpdateDropDefault, arg_59_0, ...)
end

function var_0_0.UpdateCustomDropTpl(arg_60_0, ...)
	return switch(arg_60_0.type, var_0_0.UpdateCustomDropCase, var_0_0.UpdateCustomDropDefault, arg_60_0, ...)
end

function var_0_0.InitSwitch()
	var_0_0.inited = true
	var_0_0.ConfigCase = {
		[DROP_TYPE_RESOURCE] = function(arg_62_0)
			local var_62_0 = Item.getConfigData(id2ItemId(arg_62_0.id))

			arg_62_0.desc = var_62_0.display

			return var_62_0
		end,
		[DROP_TYPE_ITEM] = function(arg_63_0)
			local var_63_0 = Item.getConfigData(arg_63_0.id)

			arg_63_0.desc = var_63_0.display

			if var_63_0.type == Item.LOVE_LETTER_TYPE then
				arg_63_0.desc = string.gsub(arg_63_0.desc, "$1", ShipGroup.getDefaultShipNameByGroupID(arg_63_0.extra))
			end

			return var_63_0
		end,
		[DROP_TYPE_VITEM] = function(arg_64_0)
			local var_64_0 = Item.getConfigData(arg_64_0.id)

			assert(var_64_0, arg_64_0.id)

			arg_64_0.desc = var_64_0.display

			return var_64_0
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_65_0)
			local var_65_0 = Item.getConfigData(arg_65_0.id)

			arg_65_0.desc = string.gsub(var_65_0.display, "$1", ShipGroup.getDefaultShipNameByGroupID(arg_65_0.count))

			return var_65_0
		end,
		[DROP_TYPE_EQUIP] = function(arg_66_0)
			local var_66_0 = Equipment.getConfigData(arg_66_0.id)

			arg_66_0.desc = var_66_0.descrip

			return var_66_0
		end,
		[DROP_TYPE_SHIP] = function(arg_67_0)
			local var_67_0, var_67_1, var_67_2 = ShipWordHelper.GetWordAndCV(pg.ship_data_statistics[arg_67_0.id].skin_id, ShipWordHelper.WORD_TYPE_DROP)

			arg_67_0.desc = var_67_2 or i18n("ship_drop_desc_default")
			arg_67_0.ship = Ship.New({
				configId = arg_67_0.id,
				skin_id = arg_67_0.skinId,
				propose = arg_67_0.propose
			})
			arg_67_0.ship.remoulded = arg_67_0.remoulded
			arg_67_0.ship.virgin = arg_67_0.virgin

			return pg.ship_data_statistics[arg_67_0.id]
		end,
		[DROP_TYPE_FURNITURE] = function(arg_68_0)
			arg_68_0.desc = pg.furniture_data_template[arg_68_0.id].describe

			return pg.furniture_data_template[arg_68_0.id]
		end,
		[DROP_TYPE_SKIN] = function(arg_69_0)
			local var_69_0 = pg.ship_skin_template[arg_69_0.id]

			if pg.ship_skin_template[arg_69_0.id].skin_type == ShipSkin.SKIN_TYPE_TB then
				local var_69_1, var_69_2, var_69_3 = EducateCharWordHelper.GetWordAndCV(NewEducateHelper.GetSecIdBySkinId(arg_69_0.id), EducateCharWordHelper.WORD_KEY_LOGIN)

				arg_69_0.desc = var_69_3
			else
				local var_69_4, var_69_5, var_69_6 = ShipWordHelper.GetWordAndCV(arg_69_0.id, ShipWordHelper.WORD_TYPE_DROP)

				arg_69_0.desc = var_69_6
			end

			return var_69_0
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_70_0)
			local var_70_0 = pg.ship_skin_template[arg_70_0.id]

			if pg.ship_skin_template[arg_70_0.id].skin_type == ShipSKin.SKIN_TYPE_TB then
				local var_70_1, var_70_2, var_70_3 = EducateCharWordHelper.GetWordAndCV(NewEducateHelper.GetSecIdBySkinId(arg_70_0.id), EducateCharWordHelper.WORD_KEY_LOGIN)

				arg_70_0.desc = var_70_3
			else
				local var_70_4, var_70_5, var_70_6 = ShipWordHelper.GetWordAndCV(arg_70_0.id, ShipWordHelper.WORD_TYPE_DROP)

				arg_70_0.desc = var_70_6
			end

			return var_70_0
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_71_0)
			arg_71_0.desc = pg.equip_skin_template[arg_71_0.id].desc

			return pg.equip_skin_template[arg_71_0.id]
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_72_0)
			arg_72_0.desc = pg.world_item_data_template[arg_72_0.id].display

			return pg.world_item_data_template[arg_72_0.id]
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_73_0)
			arg_73_0.desc = pg.item_data_frame[arg_73_0.id].desc

			return pg.item_data_frame[arg_73_0.id]
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_74_0)
			return pg.item_data_chat[arg_74_0.id]
		end,
		[DROP_TYPE_SPWEAPON] = function(arg_75_0)
			arg_75_0.desc = pg.spweapon_data_statistics[arg_75_0.id].descrip

			return pg.spweapon_data_statistics[arg_75_0.id]
		end,
		[DROP_TYPE_RYZA_DROP] = function(arg_76_0)
			arg_76_0.item = AtelierMaterial.New({
				configId = arg_76_0.id
			})
			arg_76_0.desc = arg_76_0.item:GetDesc()

			return pg.activity_ryza_item[arg_76_0.id]
		end,
		[DROP_TYPE_OPERATION] = function(arg_77_0)
			arg_77_0.ship = getProxy(BayProxy):getShipById(arg_77_0.count)

			local var_77_0, var_77_1, var_77_2 = ShipWordHelper.GetWordAndCV(pg.ship_data_statistics[arg_77_0.ship.configId].skin_id, ShipWordHelper.WORD_TYPE_DROP)

			arg_77_0.desc = var_77_2 or i18n("ship_drop_desc_default")

			return pg.ship_data_statistics[arg_77_0.ship.configId]
		end,
		[DROP_TYPE_STRATEGY] = function(arg_78_0)
			if arg_78_0.isWorldBuff then
				return pg.world_SLGbuff_data[arg_78_0.id] or pg.strategy_data_template[arg_78_0.id]
			end
		end,
		[DROP_TYPE_EMOJI] = function(arg_79_0)
			arg_79_0.name = pg.emoji_template[arg_79_0.id].item_name
			arg_79_0.desc = pg.emoji_template[arg_79_0.id].item_desc

			return pg.emoji_template[arg_79_0.id]
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_80_0)
			local var_80_0 = WorldCollectionProxy.GetCollectionTemplate(arg_80_0.id)

			arg_80_0.desc = var_80_0.name

			return var_80_0
		end,
		[DROP_TYPE_META_PT] = function(arg_81_0)
			local var_81_0 = Item.getConfigData(pg.ship_strengthen_meta[arg_81_0.id].itemid)

			arg_81_0.desc = var_81_0.display

			return var_81_0
		end,
		[DROP_TYPE_WORKBENCH_DROP] = function(arg_82_0)
			arg_82_0.item = WorkBenchItem.New({
				configId = arg_82_0.id
			})
			arg_82_0.desc = arg_82_0.item:GetDesc()

			return pg.activity_workbench_item[arg_82_0.id]
		end,
		[DROP_TYPE_BUFF] = function(arg_83_0)
			arg_83_0.desc = pg.benefit_buff_template[arg_83_0.id].desc

			return pg.benefit_buff_template[arg_83_0.id]
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_84_0)
			arg_84_0.desc = pg.commander_data_template[arg_84_0.id].desc

			return pg.commander_data_template[arg_84_0.id]
		end,
		[DROP_TYPE_ISLAND_ITEM] = function(arg_85_0)
			arg_85_0.desc = pg.island_item_data_template[arg_85_0.id].desc

			return pg.island_item_data_template[arg_85_0.id]
		end,
		[DROP_TYPE_ISLAND_ABILITY] = function(arg_86_0)
			arg_86_0.desc = ""

			return pg.island_ability_template[arg_86_0.id]
		end,
		[DROP_TYPE_ISLAND_INVITATION] = function(arg_87_0)
			arg_87_0.desc = pg.island_item_data_template[pg.island_chara_template[arg_87_0.id].invite_item].desc

			return pg.island_chara_template[arg_87_0.id]
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function(arg_88_0)
			arg_88_0.desc = pg.island_furniture_template[arg_88_0.id].describe

			return pg.island_furniture_template[arg_88_0.id]
		end,
		[DROP_TYPE_ISLAND_DRESS] = function(arg_89_0)
			arg_89_0.desc = pg.island_dress_template[arg_89_0.id].desc

			return pg.island_dress_template[arg_89_0.id]
		end,
		[DROP_TYPE_ISLAND_SKIN] = function(arg_90_0)
			arg_90_0.desc = pg.island_skin_template[arg_90_0.id].desc

			return pg.island_skin_template[arg_90_0.id]
		end,
		[DROP_TYPE_ISLAND_ACTION] = function(arg_91_0)
			arg_91_0.desc = pg.island_action[arg_91_0.id].desc

			return pg.island_action[arg_91_0.id]
		end,
		[DROP_TYPE_ISLAND_SPEEDUP_TICKET] = function(arg_92_0)
			arg_92_0.desc = pg.island_speedup_ticket[arg_92_0.id].desc

			return pg.island_speedup_ticket[arg_92_0.id]
		end,
		[DROP_TYPE_ISLAND_CARD_DIY] = function(arg_93_0)
			arg_93_0.desc = pg.island_card_diy[arg_93_0.id].desc

			return pg.island_card_diy[arg_93_0.id]
		end,
		[DROP_TYPE_TRANS_ITEM] = function(arg_94_0)
			return pg.drop_data_restore[arg_94_0.id]
		end,
		[DROP_TYPE_DORM3D_FURNITURE] = function(arg_95_0)
			arg_95_0.desc = pg.dorm3d_furniture_template[arg_95_0.id].desc

			return pg.dorm3d_furniture_template[arg_95_0.id]
		end,
		[DROP_TYPE_DORM3D_GIFT] = function(arg_96_0)
			arg_96_0.desc = pg.dorm3d_gift[arg_96_0.id].display

			return pg.dorm3d_gift[arg_96_0.id]
		end,
		[DROP_TYPE_DORM3D_SKIN] = function(arg_97_0)
			arg_97_0.desc = ""

			return pg.dorm3d_resource[arg_97_0.id]
		end,
		[DROP_TYPE_LIVINGAREA_COVER] = function(arg_98_0)
			arg_98_0.desc = pg.livingarea_cover[arg_98_0.id].desc

			return pg.livingarea_cover[arg_98_0.id]
		end,
		[DROP_TYPE_COMBAT_UI_STYLE] = function(arg_99_0)
			return pg.item_data_battleui[arg_99_0.id]
		end,
		[DROP_TYPE_ACTIVITY_MEDAL] = function(arg_100_0)
			return pg.item_virtual_data_statistics[pg.activity_medal_template[arg_100_0.id].item]
		end,
		[DROP_TYPE_HOLIDAY_VILLA] = function(arg_101_0)
			local var_101_0 = Item.getConfigData(arg_101_0.id)

			assert(var_101_0, arg_101_0.id)

			arg_101_0.desc = var_101_0.display

			return var_101_0
		end,
		[DROP_TYPE_ISLAND_COLLECTION] = function(arg_102_0)
			return pg.island_collection[arg_102_0.id]
		end,
		[VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT] = function(arg_103_0)
			arg_103_0.desc = pg.island_item_data_template[pg.island_set.season_pt_show.key_value_int].desc

			return pg.island_item_data_template[pg.island_set.season_pt_show.key_value_int]
		end
	}

	function var_0_0.ConfigDefault(arg_104_0)
		if tonumber(arg_104_0.type) and arg_104_0.type > DROP_TYPE_USE_ACTIVITY_DROP then
			return pg.activity_drop_type[arg_104_0.type].relevance and pg[pg.activity_drop_type[arg_104_0.type].relevance][arg_104_0.id]
		end

		return
	end

	var_0_0.CountCase = {
		[DROP_TYPE_RESOURCE] = function(arg_105_0)
			return getProxy(PlayerProxy):getRawData():getResById(arg_105_0.id), true
		end,
		[DROP_TYPE_ITEM] = function(arg_106_0)
			local var_106_0 = getProxy(BagProxy):getItemCountById(arg_106_0.id)

			if arg_106_0:getConfig("type") == Item.LOVE_LETTER_TYPE then
				return math.min(var_106_0, 1), true
			else
				return var_106_0, true
			end

			return
		end,
		[DROP_TYPE_EQUIP] = function(arg_107_0)
			local var_107_0 = arg_107_0:getConfig("group")

			assert(pg.equip_data_template.get_id_list_by_group[var_107_0], "equip groupId not exist")

			return underscore.reduce(pg.equip_data_template.get_id_list_by_group[var_107_0], 0, function(arg_108_0, arg_108_1)
				local var_108_0 = getProxy(EquipmentProxy):getEquipmentById(arg_108_1)

				if var_108_0 then
					local var_108_1 = var_108_0.count or 0

					return arg_108_0 + var_108_1 + getProxy(BayProxy):GetEquipCountInShips(arg_108_1)
				end
			end)
		end,
		[DROP_TYPE_SHIP] = function(arg_109_0)
			return getProxy(BayProxy):getConfigShipCount(arg_109_0.id)
		end,
		[DROP_TYPE_FURNITURE] = function(arg_110_0)
			return getProxy(DormProxy):getRawData():GetOwnFurnitureCount(arg_110_0.id)
		end,
		[DROP_TYPE_STRATEGY] = function(arg_111_0)
			local var_111_1 = tobool(arg_111_0.count)
		end,
		[DROP_TYPE_SKIN] = function(arg_112_0)
			return getProxy(ShipSkinProxy):getSkinCountById(arg_112_0.id)
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_113_0)
			return getProxy(ShipSkinProxy):getSkinCountById(arg_113_0.id)
		end,
		[DROP_TYPE_VITEM] = function(arg_114_0)
			return switch(arg_114_0:getConfig("virtual_type"), {
				[22] = function()
					local var_115_0 = getProxy(ActivityProxy):getActivityById(arg_114_0:getConfig("link_id"))

					if var_115_0 then
						local var_115_1 = var_115_0.data1 or 0

						return var_115_1, true
					end
				end,
				[101] = function()
					local var_116_0 = getProxy(ActivityProxy):getActivityById(arg_114_0:getConfig("link_id"))

					if var_116_0 then
						return var_116_0.data1 or 0
					end
				end
			}, function()
				return nil
			end)
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_118_0)
			local var_118_0 = getProxy(EquipmentProxy):getEquipmnentSkinById(arg_118_0.id)

			if var_118_0 then
				local var_118_1 = var_118_0.count or 0
				local var_118_2 = getProxy(BayProxy)

				return var_118_1 + var_118_2:GetEquipSkinCountInShips(arg_118_0.id)
			end
		end,
		[DROP_TYPE_RYZA_DROP] = function(arg_119_0)
			local var_119_0 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[arg_119_0.type].activity_id)

			if not var_119_0 then
				return 0
			end

			local var_119_1 = var_119_0:GetItemById(arg_119_0.id)

			if var_119_1 then
				return var_119_1.count or 0
			end
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_120_0)
			local var_120_0 = getProxy(AttireProxy):getAttireFrame(AttireConst.TYPE_ICON_FRAME, arg_120_0.id)

			return var_120_0 and var_120_0:isOwned() and 1 or 0
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_121_0)
			local var_121_0 = getProxy(AttireProxy):getAttireFrame(AttireConst.TYPE_CHAT_FRAME, arg_121_0.id)

			return var_121_0 and var_121_0:isOwned() and 1 or 0
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_122_0)
			local var_122_0 = nowWorld()

			if var_122_0.type ~= World.TypeFull then
				assert(false)

				return 0, false
			else
				local var_122_1 = var_122_0:GetInventoryProxy()

				return var_122_1:GetItemCount(arg_122_0.id), false
			end

			return
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_123_0)
			return getProxy(CommanderProxy):GetSameConfigIdCommanderCount(arg_123_0.id)
		end,
		[DROP_TYPE_LIVINGAREA_COVER] = function(arg_124_0)
			local var_124_0 = getProxy(LivingAreaCoverProxy):GetCover(arg_124_0.id)

			return var_124_0 and var_124_0:IsUnlock() and 1 or 0
		end,
		[DROP_TYPE_DORM3D_GIFT] = function(arg_125_0)
			return getProxy(ApartmentProxy):getGiftCount(arg_125_0.id), true
		end,
		[DROP_TYPE_COMBAT_UI_STYLE] = function(arg_126_0)
			local var_126_0 = getProxy(AttireProxy):getAttireFrame(AttireConst.TYPE_COMBAT_UI_STYLE, arg_126_0.id)

			return 1
		end,
		[DROP_TYPE_ISLAND_ITEM] = function(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = getProxy(IslandProxy):GetIsland()

			if var_127_1 then
				var_127_0 = var_127_1:GetInventoryAgency():GetOwnCount(arg_127_0.id)
			end

			return var_127_0
		end,
		[DROP_TYPE_ISLAND_ABILITY] = function(arg_128_0)
			return 0
		end,
		[DROP_TYPE_ISLAND_INVITATION] = function(arg_129_0)
			return 0
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function(arg_130_0)
			local var_130_0 = getProxy(IslandProxy):GetIsland()

			if var_130_0 then
				for iter_130_0, iter_130_1 in ipairs((var_130_0:GetAgoraAgency():GetFurnitures())) do
					if iter_130_1.id == arg_130_0.id then
						return iter_130_1.count
					end
				end
			end

			return 0
		end,
		[DROP_TYPE_ISLAND_DRESS] = function(arg_131_0)
			local var_131_0 = getProxy(IslandProxy):GetIsland()

			if var_131_0 then
				local var_131_1 = arg_131_0:getConfig("belongto")

				if var_131_1 == 1 then
					local var_131_2 = var_131_0:GetDressUpAgency()

					return var_131_2:CheckOwnDress(arg_131_0.id) and 1 or 0
				elseif var_131_1 == 2 then
					return var_131_0:GetCharacterAgency():GetDressIdRealCount(arg_131_0.id)
				end
			end

			return 0
		end,
		[DROP_TYPE_ISLAND_SKIN] = function(arg_132_0)
			local var_132_0 = getProxy(IslandProxy)

			if not var_132_0 then
				return 0
			end

			local var_132_1 = var_132_0:GetIsland()

			if var_132_1 then
				local var_132_2 = var_132_1:GetCharacterAgency()

				return var_132_2:CheckSkinIsOwned(arg_132_0.id) and 1 or 0
			end

			return 0
		end,
		[DROP_TYPE_ISLAND_ACTION] = function(arg_133_0)
			local var_133_0 = getProxy(IslandProxy)

			if not var_133_0 then
				return 0
			end

			local var_133_1 = var_133_0:GetIsland()

			if var_133_1 then
				local var_133_2 = var_133_1:GetActionAgency()

				return var_133_2:ExistAction(arg_133_0.id) and 1 or 0
			end

			return 0
		end,
		[VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT] = function(arg_134_0)
			local var_134_0 = getProxy(IslandProxy)

			if not var_134_0 then
				return 0
			end

			local var_134_1 = var_134_0:GetIsland()

			if var_134_1 then
				return var_134_1:GetSeasonAgency():GetSeason():GetPt()
			end

			return 0
		end,
		[DROP_TYPE_ISLAND_CARD_DIY] = function(arg_135_0)
			local var_135_0 = getProxy(IslandProxy)

			if not var_135_0 then
				return 0
			end

			local var_135_1 = var_135_0:GetIsland()

			if var_135_1 then
				return var_135_1:GetCardDiyAgency():GetIdCount(arg_135_0.id)
			end

			return 0
		end
	}

	function var_0_0.CountDefault(arg_136_0)
		if arg_136_0.type > DROP_TYPE_USE_ACTIVITY_DROP then
			return getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[arg_136_0.type].activity_id):getVitemNumber(arg_136_0.id)
		else
			return 0, false
		end

		return
	end

	var_0_0.LimitCase = {
		[DROP_TYPE_FURNITURE] = function(arg_137_0)
			return arg_137_0:getConfig("count")
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_138_0)
			return 1
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_139_0)
			return 1
		end,
		[DROP_TYPE_SKIN] = function(arg_140_0)
			return 1
		end
	}

	function var_0_0.LimitDefault(arg_141_0)
		return 0
	end

	var_0_0.SubClassCase = {
		[DROP_TYPE_RESOURCE] = function(arg_142_0)
			return
		end,
		[DROP_TYPE_ITEM] = function(arg_143_0)
			return Item.New(arg_143_0)
		end,
		[DROP_TYPE_VITEM] = function(arg_144_0)
			return Item.New(arg_144_0)
		end,
		[DROP_TYPE_EQUIP] = function(arg_145_0)
			return Equipment.New(arg_145_0)
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_146_0)
			return Item.New({
				count = 1,
				id = arg_146_0.id,
				extra = arg_146_0.count
			})
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_147_0)
			return WorldItem.New(arg_147_0)
		end
	}

	function var_0_0.SubClassDefault(arg_148_0)
		assert(false, string.format("drop type %d without subClass", arg_148_0.type))

		return
	end

	var_0_0.RarityCase = {
		[DROP_TYPE_RESOURCE] = function(arg_149_0)
			return arg_149_0:getConfig("rarity")
		end,
		[DROP_TYPE_ITEM] = function(arg_150_0)
			return arg_150_0:getConfig("rarity")
		end,
		[DROP_TYPE_EQUIP] = function(arg_151_0)
			return arg_151_0:getConfig("rarity") - 1
		end,
		[DROP_TYPE_SHIP] = function(arg_152_0)
			return arg_152_0:getConfig("rarity") - 1
		end,
		[DROP_TYPE_FURNITURE] = function(arg_153_0)
			return arg_153_0:getConfig("rarity")
		end,
		[DROP_TYPE_SKIN] = function(arg_154_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_155_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_VITEM] = function(arg_156_0)
			return arg_156_0:getConfig("rarity")
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_157_0)
			return arg_157_0:getConfig("rarity")
		end,
		[DROP_TYPE_BUFF] = function(arg_158_0)
			return ItemRarity.Purple
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_159_0)
			return arg_159_0:getConfig("rarity") - 1
		end,
		[DROP_TYPE_DORM3D_FURNITURE] = function(arg_160_0)
			return arg_160_0:getConfig("rarity")
		end,
		[DROP_TYPE_DORM3D_SKIN] = function(arg_161_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_162_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_COMBAT_UI_STYLE] = function(arg_163_0)
			return arg_163_0:getConfig("rare")
		end,
		[DROP_TYPE_ACTIVITY_MEDAL] = function(arg_164_0)
			return arg_164_0:getConfig("rarity")
		end,
		[DROP_TYPE_ISLAND_ITEM] = function(arg_165_0)
			return arg_165_0:getConfig("rarity")
		end,
		[DROP_TYPE_ISLAND_ABILITY] = function(arg_166_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_ISLAND_INVITATION] = function(arg_167_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function(arg_168_0)
			return arg_168_0:getConfig("rarity")
		end,
		[DROP_TYPE_ISLAND_DRESS] = function(arg_169_0)
			return ItemRarity.Gold
		end,
		[DROP_TYPE_ISLAND_SKIN] = function(arg_170_0)
			return ItemRarity.Gold
		end,
		[VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT] = function(arg_171_0)
			return ItemRarity.Gold
		end
	}

	function var_0_0.RarityDefault(arg_172_0)
		return arg_172_0:getConfig("rarity") or ItemRarity.Gray
	end

	function var_0_0.RarityDefaultDorm(arg_173_0)
		return arg_173_0:getConfig("rarity") or ItemRarity.Purple
	end

	var_0_0.TransCase = {
		[DROP_TYPE_TRANS_ITEM] = function(arg_174_0)
			local var_174_0 = Drop.New({
				type = arg_174_0:getConfig("type"),
				id = arg_174_0:getConfig("resource_type"),
				count = arg_174_0:getConfig("resource_num") * arg_174_0.count
			})
			local var_174_1 = Drop.New({
				type = arg_174_0:getConfig("target_type"),
				id = arg_174_0:getConfig("target_id"),
				count = arg_174_0.count
			})

			PlayerConst.UpdateLinkActivity({
				var_174_1
			})

			var_174_0.name = string.format("%s(%s)", var_174_0:getName(), var_174_1:getName())

			return var_174_0
		end,
		[DROP_TYPE_RESOURCE] = function(arg_175_0)
			for iter_175_0, iter_175_1 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)) do
				if pg.battlepass_event_pt[iter_175_1.id].pt == arg_175_0.id then
					return nil, arg_175_0
				end
			end

			for iter_175_2, iter_175_3 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5)) do
				if pg.black_friday_battlepass_event_pt[iter_175_3.id].pt == arg_175_0.id then
					return nil, arg_175_0
				end
			end

			return arg_175_0
		end,
		[DROP_TYPE_OPERATION] = function(arg_176_0)
			if arg_176_0.id ~= 3 then
				return nil
			end

			return arg_176_0
		end,
		[DROP_TYPE_EMOJI] = function(arg_177_0)
			return nil, arg_177_0
		end,
		[DROP_TYPE_VITEM] = function(arg_178_0, arg_178_1, arg_178_2)
			assert(arg_178_0:getConfig("type") == 0, "item type error:must be virtual type from " .. arg_178_0.id)

			return switch(arg_178_0:getConfig("virtual_type"), {
				function()
					if arg_178_0:getConfig("link_id") == ActivityConst.LINLK_DUNHUANG_ACT then
						return nil, arg_178_0
					end

					return arg_178_0
				end,
				[6] = function()
					local var_180_0 = getProxy(ActivityProxy)
					local var_180_1 = var_180_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_REFLUX)

					if var_180_1 then
						var_180_1.data1KeyValueList[1][arg_178_2.taskId] = defaultValue(var_180_1.data1KeyValueList[1][arg_178_2.taskId], 0) + arg_178_0.count

						var_180_0:updateActivity(var_180_1)
					end

					return nil, arg_178_0
				end,
				[13] = function()
					local var_181_0 = arg_178_0:getName()
					local var_181_1 = getProxy(ActivityProxy):getActivityById(arg_178_0:getConfig("link_id"))

					if not var_181_1 or var_181_1:isEnd() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("coupon_timeout_tip", var_181_0))

						return nil
					elseif var_181_1:IsMaxCnt() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("coupon_repeat_tip", var_181_0))

						return nil
					else
						return arg_178_0, nil
					end

					return
				end,
				[17] = function()
					local var_182_0 = getProxy(ActivityProxy):getActivityById(arg_178_0:getConfig("link_id"))

					if var_182_0.data1 < 1 then
						return Drop.New({
							count = 1,
							type = DROP_TYPE_SHIP,
							id = var_182_0:getConfig("config_id")
						}), arg_178_0
					else
						return Drop.New({
							id = 3,
							type = DROP_TYPE_OPERATION,
							count = var_182_0.data2
						}), arg_178_0
					end

					return
				end,
				[21] = function()
					return nil, arg_178_0
				end,
				[28] = function()
					return Drop.New({
						type = arg_178_0.type,
						id = arg_178_0.id,
						count = math.floor(arg_178_0.count / 1000)
					}), (Drop.New({
						type = arg_178_0.type,
						id = arg_178_0.id,
						count = arg_178_0.count - math.floor(arg_178_0.count / 1000)
					}))
				end
			}, function()
				return arg_178_0
			end)
		end,
		[DROP_TYPE_SHIP] = function(arg_186_0, arg_186_1)
			if Ship.isMetaShipByConfigID(arg_186_0.id) and Player.isMetaShipNeedToTrans(arg_186_0.id) then
				local var_186_0 = table.indexof(arg_186_1, arg_186_0.id, 1)

				if var_186_0 then
					table.remove(arg_186_1, var_186_0)
				else
					local var_186_1 = Drop.New(Player.metaShip2Res(arg_186_0.id)[1])

					getProxy(BayProxy):addMetaTransItemMap(arg_186_0.id, var_186_1)

					return arg_186_0, var_186_1
				end
			end

			return arg_186_0
		end,
		[DROP_TYPE_SKIN] = function(arg_187_0)
			arg_187_0.isNew = not getProxy(ShipSkinProxy):hasNonLimitSkin(arg_187_0.id)

			return arg_187_0
		end,
		[DROP_TYPE_ACTIVITY_MEDAL] = function(arg_188_0)
			getProxy(PlayerProxy):getRawData():updateMedalList({
				{
					key = arg_188_0.id,
					value = pg.TimeMgr.GetInstance():GetServerTime()
				}
			})

			return arg_188_0
		end,
		[DROP_TYPE_BUFF] = function(arg_189_0)
			return nil, arg_189_0
		end
	}

	function var_0_0.TransDefault(arg_190_0)
		return arg_190_0
	end

	var_0_0.AddItemCase = {
		[DROP_TYPE_RESOURCE] = function(arg_191_0)
			local var_191_0 = id2res(arg_191_0.id)

			assert(var_191_0, "res should be defined: " .. arg_191_0.id)

			local var_191_1 = getProxy(PlayerProxy)
			local var_191_2 = var_191_1:getData()

			var_191_2:addResources({
				[var_191_0] = arg_191_0.count
			})
			var_191_1:updatePlayer(var_191_2)

			return
		end,
		[DROP_TYPE_ITEM] = function(arg_192_0)
			if arg_192_0:getConfig("type") == Item.EXP_BOOK_TYPE then
				local var_192_0 = math.min(arg_192_0:getConfig("max_num") - getProxy(BagProxy):getItemCountById(arg_192_0.id), arg_192_0.count)

				if var_192_0 > 0 then
					getProxy(BagProxy):addItemById(arg_192_0.id, var_192_0)
				end
			else
				getProxy(BagProxy):addItemById(arg_192_0.id, arg_192_0.count, arg_192_0.extra)
			end

			return
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_193_0)
			local var_193_0 = arg_193_0:getSubClass()

			getProxy(BagProxy):addItemById(var_193_0.id, var_193_0.count, var_193_0.extra)

			return
		end,
		[DROP_TYPE_EQUIP] = function(arg_194_0)
			getProxy(EquipmentProxy):addEquipmentById(arg_194_0.id, arg_194_0.count)

			return
		end,
		[DROP_TYPE_SHIP] = function(arg_195_0)
			return
		end,
		[DROP_TYPE_FURNITURE] = function(arg_196_0)
			local var_196_0 = getProxy(DormProxy)
			local var_196_1 = Furniture.New({
				id = arg_196_0.id,
				count = arg_196_0.count
			})

			if var_196_1:isRecordTime() then
				var_196_1.date = pg.TimeMgr.GetInstance():GetServerTime()
			end

			local var_196_2 = var_196_0:getRawData()

			var_196_2:AddFurniture(var_196_1)
			var_196_0:updateDrom(var_196_2, BackYardConst.DORM_UPDATE_TYPE_FURNITURE)

			return
		end,
		[DROP_TYPE_SKIN] = function(arg_197_0)
			getProxy(ShipSkinProxy):addSkin((ShipSkin.New({
				id = arg_197_0.id
			})))

			return
		end,
		[DROP_TYPE_VITEM] = function(arg_198_0)
			arg_198_0 = arg_198_0:getSubClass()

			assert(arg_198_0:isVirtualItem(), "item type error(virtual item)>>" .. arg_198_0.id)
			switch(arg_198_0:getConfig("virtual_type"), {
				[0] = function()
					getProxy(ActivityProxy):addVitemById(arg_198_0.id, arg_198_0.count)

					return
				end,
				function()
					local var_200_0 = getProxy(ActivityProxy)
					local var_200_1 = arg_198_0:getConfig("link_id")
					local var_200_2 = var_200_1 > 0 and var_200_0:getActivityById(var_200_1) or var_200_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_PUZZLA)

					if var_200_2 and not var_200_2:isEnd() then
						if not table.contains(var_200_2.data1_list, arg_198_0.id) then
							table.insert(var_200_2.data1_list, arg_198_0.id)
						end

						var_200_0:updateActivity(var_200_2)
					end

					return
				end,
				function()
					local var_201_0 = getProxy(ActivityProxy)

					for iter_201_0, iter_201_1 in ipairs((var_201_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_VOTE))) do
						iter_201_1.data1 = iter_201_1.data1 + arg_198_0.count

						local var_201_1 = pg.activity_vote[iter_201_1:getConfig("config_id")]

						if var_201_1 and var_201_1.ticket_id_period == arg_198_0.id then
							iter_201_1.data3 = iter_201_1.data3 + arg_198_0.count
						end

						var_201_0:updateActivity(iter_201_1)
						pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_VOTE, {
							ptId = arg_198_0.id,
							ptCount = arg_198_0.count
						})
					end

					return
				end,
				[4] = function()
					local var_202_0 = getProxy(ColoringProxy):getColorItems()
					local var_202_1 = var_202_0[arg_198_0.id] or 0

					var_202_0[arg_198_0.id] = var_202_1 + arg_198_0.count

					return
				end,
				[6] = function()
					local var_203_0 = getProxy(ActivityProxy)
					local var_203_1 = var_203_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_REFLUX)

					if var_203_1 then
						var_203_1.data3 = var_203_1.data3 + arg_198_0.count

						var_203_0:updateActivity(var_203_1)
					end

					return
				end,
				[7] = function()
					local var_204_0 = getProxy(ChapterProxy)

					var_204_0:updateRemasterTicketsNum(math.min(var_204_0.remasterTickets + arg_198_0.count, pg.gameset.reactivity_ticket_max.key_value))

					return
				end,
				[9] = function()
					local var_205_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

					if var_205_0 then
						var_205_0.data1_list[1] = var_205_0.data1_list[1] + arg_198_0.count

						getProxy(ActivityProxy):updateActivity(var_205_0)
					end

					return
				end,
				[11] = function()
					local var_206_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_RED_PACKETS)

					if var_206_0 and not var_206_0:isEnd() then
						var_206_0.data1 = var_206_0.data1 + arg_198_0.count
					end

					return
				end,
				[12] = function()
					local var_207_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BUILDING_BUFF)

					if var_207_0 and not var_207_0:isEnd() then
						local var_207_1 = var_207_0.data1KeyValueList[1][arg_198_0.id] or 0

						var_207_0.data1KeyValueList[1][arg_198_0.id] = var_207_1 + arg_198_0.count
					end

					return
				end,
				[13] = function()
					local var_208_0 = getProxy(ActivityProxy):getActivityById(arg_198_0:getConfig("link_id"))

					if var_208_0:IsMaxCnt() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_already owned"))

						return
					end

					var_208_0.data1 = var_208_0.data1 + arg_198_0.count

					getProxy(ActivityProxy):updateActivity(var_208_0)

					return
				end,
				[14] = function()
					local var_209_0 = nowWorld():GetBossProxy()

					if WorldBossConst.WORLD_BOSS_ITEM_ID == arg_198_0.id then
						var_209_0:AddSummonPt(arg_198_0.count)
					elseif WorldBossConst.WORLD_PAST_BOSS_ITEM_ID == arg_198_0.id then
						var_209_0:AddSummonPtOld(arg_198_0.count)
					end

					return
				end,
				[15] = function()
					local var_210_0 = getProxy(ActivityProxy)
					local var_210_1 = var_210_0:getActivityById(arg_198_0:getConfig("link_id"))

					if not var_210_1 or var_210_1:isEnd() then
						return
					end

					if var_210_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_WORLDINPICTURE then
						if arg_198_0.id == pg.activity_event_grid[var_210_1.data1].ticket_item then
							var_210_1.data2 = var_210_1.data2 + arg_198_0.count
						elseif arg_198_0.id == pg.activity_event_grid[var_210_1.data1].explore_item then
							var_210_1.data3 = var_210_1.data3 + arg_198_0.count
						end
					elseif var_210_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_EXPEDITION then
						var_210_1.data3 = var_210_1.data3 + arg_198_0.count
					end

					var_210_0:updateActivity(var_210_1)

					return
				end,
				[16] = function()
					local var_211_0 = getProxy(ActivityProxy)

					for iter_211_0, iter_211_1 in pairs((var_211_0:getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHAKE_BEADS))) do
						if iter_211_1 and not iter_211_1:isEnd() and arg_198_0.id == iter_211_1:getConfig("config_id") then
							iter_211_1.data1 = iter_211_1.data1 + arg_198_0.count

							var_211_0:updateActivity(iter_211_1)
						end
					end

					return
				end,
				[17] = function()
					local var_212_0 = getProxy(ActivityProxy)
					local var_212_1 = var_212_0:getActivityById(arg_198_0:getConfig("link_id"))

					if not var_212_1 or var_212_1:isEnd() then
						return
					end

					var_212_1.data1 = 2

					var_212_0:updateActivity(var_212_1)

					return
				end,
				[20] = function()
					local var_213_0 = getProxy(BagProxy)
					local var_213_1 = math.min(pg.gameset.urpt_chapter_max.description[2] - var_213_0:GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), arg_198_0.count)

					if var_213_1 > 0 then
						var_213_0:addItemById(pg.gameset.urpt_chapter_max.description[1], var_213_1)
						var_213_0:AddLimitCnt(pg.gameset.urpt_chapter_max.description[1], var_213_1)
					end

					return
				end,
				[21] = function()
					local var_214_0 = getProxy(ActivityProxy)
					local var_214_1 = var_214_0:getActivityById(arg_198_0:getConfig("link_id"))

					if var_214_1 and not var_214_1:isEnd() then
						var_214_1.data2 = 1

						var_214_0:updateActivity(var_214_1)
					end

					return
				end,
				[22] = function()
					local var_215_0 = getProxy(ActivityProxy)
					local var_215_1 = var_215_0:getActivityById(arg_198_0:getConfig("link_id"))

					if var_215_1 and not var_215_1:isEnd() then
						var_215_1.data1 = var_215_1.data1 + arg_198_0.count

						var_215_0:updateActivity(var_215_1)
					end

					return
				end,
				[23] = function()
					local var_216_0 = (function()
						for iter_217_0, iter_217_1 in ipairs(pg.gameset.package_lv.description) do
							if arg_198_0.id == iter_217_1[1] then
								return iter_217_1[2]
							end
						end

						return
					end)()

					assert(var_216_0)

					local var_216_1 = getProxy(PlayerProxy)
					local var_216_2 = var_216_1:getData()

					var_216_2:addExpToLevel(var_216_0)
					var_216_1:updatePlayer(var_216_2)

					return
				end,
				[24] = function()
					local var_218_0 = getProxy(ActivityProxy):getActivityById((arg_198_0:getConfig("link_id")))

					if var_218_0 and not var_218_0:isEnd() and var_218_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_HOTSPRING then
						var_218_0.data2 = var_218_0.data2 + arg_198_0.count

						getProxy(ActivityProxy):updateActivity(var_218_0)
					end

					return
				end,
				[25] = function()
					local var_219_0 = getProxy(ActivityProxy)
					local var_219_1 = var_219_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_FIREWORK)

					if var_219_1 and not var_219_1:isEnd() then
						var_219_1.data1 = var_219_1.data1 - 1

						if not table.contains(var_219_1.data1_list, arg_198_0.id) then
							table.insert(var_219_1.data1_list, arg_198_0.id)
						end

						var_219_0:updateActivity(var_219_1)

						local var_219_2 = arg_198_0:getConfig("link_id")

						if var_219_2 > 0 then
							local var_219_3 = var_219_0:getActivityById(var_219_2)

							if var_219_3 and not var_219_3:isEnd() then
								var_219_3.data1 = var_219_3.data1 + 1

								var_219_0:updateActivity(var_219_3)
							end
						end
					end

					return
				end,
				[26] = function()
					local var_220_0 = getProxy(ActivityProxy)
					local var_220_1 = Clone(var_220_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING))

					if var_220_1 and not var_220_1:isEnd() then
						var_220_1.data1 = var_220_1.data1 + arg_198_0.count

						var_220_0:updateActivity(var_220_1)
					end

					return
				end,
				[27] = function()
					local var_221_0 = getProxy(ActivityProxy)
					local var_221_1 = Clone(var_221_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN))

					if var_221_1 and not var_221_1:isEnd() then
						var_221_1:AddExp(arg_198_0.count)
						var_221_0:updateActivity(var_221_1)
					end

					return
				end,
				[28] = function()
					local var_222_0 = getProxy(ActivityProxy)
					local var_222_1 = Clone(var_222_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN))

					if var_222_1 and not var_222_1:isEnd() then
						var_222_1:AddGold(arg_198_0.count)
						var_222_0:updateActivity(var_222_1)
					end

					return
				end,
				[29] = function()
					local var_223_0 = getProxy(ActivityProxy)
					local var_223_1 = Clone(var_223_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_PT_HEI5))

					if var_223_1 and not var_223_1:isEnd() then
						var_223_1.data1 = var_223_1.data1 + arg_198_0.count

						var_223_0:updateActivity(var_223_1)
					end

					return
				end,
				[30] = function()
					local var_224_0 = getProxy(ActivityProxy):getActivityById((arg_198_0:getConfig("link_id")))

					if not var_224_0 or var_224_0:isEnd() then
						return
					end

					local var_224_1 = arg_198_0.count

					if var_224_0:IsLimitExpItem(arg_198_0.id) then
						var_224_1 = var_224_0:FilterExp(var_224_1)
						var_224_1 = getProxy(LoveLetterProxy):AddLoveLetterExp(var_224_0:GetTargetGroupId(), var_224_1)

						var_224_0:AddDailyProgress(var_224_1)
					else
						local var_224_2 = getProxy(LoveLetterProxy):AddLoveLetterExp(var_224_0:GetTargetGroupId(), var_224_1)
					end

					getProxy(ActivityProxy):updateActivity(var_224_0)

					return
				end,
				[31] = function()
					getProxy(AuctionGameBaseProxy):AddGold(arg_198_0.count)

					return
				end,
				[99] = function()
					return
				end,
				[100] = function()
					return
				end,
				[101] = function()
					local var_228_0 = getProxy(ActivityProxy):getActivityById((arg_198_0:getConfig("link_id")))

					if var_228_0 and not var_228_0:isEnd() then
						var_228_0.data1 = var_228_0.data1 + arg_198_0.count

						getProxy(ActivityProxy):updateActivity(var_228_0)
					end

					return
				end,
				[102] = function()
					switch(pg.activity_template[arg_198_0:getConfig("link_id")].type, {
						[ActivityConst.ACTIVITY_TYPE_CITY_REBUILD] = function()
							getProxy(CityRebuildProxy):AddPt(var_0, arg_198_0.count)

							return
						end
					})

					return
				end,
				[103] = function()
					local var_231_0 = getProxy(ActivityProxy):getActivityById((arg_198_0:getConfig("link_id")))

					if not var_231_0 or var_231_0:isEnd() then
						return
					end

					switch(var_231_0:getConfig("type"), {
						[ActivityConst.ACTIVITY_TYPE_TOWN2] = function()
							local var_232_0 = getProxy(ActivityProxy)
							local var_232_1 = Clone(var_232_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_TOWN2))

							if arg_198_0:getConfig("id") == pg.activity_town_2[var_232_1.id].bubble_drop[1][2] then
								var_232_1:AddGold(arg_198_0.count)
								var_232_1:AddAllGold(arg_198_0.count)
							else
								var_232_1:AddGold2(arg_198_0.count)
							end

							var_232_0:updateActivity(var_232_1)

							return
						end,
						[ActivityConst.ACTIVITY_TYPE_MALL] = function()
							local var_233_0 = arg_198_0.id ~= var_231_0:getConfig("config_data")[1]

							if var_233_0 then
								var_231_0:AddStaff(arg_198_0.id, arg_198_0.count)
							else
								var_231_0:AddGold(arg_198_0.count)
							end

							getProxy(ActivityProxy):updateActivity(var_231_0)

							if var_233_0 then
								pg.m02:sendNotification(GAME.ACTIVITY_MALL_OP, {
									activity_id = var_231_0.id,
									cmd = ActivityMallOPCommand.CMD.GET_STAFF_DATA,
									arg1 = arg_198_0.count
								})
							end

							return
						end
					}, function()
						assert(var_231_0 .. "对应" .. var_0 .. "错误")

						return
					end)

					return
				end
			})

			return
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_235_0)
			getProxy(EquipmentProxy):addEquipmentSkin(arg_235_0.id, arg_235_0.count)

			return
		end,
		[DROP_TYPE_OPERATION] = function(arg_236_0)
			local var_236_0 = getProxy(BayProxy)
			local var_236_1 = var_236_0:getShipById(arg_236_0.count)

			if var_236_1 then
				var_236_1:unlockActivityNpc(0)
				var_236_0:updateShip(var_236_1)
				getProxy(CollectionProxy):flushCollection(var_236_1)
			end

			return
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_237_0)
			nowWorld():GetInventoryProxy():AddItem(arg_237_0.id, arg_237_0.count)

			return
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_238_0)
			local var_238_0 = IconFrame.New({
				id = arg_238_0.id
			})

			var_238_0:updateData({
				isNew = true,
				end_time = pg.TimeMgr.GetInstance():GetServerTime() + var_238_0:getConfig("time_second")
			})
			getProxy(AttireProxy):addAttireFrame(var_238_0)
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_ATTIRE, var_238_0)

			return
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_239_0)
			local var_239_0 = ChatFrame.New({
				id = arg_239_0.id
			})

			var_239_0:updateData({
				isNew = true,
				end_time = pg.TimeMgr.GetInstance():GetServerTime() + var_239_0:getConfig("time_second")
			})
			getProxy(AttireProxy):addAttireFrame(var_239_0)
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_ATTIRE, var_239_0)

			return
		end,
		[DROP_TYPE_EMOJI] = function(arg_240_0)
			getProxy(EmojiProxy):addNewEmojiID(arg_240_0.id)
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_EMOJI, arg_240_0:getConfigTable())

			return
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_241_0)
			nowWorld():GetCollectionProxy():Unlock(arg_241_0.id)

			return
		end,
		[DROP_TYPE_META_PT] = function(arg_242_0)
			getProxy(MetaCharacterProxy):getMetaProgressVOByID(arg_242_0.id):addPT(arg_242_0.count)

			return
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_243_0)
			local var_243_0 = getProxy(ShipSkinProxy)
			local var_243_1 = var_243_0:getSkinById(arg_243_0.id)

			if var_243_1 and var_243_1:isExpireType() then
				var_243_0:addSkin((ShipSkin.New({
					id = arg_243_0.id,
					end_time = arg_243_0.count + var_243_1.endTime
				})))
			elseif not var_243_1 then
				var_243_0:addSkin((ShipSkin.New({
					id = arg_243_0.id,
					end_time = arg_243_0.count + pg.TimeMgr.GetInstance():GetServerTime()
				})))
			end

			return
		end,
		[DROP_TYPE_BUFF] = function(arg_244_0)
			assert(pg.benefit_buff_template[arg_244_0.id] and pg.benefit_buff_template[arg_244_0.id].act_id > 0, "should exist act id")

			local var_244_0 = getProxy(ActivityProxy):getActivityById(pg.benefit_buff_template[arg_244_0.id].act_id)

			if var_244_0 and not var_244_0:isEnd() then
				var_244_0:AddBuff(ActivityBuff.New(var_244_0.id, arg_244_0.id, pg.TimeMgr.GetInstance():GetServerTime() + pg.benefit_buff_template[arg_244_0.id].max_time))
				getProxy(ActivityProxy):updateActivity(var_244_0)
			end

			return
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_245_0)
			return
		end,
		[DROP_TYPE_DORM3D_FURNITURE] = function(arg_246_0)
			getProxy(ApartmentProxy):ModifyRoom(arg_246_0:getConfig("room_id"), function(arg_247_0)
				arg_247_0:AddFurnitureByID(arg_246_0.id)

				return
			end)

			return
		end,
		[DROP_TYPE_DORM3D_GIFT] = function(arg_248_0)
			getProxy(ApartmentProxy):changeGiftCount(arg_248_0.id, arg_248_0.count)

			return
		end,
		[DROP_TYPE_DORM3D_SKIN] = function(arg_249_0)
			getProxy(ApartmentProxy):ModifyApartment(arg_249_0:getConfig("ship_group"), function(arg_250_0)
				arg_250_0:addSkin(arg_249_0.id)

				return
			end)

			return
		end,
		[DROP_TYPE_LIVINGAREA_COVER] = function(arg_251_0)
			local var_251_0 = LivingAreaCover.New({
				isNew = true,
				unlock = true,
				id = arg_251_0.id
			})

			getProxy(LivingAreaCoverProxy):UpdateCover(var_251_0)
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_COVER, var_251_0)
			pg.m02:sendNotification(GAME.APARTMENT_TRACK, Dorm3dTrackCommand.BuildDataCover(arg_251_0.id, 1))

			return
		end,
		[DROP_TYPE_COMBAT_UI_STYLE] = function(arg_252_0)
			local var_252_0 = pg.TimeMgr.GetInstance():GetServerTime()
			local var_252_1 = CombatUIStyle.New({
				id = arg_252_0.id
			})

			var_252_1:setUnlock()
			var_252_1:setNew()
			getProxy(AttireProxy):addAttireFrame(var_252_1)
			pg.ToastMgr.GetInstance():ShowToast(pg.ToastMgr.TYPE_COMBAT_UI, var_252_1)

			return
		end,
		[DROP_TYPE_ISLAND_ITEM] = function(arg_253_0)
			local var_253_0 = getProxy(IslandProxy):GetIsland()

			if not var_253_0 then
				return
			end

			var_253_0:GetInventoryAgency():AddItem(IslandItem.New({
				id = arg_253_0.id,
				num = arg_253_0.count
			}))

			return
		end
	}

	function var_0_0.AddItemDefault(arg_254_0)
		if arg_254_0.type > DROP_TYPE_USE_ACTIVITY_DROP then
			local var_254_0 = getProxy(ActivityProxy):getActivityById(pg.activity_drop_type[arg_254_0.type].activity_id)

			if arg_254_0.type == DROP_TYPE_RYZA_DROP then
				if var_254_0 and not var_254_0:isEnd() then
					var_254_0:AddItem(AtelierMaterial.New({
						configId = arg_254_0.id,
						count = arg_254_0.count
					}))
					getProxy(ActivityProxy):updateActivity(var_254_0)
				end
			elseif var_254_0 and not var_254_0:isEnd() then
				var_254_0:addVitemNumber(arg_254_0.id, arg_254_0.count)
				getProxy(ActivityProxy):updateActivity(var_254_0)
			end
		elseif arg_254_0.type >= DROP_TYPE_ISLAND_ITEM and arg_254_0.type <= DROP_TYPE_ISLAND_CARD_DIY then
			if not getProxy(IslandProxy):GetIsland() then
				return
			end

			local var_254_1 = {}

			table.insert({}, {
				type = arg_254_0.type,
				id = arg_254_0.id,
				number = arg_254_0.count
			})
			IslandDropHelper.AddItems({
				drop_list = var_254_1
			})
		else
			print("can not handle this type>>" .. arg_254_0.type)
		end

		return
	end

	var_0_0.MsgboxIntroCase = {
		[DROP_TYPE_RESOURCE] = function(arg_255_0, arg_255_1, arg_255_2)
			setText(arg_255_2, arg_255_0:getConfig("display"))

			return
		end,
		[DROP_TYPE_ITEM] = function(arg_256_0, arg_256_1, arg_256_2)
			local var_256_0 = arg_256_0:getConfig("display")

			if arg_256_0:getConfig("type") == Item.LOVE_LETTER_TYPE then
				var_256_0 = string.gsub(var_256_0, "$1", ShipGroup.getDefaultShipNameByGroupID(arg_256_0.extra))
			elseif arg_256_0:getConfig("combination_display") ~= nil then
				local var_256_1 = arg_256_0:getConfig("combination_display")

				if var_256_1 and #var_256_1 > 0 then
					var_256_0 = Item.StaticCombinationDisplay(var_256_1)
				end
			end

			setText(arg_256_2, SwitchSpecialChar(var_256_0, true))

			return
		end,
		[DROP_TYPE_FURNITURE] = function(arg_257_0, arg_257_1, arg_257_2)
			setText(arg_257_2, arg_257_0:getConfig("describe"))

			return
		end,
		[DROP_TYPE_SHIP] = function(arg_258_0, arg_258_1, arg_258_2)
			local var_258_0, var_258_1, var_258_2 = ShipWordHelper.GetWordAndCV(arg_258_0:getConfig("skin_id"), ShipWordHelper.WORD_TYPE_DROP, nil, PLATFORM_CODE ~= PLATFORM_US)

			setText(arg_258_2, var_258_2 or i18n("ship_drop_desc_default"))

			return
		end,
		[DROP_TYPE_OPERATION] = function(arg_259_0, arg_259_1, arg_259_2)
			local var_259_0, var_259_1, var_259_2 = ShipWordHelper.GetWordAndCV(arg_259_0:getConfig("skin_id"), ShipWordHelper.WORD_TYPE_DROP, nil, PLATFORM_CODE ~= PLATFORM_US)

			setText(arg_259_2, var_259_2 or i18n("ship_drop_desc_default"))

			return
		end,
		[DROP_TYPE_EQUIP] = function(arg_260_0, arg_260_1, arg_260_2)
			local var_260_0 = arg_260_1.name

			if not arg_260_1.name then
				var_260_0 = arg_260_0:getConfig("name")
				var_260_0 = var_260_0 or ""
			end

			setText(arg_260_2, var_260_0)

			return
		end,
		[DROP_TYPE_STRATEGY] = function(arg_261_0, arg_261_1, arg_261_2)
			local var_261_0 = arg_261_0:getConfig("desc")

			for iter_261_0, iter_261_1 in ipairs({
				arg_261_0.count
			}) do
				var_261_0 = string.gsub(var_261_0, "$" .. iter_261_0, iter_261_1)
			end

			setText(arg_261_2, var_261_0)

			return
		end,
		[DROP_TYPE_SKIN] = function(arg_262_0, arg_262_1, arg_262_2)
			setText(arg_262_2, arg_262_0:getConfig("desc"))

			return
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_263_0, arg_263_1, arg_263_2)
			setText(arg_263_2, arg_263_0:getConfig("desc"))

			return
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_264_0, arg_264_1, arg_264_2)
			setText(arg_264_2, arg_264_0:getConfig("desc") .. "\n\n" .. i18n("word_fit") .. ": " .. table.concat(_.map(arg_264_0:getConfig("equip_type"), function(arg_265_0)
				return EquipType.Type2Name2(arg_265_0)
			end), ","))

			return
		end,
		[DROP_TYPE_VITEM] = function(arg_266_0, arg_266_1, arg_266_2)
			setText(arg_266_2, arg_266_0:getConfig("display"))

			return
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_267_0, arg_267_1, arg_267_2)
			setText(arg_267_2, arg_267_0:getConfig("display"))

			return
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_268_0, arg_268_1, arg_268_2, arg_268_3)
			local var_268_0 = WorldCollectionProxy.GetCollectionType(arg_268_0.id) == WorldCollectionProxy.WorldCollectionType.FILE and "file" or "record"

			setText(arg_268_2, i18n("world_" .. var_268_0 .. "_desc", arg_268_0:getConfig("name")))
			setText(arg_268_3, i18n("world_" .. var_268_0 .. "_name", arg_268_0:getConfig("name")))

			return
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_269_0, arg_269_1, arg_269_2)
			local var_269_0 = arg_269_2

			if arg_269_0.desc then
				local var_269_1 = arg_269_0.desc or arg_269_0:getConfig("desc")

				setText(var_269_0, var_269_1)

				return
			end
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_270_0, arg_270_1, arg_270_2)
			setText(arg_270_2, arg_270_0:getConfig("desc"))

			return
		end,
		[DROP_TYPE_EMOJI] = function(arg_271_0, arg_271_1, arg_271_2)
			setText(arg_271_2, arg_271_0:getConfig("item_desc"))

			return
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_272_0, arg_272_1, arg_272_2)
			setText(arg_272_2, SwitchSpecialChar(string.gsub(arg_272_0:getConfig("display"), "$1", ShipGroup.getDefaultShipNameByGroupID(arg_272_0.count)), true))

			return
		end,
		[DROP_TYPE_META_PT] = function(arg_273_0, arg_273_1, arg_273_2)
			setText(arg_273_2, arg_273_0:getConfig("display"))

			return
		end,
		[DROP_TYPE_BUFF] = function(arg_274_0, arg_274_1, arg_274_2)
			setText(arg_274_2, arg_274_0:getConfig("desc"))

			return
		end,
		[DROP_TYPE_COMBAT_UI_STYLE] = function(arg_275_0, arg_275_1, arg_275_2)
			setText(arg_275_2, arg_275_0:getConfig("desc"))

			return
		end,
		[DROP_TYPE_ACTIVITY_MEDAL] = function(arg_276_0, arg_276_1, arg_276_2)
			setText(arg_276_2, arg_276_0:getConfig("display"))

			return
		end,
		[DROP_TYPE_LIVINGAREA_COVER] = function(arg_277_0, arg_277_1, arg_277_2)
			setText(arg_277_2, arg_277_0:getConfig("desc"))

			return
		end,
		[DROP_TYPE_ISLAND_ITEM] = function(arg_278_0, arg_278_1, arg_278_2)
			setText(arg_278_2, arg_278_0:getConfig("desc"))

			return
		end,
		[DROP_TYPE_ISLAND_ABILITY] = function(arg_279_0, arg_279_1, arg_279_2)
			setText(arg_279_2, "")

			return
		end,
		[DROP_TYPE_ISLAND_INVITATION] = function(arg_280_0, arg_280_1, arg_280_2)
			setText(arg_280_2, arg_280_0.desc)

			return
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function(arg_281_0, arg_281_1, arg_281_2)
			setText(arg_281_2, arg_281_0.desc)

			return
		end,
		[DROP_TYPE_ISLAND_DRESS] = function(arg_282_0, arg_282_1, arg_282_2)
			setText(arg_282_2, arg_282_0.desc)

			return
		end,
		[DROP_TYPE_ISLAND_SKIN] = function(arg_283_0, arg_283_1, arg_283_2)
			setText(arg_283_2, arg_283_0.desc)

			return
		end
	}

	function var_0_0.MsgboxIntroDefault(arg_284_0, arg_284_1, arg_284_2)
		if arg_284_0.type > DROP_TYPE_USE_ACTIVITY_DROP then
			setText(arg_284_2, arg_284_0:getConfig("display"))
		else
			local var_284_1 = arg_284_0.desc or ""

			var_284_0(arg_284_2, var_284_1)
		end

		return
	end

	var_0_0.UpdateDropCase = {
		[DROP_TYPE_RESOURCE] = function(arg_285_0, arg_285_1, arg_285_2)
			if arg_285_0.id == PlayerConst.ResStoreGold or arg_285_0.id == PlayerConst.ResStoreOil then
				arg_285_2 = arg_285_2 or {}
				arg_285_2.frame = "frame_store"
			end

			updateItem(arg_285_1, Item.New({
				id = id2ItemId(arg_285_0.id)
			}), arg_285_2)

			return
		end,
		[DROP_TYPE_ITEM] = function(arg_286_0, arg_286_1, arg_286_2)
			updateItem(arg_286_1, arg_286_0:getSubClass(), arg_286_2)

			return
		end,
		[DROP_TYPE_EQUIP] = function(arg_287_0, arg_287_1, arg_287_2)
			updateEquipment(arg_287_1, arg_287_0:getSubClass(), arg_287_2)

			return
		end,
		[DROP_TYPE_SHIP] = function(arg_288_0, arg_288_1, arg_288_2)
			updateShip(arg_288_1, arg_288_0.ship, arg_288_2)

			return
		end,
		[DROP_TYPE_OPERATION] = function(arg_289_0, arg_289_1, arg_289_2)
			updateShip(arg_289_1, arg_289_0.ship, arg_289_2)

			return
		end,
		[DROP_TYPE_FURNITURE] = function(arg_290_0, arg_290_1, arg_290_2)
			updateFurniture(arg_290_1, arg_290_0, arg_290_2)

			return
		end,
		[DROP_TYPE_STRATEGY] = function(arg_291_0, arg_291_1, arg_291_2)
			arg_291_2.isWorldBuff = arg_291_0.isWorldBuff

			updateStrategy(arg_291_1, arg_291_0, arg_291_2)

			return
		end,
		[DROP_TYPE_SKIN] = function(arg_292_0, arg_292_1, arg_292_2)
			arg_292_2.isSkin = true
			arg_292_2.isNew = arg_292_0.isNew

			updateShip(arg_292_1, Ship.New({
				configId = tonumber(arg_292_0:getConfig("ship_group") .. "1"),
				skin_id = arg_292_0.id
			}), arg_292_2)

			return
		end,
		[DROP_TYPE_EQUIPMENT_SKIN] = function(arg_293_0, arg_293_1, arg_293_2)
			updateEquipmentSkin(arg_293_1, setmetatable({
				count = arg_293_0.count
			}, {
				__index = arg_293_0:getConfigTable()
			}), arg_293_2)

			return
		end,
		[DROP_TYPE_VITEM] = function(arg_294_0, arg_294_1, arg_294_2)
			updateItem(arg_294_1, Item.New({
				id = arg_294_0.id
			}), arg_294_2)

			return
		end,
		[DROP_TYPE_WORLD_ITEM] = function(arg_295_0, arg_295_1, arg_295_2)
			updateWorldItem(arg_295_1, WorldItem.New({
				id = arg_295_0.id
			}), arg_295_2)

			return
		end,
		[DROP_TYPE_WORLD_COLLECTION] = function(arg_296_0, arg_296_1, arg_296_2)
			updateWorldCollection(arg_296_1, arg_296_0, arg_296_2)

			return
		end,
		[DROP_TYPE_CHAT_FRAME] = function(arg_297_0, arg_297_1, arg_297_2)
			updateAttire(arg_297_1, AttireConst.TYPE_CHAT_FRAME, arg_297_0:getConfigTable(), arg_297_2)

			return
		end,
		[DROP_TYPE_ICON_FRAME] = function(arg_298_0, arg_298_1, arg_298_2)
			updateAttire(arg_298_1, AttireConst.TYPE_ICON_FRAME, arg_298_0:getConfigTable(), arg_298_2)

			return
		end,
		[DROP_TYPE_EMOJI] = function(arg_299_0, arg_299_1, arg_299_2)
			updateEmoji(arg_299_1, arg_299_0:getConfigTable(), arg_299_2)

			return
		end,
		[DROP_TYPE_LOVE_LETTER] = function(arg_300_0, arg_300_1, arg_300_2)
			arg_300_2.count = 1

			updateItem(arg_300_1, arg_300_0:getSubClass(), arg_300_2)

			return
		end,
		[DROP_TYPE_SPWEAPON] = function(arg_301_0, arg_301_1, arg_301_2)
			updateSpWeapon(arg_301_1, SpWeapon.New({
				id = arg_301_0.id
			}), arg_301_2)

			return
		end,
		[DROP_TYPE_META_PT] = function(arg_302_0, arg_302_1, arg_302_2)
			updateItem(arg_302_1, Item.New({
				id = arg_302_0:getConfig("id")
			}), arg_302_2)

			return
		end,
		[DROP_TYPE_SKIN_TIMELIMIT] = function(arg_303_0, arg_303_1, arg_303_2)
			arg_303_2.isSkin = true
			arg_303_2.isTimeLimit = true
			arg_303_2.count = 1

			updateShip(arg_303_1, Ship.New({
				configId = tonumber(arg_303_0:getConfig("ship_group") .. "1"),
				skin_id = arg_303_0.id
			}), arg_303_2)

			return
		end,
		[DROP_TYPE_RYZA_DROP] = function(arg_304_0, arg_304_1, arg_304_2)
			AtelierMaterial.UpdateRyzaItem(arg_304_1, arg_304_0.item, arg_304_2)

			return
		end,
		[DROP_TYPE_WORKBENCH_DROP] = function(arg_305_0, arg_305_1, arg_305_2)
			WorkBenchItem.UpdateDrop(arg_305_1, arg_305_0.item, arg_305_2)

			return
		end,
		[DROP_TYPE_FEAST_DROP] = function(arg_306_0, arg_306_1, arg_306_2)
			WorkBenchItem.UpdateDrop(arg_306_1, WorkBenchItem.New({
				configId = arg_306_0.id,
				count = arg_306_0.count
			}), arg_306_2)

			return
		end,
		[DROP_TYPE_BUFF] = function(arg_307_0, arg_307_1, arg_307_2)
			updateBuff(arg_307_1, arg_307_0.id, arg_307_2)

			return
		end,
		[DROP_TYPE_COMMANDER_CAT] = function(arg_308_0, arg_308_1, arg_308_2)
			updateCommander(arg_308_1, arg_308_0, arg_308_2)

			return
		end,
		[DROP_TYPE_LIVINGAREA_COVER] = function(arg_309_0, arg_309_1, arg_309_2)
			updateCover(arg_309_1, arg_309_0, arg_309_2)

			return
		end,
		[DROP_TYPE_COMBAT_UI_STYLE] = function(arg_310_0, arg_310_1, arg_310_2)
			updateAttireCombatUI(arg_310_1, AttireConst.TYPE_ICON_FRAME, arg_310_0:getConfigTable(), arg_310_2)

			return
		end,
		[DROP_TYPE_ACTIVITY_MEDAL] = function(arg_311_0, arg_311_1, arg_311_2)
			updateActivityMedal(arg_311_1, arg_311_0:getConfigTable(), arg_311_2)

			return
		end
	}

	function var_0_0.UpdateDropDefault(arg_312_0, arg_312_1, arg_312_2)
		updateDefaultIconTpl(arg_312_1, arg_312_0, arg_312_2)

		return
	end

	var_0_0.UpdateCustomDropCase = {
		[DROP_TYPE_DORM3D_FURNITURE] = function(arg_313_0, arg_313_1, arg_313_2)
			updateDorm3dIcon(arg_313_1, arg_313_0, arg_313_2)

			return
		end,
		[DROP_TYPE_DORM3D_GIFT] = function(arg_314_0, arg_314_1, arg_314_2)
			updateDorm3dIcon(arg_314_1, arg_314_0, arg_314_2)

			return
		end,
		[DROP_TYPE_DORM3D_SKIN] = function(arg_315_0, arg_315_1, arg_315_2)
			updateDorm3dIcon(arg_315_1, arg_315_0, arg_315_2)

			return
		end,
		[DROP_TYPE_ISLAND_ITEM] = function(arg_316_0, arg_316_1, arg_316_2)
			updateIslandItem(arg_316_1, arg_316_0, arg_316_2)

			return
		end,
		[DROP_TYPE_ISLAND_ABILITY] = function(arg_317_0, arg_317_1, arg_317_2)
			updateIslandUnlock(arg_317_1, arg_317_0, arg_317_2)

			return
		end,
		[DROP_TYPE_ISLAND_INVITATION] = function(arg_318_0, arg_318_1, arg_318_2)
			updateIslandInvitation(arg_318_1, arg_318_0, arg_318_2)

			return
		end,
		[VIRTUAL_DROP_TYPE_ISLAND_SEASON_PT] = function(arg_319_0, arg_319_1, arg_319_2)
			updateIslandSeasonPt(arg_319_1, arg_319_0, arg_319_2)

			return
		end,
		[DROP_TYPE_ISLAND_COLLECTION] = function(arg_320_0, arg_320_1, arg_320_2)
			updateIslandWatherCollect(arg_320_1, arg_320_0, arg_320_2)

			return
		end,
		[DROP_TYPE_ISLAND_FURNITURE] = function(arg_321_0, arg_321_1, arg_321_2)
			updateIslandFurniture(arg_321_1, arg_321_0, arg_321_2)

			return
		end,
		[DROP_TYPE_ISLAND_CARD_DIY] = function(arg_322_0, arg_322_1, arg_322_2)
			updateIslandCardDiy(arg_322_1, arg_322_0, arg_322_2)

			return
		end,
		[DROP_TYPE_ISLAND_SPEEDUP_TICKET] = function(arg_323_0, arg_323_1, arg_323_2)
			updateIslandSpeedupTicket(arg_323_1, arg_323_0, arg_323_2)

			return
		end,
		[DROP_TYPE_HOLIDAY_VILLA] = function(arg_324_0, arg_324_1, arg_324_2)
			updateItem(arg_324_1, Item.New({
				id = arg_324_0.id
			}), arg_324_2)

			return
		end,
		[DROP_TYPE_ISLAND_SKIN] = function(arg_325_0, arg_325_1, arg_325_2)
			updateIslandSkin(arg_325_1, arg_325_0, arg_325_2)

			return
		end,
		[DROP_TYPE_ISLAND_DRESS] = function(arg_326_0, arg_326_1, arg_326_2)
			updateIslandDress(arg_326_1, arg_326_0, arg_326_2)

			return
		end
	}

	function var_0_0.UpdateCustomDropDefault(arg_327_0, arg_327_1, arg_327_2)
		if arg_327_2.style == "dorm" then
			updateDorm3dIcon(arg_327_1, arg_327_0, arg_327_2)
		elseif arg_327_2.style == "island" then
			updateIslandDefaultIconTpl(arg_327_1, arg_327_0, arg_327_2)
		else
			warning(string.format("without dropType %d in updateCustomDrop", arg_327_0.type))
		end

		return
	end

	return
end

return var_0_0
