local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CHAR_HELPER = require("uimodule.character.char_helper")
local MODEL = {
  v_advance_lv = {
    "AdvanceLv",
    BIND_TYPE.TEXT
  },
  v_cost_bg = {
    "CostBg",
    BIND_TYPE.IMAGE
  },
  v_cost_btn = {
    "CostBtn",
    BIND_TYPE.BUTTON
  },
  v_cost_content = {
    "CostContent",
    BIND_TYPE.OBJECT
  },
  v_cost_item = {
    "CostItem",
    BIND_TYPE.BUTTON
  },
  v_cost_null = {
    "CostNull",
    BIND_TYPE.OBJECT
  },
  v_cost_red_point = {
    "CostRedPoint",
    BIND_TYPE.IMAGE
  },
  v_cost = {
    "Cost",
    BIND_TYPE.OBJECT
  },
  v_down_btn = {
    "DownBtn",
    BIND_TYPE.OBJECT
  },
  v_equip_name = {
    "Equip_name",
    BIND_TYPE.TEXT
  },
  v_equip_quality = {
    "Equip_quality",
    BIND_TYPE.IMAGE
  },
  v_img_add = {
    "ImgAdd",
    BIND_TYPE.IMAGE
  },
  v_level_limit_text = {
    "LevelLimitText",
    BIND_TYPE.OBJECT
  },
  v_lock = {
    "Lock",
    BIND_TYPE.BUTTON
  },
  v_main_content = {
    "MainContent",
    BIND_TYPE.OBJECT
  },
  v_max_text = {
    "MaxText",
    BIND_TYPE.OBJECT
  },
  v_next_skill_detail = {
    "NextSkillDetail",
    BIND_TYPE.TEXT
  },
  v_now_skill = {
    "NowSkill",
    BIND_TYPE.TEXT
  },
  v_skill_detail = {
    "SkillDetail",
    BIND_TYPE.TEXT
  },
  v_skill_name = {
    "SkillName",
    BIND_TYPE.TEXT
  },
  v_star_break1 = {
    "StarBreak1",
    BIND_TYPE.IMAGE
  },
  v_star_break2 = {
    "StarBreak2",
    BIND_TYPE.IMAGE
  },
  v_star_break3 = {
    "StarBreak3",
    BIND_TYPE.IMAGE
  },
  v_star_break4 = {
    "StarBreak4",
    BIND_TYPE.IMAGE
  },
  v_title_tip = {
    "TitleTip",
    BIND_TYPE.TEXT
  },
  v_weapon_lv = {
    "WeaponLV",
    BIND_TYPE.TEXT
  }
}
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local OPEN_TYPE = CHARACTER_CONFIG.WEAPON_SELECT_TYPE

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("CostBtn", function()
    self:click_select_cost()
  end)
  self:set_button("BtnTongtiao", function()
    self:_click_advance_btn()
  end)
  self:set_button("Lock", function()
    if not self.v_equip_info then
      return
    end
    CharacterMgr:equip_lock(self.v_equip_info.uuid, function()
      self:refresh_lock_view()
    end)
  end)
  self.v_down_btn_canvasgroup = self.v_down_btn:GetComponent("CanvasGroup")
end

function ui:check_cost()
  if not self.v_skill_id then
    return false
  end
  local equip_list = CharacterMgr:get_equip_list()
  for _, equip_info in pairs(equip_list) do
    local id = equip_info.id
    if self.v_cost_id[id] and (not equip_info.owner or 0 == equip_info.owner) and equip_info.uuid ~= self.v_equip_uuid and 0 == equip_info.lock then
      return true
    end
  end
  return false
end

function ui:click_select_cost()
  if not self.v_skill_id then
    return
  end
  local is_cost = false
  local equip_list = CharacterMgr:get_equip_list()
  for _, equip_info in pairs(equip_list) do
    local id = equip_info.id
    if self.v_cost_id[id] and (not equip_info.owner or 0 == equip_info.owner) and equip_info.uuid ~= self.v_equip_uuid and 0 == equip_info.lock then
      is_cost = true
      break
    end
  end
  if not is_cost then
    Util.show_message_tip(2163)
    return
  end
  self.v_uiobjects.Cost:SetActive(false)
  
  local function selected_callback(equip_id)
    self.v_select_equip_uuid = equip_id
    self.v_parent_ui:selected_tongtiao()
  end
  
  UIMgr:get_ui("char_weapon_select"):ui_show(selected_callback, nil, OPEN_TYPE.COST, self.v_cost_id, self.v_equip_uuid)
