local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local AwardTemClass = Util.create_child_mt(require("ui.uiobject"))
local AwardTemKey = "MINESWEEPER_AWARDTEM"
local LocalStorage = require("utils.localstorage")
local color = {16117218, 6237702}
local height = 168

function AwardTemClass:ui_finish_load()
end

function AwardTemClass:set_data(data)
  local scorenum_txt = self.v_uicompents.ScoreNum_txt
  scorenum_txt.text = data.NeedScore
  local award_group_cfg = ShareRes.get_awards(data.AwardGroupId)
  self:set_award_info(self.v_uiobjects.Award1, award_group_cfg[1])
  self:set_award_info(self.v_uiobjects.Award2, award_group_cfg[2])
  local receivebg = self.v_uiobjects.ReceiveBg
  local receivemask = self.v_uiobjects.RecivedMask
  local redpoint = self.v_uiobjects.RedPoint
  local record_scroe = MineSweeperMgr:get_minesweeper_record_score()
  local award_id_map = MineSweeperMgr.gained_score_award_id_map
  if record_scroe >= data.NeedScore then
    if award_id_map[data.KeyId] then
      receivebg:SetActiveEx(false)
      receivemask:SetActiveEx(true)
      redpoint:SetActiveEx(false)
      Util.set_color(scorenum_txt, color[2])
    else
      receivebg:SetActiveEx(true)
      receivemask:SetActiveEx(false)
      redpoint:SetActiveEx(true)
      Util.set_color(scorenum_txt, color[1])
      self.v_parent_ui:mark_acceptable(data.idx)
    end
  else
    receivebg:SetActiveEx(false)
    receivemask:SetActiveEx(false)
    redpoint:SetActiveEx(false)
    Util.set_color(scorenum_txt, color[2])
    self.v_parent_ui:mark_acceptable(data.idx)
  end
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    MineSweeperMgr:request_get_score_award()
  end)
end

function AwardTemClass:set_award_info(item_obj, cfg)
  local item_id = cfg.ItemId
  local ItemIcon_img = Util.get_image("ItemIcon_", item_obj)
  local ItemQuality_img = Util.get_image("ItemQuality_", item_obj)
  local ItemNum_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", item_obj)
  local icon_path, quality_path = UtilUI.get_item_icon(item_id, true)
  ResMgr:load_set_icon(ItemQuality_img, quality_path)
  ResMgr:load_set_icon(ItemIcon_img, icon_path)
  ItemNum_txt.text = cfg.Num
  local btn = Util.get_button(nil, item_obj)
  self:set_button_listener(btn, function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id, is_exist_jump = false})
  end)
end

function AwardTemClass:on_clear()
end

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("GroupDetail1", function()
    local rule_id = ShareRes.get_minesweeper_misc().RuleId[1]
    UIMgr:get_ui("info_tips"):ui_show(rule_id)
  end)
  self:set_button("BtnRank", function()
    local minesweeper_chapter_id = MineSweeperMgr:get_minesweeper_chapter_id()
    local minesweeper_chapter_group_id = MineSweeperMgr.chapter_group_id
    local cfg = ShareRes.get_minesweeper_chaptergroup_cfg(minesweeper_chapter_group_id)
    local level_range_index
    for i, v in ipairs(cfg) do
      if minesweeper_chapter_id == v.Id then
        level_range_index = i
        break
      end
    end
    MineSweeperMgr:request_rank_list(minesweeper_chapter_id, function()
      UIMgr:get_ui("ui_act_minesweeper_rank"):ui_show(level_range_index)
    end)
  end)
  self:set_button("BtnHandBook", function()
    UIMgr:get_ui("ui_act_minesweeper_handbook"):ui_show()
  end)
  self:set_button("BtnStart", function()
    self:on_click_start_btn()
  end)
  self.v_static_sv_award = SaticSv:new(self, self.v_uiobjects.AwardList, AwardTemClass, AwardTemKey)
  local viewport = self.v_uiobjects.AwardList.transform.parent
  local viewport_rect = Util.get_rect_transform(nil, viewport)
  local _, h = viewport_rect:GetRectWH()
  self.v_viewport_height = h
end

