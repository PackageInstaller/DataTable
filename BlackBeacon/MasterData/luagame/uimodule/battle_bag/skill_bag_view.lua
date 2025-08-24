local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local SKILL_BAG_CHAR = "SKILL_BAG_CHAR"
local SKILL_BAG_SKILL = "SKILL_BAG_SKILL"
local SKILL_BAG_TALENT = "SKILL_BAG_TALENT"
local TEMPLATE_KEY_DATA_ITEM = "SKILL_BAG_TEMPLATE_KEY_DATA_ITEM"
local SKILL_BAG_CHAR_CLASS = require("uimodule.battle_bag.skill_bag_hero_item")
local Char_Helper = require("uimodule.character.char_helper")
local _tinsert = table.insert
local _tsort = table.sort
local SKILL_BAG_PAGE = {PAGE_SKILL = 1, PAGE_TALENT = 2}

function ui:ui_finish_load()
  self:register_exist_auto_template(SKILL_BAG_CHAR, self.v_uiobjects.CharTem, self.v_uiobjects.CharTem.transform.parent.gameObject)
  self:register_exist_auto_template(SKILL_BAG_SKILL, self.v_uiobjects.SkillTem, self.v_uiobjects.SkillList)
  self:register_exist_auto_template(SKILL_BAG_TALENT, self.v_uiobjects.TalentTem, self.v_uiobjects.TalentList)
  self:register_exist_auto_template(TEMPLATE_KEY_DATA_ITEM, self.v_uiobjects.DateScrollTem, self.v_uiobjects.DateScrollContent)
  local tog_skill = Util.get_toggle(nil, self.v_uiobjects.PageSkill)
  local tog_talent = Util.get_toggle(nil, self.v_uiobjects.PageTalent)
  self:set_toggle_listener(tog_skill, function(is_on)
    if is_on and self.v_show_data.cur_select_page ~= SKILL_BAG_PAGE.PAGE_SKILL then
      self:on_switch_page_skillortalent(SKILL_BAG_PAGE.PAGE_SKILL)
    end
  end)
  self:set_toggle_listener(tog_talent, function(is_on)
    if is_on and self.v_show_data.cur_select_page ~= SKILL_BAG_PAGE.PAGE_TALENT then
      self:on_switch_page_skillortalent(SKILL_BAG_PAGE.PAGE_TALENT)
    end
  end)
  self:set_button("SkillDesc", function()
    self:try_show_keyword()
  end)
  self.v_tmp_text = self.v_uiobjects.SkillDesc:GetComponent(typeof(CS.TMPro.TMP_Text))
end

function ui:ui_on_show(hero)
  self.v_tmp_text = self.v_uiobjects.SkillDesc:GetComponent(typeof(CS.TMPro.TMP_Text))
  self.v_hero = hero
  self:refresh_skill_bag_info()
  self:refresh_skill_bag_content()
end

function ui:ui_on_hide()
  self.v_show_data = nil
end

function ui:ui_on_destroy()
end

function ui:refresh_skill_bag_info()
  self.v_show_data = {}
  self.v_show_data.hero_list, self.v_show_data.buddy_id_list, self.v_show_data.skills_data, self.v_show_data.tallents_data = self:get_all_hero_data()
  self.v_show_data.cur_hero_buddy_id = self:get_default_show_buddy_id(self.v_show_data.hero_list, self.v_hero)
  self.v_show_data.cur_select_skill_idx = 1
  self.v_show_data.cur_select_tallent_idx = 1
  self.v_show_data.cur_select_page = SKILL_BAG_PAGE.PAGE_SKILL
end

