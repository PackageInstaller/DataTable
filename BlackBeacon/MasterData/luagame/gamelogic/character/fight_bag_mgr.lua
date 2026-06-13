local Base = require("gamelogic.base_system")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local FightCalc = require("cs_share.fight_calc")
local FightDefine = require("cs_share.fight_define")
local CommonDefine = require("cs_share.common_define")
local Fight_Item_Helper = require("uimodule.fight_bag.fight_item_helper")
local AttrSyncHelper = require("uimodule.fight_bag.sync_attr_helper")
local Item_Helper = require("utils.item_helper")
local BloodHelper = require("uimodule/fight/blood_helper")
local Seri = require("seri")
local MagicDef = require("cs_share.magic_def")
local MAGIC_TYPE = MagicDef.MAGIC_TYPE
local BUFF_TYPE = CommonDefine.BUFF_TYPE
local RUNE2_SOURCE = CommonDefine.RUNE2_SOURCE
local M = Util.create_child_mt(Base)
local _tinsert = table.insert
local SUIT_LIST = {
  [1] = {
    2,
    4,
    "TwoPieceMagic"
  },
  [2] = {
    4,
    6,
    "FourPieceMagic"
  }
}
local ATTR_TYPE = FightDefine.ATTR_TYPE
local ITEM_PAGE_POINT = 29

function M:init_sys()
  Base.init_sys(self)
  self.v_res_list = {}
  self.v_last_item_count_list = {}
  self.v_type_item_map = {}
  self.v_uuid_item_list = {}
  self.v_id_item_map = {}
  self.cur_equip_attrs = {}
  self.v_collect_magic_list = {}
  self.v_item_random_entries = {}
  self.v_drop_queue = {}
  self.v_senior_drop_queue = {}
  self.fight_item_cfg = ShareRes.create("battle.battle_item")
  self.ornament_cfg = ShareRes.create("item.ornaments")
  self.fight_equip_cfg = ShareRes.create("battle.battle_equip")
  self.v_bag_type_cfg = ShareRes.create("battle.battle_item_bag_type")
  self.v_collect_item_cfg = ShareRes.create("battle.battle_collection")
  self.v_element_entries = ShareRes.create("entry.battle_magic_entry")
  self:sys_mq_bind(Const.MSG_ON_FIRST_ENTER_BATTLE_FIELD, self.response_create_fight_event, self)
  self:sys_mq_bind(Const.MSG_ON_ENTER_ROOM, self.response_enter_room_event, self)
  self:sys_mq_bind(Const.MSG_ON_HERO_ITEM_HIDE, self.response_hero_item_hide, self)
  self.v_force_use_bag = false
  self.v_has_displayed = false
  self.v_item_buffs = {}
  self.v_buff_type_map = {}
  self.v_currency_add_list = {}
  self.v_blood_add_list = {}
  self.v_new_item_list = {}
  self.v_heal_hero_list = {}
  self.v_cur_chapter_item_data = nil
  self.v_last_chapter_item_data = nil
  self.unlock_item_count = 0
end

function M:on_reconnect()
  self.v_res_list = {}
  self.v_type_item_map = {}
  self.v_uuid_item_list = {}
  self.v_id_item_map = {}
  self.cur_equip_attrs = {}
  for k, v in pairs(self.v_collect_magic_list) do
    local item = self.v_id_item_map[k][1]
    self:_set_heros_magic(item.Cfg.Arg[1], true, true)
  end
  self.v_collect_magic_list = {}
  AttrSyncHelper.clear()
  self.v_drop_queue = {}
  self.v_senior_drop_queue = {}
end

function M:response_create_fight_event(msg)
  self:_set_all_attrs(true)
  self:_set_all_magic()
end

function M:response_enter_room_event(msg)
  self.v_force_use_bag = false
end

function M:on_get_item_list(data)
  self.v_uuid_item_list = {}
  UtilTable.clear_map(self.v_type_item_map)
  UtilTable.clear_map(self.v_id_item_map)
  for _, bagData in pairs(data.bags) do
    if not self.v_type_item_map[bagData.bag_type] then
      self.v_type_item_map[bagData.bag_type] = {}
    end
    for _, item in pairs(bagData.items) do
      self.v_last_item_count_list[item.id] = self:get_item_num_by_id(item.id)
      local itemObj = self:_build_item_obj(bagData.bag_type, item)
      itemObj.bag_type = bagData.bag_type
      _tinsert(self.v_type_item_map[bagData.bag_type], itemObj)
      self.v_uuid_item_list[itemObj.uuid] = itemObj
      self:_add_to_item_list(itemObj)
      self:_after_res_update(itemObj)
      self.v_new_item_list[itemObj.uuid] = item.is_new
    end
  end
  self.v_res_list = {}
  local list = CharacterMgr:get_virtural_list()
  if nil ~= list then
    for _, v in pairs(BagCfg.CURRENCY) do
      list[v] = 0
    end
  end
  for k, v in pairs(data.res_list) do
    self.v_res_list[v.id] = v.count
    self.v_last_item_count_list[v.id] = v.count
    list[v.id] = v.count
  end
  self:_set_all_attrs(true)
  self:_set_all_magic()
  AttrSyncHelper.set_finish(true)
  self.v_item_random_entries = Seri.unpack(data.pack_ran_ans)
  self:_set_new_item_redpoint()
  MsgGame:mq_publish2(Const.MSG_ON_FIGHT_BAG_INIT)
