local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AWARD_ITEM_KEY = "AWARD_ITEM_KEY"
local mathx = require("base.mathx")

function ui:ui_finish_load()
  self:register_exist_auto_template(AWARD_ITEM_KEY, self.v_uiobjects.TaskTem, self.v_uiobjects.Content)
  self.v_level_award_map = {}
  local horizontal_grp = self.v_uiobjects.Content:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
  self.v_space = horizontal_grp.spacing
  self.v_temp_item_width = self.v_uiobjects.TaskTem.transform:GetSizeDeltaA()
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_PLAYER_LVUP, self.on_player_lvup, self)
  self:refresh()
end

function ui:refresh()
  local player_lv = PlayerMgr:get_role_lv()
  self.v_uicompents.PlayerLvNum_txt.text = player_lv
  self.v_level_award_data = NoviceMgr:get_activity_level_award_data()
  for key, value in pairs(self.v_level_award_data.level_award_list) do
    self.v_level_award_map[value] = true
  end
  local cfg = ShareRes.get_level_welfare_cfg()
  local has_award = false
  local next_award_index = 1
  self:give_back_auto_cache(AWARD_ITEM_KEY)
  for index, value in ipairs(cfg) do
    if not has_award and player_lv >= value.Level and not self.v_level_award_map[value.Id] then
      has_award = true
      next_award_index = index
    end
    local item = self:get_auto_cache(AWARD_ITEM_KEY)
    self:set_data(item, value)
  end
  local award_count = #cfg
  local content_width = award_count * self.v_temp_item_width + (award_count - 1) * self.v_space
  local scroll_view_width = self.v_uiobjects.ScrollView.transform.rect.width
  local w_delta = math.abs(scroll_view_width - content_width)
  local next_award_pos = (next_award_index - 1) * (self.v_temp_item_width + self.v_space)
  local new_content_x = mathx.Clamp(next_award_pos, 0, w_delta)
  local _, content_y = self.v_uiobjects.Content.transform:GetAnchoredPositionA()
  self.v_uiobjects.Content.transform:SetAnchoredPositionA(-new_content_x, content_y)
end

function ui:ui_on_destroy()
  self.v_level_award_map = nil
end

function ui:ui_on_hide()
end

function ui:set_data(item, cfg)
  local lv = Util.get_text("Content/Lv_", item)
  local btn_unfinish = Util.get_button("Content/BtnUnfinish_", item)
  local btn_recive = Util.get_button("Content/BtnRecive_", item)
  local recived_mask = Util.get_child_gameobj("Content/RecivedMask_", item)
  local award1 = Util.get_child_gameobj("Content/award1_", item)
  local award2 = Util.get_child_gameobj("Content/award2_", item)
  local award_mask_2 = Util.get_child_gameobj("AwardMask2_", recived_mask)
  local Bg_ = Util.get_child_gameobj("Content/Bg_", item)
  local BgRecive_ = Util.get_child_gameobj("Content/BgRecive_", item)
  local award_group_cfg = ShareRes.get_awards(cfg.AwardGroupId)
  for k, v in pairs(award_group_cfg) do
    local item_id = v.ItemId
    local item_num = v.Num
    local item_icon_path = ShareRes.get_item_icon_path(item_id)
    local item_quality_path = ShareRes.get_item_quality_path(item_id)
    self:set_award_item(1 == k and award1 or award2, item_id, item_icon_path, item_quality_path, item_num)
  end
  award2:SetActive(#award_group_cfg > 1)
  award_mask_2:SetActive(#award_group_cfg > 1)
  lv.text = cfg.Level
  local player_level = PlayerMgr:get_role_lv()
  btn_unfinish:SetActive(player_level < cfg.Level)
  btn_recive:SetActive(player_level >= cfg.Level and not self.v_level_award_map[cfg.Id])
  recived_mask:SetActive(self.v_level_award_map[cfg.Id])
  Bg_:SetActive(self.v_level_award_map[cfg.Id])
  BgRecive_:SetActive(not self.v_level_award_map[cfg.Id])
  self:set_button_listener(btn_recive, function()
    NoviceMgr:request_activity_level_award_gain(self.v_level_award_data.activity_id, cfg.Id)
  end)
end

function ui:set_award_item(obj, item_id, item_icon_path, item_quality_path, item_num)
  local item_icon = Util.get_image("ItemIcon_", obj)
  local item_quality = Util.get_image("ItemQuality_", obj)
  local item_num_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", obj)
  local award_btn = Util.get_button(nil, obj)
  ResMgr:load_set_icon(item_icon, item_icon_path)
  ResMgr:load_set_icon(item_quality, item_quality_path)
  item_num_txt.text = item_num
  self:set_button_listener(award_btn, function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
  end)
end

function ui:on_player_lvup()
  self:refresh()
end

return ui
