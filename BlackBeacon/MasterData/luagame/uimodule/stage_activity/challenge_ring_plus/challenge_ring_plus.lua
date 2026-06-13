local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CURSE_OBJ_CALSS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local ITEM_ICON_PATH = "Icon/BattleItem/%s"
local asset_bar_config = {
  {
    item_id = Config.CURSE_GOLD,
    const_event = Const.MSG_ON_FIGHT_DIAMOND_UPDATE,
    is_fight_bag = true,
    not_show_max = true,
    bg_click = false
  }
}
local AssetBarView = require("ui.asset_bar.asset_bar")
local BloodHelper = require("uimodule/fight/blood_helper")
local CURSE_RING_CURRENCY = 541000

function ui:ui_finish_load()
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_bar_config)
  self.v_particle_tf_list = {}
  for index = 1, 10 do
    table.insert(self.v_particle_tf_list, self.v_uiobjects["Particle" .. index].transform)
  end
  self.v_uiobjects.ParticleNode:SetActive(false)
  self:set_button("QuitObj", function()
    self:on_click_quit_btn()
  end)
  self:set_button("NextFloorBtn", function()
    self:on_click_next_floor_btn()
  end)
  self:set_button("BtnEscapeLeft", function()
    if not self.v_ring_card_view:is_play_anim() and not ChallengeRingPlusMgr:is_selecting_card() then
      local card_cfg = self.v_ring_card_view:get_card_cfg(true)
      if ChallengeRingPlusMgr:is_achieve_total_limit() and card_cfg.CurseValue and 0 ~= card_cfg.CurseValue then
        Util.show_message_tip(2065)
      end
      ChallengeRingPlusMgr:set_skip_card_add_curse_value(card_cfg.CurseValue)
      ChallengeRingPlusMgr:req_skip_card(1)
    end
  end)
  self:set_button("BtnEscapeRight", function()
    if not self.v_ring_card_view:is_play_anim() and not ChallengeRingPlusMgr:is_selecting_card() then
      local card_cfg = self.v_ring_card_view:get_card_cfg(false)
      if ChallengeRingPlusMgr:is_achieve_total_limit() and card_cfg.CurseValue and 0 ~= card_cfg.CurseValue then
        Util.show_message_tip(2065)
      end
      ChallengeRingPlusMgr:set_skip_card_add_curse_value(card_cfg.CurseValue)
      ChallengeRingPlusMgr:req_skip_card()
    end
  end)
  self:set_button("BtnRet", function()
    if self.v_need_restart_back_timer then
      self:start_back_ring_timer()
    end
    self:ui_hide()
  end)
  self:set_button("Button_rune", function()
    if not self.v_ring_card_view:is_play_anim() then
      UIMgr:get_ui("battle_bag4"):ui_show()
    end
  end)
  self:set_button("SettingObj", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  self:set_button("Close_OrnTips_Btn", function()
    self:close_ornament_tip()
    self:close_task_tip()
  end)
  self:set_button("BtnTask", function()
    if not self.v_ring_card_view:is_play_anim() then
      self:open_task_room()
    end
  end)
  self.v_template_key = "current_item" .. self:ui_get_name()
  self.v_currency_list = {}
end

function ui:click_bless_item(select_index)
  local bless_data = self.v_bless_list[select_index]
  if bless_data and not bless_data.is_lock and bless_data.bless_id and 0 ~= bless_data.bless_id then
    local bless_cfg = ChallengeRingPlusMgr:get_bless_lv_cfg(bless_data.bless_id, bless_data.bless_lv)
    local content_pos = {pos_x = 567, pos_y = 95}
    local show_info = {
      name = bless_cfg.Name,
      desc = "<color=#FCBA00>" .. bless_cfg.Desc .. "</color>",
      icon_path = bless_cfg.Icon,
      is_hide_effct_desc = true
    }
    UIMgr:get_ui("curse_ring_tips"):ui_show(content_pos, show_info)
  end
end

function ui:close_ornament_tip()
  if self.v_select_index then
    self.v_uiobjects["Select" .. self.v_select_index]:SetActive(false)
    self.v_uiobjects.Orntips:SetActive(false)
    self.v_uiobjects.Close_OrnTips_Btn:SetActive(false)
    self.v_select_index = nil
  end
end

function ui:close_task_tip()
  self.v_uiobjects.TaskTips:SetActive(false)
  self.v_uiobjects.Close_OrnTips_Btn:SetActive(false)
end

function ui:ui_on_show()
  self.v_asset_bar:on_create()
  self:refresh_view()
end

function ui:refresh_view()
  ChallengeRingPlusMgr:set_is_show_card_plus(false)
  UIMgr:try_show_ui("curse_ring_hero_tip", "refresh_data")
  UIMgr:try_hide_ui("ui_battle_item")
  self.v_need_restart_back_timer = ChallengeRingPlusMgr:check_remove_back_ring_timer()
  self:refresh_data()
  if ChallengeRingPlusMgr:is_in_curse_fighting() then
    self.v_uiobjects.Button_rune:SetActive(false)
  else
    self.v_uiobjects.Button_rune:SetActive(true)
  end
end

function ui:refresh_data()
  self:init_event()
  BloodHelper.ignore(true)
  local ui = UIMgr:try_get_visible_ui("uidynamic_canvas")
  if ui then
    ui.v_object:SetActive(false)
  end
  self:set_pnl_data()
  self.v_curse_view = CURSE_OBJ_CALSS:ui_wrap(self, self.v_uiobjects.CurseObj, false)
  UIMgr:set_world_camera_visible_state(true)
  self.v_ring_card_view = UIMgr:get_ui("curse_ring_card")
  self.v_ring_card_view:ui_show()
  self.v_curse_view:set_enable(true)
  self:check_escape_btn_show_state()
  self:set_pnl_not_click(false)
  self:set_lock_state()
  self:refresh_point_info()
  self:refersh_no_card()
end

function ui:refresh_point_info()
  local progress = TowerMgr:get_tower_progress()
  local point_id = progress.episode_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
  self.v_uicompents.FloorNow_txt.text = progress.floor_id
  self.v_uicompents.FloorMax_txt.text = ShareRes.get_curse_max_floor_num(progress.tower_id)
  local item_cfg = UtilUI.get_item_cfg(CURSE_RING_CURRENCY)
  local path = UtilUI.get_item_icon(CURSE_RING_CURRENCY)
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, path)
  self.v_uicompents.ItemName_txt.text = item_cfg.Name
  self.v_uicompents.ItemNum_txt.text = " +" .. FightBagMgr:get_item_num_by_id(CURSE_RING_CURRENCY)
  local text = ChallengeRingPlusMgr:is_end_ring() and "通关结算" or "深入命运"
  self.v_uicompents.UnLockText_txt.text = text
  self.v_uicompents.LockText_txt.text = text
  local card_count = ChallengeRingPlusMgr:get_show_card_index_list_num()
  self.v_uicompents.LessRoomNum_txt.text = card_count
  self.v_uiobjects.LessRoom:SetActive(card_count > 2)
  local suc_task_count = ChallengeRingPlusMgr:get_curse_task_count()
  self.v_uicompents.TaskNum_txt.text = Util.format_str(string.format("查看目标(%s)", suc_task_count))
  self.v_uiobjects.TaskRed:SetActive(ChallengeRingPlusMgr:check_have_curse_task_complete())
