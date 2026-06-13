local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SKIN_TEMPLETE_KEY = "SKIN_TEMPLETE_KEY"
local DRESS_ITEM = require("uimodule.ui_fashionable_dress.ui_fashionable_dress_item")
local WEAPON_ITEM = require("uimodule.ui_fashionable_dress.ui_fashionable_weapon_item")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local NewModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local WeaponModelRtView = require("ui.model_rt_view.model_rt_weapon_view")
local all_fashionable_info = ShareRes.create("buddy.buddy_fashion")
local ShopCfg = require("uimodule.shop.shop_config")
local Shop_Helper = require("uimodule.shop.shop_helper")
local BIND_TYPE = Config.BIND_TYPE
local Math = require("base.mathx")
local Input = UnityEngine.Input
local Vec3 = require("base.vec3")
local CT_Timer = Global.ct_timer
local AssetBarView = require("ui.asset_bar.asset_bar")
local UnityShader = UnityEngine.Shader
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local EFFECT_NAME = "Fx_UI_RingLoop_Hero"
local SWTICH_EFFECT_NAME = "Fx_UI_Switch_Hero"
local INTERACT_TYPE = {
  IS_WEARING = 1,
  NOT_WEARING = 2,
  NOT_HAVE = 3,
  EMPTY = 4
}
local obj_name_list = {
  "Right",
  "SkinInfo",
  "Bg",
  "BtnHide",
  "BtnLastChar",
  "BtnNextChar",
  "Painter",
  "CV"
}
local INTERACT_BTN_TYPE = {
  [INTERACT_TYPE.IS_WEARING] = "IsWearing",
  [INTERACT_TYPE.NOT_WEARING] = "BtnWear"
}
local CAMERA_STATE = {
  NORMAL = 1,
  FAR = 2,
  NEAR = 3
}
local PANEL_TYPE = {CHARACTER = 1, WEAPON = 2}
local ITEM_INTERVAL_X = 287
local CONTENT_START_X = 287
local tsort = table.sort

local function fashion_cmp(a, b)
  local a_has_bought = FashionMgr:check_has_bought_fashion(a.Id)
  local b_has_bought = FashionMgr:check_has_bought_fashion(b.Id)
  local a_show_priority = a.ShowPriority
  local b_show_priority = b.ShowPriority
  if a_has_bought == b_has_bought then
    return a_show_priority > b_show_priority
  else
    return a_has_bought
  end
end

local MIN_CONTENT_Y = 0
local MAX_CONTENT_Y = 0.7
local CHANGE_BUDDY_TYPE = {LAST = 1, NEXT = 2}
local enough_color = Util.get_unity_color_by_hex(tonumber("634C28", 16))
local not_enough_color = Util.CommonColor_RedWarm

function ui:on_go_to_main()
  self.v_selected_idx = nil
  self.v_selected_weapon_idx = nil
end

local MODEL_PARAM = MODEL_CONFIG.UI_FASHION_MODEL_PARAM

