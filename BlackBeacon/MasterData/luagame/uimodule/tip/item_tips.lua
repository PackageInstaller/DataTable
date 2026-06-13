local Base = require("ui.uibase")
local Shop_Helper = require("uimodule.shop.shop_helper")
local BagCfg = require("uimodule.uibag.uibag_configs")
local Jump_Helper = require("gamelogic.sys_open.jump_helper")
local ui = Util.create_child_mt(Base)
local _insert = table.insert
local ITEM_TYPE = BagCfg.ITEM_TYPE
local BIND_TYPE = Config.BIND_TYPE
local SOURCE_ITEM_KEY = "SOURCE_ITEM_KEY"
local ITEM_SYNTHESIS_SYS_ID = 40
local ITEM_SYNTHESIS_JUMP_ID = 20000
local ItemSubTypeCfg = ShareRes.create("item.item_subtype")
local default_config = {
  {
    name = "钻石",
    item_id = Config.DIAMOND_ITEMID,
    const_event = Const.MSG_ON_DIAMOND_UPDATE
  },
  {
    name = "金币",
    item_id = Config.COIN_ITEMID,
    const_event = Const.MSG_ON_COIN_UPDATE
  },
  {
    name = "体力",
    item_id = Config.PLAYER_SP_ITEMID,
    const_event = Const.MSG_ON_PLAYER_SP_UPDATE
  }
}

local function BUILD_FUNCTIONS(single_item_exchange, item_count)
  local ret_item = {}
  
  local function get_item_base_info(item_id)
    local item_cfg = ShareRes.create("item.item", item_id)
    local ret_table = {}
    ret_table.id = item_id
    ret_table.priority = item_cfg.Priority
    ret_table.quality = item_cfg.Quality
    ret_table.name = item_cfg.Name
    ret_table.icon = item_cfg.Icon
    return ret_table
  end
  
  ret_item.targetInfo = {}
  local targetInfo = get_item_base_info(single_item_exchange.TargetId)
  targetInfo.Id = single_item_exchange.Id
  targetInfo.Count = single_item_exchange.Count
  targetInfo.TriesLimit = single_item_exchange.TriesLimit
  ret_item.targetInfo = targetInfo
  ret_item.materialInfos = {}
  local useMaterials = single_item_exchange.Material
  local useMaterialsNum = single_item_exchange.Num
  for i = 1, #useMaterials do
    local materialInfo = get_item_base_info(useMaterials[i])
    materialInfo.HoldNum = item_count[useMaterials[i]] or 0
    materialInfo.Num = useMaterialsNum[i]
    _insert(ret_item.materialInfos, materialInfo)
  end
  ret_item.SynthesisClassify = single_item_exchange.SynthesisClassify
  ret_item.TipsSynthesis = single_item_exchange.TipsSynthesis
  ret_item.IgnoreAwardMsg = single_item_exchange.IgnoreAwardMsg
  return ret_item
end

