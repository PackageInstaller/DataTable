local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local RUNE_HELPER = require("gamelogic.activity.rune2_helper")
local CommonDefine = require("cs_share.common_define")
local CURSE_CARD_TYPE = CommonDefine.CURSE_CARD_TYPE
local FORGE_ROOM_RUNE_SKILL_ENTRY_KEY = "FORGE_ROOM_RUNE_SKILL_ENTRY_KEY"
local LV_START = 1
local LV_END = 3
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_entry_content = {
    "EntryContent",
    BIND_TYPE.OBJECT
  },
  v_entry_item = {
    "EntryItem",
    BIND_TYPE.OBJECT
  },
  v_no_entry_name = {
    "NoEntryName",
    BIND_TYPE.TEXT
  },
  v_no_next_rune = {
    "NoNextRune",
    BIND_TYPE.OBJECT
  },
  v_normal_entry_item = {
    "NormalEntryItem",
    BIND_TYPE.OBJECT
  },
  v_rune_icon_layout = {
    "RuneIconLayout",
    BIND_TYPE.OBJECT
  },
  v_rune_icon = {
    "RuneIcon",
    BIND_TYPE.IMAGE
  },
  v_rune_lv_after = {
    "RuneLvAfter",
    BIND_TYPE.TEXT
  },
  v_rune_lv_now = {
    "RuneLvNow",
    BIND_TYPE.TEXT
  },
  v_rune_roll = {
    "RuneRoll",
    BIND_TYPE.OBJECT
  },
  v_rune_skill_desc = {
    "RuneSkillDesc",
    BIND_TYPE.TEXT
  },
  v_rune_skill_name = {
    "RuneSkillName",
    BIND_TYPE.TEXT
  },
  v_rune_streng = {
    "RuneStreng",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_skill_tog_list = {}
  for i = LV_START, LV_END do
    local skill_tog = self.v_uicompents["SkillLevel" .. i .. "_tog"]
    self.v_skill_tog_list[i] = skill_tog
    self:set_toggle_listener(skill_tog, function(is_on)
      self:on_click_skill_lv(is_on, i)
    end)
  end
  self:register_exist_auto_template(FORGE_ROOM_RUNE_SKILL_ENTRY_KEY, self.v_entry_item, self.v_entry_content)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  self.v_rune_skill_list = nil
  self:unregister_template(FORGE_ROOM_RUNE_SKILL_ENTRY_KEY)
end

function ui:ui_on_destroy()
end

function ui:set_data(hero, type, forge_id, current_skill_tog_index)
  self.v_hero = hero
  self.v_type = type
  self.v_forge_id = forge_id
  self.v_current_skill_tog_index = current_skill_tog_index
  self.v_buddy_cfg = self.v_hero.buddy_cfg
  self.v_hero_uuid = self.v_hero.uuid
  self.v_buddy_id = self.v_buddy_cfg.Id
  local buddy_rune_info = Rune2Mgr:get_rune_buddy_info(self.v_buddy_id)
  self:show_obj_state(buddy_rune_info)
  if buddy_rune_info then
    self.v_pos = buddy_rune_info.pos
    self.v_rune_type = ShareRes.get_buddy_rune_type(self.v_buddy_id, self.v_pos)
    self.v_buddy_rune_lv = buddy_rune_info.level
    self.v_entry_list = buddy_rune_info.entry_list
    local now_rune_cfg = ShareRes.get_buddy_rune_list_cfg(self.v_buddy_id, self.v_rune_type, self.v_buddy_rune_lv)
    self.v_buddy_skill_lv = now_rune_cfg and now_rune_cfg.Level or 0
    local icon_name = self.v_buddy_cfg.RuneIcon[self.v_pos]
    local icon_path = RUNE_HELPER.get_rune_icon(icon_name)
    ResMgr:load_set_icon(self.v_rune_icon, icon_path)
    if self.v_type == CURSE_CARD_TYPE.FORGE_UPGRADE then
      local forge_cfg = ShareRes.create("activity.curse_forge", self.v_forge_id)
      self.v_rune_lv_now.text = Util.format_str("{1}级", buddy_rune_info.level)
      local after_lv = buddy_rune_info.level + forge_cfg.Args[1]
      self.v_rune_lv_after.text = Util.format_str("{1}级", after_lv)
      self:init_skill_data_list()
      self:refresh_skill_active()
      self:init_skill_tog_state()
    elseif self.v_type == CURSE_CARD_TYPE.FORGE_ENTRY then
      self:refresh_entry_list()
    end
  end
end

function ui:show_obj_state(buddy_rune_info)
  if buddy_rune_info then
    self.v_rune_icon_layout:SetActive(true)
    self.v_rune_roll:SetActive(self.v_type == CURSE_CARD_TYPE.FORGE_ENTRY)
    self.v_rune_streng:SetActive(self.v_type == CURSE_CARD_TYPE.FORGE_UPGRADE)
    self.v_no_next_rune:SetActive(false)
  else
    self.v_rune_icon_layout:SetActive(false)
    self.v_rune_roll:SetActive(false)
    self.v_rune_streng:SetActive(false)
    self.v_no_next_rune:SetActive(true)
  end
end

function ui:init_skill_data_list()
  self.v_rune_skill_list = {}
  for lv = LV_START, LV_END do
    local rune_cfg = ShareRes.get_buddy_rune_lv_cfg(self.v_buddy_id, self.v_rune_type, lv)
    self.v_rune_skill_list[lv] = rune_cfg
  end
end

function ui:refresh_skill_active()
  for lv = LV_START, LV_END do
    local skill_obj = self.v_uiobjects["SkillLevel" .. lv]
    local active_obj = Util.get_child_gameobj("Active", skill_obj)
    local is_active = self.v_buddy_skill_lv == lv
    active_obj:SetActive(is_active)
  end
end

function ui:refresh_skill_info(lv)
  self.v_rune_skill_name.text = Util.format_str("暂无")
  self.v_rune_skill_desc.text = ""
  local rune_cfg = self.v_rune_skill_list[lv]
  if rune_cfg then
    local condition = rune_cfg.Condition
    local skill_name = rune_cfg.SkillName
    local show_skill_name = lv > self.v_buddy_skill_lv and Util.format_str("{1}(解锁等级 : {2})", skill_name, condition) or skill_name
    self.v_rune_skill_name.text = show_skill_name
    self.v_rune_skill_desc.text = rune_cfg.SkillDesc
  end
end

function ui:refresh_entry_list()
  self:give_back_auto_cache(FORGE_ROOM_RUNE_SKILL_ENTRY_KEY)
  self.v_normal_entry_item:SetActive(false)
  if not self.v_entry_list or not next(self.v_entry_list) then
    self.v_normal_entry_item:SetActive(true)
    self.v_no_entry_name.text = Util.format_str("无词条")
    return
  end
  for _, entry_id in pairs(self.v_entry_list) do
    local entry_item = self:get_auto_cache(FORGE_ROOM_RUNE_SKILL_ENTRY_KEY)
    local entry_cfg = ShareRes.get_entry_cfg(entry_id)
    local entry_desc_text = Util.get_text("EntryDesc", entry_item)
    entry_desc_text.text = entry_cfg.Desc
  end
end

function ui:init_skill_tog_state()
  local tog_indx = self.v_current_skill_tog_index and self.v_current_skill_tog_index or LV_START
  if self.v_skill_tog_list[tog_indx].isOn then
    self:refresh_skill_info(tog_indx)
    return
  end
  self.v_skill_tog_list[tog_indx].isOn = true
end

function ui:on_click_skill_lv(is_on, idx)
  if is_on then
    self:refresh_skill_info(idx)
    self.v_parent_ui:set_current_skill_tog_index(idx)
  end
end

return ui
