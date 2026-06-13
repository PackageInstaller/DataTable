local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_advice_tem = {
    "AdviceTem",
    BIND_TYPE.OBJECT
  },
  v_advice = {
    "Advice",
    BIND_TYPE.OBJECT
  },
  v_btn_quit = {
    "BtnQuit",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnQuit", function()
    self:_onclick_quit_btn()
  end)
  self.template_key = {
    desc_item = "desc_item_" .. self:ui_get_name()
  }
  self:register_exist_auto_template(self.template_key.desc_item, self.v_uiobjects.AdviceTem, self.v_uiobjects.Advice)
end

function ui:ui_on_show(callback, ...)
  local tower_info = TowerMgr:get_tower_progress()
  local cfg = ShareRes.get_chapter_point_cfg(tower_info.episode_id)
  if not cfg.Failure_Notice then
    return
  end
  local list = Util.split_str(cfg.Failure_Notice, "|")
  self:give_back_auto_cache(self.template_key.desc_item, false)
  for _, v in ipairs(list) do
    local item = self:get_auto_cache(self.template_key.desc_item)
    local lab = self:get_text("Text", item)
    lab.text = v
  end
end

function ui:ui_on_hide()
end

function ui:_onclick_quit_btn()
  local function callback()
    Global.scene_mgr:on_enter_main_scene()
    
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:get_fight_reward(callback)
  end
end

return ui
