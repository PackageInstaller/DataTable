local CSLuaService = CS.Game.LuaService
local _insert = table.insert
local _sformat = string.format
local FightDefine = require("cs_share.fight_define")
local M = {}
local global_res_tbl = {}

function M.is_exist_config(path)
  return CSLuaService.isExistConfig("XLS." .. path)
end

local function load_config_file(file)
  local data = CSLuaService.loadConfig(file)
  if not data then
    Log.Error("load file error", file, debug.traceback())
    return
  end
  local cfg, err = load(data, file, "bt")
  if not cfg then
    Log.Error("load cfg error", file, err)
    return
  end
  return cfg()
end

local function get_bundle_ref_config(path)
  local tbl = global_res_tbl[path]
  if not tbl then
    tbl = load_config_file("BundleRef." .. path)
    global_res_tbl[path] = tbl
  end
  return tbl
end

local function get_tbl(path)
  local tbl = global_res_tbl[path]
  if not tbl then
    tbl = load_config_file("XLS." .. path)
    global_res_tbl[path] = tbl
  end
  return tbl
end

function M.clear()
  global_res_tbl = {}
end

function M.create_bundleref(path)
  local tbl = get_bundle_ref_config(path)
  if not tbl then
    Log.Error("can't find cfg: " .. path)
    return
  end
  return tbl
end

function M.create(path, key)
  local tbl = get_tbl(path)
  if not tbl then
    Log.Error("can't find cfg: " .. path)
    return
  end
  if key then
    return tbl[key]
  else
    return tbl
  end
end

function M.create_ex(path, key1, key2)
  local tbl = get_tbl(path)
  assert(tbl)
  tbl = tbl[key1]
  if not tbl then
    return nil
  end
  return tbl[key2]
end

function M.get_buff_cfg(buff_id)
  return M.create("character.buff", buff_id)
end

function M.get_skill_list(model_id)
  return M.create("character.skill_list", model_id)
end

local magic_path = "magic.magic"

function M.get_magic_cfg(magic_id)
  local magic_cfg = ShareRes.create(magic_path, magic_id)
  return magic_cfg
end

function M.get_buddy_max_break_level()
  return #M.create("buddy.buddy_max_level")
end

function M.get_buddy_max_level(break_lv)
  return M.create("buddy.buddy_max_level", break_lv).MaxLv
end

function M.get_equip_max_level(break_lv)
  return M.create("equip.equip_max_level", break_lv).MaxLv
end

function M.get_default_skill_list(model_id)
  return M.create("character.default_skill_list", model_id)
end

function M.get_buddy_skill_lv_cfg_list(id)
  return M.create("buddy.buddy_skill_level", id)
end

function M.get_buddy_skill_lv_cfg(id, lv)
  return M.create("buddy.buddy_skill_level", id)[lv]
end

function M.get_buddy_skill_max_lv(id)
  return #M.create("buddy.buddy_skill_level", id)
end

function M.get_buddy_skill_details_cfg(id)
  return M.create("buddy.buddy_skill_details", id)
end

function M.get_buddy_talent_lv_cfg_list(id)
  return M.create("buddy.buddy_talent", id)
end

function M.get_buddy_talent_lv_cfg(id, lv)
  return M.create("buddy.buddy_talent", id)[lv]
end

function M.get_buddy_talent_max_lv(id)
  return #M.create("buddy.buddy_talent", id)
end

function M.is_buddy_breack_auto_unlock_talent(id, break_lv)
  local talent_cfg = ShareRes.create("buddy.buddy_talent", id)
  for _, v in ipairs(talent_cfg) do
    if v.NeedBreak == break_lv then
      return v.ItemId == nil or not next(v.ItemId)
    end
  end
  return false
end

function M.get_buddy_talent_attr(id, lv)
  return M.create_ex("buddy.buddy_talent_new_attr", id, lv)
end

function M.get_buddy_advance_attr_cfg(id, advance_lv)
  local advance_cfg = M.create("buddy.buddy_upgrade_advance_attr", id)
  if advance_lv then
    return advance_cfg[advance_lv]
  end
  return advance_cfg
end

function M.get_fixed_buddy_config(fixed_id)
  local all_cfg = M.create("chapter.fixed_buddy")
  return all_cfg[fixed_id]
end

function M.get_buddy_skill_list_cfg(id)
  return M.create("buddy.buddy_skill", id)
end

function M.get_task_group_cfg(group_id)
  return M.create("condition.task_by_group", group_id)
end

function M.get_task_cfg(task_id)
  if not task_id then
    Log.Error("任务id为空")
    return
  end
  local cfg = M.create("condition.task", task_id)
  if not task_id then
    Log.Error("任务配置不存在", task_id)
    return
  end
  return cfg
end

function M.get_explain_cfg(explain_id)
  return M.create("explain.explain_list", explain_id)
end

function M.get_buddy_archives_cfg(archives_id)
  return M.create("buddy.buddy_archives", archives_id)
end

function M.get_buddy_archive_overview(buddy_id)
  return M.create("buddy.buddy_archives_overview", buddy_id)
end

function M.get_buddy_skill_upgrade_list(buddy_id)
  return M.create("battle.skill_upgrade_list", buddy_id)
end

function M.get_buddy_skill_gm_list(buddy_id)
  return M.create("battle.skill_gm_list", buddy_id)
end

function M.get_buddy_voice_cfg(voice_id)
  return M.create("buddy.buddy_voice", voice_id)
end

function M.get_equip(equip_id)
  return M.create("equip.equip", equip_id)
end

function M.get_equip_priority(equip_id)
  return M.create("equip.equip", equip_id).Priority
end

function M.get_equip_quality(equip_id)
  return M.create("equip.equip", equip_id).Quality
end

function M.get_equip_desc(equip_id)
  return M.create("equip.equip", equip_id).WorldDesc
end

function M.get_item_quality(item_id)
  return M.get_item_cfg(item_id).Quality
end

function M.get_item_priority(item_id)
  return M.get_item_cfg(item_id).Priority
end

function M.get_item_name(item_id)
  return M.get_item_cfg(item_id).Name
end

function M.get_item_icon_path(item_id, get_quality_path)
  local item_cfg = M.get_item_cfg(item_id)
  local get_award_type_cfg = M.get_award_type_cfg(item_id)
  local icon_name
  if get_award_type_cfg.TabName == "buddy" then
    icon_name = item_cfg.Icon[1]
  elseif get_award_type_cfg.TabName == "buddy_fashion" then
    icon_name = item_cfg.ItemIcon
  else
    icon_name = item_cfg.Icon
  end
  if not get_award_type_cfg.IconPath then
    Log.Error("获取道具图标失败，道具奖励分段表未配置Icon路径, item_id", item_id)
    return
  end
  local quality_path
  if get_quality_path then
    quality_path = M.get_quality_path(item_cfg.Quality)
  end
  return string.format(get_award_type_cfg.IconPath, icon_name), quality_path
end

function M.get_item_quality_path(item_id)
  local quality = M.get_item_quality(item_id)
  return M.get_quality_path(quality)
end

function M.get_quality_path(quality)
  local cfg = M.get_item_quality_cfg(quality)
  if not cfg or not cfg.QualityIcon then
    Log.Error("获取道具品质图标失败，品质：", quality)
    return
  end
  local QUALITY_ICON_PATH = "UICommon/%s"
  return (string.format(QUALITY_ICON_PATH, cfg.QualityIcon))
end

function M.get_item_quality_cfg(quality)
  return M.create("item.item_quality", quality)
end

function M.get_item_cfg(item_id)
  local cfg = M.create("item.item", item_id)
  if cfg then
    return cfg
  end
  local get_award_type_cfg = M.get_award_type_cfg(item_id)
  cfg = M.create(get_award_type_cfg.TabPath, item_id)
  if cfg then
    return cfg
  end
  Log.Error("道具配置获取失败,item_id:", item_id, get_award_type_cfg.TabPath)
end

function M.get_award_type_cfg(item_id)
  local cfg = ShareRes.create("item.award_type")
  for _, v in pairs(cfg) do
    if item_id >= v.IdBegin and item_id <= v.IdEnd then
      return v
    end
  end
  Log.Error("道具奖励分段表匹配失败,item_id:", item_id)
end

function M.get_battle_item_cfg(item_id)
  return M.create("battle.battle_item", item_id)
end

function M.get_battle_item_quality(item_id)
  local item = M.create("battle.battle_item", item_id)
  local collection = M.create("battle.battle_collection", item_id)
  local ornament = M.create("item.ornaments", item_id)
  local quality
  if item then
    quality = item.Quality
  end
  if collection then
    quality = collection.Quality
  end
  if not quality and ornament then
    quality = ornament.Quality
  end
  return quality
end

function M.get_battle_equip_cfg(item_id)
  return M.create("battle.battle_collection", item_id)
end

function M.get_awards(award_id)
  local awards = M.create("award.award_group", award_id)
  if not awards then
    return
  end
  local awardid2item = M.create("award.award")
  local award_items = {}
  for i = 1, #awards do
    _insert(award_items, awardid2item[awards[i]])
  end
  return award_items
end

function M.get_award_item_data(award_id, award_items)
  local awards = M.create("award.award_group", award_id)
  if not awards then
    return
  end
  local awardid2item = M.create("award.award")
  local award_items = award_items or {}
  for i = 1, #awards do
    local id = awards[i]
    if 0 ~= id then
      _insert(award_items, {
        awardid2item[id].ItemId,
        awardid2item[id].Num,
        awardid2item[id].Limit
      })
    end
  end
  return award_items
end

function M.get_battle_task_show_award_data(award_id)
  local awards = M.create("battle.battle_task_reward", award_id)
  return awards
end

function M.get_equip_dec_res(equip_id)
  local dec_id = M.create("equip.equip", equip_id).DecomposeId
  return M.get_awards(dec_id)
end

function M.get_item_sell_res(item_id)
  local sell_id = M.get_item_cfg(item_id).SellId
  return M.get_awards(sell_id)
end

function M.get_source_dec_res(gem_quality)
  local dec_id = M.create("equip.equip_gemstone_quality", gem_quality).DecomposeAwardGroup
  return M.get_awards(dec_id)
end

function M.get_puzzle_dec_res(puzzle_id, puzzle_quality)
  if 3 == puzzle_quality then
    local dec_id = M.get_buddy_puzzle_cfg(puzzle_id).DecomposeAwardId
    return M.get_awards(dec_id)
  end
end

function M.get_chapter_cfg(chapter_id)
  local chapter_list = M.create("chapter.chapter")
  if not chapter_id then
    return chapter_list
  end
  return chapter_list[chapter_id]
end

function M.get_chapter_page_type(chapter_id)
  local chapter_cfg = M.create("chapter.chapter")[chapter_id]
  if chapter_cfg then
    return chapter_cfg.ChapterPage
  end
end

function M.get_chapter_material_cfg(material_id)
  local chapter_list = M.create("chapter.chapter_material")
  if not material_id then
    return chapter_list
  end
  return chapter_list[material_id]
end

function M.get_chapter_material_type_cfg(material_type_id)
  local list = M.create("chapter.chapter_material_type")
  if not material_type_id then
    return list
  end
  return list[material_type_id]
end

function M.get_chapter_material_list_with_type(material_type)
  local list = M.create("chapter.new_material_epi")
  if not material_type then
    return list
  end
  local typeList = {}
  for i, v in pairs(list) do
    if v.MaterialType == material_type then
      typeList[i] = v
    end
  end
  return typeList
end

function M.get_material_epi_cfg(material_id)
  local list = M.create("chapter.new_material_epi")
  if not material_id then
    return list
  end
  return list[material_id]
end

function M.get_material_id_by_epi_id(epi_id)
  local list_temp = M.create("chapter.new_material_epi_index")
  return list_temp[epi_id]
end

function M.get_buddy_cfg(buddy_id)
  local cfg = ShareRes.create("buddy.buddy", buddy_id)
  if not cfg then
    Log.Error("获取角色配置失败，buddyId：", buddy_id)
  end
  return cfg
end

function M.get_show_buddy_attr_cfg(buddy_id)
  return ShareRes.create("buddy.show_attr_group", buddy_id)
end

function M.get_show_buddy_pos_info(buddy_id, fashion_id)
  local all_cfg = ShareRes.create("buddy.buddy_pos_info")
  if fashion_id and all_cfg[fashion_id] then
    return all_cfg[fashion_id]
  end
  return all_cfg[buddy_id]
end

function M.get_buddy_attr_cfg(attr_id)
  return ShareRes.create("buddy.attribute_define", attr_id)
end

function M.get_buddy_rune_type_list(buddy_id)
  local buddy_cfg = M.create("buddy.buddy", buddy_id)
  return buddy_cfg.RuneType
end

function M.get_buddy_rune_type(buddy_id, pos)
  local buddy_cfg = M.create("buddy.buddy", buddy_id)
  return buddy_cfg.RuneType[pos]
end

function M.get_buddy_pos_by_rune_type(buddy_id, rune_type)
  local buddy_cfg = M.create("buddy.buddy", buddy_id)
  local rune_type_list = buddy_cfg.RuneType
  for pos_idx, cfg_rune_type in pairs(rune_type_list) do
    if rune_type == cfg_rune_type then
      return pos_idx
    end
  end
end

function M.get_buddy_attr_name(attr_id)
  local cfg = ShareRes.create("equip.attr_type", attr_id)
  if not cfg then
    Log.Error("attr is not exist, attr_id = ", attr_id)
  end
  return cfg.Name
end

function M.get_buddy_res_attr_id(buddy_id)
  local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
  if not buddy_cfg then
    return
  end
  local res_attr_id = buddy_cfg.ResAttrId
  return res_attr_id
end

function M.get_chapter_task_cfg(group_id, task_id)
  local task_group_cfg = M.create("chapter.chapter_task", group_id)
  if task_id then
    return task_group_cfg[task_id]
  end
  return task_group_cfg
end

function M.get_chapter_stage_group_task_cfg(task_group_id, stage_group_id)
  local stage_group_cfg = M.create("chapter.chapter_stage_group_task", stage_group_id)
  if stage_group_cfg then
    return stage_group_cfg[task_group_id]
  end
end

function M.get_chapter_team_cfg(point_id, floor_num)
  local chapter_team = M.create("chapter.chapter_team", point_id)
  if not chapter_team then
    return
  end
  floor_num = floor_num or 1
  local chapter_team_cfg = chapter_team[floor_num] or chapter_team[0]
  if not chapter_team_cfg then
    return
  end
  return chapter_team_cfg
