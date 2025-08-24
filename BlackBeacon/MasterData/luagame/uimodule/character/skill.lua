local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local SKILL_ITEM_KEY = "SKILL_ITEM_KEY"
local SKILL_DETAILS_KEY = "SKILL_DETAILS_KEY"
local SKILL_INFO_KEY = "SKILL_INFO_KEY"
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local SKILL_TYPE_ACTIVE = 1
local SKILL_TYPE_PASSIVE = 2
local SKILL_CLICK_INFO = 1
local SKILL_CLICK_DETAIL = 2
local MODEL = {
  v_skill_list_content = {
    "SkillListContent",
    BIND_TYPE.OBJECT
  },
  v_skill_item_template = {
    "ItemTemplate",
    BIND_TYPE.OBJECT
  },
  v_left_panel = {
    "LeftPanel",
    BIND_TYPE.OBJECT
  },
  v_condition = {
    "Condition",
    BIND_TYPE.OBJECT
  },
  v_condition_desc = {
    "ConditionDesc",
    BIND_TYPE.TEXT
  },
  v_active_skill_btn = {
    "ActiveSkill",
    BIND_TYPE.BUTTON
  },
  v_passive_skill_btn = {
    "PassiveSkill",
    BIND_TYPE.BUTTON
  },
  v_skill_details_content = {
    "DetailsContent",
    BIND_TYPE.OBJECT
  },
  v_skill_details_template = {
    "DetailsTemplate",
    BIND_TYPE.OBJECT
  },
  v_skill_details_pnl = {
    "SkillDetail",
    BIND_TYPE.OBJECT
  },
  v_skill_info_pnl = {
    "InfoList",
    BIND_TYPE.OBJECT
  },
  v_skill_info_content = {
    "SkillInfoContent",
    BIND_TYPE.OBJECT
  },
  v_skill_info_template = {
    "InfoTemplate",
    BIND_TYPE.OBJECT
  },
  v_skill_upgrade = {
    "BtnUpgrade",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:set_button("BtnRet", function()
    self:set_enable(false)
  end)
  self:set_button("ActiveSkill", function()
    self:_on_click_active_skill()
  end)
  self:set_button("PassiveSkill", function()
    self:_on_click_passive_skill()
  end)
  self:set_button("BtnSkillInfo", function()
    self:_on_click_btn_skill_info()
  end)
  self:set_button("BtnSkillDetail", function()
    self:_on_click_skill_detail()
  end)
  self:set_button("BtnUpgrade", function()
    self:_on_click_skill_Upgrade()
  end)
  self:set_button("backBtn", function()
    for k, skill_ui in pairs(self.v_skill_ui) do
      local choose_img = Util.get_image("Choose", skill_ui.transform)
      choose_img.gameObject:SetActive(false)
    end
    self.v_select_skill = {}
    self.v_left_panel:SetActive(false)
    local character_main = self.v_parent_ui:get_panel("char_main")
    character_main:update_left_view(true)
  end)
  self:init_model(MODEL)
  self:register_exist_auto_template(SKILL_ITEM_KEY, self.v_skill_item_template, self.v_skill_list_content)
  self:register_exist_auto_template(SKILL_DETAILS_KEY, self.v_skill_details_template, self.v_skill_details_content)
  self:register_exist_auto_template(SKILL_INFO_KEY, self.v_skill_info_template, self.v_skill_info_content)
end

function ui:ui_on_show(buddy_idx)
end

function ui:ui_on_hide()
  self.v_skill_type = nil
end

function ui:refresh(buddy_idx)
  self.v_buddy_idx = buddy_idx
  self:_on_click_active_skill(true)
end

function ui:update_skill_view()
  self.v_skill_type = self.v_skill_type or SKILL_TYPE_ACTIVE
  local buddy_info = CharacterMgr:get_buddy_info(self.v_buddy_idx)
  local skill_list = buddy_info.lSkill
  local new_skill_list = {}
  for i, info in ipairs(skill_list) do
    local skill_details_cfg = ShareRes.get_buddy_skill_details_cfg(info.id)
    if skill_details_cfg.Type == self.v_skill_type then
      info.sort_index = skill_details_cfg.SortIndex
      _tinsert(new_skill_list, info)
    end
  end
  table.sort(new_skill_list, function(a, b)
    if a.sort_index == b.sort_index then
      return a.id > b.id
    end
    return a.sort_index > b.sort_index
  end)
  self:give_back_auto_cache(SKILL_ITEM_KEY)
  self.v_skill_ui = {}
  for _, skill_info in ipairs(new_skill_list) do
    local skill_lv = skill_info.lv
    local skill_id = skill_info.id
    local skill_ui = self:get_auto_cache(SKILL_ITEM_KEY)
    self:update_skill_details(skill_id, skill_lv, skill_ui)
    local choose_img = Util.get_image("Choose", skill_ui.transform)
    choose_img.gameObject:SetActive(false)
    self.v_skill_ui[skill_id] = skill_ui
    self:set_button_listener(Util.get_button(nil, skill_ui), function()
      self:_show_skill_detail(skill_id, skill_lv)
      choose_img.gameObject:SetActive(true)
    end)
  end
  self.v_left_panel:SetActive(false)
end

function ui:update_skill_details(skill_id, skill_lv, skill_ui)
  local skill_details_cfg = ShareRes.get_buddy_skill_details_cfg(skill_id)
  local skill_lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv)
  local name = skill_details_cfg.Name
  Util.get_text("Name", skill_ui).text = name
  local tips = Util.format_str("{1}阶", skill_lv)
  Util.get_text("Jie", skill_ui).text = tips
  local icon_path = string.format("Item/%s", skill_details_cfg.Icon)
  ResMgr:load_set_icon(Util.get_image("Icon", skill_ui), icon_path)
end

function ui:_on_click_active_skill(is_refresh)
  if not is_refresh and self.v_skill_type == SKILL_TYPE_ACTIVE then
    return
  end
  self.v_skill_type = SKILL_TYPE_ACTIVE
  local btn_img = Util.get_image(nil, self.v_active_skill_btn.transform)
  local icon_path = "UI_Button/btn_16"
  ResMgr:load_set_icon(btn_img, icon_path)
  btn_img = Util.get_image(nil, self.v_passive_skill_btn.transform)
  icon_path = "UI_Button/btn_15"
  ResMgr:load_set_icon(btn_img, icon_path)
  self:update_skill_view()
end

function ui:_on_click_passive_skill()
  if self.v_skill_type == SKILL_TYPE_PASSIVE then
    return
  end
  self.v_skill_type = SKILL_TYPE_PASSIVE
  local btn_img = Util.get_image(nil, self.v_passive_skill_btn.transform)
  local icon_path = "UI_Button/btn_16"
  ResMgr:load_set_icon(btn_img, icon_path)
  btn_img = Util.get_image(nil, self.v_active_skill_btn.transform)
  icon_path = "UI_Button/btn_15"
  ResMgr:load_set_icon(btn_img, icon_path)
  self:update_skill_view()
end

function ui:_on_click_skill_detail()
  self.v_last_click_tag = SKILL_CLICK_INFO
  self.v_skill_details_pnl:SetActive(false)
  self.v_skill_info_pnl:SetActive(true)
  local transform_detail = self.v_uicompents.BtnSkillDetail_btn.transform
  local btn_img = Util.get_image(nil, transform_detail)
  local icon_path = "UI_Button/btn_18"
  ResMgr:load_set_icon(btn_img, icon_path)
  local text = Util.get_text("Text", transform_detail)
  local color = tonumber("000000", 16)
  text.color = Util.get_unity_color_by_hex(color)
  local transform_skill = self.v_uicompents.BtnSkillInfo_btn.transform
  btn_img = Util.get_image(nil, transform_skill)
  icon_path = "UI_Button/btn_19"
  ResMgr:load_set_icon(btn_img, icon_path)
  text = Util.get_text("Text", transform_skill)
  local color = tonumber("999999", 16)
  text.color = Util.get_unity_color_by_hex(color)
  local skill_id, skill_lv = self.v_select_skill[1], self.v_select_skill[2]
  local skill_details_cfg = ShareRes.get_buddy_skill_details_cfg(skill_id)
  local skill_lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv)
  local skill_name_list = skill_details_cfg.SkillName
  local skill_effect_list = skill_lv_cfg.SkillEffect
  self:give_back_auto_cache(SKILL_INFO_KEY)
  for index, info_name in ipairs(skill_name_list) do
    if "0" ~= info_name then
      local info_ui = self:get_auto_cache(SKILL_INFO_KEY)
      local skill_name = Util.get_text("Text_name", info_ui.transform)
      local skill_val = Util.get_text("Text_data", info_ui.transform)
      skill_name.text = info_name
      skill_val.text = skill_effect_list[index]
    end
  end
