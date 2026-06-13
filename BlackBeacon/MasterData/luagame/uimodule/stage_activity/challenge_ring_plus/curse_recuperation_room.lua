local Base = require("ui.uibase")
local CURSE_OBJ_CLASS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local RECUPERATION_ROOM_ITEM_CLASS = require("uimodule.stage_activity.challenge_ring_plus.curse_recuperation_room_item")
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local ADD_CURSE_TYPE = curse_com_def.ADD_CURSE_TYPE
local AssetBarView = require("ui.asset_bar.asset_bar")
local RECUPERATION_TYPE = Config.CommonDefine.RECUPERATION_TYPE
local FUNCTION_TEM = "FUNCTION_TEM"
local ui = Util.create_child_mt(Base)
local asset_bar_config = {
  {
    item_id = Config.CURSE_GOLD,
    const_event = Const.MSG_ON_FIGHT_DIAMOND_UPDATE,
    is_fight_bag = true,
    not_show_max = true,
    bg_click = false
  }
}

local function sort_func(a, b)
  if a.id ~= b.id then
    return a.id < b.id
  else
    return false
  end
end

local TYPE_FUNC_NAME = {
  [RECUPERATION_TYPE.RANDOM_UPDAGRADE_ABILITY] = "use_random_updagrade_ability_func",
  [RECUPERATION_TYPE.CHOOSE_ABILITY_UPGRADE] = "use_choose_ability_upgrade_func",
  [RECUPERATION_TYPE.GET_ORNAMENTS] = "use_get_ornament_func",
  [RECUPERATION_TYPE.ADD_MAGIC] = "use_add_magic_func",
  [RECUPERATION_TYPE.EXIT] = "exit_func",
  [RECUPERATION_TYPE.REVIVE_HERO] = "use_reborn_or_cure_func",
  [RECUPERATION_TYPE.TREATMENT_HERO] = "use_reborn_or_cure_func"
}

function ui:on_click_complete_btn()
  local have_next_step = self:check_have_next_step()
  local sure_cb, content
  if have_next_step then
    function sure_cb()
      self:to_next_step()
    end
    
    content = "是否进行下一步，不可返回"
  else
    function sure_cb()
      self:close_view(true)
    end
    
    content = "是否离开，不可返回"
  end
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_cb, nil, content)
end

function ui:on_uiqueue_empty()
  if self.v_on_uiqueue_empty_cb then
    self.v_on_uiqueue_empty_cb()
  end
end

function ui:ui_finish_load()
  self.v_room_item_list = {}
  self.v_multi_func_item = nil
  self:set_button("BtnRet1", function()
    self:close_view(false)
  end)
  self:set_button("BtnComplete", function()
    self:on_click_complete_btn()
  end)
  self:set_button("Button_Tp", function()
    self:open_battle_bag()
  end)
  
  function self.v_to_next_step_cb()
    ChallengeRingPlusMgr:request_curse_recuperation_next_step(self.v_select_index)
    self.v_uicompents.Ani_FBPrePareRoom1_Out_pd:stopped("-", self.v_to_next_step_cb)
  end
  
  self.v_max_step_count = 0
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_bar_config)
  self:register_exist_auto_template(FUNCTION_TEM, self.v_uiobjects.FunctionTem, self.v_uiobjects.FunctionLayout)
end

function ui:ui_on_show(select_index, recuperation_card_data)
  self.v_uicompents.FunctionLayout_rect:SetAnchoredPositionA(0, self.v_init_y)
  self.v_init_y = self.v_uicompents.FunctionLayout_rect.anchoredPosition.y
  self.v_select_index = select_index
  local need_check_mask = self.v_recuperation_data ~= nil
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_CHANGE, self.on_ornament_change, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_CARD_DATA, self.on_update_recuperation_data, self)
  self:bind_auto_mq(Const.MSG_ON_PAYMENT_BUFF_CAHNGE, self.on_update_recuperation_data, self)
  self:bind_auto_mq(Const.MSG_ON_UIQUEUE_EMPTY, self.on_uiqueue_empty, self)
  self:refresh_recuperation_data(recuperation_card_data)
  self.v_asset_bar:on_create()
  self:set_curse_view()
  self:refresh_view(self.v_recuperation_data, need_check_mask)
