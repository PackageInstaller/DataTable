local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local SKILL_BOOK_ICON_PATH = "UISkillBook/%s"
local CHAR_HELPER = require("uimodule.character.char_helper")
local util_get_color = Util.get_unity_color_by_hex
local color_first = util_get_color(tonumber("BF9046", 16))
local color_second = util_get_color(tonumber("BF4646", 16))
local color_third = util_get_color(tonumber("396CA5", 16))
local select_color = util_get_color(tonumber("FFFFFF", 16))
local unselect_color = util_get_color(tonumber("736F5F", 16))
local TEAM_INDEX = {
  First = 1,
  Second = 2,
  Third = 3
}

function M:ui_finish_load()
  self.v_tog = Util.get_toggle(nil, self.v_object)
end

function M:set_data(src_data)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  self.v_skill_data = src_data
  self.v_idx = src_data.idx
  self.v_skill_data.go = self.v_object
  local skill_cfg = src_data.skill_cfg
  local show_item_obj = uobj.ShowItem
  local total_item_obj = uobj.SkillItem
  local max_col = 5
  local row = src_data.row
  local col = src_data.col
  local skill_item_rect = ucom.SkillItem_rect
  show_item_obj:SetActive(true)
  total_item_obj:SetActive(true)
  if not skill_cfg then
    show_item_obj:SetActive(false)
    return
  end
  local skill_icon = ucom.SkillIcon_img
  local skill_type_txt = ucom.Skill_type_txt
  local TeamBg_img = ucom.TeamBg_img
  local icon_name = skill_cfg.Icon
  local skill_id = skill_cfg.SkillId
  local skill_icon_path = CHAR_HELPER.get_battle_skill_icon(skill_id)
  local icon_path = string.format(skill_icon_path, icon_name)
  local pos_id = src_data.pos_id
  ResMgr:load_set_icon(skill_icon, icon_path)
  skill_type_txt.text = skill_cfg.SkillLevel
  local color = color_first
  if pos_id == TEAM_INDEX.First then
    color = color_first
  elseif pos_id == TEAM_INDEX.Second then
    color = color_second
  elseif pos_id == TEAM_INDEX.Third then
    color = color_third
  end
  TeamBg_img.color = color
  self:set_toggle_listener(self.v_tog, function(isOn)
    self:_on_click_tog(isOn)
  end)
  self:on_refresh()
end

function M:on_clear()
  self.v_skill_data = nil
  self:on_refresh()
  self:unbind_all_auto_mq()
end

function M:_on_click_tog(is_select)
  if not self.v_skill_data then
    return
  end
  if not is_select then
    self.v_uicompents.SelectIcon_img.color = unselect_color
    return
  end
  self.v_uicompents.SelectIcon_img.color = select_color
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CLICK_RING_SKILL_ITEM)
  msg.mm_x = self.v_skill_data
end

function M:on_refresh()
  self.v_uicompents.SelectIcon_img.color = unselect_color
  self.v_tog.isOn = false
end

return M
