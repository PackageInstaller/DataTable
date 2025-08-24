local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(cfg)
  self.v_id = cfg.Id
  self.v_cfg = cfg
  self:refresh_line()
end

function ui:refresh_line()
  local show = not self.v_parent_ui:check_is_first_group(self.v_cfg.PosGroup) or not self.v_parent_ui:check_need_show_line(self.v_cfg.Pos)
  self.v_uiobjects.Line:SetActive(show)
  local bless_id = self.v_cfg.Id
  local is_unlock = ChallengeRingPlusMgr:check_bless_is_unlock(bless_id)
  local is_active = false
  if not is_unlock then
    is_active = ChallengeRingPlusMgr:check_skill_item_is_active(bless_id)
  end
  self.v_uiobjects.Lock:SetActive(true ~= is_unlock and not is_active)
  self.v_uiobjects.LineActive:SetActive(is_unlock)
  self.v_uiobjects.BgActive:SetActive(is_unlock)
  local icon_path = ShareRes.get_curse_ring_bless_icon(bless_id)
  ResMgr:load_set_icon(self.v_uicompents.BlessingIcon_img, icon_path)
  local cost_item, cost_count = self.v_cfg.CostItem, self.v_cfg.CostCnt
  local show_redpoint = is_active and (not Util.is_more_than_zero(cost_item) or cost_count <= BagMgr:get_item_num(cost_item))
  self.v_uiobjects.RedPoint:SetActive(show_redpoint)
  local btn = self:get_button()
  self:set_button_listener(btn, function()
    self:on_click_btn()
  end)
end

function ui:on_click_btn()
  self.v_parent_ui:on_select_bless_item(self.v_id)
end

function ui:on_select_item(select_id)
  self.v_uiobjects.Select:SetActive(self.v_id == select_id)
end

return ui
