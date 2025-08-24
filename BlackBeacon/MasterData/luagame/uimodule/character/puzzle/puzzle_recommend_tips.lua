local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY_ATTR = "PUZZLE_RECOMMEND_TIPS_TEMPLATE_KEY_ATTR"
local TEMPLATE_KEY_EFFECT = "PUZZLE_RECOMMEND_TIPS_TEMPLATE_KEY_EFFECT"
local TXT_NORMAL_COLOR = Util.get_unity_color_by_hex(tonumber("484243", 16))
local TXT_ACTIVE_COLOR = Util.get_unity_color_by_hex(tonumber("F5EDE2", 16))
local ICON_ACTIVE_COLOR = Util.get_unity_color_by_hex(tonumber("EFC66E", 16))
local ENTRY_ICON_NORMAL_COLOR = Util.get_unity_color_by_hex(tonumber("292929", 16))
local ATTR_ICON_NORMAL_COLOR = Util.get_unity_color_by_hex(tonumber("ae9577", 16))
local buddy_puzzle_entry = ShareRes.create("buddy.buddy_puzzle_entry")
local buddy_puzzle_graph_icon = ShareRes.create("buddy.buddy_puzzle_graph_icon")

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClosePassDrag", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(TEMPLATE_KEY_ATTR, self.v_uiobjects.AttrTem, self.v_uiobjects.AttrLayout)
  self:register_exist_auto_template(TEMPLATE_KEY_EFFECT, self.v_uiobjects.EffectTem, self.v_uiobjects.EffectLayout)
end

function ui:ui_after_show(buddy_id)
  self.v_buddy_id = buddy_id
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local puzzle_graph = buddy_info.puzzle_graph
  local map_graph_id = puzzle_graph.id
  self.v_recommend_cfg = ShareRes.get_recommend_puzzle_cfg(buddy_id, map_graph_id)
  if not self.v_recommend_cfg then
    self:ui_hide()
    Log.Error(self.v_buddy_id, "角色插件 区域开放表填的推荐ID不存在")
    return
  end
  self.v_is_init = true
  self.v_is_first_click = true
  self:refresh_attr_list()
  self:refresh_entry_list()
  self.v_is_init = false
end

function ui:refresh_attr_list(puzzle_place_infos)
  local recommend_attrs = self.v_recommend_cfg.RecommendAttrs
  if not recommend_attrs then
    self.v_uiobjects.EffectLayout:SetActive(false)
    return
  end
  self.v_uiobjects.EffectLayout:SetActive(true)
  self.v_attr_list = {}
  self:give_back_auto_cache(TEMPLATE_KEY_ATTR)
  for idx, attr_id in ipairs(recommend_attrs) do
    local item = self:get_auto_cache(TEMPLATE_KEY_ATTR)
    local txt = Util.get_text("Name_", item)
    local icon = Util.get_image("Icon_", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    local name = ShareRes.get_attr_name(attr_id)
    txt.text = name
    local icon_name = ShareRes.get_attr_icon(attr_id)
    if icon_name then
      Util.load_attr_icon(icon, icon_name)
    end
    self.v_attr_list[idx] = {
      id = attr_id,
      tog = tog,
      txt = txt,
      icon = icon
    }
    self:set_attr_item_color(txt, icon, false)
    self:set_toggle_listener(tog, function(is_on)
      self:set_attr_item_color(txt, icon, is_on)
      if self.v_is_init then
        return
      end
      if PuzzleMgr:get_view_filter_tab_type() ~= PuzzleMgr.TabEnum.Entry then
        PuzzleMgr:set_view_filter_tab_type(PuzzleMgr.TabEnum.Entry)
      end
      if self.v_is_first_click then
        PuzzleMgr:reset_view_filter()
        self.v_is_first_click = false
      end
      PuzzleMgr:set_view_filter(PuzzleMgr.FilterTypeEnum.Attr, attr_id, not is_on)
    end)
  end
end

function ui:refresh_entry_list(puzzle_place_infos)
  local recommend_effects = self.v_recommend_cfg.RecommendEffects
  if not recommend_effects then
    self.v_uiobjects.EffectLayout:SetActive(false)
    return
  end
  self.v_uiobjects.EffectLayout:SetActive(true)
  self.v_entry_list = {}
  self:give_back_auto_cache(TEMPLATE_KEY_EFFECT)
  for idx, entry_id in ipairs(recommend_effects) do
    local item = self:get_auto_cache(TEMPLATE_KEY_EFFECT)
    local txt = Util.get_text("Name_", item)
    local icon = Util.get_image("Icon_", item)
    local tog = Util.get_toggle(nil, item)
    tog.isOn = false
    local entry_cfg = buddy_puzzle_entry[entry_id]
    local single_cfg = entry_cfg[next(entry_cfg)]
    local graph_cfg = buddy_puzzle_graph_icon[single_cfg.GraphID]
    txt.text = single_cfg.Name
    local icon_name = graph_cfg.SmallIcon
    if icon_name then
      ResMgr:load_set_icon(icon, icon_name, nil, true)
    end
    self.v_entry_list[idx] = {
      id = entry_id,
      tog = tog,
      txt = txt,
      icon = icon
    }
    self:set_entry_item_color(txt, icon, false)
    self:set_toggle_listener(tog, function(is_on)
      self:set_entry_item_color(txt, icon, is_on)
      if self.v_is_init then
        return
      end
      if PuzzleMgr:get_view_filter_tab_type() ~= PuzzleMgr.TabEnum.Entry then
        PuzzleMgr:set_view_filter_tab_type(PuzzleMgr.TabEnum.Entry)
      end
      if self.v_is_first_click then
        PuzzleMgr:reset_view_filter()
        self.v_is_first_click = false
      end
      PuzzleMgr:set_view_filter(PuzzleMgr.FilterTypeEnum.Entry, entry_id, not is_on)
    end)
  end
end

function ui:set_attr_item_color(txt, icon, active)
  txt.color = active and TXT_ACTIVE_COLOR or TXT_NORMAL_COLOR
  icon.color = active and ICON_ACTIVE_COLOR or ATTR_ICON_NORMAL_COLOR
end

function ui:set_entry_item_color(txt, icon, active)
  txt.color = active and TXT_ACTIVE_COLOR or TXT_NORMAL_COLOR
  icon.color = active and ICON_ACTIVE_COLOR or ENTRY_ICON_NORMAL_COLOR
end

return ui