function ui:get_all_hero_data()
  local hero_list = SceneMgr:get_hero_list()
  local hero_team_pos = SceneMgr:get_heros_team_pos()
  local hero_to_pos = {}
  local sort_hero_list = {}
  for index, pos_data in pairs(hero_team_pos) do
    hero_to_pos[pos_data.buddy_id] = pos_data.pos
  end
  for uuid, data in pairs(hero_list) do
    local insert_data = {}
    insert_data.uuid = uuid
    insert_data.buddy_type = data.v_type
    insert_data.buddy_id = data.buddy_cfg.Id
    insert_data.fashion_id = data:get_fashion_id()
    insert_data.pos = hero_to_pos[data.buddy_cfg.Id] or data.buddy_cfg.Id
    _tinsert(sort_hero_list, insert_data)
  end
  _tsort(sort_hero_list, function(a, b)
    return a.pos < b.pos
  end)
  local buddy_id_list = {}
  for _, data in pairs(sort_hero_list) do
    _tinsert(buddy_id_list, data.buddy_id)
  end
  local skills_data_by_buddyId = {}
  local tallents_data_by_buddyId = {}
  for _, buddy_id in pairs(buddy_id_list) do
    local skill_data = {}
    skill_data.skill_lv_data = nil
    skill_data.skill_detail_data = nil
    local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
    local skill_lv_temp = {}
    if nil ~= buddy_info then
      for _, v in pairs(buddy_info.lSkill) do
        skill_lv_temp[v.id] = {
          lv = v.lv or 1
        }
      end
    end
    skill_data.skill_lv_data = skill_lv_temp
    local all_skill = ShareRes.get_buddy_skill_list_cfg(buddy_id).Skill
    local skill_detail_temp = {}
    for _, skill_id in ipairs(all_skill) do
      local detail_cfg = ShareRes.get_buddy_skill_details_cfg(skill_id)
      skill_detail_temp[#skill_detail_temp + 1] = detail_cfg
    end
    skill_data.skill_detail_data = skill_detail_temp
    skills_data_by_buddyId[buddy_id] = skill_data
    local tallents_data_temp = ShareRes.get_buddy_talent_lv_cfg_list(buddy_id)
    table.sort(tallents_data_temp, function(a, b)
      return a.Lv < b.Lv
    end)
    tallents_data_by_buddyId[buddy_id] = tallents_data_temp
  end
  return sort_hero_list, buddy_id_list, skills_data_by_buddyId, tallents_data_by_buddyId
end

function ui:get_default_show_buddy_id(hero_list, hero)
  for _, data in pairs(hero_list) do
    if data.uuid == hero.uuid then
      return data.buddy_id
    end
  end
end

function ui:refresh_skill_bag_content()
  self:refresh_hero(self.v_show_data.hero_list)
  self:refresh_skill()
  self:refresh_talent()
  self:on_switch_page_skillortalent(SKILL_BAG_PAGE.PAGE_SKILL)
  local tog_skill = Util.get_toggle(nil, self.v_uiobjects.PageSkill)
  tog_skill.isOn = true
end

function ui:refresh_hero(use_data)
  self:give_back_auto_cache(SKILL_BAG_CHAR)
  self:clear_hero_item_list()
  self.v_hero_item_list = {}
  self.v_hero_item_map = {}
  local idx = 1
  local select_hero_uuid = self.v_hero.uuid
  for _, hero_data in ipairs(use_data) do
    local uuid = hero_data.uuid
    local hero_item_go = self:get_auto_cache(SKILL_BAG_CHAR)
    local lua_obj = SKILL_BAG_CHAR_CLASS:ui_wrap_ex(self, hero_item_go, true)
    lua_obj:set_data(hero_data, idx)
    self.v_hero_item_list[idx] = lua_obj
    self.v_hero_item_map[uuid] = idx
    idx = idx + 1
  end
  local select_idx = self.v_hero_item_map[select_hero_uuid]
  self.v_hero_item_list[select_idx]:on_select(select_idx)
end

function ui:clear_hero_item_list()
  if self.v_hero_item_list then
    self:remove_wrap_ui_list(self.v_hero_item_list)
    self.v_hero_item_list = nil
    self.v_hero_item_map = nil
  end
end

function ui:refresh_skill()
  local all_skill_detail_data = self.v_show_data.skills_data[self.v_show_data.cur_hero_buddy_id].skill_detail_data
  local all_skill_lv_data = self.v_show_data.skills_data[self.v_show_data.cur_hero_buddy_id].skill_lv_data
  self:give_back_auto_cache(SKILL_BAG_SKILL)
  self.v_skill_select_effobj = {}
  local hero = SceneMgr:get_hero_by_id(self.v_show_data.cur_hero_buddy_id)
  local skill_data
  if hero and hero:get_buddy_data() then
    skill_data = hero:get_buddy_data().skill_data
  end
  for idx, data in ipairs(all_skill_detail_data) do
    local skill_obj = self:get_auto_cache(SKILL_BAG_SKILL)
    local icon = Util.get_image("Icon_", skill_obj)
    local skill_lv_text = Util.get_text("SkillLevel/SkillLvNum_", skill_obj)
    local skill_lv_max_obj = Util.get_child_gameobj("SkillLevel/LvMax_", skill_obj)
    local skill_type = Util.get_text("SkillType_", skill_obj)
    local btn = Util.get_button(nil, skill_obj)
    self.v_skill_select_effobj[idx] = Util.get_child_gameobj("Select_", skill_obj)
    self.v_skill_select_effobj[idx]:SetActive(false)
    Util.load_skill_icon(data.Icon, icon)
    local skill_lv_data = all_skill_lv_data[data.Id] or {}
    local skill_lv = skill_lv_data.lv or 1
    if skill_data and skill_data[data.Id] then
      skill_lv = skill_data[data.Id].lv
    end
    if skill_lv_data.lv or skill_data[data.Id] then
      local max_lv = ShareRes.get_buddy_skill_max_lv(data.Id)
      skill_lv_text.gameObject:SetActiveEx(skill_lv < max_lv)
      skill_lv_max_obj:SetActiveEx(skill_lv >= max_lv)
    else
      skill_lv_text.gameObject:SetActiveEx(true)
      skill_lv_max_obj:SetActiveEx(false)
    end
    skill_lv_text.text = Util.format_str("{1}级", skill_lv)
    skill_type.text = data.SkillTypeName
    self:set_button_listener(btn, function()
      self:on_switch_skill(idx)
    end)
  end
  self.v_skill_select_effobj[self.v_show_data.cur_select_skill_idx]:SetActive(true)
end

local icon_lock_color = Util.get_unity_color_by_hex(tonumber("9a9a9a", 16))
local icon_unlock_color = Util.get_unity_color_by_hex(tonumber("ffffff", 16))

function ui:refresh_talent()
  local all_tallents_data = self.v_show_data.tallents_data[self.v_show_data.cur_hero_buddy_id]
  self:give_back_auto_cache(SKILL_BAG_TALENT)
  self.v_talent_select_effobj = {}
  self.v_talent_is_lock = {}
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_show_data.cur_hero_buddy_id)
  local buddy_talent_lv = 0
  if nil ~= buddy_info then
    buddy_talent_lv = buddy_info.talent_lv or 0
  end
  local hero = SceneMgr:get_hero_by_id(self.v_show_data.cur_hero_buddy_id)
  if hero and hero:get_buddy_data() then
    buddy_talent_lv = hero:get_buddy_data().talent_lv
  end
  for idx, data in ipairs(all_tallents_data) do
    local tallent_obj = self:get_auto_cache(SKILL_BAG_TALENT)
    self.v_talent_select_effobj[idx] = Util.get_child_gameobj("Select_", tallent_obj)
    local icon = Util.get_image("TalentIcon_", tallent_obj)
    local unlock_bg = Util.get_child_gameobj("Bg/UnLockBg_", tallent_obj)
    local btn = Util.get_button(nil, tallent_obj)
    Util.load_talent_icon(data.Icon, icon)
    self.v_talent_select_effobj[idx]:SetActive(false)
    local is_lock = buddy_talent_lv < data.Lv
    self.v_talent_is_lock[idx] = is_lock
    unlock_bg:SetActive(not is_lock)
    icon.color = is_lock and icon_lock_color or icon_unlock_color
    self:set_button_listener(btn, function()
      self:on_switch_talent(idx)
    end)
  end
  self.v_talent_select_effobj[self.v_show_data.cur_select_tallent_idx]:SetActive(true)
