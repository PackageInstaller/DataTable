local Base = require("ui.uibase")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local commonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local Act_ID = commonDef.ACTY_TYPE.BUDDY_TEACH
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_ret = {
    "BtnRet",
    BIND_TYPE.BUTTON
  },
  v_detail_img = {
    "Detail_Img",
    BIND_TYPE.IMAGE
  },
  v_quit_btn = {
    "QuitBtn",
    BIND_TYPE.BUTTON
  },
  v_setting_btn = {
    "SettingBtn",
    BIND_TYPE.BUTTON
  },
  v_skill_title = {
    "SkillTitle",
    BIND_TYPE.TEXT
  },
  v_tec_info = {
    "TecInfo",
    BIND_TYPE.TEXT
  },
  v_tips_detail_name = {
    "TipsDetailName",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self:set_button("QuitBtn", function()
    self:_onclick_quit_btn()
  end)
  self:set_button("SettingBtn", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
end

function ui:ui_on_show(point_id, ...)
  self.v_point_id = point_id
  if not point_id then
    Log.Error("get point_id failure!")
    return
  end
  local buddy_id = Global.hero:get_config_id()
  local stage_cfg = ShareRes.get_buddy_teach_cfg_by_point_id(point_id)
  local progress = TowerMgr:get_tower_progress()
  local floor = progress.floor_id
  local tips_id = stage_cfg.Tips[floor]
  if not tips_id then
    Log.Error("get tips id failed, buddy_id=", buddy_id, "point_id=", point_id)
    return
  end
  local cfg = ShareRes.create("activity.buddy_skill_tips", tips_id)
  if nil == cfg then
    Log.Error("lack buddy_skill_tips cfg, ", tips_id)
  end
  self.v_uicompents.TecInfo_txt.text = cfg.Detail_Desc
  
  local function cb()
    self.v_uicompents.Detail_Img_img:SetNativeSize()
  end
  
  ResMgr:load_set_icon(self.v_uicompents.Detail_Img_img, "UIHeroTeaching/" .. cfg.Detail_Img, cb, true)
  self.v_uicompents.SkillTitle_txt.text = cfg.Detail_Name
end

function ui:ui_on_hide()
end

function ui:_onclick_quit_btn()
  local tip = Util.format_str("是否立即退出关卡")
  local sure_btn = Util.format_str("退出")
  local cancle_btn = Util.format_str("返回")
  
  local function sure_callback()
    self:ui_hide()
    UIMgr:get_ui("not_progress_battle_def_settle"):ui_show()
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip, sure_btn, cancle_btn)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_point_id
end

return ui
