local AWARD_STATUS = Config.CommonDefine.BUDDY_PROBATION_AWARD_STATUS
local ItemBase = require("ui.uiobject")
local BuddyItem = Util.create_child_mt(ItemBase)
local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")

function BuddyItem:ui_finish_load()
  self:set_button("Char", function()
    self.v_linked_parent:on_selected(self.v_idx)
  end)
end

function BuddyItem:set_linked_parent(parent)
  self.v_linked_parent = parent
end

function BuddyItem:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_TRYOUT_DATA_UPDATE, self.on_data_update, self)
end

function BuddyItem:on_data_update(msg)
  if msg and msg.mm_x == self.v_id then
    local new_data = BuddyTryoutMgr:get_buddy_data(self.v_id)
    if new_data then
      self:set_data(new_data, self.v_idx, true)
    end
  end
end

function BuddyItem:set_data(data, idx, ignore_tween)
  if not data or not self.v_uiobjects then
    return
  end
  self.v_is_empty = 0 == data.id
  self.v_uiobjects.Char:SetActive(not self.v_is_empty)
  if self.v_is_empty then
    return
  end
  self.v_data = data
  self.v_id = data.id
  self.v_idx = idx
  self.v_cfg = data.cfg or ShareRes.get_buddy_tryout_cfg(data.id)
  self:update_icon()
  self:update_red()
end

function BuddyItem:update_icon()
  if self.v_is_empty then
    return
  end
  self.v_uicompents.CharName_txt.text = ShareRes.get_buddy_name(self.v_cfg.BuddyID)
  local icon_path = UtilUI.get_hero_images(self.v_cfg.BuddyID, Config.HERO_ICON_LV.SHOW_IMG)
  ResMgr:load_set_icon(self.v_uicompents.CharIcon_img, icon_path)
end

function BuddyItem:update_red()
  if self.v_is_empty then
    return
  end
  local is_new = self.v_data.is_new
  local can_get_award = self.v_data.award_status == AWARD_STATUS.ACTIVE_AWARD
  self.v_uiobjects.RedPoint:SetActive(is_new or can_get_award)
end

function BuddyItem:update_selected()
  if self.v_is_empty then
    return
  end
  local selected_id = self.v_linked_parent:get_selected_id()
  self.v_is_selected = selected_id == self.v_data.id
  self.v_uiobjects.Select:SetActive(self.v_is_selected)
  self.v_uicompents.Char_btn.interactable = not self.v_is_selected
end

local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local ITEM_OBJ_CLASS = require("uimodule.item.item_obj_com")
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SpineHelper = require("ui.model_rt_view.spine_helper")
local BUDDY_TRYOUT_LIST_TEMP_KEY = "BUDDY_TRYOUT_LIST_TEMP_KEY"
local _mfloor = math.floor

function ui:ui_finish_load()
  self:set_button("BtnRecive", function()
    BuddyTryoutMgr:req_get_award(self.v_selected_id)
  end)
  self:set_button("BtnPreview", function()
    if self.v_is_over then
      Util.show_message_tip(1840)
      return
    end
    Player_Hero_Helper.build_fake_buddy(self.v_buddy_id)
    UIMgr:get_ui("player_hero"):ui_show()
  end)
  self:set_button("ShowHeroBtn", function()
    if self.v_anim_data.record_data.play_start then
      if self.v_anim_data.record_data.play_interrupt then
        SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
      end
    else
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.CLICK)
    end
  end)
  self:set_button("BtnStart", function()
    if TowerMgr:check_fight_progress() then
      return
    end
    if self.v_buddy_id == 1001020 and Game_AssetBundle and DownloadMgr and not DownloadMgr:check_res_is_integrity() then
      local msg = "资源不完整，是否前往下载所有资源"
      Util.show_notify_popup_message(function()
        UIMgr:get_ui("battle_setting"):ui_show(Setting_Cfg.PageTag.Download)
      end, msg, "提示", "确定", "取消", nil, false)
      return
    end
    if self.v_episode_id then
      UIMgr:get_ui("team"):ui_show(nil, self.v_episode_id)
    end
  end)
  self:register_exist_auto_template(BUDDY_TRYOUT_LIST_TEMP_KEY, self.v_uiobjects.TryoutCharTem, self.v_uiobjects.TryoutCharList)