function ui:ui_finish_load()
  self.v_content_y = self.v_uicompents.SkinContent_rect.anchoredPosition.y
  self.v_fashion_item_list = {}
  self.v_panel_type = PANEL_TYPE.CHARACTER
  self:set_button("BtnReturn", function()
    if not self.v_fade_bg then
      self:ui_hide()
      self.v_selected_idx = nil
      self.v_selected_weapon_idx = nil
    else
      self:black_bg_close()
    end
  end)
  self:set_button("BtnLastChar", function()
    self:change_buddy(CHANGE_BUDDY_TYPE.LAST)
  end)
  self:set_button("BtnNextChar", function()
    self:change_buddy(CHANGE_BUDDY_TYPE.NEXT)
  end)
  self:set_button("BtnLeft", function()
    self:change_page(true, nil, true)
  end)
  self:set_button("BtnRight", function()
    self:change_page(false, nil, true)
  end)
  self:set_button("BtnHide", function()
    self:show_or_hide()
  end)
  self:set_button("BtnShow", function()
    self:show_or_hide()
  end)
  self:set_button("BtnShowSpine", function()
    UIMgr:get_ui("char_spine_display"):ui_show(self.v_current_buddy_id, self.v_current_select_fashion_id)
  end)
  self:set_button("BtnChange", function()
    if self.v_weapon_model_rt then
      self.v_weapon_model_rt:on_destroy()
      self.v_weapon_model_rt = nil
      self.v_current_model_view:set_visible(true)
      self.v_current_model_view:change_weapon_by_res(self:get_cur_select_weapon_res())
      self.v_current_model_view:reset_init_anim(self.v_model_idx)
      self.v_uicompents.BtnChangeText_txt.text = "武器"
      self.v_uiobjects.BtnHide:SetActive(true)
      self:check_need_open_change_btn()
    else
      local weapon_res = self:get_cur_select_weapon_res()
      self.v_weapon_model_rt = WeaponModelRtView:new(nil, false, nil, nil, true, "UIModelRtViewWeapon")
      self.v_weapon_model_rt:set_x_offset()
      self.v_weapon_model_rt:init_weapon_info_by_res_id(weapon_res)
      self.v_weapon_model_rt:set_visible(true)
      self.v_current_model_view:set_visible(false)
      self.v_uicompents.BtnChangeText_txt.text = "角色"
      self.v_uiobjects.BtnLastChar:SetActive(false)
      self.v_uiobjects.BtnNextChar:SetActive(false)
      self.v_uiobjects.BtnHide:SetActive(false)
    end
    self.v_uicompents.Ani_UIFashion_Refresh_pd:Play()
  end)
  self:set_button("BtnWear", function()
    if self.v_panel_type == PANEL_TYPE.CHARACTER then
      if not self.v_current_buddy_id then
        return
      end
      if self.v_current_wearing_id == self.v_current_select_fashion_id then
        return
      end
      FashionMgr:change_fashion_request(self.v_current_buddy_id, self.v_current_select_fashion_id, function(msg)
        if true == msg and self:has_inited() then
          self.v_current_wearing_id = self.v_current_select_fashion_id
          self:show_current_fashion_info()
        end
      end)
    else
      local weapon_fashion_id = self.v_weapon_all_fashion[self.v_selected_weapon_idx]
      if 1 == self.v_selected_weapon_idx then
        local weapon_id = weapon_fashion_id
        local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
        local sub_type = weapon_cfg.SubType
        local fashion_id = FashionMgr:get_wearing_weapon_fashion_id(sub_type)
        FashionMgr:change_equip_fashion(fashion_id, false, function()
          self:show_current_weapon_fashion_info()
        end)
      else
        FashionMgr:change_equip_fashion(weapon_fashion_id, true, function()
          self:show_current_weapon_fashion_info()
        end)
      end
    end
  end)
  self:set_button("BtnBuy", function()
    self:_onclick_buy_btn()
  end)
  local slider = self.v_uicompents.CharPos_sld
  self:set_scrollrect_listener(slider, function()
    if not self.v_uicompents.CharPos_sld.gameObject.activeSelf then
      return
    end
    if self.v_current_model_view then
      local init_y = self.v_content_root_position and self.v_content_root_position.pos_y or 0
      local y = Math.lerp_number(MIN_CONTENT_Y + init_y, MAX_CONTENT_Y + init_y, slider.value)
      self.v_current_model_view:change_content_pos_y(y)
      self.v_current_model_view:change_effect_root_pos_y(y)
      self.v_content_root_position.y = y
    end
  end)
  self:set_button("CharScaleBtn", function()
    self:click_scale_btn()
  end)
  self:set_button("BtnGoGet", function()
    self:_onclick_get_btn()
  end)
  self:set_button("BtnActJump", function()
    self:_onclick_get_btn()
  end)
  self:set_toggle("CharTog", function(is_on)
    if not is_on or self.v_panel_type == PANEL_TYPE.CHARACTER then
      self.v_uicompents.CharTog_tog.interactable = true
      return
    end
    self.v_panel_type = PANEL_TYPE.CHARACTER
    self.v_uiobjects.BtnChange:SetActive(false)
    self.v_uiobjects.BtnHide:SetActive(true)
    self.v_uicompents.Ani_UIFashion_Refresh_pd:Play()
    if self.v_weapon_model_rt then
      self.v_uicompents.BtnChange_btn.onClick:Invoke()
    end
    self:refresh_buddy(self.v_cur_select_buddy_idx or 1)
    self.v_uicompents.CharTog_tog.interactable = false
    self:refresh_show_spine_btn()
  end)
  self:set_toggle("WeaponTog", function(is_on)
    if not is_on or self.v_panel_type == PANEL_TYPE.WEAPON then
      self.v_uicompents.WeaponTog_tog.interactable = true
      return
    end
    self.v_panel_type = PANEL_TYPE.WEAPON
    self.v_uiobjects.BtnChange:SetActive(true)
    self.v_uiobjects.BtnShowSpine:SetActive(false)
    self.v_uicompents.Ani_UIFashion_Refresh_pd:Play()
    local cur_fashion_cfg = ShareRes.get_fashion_cfg(self.v_current_wearing_id)
    if cur_fashion_cfg and self.v_last_model_id ~= cur_fashion_cfg.ModelId then
      self.v_cur_model_id = cur_fashion_cfg.ModelId
      self:refresh_fashion_model()
      self.v_last_model_id = cur_fashion_cfg.ModelId
    end
    self.v_uiobjects.BtnLastChar:SetActive(false)
    self.v_uiobjects.BtnNextChar:SetActive(false)
    self:refresh_weapon_list()
    self.v_uicompents.WeaponTog_tog.interactable = false
  end)
  self:set_scrollrect_cb()
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self:register_exist_auto_template(SKIN_TEMPLETE_KEY, self.v_uiobjects.Skin, self.v_uiobjects.SkinContent)
end

function ui:refresh_show_spine_btn()
  local big_spine_id, simple_spine_id
  if self.v_panel_type == PANEL_TYPE.CHARACTER then
    big_spine_id = UtilUI.get_hero_display_big_spine(self.v_current_buddy_id, self.v_current_select_fashion_id)
    simple_spine_id = UtilUI.get_hero_display_simple_spine(self.v_current_buddy_id, self.v_current_select_fashion_id)
  end
  local is_show_scale_view = self.v_uiobjects.CharPosContent.activeSelf
  self.v_uiobjects.BtnShowSpine:SetActive(not is_show_scale_view and (nil ~= big_spine_id or nil ~= simple_spine_id))
end

function ui:on_scroll()
  local tf
  for fashion_id, item in pairs(self.v_fashion_item_list) do
    tf = item:get_object_transform()
    local pos1 = tf.position
    pos1.z = 0
    local pos2 = self.v_uiobjects.CentralNode.transform.position
    pos2.z = 0
    local dis = math.min(Util.VEC3_TEMP.Distance(pos1, pos2), 5)
    if dis <= 1 then
      if self.v_panel_type == PANEL_TYPE.CHARACTER then
        if self.v_scroll_fashion_id ~= fashion_id then
          self.v_scroll_fashion_id = fashion_id
        end
      elseif self.v_scroll_weapon_fashion_id ~= fashion_id then
        self.v_scroll_weapon_fashion_id = fashion_id
      end
    end
    local scale = 1 - dis / 2.5 * 0.1
    tf:SetLocalScaleA(scale)
  end
end

function ui:on_scroll_end()
  self:change_target_index_by_fashion_id(true)
end

function ui:change_target_index_by_fashion_id(need_dotween)
  if self.v_panel_type == PANEL_TYPE.CHARACTER then
    local item = self.v_fashion_item_list[self.v_scroll_fashion_id]
    local scroll_index = item and item:get_index()
    local target_index = scroll_index or self.v_selected_idx
    self:change_page(nil, target_index, need_dotween)
  else
    local item = self.v_fashion_item_list[self.v_scroll_weapon_fashion_id]
    local scroll_index = item and item:get_index()
    local target_index = scroll_index or self.v_selected_weapon_idx
    self:change_page(nil, target_index, need_dotween)
  end
