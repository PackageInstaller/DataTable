local cjson = require("cjson")

function DealAreaDifferenceCfg(arg_1_0)
	if arg_1_0 == nil or arg_1_0 == "" or arg_1_0 == "zh_cn" then
		return
	end

	local var_1_0 = AssetEx.LoadText("AreaDifferentConfig")

	if not var_1_0 then
		return
	end

	for iter_1_0, iter_1_1 in pairs(cjson.decode(var_1_0) or {}) do
		RedirectAreaDiffConfig(iter_1_1 .. arg_1_0, iter_1_1)

		local var_1_1 = 2

		while _G[iter_1_1 .. 2] do
			RedirectAreaDiffConfig((iter_1_1 .. 2) .. arg_1_0, iter_1_1 .. 2)

			var_1_1 = var_1_1 + 1
		end
	end

	if GameToSDK.IsPCPlatform() and SDKTools.GetIsKorea() then
		AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list = {
			4,
			2,
			1
		}
	end
end

function RedirectAreaDiffConfig(arg_2_0, arg_2_1)
	if _G[arg_2_0] and _G[arg_2_1] then
		_G[arg_2_1] = _G[arg_2_0]
	end
end

DealAreaDifferenceCfg(GameToSDK.CURRENT_SERVER)

for iter_0_0, iter_0_1 in pairs({
	{
		ItemCfg,
		ItemCfg2
	},
	{
		ShopCfg,
		ShopCfg2,
		ShopCfg3,
		ShopCfg4
	},
	{
		EquipCfg,
		EquipCfg2
	},
	{
		AssignmentCfg,
		AssignmentCfg2
	}
}) do
	setmetatable(iter_0_1[1], {
		__index = function(arg_3_0, arg_3_1)
			for iter_3_0, iter_3_1 in ipairs(iter_0_1) do
				local var_3_0 = rawget(iter_3_1, arg_3_1)

				if var_3_0 then
					return var_3_0
				end
			end
		end
	})
end

for iter_0_2, iter_0_3 in ipairs(ChapterClientCfg.all) do
	if ChapterClientCfg[iter_0_3].not_chapter_id == false then
		for iter_0_4, iter_0_5 in ipairs(ChapterClientCfg[iter_0_3].chapter_list) do
			ChapterCfg[iter_0_5].clientID = iter_0_3
			ChapterClientCfg[iter_0_3].difficulty = ChapterCfg[iter_0_5].difficulty
		end
	else
		for iter_0_6, iter_0_7 in ipairs(ChapterClientCfg[iter_0_3].chapter_list) do
			ChapterClientCfg[iter_0_7].parentToggle = ChapterClientCfg[iter_0_3].toggle

			for iter_0_8, iter_0_9 in ipairs(ChapterClientCfg[iter_0_7].chapter_list) do
				ChapterCfg[iter_0_9].toggle = ChapterClientCfg[iter_0_7].toggle
			end
		end
	end
end

local var_0_1 = {}

for iter_0_10, iter_0_11 in pairs(ChapterCfg.all) do
	for iter_0_12, iter_0_13 in ipairs(ChapterCfg[iter_0_11].section_id_list) do
		var_0_1[iter_0_13] = var_0_1[iter_0_13] or iter_0_11
	end
end

local var_0_2 = {}

for iter_0_14, iter_0_15 in ipairs(ChapterCfg.get_id_list_by_type[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT]) do
	var_0_2[ChapterCfg[iter_0_15].sub_type] = var_0_2[ChapterCfg[iter_0_15].sub_type] or {}
	var_0_2[ChapterCfg[iter_0_15].sub_type][ChapterCfg[iter_0_15].difficulty] = var_0_2[ChapterCfg[iter_0_15].sub_type][ChapterCfg[iter_0_15].difficulty] or {}

	table.insert(var_0_2[ChapterCfg[iter_0_15].sub_type][ChapterCfg[iter_0_15].difficulty], iter_0_15)
end

function getChapterNumList(arg_4_0)
	return var_0_2[arg_4_0]
end

function getChapterList()
	return var_0_2
end

local var_0_3 = {}

