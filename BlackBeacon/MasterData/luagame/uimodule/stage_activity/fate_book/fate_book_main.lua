local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local ASSET_ITEM = {
  29,
  28,
  11
}
local SHOP_HELPER = require("uimodule.shop.shop_helper")
local ACTY_TYPE = Config.CommonDefine.ACTY_TYPE
local ActivityCfg = require("gamelogic.activity.activity_config")
local ACTY_TYPE_TO_SYSID = ActivityCfg.ACTY_TYPE_TO_SYSID
local SPINE_RT_VIEW = require("ui.model_rt_view.spine_rt_view")
local SPINE_RES_NAME = "mingyunzhishu"
local SpineHelper = require("ui.model_rt_view.spine_helper")

function ui:on_click_return_btn()
  self:ui_hide()
end

function ui:on_click_type1_btn()
  if SysOpenMgr:get_sys_is_open(ACTY_TYPE_TO_SYSID[ACTY_TYPE.CURSE_CIRCLE], true) and ActivityMgr:get_activity_is_open(ACTY_TYPE.CURSE_CIRCLE) then
    local group_ids = ShareRes.get_curse_ring_config_type_to_group_cfg(Config.FATE_POINT_TYPE.STORY)
    for key, group_id in pairs(group_ids) do
      local config_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
      for key, config_id in pairs(config_ids) do
        if not ChallengeRingPlusMgr:check_ring_is_pass(config_id) then
          Util.show_message_tip(2295)
          return
        end
      end
    end
    UIMgr:get_ui("fate_book_point_detail"):ui_show(Config.FATE_POINT_TYPE.HARD)
  else
    Util.show_message_tip(2148)
  end
end

function ui:on_click_type2_btn()
  if SysOpenMgr:get_sys_is_open(ACTY_TYPE_TO_SYSID[ACTY_TYPE.CURSE_CIRCLE], true) and ActivityMgr:get_activity_is_open(ACTY_TYPE.CURSE_CIRCLE) then
    UIMgr:get_ui("fate_book_point_detail"):ui_show(Config.FATE_POINT_TYPE.STORY)
  else
    Util.show_message_tip(2148)
  end
end

function ui:on_click_course_btn()
  UIMgr:get_ui("fate_book_course_main"):ui_show()
end

function ui:on_click_shop_btn()
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  if Util.is_more_than_zero(main_cfg.ShopId) then
    SysOpenMgr:jump_to_sys(main_cfg.ShopId, true)
  end
end

function ui:on_click_illustrated_btn()
  UIMgr:get_ui("fate_book_illustrated"):ui_show()
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:on_click_return_btn()
  end)
  self:set_button("BtnStageType1", function()
    self:on_click_type1_btn()
  end)
  self:set_button("BtnStageType2", function()
    self:on_click_type2_btn()
  end)
  self:set_button("BtnCourse", function()
    self:on_click_course_btn()
  end)
  self:set_button("BtnShop", function()
    self:on_click_shop_btn()
  end)
  self:set_button("BtnHandbook", function()
    self:on_click_illustrated_btn()
  end)
  local asset_config = SHOP_HELPER.get_asset_list(ASSET_ITEM)
  asset_config[3].func = "_onclick_fate_book_tickets"
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_config)
end

function ui:ui_on_show()
  self.v_uiobjects.SpineRaw:SetActive(true)
  self.v_asset_bar:on_create()
  self:refresh_course_progress()
  self:refresh_story_progress()
  self:refresh_repoint()
  self:refresh_type1_entrance()
  self:create_spine()
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  if self.v_spine_rt then
    self.v_spine_rt:on_destroy()
    self.v_spine_rt = nil
  end
end

