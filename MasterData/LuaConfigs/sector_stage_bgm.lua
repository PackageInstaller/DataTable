local sector_stage_bgm = {
  {
    label_boss_combat = "SelectorLabel_BossCombat",
    label_lv_select = "SelectorLabel_LevelSelect",
    label_normal_combat = "SelectorLabel_NormalCombat",
    selector = "Selector_Mus_Sector"
  },
  {
    id = 2,
    label_boss_combat = "SelectorLabel_BossCombat_Hi",
    label_lv_select = "SelectorLabel_LevelSelect_Mid",
    label_normal_combat = "SelectorLabel_NormalCombat_Hi",
    selector = "Selector_Mus_Sector"
  },
  {
    bgm_id = 3109,
    id = 3,
    label_boss_combat = "SelectorLabel_BossCombat",
    label_lv_select = "SelectorLabel_LevelSelect",
    label_normal_combat = "SelectorLabel_NormalCombat",
    selector = "Selector_Mus_Sector"
  },
  {bgm_id = 3201, id = 4},
  {bgm_id = 3203, id = 5},
  {bgm_id = 3381, id = 6},
  {bgm_id = 3410, id = 7},
  {bgm_id = 3431, id = 8},
  {bgm_id = 3444, id = 9},
  {bgm_id = 3441, id = 10},
  {bgm_id = 3433, id = 11},
  {bgm_id = 3435, id = 12},
  {bgm_id = 3448, id = 13},
  {bgm_id = 3436, id = 14},
  {bgm_id = 3450, id = 15},
  {bgm_id = 3439, id = 16},
  {bgm_id = 3446, id = 17},
  {bgm_id = 3451, id = 18},
  {bgm_id = 3447, id = 19},
  {bgm_id = 3452, id = 20},
  {bgm_id = 3430, id = 21},
  {bgm_id = 3451, id = 22},
  {bgm_id = 3456, id = 23},
  {bgm_id = 3457, id = 24},
  {bgm_id = 3458, id = 25},
  {bgm_id = 3109, id = 26},
  {bgm_id = 3340, id = 27},
  {bgm_id = 3004, id = 28},
  {bgm_id = 3462, id = 29},
  {bgm_id = 3460, id = 30},
  {bgm_id = 3461, id = 31},
  {bgm_id = 3463, id = 32}
}
local __default_values = {
  bgm_id = 3108,
  id = 1,
  label_boss_combat = "",
  label_lv_select = "",
  label_normal_combat = "",
  selector = ""
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_stage_bgm) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_stage_bgm, {__index = __rawdata})
return sector_stage_bgm
