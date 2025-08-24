local Base = require("ui.uiobject")
local DROP_ABILITY_ITEM_CLASS = require("uimodule.stage_activity.challenge_ring_plus.drop_ability_item")
local ui = Util.create_child_mt(Base)
local ABILITY_TEM = "ABILITY_TEM"
local GROUP_TOGGLE_TEM = "GROUP_TOGGLE_TEM"
local SELECT_PAGE_TYPE = {GENRES_PAGE = 1, ABILITY_PAGE = 2}
local TOTAL_GROUP_ID = 0

function ui:on_click_StageSkillDesc()
  if self.v_key_id_list then
    UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_key_id_list, 0, true)
  end
end

function ui:ui_finish_load()
  self:set_toggle_listener(self.v_uicompents.PageSect_tog, function(is_on)
    self.v_uicompents.PageSect_tog.interactable = not is_on
    self:change_select_page(is_on, SELECT_PAGE_TYPE.GENRES_PAGE)
  end)
  self:set_toggle_listener(self.v_uicompents.PageTalent_tog, function(is_on)
    self:change_select_page(is_on, SELECT_PAGE_TYPE.ABILITY_PAGE)
  end)
  self:set_button("StageSkillDesc", function()
    self:on_click_StageSkillDesc()
  end)
  self:set_button("StageSkillDesc2", function()
    self:on_click_StageSkillDesc()
  end)
  self:set_button("StageSkillDesc3", function()
    self:on_click_StageSkillDesc()
  end)
  ABILITY_TEM = ABILITY_TEM .. self.v_parent_ui:ui_get_name()
  GROUP_TOGGLE_TEM = GROUP_TOGGLE_TEM .. self.v_parent_ui:ui_get_name()
  self:register_exist_auto_template(ABILITY_TEM, self.v_uiobjects.AbilityTem, self.v_uiobjects.AbilityContent)
  self:register_exist_auto_template(GROUP_TOGGLE_TEM, self.v_uiobjects.ScreenTem, self.v_uiobjects.ScreenGroup)
  self.v_drop_ability_item_map = {}
  self.v_genres_tog_map = {}
end

function ui:on_show_ui(msg)
  if msg.mm_obj == "keyword_tips_v2" then
    self.v_uiobjects.BgClose:SetActive(true)
  end
end

function ui:on_hide_ui(msg)
  if msg.mm_obj == "keyword_tips_v2" then
    self.v_uiobjects.BgClose:SetActive(false)
  end
end

function ui:ui_on_show(preview_data, main_sect)
  self.v_main_sect = main_sect
  self.v_preview_data = preview_data
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.on_hide_ui, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.on_show_ui, self)
  self.v_uicompents.PageTalent_tog.isOn = false
  self.v_uicompents.PageTalent_tog.isOn = true
  self.v_uicompents.ScreenAll_tog.isOn = false
  self.v_uicompents.ScreenAll_tog.isOn = true
end

function ui:ui_on_hide()
  self.v_preview_data = nil
  self.v_key_id_list = nil
  self:remove_all_group()
end

function ui:ui_on_destroy()
end

function ui:on_click_genres_tog(is_on, genres_id)
  if not is_on then
    return
  end
  self:change_select_genres(is_on, genres_id)
end

function ui:create_ability_item(ability_list)
  if not ability_list or not next(ability_list) then
    return
  end
  local sort_list = ability_list
  local a_cfg, b_cfg
  table.sort(sort_list, function(a, b)
    a_cfg = ShareRes.get_ability_cfg(a.ability_id)
    b_cfg = ShareRes.get_ability_cfg(b.ability_id)
    if a_cfg.Quality ~= b_cfg.Quality then
      return a_cfg.Quality > b_cfg.Quality
    elseif a_cfg.Id ~= b_cfg.Id then
      return a_cfg.Id > b_cfg.Id
    else
      return false
    end
  end)
  for key, ability_info in pairs(sort_list) do
    local obj = self:get_auto_cache(ABILITY_TEM)
    self.v_drop_ability_item_map[ability_info.ability_id] = DROP_ABILITY_ITEM_CLASS:ui_wrap(self, obj, true)
    self.v_drop_ability_item_map[ability_info.ability_id]:set_data(ability_info.ability_id, nil, true, true, ability_info.ability_grade, true)
  end
end

function ui:change_select_genres(is_on, genres_id)
  self:remove_all_group()
  local ability_list
  if self.v_preview_data then
    ability_list = self.v_preview_data[genres_id] and self.v_preview_data[genres_id].sect_ability
  else
    ability_list = GenresMgr:get_show_ability_list(genres_id)
  end
  self:create_ability_item(ability_list)
  local total_num = GenresMgr:get_ability_count(genres_id)
  if ability_list then
    total_num = UtilTable.hash_lenth(ability_list)
  end
  local genres_cfg = ShareRes.get_genres_cfg(genres_id)
  self.v_uicompents.SectName1_txt.text = genres_cfg and genres_cfg.Name or Util.format_str("全部片语")
  self.v_uicompents.TalentNum_txt.text = total_num
  self.v_uiobjects.NoTalent:SetActive(total_num <= 0)
end

