local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local DESTINY_DROP_STATE = curse_com_def.DESTINY_DROP_STATE

function ui:on_click_btn()
  self.v_parent_ui:on_click_item_btn(self.v_index)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(ring_id, index, item_id, state, state_time)
  self.v_item_id = item_id
  self.v_index = index
  self.v_ring_id = ring_id
  local puzzle_cfg = ShareRes.get_buddy_puzzle_cfg(item_id)
  if not puzzle_cfg then
    Log.Error("获取插件配置失败，请检查配置 id:", item_id)
    return
  end
  local graph_show_cfg = ShareRes.get_buddy_puzzle_graph_show_cfg(puzzle_cfg.GraphID)
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_quality_path(puzzle_cfg.Quality)
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, item_icon_path)
  ResMgr:load_set_icon(self.v_uicompents.QualityBg_img, item_quality_path)
  ResMgr:load_set_icon(self.v_uicompents.PuzzleSize_img, graph_show_cfg.SmallIcon, nil, true)
  self.v_uicompents.Name_txt.text = puzzle_cfg.Name
  self.v_is_lock = false
  if state == DESTINY_DROP_STATE.CAN_SHOW then
    local cur_time = Date.server_time()
    if state_time > cur_time then
      self.v_is_lock = true
      self.v_uicompents.LockDesc_txt.text = Date.get_time_desc2(state_time - cur_time) .. "后解锁"
    end
  end
  self.v_uiobjects.Lock:SetActive(self.v_is_lock)
  self:set_button_listener(nil, function()
    self:on_click_btn()
  end)
end

function ui:set_select(is_select, is_real_select)
  self.v_is_select = is_select
  self.v_uiobjects.Now:SetActive(is_real_select)
  self.v_uiobjects.Select:SetActive(is_select)
  if not self.v_is_lock then
    self.v_uiobjects.RedPoint:SetActive(ChallengeRingPlusMgr:get_destiny_drop_red(self.v_index))
  else
    self.v_uiobjects.RedPoint:SetActive(false)
  end
end

function ui:get_item_id()
  return self.v_item_id
end

return ui