function ui:ui_on_show()
  self:refresh()
  self:bind_auto_mq(Const.MSG_ON_UPDATE_MINESWEEPER_INFO, self.on_update_minesweeper_info, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:refresh()
  local t = LocalStorage:load_table(MineSweeperMgr.MINESWEEPER_KEY, true) or {}
  t[MineSweeperMgr.chapter_group_id] = 1
  LocalStorage:save_table(MineSweeperMgr.MINESWEEPER_KEY, t, true)
  MineSweeperMgr:refresh_redpoint()
  local minesweep_chapter_info = MineSweeperMgr:get_minesweeper_chapter_info()
  local minesweep_activity_id = MineSweeperMgr.activity_id
  local minesweep_chapter_id = MineSweeperMgr:get_minesweeper_chapter_id()
  local minesweeper_chapter_cfg = ShareRes.create("minesweeper.minesweeper_chapter")[minesweep_chapter_id]
  local score_award_id = minesweeper_chapter_cfg.ScoreAwardId
  local award_list = ShareRes.create("minesweeper.minesweeper_score_award")[score_award_id]
  self.v_min_idx = #award_list
  self.v_static_sv_award:update_list(award_list)
  self:scroll_to_index(self.v_min_idx)
  local activity_cfg = ShareRes.get_activity_cfg(minesweep_activity_id)
  local remain_time = NoviceMgr:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_cfg.OpenTime, activity_cfg.SustainTime)
  self.v_uicompents.Time_txt.text = Date.get_time_format_7(remain_time)
  local minesweep_chaptergroup_id = minesweeper_chapter_cfg.GroupId
  local minesweeper_cfg = ShareRes.create("minesweeper.minesweeper")[minesweep_activity_id]
  local index
  for i, v in ipairs(minesweeper_cfg.ChapterGroupId) do
    if v == minesweep_chaptergroup_id then
      index = i
      break
    end
  end
  local endtime_id = minesweeper_cfg.EndTime[index]
  remain_time = Date.get_time_stamp_by_scheme_id(endtime_id) - Date.server_time()
  self.v_uicompents.ChapTime_txt.text = Date.get_time_format_7(remain_time)
  self.v_uicompents.ChapName_txt.text = minesweeper_chapter_cfg.ChapterName
  self.v_uicompents.LvGroupNum1_txt.text = minesweeper_chapter_cfg.LevelName
  self.v_uicompents.Title_txt.text = "战功奖励" .. minesweeper_chapter_cfg.LevelRangeText
  self.v_uicompents.ScoreNum_txt.text = MineSweeperMgr:get_minesweeper_record_score()
  local level, level_range_begin, level_range_end = MineSweeperMgr:calc_minesweeper_knowledge_level(minesweep_chapter_info.knowledge_level_score, minesweep_chapter_id, true)
  self.v_uicompents.HBLvNum_txt.text = level
  self.v_uicompents.HBExp_txt.text = (level_range_begin or "-") .. "/" .. (level_range_end or "-")
  self.v_uicompents.HbBarFill_img.fillAmount = level_range_end and level_range_begin / level_range_end or 1
  self.v_start_game = not minesweep_chapter_info.grids
  self.v_uiobjects.StartText:SetActiveEx(self.v_start_game)
  self.v_uiobjects.ContinueText:SetActiveEx(not self.v_start_game)
  self.v_uiobjects.ScoreNow:SetActiveEx(not self.v_start_game)
  self.v_uicompents.ScoreNowNum_txt.text = minesweep_chapter_info.cur_score
end

function ui:on_click_start_btn()
  if self.v_start_game then
    MineSweeperMgr:request_start_game(function()
      UIMgr:get_ui("ui_minesweeper_battle"):ui_show()
    end)
  else
    UIMgr:get_ui("ui_minesweeper_battle"):ui_show()
  end
end

function ui:scroll_to_index(index)
  local list_height = #self.v_static_sv_award:get_items() * height
  self.v_uicompents.AwardList_rect:SetAnchoredPositionY(math.min((index - 1) * height, list_height - self.v_viewport_height))
end

function ui:mark_acceptable(index)
  self.v_min_idx = math.min(index, self.v_min_idx)
end

function ui:on_update_minesweeper_info()
  self:refresh()
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(MineSweeperMgr.activity_id, self.v_ui_name, nil, true)
end

return ui
