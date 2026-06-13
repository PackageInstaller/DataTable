local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CommonDef = require("cs_share.common_define")
local TEMPLATE_KEY_ADVICE = "TEMPLATE_KEY_ADVICE"

function ui:ui_finish_load()
  self:register_exist_auto_template(TEMPLATE_KEY_ADVICE, self.v_uiobjects.AdviceTem, self.v_uiobjects.Advice)
  self:set_button("BtnQuit", function()
    self:on_click_quit_button()
  end)
  self:set_button("BtnRelive", function()
    self:on_click_relive_button()
  end)
  self:set_button("BtnReliveAuto", function()
    self:click_archieve_born_btn()
  end)
  self:set_button("BtnReFight", function()
    if TowerMgr:get_tower() == nil then
      TowerMgr:restart_tower(nil, nil, nil, nil, true)
    else
      TowerMgr:get_fight_reward(function()
        TowerMgr:restart_tower(nil, nil, nil, nil, true)
      end, true)
    end
  end)
end

function ui:on_click_quit_button()
  local function cb()
    self:try_record_select_param()
    
    Global.scene_mgr:on_enter_main_scene()
    UIMgr:revert_cache_ui()
  end
  
  if SceneMgr:check_main_scene() then
    self:ui_hide()
  end
  if TowerMgr:get_has_exist() then
    Global.scene_mgr:on_enter_main_scene()
    UIMgr:clear_ui_stack()
    return
  end
  if not self.v_is_get_award then
    TowerMgr:get_fight_reward(cb)
  else
    cb()
    self.v_is_get_award = false
  end
end

function ui:on_click_relive_button()
  if not self.v_reborn_cost_id or 0 == self.v_reborn_cost_id then
    Util.show_message_tip(2114)
    return
  end
  local name = UtilUI.get_item_name(self.v_reborn_cost_id)
  local desc = Util.format_str("是否花费{1}{2}立即复活该角色", self.v_reborn_cost_num, name)
  
  local function cb()
    local cur_num = BagMgr:get_item_num(self.v_reborn_cost_id)
    if cur_num < self.v_reborn_cost_num then
      Util.show_message_tip(2115)
    else
      ChapterMgr:request_reborn_all()
      self:ui_hide()
    end
  end
  
  Util.show_conform_tip(desc, nil, nil, nil, cb)
end

function ui:click_archieve_born_btn()
  local function callback()
    local node_id
    
    local progress = self.v_tower_progress
    node_id = progress.node_id
    TowerMgr:restart_tower(nil, nil, nil, node_id, true)
    self:ui_hide()
  end
  
  if not self.v_is_get_award then
    TowerMgr:get_fight_reward(callback, true)
  else
    self.v_is_get_award = false
    callback()
  end
end

function ui:ui_on_show()
  MsgGame:mq_publish2(Const.MSG_ON_FIGHT_OVER_WIN_OPEN)
  self.v_is_get_award = false
  self.v_uiobjects.Blur:SetActive(SceneMgr:check_main_scene())
  if TowerMgr then
    self.v_tower_progress = TowerMgr:get_tower_progress()
    if self.v_tower_progress then
      self.v_episode_id = self.v_tower_progress.episode_id
    end
  end
  self.v_episode_cfg = ShareRes.get_chapter_point_cfg(self.v_episode_id)
  if not self.v_episode_cfg then
    return
  end
  self:refresh_data()
  if not SceneMgr:check_main_scene() then
    local camera = Global.camera
    if camera then
      camera:set_enable_camera(true)
    end
  end
end

function ui:ui_on_hide()
  self.v_episode_cfg = nil
  self.v_tower_progress = nil
  self.v_episode_id = nil
end

function ui:ui_on_destroy()
end

function ui:refresh_data()
  self:refresh_text()
  self:refresh_button()
end

function ui:refresh_button()
  if not TowerMgr then
    return
  end
  local hero_list = SceneMgr:get_hero_list()
  local is_show_relive = true
  if hero_list then
    for key, hero in pairs(hero_list) do
      if not hero:is_die() then
        is_show_relive = false
      end
    end
  else
    is_show_relive = false
  end
  local fight_info = TowerMgr:get_fight_info()
  self.v_fight_type = fight_info.type
  self.v_chapter_id = fight_info.param
  self.v_param = self.v_fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER and fight_info.node_id or fight_info.point_id
  if is_show_relive then
    local icon_path
    icon_path, self.v_reborn_cost_num, self.v_reborn_cost_id = TowerMgr:get_reborn_cost(true)
    if not (icon_path and self.v_reborn_cost_id) or 0 == self.v_reborn_cost_id then
      is_show_relive = false
    else
      ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, icon_path)
      self.v_uicompents.CurrNum_txt.text = self.v_reborn_cost_num
    end
  elseif self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.LONG_CHAPTER then
    TowerMgr:get_fight_reward()
    self.v_is_get_award = true
  end
  self.v_uiobjects.BtnRelive:SetActive(is_show_relive)
  self.v_uiobjects.BtnReliveAuto:SetActive(self.v_fight_type == CommonDef.CHALLENGE_TYPE.LONG_CHAPTER)
  self.v_uiobjects.BtnQuit:SetActive(true)
  self:refresh_re_fight_btn()
end

function ui:refresh_re_fight_btn()
  self.v_uiobjects.BtnReFight:SetActive(TowerMgr:is_need_show_re_fight_btn(true))
end

function ui:refresh_text()
  self:give_back_auto_cache(TEMPLATE_KEY_ADVICE)
  local notice = self.v_episode_cfg.Failure_Notice
  if notice and not Util.is_empty(notice) then
    self.v_failure_notice_list = Util.split_str(notice, "|")
    for index, failure_notice in ipairs(self.v_failure_notice_list) do
      local item = self:get_auto_cache(TEMPLATE_KEY_ADVICE)
      local item_text = Util.get_text("Text", item)
      item_text.text = failure_notice
    end
  end
end

function ui:try_record_select_param()
  local is_long_chapter = self.v_fight_type == Config.CommonDefine.CHALLENGE_TYPE.LONG_CHAPTER
  local is_chapter = self.v_fight_type == Config.CommonDefine.CHALLENGE_TYPE.CHAPTER
  if is_long_chapter or is_chapter then
    ChapterMgr:set_record_select_chapter_id(self.v_chapter_id)
    ChapterMgr:set_record_select_param_id(self.v_param)
  end
end

return ui