end

function ui:_click_advance_btn()
  if not self.v_select_equip_uuid then
    Util.show_message_tip(2115)
    return
  end
  CharacterMgr:advance_equip(self.v_equip_uuid, self.v_select_equip_uuid, function()
    self.v_select_equip_uuid = nil
    self:update_equip_info()
    Util.show_message_tip(2164)
  end)
end

function ui:refresh(equip_uuid)
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  self.v_equip_info = equip_info
  self.v_equip_uuid = equip_uuid
  self.v_cost_id = {}
  self:update_equip_info()
  self:refresh_lock_view()
end

function ui:ui_on_show()
end

function ui:refresh_lock_view()
  local equip_uuid = self.v_equip_info.uuid
  local lock = self:get_uiobject("Lock")
  lock:SetActive(true)
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  local img_lock = Util.get_image("img_lock", lock)
  local img_no_lock = Util.get_image("img_no_lock", lock)
  local lock = 1 == equip_info.lock
  img_lock.gameObject:SetActive(lock)
  img_no_lock.gameObject:SetActive(not lock)
end

function ui:ui_on_hide()
  self.v_cost_id = {}
  self.v_select_equip_uuid = nil
end

function ui:update_equip_info()
  self.v_cost:SetActive(false)
  CharacterMgr:update_equip_homology_red(self.v_equip_uuid)
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local id = equip_info.id
  local break_lv = equip_info.break_lv
  local advance_lv = equip_info.advance
  local equip_cfg = ShareRes.get_equip(id)
  local name = equip_cfg.Name
  self.v_equip_name.text = name
  local quality_cfg = ShareRes.get_equip_icon_cfg(equip_cfg.Quality)
  local path = string.format("UICommon/%s", quality_cfg.QualityIcon)
  ResMgr:load_set_icon(self.v_equip_quality, path)
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  assert(advance_cfg, "no such equip_advance, id " .. equip_info.id)
  local max_advance_lv = #advance_cfg
  local is_max = advance_lv >= max_advance_lv
  self.v_max_text:SetActive(is_max)
  self.v_level_limit_text:SetActive(is_max)
  self.v_title_tip.text = Util.format_str("同调{1}级", advance_lv)
  self.v_next_skill_detail.gameObject:SetActive(not is_max)
  self.v_cost:SetActive(not is_max)
  local skill_id = advance_cfg[advance_lv].SkillId
  self.v_skill_id = skill_id
  self:update_skill_desc(skill_id)
  if advance_lv >= max_advance_lv then
    return
  end
  local cfg = advance_cfg[advance_lv]
  self.v_cost_id[cfg.CostEquipId] = true
  self.v_cost_id[cfg.CostCommonId] = true
  self:update_cost_info()
  local next_cfg = advance_cfg[advance_lv + 1]
  local next_skill_id = next_cfg.SkillId
  self:update_next_skill_desc(next_skill_id)
end

function ui:update_skill_desc(skill_id)
  local skill_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  assert(skill_cfg, "NO SKILL CFG = " .. skill_id)
  self.v_skill_name.text = skill_cfg.Name
  self.v_skill_detail.text = Util.format_str("当前效果：{1}", skill_cfg.Desc)
end

function ui:update_next_skill_desc(skill_id)
  local skill_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  assert(skill_cfg, "NO SKILL CFG = " .. skill_id)
  self.v_next_skill_detail.text = Util.format_str("<color=#FFD07B>下一阶段效果：</color>{1}", skill_cfg.Desc)
end

function ui:update_cost_info()
  local selected = self.v_select_equip_uuid ~= nil
  self.v_down_btn:SetActive(true)
  self.v_cost_null:SetActive(not selected)
  Util.apply_grey_ex(self.v_uiobjects.BtnTongtiao, not selected)
  self.v_uicompents.CostItem_rect:SetActive(false)
  self.v_down_btn_canvasgroup.alpha = selected and 1 or 0.4
  self.v_uiobjects.CostRedPoint:SetActive(not selected and self:check_cost())
  if not selected then
    return
  end
  local equip_info = CharacterMgr:get_equip_info(self.v_select_equip_uuid)
  local cost_item_ui = self.v_uicompents.CostItem_rect
  cost_item_ui:SetActive(true)
  Util.load_equip_item(equip_info, cost_item_ui)
  self.v_weapon_lv.text = equip_info.lv
  self.v_advance_lv.text = Util.format_str("同调{1}", equip_info.advance)
end

return ui