end

function ui:set_scrollrect_cb()
  self.v_skin_rect_list = {}
  self.v_skin_rect_count = self.v_uicompents.SkinContent_rect.childCount
  local tf
  for index = 0, self.v_skin_rect_count - 1 do
    tf = self.v_uicompents.SkinContent_rect:GetChild(index)
    self.v_skin_rect_list[index] = self:get_rect_transform(nil, tf).component
  end
  local scroll_rect = self.v_uiobjects.Skin_Selector:GetComponent(typeof(CS.Game.ScrollRectEx))
  
  local function scroll_cb()
    self:on_scroll()
  end
  
  local function scroll_end_cb()
    self:on_scroll_end()
  end
  
  self:set_scrollrect_ex_listener(scroll_rect, nil, nil, scroll_end_cb, scroll_cb)
end

function ui:ui_on_show(buddy_id, buddy_list, fashion_id, buddy_ex_fashion_list, shop_skin_list, fade_bg, is_from_archives, show_weapon_tog, fashion_list_order_by_index, is_from_shop)
  self.v_param1 = buddy_id
  self.v_param2 = buddy_list
  self.v_param3 = fashion_id
  self.v_param4 = buddy_ex_fashion_list
  self.v_param5 = shop_skin_list
  self.v_param6 = fade_bg
  self.v_param7 = is_from_archives
  self.v_param8 = show_weapon_tog
  self.v_param9 = fashion_list_order_by_index
  self.v_param10 = is_from_shop
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
  self.v_fade_bg = fade_bg
  self:black_bg_open()
  if buddy_list then
    self.v_buddy_list = buddy_list
  elseif buddy_id then
    self.v_buddy_list = {
      [1] = buddy_id
    }
  else
    Log.Error("buddy_id and buddy_list is nil")
    return
  end
  self.v_is_from_archives = is_from_archives
  self.v_is_from_shop = is_from_shop
  self.v_uiobjects.PagBtnList:SetActive(show_weapon_tog)
  self.v_show_weapon_tog = show_weapon_tog
  self.v_buddy_ex_fashion_list = buddy_ex_fashion_list
  self.v_fashion_list_order_by_index = fashion_list_order_by_index
  if shop_skin_list then
    self.v_ex_fashion_list = shop_skin_list.skins
    self.v_gift_list = shop_skin_list.gifts
  end
  local cur_buddy_id = buddy_id or self.v_buddy_list[1]
  local cur_buddy_idx = self:init_select_buddy_idx(cur_buddy_id)
  if not cur_buddy_idx then
    Log.Error("cur select buddy idx is nil", buddy_id, buddy_list)
    return
  end
  self:init_fashion_model()
  self.v_uicompents.CharTog_tog.isOn = true
  self.v_uicompents.CharTog_tog.interactable = false
  self:refresh_buddy(cur_buddy_idx, fashion_id)
  self.v_uiobjects.AssetBar:SetActive(true)
  if self.v_gift_list then
    self:_refresh_asset()
  end
  if not self.v_init_show then
    self:_regist_client_event()
  end
  if self.v_is_from_archives then
    for _, uiname in pairs(INTERACT_BTN_TYPE) do
      self.v_uiobjects[uiname]:SetActive(false)
    end
    self:_set_jump_btn()
  end
end

function ui:refresh_weapon_list()
  self:clear_all_fashion_item()
  local weapon_id = CharacterMgr:get_weapon_id(self.v_current_buddy_id)
  local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
  local weapon_fashion_id_list = ShareRes.get_weapon_fashion_id_by_subtype(weapon_cfg.SubType) or {}
  weapon_fashion_id_list = UtilTable.copy_table(weapon_fashion_id_list)
  UtilTable.list_delete_by_func(weapon_fashion_id_list, function(weapon_fashion_id)
    local _cfg = ShareRes.get_weapon_fashion_cfg(weapon_fashion_id)
    return not _cfg or _cfg.ReleaseTime and not Date.check_time_pass_by_scheme_id(_cfg.ReleaseTime)
  end)
  table.insert(weapon_fashion_id_list, 1, weapon_id)
  local target_index = 1
  local cur_wearing_weapon_fashion_id = FashionMgr:get_wearing_weapon_fashion_id(weapon_cfg.SubType)
  local obj = self:get_auto_cache(SKIN_TEMPLETE_KEY)
  local item = WEAPON_ITEM:ui_wrap_ex(self, obj, true)
  item:set_data_by_weapon_cfg(weapon_cfg, 1)
  self.v_fashion_item_list[0] = item
  for i = 2, #weapon_fashion_id_list do
    local obj = self:get_auto_cache(SKIN_TEMPLETE_KEY)
    local item = WEAPON_ITEM:ui_wrap_ex(self, obj, true)
    local weapon_fashion_cfg = ShareRes.get_weapon_fashion_cfg(weapon_fashion_id_list[i])
    item:set_data(weapon_fashion_cfg, i)
    item:set_mask()
    self.v_fashion_item_list[weapon_fashion_id_list[i]] = item
    target_index = cur_wearing_weapon_fashion_id == weapon_fashion_id_list[i] and i or target_index
  end
  self:change_page(nil, target_index, false, true)
  self:on_scroll()
end

function ui:refresh_buddy(idx, fashion_id)
  self.v_camera_state = CAMERA_STATE.NORMAL
  self.v_current_slot_info = nil
  self.v_current_model_id = nil
  self.v_current_select_fashion_id = nil
  self.v_enbale_fashionale_list = nil
  self.v_current_buddy_id = self.v_buddy_list[idx]
  self.v_cur_select_buddy_idx = idx
  self.v_current_wearing_id = FashionMgr:get_fashion_wearing_id(self.v_current_buddy_id)
  self:init_fashion_list(fashion_id)
  self:init_sld()
  self:check_need_open_change_btn()
  self:refresh_show_spine_btn()
end

function ui:ui_on_update()
  if self.v_current_model_view then
    if self.v_camera_state == CAMERA_STATE.NEAR then
      self:_check_Scroll()
    end
    self.v_current_model_view:update()
  end
