local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ITEM_KEY = "UIFIGHTDEBUGFILTER"

function ui:ui_finish_load()
  local item_obj = self:get_uiobject("Item")
  local content_obj = self:get_uiobject("Content")
  self:register_exist_auto_template(ITEM_KEY, item_obj, content_obj)
end

function ui:ui_on_show(callback)
  local all_npcs = SceneMgr:get_all_char()
  for _, npc in pairs(all_npcs) do
    local item = self:get_auto_cache(ITEM_KEY)
    Util.get_text("Text", item).text = npc.character_cfg.name
    local btn = self:get_button(nil, item)
    self:set_button_listener(btn, function()
      callback(npc)
      self:ui_hide()
    end)
  end
  local select_all_item = self:get_auto_cache(ITEM_KEY)
  Util.get_text("Text", select_all_item).text = "选择全部"
  local btn = self:get_button(nil, select_all_item)
  self:set_button_listener(btn, function()
    callback()
    self:ui_hide()
  end)
end

return ui