end

function ui:_on_click_btn_skill_info()
  self.v_last_click_tag = SKILL_CLICK_DETAIL
  self.v_skill_details_pnl:SetActive(true)
  self.v_skill_info_pnl:SetActive(false)
  local transform_skill = self.v_uicompents.BtnSkillInfo_btn.transform
  local btn_img = Util.get_image(nil, transform_skill)
  local icon_path = "UI_Button/btn_18"
  ResMgr:load_set_icon(btn_img, icon_path)
  local text = Util.get_text("Text", transform_skill)
  local color = tonumber("000000", 16)
  text.color = Util.get_unity_color_by_hex(color)
  local transform_detail = self.v_uicompents.BtnSkillDetail_btn.transform
  btn_img = Util.get_image(nil, transform_detail)
  icon_path = "UI_Button/btn_19"
  ResMgr:load_set_icon(btn_img, icon_path)
  text = Util.get_text("Text", transform_detail)
  local color = tonumber("999999", 16)
  text.color = Util.get_unity_color_by_hex(color)
  local skill_id, skill_lv = self.v_select_skill[1], self.v_select_skill[2]
  local skill_details_cfg = ShareRes.get_buddy_skill_details_cfg(skill_id)
  local skill_lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv)
  self.v_uicompents.SkillName_txt.text = skill_details_cfg.Name
  local tips = Util.format_str("{1}阶", skill_lv)
  self.v_uicompents.SkillLevel_txt.text = tips
  self:give_back_auto_cache(SKILL_DETAILS_KEY)
  for index, desc_name in ipairs(skill_details_cfg.DescName) do
    local desc_ui = self:get_auto_cache(SKILL_DETAILS_KEY)
    local name_txt = Util.get_text("Name", desc_ui.transform)
    name_txt.text = desc_name
    local detail_txt = Util.get_text("Detil", desc_ui.transform)
    detail_txt.text = skill_details_cfg.Desc[index]
  end
