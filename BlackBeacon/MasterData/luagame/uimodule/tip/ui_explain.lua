local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local MODEL = {
  v_desc_content = {
    "DescList",
    BIND_TYPE.OBJECT
  },
  v_desc_temp = {
    "Temp",
    BIND_TYPE.OBJECT
  }
}
local DESC_ITEM_KEY = "DESC_ITEM_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnBack", function()
    self:ui_hide()
  end)
  self:set_button("BtnReturnExplain", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(DESC_ITEM_KEY, self.v_desc_temp, self.v_desc_content)
end

function ui:ui_on_show(explain_id)
  self.v_explain_id = explain_id
  self:update_explain_list()
end

function ui:ui_on_hide()
end

function ui:update_explain_list()
  local explain_cfg = ShareRes.get_explain_cfg(self.v_explain_id)
  assert(explain_cfg, "ERROR EXPLAINCFG = " .. self.v_explain_id)
  local list_num = #explain_cfg.Title
  local title_cfg = explain_cfg.Title
  local desc_cfg = explain_cfg.Desc
  for index = 1, list_num do
    local title_name = title_cfg[index]
    if "" ~= title_name then
      local ui_obj = self:get_auto_cache(DESC_ITEM_KEY)
      local name_txt = Util.get_text("Name", ui_obj)
      name_txt.text = title_name
      local desc_txt = Util.get_text("Desc", ui_obj)
      desc_txt.text = desc_cfg[index]
      UnityEngine.UI.LayoutRebuilder:ForceRebuildLayoutImmediate(Util.get_rect_transform(nil, ui_obj))
    end
  end
end

return ui
