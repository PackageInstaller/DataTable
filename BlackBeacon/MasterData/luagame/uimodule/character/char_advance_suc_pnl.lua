local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local _insert = table.insert
local FightDefine = require("cs_share.fight_define")
local NAMEATTR = FightDefine.CONFIG_NAME_ATTR_ID
local MODEL = {
  v_content = {
    "SkillContent",
    BIND_TYPE.OBJECT
  },
  v_temp = {
    "Temp",
    BIND_TYPE.OBJECT
  }
}
local SKILL_SUC_PNL_KEY = "SKILL_SUC_PNL_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnBack", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(SKILL_SUC_PNL_KEY, self.v_temp, self.v_content)
end

function ui:ui_on_show(buddy_id, equip_uuid)
  self.v_uicompents.SkillDetail_rect.gameObject:SetActive(false)
  self.v_buddy_id = buddy_id
  if not equip_uuid then
    self:update_skill_detail()
  else
    self.v_equip_uuid = equip_uuid
    self:update_equip_detail()
  end
  self:update_hero_icon()
end

function ui:ui_on_hide()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:update_equip_detail()
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local advance_lv = equip_info.advance
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  assert(advance_cfg, "no such equip_advance, id " .. equip_info.id)
  local skill_id = advance_cfg[advance_lv].SkillId
  local skill_cfg = ShareRes.create("equip.equip_skill_level", skill_id)
  local icon_path = skill_cfg.Icon_path
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, icon_path)
end

function ui:update_skill_detail()
  self.v_uicompents.SkillDetail_rect.gameObject:SetActive(true)
  local alpha_ui = self.v_uicompents.SkillDetail_rect:GetComponent("CanvasGroup")
  alpha_ui.alpha = 0
  local buddy_id = self.v_buddy_id
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local advance_all_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_id)
  local advance_lv = buddy_info.advance
  local advance_skill_cfg = advance_all_cfg[advance_lv]
  local show_lv = advance_skill_cfg.ShowLv
  local skill_name = advance_skill_cfg.SkillName
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", advance_lv)
  local before_advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", advance_lv - 1)
  local after_icon_path = advance_icon_cfg.AdvacneAfter
  local before_icon_path = before_advance_icon_cfg.AdvacneAfter
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, before_icon_path, nil, true)
  ResMgr:load_set_icon(self.v_uicompents.Icon_after_img, after_icon_path, nil, true)
  self.v_uicompents.PotentialNum_txt.text = show_lv - 1
  self.v_uicompents.AdvanceName_txt.text = Config.NUM_2_ROMAN[show_lv - 1] .. " : " .. skill_name
  self.v_all_before_show_lv_cfgs = {}
  for k, v in ipairs(advance_all_cfg) do
    if v.ShowLv == show_lv then
      _insert(self.v_all_before_show_lv_cfgs, v)
    end
  end
  local detail_list = {}
  for k, single_cfg in ipairs(self.v_all_before_show_lv_cfgs) do
    local skill_desc_list = {}
    local base_desc = single_cfg.SkillDesc
    local advance_lv = single_cfg.Lv
    local advance_born_item_cfg = ShareRes.get_buddy_advance_born_item_cfg(buddy_id)
    if advance_born_item_cfg then
      local all_data = advance_born_item_cfg[advance_lv]
      if all_data then
        local item_id_cfg = all_data.ItemId
        local item_num_cfg = all_data.ItemCnt
        local item_num = #item_id_cfg
        for index = 1, item_num do
          local item_id = item_id_cfg[index]
          local item_num = item_num_cfg[index]
          if 0 ~= item_id and 0 ~= item_num then
            local item_cfg = ShareRes.get_battle_item_cfg(item_id)
            if item_cfg then
              base_desc = base_desc .. item_cfg.Name .. "*" .. item_num .. "  "
            end
          end
        end
      end
    end
    if base_desc and "" ~= base_desc then
      _insert(skill_desc_list, base_desc)
    end
    local up_skill_lv = single_cfg.UpSkillLv
    if up_skill_lv and 0 ~= up_skill_lv then
      _insert(skill_desc_list, "技能等级+" .. up_skill_lv)
    end
    local advance_lv_attr_cfg = ShareRes.get_buddy_advance_attr_cfg(buddy_id, advance_lv)
    local attr_list = {}
    if advance_lv_attr_cfg then
      for attr_name, attr_val in pairs(advance_lv_attr_cfg) do
        local attr_id = NAMEATTR[attr_name]
        if attr_id and not ShareRes.get_is_masked_attr(attr_id) and 0 ~= attr_val then
          _insert(attr_list, {id = attr_id, val = attr_val})
        end
      end
    end
    table.sort(attr_list, function(a, b)
      if a.attr_id == b.attr_id then
        return a.val > b.val
      end
      return a.attr_id < b.attr_id
    end)
    local tips
    for index, attr_data in ipairs(attr_list) do
      local attr_name = ShareRes.equip_attr_str(attr_data.id)
      local tip = attr_name .. "+" .. attr_data.val
      if tips then
        tips = string.format("%s  %s", tips, tip)
      else
        tips = tip
      end
    end
    _insert(skill_desc_list, tips)
    tips = nil
    for k, v in ipairs(skill_desc_list) do
      if tips then
        tips = string.format([[
%s
%s]], tips, v)
      else
        tips = v
      end
    end
    _insert(detail_list, tips)
  end
  self:update_skill_list(detail_list)
  self:star_sequence()
end

function ui:update_skill_list(skill_desc_list)
  self:give_back_auto_cache(SKILL_SUC_PNL_KEY)
  for _, desc in ipairs(skill_desc_list) do
    local ui = self:get_auto_cache(SKILL_SUC_PNL_KEY)
    local desc_txt = Util.get_text("Desc", ui.transform)
    desc_txt.text = desc
  end
end

function ui:star_sequence()
  local alpha_ui = self.v_uicompents.SkillDetail_rect:GetComponent("CanvasGroup")
  self.v_sequence = Util.create_sequence()
  self.v_sequence:Append(alpha_ui:DOFade(1, 1))
end

function ui:update_hero_icon()
  if not self.v_buddy_id then
    return
  end
  local ucom = self.v_uicompents
  local hero_img = ucom.hero_img
  local hero_shadow_img = ucom.hero_shadow_img
  local hero_icon = UtilUI.get_hero_images(self.v_buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  if not hero_icon then
    return
  end
  ResMgr:load_set_icon(hero_img, hero_icon, nil, true, self)
  ResMgr:load_set_icon(hero_shadow_img, hero_icon, nil, true, self)
end

return ui
