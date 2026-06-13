local Base = require("ui.uibase")
local FightDefine = require("cs_share.fight_define")
local NAMEATTR = FightDefine.CONFIG_NAME_ATTR_ID
local BIND_TYPE = Config.BIND_TYPE
local _insert = table.insert
local SKILL_DETAIL_KEY = "SKILL_DETAIL_KEY"
local MODEL = {
  v_name = {
    "Name",
    BIND_TYPE.TEXT
  },
  v_icon = {
    "Icon",
    BIND_TYPE.IMAGE
  },
  v_content = {
    "SkillContent",
    BIND_TYPE.OBJECT
  },
  v_temp = {
    "Temp",
    BIND_TYPE.OBJECT
  }
}
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self:set_button("BtnNext", function()
    self:click_btn(true)
  end)
  self:set_button("BtnLast", function()
    self:click_btn(false)
  end)
  self:set_button("AdvanceBtn", function()
    if not self:check_advance() then
      return
    end
    
    local function callback()
      Util.show_message_tip(2141)
      UIMgr:get_ui("char_advance_suc_pnl"):ui_show(self.v_buddy_info.id)
      self:update_buddy_info()
    end
    
    CharacterMgr:char_advance(self.v_buddy_info.id, callback)
  end)
  self:set_button("CostItem", function()
    if not self.v_cost_id then
      return
    end
    Util.show_item_tip(self.v_cost_id)
  end)
  self:register_exist_auto_template(SKILL_DETAIL_KEY, self.v_temp, self.v_content)
end

function ui:update_buddy_info()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  self.v_buddy_info = buddy_info
  self.v_cur_advance_lv = buddy_info.advance
  local advance_skill_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_info.id)
  local max_lv = #advance_skill_cfg
  if max_lv <= self.v_cur_advance_lv then
    self:update_fun()
  else
    self:click_btn(true)
  end
end

function ui:check_advance()
  local advance_cfg = self.v_advance_skill_cfg
  local cost_id = advance_cfg.CostId
  local cost_num = advance_cfg.CostCnt
  local cur_item_num = BagMgr:get_item_num(cost_id)
  if cost_num > cur_item_num then
    Util.show_message_tip(2115)
    return false
  end
  return true
end

function ui:ui_on_hide()
  if self.v_callback then
    self.v_callback()
    self.v_callback = nil
  end
  self.v_is_other_player = nil
end

function ui:ui_on_show(buddy_id, advance_skill_cfg, is_open, callback, player_buddy_info, other_player)
  self.v_callback = callback
  self.v_buddy_id = buddy_id
  self.v_advance_skill_cfg = advance_skill_cfg
  if player_buddy_info then
    self.v_buddy_info = player_buddy_info
    self.v_uiobjects.Down:SetActive(false)
    self.v_is_other_player = true
  else
    local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
    self.v_buddy_info = buddy_info
  end
  self.v_cfg_advance_lv = advance_skill_cfg.Lv
  self.v_cur_advance_lv = self.v_buddy_info.advance
  self:update_buddy_view()
  self:update_fun()
  self.v_uiobjects.BtnMain:SetActive(not other_player)
end

function ui:click_btn(is_add)
  self.v_cfg_advance_lv = is_add and self.v_cfg_advance_lv + 1 or self.v_cfg_advance_lv - 1
  local advance_skill_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_info.id)
  local new_cfg = advance_skill_cfg[self.v_cfg_advance_lv]
  self.v_advance_skill_cfg = new_cfg
  self:update_fun()
end

function ui:update_fun()
  self:update_skill_title()
  self:update_skill_detail()
  self:update_btn_view()
  if not self.v_is_other_player then
    self:update_cost_info()
  end
end

function ui:update_btn_view()
  local advance_skill_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_info.id)
  local max_lv = #advance_skill_cfg
  self.v_uicompents.BtnLast_btn.gameObject:SetActive(self.v_cfg_advance_lv - 1 > 1)
  self.v_uicompents.BtnNext_btn.gameObject:SetActive(max_lv > self.v_cfg_advance_lv)
end

function ui:update_skill_title()
  self.v_name.text = self.v_advance_skill_cfg.SkillName
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", self.v_cfg_advance_lv)
  local icon_path = self.v_cur_advance_lv >= self.v_cfg_advance_lv and advance_icon_cfg.AdvacneAfter or advance_icon_cfg.AdvacneBefore
  ResMgr:load_set_icon(self.v_icon, icon_path, nil, true)
end

function ui:update_skill_detail()
  local advance_skill_cfg = self.v_advance_skill_cfg
  local buddy_info = self.v_buddy_info
  local buddy_id = buddy_info.id
  local skill_desc_list = {}
  local base_desc = advance_skill_cfg.SkillDesc
  local advance_lv = advance_skill_cfg.Lv
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
  for index, attr_data in ipairs(attr_list) do
    local attr_name = ShareRes.equip_attr_str(attr_data.id)
    local tip = attr_name .. "+" .. attr_data.val
    _insert(skill_desc_list, tip)
  end
  self:update_skill_list(skill_desc_list)
end

function ui:update_skill_list(skill_desc_list)
  self:give_back_auto_cache(SKILL_DETAIL_KEY)
  for _, desc in ipairs(skill_desc_list) do
    local ui = self:get_auto_cache(SKILL_DETAIL_KEY)
    local desc_txt = Util.get_text("Desc", ui.transform)
    desc_txt.text = desc
  end
end

function ui:update_buddy_view()
  local title = self.v_uicompents.Title_rect
  title.gameObject:SetActive(false)
  if not self.v_buddy_id then
    return
  end
  title.gameObject:SetActive(true)
  local buddy_data = self.v_buddy_info
  local buddy_config = ShareRes.create("buddy.buddy", buddy_data.id)
  local path = CharacterMgr:get_buddy_element_icon_path(buddy_data.id)
  ResMgr:load_set_icon(self.v_uicompents.Attribute_img, path)
  self.v_uicompents.BuddyName_txt.text = buddy_config.Name
end

function ui:update_cost_info()
  if self.v_cur_advance_lv + 1 ~= self.v_cfg_advance_lv then
    self.v_uicompents.Down_rect.gameObject:SetActive(false)
    return
  end
  self.v_uicompents.Down_rect.gameObject:SetActive(true)
  local advance_skill_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_info.id)
  local advance_cfg = advance_skill_cfg[self.v_cur_advance_lv]
  local cost_id = advance_cfg.CostId
  local cost_num = advance_cfg.CostCnt
  local cur_item_num = BagMgr:get_item_num(cost_id)
  self.v_cost_id = cost_id
  Util.load_ui_item(self.v_uicompents.CostItem_rect.gameObject, cost_id, cur_item_num, cost_num)
  self.v_uicompents.ImgSure_img.gameObject:SetActive(cost_num <= cur_item_num)
  self.v_uicompents.ImgNo_img.gameObject:SetActive(cost_num > cur_item_num)
  if cost_num <= cur_item_num then
    Util.apply_grey_ex(self.v_uiobjects.AdvanceBtn, false)
  else
    Util.apply_grey_ex(self.v_uiobjects.AdvanceBtn, true)
  end
end

return ui