end

function ui:refresh_recuperation_data(recuperation_card_data)
  recuperation_card_data = recuperation_card_data or ChallengeRingPlusMgr:get_recuperation_card_data()
  self.v_recuperation_card_data = recuperation_card_data
  if self.v_recuperation_card_data.step ~= self.v_cur_step then
    self.v_be_skipping_cur_step = false
    self:clear_room_item()
    self.v_cur_step = self.v_recuperation_card_data.step
    ChallengeRingPlusMgr:set_choose_recuperation_id(nil)
    self:play_in_pd()
  end
  self.v_recuperation_data = recuperation_card_data.recuperation_data
  local card_cfg = ChallengeRingPlusMgr:get_cur_card_cfg_info()
  self.v_group_id = card_cfg.Arg[1]
  local all_step_cfg = ShareRes.get_recuperation_step_cfg(self.v_group_id)
  local max_step = 0
  for step in pairs(all_step_cfg) do
    if step > max_step then
      max_step = step
    end
  end
  self.v_max_step_count = max_step
end

function ui:refresh_view(need_check_mask)
  self.v_data = self.v_recuperation_data
  self:show_recuperate_item(need_check_mask)
end

function ui:ui_on_hide()
  self.v_uicompents.Ani_FBPrePareRoom1_Out_pd:stopped("-", self.v_to_next_step_cb)
  self.v_uicompents.Ani_FBPrePareRoom1_Out_pd:ResetPD()
  self.v_cur_step = nil
  self:clear_room_item()
  self:clear_wrap_curse_obj()
  ChallengeRingPlusMgr:set_is_selecting_card(false)
  self.v_asset_bar:on_hide()
  UIMgr:try_hide_ui("curse_ring_hero_tip")
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:show_recuperate_item(need_check_mask)
  table.sort(self.v_data, sort_func)
  local group_cfg = ShareRes.get_recuperation_step_cfg(self.v_group_id)
  local step_cfg = group_cfg and group_cfg[self.v_cur_step]
  if self.v_be_skipping_cur_step then
    return
  end
  local is_skip_cur_step = step_cfg and Util.is_more_than_zero(step_cfg.UnlockOrnament) and not BattleOrnamentMgr:is_have_same_ornament(step_cfg.UnlockOrnament)
  if is_skip_cur_step then
    self.v_be_skipping_cur_step = true
    self:check_next_step(is_skip_cur_step)
    return
  end
  local recuperate_cfg, is_multi_type
  for index, recuperate_data in ipairs(self.v_data) do
    local item
    recuperate_cfg = ShareRes.get_recuperation_cfg(recuperate_data.id)
    is_multi_type = recuperate_cfg.Type == RECUPERATION_TYPE.REVIVE_HERO or recuperate_cfg.Type == RECUPERATION_TYPE.TREATMENT_HERO
    if not self.v_room_item_list[index] and (not is_multi_type or not self.v_multi_func_item) then
      local obj = self:get_auto_cache(FUNCTION_TEM)
      self.v_room_item_list[index] = RECUPERATION_ROOM_ITEM_CLASS:ui_wrap(self, obj, true)
      if is_multi_type then
        self.v_multi_func_item = self.v_room_item_list[index]
      end
    end
    item = is_multi_type and self.v_multi_func_item or self.v_room_item_list[index]
    if 0 ~= recuperate_data.use_count then
      item:set_enable(true)
      item:set_data(recuperate_data, step_cfg.UnlockOrnament)
      if need_check_mask then
        item:check_play_mask_effect()
      end
    else
      item:set_enable(false)
    end
  end
  local remain_func_count = 0
  for key, item in pairs(self.v_room_item_list) do
    if item:visible() then
      remain_func_count = remain_func_count + 1
    end
  end
  self.v_uiobjects.PrepareFinish:SetActive(remain_func_count <= 0)
  self:refresh_remain_step()
end

function ui:refresh_remain_step()
  local have_next_step = self:check_have_next_step()
  local str = have_next_step and "下一步" or "离开"
  self.v_uicompents.CompleteText_txt.text = str