end

function M:on_items_update(data)
  local items = self.v_type_item_map[data.bag_type]
  local add_list = {}
  for _, item in pairs(data.items) do
    self.v_last_item_count_list[item.id] = self:get_item_num_by_id(item.id)
    local has = false
    local itemObj
    if self.v_uuid_item_list[item.uuid] == nil then
      itemObj = self:_build_item_obj(data.bag_type, item)
      itemObj.bag_type = data.bag_type
      self.v_uuid_item_list[item.uuid] = itemObj
    else
      has = true
      itemObj = self.v_uuid_item_list[item.uuid]
      self:_sync_item_data(itemObj, item)
    end
    if nil ~= items and false == has then
      _tinsert(items, itemObj)
    end
    _tinsert(add_list, itemObj)
    if false == has then
      self:_add_to_item_list(itemObj)
    end
    if data.bag_type == BagCfg.BagType.ITEM and itemObj.Cfg.Auto_Use then
      self:request_use_item(Global.hero, itemObj, itemObj.count)
    end
    self.v_new_item_list[item.uuid] = item.is_new
    self:_after_res_update(item)
  end
  if #add_list > 0 then
    self:_set_all_attrs()
    for _, itemObj in pairs(add_list) do
      if itemObj.bag_type == BagCfg.BagType.COLLECT then
        local collect_type_list = itemObj.Cfg.EffectType
        if UtilTable.contains(collect_type_list, CommonDefine.COLLECTION_EFFECT_TYPE.MAGIC_LIST) then
          self:_set_collect_magic(itemObj)
        end
      end
    end
  end
  self:_set_new_item_redpoint()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_FIGHT_BAG_UPDATE)
  msg.mm_obj = data
end

function M:on_item_delete(data)
  local items = self.v_type_item_map[data.bag_type]
  if not items then
    Log.Error("背包数据中没有该类型的背包 type = ", data.bag_type)
    return
  end
  local itemObj = self.v_uuid_item_list[data.uuid]
  self.v_uuid_item_list[data.uuid] = nil
  self.v_new_item_list[data.uuid] = nil
  for k, item_info in pairs(items) do
    if item_info.uuid == itemObj.uuid then
      table.remove(items, k)
      break
    end
  end
  local list = self.v_id_item_map[itemObj.id]
  if nil ~= list then
    UtilTable.list_delete_by_value(list, itemObj)
    if 0 == #list then
      self.v_id_item_map[itemObj.id] = nil
    end
  end
  if data.bag_type == BagCfg.BagType.COLLECT then
    self:_set_all_collects_attrs()
    local collect_type_list = itemObj.Cfg.EffectType
    if UtilTable.contains(collect_type_list, CommonDefine.COLLECTION_EFFECT_TYPE.MAGIC_LIST) then
      self:_set_collect_magic(itemObj, true)
    end
  else
    self:_set_all_attrs()
  end
  self:_set_new_item_redpoint()
  local msg2 = MsgGame:mq_publish2(Const.MSG_ON_FIGHT_BAG_UPDATE)
  msg2.mm_obj = data
end

function M:on_wear_info_update(data)
end

function M:on_wear_info_list(data)
end

function M:on_res_update(data)
  self:_calc_currecy_add_list(data)
  self.v_last_item_count_list[data.id] = self.v_res_list[data.id]
  self.v_res_list[data.id] = data.count
  CharacterMgr:get_virtural_list()[data.id] = data.count
  MsgGame:mq_publish2(Const.MSG_ON_FIGHT_DIAMOND_UPDATE)
  self:_after_res_update(data)
end

function M:_after_res_update(data)
  if Config.NEED_SHOW_DROP_TIPS_ITEM[data.id] and data.count > 0 and self:get_last_fight_res_by_id(data.id) ~= data.count and not SceneMgr:check_main_scene() then
    local ui = UIMgr:get_ui("common_battle_tips")
    local drop_data = {
      item_id = data.id
    }
    if ui:visible() then
      ui:drop_data_enqueue(drop_data)
    else
      local show_data = {drop_data = drop_data}
      ui:ui_show(show_data)
    end
  end