end

function ui:set_pnl_not_click(is_click)
  self.v_uiobjects.NoClick:SetActive(is_click)
end

function ui:set_lock_state()
  local is_open = ChallengeRingPlusMgr:is_door_open() and ChallengeRingPlusMgr:get_remove_card_data() == nil
  self:open_unlock_icon(is_open)
end

function ui:init_event()
  self:bind_auto_mq(Const.MSG_ON_CURSE_RING_CARD_REMOVE_DATA_UPDATE, self.check_escape_btn_show_state, self)
  self:bind_auto_mq(Const.MSG_CURSE_UPDATE, self.update_curse_activate_view, self)
  self:bind_auto_mq(Const.MSG_ON_SYNC_FIGHT_PROGRESS, self.refresh_point_info, self)
end

function ui:set_currency(obj, index)
  if nil == obj then
    Log.Error("获取货币item对象失败！！！")
    return
  end
  obj:SetActive(true)
  local data = bagConfig.SHOW_CURRENCY[index]
  local cfg = FightBagMgr:get_cfg_by_id(data)
  local moneyIcon = self:get_image("Label", obj)
  ResMgr:load_set_icon(moneyIcon, string.format(ITEM_ICON_PATH, cfg.Icon))
  local moneyNum = self:get_text("Aomunt", obj)
  moneyNum.text = CharacterMgr:get_res_val(data)