for iter_0_16, iter_0_17 in ipairs(ChapterClientCfg.get_id_list_by_toggle[BattleConst.TOGGLE.PLOT]) do
	var_0_3[ChapterCfg[ChapterClientCfg[iter_0_17].chapter_list[1]].difficulty] = var_0_3[ChapterCfg[ChapterClientCfg[iter_0_17].chapter_list[1]].difficulty] or {}

	if #ChapterCfg[ChapterClientCfg[iter_0_17].chapter_list[1]].section_id_list > 0 then
		table.insert(var_0_3[ChapterCfg[ChapterClientCfg[iter_0_17].chapter_list[1]].difficulty], iter_0_17)
	end
end

function getChapterClientList()
	return var_0_3
end

StageTools.InitStageArchiveCfg()

local function var_0_4(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0.all) do
		if type(arg_7_0[iter_7_1].next_show_id_list) == "table" then
			for iter_7_2, iter_7_3 in ipairs(arg_7_0[iter_7_1].next_show_id_list) do
				arg_7_0[iter_7_3].pre_show_id_list = arg_7_0[iter_7_3].pre_show_id_list or {}

				table.insert(arg_7_0[iter_7_3].pre_show_id_list, iter_7_1)
			end
		end

		if type(arg_7_0[iter_7_1].next_unlock_id_list) == "table" then
			for iter_7_4, iter_7_5 in ipairs(arg_7_0[iter_7_1].next_unlock_id_list) do
				arg_7_0[iter_7_5].pre_unlock_id_list = arg_7_0[iter_7_5].pre_unlock_id_list or {}

				table.insert(arg_7_0[iter_7_5].pre_unlock_id_list, iter_7_1)
			end
		end
	end
end

for iter_0_18, iter_0_19 in pairs({
	BattleChapterStageCfg,
	BattleDailyStageCfg,
	BattleActivityStoryStageCfg
}) do
	var_0_4(iter_0_19)
end

local var_0_5 = {}

for iter_0_20, iter_0_21 in ipairs((string.split(GameSetting.guide_map.value2, ","))) do
	local var_0_6 = string.split(iter_0_21, "=")

	if var_0_6[1] and var_0_6[2] then
		var_0_5[tonumber(var_0_6[1])] = tonumber(var_0_6[2])
	end
end

GameSetting.guide_map.value2 = var_0_5

local var_0_7 = {}

for iter_0_22, iter_0_23 in pairs(WarchessHexCfg) do
	if iter_0_23.id then
		local var_0_8 = GridConfig.New()

		var_0_8.id = iter_0_23.id
		var_0_8.walkable = iter_0_23.move
		var_0_8.interact = iter_0_23.interact
		var_0_8.explode = iter_0_23.explode
		var_0_8.stonecanmove = iter_0_23.stonecanmove
		var_0_8.stonecaninteract = iter_0_23.stonecaninteract

		table.insert(var_0_7, var_0_8)
	end
end

WarchessHexCfg.AllGridConfig = var_0_7

local var_0_9 = {}

for iter_0_24, iter_0_25 in pairs(WarchessLevelCfg.all) do
	if type(WarchessLevelCfg[iter_0_25].trial_stage_list) == "table" then
		for iter_0_26, iter_0_27 in pairs(WarchessLevelCfg[iter_0_25].trial_stage_list) do
			var_0_9[iter_0_27] = WarchessLevelCfg[iter_0_25].id_level
		end
	end
end

function GetChessLevelIDByStageID(arg_8_0)
	return var_0_9[arg_8_0]
end

local var_0_10 = {}