end

function M:on_battle_drop_list(data)
  for k, v in pairs(data.item_list) do
    local item_cfg = self:get_cfg_by_id(v.id)
    local insert_data = {
      id = v.id,
      count = v.count,
      cfg = item_cfg
    }
    if not item_cfg.UseSeniorShow then
      _tinsert(self.v_drop_queue, insert_data)
    else
      _tinsert(self.v_senior_drop_queue, insert_data)
    end
  end
  table.sort(self.v_drop_queue, function(a, b)
    local is_equip_a = self:get_is_collect_by_id(a.id) and 1 or 0
    local is_equip_b = self:get_is_collect_by_id(b.id) and 1 or 0
    if is_equip_a == is_equip_b then
      return a.cfg.Quality > b.cfg.Quality
    else
      return is_equip_a > is_equip_b
    end
  end)
  for _, drop_data in ipairs(self.v_senior_drop_queue) do
    Util.show_pop_text(nil, true, drop_data)
  end
  UtilTable.clear_list(self.v_drop_queue)
  UtilTable.clear_list(self.v_senior_drop_queue)
end

function M:on_open_floor_preview(data)
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  tower:on_open_floor_preview(data)
  self:get_need_display_map()
  MsgGame:mq_publish2(Const.MSG_ON_FIGHT_BAG_UPDATE)
end

function M:on_random_ans_update(data)
  self.v_item_random_entries = Seri.unpack(data.pack_data)
end

function M:on_battle_buff_list(data)
  self.v_item_buffs = {}
  self.v_add_attr_list_by_buff = {}
  local has_attr_change = false
  for _, buff in pairs(data.buff_list) do
    local cfg = ShareRes.create("battle.battle_buff", buff.id)
    buff.buff_cfg = cfg
    self.v_item_buffs[buff.uuid] = buff
    self.v_buff_type_map[cfg.Type] = self.v_buff_type_map[cfg.Type] or {}
    self.v_buff_type_map[cfg.Type][buff.uuid] = buff
    if cfg.Type == BagCfg.ITEM_BUFF_TYPE.JOB_ATTR_ALIGNMENT then
      has_attr_change = true
    end
    self:set_buff(cfg, buff)
    BuffMgr:set_buff_effect(buff)
  end
  if next(self.v_add_attr_list_by_buff) then
    AttrSyncHelper.sync_module_attrs(CommonDefine.MODULE_ATTR_TYPE.BUFF, self.v_add_attr_list_by_buff)
  end
  if has_attr_change then
    self:_set_all_attr_item_attrs()
  end
  BuffMgr:update_battle_buff_list()
end

function M:set_buff(buff_cfg, buff)
  if buff_cfg.Type == BUFF_TYPE.ADD_ATTR then
    if self.v_add_attr_list_by_buff then
      for index = 1, #buff.arg, 3 do
        local attr_id = buff.arg[index].value
        local attr_value = buff.arg[index + 1].value
        local set_type = buff.arg[index + 2] and buff.arg[index + 2].value or 0
        local attr = self.v_add_attr_list_by_buff[attr_id]
        if not attr then
          attr = FightDefine.init_single_attr()
          self.v_add_attr_list_by_buff[attr_id] = attr
        end
        if 0 == set_type then
          attr.FIXED = attr.FIXED + attr_value
        else
          attr.RATIO = attr.RATIO + attr_value
        end
      end
    end
  elseif buff_cfg.Type == BUFF_TYPE.ADD_CURSE_TIME_AND_VAL_RATIO then
    ChallengeRingPlusMgr:per_interval_add_curse_ratio(buff.arg[2].value, buff.uuid, buff.state)
    ChallengeRingPlusMgr:add_curse_interval_ratio(buff.arg[1].value, buff.uuid, buff.state)
  elseif buff_cfg.Type == BUFF_TYPE.ADD_CURSE_INTERVAL_TIME then
    ChallengeRingPlusMgr:add_curse_interval_value(buff.arg[1].value, buff.uuid, buff.state)
  end
end

function M:on_battle_buff_info(data)
  local buff = data.buff
  if 0 == buff.round_count and 0 ~= buff.state then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_BUFF_ROUND_COUNT_ZERO)
    msg.mm_x = buff
  end
  local old_buff = self.v_item_buffs[buff.uuid]
  if old_buff and old_buff.state == buff.state and old_buff.level == buff.level then
    if old_buff.round_count ~= buff.round_count then
      old_buff.round_count = buff.round_count
    end
    return
  end
  local cfg = ShareRes.create("battle.battle_buff", buff.id)
  buff.buff_cfg = cfg
  local has_attr_change = buff.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.JOB_ATTR_ALIGNMENT
  if 0 == buff.state then
    self.v_item_buffs[buff.uuid] = nil
    if self.v_buff_type_map[cfg.Type] then
      self.v_buff_type_map[cfg.Type][buff.uuid] = nil
    end
    BuffMgr:remove_buff(buff)
    return
  else
    self.v_item_buffs[buff.uuid] = buff
    self.v_buff_type_map[cfg.Type] = self.v_buff_type_map[cfg.Type] or {}
    self.v_buff_type_map[cfg.Type][buff.uuid] = buff
  end
  self:set_buff(cfg, buff)
  BuffMgr:set_buff_effect(buff)
  if has_attr_change then
    self:_set_all_attr_item_attrs()
  end
  BuffMgr:update_battle_buff_list()
