local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local FightDefine = require("cs_share.fight_define")
local ATTR_TYPE = FightDefine.ATTR_TYPE
local max_width = 222
local min_width = 19
local range = max_width - min_width
local bar_style_enum = {dot = 2, line = 1}

function ui:add_listener()
end

function ui:ui_finish_load()
  self.v_bg2_rect = Util.get_rect_transform(nil, self.v_uiobjects.BarFill2)
end

function ui:ui_on_show()
end

function ui:set_bar_style(bar_style)
  if bar_style == bar_style_enum.dot then
    self.v_uiobjects.Style1:SetActive(true)
    self.v_uiobjects.Style2:SetActive(false)
  elseif bar_style == bar_style_enum.line then
    self.v_uiobjects.Style1:SetActive(false)
    self.v_uiobjects.Style2:SetActive(true)
  end
end

function ui:set_line_bar()
  local value = math.max(Global.hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_FIGHT_LINE_BAR), 0)
  local max_value = math.max(Global.hero.attr_mgr:get_attr(ATTR_TYPE.CHAR_FIGHT_LINE_BAR_MAX), 1)
  self.v_bg2_rect:SetSizeDeltaWidthA(min_width + math.min(value / max_value, 1) * range)
end

function ui:set_point_count(max_count)
  max_count = math.min(max_count, 5)
  local root_tf = self.v_uiobjects.Style1.transform
  local childCount = root_tf.childCount
  for index = 1, childCount - 1 do
    local go = root_tf:GetChild(index).gameObject
    go:SetActive(false)
    local light = Util.get_child("Light", go)
    light:SetActive(true)
  end
  for index = 2, max_count do
    self.v_uiobjects["Block" .. index]:SetActive(true)
    self.v_uiobjects["Line" .. index]:SetActive(true)
  end
end

function ui:set_point_state(active_list)
  for key, active in pairs(active_list) do
    if key <= 5 then
      local dot_light = Util.get_child("Light", self.v_uiobjects["Block" .. key])
      dot_light:SetActive(active)
    end
  end
end

return ui