for iter_0_28, iter_0_29 in pairs(BackHomeCfg) do
	if iter_0_29.id then
		local var_0_11 = DormMapCfg.New()

		var_0_11.id = iter_0_29.id
		var_0_11.name = iter_0_29.scene
		var_0_11.previewParams = DormCameraParams.New()
		var_0_11.editParams = DormCameraParams.New()
		var_0_11.previewParams.value = Vector2.New(DormCameraCfg[iter_0_29.camera_preview].value[1], DormCameraCfg[iter_0_29.camera_preview].value[2])
		var_0_11.previewParams.topRig = Vector2.New(DormCameraCfg[iter_0_29.camera_preview].toprig[1], DormCameraCfg[iter_0_29.camera_preview].toprig[2])
		var_0_11.previewParams.middleRig = Vector2.New(DormCameraCfg[iter_0_29.camera_preview].middlerig[1], DormCameraCfg[iter_0_29.camera_preview].middlerig[2])
		var_0_11.previewParams.bottomRig = Vector2.New(DormCameraCfg[iter_0_29.camera_preview].bottomrig[1], DormCameraCfg[iter_0_29.camera_preview].bottomrig[2])
		var_0_11.previewParams.topRigInterval = Vector2.New(DormCameraCfg[iter_0_29.camera_preview].toprig_interval[1], DormCameraCfg[iter_0_29.camera_preview].toprig_interval[2])
		var_0_11.editParams.value = Vector2.New(DormCameraCfg[iter_0_29.camera_edit].value[1], DormCameraCfg[iter_0_29.camera_edit].value[2])
		var_0_11.editParams.topRig = Vector2.New(DormCameraCfg[iter_0_29.camera_edit].toprig[1], DormCameraCfg[iter_0_29.camera_edit].toprig[2])
		var_0_11.editParams.middleRig = Vector2.New(DormCameraCfg[iter_0_29.camera_edit].middlerig[1], DormCameraCfg[iter_0_29.camera_edit].middlerig[2])
		var_0_11.editParams.bottomRig = Vector2.New(DormCameraCfg[iter_0_29.camera_edit].bottomrig[1], DormCameraCfg[iter_0_29.camera_edit].bottomrig[2])
		var_0_11.editParams.topRigInterval = Vector2.New(DormCameraCfg[iter_0_29.camera_edit].toprig_interval[1], DormCameraCfg[iter_0_29.camera_edit].toprig_interval[2])

		table.insert(var_0_10, var_0_11)
	end
end

BackHomeCfg.AllMapCfg = var_0_10

local var_0_12 = {}

for iter_0_30, iter_0_31 in pairs(BackHomeFurniture) do
	if iter_0_31.id and not DormSpecialFurnitureTools:JudgeFurIsSpecialType(iter_0_31.id) then
		local var_0_13 = FurnitureConfig.New()

		var_0_13.id = iter_0_31.id
		var_0_13.prefab = iter_0_31.model

		local var_0_14 = {
			iter_0_31.display_type
		}

		var_0_14[2] = iter_0_31.sub_type or 0
		var_0_13.type = var_0_14
		var_0_13.width = iter_0_31.title[1]
		var_0_13.height = iter_0_31.title[2]
		var_0_13.depth = iter_0_31.title[3] or 0

		table.insert(var_0_12, var_0_13)
	end
end

BackHomeFurniture.AllFurnitureConfig = var_0_12

local var_0_15 = {}
local var_0_16 = {}

for iter_0_32, iter_0_33 in pairs(HeroSkillCfg.all) do
	if HeroSkillCfg[iter_0_33].strengthen_desc and HeroSkillCfg[iter_0_33].strengthen_desc ~= "" then
		for iter_0_34, iter_0_35 in ipairs(HeroSkillCfg[iter_0_33].strengthen_desc) do
			if iter_0_35[1] then
				var_0_15[iter_0_35[1]] = iter_0_33
			end
		end
	end
end

for iter_0_36, iter_0_37 in pairs(WeaponEffectCfg.all) do
	if iter_0_37 > 0 and type(WeaponEffectCfg[iter_0_37].strengthen_description) == "table" and WeaponEffectCfg[iter_0_37].strengthen_description[1] then
		var_0_16[WeaponEffectCfg[iter_0_37].strengthen_description[1]] = WeaponServantCfg.get_id_list_by_effect[iter_0_37][1]
	end
end

function getSkillAffectByModule(arg_9_0)
	return var_0_15[arg_9_0]
end

function getWeaponServantAffectByModule(arg_10_0)
	return var_0_16[arg_10_0]
end

local var_0_17 = {}

for iter_0_38, iter_0_39 in pairs(AstrolabeEffectCfg.all) do
	if type(AstrolabeEffectCfg[iter_0_39].equip_orange_desc) == "table" then
		for iter_0_40, iter_0_41 in pairs(AstrolabeEffectCfg[iter_0_39].equip_orange_desc) do
			if var_0_17[iter_0_41[3]] == nil then
				var_0_17[iter_0_41[3]] = {}
			end

			var_0_17[iter_0_41[3]][iter_0_41[1]] = AstrolabeEffectCfg[iter_0_39].id
		end
	end
end

function getAstrolabeID(arg_11_0, arg_11_1)
	if var_0_17[arg_11_0] == nil then
		print("配置错误！检查AstrolabeEffectCfg和WeaponModuleEffectCfg")

		return
	end

	return var_0_17[arg_11_0][arg_11_1]
