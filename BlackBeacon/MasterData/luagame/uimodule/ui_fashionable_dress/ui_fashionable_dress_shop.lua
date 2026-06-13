local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SKIN_TEMPLETE_KEY = "SKIN_TEMPLETE_KEY_SHOP"
local DRESS_ITEM = require("uimodule.ui_fashionable_dress.ui_fashionable_dress_item")
local WEAPON_ITEM = require("uimodule.ui_fashionable_dress.ui_fashionable_weapon_item")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local NewModelRtView = require("ui.model_rt_view.signboard_rt_view_new")
local WeaponModelRtView = require("ui.model_rt_view.model_rt_weapon_view")
local all_fashionable_info = ShareRes.create("buddy.buddy_fashion")
local ShopCfg = require("uimodule.shop.shop_config")
local Shop_Helper = require("uimodule.shop.shop_helper")
local Math = require("base.mathx")
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
local INTERACT_BTN_TYPE = {
  [INTERACT_TYPE.IS_WEARING] = "IsWearing",
  [INTERACT_TYPE.NOT_WEARING] = "BtnWear",
  [INTERACT_TYPE.NOT_HAVE] = "BtnGoGet"
}
local CAMERA_STATE = {
  NORMAL = 1,
  FAR = 2,
  NEAR = 3
}
local PANEL_TYPE = {BUDDY_FASHION = 1, WEAPON_FASHION = 2}
local PAGE_TYPE = {
  CHARACTER = 1,
  WEAPON_FROM_SUIT = 2,
  WEAPON_ONLY = 3
}
local MIN_CONTENT_Y = 0
local MAX_CONTENT_Y = 0.7
local enough_color = Util.get_unity_color_by_hex(tonumber("634C28", 16))
local not_enough_color = Util.CommonColor_RedWarm
local MODEL_PARAM = MODEL_CONFIG.UI_FASHION_MODEL_PARAM

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    if not self.v_fade_bg then
      self:ui_hide()
    else
      self:black_bg_close()
    end
  end)
  self:set_button("BtnHide", function()
    self:show_or_hide()
  end)
  self:set_button("BtnShow", function()
    self:show_or_hide()
  end)
  self:set_button("BtnShowSpine", function()
    UIMgr:get_ui("char_spine_display"):ui_show(self.v_current_buddy_id, self.v_buddy_fashion_id)
  end)
  self:set_button("BtnWear", function()
    self:_on_click_wear()
  end)
  self:set_button("BtnBuy", function()
    self:_on_click_buy()
  end)
  self:set_scrollrect_listener(self.v_uicompents.CharPos_sld, function()
    self:_on_slider_change()
  end)
  self:set_button("CharScaleBtn", function()
    self:_on_click_scale()
  end)
  self:set_button("BtnGoGet", function()
    self:_on_click_get()
  end)
  self:set_button("BtnActJump", function()
    self:_on_click_get()
  end)
  self:set_toggle("CharTog", function(is_on)
    if is_on then
      self:_on_click_char_tog()
    end
  end)
  self:set_toggle("WeaponTog", function(is_on)
    if is_on then
      self:_on_click_weapon_tog()
    end
  end)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self.v_content_y = self.v_uicompents.SkinContent_rect.anchoredPosition.y
  self:register_exist_auto_template(SKIN_TEMPLETE_KEY, self.v_uiobjects.Skin, self.v_uiobjects.SkinContent)
end

function ui:_on_click_wear()
  if self.v_cur_page == PAGE_TYPE.CHARACTER then
    FashionMgr:protect_change_fashion_request(self.v_buddy_fashion_id, function()
      self:refresh_info_view()
    end)
  elseif self.v_cur_page == PAGE_TYPE.WEAPON_FROM_SUIT then
    FashionMgr:protect_change_equip_fashion(self.v_weapon_fashion_id, function()
      self:refresh_info_view()
    end)
  elseif self.v_cur_page == PAGE_TYPE.WEAPON_ONLY then
    FashionMgr:protect_change_equip_fashion(self.v_weapon_fashion_id, function()
      self:refresh_info_view()
    end)
  end
end

function ui:_on_click_buy()
  local gift_cfg = self.v_gift_cfg
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

