local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local CharTemClass = Util.create_child_mt(require("ui.uiobject"))
local CharTemKey = "MINESWEEPER_CHARTEM"

function CharTemClass:ui_finish_load()
end

function CharTemClass:set_data(data)
  local icon_path = UtilUI.get_hero_images(data.buddy_id, 1, data.fashion)
  ResMgr:load_set_icon(self.v_uicompents.Profile_img, icon_path)
  local record_buddy = MineSweeperMgr:get_minesweeper_record_buddy_list() or E
  local recorded
  for _, buddy_id in ipairs(record_buddy) do
    if buddy_id == data.buddy_id then
      recorded = true
      break
    end
  end
  if recorded then
    self.v_uiobjects.HpMask:SetActive(true)
    local minesweeper_misc_cfg = ShareRes.get_minesweeper_misc()
    local num = -minesweeper_misc_cfg.RepeatBuddyStamina
    self.v_uicompents.HpNum_txt.text = num
    self.v_repeat_buddy_stamina = num
  else
    self.v_uiobjects.HpMask:SetActive(false)
    self.v_repeat_buddy_stamina = 0
  end
end

function CharTemClass:on_clear()
end

function CharTemClass:get_repeat_buddy_stamina()
  return self.v_repeat_buddy_stamina
end

function ui:ui_finish_load()
  self:set_button("BtnReFight", function()
    if TowerMgr:get_tower() == nil then
      TowerMgr:restart_tower(nil, nil, nil, nil, true)
    else
      TowerMgr:get_fight_reward(function()
        TowerMgr:restart_tower(nil, nil, nil, nil, true)
      end, true)
    end
  end)
  self:set_button("BtnConfirm", function()
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
      
      UIMgr:revert_cache_ui()
    end
    
    TowerMgr:get_fight_reward(cb, nil, true)
  end)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.Layout1, CharTemClass, CharTemKey)
end

function ui:ui_on_show()
  self:refresh()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh()
  local tower_progress = TowerMgr:get_tower_progress()
  local cost_time = tower_progress.fight_time or 0
  self.v_static_sv:update_list(tower_progress.battle_buddy_data)
  self.v_uicompents.TimeNum_txt.text = cost_time .. "s"
  local hp_cost = -MineSweeperBattleMgr:get_hp_cost(cost_time)
  local character_hp_cost = 0
  for _, item in ipairs(self.v_static_sv:get_items()) do
    local repeat_buddy_stamina = item:get_repeat_buddy_stamina()
    character_hp_cost = character_hp_cost + repeat_buddy_stamina
  end
  self.v_uicompents.TimeHpNum_txt.text = hp_cost
  self.v_uicompents.HpReduceNum_txt.text = hp_cost + character_hp_cost
  Util.set_color(self.v_uicompents.TimeHpNum_txt, 0 == hp_cost and 16117218 or 16735838)
  local grid_cfg = ShareRes.get_minesweeper_grid_cfg(MineSweeperMgr.battle_grid_id)
  if grid_cfg.AwardTime and grid_cfg.AwardScore and cost_time < grid_cfg.AwardTime then
    local awardscore = math.floor((grid_cfg.AwardTime - cost_time) / grid_cfg.AwardTime * grid_cfg.AwardScore)
    self.v_uiobjects.AwardScore:SetActiveEx(true)
    self.v_uicompents.AwardScoreNum_txt.text = awardscore
  else
    self.v_uiobjects.AwardScore:SetActiveEx(false)
  end
end

return ui