end

function M:request_use_item(hero, item_data, num, callback, skipFloatTxt)
  local send_data = {
    item_list = {
      {
        uuid = item_data.uuid,
        count = num
      }
    },
    hero_uuid = hero.uuid
  }
  Network:call("c2gs_use_battle_items", send_data, function(ok, resp)
    if true == ok then
      if skipFloatTxt then
        BloodHelper.ignore(true)
      end
      
      local function cb(hero, item_id, num)
        self:_calc_blood_item_add_list(hero, item_id, num)
      end
      
      local param = {hero = hero, cb = cb}
      Fight_Item_Helper.add_use_effect(item_data.id, num, param)
      if skipFloatTxt then
        BloodHelper.ignore(false)
      end
    end
    if callback then
      callback()
    end
    self.v_has_used_item = true
  end)
end

function M:request_read_new_item(item_id, uuid, callback)
  if not self.v_new_item_list[uuid] then
    return
  end
  Network:call("c2gs_read_new_item", {item_id = item_id, uuid = uuid}, function(ok, resp)
    if ok then
      self.v_new_item_list[uuid] = false
      self:_set_new_item_redpoint()
      MsgGame:mq_publish2(Const.MSG_ON_FIGHT_BAG_UPDATE)
      if callback then
        callback()
      end
    end
  end)
end

function M:request_operate_equip_item(proto_name, args, is_need, cb)
  local send_data = {
    proto_name = proto_name,
    pack_args = Seri.packstring(args),
    is_need = is_need
  }
  Network:call("c2gs_replace_collection_item", send_data, function(ok, resp)
    if ok and cb then
      local data = Seri.unpack(resp.pack_args)
      cb(data, ok, resp)
    end
  end)
end

function M:get_had_item_by_id(id)
  return self.v_id_item_map[id]
end

function M:get_had_item_by_uuid(uuid)
  return self.v_uuid_item_list[uuid]
end

function M:get_cfg_by_id(id)
  local cfg = self.v_collect_item_cfg[id]
  if nil ~= cfg then
    return cfg
  end
  cfg = self.fight_item_cfg[id]
  if nil ~= cfg then
    return cfg
  end
  cfg = self.ornament_cfg[id]
  if nil ~= cfg then
    return cfg
  end
  Log.Error("当前id的配置不存在，请检查！！id = ", id)
end

function M:get_item_by_uuid(uuid)
  if self.v_uuid_item_list[uuid] == nil then
    Log.Error("当前物品不存在于背包，请检查！！， uuid = ", uuid, "", debug.traceback())
    return
  end
  return self.v_uuid_item_list[uuid]
end

function M:get_item_by_id(item_id)
  if self.v_id_item_map[item_id] == nil then
    Log.Error("当前物品不存在于背包，请检查！！， item_id = ", item_id, "", debug.traceback())
    return
  end
  return self.v_id_item_map[item_id][1]
end

function M:get_item_num_by_id(item_id)
  local list = self.v_id_item_map[item_id]
  if nil == list then
    return 0
  end
  local num = 0
  for i = 1, #list do
    num = num + list[i].count
  end
  return num
end

function M:get_grid_stack_num(uuid)
  local data = self.v_uuid_item_list[uuid]
  if nil == data then
    return 0
  end
  return data.count
end

function M:get_bag(bag_type)
  local data = self.v_type_item_map[bag_type]
  if nil == data then
    return {}
  end
  return data
end

function M:get_bag_capacity(bagType)
  return BagCfg.MAX_CAPACITY[bagType]
end

function M:get_used_capacity(bagType)
  local num = 0
  if self.v_type_item_map[bagType] == nil then
    return num
  end
  for _, v in pairs(self.v_type_item_map[bagType]) do
    num = num + 1
  end
  return num
end

function M:get_is_consumable(id)
  return Item_Helper.get_is_consume(id)
end

function M:get_is_collect_by_uuid(uuid)
  local data = self.v_uuid_item_list[uuid]
  if nil == data then
    Log.Error("当前物品不存在于背包，请检查！！， uuid = ", uuid, "", debug.traceback())
    return
  end
  return data.bag_type == BagCfg.BagType.COLLECT
