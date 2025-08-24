local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert

function ui:ui_finish_load()
  self:set_button("Tips", function()
    self:ui_hide()
  end)
  self:set_button("BtnJump", function()
    UIMgr:go_to_main()
    local uimain = UIMgr:get_ui("uimain")
    uimain:on_mascot_click(2)
  end)
  self.v_timer = {}
end

function ui:ui_on_show(last_level, next_level, last_rec_limit, next_rec_limit, rec_award)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  uobj.TitleImg:SetActive(false)
  uobj.LvText:SetActive(false)
  uobj.InsideCircle:SetActive(false)
  uobj.LevelLayout:SetActive(false)
  uobj.BottomLayout:SetActive(false)
  uobj.Effect:SetActive(false)
  uobj.CannotTouch:SetActive(true)
  ucom.Lv_txt.text = last_level
  ucom.LastLevel_txt.text = Util.format_str("等级{1}", last_level)
  ucom.NextLevel_txt.text = Util.format_str("等级{1}", next_level)
  ucom.LastRecLimit_txt.text = last_rec_limit
  ucom.NextRecLimit_txt.text = next_rec_limit
  ucom.RecAward_txt.text = Util.format_str("+{1}", rec_award)
  uobj.TitleImg:SetActive(true)
  uobj.LvText:SetActive(true)
  uobj.InsideCircle:SetActive(true)
  uobj.InsideCircle:SetActive(true)
  uobj.LevelLayout:SetActive(true)
  uobj.BottomLayout:SetActive(true)
  uobj.Effect:SetActive(true)
  ucom.Lv_txt.text = next_level
  local hide_cannot_touch_timer = Timer:add_timer("hide_cannot_touch_timer", 2, function()
    uobj.CannotTouch:SetActive(false)
  end)
  _tinsert(self.v_timer, hide_cannot_touch_timer)
  uobj.BtnJump:SetActive(UIMgr:try_get_visible_ui("uimain") ~= nil and SceneMgr:check_main_scene())
end

function ui:ui_update()
  self.v_exp_tip = UIMgr:try_get_ui("exp_up_tips")
  if self.v_exp_tip then
    self.v_exp_tip:ui_be_transparent(true)
  end
end

function ui:ui_on_hide()
  for _, timer_idx in pairs(self.v_timer) do
    Timer:remove_timer(timer_idx)
  end
  UtilTable.clear_map(self.v_timer)
  if self.v_exp_tip then
    self.v_exp_tip:ui_be_transparent(false)
  end
end

function ui:ui_on_destroy()
  self.v_timer = nil
end

return ui