end

function ui:ui_on_show()
  self.v_low_update = Global.real_time
  self.v_start_time = Global.real_time
  self.v_anim_data = SpineHelper.get_init_anim_info()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_TRYOUT_DATA_UPDATE, self.on_data_update, self)
  self:bind_auto_mq(Const.MSG_ON_BUDDY_TRYOUT_LIST_UPDATE, self.on_list_update, self)
end

function ui:ui_after_show(_, selected_id)
  self:refresh_list(selected_id)
end

function ui:ui_on_hide()
  self.v_spine_id = nil
  self:clear_spine_rt()
  self:clear_wrap_award()
  self:clear_wrap_items()
end

function ui:on_data_update()
  self:refresh_info()
  self:refresh_item_red(true)
end

function ui:on_list_update()
  self:refresh_list(self.v_selected_id)
end

function ui:refresh_list(selected_id)
  local selected_idx = 1
  local buddy_list = BuddyTryoutMgr:get_buddy_list()
  self.v_is_over = 0 == #buddy_list
  if self.v_is_over then
    return
  end
  self.v_buddy_list = buddy_list
  table.sort(self.v_buddy_list, function(a, b)
    local cfg_a = a.cfg
    local cfg_b = b.cfg
    if cfg_a.Priority ~= cfg_b.Priority then
      return cfg_a.Priority > cfg_b.Priority
    end
    return cfg_a.Id > cfg_b.Id
  end)
  local empty_slot = 6 - #self.v_buddy_list
  if empty_slot > 0 then
    for i = 1, empty_slot do
      self.v_buddy_list[#self.v_buddy_list + 1] = {id = 0}
    end
  end
  self:clear_wrap_items()
  self.v_buddy_items = {}
  self:give_back_auto_cache(BUDDY_TRYOUT_LIST_TEMP_KEY)
  for idx, data in ipairs(self.v_buddy_list) do
    local obj = self:get_auto_cache(BUDDY_TRYOUT_LIST_TEMP_KEY)
    local item = BuddyItem:ui_wrap_ex(self, obj, true)
    item:set_linked_parent(self)
    item:set_data(data, idx)
    table.insert(self.v_buddy_items, item)
    if data.id == selected_id then
      selected_idx = idx
    end
  end
  self:on_selected(selected_idx)
end

function ui:refresh_item_red()
  if not self.v_buddy_items then
    return
  end
  for _, item in ipairs(self.v_buddy_items) do
    item:update_red()
  end
end

function ui:on_selected(selected_idx)
  if not self.v_buddy_list then
    return
  end
  self.v_selected_idx = selected_idx or 1
  if not self.v_buddy_list[self.v_selected_idx] then
    self.v_selected_idx = 1
  end
  self.v_selected_id = self.v_buddy_list[self.v_selected_idx].id
  self.v_parent_panel:set_sub_param(self.v_selected_id)
  BuddyTryoutMgr:req_do_read(self.v_selected_id)
  for _, item in ipairs(self.v_buddy_items) do
    item:update_selected()
  end
  self:refresh_info()
end

function ui:get_selected_id()
  return self.v_selected_id
end

function ui:refresh_info()
  local cfg = self.v_buddy_list[self.v_selected_idx].cfg
  self.v_episode_id = cfg.EpisodeId
  if self.v_spine_id ~= cfg.SpineId then
    self:clear_spine_rt()
    self.v_spine_id = cfg.SpineId
    self.v_anim_interval = SpineHelper.get_anim_interval(self.v_spine_id)
    self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.ShowHero)
    SpineHelper.load_char_spine_res(self.v_spine_rt, self.v_spine_id, self.v_uiobjects.ShowHero)
    self.v_uiobjects.Ani_UIOrder_Pick:SetActiveEx(false)
    self.v_uiobjects.Ani_UIOrder_Pick:SetActive(true)
  end
  self.v_uicompents.Title_txt.text = cfg.Title
  self:refresh_char_info(cfg.BuddyID)
  self:refresh_award(cfg.AwardId)
  local end_time = cfg.EndTime and Date.get_time_stamp_by_scheme_id(cfg.EndTime)
  self:refresh_time_remaining(end_time)