end

function ui:_show_skill_detail(skill_id, skill_lv)
  for id, ui in pairs(self.v_skill_ui) do
    if id ~= skill_id then
      local choose_img = Util.get_image("Choose", ui.transform)
      choose_img.gameObject:SetActive(false)
    end
  end
  self.v_select_skill = {skill_id, skill_lv}
  self.v_left_panel:SetActive(true)
  self.v_condition:SetActive(true)
  self.v_skill_upgrade.gameObject:SetActive(false)
  local character_main = self.v_parent_ui:get_panel("char_main")
  character_main:update_left_view(false)
  local skill_details_cfg = ShareRes.get_buddy_skill_details_cfg(skill_id)
  local skill_lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv)
  self:_on_click_btn_skill_info()
  local skill_next_lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv + 1)
  if not skill_next_lv_cfg then
    self.v_condition:SetActive(false)
    return
  end
  local condition = Condition:check_condition(skill_lv_cfg.Condition)
  if condition then
    self.v_condition:SetActive(false)
    self.v_skill_upgrade.gameObject:SetActive(true)
  else
    self.v_condition:SetActive(true)
    local condition_cfg = ShareRes.create("condition.condition", skill_lv_cfg.Condition)
    self.v_condition_desc.text = condition_cfg.Desc
  end
end

function ui:_on_click_skill_Upgrade()
  if not self.v_select_skill then
    return
  end
end

function ui:upgrade_callback(skill_id, skill_lv)
  local skill_ui = self.v_skill_ui[skill_id]
  self.v_select_skill = {skill_id, skill_lv}
  self:update_skill_details(skill_id, skill_lv, skill_ui)
  if self.v_last_click_tag == SKILL_CLICK_DETAIL then
    self:_on_click_skill_detail()
  else
    self:_on_click_btn_skill_info()
  end
end

return ui