end

function M:get_is_collect_by_id(id)
  return Item_Helper.get_is_collect(id)
end

function M:get_is_item_by_uuid(uuid)
  local data = self.v_uuid_item_list[uuid]
  if nil == data then
    Log.Error("当前物品不存在于背包，请检查！！， uuid = ", uuid, "", debug.traceback())
    return
  end
  return data.bag_type == BagCfg.BagType.ITEM
end

function M:get_is_item_by_id(id)
  local data = self.v_id_item_map[id]
  if nil ~= data and nil ~= data[1] then
    return data[1].bag_type == BagCfg.BagType.ITEM
  end
  local cfg = self.fight_item_cfg[id]
  if nil ~= cfg then
    return true
  end
  return false
end

function M:get_hero_equip_attr_list()
  local item_list = self.v_type_item_map[BagCfg.BagType.COLLECT]
  if not item_list or next(item_list) == nil then
    return {}
  end
  return self:_calc_item_enties(item_list)
end

function M:get_collects_attr_list()
  local item_list = self.v_type_item_map[BagCfg.BagType.COLLECT]
  if not item_list or next(item_list) == nil then
    return {}
  end
  return self:_calc_item_enties(item_list)
end

function M:get_drop_queue()
  return self.v_drop_queue
end

function M:get_suit_data(suit_id)
  return self.v_suit_map[suit_id]
end

function M:get_collect_num()
  if self.v_type_item_map[BagCfg.BagType.COLLECT] == nil then
    return 0
  end
  local num = 0
  for k, v in pairs(self.v_type_item_map[BagCfg.BagType.COLLECT]) do
    num = num + v.count
  end
  return num
end

function M:exit_tower()
  AttrSyncHelper.clear()
  for k, v in pairs(self.v_collect_magic_list) do
    local item = self.v_id_item_map[k][1]
    self:_set_heros_magic(item.Cfg.Arg[1], true, true)
  end
  self.v_collect_magic_list = {}
  self.v_has_displayed = false
  self.v_new_item_list = {}
  self.v_item_buffs = {}
  self.v_buff_type_map = {}
  self.v_add_attr_list_by_buff = {}
  self.v_last_chapter_item_data = nil
  self.unlock_item_count = 0
  self.v_last_item_count_list = {}
end

function M:set_force_use_bag(can_use)
  self.v_force_use_bag = can_use
end

function M:get_force_use_bag()
  return self.v_force_use_bag
end

function M:get_item_data(item_id)
  local data = self.v_id_item_map[item_id]
  if nil ~= data and nil ~= data[1] then
    return data[1]
  end
  return self:_build_item_obj_by_id(item_id)
end

function M:get_item_elements(ele_entries)
  if not ele_entries then
    return {}
  end
  local tb = {}
  for _, v in pairs(ele_entries) do
    local entry_cfg = self.v_element_entries[v]
    if entry_cfg then
      table.insert(tb, entry_cfg.Element)
    end
  end
  table.sort(tb)
  return tb
end

function M:get_show_all_map()
  if not TowerMgr then
    return false
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return false
  end
  local floor_info = tower:get_cur_floor_info()
  if not floor_info then
    return false
  end
  return floor_info.preview_status
end

function M:get_need_display_map()
  if not self:get_show_all_map() then
    return false
  end
  if not self.v_has_displayed and self.v_has_used_item then
    self.v_has_displayed = true
    self.v_has_used_item = false
    MsgGame:mq_publish2(Const.MSG_ON_USE_MAP_ITEM)
    return true
  else
    return false
  end
end

function M:has_same_type_equip(item_id)
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  local item_list = self.v_type_item_map[BagCfg.BagType.COLLECT]
  if not item_list or next(item_list) == nil then
    return false
  end
  for _, v in pairs(item_list) do
    if v.Cfg.Type ~= BagCfg.CollectType.EQUIP then
    elseif v.Cfg.Arg[1] == item_cfg.Arg[1] then
      return true
    end
  end
  return false
end

function M:get_wearing_equip(item_id)
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  local item_list = self.v_type_item_map[BagCfg.BagType.COLLECT]
  if not item_list or next(item_list) == nil then
    return
  end
  for _, v in pairs(item_list) do
    if v.Cfg.Type ~= BagCfg.CollectType.EQUIP then
    elseif v.Cfg.Arg[1] == item_cfg.Arg[1] then
      return v
    end
  end
end