end

HERO_FRAGMENT_VALUE = 10000

for iter_0_42, iter_0_43 in pairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.HERO]) do
	ItemCfg[iter_0_43].fragment = iter_0_43 + HERO_FRAGMENT_VALUE
end

for iter_0_44, iter_0_45 in pairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.HERO_PIECE]) do
	ItemCfg[iter_0_45].hero_id = iter_0_45 - HERO_FRAGMENT_VALUE
end

for iter_0_46, iter_0_47 in pairs(ActivityPtCfg.all) do
	ItemCfg[ActivityPtCfg[iter_0_47].item_id].activity_id = iter_0_47
end

ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId = {}

for iter_0_48, iter_0_49 in ipairs(ActivityPtRepeatCfg.all) do
	ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[ActivityPtRepeatCfg[iter_0_49].activity_id] = ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[ActivityPtRepeatCfg[iter_0_49].activity_id] or {}
	ActivityPtRepeatCfg.GetCfgFromActivityIdAndStageId[ActivityPtRepeatCfg[iter_0_49].activity_id][ActivityPtRepeatCfg[iter_0_49].stage_id] = ActivityPtRepeatCfg[iter_0_49]
end

ActivityPt2Cfg.GetCfgFromActivityIdAndStageId = {}

for iter_0_50, iter_0_51 in ipairs(ActivityPt2Cfg.all) do
	ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[ActivityPt2Cfg[iter_0_51].activity_id] = ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[ActivityPt2Cfg[iter_0_51].activity_id] or {}
	ActivityPt2Cfg.GetCfgFromActivityIdAndStageId[ActivityPt2Cfg[iter_0_51].activity_id][ActivityPt2Cfg[iter_0_51].stage_id] = ActivityPt2Cfg[iter_0_51]
end

ShopListCfg.get_id_list_by_system_and_group = {}

for iter_0_52, iter_0_53 in pairs(ShopListCfg.get_id_list_by_system) do
	local var_0_18 = {}

	for iter_0_54, iter_0_55 in ipairs(iter_0_53) do
		var_0_18[ShopListCfg[iter_0_55].display_group] = var_0_18[ShopListCfg[iter_0_55].display_group] or {}

		table.insert(var_0_18[ShopListCfg[iter_0_55].display_group], ShopListCfg[iter_0_55])
	end

	ShopListCfg.get_id_list_by_system_and_group[iter_0_52] = var_0_18
end

