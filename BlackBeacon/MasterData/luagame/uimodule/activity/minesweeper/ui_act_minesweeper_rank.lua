local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local LoopListClass = require("ui.widget.infinite_loop_list")
local StageTemClass = Util.create_child_mt(require("ui.uiobject"))
local MemberTemClass = Util.create_child_mt(require("ui.uiobject"))
local StageTemKey = "MINESWEEPER_STAGETEM"
local MemberTemKey = "MINESWEEPER_MEMBERTEM"
local HERO_ICON_PATH = "Icon/Profile/%s"

function StageTemClass:ui_finish_load()
end

function StageTemClass:set_data(data)
  local chapName_txt = Util.get_text("ChapName", self.v_object)
  local lv_txt = Util.get_text("Lv", self.v_object)
  chapName_txt.text = data.ChapterName
  lv_txt.text = data.LevelRangeText
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    self.v_parent_ui:select_rank_list(data.idx)
    self.v_parent_ui:hide_or_show_stage_dp()
  end)
end

function StageTemClass:on_clear()
end

local index_to_bgname_map = {
  "RankNumBg1",
  "RankNumBg2",
  "RankNumBg3"
}

function MemberTemClass:ui_finish_load()
end

function MemberTemClass:set_data(item_obj, data_list, index)
  local data_info = data_list[index]
  if data_info.ranking > 3 then
    self.v_uiobjects.RankNumBgList:SetActiveEx(false)
    self.v_uiobjects.RankNum:SetActiveEx(true)
    self.v_uicompents.RankNum_txt.text = data_info.ranking
  else
    self.v_uiobjects.RankNumBgList:SetActiveEx(true)
    self.v_uiobjects.RankNum:SetActiveEx(false)
    for idx, bg_name in ipairs(index_to_bgname_map) do
      self.v_uiobjects[bg_name]:SetActiveEx(idx == data_info.ranking)
    end
  end
  local snapinfo = data_info.snapinfo
  self.v_uicompents.PlayerName_txt.text = snapinfo.name
  self.v_uicompents.Score_txt.text = data_info.value
  self.v_uicompents.Floor_txt.text = data_info.floor_idx
  local avatar_cfg = ShareRes.create("player.player_avatar", snapinfo.face_id)
  ResMgr:load_set_icon(self.v_uicompents.Profile_img, string.format(HERO_ICON_PATH, avatar_cfg.Icon))
end

function MemberTemClass:on_clear()
end

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnStage", function()
    self:hide_or_show_stage_dp()
  end)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.StageDropDown, StageTemClass, StageTemKey)
  self.v_rank_loop_list = LoopListClass:new(self, self.v_uiobjects.MemberScroll, MemberTemClass, MemberTemKey)
end

function ui:ui_on_show(level_range_index)
  self:refresh(level_range_index)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_MINESWEEPER_INFO, self.on_update_minesweeper_info, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh(level_range_index)
  self.v_level_range_index = level_range_index or self.v_level_range_index or 1
  local chaptergroup_id = MineSweeperMgr.chapter_group_id
  self.v_minesweeper_chaptergroup_cfg = ShareRes.get_minesweeper_chaptergroup_cfg(chaptergroup_id)
  self.v_static_sv:update_list(self.v_minesweeper_chaptergroup_cfg)
  local minesweeper_chapter_cfg = self.v_minesweeper_chaptergroup_cfg[self.v_level_range_index]
  self.v_uicompents.ChapName_txt.text = minesweeper_chapter_cfg.ChapterName
  self.v_uicompents.Lv_txt.text = minesweeper_chapter_cfg.LevelRangeText
  local rank_list = MineSweeperMgr.minesweeper_rank_list
  local my_rank = rank_list.my_rank
  local preranking = 0
  local prevalue = -1
  local samevaluecount = 1
  local onthelist = false
  local insert_index, remove_index
  for index, rank_data in ipairs(rank_list.rank_list) do
    if rank_data.value == prevalue then
      rank_data.ranking = preranking
      samevaluecount = samevaluecount + 1
    else
      preranking = preranking + samevaluecount
      rank_data.ranking = preranking
      prevalue = rank_data.value
      samevaluecount = 1
    end
    if not onthelist and rank_data.value == my_rank.value then
      insert_index = index
      onthelist = true
      my_rank.ranking = preranking
    end
    if rank_data.snapinfo.uuid == my_rank.snapinfo.uuid then
      remove_index = index
    end
  end
  if onthelist then
    if remove_index then
      table.remove(rank_list.rank_list, remove_index)
    end
    table.insert(rank_list.rank_list, insert_index, my_rank)
    if #rank_list.rank_list > MineSweeperMgr.minesweeper_rank_user_count then
      table.remove(rank_list.rank_list)
    end
  end
  self.v_uiobjects.BestRecord:SetActiveEx(-1 ~= my_rank.rank)
  self.v_uiobjects.NoRecord:SetActiveEx(-1 == my_rank.rank)
  self.v_uiobjects.RankNum:SetActiveEx(-1 ~= my_rank.rank)
  self.v_uiobjects.NoRank:SetActiveEx(-1 == my_rank.rank)
  if -1 ~= my_rank.rank then
    self.v_uicompents.ScoreNum_txt.text = my_rank.value
    self.v_uicompents.DifficultyNum_txt.text = my_rank.floor_idx
    self.v_uicompents.RankNum_txt.text = my_rank.ranking or my_rank.rank
  end
  local player_snapinfo = my_rank.snapinfo
  local avatar_cfg = ShareRes.create("player.player_avatar", player_snapinfo.face_id)
  ResMgr:load_set_icon(self.v_uicompents.Profile_img, string.format(HERO_ICON_PATH, avatar_cfg.Icon))
  self.v_uicompents.PlayerName_txt.text = player_snapinfo.name
  self.v_uiobjects.MemberEmptyTip:SetActiveEx(UtilTable.is_empty(rank_list.rank_list))
  self.v_rank_loop_list:refresh_data(rank_list.rank_list)
end

function ui:hide_or_show_stage_dp()
  local StageDropDown = self.v_uiobjects.StageDropDown
  StageDropDown:SetActiveEx(not StageDropDown.activeSelf)
end

function ui:select_rank_list(index)
  self.v_level_range_index = index
  local chapter_id = self.v_minesweeper_chaptergroup_cfg[self.v_level_range_index].Id
  MineSweeperMgr:request_rank_list(chapter_id, function()
    self:refresh()
  end)
end

function ui:on_update_minesweeper_info()
  self:refresh()
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(MineSweeperMgr.activity_id, self.v_ui_name, nil, true)
end

return ui