function ui:_on_slider_change()
  if not self.v_uicompents.CharPos_sld.gameObject.activeSelf then
    return
  end
  if not self.v_current_model_view then
    return
  end
  local init_y = self.v_content_root_postion and self.v_content_root_postion.pos_y or 0
  local y = Math.lerp_number(MIN_CONTENT_Y + init_y, MAX_CONTENT_Y + init_y, self.v_uicompents.CharPos_sld.value)
  self.v_current_model_view:change_content_pos_y(y)
  self.v_current_model_view:change_effect_root_pos_y(y)
end

function ui:_on_click_scale()
  if not self.v_current_model_view then
    return
  end
  if self.v_camera_state == CAMERA_STATE.FAR then
    self.v_camera_state = CAMERA_STATE.NEAR
  elseif self.v_camera_state == CAMERA_STATE.NEAR then
    self.v_camera_state = CAMERA_STATE.FAR
  end
  self:refresh_scale_btn()
  self:update_fashion_model_pos(false)
end

function ui:_on_click_get()
  local fashion_cfg
  if self.v_panel_type == PANEL_TYPE.BUDDY_FASHION then
    fashion_cfg = ShareRes.get_fashion_cfg(self.v_buddy_fashion_id)
  else
    fashion_cfg = ShareRes.get_weapon_fashion_cfg(self.v_weapon_fashion_id)
  end
  if FashionMgr:check_during_special_jump(fashion_cfg) then
    SysOpenMgr:jump_to_sys(fashion_cfg.SpecialJumpId, true)
    return
  end
  if not fashion_cfg or not fashion_cfg.JumpId then
    return
  end
  SysOpenMgr:jump_to_sys(fashion_cfg.JumpId, true)
end

function ui:_on_click_char_tog()
  self.v_uicompents.CharTog_tog.interactable = false
  self.v_uicompents.WeaponTog_tog.interactable = true
  if self.v_cur_page == PAGE_TYPE.CHARACTER then
    return
  end
  self:reset_buddy_view()
end

function ui:_on_click_weapon_tog()
  self.v_uicompents.WeaponTog_tog.interactable = false
  self.v_uicompents.CharTog_tog.interactable = true
  if self.v_cur_page == PAGE_TYPE.WEAPON then
    return
  end
  self:reset_weapon_view()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_buddy_fashion_id, self.v_weapon_fashion_id, self.v_gift_cfg
end

function ui:ui_on_show(buddy_fashion_id, weapon_fashion_id, gift_cfg)
  if not ((not buddy_fashion_id or not weapon_fashion_id) and (buddy_fashion_id or weapon_fashion_id)) or not gift_cfg then
    Log.Error("商城进入时装展示界面传参错误", buddy_fashion_id, "/", weapon_fashion_id, "/", gift_cfg)
    return
  end
  self.v_buddy_fashion_id = buddy_fashion_id
  self.v_suit_weapon_fashion_id = nil
  self.v_weapon_fashion_id = weapon_fashion_id
  self.v_gift_cfg = gift_cfg
  self.v_panel_type = nil ~= buddy_fashion_id and PANEL_TYPE.BUDDY_FASHION or PANEL_TYPE.WEAPON_FASHION
  self.v_cur_page = self.v_panel_type == PANEL_TYPE.BUDDY_FASHION and PAGE_TYPE.CHARACTER or PAGE_TYPE.WEAPON_ONLY
  self.v_show_tog = false
  if buddy_fashion_id then
    local fashion_cfg = ShareRes.get_fashion_cfg(buddy_fashion_id)
    self.v_suit_weapon_fashion_id = fashion_cfg.WeaponFashionId
    self.v_show_tog = self.v_suit_weapon_fashion_id ~= nil
  end
  self.v_uiobjects.PagBtnList:SetActive(self.v_show_tog)
  self.v_uiobjects.BtnLastChar:SetActive(false)
  self.v_uiobjects.BtnNextChar:SetActive(false)
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
  self:init_tog_selected()
  self:init_rt_view()
  self:refresh_info_view()
  self:black_bg_open()
  self:_refresh_asset()
  self:bind_auto_mq(Const.MSG_ON_GIFT_INFO_UPDATE, self.refresh_info_view, self)
end

