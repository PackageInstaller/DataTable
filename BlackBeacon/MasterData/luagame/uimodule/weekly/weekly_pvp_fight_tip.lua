local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local _insert = table.insert
local _remove = table.remove
local BATTLE_TASK_CFG = require("uimodule.fight_task.battle_task_config")
local NOTICE_TYPE = BATTLE_TASK_CFG.NOTICE_TYPE
local NOTICE_IMG_RES = {
  [NOTICE_TYPE.BATTLE_TASK_RECEIVE] = "Battle_zs_jqrw",
  [NOTICE_TYPE.BATTLE_TASK_COMPLETE] = "Battle_zs_rwwc"
}
local MODEL = {}

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:ui_update()
  local now_time = Global.real_time
  if self.v_start_time and now_time - self.v_start_time >= 2 then
    self:ui_hide()
  end
end

function ui:ui_on_show(tip)
  self.v_start_time = Global.real_time
  local str = Util.format_str("限时内击败更多的敌人")
  if TowerMgr then
    local point_id = TowerMgr:get_cur_point_id()
    local cfg = ShareRes.get_weekly_pvp_epi_cfg(point_id)
    if not cfg then
      local all_config = ShareRes.get_weekly_prepare_war()
      for i, v in pairs(all_config) do
        if v.EpiID == point_id then
          cfg = v
          break
        end
      end
    end
    if cfg then
      str = ""
      for i, v in ipairs(cfg.BuffDesc) do
        if nil ~= v and "" ~= v then
          if 1 ~= i then
            str = str .. "&"
          end
          str = str .. v
        end
      end
    end
  end
  local tip = str
  self.v_uicompents.NoticeText_txt.text = tip
end

function ui:ui_on_hide()
  self.v_start_time = nil
end

return ui
