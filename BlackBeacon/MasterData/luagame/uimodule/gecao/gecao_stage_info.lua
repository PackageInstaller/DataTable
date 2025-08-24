local Base = require("ui.uibase")
local M = Util.create_child_mt(Base)
local Fade_Anim_Time = 0.3
local Fade_In_PosX = -367
local Fade_Out_PosX = 520
local SaticSv = require("ui.widget.static_scroll_view")
local TaskItem = require("uimodule.gecao.local_widgets.gecao_task_item")
local TaskItemKey = "GECAO_TASK_ITEM_KEY"
local AwardItem = require("uimodule.gecao.local_widgets.gecao_pre_award_item")
local AwardItemKey = "GECAO_AWARD_PREVIEW_ITEM_KEY"
local Vec2 = require("base.vec2")
local Vec3 = require("base.vec3")
local CommonDef = require("cs_share.common_define")
local _insert = table.insert

function M:ui_finish_load()
  self:set_button("BtnRet", function()
    self:hide_anim()
  end)
  local uobj = self.v_uiobjects
  self.v_task_sv = SaticSv:new(self, uobj.TargetObj, TaskItem, TaskItemKey)
  self.v_award_preview_sv = SaticSv:new(self, uobj.AwardContent, AwardItem, AwardItemKey)
  self:set_button("BtnStart", function()
    self:click_fight_btn()
  end)
end

function M:ui_before_show(cfg, item_obj, item_move_time)
  self.v_chapter_id = cfg.Id
  self.v_chapter_cfg = cfg
  self.v_src_item_obj = item_obj
  self.v_item_move_time = item_move_time
  self.v_src_item_trans = item_obj.transform
end

function M:ui_on_show()
  self:refresh_view()
  self:show_anim()
end

function M:refresh_view()
  local ucom = self.v_uicompents
  local cfg = self.v_chapter_cfg
  ResMgr:load_set_icon(ucom.TitleBg_img, cfg.TitleBg, nil, true, self)
  ucom.SiNum_txt.text = Util.format_str("STAGE{1}-{2}", cfg.Level, cfg.LevelName)
  ucom.SiName_txt.text = cfg.Name
  ucom.SuggestPower_txt.text = cfg.SuggestLevel
  local task_data_list = {}
  for i = 1, 3 do
    local condition_id = cfg.Condition[i]
    if condition_id > 0 then
      local task_data = ShareRes.get_gecao_star_desc_cfg(condition_id)
      local is_finish = ChapterMgr:is_cut_grass_epi_task_finish(cfg.Id, i)
      task_data.is_finish = is_finish
      task_data.arg = cfg.Arg[i]
      _insert(task_data_list, task_data)
    end
  end
  self.v_task_sv:update_list(task_data_list)
  local award_cfgs = ShareRes.get_awards(cfg.RewardGroup)
  self.v_award_preview_sv:update_list(award_cfgs)
  local net_data = ChapterMgr:get_cut_grass_epi_data_by_id(cfg.Id)
  ucom.BestFloor_txt.text = net_data.history_max_floor
  local chapter_point_cfg = ShareRes.get_chapter_point_cfg(cfg.EpisodeId)
  local tower_cfg = ShareRes.get_tower_cfg(chapter_point_cfg.FightId)
  local max_floor = tower_cfg.FloorMax
  ucom.MaxFloor_txt.text = max_floor
end

function M:ui_on_hide()
  self:remove_cannot_touch_timer()
  self.v_task_sv:clear()
  self.v_award_preview_sv:clear()
  if self.v_clone_item_obj then
    ResMgr:destroy_gameobj(self.v_clone_item_obj)
  end
  self.v_clone_item_obj = nil
  self.v_src_item_obj = nil
  local parent_ui = UIMgr:try_get_ui("gecao_main")
  if parent_ui then
    parent_ui:revert_scroll(1)
  end
  if self.v_hide_sequence then
    self.v_hide_sequence:Kill(false)
    self.v_hide_sequence = nil
  end
  if self.v_show_sequence then
    self.v_show_sequence:Kill(false)
    self.v_show_sequence = nil
  end
end

function M:ui_on_destroy()
  self.v_task_sv = nil
  self.v_award_preview_sv = nil
end

function M:hide_anim()
  self:set_cannot_touch()
  local uobj = self.v_uiobjects
  local ucom = self.v_uicompents
  local parent_ui = UIMgr:try_get_ui("gecao_main")
  if parent_ui then
    parent_ui:move_level_item_to_src_pos()
  end
  local sequence = Util.create_sequence()
  sequence:Append(uobj.StInfo.transform:DOAnchorPosX(Fade_Out_PosX, Fade_Anim_Time))
  sequence:Join(ucom.Black_Bg_img:DOFade(0, Fade_Anim_Time))
  sequence:AppendInterval(self.v_item_move_time)
  sequence:OnComplete(function()
    self:ui_hide()
  end)
  self.v_hide_sequence = sequence
end

function M:ui_on_update(delta_time)
  if self.v_src_item_trans and self.v_item_root_trans then
    self.v_item_root_trans:SetPositionA(self.v_src_item_trans:GetPositionA())
  end
end

function M:clone_item()
  self.v_item_root_trans = self.v_uiobjects.ItemObjRoot.transform
  self.v_item_root_trans.position = self.v_src_item_trans.position
  local item_obj = ResMgr:instantiate(self.v_src_item_obj)
  item_obj.transform:SetParent(self.v_item_root_trans, false)
  item_obj.transform.localPosition = Vec3.zero
  local item_canvas = self:get_canvas_group(nil, item_obj)
  item_canvas.alpha = 1
  local src_item_canvas = self:get_canvas_group(nil, self.v_src_item_obj)
  src_item_canvas.alpha = 0
  return item_obj
end

function M:show_anim()
  self:set_cannot_touch()
  local uobj = self.v_uiobjects
  local ucom = self.v_uicompents
  self.v_clone_item_obj = self:clone_item()
  self.v_src_item_root_pos_x = uobj.ItemObjRoot.transform.anchoredPosition.x
  local stage_rect = self:get_rect_transform(nil, uobj.StInfo)
  stage_rect.anchoredPosition.x = Fade_Out_PosX
  local sequence = Util.create_sequence()
  sequence:Append(ucom.Black_Bg_img:DOFade(0.8, Fade_Anim_Time))
  sequence:Join(uobj.StInfo.transform:DOAnchorPosX(Fade_In_PosX, Fade_Anim_Time))
  sequence:AppendInterval(self.v_item_move_time)
  self.v_show_sequence = sequence
end

function M:set_cannot_touch()
  self:remove_cannot_touch_timer()
  self.v_uiobjects.Cannot_Touch_Bg:SetActive(true)
  local time = math.max(self.v_item_move_time, Fade_Anim_Time)
  self.v_cannot_touch_timer = Timer:add_timer("cannot_touch_timer", time, function()
    self.v_uiobjects.Cannot_Touch_Bg:SetActive(false)
  end)
end

function M:remove_cannot_touch_timer()
  if self.v_cannot_touch_timer then
    Timer:remove_timer(self.v_cannot_touch_timer)
    self.v_cannot_touch_timer = nil
  end
end

function M:click_fight_btn()
  if TowerMgr:check_fight_progress() then
    return
  end
  self:ui_hide()
  UIMgr:get_ui("team"):ui_show(self.v_chapter_id, self.v_chapter_cfg.EpisodeId, CommonDef.CHALLENGE_TYPE.CUT_GRASS)
end

return M