end

function ui:refresh_skill_describe(idx)
  idx = idx or self.v_show_data.cur_select_skill_idx
  local all_skill_data = self.v_show_data.skills_data[self.v_show_data.cur_hero_buddy_id].skill_detail_data
  local skill_detail_data = all_skill_data[idx]
  local all_skill_lv_data = self.v_show_data.skills_data[self.v_show_data.cur_hero_buddy_id].skill_lv_data
  local skill_id = skill_detail_data.Id
  local skill_lv_data = all_skill_lv_data[skill_id] or {}
  local skill_max_lv = ShareRes.get_buddy_skill_max_lv(skill_id)
  local skill_lv = skill_lv_data.lv or 1
  local hero = SceneMgr:get_hero_by_id(self.v_show_data.cur_hero_buddy_id)
  local skill_data
  if hero and hero:get_buddy_data() then
    skill_data = hero:get_buddy_data().skill_data
    if skill_data and skill_data[skill_id] then
      skill_lv = skill_data[skill_id].lv
    end
  end
  skill_lv = skill_max_lv < skill_lv and skill_max_lv or skill_lv
  local lv_cfg = ShareRes.get_buddy_skill_lv_cfg(skill_id, skill_lv)
  self.v_uicompents.SkillType_txt.text = skill_detail_data.SkillTypeName
  self.v_uicompents.SkillName_txt.text = skill_detail_data.Name
  self.v_tmp_text.text = lv_cfg.Desc
  if skill_max_lv == skill_lv then
    self.v_uicompents.SkillState_txt.text = Util.format_str("MAX")
  else
    self.v_uicompents.SkillState_txt.text = Util.format_str("{1}级", skill_lv)
  end
  self.v_keyword_list = skill_detail_data.Keywords
  self:_show_data_items(lv_cfg)