function ui:change_select_page(is_on, page_type)
  if page_type == SELECT_PAGE_TYPE.GENRES_PAGE then
    self.v_uiobjects.SectObj:SetActive(is_on)
    if is_on then
      self:refresh_genres_page()
    end
  elseif page_type == SELECT_PAGE_TYPE.ABILITY_PAGE then
    self.v_uiobjects.TalentObj:SetActive(is_on)
    if is_on then
      self:refresh_ability_page()
    end
  end
end

function ui:refresh_ability_page()
  self:give_back_auto_cache(GROUP_TOGGLE_TEM)
  self.v_genres_tog_map = {}
  local genres_map = self.v_preview_data or GenresMgr:get_genres_map()
  for key, genres_data in pairs(genres_map) do
    if not self.v_preview_data or key ~= TOTAL_GROUP_ID then
      local obj = self:get_auto_cache(GROUP_TOGGLE_TEM)
      self:refresh_ability_tog(obj, genres_data.sect_id)
    end
  end
  self:refresh_ability_tog(self.v_uiobjects.ScreenAll, TOTAL_GROUP_ID)
end

function ui:refresh_ability_tog(obj, genres_id)
  local num = self:get_text("TalentNum", obj)
  local count = GenresMgr:get_ability_count(genres_id)
  if self.v_preview_data and self.v_preview_data[genres_id] then
    count = UtilTable.hash_lenth(self.v_preview_data[genres_id].sect_ability)
  end
  num.text = count
  if genres_id ~= TOTAL_GROUP_ID then
    local icon = self:get_image("Icon", obj)
    local cfg = ShareRes.get_genres_cfg(genres_id)
    ResMgr:load_set_icon(icon, cfg.IconPath, nil, true)
  end
  local tog = self:get_toggle(nil, obj)
  self.v_genres_tog_map[genres_id] = tog
  self:set_toggle_listener(tog, function(is_on)
    tog.interactable = not is_on
    self:on_click_genres_tog(is_on, genres_id)
  end)
end

function ui:refresh_genres_page()
  local main_genres_id = self.v_main_sect or GenresMgr:get_main_genres_id()
  local cfg = ShareRes.get_genres_cfg(main_genres_id)
  self:set_skill_info(cfg.Skill, cfg)
end

function ui:set_skill_info(skill_id, genres_cfg)
  local desc_cfg = ShareRes.create("activity.sect_client_desc")
  local skill_level_cfg = ShareRes.create("battle.scene_skill_level")[skill_id]
  ResMgr:load_set_icon(self.v_uicompents.StageSkill_Icon_img, skill_level_cfg[1].IconPath)
  self.v_uicompents.SkillName_txt.text = skill_level_cfg[1].Name
  self.v_uicompents.StageSkillDesc_txt.text = skill_level_cfg[1].Desc
  self.v_uicompents.LvUpTips_txt.text = Util.format_str(desc_cfg[2].Desc, genres_cfg.Name)
  self.v_uicompents.SectName_txt.text = genres_cfg.Name
  local need_build_keyword = not self.v_key_id_list
  if need_build_keyword then
    self.v_key_id_list = {}
    if skill_level_cfg[1].KeyIDList then
      for key, id in ipairs(skill_level_cfg[1].KeyIDList) do
        self.v_key_id_list[#self.v_key_id_list + 1] = id
      end
    end
  end
  local canvas_group
  local skill_data = TowerMgr:get_scene_skill_data()
  local skill_lv = self.v_preview_data and #skill_level_cfg or skill_data and skill_data.lv or 0
  for index = 2, 3 do
    canvas_group = self:get_canvas_group(nil, self.v_uiobjects["Content" .. index])
    if index <= skill_lv then
      self.v_uiobjects["BgUnLock" .. index]:SetActive(true)
      self.v_uiobjects["Unlock" .. index]:SetActive(true)
      self.v_uiobjects["BgLock" .. index]:SetActive(false)
      self.v_uiobjects["Lock" .. index]:SetActive(false)
      canvas_group.alpha = 1
    else
      self.v_uiobjects["BgUnLock" .. index]:SetActive(false)
      self.v_uiobjects["Unlock" .. index]:SetActive(false)
      self.v_uiobjects["Lock" .. index]:SetActive(true)
      self.v_uiobjects["BgLock" .. index]:SetActive(true)
      canvas_group.alpha = 0.2
    end
    self.v_uicompents["StageSkillDesc" .. index .. "_txt"].text = skill_level_cfg[index].Desc
    self.v_uicompents["SkillName" .. index .. "_txt"].text = skill_level_cfg[index].Name
    if need_build_keyword and skill_level_cfg[index].KeyIDList then
      for key, id in ipairs(skill_level_cfg[1].KeyIDList) do
        self.v_key_id_list[#self.v_key_id_list + 1] = id
      end
    end
  end
end

function ui:force_select_genres(genres_id)
  self.v_genres_tog_map[genres_id].isOn = false
  self.v_genres_tog_map[genres_id].isOn = true
end

function ui:remove_all_group()
  self:give_back_auto_cache(ABILITY_TEM)
  for key, drop_abilit_item in pairs(self.v_drop_ability_item_map) do
    drop_abilit_item:ui_hide()
    drop_abilit_item:ui_destroy()
    self.v_drop_ability_item_map[key] = nil
  end
end

return ui