function UpdateShopCfg(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.goods_list) do
		local var_12_0 = {}

		for iter_12_2, iter_12_3 in ipairs(iter_12_1.give_back_list or {}) do
			table.insert(var_12_0, {
				id = iter_12_3.id,
				num = iter_12_3.num
			})
		end

		ShopCfg[iter_12_1.goods_id] = {
			taken_down = 0,
			position = 0,
			shop_refresh = 3,
			goods_id = iter_12_1.goods_id,
			shop_id = arg_12_0.shop_id,
			shop_sort = iter_12_1.shop_sort,
			give_id = iter_12_1.give_id,
			description = iter_12_1.description,
			give = iter_12_1.give,
			cost_type = iter_12_1.cost_type,
			cost_id = iter_12_1.cost_id,
			cost = iter_12_1.cost,
			cheap_cost_id = iter_12_1.cheap_cost_id,
			cheap_cost = iter_12_1.cheap_cost,
			cost_id_2 = iter_12_1.cost_id_2,
			cost_2 = iter_12_1.cost_2,
			cheap_cost_id_2 = iter_12_1.cheap_cost_id_2,
			cheap_cost_2 = iter_12_1.cheap_cost_2,
			cheap_open_time_2 = {},
			cheap_close_time_2 = {},
			discount = iter_12_1.discount,
			limit_num = iter_12_1.limit_num,
			level_limit = cleanProtoTable(iter_12_1.level_limit),
			limit_display = iter_12_1.limit_display,
			pre_goods_id = cleanProtoTable(iter_12_1.pre_goods_id),
			refresh_cycle = iter_12_1.refresh_cycle,
			open_time = {},
			close_time = {},
			is_limit_time_discount = iter_12_1.is_limit_time_discount,
			is_limit_time_discount_2 = iter_12_1.is_limit_time_discount_2,
			cheap_open_time = {},
			cheap_close_time = {},
			tag = iter_12_1.tag,
			backhome_tag = iter_12_1.backhome_tag,
			next_goods_id = cleanProtoTable(iter_12_1.next_goods_id),
			give_back_list = var_12_0,
			dlc = iter_12_1.dlc
		}

		if iter_12_1.open_time and iter_12_1.open_time.year ~= 0 then
			ShopCfg[iter_12_1.goods_id].open_time = {
				{
					iter_12_1.open_time.year,
					iter_12_1.open_time.month,
					iter_12_1.open_time.day
				},
				{
					iter_12_1.open_time.hour,
					iter_12_1.open_time.minute,
					iter_12_1.open_time.second
				}
			}
		end

		if iter_12_1.close_time and iter_12_1.close_time.year ~= 0 then
			ShopCfg[iter_12_1.goods_id].close_time = {
				{
					iter_12_1.close_time.year,
					iter_12_1.close_time.month,
					iter_12_1.close_time.day
				},
				{
					iter_12_1.close_time.hour,
					iter_12_1.close_time.minute,
					iter_12_1.close_time.second
				}
			}
		end

		if iter_12_1.cheap_open_time and iter_12_1.cheap_open_time.year ~= 0 then
			ShopCfg[iter_12_1.goods_id].cheap_open_time = {
				{
					iter_12_1.cheap_open_time.year,
					iter_12_1.cheap_open_time.month,
					iter_12_1.cheap_open_time.day
				},
				{
					iter_12_1.cheap_open_time.hour,
					iter_12_1.cheap_open_time.minute,
					iter_12_1.cheap_open_time.second
				}
			}
		end

		if iter_12_1.cheap_close_time and iter_12_1.cheap_close_time.year ~= 0 then
			ShopCfg[iter_12_1.goods_id].cheap_close_time = {
				{
					iter_12_1.cheap_close_time.year,
					iter_12_1.cheap_close_time.month,
					iter_12_1.cheap_close_time.day
				},
				{
					iter_12_1.cheap_close_time.hour,
					iter_12_1.cheap_close_time.minute,
					iter_12_1.cheap_close_time.second
				}
			}
		end

		if iter_12_1.cheap_open_time_2 and iter_12_1.cheap_open_time_2.year ~= 0 then
			ShopCfg[iter_12_1.goods_id].cheap_open_time_2 = {
				{
					iter_12_1.cheap_open_time_2.year,
					iter_12_1.cheap_open_time_2.month,
					iter_12_1.cheap_open_time_2.day
				},
				{
					iter_12_1.cheap_open_time_2.hour,
					iter_12_1.cheap_open_time_2.minute,
					iter_12_1.cheap_open_time_2.second
				}
			}
		end

		if iter_12_1.cheap_close_time_2 and iter_12_1.cheap_close_time_2.year ~= 0 then
			ShopCfg[iter_12_1.goods_id].cheap_close_time_2 = {
				{
					iter_12_1.cheap_close_time_2.year,
					iter_12_1.cheap_close_time_2.month,
					iter_12_1.cheap_close_time_2.day
				},
				{
					iter_12_1.cheap_close_time_2.hour,
					iter_12_1.cheap_close_time_2.minute,
					iter_12_1.cheap_close_time_2.second
				}
			}
		end

		ShopCfg.get_id_list_by_shop_id[arg_12_0.shop_id] = ShopCfg.get_id_list_by_shop_id[arg_12_0.shop_id] or {}

		if not table.indexof(ShopCfg.get_id_list_by_shop_id[arg_12_0.shop_id]) then
			table.insert(ShopCfg.get_id_list_by_shop_id[arg_12_0.shop_id], iter_12_1.goods_id)
		end

		ShopCfg.get_id_list_by_cost_id[iter_12_1.cost_id] = ShopCfg.get_id_list_by_cost_id[iter_12_1.cost_id] or {}

		if not table.indexof(ShopCfg.get_id_list_by_cost_id[iter_12_1.cost_id]) then
			table.insert(ShopCfg.get_id_list_by_cost_id[iter_12_1.cost_id], iter_12_1.goods_id)
		end
	end
end

for iter_0_56, iter_0_57 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.SKIN_CHANGE]) do
	SkinCfg[ItemCfg[iter_0_57].param[1]].change_item = iter_0_57
end

function getChapterIDByStageID(arg_13_0)
	return var_0_1[arg_13_0]
end

function getChapterClientCfgByChapterID(arg_14_0)
	return ChapterClientCfg[ChapterCfg[arg_14_0].clientID]
