local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local FontStyle = UnityEngine.FontStyle
local ToggleTab = require("ui.widget.widget_toggle_tab")
local HERO_ICON_PATH = "Icon/Profile/%s"
local LoopListClass = require("ui.widget.infinite_loop_list")
local RankItemClass = require("uimodule.chapter.infinite.infinite_rank_item")
local INFINITE_RANK_STAGE_ITEM_KEY = "INFINITE_RANK_STAGE_ITEM_KEY"
local _floor = math.floor
local _insert = table.insert
local ONE_HOUR_SEC = 3600
local ONE_MINUTE_SEC = 60
local last_rank_item

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnStage", function()
    self:on_click_stage()
  end)
  self:set_button("BtnCloseStage", function()
    self.v_uiobjects.StageDropDown:SetActive(false)
    self.v_uiobjects.BtnCloseStage:SetActive(false)
  end)
  self:set_button("BtnMaskClose", function()
    self:hide_rank_function_panel()
  end)
  self.v_time_obj = Util.get_child_gameobj("Time", self.v_uiobjects.PlayerObj)
  self.v_rank_list = LoopListClass:new(self, self.v_uiobjects.MemberScroll, RankItemClass)
  self:register_exist_auto_template(INFINITE_RANK_STAGE_ITEM_KEY, self.v_uiobjects.StageTem, self.v_uiobjects.StageDropDown)
end

function ui:ui_on_show(rank_name, curr_rank_cfg, all_rank_cfg_list)
  self.v_all_rank_cfg_list = all_rank_cfg_list
  self.v_rank_name = rank_name
  self.v_curr_rank_cfg = curr_rank_cfg
  self.v_rank_desc_info = RankMgr:get_rank_desc_info(rank_name)
  self.v_uicompents.TitleScore_txt.text = self.v_rank_desc_info.score_name
  self:refresh_all_info()
  self:register_event()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_RANK_UPDATE, self.refresh_all_info, self)
end

function ui:ui_on_hide()
  self.v_rank_list:ui_on_hide()
  self:hide_rank_function_panel()
end

function ui:refresh_stage_list()
  self:give_back_auto_cache(INFINITE_RANK_STAGE_ITEM_KEY)
  for _, cfg in pairs(self.v_all_rank_cfg_list) do
    local item_obj = self:get_auto_cache(INFINITE_RANK_STAGE_ITEM_KEY)
    Util.get_text("Text", item_obj).text = cfg.name
    local btn = Util.get_button(nil, item_obj)
    self:set_button_listener(btn, function()
      self:on_stage_item_click(cfg)
    end)
  end
end

function ui:on_click_stage()
  if self.v_uiobjects.StageDropDown.activeSelf then
    self.v_uiobjects.StageDropDown:SetActive(false)
    self.v_uiobjects.BtnCloseStage:SetActive(false)
    return
  end
  self.v_uiobjects.StageDropDown:SetActive(true)
  self.v_uiobjects.BtnCloseStage:SetActive(true)
  self:refresh_stage_list()
end

function ui:on_stage_item_click(cfg)
  self.v_uiobjects.StageDropDown:SetActive(false)
  self.v_uiobjects.BtnCloseStage:SetActive(false)
  if cfg.flag == self.v_curr_rank_cfg.flag then
    return
  end
  self.v_curr_rank_cfg = cfg
  RankMgr:request_rank_list(self.v_rank_name, cfg.flag, 1, cfg.show_count, cfg.total_count, true)
end

function ui:on_rank_icon_click(msg)
  local rank_item = msg.mm_obj
  if not rank_item then
    self:hide_rank_function_panel()
    return
  end
  if last_rank_item then
    if last_rank_item == rank_item then
      return
    end
    last_rank_item:hide_function_btn()
  end
  self.v_uiobjects.BtnMaskClose:SetActive(true)
  rank_item:show_function_btn()
  last_rank_item = rank_item
end