end

function ui:check_need_open_change_btn()
  if self.v_gift_cfg then
    self.v_uiobjects.BtnLastChar:SetActive(false)
    self.v_uiobjects.BtnNextChar:SetActive(false)
    return
  end
  if self.v_panel_type == PANEL_TYPE.CHARACTER then
    local right_visible = self.v_uiobjects.Right.activeInHierarchy
    local length = #self.v_buddy_list
    local need_open = length > 1
    local open_last_btn = need_open and self.v_cur_select_buddy_idx > 1 and right_visible
    local open_next_btn = need_open and length > self.v_cur_select_buddy_idx and right_visible
    self.v_uiobjects.BtnLastChar:SetActive(open_last_btn)
    self.v_uiobjects.BtnNextChar:SetActive(open_next_btn)
  end
end

function ui:init_select_buddy_idx(buddy_id)
  for idx, check_buddy_id in pairs(self.v_buddy_list) do
    if buddy_id == check_buddy_id then
      return idx
    end
  end
end

function ui:register_drag()
  local drag_obj = self.v_uiobjects.ShowChar
  Util.set_drag(drag_obj, self.v_ui_root, function(x, _)
    if not self.v_current_model_view then
      return
    end
    self.v_current_model_view:change_content_angle_y(x)
  end)
end

function ui:init_sld()
  self.v_uicompents.CharPos_sld.gameObject:SetActive(false)
  self.v_uicompents.CharPos_sld.value = 0
end

function ui:click_scale_btn()
  if not self.v_current_model_view then
    return
  end
  if self.v_camera_state == CAMERA_STATE.FAR then
    self.v_camera_state = CAMERA_STATE.NEAR
  elseif self.v_camera_state == CAMERA_STATE.NEAR then
    self.v_camera_state = CAMERA_STATE.FAR
  end
  self.v_content_root_position.y = nil
  self:refresh_scale_btn()
  self:update_scene_model(false)
end

function ui:update_scene_model(is_fast)
  self:update_content_roo_pos()
  local init_y = self.v_content_root_position and self.v_content_root_position.pos_y or 0
  self.v_current_model_view:update_scene_model_type(self.v_ui_name, self.v_camera_state, is_fast, self.v_current_select_fashion_id)
  self.v_current_model_view:change_content_pos_y(init_y)
  self.v_current_model_view:change_effect_root_pos_y(init_y)
end

function ui:refresh_scale_btn()
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  local slider = ucom.CharPos_sld
  slider.gameObject:SetActive(self.v_camera_state == CAMERA_STATE.NEAR)
  uobj.IconNear:SetActive(self.v_camera_state == CAMERA_STATE.FAR)
  uobj.IconFar:SetActive(self.v_camera_state == CAMERA_STATE.NEAR)
  local scale_txt = self.v_camera_state == CAMERA_STATE.NEAR and Util.format_str("远景") or Util.format_str("近景")
  ucom.ScaleText_txt.text = scale_txt
  slider.value = 0
end

function ui:ui_on_hide()
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  self:clear_all_fashion_item()
  if self.v_current_model_view then
    self.v_current_model_view:on_destroy()
    self.v_current_model_view = nil
  end
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:on_destroy()
    self.v_weapon_model_rt = nil
  end
  self.v_current_slot_info = nil
  self.v_current_buddy_id = nil
  self.v_cur_select_buddy_idx = nil
  self.v_current_model_id = nil
  self.v_enbale_fashionale_list = nil
  self.v_buddy_list = nil
  self.v_model_idx = nil
  self.v_buddy_ex_fashion_list = nil
  self.v_fashion_list_order_by_index = nil
  self.v_ex_fashion_list = nil
  self.v_gift_list = nil
  self.v_scroll_fashion_id = nil
  self.v_scroll_weapon_fashion_id = nil
  self.v_last_model_id = nil
  self.v_cur_model_id = nil
  self.v_content_root_position = nil
  self:clear_black_fade_open_seq()
  self:clear_black_fade_close_seq()
  self.v_asset_bar:on_hide()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
  self.v_uiobjects.BlackScreen:SetActive(false)
  self:remove_delay_close_timer()
  self.v_init_show = false
end

function ui:change_page(is_pre, force_jump_index, need_dotween, need_move)
  local target_index
  if self.v_panel_type == PANEL_TYPE.CHARACTER then
    if not self.v_selected_idx and not force_jump_index then
      return
    end
    target_index = force_jump_index or is_pre and self.v_selected_idx - 1 or self.v_selected_idx + 1
    if self.v_enbale_fashionale_list[target_index] then
      self.v_selected_idx = target_index
    end
  else
    target_index = force_jump_index or is_pre and self.v_selected_weapon_idx - 1 or self.v_selected_weapon_idx + 1
    self.v_selected_weapon_idx = target_index
  end
  if need_dotween then
    local content_x = ITEM_INTERVAL_X * (target_index - 1)
    self.v_uicompents.SkinContent_rect:DOAnchorPosX(-content_x, 0.35)
  elseif need_move then
    UnityEngineUI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.SkinContent_rect)
    local content_x = ITEM_INTERVAL_X * (target_index - 1)
    self.v_uicompents.SkinContent_rect:SetAnchoredPositionA(-content_x, self.v_content_y)
  end
  self:refresh_slot_show()
  self:refresh_slot_btn_ui()
end

function ui:change_buddy(change_type)
  self.v_selected_idx = nil
  self.v_selected_weapon_idx = nil
  local result_num
  if change_type == CHANGE_BUDDY_TYPE.LAST then
    local pre_num = self.v_cur_select_buddy_idx - 1
    if pre_num < 1 then
      return
    end
    result_num = pre_num
  else
    local next_num = self.v_cur_select_buddy_idx + 1
    local length = #self.v_buddy_list
    if next_num > length then
      return
    end
    result_num = next_num
  end
  self:refresh_buddy(result_num)
  if self.v_panel_type == PANEL_TYPE.WEAPON then
    self:refresh_weapon_list()
  end
end