function ui:init_tog_selected()
  if not self.v_show_tog then
    return
  end
  local is_show_char = self.v_cur_page == PAGE_TYPE.CHARACTER
  self.v_uicompents.CharTog_tog.isOn = is_show_char
  self.v_uicompents.WeaponTog_tog.isOn = not is_show_char
  self.v_uicompents.CharTog_tog.interactable = not is_show_char
  self.v_uicompents.WeaponTog_tog.interactable = is_show_char
end

function ui:_refresh_asset()
  local list = Shop_Helper.get_asset_list({
    Config.GILTGOLD_ITEMID
  })
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
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

function ui:black_bg_close()
  local black_screen_obj = self.v_uiobjects.BlackScreen
  black_screen_obj:SetActive(true)
  self:clear_black_fade_close_seq()
  local alpha_target = black_screen_obj:GetComponent("CanvasGroup")
  alpha_target.alpha = 0
  self.v_black_fade_close_seq = Util.create_sequence()
  self.v_black_fade_close_seq:Append(alpha_target:DOFade(1, 0.5))
  self:remove_delay_close_timer()
  self.v_delay_close_timer = Timer:add_timer("delay_enter_chapter_timer", 0.5, function()
    black_screen_obj:SetActive(false)
    self:ui_hide()
  end)
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

function ui:remove_delay_close_timer()
  if self.v_delay_close_timer then
    Timer:remove_timer(self.v_delay_close_timer)
    self.v_delay_close_timer = nil
  end
end

function ui:refresh_show_spine_btn()
  local big_spine_id, simple_spine_id
  if self.v_panel_type == PANEL_TYPE.BUDDY_FASHION and self.v_cur_page == PAGE_TYPE.CHARACTER then
    big_spine_id = UtilUI.get_hero_display_big_spine(self.v_current_buddy_id, self.v_buddy_fashion_id)
    simple_spine_id = UtilUI.get_hero_display_simple_spine(self.v_current_buddy_id, self.v_buddy_fashion_id)
  end
  local is_show_scale_view = self.v_uiobjects.CharPosContent.activeSelf
  self.v_uiobjects.BtnShowSpine:SetActive(not is_show_scale_view and (nil ~= big_spine_id or nil ~= simple_spine_id))
end

function ui:init_rt_view()
  if self.v_cur_page == PAGE_TYPE.CHARACTER then
    self:reset_buddy_view()
  else
    self:reset_weapon_view()
  end
end

function ui:reset_buddy_view()
  self.v_cur_page = PAGE_TYPE.CHARACTER
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:set_visible(false)
  end
  self.v_camera_state = CAMERA_STATE.NORMAL
  if not self.v_current_model_view then
    self.v_current_model_view = NewModelRtView:new(MODEL_PARAM.BG_NAME, true, nil, true)
    self:load_fashion_model()
  else
    self.v_current_model_view:set_visible(true)
    self.v_current_model_view:reset_init_anim(self.v_model_idx)
  end
  self:update_fashion_model_pos(true)
  self.v_uiobjects.BtnHide:SetActive(true)
  self.v_uiobjects.BtnShow:SetActive(false)
  self.v_uiobjects.BtnChange:SetActive(false)
  self:refresh_show_spine_btn()
end

function ui:reset_weapon_view()
  self.v_cur_page = PAGE_TYPE.WEAPON_ONLY
  if self.v_current_model_view then
    self.v_current_model_view:set_visible(false)
  end
  if not self.v_weapon_model_rt then
    self.v_weapon_model_rt = WeaponModelRtView:new(nil, false, nil, nil, true, "UIModelRtViewWeapon")
    self.v_weapon_model_rt:set_x_offset()
  end
  self.v_weapon_model_rt:set_visible(true)
  self.v_weapon_model_rt:init_weapon_info_by_res_id(self:get_cur_select_weapon_res())
  self.v_uiobjects.BtnHide:SetActive(false)
  self.v_uiobjects.BtnShow:SetActive(false)
  self.v_uiobjects.BtnChange:SetActive(false)
  self:refresh_show_spine_btn()
end

