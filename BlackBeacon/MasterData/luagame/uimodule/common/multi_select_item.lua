local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local type_func_name = {
  [Config.SELECT_ITEM_TYPE.STORY_SNIPPET] = "set_story_snippet_data",
  [Config.SELECT_ITEM_TYPE.CURSE_SELECT_POINT] = "set_curse_select_point_data"
}

local function _set_text_and_btn(self, data)
  self.v_uicompents.Text_txt.text = data.text
  if data.cb then
    local btn = self:get_button()
    self:set_button_listener(btn, function()
      data.cb()
    end)
  end
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:set_data(data)
  self.v_data = data
  local type = data.type
  if type_func_name[type] and self[type_func_name[type]] then
    self[type_func_name[type]](self, data)
  end
end

function ui:ui_on_hide()
  self.v_data = nil
end

function ui:ui_on_destroy()
end

function ui:set_story_snippet_data(data)
  _set_text_and_btn(self, data)
end

function ui:set_curse_select_point_data(data)
  self.v_uiobjects.Lock:SetActive(not data.is_unlock)
  self.v_uiobjects.Icon:SetActive(data.is_unlock)
  Util.set_color(self.v_uicompents.Text_txt, data.is_unlock and "FFFFFF" or "909090")
  _set_text_and_btn(self, data)
end

function ui:set_select(is_select)
  local data = self.v_data
  data.is_select = is_select
  self.v_uiobjects.Icon:SetActive(data.is_select)
  if data.is_unlock then
    Util.set_color(self.v_uicompents.Text_txt, data.is_select and "FFFFFF" or "ae9577")
  end
end

return ui