end

function ui:refresh_char_info(buddy_id)
  self.v_buddy_id = buddy_id
  local buddy_cfg = ShareRes.get_buddy_cfg(buddy_id)
  self.v_uicompents.CharName_txt.text = buddy_cfg.Name
  Char_Helper.set_buddy_quality_star(self.v_uiobjects, buddy_cfg.Quality)
  local char_job_icon = Char_Helper.get_char_job_icon(buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.JobIcon_img, char_job_icon)
  local element_icon_path = Char_Helper.get_char_element_icon(buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.EleIcon_img, element_icon_path)
end

function ui:refresh_award(award_group_id)
  local award_status = BuddyTryoutMgr:get_award_status(self.v_selected_id)
  self:clear_wrap_award()
  self.v_item_list = {}
  local awards = {}
  ShareRes.get_item_obj_use_award_list(award_group_id, awards)
  for index = 1, 3 do
    local item_obj = self.v_uiobjects["Award" .. index]
    if item_obj then
      local award_data = awards[index]
      item_obj:SetActiveEx(nil ~= award_data)
      if nil ~= award_data then
        local item = ITEM_OBJ_CLASS:ui_wrap_ex(self, item_obj, true)
        item:set_data(award_data, true)
        item.v_uiobjects.Mask:SetActive(award_status == AWARD_STATUS.GET_AWARD)
        table.insert(self.v_item_list, item)
      end
    end
  end
  self.v_uiobjects.UnFinish:SetActive(award_status == AWARD_STATUS.NOT_ACTIVE_AWARD)
  self.v_uiobjects.BtnRecive:SetActive(award_status == AWARD_STATUS.ACTIVE_AWARD)
  self.v_uiobjects.Finish:SetActive(award_status == AWARD_STATUS.GET_AWARD)
end

function ui:refresh_time_remaining(stop_time)
  local time_length = stop_time - Date.server_time()
  self.v_uicompents.LessTime_txt.text = Util.format_str("{1}天{2}时", _mfloor(time_length / 86400), _mfloor(time_length % 86400 / 3600))
end

function ui:ui_on_destroy()
  self:clear_spine_rt()
end

function ui:clear_spine_rt()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:ui_on_update()
  if not self.v_spine_id then
    return
  end
  if Global.real_time - self.v_low_update < SpineHelper.UPDATE_TIME then
    return
  end
  self.v_low_update = Global.real_time
  if self.v_anim_data.record_data.play_end then
    self.v_start_time = self.v_start_time or Global.real_time
    if self.v_anim_interval and Global.real_time - self.v_start_time > self.v_anim_interval then
      SpineHelper.init_anim_info(self.v_spine_id, self.v_anim_data, SpineHelper.ANIM_TYPE.INTERVAL)
    end
  else
    self.v_start_time = Global.real_time
  end
  SpineHelper.check_play_anim(self.v_spine_rt, self.v_anim_data)
end

function ui:clear_wrap_items()
  if self.v_buddy_items then
    for idx = #self.v_buddy_items, 1, -1 do
      local item = self.v_buddy_items[idx]
      item:ui_hide()
      item:ui_destroy()
      self.v_buddy_items[idx] = nil
    end
    self.v_buddy_items = nil
  end
end

function ui:clear_wrap_award()
  if self.v_item_list then
    for key, item in pairs(self.v_item_list) do
      item:ui_hide()
      item:ui_destroy()
      self.v_item_list[key] = nil
    end
    self.v_item_list = nil
  end
end

return ui