end

function ui:set_pnl_data()
  local ornaments_list = BattleOrnamentMgr:get_ornaments_list()
  if not ornaments_list then
    return
  end
  self.v_ornaments_list = UtilTable.copy_table(ornaments_list)
end

function ui:set_ornaments_icon(bg_img, icon_img, ornament_id)
  local ornament_cfg = ShareRes.create("item.ornaments", ornament_id)
  if not ornament_cfg and ornament_id then
    Log.Error("饰品表中没有ID为：", ornament_id, "的配置信息")
  end
  local icon_path = string.format(ITEM_ICON_PATH, ornament_cfg.Icon)
  ResMgr:load_set_icon(icon_img, icon_path)
  ResMgr:load_set_icon(bg_img, BattleOrnamentMgr:get_ornament_bg_icon(ornament_cfg.Quality))
end

function ui:update_jump_card_pro()
  local jump_pro = ChallengeRingPlusMgr:get_jump_card_pro()
  self.v_uicompents.SuccessRate_txt.text = math.floor(jump_pro * 100) .. "%"
  if math.floor(jump_pro) > 50 then
    self.v_uicompents.Escape_img.color = Util.get_unity_color_by_hex("1f725d", 16)
  else
    self.v_uicompents.Escape_img.color = Util.get_unity_color_by_hex("721F1F", 16)
  end
end

function ui:cache_ui()
  return true
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
  UIMgr:try_hide_ui("curse_ring_hero_tip")
  self.v_ring_card_view:set_is_play_anim(false)
  for key, particle_tf in pairs(self.v_particle_tf_list) do
    particle_tf.gameObject:SetActive(false)
  end
  if self.v_particle_sequence then
    self.v_particle_sequence:Kill(false)
    self.v_particle_sequence = nil
  end
  BloodHelper.ignore(false)
  self.v_currency_list = {}
  UIMgr:set_world_camera_visible_state(false)
  self.v_curse_view:ui_destroy()
  local ui = UIMgr:try_get_visible_ui("uidynamic_canvas")
  if ui then
    ui.v_object:SetActive(true)
  end
  UIMgr:try_hide_ui("curse_ring_tips")
  self.v_uicompents.KeyUnLockPd_pd:ResetPD()
  local canvas_group = self:get_canvas_group(nil, self.v_uiobjects.UnLock)
  if canvas_group then
    canvas_group.alpha = 1
  end
  self.v_uicompents.KeyRotationPd_pd:ResetPD()
  if self.v_rotation_timer then
    Timer:remove_timer(self.v_rotation_timer)
    self.v_rotation_timer = nil
  end
  self:clear_close_ring_callback()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:set_escape_btn_show_state(is_show)
  self.v_uiobjects.BtnEscapeLeft:SetActive(is_show)
  self.v_uiobjects.BtnEscapeRight:SetActive(is_show)
  local show_btn = Global.is_show_ring_skip_btn ~= nil
  self.v_uiobjects.BtnEscapeLeft:SetActive(show_btn)
  self.v_uiobjects.BtnEscapeRight:SetActive(show_btn)
end

function ui:check_escape_btn_show_state()
  local card_num = ChallengeRingPlusMgr:get_show_card_index_list_num()
  local is_in_battle = ChallengeRingPlusMgr:is_in_curse_fighting()
  self.v_uiobjects.BtnRet:SetActive(is_in_battle)
  self.v_uiobjects.NextFloorBtn:SetActive(not is_in_battle)
  self:set_escape_btn_show_state(card_num > 2 and not is_in_battle)
  self:refersh_no_card()
  self:refresh_point_info()
end

function ui:update_curse_activate_view()
  local debuff_list = ChallengeRingPlusMgr:get_debuff()
  local debuff_list_old = ChallengeRingPlusMgr:get_debuff_old()
  local count = #debuff_list
  if count > #debuff_list_old and self:visible() then
    UIMgr:get_ui("curse_activate"):ui_show()
  end
