local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Char_Helper = require("uimodule.character.char_helper")
local MODEL = {
  v_desc_tem_1 = {
    "DescTem",
    BIND_TYPE.OBJECT
  },
  v_desc_tem_2 = {
    "DescTem_ (1)",
    BIND_TYPE.OBJECT
  },
  v_desc_tem_3 = {
    "DescTem_ (2)",
    BIND_TYPE.OBJECT
  },
  v_rune_icon1 = {
    "RuneIcon1",
    BIND_TYPE.IMAGE
  },
  v_rune_icon2 = {
    "RuneIcon2",
    BIND_TYPE.IMAGE
  },
  v_rune_route1 = {
    "RuneRoute1",
    BIND_TYPE.TOGGLE
  },
  v_rune_route2 = {
    "RuneRoute2",
    BIND_TYPE.TOGGLE
  },
  v_rune_type = {
    "RuneType",
    BIND_TYPE.TEXT
  },
  v_skill_name = {
    "SkillName",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:ui_on_show(data)
  self.v_buddy_id = data.buddy_id
  self.v_select_index = data.select_index
  for i = 1, 2 do
    local icon_path = Char_Helper.get_rune_icon(self.v_buddy_id, i)
    local rune_toggle = self["v_rune_route" .. i]
    ResMgr:load_set_icon(self["v_rune_icon" .. i], icon_path)
    self:set_toggle_listener(rune_toggle, function(is_on)
      if is_on then
        self.v_select_index = i
        self:reflesh_select()
      end
    end)
    if self.v_select_index == i then
      rune_toggle.isOn = false
      rune_toggle.isOn = true
    end
  end
end

function ui:reflesh_select()
  local buddy_cfg = ShareRes.get_buddy_cfg(self.v_buddy_id)
  local index = self.v_select_index
  local rune_type = buddy_cfg.RuneType[index]
  local rune_infos = ShareRes.get_buddy_rune_lv_map(self.v_buddy_id, rune_type)
  self.v_rune_type.text = Util.get_i18n("符文")
  self.v_skill_name.text = buddy_cfg.RuneName[index]
  for i = 1, 3 do
    local info = rune_infos[i]
    local desc_name = "v_desc_tem_" .. i
    if info then
      self[desc_name]:SetActive(true)
      local rune_name = Util.get_text("RuneSkillName_", self[desc_name])
      local rune_desc = Util.get_text("RuneDesc", self[desc_name])
      rune_name.text = info.SkillName
      rune_desc.text = info.SkillDesc
    else
      self[desc_name]:SetActive(false)
    end
  end
end

return ui