function ui:get_cur_select_weapon_res()
  local weapon_fashion_id = self.v_suit_weapon_fashion_id or self.v_weapon_fashion_id
  local weapon_fashion_cfg = weapon_fashion_id and ShareRes.get_weapon_fashion_cfg(weapon_fashion_id)
  if not weapon_fashion_cfg then
    Log.Error("获取武器时装配置失败，武器时装ID=", weapon_fashion_id)
    return
  end
  return weapon_fashion_cfg.WeaponRes
end

function ui:clear_all_rt_view()
  if self.v_current_model_view then
    self.v_current_model_view:on_destroy()
    self.v_current_model_view = nil
  end
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:on_destroy()
    self.v_weapon_model_rt = nil
  end
end

function ui:load_fashion_model()
  local function load_npc_done_cb(npc_index)
    if not self:visible() or not self:has_inited() then
      return
    end
    self.v_current_model_view:hide_model_node(false)
    self.v_current_model_view:signboard_set_dynamic_bone_enable(true)
    self:update_fashion_model_pos(true)
    local pos
    if not UtilTable.is_empty(self.v_model_cfg.EffectPosition) then
      pos = Util.VEC3_TEMP.New(table.unpack(self.v_model_cfg.EffectPosition))
    end
    self.v_current_model_view:play_act_effect(npc_index, EFFECT_NAME, nil, nil, true, pos)
    self.v_current_model_view:play_act_effect(npc_index, SWTICH_EFFECT_NAME, nil, nil, true)
  end
  
  local fashion_cfg = ShareRes.get_fashion_cfg(self.v_buddy_fashion_id)
  local buddy_id = fashion_cfg.BuddyId
  local model_id = fashion_cfg.ModelId
  self.v_cur_model_id = model_id
  local weapon_id = CharacterMgr:get_weapon_id(buddy_id)
  local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
  local params = {
    model_id = model_id,
    npc_id = buddy_id,
    is_reload = true,
    cb = load_npc_done_cb,
    init_anim = fashion_cfg.EnterAction or "arder_idle",
    npc_param = self:get_model_pos(),
    use_weapon_res = weapon_cfg.ResId
  }
  self.v_model_idx = self.v_current_model_view:load_npc(params)
  self.v_current_model_view:set_touch_area(self.v_uicompents.ShowChar_rect)
end

function ui:get_model_pos()
  local cfg
  local scene_model_cfg_list = ShareRes.get_scene_model_cfg().ui_fashionable_dress
  local scene_model_cfg = scene_model_cfg_list[self.v_cur_model_id]
  if scene_model_cfg and scene_model_cfg[self.v_camera_state] then
    cfg = scene_model_cfg[self.v_camera_state]
  else
    cfg = scene_model_cfg_list[self.v_camera_state]
  end
  if not cfg then
    Log.Error("模型设置表获取配置失败:【ui model_id type】ui_fashionable_dress", self.v_cur_model_id, self.v_camera_state)
    return
  end
  return {
    pos_x = cfg.ModelPosition[1],
    pos_y = cfg.ModelPosition[2],
    pos_z = cfg.ModelPosition[3]
  }
end

function ui:update_fashion_model_pos(is_fast)
  if not self.v_current_model_view then
    return
  end
  self:update_content_roo_pos()
  local init_y = self.v_content_root_postion and self.v_content_root_postion.pos_y or 0
  self.v_current_model_view:update_scene_model_type("ui_fashionable_dress", self.v_camera_state, is_fast, self.v_buddy_fashion_id)
  self.v_current_model_view:change_content_pos_y(init_y)
  self.v_current_model_view:change_effect_root_pos_y(init_y)
end

function ui:update_content_roo_pos()
  local scene_model_cfg_list = ShareRes.get_scene_model_cfg().ui_fashionable_dress
  self.v_model_cfg = scene_model_cfg_list[self.v_cur_model_id] and scene_model_cfg_list[self.v_cur_model_id][self.v_camera_state] or scene_model_cfg_list[self.v_camera_state]
  MAX_CONTENT_Y = self.v_model_cfg.FashionSliderMaxY or scene_model_cfg_list[self.v_camera_state].FashionSliderMaxY
  if self.v_current_model_view and self.v_model_cfg and not UtilTable.is_empty(self.v_model_cfg.ContentRootPosition) then
    local pos = self.v_model_cfg.ContentRootPosition
    self.v_content_root_postion = self.v_content_root_postion or {}
    self.v_content_root_postion.pos_x = pos[1]
    self.v_content_root_postion.pos_y = pos[2]
    self.v_content_root_postion.pos_z = pos[3]
    self.v_current_model_view:set_content_pos(self.v_content_root_postion)
  end
