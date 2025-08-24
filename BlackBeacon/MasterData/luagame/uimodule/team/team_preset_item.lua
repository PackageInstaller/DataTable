local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnChangeName", function()
    self.v_parent_ui:_edit_formation_name(self.v_team_data)
  end)
  self:set_button("Char1", function()
    self:on_click_char(1)
  end)
  self:set_button("Char2", function()
    self:on_click_char(2)
  end)
  self:set_button("Char3", function()
    self:on_click_char(3)
  end)
  self:set_button("BtnRecordTeam", function()
    self:record_team_to_preset_team()
  end)
  self:set_button("BtnUseTeam", function()
    self:apply_preset_team()
  end)
  self.v_name_input = Util.get_inputfield(nil, self.v_uiobjects.InputField)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(data)
  self.v_fight_team_id = self.v_parent_ui.v_fight_team_id
  self.v_team_data = data
  self:update_name()
  self:update_chars()
end

function ui:on_click_char(pos)
  local team_data = {
    select_pos = pos,
    formation_type = self.v_formation_type,
    select_prefab_team_id = self.v_team_data.id,
    pos_data = self.v_team_data.buddys
  }
  UIMgr:get_ui("character_enter"):ui_show(team_data)
  FormationMgr:cache_team_preset_show(self.v_fight_team_id)
  self.v_parent_ui:ui_hide()
  local team = UIMgr:try_get_ui("team")
  if team then
    team:set_model_disable()
  end
end

function ui:update_name(new_name)
  if new_name then
    self.v_team_data.name = new_name
  end
  local name = self.v_team_data.name
  if not name or "" == name then
    name = Util.format_str("编队{1}", self.v_team_data.id)
  end
  self.v_uicompents.Name_txt.text = name
end

function ui:update_chars()
  local buddys = self.v_team_data.buddys
  for i = 1, 3 do
    local data = buddys[i]
    if data and 0 ~= data.buddy_id then
      local id = data.buddy_id
      self.v_uiobjects["CharIconObj" .. i]:SetActive(true)
      local path = CharacterMgr:get_buddy_icon_path(id, true)
      ResMgr:load_set_icon(self.v_uicompents["CharIcon" .. i .. "_img"], path)
    else
      self.v_uiobjects["CharIconObj" .. i]:SetActive(false)
    end
  end
end

function ui:record_team_to_preset_team()
  local fight_team = FormationMgr:get_fight_team_data(self.v_fight_team_id)
  if not self.check_buddys_legal(fight_team.buddys) then
    return
  end
  local team_data = FormationMgr:apply_fight_to_prefab_team(self.v_fight_team_id, self.v_team_data.id)
  self.v_team_data.buddys = team_data.buddys
  self.v_team_data.main_pos = team_data.main_pos
  self:update_chars()
end

function ui.check_buddys_legal(buddys)
  for _, team_buddy in pairs(buddys) do
    if 0 ~= team_buddy.buddy_id and 1 ~= team_buddy.buddy_type then
      Util.show_banner_tip("当前队伍存在试用角色")
      return false
    end
  end
  return true
end

function ui:apply_preset_team()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_TEAM_CHANGE)
  msg.mm_x = self.v_team_data.id
  self.v_parent_ui:ui_hide()
end

return ui