end

function ui:check_have_next_step()
  local group_cfg = ShareRes.get_recuperation_step_cfg(self.v_group_id)
  local remain_step = self.v_max_step_count - self.v_recuperation_card_data.step
  if remain_step > 0 then
    local next_step_cfg
    for i = 1, remain_step do
      next_step_cfg = group_cfg and group_cfg[self.v_cur_step + i]
      if not Util.is_more_than_zero(next_step_cfg.UnlockOrnament) or BattleOrnamentMgr:is_have_same_ornament(next_step_cfg.UnlockOrnament) then
        return true
      end
    end
  end
  return false
end

function ui:set_curse_view()
  self.v_curse_view = CURSE_OBJ_CLASS:ui_wrap(self, self.v_uiobjects.CurseObj, false)
  self.v_curse_view:set_enable(true)
end

function ui:clear_wrap_curse_obj()
  if self.v_curse_view then
    self.v_curse_view:ui_hide()
    self.v_curse_view:ui_destroy()
    self.v_curse_view = nil
  end
end

function ui:clear_room_item()
  self:give_back_auto_cache(FUNCTION_TEM)
  for key, item in pairs(self.v_room_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_room_item_list[key] = nil
  end
  self.v_multi_func_item = nil
end

function ui:on_click_pay_btn(pay_type, recuperate_data)
  local recuperation_id = recuperate_data.id
  if ChallengeRingPlusMgr:get_choose_recuperation_id() and self.v_choose_recuperation and self.v_choose_recuperation ~= recuperation_id then
    return
  end
  local cfg = ShareRes.get_recuperation_cfg(recuperation_id)
  if not ChallengeRingPlusMgr:check_can_pay_recuperation_card(pay_type, cfg, true) then
    return
  end
  ChallengeRingPlusMgr:set_choose_recuperation_id(self.v_recuperation_card_data.choose_recuperation or recuperation_id)
  local use_curse_value = pay_type == Config.PAY_COSE_TYPE.USE_CUESE
  local func_name = TYPE_FUNC_NAME[cfg.Type]
  if func_name and self[func_name] then
    self[func_name](self, cfg, recuperate_data, use_curse_value, pay_type)
  else
    self:common_use_recuperation_func(cfg, recuperate_data, use_curse_value)
  end
end

function ui:close_view(click_complete)
  local function cb()
    ChallengeRingPlusMgr:set_choose_recuperation_id(nil)
    
    self:ui_hide()
  end
  
  local function sure_cb()
    self.v_recuperation_data = nil
    ChallengeRingPlusMgr:req_remove_card(cb)
  end
  
  if click_complete then
    sure_cb()
  else
    local content = "是否退出修整，一旦退出将不可返回"
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_cb, nil, content)
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_select_index
end

function ui:common_use_recuperation_func(cfg, recuperate_data, use_curse_value)
  local function cb(resp)
    self:refresh_recuperation_data()
    
    self:refresh_view()
    self:after_use_recuperation_func()
  end
  
  if cfg.Type == RECUPERATION_TYPE.DEC_CURSE_VALUE then
    ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SHOP_BUY, -cfg.Arg[1])
  end
  ChallengeRingPlusMgr:request_use_recuperation_func(recuperate_data.id, nil, use_curse_value, cb)
end

function ui:use_choose_ability_upgrade_func(cfg, recuperate_data, use_curse_value)
  local curse_ability_upgrade = UIMgr:get_ui("curse_ability_upgrade")
  curse_ability_upgrade:ui_show(recuperate_data)
  
  local function hide_cb()
    self:after_use_recuperation_func()
  end
  
  curse_ability_upgrade:set_hide_cb(hide_cb)
end

