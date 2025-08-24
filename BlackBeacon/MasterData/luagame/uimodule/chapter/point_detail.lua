local Base = require("ui.uibase")
local AssetBarView = require("ui.asset_bar.asset_bar")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local AWARD_KEY_ITEM = "AWARD_KEY_ITEM"
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local CommonDef = require("cs_share.common_define")
local POINT_INFO_CLASS = require("uimodule.chapter.point_info_common")
local cost_time = 0.3
local OBJ_STATE = {SHOW = 1, HIDE = 2}
local MODEL = {
  v_award_content = {
    "AwardContent",
    BIND_TYPE.OBJECT
  },
  v_award_item = {
    "AwardItem",
    BIND_TYPE.OBJECT
  }
}
local Act_ID = CommonDef.ACTY_TYPE.BUDDY_TEACH

function ui:ui_finish_load()
  self.v_original_pos = self.v_uiobjects.HideNode.transform.anchoredPosition
  self.v_target_pos = self.v_uiobjects.ShowNode.transform.anchoredPosition
  self:init_model(MODEL)
  self:set_button("BtnRet", function()
    self:play_dynamic_effect(OBJ_STATE.HIDE)
    self:remove_delay_hide_timer()
    self.v_delay_hide_timer = Timer:add_timer("delay_hide_timer", cost_time, function()
      self:ui_hide()
    end)
  end)
  self:set_button("BtnStart", function()
    self:click_fight_btn()
  end)
  self:register_exist_auto_template(AWARD_KEY_ITEM, self.v_award_item, self.v_award_content)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:ui_on_show(chapter_id, point_id, fight_type, buddy_id, cb, floor_index)
  self.v_asset_bar:reset_by_id_list({
    Config.PLAYER_SP_ITEMID
  })
  self.v_asset_bar:on_create()
  self.v_fight_type = fight_type
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self.update_cost_info, self)
  self.v_chapter_id = chapter_id
  self.v_point_id = point_id
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  self.v_detail_cfg = ShareRes.get_chapter_point_details_cfg(self.v_point_cfg.PointDetail)
  self.v_buddy_id = buddy_id
  self.v_floor_index = floor_index
  self:update_point_detail()
  self:update_cost_info()
  self:update_drop_award()
  self:update_skill_teach_drop_award()
  self:update_point_desc()
  self:play_dynamic_effect(OBJ_STATE.SHOW)
  self.v_hide_cb = cb
end

function ui:ui_on_hide()
  if self.v_hide_cb then
    self.v_hide_cb()
    self.v_hide_cb = nil
  end
  self.v_floor_index = nil
  self:release_point_info_obj()
  self.v_asset_bar:on_hide()
  self:clear_sequence()
  self:remove_delay_hide_timer()
  self:remove_cannot_touch_timer()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:release_point_info_obj()
  if self.v_point_info_obj then
    ResMgr:destroy_gameobj(self.v_point_info_obj)
    self.v_point_info_obj = nil
  end
  if self.v_point_info_lua_obj then
    self.v_point_info_lua_obj:set_enable(false)
    self:remove_wrap_ui(self.v_point_info_lua_obj)
  end
end

function ui:update_point_detail()
  local bg_path = self.v_point_cfg.BgPath
  ResMgr:load_set_icon(self.v_uicompents.Title_img, bg_path, nil, true)
  self.v_uicompents.SiNum_txt.text = self.v_point_cfg.SerialNum
  self.v_uicompents.SiName_txt.text = self.v_point_cfg.PointName
end