end

function ui:ui_on_update()
  if self.v_current_model_view then
    self.v_current_model_view:update()
  end
end

function ui:refresh_buddy_slot_item()
  if self.v_weapon_slot_item then
    self.v_weapon_slot_item:set_enable(false)
  end
  if not self.v_buddy_slot_item then
    local obj = self:get_auto_cache(SKIN_TEMPLETE_KEY)
    self.v_buddy_slot_item = DRESS_ITEM:ui_wrap_ex(self, obj)
  end
  self.v_buddy_slot_item:set_enable(true)
  local fashion_cfg = ShareRes.get_fashion_cfg(self.v_buddy_fashion_id)
  self.v_buddy_slot_item:set_data(fashion_cfg)
end

function ui:refresh_weapon_slot_item()
  if self.v_buddy_slot_item then
    self.v_buddy_slot_item:set_enable(false)
  end
  if not self.v_weapon_slot_item then
    local obj = self:get_auto_cache(SKIN_TEMPLETE_KEY)
    self.v_weapon_slot_item = WEAPON_ITEM:ui_wrap_ex(self, obj)
  end
  self.v_weapon_slot_item:set_enable(true)
  local weapon_fashion_id = self.v_suit_weapon_fashion_id or self.v_weapon_fashion_id
  local weapon_fashion_cfg = ShareRes.get_weapon_fashion_cfg(weapon_fashion_id)
  self.v_weapon_slot_item:set_data(weapon_fashion_cfg)
end

function ui:clear_all_slot_item()
  if self.v_buddy_slot_item then
    self.v_buddy_slot_item:ui_hide()
    self.v_buddy_slot_item:ui_destroy()
    self.v_buddy_slot_item = nil
  end
  if self.v_weapon_slot_item then
    self.v_weapon_slot_item:ui_hide()
    self.v_weapon_slot_item:ui_destroy()
    self.v_weapon_slot_item = nil
  end
end

function ui:refresh_info_view()
  if self.v_panel_type == PANEL_TYPE.BUDDY_FASHION then
    self:refresh_buddy_slot_item()
    self:show_current_fashion_info()
  elseif self.v_panel_type == PANEL_TYPE.WEAPON_FASHION then
    self:refresh_weapon_slot_item()
    self:show_current_weapon_fashion_info()
  end
end

function ui:show_current_fashion_info()
  local cur_fashion_cfg = self.v_buddy_fashion_id and ShareRes.get_fashion_cfg(self.v_buddy_fashion_id)
  if not cur_fashion_cfg then
    return
  end
  self.v_uicompents.FashionName_txt.text = cur_fashion_cfg.Name
  local brand_id = cur_fashion_cfg.Type
  local brand_cfg = ShareRes.get_buddy_fashion_brand(brand_id)
  self.v_uicompents.BrandName_txt.text = brand_cfg and brand_cfg.TypeName
  local is_wearing = FashionMgr:check_wearing_fashion(cur_fashion_cfg.Id)
  local is_own = FashionMgr:check_has_bought_fashion(cur_fashion_cfg.Id)
  self:refresh_operate_btn_state(is_wearing, is_own, cur_fashion_cfg)
end

function ui:show_current_weapon_fashion_info()
  local weapon_fashion_cfg = self.v_weapon_fashion_id and ShareRes.get_weapon_fashion_cfg(self.v_weapon_fashion_id)
  if not weapon_fashion_cfg then
    return
  end
  self.v_uicompents.FashionName_txt.text = weapon_fashion_cfg.Name
  self.v_uicompents.BrandName_txt.text = weapon_fashion_cfg.BrandName
  local is_wearing = FashionMgr:check_wearing_weapon_fashion(self.v_weapon_fashion_id)
  local is_own = FashionMgr:has_weapon_fashion(self.v_weapon_fashion_id)
  self:refresh_operate_btn_state(is_wearing, is_own, weapon_fashion_cfg)
