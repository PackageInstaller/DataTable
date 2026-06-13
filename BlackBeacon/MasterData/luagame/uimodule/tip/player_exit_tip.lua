local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  local ui_compents = self.v_uicompents
  self:set_button_listener(ui_compents.BtnContinue_btn, function()
    self:ui_hide()
  end)
  self:set_button_listener(ui_compents.BtnExitToLogin_btn, function()
    self:ui_hide()
    local login_ui = UIMgr:try_get_visible_ui("uilogin")
    if Global.gamemode:gmode_is_login() and login_ui and not SDKManager:is_use_sdk() then
      login_ui:show_logout_popup()
    else
      SDKManager:logout()
    end
  end)
  self:set_button_listener(ui_compents.BtnExitToDesktop_btn, function()
    CSHelper.QuitApplication()
  end)
end

return ui