function ui:get_cur_select_weapon_res()
  local weapon_res
  if 1 == self.v_selected_weapon_idx then
    local cur_fashion_cfg = self.v_enbale_fashionale_list[self.v_selected_idx]
    local cfg = all_fashionable_info[cur_fashion_cfg.Id]
    local weapon_id = self.v_weapon_all_fashion[self.v_selected_weapon_idx]
    local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
    weapon_res = weapon_cfg.ResId
  else
    local weapon_fashion_id = self.v_weapon_all_fashion[self.v_selected_weapon_idx]
    weapon_res = ShareRes.get_weapon_fashion_cfg(weapon_fashion_id).WeaponRes
  end
  return weapon_res
end

function ui:show_or_hide()
  local uiobj = self.v_uiobjects
  local visible = self.v_uiobjects.Right.activeInHierarchy
  uiobj.BtnShow:SetActive(visible)
  uiobj.CharPosContent:SetActive(visible)
  uiobj.BtnReturn:SetActive(not visible)
  uiobj.BtnMain:SetActive(not visible)
  uiobj.BtnChange:SetActive(self.v_panel_type == PANEL_TYPE.WEAPON and not visible or false)
  if self.v_show_weapon_tog then
    uiobj.PagBtnList:SetActive(not visible)
  end
  self.v_camera_state = visible and CAMERA_STATE.FAR or CAMERA_STATE.NORMAL
  self:update_scene_model(false)
  for key, obj_name in pairs(obj_name_list) do
    if 5 ~= key and 6 ~= key then
      self.v_uiobjects[obj_name]:SetActive(not visible)
    end
  end
  self:check_need_open_change_btn()
  self:refresh_scale_btn()
  self:refresh_show_spine_btn()
end

function ui:init_fashion_model()
  if self.v_current_model_view then
    return
  end
  self.v_current_model_view = NewModelRtView:new(MODEL_PARAM.BG_NAME, true, nil, true)
  self.v_camera_state = CAMERA_STATE.NORMAL
  self:update_scene_model(true)
end

function ui:refresh_fashion_model()
  local function load_npc_done_cb(npc_index)
    if not self:visible() or not self:has_inited() then
      return
    end
    self.v_current_model_view:hide_model_node(false)
    self.v_current_model_view:signboard_set_dynamic_bone_enable(true)
    local pos
    if not UtilTable.is_empty(self.v_model_cfg.EffectPosition) then
      pos = Util.VEC3_TEMP.New(table.unpack(self.v_model_cfg.EffectPosition))
    end
    self.v_current_model_view:play_act_effect(npc_index, EFFECT_NAME, nil, nil, true, pos)
    self.v_current_model_view:play_act_effect(npc_index, SWTICH_EFFECT_NAME, nil, nil, true)
    self:update_scene_model(true)
  end
  
  local cfg = all_fashionable_info[self.v_current_select_fashion_id]
  local weapon_id = CharacterMgr:get_weapon_id(self.v_current_buddy_id)
  local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
  local weapon_res = weapon_cfg.ResId
  local weapon_fashion_id = FashionMgr:get_wearing_weapon_fashion_id(weapon_cfg.SubType)
  local weapon_fashion_res = weapon_fashion_id and ShareRes.get_weapon_fashion_cfg(weapon_fashion_id).WeaponRes or nil
  local params = {
    model_id = self.v_cur_model_id,
    npc_id = self.v_current_buddy_id,
    is_reload = true,
    cb = load_npc_done_cb,
    init_anim = cfg.EnterAction or "arder_idle",
    npc_param = self:get_model_pos()
  }
  if self.v_is_from_archives then
    params.use_weapon_res = weapon_res
  else
    params.use_weapon_res = weapon_fashion_res or weapon_res
  end
  self.v_model_idx = self.v_current_model_view:load_npc(params)
  self.v_cur_wearing_weapon_res = params.use_weapon_res
  self.v_current_model_view:set_touch_area(self.v_uicompents.ShowChar_rect)
end

function ui:get_model_pos()
  local cfg
  local scene_model_cfg_list = ShareRes.get_scene_model_cfg()[self.v_ui_name]
  local scene_model_cfg = scene_model_cfg_list[self.v_cur_model_id]
  if scene_model_cfg and scene_model_cfg[self.v_camera_state] then
    cfg = scene_model_cfg[self.v_camera_state]
  else
    cfg = scene_model_cfg_list[self.v_camera_state]
  end
  if not cfg then
    Log.Error("模型设置表获取配置失败:【ui model_id type】", self.v_ui_name, self.v_cur_model_id, self.v_camera_state)
    return
  end
  return {
    pos_x = cfg.ModelPosition[1],
    pos_y = cfg.ModelPosition[2],
    pos_z = cfg.ModelPosition[3]
  }
end

function ui:update_content_roo_pos()
  local scene_model_cfg_list = ShareRes.get_scene_model_cfg()[self:ui_get_name()]
  self.v_model_cfg = scene_model_cfg_list[self.v_cur_model_id] and scene_model_cfg_list[self.v_cur_model_id][self.v_camera_state] or scene_model_cfg_list[self.v_camera_state]
  MAX_CONTENT_Y = self.v_model_cfg.FashionSliderMaxY or scene_model_cfg_list[self.v_camera_state].FashionSliderMaxY
  if self.v_model_cfg and not UtilTable.is_empty(self.v_model_cfg.ContentRootPosition) then
    local pos = self.v_model_cfg.ContentRootPosition
    self.v_content_root_position = self.v_content_root_position or {}
    self.v_content_root_position.pos_x = pos[1]
    self.v_content_root_position.pos_y = pos[2]
    self.v_content_root_position.pos_z = pos[3]
    self.v_current_model_view:set_content_pos(self.v_content_root_position)
  end
end