end

function ui:refresh_operate_btn_state(is_wearing, is_own, fashion_cfg)
  local gift_sold_out = self.v_gift_cfg ~= nil and Shop_Helper.check_sold_out(self.v_gift_cfg)
  local during_special_jump = FashionMgr:check_during_special_jump(fashion_cfg)
  local show_wear_btn = is_own and not is_wearing
  local show_special_jump_btn = not is_own and nil ~= fashion_cfg.SpecialJumpId and during_special_jump
  local show_jump_btn = not is_own and nil ~= fashion_cfg.JumpId and not during_special_jump
  local show_buy_btn = not is_own and not gift_sold_out and not show_special_jump_btn
  local show_own_state_txt = not show_special_jump_btn
  local uiobj = self.v_uiobjects
  uiobj.IsWearing:SetActiveEx(is_wearing)
  uiobj.BtnWear:SetActiveEx(show_wear_btn)
  uiobj.BtnGoGet:SetActiveEx(show_jump_btn)
  uiobj.BtnBuy:SetActiveEx(show_buy_btn)
  uiobj.BtnActJump:SetActiveEx(show_special_jump_btn)
  uiobj.ActJumpCost:SetActiveEx(true)
  uiobj.Owned:SetActiveEx(show_own_state_txt)
  if show_buy_btn then
    self:_set_price(self.v_gift_cfg)
  elseif show_special_jump_btn then
    self:_set_price_for_jump(self.v_gift_cfg)
  end
  if show_own_state_txt then
    self.v_uicompents.OwnedText_txt.text = is_own and "已获得" or fashion_cfg.GetDesc
  end
end

function ui:_set_price(gift_cfg)
  local icon_path = Shop_Helper.get_item_icon(gift_cfg.CostItem)
  ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, icon_path)
  local cur_price = gift_cfg.CostItemNum
  local has_discount = gift_cfg.Discount ~= nil
  self.v_uiobjects.PriceBefore:SetActive(has_discount)
  self.v_uicompents.Price_txt.text = gift_cfg.CostItemNum
  self.v_uicompents.PriceBefore_txt.text = gift_cfg.Discount
  ResMgr:load_set_icon(self.v_uicompents.CurrIcon_Jump_img, icon_path)
  self.v_uicompents.Price_Jump_txt.text = gift_cfg.Discount or gift_cfg.CostItemNum
  local is_enough = BagMgr:get_cost_enough(gift_cfg.CostItem, cur_price)
  self.v_uicompents.Price_txt.color = is_enough and enough_color or not_enough_color
end

function ui:_set_price_for_jump(gift_cfg)
  ResMgr:load_set_icon(self.v_uicompents.CurrIcon_Jump_img, Shop_Helper.get_item_icon(gift_cfg.CostItem))
  self.v_uicompents.Price_Jump_txt.text = gift_cfg.Discount or gift_cfg.CostItemNum
end

function ui:ui_on_hide()
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  self:clear_all_rt_view()
  self:clear_all_slot_item()
  self:clear_black_fade_open_seq()
  self:clear_black_fade_close_seq()
  self:remove_delay_close_timer()
  self.v_asset_bar:on_hide()
  self.v_uiobjects.BlackScreen:SetActive(false)
end

function ui:show_or_hide()
  local uiobj = self.v_uiobjects
  local visible = self.v_uiobjects.Right.activeInHierarchy
  uiobj.BtnReturn:SetActive(not visible)
  uiobj.BtnMain:SetActive(not visible)
  uiobj.BtnHide:SetActive(not visible)
  uiobj.BtnShow:SetActive(visible)
  uiobj.CharPosContent:SetActive(visible)
  uiobj.Right:SetActive(not visible)
  uiobj.SkinInfo:SetActive(not visible)
  uiobj.Bg:SetActive(not visible)
  if self.v_show_tog then
    uiobj.PagBtnList:SetActive(not visible)
  end
  self.v_camera_state = visible and CAMERA_STATE.FAR or CAMERA_STATE.NORMAL
  self:update_fashion_model_pos(false)
  if visible then
    self:refresh_scale_btn()
    uiobj.BtnShowSpine:SetActive(false)
  else
    self:refresh_show_spine_btn()
  end
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

return ui
