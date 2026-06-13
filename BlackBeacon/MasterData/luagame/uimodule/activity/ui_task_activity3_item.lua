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

function ui:set_data(unlock_time, puzzle_id, role_id)
  local cur_time = Date.server_time()
  local is_unlock = not unlock_time or unlock_time <= cur_time
  self.v_uiobjects.Bg:SetActive(is_unlock)
  if self.v_uiobjects.LockBg then
    self.v_uiobjects.LockBg:SetActive(not is_unlock)
  end
  self.v_uiobjects.Lock:SetActive(not is_unlock)
  self.v_uiobjects.UnLock:SetActive(is_unlock)
  self.v_uiobjects.ProfileLock:SetActive(not is_unlock)
  self.v_uiobjects.Profile:SetActive(is_unlock)
  self.v_uiobjects.BtnDetail:SetActive(is_unlock)
  local icon_path = ShareRes.get_item_icon_path(puzzle_id)
  ResMgr:load_set_icon(self.v_uicompents.PuzzleIcon_img, icon_path)
  local buddy_name = "？？？"
  if is_unlock then
    local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(puzzle_id)
    self.v_uicompents.PuzzleName_txt.text = puzzle_cfg.Name
    local buddy_cfg = ShareRes.get_buddy_cfg(role_id)
    buddy_name = buddy_cfg.Name
    ResMgr:load_set_icon(self.v_uicompents.Profile_img, CharacterMgr:get_buddy_icon_path(role_id))
    self:set_button("BtnDetail", function()
      UIMgr:get_ui("itemTip"):ui_show({item_id = puzzle_id})
    end)
  else
    self.v_uicompents.LockDesc_txt.text = Date.get_time_desc2(unlock_time - cur_time) .. "后解锁"
  end
  self.v_uicompents.CharName_txt.text = buddy_name
end

return ui