function ui:show_current_weapon_fashion_info()
  if not self.v_selected_weapon_idx or not self.v_weapon_all_fashion then
    return
  end
  local weapon_fashion_id = self.v_weapon_all_fashion[self.v_selected_weapon_idx]
  local weapon_fashion_cfg = ShareRes.get_weapon_fashion_cfg(weapon_fashion_id)
  local is_default_weapon
  if not weapon_fashion_cfg then
    weapon_fashion_cfg = ShareRes.create("equip.equip", weapon_fashion_id)
    is_default_weapon = true
  end
  for index, item in pairs(self.v_fashion_item_list) do
    item:set_mask()
  end
  self.v_uicompents.FashionName_txt.text = weapon_fashion_cfg.SkinName
  self.v_uicompents.BrandName_txt.text = weapon_fashion_cfg.BrandName
  local weapon_res = self:get_cur_select_weapon_res()
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:set_bg_x_offset(false)
    self.v_weapon_model_rt:change_weapon_by_weapon_res_id(weapon_res)
  else
    self.v_current_model_view:change_weapon_by_res(weapon_res)
    self.v_current_model_view:reset_init_anim(self.v_model_idx)
  end
  local is_bought = is_default_weapon or FashionMgr:has_weapon_fashion(weapon_fashion_id)
  local weapon_id = CharacterMgr:get_weapon_id(self.v_current_buddy_id)
  local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
  local cur_wearing_weapon_fashion_id = FashionMgr:get_wearing_weapon_fashion_id(weapon_cfg.SubType)
  local is_wearing = is_default_weapon and not cur_wearing_weapon_fashion_id or weapon_fashion_id == cur_wearing_weapon_fashion_id
  self.v_uiobjects.Owned:SetActive(not is_bought)
  self.v_uicompents.OwnedText_txt.text = is_bought and "已获得" or weapon_fashion_cfg.GetDesc
  local interact_type = INTERACT_TYPE.EMPTY
  local is_wearing_enable = is_bought and not is_wearing
  if is_wearing then
    interact_type = INTERACT_TYPE.IS_WEARING
  elseif is_wearing_enable then
    interact_type = INTERACT_TYPE.NOT_WEARING
  elseif weapon_fashion_cfg and Util.is_more_than_zero(weapon_fashion_cfg.JumpId) then
    interact_type = INTERACT_TYPE.NOT_HAVE
  end
  for check_type, uiname in pairs(INTERACT_BTN_TYPE) do
    self.v_uiobjects[uiname]:SetActive(interact_type == check_type)
  end
  self:_set_jump_btn(weapon_fashion_cfg, interact_type)
end

function ui:show_current_fashion_info()
  if not self.v_selected_idx then
    return
  end
  local cur_fashion_cfg = self.v_enbale_fashionale_list[self.v_selected_idx]
  if not cur_fashion_cfg or not self.v_current_model_view then
    return
  end
  for index, item in pairs(self.v_fashion_item_list) do
    item:set_mask()
  end
  self.v_uicompents.FashionName_txt.text = cur_fashion_cfg.Name
  self.v_uicompents.PainterName_txt.text = Util.format_str(cur_fashion_cfg.Painter)
  self.v_uicompents.CVName_txt.text = ShareRes.get_buddy_cv(self.v_current_buddy_id)
  local brand_id = cur_fashion_cfg.Type
  local brand_cfg = ShareRes.get_buddy_fashion_brand(brand_id)
  local brand_name = brand_cfg.TypeName
  self.v_uicompents.BrandName_txt.text = brand_name
  if self.v_last_model_id ~= cur_fashion_cfg.ModelId then
    self.v_cur_model_id = cur_fashion_cfg.ModelId
    self.v_last_model_id = cur_fashion_cfg.ModelId
  end
  self:refresh_fashion_model()
  local is_bought = FashionMgr:check_has_bought_fashion(cur_fashion_cfg.Id)
  self.v_uiobjects.Owned:SetActive(not is_bought or self.v_is_from_archives)
  self.v_uicompents.OwnedText_txt.text = is_bought and "已获得" or cur_fashion_cfg.GetDesc
  if self.v_gift_list then
    self.v_uiobjects.Owned:SetActive(true)
    self.v_uiobjects.BtnBuy:SetActive(not is_bought)
    if is_bought then
      self:_set_operate_btn(cur_fashion_cfg, true)
    else
      local gift_cfg = self.v_gift_list[self.v_selected_idx]
      for _, uiname in pairs(INTERACT_BTN_TYPE) do
        self.v_uiobjects[uiname]:SetActive(false)
      end
      self:_set_jump_btn()
      self:_set_price(gift_cfg)
    end
  else
    self.v_uiobjects.BtnBuy:SetActive(false)
    self:_set_operate_btn(cur_fashion_cfg, is_bought)
  end
  self:set_button("SkinInfo", function()
    self:click_brand_detail(cur_fashion_cfg.Id, brand_id)
  end)
end

function ui:_set_jump_btn(fashion_cfg, interact_type)
  self.v_uiobjects.ActJumpCost:SetActiveEx(false)
  if self.v_is_from_archives then
    self.v_uiobjects.BtnActJump:SetActive(false)
    self.v_uiobjects.BtnGoGet:SetActive(false)
    return
  end
  local show_jump_btn = interact_type == INTERACT_TYPE.NOT_HAVE
  local during_special_jump = nil ~= fashion_cfg and FashionMgr:check_during_special_jump(fashion_cfg)
  self.v_uiobjects.BtnActJump:SetActive(show_jump_btn and during_special_jump)
  self.v_uiobjects.BtnGoGet:SetActive(show_jump_btn and not during_special_jump)
end

function ui:_set_operate_btn(cfg_info, is_bought)
  local is_wearing = FashionMgr:get_fashion_wearing_id(self.v_current_buddy_id) == cfg_info.Id
  local is_wearing_enable = is_bought and not is_wearing
  local interact_type = INTERACT_TYPE.EMPTY
  local cfg = ShareRes.get_fashion_cfg(self.v_current_select_fashion_id)
  if is_wearing then
    interact_type = INTERACT_TYPE.IS_WEARING
  elseif is_wearing_enable then
    interact_type = INTERACT_TYPE.NOT_WEARING
  elseif cfg and Util.is_more_than_zero(cfg.JumpId) then
    interact_type = INTERACT_TYPE.NOT_HAVE
  end
  if not self.v_is_from_archives then
    for check_type, uiname in pairs(INTERACT_BTN_TYPE) do
      self.v_uiobjects[uiname]:SetActive(interact_type == check_type)
    end
    self:_set_jump_btn(cfg, interact_type)
  end