function ui:refresh_course_progress()
  local all_chapter_cfg = ShareRes.get_curse_course_chapter_cfg()
  local all_node_cfg
  local total_node_count = 0
  for key, cfg in pairs(all_chapter_cfg) do
    all_node_cfg = ShareRes.get_curse_course_node_by_chapter_id(cfg.Id)
    total_node_count = total_node_count + (all_node_cfg and UtilTable.hash_lenth(all_node_cfg) or 0)
  end
  self.v_uicompents.CourseProgressNow_txt.text = FateBookMgr:get_curse_node_completed_count()
  self.v_uicompents.CourseProgressMax_txt.text = total_node_count
end

function ui:refresh_story_progress()
  local group_ids = ShareRes.get_curse_ring_config_type_to_group_cfg(Config.FATE_POINT_TYPE.STORY)
  local total = 0
  local suc = 0
  for key, group_id in pairs(group_ids) do
    local config_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
    for key, config_id in pairs(config_ids) do
      if ChallengeRingPlusMgr:check_ring_is_pass(config_id) then
        suc = suc + 1
      end
      total = total + 1
    end
  end
  self.v_uicompents.StageProgressNow_txt.text = suc
  self.v_uicompents.StageProgressMax_txt.text = total
end

function ui:refresh_repoint()
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.CourseRedPoint, RedEnum.CURSE_COURSE_ENTER)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.HandbookRedPoint, RedEnum.CURSE_ILLUSTRATED_ENTER)
end

function ui:refresh_type1_entrance()
  local is_unlock = true
  local group_ids = ShareRes.get_curse_ring_config_type_to_group_cfg(Config.FATE_POINT_TYPE.STORY)
  for key, group_id in pairs(group_ids) do
    local config_ids = ShareRes.get_curse_ring_config_group_to_point_cfg(group_id)
    for key, config_id in pairs(config_ids) do
      if not ChallengeRingPlusMgr:check_ring_is_pass(config_id) then
        is_unlock = false
        break
      end
    end
  end
  self.v_uiobjects.Type1Nor:SetActive(is_unlock)
  self.v_uiobjects.Type1Lock:SetActive(not is_unlock)
  local is_start, activity_id = NoviceMgr:is_double_challenge_start(Config.CommonDefine.DOUBLE_TYPE.FATEBOOK)
  local multi_obj = Util.get_child_gameobj("Type1Nor_/Multi", self.v_uiobjects.BtnStageType1)
  multi_obj:SetActive(is_start)
  if is_start then
    local multi_times_txt = Util.get_text("MultiTimes", multi_obj)
    multi_times_txt.text = ShareRes.get_double_challenge_cfg(activity_id).Double .. "倍"
  end
end

function ui:create_spine()
  local main_cfg = ChallengeRingPlusMgr:get_main_cfg()
  local spine_id = main_cfg.SpineID
  self.v_spine_rt = self.v_spine_rt or SPINE_RT_VIEW:new(self, self.v_uiobjects.SpineRaw)
  local spine_cfg = ShareRes.get_spine_cfg(spine_id)
  local role_res = spine_cfg.SpineRes
  local loop_anim_name = spine_cfg.DefaultAnim
  local pos_info = spine_cfg.Pos
  local raw = self:get_rawimage(nil, self.v_uiobjects.SpineRaw)
  raw.enabled = false
  
  local function load_cb(obj)
    if Util.is_nil(raw) then
      return
    end
    obj:ResetAttr()
    obj.transform:SetLocalScaleA(pos_info[4], pos_info[4], pos_info[4])
    obj.transform:SetLocalPositionA(pos_info[1], pos_info[2], pos_info[3])
    local spine_component = obj:GetComponent(typeof(CS.Game.SpineController))
    if Util.is_nil(spine_component) then
      return
    end
    spine_component:ClearTrackIndex()
    self.v_spine_rt:play_loop_anim(role_res, loop_anim_name)
    self.v_spine_rt:play_anim(role_res, "Enter", false, 1, 0)
    raw.enabled = true
  end
  
  self.v_spine_rt:load_spine_res(role_res, load_cb)
end

function ui:cache_ui()
  return true
end

return ui
