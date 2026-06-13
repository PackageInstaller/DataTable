local TeamPresetItemClass = require("uimodule.team.team_preset_item")
local team_name_max_len = ShareRes.get_system_comm_value("TeamNameMaxLen")
local MAX_TEAM_NUM = ShareRes.get_system_comm_value("MaxTeamNum")
local CommonDef = require("cs_share.common_define")
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local TEAM_PRESET_ITEM_KEY = "TEAM_PRESET_ITEM_KEY"

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnFullColse", function()
    self:ui_hide()
  end)
  self:set_button("ChangeNameCancel", function()
    self:_cancel_change_name()
  end)
  self:set_button("ChangeNameConfirm", function()
    self:_confirm_change_name()
  end)
  self:register_exist_auto_template(TEAM_PRESET_ITEM_KEY, self.v_uiobjects.PresetTem, self.v_uiobjects.Content)
end

function ui:ui_on_show(reset_scroll_pos, fight_team_id)
  self.v_team_item_list = {}
  self.v_fight_team_id = fight_team_id
  self:update_team_list()
  if reset_scroll_pos then
    self.v_uicompents.Content_rect:SetLocalPositionA(0, 0, 0)
  end
end

function ui:ui_on_hide()
  self:remove_wrap_ui_items()
end

function ui:ui_on_destroy()
end

function ui:update_team_list()
  self.v_team_item_list = {}
  self:give_back_auto_cache(TEAM_PRESET_ITEM_KEY)
  local team_list = FormationMgr:get_prefab_team_list()
  for i = 1, MAX_TEAM_NUM do
    local team_data = team_list[i]
    team_data = team_data or {
      id = i,
      name = nil,
      buddys = {},
      main_pos = 1
    }
    local team_obj = self:get_auto_cache(TEAM_PRESET_ITEM_KEY)
    local item = TeamPresetItemClass:ui_wrap(self, team_obj, true)
    item:set_data(team_data)
    self.v_team_item_list[i] = item
  end
end

function ui:remove_wrap_ui_items()
  if self.v_team_item_list then
    self:remove_wrap_ui_list(self.v_team_item_list)
  end
end

function ui:cache_ui()
  return false
end

local function get_team_name(team_data)
  local name = team_data.name
  if not name or "" == name then
    name = Util.format_str("编队{1}", team_data.id)
  end
  return name
end

function ui:_edit_formation_name(team_data)
  local input = Util.get_inputfield(nil, self.v_uiobjects.ChangeNameInput)
  input.text = get_team_name(team_data)
  self.v_edit_name_team_id = team_data.id
  self.v_uiobjects.ChangeName:SetActive(true)
end

function ui:_confirm_change_name()
  local input = Util.get_inputfield(nil, self.v_uiobjects.ChangeNameInput)
  local new_name = Util.get_strip_space_str(input.text)
  if not new_name or "" == new_name then
    Util.show_message_tip(2220)
    return
  else
    local len = Util.get_string_len(input.text)
    if len > team_name_max_len then
      Util.show_message_tip(2221)
      return
    end
    Word_Censor.check_has_sensitive(self:ui_get_name(), new_name, function(ok, lab)
      if ok then
        local team_id = self.v_edit_name_team_id
        
        local function cb(ok)
          if ok then
            self:update_team_name_show(team_id, new_name)
          else
            new_name = Util.format_str("编队{1}", team_id)
            self:update_team_name_show(team_id, new_name)
          end
        end
        
        FormationMgr:save_prefab_team(team_id, new_name, nil, nil, cb)
      end
    end, "save_formation_name")
  end
  self.v_uiobjects.ChangeName:SetActive(false)
end

function ui:_cancel_change_name()
  self.v_edit_name_team_id = nil
  self.v_uiobjects.ChangeName:SetActive(false)
end

function ui:update_team_name_show(team_id, new_name)
  for i, ui_item in ipairs(self.v_team_item_list) do
    if i == team_id then
      ui_item:update_name(new_name)
    end
  end
end

return ui