end

function ui:_set_price(gift_cfg)
  ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, Shop_Helper.get_item_icon(gift_cfg.CostItem))
  local cur_price = gift_cfg.CostItemNum
  local has_discount = gift_cfg.Discount ~= nil
  self.v_uiobjects.PriceBefore:SetActive(has_discount)
  self.v_uicompents.Price_txt.text = gift_cfg.CostItemNum
  self.v_uicompents.PriceBefore_txt.text = gift_cfg.Discount
  local is_enough = BagMgr:get_cost_enough(gift_cfg.CostItem, cur_price)
  self.v_uicompents.Price_txt.color = is_enough and enough_color or not_enough_color
end

function ui:init_fashion_list(init_select_fashion_id)
  self:clear_all_fashion_item()
  local current_buddy_all_fashion = {}
  local need_sort = true
  if self.v_buddy_ex_fashion_list and self.v_buddy_ex_fashion_list[self.v_current_buddy_id] then
    local have_fashion_list = self.v_buddy_ex_fashion_list[self.v_current_buddy_id]
    for idx, fashion_id in pairs(have_fashion_list) do
      current_buddy_all_fashion[idx] = ShareRes.get_fashion_cfg(fashion_id)
    end
  elseif self.v_ex_fashion_list then
    need_sort = false
    for idx, v in ipairs(self.v_ex_fashion_list) do
      current_buddy_all_fashion[idx] = ShareRes.get_fashion_cfg(v.Id)
    end
  else
    current_buddy_all_fashion = ShareRes.get_buddy_fashion_list(self.v_current_buddy_id)
  end
  local weapon_id = CharacterMgr:get_weapon_id(self.v_current_buddy_id)
  local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
  local weapon_sub_type = weapon_cfg.SubType
  self.v_weapon_all_fashion = ShareRes.get_weapon_fashion_id_by_subtype(weapon_sub_type) or {}
  self.v_weapon_all_fashion = UtilTable.copy_table(self.v_weapon_all_fashion)
  UtilTable.list_delete_by_func(self.v_weapon_all_fashion, function(weapon_fashion_id)
    local _cfg = ShareRes.get_weapon_fashion_cfg(weapon_fashion_id)
    return not _cfg or _cfg.ReleaseTime and not Date.check_time_pass_by_scheme_id(_cfg.ReleaseTime)
  end)
  table.insert(self.v_weapon_all_fashion, 1, weapon_id)
  self.v_slot_info = {}
  self.v_enbale_fashionale_list = UtilTable.copy_table(current_buddy_all_fashion)
  UtilTable.list_delete_by_func(self.v_enbale_fashionale_list, function(buddy_fashion_cfg)
    return buddy_fashion_cfg.ReleaseTime and not Date.check_time_pass_by_scheme_id(buddy_fashion_cfg.ReleaseTime)
  end)
  if need_sort then
    tsort(self.v_enbale_fashionale_list, fashion_cmp)
  end
  local cur_fashion_id = init_select_fashion_id or self.v_current_wearing_id
  local obj, item, fashion_id
  for index, cfg in ipairs(self.v_enbale_fashionale_list) do
    fashion_id = cfg.Id
    obj = self:get_auto_cache(SKIN_TEMPLETE_KEY)
    item = DRESS_ITEM:ui_wrap_ex(self, obj, true)
    item:set_data(cfg, index)
    item:set_discount(self.v_gift_list and self.v_gift_list[index])
    item:set_mask()
    self.v_fashion_item_list[fashion_id] = item
    if cur_fashion_id == fashion_id then
      self.v_cur_wearing_selected_idx = index
      self.v_selected_idx = index
    end
  end
  if self.v_is_from_archives then
    self.v_selected_idx = 1
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.SkinContent_rect)
  self:change_page(nil, self.v_selected_idx, false, true)
  self:on_scroll()
  self:refresh_slot_show()
  self:refresh_slot_btn_ui()
end

function ui:refresh_red_point()
  for _, item in pairs(self.v_fashion_item_list) do
    item:set_red()
  end
end

function ui:refresh_slot_show()
  self.v_selected_idx = self.v_selected_idx or 1
  local cur_fashion_cfg = self.v_enbale_fashionale_list[self.v_selected_idx]
  self.v_current_select_fashion_id = cur_fashion_cfg.Id
  self.v_current_buddy_id = cur_fashion_cfg.BuddyId
  if self.v_panel_type == PANEL_TYPE.CHARACTER then
    self:show_current_fashion_info()
  else
    self:show_current_weapon_fashion_info()
  end
end

function ui:_set_discount(item, has_buy, gift_cfg)
  local has_tag = gift_cfg.ShowTag
  item.discount_bg:SetActive(has_tag and not has_buy)
  if not has_tag then
    return
  end
  local tag_cfg = ShareRes.create("recharge.gift_tag", gift_cfg.ShowTag)
  if tag_cfg.TagBgIcon == "" then
    item.discount_bg:SetActive(false)
    return
  end
  ResMgr:load_set_icon(item.discount_bg, tag_cfg.TagBgIcon, nil, false)
  local lab = gift_cfg.Discount and string.format("%s%s", gift_cfg.Discount / 10, tag_cfg.Name) or tag_cfg.Name
  item.discount.text = lab
end

function ui:cache_ui()
  return true
end

function ui:click_brand_detail(now_fashion_id, brand_id)
  UIMgr:get_ui("ui_brand_tip"):ui_show(now_fashion_id, brand_id)
end

function ui:clear_black_fade_open_seq()
  if self.v_black_fade_open_seq then
    self.v_black_fade_open_seq:Kill(false)
    self.v_black_fade_open_seq = nil
  end
end

function ui:clear_black_fade_close_seq()
  if self.v_black_fade_close_seq then
    self.v_black_fade_close_seq:Kill(false)
    self.v_black_fade_close_seq = nil
  end
