local formation_rule = {
  {
    bench_num = 5,
    id = 1,
    stage_num = 2
  },
  {
    bench_num = 5,
    id = 2,
    stage_num = 3
  },
  {
    bench_num = 2,
    bench_start_idx = 7,
    id = 3
  },
  {
    bench_num = 4,
    bench_start_idx = 5,
    id = 4,
    stage_num = 4
  },
  {
    bench_num = 3,
    bench_start_idx = 6,
    id = 5,
    stage_num = 5
  },
  [0] = {
    bench_num = 3,
    bench_start_idx = 6,
    stage_num = 5
  },
  [11] = {
    bench_start_idx = 9,
    id = 11,
    stage_num = 1
  },
  [12] = {bench_start_idx = 9, id = 12},
  [13] = {
    bench_num = 2,
    bench_start_idx = 7,
    id = 13
  }
}
local __default_values = {
  bench_num = 0,
  bench_start_idx = 4,
  id = 0,
  stage_num = 6
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(formation_rule) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(formation_rule, {__index = __rawdata})
return formation_rule