local MODEL = {
  v_item_quality = {
    "Icon_Bg",
    BIND_TYPE.IMAGE
  },
  v_item_num = {
    "Show_Item_Amout",
    BIND_TYPE.TEXT
  },
  v_item_name = {
    "Item_Name",
    BIND_TYPE.TEXT
  },
  v_qulity_bg = {
    "Quality_Bg",
    BIND_TYPE.IMAGE
  },
  v_break_star_layout = {
    "Break_Star_Layout",
    BIND_TYPE.BUTTON
  },
  v_need_star_layout = {
    "Star_Need_Layout",
    BIND_TYPE.OBJECT
  },
  v_star_num = {
    "Star_Need_Amount",
    BIND_TYPE.TEXT
  },
  v_mat_num = {
    "Mat_Need_Amount",
    BIND_TYPE.TEXT
  },
  v_star_overflow_desc = {
    "Overflow",
    BIND_TYPE.OBJECT
  },
  v_no_hero_desc = {
    "Hero_Lock",
    BIND_TYPE.OBJECT
  },
  v_time_layout = {
    "Time_Layout",
    BIND_TYPE.OBJECT
  },
  v_remain_time = {
    "Remain_Time",
    BIND_TYPE.TEXT
  },
  v_item_desc = {
    "Item_Desc",
    BIND_TYPE.TEXT
  },
  v_item_world_desc = {
    "Item_World_Desc",
    BIND_TYPE.TEXT
  },
  v_get_way_list = {
    "Get_Way_List",
    BIND_TYPE.OBJECT
  },
  v_get_way_content = {
    "Get_Way_Content",
    BIND_TYPE.OBJECT
  },
  v_get_way_item = {
    "Get_Way_Tem",
    BIND_TYPE.OBJECT
  },
  v_use_btn = {
    "Btn_Use",
    BIND_TYPE.BUTTON
  },
  v_synthesis_btn = {
    "Btn_Synthesis",
    BIND_TYPE.BUTTON
  },
  v_return_btn = {
    "Return",
    BIND_TYPE.BUTTON
  },
  v_use_panel = {
    "UseMode",
    BIND_TYPE.OBJECT
  }
}
local TIPS_TYPE = Config.ITEM_TIPS_TYPE

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button_listener(self.v_use_btn, function()
    self:_onclick_use_btn()
  end)
  self:set_button_listener(self.v_return_btn, function()
    self:_onclick_return_btn()
  end)
  self:set_button("BtnClose", function()
    self:_onclick_return_btn()
  end)
  self:set_button("Btn_Preview", function()
    UIMgr:get_ui("use_item_preview"):ui_show(self.v_data)
  end)
  self.v_way_rect = self:get_rect_transform(nil, self.v_get_way_content)
  self:register_exist_auto_template(SOURCE_ITEM_KEY, self.v_get_way_item, self.v_get_way_content)
  self.v_tips_type = TIPS_TYPE.COMMON
  self.v_item_id = 0
  self.v_item_cfg = nil
  self.v_panels.item_use_view:set_enable(false)
  self.v_text_content_init_pos = self.v_uiobjects.TextContent.transform.localPosition
  self.v_get_way_content_init_pos = self.v_uiobjects.GetWayContent.transform.localPosition
end

function ui:ui_on_show(data, ...)
  self:refresh_panel(data, ...)
end

function ui:refresh_panel(data)
  if not data.item_id then
    return
  end
  self.v_uiobjects.TextContent.transform.localPosition = self.v_text_content_init_pos
  self.v_uiobjects.GetWayContent.transform.localPosition = self.v_get_way_content_init_pos
  self.v_exchange_id = self:get_exchange_id(data.item_id)
  if SysOpenMgr:get_sys_is_open(ITEM_SYNTHESIS_SYS_ID) and self.v_exchange_id and not data.from_award_show_panel then
    self.v_synthesis_btn.gameObject:SetActive(true)
    self:set_button_listener(self.v_synthesis_btn, function()
      if UIMgr:try_get_visible_ui("new_ui_item_synthesis") then
        self.v_jump_cb = nil
      end
      self:jump_fun(ITEM_SYNTHESIS_JUMP_ID, self.v_exchange_id, self.v_need_count)
    end)
  else
    self.v_synthesis_btn.gameObject:SetActive(false)
  end
  if data.tips_type then
    self.v_tips_type = data.tips_type
  end
  self.v_item_id = data.item_id
  self.v_item_cfg = UtilUI.get_item_cfg(self.v_item_id)
  self.v_is_in_fight = data.is_in_fight
  if data.create_time then
    self.v_create_time = data.create_time
  end
  if data.item_uuid then
    self.v_item_uuid = data.item_uuid
  end
  if data.is_exist_jump ~= nil then
    self.v_is_exist_jump = data.is_exist_jump
  end
  if data.jump_cb then
    self.v_jump_cb = data.jump_cb
  else
    self.v_jump_cb = nil
  end
  self.v_curr_count = data.curr_count
  self.v_need_count = data.need_count
  self.v_need_select_item_id = data.need_select_item_id
  self.v_data = data
  self:refresh_tips_view()
  MsgGame:mq_publish2(Const.MSG_ON_ITEM_TIPS_WIN_SHOW)
  self.v_uiobjects.NeedCountContainer:SetActive(false)
  if self.v_curr_count and self.v_need_count and not data.not_show_count_text then
    self.v_uiobjects.NeedCountContainer:SetActive(true)
    self.v_uicompents.CurrCount_txt.text = tostring(self.v_curr_count)
    self.v_uicompents.NeedCount_txt.text = tostring(self.v_need_count)
  end
  self:refresh_box_item()
end

