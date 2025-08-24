local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local UNSETTEMKEY = "UNSETTEMKEY"
local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")

function ui:ui_finish_load()
  self:set_button("CloseBg", function()
    self:ui_hide()
  end)
  self:set_button("Button_no", function()
    self:ui_hide()
  end)
  self:set_button("Button_yes", function()
    UIMgr:try_hide_ui("battle_setting")
    self:ui_hide()
  end)
  self.v_uiobjects.Button_yes:SetActiveEx(true)
  self.v_uiobjects.ScrollView:SetActiveEx(true)
  self.v_uiobjects.NewBtn:SetActiveEx(false)
  local cancel_txt = Util.get_text("Text", self.v_uiobjects.Button_no)
  cancel_txt.text = "继续"
  local confirm_txt = Util.get_text("Text", self.v_uiobjects.Button_yes)
  confirm_txt.text = "离开"
  self.v_uicompents.Tips_txt.text = "当前存在未设置按键的操作，是否离开设置界面"
  self:register_exist_auto_template(UNSETTEMKEY, self.v_uiobjects.UnSetTem, self.v_uiobjects.Content)
end

function ui:ui_on_show(btn_list)
  self:refresh(btn_list)
end

function ui:ui_on_hide()
end

function ui:refresh(btn_list)
  self:give_back_auto_cache(UNSETTEMKEY)
  for _, btn_name in ipairs(btn_list) do
    local obj = self:get_auto_cache(UNSETTEMKEY)
    local txt = Util.get_text(nil, obj)
    txt.text = string.format("[%s]", Setting_Cfg.BTNNAME_INFO[btn_name].desc)
  end
end

return ui
