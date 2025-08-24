local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local MODEL = {}
local WEEKLY_CFG = require("gamelogic.weekly.weekly_config")
local RANK_TYPE = WEEKLY_CFG.RANK_TYPE
local WEEKLY_CFG = require("gamelogic.weekly.weekly_config")
local WEEKLY_RES_PATH = WEEKLY_CFG.RANK_ICON_PATH
local UnionHelper = require("uimodule.union.union_helper")

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:ui_on_show()
  self:set_button_listener(self.v_uicompents.RankNum_btn, function()
    WeeklyMgr:request_player_info(self.v_data.snapinfo.uuid)
  end)
end

function ui:ui_on_hide()
end

function ui:set_data(go, data_list, idx)
  self.v_data = data_list[idx]
  self:update_rank_info()
end

function ui:update_rank_info()
  local data = self.v_data
  local player_info = data.snapinfo
  self.v_uiobjects.EmptyObj:SetActive(data.snapinfo == nil)
  self.v_uicompents.RankNum_txt.text = data.rank
  self.v_uicompents.PlayerName_txt.text = player_info.name
  self.v_uicompents.Score_txt.text = data.value
  local icon_path = UnionHelper.get_player_icon_path(player_info.face_id)
  ResMgr:load_set_icon(self.v_uicompents.ProfileIcon_img, icon_path)
  local segment_cfg = ShareRes.get_week_acty_segment_cfg(5)
  self.v_uicompents.RankName_txt.text = segment_cfg.SegmentName
  local rank_val = data.rank
  local is_top_rank = rank_val <= 3
  self.v_uiobjects.RankNum:SetActive(not is_top_rank)
  local name
  for index = 1, 3 do
    name = "RankNumBg" .. index
    self.v_uiobjects[name]:SetActive(is_top_rank and rank_val == index)
  end
end

return ui