function M:preview_equip(item_a, item_b)
  local item_list = self.v_type_item_map[BagCfg.BagType.COLLECT]
  if not item_list or next(item_list) == nil then
    return
  end
  local tb = {
    [1] = item_a
  }
  for _, v in ipairs(item_list) do
    if v.uuid ~= item_b.uuid then
      _tinsert(tb, v)
    end
  end
  local attr_list = self:_calc_item_enties(tb)
  AttrSyncHelper.sync_module_attrs(CommonDefine.MODULE_ATTR_TYPE.COLLECT, attr_list, nil, true)
end

function M:has_equip(uuid)
  local item_list = self.v_type_item_map[BagCfg.BagType.COLLECT]
  if not item_list or next(item_list) == nil then
    return false
  end
  for _, v in ipairs(item_list) do
    if v.uuid == uuid then
      return true
    end
  end
  return false
end

function M:get_preview_random_entries(uuid)
  if not uuid or not self.v_item_random_entries[uuid] then
    return
  end
  return self.v_item_random_entries[uuid]
end

function M:get_item_buffs()
  return self.v_item_buffs
end

function M:get_buff_type_map()
  return self.v_buff_type_map
end

function M:get_blood_buff_addtional()
  local radio = 0
  for _, v in pairs(self.v_item_buffs) do
    if v.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.ENHANCE_ATTR_MAGIC then
      radio = radio + Item_Helper.get_new_rune_lv(v.buff_cfg.Arg[2]) * v.buff_cfg.Arg[3]
    end
  end
  return radio
end

function M:get_attr_magic_buff_addtional(magic_id)
  local radio = 0
  for _, v in pairs(self.v_item_buffs) do
    if v.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.ENHANCE_ATTR_MAGIC then
      local can_add = false
      local effect_cfg = ShareRes.create("battle.battle_buff_effect", v.buff_cfg.Arg[1])
      if effect_cfg then
        for _, t in pairs(effect_cfg.Arg) do
          if t == magic_id then
            can_add = true
            break
          end
        end
      end
      if can_add then
        radio = radio + Item_Helper.get_new_rune_lv(v.buff_cfg.Arg[2]) * v.buff_cfg.Arg[3]
      end
    end
  end
  return radio
end

function M:get_currency_add_list()
  local tb = {}
  for i, v in ipairs(self.v_currency_add_list) do
    if type(v) == "number" then
      table.insert(tb, "+" .. v)
    else
      table.insert(tb, string.format("+%s（%s）", v.value, v.desc))
    end
  end
  self.v_currency_add_list = {}
  return tb
end

function M:is_new_item(uuid)
  return self.v_new_item_list[uuid] or false
end

function M:get_blood_add_list(heor_uuid)
  local tb = self.v_blood_add_list[heor_uuid] or {}
  self.v_blood_add_list[heor_uuid] = nil
  return tb
end

function M:get_has_new_item()
  for _, v in pairs(self.v_new_item_list) do
    if v then
      return true
    end
  end
  return false
end

function M:_add_to_item_list(item)
  local list = self.v_id_item_map[item.Id] or {}
  self.v_id_item_map[item.Id] = list
  _tinsert(list, item)
end

function M:_get_is_attr_item(item_id)
  if self.v_id_item_map[item_id] == nil then
    Log.Error("当前物品不存在于背包，请检查！！， item_id = ", item_id, "", debug.traceback())
    return
  end
  local cfg = self.v_id_item_map[item_id][1].Cfg
  return cfg.Type == BagCfg.ATTR_ITEM_TYPE.Type and cfg.Subtype == BagCfg.ATTR_ITEM_TYPE.SubType
end

function M:_set_all_attrs(init)
  self:_set_all_attr_item_attrs(init)
  self:_set_all_collects_attrs(init)
end

function M:_set_all_magic()
  self:_add_collect_magic()
end

function M:_set_all_attr_item_attrs()
  local god = SceneMgr:get_god_npc()
  if nil == god then
    return
  end
  local temp_list = {}
  local item_list = self.v_type_item_map[BagCfg.BagType.ITEM]
  if item_list and next(item_list) then
    for _, item_obj in pairs(item_list) do
      if self:_get_is_attr_item(item_obj.id) then
        local attrid = item_obj.Cfg.Arg[1]
        local attr = temp_list[attrid]
        local count = item_obj.count
        if not attr then
          attr = FightDefine.init_single_attr()
          temp_list[attrid] = attr
        end
        attr.FIXED = attr.FIXED + item_obj.Cfg.Arg[2] * count
      end
    end
  end
  god:update_module_attrs(CommonDefine.MODULE_ATTR_TYPE.ITEM, temp_list, true)
end

function M:_set_all_collects_attrs(init)
  local attr_list = self:get_collects_attr_list()
  if next(attr_list) == nil then
    return
  end
  local cur_attr_mgr = Global.hero.attr_mgr
  if not init then
    cur_attr_mgr.attr_play_anim = true
  end
  AttrSyncHelper.sync_module_attrs(CommonDefine.MODULE_ATTR_TYPE.COLLECT, attr_list, init)
  if not init then
    cur_attr_mgr.attr_play_anim = false
  end
