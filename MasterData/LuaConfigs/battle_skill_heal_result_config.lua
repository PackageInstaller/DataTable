local battle_skill_heal_result_config = {
  {baseheal_formula = 0},
  {baseheal_formula = 3020, id = 2},
  {id = 3},
  {baseheal_formula = 3022, id = 4},
  {correct_formula = 3031, id = 5},
  {baseheal_formula = 501, id = 6},
  {
    baseheal_formula = 3022,
    correct_formula = 3031,
    id = 7
  }
}
local __default_values = {
  baseheal_formula = 3021,
  correct_formula = 9990,
  crit_formula = 0,
  crithur_ratio = 0,
  heal_number = 0,
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(battle_skill_heal_result_config) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  formulaTypes = {
    "baseheal_formula",
    "correct_formula",
    "crit_formula",
    "crithur_ratio",
    "heal_number"
  }
}
setmetatable(battle_skill_heal_result_config, {__index = __rawdata})
return battle_skill_heal_result_config
