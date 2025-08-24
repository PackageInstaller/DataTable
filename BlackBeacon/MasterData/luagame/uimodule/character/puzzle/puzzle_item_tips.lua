local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TEMPLATE_KEY_ATTR = "PUZZLE_ITEM_TIPS_TEMPLATE_KEY_ATTR"
local RectTransformUtility = UnityEngine.RectTransformUtility
local Vec2 = require("base.vec2")
local Input = UnityEngine.Input
local TouchPhase = UnityEngine.TouchPhase

function ui:ui_finish_load()
  self:set_button("BtnUpLv", function()
    local puzzle_data = PuzzleMgr:get_puzzle_data(self.v_uuid)
    if not puzzle_data then
      return
    end
    if puzzle_data.quality >= Config.PUZZLE_MAX_QUALITY then
      Util.show_message_tip(2260)
      return
    end
    local puzzle_panel = UIMgr:try_get_visible_ui("puzzle_panel")
    if puzzle_panel then
      puzzle_panel:set_view_enable(Config.PUZZLE_OPERATE_PANEL_VIEW_TYPE.UP_LV, self.v_uuid)
    else
      UIMgr:get_ui("puzzle_panel"):ui_show(nil, Config.PUZZLE_OPERATE_PANEL_VIEW_TYPE.UP_LV, self.v_uuid)
    end
    self:ui_hide()
  end)
  self:set_button("BtnDecompose", function()
    local puzzle_panel = UIMgr:try_get_visible_ui("puzzle_panel")
    if puzzle_panel then
      puzzle_panel:set_view_enable(Config.PUZZLE_OPERATE_PANEL_VIEW_TYPE.DECOMPOSE, self.v_uuid)
    else
      UIMgr:get_ui("puzzle_panel"):ui_show(nil, Config.PUZZLE_OPERATE_PANEL_VIEW_TYPE.DECOMPOSE, self.v_uuid)
    end
    self:ui_hide()
  end)
  self:set_button("BtnRefine", function()
    local puzzle_panel = UIMgr:try_get_visible_ui("puzzle_panel")
    if puzzle_panel then
      puzzle_panel:set_view_enable(Config.PUZZLE_OPERATE_PANEL_VIEW_TYPE.REFINE, self.v_uuid)
    else
      UIMgr:get_ui("puzzle_panel"):ui_show(nil, Config.PUZZLE_OPERATE_PANEL_VIEW_TYPE.REFINE, self.v_uuid)
    end
    self:ui_hide()
  end)
  self:set_button("BtnSelect", function()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_CHOOSE_PUZZLE_ITEM)
    msg.mm_x = self.v_uuid
    self.v_not_send_hide_msg = true
    self:ui_hide()
  end)
  self:set_button("BtnReplace", function()
    local msg = MsgGame:mq_publish2(Const.MSG_ON_CHOOSE_PUZZLE_ITEM)
    msg.mm_x = self.v_uuid
    self.v_not_send_hide_msg = true
    self:ui_hide()
  end)
  self:set_button("BtnRemove", function()
    if self.v_remove_cb then
      self.v_remove_cb()
    end
    self:ui_hide()
  end)
  self.v_ui_rect = self.v_uiobjects.Root.transform
  self.v_canvas_camera = self:get_canvas().worldCamera
  self:register_exist_auto_template(TEMPLATE_KEY_ATTR, self.v_uiobjects.AttrTemp, self.v_uiobjects.AttrObj)
end

function ui:ui_on_show(uuid)
end

function ui:ui_after_show(uuid, show_data)
  if uuid == self.v_uuid then
    self:ui_hide()
    return
  end
  self.v_show_data = show_data
  local offset = show_data and show_data.offset
  self.v_remove_cb = show_data and show_data.remove_cb
  offset = offset or Config.PUZZLE_TIPS_OFFSET.MIDDLE
  self.v_uicompents.Root_rect:SetLocalPositionA(offset[1], offset[2])
  self.v_uuid = uuid
  if show_data and show_data.puzzle_data then
    self.v_puzzle_data = show_data.puzzle_data
  else
    self.v_puzzle_data = PuzzleMgr:get_puzzle_data(uuid)
  end
  self.v_puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(self.v_puzzle_data.id)
  self:refresh_base_info()
  self:refresh_attr_list()
  self:refresh_entry_info()
  self:refresh_btns()
  self:refresh_mini_icon()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SHOW_PUZZLE_ITEM_TIPS)
  msg.mm_x = uuid
  self.v_not_send_hide_msg = false
end

function ui:refresh_base_info()
  self.v_uicompents.PluginsName_txt.text = self.v_puzzle_cfg.Name
  local quality_icon_path = ShareRes.get_equip_quality_icon_path(self.v_puzzle_data.quality)
  ResMgr:load_set_icon(self.v_uicompents.PluginsQuality_img, quality_icon_path)