end

function getChapterClientCfgByStageID(arg_15_0)
	return getChapterClientCfgByChapterID((getChapterIDByStageID(arg_15_0)))
end

function getChapterAndSectionID(arg_16_0)
	local var_16_0 = getChapterIDByStageID(arg_16_0)

	return var_16_0, ChapterCfg[var_16_0].section_id_list ~= "" and table.keyof(ChapterCfg[var_16_0].section_id_list, arg_16_0) or 1
end

function getChapterToggle(arg_17_0)
	return ChapterClientCfg[arg_17_0].parentToggle or ChapterClientCfg[arg_17_0].toggle
end

function getChapterDifficulty(arg_18_0)
	local var_18_0 = ChapterCfg[BattleStageTools.GetChapterByStageId(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, arg_18_0)]

	if not var_18_0 then
		error("错误的难度参数")
	end

	local var_18_1 = var_18_0.difficulty

	if var_18_0.difficulty == 1 then
		return GetTips("HARDLEVEL_EASY")
	elseif var_18_1 == 2 then
		return GetTips("HARDLEVEL_HARD_2")
	end
end

function getStageViaStoryID(arg_19_0)
	return StoryCfg[arg_19_0].trigger[2]
end

local var_0_19 = {}

function getChapterListByDifficulty(arg_20_0, arg_20_1)
	arg_20_1 = arg_20_1 or "all"

	if not var_0_19[arg_20_0] then
		local var_20_0 = {}

		for iter_20_0, iter_20_1 in ipairs(ChapterCfg.get_id_list_by_type[arg_20_0]) do
			var_20_0[ChapterCfg[iter_20_1].difficulty] = var_20_0[ChapterCfg[iter_20_1].difficulty] or {}
			var_20_0.all = var_20_0.all or {}

			table.insert(var_20_0.all, iter_20_1)
			table.insert(var_20_0[ChapterCfg[iter_20_1].difficulty], iter_20_1)
		end

		var_0_19[arg_20_0] = var_20_0
	end

	return var_0_19[arg_20_0][arg_20_1] or {}
end

local var_0_20 = {}

for iter_0_58, iter_0_59 in pairs(StoryCfg) do
	if iter_0_59.trigger[2] then
		var_0_20[iter_0_59.trigger[2]] = var_0_20[iter_0_59.trigger[2]] or {}
		var_0_20[iter_0_59.trigger[2]][iter_0_59.trigger[3]] = iter_0_59.id
	end
end

function getStoryViaStageID(arg_21_0, arg_21_1)
	if not var_0_20[arg_21_0] then
		return false
	end

	return var_0_20[arg_21_0][arg_21_1]
end

for iter_0_60, iter_0_61 in ipairs(WeaponServantCfg.all) do
	local var_0_21 = ServantTools.GetServantSpecHero(iter_0_61)

	if var_0_21 then
		HeroCfg[var_0_21].spec_servant = iter_0_61
	end
end

local var_0_22 = {}

for iter_0_62, iter_0_63 in pairs(ItemCfg.get_id_list_by_type[14]) do
	var_0_22[ItemCfg[iter_0_63].param[1]] = iter_0_63
end

function getTicketIDBySkinID(arg_22_0)
	return var_0_22[arg_22_0]
end

TalentTreeCfg.get_id_list_by_activity_id_and_race = {}

for iter_0_64, iter_0_65 in pairs(TalentTreeCfg.get_id_list_by_activity_id) do
	TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_0_64] = {}

	for iter_0_66, iter_0_67 in ipairs(iter_0_65) do
		if TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_0_64][TalentTreeCfg[iter_0_67].race] == nil then
			TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_0_64][TalentTreeCfg[iter_0_67].race] = {}
		end

		table.insert(TalentTreeCfg.get_id_list_by_activity_id_and_race[iter_0_64][TalentTreeCfg[iter_0_67].race], iter_0_67)
	end
end

for iter_0_68, iter_0_69 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_CULTIVATE_HERO]) do
	if ActivityCultivateHeroCfg[iter_0_69] then
		for iter_0_70, iter_0_71 in ipairs(ActivityCultivateHeroCfg[iter_0_69].group) do
			for iter_0_72, iter_0_73 in ipairs(CultivateHeroTaskCfg.get_id_list_by_group_id[iter_0_71]) do
				CultivateHeroTaskCfg[iter_0_73].activity_id = iter_0_69
			end
		end
	end