function ui:update_cost_info()
  local cost_val = self.v_point_cfg.FightCost[2]
  local first_fight = false
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    cost_val = Util.get_buddy_teach_fight_cost(self.v_buddy_id, self.v_point_id, self.v_floor_index)
  elseif self.v_chapter_id then
    first_fight = ChapterMgr:check_no_first_suc_by_point_id(self.v_chapter_id, self.v_point_id)
  end
  if first_fight then
    cost_val = self.v_point_cfg.FightCost[1]
  end
  local cur_val = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  self.v_uicompents.SiForceNow_txt.text = cur_val
  local item_cfg = ShareRes.get_item_cfg(Config.PLAYER_SP_ITEMID)
  local item_maxnum = CharacterMgr:get_res_force_max_val()
  self.v_uicompents.SiForceMax_txt.text = item_maxnum
  self.v_uicompents.ForceNeed_txt.text = cost_val
  self.v_cost_val = cost_val
end

function ui:update_drop_award()
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    return
  end
  self:give_back_auto_cache(AWARD_KEY_ITEM)
  local has_reward = false
  if self.v_chapter_id then
    local first_fight = ChapterMgr:check_no_first_suc_by_point_id(self.v_chapter_id, self.v_point_id)
    if first_fight and self.v_point_cfg.AwardId[1] > 0 then
      local first_award = ShareRes.get_award_item_data(self.v_point_cfg.AwardId[1])
      for _, data in ipairs(first_award) do
        local award_ui = self:get_auto_cache(AWARD_KEY_ITEM)
        self:update_item_info(award_ui, data[1], data[2], true)
        has_reward = true
      end
    end
  end
  local many_award_list = self.v_point_cfg.ShowRewardList
  for _, item_id in ipairs(many_award_list) do
    local award = ShareRes.get_award_item_data(item_id)
    if award then
      for _, data in ipairs(award) do
        local award_ui = self:get_auto_cache(AWARD_KEY_ITEM)
        self:update_item_info(award_ui, data[1], data[2], false)
      end
      has_reward = true
    else
      Log.Error("read award failure, award_id=", item_id)
    end
  end
  self.v_uiobjects.NoRewardDesc:SetActive(not has_reward)
end

function ui:update_skill_teach_drop_award()
  if self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    return
  end
  self:give_back_auto_cache(AWARD_KEY_ITEM)
  local has_reward = false
  local has_pass = ActivityMgr:invoke(Act_ID, "get_floor_has_passed", self.v_buddy_id, self.v_floor_index)
  if not has_pass then
    local award = Util.get_buddy_teach_award(self.v_buddy_id, self.v_point_id, self.v_floor_index)
    if Util.is_more_than_zero(award) then
      local first_award = ShareRes.get_award_item_data(award)
      if not first_award then
        Log.Error("获取奖励失败，奖励组ID:", award)
        return
      end
      for _, data in ipairs(first_award) do
        local award_ui = self:get_auto_cache(AWARD_KEY_ITEM)
        self:update_item_info(award_ui, data[1], data[2], true)
        has_reward = true
      end
    end
  end
  local many_award_list = self.v_point_cfg.ShowRewardList
  for _, item_id in ipairs(many_award_list) do
    for _, data in ipairs(ShareRes.get_award_item_data(item_id)) do
      local award_ui = self:get_auto_cache(AWARD_KEY_ITEM)
      self:update_item_info(award_ui, data[1], data[2], false)
    end
    has_reward = true
  end
  self.v_uiobjects.NoRewardDesc:SetActive(not has_reward)
end

function ui:update_item_info(award_ui, item_id, num, is_first)
  local first_img = Util.get_image("FirstGet", award_ui.transform)
  first_img.gameObject:SetActive(is_first)
  local award_num = Util.get_text("ItemAmount/AmoBg/SiItemAmount", award_ui.transform)
  award_num.text = 0 ~= num and num or ""
  local num_bg = Util.get_image("ItemAmount/AmoBg", award_ui.transform)
  num_bg.gameObject:SetActive(0 ~= num)
  self:set_award_icon(item_id, award_ui)
  self:set_button_listener(Util.get_button(nil, award_ui), function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
  end)
end

