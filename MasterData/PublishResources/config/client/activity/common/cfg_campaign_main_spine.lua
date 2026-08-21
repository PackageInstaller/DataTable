local key = {
  ID = 1,
  SpineName = 2,
  SpineAnim = 3
}
local config = {
  [5050] = {
    5050,
    "n45_kv_spine_idle",
    {
      {"5451004", "2"},
      {"5451007", "3"},
      {"5451010", "4"},
      {"5451015", "5"}
    }
  },
  [5059] = {
    5059,
    "n47_kv_1_spine_idle"
  }
}
return config, "ID", key
