local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local _tsort = table.sort
local LEVEL_ITEM_KEY = "GECAO_LEVEL_ITEM_KEY"
local AWARD_ITEM_KEY = "GECAO_AWARD_ITEM_KEY"
local LevelSv = require("uimodule.gecao.local_widgets.gecao_scroll_view")
local ProgressAwardSlider = require("uimodule.gecao.local_widgets.progress_award_slider")
local LevelItem = require("uimodule.gecao.local_widgets.gecao_level_item")
local AwardItem = require("uimodule.gecao.local_widgets.progress_award_item")
local Scroll_Anim_Time = 0.5
local MODEL = {
  v_black_bg = {
    "Black_Bg",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self.v_is_click_return = true
    self:ui_hide()
  end)
  local uobj = self.v_uiobjects
  self.v_level_sv = LevelSv:new(self, uobj.LevelList, uobj.LevelContent, LevelItem, LEVEL_ITEM_KEY)
  self.v_award_slider = ProgressAwardSlider:new(self, uobj.ProgressAwardSlider, AwardItem, AWARD_ITEM_KEY)
  local view_port_rect = self:get_rect_transform(nil, uobj.Viewport)
  self.v_view_port_width = view_port_rect.rect.width
end

function ui:cache_ui()
  return true
end

function ui:ui_on_show()
  self.cur_time = 0
  self.v_black_bg:SetActive(false)
  self:remove_sequences(false)
  self:refresh_view()
  local time = self.v_level_sv:get_anim_time()
  self:set_cannot_touch(time)
  self:register_event()
end

function ui:ui_on_hide()
  self.v_chapter_data = nil
  self:remove_sequences(true)
  self:remove_cannot_touch_timer()
  self.cur_time = nil
  self.v_black_bg:SetActive(false)
  self.v_level_sv:clear()
  self:unbind_all_auto_mq()
end

function ui:ui_on_destroy()
  self.v_level_sv = nil
  self.v_select_item_index = nil
end

function ui:refresh_view()
  self:refresh_level_sv()
  self:refresh_award()
end

function ui:refresh_level_sv()
  local gecao_cfg = ShareRes.get_gecao_cfg()
  if not gecao_cfg then
    return
  end
  local cfg = {}
  for _, data in pairs(gecao_cfg) do
    _tinsert(cfg, data)
  end
  table.sort(cfg, function(a, b)
    if a.Level == b.Level then
      return a.Id < b.Id
    end
    return a.Level < b.Level
  end)
  self.v_level_sv:update_list(cfg)
end

function ui:refresh_award()
  local award_cfgs = ShareRes.get_gecao_award_cfg()
  if not award_cfgs then
    return
  end
  local cfg = {}
  for _, data in pairs(award_cfgs) do
    _tinsert(cfg, data)
  end
  table.sort(cfg, function(a, b)
    return a.Id < b.Id
  end)
  local max_star_num = cfg[#cfg].Id
  local cur_star_num = ChapterMgr:get_cut_grass_star_num()
  local val = cur_star_num / max_star_num
  self.v_award_slider:update_list(cfg, val)
  self:refresh_star(cur_star_num, max_star_num)
end

function ui:refresh_star(cur_star_num, max_star_num)
  local ucom = self.v_uicompents
  ucom.AllStarMax_txt.text = max_star_num or 0
  ucom.AllStarNow_txt.text = cur_star_num or 0
end

function ui:set_cannot_touch(time)
  self:remove_cannot_touch_timer()
  self.v_uiobjects.Cannot_Touch_Bg:SetActive(true)
  self.v_cannot_touch_timer = Timer:add_timer("cannot_touch_timer", time, function()
    self.v_uiobjects.Cannot_Touch_Bg:SetActive(false)
  end)
end

function ui:remove_cannot_touch_timer()
  if self.v_cannot_touch_timer then
    Timer:remove_timer(self.v_cannot_touch_timer)
    self.v_cannot_touch_timer = nil
  end
end

function ui:move_level_item_to_first(data)
  local index = data.index
  self.v_select_item_index = index
  local item = self.v_level_sv:get_item_at_index(index)
  local item_obj = item.go
  local width = item:get_width()
  self.v_move_item_obj = item_obj
  local uobj = self.v_uiobjects
  local scrollRect = self:get_scrollrect(nil, uobj.LevelList)
  scrollRect.movementType = 0
  self.v_content_pos_x = uobj.LevelContent.transform.anchoredPosition.x
  local horizontal_grp = uobj.LevelContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
  local item_width = horizontal_grp.spacing + width
  local content_target_pos_x = -1 * (index - 1) * item_width
  local move_width = self.v_content_pos_x - content_target_pos_x
  local rate = move_width / self.v_view_port_width
  self.v_anim_time = Scroll_Anim_Time * rate
  self:set_cannot_touch(self.v_anim_time)
  UIMgr:get_ui("gecao_stage_info"):ui_show(data, item_obj, self.v_anim_time)
  local sequence = Util.create_sequence()
  sequence:Append(uobj.LevelContent.transform:DOAnchorPosX(content_target_pos_x, self.v_anim_time))
  table.insert(self.v_sequences, sequence)
end

function ui:revert_scroll(alpha)
  local item_canvas = self:get_canvas_group(nil, self.v_move_item_obj)
  item_canvas.alpha = alpha
  local uobj = self.v_uiobjects
  local scrollRect = self:get_scrollrect(nil, uobj.LevelList)
  scrollRect.movementType = 1
end

function ui:move_level_item_to_src_pos()
  self:set_cannot_touch(self.v_anim_time or Scroll_Anim_Time)
  local pos_x = self.v_content_pos_x or 0
  local uobj = self.v_uiobjects
  local sequence = Util.create_sequence()
  sequence:Append(uobj.LevelContent.transform:DOAnchorPosX(pos_x, self.v_anim_time or Scroll_Anim_Time))
  table.insert(self.v_sequences, sequence)
end

function ui:remove_sequences(is_nil)
  if self.v_sequences then
    for k, sequence in pairs(self.v_sequences) do
      sequence:Kill(false)
    end
  end
  if is_nil then
  end
  self.v_sequences = {}
end

function ui:on_single_epi_net_data_update(msg)
  self:refresh_award()
end

function ui:on_get_award(msg)
  self:refresh_award()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_GECAO_EPI_NET_UPDATE, self.on_single_epi_net_data_update, self)
  self:bind_auto_mq(Const.MSG_ON_GECAO_GET_AWARD, self.on_get_award, self)
end

return ui
