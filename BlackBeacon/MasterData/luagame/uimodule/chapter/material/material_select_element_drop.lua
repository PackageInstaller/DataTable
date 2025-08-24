local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local select_element_item = require("uimodule.chapter.material.material_select_element_item")
local MODEL = {
  v_btn_confirm = {
    "BtnConfirm",
    BIND_TYPE.BUTTON
  },
  v_ele_tem = {
    "EleTem",
    BIND_TYPE.IMAGE
  },
  v_tog_content = {
    "TogContent",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:ui_on_show()
  self.select_id = ChapterMaterialMgr:get_select_element_id()
  self.item_list = {}
  local epi_type = ChapterMaterialMgr:get_chapter_material_level_type()
  self:set_button_listener(self.v_btn_confirm, function()
    local now_select_id = self:get_select_id()
    local drop_index = now_select_id - 1
    ChapterMaterialMgr:request_choose_new_material_drop(epi_type, drop_index, function(msg)
      MsgGame:mq_publish2(Const.MSG_UPDATE_MATERIAL_SELECT_ELEMENT)
      self:ui_hide()
    end)
  end)
  self.list_key = "material_select_element_item_Key" .. self:ui_get_name()
  self:register_exist_auto_template(self.list_key, self.v_ele_tem, self.v_tog_content)
  local element_list = ChapterMaterialMgr:get_element_list_with_day(6)
  for i = 1, #element_list do
    local ele_drop_item = self:get_auto_cache(self.list_key)
    local item = select_element_item:ui_wrap_ex(nil, ele_drop_item)
    if item.refresh then
      item:refresh(i, ele_drop_item, element_list[i])
    end
    table.insert(self.item_list, item)
  end
end

function ui:get_select_id()
  for i, v in pairs(self.item_list) do
    if v:is_select() == true then
      return v.id
    end
  end
  return 2
end

function ui:ui_on_hide()
  self:unregister_template(self.list_key)
end

function ui:ui_on_destroy()
end

return ui