end

function M.get_chapter_point_cfg(point_id)
  return M.create("chapter.chapter_point", point_id)
end

function M.get_chapter_point_details_cfg(details_id)
  return M.create("chapter.point_details", details_id)
end

function M.get_chapter_keyword_cfg(keyword_id)
  return M.create("chapter.chapter_keyword", keyword_id)
end

function M.get_chapter_reborn_cfg(reborn_id)
  return M.create("chapter.chapter_reborn", reborn_id)
end

function M.get_missile(missile_id)
  local missile_cfg = M.create("skill.missile", missile_id)
  if not missile_cfg then
    Log.Error("获取子弹配置失败，请找相关    策划    确认配置！  子弹ID", missile_id, debug.traceback())
  end
  return missile_cfg
end

function M.get_battle_drop_show_cfg(npc_type)
  local battle_drop_show_cfg = M.create("battle.battle_drop_show")
  for _, drop_cfg in pairs(battle_drop_show_cfg) do
    if drop_cfg.NPCKind == npc_type then
      return drop_cfg
    end
  end
end

function M.equip_attr_str(attr_name)
  if type(attr_name) == "number" then
    local attr = M.create("equip.attr_type", attr_name)
    if not attr then
      return "??"
    end
    return attr.Name
  elseif type(attr_name) == "string" then
    if FightDefine.CONFIG_NAME_ATTR_ID[attr_name] ~= nil then
      attr_name = FightDefine.CONFIG_NAME_ATTR_ID[attr_name]
      return M.create("equip.attr_type", attr_name).Name
    else
      Log.Error("未能在FightDefine中找到对应的属性键值，请检查！！attr_name = ", attr_name)
      return ""
    end
  else
    Log.Error("参数类型不对，请检查！！attr_name = ", attr_name)
    return ""
  end
end

function M.get_attr_cfg(attr_id)
  return M.create("equip.attr_type")[attr_id]
end

function M.get_attr_icon(attr_id)
  local cfg = M.create("equip.attr_type")[attr_id]
  if cfg and cfg.IconName then
    return cfg.IconName
  else
    Log.Error("s属性表中 未找到属性图标 AttrId:", attr_id)
  end
end

function M.get_attr_name(attr_id)
  local cfg = M.create("equip.attr_type")[attr_id]
  if cfg and cfg.Name then
    return cfg.Name
  else
    Log.Error("s属性表中 未找到属性名字 AttrId:", attr_id)
  end
end

function M.get_attr_max(attr_id)
  local cfg = M.get_attr_cfg(attr_id)
  return cfg and cfg.Max or 0
end

function M.get_is_masked_attr(attr_id)
  local attr_cfg = M.create("equip.attr_type")[attr_id]
  if not attr_cfg then
    return false
  end
  return attr_cfg.MaskedDisplay
end

function M.get_is_ration_attr(attr_id)
  local attr = M.create("equip.attr_type", attr_id)
  if not attr then
    return false
  end
  return attr.IsRatio
end

function M.get_comm_value(key)
  local cfg = M.create("commcfg.commcfg", key)
  return cfg and cfg.value
end

function M.get_gameplay_desc(key)
  local cfg = M.create("commcfg.gameplay_desc", key)
  return cfg and cfg.value
end

function M.get_comm_string_value(key)
  local cfg = M.create("commcfg.commcfg", key)
  return cfg and cfg.stringvalue
end

function M.get_system_comm_value(key)
  local cfg = M.create("commcfg.system_commcfg", key)
  return cfg and cfg.value
end

function M.get_tower_preload_cfg(tower_id)
  return M.create("tower.tower_preload", tower_id)
end

function M.get_tower_cfg(tower_id)
  return M.create("tower.tower", tower_id)
end

function M.get_tower_drop_cfg(tower_id)
  return M.create("tower.tower_drop", tower_id)
end

function M.get_tower_id_by_point_id(point_id)
  local point_cfg = M.get_chapter_point_cfg(point_id)
  if point_cfg then
    return point_cfg.FightId
  else
    Log.Error("关卡配置为空，id为：", point_id)
  end
end

function M.get_chance_layer(id)
  return M.create("drop.chance_layer", id)
end

function M.get_weight_layer_1(id)
  return M.create("drop.weight_layer_1", id)
end

function M.get_weight_layer_2(id)
  return M.create("drop.weight_layer_2", id)
end

function M.get_weight_layer_3(id)
  return M.create("drop.weight_layer_3", id)
end

function M.get_base_layer(id)
  return M.create("drop.base_layer", id)
end

function M.get_cell_id_section(id)
  local drop_section = M.create("drop.drop_section")
  for _, section in pairs(drop_section) do
    if id >= section.MinId and id <= section.MaxId then
      return section.Layer
    end
  end
  Log.Error("掉落, ID分段不匹配")
  return 0
end

function M.get_sound_cfg(sound_id)
  local all_sound_cfg = ShareRes.create("sound.sound")
  local sound_cfg = all_sound_cfg[sound_id]
  if not sound_cfg then
    all_sound_cfg = ShareRes.create("sound.sound_acb_key")
    sound_cfg = all_sound_cfg[sound_id]
  end
  return sound_cfg
end

function M.get_play_sound_info(sound_id, return_all_cfg, check_sound)
  local sound_cfg = ShareRes.get_sound_cfg(sound_id)
  if check_sound and not sound_cfg then
    return
  end
  if not sound_cfg then
    Log.Error("音效配置丢失，音效id = " .. sound_id, debug.traceback())
    return
  end
  local random_data = sound_cfg.RandomSound
  local is_random = false
  local random_val = #sound_cfg.PlaySoundName
  if random_data then
    is_random = random_data[1] and 0 ~= random_data[1]
    random_val = random_data[2]
  end
  if not is_random then
    if return_all_cfg then
      return sound_cfg
    end
    return sound_cfg.SoundACDName, sound_cfg.PlaySoundName[1], sound_cfg.SourceType, sound_cfg.LabelSwitch, sound_cfg.IsStreaming, sound_cfg.No_Loop, sound_cfg.BusLevel
  end
  Util.assert(random_val, "error sound cfg, no random val: ", sound_id)
  local random_id = math.random(1, random_val)
  if return_all_cfg then
    return sound_cfg
  else
    return sound_cfg.SoundACDName, sound_cfg.PlaySoundName[random_id], sound_cfg.SourceType, sound_cfg.LabelSwitch, sound_cfg.IsStreaming, sound_cfg.No_Loop, sound_cfg.BusLevel
  end
end

function M.get_sound_cfg_by_index(sound_id, index)
  local sound_cfg = ShareRes.get_sound_cfg(sound_id)
  if not sound_cfg then
    Log.Error("音效配置丢失，音效id = " .. sound_id, debug.traceback())
    return
  end
  return sound_cfg.PlaySoundName[index]
end

function M.get_ui_sound_cfg(ui_name)
  local cfg = M.create("sound.ui_sound", ui_name)
  return cfg
end

function M.get_sound_preload_cfg()
  local cfg = M.create("sound.sound_preload")
  return cfg or {}
end

function M.get_sound_common_setting(key, ret_float)
  local cfg = M.create("sound.sound_common_setting", key)
  if ret_float then
    return cfg and cfg.Value
  end
  return cfg and cfg.StringValue
end

function M.name2id(item_name, item_type)
  if "battle_item" == item_type then
    return ShareRes.create("battle.battle_item_name_to_id")[item_name]
  elseif "item" == item_type then
    return ShareRes.create("item.item_name_to_id")[item_name]
  end
end

function M.get_res_version()
  return M.create("res_version", "res_version")
end

function M.get_tower_energy_cfg(energy_id)
  local energy_cfg = M.create("tower.tower_energy")
  return energy_cfg[energy_id]
end

function M.get_inf_chapter_cfg(chapter_id)
  local chapter_list = M.create("chapter.chapter_infinite")
  if not chapter_id then
    return chapter_list
  end
  return chapter_list[chapter_id]
end

function M.get_inf_chapter_name(chapter_id)
  local chapter_list = M.create("chapter.chapter_infinite")
  if not chapter_id then
    return chapter_list
  end
  local cfg = chapter_list[chapter_id]
  return cfg and cfg.Name
end

function M.get_infinite_id_by_point_id(point_id)
  local all_infinite_cfg = M.create("chapter.chapter_infinite")
  local infinite_id
  for key, infinite_cfg in pairs(all_infinite_cfg) do
    if infinite_cfg.EpisodeId == point_id then
      infinite_id = infinite_cfg.Id
      break
    end
  end
  return infinite_id
end

function M.get_buddy_advance_born_item_cfg(buddy_id, advance_lv)
  local cfg = M.create("battle.battle_buddy_init_item", buddy_id)
  if not cfg then
    return
  end
  if advance_lv then
    return cfg[advance_lv]
  end
  return cfg
end

function M.get_game_const(const_key)
  local cfg = M.create("commcfg.system_commcfg", const_key)
  if not cfg then
    Log.Error("read game const failure ! const_key=", const_key)
    return
  end
  return cfg.value
end

function M.get_single_key_define(key)
  return M.create("single_key_define", key)
end

function M.get_task_group(group_id)
  local group = ShareRes.create("condition.task_by_group", group_id)
  if not group then
    Log.Error("read task group failure ! group_id=", group_id)
    return
  end
  local tb = {}
  for k, v in pairs(group) do
    tb[k] = ShareRes.create("condition.task", k)
  end
  return tb
end

function M.get_reborn_id_by_tower_id(tower_id)
  local total_chapter_cfg = M.create("chapter.chapter_point")
  local total_reborn_cfg = M.create("chapter.chapter_reborn")
  local reborn_cfg
  for _, data in pairs(total_chapter_cfg) do
    if data.FightId == tower_id then
      reborn_cfg = total_reborn_cfg[data.RebornId]
      break
    end
  end
  return reborn_cfg
end

function M.get_buddy_group_attr(group_id)
  if not group_id then
    return ShareRes.create("buddy.buddy_attr_group")
  end
  return ShareRes.create("buddy.buddy_attr_group", group_id)
end

function M.get_attr_group_cfg()
  return ShareRes.create("buddy.attr_group_info")
end

function M.get_scene_skill_cfg(skill_Id)
  return ShareRes.create("battle.scene_skill", skill_Id)
end

function M.get_scene_skill_lv_cfg(skill_Id, skill_lv)
  local all_cfg = ShareRes.create("battle.scene_skill_level", skill_Id)
  if skill_lv then
    return all_cfg[skill_lv]
  end
  return all_cfg
end

function M.get_drawcard_pool(id)
  return ShareRes.create("draw.draw_pool", id)
end

function M.get_draw_base_rule(id)
  return ShareRes.create("draw.draw_base_rule", id)
end

function M.get_draw_base_rule_content(id)
  return ShareRes.create("draw.draw_base_rule_content", id)
end

function M.get_draw_pool_group(id)
  return ShareRes.create("draw.draw_pool_group", id)
end

function M.get_draw_preview(id)
  return ShareRes.create("draw.draw_preview", id)
end

function M.get_draw_tag_name(id)
  return ShareRes.create("draw.draw_tag_name", id)
end

function M.get_drawcard_anim_res(quality)
  return ShareRes.create("draw.draw_anim_res", quality)
end

function M.get_drawcard_free_times_cfg(id)
  return ShareRes.create("draw.limit_time_free_draw", id)
end

function M.get_drop_guarantee(id)
  return ShareRes.create("drop.drop_guarantee", id)
end

function M.get_drop_guarantee_limit(id)
  return ShareRes.create("drop.drop_guarantee_limit", id)
end

function M.get_char_expression_cfg(char_id)
  local all_cfg = M.create("story.story_expression")
  if char_id then
    return all_cfg[char_id]
  end
  return all_cfg
end

function M.get_fight_story_config(story_id)
  local all_cfg = M.create("story.fight_story")
  return all_cfg[story_id]
end

function M.get_element_cfg(element_id)
  local all_cfg = ShareRes.create("buddy.buddy_element")
  return all_cfg[element_id]
end

function M.get_job_cfg(job_id)
  return ShareRes.create("buddy.buddy_job", job_id)
end

function M.get_buddy_tag_str(tag_id)
  if tag_id then
    return ShareRes.create("buddy.buddy_tag", tag_id).Name
  end
end

function M.get_ring_card_type(card_id)
  local card_cfg = ShareRes.create("activity.challenge_ring_card", card_id)
  return card_cfg.Type
end

function M.get_ring_card_show_type(card_id)
  local card_cfg = ShareRes.create("activity.challenge_ring_card", card_id)
  return card_cfg.ShowType
end

function M.get_ring_card_type_cfg(card_type)
  return ShareRes.create("activity.curse_ring_card_type")[card_type]
end

function M.get_state_sound_config(char_id, state_id)
  local state_cfg = ShareRes.create("sound.state_sound")
  local cfg = state_cfg[char_id]
  if not cfg then
    return
  end
  return cfg[state_id]
end

function M.get_ring_card(card_id)
  local card_cfg = ShareRes.create("activity.challenge_ring_card", card_id)
  return card_cfg
end

function M.get_buddy_archive_groups(buddy_id)
  return ShareRes.create("buddy.buddy_archives_client", buddy_id)
end

function M.get_buddy_archive_page_list(group_id)
  return ShareRes.create("buddy.buddy_archive_page_by_group_id", group_id)
end

function M.get_buddy_archive_page_cfg(page_id)
  return ShareRes.create("buddy.buddy_archive_page", page_id)
end

function M.get_archive_start_num(buddy_id, group_id)
  local group_list = ShareRes.create("buddy.buddy_archives_client", buddy_id)
  local now_num = 1
  for _, data in ipairs(group_list) do
    local now_group_id = data.ID
    if now_group_id == group_id then
      break
    end
    local page_list = M.get_buddy_archive_page_list(now_group_id)
    now_num = now_num + #page_list
  end
  return now_num
end

function M.get_equip_advance(equip_id)
  return M.create("equip.equip_advance", equip_id)
end

function M.get_equip_max_advance_lv(equip_id)
  return #M.create("equip.equip_advance", equip_id)
end