end

function M:_add_collect_magic()
  local hero_list = SceneMgr:get_hero_list()
  if nil == hero_list then
    return
  end
  local item_list = self.v_type_item_map[BagCfg.BagType.COLLECT]
  if not item_list or nil == next(item_list) then
    return
  end
  for _, itemObj in pairs(item_list) do
    local collect_type_list = itemObj.Cfg.EffectType
    if UtilTable.contains(collect_type_list, CommonDefine.COLLECTION_EFFECT_TYPE.MAGIC_LIST) then
      self:_set_collect_magic(itemObj)
    end
  end
end

function M:_set_heros_magic(magic_id, is_remove, is_all)
  if magic_id <= 0 then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  for _, hero in pairs(hero_list) do
    if is_remove then
      Log.Info("角色", hero:get_name(), "移除magic", magic_id)
      if is_all then
        hero.magic_mgr:_remove_all_magic_by_id(magic_id)
      else
        hero.magic_mgr:remove_first_magic(magic_id)
      end
    else
      Log.Info("角色", hero:get_name(), "添加magic", magic_id)
      hero.magic_mgr:add_magic(hero, magic_id)
    end
  end
end

function M:_set_collect_magic(item, is_remove)
  local magic_id_list = item.magic_list
  if next(magic_id_list) == nil then
    return
  end
  for _, magic_id in pairs(magic_id_list) do
    self:_set_heros_magic(magic_id, is_remove)
  end
end

function M:_calc_item_enties(item_list)
  local temp_attr = {}
  for _, item_data in pairs(item_list) do
    for key, value in pairs(item_data.entry_list) do
      if not temp_attr[value] then
        temp_attr[value] = 0
      end
      temp_attr[value] = temp_attr[value] + 1
    end
  end
  return FightCalc.GetEntryAttrs(temp_attr)
end

function M:_build_item_obj(bagType, data)
  if self.v_bag_type_cfg[bagType].group == BagCfg.Type.ITEM then
    return Item_Helper.build_item_data(data)
  else
    return Item_Helper.build_collect_data(data)
  end
end

function M:_build_item_obj_by_id(item_id)
  local is_collect = Item_Helper.get_is_collect(item_id)
  if is_collect then
    return Item_Helper.build_collect_data({id = item_id})
  else
    return Item_Helper.build_item_data({id = item_id})
  end
end

function M:_sync_item_data(target, source)
  if target.uuid ~= source.uuid then
    Log.Error("uuid不一致，无法同步数据！！！", debug.traceback())
    return
  end
  target.count = source.count
  target.create_time = source.create_time
  target.random_entrys = source.random_entrys
end

function M:_calc_currecy_add_list(money_data)
  if money_data.id ~= BagCfg.CURRENCY[1] then
    return
  end
  if money_data.source ~= FightDefine.ITEM_SOURCE_EVENT.ROOM_END_DROP and money_data.source ~= FightDefine.ITEM_SOURCE_EVENT.BATTLE_SHOP_SELL then
    return
  end
  local cur_num = self.v_res_list[money_data.id] or 0
  local diff = money_data.count - cur_num
  local total = 0
  for _, v in pairs(self.v_item_buffs) do
    if v.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.BATTLE_ADD_MONEY then
      total = total + Item_Helper.get_new_rune_lv(v.buff_cfg.Arg[2]) * v.buff_cfg.Arg[3]
    end
  end
  local total2 = 0
  local origin = diff / (1 + total / 10000)
  local new_origin = math.ceil(origin)
  total2 = total2 + new_origin
  self.v_currency_add_list[1] = (self.v_currency_add_list[1] or 0) + new_origin
  if 0 == total then
    return
  end
  for _, v in pairs(self.v_item_buffs) do
    if v.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.BATTLE_ADD_MONEY then
      local radio = Item_Helper.get_new_rune_lv(v.buff_cfg.Arg[2]) * v.buff_cfg.Arg[3]
      local value = math.floor(origin * radio / 10000)
      total2 = total2 + value
      table.insert(self.v_currency_add_list, {
        value = value,
        desc = v.buff_cfg.Desc
      })
    end
  end
  local diff2 = total2 - diff
  if 0 ~= diff2 then
    self.v_currency_add_list[1] = self.v_currency_add_list[1] - diff2
  end
end