function ui:use_random_updagrade_ability_func(cfg, recuperate_data, use_curse_value)
  if UtilTable.is_empty(recuperate_data.random_up_ability_grade) then
    ChallengeRingPlusMgr:set_choose_recuperation_id(nil)
    Util.show_message_tip(2290)
    return
  end
  local data = {
    id = recuperate_data.id,
    ability_drop = {},
    data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.UPDAGRADE_ABILITY
  }
  local id, grade
  for _, ability_id in pairs(recuperate_data.random_up_ability_grade) do
    id = ability_id
    grade = GenresMgr:get_ability_grade(ability_id)
    data.ability_drop[#data.ability_drop + 1] = {
      id = id,
      grade = grade + 1
    }
  end
  ChallengeRingPlusMgr:drop_award_data_enqueue(data)
  ChallengeRingPlusMgr:try_choose_drop_award()
  
  local function hide_cb()
    self:after_use_recuperation_func()
  end
  
  local choose_ability_view = UIMgr:get_ui("choose_ability_view")
  choose_ability_view:set_hide_cb(hide_cb)
end

function ui:use_add_magic_func(cfg, recuperate_data, use_curse_value)
  local function cb()
    ChallengeRingPlusMgr:add_recuperation_magic(cfg.Arg[1], cfg.Arg[2])
    
    self:refresh_recuperation_data()
    self:refresh_view(true)
    self:after_use_recuperation_func()
  end
  
  ChallengeRingPlusMgr:request_use_recuperation_func(recuperate_data.id, nil, use_curse_value, cb)
end

function ui:use_get_ornament_func(cfg, recuperate_data, use_curse_value, pay_type)
  if recuperate_data.is_select == false then
    BattleOrnamentMgr:request_choose_ornament(recuperate_data.id, 1, use_curse_value)
    return
  end
  local param = {
    pay_type = pay_type,
    recuperate_data = recuperate_data,
    recuperate_cfg = cfg,
    data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.ORNAMENT
  }
  ChallengeRingPlusMgr:drop_award_data_enqueue(param)
  ChallengeRingPlusMgr:try_choose_drop_award()
  
  function self.v_on_uiqueue_empty_cb()
    self:refresh_recuperation_data()
    self:refresh_view(true)
    self:after_use_recuperation_func()
  end
end

function ui:exit_func(cfg, recuperate_data, use_curse_value)
  local function cb()
    self:close_view(true)
  end
  
  ChallengeRingPlusMgr:request_use_recuperation_func(recuperate_data.id, nil, use_curse_value, cb)
end

function ui:use_reborn_or_cure_func(cfg, recuperate_data, use_curse_value)
  local param = {
    pay_type = Config.PAY_COSE_TYPE.USE_ITEM
  }
  UIMgr:get_ui("fate_book_cure_func"):ui_show(param)
end

function ui:on_update_recuperation_data(msg)
  self:refresh_recuperation_data()
  self:refresh_view()
end

function ui:on_ornament_change(msg)
  self:refresh_remain_step()
end

function ui:open_battle_bag()
  UIMgr:get_ui("battle_bag4"):ui_show()
end

function ui:check_play_mask_effect()
  if not self.v_room_item_list then
    return
  end
  for key, item in pairs(self.v_room_item_list) do
    item:check_play_mask_effect()
  end
end

function ui:to_next_step()
  self.v_uicompents.Ani_FBPrePareRoom1_Out_pd:stopped("+", self.v_to_next_step_cb)
  self:play_out_od()
end

function ui:check_next_step(skip_cur_step)
  if skip_cur_step then
    if self:check_have_next_step() then
      self:to_next_step()
    end
    return
  end
  local choose_data
  for key, data in pairs(self.v_recuperation_card_data.recuperation_data) do
    if data.id == ChallengeRingPlusMgr:get_choose_recuperation_id() then
      choose_data = data
      break
    end
  end
  if not choose_data then
    return
  end
  local id = choose_data.id
  local cfg = ShareRes.get_recuperation_cfg(id)
  if cfg.UseCount and 0 == choose_data.use_count then
    ChallengeRingPlusMgr:set_choose_recuperation_id(nil)
  end
end

function ui:after_use_recuperation_func()
  self:check_next_step()
end

function ui:play_in_pd()
  self.v_uicompents.Ani_FBPrePareRoom1_In_pd:RePlayPD()
end

function ui:play_out_od()
  self.v_uicompents.Ani_FBPrePareRoom1_Out_pd:RePlayPD()
  self.v_uicompents.Ani_PrepareFinish_Out_pd:RePlayPD()
end

return ui