function ui:refresh_box_item()
  if self.v_data.item_uuid then
    self.v_uiobjects.Btn_Preview:SetActive(false)
    return
  end
  local item_id = self.v_data.item_id
  local cfg = ShareRes.get_item_cfg(item_id)
  if not cfg or 2 ~= cfg.Type or cfg.Subtype ~= ItemSubTypeCfg.treasure_chest_unlocked.SubtypeId and cfg.Subtype ~= ItemSubTypeCfg.treasure_chest_select.SubtypeId and cfg.Subtype ~= ItemSubTypeCfg.award_item.SubtypeId then
    self.v_uiobjects.Btn_Preview:SetActive(false)
    return
  end
  self.v_uiobjects.Btn_Preview:SetActive(true)
end

function ui:ui_on_hide()
  self:on_clear_info()
  MsgGame:mq_publish2(Const.MSG_ON_ITEM_TIPS_WIN_HIDE)
end

function ui:on_clear_info()
  self.v_tips_type = TIPS_TYPE.COMMON
  self.v_item_id = 0
  self.v_create_time = nil
  self.v_item_uuid = nil
  self.v_is_exist_jump = nil
  self.v_item_cfg = nil
  self.v_item_obj = nil
  self.v_data = nil
  self.v_exchange_id = nil
  self.v_panels.item_use_view:set_enable(false)
end

function ui:refresh_tips_view()
  self.v_item_name.text = UtilUI.get_item_name(self.v_item_id)
  local num = BagMgr:get_item_num(self.v_item_id)
  self.v_uiobjects.AmountBg:SetActive(0 ~= num)
  self.v_item_num.text = num
  if not self.v_item_obj then
    self.v_item_obj = self:create_item_obj(nil, self.v_item_quality.gameObject, nil, {
      item_id = self.v_item_id
    })
  else
    self.v_item_obj:ui_show({
      item_id = self.v_item_id
    })
  end
  local quality_cfg = ShareRes.get_item_quality_cfg(self.v_item_cfg.Quality)
  if quality_cfg then
    ResMgr:load_set_icon(self.v_qulity_bg, quality_cfg.QualityBgIcon)
  end
  local is_break_mat = false
  if self.v_item_cfg then
    is_break_mat = self.v_item_cfg.Type == ITEM_TYPE.MATS and 1 == self.v_item_cfg.Subtype
  end
  self.v_break_star_layout.gameObject:SetActiveEx(is_break_mat)
  Global.listener_mgr:add_listener(self.v_object, self.v_break_star_layout.onClick, function()
    self:_onclick_break_star_btn()
  end)
  if is_break_mat then
    self:_set_break_info()
  end
  self:_set_mini_icon()
  self:_refresh_right_view()
end

function ui:_onclick_use_btn()
  local need_count = 0
  if self.v_need_count ~= nil and nil ~= self.v_curr_count then
    need_count = self.v_need_count - self.v_curr_count
  end
  if self.v_item_cfg.Subtype == ItemSubTypeCfg.treasure_chest_select.SubtypeId then
    UIMgr:get_ui("use_select_item_tips"):ui_show(self.v_item_id, self.v_item_uuid, self.v_need_select_item_id, need_count)
  elseif self.v_item_cfg.Subtype == ItemSubTypeCfg.treasure_chest_unlocked.SubtypeId or self.v_item_cfg.Subtype == ItemSubTypeCfg.award_item.SubtypeId then
    UIMgr:get_ui("use_ramdom_item_tips"):ui_show(self.v_item_id, self.v_item_uuid, self.v_need_select_item_id, need_count)
  elseif self.v_item_cfg.Subtype == ItemSubTypeCfg.stamina_item.SubtypeId then
    self.v_panels.item_use_view:set_enable(true, {
      item_id = self.v_item_id,
      item_uuid = self.v_item_uuid
    })
  elseif self.v_item_cfg.Subtype == ItemSubTypeCfg.active_system_item.SubtypeId then
    local consume_list = {
      bag_type = self.v_item_cfg.Type,
      item_list = {
        {
          uuid = self.v_item_uuid,
          count = 1
        }
      }
    }
    BagMgr:request_use_item(consume_list, function(ok)
      if ok then
        Util.show_message_tip(2070)
        self:ui_hide()
      end
    end)
  elseif self.v_item_cfg.Subtype == ItemSubTypeCfg.buddy_develop_call_back.SubtypeId then
    UIMgr:get_ui("recultivate_tips"):ui_show(self.v_item_id, self.v_item_uuid)
    self:ui_hide()
  elseif self.v_item_cfg.Subtype == ItemSubTypeCfg.weapon_develop_call_back.SubtypeId then
    UIMgr:get_ui("recultivate_tips"):ui_show(self.v_item_id, self.v_item_uuid, true)
    self:ui_hide()
  end
