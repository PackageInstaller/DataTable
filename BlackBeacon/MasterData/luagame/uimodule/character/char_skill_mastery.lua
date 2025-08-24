local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Char_Helper = require("uimodule.character.char_helper")
local ToggleTab = require("ui.widget.widget_toggle_tab")

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnExplain", function()
    self:on_click_explain()
  end)
  self.v_skill_icon_list = {}
  self.v_skill_tog_list = {}
  for index = 1, 6 do
    self.v_skill_icon_list[index] = self.v_uicompents["MasteryIcon" .. index .. "_img"]
    self.v_skill_tog_list[index] = self.v_uicompents["SkillMastery" .. index .. "_tog"]
  end
end

function ui:ui_on_show(buddy_id)
  self.v_buddy_id = buddy_id
  self.v_skill_list = ShareRes.get_buddy_skill_upgrade_list(buddy_id)
  if not self.v_skill_list then
    Log.Error("无配置---buddyId--", buddy_id)
    return
  end
  table.sort(self.v_skill_list[1], function(a, b)
    return a.Skillsort < b.Skillsort
  end)
  self.v_cur_select_index = 1
  self:set_skill_tog()
  self:update_skill_icon()
end

function ui:update_skill_icon()
  for index, icon in ipairs(self.v_skill_icon_list) do
    local icon_path = Char_Helper.get_skill_icon_by_name(self.v_skill_list[1][index].Icon)
    ResMgr:load_set_icon(icon, icon_path)
  end
end

function ui:update_skill_info()
  local cfg = self.v_skill_list[1][self.v_cur_select_index]
  self.v_uicompents.MasteryName_txt.text = cfg.Name
  self.v_uicompents.MasteryDesc_txt.text = cfg.SkillDesc
  self.v_uicompents.MasteryLabel_txt.text = cfg.MasteryType
end

function ui:set_skill_tog()
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(self.v_skill_tog_list, function(cur_select)
    self:click_tog(cur_select)
  end, 1)
  self:click_tog(1)
end

function ui:click_tog(index)
  self.v_cur_select_index = index
  self:update_skill_info()
end

function ui:on_click_explain()
  local data_list = ShareRes.get_graphic_guide_list(100000001)
  table.sort(data_list, function(a, b)
    return a.sort < b.sort
  end)
  UIMgr:get_ui("teaching"):ui_show(data_list)
end

function ui:ui_on_hide()
end

return ui
