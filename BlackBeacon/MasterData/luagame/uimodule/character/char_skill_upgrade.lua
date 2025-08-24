local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local CHAR_SKILL_UPGRADE_ITEM_KEY1 = "CHAR_SKILL_UPGRADE_ITEM_KEY1"
local CHAR_SKILL_UPGRADE_ITEM_KEY2 = "CHAR_SKILL_UPGRADE_ITEM_KEY2"
local CHAR_SKILL_UPGRADE_ITEM_KEY3 = "CHAR_SKILL_UPGRADE_ITEM_KEY3"
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_skill_info_content1 = {
    "SkillContent1",
    BIND_TYPE.OBJECT
  },
  v_skill_info_template1 = {
    "SkillTem1",
    BIND_TYPE.OBJECT
  },
  v_skill_info_content2 = {
    "SkillContent2",
    BIND_TYPE.OBJECT
  },
  v_skill_info_template2 = {
    "SkillTem2",
    BIND_TYPE.OBJECT
  },
  v_skill_info_content3 = {
    "SkillContent3",
    BIND_TYPE.OBJECT
  },
  v_skill_info_template3 = {
    "SkillTem3",
    BIND_TYPE.OBJECT
  }
}
local DETAIL_POSX = 294

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnDetailClose", function()
    self.v_uicompents.BtnDetailClose_btn.gameObject:SetActive(false)
    self.v_uicompents.SkillDetail_rect.gameObject:SetActive(false)
  end)
  self:set_button("BtnExplain", function()
    local explain_id = ShareRes.get_system_comm_value("CharSkillUpgradeExplainId")
    UIMgr:get_ui("ui_explain"):ui_show(explain_id)
  end)
  self:register_exist_auto_template(CHAR_SKILL_UPGRADE_ITEM_KEY1, self.v_skill_info_template1, self.v_skill_info_content1)
  self:register_exist_auto_template(CHAR_SKILL_UPGRADE_ITEM_KEY2, self.v_skill_info_template2, self.v_skill_info_content2)
  self:register_exist_auto_template(CHAR_SKILL_UPGRADE_ITEM_KEY3, self.v_skill_info_template3, self.v_skill_info_content3)
  self.v_tmp_text = self.v_uiobjects.SkillDesc:GetComponent(typeof(CS.TMPro.TMP_Text))
end

function ui:ui_update()
end

function ui:ui_on_show(buddy_idx)
  self.v_buddy_idx = buddy_idx
  local buddy_info = CharacterMgr:get_buddy_info(self.v_buddy_idx)
  self.v_buddy_id = buddy_info.id
  self.v_uicompents.BtnDetailClose_btn.gameObject:SetActive(false)
  self.v_uicompents.SkillDetail_rect.gameObject:SetActive(false)
  self:update_upgrade_skill()
end

function ui:ui_on_hide()
end

function ui:update_upgrade_skill()
  local skill_upgrade_list = ShareRes.get_buddy_skill_upgrade_list(self.v_buddy_id)
  assert(skill_upgrade_list, "ERROR SKILL UPGRADE = " .. self.v_buddy_id)
  for lv = 1, 3 do
    local skill_list = skill_upgrade_list[lv]
    self:update_skill_list(skill_list, lv)
  end
end

function ui:update_skill_list(skill_list, lv)
  local key = "CHAR_SKILL_UPGRADE_ITEM_KEY" .. lv
  self:give_back_auto_cache(key)
  for index, skill_cfg in ipairs(skill_list) do
    local ui_obj = self:get_auto_cache(key)
    local icon = Util.get_image("SkillIcon", ui_obj)
    Util.load_skill_upgrade_icon(skill_cfg.Icon, icon)
    self:set_button_listener(Util.get_button(nil, ui_obj), function()
      self:show_skill_detail(ui_obj, skill_cfg, index)
    end)
  end
end

function ui:show_skill_detail(select_obj, skill_cfg, index)
  self.v_uicompents.SkillName_txt.text = skill_cfg.Name
  self.v_tmp_text.text = skill_cfg.SkillDesc
  local rect_trans = Util.get_rect_transform("SkillInfo", self.v_uicompents.SkillDetail_rect.transform)
  local pos_x = index <= 3 and DETAIL_POSX or -DETAIL_POSX
  local pos_y = rect_trans.anchoredPosition.y
  rect_trans:SetAnchoredPositionA(pos_x, pos_y)
  self.v_uicompents.BtnDetailClose_btn.gameObject:SetActive(true)
  local detail_rect = self.v_uicompents.SkillDetail_rect
  detail_rect.gameObject:SetActive(true)
  local position = select_obj.transform.position
  detail_rect.transform:SetPositionA(position.x, position.y, position.z)
end

return ui