end

function ui:_onclick_return_btn()
  if self.v_use_panel.gameObject.activeInHierarchy then
    self.v_panels.item_use_view:set_enable(false)
    return
  end
  self:ui_hide()
end

function ui:_onclick_break_star_btn()
  UIMgr:get_ui("break_mat_tips"):ui_show(self.v_item_id)
  self:ui_hide()
end

function ui:_set_mini_icon()
  local item_id = self.v_item_cfg.Id
  local type_config = ShareRes.get_award_type_cfg(item_id)
  self.v_uiobjects.PluginsSize:SetActive(false)
  if type_config.AwardType == Config.AWARD_TYPE.PUZZLE then
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
    local graph_show_cfg = ShareRes.get_buddy_puzzle_graph_show_cfg(puzzle_cfg.GraphID)
    ResMgr:load_set_icon(self.v_uicompents.PluginsSizeIcon_img, graph_show_cfg.SmallIcon, nil, true)
    self.v_uiobjects.PluginsSize:SetActive(true)
  end
end

function ui:_set_break_info()
  local role_id = self.v_item_cfg.Arg[1]
  local buddy_info = CharacterMgr:get_buddy_by_id(role_id)
  self.v_no_hero_desc:SetActiveEx(nil == buddy_info)
  self.v_need_star_layout:SetActiveEx(nil ~= buddy_info)
  self.v_star_overflow_desc:SetActiveEx(nil ~= buddy_info)
  self.v_break_star_layout.interactable = nil ~= buddy_info
  if nil ~= buddy_info then
    local is_enough, anmout, lv = Shop_Helper.check_break_mat_enough(self.v_item_id, role_id)
    self.v_need_star_layout:SetActiveEx(false == is_enough)
    self.v_star_overflow_desc:SetActiveEx(true == is_enough)
    if false == is_enough then
      self.v_star_num.text = Util.format_str("突破{1}", lv)
      self.v_mat_num.text = Util.format_str("仍需<color=red>{1}</color>个", anmout)
    end
  end
end

