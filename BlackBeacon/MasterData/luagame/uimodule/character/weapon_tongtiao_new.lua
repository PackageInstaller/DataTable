local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CommonDef = require("cs_share.common_define")
local CHAR_HELPER = require("uimodule.character.char_helper")
local MODEL = {
  v_btn_auto_add = {
    "BtnAutoAdd",
    BIND_TYPE.BUTTON
  },
  v_btn_clear = {
    "BtnClear",
    BIND_TYPE.BUTTON
  },
  v_btn_tongtiao = {
    "BtnTongtiao",
    BIND_TYPE.BUTTON
  },
  v_cost_tem1 = {
    "CostTem1",
    BIND_TYPE.OBJECT
  },
  v_cost_tem2 = {
    "CostTem2",
    BIND_TYPE.OBJECT
  },
  v_cost_tem3 = {
    "CostTem3",
    BIND_TYPE.OBJECT
  },
  v_cost_tem4 = {
    "CostTem4",
    BIND_TYPE.OBJECT
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
  v_level_limit_text = {
    "LevelLimitText",
    BIND_TYPE.TEXT
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
    BIND_TYPE.TEXT
  },
  v_next_skill_lv = {
    "NextSkillLV",
    BIND_TYPE.TEXT
  },
  v_red_weapon_replace = {
    "RedWeaponReplace",
    BIND_TYPE.IMAGE
  },
  v_skill_detail = {
    "SkillDetail",
    BIND_TYPE.TEXT
  },
  v_skill_lv = {
    "SkillLV",
    BIND_TYPE.TEXT
  },
  v_skill_name = {
    "SkillName",
    BIND_TYPE.TEXT
  },
  v_title_tip = {
    "TitleTip",
    BIND_TYPE.TEXT
  }
}

function ui:ui_on_show()
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_cost_list()
  self:set_button("BtnAutoAdd", function()
    self:click_btn_auto_add()
  end)
  self:set_button("BtnClear", function()
    self:click_btn_clear()
  end)
  self:set_button("BtnTongtiao", function()
    self:click_btn_tong_tiao()
  end)
end

function ui:click_btn_auto_add()
  self.weapon_select_ui:auto_add()
  if 0 == #self.select_equip_list then
    Util.show_message_tip(2147)
  end
end

function ui:click_btn_clear()
  self.weapon_select_ui:un_select_all()
end

function ui:click_btn_tong_tiao()
  if not self.select_equip_list or 0 == #self.select_equip_list then
    Util.show_message_tip(2152)
    return
  end
  local is_lock = false
  for i, v in pairs(self.select_equip_list) do
    if CHAR_HELPER.is_equip_lock(v) then
      is_lock = true
      break
    end
  end
  
  local function finish_close_cb()
    if self.is_can_max then
      local select_ui = UIMgr:try_get_ui("char_weapon_select")
      if select_ui then
        select_ui:ui_hide()
      end
    else
      self.weapon_select_ui:set_model_visible(true)
    end
  end
  
  local function cb()
    self.weapon_select_ui:set_model_visible(false)
    CharacterMgr:advance_equip_new(self.v_equip_uuid, self.select_equip_list, function()
      UIMgr:get_ui("weapon_tongtiao_finish"):ui_show(self.advance_lv, self.v_equip_uuid, finish_close_cb)
      self.weapon_select_ui:un_select_all(true)
    end)
  end
  
  if not is_lock then
    cb()
  else
    self.weapon_select_ui:set_model_visible(false)
    Util.show_notify_popup_message(cb, "武器已锁定，是否取消锁定并选为消耗材料？", nil, nil, nil, function()
      self.weapon_select_ui:set_model_visible(true)
    end)
  end
end

function ui:set_cost_list()
  local cost_parent = Util.get_child_gameobj("CostContent", self.v_cost)
  self.can_select_max_count = cost_parent.transform.childCount
  self.cost_list = {}
  for i = 1, self.can_select_max_count do
    local obj = cost_parent.transform:GetChild(i - 1).gameObject
    local temp_table = {}
    temp_table.cost_null = Util.get_child_gameobj("CostNull_", obj)
    temp_table.cost_item = Util.get_button("CostItem_", obj)
    temp_table.cost_del = Util.get_button("BtnDel_", obj)
    temp_table.weapon_lv = Util.get_text("CostItem_/Lower/WeaponLV_", obj)
    temp_table.advance_lv = Util.get_text("CostItem_/AdvanceLv/AdvanceLv_", obj)
    temp_table.star_list = {}
    local star_layout_trans = Util.get_child_gameobj("CostItem_/Lower/StarLayout", obj).transform
    local star_count = star_layout_trans.childCount
    for i = 1, star_count do
      local star_parent_path = string.format("TupoStar%s_", i)
      local star_parent = Util.get_child_gameobj(star_parent_path, star_layout_trans.gameObject)
      local star_path = string.format("StarBreak%s_", i)
      local star = Util.get_child_gameobj(star_path, star_parent)
      temp_table.star_list[i] = {}
      temp_table.star_list[i].star_parent = star_parent
      temp_table.star_list[i].star = star
    end
    temp_table.cost_null:SetActive(true)
    temp_table.cost_item.gameObject:SetActive(false)
    temp_table.cost_del.gameObject:SetActive(false)
    self.cost_list[i] = temp_table
    self:set_button_listener(temp_table.cost_del, function()
      self.weapon_select_ui:un_select_with_index(i)
    end)
  end
end

function ui:refresh_equip_info(equip_info, select_equip_list, weapon_select_ui)
  self.v_equip_uuid = equip_info.uuid
  self.weapon_select_ui = weapon_select_ui
  self.select_equip_list = select_equip_list
  CharacterMgr:update_equip_homology_red(self.v_equip_uuid)
  local id = equip_info.id
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  assert(advance_cfg, "no such equip_advance, id " .. equip_info.id)
  self.advance_lv = equip_info.advance
  local max_advance_lv = #advance_cfg
  local break_lv = equip_info.break_lv
  local equip_cfg = ShareRes.get_equip(id)
  local name = equip_cfg.Name
  self.v_equip_name.text = name
  local quality_cfg = ShareRes.get_equip_icon_cfg(equip_cfg.Quality)
  local path = string.format("UICommon/%s", quality_cfg.QualityIcon)
  ResMgr:load_set_icon(self.v_equip_quality, path)
  local is_max = max_advance_lv <= self.advance_lv
  self.v_max_text.gameObject:SetActive(is_max)
  self.v_level_limit_text:SetActive(is_max)
  self.v_cost:SetActive(not is_max)
  self.v_skill_lv.text = CommonDef.ROME_NUM[self.advance_lv]
  self.to_advance_lv = self.advance_lv
  self:refresh_to_level()
  self.is_can_max = self.to_advance_lv == max_advance_lv
  local skill_id = advance_cfg[self.to_advance_lv].SkillId
  self:update_skill_desc(skill_id)
  weapon_select_ui:set_max_select_count(self.can_select_max_count)
  self:refresh_btn_status(true)
  self:update_cost_list(select_equip_list)
  self.v_btn_clear.gameObject:SetActive(#select_equip_list > 0)
  self.v_btn_auto_add.gameObject:SetActive(0 == #select_equip_list)
  Util.apply_grey_ex(self.v_uiobjects.BtnTongtiao, #select_equip_list <= 0)
end

function ui:update_cost_list(select_equip_list)
  for i = 1, self.can_select_max_count do
    local uuid = select_equip_list[i]
    if uuid and uuid > 0 then
      self.cost_list[i].cost_item:SetActive(true)
      self.cost_list[i].cost_del:SetActive(true)
      local equip_info = CharacterMgr:get_equip_info(uuid)
      Util.load_equip_item(equip_info, self.cost_list[i].cost_item.transform)
      self.cost_list[i].weapon_lv.text = equip_info.lv
      self.cost_list[i].advance_lv.text = Util.format_str("同调{1}", CommonDef.ROME_NUM[equip_info.advance])
      local star_count = #self.cost_list[i].star_list
      local max_star_num = ShareRes.get_max_equip_break_lv(equip_info.id)
      for index = 1, star_count do
        self.cost_list[i].star_list[index].star_parent:SetActive(index <= max_star_num)
        self.cost_list[i].star_list[index].star:SetActive(index <= equip_info.break_lv - 1)
      end
    else
      self.cost_list[i].cost_item:SetActive(false)
      self.cost_list[i].cost_del:SetActive(false)
      self.cost_list[i].cost_null:SetActive(true)
    end
  end
end

function ui:refresh_btn_status(is_show_add)
  self.v_btn_auto_add.gameObject:SetActive(is_show_add)
  self.v_btn_clear.gameObject:SetActive(not is_show_add)
end

function ui:refresh_to_level()
  local arrow = Util.get_child_gameobj("NextlSkillArrow", self.v_next_skill_lv.gameObject)
  local select_count = #self.select_equip_list
  if 0 == select_count then
    arrow:SetActive(false)
    self.v_next_skill_lv.text = ""
    return
  end
  arrow:SetActive(true)
  self.to_advance_lv = self.advance_lv + select_count
  self.v_next_skill_lv.text = CommonDef.ROME_NUM[self.to_advance_lv]
end

function ui:ui_on_hide()
  self.v_cost_id = {}
  self.v_select_equip_uuid = nil
end

function ui:update_skill_desc(skill_id)
  local skill_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  assert(skill_cfg, "NO SKILL CFG = " .. skill_id)
  self.v_skill_name.text = skill_cfg.Name
  self.v_skill_detail.text = Util.format_str("{1}", skill_cfg.Desc)
end

return ui