function ui:hide_rank_function_panel()
  if last_rank_item then
    last_rank_item:hide_function_btn()
  end
  last_rank_item = nil
  self.v_uiobjects.BtnMaskClose:SetActive(false)
end

function ui:ui_on_destroy()
  self.v_rank_list:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_infinite_id, self.v_rank_info
end

function ui:refresh_all_info()
  self.v_rank_info = RankMgr:get_rank_info(RankMgr:get_full_rank_name(self.v_rank_name, self.v_curr_rank_cfg.flag))
  self.v_uicompents.StageName_txt.text = self.v_curr_rank_cfg.name
  self:set_player_info()
  self.v_uiobjects.StageDropDown:SetActive(false)
  self:refresh_rank_info()
end

function ui:set_player_info()
  local player_data = self.v_rank_info.my_rank
  local player_snapinfo = player_data.snapinfo
  local avatar_cfg = ShareRes.create("player.player_avatar", player_snapinfo.face_id)
  ResMgr:load_set_icon(self.v_uicompents.Profile_img, string.format(HERO_ICON_PATH, avatar_cfg.Icon))
  self.v_uicompents.PlayerName_txt.text = player_snapinfo.name
  self.v_uiobjects.NoRecord:SetActive(false)
  self.v_uiobjects.BestRecord:SetActive(true)
  self.v_uicompents.ScoreNum_txt.text = RankMgr:get_score(self.v_rank_name, player_data.value)
  self.v_uicompents.DifficultyNum_txt.text = player_data.infinite_data and player_data.infinite_data.coeff or "--"
  self.v_uiobjects.RankNum:SetActive(-1 ~= player_data.rank)
  self.v_uiobjects.NoRank.gameObject:SetActive(-1 == player_data.rank)
  self:refresh_rank_text_desc()
  if -1 ~= player_data.rank then
    local rank_area = self.v_curr_rank_cfg.total_count
    if rank_area < player_data.rank then
      self.v_uicompents.RankNum_txt.text = ">" .. rank_area
    else
      self.v_uicompents.RankNum_txt.text = player_data.rank
    end
  end
end

function ui:refresh_rank_text_desc()
  self.v_uicompents.ScoreDesc_txt.text = self.v_rank_desc_info.score_name .. "："
  self.v_uicompents.DifficultyDesc_txt.text = self.v_rank_desc_info.difficulty_name .. "："
  self.v_uiobjects.DifficultyIcon:SetActive(self.v_rank_desc_info.is_show_difficulty_icon)
  if self.v_rank_name == Config.CommonDefine.RANK_NAME.BOSS_FIGHT then
    self.v_uicompents.DifficultyNum_txt.text = self.v_curr_rank_cfg.boss_name
  end
end

function ui:refresh_rank_info()
  local rank_list = UtilTable.copy_table(self.v_rank_info.rank_list)
  if #rank_list > 0 then
    table.sort(rank_list, function(a, b)
      return a.rank < b.rank
    end)
  end
  local refresh_time = self.v_rank_info.refresh_time
  self.v_time_obj:SetActive(refresh_time and refresh_time > 0 and self.v_curr_rank_cfg.refresh_type and self.v_curr_rank_cfg.refresh_type > 0)
  if refresh_time and refresh_time > 0 then
    local time = Date.get_time_format_7(refresh_time - Date.server_time())
    self.v_uicompents.Time_txt.text = time
  end
  local total_rank = self.v_rank_info.total_rank
  local show_rank_count = self.v_curr_rank_cfg.show_count
  if 0 == total_rank then
    self.v_uiobjects.MemberEmptyTip:SetActive(true)
    self.v_uiobjects.MemberScroll:SetActive(false)
  else
    self.v_uiobjects.MemberEmptyTip:SetActive(false)
    self.v_uiobjects.MemberScroll:SetActive(true)
    if show_rank_count >= total_rank + 1 then
      _insert(rank_list, {})
    end
    for _, rank_info in pairs(rank_list) do
      rank_info.rank_name = self.v_rank_name
    end
    self.v_rank_list:refresh_data(rank_list)
  end
end

return ui