function ui:set_award_icon(item_id, award_ui)
  local quality_img = Util.get_image("Quality", award_ui.transform)
  Util.load_quality_icon(item_id, quality_img.gameObject)
  local obj = self:create_item_obj(nil, quality_img.gameObject, nil, {item_id = item_id})
  local button = Util.get_button(nil, obj.v_object)
  if button then
    button.enabled = false
  end
end

function ui:check_fight()
  local cur_val = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  if cur_val < self.v_cost_val then
    UIMgr:get_ui("uiforcerecharg"):ui_show()
    return false
  end
  return true
end

function ui:click_fight_btn()
  if not self:check_fight() then
    return
  end
  if TowerMgr:check_fight_progress() then
    return
  end
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.CHALLENGE_RING then
    UIMgr:get_ui("team"):ui_show(nil, self.v_point_id, CommonDef.CHALLENGE_TYPE.CHALLENGE_RING)
  elseif self.v_fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    UIMgr:get_ui("team"):ui_show(nil, self.v_point_id, CommonDef.CHALLENGE_TYPE.BUDDY_TEACH, self.v_buddy_id, nil, self.v_floor_index)
  elseif self.v_fight_type == CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE then
    UIMgr:get_ui("team"):ui_show(nil, self.v_point_id, CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE)
  else
    UIMgr:get_ui("team"):ui_show(self.v_chapter_id, self.v_point_id, self.v_fight_type)
  end
  self:ui_hide()
end

function ui:update_force_info()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local cost_val = point_cfg.FightCost[1]
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.BUDDY_TEACH then
    cost_val = Util.get_buddy_teach_fight_cost(self.v_buddy_id, self.v_point_id, self.v_floor_index)
  else
    local first_fight = ChapterMgr:check_no_first_suc_by_point_id(self.v_chapter_id, self.v_point_id)
    if not first_fight then
      cost_val = point_cfg.FightCost[2]
    end
  end
end

function ui:update_point_desc()
  self.v_uiobjects.StageDesc:SetActive(self.v_point_cfg.PointDesc ~= nil)
  if not self.v_point_cfg.PointDesc then
    return
  end
  self.v_uicompents.Describe_txt.text = self.v_point_cfg.PointDesc
end

function ui:play_dynamic_effect(obj_state)
  self:set_cannot_touch()
  local stinfo_rect = Util.get_rect_transform(nil, self.v_uiobjects.StInfo.transform)
  self:clear_sequence()
  local canvas_group = self:get_canvas_group(nil, self.v_uiobjects.StInfo)
  local sequence = Util.create_sequence()
  if obj_state == OBJ_STATE.SHOW then
    stinfo_rect:SetAnchoredPositionA(self.v_original_pos.x, self.v_original_pos.y, self.v_original_pos.z)
    canvas_group.alpha = 0
    sequence:Append(canvas_group:DOFade(1, cost_time))
    sequence:Join(stinfo_rect:DOAnchorPosX(self.v_target_pos.x, cost_time))
  elseif obj_state == OBJ_STATE.HIDE then
    sequence:Append(canvas_group:DOFade(0, cost_time))
    sequence:Join(stinfo_rect:DOAnchorPosX(self.v_original_pos.x, cost_time))
  end
  self.v_sequence = sequence
end

function ui:set_cannot_touch()
  self:remove_cannot_touch_timer()
  self.v_uiobjects.Cannot_Touch_Bg:SetActive(true)
  self.v_cannot_touch_timer = Timer:add_timer("cannot_touch_timer", cost_time, function()
    self.v_uiobjects.Cannot_Touch_Bg:SetActive(false)
  end)
end

function ui:remove_cannot_touch_timer()
  if self.v_cannot_touch_timer then
    Timer:remove_timer(self.v_cannot_touch_timer)
    self.v_cannot_touch_timer = nil
  end
end

function ui:clear_sequence()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:remove_delay_hide_timer()
  if self.v_delay_hide_timer then
    Timer:remove_timer(self.v_delay_hide_timer)
    self.v_delay_hide_timer = nil
  end
end

return ui