end

function ui:clear_close_ring_callback()
  if self.v_need_restart_back_timer then
    self.v_need_restart_back_timer = nil
  end
end

function ui:on_remove_card_done(is_right, not_additional)
  if not_additional then
    self:remove_card_particle_move(is_right)
  end
end

function ui:remove_card_particle_move(is_right)
  local function cb()
    self.v_curse_view:set_curse_val(true, function()
      self:set_pnl_not_click(false)
      
      self.v_ring_card_view:set_is_play_anim(false)
    end)
    ChallengeRingPlusMgr:set_is_first_max_value(false)
  end
  
  if nil == is_right then
    return
  end
  if ChallengeRingPlusMgr:is_achieve_total_limit() and not ChallengeRingPlusMgr:get_is_first_max_value() then
    cb()
    return
  end
  if ChallengeRingPlusMgr:get_is_not_use_curse_buy() then
    ChallengeRingPlusMgr:set_is_not_use_curse_buy(false)
    self:set_pnl_not_click(false)
    self.v_ring_card_view:set_is_play_anim(false)
    return
  end
  local record_value = ChallengeRingPlusMgr:get_fight_add_curse_value() or 0
  local reduce = ChallengeRingPlusMgr:get_skip_card_add_curse_value()
  local change_value = ChallengeRingPlusMgr.v_wait_skip_card and reduce or record_value
  if 0 == change_value then
    ChallengeRingPlusMgr:set_is_first_max_value(false)
    self:set_pnl_not_click(false)
    self.v_ring_card_view:set_is_play_anim(false)
    return
  end
  local uiobjs = self.v_uiobjects
  local node_tf
  local offset_x_max = is_right and 280 or -280
  local top_count = math.random(3, 8)
  if self.v_particle_sequence then
    self.v_particle_sequence:Kill(false)
    self.v_particle_sequence = nil
  end
  self.v_particle_sequence = Util.create_sequence()
  node_tf = is_right and uiobjs.RightTopNode.transform or uiobjs.LeftTopNode.transform
  for index = 1, top_count do
    local particle_tf = self.v_particle_tf_list[index]
    self:_set_offset_and_dotween(particle_tf, node_tf, offset_x_max, true)
  end
  node_tf = is_right and uiobjs.RightDownNode.transform or uiobjs.LeftDownNode.transform
  for index = top_count, 10 do
    local particle_tf = self.v_particle_tf_list[index]
    self:_set_offset_and_dotween(particle_tf, node_tf, offset_x_max, false)
  end
  self.v_uiobjects.ParticleNode:SetActive(true)
  self.v_particle_sequence:OnComplete(function()
    self.v_uiobjects.ParticleNode:SetActive(false)
    if self.v_uiobjects.ZoomIm.activeInHierarchy then
      self.v_uiobjects.ZoomIm:SetActive(false)
    end
    self.v_uiobjects.ZoomIm:SetActive(true)
    cb()
    if self.v_particle_sequence then
      self.v_particle_sequence:Kill(false)
      self.v_particle_sequence = nil
    end
  end)
end

function ui:_set_offset_and_dotween(particle_tf, node_tf, offset_x_max, is_top)
  local offset_y_min = -110
  local x_multi = is_top and -50 or offset_x_max
  local offset_x = math.random() * x_multi
  local offset_y = math.random() * offset_y_min
  particle_tf.localPosition = node_tf.localPosition
  local target_pos = particle_tf.localPosition
  target_pos.x = target_pos.x + offset_x
  target_pos.y = target_pos.y + offset_y
  particle_tf.localPosition = target_pos
  particle_tf.gameObject:SetActive(true)
  local curse_max = self.v_curse_view.v_uiobjects.CurseMax.transform
  self.v_particle_sequence:Join(particle_tf:DOMove(curse_max.position, 1))
end

function ui:get_curse_obj_debuff_list()
  return self.v_curse_view.v_debuff_list
end

function ui:get_curse_obj_curse_value()
  return self.v_curse_view.v_last_curse_val
end