function M.get_weapon_skill_max_lv(equip_id)
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_id)
  local max_skill_id = advance_cfg[#advance_cfg].SkillId
  local skill_cfg = ShareRes.create("equip.equip_skill_level", max_skill_id)
  if nil == skill_cfg then
    return 0
  end
  return skill_cfg.Lv
end

function M.get_init_box_max_count(tower_id)
  local cfg = M.create("tower.tower_init_box", tower_id)
  if not cfg then
    Log.Error("初始掉落配置不存在, tower_id = ", tower_id)
    return 0
  end
  return cfg.Count
end

function M.get_battle_task_cfg(task_id)
  return M.create("battle.battle_task")[task_id]
end

function M.get_battle_task_condition_cfg(condition_id)
  local con_cfg = ShareRes.create("condition.condition")[condition_id]
  con_cfg = con_cfg or ShareRes.create("battle.battle_condition")[condition_id]
  return con_cfg
end

function M.get_battle_task_type_cfg(task_type)
  local type_cfg = ShareRes.create("battle.battle_task_type", task_type)
  return type_cfg
end

function M.get_battle_task_group_list(group_id)
  local group_list = ShareRes.create("battle.battle_task_by_group", group_id)
  return group_list
end

function M.get_battle_task_group_cfg(group_id)
  local group_cfg = ShareRes.create("battle.battle_task_group", group_id)
  return group_cfg
end

function M.get_buddy_cv_config(sound_id)
  if sound_id then
    return ShareRes.create("buddy.buddy_cv_res", sound_id)
  end
end

function M.get_buddy_cv(buddy_id)
  local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
  return buddy_cfg.CV
end

function M.get_buddy_is_show(buddy_id)
  local buddy_cfg = ShareRes.create("buddy.buddy", buddy_id)
  return buddy_cfg and 1 ~= buddy_cfg.IsShow
end

function M.get_buddy_trigger_sound_cfg(trigger_type, buddy_id)
  local all_cfg = ShareRes.create("buddy.buddy_trigger_sound", trigger_type)
  if not all_cfg then
    return
  end
  return all_cfg[buddy_id]
end

function M.get_buddy_trigger_sound_cv_cfg(trigger_type, buddy_id)
  local trigger_cfg = ShareRes.get_buddy_trigger_sound_cfg(trigger_type, buddy_id)
  return trigger_cfg.SoundId and ShareRes.get_buddy_cv_config(trigger_cfg.SoundId)
end

function M.get_equip_lv_up_cfg(quality)
  local equip_level_cfgs = ShareRes.create("equip.equip_level", quality)
  return equip_level_cfgs
end

function M.get_equip_icon_cfg(quality)
  local quality_cfg = ShareRes.create("equip.equip_quality_icon", quality)
  return quality_cfg
end

function M.get_equip_quality_icon_path(quality)
  local quality_cfg = ShareRes.get_equip_icon_cfg(quality)
  return string.format("UICommon/%s", quality_cfg.QualityIcon)
end

function M.get_max_equip_break_lv(equip_id)
  local break_cfg = ShareRes.create("equip.equip_break", equip_id)
  Util.assert(break_cfg, "突破配置丢失 装备id = " .. equip_id)
  local break_lv = #break_cfg - 1
  local quality = M.get_equip_quality(equip_id)
  local quality_lv_cfg = M.get_equip_lv_up_cfg(quality)
  local max_lv = #quality_lv_cfg - 1
  break_lv = math.min(break_lv, max_lv)
  return break_lv
end

function M.get_role_max_break_lv(buddy_id)
  local break_cfg = ShareRes.create("buddy.buddy_break", buddy_id)
  Util.assert(break_cfg, "突破配置丢失 角色id = " .. buddy_id)
  return #break_cfg - 1
end

function M.get_condition_cfg(condition_id)
  local condition_cfg = M.create("condition.condition")[condition_id]
  return condition_cfg
end

function M.get_condition_desc(condition_id)
  local condition_cfg = M.create("condition.condition", condition_id)
  if not condition_cfg then
    Log.Error("condition is not exist , id = ", condition_id, debug.traceback())
    return
  end
  return condition_cfg.Desc
end

function M.get_buddy_qualityIcon_Small(quality)
  local buddy_quality_cfg = ShareRes.create("buddy.buddy_quality", quality)
  return buddy_quality_cfg.QualityIcon[1]
end

function M.get_buddy_qualityIcon_Big(quality)
  local buddy_quality_cfg = ShareRes.create("buddy.buddy_quality", quality)
  return buddy_quality_cfg.QualityIcon[2]
end

function M.get_buddy_qualityIcon_Name(quality)
  local buddy_quality_cfg = ShareRes.create("buddy.buddy_quality", quality)
  return buddy_quality_cfg.IconName
end

function M.get_buddy_qualityIcon_Long(quality)
  local buddy_quality_cfg = ShareRes.create("buddy.buddy_quality", quality)
  return buddy_quality_cfg.QualityIcon[3]
end

function M.get_buddy_qualityIcon_Short(quality)
  local buddy_quality_cfg = ShareRes.create("buddy.buddy_quality", quality)
  return buddy_quality_cfg.QualityIcon[4]
end

function M.get_buddy_qualityIcon_small_square(quality)
  local buddy_quality_cfg = ShareRes.create("buddy.buddy_quality", quality)
  return buddy_quality_cfg.QualityIcon[5]
end

function M.get_sys_open_cfg(sys_id)
  return M.create("sysopen.sys_open", sys_id)
end

function M.get_battle_skill_cfg(skill_id)
  return M.create("battle.battle_skill", skill_id)
end

function M.get_buddy_lie_cfg(buddy_id)
  return M.create("buddy.buddy_lie_state", buddy_id)
end

function M.get_effect_sound_cfg(effect_name)
  local all_cfg = M.create("sound.effect_sound")
  return all_cfg[effect_name]
end

function M.get_graphic_guide_list(ground_id)
  return M.create("graphic_guide.graphic_guide_outside_by_ground", ground_id)
end

function M.get_graphic_guide_cfg(id)
  return M.create("graphic_guide.graphic_guide_outside", id)
end

function M.get_fashion_cfg(fashion_id)
  return M.create("buddy.buddy_fashion", fashion_id)
end

function M.get_buddy_fashion_list(buddy_id)
  return M.create("buddy.buddy_fashion_list", buddy_id)
end

function M.get_fashion_tag_cfg(id)
  return M.create("buddy.buddy_fashion_tag", id)
end

function M.get_fashion_brand_cfg(id)
  return M.create("buddy.buddy_fashion_brand", id)
end

function M.get_enemy_list_cfg(level_id)
  return M.create("archives.monster_level_archlist", level_id)
end

function M.get_enemy_cfg(id)
  return M.create("archives.monster_arch_list", id)
end

function M.get_enemy_level_cfg(id)
  return M.create("archives.monster_arch_level", id)
end

function M.get_enemy_skill_cfg(id)
  return M.create("archives.monster_skill_list", id)
end

function M.get_buddy_fashion_brand(brand_id)
  return M.create("buddy.buddy_fashion_brand", brand_id)
end

function M.get_dictionary_content_cfg(brand_id)
  return M.create("archives.dictionary_content_title", brand_id)
end

function M.get_world_dic_cfg(id)
  return M.create("archives.dictionary_content", id)
end

function M.get_archive_group_cfg(id)
  return M.create("archives.move_video_group", id)
end

function M.get_archive_by_small_group_id(id)
  return M.create("archives.video_small_group")[id]
end

function M.get_archive_group_list_cfg(id)
  return M.create("archives.move_video_group_list", id)
end

function M.get_archive_video_cfg(id)
  return M.create("archives.move_video_list", id)
end

function M.get_archive_photo_title_cfg(id)
  return M.create("archives.album_title_list", id)
end

function M.get_scene_model_cfg()
  return M.create("scene_model.scene_model_list")
end

function M.get_enemy_feature_cfg(id)
  return M.create("archives.monster_features_list", id)
end

function M.get_character_cfg(npc_id)
  return M.create("character.character", npc_id)
end

function M.get_character_model_cfg(model_id)
  if model_id then
    return ShareRes.create("character.character_model", model_id)
  end
end

function M.get_buddy_rune_cfg(buddy_id)
  return M.create("battle.battle_buddy_rune", buddy_id)
end

function M.get_buddy_rune_lv_map(buddy_id, rune_type)
  if not rune_type then
    return
  end
  local buddy_rune_list = M.create("battle.battle_buddy_rune_lv", buddy_id)
  if not buddy_rune_list then
    return
  end
  local lv_map = buddy_rune_list[rune_type]
  return lv_map
end

function M.get_buddy_rune_max_lv(buddy_id, rune_type)
  local lv_map = M.get_buddy_rune_lv_map(buddy_id, rune_type)
  if not lv_map then
    return 3
  end
  return #lv_map
end

function M.get_buddy_rune_lv_cfg(buddy_id, rune_type, lv)
  local buddy_rune_list = M.create("battle.battle_buddy_rune_lv", buddy_id)
  if not buddy_rune_list then
    Log.Error("buddy rune is not exist, buddy id = ", buddy_id)
    return
  end
  local lv_map = buddy_rune_list[rune_type]
  if not lv_map then
    Log.Error("buddy rune type is not exist, buddy id = ", buddy_id, "rune type = ", rune_type)
    return
  end
  return lv_map[lv]
end

function M.get_buddy_rune_list_cfg(buddy_id, rune_type, rune_condition)
  local total_buddy_rune_list = M.create("battle.battle_buddy_rune_list")
  local buddy_rune_list = total_buddy_rune_list[buddy_id]
  if not buddy_rune_list then
    Log.Error("buddy rune list is not exist, buddy id = ", buddy_id)
    return
  end
  if rune_type then
    if rune_condition then
      local level_list = buddy_rune_list[rune_type]
      if level_list then
        return level_list[rune_condition]
      end
    else
      return buddy_rune_list[rune_type]
    end
  end
  return buddy_rune_list
end

function M.get_team_rune_cfg()
  return M.create("battle.battle_team_rune")
end

function M.get_team_level_rune_cfg(level)
  local battle_team_rune_cfg = M.create("battle.battle_team_rune")
  local length = #battle_team_rune_cfg
  for i = length, 1, -1 do
    local cfg = battle_team_rune_cfg[i]
    local lv = cfg.Level
    if level >= lv then
      return cfg, i
    end
  end
end

function M.get_random_entry_group_cfg(id)
  return M.create("entry.random_entry_group", id)
end

function M.get_entry_group(group_id)
  return M.create("entry.entry_main_group", group_id)
end

function M.get_entry_cfg(entry_id)
  return M.create("entry.entry_main", entry_id)
end

function M.get_fixed_char_pool(pool_id)
  local all_cfg = M.create("chapter.replace_role")
  return all_cfg[pool_id]
end

function M.get_rune_cast_cfg(cast_id)
  return M.create("battle.rune2_cast", cast_id)
end

function M.get_desc_story_cfg(story_id)
  local all_cfg = M.create("story.desc_story")
  return all_cfg[story_id]
end

function M.get_desc_story_detail_cfg(detail_id)
  local all_cfg = M.create("story.desc_story_detail")
  return all_cfg[detail_id]
end

function M.get_story_step_char_pos_offset(res_id, role_pos)
  local all_cfg = M.create("story.story_char_pos")
  if all_cfg and all_cfg[role_pos] and all_cfg[role_pos][res_id] then
    return all_cfg[role_pos][res_id].Offset
  end
end

function M.get_buddy_engrave_icon(buddy_id, streng_lv)
  local buddy_engrave_cfg = M.create("buddy.buddy_refine", buddy_id)
  local streng_lv_cfg = buddy_engrave_cfg[streng_lv]
  return streng_lv_cfg.Icon
end

function M.get_buddy_engrave_attr_list(buddy_id, streng_lv)
  local buddy_engrave_cfg = M.create("buddy.buddy_refine", buddy_id)
  local streng_lv_cfg = buddy_engrave_cfg[streng_lv]
  return streng_lv_cfg.EffectList
end

function M.get_curse_ring_card_type_cfg(type)
  local card_type_cfg = M.create("activity.curse_ring_card_type", type)
  return card_type_cfg
end

function M.get_curse_ring_bless_all_cfg()
  local bless_cfg = M.create("activity.curse_ring_bless")
  return bless_cfg
end

function M.get_curse_ring_bless_cfg(id)
  local bless_cfg = M.get_curse_ring_bless_all_cfg()[id]
  return bless_cfg
end

function M.get_curse_ring_bless_icon(id)
  local bless_cfg = M.get_curse_ring_bless_cfg(id)
  Util.assert(bless_cfg, "无祝福id = ", id)
  return bless_cfg.Icon
end

function M.get_curse_ring_curse_iocn(id)
  local curse_cfg = M.create("activity.curse_effect", id)
  return curse_cfg.Icon
end

function M.get_curse_ring_rune_price_cfg(lv)
  local rune_price_cfg = M.create("activity.curse_rune_price", lv)
  if nil == rune_price_cfg then
    return M.create("activity.curse_rune_price", 1)
  end
  return rune_price_cfg
end

function M.get_curse_task_card(group_id)
  local task_id_list = M.create("activity.curse_task_card_group", group_id)
  if not task_id_list then
    assert(false, "can't find cfg, group_id: " .. group_id)
  end
  local cfgs = {}
  for _, Id in ipairs(task_id_list) do
    local task_cfg = M.create("activity.curse_task_card", Id)
    _insert(cfgs, task_cfg)
  end
  return cfgs
end

function M.get_curse_task(task_id)
  local task_cfg = M.create("activity.curse_task_card")
  if task_id then
    return task_cfg[task_id]
  else
    return task_cfg
  end
end

function M.get_bag_capacity_by_award_type(award_type)
  return M.create("item.award_type", award_type).MaxGrid
end

function M.get_all_item_combine_cfg()
  return M.create("item.item_combine")
end

function M.get_can_show_item_combine_cfg()
  local cfgs = M.get_all_item_combine_cfg()
  local temp_cfg_map = {}
  local combine_id, cfg_id
  for _, cfg in pairs(cfgs) do
    if not cfg.ActivateByBuilding then
      combine_id = BuildingMgr:get_replace_item_combine_id(cfg.Id)
      cfg_id = combine_id and combine_id or cfg.Id
      temp_cfg_map[cfg_id] = cfgs[cfg_id]
    end
  end
  return temp_cfg_map
end

function M.get_item_combine_cfg(combine_id)
  return M.create("item.item_combine")[combine_id]
end

function M.get_item_exchange_cfg(exchange_id)
  return M.create("item.item_exchange")[exchange_id]
end

function M.get_gecao_cfg(id)
  local gecao_list = M.create("chapter.cut_grass_epi")
  if not id then
    return gecao_list
  end
  return gecao_list[id]
end

function M.get_gecao_award_cfg(id)
  local gecao_award_list = M.create("chapter.cut_grass_star_reward")
  if not id then
    return gecao_award_list
  end
  return gecao_award_list[id]
end

function M.get_gecao_star_desc_cfg(id)
  local list = M.create("chapter.cut_grass_star_desc")
  if not id then
    return list
  end
  return list[id]
end

function M.get_chapter_material_desc_cfg(id)
  local list = M.create("chapter.chapter_material_star_desc")
  if not id then
    return list
  end
  return list[id]
end

function M.get_chapter_collection_cfg(id)
  local collection_list = M.create("chapter.collection")
  if not id then
    return collection_list
  end
  return collection_list[id]
end

function M.get_achievement_group_cfg(id)
  local achievement_group_cfg = M.create("achievement.achievement_group")
  if not id then
    return achievement_group_cfg
  end
  return achievement_group_cfg[id]
end

function M.get_achievements(id)
  return M.create("achievement.achievement", id)
end

function M.get_achievements_num()
  local count = 0
  for k, v in pairs(M.create("achievement.achievement")) do
    count = count + 1
  end
  return count
end

function M.get_achievement_award(id)
  local award_id = M.create("achievement.achievement_progress_task", id).Award
  return M.get_award_item_data(award_id)
end

function M.get_achievement_progress_condition(id)
  return M.create("achievement.achievement_progress_task", id).Condition
end

function M.get_achievement_map()
  return M.create("achievement.achievement_map")
end

function M.get_title(id)
  return M.create("title.title", id)
end

function M.get_title_quality_path(id)
  return M.create("title.title_quality", id)
end

function M.get_progress_task_location(progress_task_id)
  return M.create("achievement.achievement_progress_map", progress_task_id)
end

function M.get_chapter_node_cfg(node_id)
  return M.create("chapter.chapter_node")[node_id]
end

function M.get_chapter_node_cfg_by_last_room_id(point_id, last_room_id, tp_index)
  local cfgs = M.create("chapter.chapter_settle_room_node_map")[point_id]
  if cfgs and cfgs[last_room_id] and cfgs[last_room_id][tp_index] then
    return M.get_chapter_node_cfg(cfgs[last_room_id][tp_index])
  end
end

function M.get_chapter_node_cfg_by_last_room_id(point_id, last_room_id, tp_index)
  local cfgs = M.create("chapter.chapter_settle_room_node_map")[point_id]
  if cfgs and cfgs[last_room_id] and cfgs[last_room_id][tp_index] then
    return M.get_chapter_node_cfg(cfgs[last_room_id][tp_index])
  end
end

function M.get_chapter_node_tp_dir(node_id)
  local node_cfg = M.create("chapter.chapter_node", node_id)
  if not node_cfg then
    return ""
  end
  return node_cfg.TpDir
end

function M.get_chapter_node_tag_num(node_id)
  local node_cfg = M.create("chapter.chapter_node", node_id)
  if not node_cfg then
    return ""
  end
  return node_cfg.TagNumName
end

function M.get_chapter_node_pre_node_id(node_id)
  local cur_node = M.get_chapter_node_cfg(node_id)
  if not cur_node then
    return
  end
  return cur_node.PreNodeId
end

function M.get_chapter_node_behind_node_id(node_id)
  local cur_node = M.get_chapter_node_cfg(node_id)
  if not cur_node then
    return
  end
  return cur_node.BehindNodeId
end

function M.get_chapter_node_behind_node_cfg(node_id)
  local behind_node_id = M.get_chapter_node_behind_node_id(node_id)
  if behind_node_id and behind_node_id > 0 then
    return M.get_chapter_node_cfg(node_id)
  end
end

function M.get_chapter_node_first_room_id(node_id)
  local cur_node = M.get_chapter_node_cfg(node_id)
  if not cur_node then
    return
  end
  return cur_node.FirstRoomId
end

function M.get_chapter_node_last_room_id(node_id)
  local cur_node = M.get_chapter_node_cfg(node_id)
  if not cur_node then
    return
  end
  return cur_node.LastRoomId
end

function M.get_chapter_node_award_id(node_id)
  local cur_node = M.get_chapter_node_cfg(node_id)
  if not cur_node then
    return
  end
  return cur_node.AwardId
end

function M.get_chapter_all_node_id_by_point_id(point_id)
  local temp = M.create("chapter.chapter_node_relation")
  return temp[point_id]
end

function M.get_chapter_all_node_id_by_chapter_id(chapter_id)
  local chapter_cfg = M.get_chapter_cfg(chapter_id)
  if not (chapter_cfg and chapter_cfg.Point) or not chapter_cfg.Point[1] then
    return
  end
  return M.get_chapter_all_node_id_by_point_id(chapter_cfg.Point[1])
end

function M.get_chapter_node_layout(id)
  return M.create("chapter.chapter_node_layout", id)
end

function M.get_chapter_points(chapter_id)
  local chapter_list = M.create("chapter.chapter")
  if not chapter_list or not chapter_list[chapter_id] then
    return
  end
  return chapter_list[chapter_id].Point
end

function M.get_weekly_hundle_all_cfg()
  local all_cfg = M.create("activity.prepare_war_epi_index")
  return all_cfg
end

function M.get_weekly_hundle_cfg(id)
  local all_cfg = M.create("activity.prepare_war_epi_index")
  return all_cfg[id]
end

function M.get_weekly_pvp_epi_pool_cfg(id)
  local all_cfg = M.create("activity.week_acty_episode")
  return all_cfg[id]
end

function M.get_weekly_prepare_war()
  return M.create("activity.prepare_war_epi")
end

function M.get_weekly_prepare_rule_cfg()
  return M.create("activity.prepare_war_rule")
end

function M.get_weekly_pvp_rule_cfg()
  return M.create("activity.pvp_rule")
end

function M.get_weekly_element_rule_cfg()
  return M.create("activity.element_rule")
end

function M.get_rune_group_cfg(group_id)
  local all_cfg = M.create("activity.week_acty_rune_group")
  return all_cfg[group_id]
end

function M.get_ornaments(id)
  local ornaments = M.create("item.ornaments")
  if id then
    return ornaments[id]
  end
  return ornaments
end

function M.get_ornaments_group_data(id)
  local groups = M.create("item.ornament_group_data")
  if id then
    return groups[id]
  else
    return groups
  end
end

function M.get_ornaments_group(id)
  local groups = M.create("item.ornament_group")
  if id then
    return groups[id]
  else
    return groups
  end
end

function M.get_ornaments_quality()
  return M.create("item.ornament_quality")
end

function M.get_point_award(point_id)
  local point_cfg = M.get_chapter_point_cfg(point_id)
  if not point_cfg then
    return
  end
  local list
  if point_cfg.AwardId[1] then
    list = M.get_awards(point_cfg.AwardId[1])
  end
  if point_cfg.AwardId[2] then
    local award_2_list = M.get_awards(point_cfg.AwardId[2])
    if not list then
      list = award_2_list
    elseif award_2_list then
      for index, value in ipairs(award_2_list) do
        table.insert(list, value)
      end
    end
  end
  return list
end

function M.get_node_by_param_id(param_id)
  return M.create("chapter.chapter_param_map")[param_id]
end

function M.get_weekly_rune_group_cfg(group_id)
  local cfg = M.create("activity.week_acty_rune_group")
  return cfg[group_id]
end

function M.get_buddy_name(buddy_id)
  local buddy_cfg = M.get_buddy_cfg(buddy_id)
  return buddy_cfg.Name
end

function M.get_week_acty_segment_cfg(segment_id)
  local all_cfg = M.create("activity.week_acty_segment")
  if not segment_id then
    return all_cfg
  end
  return all_cfg[segment_id]
end

function M.get_segment_cfg_by_cup_val(cup_val)
  local cfg = M.get_week_acty_segment_cfg()
  if not cfg then
    return
  end
  local new_segment_cfg
  for _, data in ipairs(cfg) do
    if cup_val >= data.NeedPunishment then
      new_segment_cfg = data
    end
  end
  return new_segment_cfg
end

function M.get_weekly_pvp_task_group_id(cur_segment)
  local cfg = M.get_week_acty_segment_cfg(cur_segment)
  if not cfg then
    return
  end
  return cfg.TaskGroupID
end

function M.get_weekly_pvp_activity_cfg()
  local all_cfg = M.create("activity.week_acty_pvp_summary")
  local max = #all_cfg
  return all_cfg[max]
end

function M.get_weekly_pvp_epi_cfg(epi_id)
  local all_cfg = M.create("activity.week_pvp_episode_config")
  return all_cfg[epi_id]
end

function M.get_shop_cfg_by_shop_id(shop_id)
  local all_cfg = M.create("shop.exchange_goods_type")
  return all_cfg[shop_id]
end

function M.get_visiting_card_cfg(card_id)
  local cfg = M.create("player.business_card")
  if card_id then
    return cfg[card_id]
  else
    return cfg
  end
end

function M.get_visiting_card_bg(card_id)
  if card_id then
    local cfg = M.create("player.business_card", card_id)
    if cfg then
      return cfg.Icon
    end
  end
end

function M.get_visiting_card_rank_bg(card_id)
  if card_id then
    local cfg = M.create("player.business_card", card_id)
    if cfg then
      return cfg.RankingListIcon
    end
  end
end

function M.get_player_head_cfg(id)
  local cfg = M.create("player.player_avatar")
  if id then
    return cfg[id]
  else
    return cfg
  end
end

function M.get_legal_special_char()
  local special_char = M.create("player.special_char")
  return special_char
end

function M.get_floor_cfg(floor_id)
  return M.create("tower.tower_floor")[floor_id]
end

function M.get_floor_cfg_by_tower_id(tower_id, floor_num)
  local tower_cfg = ShareRes.create("tower.tower", tower_id)
  local cfg = tower_cfg.FloorGroup[floor_num]
  if cfg then
    local floor_id = cfg[1]
    return M.get_floor_cfg(floor_id)
  end
end

function M.get_char_element_id(buddy_id)
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  return buddy_cfg.Element
end

function M.get_point_star_award(point_id)
  local tb = {}
  local point_cfg = M.get_chapter_point_cfg(point_id)
  if not point_cfg or point_cfg.StarRating <= 0 then
    return
  end
  local star_rating_cfg = M.create("chapter.chapter_star_rating")[point_cfg.StarRating]
  if not star_rating_cfg then
    return
  end
  local award_list = star_rating_cfg.RewardGroupId
  for index, award_id in pairs(award_list) do
    if award_id > 0 then
      tb[index] = M.get_awards(award_id)
    end
  end
  return tb
end

function M.get_hard_node_type_five_award(point_id)
  local throw_cfg = M.create("chapter.chapter_throw")[point_id]
  if not throw_cfg then
    return
  end
  return throw_cfg[5]
end

function M.get_point_star_condition(point_id)
  local point_cfg = M.get_chapter_point_cfg(point_id)
  if not (point_cfg and point_cfg.StarRating) or point_cfg.StarRating <= 0 then
    return
  end
  local star_rating_cfg = M.create("chapter/chapter_star_rating")[point_cfg.StarRating]
  if not star_rating_cfg then
    return
  end
  return star_rating_cfg.Condition
end

function M.get_point_star_condition_cfg(condition)
  return M.create("chapter/chapter_star_rating_condition")[condition]
end

function M.get_point_star_condition_desc(condition)
  local cfg = M.get_point_star_condition_cfg(condition)
  if not cfg then
    return
  end
  local arg = cfg.Arg[1]
  if cfg.ConditionType == Config.Condition_Type.HealthMoreThan then
    local percent_health = arg / 100
    percent_health = math.max(percent_health, 1)
    arg = string.format("%d", percent_health) .. "%"
  end
  local desc = cfg.ConditionDesc
  desc = Util.format_str(desc, arg)
  return desc
end

function M.get_point_throw_show_award(node_id)
  local throw_cfg = M.create("chapter/chapter_throw_show_node")[node_id]
  if not throw_cfg then
    return
  end
  local temp = {}
  for key, value in pairs(throw_cfg) do
    if next(value) ~= nil then
      table.insert(temp, value)
    end
  end
  table.sort(temp, function(a, b)
    if a[1].Type ~= b[1].Type then
      return a[1].Type < b[1].Type
    else
      return false
    end
  end)
  return temp
end

function M.get_item_id_by_battle_item_id(battle_item_id)
  local cfg = ShareRes.create("battle.battle_item_exchange")[battle_item_id]
  if cfg then
    return cfg.ExchangeId
  end
end

function M.check_can_exchange_item(battle_item_id)
  return M.get_battle_item_cfg(battle_item_id) ~= nil and nil ~= M.get_item_id_by_battle_item_id(battle_item_id)
end

function M.get_item_cfg_by_battle_item_id(battle_item_id)
  local item_id = M.get_item_id_by_battle_item_id(battle_item_id)
  if battle_item_id then
    return M.get_item_cfg(item_id)
  end
end

function M.get_equip_advance_cfg(equip_id, advance_lv)
  local cfg = ShareRes.create("equip.equip_advance")[equip_id]
  if cfg then
    return cfg[advance_lv]
  else
    Log.Error("武器同调配置获取失败，武器ID", equip_id)
  end
end

function M.get_all_privilege_cfg()
  return M.create("activity.privilege")
end

function M.get_privilege_cfg(privilege_id)
  local cfg = M.create("activity.privilege")
  if cfg then
    return cfg[privilege_id]
  end
end

function M.get_privilege_remodel_percent(privilege_id)
  local cfg = M.get_privilege_cfg(privilege_id)
  if cfg then
    return tonumber(cfg.Arg[1]), tonumber(cfg.Arg[2]), tonumber(cfg.Arg[3])
  end
end

function M.get_remodel_percent()
  local cfg = M.create("equip.equip_reshape")[1]
  if cfg then
    return cfg.GoldReshapeRatio, cfg.ExpReshapeRatio, cfg.BreakReshapeRatio
  end
end

function M.get_room_cfg(room_id)
  return ShareRes.create("tower.tower_room")[room_id]
end

function M.get_preload_role_effect_cfg(tower_id)
  return M.create("preload.role_effect", tower_id)
end

function M.get_tower_room_type_cfg(room_type)
  return M.create("tower.tower_room_type")[room_type]
end

function M.get_main_scene_video_cfg(cur_time)
  local all_cfg = M.create("main_scene_video.main_scene_video")
  if all_cfg then
    for key, value in pairs(all_cfg) do
      local start_time = value[1].TimeStart
      local end_time = value[1].TimeEnd
      if cur_time >= start_time and cur_time <= end_time then
        return value
      end
    end
  end
end

function M.get_main_scene_tex_cfg()
  local all_cfg = M.create("main_scene_video.main_scene_tex")
  if all_cfg then
    return all_cfg
  end
end

function M.get_favor_show_item_cfg()
  return ShareRes.create("buddy.favor_show_item")
end

function M.get_favor_item_cfg(item_id, buddy_id)
  local cfg = ShareRes.create("buddy.favor")[item_id]
  if cfg and cfg[buddy_id] then
    return cfg[buddy_id]
  end
  return nil
end

function M.get_favor_lv_cfg(buddy_id, lv)
  local cfg = ShareRes.create("buddy.buddy_favorability_lv")
  local target = cfg[buddy_id] or cfg[0]
  if lv then
    return target[lv]
  end
  return target
end

function M.get_max_favor_lv(buddy_id)
  return #M.get_favor_lv_cfg(buddy_id)
end

function M.get_camera_cfg(id, is_new_config)
  if is_new_config then
    return M.create("camera." .. id)
  else
    return M.create("camera.camera", id)
  end
end

function M.get_all_genres_cfg()
  return ShareRes.create("activity.sect")
end

function M.get_genres_cfg(genres_id)
  return M.get_all_genres_cfg()[genres_id]
end

function M.get_ability_cfg(ability_id)
  return ShareRes.create("activity.ability")[ability_id]
end

function M.get_ability_drop_cfg(drop_id)
  return ShareRes.create("activity.ability_drop")[drop_id]
end

function M.get_ability_quality_cfg(quality)
  return ShareRes.create("activity.ability_quality")[quality]
end

function M.get_ability_upgrade_cfg(ability_id, upgrade)
  local cfg = ShareRes.create("activity.ability_upgrade")[ability_id]
  if cfg then
    return cfg[upgrade]
  end
end

function M.get_ability_max_lv(ability_id)
  local max_lv = 0
  local ability_all_lv_cfg = ShareRes.create("activity.ability_upgrade")[ability_id]
  if ability_all_lv_cfg then
    for key, single_cfg in pairs(ability_all_lv_cfg) do
      if max_lv < single_cfg.Grade then
        max_lv = single_cfg.Grade
      end
    end
  end
  return max_lv
end

function M.get_ability_id_list_by_genres_id(target_genres_id)
  local all_cfg = ShareRes.create("activity.ability_sect_id_list")
  return all_cfg and all_cfg[target_genres_id]
end

function M.get_recuperation_cfg(recuperation_id)
  return ShareRes.create("activity.curse_ring_recuperation")[recuperation_id]
end

function M.get_recuperation_step_cfg(group_id)
  return ShareRes.create("activity.curse_recuperation_group")[group_id]
end

function M.get_recuperation_type_cfg(recuperation_type)
  return ShareRes.create("activity.recuperation_type")[recuperation_type]
end

function M.get_recuperation_type_cfg_by_id(recuperation_id)
  local cfg = M.get_recuperation_cfg(recuperation_id)
  return M.get_recuperation_type_cfg(cfg.Type)
end

function M._check_possible_award(check_cfg, result)
  local all_cfg = ShareRes.create("drop.drop_layer")
  local all_base_cfg = ShareRes.create("drop.drop_layer_base")
  local temp_cfg, base_cfg
  if check_cfg and check_cfg.DropCells and next(check_cfg.DropCells) then
    for key, cell in pairs(check_cfg.DropCells) do
      temp_cfg = all_cfg[cell.CellId]
      if not temp_cfg then
        base_cfg = all_base_cfg[cell.CellId]
        if base_cfg then
          result[base_cfg.ItemId] = (result[base_cfg.ItemId] or 0) + base_cfg.MaxCount
        end
      else
        M._check_possible_award(temp_cfg, result)
      end
    end
  end
end

function M.get_all_possible_award(drop_id)
  local check_cfg = ShareRes.create("drop.drop_layer")[drop_id]
  local result = {}
  M._check_possible_award(check_cfg, result)
  return result
end

function M.get_abnormal_damage_param()
  local cfg = M.create("magic.abnormal_mastery_parameter")
  if cfg then
    return cfg
  else
    Log.Error("没有找到新异常专精参数表", debug.traceback())
  end
end

function M.get_abnormal_mastery_parameter(index)
  local cfg = M.create("magic.abnormal_mastery_parameter")[index]
  if cfg then
    return cfg
  else
    Log.Error("没有找到异常专精索引值为", index, "的参数配置", debug.traceback())
  end
end

function M.get_abnormal_parameter_cfg(attr_value)
  local cfg = M.create("magic.abnormal_parameter")[attr_value]
  if cfg then
    return cfg
  else
    Log.Error("没有找到等级参数为", attr_value, "的异常专精参数配置", debug.traceback())
  end
end

function M.get_abnormal_level_param(break_lv, lv)
  local cfg = M.create("magic.break_parameter")[break_lv]
  if cfg and cfg[lv] then
    return cfg[lv].LevelParam
  else
    Log.Error("没有找到突破等级", break_lv, "等级为", lv, "的等级参数", debug.traceback())
  end
end

function M._get_logic_cfg(char_id, param_name, path)
  local cfg = ShareRes.create(path)
  if cfg then
    if char_id then
      if not cfg[char_id] then
        Log.Error("单位物理按钮配置获取失败, 未找到char_id：", char_id, "对应配置")
      elseif param_name then
        if not cfg[char_id][param_name] then
          Log.Error("单位物理按钮配置获取失败, char_id：", char_id, "btn_name:", param_name, "对应配置")
        else
          return cfg[char_id][param_name]
        end
      else
        return cfg[char_id]
      end
    elseif not param_name then
      return cfg
    elseif param_name then
      Log.Error("单位物理按钮配置无法只通过btn_name来获取")
    end
  end
end

function M.get_unit_physical_button_cfg(char_id, btn_name)
  return M._get_logic_cfg(char_id, btn_name, "character.unit_physical_button")
end

function M.get_unit_logic_button_cfg_by_char_id(char_id)
  return M.create("character.unit_logic_button")[char_id]
end

function M.get_unit_logic_button_cfg(char_id, icon_name)
  return M._get_logic_cfg(char_id, icon_name, "character.unit_logic_button")
end

function M.get_unit_skill_action_cfg(char_id, skact_name)
  return M._get_logic_cfg(char_id, skact_name, "character.unit_skill_action")
end

function M.get_role_shadow_cfg(id)
  if not id then
    return
  end
  return M.create("role_shadow.role_shadow", id)
end

function M.get_equip_cfg(equip_id)
  return M.create("equip.equip")[equip_id]
end

function M.get_spine_cfg(spine_id)
  if type(spine_id) == "string" then
    spine_id = tonumber(spine_id)
  end
  return M.create("spine.spine", spine_id)
end

function M.get_spine_anim_group_cfg(group_id)
  return M.create("spine.spine_anim_group", group_id)
end

function M.get_newbie_privilege(id)
  if id then
    return M.create("activity.newbie_privilege", id)
  else
    return M.create("activity.newbie_privilege")
  end
end

function M.get_course_award(index)
  return M.create("activity.activity_journey", index)
end

function M.get_course_award_chapter_cfg(chapter_id)
  return M.create("activity.activity_journey_chaptericon", chapter_id)
end

function M.get_compensate_cfg(id)
  return M.create("activity.compensate", id)
end

function M.get_activity_cfg(id)
  local cfg = M.create("activity.routine_activity", id)
  if cfg then
    return cfg
  end
end

function M.get_battle_passport_cfg(id)
  local cfg = M.create("battle_passport.battle_passport", id)
  if cfg then
    return cfg
  end
end

function M.get_battle_passport_group_cfg(id)
  local cfg = M.create("battle_passport.battle_passport_group_data", id)
  if cfg then
    return cfg
  end
end

function M.get_battle_passport_key_cfg(id)
  local cfg = M.create("battle_passport.battle_passport_key", id)
  if cfg then
    return cfg
  end
end

function M.get_relic_cfg(id)
  return M.create("relic.relic", id)
end

function M.get_relic_slot_cfg(id)
  local relic_slot_base = M.create("relic.relic_slot_base")
  if relic_slot_base[id] then
    return relic_slot_base[id]
  else
    return relic_slot_base[0]
  end
end

function M.get_relic_buddy_slot_id(id, idx)
  return ShareRes.create("relic.relic_buddy_slot", id)[idx]
end

function M.get_relic_max_lv(id)
  local relic_cfg = M.create("relic.relic", id)
  local relic_level_cfg = M.create("relic.relic_level", 5)
  return #relic_level_cfg
end

function M.get_skill_battle_res_cost(skill_id)
  local cfg = ShareRes.create("skill.skill")[skill_id]
  if cfg then
    return cfg.BattleResCost
  else
    Log.Error("获取技能：", skill_id, "配置失败")
    return 0
  end
end

function M.get_skill_cfg(skill_id)
  local cfg = ShareRes.create("skill.skill")
  if skill_id then
    return cfg and cfg[skill_id]
  else
    return cfg
  end
end

function M.get_weapon_magic(equip_id, advance_lv)
  local advance_cfg = ShareRes.create("equip.equip_advance")[equip_id]
  local skill_id = advance_cfg[advance_lv].SkillId
  local skill_lv_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  if not skill_lv_cfg then
    return
  end
  return skill_lv_cfg.EffectId, advance_lv
end

function M.get_archive_small_group_cfg(id)
  return M.create("archives.move_video_small_group", id)
end

function M.get_album_arch_small_group_cfg(id)
  return M.create("archives.album_arch_small_group", id)
end

function M.get_chapter_ared_cfg(area_id)
  return M.create("chapter.area")[area_id]
end

function M.get_chapter_area_gather(chapter_id)
  return M.create("chapter.area_gather")[chapter_id]
end

function M.get_chapter_area_list(chapter_id)
  return M.create("chapter.area_list")[chapter_id]
end

function M.get_chapter_area_point_cfg(area_point_id)
  return M.create("chapter.area_point")[area_point_id]
end

function M.get_chapter_area_point_gather(area_id)
  return M.create("chapter.area_point_gather")[area_id]
end

function M.get_chapter_area_point_type_cfg(point_type)
  return M.create("chapter.area_point_type")[point_type]
end

function M.get_chapter_area_point_cfg_by_module(module_type, module_param)
  local cfg = M.create("chapter.module_to_point")[module_type]
  if cfg then
    return cfg[module_param]
  end
end

function M.get_item_obj_use_award_list(award_group_id, data_list, build_data_func)
  local awards = M.create("award.award_group")[award_group_id]
  if not awards then
    return
  end
  local all_award_cfg = M.create("award.award")
  data_list = data_list or {}
  local award_cfg, temp
  for index, award_id in ipairs(awards) do
    if award_id > 0 then
      award_cfg = all_award_cfg[award_id]
      if build_data_func then
        temp = build_data_func(award_cfg, index)
      else
        temp = {
          id = award_cfg.ItemId,
          count = award_cfg.Num
        }
      end
      table.insert(data_list, temp)
    end
  end
  return data_list
end

function M.get_chapter_node_award2(node_id, data_list, cal_force_exchange_ex)
  local node_cfg = M.get_chapter_node_cfg(node_id)
  local award_id = node_cfg.AwardId
  local OneVitToExp, fight_cost
  if cal_force_exchange_ex then
    OneVitToExp = ShareRes.get_comm_value("OneVitToExp")
    fight_cost = node_cfg.Cost
  end
  local temp_arg = {
    check_first_pass = true,
    star = 0,
    type = -1,
    fight_cost = fight_cost
  }
  
  local function build_data_func(award_cfg, index)
    local data = {
      id = award_cfg.ItemId,
      count = award_cfg.Num,
      limit = award_cfg.Limit,
      check_first_pass = temp_arg.check_first_pass,
      star = temp_arg.star,
      type = temp_arg.type,
      index = index
    }
    if cal_force_exchange_ex and data.id == Config.EXP_ITEMID then
      local add_count = temp_arg.fight_cost * OneVitToExp
      data.count = data.count + add_count
      data.limit = data.limit + add_count
    end
    return data
  end
  
  if award_id and award_id > 0 then
    M.get_item_obj_use_award_list(award_id, data_list, build_data_func)
  end
  temp_arg.star = nil
  temp_arg.type = nil
  temp_arg.check_first_pass = false
  if cal_force_exchange_ex then
    temp_arg.fight_cost = node_cfg.RepeatCost
  end
  local repeat_award_id = node_cfg.RepeatAwardId
  if repeat_award_id and repeat_award_id > 0 then
    M.get_item_obj_use_award_list(repeat_award_id, data_list, build_data_func)
  end
  return data_list
end

function M.get_point_award2(point_id, data_list, cal_force_exchange_ex)
  data_list = data_list or {}
  local point_cfg = M.get_chapter_point_cfg(point_id)
  if not point_cfg then
    return data_list
  end
  local first_award = point_cfg.AwardId[1]
  local OneVitToExp, fight_cost
  if cal_force_exchange_ex then
    OneVitToExp = ShareRes.get_comm_value("OneVitToExp")
    fight_cost = point_cfg.FightCost[1]
  end
  local temp_arg = {
    check_first_pass = true,
    type = -1,
    fight_cost = fight_cost
  }
  
  local function build_data_func(award_cfg)
    local data = {
      id = award_cfg.ItemId,
      count = award_cfg.Num,
      check_first_pass = temp_arg.check_first_pass,
      star = 0,
      type = temp_arg.type
    }
    if cal_force_exchange_ex and data.id == Config.EXP_ITEMID then
      local add_count = temp_arg.fight_cost * OneVitToExp
      data.count = data.count + add_count
      data.limit = data.limit + add_count
    end
    return data
  end
  
  if first_award and first_award > 0 then
    M.get_item_obj_use_award_list(first_award, data_list, build_data_func)
  end
  local repeat_award = point_cfg.AwardId[2]
  temp_arg.check_first_pass = false
  temp_arg.type = nil
  if cal_force_exchange_ex then
    temp_arg.fight_cost = point_cfg.FightCost[2]
  end
  if repeat_award and repeat_award > 0 then
    M.get_item_obj_use_award_list(repeat_award, data_list, build_data_func)
  end
  return data_list
end

function M.only_get_point_get_point_award1(point_id, data_list)
  data_list = data_list or {}
  local point_cfg = M.get_chapter_point_cfg(point_id)
  if not point_cfg then
    return data_list
  end
  local repeat_award = point_cfg.AwardId[1]
  if repeat_award and repeat_award > 0 then
    M.get_item_obj_use_award_list(repeat_award, data_list)
  end
  return data_list
end

function M.get_point_star_award2(point_id, data_list)
  data_list = data_list or {}
  local point_cfg = M.get_chapter_point_cfg(point_id)
  if not point_cfg or point_cfg.StarRating <= 0 then
    return data_list
  end
  local star_rating_cfg = M.create("chapter.chapter_star_rating")[point_cfg.StarRating]
  if not star_rating_cfg then
    return data_list
  end
  local award_list = star_rating_cfg.RewardGroupId
  local temp_arg = {star = 0}
  
  local function build_data_func(award_cfg)
    return {
      id = award_cfg.ItemId,
      count = award_cfg.Num,
      star = temp_arg.star,
      check_star_complete = true,
      type = -1
    }
  end
  
  for star, award_id in pairs(award_list) do
    if award_id > 0 then
      temp_arg.star = star
      M.get_item_obj_use_award_list(award_id, data_list, build_data_func)
    end
  end
  return data_list
end

function M.get_hard_node_type_five_award2(point_id, data_list)
  data_list = data_list or {}
  local throw_cfg = M.create("chapter.chapter_throw")[point_id]
  if not throw_cfg then
    return data_list
  end
  local award_data
  for key, data in ipairs(throw_cfg[5]) do
    award_data = {
      id = M.get_item_id_by_battle_item_id(data.ItemId) or data.ItemId,
      count = data.ItemNum,
      throw_data_id = data.Id,
      star = data.Param[1]
    }
    table.insert(data_list, award_data)
  end
  return data_list
end

function M.get_point_throw_show_award2(node_id, data_list)
  local throw_cfg = M.create("chapter/chapter_throw_show_node")[node_id]
  if not throw_cfg then
    return
  end
  local temp_list = {}
  local temp
  for key, data in pairs(throw_cfg) do
    for k, v in pairs(data) do
      temp = {
        id = M.get_item_id_by_battle_item_id(v.ItemId) or v.ItemId,
        count = v.ItemNum,
        type = v.Type,
        throw_data_id = v.Id
      }
      table.insert(temp_list, temp)
    end
  end
  table.sort(temp_list, function(a, b)
    if a.type ~= b.type then
      return a.type < b.type
    else
      return false
    end
  end)
  if data_list then
    for index, data in ipairs(temp_list) do
      table.insert(data_list, data)
    end
  end
  return temp_list, data_list
end

function M.get_minigame_cfg_insertNeedle(id)
  return M.create("minigame/insertneedle." .. id)
end

function M.get_curse_to_magic_level(curse)
  local all_cfg = M.create("activity.curse_map_level")
  for key, cfg in pairs(all_cfg) do
    if curse >= cfg.Low and curse <= cfg.Hight then
      return cfg.Level
    end
  end
end

function M.get_grandshadow_cfg(id)
  if not id then
    return
  end
  local cfg = M.create("role_shadow.grand_shadow", id)
  if cfg then
    return cfg.rot, cfg.hight
  end
  return
end

function M.get_node_after_fight_story_id(node_id)
  local cfg = M.get_chapter_node_cfg(node_id)
  if cfg then
    return cfg.AfterFightStoryId
  end
end

function M.get_buddy_teach_cfg_by_point_id(point_id)
  local cfg = M.create("activity.buddy_teach_episode_key")
  return cfg[point_id]
end

function M.get_teach_point_id_by_buddy_id(buddy_id)
  local cfg = M.create("activity.buddy_teach_buddy_key")
  return cfg[buddy_id] and cfg[buddy_id].EpisodeId
end

function M.get_teach_buddy_id_by_point_id(point_id)
  local cfg = M.create("activity.buddy_teach_episode_key")
  return cfg[point_id] and cfg[point_id].BuddyID
end

function M.get_buddy_teach_cfg_by_buddy_id(buddy_id)
  local cfg = M.create("activity.buddy_teach_buddy_key")
  return cfg[buddy_id]
end

function M.get_buddy_teach_floor_by_point_id(point_id)
  local cfg = M.create("activity.buddy_teach_floor")
  return cfg[point_id]
end

function M.get_buddy_teach_floor_cfg_by_point_id(point_id, floor_index)
  local cfg = M.get_buddy_teach_floor_by_point_id(point_id)
  return cfg and cfg[floor_index]
end

function M.get_buddy_teach_floor_cfg_by_buddy_id(buddy_id, floor_index)
  local teach_cfg = M.get_buddy_teach_cfg_by_buddy_id(buddy_id)
  if teach_cfg then
    local cfg = M.get_buddy_teach_floor_by_point_id(teach_cfg.EpisodeId)
    return cfg and cfg[floor_index]
  else
    Log.Error("获取角色教学配置失败，buddyId：", buddy_id)
  end
end

function M.get_random_spineid_bygroupid(group_id)
  if group_id then
    local cfg = M.create("spine.spine_group", group_id)
    if cfg then
      local cfg_length = #cfg
      local random_id = math.random(1, cfg_length)
      if cfg[random_id] then
        return cfg[random_id].Id
      end
    end
  end
end

function M.get_chapter_infinite_misc()
  local cfg = M.create("chapter.chapter_infinite_misc")
  return cfg
end

function M.get_endless_progress_task_group()
  local cfg = M.get_chapter_infinite_misc()
  return cfg and cfg.RewardTaskGroup
end

function M.get_endless_sweep_discount()
  local cfg = M.get_chapter_infinite_misc()
  return cfg and cfg.SweepDiscount
end

function M.get_infinite_entry_group_by_option(option_group)
  local cfg = M.create("chapter.chapter_infinite_entry_owner_group")[option_group]
  return cfg
end

function M.get_infinite_entry_group_cfg(group_id)
  local cfg = M.create("chapter.chapter_infinite_entry_group")[group_id]
  return cfg
end

function M.get_infinite_entry_group(group_id)
  local cfg = M.create("chapter.chapter_infinite_owner_entry")[group_id]
  return cfg
end

function M.get_infinite_entry_cfg(entry_id)
  local cfg = M.create("chapter.chapter_infinite_entry")[entry_id]
  return cfg
end

function M.get_infinite_score_award()
  local cfg = M.create("chapter.chapter_infinite_score")
  return cfg
end

function M.get_curse_illustrated_type_cfg(type_id)
  local cfg = M.create("activity.activity_curse_illustrated")
  return cfg[type_id]
end

function M.get_curse_illustrated_task_group_by_type_id(type_id)
  local cfg = M.create("activity.activity_curse_illustrated")
  return cfg[type_id] and cfg[type_id].RewardTaskGroup
end

function M.get_curse_equation_illustrated_cfg(group_id)
  return M.create("activity.curse_equation_illustrated", group_id)
end

function M.get_curse_ring_skill_tree_pos_cfg()
  local cfg = M.create("activity.curse_ring_skill_tree_pos")
  return cfg
end

function M.get_curse_course_chapter_cfg(id)
  local cfg = M.create("activity.activity_curse_task_chapter")
  if id then
    return cfg and cfg[id]
  end
  return cfg
end

function M.get_curse_course_node_by_chapter_id(chapter_id)
  local cfg = M.create("activity.activity_curse_task_node_by_chapter")[chapter_id]
  return cfg
end

function M.get_curse_course_node_cfg(node_id)
  local cfg = M.create("activity.activity_curse_task_node")[node_id]
  return cfg
end

function M.get_curse_event_cfg(event_id)
  local cfg = M.create("activity.curse_event_card")
  if event_id then
    return cfg and cfg[event_id]
  end
  return cfg
end

function M.get_curse_event_group_cfg(event_group_id)
  local cfg = M.create("activity.curse_event_group")
  if event_group_id then
    return cfg and cfg[event_group_id]
  end
  return cfg
end

function M.get_curse_ring_config(ring_id)
  local cfg = M.create("activity.curse_ring_config")
  if ring_id then
    return cfg and cfg[ring_id]
  end
  return cfg
end

function M.get_curse_ring_config_type_to_group_cfg(type_id)
  local cfg = M.create("activity.curse_ring_config_type_to_group")
  if type_id then
    return cfg and cfg[type_id]
  end
  return cfg
end

function M.get_curse_ring_group_cfg(group_id)
  local cfg = M.create("activity.curse_ring_config_group")
  if group_id then
    return cfg and cfg[group_id]
  end
  return cfg
end

function M.get_curse_ring_config_group_to_point_cfg(group_id)
  local cfg = M.create("activity.curse_ring_config_group_to_point")
  if group_id then
    return cfg and cfg[group_id]
  end
  return cfg
end

function M.get_curse_event_option_cfg(option_id)
  local cfg = M.create("activity.curse_event_option")
  if option_id then
    return cfg and cfg[option_id]
  end
  return cfg
end

function M.get_curse_max_floor_num(tower_id)
  local ring_cfg = ShareRes.create("activity.rings_of_curse_ring_by_tower")[tower_id]
  return ring_cfg and UtilTable.hash_lenth(ring_cfg) or 0
end

function M.get_weekly_prepare_war_epi_task_group_id()
  local cfg = M.create("activity.prepare_war_epi_task")
  if cfg then
    local _, nextcfg = next(cfg)
    if nextcfg then
      return nextcfg.TaskGroup
    end
  end
end

function M.get_post_process_cfg_by_ui_name(ui_name)
  local config_id = 1
  if ui_name then
    local post_process_cfg = M.create("post_process.post_process_ui", ui_name)
    if post_process_cfg then
      config_id = post_process_cfg.ConfigId
    end
  end
  return M.create("post_process.post_process_param", config_id)
end

function M.get_attach_model_id(buddy_id, act_name)
  if not buddy_id or not act_name then
    return
  end
  local act_to_attach_cfg = M.create("attach_model.act_to_attach_model", buddy_id)
  if act_to_attach_cfg then
    return act_to_attach_cfg[act_name]
  end
  return
end

function M.get_weapon_attach_model_id(weapon_res_id, act_name)
  if not weapon_res_id or not act_name then
    return
  end
  local act_to_attach_cfg = M.create("attach_model.weapon_act_to_attach_model")
  if act_to_attach_cfg then
    local t1 = act_to_attach_cfg[weapon_res_id]
    if t1 then
      return t1[act_name] and t1[act_name].AttachModelId or false
    end
  end
  return false
end

function M.get_challenge_type_config(challenge_type)
  local cfg = M.create("chapter.challenge_type")[challenge_type]
  if not cfg then
    Log.Error("获取玩法描述配置失败，挑战类型：", challenge_type)
  end
  return cfg
end

function M.get_character_light_by_id(character_id)
  if not character_id then
    return
  end
  local cfg = M.create("role_shadow.role_light_offset", character_id)
  return cfg
end

function M.get_character_edge_light_by_id(character_id)
  if not character_id then
    return
  end
  local cfg = M.create("role_shadow.role_edge_light", character_id)
  return cfg
end

function M.get_ring_id_by_point_id(point_id)
  local all_ring_config = ShareRes.get_curse_ring_config()
  for key, ring_config in pairs(all_ring_config) do
    if ring_config.EpisodeId == point_id then
      return ring_config.Id
    end
  end
end

function M.get_group_ai_cfg(id)
  return M.create("battle.behavior_ai", id)
end

function M.get_gem_lv_cfg(id)
  return M.create("equip.equip_gemstone_level", id)
end

function M.get_gem_lv_cfg_ex(id, lv)
  if not id or not lv then
    return
  end
  local get_gem_lv_cfg = M.get_gem_lv_cfg(id)
  if get_gem_lv_cfg then
    return get_gem_lv_cfg[lv]
  end
end

function M.get_gem_cfg(id)
  return M.create("equip.equip_gemstone", id)
end

function M.get_gem_icon_path(id)
  local cfg = M.create("equip.equip_gemstone", id)
  return string.format("Icon/Item/%s", cfg.Icon)
end

function M.get_gem_quality(id)
  local cfg = M.create("equip.equip_gemstone", id)
  return cfg.Quality
end

function M.get_chapter_node_sort_index(id)
  local index = M.create("chapter.chapter_node_sort_idx", id)
  return index
end

function M.get_action_sound_cfg(npc_id, action_name)
  local cfg = M.create("sound.action_sound", npc_id)
  if cfg then
    return cfg[action_name]
  end
end

function M.get_buddy_settle_param(buddy_id)
  local cfg = M.create("buddy.buddy_settle_param")[buddy_id]
  return cfg
end

function M.get_object_sound_cfg(object_name)
  local cfg = M.create("sound.object_sound", object_name)
  if cfg then
    return cfg
  else
    return {
      ObjectName = object_name,
      ObjectSoundName = object_name,
      FadeTime = 6,
      no_cfg = true
    }
  end
end

function M.get_scene_logic_config(logic_id)
  return M.create("scene_logic." .. logic_id)
end

function M.get_monster_group_config(group_id)
  return M.create("unit.MonsterGroup." .. group_id)
end

function M.get_machine_group_config(group_id)
  return M.create("unit.MachineGroup." .. group_id)
end

function M.get_signboard_girl_param(param_id, buddy_id, fashion_id)
  local all_cfg = M.create("signboard_girl.signboard_buddy_view_param")
  local fashion_param_cfg = fashion_id and all_cfg[fashion_id]
  if fashion_param_cfg and fashion_param_cfg[param_id] then
    return fashion_param_cfg[param_id]
  end
  local buddy_param_cfg = all_cfg[buddy_id]
  if buddy_param_cfg and buddy_param_cfg[param_id] then
    return buddy_param_cfg[param_id]
  end
  local default_buddy_param_cfg = all_cfg[0]
  return default_buddy_param_cfg[param_id]
end

function M.get_signboard_girl_reaction_cfg(react_type, buddy_id, fashion_id, check_empty)
  local all_cfg = M.create("signboard_girl.signboard_girl_action").CharAction
  local fashion_reaction_cfg = fashion_id and all_cfg[fashion_id]
  if fashion_reaction_cfg and fashion_reaction_cfg[react_type] then
    return fashion_reaction_cfg[react_type]
  end
  local buddy_reaction_cfg = all_cfg[buddy_id]
  if buddy_reaction_cfg and buddy_reaction_cfg[react_type] then
    return buddy_reaction_cfg[react_type]
  end
  if check_empty then
    Log.Error("无板反应配置，类型、角色id、时装id：", react_type, buddy_id, fashion_id)
  end
end

function M.get_char_model_id(buddy_id)
  local fashion_id = M.get_buddy_cfg(buddy_id).FashionInitId
  local fashion_cfg = M.get_fashion_cfg(fashion_id)
  return fashion_cfg.ModelId
end

function M.get_equip_user(equip_id)
  local equip_sub_type = M.get_equip(equip_id).SubType
  local buddy_map = M.create("buddy.buddy")
  for _, cfg in pairs(buddy_map) do
    if equip_sub_type == cfg.WeaponSubType then
      return cfg.Id
    end
  end
end

function M.get_camera_path_group_data(filename)
  return M.create("camera_track." .. filename)
end

function M.get_signboard_girl_track_table(key)
  return M.create("signboard_girl.camera_pathgroup_table", key)
end

function M.get_rec_shop_page_cfg()
  return M.create("recharge.recommond_shop_page")
end

function M.get_rec_shop_page_item_cfg(page_id)
  return M.create("recharge.recommond_shop_items", page_id)
end

function M.get_story_preheat_group_id_by_chapter_id(chapter_id)
  return M.create("chapter.story_preheat_group_chapter")[chapter_id]
end

function M.get_story_preheat_list_by_group_id(group_id)
  return M.create("chapter.story_preheat_to_group")[group_id]
end

function M.get_story_preheat_cfg(story_preheat_id)
  return M.create("chapter.story_preheat")[story_preheat_id]
end

function M.get_story_preheat_group_cfg(group_id)
  return M.create("chapter.story_preheat_group")[group_id]
end

function M.get_buddy_puzzle_cfg(puzzle_id)
  return M.create("buddy.buddy_puzzle")[puzzle_id]
end

function M.get_buddy_puzzle_refine_cfg(puzzle_id)
  local cfg = M.create("buddy.buddy_puzzle_refresh", puzzle_id)
  if not cfg then
    Log.Error("获取插件洗练消耗配置失败，插件id：", puzzle_id)
    return
  end
  return cfg
end

function M.get_buddy_puzzle_graph_hex_pos(graph_id, rotate)
  return M.create("buddy.buddy_puzzle_graph", graph_id)[rotate]
end

function M.get_buddy_puzzle_map_unlock_cfg(buddy_id)
  local cfg = M.create("buddy.buddy_puzzle_area_open", buddy_id)
  cfg = cfg or M.create("buddy.buddy_puzzle_area_open", 1010000)
  return cfg
end

function M.get_buddy_puzzle_map_unlock_cond(buddy_id)
  local cfg = M.get_buddy_puzzle_map_unlock_cfg(buddy_id)
  local condition = cfg and cfg.Condition[1] or 0
  return condition
end

function M.get_buddy_puzzle_graph_hex_pos_by_puzzle_id(puzzle_id, rotate)
  local graph_id = M.get_buddy_puzzle_cfg(puzzle_id).GraphID
  return M.create("buddy.buddy_puzzle_graph", graph_id)[rotate]
end

function M.get_buddy_puzzle_graph_show_list()
  local map = M.create("buddy.buddy_puzzle_graph_icon")
  local list = {}
  for _, data in pairs(map) do
    list[#list + 1] = data
  end
  table.sort(list, function(a, b)
    return a.Order < b.Order
  end)
  return list
end

function M.get_buddy_puzzle_graph_show_cfg(graph_id)
  if graph_id then
    return M.create("buddy.buddy_puzzle_graph_icon", graph_id)
  end
end

function M.get_buddy_puzzle_attr_cfg(attr_cfg_id)
  return M.create("buddy.buddy_puzzle_attr")[attr_cfg_id]
end

function M.get_buddy_puzzle_attr_show_cfg(attr_id)
  local cfgs = M.create("buddy.buddy_puzzle_attr_show")
  for _, cfg in ipairs(cfgs) do
    if cfg.AttrId == attr_id then
      return cfg
    end
  end
end

function M.get_buddy_puzzle_attr_show_list()
  local cfg = M.create("buddy.buddy_puzzle_attr_show")
  table.sort(cfg, function(a, b)
    return a.Order < b.Order
  end)
  return cfg
end

function M.get_buddy_puzzle_entry_cfg(entry_id, quality)
  local cfg = M.create("buddy.buddy_puzzle_entry")[entry_id]
  if not cfg then
    Log.Error("插件词条配置获取失败，词条Id：", entry_id)
    return
  end
  if not cfg[quality] then
    Log.Error("插件词条配置获取失败，词条Id、品质：", entry_id, quality)
    return
  end
  return cfg[quality]
end

function M.get_buddy_puzzle_entry_id_list()
  local cfg = M.create("buddy.buddy_puzzle_entry")
  local entry_id_map = {}
  local entry_id_list = {}
  for entry_id, v in pairs(cfg) do
    if not entry_id_map[entry_id] then
      entry_id_map[entry_id] = true
      entry_id_list[#entry_id_list + 1] = entry_id
    end
  end
  return entry_id_list
end

function M.get_buddy_puzzle_upLv_cfg(quality, graph_id)
  local cfg = M.create("buddy.buddy_puzzle_up_quality", quality)
  if cfg then
    return cfg[graph_id]
  end
end

function M.get_puzzle_map_idx(buddy_id, map_graph_id)
  local unlock_cfg = M.get_buddy_puzzle_map_unlock_cfg(buddy_id)
  for idx, graph_id in ipairs(unlock_cfg.GraphID) do
    if graph_id == map_graph_id then
      return idx
    end
  end
  Log.Error("插件地图获取失败，回传默认值1。buddy_id, map_graph_id：", buddy_id, map_graph_id)
  return 1
end

function M.get_recommend_puzzle_cfg(buddy_id, map_graph_id)
  local unlock_cfg = M.get_buddy_puzzle_map_unlock_cfg(buddy_id)
  local map_idx = 1
  for idx, graph_id in ipairs(unlock_cfg.GraphID) do
    if graph_id == map_graph_id then
      map_idx = idx
      break
    end
  end
  local recommend_id = unlock_cfg and unlock_cfg.RecommendID[map_idx]
  if recommend_id then
    return M.create("buddy.buddy_puzzle_recommend", recommend_id)
  end
end

function M.get_recommend_puzzle_suit_cfg(buddy_id, map_graph_id)
  local unlock_cfg = M.get_buddy_puzzle_map_unlock_cfg(buddy_id)
  local map_idx = 1
  for idx, graph_id in ipairs(unlock_cfg.GraphID) do
    if graph_id == map_graph_id then
      map_idx = idx
      break
    end
  end
  local recommend_suit_id = unlock_cfg and unlock_cfg.RecommendSuitID[map_idx]
  if recommend_suit_id then
    return M.create("buddy.buddy_puzzle_suit_recommend", recommend_suit_id)
  end
end

function M.get_curse_shop_cfg(shop_id)
  return M.create("activity.curse_new_shop")[shop_id]
end

function M.get_curse_shop_slot_cfg(slot_id)
  return M.create("activity.curse_slot_data")[slot_id]
end

function M.get_curse_shop_slot_cfg(slot_id)
  return M.create("activity.curse_slot_data")[slot_id]
end

function M.get_curse_option_cfgs_by_group_id(group_id)
  return M.create("activity.ability_options_group")[group_id]
end

function M.get_curse_option_cfg(option_id)
  return M.create("activity.curse_options")[option_id]
end

function M.get_curse_destiny_level_cfg()
  return M.create("activity.curse_destiny_level")
end

function M.get_curse_mini_game_cfg(id)
  return M.create("activity.curse_mini_game")[id]
end

function M.get_curse_mini_game_award_group_cfg(id)
  return M.create("activity.curse_mini_game_award_group")[id]
end

function M.get_first_recharge_award(id)
  return M.create("recharge.firse_recharge_award")[id].AwardId
end

function M.get_first_recharge_free_award()
  local cfg = M.create("recharge.firse_recharge_common_define")[1]
  if not cfg or 0 == cfg.RewardDay or 0 == cfg.RewardId then
    return
  end
  return cfg.RewardId
end

function M.get_pop_widget_cfg(id)
  return M.create("pop_widget.pop_widget")[id]
end

function M.get_stamina_warehouse_level_cfg(level)
  return M.create("building.building_stamina")[level]
end

function M.get_quality_setting_image_cfg(type)
  return M.create("setting.quality_setting_image")[type]
end

function M.get_quality_setting_option_cfg(level)
  return M.create("setting.quality_setting_option")[level]
end

function M.get_building_level_cfg(building_type, level)
  local cfg = M.create("building.building_level")
  if building_type then
    if level then
      return cfg[building_type] and cfg[building_type][level]
    end
    return cfg[building_type]
  end
  return cfg
end

function M.get_building_max_level(building_type)
  return #M.create("building.building_level")[building_type]
end

function M.get_building_cfg(building_type)
  local cfg = M.create("building.building")
  if building_type then
    return cfg[building_type]
  else
    return cfg
  end
end

function M.get_adventrue_task_cfg(task_id)
  return M.create("building.building_adventure_task")[task_id]
end

function M.get_adventrue_task_quality_cfg(quality)
  return M.create("building.building_adventure_task_quality")[quality]
end

function M.get_adventrue_task_quality_cfg_by_task_id(task_id)
  local task_cfg = ShareRes.get_adventrue_task_cfg(task_id)
  if task_cfg then
    return M.get_adventrue_task_quality_cfg(task_cfg.Quality)
  end
end

function M.get_factory_material_cfg(material_id)
  local cfg = M.create("building.building_factory_material")
  if material_id then
    return cfg[material_id]
  end
  return cfg
end

function M.get_factory_material_level_id_list(level)
  local cfg = M.create("building.factory_material_level_id_list", level)
  return cfg
end

function M.get_factory_cfg(factory_id)
  local cfg = M.create("building.building_factory")
  return cfg[factory_id]
end

function M.get_building_misc_cfg()
  return M.create("building.building_misc")
end

function M.get_building_model_cfg(model_id)
  local cfg = M.create("building.building_model")
  return cfg and cfg[model_id]
end

function M.get_photo_cfg(photo_id)
  if not photo_id or 0 == photo_id then
    return
  end
  return M.create("main_scene_video.chartlet")[photo_id]
end

function M.get_photo_path(photo_id)
  local cfg = M.get_photo_cfg(photo_id)
  return cfg and cfg.Path
end

function M.get_photo_max_width(photo_id)
  local cfg = M.get_photo_cfg(photo_id)
  return cfg and cfg.MaxWidth or 600
end

function M.get_photo_frame_idx(frame_id)
  if not frame_id or 0 == frame_id then
    return
  end
  local cfg = M.create("main_scene_video.chartlet_frame")[frame_id]
  return cfg and cfg.Index
end

function M.get_building_buddy_limit_cfg(limit_id)
  return M.create("building.building_buddy_limit")[limit_id]
end

function M.get_building_buddy_to_clue_cfg(buddy_id)
  return M.create("building.building_buddy_to_clue")[buddy_id]
end

function M.get_building_clue_cfg(clue_id)
  return M.create("building.building_clue", clue_id)
end

function M.get_building_combine_cfg(combine_id)
  return M.create("building.building_combine")[combine_id]
end

function M.get_building_adventure_type(adventure_type)
  return M.create("building.building_adventure_type")[adventure_type]
end

function M.get_shadow_offset_cfg(role_id, uiname)
  if not role_id then
    return
  end
  local shadow_cfg = M.create("role_shadow.role_shadow_offset")
  if shadow_cfg and shadow_cfg[role_id] then
    return shadow_cfg[role_id][uiname]
  end
end

function M.get_buddy_tryout_cfg(id)
  if id then
    return M.create("activity.buddy_probation", id)
  end
end

function M.get_spline_file(file_path)
  return M.create("splines." .. file_path)
end

function M.get_terrain_sound_cfg(sound_name)
  return M.create("sound.terrain_sound", sound_name)
end

function M.get_usm_video_cfg(video_name)
  return M.create("sound.usm_video", video_name)
end

function M.get_shake_curve_value_lut(curve_name)
  return M.create("shake.curvevaluelut")[curve_name]
end

function M.get_shake_preset_data(preset_name)
  return M.create("shake.presetdata").presetDic[preset_name]
end

function M.get_ornament_desc_magic(magic_id)
  local cfg = M.create("item.ornament_desc_magic_map")
  return cfg and cfg[magic_id]
end

function M.get_character_preload_role_effect_list(character_id)
  local cfg = M.create("character.character_preload")
  return cfg and cfg.RoleEffect and cfg.RoleEffect[character_id]
end

function M.get_character_preload_scene_effect_list(character_id)
  local cfg = M.create("character.character_preload")
  return cfg and cfg.SceneEffect and cfg.SceneEffect[character_id]
end

function M.get_character_preload_indicator_list(character_id)
  local cfg = M.create("character.character_preload")
  return cfg and cfg.SkillIndicator and cfg.SkillIndicator[character_id]
end

function M.get_character_preload_common_effect_list()
  local cfg = M.create("character.character_preload")
  return cfg and cfg.CommonRoleEffect and cfg.CommonRoleEffect[0], cfg and cfg.CommonSceneEffect and cfg.CommonSceneEffect[0]
end

function M.get_character_preload_collider_type_list(character_id)
  local cfg = M.create("character.character_preload")
  return cfg and cfg.ColliderType and cfg.ColliderType[character_id]
end

function M.get_character_preload_hit_effect_list(character_id)
  local cfg = M.create("character.character_preload")
  return cfg and cfg.RoleHitEffect and cfg.RoleHitEffect[character_id]
end

function M.get_character_model_extra_preload_effect_list(model_id)
  local is_exist = M.is_exist_config("preload.timeline_preload")
  if is_exist then
    local cfg = M.create("preload.timeline_preload")
    return cfg and cfg[model_id]
  end
end

function M.get_info_tips_cfg(id)
  return M.create("tips.info_tips")[id]
end

function M.get_recharge_welfare_range_cfg()
  return M.create("activity.recharge_welfare_range")
end

function M.get_recharge_welfare_const_cfg(id)
  return M.create("activity.recharge_welfare_const")[id].Value
end

function M.get_level_welfare_cfg()
  return M.create("activity.level_welfare")
end

function M.get_monthly_card_tips_cfg()
  return M.create("recharge.monthly_card_tips")
end

function M.get_capsule_toys_cfg()
  return M.create("recharge.capsule_toys")
end

function M.get_capsule_toys_quality_cfg(item_id)
  return M.create("recharge.item_capsule_toys_quality")[item_id]
end

function M.get_curse_equation_group_cfg(group_id)
  return M.create("activity.curse_equation_group")[group_id]
end

function M.get_curse_equation_cfg(equation_id)
  return M.create("activity.curse_equation")[equation_id]
end

function M.get_curse_equation_branch_cfg(branch_id, level)
  local cfg = M.create("activity.curse_equation_branch")[branch_id]
  if level then
    return cfg and cfg[level]
  end
  return cfg
end

function M.get_curse_equation_branch_max_level(branch_id)
  local cfg = M.get_curse_equation_branch_cfg(branch_id)
  return cfg and #cfg or 0
end

function M.get_boss_fight_cfg(id)
  local cfg = M.create("chapter.boss_fight")[id]
  return cfg
end

function M.get_boss_fight_episode_cfg(episode_id)
  local cfg = M.create("chapter.boss_fight_episode_base")[episode_id]
  return cfg
end

function M.get_boss_fight_episode_map(challenge_id)
  local cfg = M.create("chapter.boss_fight_episode")[challenge_id]
  return cfg
end

function M.get_buddy_combo_cfg(combo_id)
  local cfg = M.create("buddy.buddy_combo_table")[combo_id]
  return cfg
end

function M.get_loading_tips_cfg(group_id)
  local cfg = M.create("loading.loading")[group_id]
  if cfg then
    return cfg
  end
end

function M.get_loading_tips_group_cfg(group_id)
  local cfg = M.create("loading.loading_group")[group_id]
  if cfg then
    return cfg
  end
end

function M.get_weapon_fashion_cfg(fashion_id)
  local cfg = M.create("equip.equip_fashion")[fashion_id]
  return cfg
end

function M.get_weapon_fashion_id_by_subtype(sub_type)
  local cfg = M.create("equip.equip_fashion_map")[sub_type]
  return cfg
end

function M.get_gold_equip_cfg(activity_id)
  local cfg = M.create("activity.gold_equip")[activity_id]
  return cfg
end

function M.get_gold_equip_group_cfg(group_id)
  local cfg = M.create("activity.gold_equip_group")[group_id]
  return cfg
end

function M.get_gold_equip_single_group_cfg(group_id, weapon_id)
  local cfg = M.create("activity.gold_equip_group")[group_id]
  if cfg then
    return cfg[weapon_id]
  end
end

function M.get_monkey_typer_question_cfg(activity_id, question_id)
  local cfg = M.create("activity.monkey_typewriter_question")[activity_id]
  if cfg then
    return cfg[question_id]
  end
end

function M.get_monkey_typer_upgrade_cfg(activity_id, type)
  local cfg = M.create("activity.monkey_typewriter_upgrade")[activity_id]
  if cfg then
    return cfg[type]
  end
end

function M.get_double_challenge_cfg(activity_id)
  local cfg = M.create("activity.double_challenge")[activity_id]
  return cfg
end

function M.get_fight_layout_config(index)
  local cfg = M.create("fight_layout.fight_layout")
  if not index then
    return cfg
  end
  return cfg[index]
end

function M.get_lipsync_data(sound_name)
  local cfg = M.create("sound.lipsync_data")
  if cfg then
    return cfg[sound_name]
  end
end

function M.get_notice_txt_by_id(id)
  local cfg = M.create("notice.notice_language")
  if not cfg[id] then
    Log.Error("未找到公告多语言文本，id:", id)
  elseif not cfg[id][Global.curr_text_language] then
    Log.Error("未找到公告多语言文本，id:", id, Global.curr_text_language)
  else
    return cfg[id][Global.curr_text_language]
  end
end

function M.get_egg_cfg(egg_id)
  local cfg = M.create("egg.egg")
  return cfg and cfg[egg_id]
end

function M.get_puzzle_game_cfg(stage_id)
  local cfg = M.create("activity.puzzle_game_episode")
  return cfg and cfg[stage_id]
end

function M.get_puzzle_game_graph_cfg(graph_id)
  local cfg = M.create("activity.puzzle_game_graph")
  return cfg and cfg[graph_id]
end

function M.get_music_game_act_cfg(activity_id)
  local cfg = M.create("activity.music_mini_game")
  return cfg and cfg[activity_id]
end

function M.get_music_game_chapter_cfg(chapter_id)
  local cfg = M.create("activity.music_mini_game_chapter")
  return cfg and cfg[chapter_id]
end

function M.get_puzzle_game_stage_cfg(stage_id)
  local cfg = M.create("activity.music_mini_game_episode")
  return cfg and cfg[stage_id]
end

function M.get_time_scheme_cfg(scheme_id, time_key)
  local cfgs = M.create("time.time_scheme")
  local scheme_cfg = cfgs and cfgs[scheme_id]
  if not scheme_cfg then
    Log.Error("时间方案配置不存在，ID：", scheme_id, debug.traceback())
    return
  end
  return scheme_cfg[time_key]
end

function M.get_skin_tryout_cfg(activity_id)
  local cfg = M.create("activity.buddy_fashion_probation")
  return cfg and cfg[activity_id]
end

function M.get_quantum_camera_cfg(id)
  local cfg = M.create("quantum.quantum_camera_cfg")
  return cfg and cfg[id]
end

function M.get_index_map_by_fashion_id(fashion_id)
  local index_map = M.create("resource_map.index_map")
  return index_map and index_map[fashion_id]
end

function M.get_effect_map_by_fashion_id(origin_name, fashion_id)
  if not fashion_id then
    return origin_name
  end
  local index = M.get_index_map_by_fashion_id(fashion_id)
  if not index then
    return origin_name
  end
  local cfg = M.create("resource_map.effect_map")
  return cfg and cfg[origin_name] and cfg[origin_name][index] or origin_name
end

function M.get_sound_map_by_fashion_id(origin_name, fashion_id)
  if not fashion_id then
    return origin_name
  end
  local index = M.get_index_map_by_fashion_id(fashion_id)
  if not index then
    return origin_name
  end
  local cfg = M.create("resource_map.sound_map")
  return cfg and cfg[origin_name] and cfg[origin_name][index] or origin_name
end

function M.get_skill_keyframe_cfg(skill_id)
  local cfg = M.create("skill.skillkeyframe")
  return cfg and cfg[skill_id]
end

function M.get_curse_save_cfg(save_id)
  local cfg = M.create("activity.curse_save")
  if save_id then
    return cfg and cfg[save_id]
  end
  return cfg
end

function M.get_scene_skill_level_cfg(skill_id)
  local cfg = M.create("battle.scene_skill_level")
  if skill_id then
    return cfg and cfg[skill_id]
  end
  return cfg
end

function M.get_gift_shop_cfg(gift_id)
  local cfg = M.create("recharge.gift_shop")
  if gift_id then
    return cfg and cfg[gift_id]
  end
  return cfg
end

function M.get_return_activity_sign_award()
  local cfg = M.create("activity.flyback_sign_in")
  return cfg
end

function M.get_return_activity_sign_spine()
  local cfg = M.create("activity.flyback_sign_in_spine")
  return cfg
end

function M.get_return_activity_gift()
  local cfg = M.create("activity.flyback_gift")
  return cfg
end

function M.get_return_activity_task(day_id)
  local cfg = M.create("activity.flyback_daily_task", day_id)
  return cfg
end

function M.get_return_activity_hold_task()
  local cfg = M.create("activity.flyback_misc")
  return cfg
end

function M.get_return_activity_new_cfg()
  local cfg = M.create("activity.flyback_new_act")
  return cfg
end

function M.get_return_activity_new_cfg()
  local cfg = M.create("activity.flyback_new_act")
  return cfg
end

function M.get_return_activity_main_view_cfg(act_id)
  local cfg = M.create("activity.flyback_main_view_act", act_id)
  return cfg
end

function M.get_return_activity_task_progress()
  local cfg = M.create("activity.flyback_task_progress")
  return cfg
end

function M.get_map_env_bgm(scene_name, light_idx)
  if nil == scene_name or nil == light_idx then
    return
  end
  local cfg = M.create("sound.map_env_sound", scene_name)
  if cfg then
    return cfg[light_idx]
  end
end

function M.get_minigame_list_by_acid(activity_id)
  local cfg = M.create("activity.activity_mini_game_episode")
  if not cfg then
    return
  end
  local minigame_cfg_list = {}
  for _, minigame_cfg in pairs(cfg) do
    if minigame_cfg.ActivityId == activity_id then
      _insert(minigame_cfg_list, minigame_cfg)
    end
  end
  return minigame_cfg_list
end

function M.get_item_reset_develop_list(item_id)
  local cfg = M.create("item.item_reset_develop")[item_id]
  return cfg and cfg.IDList
end

function M.get_item_combine_alias(target_id)
  local cfg = M.create("item.item_combine_alias")[target_id]
  return cfg
end

function M.get_curse_destiny_level_select_drop(destiny_id)
  local cfg = M.create("activity.curse_destiny_level_select_drop")[destiny_id]
  return cfg
end

function M.get_time_limited_activity_detail(activity_id)
  local cfg = M.create("activity.time_limited_activity_detail")
  local t = {}
  local prebodytryout_id = -1
  for _, value in pairs(cfg) do
    if value.ActivityId == activity_id then
      if value.Type == TimeLimitedActMgr.Type.CharTryout then
        local data = BuddyTryoutMgr:get_buddy_data(tonumber(value.Param[2]))
        if data and prebodytryout_id < value.Id then
          t[value.Node] = value
          prebodytryout_id = value.Id
        end
      else
        t[value.Node] = value
      end
    end
  end
  return t
end

function M.get_fish_game_stage_list()
  local cfg = M.create("activity.fish_game_stage")
  return cfg
end

function M.get_fish_game_stage_by_id(stage_id)
  local cfg = M.create("activity.fish_game_stage")[stage_id]
  return cfg
end

function M.get_fish_game_task()
  local cfg = M.create("activity.fish_game")
  return cfg
end

function M.get_fish_game_fishtool()
  local cfg = M.create("activity.fish_game_fishtool")
  return cfg
end

function M.get_fish_game_item()
  local cfg = M.create("activity.fish_game_item")
  return cfg
end

function M.get_fish_game_stage_item_cfg()
  local cfg = M.create("activity.fish_game_stage_cnt")
  return cfg
end

function M.get_fish_game_emj_cfg()
  local cfg = M.create("activity.fish_game_face")
  return cfg
end

function M.get_fish_game_cond_cfg(cond_id)
  local cfg = M.create("activity.fish_game_cond")[cond_id]
  return cfg
end

function M.get_fish_game_fish_game_cfg(act_id)
  local cfg = M.create("activity.fish_game")[act_id]
  return cfg
end

function M.get_liveness_gift_cfg(id)
  local cfg = M.create("recharge.liveness_gift")[id]
  return cfg
end

function M.get_minesweeper_chaptergroup_cfg(group_id)
  local cfg = M.create("minesweeper.minesweeper_chapter")
  local result = {}
  for k, value in pairs(cfg) do
    if value.GroupId == group_id then
      _insert(result, value)
    end
  end
  return result
end

function M.get_minesweeper_bless_cfg(bless_id)
  local cfg = M.create("minesweeper.minesweeper_bless")
  return (cfg or E)[bless_id]
end

function M.get_minesweeper_bless_quality_cfg(bless_quality_id)
  local cfg = M.create("minesweeper.minesweeper_bless_quality")
  return (cfg or E)[bless_quality_id]
end

function M.get_ponder_maze_activity_cfg(activity_id)
  local cfg = M.create("activity.ponder_maze_activity")[activity_id]
  return cfg
end

function M.get_ponder_maze_point_cfg(point_id)
  local cfg = M.create("activity.ponder_maze_point")[point_id]
  return cfg
end

function M.get_ponder_maze_map_cfg(map_id)
  local cfg = M.create("activity.ponder_maze_map")[map_id]
  return cfg
end

function M.get_ponder_maze_clue_cfg(clue_id)
  local cfg = M.create("activity.ponder_maze_clue")[clue_id]
  return cfg
end

function M.get_ponder_maze_node_thought_cfg(thought_id)
  local cfg = M.create("activity.ponder_maze_node_thought")[thought_id]
  return cfg
end

function M.get_ponder_maze_node_library_cfg(library_id, serial_num)
  local cfg = M.create("activity.ponder_maze_node_library")[library_id]
  if serial_num then
    return cfg and cfg[serial_num] or nil
  end
  return cfg
end

function M.get_ponder_maze_node_cfg(serial_num)
  local cfg = M.create("activity.ponder_maze_node")[serial_num]
  return cfg
end

function M.get_ponder_maze_node_event_cfg(event_id)
  local cfg = M.create("activity.ponder_maze_node_event")[event_id]
  return cfg
end

function M.get_ponder_maze_node_option_cfg(option_id)
  local cfg = M.create("activity.ponder_maze_node_option")[option_id]
  return cfg
end

function M.get_ponder_cfg(ponder_id)
  local cfg = M.create("activity.ponder", ponder_id)
  return cfg
end

function M.get_ponder_maze_story_cfg(story_id)
  local cfg = M.create("activity.ponder_maze_story", story_id)
  return cfg
end

function M.get_minesweeper_misc()
  return M.create("minesweeper.minesweeper_misc")[1]
end

function M.get_minesweeper_grid_cfg(grid_id)
  return M.create("minesweeper.minesweeper_grid")[grid_id]
end

function M.get_minesweeper_grid_type(grid_id)
  if 0 == grid_id then
    return MineSweeperMgr.GRID_TYPE.EMPTY
  else
    return M.get_minesweeper_grid_cfg(grid_id).Type
  end
end

function M.get_minesweeper_shop_item_list(shop_id)
  return M.create("minesweeper.minesweeper_shop")[shop_id]
end

function M.get_minesweeper_floor_monster_level_cfg(chapter_id, floor_idx, tower_id)
  return M.create("minesweeper.minesweeper_floor_monster_level")[chapter_id][floor_idx][tower_id]
end

return M