function ui:_refresh_right_view()
  self.v_item_desc.text = ""
  self.v_item_world_desc.text = ""
  if not self.v_item_cfg then
    return
  end
  self.v_item_desc.text = self.v_item_cfg.Desc or self.v_item_cfg.Describe
  local item_id = self.v_item_cfg.Id
  local type_config = ShareRes.get_award_type_cfg(item_id)
  if type_config.AwardType == Config.AWARD_TYPE.PUZZLE then
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
    if puzzle_cfg.EntryId then
      local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(puzzle_cfg.EntryId, 3)
      self.v_item_world_desc.text = entry_cfg.Desc
    end
  else
    self.v_item_world_desc.text = self.v_item_cfg.WorldDesc
  end
  local has_source = false
  if self.v_item_cfg.Jump then
    for _, jump_id in pairs(self.v_item_cfg.Jump) do
      if 0 ~= jump_id and Jump_Helper.get_jump_show(jump_id) then
        has_source = true
      end
    end
  end
  self.v_get_way_list:SetActiveEx(false)
  local box_list = self:check_box(self.v_item_id)
  if (has_source or box_list and #box_list > 0) and self.v_is_exist_jump == nil then
    self.v_get_way_list:SetActiveEx(true)
    self:_refresh_source_view(box_list)
  end
  if self.v_tips_type == TIPS_TYPE.BAG then
    if self.v_item_cfg.Subtype == ItemSubTypeCfg.stamina_item.SubtypeId or self.v_item_cfg.Subtype == ItemSubTypeCfg.treasure_chest_select.SubtypeId or self.v_item_cfg.Subtype == ItemSubTypeCfg.treasure_chest_unlocked.SubtypeId or self.v_item_cfg.Subtype == ItemSubTypeCfg.award_item.SubtypeId or self.v_item_cfg.Subtype == ItemSubTypeCfg.active_system_item.SubtypeId or self.v_item_cfg.Subtype == ItemSubTypeCfg.buddy_develop_call_back.SubtypeId or self.v_item_cfg.Subtype == ItemSubTypeCfg.weapon_develop_call_back.SubtypeId then
      self.v_use_btn.gameObject:SetActiveEx(true)
    else
      self.v_use_btn.gameObject:SetActiveEx(false)
    end
    if self.v_item_cfg.Duration and 0 ~= self.v_item_cfg.Duration then
      self.v_time_layout:SetActiveEx(true)
      self.v_remain_time.text = Date.standard_data(self.v_create_time + self.v_item_cfg.Duration)
    else
      self.v_time_layout:SetActiveEx(false)
    end
  else
    self.v_use_btn.gameObject:SetActiveEx(false)
    self.v_time_layout:SetActiveEx(false)
  end
end

function ui:_refresh_source_view(box_list)
  self.v_way_rect:SetAnchoredPositionA(0, 0)
  self:give_back_auto_cache(SOURCE_ITEM_KEY, false)
  if box_list and #box_list > 0 then
    for idx, item_data in pairs(box_list) do
      local item_cfg = item_data.item_cfg
      local item_info = item_data.item_info
      local obj = self:get_auto_cache(SOURCE_ITEM_KEY)
      local title = self:get_text("Get_Way_Name", obj)
      title.text = item_cfg.Name
      local desc = self:get_text("Get_Way_Detail", obj)
      desc.gameObject:SetActive(false)
      local btn = self:get_button(nil, obj)
      Global.listener_mgr:add_listener(self.v_object, btn.onClick, function()
        local temp_item_id = self.v_item_id
        local data = {
          item_id = item_info.id,
          tips_type = Config.ITEM_TIPS_TYPE.BAG,
          create_time = item_info.create_time,
          item_uuid = item_info.uuid,
          curr_count = self.v_curr_count,
          need_count = self.v_need_count,
          need_select_item_id = temp_item_id,
          not_show_count_text = true
        }
        UIMgr:get_ui("itemTip"):on_clear_info()
        UIMgr:get_ui("itemTip"):refresh_panel(data)
      end)
    end
  end
  local jump = self.v_item_cfg.Jump
  local lack_item_id, lack_item_count = self.v_item_id, self.v_need_count
  if jump then
    for k, v in pairs(jump) do
      if 0 ~= v and Jump_Helper.get_jump_show(v) then
        local cfg = ShareRes.create("sysopen.sys_jump", v)
        local obj = self:get_auto_cache(SOURCE_ITEM_KEY)
        local title = self:get_text("Get_Way_Name", obj)
        title.text = cfg.title
        local desc = self:get_text("Get_Way_Detail", obj)
        desc.text = cfg.source_desc
        local btn = self:get_button(nil, obj)
        Global.listener_mgr:add_listener(self.v_object, btn.onClick, function()
          local suc = self:jump_fun(v)
          if suc then
            ChapterMaterialMgr:try_cache_lack_item(v, lack_item_id, lack_item_count)
          end
        end)
      end
    end
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_way_rect)
end

function ui:check_box(item_id)
  local list = BagMgr:get_auto_select_box(item_id)
  return list
end

local ignore_jump_cb_ui = {use_select_item_tips = true}

function ui:jump_fun(jump_id, ...)
  if not self.v_is_in_fight then
    local value = SysOpenMgr:jump_to_sys(jump_id, true, ...)
    if value then
      self:ui_hide()
      if self.v_jump_cb and not ignore_jump_cb_ui[Jump_Helper.get_jump_ui_name(jump_id)] then
        self.v_jump_cb()
      end
      return true
    end
  else
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("请先完成关卡结算！"))
  end
end

function ui:close_item_use_view()
  self.v_panels.item_use_view:set_enable(false)
end

function ui:get_exchange_id(item_id)
  local item_exchange_table = ShareRes.get_can_show_item_combine_cfg()
  local lower, target_exchange_id
  for k, v in pairs(item_exchange_table) do
    if v.TargetId == item_id and v.TipsSynthesis ~= nil and (not lower or lower > v.TipsSynthesis) then
      target_exchange_id = k
      lower = v.TipsSynthesis
    end
  end
  return target_exchange_id
end

function ui:get_items_count(items)
  local ret = {}
  for i = 1, #items do
    if ret[items[i].id] then
      ret[items[i].id] = ret[items[i].id] + items[i].count
    else
      ret[items[i].id] = items[i].count
    end
  end
  for k, v in pairs(default_config) do
    ret[v.item_id] = BagMgr:get_item_num(v.item_id)
  end
  return ret
end

return ui