end

function ui:refresh_attr_list()
  self:give_back_auto_cache(TEMPLATE_KEY_ATTR)
  local attr_id2value = {}
  for _, attr_cfg_id in ipairs(self.v_puzzle_data.attr_list) do
    local attr_cfg = ShareRes.get_buddy_puzzle_attr_cfg(attr_cfg_id)
    attr_id2value[attr_cfg.AttrId] = (attr_id2value[attr_cfg.AttrId] or 0) + attr_cfg.AttrValue
  end
  local is_empty = not next(attr_id2value)
  if is_empty then
    return
  end
  for _, attr_show_cfg in ipairs(ShareRes.get_buddy_puzzle_attr_show_list()) do
    local attr_id = attr_show_cfg.AttrId
    local attr_val = attr_id2value[attr_id]
    if attr_val then
      local item = self:get_auto_cache(TEMPLATE_KEY_ATTR)
      local icon = Util.get_image("AttrIcon", item)
      local name_txt = Util.get_text("AttrName", item)
      local val_txt = Util.get_text("AttrVal", item)
      Util.load_attr_icon(icon, ShareRes.get_attr_icon(attr_id))
      name_txt.text = attr_show_cfg.Desc
      local is_ration = 1 == attr_show_cfg.AttrType
      val_txt.text = Util.format_number(attr_val, is_ration)
    end
  end
end

function ui:refresh_entry_info()
  local entry_id = self.v_puzzle_cfg.EntryId
  local quality = self.v_puzzle_data.quality
  self.v_uiobjects.EffectObj:SetActive(nil ~= entry_id)
  if not entry_id then
    return
  end
  local entry_cfg = ShareRes.get_buddy_puzzle_entry_cfg(entry_id, quality)
  self.v_uicompents.EffectName_txt.text = entry_cfg.Name
  self.v_uicompents.LvNum_txt.text = entry_cfg.Lv
  self.v_uicompents.EffectDesc_txt.text = entry_cfg.Desc
end

function ui:refresh_btns()
  local show_up_lv, show_remove, show_select, show_replace, show_mask, show_decompose, show_refine = false, false, false, false, false, false, false
  local show_close_mask = false
  if self.v_show_data then
    show_up_lv = self.v_show_data.show_up_lv_btn == true
    show_decompose = true == self.v_show_data.show_decompose_btn
    show_refine = true == self.v_show_data.show_refine_btn
    show_remove = true == self.v_show_data.show_remove_btn
    show_select = true == self.v_show_data.show_select_btn
    show_replace = true == self.v_show_data.show_replace_btn
    show_mask = true == self.v_show_data.show_dark_mask
    show_close_mask = true == self.v_show_data.show_close_mask
  end
  self.v_uiobjects.BtnClose:SetActive(show_close_mask)
  self.v_uiobjects.BtnSelect:SetActive(show_select)
  self.v_uiobjects.BtnReplace:SetActive(show_replace)
  self.v_uiobjects.BtnUpLv:SetActive(show_up_lv)
  self.v_uiobjects.BtnDecompose:SetActive(show_decompose)
  self.v_uiobjects.BtnRefine:SetActive(show_refine)
  self.v_uiobjects.BtnRemove:SetActive(show_remove)
  self.v_uiobjects.ButtonObj:SetActive(show_select or show_up_lv or show_remove or show_replace or show_decompose or show_refine)
  self.v_uiobjects.BlackMask:SetActive(show_mask)
end

function ui:refresh_mini_icon()
  local graph_show_cfg = ShareRes.get_buddy_puzzle_graph_show_cfg(self.v_puzzle_cfg.GraphID)
  ResMgr:load_set_icon(self.v_uicompents.PluginsSize_img, graph_show_cfg.SmallIcon, nil, true)
  self.v_uiobjects.PluginsSize:SetActive(true)
end

function ui:ui_on_hide()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_HIDE_PUZZLE_ITEM_TIPS)
  msg.mm_x = self.v_uuid
  self.v_uuid = nil
end

local vec2_pos = Vec2.New()

function ui:ui_update()
  local touch_0_pos
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    if Input.GetMouseButtonDown(0) or Input.GetMouseButton(0) then
      touch_0_pos = Input.mousePosition
    end
  elseif Input.touchCount > 0 then
    local touch_0 = Input.GetTouch(0)
    if touch_0.phase == TouchPhase.Began then
      touch_0_pos = touch_0.position
    end
  else
    return
  end
  if not touch_0_pos then
    return
  end
  vec2_pos.x = touch_0_pos.x
  vec2_pos.y = touch_0_pos.y
  local isTouchInside = RectTransformUtility.RectangleContainsScreenPoint(self.v_ui_rect, vec2_pos, self.v_canvas_camera)
  if not isTouchInside then
    self:ui_hide()
  end
end

return ui