end

function GetCfgDescription(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	if arg_24_2 == nil then
		arg_24_2 = 1
	end

	local function var_24_0(arg_25_0, arg_25_1)
		if arg_25_1 then
			return math.floor(arg_25_0 * 10^arg_25_1 + 0.5) / 10^arg_25_1
		else
			return math.floor(arg_25_0 + 0.5)
		end
	end

	if not DescriptionCfg[arg_24_0] then
		print("错误, 找不到对应id的描述配置 " .. arg_24_0 .. " description.csv 表")

		return "错误, 找不到对应id的描述配置 " .. arg_24_0 .. " description.csv 表"
	end

	local var_24_1 = GetI18NText(DescriptionCfg[arg_24_0].description)
	local var_24_2 = arg_24_1

	if arg_24_1 == nil then
		arg_24_1 = 1
	end

	if arg_24_3 == nil then
		arg_24_3 = DescriptionCfg[arg_24_0].maxLv
	end

	if DescriptionCfg[arg_24_0].type == 1 then
		if arg_24_1 > DescriptionCfg[arg_24_0].maxLv or arg_24_1 < 1 then
			print("错误, 找不到对应等级的描述配置 id = " .. arg_24_0 .. " description.csv 表 level = " .. arg_24_1)

			return "错误, 找不到对应等级的描述配置 id = " .. arg_24_0 .. " description.csv 表 level = " .. arg_24_1
		end

		if #DescriptionCfg[arg_24_0].param >= 1 then
			local var_24_3 = {
				"0"
			}

			for iter_24_0, iter_24_1 in ipairs(DescriptionCfg[arg_24_0].param) do
				local var_24_4 = iter_24_1[1]
				local var_24_5 = iter_24_1[2]
				local var_24_6 = iter_24_1[4]
				local var_24_7 = iter_24_1[3]

				if arg_24_4 then
					var_24_7 = false
				end

				local var_24_8 = var_24_0(var_24_4 + var_24_5 * (arg_24_1 - 1), arg_24_2)

				var_24_8 = var_24_8 % 1 == 0 and string.format("%.0f", var_24_8) .. var_24_6 or string.format("%." .. arg_24_2 .. "f", var_24_8) .. var_24_6

				local var_24_9 = var_24_8

				if var_24_7 and arg_24_1 < arg_24_3 then
					local var_24_10 = var_24_0(var_24_4 + var_24_5 * arg_24_1, arg_24_2)

					var_24_10 = var_24_10 % 1 == 0 and string.format("%.0f", var_24_10) .. var_24_6 or string.format("%." .. arg_24_2 .. "f", var_24_10) .. var_24_6
					var_24_9 = GetTipsF("DESCRIPTION_NEXT_LEVEL", var_24_8, var_24_10)
				end

				if arg_24_4 then
					var_24_9 = ""

					for iter_24_2 = 1, arg_24_3 do
						local var_24_11 = var_24_0(var_24_4 + var_24_5 * (iter_24_2 - 1), arg_24_2)

						var_24_11 = var_24_11 % 1 == 0 and string.format("%.0f", var_24_11) .. var_24_6 or string.format("%." .. arg_24_2 .. "f", var_24_11) .. var_24_6

						if arg_24_5 and var_24_2 == iter_24_2 then
							var_24_11 = "<color=#E78300>" .. var_24_11 .. "</color>"
						end

						var_24_9 = var_24_5 ~= 0 and (iter_24_2 > 1 and var_24_9 .. "/" .. var_24_11 or var_24_11) or var_24_11
					end
				end

				table.insert(var_24_3, var_24_9)
			end

			return LuaExchangeHelper.GetDescription(var_24_1, var_24_3)
		else
			return var_24_1
		end
	else
		local var_24_12 = DescriptionCfg[arg_24_0].param[arg_24_1]

		if not DescriptionCfg[arg_24_0].param[arg_24_1] then
			print("错误, 找不到对应等级的描述配置 id = " .. arg_24_0 .. " description.csv 表 level = " .. arg_24_1)

			return "错误, 找不到对应等级的描述配置 id = " .. arg_24_0 .. " description.csv 表 level = " .. arg_24_1
		end

		if #var_24_12 > 1 then
			if arg_24_4 then
				return LuaExchangeHelper.GetDescription(var_24_1, DescriptionCfg[arg_24_0].extra_param)
			end

			return LuaExchangeHelper.GetDescription(var_24_1, var_24_12)
		else
			return var_24_1
		end
	end
end

function GetCfgDescriptionWithValue(arg_26_0, arg_26_1)
	if not DescriptionCfg[arg_26_0] then
		print("错误, 找不到对应id的描述配置 " .. arg_26_0 .. " description.csv 表")

		return "错误, 找不到对应id的描述配置 " .. arg_26_0 .. " description.csv 表"
	end

	local var_26_0 = GetI18NText(DescriptionCfg[arg_26_0].description)
	local var_26_1 = {
		""
	}

	if type(arg_26_1) ~= "table" then
		table.insert(var_26_1, arg_26_1)
	else
		table.insertto(var_26_1, arg_26_1)
	end

	return LuaExchangeHelper.GetDescription(var_26_0, var_26_1)
end

ActivityReprintExCfg = {}

for iter_0_74, iter_0_75 in ipairs(ActivityReprintCfg.all) do
	for iter_0_76, iter_0_77 in pairs(ActivityReprintCfg[iter_0_75]) do
		if iter_0_76 ~= "id" then
			ActivityReprintExCfg[iter_0_77] = {
				originActivityID = iter_0_75
			}
		end
	end
end

HeroStarUpTemplateCfg.template_dic = {}

for iter_0_78, iter_0_79 in pairs(HeroStarUpTemplateCfg.get_id_list_by_template) do
	local var_0_25 = {}

	for iter_0_80, iter_0_81 in ipairs(iter_0_79) do
		var_0_25[HeroStarSkillCfg[HeroStarUpTemplateCfg[iter_0_81].skill_id].type] = var_0_25[HeroStarSkillCfg[HeroStarUpTemplateCfg[iter_0_81].skill_id].type] or {}
		var_0_25[HeroStarSkillCfg[HeroStarUpTemplateCfg[iter_0_81].skill_id].type].stage_dic = var_0_25[HeroStarSkillCfg[HeroStarUpTemplateCfg[iter_0_81].skill_id].type].stage_dic or {}
		var_0_25[HeroStarSkillCfg[HeroStarUpTemplateCfg[iter_0_81].skill_id].type].stage_dic[HeroStarUpTemplateCfg[iter_0_81].stage] = HeroStarUpTemplateCfg[iter_0_81].skill_id
	end

	for iter_0_82, iter_0_83 in pairs(var_0_25) do
		local var_0_26 = {}

		for iter_0_84, iter_0_85 in pairs(iter_0_83.stage_dic) do
			var_0_26[#var_0_26 + 1] = iter_0_84
		end

		table.sort(var_0_26)

		var_0_25[iter_0_82].stage_list = var_0_26
	end

	HeroStarUpTemplateCfg.template_dic[iter_0_78] = var_0_25
end

function HeroVoiceDescCfg.GetConfig(arg_27_0, arg_27_1)
	return nullable(HeroVoiceDescCfg, (nullable(HeroVoiceDescCfg.get_id_list_by_subtitle_id_form_id, arg_27_1, arg_27_0, 1)))
end

function HeroVoiceDescCfg.Get(arg_28_0, arg_28_1)
	return nullable(HeroVoiceDescCfg.GetConfig(arg_28_0, arg_28_1), "content")
end

ChapterV2MapLocationCfg.get_id_list_by_sub_location_id = {}

for iter_0_86, iter_0_87 in ipairs(ChapterV2MapTagCfg.all) do
	if ChapterV2MapTagCfg[iter_0_87].tag_behaviour == 1 then
		if not ChapterV2MapLocationCfg[ChapterV2MapTagCfg[iter_0_87].tag_id] then
			Debug.LogError("4.8地图区域TagID 和区域LocationID不一致 tagID：" .. ChapterV2MapTagCfg[iter_0_87].tag_id)
		else
			for iter_0_88, iter_0_89 in ipairs(ChapterV2MapTagCfg[iter_0_87].behaviour_parameters) do
				ChapterV2MapLocationCfg.get_id_list_by_sub_location_id[iter_0_89] = ChapterV2MapTagCfg[iter_0_87].tag_id
			end
		end
	end
end

function ConfigHelper_GetCfg(arg_29_0, arg_29_1, arg_29_2)
	return _G[arg_29_0][arg_29_1][arg_29_2]
end