function ui:play_key_anima(init_pos, cb)
  local objs = self.v_uiobjects
  local coms = self.v_uicompents
  self:open_unlock_icon(false)
  local duration = coms.KeyRotationPd_pd.duration
  
  local function rotation_cb()
    objs.KeyAnima:SetActive(false)
    Global.sound_mgr:play_common_sound("Sound_nextlayer_unlock")
    coms.KeyUnLockPd_pd:ResetPD()
    coms.KeyUnLockPd_pd:Play()
    self:set_pnl_not_click(false)
    self:open_unlock_icon(true)
    self.v_ring_card_view:set_is_play_anim(false)
    ChallengeRingPlusMgr:update_remove_card()
    if cb then
      cb()
    end
    self.v_rotation_timer = nil
  end
  
  if self.v_rotation_timer then
    Timer:remove_timer(self.v_rotation_timer)
    self.v_rotation_timer = nil
  end
  local world_camera = UIMgr:get_world_camera()
  local init_screen_pos = world_camera:WorldToScreenPoint(init_pos)
  local ui_tf = self:get_object_transform()
  local target_pos = ui_tf:InverseTransformPoint(objs.UnLockPos.transform.position)
  objs.KeyAnima.transform:SetAnchoredPositionA(init_screen_pos.x, init_screen_pos.y)
  objs.KeyAnima.transform:DOLocalMove(target_pos, duration)
  objs.KeyAnima:SetActive(true)
  coms.KeyRotationPd_pd:ResetPD()
  coms.KeyRotationPd_pd:Play()
  self.v_rotation_timer = Timer:add_timer("rotation_timer", duration, rotation_cb)
end

function ui:play_key_break_effect()
end

function ui:open_unlock_icon(is_open)
  self.v_uiobjects.UnLock:SetActive(is_open)
  self.v_uiobjects.Lock:SetActive(not is_open)
end

function ui:on_click_next_floor_btn()
  if self.v_ring_card_view:is_play_anim() then
    return
  end
  if ChallengeRingPlusMgr:is_door_open() then
    local num = ChallengeRingPlusMgr:get_show_card_index_list_num()
    
    local function sure_func()
      if self.v_rotation_timer then
        Timer:remove_timer(self.v_rotation_timer)
        self.v_rotation_timer = nil
        ChallengeRingPlusMgr:update_remove_card()
      end
      ChallengeRingPlusMgr:select_door_card()
    end
    
    if Util.is_more_than_zero(num) then
      local str = ChallengeRingPlusMgr:is_end_ring() and "是否进行通关结算" or "是否进入下一层"
      UIMgr:get_ui("uinotice_tips"):ui_show(sure_func, nil, str)
    else
      sure_func()
    end
  else
    self.v_ring_card_view:play_end_card_select_effect()
    Util.show_message_tip(2283)
  end
end

function ui:on_click_quit_btn()
  if not self.v_ring_card_view:is_play_anim() then
    local sure_btn = Util.format_str("中继保存")
    local cancel_btn = Util.format_str("直接结算")
    
    local function sure_func()
      self:save_and_exit()
    end
    
    local function cancel_func()
      self:exit()
    end
    
    Util.show_conform_tip("是否立即退出关卡", cancel_btn, sure_btn, cancel_func, sure_func)
  end
end

function ui:exit()
  local hero_list = SceneMgr:get_hero_list()
  for key, hero in pairs(hero_list) do
    for k, _ in pairs(hero.magic_mgr.v_magic_id_map) do
      hero.magic_mgr:remove_magic_by_id(k)
    end
  end
  
  local function clear_fun()
    TowerMgr:entry_choose_reward(true, ChallengeRingPlusMgr:is_end_ring(), false)
    self.v_timer = nil
  end
  
  self.v_timer = Timer:add_timer(nil, 0.3, clear_fun)
end

function ui:save_and_exit()
  self:ui_hide()
  
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function ui:refersh_no_card()
  local num = ChallengeRingPlusMgr:get_show_card_index_list_num()
  self.v_uiobjects.NoCard:SetActive(not Util.is_more_than_zero(num))
end

function ui:open_task_room()
  UIMgr:get_ui("curse_task_room"):ui_show(nil, nil, true)
end

return ui