end

function ui:black_bg_close()
  local black_screen_obj = self.v_uiobjects.BlackScreen
  black_screen_obj:SetActive(true)
  self:clear_black_fade_close_seq()
  local alpha_target = black_screen_obj:GetComponent("CanvasGroup")
  alpha_target.alpha = 0
  self.v_black_fade_close_seq = Util.create_sequence()
  self.v_black_fade_close_seq:Append(alpha_target:DOFade(1, 0.1))
  self:remove_delay_close_timer()
  self.v_delay_close_timer = Timer:add_timer("delay_enter_chapter_timer", 0.1, function()
    black_screen_obj:SetActive(false)
    self:ui_hide()
  end)
end

function ui:black_bg_open()
  if not self.v_fade_bg then
    return
  end
  local black_screen_obj = self.v_uiobjects.BlackScreen
  black_screen_obj:SetActive(true)
  self:clear_black_fade_open_seq()
  local alpha_target = black_screen_obj:GetComponent("CanvasGroup")
  alpha_target.alpha = 1
  self.v_black_fade_open_seq = Util.create_sequence()
  self.v_black_fade_open_seq:Append(alpha_target:DOFade(0, 1))
  self.v_black_fade_open_seq:OnComplete(function()
    black_screen_obj:SetActive(false)
  end)
end

function ui:_refresh_asset()
  local list = Shop_Helper.get_asset_list({
    Config.GILTGOLD_ITEMID
  })
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
end

function ui:_onclick_buy_btn()
  local gift_cfg = self.v_gift_list[self.v_selected_idx]
  if not gift_cfg then
    return
  end
  if gift_cfg.CostItem and not Shop_Helper.check_cost_enough(gift_cfg.CostItem, gift_cfg.CostItemNum) then
    return
  end
  local id = gift_cfg.Id
  if gift_cfg.CostItem then
    UIMgr:get_ui("ui_buy_fashion_tips"):ui_show(gift_cfg, id)
  else
    RechargeMgr:request_buy_gift(id)
  end
end

function ui:_onclick_get_btn()
  local cur_fashion_cfg
  if self.v_panel_type == PANEL_TYPE.CHARACTER then
    cur_fashion_cfg = self.v_enbale_fashionale_list[self.v_selected_idx]
  else
    cur_fashion_cfg = ShareRes.get_weapon_fashion_cfg(self.v_scroll_weapon_fashion_id)
  end
  self.v_selected_idx = nil
  self.v_selected_weapon_idx = nil
  if FashionMgr:check_during_special_jump(cur_fashion_cfg) then
    SysOpenMgr:jump_to_sys(cur_fashion_cfg.SpecialJumpId, true)
    return
  end
  if not cur_fashion_cfg or not cur_fashion_cfg.JumpId then
    return
  end
  SysOpenMgr:jump_to_sys(cur_fashion_cfg.JumpId, true)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_param1, self.v_param2, self.v_param3, self.v_param4, self.v_param5, self.v_param6, self.v_param7, self.v_param8, self.v_param9, self.v_param10
end

function ui:_regist_client_event()
  self.v_init_show = true
  self:bind_auto_mq(Const.MSG_ON_FASHION_BUY_SUC, self._response_buy_result, self)
end

function ui:_response_buy_result()
  local cur_buddy_idx = self:init_select_buddy_idx(self.v_current_buddy_id)
  local fashion_id = self.v_current_select_fashion_id
  self:refresh_buddy(cur_buddy_idx, fashion_id)
end

function ui:refresh_slot_btn_ui()
  if self.v_panel_type == PANEL_TYPE.CHARACTER then
    self.v_uiobjects.BtnLeft:SetActive(self.v_enbale_fashionale_list[self.v_selected_idx - 1] ~= nil)
    self.v_uiobjects.BtnRight:SetActive(self.v_enbale_fashionale_list[self.v_selected_idx + 1] ~= nil)
  else
    self.v_uiobjects.BtnLeft:SetActive(self.v_weapon_all_fashion and nil ~= self.v_weapon_all_fashion[self.v_selected_weapon_idx - 1] or nil)
    self.v_uiobjects.BtnRight:SetActive(self.v_weapon_all_fashion and nil ~= self.v_weapon_all_fashion[self.v_selected_weapon_idx + 1] or nil)
  end
end

function ui:remove_delay_close_timer()
  if self.v_delay_close_timer then
    Timer:remove_timer(self.v_delay_close_timer)
    self.v_delay_close_timer = nil
  end
end

function ui:clear_all_fashion_item()
  self:give_back_auto_cache(SKIN_TEMPLETE_KEY)
  for key, item in pairs(self.v_fashion_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_fashion_item_list[key] = nil
  end
end

local AXIS = "Mouse ScrollWheel"
local PARAM = ShareRes.get_comm_string_value("CharSpineDisplayParam")
local TOUCH_SCALE_SPEED_M = PARAM and PARAM[2] or 3
local MIN_SCALE = PARAM and PARAM[3] or 0.8
local MAX_SCALE = PARAM and PARAM[4] or 2

function ui:_check_Scroll()
  if UNITY_EDITOR or UNITY_STANDALONE_WIN then
    local diff = Input.GetAxis(AXIS)
    if 0 ~= diff then
      self:_on_scrollWheel(diff * TOUCH_SCALE_SPEED_M)
    end
  end
end

function ui:_on_scrollWheel(diff)
  local init_y = self.v_content_root_position.y and self.v_content_root_position.y or 0
  local clamped_y = Math.Clamp(init_y - diff, MIN_CONTENT_Y, MAX_CONTENT_Y)
  self.v_current_model_view:change_content_pos_y(clamped_y)
  self.v_current_model_view:change_effect_root_pos_y(clamped_y)
  local scroll_value = (clamped_y - MIN_CONTENT_Y) / (MAX_CONTENT_Y - MIN_CONTENT_Y)
  self.v_uicompents.CharPos_sld.value = scroll_value
  self.v_content_root_position.y = clamped_y
end

return ui