function M:calc_blood_add_list(hero, magic_id, count, item_id)
  if not hero then
    return
  end
  local magic_cfg = ShareRes.create("magic.magic", magic_id)
  if not magic_cfg or magic_cfg.logic.type ~= MAGIC_TYPE.Heal and magic_cfg.logic.type ~= MAGIC_TYPE.ChangeAttr then
    return
  end
  local attr_id = magic_cfg.logic[1]
  if attr_id == ATTR_TYPE.CHAR_HP_MAX then
    attr_id = ATTR_TYPE.CHAR_HP
  end
  local radio = 0
  local value = 0
  if 2 == magic_cfg.logic[3] then
    radio = magic_cfg.logic[2][1] / 10000 * count
  else
    value = magic_cfg.logic[2][1] * count
  end
  local cur_attr = hero.attr_mgr:get_attr(attr_id)
  local max_attr = hero.attr_mgr:get_attr(FightDefine.HERO_RES2MAX[attr_id])
  local diff = max_attr - cur_attr
  if 0 == diff and not Item_Helper.is_team_heal_item(item_id) then
    return
  end
  local origin = 0
  if radio > 0 then
    origin = max_attr * radio
  elseif value > 0 then
    origin = value
  end
  local tb
  if not self.v_blood_add_list[hero.uuid] then
    self.v_blood_add_list[hero.uuid] = {}
  end
  tb = self.v_blood_add_list[hero.uuid]
  local origin_value = math.floor(origin)
  local diff_value = math.floor(diff)
  if 0 ~= origin_value then
    if origin_value > diff_value then
      table.insert(tb, "+" .. diff_value)
    else
      table.insert(tb, "+" .. origin_value)
    end
  end
  local buff_sum = 0
  for _, v in pairs(self.v_item_buffs) do
    if v.buff_cfg.Type == BagCfg.ITEM_BUFF_TYPE.ENHANCE_ATTR_MAGIC then
      local can_add = false
      local effect_cfg = ShareRes.create("battle.battle_buff_effect", v.buff_cfg.Arg[1])
      if effect_cfg then
        for _, t in pairs(effect_cfg.Arg) do
          if t == magic_id then
            can_add = true
            break
          end
        end
      end
      if can_add then
        local radio = Item_Helper.get_new_rune_lv(v.buff_cfg.Arg[2]) * v.buff_cfg.Arg[3]
        local buff_value = math.floor(origin * radio / 10000)
        if diff_value > origin_value + buff_sum then
          local delta_value = diff_value - (origin_value + buff_sum)
          if buff_value <= delta_value then
            table.insert(tb, string.format("+%d（%s）", buff_value, v.buff_cfg.Desc))
            buff_sum = buff_sum + buff_value
          else
            table.insert(tb, string.format("+%d（%s）", buff_value - delta_value, v.buff_cfg.Desc))
            buff_sum = buff_sum + (buff_value - delta_value)
          end
        end
      end
    end
  end
end

function M:_calc_blood_item_add_list(hero, item_id, count)
  local cfg = ShareRes.create("battle.battle_item", item_id)
  local magic_id = cfg.Arg[1]
  local magic_cfg = ShareRes.create("magic.magic", magic_id)
  if not magic_cfg then
    return
  end
  self:calc_blood_add_list(hero, magic_id, count, item_id)
end

function M:_set_new_item_redpoint()
  local show = self:get_has_new_item()
  RedPointMgr:enable_redpoint(ITEM_PAGE_POINT, show)
end

function M:response_hero_item_hide()
  self.v_heal_hero_list = {}
end

function M:get_fight_item_num_by_id(item_id)
  return self.v_res_list[item_id] or self:get_item_num_by_id(item_id)
end

function M:get_last_fight_res_by_id(item_id)
  return self.v_last_item_count_list[item_id] or 0
end

function M:set_last_fight_res_by_id(item_id, count)
  self.v_last_item_count_list[item_id] = count
end

function M:_send_change_msg(chapter_item, need_reduce)
  if need_reduce then
    chapter_item.change_value = chapter_item.count - self.v_last_chapter_item_data.count
  else
    chapter_item.change_value = chapter_item.count - self.unlock_item_count
    self.unlock_item_count = 0
  end
  self.v_last_chapter_item_data = self.v_cur_chapter_item_data
  local achievement_tip = UIMgr:get_ui("common_battle_tips")
  if achievement_tip:visible() then
    achievement_tip:on_chapter_drop_count_change(chapter_item)
  else
    local show_data = {chapter_drop_data = chapter_item}
    achievement_tip:ui_show(show_data)
  end
end

function M:update_chapter_drop(data)
  local chapter_item = data.chapter_item
  self.v_cur_chapter_item_data = chapter_item
  if not self.v_last_chapter_item_data then
    self:_send_change_msg(chapter_item, false)
  elseif self.v_last_chapter_item_data.count ~= chapter_item.count then
    self:_send_change_msg(chapter_item, true)
  end
end

function M:record_enter_long_chapter_unlock_item_count(count)
  self.unlock_item_count = count
end

return M