end

function ui:_show_data_items(lv_cfg)
  self:give_back_auto_cache(TEMPLATE_KEY_DATA_ITEM)
  if not lv_cfg then
    return
  end
  local data_name_list = lv_cfg.DataTxt
  if not data_name_list or 0 == #data_name_list then
    return
  end
  for idx, name in ipairs(data_name_list) do
    local item = self:get_auto_cache(TEMPLATE_KEY_DATA_ITEM)
    Util.get_text("DateName", item).text = name
    Util.get_text("DateNum", item).text = lv_cfg.DataVal[idx]
  end
end

function ui:refresh_talent_describe(idx)
  idx = idx or self.v_show_data.cur_select_tallent_idx
  local all_talent_data = self.v_show_data.tallents_data[self.v_show_data.cur_hero_buddy_id]
  local talent_data = all_talent_data[idx]
  self.v_uicompents.SkillType_txt.text = talent_data.Type
  self.v_uicompents.SkillName_txt.text = ""
  local attr_desc = CharacterMgr:get_talent_attr_desc(self.v_show_data.cur_hero_buddy_id, idx)
  if talent_data.Desc and "" ~= talent_data.Desc then
    if attr_desc then
      self.v_tmp_text.text = talent_data.Desc .. "\n" .. attr_desc
    else
      self.v_tmp_text.text = talent_data.Desc
    end
  else
    self.v_tmp_text.text = attr_desc
  end
  if self.v_talent_is_lock[idx] then
    self.v_uicompents.SkillState_txt.text = Util.format_str("未解锁")
  else
    self.v_uicompents.SkillState_txt.text = Util.format_str("已解锁")
  end
  self.v_keyword_list = talent_data.Keywords
  self:_show_data_items()
end

function ui:on_switch_buddy(buddy_id)
  if self.v_show_data.cur_hero_buddy_id == buddy_id then
    return
  end
  self.v_show_data.cur_hero_buddy_id = buddy_id
  self.v_show_data.cur_select_skill_idx = 1
  self.v_show_data.cur_select_tallent_idx = 1
  self:refresh_talent()
  self:refresh_skill()
  self:on_switch_page_skillortalent(self.v_show_data.cur_select_page)
end

function ui:on_switch_skill(idx)
  self.v_skill_select_effobj[self.v_show_data.cur_select_skill_idx]:SetActive(false)
  self.v_show_data.cur_select_skill_idx = idx
  self.v_skill_select_effobj[self.v_show_data.cur_select_skill_idx]:SetActive(true)
  self:refresh_skill_describe(idx)
end

function ui:on_switch_talent(idx)
  self.v_talent_select_effobj[self.v_show_data.cur_select_tallent_idx]:SetActive(false)
  self.v_show_data.cur_select_tallent_idx = idx
  self.v_talent_select_effobj[self.v_show_data.cur_select_tallent_idx]:SetActive(true)
  self:refresh_talent_describe(idx)
end

function ui:on_switch_page_skillortalent(page)
  self.v_show_data.cur_select_page = page
  if page == SKILL_BAG_PAGE.PAGE_SKILL then
    self.v_uiobjects.SkillList:SetActive(true)
    self.v_uiobjects.TalentList:SetActive(false)
    self:on_switch_skill(self.v_show_data.cur_select_skill_idx)
  elseif page == SKILL_BAG_PAGE.PAGE_TALENT then
    self.v_uiobjects.SkillList:SetActive(false)
    self.v_uiobjects.TalentList:SetActive(true)
    self:on_switch_talent(self.v_show_data.cur_select_tallent_idx)
  end
end

function ui:try_show_keyword()
  if self.v_keyword_list then
    UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_keyword_list)
  end
end

return ui
